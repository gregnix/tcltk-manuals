#!/usr/bin/env tclsh
# createpdf.tcl -- one PDF from a tree of manual pages in Markdown (TIP 700)
# or in HTML, with title page, table of contents, subject index and the
# license terms.
#
#   tclsh createpdf.tcl <dir> ?options?
#
#   <dir>              folder with the pages, searched recursively for *.md,
#                      e.g. en-markdown/9.0 (with tcl/ and tk/ below it);
#                      a folder with *.html / *.htm and no *.md is read as
#                      HTML (see "HTML pages" below)
#
#   -o FILE            output PDF (default: <name of dir>.pdf)
#   -title T           title on the title page and in the header
#                      (default: name of dir; HTML: the <title> of its
#                      index.html, if there is one)
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
#   -index-terms M     where the index terms come from (default: auto):
#                      keywords  command name and "Keywords:" only
#                      auto      the same, plus terms taken from the page
#                                for pages without a YAML head (pages
#                                converted from HTML, e.g. Nemethi's)
#                      all       terms taken from every page
#   -html              read the HTML pages of <dir>, even if it has *.md
#   -no-html           read only *.md, even if <dir> has only HTML pages
#   -keep-md DIR       HTML: write the converted pages to DIR and keep them
#                      (default: a temporary folder, removed at the end)
#
# Each page becomes a chapter named after its file (after.md -> "after");
# the page's own headings move one level down. With pages in more than one
# folder every folder is a part ("Tcl", "Tk", "Ttk" for the ttk_* pages).
# The index terms are the command name and the "Keywords:" of the YAML head;
# see -index-terms and "Index terms from the page" below for more.
# The copyright lines of the YAML head stay with each page.
#
# HTML pages (folder with *.html / *.htm and no *.md, or -html): every page
# is converted to Markdown with docir's HTML reader (docir::htmlSource ->
# docir::md, as docir bin/h2md --batch does it: links to .html become .md,
# links to ids go to the heading before them, images are copied, missing
# ones left out) into a temporary folder below $TMPDIR (or /tmp), and that
# folder is built like any other. An index.html / index.htm comes first in
# its folder (in package docs it is the start page with the contents),
# the other pages follow sorted by name; frameset pages (BWidget's
# index.html) are left out. License files are searched in <dir> itself.
# If docir::htmlSource cannot be loaded, an h2md script is run instead:
# $H2MD, else $DOCIR_HOME/bin/h2md, else bin/h2md of the docir that is
# loaded. Both need the package tdom.
#
# Links from one page to another ("other.md", "other.md#anchor") jump to
# that chapter in the PDF, or to the heading the anchor names.
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
    puts stderr "         ?-md file? ?-index-tsv file? ?-index-terms auto|keywords|all?"
    puts stderr "         ?-html|-no-html? ?-keep-md dir?"
    exit 2
}
proc die {msg} { puts stderr "createpdf: $msg"; cleanup; exit 1 }
# The temporary folder of the converted HTML pages (see "HTML pages").
set tmpDir ""
proc cleanup {} {
    if {$::tmpDir ne "" && [file isdirectory $::tmpDir]} {
        catch {file delete -force $::tmpDir}
    }
    set ::tmpDir ""
}

# ------------------------------------------------------------------
# Options
# ------------------------------------------------------------------

if {![llength $argv]} usage
set dir ""
set o [dict create -o "" -title "" -subtitle "" -author "" -date "" -lang en \
    -subject "" -md "" -index-tsv "" -note "" -index-terms auto -keep-md ""]
set licFiles {}
set flags [dict create license 1 titlepage 1 index 1 header 1 groups 1 cid 1 \
    html auto]
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
        -html          { if {[dict get $flags html] eq "0"} usage
                         dict set flags html 1 }
        -no-html       { if {[dict get $flags html] eq "1"} usage
                         dict set flags html 0 }
        default {
            if {[string match -* $a] || $dir ne ""} usage
            set dir $a
        }
    }
}
if {$dir eq ""} usage
if {[dict get $o -index-terms] ni {auto keywords all}} usage
if {![file isdirectory $dir]} { die "not a folder: $dir" }
set dirN [file normalize $dir]

set lang [dict get $o -lang]
set L [dict get {
    en {contents Contents index Index keywords Keywords license License licenseOf "%s license terms"}
    de {contents Inhalt index Stichwortverzeichnis keywords Stichw\u00f6rter license Lizenz licenseOf "Lizenzbedingungen %s"}
} [expr {$lang eq "de" ? "de" : "en"}]]
set L [subst $L]

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
# Manual pages are full of "$var": no $...$ math (mdstack::parser 0.9.1;
# older versions ignore the variable)
set ::mdstack::parser::inlineMath 0
# TIP-700 pages indent further paragraphs of "1." items by 4 spaces
set ::mdstack::parser::listContinuation 1

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

