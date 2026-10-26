#!/usr/bin/env tclsh
# createpdf.tcl -- one PDF from a tree of manual pages in Markdown (TIP 700),
# with title page, table of contents, subject index and the license terms.
#
#   tclsh createpdf.tcl <dir> ?options?
#
#   <dir>              folder with the pages, searched recursively for *.md,
#                      e.g. en-markdown/9.0 (with tcl/ and tk/ below it)
#
#   -o FILE            output PDF (default: <name of dir>.pdf)
#   -title T           title on the title page and in the header
#                      (default: name of dir)
#   -subtitle S        second line on the title page
#   -author A          author line on the title page and in the metadata
#   -date D            date line on the title page (default: today, or the
#                      date from SOURCE_DATE_EPOCH)
#   -lang en|de        language of the labels (Contents, Index, Keywords,
#                      License) and of the PDF metadata (default: en)
#   -subject S         PDF metadata "Subject"
#   -license FILE      license text for the last chapter (repeatable).
#                      Default: every license.terms / LICENSE / LICENSE.txt /
#                      COPYRIGHT.txt (Nemethi packages) / COPYING
#                      found below <dir>, one section per folder.
#   -note FILE         text printed at the start of the license chapter,
#                      before the license terms (e.g. who translated the
#                      pages and under which terms)
#   -no-license        no license chapter
#   -no-title-page     no title page
#   -no-index          no subject index
#   -no-header         no running header
#   -no-groups         no parts per folder (tcl/, tk/ ...): one flat list
#   -no-cid            256-character font subset instead of full Unicode
#   -md FILE           also write the merged Markdown
#   -index-tsv FILE    also write the printed index as a table
#
# Each page becomes a chapter named after its file (after.md -> "after");
# the page's own headings move one level down. With pages in more than one
# folder every folder is a part ("Tcl", "Tk", "Ttk" for the ttk_* pages).
# The index terms are the command name and the "Keywords:" of the YAML head.
# The copyright lines of the YAML head stay with each page.
#
# Needs the packages docir, mdstack, pdf4tcl and pdf4tcllib. They are loaded
# with plain "package require"; where they are found is up to Tcl:
# TCLLIBPATH for pkgIndex.tcl packages (pdf4tcl), TCL8_6_TM_PATH /
# TCL9_0_TM_PATH (or tcl::tm::path) for modules (docir, mdstack,
# pdf4tcllib), or an installation in the default paths.
#
# Tcl 8.6 or 9.x. Exit 0 on success, 1 on errors, 2 on bad usage.
# Derived from bookkit tools/manual-build.tcl.

package require Tcl 8.6-

proc usage {} {
    puts stderr "usage: tclsh createpdf.tcl <dir> ?-o file.pdf? ?-title T? ?-subtitle S? ?-author A?"
    puts stderr "         ?-date D? ?-lang en|de? ?-subject S? ?-license file ...? ?-note file?"
    puts stderr "         ?-no-license?"
    puts stderr "         ?-no-title-page? ?-no-index? ?-no-header? ?-no-groups? ?-no-cid?"
    puts stderr "         ?-md file? ?-index-tsv file?"
    exit 2
}
proc die {msg} { puts stderr "createpdf: $msg"; exit 1 }

# ------------------------------------------------------------------
# Options
# ------------------------------------------------------------------

if {![llength $argv]} usage
set dir ""
set o [dict create -o "" -title "" -subtitle "" -author "" -date "" -lang en \
    -subject "" -md "" -index-tsv "" -note ""]
set licFiles {}
set flags [dict create license 1 titlepage 1 index 1 header 1 groups 1 cid 1]
for {set i 0} {$i < [llength $argv]} {incr i} {
    set a [lindex $argv $i]
    if {[dict exists $o $a]} {
        if {$i + 1 >= [llength $argv]} usage
        dict set o $a [lindex $argv [incr i]]
        continue
    }
    switch -- $a {
        -license       { if {$i + 1 >= [llength $argv]} usage
                         lappend licFiles [lindex $argv [incr i]] }
        -no-license    { dict set flags license 0 }
        -no-title-page { dict set flags titlepage 0 }
        -no-index      { dict set flags index 0 }
        -no-header     { dict set flags header 0 }
        -no-groups     { dict set flags groups 0 }
        -no-cid        { dict set flags cid 0 }
        default {
            if {[string match -* $a] || $dir ne ""} usage
            set dir $a
        }
    }
}
if {$dir eq ""} usage
if {![file isdirectory $dir]} { die "not a folder: $dir" }
set dirN [file normalize $dir]

set lang [dict get $o -lang]
set L [dict get {
    en {contents Contents index Index keywords Keywords license License licenseOf "%s license terms"}
    de {contents Inhalt index Stichwortverzeichnis keywords Stichw\u00f6rter license Lizenz licenseOf "Lizenzbedingungen %s"}
} [expr {$lang eq "de" ? "de" : "en"}]]
set L [subst $L]

set title [dict get $o -title]
if {$title eq ""} { set title [file tail $dirN] }
set pdfOut [dict get $o -o]
if {$pdfOut eq ""} { set pdfOut "[file tail $dirN].pdf" }
set date [dict get $o -date]
if {$date eq ""} {
    set now [clock seconds]
    if {[info exists env(SOURCE_DATE_EPOCH)] && [string is integer -strict $env(SOURCE_DATE_EPOCH)]} {
        set now $env(SOURCE_DATE_EPOCH)
    }
    set date [clock format $now -format %Y-%m-%d -gmt 1]
}

# ------------------------------------------------------------------
# Packages: plain package require
# ------------------------------------------------------------------

foreach pkg {mdstack::parser docir::mdSource docir::md docir::pdf} {
    if {[catch {package require $pkg} err]} {
        puts stderr "createpdf: package $pkg: $err"
        puts stderr "  Make docir, mdstack, pdf4tcl and pdf4tcllib findable for Tcl, e.g."
        puts stderr "    export TCLLIBPATH=\"/path/to/pdf4tcl\""
        puts stderr "    export TCL[string map {. _} [info tclversion]]_TM_PATH=\"/path/to/docir/lib/tm:/path/to/mdstack/lib:/path/to/pdf4tcllib/lib\""
        exit 1
    }
}

# ------------------------------------------------------------------
# Pages
# ------------------------------------------------------------------

proc readUtf {path} {
    set fh [open $path r]
    fconfigure $fh -encoding utf-8
    set t [read $fh]
    close $fh
    return $t
}

proc collectPages {dir} {
    set files [lsort [glob -nocomplain -type f -directory $dir *.md]]
    foreach sub [lsort [glob -nocomplain -type d -directory $dir *]] {
        lappend files {*}[collectPages $sub]
    }
    return $files
}

# Code fences after CommonMark: a fence opens with at least three ` or ~
# (up to three spaces indent; after ` no ` in the info string) and closes
# only with the same character, at least as many, nothing else on the line.
proc fenceStep {stateVar line} {
    upvar 1 $stateVar state
    if {$state eq ""} {
        if {[regexp {^ {0,3}(`{3,}|~{3,})(.*)$} $line -> f info]
                && !([string index $f 0] eq "`" && [string first "`" $info] >= 0)} {
            set state [list [string index $f 0] [string length $f]]
            return 1
        }
        return 0
    }
    lassign $state c len
    if {[regexp {^ {0,3}([`~]+)\s*$} $line -> f]
            && [string index $f 0] eq $c && [string length $f] >= $len
            && [string length [string map [list $c ""] $f]] == 0} {
        set state ""
        return 1
    }
    return 0
}