# Pages of a folder tree, sorted by name in each folder, the folder's own
# pages before its subfolders. indexFirst: an index page first (HTML).
proc collectPages {dir {patterns *.md} {indexFirst 0}} {
    set files [lsort [glob -nocomplain -type f -directory $dir {*}$patterns]]
    if {$indexFirst} {
        set ix [lsearch -all -inline -regexp $files {/index\.(md|html?)$}]
        set files [concat $ix [lsearch -all -inline -not -regexp $files {/index\.(md|html?)$}]]
    }
    foreach sub [lsort [glob -nocomplain -type d -directory $dir *]] {
        lappend files {*}[collectPages $sub $patterns $indexFirst]
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

# ------------------------------------------------------------------
# Index terms from the page (-index-terms auto|all)
# ------------------------------------------------------------------
#
# docir records an index term where a [term]{.index} span is printed and
# links the index to that spot. The span shows its text, so a term can only
# be a piece of text the page shows anyway: createpdf wraps that piece in a
# span and leaves the rest of the line as it was. In a code span the piece
# leaves the code (`pathName `[cellconfigure]{.index}` cellIndex`); in a
# definition term, which docir sets bold, it is printed bold.
#
#  1. Definition terms (the line before ": ...", also indented, and lines
#     before it that end in a hard line break): options
#     (-arrowstyle), commands (tablelist::tablelist), subcommands, methods.
#     Italic parts and ?...? are arguments and drop out, and so does the
#     placeholder pathName in front: "pathName cellconfigure cellIndex
#     ?option?" gives "cellconfigure". If the page has the ensemble form
#     "pathName header option ...", a subcommand keeps its second word
#     ("header bbox"). A line in capitals (ROW INDICES) is a label and is
#     taken whole, if it is short and not a common one.
#  2. Headings from level 2 on (levels of the page), without the common
#     ones (Contents, Description, Examples ..., de and en), the title block
#     of the HTML pages (For Tablelist Version 7.12, by, the author) and
#     questions (How to get it?). "The `x` Command" / "Der Befehl `x`" give
#     x, "name - text" gives name, other headings are taken whole.
#  3. Terms the page marks itself ([term]{.index}) count as they are.
# A term goes in once per page, at its first place; the page name and the
# keywords are not repeated. The index is flat (term and pages; the
# combined index adds the manual), so a term stands on its own:
# "cellconfigure", not "pathName cellconfigure"; "cellconfigure (page)"
# would need a term the page does not show.
#
# A heading with a span gets another anchor ("x" -> "x-index"); links to the
# old anchor are moved to the new one (::ixt::relink), so the table of
# contents of a page keeps working.

namespace eval ::ixt {
    # common headings and definition labels, lower case (de, en)
    variable stop [subst -nocommands -novariables {
        contents {table of contents} description descriptions examples
        example keywords {see also} copyright name names synopsis overview
        summary introduction license licence {quick reference}
        {detailed reference} arguments options {standard options}
        {widget-specific options} {widget command} {widget commands}
        commands {return value} {return values} bugs notes author authors
        history references index credits acknowledgements acknowledgments
        category creation {required tk version} {required tcl version}
        inhalt inhaltsverzeichnis beschreibung beispiele beispiel
        stichwörter schlüsselwörter {siehe auch} übersicht
        überblick zusammenfassung einleitung einführung lizenz
        kurzreferenz {ausführliche referenz} argumente optionen
        standardoptionen {widget-spezifische optionen} widget-befehl
        widget-befehle befehle rückgabewert rückgabewerte fehler
        anmerkungen hinweise autor autoren geschichte verweise kategorie
        {erforderliche tk-version} {erforderliche tcl-version}
    }]
    variable placeholders {pathName pathname}
    # anchor of a heading -> the anchor it has now (first heading only;
    # "" = unchanged)
    variable firstAnchor [dict create]
    variable count 0
    variable pages 0
}

proc ::ixt::unescape {s} {
    regsub -all {\\([[:punct:]])} $s {\1}
}
proc ::ixt::escape {s} {
    string map {\\ \\\\ * \\* _ \\_ [ \\[ ] \\] ` \\` < \\<} $s
}

# Inline pieces of a line, each a list {kind start end in0 in1 extra}:
# kind code | strong | emph | link | span | plain, start/end the source
# range with the markers, in0/in1 the text inside, extra the backticks of a
# code span or the attributes of a span.
proc ::ixt::segments {line} {
    set segs {}
    set n [string length $line]
    set i 0
    set p 0
    while {$i < $n} {
        set c [string index $line $i]
        if {$c eq "\\"} { incr i 2; continue }
        set seg ""
        if {$c eq "`"} {
            regexp -start $i {\A`+} $line ticks
            set k [string length $ticks]
            set j [expr {$i + $k}]
            set close -1
            while {[regexp -start $j -indices {`+} $line r]} {
                lassign $r r0 r1
                if {$r1 - $r0 + 1 == $k} { set close $r0; break }
                set j [expr {$r1 + 1}]
            }
            if {$close < 0} { incr i $k; continue }
            set seg [list code $i [expr {$close + $k - 1}] \
                [expr {$i + $k}] [expr {$close - 1}] $ticks]
        } elseif {[string range $line $i $i+1] eq "**"} {
            set j [string first ** $line [expr {$i + 2}]]
            while {$j > 0 && [string index $line $j-1] eq "\\"} {
                set j [string first ** $line [expr {$j + 1}]]
            }
            if {$j > $i + 2} {
                set seg [list strong $i [expr {$j + 1}] [expr {$i + 2}] [expr {$j - 1}] ""]
            }
        } elseif {$c eq "*" && ![string is space [string index $line $i+1]]} {
            set j [string first * $line [expr {$i + 1}]]
            while {$j > 0 && [string index $line $j-1] eq "\\"} {
                set j [string first * $line [expr {$j + 1}]]
            }
            if {$j > $i + 1} {
                set seg [list emph $i $j [expr {$i + 1}] [expr {$j - 1}] ""]
            }
        } elseif {$c eq "\[" || ($c eq "!" && [string index $line $i+1] eq "\[")} {
            set b [expr {$c eq "!" ? $i + 1 : $i}]
            set j [expr {$b + 1}]
            set close -1
            while {$j < $n} {
                set d [string index $line $j]
                if {$d eq "\\"} { incr j 2; continue }
                if {$d eq "\]"} { set close $j; break }
                if {$d eq "\["} break
                incr j
            }
            if {$close > $b} {
                set nx [string index $line $close+1]
                set end $close
                set kind link
                set extra ""
                if {$nx eq "("} {
                    set e [string first ")" $line $close]
                    if {$e > 0} { set end $e }
                } elseif {$nx eq "\["} {
                    set e [string first "\]" $line [expr {$close + 2}]]
                    if {$e > 0} { set end $e }
                } elseif {$nx eq "\{" && $c ne "!"} {
                    set e [string first "\}" $line $close]
                    if {$e > 0} {
                        set end $e
                        set kind span
                        set extra [string range $line $close+2 $e-1]
                    }
                }
                set seg [list $kind $i $end [expr {$b + 1}] [expr {$close - 1}] $extra]
            }
        } elseif {$c eq "<"} {
            set e [string first ">" $line $i]
            if {$e > $i} { set seg [list link $i $e [expr {$i + 1}] [expr {$e - 1}] ""] }
        }
        if {$seg eq ""} { incr i; continue }
        if {$p < $i} { lappend segs [list plain $p [expr {$i - 1}] $p [expr {$i - 1}] ""] }
        lappend segs $seg
        set i [expr {[lindex $seg 2] + 1}]
        set p $i
    }
    if {$p < $n} { lappend segs [list plain $p [expr {$n - 1}] $p [expr {$n - 1}] ""] }
    return $segs
}

# Words of a line: dicts {raw s e seg kind ph}. raw is the source text
# (s..e), ph 1 for an argument: italic, a span of an argument class, or
# inside ?...?. Links and spans are one word each.
proc ::ixt::words {line segs} {
    set out {}
    set depth 0
    set k 0
    foreach seg $segs {
        lassign $seg kind s0 s1 i0 i1 extra
        switch -- $kind {
            emph {
                lappend out [dict create raw [string range $line $i0 $i1] \
                    s $i0 e $i1 seg $k kind emph ph 1]
            }
            link {
                lappend out [dict create raw [string range $line $i0 $i1] \
                    s $s0 e $s1 seg $k kind link ph 0]
            }
            span {
                set cls [regexp -all -inline {\.[-\w]+} $extra]
                set ph [expr {[llength [lsearch -all -inline -regexp $cls \
                    {^\.(arg|ins|optarg|optdot|optlit)$}]] > 0}]
                set kd [expr {".index" in $cls ? "marked" : "span"}]
                lappend out [dict create raw [string range $line $i0 $i1] \
                    s $i0 e $i1 seg $k kind $kd ph $ph]
            }
            default {
                set j $i0
                while {[regexp -start $j -indices {\S+} $line r]} {
                    lassign $r w0 w1
                    if {$w0 > $i1} break
                    if {$w1 > $i1} { set w1 $i1 }
                    set raw [string range $line $w0 $w1]
                    set q [regexp -all {\?} $raw]
                    set ph [expr {$depth > 0 || $q > 0}]
                    set depth [expr {($depth + $q) % 2}]
                    lappend out [dict create raw $raw s $w0 e $w1 seg $k \
                        kind $kind ph $ph]
                    set j [expr {$w1 + 1}]
                }
            }
        }
        incr k
    }
    return $out
}

proc ::ixt::visible {w} {
    if {[dict get $w kind] eq "code"} { return [dict get $w raw] }
    return [unescape [dict get $w raw]]
}