# Relative image paths of a page point to the page's folder. The pages of
# all folders end up in one document, which docir resolves against the
# current directory -- so they are made absolute here. Without this the
# images (tablelist, tsw ...) were found only when createpdf was started in
# the page's folder; otherwise a grey marker or the alt text was printed.
proc absImages {line dir} {
    set out ""
    while {[regexp -indices {!\[[^\]]*\]\((<[^>]*>|[^)[:space:]]+)} $line all url]} {
        lassign $all a0 a1
        lassign $url u0 u1
        set u [string range $line $u0 $u1]
        set u [string trim $u <>]
        if {![regexp {^([a-zA-Z][a-zA-Z0-9+.-]*:|/|#)} $u] && $u ne ""} {
            set abs [file join $dir $u]
            if {[file exists $abs]} {
                set u <$abs>
            } else {
                set u [string range $line $u0 $u1]
            }
        } else {
            set u [string range $line $u0 $u1]
        }
        append out [string range $line 0 [expr {$u0 - 1}]] $u
        set line [string range $line [expr {$u1 + 1}] end]
    }
    return $out$line
}

# One page -> one chapter. The body is taken verbatim (no round trip through
# docir, which would turn definition lists into code blocks); only the YAML
# head goes (its Copyright and Keywords are kept) and the headings move down.
proc pageChapter {file withIndex indexLabel level} {
    set name [file rootname [file tail $file]]
    set lines [split [readUtf $file] \n]
    set keywords {}
    set copyrights {}
    set i 0
    if {[lindex $lines 0] eq "---"} {
        set inList ""
        for {set i 1} {$i < [llength $lines]} {incr i} {
            set fm [lindex $lines $i]
            if {$fm eq "---"} { incr i; break }
            if {[regexp {^(Copyright|Keywords):} $fm -> key]} { set inList $key; continue }
            if {$inList ne "" && [regexp {^ +- +(.+)$} $fm -> v]} {
                set v [string trim [string trim $v] \"]
                if {$inList eq "Copyright"} { lappend copyrights $v } else { lappend keywords $v }
                continue
            }
            set inList ""
        }
    }
    set out "[string repeat # $level] $name\n\n"
    # Index terms right under the heading, so that the index points to the
    # first page of the chapter (at the end they pointed to its last page)
    if {$withIndex} {
        set terms [list $name]
        foreach k $keywords {
            if {[string tolower $k] ni [lmap t $terms {string tolower $t}]} { lappend terms $k }
        }
        set spans [lmap t $terms {
            string cat "\[" [string map {\[ ( \] ) * {} _ {\_}} $t] "\]{.index}"
        }]
        append out "*$indexLabel:* [join $spans {, }]\n\n"
    }
    set fence ""
    for {} {$i < [llength $lines]} {incr i} {
        set line [lindex $lines $i]
        if {[fenceStep fence $line]} { append out $line \n; continue }
        # Navigation lines of the HTML originals (Nemethi packages):
        # "[Contents](#contents)  [Start page](index.md)" -- no use in a PDF.
        if {$fence eq "" && [regexp {^\s*(\[(Contents|Start page|Inhalt|Startseite)\]\((#[A-Za-z-]*|index\.md)\)\s*)+$} $line]} {
            continue
        }
        if {$fence eq "" && [regexp {^(#{1,6}) (.*)$} $line -> h rest]} {
            append out [string repeat # [expr {min(6, [string length $h] + $level)}]] " " $rest \n
        } elseif {$fence eq "" && [string first "!\[" $line] >= 0} {
            append out [absImages $line [file dirname [file normalize $file]]] \n
        } else {
            append out $line \n
        }
    }
    set out [string trimright $out]
    # Copyright lines the page does not show itself already.
    set flat [string tolower [regsub -all {[^[:alnum:]]+} $out ""]]
    set copyrights [lmap c $copyrights {
        set k [string tolower [regsub -all {[^[:alnum:]]+} $c ""]]
        if {$k ne "" && [string first $k $flat] >= 0} continue
        set c
    }]
    if {[llength $copyrights]} {
        append out "\n\n" [join [lmap c $copyrights {string cat * $c *}] " \\\n"]
    }
    return "$out\n\n"
}

# Part of a page: the folders below <dir> (without "modules"); ttk_* pages
# under tk/ form the part "ttk".
proc partOf {file} {
    global dirN
    set rel [file split [string range [file dirname [file normalize $file]] \
        [string length $dirN] end]]
    set p [join [lsearch -all -inline -not -regexp $rel {^(/|modules)$}] " / "]
    if {$p eq "tk" && [string match ttk_* [file tail $file]]} { set p ttk }
    return $p
}
proc partTitle {p} {
    set names {tcl Tcl tk Tk ttk Ttk tcl-c {Tcl C API} tk-c {Tk C API}}
    if {[dict exists $names $p]} { return [dict get $names $p] }
    return $p
}

set files [collectPages $dir]
if {![llength $files]} { die "no .md files below $dir" }

set groups [dict get $flags groups]
set order {}
set byPart [dict create]
foreach f $files {
    set p [partOf $f]
    dict lappend byPart $p $f
    if {$p ni $order} { lappend order $p }
}
if {$groups && [llength $order] > 1} {
    set files [concat {*}[lmap p $order {dict get $byPart $p}]]
} else {
    set groups 0
}

# Running header: the page that starts on a page (else the one running),
# with path and neighbours, as much as fits; the current name in bold.
set runInfo [dict create]
set names [lmap f $files {file rootname [file tail $f]}]
for {set k 0} {$k < [llength $files]} {incr k} {
    set name [lindex $names $k]
    if {[dict exists $runInfo $name]} continue
    set path [lmap x [split [partOf [lindex $files $k]] /] {string trim $x}]
    set path [lsearch -all -inline -not -exact $path ""]
    # if, not an expr ternary: that would turn a name like "1.10" into 1.1
    set prev [if {$k > 0} {lindex $names $k-1} else {return -level 0 ""}]
    set next [lindex $names $k+1]
    set cur "\x02$name\x02"
    set pfad [join [concat $path [list $cur]] " / "]
    set nach $cur; set beide $pfad
    if {$prev ne ""} { set nach "\u2039 $prev  |  $nach"; set beide "\u2039 $prev  |  $beide" }
    if {$next ne ""} { set nach "$nach  |  $next \u203a"; set beide "$beide  |  $next \u203a" }
    set c {}
    foreach x [list $beide $pfad $nach $cur] { if {$x ni $c} { lappend c $x } }
    dict set runInfo $name [lsort -command {apply {{a b} {
        expr {[string length $b] - [string length $a]}}}} $c]
}
proc runningText {title level} {
    global runInfo
    if {![dict exists $runInfo $title]} { return [list $title] }
    set mark [expr {[llength [info commands ::docir::pdf::_hdrSegs]] ? "**" : ""}]
    return [lmap c [dict get $runInfo $title] {string map [list \x02 $mark] $c}]
}

# ------------------------------------------------------------------
# Merge
# ------------------------------------------------------------------

set withIndex [dict get $flags index]
set manual ""
set last "\x00"
foreach f $files {
    if {$groups} {
        set p [partOf $f]
        if {$p ne $last} { append manual "# [partTitle $p]\n\n"; set last $p }
        append manual [pageChapter $f $withIndex [dict get $L keywords] 2]
    } else {
        append manual [pageChapter $f $withIndex [dict get $L keywords] 1]
    }
}

# License chapter: -license files, else the license files found below <dir>.
# Files with the same text are printed once.
if {[dict get $flags license]} {
    if {![llength $licFiles]} {
        set found {}
        set walk [list $dir]
        while {[llength $walk]} {
            set walk [lassign $walk d]
            foreach n {license.terms LICENSE LICENSE.txt LICENSE.md license.txt COPYRIGHT.txt COPYING} {
                if {[file isfile [file join $d $n]]} { lappend found [file join $d $n]; break }
            }
            lappend walk {*}[lsort [glob -nocomplain -type d -directory $d *]]
        }
        set licFiles $found
    }
    set seen [dict create]
    set lic {}
    foreach lf $licFiles {
        if {![file isfile $lf]} { die "license file not found: $lf" }
        set text [string trim [readUtf $lf]]
        set key [regsub -all {\s+} $text " "]
        set rel [string range [file dirname [file normalize $lf]] [string length $dirN]+1 end]
        if {$rel eq ""} {
            set label [file rootname [file tail $lf]]
        } else {
            set label [partTitle [lindex [file split $rel] end]]
        }
        if {[dict exists $seen $key]} {
            set j [dict get $seen $key]
            lset lic $j 0 "[lindex $lic $j 0], $label"
            continue
        }
        dict set seen $key [llength $lic]
        lappend lic [list $label $text]
    }
    set note ""
    if {[dict get $o -note] ne ""} {
        if {![file isfile [dict get $o -note]]} { die "note file not found: [dict get $o -note]" }
        set note [string trim [readUtf [dict get $o -note]]]
    }
    if {[llength $lic] || $note ne ""} {
        append manual "# [dict get $L license]\n\n"
        foreach para [regexp -all -inline {(?:[^\n]+\n?)+} $note] {
            set para [regsub -all {\s+} [string trim $para] " "]
            set para [regsub -all {([\\`*_\[\]<>])} $para {\\\1}]
            regsub {^([#+-])} $para {\\\1} para
            append manual $para "\n\n"
        }
        foreach e $lic {
            lassign $e label text
            # A section per license (with parts always, so the running
            # header names it), the text as plain paragraphs.
            if {[llength $lic] > 1 || $groups} {
                append manual "## [format [dict get $L licenseOf] $label]\n\n"
            }
            foreach para [regexp -all -inline {(?:[^\n]+\n?)+} $text] {
                set para [regsub -all {\s+} [string trim $para] " "]
                set para [regsub -all {([\\`*_\[\]<>])} $para {\\\1}]
                regsub {^([#+-])} $para {\\\1} para
                append manual $para "\n\n"
            }
        }
    } else {
        puts stderr "createpdf: note: no license file found below $dir (use -license file)"
    }
}
set manual "[string trimright $manual]\n"

if {[dict get $o -md] ne ""} {
    set fh [open [dict get $o -md] w]
    fconfigure $fh -encoding utf-8
    puts -nonewline $fh $manual
    close $fh
}

# ------------------------------------------------------------------
# PDF
# ------------------------------------------------------------------

set header [expr {[dict get $flags header] ? "%t\t%c" : ""}]
if {$header ne "" && ![llength [info commands ::docir::pdf::_runningTitle]]} {
    puts stderr "createpdf: note: this docir has no running title, header left out"
    set header ""
}
set lvl [expr {$groups ? 2 : 1}]
set ir [docir::md::fromAst [mdstack::parser::parse $manual]]
set opts [dict create \
    title $title subtitle [dict get $o -subtitle] author [dict get $o -author] \
    date $date titlePage [dict get $flags titlepage] \
    paper a4 footer "%p" header $header runningLevel $lvl runningProc runningText \
    generateToc 1 tocTitle [dict get $L contents] tocDepth $lvl \
    generateIndex $withIndex indexTitle [dict get $L index] \
    cid [dict get $flags cid] lang $lang subject [dict get $o -subject] \
    creator "createpdf.tcl"]
if {[catch {docir::pdf::render $ir $pdfOut $opts} err]} { die "PDF: $err" }
puts "PDF: $pdfOut ([llength $files] pages of manual, [file size $pdfOut] bytes)"

# Printed index as a table (term TAB pages), e.g. for a combined index.
set tsv [dict get $o -index-tsv]
if {$tsv ne "" && $withIndex && [llength [info commands ::docir::pdf::indexEntries]]} {
    set by [dict create]
    foreach e [docir::pdf::indexEntries] {
        lassign $e term pages
        foreach pg $pages { dict set by $term $pg 1 }
    }
    set fh [open $tsv w]
    fconfigure $fh -encoding utf-8 -translation lf
    puts $fh "# pdf\t[file tail $pdfOut]"
    puts $fh "# label\t$title"
    puts $fh "# title\t$title"
    foreach term [lsort -dictionary [dict keys $by]] {
        puts $fh "[string map {\t { } \n { }} $term]\t[join [lsort -integer [dict keys [dict get $by $term]]] ,]"
    }
    close $fh
}
exit 0