# Definition term -> list of changes {s e span tail} (see ::ixt::mark);
# ensembles: names with the form "name option ...", seenVar: terms so far.
proc ::ixt::dtTerms {line ensembles seenVar} {
    upvar 1 $seenVar seen
    variable placeholders
    variable stop
    set segs [segments $line]
    set ws [words $line $segs]
    # alternatives: "-itembackground color or -itembg color"
    set alts {}
    set cur {}
    foreach w $ws {
        if {[dict get $w kind] eq "plain"
                && [dict get $w raw] in {or oder | , / und and}} {
            lappend alts $cur
            set cur {}
            continue
        }
        lappend cur $w
    }
    lappend alts $cur
    set changes {}
    foreach alt $alts {
        set all $alt
        set alt [lmap w $alt { if {[dict get $w ph]} continue; set w }]
        while {[llength $alt] && [dict get [lindex $alt 0] raw] in $placeholders
                && [dict get [lindex $alt 0] kind] ne "link"} {
            set alt [lrange $alt 1 end]
        }
        if {![llength $alt]} continue
        set w0 [lindex $alt 0]
        set kind0 [dict get $w0 kind]
        if {$kind0 in {link marked emph}} continue
        set ch ""
        # a label in capitals: the whole run
        set caps 1
        foreach w $all {
            set v [visible $w]
            if {[dict get $w ph] || [dict get $w kind] ni {plain strong code}
                    || [string toupper $v] ne $v
                    || ![regexp {^([[:alpha:]]|[&+/-]+$)} $v]
                    || [dict get $w seg] != [dict get $w0 seg]} {
                set caps 0; break
            }
        }
        # a label in words ("Options for all entries"): whole, if short
        set words [expr {$kind0 in {plain strong}
            && [regexp {^[[:upper:]][[:lower:]]} [dict get $w0 raw]]
            && [string first :: [dict get $w0 raw]] < 0 && [llength $alt] >= 3
            && [llength $alt] == [llength $all]}]
        if {$words} {
            foreach w $all {
                if {[dict get $w seg] != [dict get $w0 seg]} { set words 0 }
            }
            if {!$words} continue
        }
        if {($caps || $words) && [string index [dict get $w0 raw] 0] ne "-"} {
            set s [dict get $w0 s]
            set e [dict get [lindex $all end] e]
            set raw [string trimright [string range $line $s $e] ":"]
            set e [expr {$s + [string length $raw] - 1}]
            set term [unescape $raw]
            if {[llength $all] <= 5 && [string length $term] <= 40
                    && [string length $term] > 1
                    && [string tolower $term] ni $stop} {
                set ch [list $s $e $term]
            }
        } else {
            set raw [dict get $w0 raw]
            set idx [lsearch -exact $all $w0]
            set w1 [lindex $all $idx+1]
            if {$kind0 eq "plain" && $w1 ne "" && ![dict get $w1 ph]
                    && [dict get $w1 kind] eq "strong"
                    && [lindex $segs [dict get $w1 seg] 1] == [dict get $w0 e] + 1
                    && [dict get $w1 s] == [lindex $segs [dict get $w1 seg] 3]
                    && [regexp {::$} $raw]} {
                # BWidget::**place**: the plain prefix and the bold name
                set full "$raw[dict get $w1 raw]"
                if {[regexp {^[A-Za-z_][\w:]*::[A-Za-z_]\w*$} $full]} {
                    set sseg [lindex $segs [dict get $w1 seg]]
                    set rest [string range $line [dict get $w1 e]+1 [lindex $sseg 4]]
                    set tail ""
                    if {[string trim $rest] ne ""} {
                        regexp {^(\s*)(.*?)(\s*)$} $rest -> l mid r
                        set tail "$l**$mid**$r"
                    }
                    set ch [list [dict get $w0 s] [lindex $sseg 2] [unescape $full] $tail]
                }
            } elseif {$kind0 eq "span"} {
                # TIP-700 span ([x]{.cmd}): the span gets the class index
                if {[regexp {^-?[A-Za-z_][\w:.-]*$} $raw]} {
                    set seg [lindex $segs [dict get $w0 seg]]
                    set ch [list [lindex $seg 1] [lindex $seg 2] [unescape $raw] "" \
                        "\[$raw\]\{[lindex $seg 5] .index\}"]
                }
            } elseif {$kind0 ne "plain" || [string match -* $raw] || [string match *::* $raw]} {
                if {[regexp {^-[A-Za-z](?:[-\w.:]|\\_)*} $raw m]
                        || [regexp {^(?:[A-Za-z_]|\\_)(?:[\w.:]|\\_)*} $raw m]} {
                    set m [string trimright $m .:]
                    set s [dict get $w0 s]
                    set e [expr {$s + [string length $m] - 1}]
                    set term [expr {$kind0 eq "code" ? $m : [unescape $m]}]
                    # subcommand of an ensemble: two words
                    set n1 [lindex $alt 1]
                    if {$m eq $raw && $term in $ensembles && $n1 ne ""
                            && [dict get $n1 seg] == [dict get $w0 seg]
                            && [string is space [string range $line $e+1 [dict get $n1 s]-1]]
                            && [regexp {^[a-z][A-Za-z0-9]*$} [dict get $n1 raw]]
                            && [dict get $n1 raw] ne "option"} {
                        set e [dict get $n1 e]
                        set term "$term [dict get $n1 raw]"
                    }
                    set ch [list $s $e $term]
                }
            }
        }
        if {$ch eq ""} continue
        set term [lindex $ch 2]
        if {[string length $term] < 2 || [string length $term] > 40
                || ![regexp {[[:alpha:]]} $term]} continue
        set key [string tolower $term]
        if {[dict exists $seen $key]} continue
        dict set seen $key 1
        # code span: the term leaves the code, the rest stays code
        set seg0 [lindex $segs [dict get $w0 seg]]
        if {[lindex $seg0 0] eq "code" && [llength $ch] == 3} {
            lassign $seg0 - c0 c1 i0 i1 ticks
            lassign $ch s e
            set pre [string range $line $i0 $s-1]
            set post [string range $line $e+1 $i1]
            set new ""
            if {[string trim $pre] ne ""} {
                regexp {^(.*?)(\s*)$} $pre -> pc ps
                append new $ticks $pc $ticks $ps
            } else {
                append new $pre
            }
            append new "\[[escape $term]\]{.index}"
            if {[string trim $post] ne ""} {
                regexp {^(\s*)(.*)$} $post -> ps pc
                append new $ps $ticks $pc $ticks
            } else {
                append new $post
            }
            set ch [list $c0 $c1 $term "" $new]
        }
        lappend changes $ch
    }
    return $changes
}

# Applies changes {s e term ?tail? ?replacement?} to a line, from the right.
proc ::ixt::mark {line changes} {
    variable count
    foreach ch [lsort -integer -decreasing -index 0 $changes] {
        lassign $ch s e term tail repl
        if {$repl eq ""} {
            set raw [string range $line $s $e]
            set txt [expr {[regexp {[][\\*`]} $raw] ? [escape $term] : $raw}]
            set repl "\[$txt\]{.index}$tail"
        }
        set line [string replace $line $s $e $repl]
        incr count
    }
    return $line
}

# Heading text (after the hashes) -> change {s e term ?tail? ?repl?} or "".
proc ::ixt::headTerm {raw seenVar} {
    upvar 1 $seenVar seen
    variable stop
    if {[regexp {[\[\]<>{}!]} $raw]} { return "" }
    set vis [string trimright [unescape [string map {` "" ** "" * ""} $raw]] " .:"]
    set lv [string tolower $vis]
    if {$lv eq "" || $lv in $stop || [string index $lv end] eq "?"
            || [regexp {^(for|für) .* version [0-9]} $lv]} { return "" }
    set ch ""
    set codes [regexp -all -inline -indices {`[^`]+`} $raw]
    if {[llength $codes] == 1} {
        lassign [lindex $codes 0] c0 c1
        set x [string range $raw $c0+1 $c1-1]
        set outside [string range $raw 0 $c0-1][string range $raw $c1+1 end]
        if {[regexp {^[A-Za-z_][\w:.-]*$} $x] && ([string first :: $x] > 0
                || [llength [regexp -all -inline {[[:alpha:]]\S*} $outside]] <= 2)} {
            set ch [list $c0 $c1 $x "" "\[[escape $x]\]{.index}"]
        }
    }
    if {$ch eq "" && [regexp -indices {^([A-Za-z_][\w:.]*)\s+[-–]\s+\S} $raw -> m]} {
        lassign $m m0 m1
        set ch [list $m0 $m1 [string range $raw $m0 $m1]]
    }
    if {$ch eq ""} {
        if {[string length $vis] > 60
                || [llength [regexp -all -inline {[[:alpha:]]\S*} $vis]] > 8} {
            return ""
        }
        set raw [string trimright $raw " .:"]
        set ch [list 0 [expr {[string length $raw] - 1}] $vis]
        if {[regexp {[`*]} $raw]} {
            lappend ch "" "\[[escape $vis]\]{.index}"
        }
    }
    set term [lindex $ch 2]
    if {[string length $term] < 2 || ![regexp {[[:alpha:]]} $term]} { return "" }
    set key [string tolower $term]
    if {[dict exists $seen $key]} { return "" }
    dict set seen $key 1
    return $ch
}

# Marks the terms of a page. lines: the page, from line i on the body;
# seen: terms already in the index line (lower case). Returns the lines
# and a dict line -> old heading text for the headings that changed.
proc ::ixt::derive {lines i seen} {
    variable pages
    variable count
    set before $count
    # terms the page marks itself
    set fence ""
    set dts {}
    for {set k $i} {$k < [llength $lines]} {incr k} {
        set line [lindex $lines $k]
        if {[fenceStep fence $line] || $fence ne ""} continue
        foreach {- t} [regexp -all -inline {\[([^\]]+)\]\{[^\}]*\.index\y[^\}]*\}} $line] {
            dict set seen [string tolower [string trim [unescape $t]]] 1
        }
        if {[regexp {^\s*:(\s|$)} [lindex $lines $k+1]] && [string trim $line] ne ""
                && ![regexp {^\s*(:|#|\||>|([-*+]|\d+[.)])\s)} $line]} {
            lappend dts $k
            # several terms for one definition, one per line with a hard
            # line break ("-labelbg color  " / "-labelfont font  " / ...)
            set m $k
            while {$m - 1 >= $i && [regexp {(  |\\)$} [lindex $lines $m-1]]
                    && [string trim [lindex $lines $m-1]] ne ""
                    && ![regexp {^\s*(:|#|\||>|([-*+]|\d+[.)])\s)} [lindex $lines $m-1]]} {
                incr m -1
                lappend dts $m
            }
        }
    }
    set dts [lsort -integer -unique $dts]
    # ensembles: "pathName header option ..."
    set ensembles {}
    variable placeholders
    foreach k $dts {
        set line [lindex $lines $k]
        set ws [lmap w [words $line [segments $line]] {
            if {[dict get $w ph]} continue; set w
        }]
        while {[llength $ws] && [dict get [lindex $ws 0] raw] in $placeholders} {
            set ws [lrange $ws 1 end]
        }
        if {[llength $ws] >= 2 && [dict get [lindex $ws 1] raw] eq "option"
                && [regexp {^[A-Za-z_][\w:]*$} [dict get [lindex $ws 0] raw]]} {
            lappend ensembles [dict get [lindex $ws 0] raw]
        }
    }
    set heads [dict create]
    set fence ""
    set author 0
    for {set k $i} {$k < [llength $lines]} {incr k} {
        set line [lindex $lines $k]
        if {[fenceStep fence $line] || $fence ne ""} continue
        if {[regexp {^(#{1,6}) +(.*)$} $line -> h raw]} {
            set raw [regsub {\s+#+$} [string trimright $raw] ""]
            set lv [string tolower [string trim $raw]]
            if {$lv in {by von}} { set author 1; continue }
            if {$author} { set author 0; continue }
            if {[string length $h] < 2} continue
            set ch [headTerm $raw seen]
            if {$ch ne ""} {
                set off [expr {[string length $h] + 1}]
                while {[string index $line $off] eq " "} { incr off }
                lset ch 0 [expr {[lindex $ch 0] + $off}]
                lset ch 1 [expr {[lindex $ch 1] + $off}]
                dict set heads $k $raw
                lset lines $k [mark $line [list $ch]]
            }
            continue
        }
        if {$k in $dts} {
            set ch [dtTerms $line $ensembles seen]
            if {[llength $ch]} { lset lines $k [mark $line $ch] }
        }
    }
    if {$count > $before} { incr pages }
    return [list $lines $heads]
}

# A heading of the merged manual (title: text after the hashes; old: its
# text before a span was added, else ""): remembers the first heading of
# each anchor, see ::ixt::relink.
proc ::ixt::noteHeading {title {old ""}} {
    variable firstAnchor
    set title [regsub {\s+#+\s*$} [string trim $title] ""]
    set new [mdstack::parser::anchorize $title]
    set was [expr {$old eq "" ? $new : [mdstack::parser::anchorize \
        [regsub {\s+#+\s*$} [string trim $old] ""]]}]
    if {![dict exists $firstAnchor $was]} {
        if {$was ne $new && ![dict exists $firstAnchor $new]} {
            dict set firstAnchor $was $new
        } else {
            dict set firstAnchor $was ""
        }
    }
    if {![dict exists $firstAnchor $new]} { dict set firstAnchor $new "" }
}

# Links "#old" to a heading that got a span: "#new" (outside code blocks).
proc ::ixt::relink {text} {
    variable firstAnchor
    set map [dict create]
    dict for {a n} $firstAnchor { if {$n ne ""} { dict set map $a $n } }
    if {![dict size $map]} { return $text }
    set out {}
    set fence ""
    foreach line [split $text \n] {
        if {[fenceStep fence $line] || $fence ne "" || [string first "#" $line] < 0} {
            lappend out $line
            continue
        }
        set new ""
        set j 0
        while {[regexp -start $j -indices {\]\(#([^)\s]+)\)|^\s*\[[^\]]+\]:\s*#(\S+)} $line all a b]} {
            set r [expr {[lindex $a 0] >= 0 ? $a : $b}]
            lassign $r r0 r1
            set anc [string range $line $r0 $r1]
            append new [string range $line $j $r0-1]
            if {[dict exists $map $anc]} {
                append new [dict get $map $anc]
            } else {
                append new $anc
            }
            set j [expr {$r1 + 1}]
        }
        lappend out "$new[string range $line $j end]"
    }
    return [join $out \n]
}

# ------------------------------------------------------------------
# Links between the pages
# ------------------------------------------------------------------
#
# "other.md" and "other.md#anchor" (relative to the page) lead nowhere in
# the PDF. If other.md is one of the pages, the link goes to the anchor, if
# its first heading is on that page, else to the chapter of that page.
# Anchors as mdstack makes them from the heading text; the first heading
# with an anchor wins (docir::pdf). Links to headings that get an index
# span are moved on by ::ixt::relink afterwards.

namespace eval ::plink {
    variable pageOf [dict create]
    variable owner [dict create]
}
proc ::plink::own {title file} {
    variable owner
    set a [mdstack::parser::anchorize [regsub {\s+#+\s*$} [string trim $title] ""]]
    if {![dict exists $owner $a]} { dict set owner $a $file }
}
# Pages in the order of the manual (groups: with part headings).
proc ::plink::prepare {files groups} {
    variable pageOf
    set last "\x00"
    foreach f $files {
        set n [file normalize $f]
        set name [file rootname [file tail $f]]
        dict set pageOf $n $name
        if {$groups && [partOf $f] ne $last} {
            set last [partOf $f]
            own [partTitle $last] ""
        }
        own $name $n
        set lines [split [readUtf $f] \n]
        set i 0
        if {[lindex $lines 0] eq "---"} {
            set i [lsearch -exact -start 1 $lines ---]
            if {$i < 0} { set i 0 }
        }
        set fence ""
        foreach line [lrange $lines $i end] {
            if {[fenceStep fence $line] || $fence ne ""} continue
            if {[regexp {^#{1,6} +(.*)$} $line -> t]} { own $t $n }
        }
    }
}
proc ::plink::target {file path frag} {
    variable pageOf
    variable owner
    if {[regexp {^([a-zA-Z][-\w+.]*:|/)} $path]} { return "" }
    set t [file normalize [file join [file dirname [file normalize $file]] $path]]
    if {![dict exists $pageOf $t]} { return "" }
    if {$frag ne "" && [dict exists $owner $frag] && [dict get $owner $frag] eq $t} {
        return "#$frag"
    }
    set a [mdstack::parser::anchorize [dict get $pageOf $t]]
    if {[dict exists $owner $a] && [dict get $owner $a] eq $t} { return "#$a" }
    return ""
}
proc ::plink::rewrite {line file} {
    variable pageOf
    if {![dict size $pageOf] || [string first .md $line] < 0} { return $line }
    set out ""
    set j 0
    while {[regexp -start $j -indices {\]\(<?([^()<>\s#]+\.md)(?:#([^)\s>]*))?>?\)|^\s*\[[^\]]+\]:\s*<?([^\s#<>]+\.md)(?:#([^\s>]*))?} $line all p1 f1 p2 f2] } {
        if {[lindex $p1 0] >= 0} {
            set pr $p1; set fr $f1
            set r0 [expr {[lindex $all 0] + 2}]
            set r1 [expr {[lindex $all 1] - 1}]
        } else {
            set pr $p2; set fr $f2
            set r0 [lindex $p2 0]
            set r1 [lindex $all 1]
        }
        set path [string range $line {*}$pr]
        set frag [expr {[lindex $fr 0] >= 0 ? [string range $line {*}$fr] : ""}]
        append out [string range $line $j $r0-1]
        set to [target $file $path $frag]
        if {$to eq ""} {
            append out [string range $line $r0 $r1]
        } else {
            append out $to
        }
        set j [expr {$r1 + 1}]
    }
    return "$out[string range $line $j end]"
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
    ::ixt::noteHeading $name
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
        # more terms from the page itself (-index-terms)
        set mode $::indexTerms
        if {$mode eq "all" || ($mode eq "auto" && [lindex $lines 0] ne "---")} {
            set seen [dict create]
            foreach t $terms { dict set seen [string tolower $t] 1 }
            lassign [::ixt::derive $lines $i $seen] lines heads
        }
    }
    if {![info exists heads]} { set heads [dict create] }
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
            ::ixt::noteHeading $rest [expr {[dict exists $heads $i] ? [dict get $heads $i] : ""}]
            append out [string repeat # [expr {min(6, [string length $h] + $level)}]] " " $rest \n
        } elseif {$fence eq ""} {
            if {[string first "!\[" $line] >= 0} {
                set line [absImages $line [file dirname [file normalize $file]]]
            }
            append out [::plink::rewrite $line $file] \n
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


# ------------------------------------------------------------------
# HTML pages (-html, -no-html, -keep-md)
# ------------------------------------------------------------------
#
# The conversion follows docir bin/h2md --batch (2026-10), but over the
# whole tree at once, so that links between folders are resolved too.

namespace eval ::h2m {
    # module (docir::htmlSource in this interpreter) or the path of h2md
    variable how ""
    variable images {*.png *.gif *.jpg *.jpeg *.svg *.PNG *.GIF *.JPG *.JPEG *.SVG}
}

# HTML text, in the charset of its <meta> (default UTF-8, as h2md).
proc ::h2m::read {file} {
    set fh [open $file r]
    fconfigure $fh -encoding iso8859-1
    set head [::read $fh 4096]
    close $fh
    set enc utf-8
    if {[regexp -nocase {<meta[^>]*charset\s*=\s*["']?([-\w]+)} $head -> cs]} {
        switch -nocase -- $cs {
            iso-8859-1 - latin1 - iso_8859-1 { set enc iso8859-1 }
            iso-8859-15  { set enc iso8859-15 }
            windows-1252 - cp1252 { set enc cp1252 }
        }
    }
    set fh [open $file r]
    fconfigure $fh -encoding $enc
    set t [::read $fh]
    close $fh
    return $t
}

proc ::h2m::isFrameset {file} {
    regexp -nocase {<frameset[\s>]} [read $file]
}

# Text of <title> (entities and tags removed), "" without one.
proc ::h2m::title {file} {
    if {![regexp -nocase {<title[^>]*>(.*?)</title>} [read $file] -> t]} { return "" }
    regsub -all {<[^>]*>} $t "" t
    set t [string map {&amp; & &lt; < &gt; > &quot; \" &#39; ' &apos; ' &nbsp; " "} $t]
    while {[regexp {&#(x?)([0-9A-Fa-f]+);} $t m x n]} {
        set c [format %c [expr {$x eq "" ? $n : "0x$n"}]]
        set t [string map [list $m $c] $t]
    }
    return [string trim [regsub -all {\s+} $t " "]]
}

# How to convert: docir::htmlSource here, else an h2md script.
proc ::h2m::setup {} {
    variable how
    if {![catch {package require docir::htmlSource} err]} {
        set how module
        return
    }
    if {[catch {package require tdom} terr]} {
        die "HTML pages need the package tdom (docir reads HTML with it): $terr"
    }
    set cands {}
    if {[info exists ::env(H2MD)]} { lappend cands $::env(H2MD) }
    if {[info exists ::env(DOCIR_HOME)]} {
        lappend cands [file join $::env(DOCIR_HOME) bin h2md]
    }
    # bin/h2md of the docir loaded here (lib/tm/docir-X.tm -> ../../bin)
    set load [package ifneeded docir [package present docir]]
    set tm [lindex $load end]
    if {[file isfile $tm]} {
        lappend cands [file join [file dirname [file dirname [file dirname \
            [file normalize $tm]]]] bin h2md]
    }
    foreach c $cands {
        if {[file isfile $c]} { set how $c; return }
    }
    die "HTML pages: docir::htmlSource not loadable ($err), and no h2md\
        found (set H2MD=/path/to/h2md or DOCIR_HOME)"
}

proc ::h2m::anchorize {s} { mdstack::parser::anchorize $s }

# Ids on paragraphs and terms (<p id>, <dt id>) have no target in Markdown;
# they point to the heading before them (as h2md).
proc ::h2m::anchorMap {ir} {
    set m [dict create]
    set cur ""
    foreach b $ir {
        if {[dict get $b type] eq "heading"} {
            set cur [anchorize [docir::md::_inlinesToText [dict get $b content]]]
        }
        if {$cur ne ""} { ids $b $cur m }
    }
    return $m
}
proc ::h2m::ids {b anchor mVar} {
    upvar 1 $mVar m
    if {[dict exists $b meta id] && [dict get $b meta id] ne ""} {
        dict set m [dict get $b meta id] $anchor
    }
    if {[dict get $b type] eq "list"} {
        foreach it [dict get $b content] {
            if {[dict exists $it meta id]} { dict set m [dict get $it meta id] $anchor }
            if {[dict exists $it blocks]} {
                foreach sub [dict get $it blocks] { ids $sub $anchor m }
            }
        }
    }
}

# Relative links: .html -> .md; "#id" and "page.md#id" to the anchors of
# the headings (maps: page key -> id map; key = normalized path without
# extension). A link to an id of a known page without a heading before
# it goes to the page; on the same page it becomes plain text.
proc ::h2m::links {md file maps} {
    regsub -all {\]\((?![a-zA-Z][-\w+.]*:)([^)#\s]+)\.html?(#[^)\s]*)?\)} $md {](\1.md\2)} md
    set self [file rootname [file normalize $file]]
    set out ""
    set pos 0
    while {[regexp -indices -start $pos {\]\(([^)#\s]*)#([^)\s]+)\)} $md m f a]} {
        lassign $m x y
        set target [string range $md {*}$f]
        set id [string range $md {*}$a]
        if {$target eq ""} {
            set key $self
        } elseif {[regexp {^[a-zA-Z][-\w+.]*:} $target]} {
            set key ""
        } else {
            set key [file rootname [file normalize \
                [file join [file dirname $file] $target]]]
        }
        if {$key ne "" && [dict exists $maps $key $id]} {
            set to "$target#[dict get $maps $key $id]"
        } elseif {$key ne "" && [dict exists $maps $key]} {
            set to [expr {$target eq "" ? "\x01" : $target}]
        } else {
            set to "$target#$id"
        }
        append out [string range $md $pos [expr {$x - 1}]] "]($to)"
        set pos [expr {$y + 1}]
    }
    append out [string range $md $pos end]
    regsub -all {\[([^\[\]]*)\]\(\x01\)} $out {\1} out
    return $out
}

# Images whose file is missing are left out (else a marker in the PDF).
proc ::h2m::dropMissingImages {md dir name} {
    set out ""
    set pos 0
    while {[regexp -indices -start $pos {!\[[^\]]*\]\(([^)\s]+)\)} $md m u]} {
        lassign $m x y
        set url [string range $md {*}$u]
        append out [string range $md $pos [expr {$x - 1}]]
        if {[regexp {^[a-z]+:} $url] || [file exists [file join $dir $url]]} {
            append out [string range $md $x $y]
        } else {
            puts stderr "createpdf: note: $name: image missing, left out: $url"
        }
        set pos [expr {$y + 1}]
    }
    append out [string range $md $pos end]
    return $out
}

proc ::h2m::writeUtf {path text} {
    file mkdir [file dirname $path]
    set fh [open $path w]
    fconfigure $fh -encoding utf-8
    puts -nonewline $fh $text
    close $fh
}

# All HTML pages below src -> Markdown below out, same folders, images
# copied. Returns the number of pages.
proc ::h2m::convert {src out} {
    variable how
    variable images
    set srcN [file normalize $src]
    set pages {}
    foreach f [collectPages $src {*.html *.htm} 1] {
        if {[isFrameset $f]} {
            puts stderr "createpdf: note: frameset left out: [file tail $f]"
            continue
        }
        # index.html and index.htm in one folder: the .html one
        set md [file rootname [file normalize $f]].md
        if {[lsearch -exact -index 1 $pages $md] >= 0} {
            puts stderr "createpdf: note: [file tail $f] left out (same name as another page)"
            continue
        }
        lappend pages [list $f $md]
    }
    set dirs [lsort -unique [lmap p $pages {file dirname [file normalize [lindex $p 0]]}]]
    if {$how eq "module"} {
        set irs [dict create]
        set maps [dict create]
        set fail 0
        foreach p $pages {
            set f [lindex $p 0]
            if {[catch {docir::htmlSource::fromHtml [read $f]} ir]} {
                puts stderr "createpdf: [file tail $f]: $ir"
                incr fail
                continue
            }
            dict set irs $f $ir
            dict set maps [file rootname [file normalize $f]] [anchorMap $ir]
        }
        dict for {f ir} $irs {
            if {[catch {docir::md::render $ir} md]} {
                puts stderr "createpdf: [file tail $f]: $md"
                incr fail
                continue
            }
            set md [links $md $f $maps]
            set md [dropMissingImages $md [file dirname $f] [file tail $f]]
            set n [file normalize $f]
            writeUtf [file join $out [file rootname [rel $srcN $n]].md] $md
        }
        if {$fail} { die "$fail HTML pages could not be converted" }
    } else {
        foreach d $dirs {
            set od [file join $out [rel $srcN $d]]
            file mkdir $od
            if {[catch {exec [info nameofexecutable] $how --batch $d $od 2>@1} msg]} {
                die "h2md $d: $msg"
            }
        }
        # h2md converts every page; framesets and doubles go again
        set keep [lmap p $pages {file rootname [rel $srcN [file normalize [lindex $p 0]]]}]
        foreach md [collectPages $out] {
            set r [file rootname [rel [file normalize $out] [file normalize $md]]]
            if {$r ni $keep} { file delete $md }
        }
    }
    foreach d $dirs {
        set od [file join $out [rel $srcN $d]]
        foreach img [glob -nocomplain -type f -directory $d {*}$images] {
            file copy -force $img $od
        }
    }
    return [llength $pages]
}
# path below base ("" for base itself)
proc ::h2m::rel {base path} {
    string range $path [string length $base]+1 end
}

# Markdown or HTML?
set srcDir $dir
set htmlMode [dict get $flags html]
set mdPages [collectPages $dir]
set htmlPages [collectPages $dir {*.html *.htm}]
if {$htmlMode eq "auto"} {
    set htmlMode [expr {![llength $mdPages] && [llength $htmlPages]}]
    if {!$htmlMode && [llength $mdPages] && [llength $htmlPages]} {
        puts stderr "createpdf: note: $dir also has [llength $htmlPages] HTML pages;\
            only the .md pages are read (-html reads the HTML pages)"
    }
}
set title [dict get $o -title]
if {$htmlMode} {
    if {![llength $htmlPages]} { die "no .html or .htm files below $dir" }
    if {$title eq ""} {
        foreach n {index.html index.htm} {
            if {[file isfile [file join $dir $n]]} {
                set title [::h2m::title [file join $dir $n]]
                break
            }
        }
    }
    ::h2m::setup
    if {[dict get $o -keep-md] ne ""} {
        set mdDir [file normalize [dict get $o -keep-md]]
        if {[string first $dirN/ $mdDir/] == 0} {
            die "-keep-md must not be inside $dir"
        }
        if {[file isdirectory $mdDir] && [llength [collectPages $mdDir]]} {
            die "-keep-md folder has .md files already: $mdDir"
        }
    } else {
        set base /tmp
        foreach v {TMPDIR TMP TEMP} {
            if {[info exists env($v)] && [file isdirectory $env($v)]} {
                set base $env($v)
                break
            }
        }
        set mdDir [file join [file normalize $base] \
            createpdf-[pid]-[clock clicks -milliseconds]]
        set tmpDir $mdDir
    }
    file mkdir $mdDir
    set n [::h2m::convert $dir $mdDir]
    puts "HTML: $n pages converted ([expr {$::h2m::how eq "module" ? "docir::htmlSource" : $::h2m::how}])"
    set dir $mdDir
    set dirN [file normalize $dir]
}
if {$title eq ""} { set title [file tail [file normalize $srcDir]] }
set srcDirN [file normalize $srcDir]

set files [collectPages $dir *.md $htmlMode]
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

::plink::prepare $files $groups
set withIndex [dict get $flags index]
set indexTerms [dict get $o -index-terms]
set manual ""
set last "\x00"
foreach f $files {
    if {$groups} {
        set p [partOf $f]
        if {$p ne $last} {
            append manual "# [partTitle $p]\n\n"
            ::ixt::noteHeading [partTitle $p]
            set last $p
        }
        append manual [pageChapter $f $withIndex [dict get $L keywords] 2]
    } else {
        append manual [pageChapter $f $withIndex [dict get $L keywords] 1]
    }
}
set manual [::ixt::relink $manual]

# License chapter: -license files, else the license files found below <dir>.
# Files with the same text are printed once.
if {[dict get $flags license]} {
    if {![llength $licFiles]} {
        set found {}
        set walk [list $srcDir]
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
        set rel [string range [file dirname [file normalize $lf]] [string length $srcDirN]+1 end]
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
        puts stderr "createpdf: note: no license file found below $srcDir (use -license file)"
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
if {$::ixt::count} {
    puts "Index: $::ixt::count terms taken from $::ixt::pages pages (-index-terms $indexTerms)"
}

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
cleanup
exit 0
