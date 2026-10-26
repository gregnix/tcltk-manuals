#!/usr/bin/env wish
# pdfgui.tcl -- Oberfläche zum Bauen eines oder mehrerer Handbuch-PDFs.
#
#   wish scripts/pdfgui.tcl
#
# Ruft scripts/createpdf/createpdf.tcl und, für den Gesamtindex,
# scripts/createpdf/index-gesamt.tcl auf. Bücher laufen über bookkit
# (tools/book-build.tcl), wie scripts/build-pdfs.sh.
# „Seiten übernehmen“ kopiert aus den beiden Ordnern de-markdown und
# en-markdown nach Tcl-family und Extensions. Jeder Ordner hat einen
# Auswahldialog. Lizenzdateien der Sammlung bleiben. Bücher liegen
# nicht in diesen Ordnern.
#
# Benannte Einstellungen liegen einmal unter
# ~/.config/tcltk-manuals/pdfgui/NAME.cfg, für alle Kopien der Sammlung
# gemeinsam. Speichern, Laden, Löschen stehen rechts unten.
# „Bestand“ schreibt die PDFs in die Kopie, aus der die Oberfläche läuft.
#
# Gesucht wird in Wurzelordnern: zuerst der Ordner, in dem diese Kopie der
# Sammlung liegt, dann die Ordner aus PDFGUI_ROOTS (getrennt wie PATH,
# unter Unix mit „:“, unter Windows mit „;“). In jedem Wurzelordner:
#   tkutils/lib/tm, tclutils/lib/tm     die Pakete der Oberfläche
#   translation/tcltk-manual-de, tcltk-manual-de    de- und en-markdown
#   bibliothek/books/bookkit, bookkit   bookkit
# TCLTK_MANUAL_DE und BOOKKIT gehen vor. Pakete, die Tcl schon findet
# (TCL8_6_TM_PATH, TCL9_0_TM_PATH, installiert), brauchen keinen Eintrag.
#
# Die Vorgaben je Handbuch stehen in der Liste, gleichlautend mit
# build-pdfs.sh, und sind im Formular schon eingetragen. Solange ein Feld
# auf dieser Vorgabe steht, gilt sie je Handbuch und je Sprache. Ein
# geänderter Text gilt für jedes gewählte PDF. Die Kurzhilfe an den
# Feldern kommt von tkutils::tkuballoon.

package require Tcl 8.6-
package require Tk 8.6-
package require msgcat

set scriptDir [file dirname [file normalize [info script]]]
set repoRoot  [file dirname $scriptDir]

# Wurzelordner: der Ordner um diese Kopie, dann PDFGUI_ROOTS.
proc pdfguiRoots {} {
    set roots [list [file dirname $::repoRoot]]
    if {[info exists ::env(PDFGUI_ROOTS)]} {
        set sep [expr {$::tcl_platform(platform) eq "windows" ? ";" : ":"}]
        foreach r [split $::env(PDFGUI_ROOTS) $sep] {
            set r [string trim $r]
            if {$r eq ""} continue
            set r [file normalize $r]
            if {$r ni $roots && [file isdirectory $r]} { lappend roots $r }
        }
    }
    return $roots
}

foreach root [pdfguiRoots] {
    foreach tmDir [list \
            [file join $root tkutils lib tm] \
            [file join $root tclutils lib tm]] {
        if {[file isdirectory $tmDir] && $tmDir ni [tcl::tm::path list]} {
            tcl::tm::path add $tmDir
        }
    }
}

foreach {pkg ver} {
    tkutils::tkuform 0.1  tkutils::tkuballoon 0.1  tkutils::tkustatus 0.2
    tkutils::tkufiledialog 0.2  tkutils::tkudialog 0.3  tclutils::tutask 0.2
} {
    if {[catch {package require $pkg $ver} msg]} {
        set text [join [list "pdfgui: $msg" "" \
            "Die Oberfläche braucht tkutils und tclutils: als Ordner neben" \
            "der Sammlung, unter PDFGUI_ROOTS oder über TCL8_6_TM_PATH /" \
            "TCL9_0_TM_PATH. Siehe README.de.md (Oberfläche) bzw. README.md (GUI)."] \n]
        puts stderr $text
        catch {wm withdraw .; tk_messageBox -icon error -title pdfgui -message $text}
        exit 1
    }
}

namespace eval ::pdfgui {
    variable repo $::repoRoot
    variable task ""
    variable runs
    array set runs {}
    # Zuletzt eingetragene Vorgabe je Feld. Ein abweichender Text ist
    # eine Änderung und gilt für alle gewählten PDFs.
    variable preset
    array set preset {}
    variable uiLang de

    # name gruppe ordner teile titelDe titelEn art
    # art: handbuch | index | buch. Bücher tragen die Sprache im Namen.
    variable katalog {
        {tcltk-9.0      Tcl-family 9.0               tcl,tk  {Tcl/Tk 9.0}       {Tcl/Tk 9.0}       handbuch}
        {tcltk-9.0-capi Tcl-family 9.0               tcl-c,tk-c {Tcl/Tk 9.0 C-API} {Tcl/Tk 9.0 C API} handbuch}
        {tcltk-8.6      Tcl-family 8.6               tcl,tk  {Tcl/Tk 8.6}       {Tcl/Tk 8.6}       handbuch}
        {tcltk-8.6-capi Tcl-family 8.6               tcl-c,tk-c {Tcl/Tk 8.6 C-API} {Tcl/Tk 8.6 C API} handbuch}
        {tcllib         Tcl-family tcllib            *       Tcllib             Tcllib             handbuch}
        {tklib          Tcl-family tklib             *       Tklib              Tklib              handbuch}
        {tablelist      Tcl-family pakete/tablelist  *       Tablelist          Tablelist          handbuch}
        {mentry         Tcl-family pakete/mentry     *       Mentry             Mentry             handbuch}
        {scrollutil     Tcl-family pakete/scrollutil *       Scrollutil         Scrollutil         handbuch}
        {wcb            Tcl-family pakete/wcb        *       Wcb                Wcb                handbuch}
        {tsw            Tcl-family pakete/tsw        *       Tsw                Tsw                handbuch}
        {erweiterungen  Extensions .                 *       Erweiterungen      Extensions         handbuch}
        {tcl-family-index Tcl-family .               *       {Tcl-Familie: Gesamtindex} {Tcl family: combined index} index}
        {Tclutils-de    Books Tclutils-de            *       Tclutils           Tclutils           buch}
        {Tclutils-en    Books Tclutils-en            *       Tclutils           Tclutils           buch}
        {pdf4tcl-de     Books pdf4tcl-de             *       pdf4tcl            pdf4tcl            buch}
        {pdf4tcl-en     Books pdf4tcl-en             *       pdf4tcl            pdf4tcl            buch}
        {pdf4tcllib-de  Books pdf4tcllib-de          *       pdf4tcllib         pdf4tcllib         buch}
        {pdf4tcllib-en  Books pdf4tcllib-en          *       pdf4tcllib         pdf4tcllib         buch}
    }
}

# createpdf und bookkit sind kommandozeilen. Ein wish-Kind öffnet
# sonst ein leeres Tk-Fenster.
proc ::pdfgui::tclsh {} {
    set exe [info nameofexecutable]
    set base [file tail $exe]
    if {[string match wish* $base]} {
        set cand [file join [file dirname $exe] [string map {wish tclsh} $base]]
        if {[file executable $cand]} { return $cand }
    }
    return $exe
}

proc ::pdfgui::row {name} {
    variable katalog
    foreach row $katalog {
        if {[lindex $row 0] eq $name} { return $row }
    }
    return {}
}

proc ::pdfgui::log {text} {
    .log configure -state normal
    .log insert end $text\n
    .log see end
    .log configure -state disabled
    update idletasks
}

proc ::pdfgui::selectedNames {} {
    set names {}
    foreach i [.list curselection] {
        lappend names [lindex $::pdfgui::names $i]
    }
    return $names
}

proc ::pdfgui::langs {} {
    set l {}
    if {$::pdfgui::langDe} { lappend l de }
    if {$::pdfgui::langEn} { lappend l en }
    return $l
}

proc ::pdfgui::flagOn {form name} {
    set v [::tkutils::tkuform::get $form $name]
    return [expr {$v eq "1" || $v eq "true" || $v eq "yes"}]
}

# Arbeitskopie ohne README.md und QUELLE.txt, wie build-pdfs.sh.
proc ::pdfgui::copyTree {from to} {
    file mkdir $to
    foreach f [glob -nocomplain -directory $from *] {
        set dest [file join $to [file tail $f]]
        if {[file isdirectory $f]} {
            copyTree $f $dest
        } else {
            file copy -force $f $dest
        }
    }
}

proc ::pdfgui::stripMeta {dir} {
    foreach f [glob -nocomplain -directory $dir *] {
        set tail [file tail $f]
        if {[file isdirectory $f]} {
            stripMeta $f
        } elseif {$tail eq "README.md" || $tail eq "QUELLE.txt"} {
            file delete $f
        }
    }
}

proc ::pdfgui::hasMd {dir} {
    foreach f [glob -nocomplain -directory $dir *] {
        if {[file isdirectory $f]} {
            if {[hasMd $f]} { return 1 }
        } elseif {[string match *.md [file tail $f]]} {
            return 1
        }
    }
    return 0
}

proc ::pdfgui::prepare {src parts dest} {
    file delete -force $dest
    file mkdir $dest
    if {$parts eq "*"} {
        if {[file isdirectory $src]} { copyTree $src $dest }
    } else {
        foreach t [split $parts ,] {
            set sub [file join $src $t]
            if {[file isdirectory $sub]} { copyTree $sub [file join $dest $t] }
        }
    }
    stripMeta $dest
    return [hasMd $dest]
}

proc ::pdfgui::noteFile {lang form} {
    switch -- [choice $form vermerk] {
        none { return "" }
        file { return [string trim [::tkutils::tkuform::get $form notefile]] }
        default {
            variable repo
            if {$lang eq "de"} {
                return [file join $repo scripts createpdf uebersetzung-de.txt]
            }
            return [file join $repo scripts createpdf umwandlung-en.txt]
        }
    }
}

# True, wenn der Benutzer den Vorgabetext des Feldes geändert hat.
proc ::pdfgui::edited {form name} {
    variable preset
    set v [string trim [::tkutils::tkuform::get $form $name]]
    if {![info exists preset($name)]} {
        return [expr {$v ne ""}]
    }
    return [expr {$v ne $preset($name)}]
}

proc ::pdfgui::markPreset {form name value} {
    variable preset
    set preset($name) $value
    ::tkutils::tkuform::setField $form $name $value
}

# Sichtbare Vorgaben: Datum, Vermerkdatei, Untertitel, Betreff, Pfade.
# Titel nur bei genau einem gewählten Handbuch, sonst je Eintrag der Liste.
proc ::pdfgui::fillDefaults {} {
    set form .form
    if {![winfo exists $form]} return
    variable repo
    set langs [langs]
    set de [expr {"de" in $langs || [llength $langs] == 0}]
    if {$de} {
        set sub "Handbuchseiten (deutsch)"
        set note [file join $repo scripts createpdf uebersetzung-de.txt]
        set customPdf [file join $repo Tcl-family de-pdf eigen.pdf]
    } else {
        set sub "Reference manual pages"
        set note [file join $repo scripts createpdf umwandlung-en.txt]
        set customPdf [file join $repo Tcl-family en-pdf eigen.pdf]
    }
    set title ""
    set manuals {}
    foreach name [selectedNames] {
        set row [row $name]
        if {$row eq ""} continue
        if {[lindex $row 6] eq "handbuch"} { lappend manuals $row }
    }
    if {[llength $manuals] == 1} {
        lassign [lindex $manuals 0] name gruppe ordner teile tde ten art
        if {$de} { set title $tde } else { set title $ten }
        if {[string match pakete/* $ordner]} {
            if {$de} {
                set sub "Programmierhandbuch (deutsch)"
            } else {
                set sub "Programmer's guide"
            }
        }
    }
    if {[info exists ::env(SOURCE_DATE_EPOCH)]
            && [string is integer -strict $::env(SOURCE_DATE_EPOCH)]} {
        set now $::env(SOURCE_DATE_EPOCH)
    } else {
        set now [clock seconds]
    }
    set date [clock format $now -format %Y-%m-%d -gmt 1]
    foreach {key value} [list \
            title $title subtitle $sub subject $sub notefile $note \
            date $date outdir $repo customout $customPdf] {
        if {![edited $form $key]} {
            markPreset $form $key $value
        }
    }
    foreach lang {de en} {
        if {![srcEdited $lang]} {
            setSrc $lang [defaultSrc $lang] 1
        }
    }
}

# Wurzelordner, die laufende Kopie vorn (siehe pdfguiRoots oben).
proc ::pdfgui::knownRoots {} {
    return [::pdfguiRoots]
}

proc ::pdfgui::defaultSrc {lang} {
    if {[info exists ::env(TCLTK_MANUAL_DE)] && $::env(TCLTK_MANUAL_DE) ne ""} {
        set p [file join $::env(TCLTK_MANUAL_DE) ${lang}-markdown]
        if {[file isdirectory $p]} { return [file normalize $p] }
    }
    set fallback ""
    foreach root [knownRoots] {
        foreach rel {{translation tcltk-manual-de} {tcltk-manual-de}} {
            set p [file join $root {*}$rel ${lang}-markdown]
            if {[file isdirectory $p]} { return [file normalize $p] }
            if {$fallback eq ""} { set fallback [file normalize $p] }
        }
    }
    return $fallback
}

proc ::pdfgui::defaultBookkit {} {
    if {[info exists ::env(BOOKKIT)] && $::env(BOOKKIT) ne ""
            && [file exists [file join $::env(BOOKKIT) tools book-build.tcl]]} {
        return [file normalize $::env(BOOKKIT)]
    }
    set fallback ""
    foreach root [knownRoots] {
        foreach rel {{bibliothek books bookkit} {bookkit}} {
            set p [file join $root {*}$rel]
            if {[file exists [file join $p tools book-build.tcl]]} {
                return [file normalize $p]
            }
            if {$fallback eq ""} { set fallback [file normalize $p] }
        }
    }
    return $fallback
}

proc ::pdfgui::srcPath {lang} {
    if {$lang eq "de"} {
        return [string trim $::pdfgui::srcDe]
    }
    return [string trim $::pdfgui::srcEn]
}

proc ::pdfgui::srcEdited {lang} {
    variable srcPreset
    set v [srcPath $lang]
    if {![info exists srcPreset($lang)]} {
        return [expr {$v ne ""}]
    }
    return [expr {$v ne $srcPreset($lang)}]
}

proc ::pdfgui::setSrc {lang value {asPreset 0}} {
    variable srcPreset
    if {$lang eq "de"} {
        set ::pdfgui::srcDe $value
    } else {
        set ::pdfgui::srcEn $value
    }
    if {$asPreset} { set srcPreset($lang) $value }
}

# Lizenzdateien legt hole-lizenzen.sh in die Sammlung. Die Übersetzung
# führt sie nicht, deshalb bleiben sie beim Übernehmen stehen.
proc ::pdfgui::keepName {name} {
    return [expr {$name in {
        license.terms LICENSE COPYRIGHT.txt LICENSE.txt COPYING license.txt
    }}]
}

proc ::pdfgui::pageFile {name} {
    if {[keepName $name]} { return 0 }
    if {$name in {QUELLE.txt README.md konvertierung.log}} { return 1 }
    set ext [string tolower [file extension $name]]
    return [expr {$ext in {.md .png .gif .jpg .jpeg .svg}}]
}

proc ::pdfgui::sameFile {a b} {
    if {![file isfile $b]} { return 0 }
    if {[file size $a] != [file size $b]} { return 0 }
    set fa [open $a rb]
    set fb [open $b rb]
    set same 1
    while {1} {
        set ca [read $fa 65536]
        set cb [read $fb 65536]
        if {$ca ne $cb} { set same 0; break }
        if {[eof $fa]} break
    }
    close $fa
    close $fb
    return $same
}

proc ::pdfgui::syncFile {src dest statsName} {
    upvar 1 $statsName st
    if {[file tail $src] eq "konvertierung.log"} {
        incr st(skip)
        return
    }
    file mkdir [file dirname $dest]
    if {[sameFile $src $dest]} {
        incr st(same)
        return
    }
    file copy -force $src $dest
    catch {file mtime $dest [file mtime $src]}
    incr st(copy)
}

proc ::pdfgui::pruneTree {dir statsName} {
    upvar 1 $statsName st
    foreach f [glob -nocomplain -directory $dir *] {
        if {[file isdirectory $f]} {
            pruneTree $f st
        } elseif {[pageFile [file tail $f]]} {
            file delete $f
            incr st(del)
        }
    }
    if {[glob -nocomplain -directory $dir *] eq ""} {
        file delete $dir
    }
}

proc ::pdfgui::syncTree {src dest statsName} {
    upvar 1 $statsName st
    if {![file isdirectory $src]} {
        incr st(missing)
        return
    }
    file mkdir $dest
    foreach f [glob -nocomplain -directory $src *] {
        set to [file join $dest [file tail $f]]
        if {[file isdirectory $f]} {
            syncTree $f $to st
        } else {
            syncFile $f $to st
        }
    }
    foreach f [glob -nocomplain -directory $dest *] {
        set from [file join $src [file tail $f]]
        if {[file isdirectory $f]} {
            if {![file isdirectory $from]} { pruneTree $f st }
        } elseif {[file tail $f] eq "konvertierung.log"
                || (![file exists $from] && [pageFile [file tail $f]])} {
            file delete $f
            incr st(del)
        }
    }
}

# Quell- und Zielordner für ein Handbuch und eine Sprache.
# Extensions liegen in der Übersetzung unter erweiterungen/.
proc ::pdfgui::syncPairs {name lang} {
    variable repo
    set row [row $name]
    if {$row eq ""} { return {} }
    lassign $row name gruppe ordner teile tde ten art
    if {$art ne "handbuch"} { return {} }
    set srcRoot [srcPath $lang]
    set dstRoot [file join $repo $gruppe ${lang}-markdown]
    if {$gruppe eq "Extensions"} {
        return [list [list [file join $srcRoot erweiterungen] $dstRoot]]
    }
    if {$teile eq "*"} {
        return [list [list \
            [file join $srcRoot $ordner] [file join $dstRoot $ordner]]]
    }
    set pairs {}
    foreach part [split $teile ,] {
        lappend pairs [list \
            [file join $srcRoot $ordner $part] \
            [file join $dstRoot $ordner $part]]
    }
    return $pairs
}

proc ::pdfgui::syncSelected {} {
    variable task
    if {$task ne ""} {
        ::tkutils::tkudialog::showWarning [t "Es läuft schon ein Bau."] -parent .
        return
    }
    set langs [langs]
    if {[llength $langs] == 0} {
        ::tkutils::tkudialog::showError [t "Keine Sprache gewählt."] -parent .
        return
    }
    foreach lang $langs {
        set p [srcPath $lang]
        if {![file isdirectory $p]} {
            set welche [expr {$lang eq "de" ? [t Deutsch] : [t Englisch]}]
            ::tkutils::tkudialog::showError \
                [t "Ordner für %s fehlt.\n%s" $welche $p] -parent .
            return
        }
    }
    set pairs {}
    set books 0
    foreach name [selectedNames] {
        set row [row $name]
        if {$row eq "" || [lindex $row 6] ne "handbuch"} {
            incr books
            continue
        }
        foreach lang $langs {
            set teil [syncPairs $name $lang]
            set da 0
            foreach p $teil {
                if {[file isdirectory [lindex $p 0]]} { set da 1 }
            }
            # Fehlt ein Handbuch in einer Sprache ganz (die C-API gibt es
            # nur englisch), entfällt es dort ohne Meldung, wie beim Bauen.
            # Fehlt nur ein Teil, meldet das Protokoll ihn.
            if {$da} { lappend pairs {*}$teil }
        }
    }
    if {[llength $pairs] == 0} {
        ::tkutils::tkudialog::showWarning \
            [t "Nichts zu übernehmen. Bücher und der Gesamtindex liegen nicht in der Übersetzung."] \
            -parent .
        return
    }
    set n [llength $pairs]
    set herkunft {}
    foreach lang $langs {
        lappend herkunft [srcPath $lang]
    }
    if {![::tkutils::tkudialog::confirm \
            [t "Markdown aus\n%s\nin die Handbuchsammlung übernehmen (%d Ordner)?\nLizenzdateien bleiben stehen." \
                [join $herkunft \n] $n] \
            -parent .]} {
        return
    }
    array set st {copy 0 same 0 del 0 missing 0 skip 0}
    log [t "Übernehmen aus %s" [join $herkunft {, }]]
    foreach p $pairs {
        lassign $p src dest
        if {![file isdirectory $src]} {
            incr st(missing)
            log [t "  fehlt: %s" $src]
            continue
        }
        syncTree $src $dest st
        log "  [file tail [file dirname $src]]/[file tail $src] -> $dest"
        update idletasks
    }
    set line [t "kopiert %d, unverändert %d, entfernt %d, Quelle fehlt %d" \
        $st(copy) $st(same) $st(del) $st(missing)]
    log $line
    ::tkutils::tkustatus::setText .status [t "Übernommen: %d Dateien" $st(copy)]
    ::tkutils::tkudialog::showInfo [t "Übernommen.\n%s" $line] -parent .
}

proc ::pdfgui::t {msg args} {
    return [::msgcat::mc $msg {*}$args]
}

proc ::pdfgui::choiceCode {field raw} {
    set raw [string trim $raw]
    switch -- $field {
        vermerk {
            switch -- $raw {
                Vorgabe - Default - preset { return preset }
                keine - None - none { return none }
                Datei - File - file { return file }
            }
        }
        outmode {
            switch -- $raw {
                Bestand - Collection - collection { return collection }
                Ordner - Folder - folder { return folder }
            }
        }
    }
    return $raw
}

proc ::pdfgui::choiceLabel {field code} {
    switch -- $field,$code {
        vermerk,preset     { return [t Vorgabe] }
        vermerk,none       { return [t keine] }
        vermerk,file       { return [t Datei] }
        outmode,collection { return [t Bestand] }
        outmode,folder     { return [t Ordner] }
    }
    return $code
}

proc ::pdfgui::choiceValues {field} {
    switch -- $field {
        vermerk { return [list [t Vorgabe] [t keine] [t Datei]] }
        outmode { return [list [t Bestand] [t Ordner]] }
    }
    return {}
}

proc ::pdfgui::choice {form field} {
    return [choiceCode $field [::tkutils::tkuform::get $form $field]]
}

proc ::pdfgui::retargetChoices {} {
    if {![winfo exists .form]} return
    foreach field {vermerk outmode} {
        set code [choiceCode $field [::tkutils::tkuform::get .form $field]]
        set w [::tkutils::tkuform::widgetOf .form $field]
        $w configure -values [choiceValues $field]
        if {$code ne ""} {
            ::tkutils::tkuform::setField .form $field [choiceLabel $field $code]
        }
    }
}

proc ::pdfgui::fillList {} {
    if {![winfo exists .list]} return
    variable katalog
    variable uiLang
    set sel [.list curselection]
    .list delete 0 end
    foreach row $katalog {
        lassign $row name gruppe ordner teile tde ten art
        if {$art eq "index"} {
            .list insert end [t "Gesamtindex  (Tcl-Familie)"]
        } elseif {$art eq "buch"} {
            .list insert end [t "Buch  %s" $name]
        } else {
            if {$uiLang eq "en"} { set titel $ten } else { set titel $tde }
            .list insert end "$titel   \[$gruppe\]"
        }
    }
    foreach i $sel {
        if {$i < [.list size]} { .list selection set $i }
    }
}

proc ::pdfgui::applyTexts {} {
    if {![winfo exists .top.left.cap]} return
    wm title . [t "Handbuch-PDFs"]
    if {[winfo exists .ui.cap]} { .ui.cap configure -text [t Oberfläche] }
    .top.left.cap configure -text [t Handbücher]
    .top.left.lang.de configure -text [t deutsch]
    .top.left.lang.en configure -text [t englisch]
    .top.left.bt.all configure -text [t Alle]
    .top.left.bt.none configure -text [t Keine]
    .top.right.src configure -text [t "Markdown-Quellen"]
    .top.right.src.lde configure -text [t Deutsch]
    .top.right.src.len configure -text [t Englisch]
    .top.right.src.bde configure -text [t "Wählen…"]
    .top.right.src.ben configure -text [t "Wählen…"]
    set labels {
        Titel Untertitel Autor Datum Betreff Vermerk Titelseite Vermerk-Datei
        Stichwörter Kopfzeile {Teile je Ordner} Lizenzkapitel Unicode-Schrift
        Index-Tabelle Markdown-Datei Ablegen {Sprache dazu} Zielordner
        {Eigener Ordner} {Ausgabe dazu} Bookkit
    }
    set i 0
    foreach lab $labels {
        .form.l$i configure -text [t $lab]
        incr i
    }
    retargetChoices
    fillList
    .drop configure -text [t "TSV entfernen"]
    .sync configure -text [t "Seiten übernehmen"]
    .go configure -text [t "PDFs erzeugen"]
    .cancel configure -text [t Abbrechen]
    .bar.save configure -text [t Speichern]
    .bar.load configure -text [t Laden]
    .bar.forget configure -text [t Löschen]
    helpBalloons
}

proc ::pdfgui::useLang {} {
    variable uiLang
    if {$uiLang ni {de en}} { set uiLang de }
    ::msgcat::mclocale $uiLang
    applyTexts
}

proc ::pdfgui::loadCatalog {} {
    ::msgcat::mclocale de
    namespace eval ::tkutils::tkudialog {
        ::msgcat::mcset de Yes Ja
        ::msgcat::mcset de No Nein
        ::msgcat::mcset de OK OK
        ::msgcat::mcset de Confirm Bestätigen
        ::msgcat::mcset de Information Hinweis
        ::msgcat::mcset de Warning Warnung
        ::msgcat::mcset de Error Fehler
        ::msgcat::mcset de Cancel Abbrechen
        ::msgcat::mcset de Copy Kopieren
        ::msgcat::mcset de Details Einzelheiten
    }
    foreach {de en} {
        {Handbuch-PDFs} {Manual PDFs}
        Oberfläche Interface
        Handbücher Manuals
        deutsch German
        englisch English
        Deutsch German
        Englisch English
        Alle All
        Keine None
        {Markdown-Quellen} {Markdown sources}
        {Wählen…} {Choose…}
        {TSV entfernen} {Remove TSV}
        {Seiten übernehmen} {Copy pages}
        {PDFs erzeugen} {Build PDFs}
        Abbrechen Cancel
        Speichern Save
        Laden Load
        Löschen Delete
        Bereit Ready
        Titel Title
        Untertitel Subtitle
        Autor Author
        Datum Date
        Betreff Subject
        Vermerk Note
        Titelseite {Title page}
        Vermerk-Datei {Note file}
        Stichwörter Keywords
        Kopfzeile Header
        {Teile je Ordner} {Parts per folder}
        Lizenzkapitel {License chapter}
        Unicode-Schrift {Unicode font}
        Index-Tabelle {Index table}
        Markdown-Datei {Markdown file}
        Ablegen Store
        {Sprache dazu} {Language for it}
        Zielordner {Output folder}
        {Eigener Ordner} {Own folder}
        {Ausgabe dazu} {Output for it}
        Vorgabe Default
        keine None
        Datei File
        Bestand Collection
        Ordner Folder
        {Gesamtindex  (Tcl-Familie)} {Combined index (Tcl family)}
        {Buch  %s} {Book  %s}
        {Keine Sprache gewählt.} {No language selected.}
        {Zielordner fehlt oder ist kein Ordner.} {Output folder is missing or is not a folder.}
        {%s: kein book.tcl unter %s} {%s: no book.tcl under %s}
        {Bookkit fehlt. Pfad auf tools/book-build.tcl setzen.} {Bookkit is missing. Point it at tools/book-build.tcl.}
        {%s (%s): keine Seiten, übersprungen} {%s (%s): no pages, skipped}
        {Eigener Ordner ist kein Verzeichnis.} {Own folder is not a directory.}
        {Für den eigenen Ordner fehlt die Ausgabe-PDF.} {The own folder needs an output PDF.}
        {Im eigenen Ordner liegen keine Markdown-Seiten.} {The own folder has no Markdown pages.}
        {eigener Ordner (%s)} {own folder (%s)}
        {Gesamtindex (%s): keine Index-Tabellen} {Combined index (%s): no index tables}
        {Gesamtindex (%s)} {Combined index (%s)}
        {Nichts gewählt, oder die gewählten Seiten fehlen in dieser Sprache.} {Nothing selected, or the selected pages are missing for this language.}
        {Es läuft schon ein Bau.} {A build is already running.}
        {Ordner für %s fehlt.\n%s} {Folder for %s is missing.\n%s}
        {Nichts zu übernehmen. Bücher und der Gesamtindex liegen nicht in der Übersetzung.} {Nothing to copy. Books and the combined index are not in the translation tree.}
        {Markdown aus\n%s\nin die Handbuchsammlung übernehmen (%d Ordner)?\nLizenzdateien bleiben stehen.} {Copy Markdown from\n%s\ninto the manual collection (%d folders)?\nLicense files stay.}
        {Übernehmen aus %s} {Copy from %s}
        {  fehlt: %s} {  missing: %s}
        {kopiert %d, unverändert %d, entfernt %d, Quelle fehlt %d} {copied %d, unchanged %d, removed %d, source missing %d}
        {Übernommen: %d Dateien} {Copied: %d files}
        {Übernommen.\n%s} {Copied.\n%s}
        Fehler Error
        Abgebrochen Cancelled
        Fertig Done
        {Die PDFs sind geschrieben.} {The PDFs are written.}
        {%d fehlgeschlagen} {%d failed}
        {%d Lauf fehlgeschlagen. Das Protokoll steht unten.} {%d runs failed. The log is below.}
        Start Start
        {Name fehlt oder enthält einen Schrägstrich.} {The name is missing or contains a slash.}
        {Die Datei enthält keine Einstellung.} {The file does not hold a setting.}
        {Keine Einstellung „%s“.} {No setting “%s”.}
        {Einstellung „%s“ ist keine gültige Datei.} {Setting “%s” is not a valid file.}
        {Einstellung „%s“ überschreiben?} {Overwrite setting “%s”?}
        {Einstellung gespeichert: %s} {Setting saved: %s}
        {Gespeichert: %s} {Saved: %s}
        {Einstellung geladen: %s} {Setting loaded: %s}
        {Geladen: %s} {Loaded: %s}
        {Einstellung „%s“ löschen?} {Delete setting “%s”?}
        {Einstellung gelöscht: %s} {Setting deleted: %s}
        {Gelöscht: %s} {Deleted: %s}
        {Nichts gewählt.} {Nothing selected.}
        {Für diese Auswahl liegt keine Index-Tabelle.} {This selection has no index table.}
        {%d Index-Tabellen entfernen?\nDie PDFs bleiben.\n\n%s} {Remove %d index tables?\nThe PDFs stay.\n\n%s}
        {nicht entfernt %s: %s} {not removed %s: %s}
        {entfernt %s} {removed %s}
        {%d Index-Tabellen entfernt} {%d index tables removed}
        {%d Index-Tabellen entfernt.} {%d index tables removed.}
        {Abbruch…} {Cancelling…}
        Ordner Folder
        PDF PDF
        {Titel auf der Titelseite. Bei einem gewählten Handbuch steht hier dessen Name, zum Beispiel Tcl/Tk 9.0. Bei mehreren bleibt das Feld leer, jedes PDF behält den Namen aus der Liste. Ein geänderter Text gilt für alle gewählten PDFs. Bücher nehmen den Titel aus book.tcl.} {Title on the title page. With one manual selected, this is its name, for example Tcl/Tk 9.0. With several, the field stays empty and each PDF keeps the name from the list. A changed text is used for every selected PDF. Books take the title from book.tcl.}
        {Untertitel. Handbuchseiten: „Handbuchseiten (deutsch)“ und „Reference manual pages“. Pakete wie Tablelist: „Programmierhandbuch (deutsch)“ und „Programmer's guide“. Steht das Feld auf dieser Vorgabe, gilt sie je Handbuch und je Sprache. Ein geänderter Text gilt für alle.} {Subtitle. Manual pages: “Handbuchseiten (deutsch)” and “Reference manual pages”. Packages such as Tablelist: “Programmierhandbuch (deutsch)” and “Programmer's guide”. While the field shows this preset, it applies per manual and language. A changed text applies to all.}
        {Autorzeile auf der Titelseite und in den PDF-Angaben. Leer: die Zeile entfällt. Die Copyright-Zeilen der einzelnen Seiten bleiben.} {Author line on the title page and in the PDF metadata. Empty: the line is omitted. The copyright lines of the individual pages stay.}
        {Datum auf der Titelseite, JJJJ-MM-TT. Vorgabe ist heute in UTC, oder das Datum aus SOURCE_DATE_EPOCH.} {Date on the title page, YYYY-MM-DD. The preset is today in UTC, or the date from SOURCE_DATE_EPOCH.}
        {Betreff in den PDF-Angaben. Vorgabe ist der Untertitel des jeweiligen Handbuchs.} {Subject in the PDF metadata. The preset is the subtitle of each manual.}
        {Text vor dem Lizenzkapitel. Vorgabe nimmt scripts/createpdf/uebersetzung-de.txt für Deutsch und umwandlung-en.txt für Englisch. „keine“ lässt den Vermerk weg. „Datei“ nimmt den Pfad im Feld daneben.} {Text before the license chapter. Default uses scripts/createpdf/uebersetzung-de.txt for German and umwandlung-en.txt for English. “None” omits the note. “File” uses the path in the next field.}
        {Titelseite mit Titel, Untertitel, Autor und Datum.} {Title page with title, subtitle, author and date.}
        {Vermerk-Datei. Bei „Vorgabe“ zeigt das Feld die Datei der gewählten Sprache; gebaut wird je Sprache die passende. Bei „Datei“ wird genau dieser Pfad verwendet. Der Knopf daneben öffnet den Dateidialog.} {Note file. On “Default” the field shows the file for the selected language; each language is built with its own file. On “File” this exact path is used. The button beside it opens the file dialog.}
        {Stichwortverzeichnis am Ende, aus den Ankern der Seiten.} {Index at the end, from the page anchors.}
        {Kopfzeile mit Kurztitel und Seitenzahl.} {Header with the short title and the page number.}
        {Zwischenüberschriften nach den Ordnern, etwa Tcl und Tk.} {Section headings by folder, such as Tcl and Tk.}
        {Lizenzkapitel. createpdf sucht license.terms, LICENSE oder COPYING im Quellenbaum.} {License chapter. createpdf looks for license.terms, LICENSE or COPYING in the source tree.}
        {CID-Schrift für Umlaute und den vollen Zeichenvorrat der Seiten.} {CID font for accented letters and the full character set of the pages.}
        {Schreibt neben das PDF eine .index.tsv. Der Gesamtindex liest alle vorhandenen Tabellen der Tcl-Familie. „TSV entfernen“ löscht die Tabellen der gewählten Handbücher; die PDFs bleiben.} {Writes an .index.tsv next to the PDF. The combined index reads every existing Tcl-family table. “Remove TSV” deletes the tables of the selected manuals; the PDFs stay.}
        {Schreibt das zusammengefügte Markdown neben das PDF.} {Writes the merged Markdown next to the PDF.}
        {Bestand legt die PDFs nach Tcl-family/de-pdf, Books/de-pdf und die englischen Geschwister, wie build-pdfs.sh. Ordner schreibt alle in den Zielordner.} {Collection stores the PDFs in Tcl-family/de-pdf, Books/de-pdf and the English siblings, as build-pdfs.sh does. Folder writes all of them into the output folder.}
        {Sprache des eigenen Ordners: Vermerk, Untertitel und die PDF-Angabe -lang.} {Language of the own folder: note, subtitle and the PDF option -lang.}
        {Zielordner, nur bei Ablegen „Ordner“. Vorgabe ist das Verzeichnis der Handbuchsammlung. Der Knopf daneben öffnet den Ordnerdialog.} {Output folder, only when Store is “Folder”. The preset is the manual collection. The button beside it opens the folder dialog.}
        {Weiterer Markdown-Ordner, zusätzlich zur Liste. Leer: kein zusätzliches PDF. Der Knopf daneben öffnet den Ordnerdialog.} {Extra Markdown folder, in addition to the list. Empty: no extra PDF. The button beside it opens the folder dialog.}
        {Zieldatei für den eigenen Ordner. Vorgabe ist Tcl-family/de-pdf/eigen.pdf bzw. en-pdf. Der Knopf daneben öffnet den Dateidialog.} {Output file for the own folder. The preset is Tcl-family/de-pdf/eigen.pdf or en-pdf. The button beside it opens the file dialog.}
        {Pfad zu bookkit. Die Bücher rufen tools/book-build.tcl auf. Handbücher brauchen ihn nicht. Der Knopf daneben öffnet den Ordnerdialog.} {Path to bookkit. The books call tools/book-build.tcl. Manuals do not need it. The button beside it opens the folder dialog.}
        {Ein Handbuch oder mehrere. Strg-Klick und Umschalt erweitern die Auswahl. Deutsch und Englisch sind getrennte Läufe. Der Gesamtindex braucht die .index.tsv der Handbücher.} {One manual or several. Ctrl-click and Shift extend the selection. German and English are separate runs. The combined index needs the .index.tsv files of the manuals.}
        {Deutsche Markdown-Seiten und der Vermerk zur Übersetzung.} {German Markdown pages and the note about the translation.}
        {Englische Markdown-Seiten und der Vermerk zur Umwandlung.} {English Markdown pages and the note about the conversion.}
        {Wählt alle Einträge der Liste.} {Selects every entry in the list.}
        {Hebt die Auswahl auf.} {Clears the selection.}
        {Ordner de-markdown. Daraus kommen die deutschen Seiten für Tcl-family und Extensions.} {The de-markdown folder. German pages for Tcl-family and Extensions come from here.}
        {Ordnerdialog für de-markdown. Der Dialog öffnet den eingetragenen Ordner.} {Folder dialog for de-markdown. It opens the folder shown in the field.}
        {Ordner en-markdown. Daraus kommen die englischen Seiten, einschließlich der C-API.} {The en-markdown folder. English pages, including the C API, come from here.}
        {Ordnerdialog für en-markdown. Der Dialog öffnet den eingetragenen Ordner.} {Folder dialog for en-markdown. It opens the folder shown in the field.}
        {Vermerk-Datei wählen und Vermerk auf „Datei“ stellen.} {Pick the note file and set the note to “File”.}
        {Ordner für Ablegen „Ordner“ wählen.} {Pick the folder used when Store is “Folder”.}
        {Markdown-Ordner für das zusätzliche PDF wählen.} {Pick the Markdown folder for the extra PDF.}
        {Zieldatei für den eigenen Ordner wählen.} {Pick the output file for the own folder.}
        {Bookkit-Verzeichnis wählen.} {Pick the bookkit directory.}
        {Name der Einstellung. Ein neuer Name legt eine weitere an. Dieselbe Liste gilt für alle Kopien der Sammlung, abgelegt unter ~/.config/tcltk-manuals/pdfgui/.} {Name of the setting. A new name adds another one. The same list is used by every copy of the collection, stored under ~/.config/tcltk-manuals/pdfgui/.}
        {Speichert Auswahl, Sprachen, Markdown-Ordner und alle Formularfelder unter diesem Namen.} {Saves the selection, the languages, the Markdown folders and every form field under this name.}
        {Lädt die genannte Einstellung.} {Loads the named setting.}
        {Löscht die genannte Einstellung. Die Handbücher und PDFs bleiben.} {Deletes the named setting. The manuals and PDFs stay.}
        {Entfernt die .index.tsv der gewählten Handbücher und Sprachen. Die PDFs bleiben. Nur der Gesamtindex gewählt: alle Tabellen der Tcl-Familie in diesen Sprachen.} {Removes the .index.tsv files of the selected manuals and languages. The PDFs stay. If only the combined index is selected: every Tcl-family table in those languages.}
        {Kopiert die gewählten Handbücher aus der Übersetzung in die Sammlung. Lizenzdateien bleiben. Bücher und der Gesamtindex haben dort keine Seiten.} {Copies the selected manuals from the translation tree into the collection. License files stay. Books and the combined index have no pages there.}
        {Baut die gewählten PDFs nacheinander. Das Protokoll zeigt jeden Lauf.} {Builds the selected PDFs one after another. The log shows each run.}
        {Beendet den laufenden Bau. Fertige PDFs bleiben liegen.} {Stops the running build. PDFs already written stay.}
        {Ausgabe von createpdf, dem Gesamtindex und bookkit.} {Output of createpdf, the combined index and bookkit.}
        {Fehler: %s} {Error: %s}
    } {
        ::msgcat::mcset en $de $en
    }
}

proc ::pdfgui::tip {w text} {
    if {![winfo exists $w]} return
    ::tkutils::tkuballoon::add $w [t $text]
}

proc ::pdfgui::helpBalloons {} {
    ::tkutils::tkuballoon::configure -delay 450 -wraplength 380
    set helps {
        title "Titel auf der Titelseite. Bei einem gewählten Handbuch steht hier dessen Name, zum Beispiel Tcl/Tk 9.0. Bei mehreren bleibt das Feld leer, jedes PDF behält den Namen aus der Liste. Ein geänderter Text gilt für alle gewählten PDFs. Bücher nehmen den Titel aus book.tcl."
        subtitle "Untertitel. Handbuchseiten: „Handbuchseiten (deutsch)“ und „Reference manual pages“. Pakete wie Tablelist: „Programmierhandbuch (deutsch)“ und „Programmer's guide“. Steht das Feld auf dieser Vorgabe, gilt sie je Handbuch und je Sprache. Ein geänderter Text gilt für alle."
        author "Autorzeile auf der Titelseite und in den PDF-Angaben. Leer: die Zeile entfällt. Die Copyright-Zeilen der einzelnen Seiten bleiben."
        date "Datum auf der Titelseite, JJJJ-MM-TT. Vorgabe ist heute in UTC, oder das Datum aus SOURCE_DATE_EPOCH."
        subject "Betreff in den PDF-Angaben. Vorgabe ist der Untertitel des jeweiligen Handbuchs."
        vermerk "Text vor dem Lizenzkapitel. Vorgabe nimmt scripts/createpdf/uebersetzung-de.txt für Deutsch und umwandlung-en.txt für Englisch. „keine“ lässt den Vermerk weg. „Datei“ nimmt den Pfad im Feld daneben."
        titlepage "Titelseite mit Titel, Untertitel, Autor und Datum."
        notefile "Vermerk-Datei. Bei „Vorgabe“ zeigt das Feld die Datei der gewählten Sprache; gebaut wird je Sprache die passende. Bei „Datei“ wird genau dieser Pfad verwendet. Der Knopf daneben öffnet den Dateidialog."
        index "Stichwortverzeichnis am Ende, aus den Ankern der Seiten."
        header "Kopfzeile mit Kurztitel und Seitenzahl."
        groups "Zwischenüberschriften nach den Ordnern, etwa Tcl und Tk."
        license "Lizenzkapitel. createpdf sucht license.terms, LICENSE oder COPYING im Quellenbaum."
        cid "CID-Schrift für Umlaute und den vollen Zeichenvorrat der Seiten."
        indextsv "Schreibt neben das PDF eine .index.tsv. Der Gesamtindex liest alle vorhandenen Tabellen der Tcl-Familie. „TSV entfernen“ löscht die Tabellen der gewählten Handbücher; die PDFs bleiben."
        writemd "Schreibt das zusammengefügte Markdown neben das PDF."
        outmode "Bestand legt die PDFs nach Tcl-family/de-pdf, Books/de-pdf und die englischen Geschwister, wie build-pdfs.sh. Ordner schreibt alle in den Zielordner."
        customlang "Sprache des eigenen Ordners: Vermerk, Untertitel und die PDF-Angabe -lang."
        outdir "Zielordner, nur bei Ablegen „Ordner“. Vorgabe ist das Verzeichnis der Handbuchsammlung. Der Knopf daneben öffnet den Ordnerdialog."
        customdir "Weiterer Markdown-Ordner, zusätzlich zur Liste. Leer: kein zusätzliches PDF. Der Knopf daneben öffnet den Ordnerdialog."
        customout "Zieldatei für den eigenen Ordner. Vorgabe ist Tcl-family/de-pdf/eigen.pdf bzw. en-pdf. Der Knopf daneben öffnet den Dateidialog."
        bookkit "Pfad zu bookkit. Die Bücher rufen tools/book-build.tcl auf. Handbücher brauchen ihn nicht. Der Knopf daneben öffnet den Ordnerdialog."
    }
    set i 0
    foreach {name text} $helps {
        tip [::tkutils::tkuform::widgetOf .form $name] $text
        tip .form.l$i $text
        incr i
    }
    tip .list "Ein Handbuch oder mehrere. Strg-Klick und Umschalt erweitern die Auswahl. Deutsch und Englisch sind getrennte Läufe. Der Gesamtindex braucht die .index.tsv der Handbücher."
    tip .top.left.lang.de "Deutsche Markdown-Seiten und der Vermerk zur Übersetzung."
    tip .top.left.lang.en "Englische Markdown-Seiten und der Vermerk zur Umwandlung."
    tip .top.left.bt.all "Wählt alle Einträge der Liste."
    tip .top.left.bt.none "Hebt die Auswahl auf."
    tip .top.right.src.de "Ordner de-markdown. Daraus kommen die deutschen Seiten für Tcl-family und Extensions."
    tip .top.right.src.bde "Ordnerdialog für de-markdown. Der Dialog öffnet den eingetragenen Ordner."
    tip .top.right.src.en "Ordner en-markdown. Daraus kommen die englischen Seiten, einschließlich der C-API."
    tip .top.right.src.ben "Ordnerdialog für en-markdown. Der Dialog öffnet den eingetragenen Ordner."
    tip .form.picknotefile "Vermerk-Datei wählen und Vermerk auf „Datei“ stellen."
    tip .form.pickoutdir "Ordner für Ablegen „Ordner“ wählen."
    tip .form.pickcustomdir "Markdown-Ordner für das zusätzliche PDF wählen."
    tip .form.pickcustomout "Zieldatei für den eigenen Ordner wählen."
    tip .form.pickbookkit "Bookkit-Verzeichnis wählen."
    tip .bar.setname "Name der Einstellung. Ein neuer Name legt eine weitere an. Dieselbe Liste gilt für alle Kopien der Sammlung, abgelegt unter ~/.config/tcltk-manuals/pdfgui/."
    tip .bar.save "Speichert Auswahl, Sprachen, Markdown-Ordner und alle Formularfelder unter diesem Namen."
    tip .bar.load "Lädt die genannte Einstellung."
    tip .bar.forget "Löscht die genannte Einstellung. Die Handbücher und PDFs bleiben."
    tip .drop "Entfernt die .index.tsv der gewählten Handbücher und Sprachen. Die PDFs bleiben. Nur der Gesamtindex gewählt: alle Tabellen der Tcl-Familie in diesen Sprachen."
    tip .sync "Kopiert die gewählten Handbücher aus der Übersetzung in die Sammlung. Lizenzdateien bleiben. Bücher und der Gesamtindex haben dort keine Seiten."
    tip .go "Baut die gewählten PDFs nacheinander. Das Protokoll zeigt jeden Lauf."
    tip .cancel "Beendet den laufenden Bau. Fertige PDFs bleiben liegen."
    tip .log "Ausgabe von createpdf, dem Gesamtindex und bookkit."
}

proc ::pdfgui::createArgs {dir out lang title subtitle form} {
    variable repo
    set cmd [list [tclsh] \
        [file join $repo scripts createpdf createpdf.tcl] $dir \
        -o $out -title $title -lang $lang]
    set sub $subtitle
    if {[edited $form subtitle]} {
        set sub [string trim [::tkutils::tkuform::get $form subtitle]]
    }
    if {$sub ne ""} { lappend cmd -subtitle $sub }
    foreach {field opt} {author -author date -date} {
        set v [string trim [::tkutils::tkuform::get $form $field]]
        if {$v ne ""} { lappend cmd $opt $v }
    }
    if {[edited $form subject]} {
        set v [string trim [::tkutils::tkuform::get $form subject]]
        if {$v ne ""} { lappend cmd -subject $v }
    } elseif {$sub ne ""} {
        lappend cmd -subject $sub
    }
    set note [noteFile $lang $form]
    if {$note ne ""} { lappend cmd -note $note }
    foreach {field flag} {
        license -no-license titlepage -no-title-page index -no-index
        header -no-header groups -no-groups cid -no-cid
    } {
        if {![flagOn $form $field]} { lappend cmd $flag }
    }
    if {[flagOn $form indextsv]} {
        lappend cmd -index-tsv [file rootname $out].index.tsv
    }
    if {[flagOn $form writemd]} {
        lappend cmd -md [file rootname $out].md
    }
    return $cmd
}

proc ::pdfgui::outPath {gruppe lang name form {withLang 1}} {
    variable repo
    if {$withLang} {
        set file $name-$lang.pdf
    } else {
        set file $name.pdf
    }
    set base [string trim [::tkutils::tkuform::get $form outdir]]
    if {[choice $form outmode] eq "folder" && $base ne ""} {
        return [file join $base $file]
    }
    return [file join $repo $gruppe $lang-pdf $file]
}

# Liste {label cmd} in der Reihenfolge des Laufs. Wirft bei einer Lücke
# in der Auswahl (keine Sprache, Buch ohne bookkit, leerer Zielordner).
proc ::pdfgui::jobs {form tmp} {
    variable repo
    set langs [langs]
    if {![llength $langs]} {
        return -code error [t "Keine Sprache gewählt."]
    }
    if {[choice $form outmode] eq "folder"} {
        set base [string trim [::tkutils::tkuform::get $form outdir]]
        if {$base eq "" || ![file isdirectory $base]} {
            return -code error [t "Zielordner fehlt oder ist kein Ordner."]
        }
    }
    set bookkit [string trim [::tkutils::tkuform::get $form bookkit]]
    set jobs {}
    set n 0
    foreach name [selectedNames] {
        set row [row $name]
        if {$row eq ""} continue
        lassign $row name gruppe ordner teile tde ten art
        if {$art eq "index"} continue
        if {$art eq "buch"} {
            set lang [string range $name end-1 end]
            if {$lang ni $langs} continue
            set src [file join $repo Books $lang-markdown $ordner]
            if {![file exists [file join $src book.tcl]]} {
                return -code error [t "%s: kein book.tcl unter %s" $name $src]
            }
            if {$bookkit eq "" || ![file exists [file join $bookkit tools book-build.tcl]]} {
                return -code error [t "Bookkit fehlt. Pfad auf tools/book-build.tcl setzen."]
            }
            set out [outPath Books $lang $name $form 0]
            lappend jobs [list $name [list [tclsh] \
                [file join $bookkit tools book-build.tcl] $src -number -pdf $out]]
            continue
        }
        foreach lang $langs {
            set src [file join $repo $gruppe $lang-markdown $ordner]
            set work [file join $tmp $lang $name]
            if {![prepare $src $teile $work]} {
                lappend jobs [list [t "%s (%s): keine Seiten, übersprungen" $name $lang] {}]
                continue
            }
            if {$lang eq "de"} { set titel $tde } else { set titel $ten }
            if {[edited $form title]} {
                set over [string trim [::tkutils::tkuform::get $form title]]
                if {$over ne ""} { set titel $over }
            }
            if {[string match pakete/* $ordner]} {
                set ude "Programmierhandbuch (deutsch)"
                set uen "Programmer's guide"
            } else {
                set ude "Handbuchseiten (deutsch)"
                set uen "Reference manual pages"
            }
            if {$lang eq "de"} { set sub $ude } else { set sub $uen }
            set out [outPath $gruppe $lang $name $form]
            lappend jobs [list "$name ($lang)" \
                [createArgs $work $out $lang $titel $sub $form]]
            incr n
        }
    }
    set custom [string trim [::tkutils::tkuform::get $form customdir]]
    if {$custom ne ""} {
        if {![file isdirectory $custom]} {
            return -code error [t "Eigener Ordner ist kein Verzeichnis."]
        }
        set lang [::tkutils::tkuform::get $form customlang]
        set out [string trim [::tkutils::tkuform::get $form customout]]
        if {$out eq ""} {
            return -code error [t "Für den eigenen Ordner fehlt die Ausgabe-PDF."]
        }
        set work [file join $tmp custom]
        if {![prepare $custom * $work]} {
            return -code error [t "Im eigenen Ordner liegen keine Markdown-Seiten."]
        }
        set titel [file tail $custom]
        if {[edited $form title]} {
            set over [string trim [::tkutils::tkuform::get $form title]]
            if {$over ne ""} { set titel $over }
        }
        if {$lang eq "de"} {
            set sub "Handbuchseiten (deutsch)"
        } else {
            set sub "Reference manual pages"
        }
        lappend jobs [list [t "eigener Ordner (%s)" $lang] \
            [createArgs $work $out $lang $titel $sub $form]]
    }
    if {[lsearch -exact [selectedNames] tcl-family-index] >= 0} {
        foreach lang $langs {
            set tsvs {}
            variable katalog
            foreach row $katalog {
                if {[lindex $row 1] ne "Tcl-family" || [lindex $row 6] ne "handbuch"} continue
                set t [file rootname [outPath Tcl-family $lang [lindex $row 0] $form]].index.tsv
                if {[file exists $t]} { lappend tsvs $t }
            }
            if {![llength $tsvs]} {
                lappend jobs [list [t "Gesamtindex (%s): keine Index-Tabellen" $lang] {}]
                continue
            }
            if {$lang eq "de"} {
                set titel "Tcl-Familie: Gesamtindex"
            } else {
                set titel "Tcl family: combined index"
            }
            set over [string trim [::tkutils::tkuform::get $form title]]
            if {$over ne "" && [llength [selectedNames]] == 1} { set titel $over }
            set out [outPath Tcl-family $lang tcl-family-index $form]
            lappend jobs [list [t "Gesamtindex (%s)" $lang] [list [tclsh] \
                [file join $repo scripts createpdf index-gesamt.tcl] \
                -pdf $out -lang $lang -title $titel {*}$tsvs]]
        }
    }
    set real 0
    foreach job $jobs {
        if {[llength [lindex $job 1]]} { incr real }
    }
    if {$real == 0} {
        return -code error [t "Nichts gewählt, oder die gewählten Seiten fehlen in dieser Sprache."]
    }
    return $jobs
}

# Starter für tutask::await: Ausgabe zeilenweise ins Protokoll,
# Abbruch beendet den Prozess.
proc ::pdfgui::runStart {cmd} {
    return [list ::pdfgui::runGo $cmd]
}

proc ::pdfgui::runGo {cmd cb} {
    variable runs
    set ch [open |[concat $cmd [list 2>@1]] r]
    set cfg {-blocking 0 -translation auto -encoding utf-8}
    if {[package vcompare [info tclversion] 9] >= 0} {
        lappend cfg -profile replace
    }
    chan configure $ch {*}$cfg
    set runs($ch) [list $cb ""]
    chan event $ch readable [list ::pdfgui::runRead $ch]
    return [list ::pdfgui::runKill $ch]
}

proc ::pdfgui::runRead {ch} {
    variable runs
    if {![info exists runs($ch)]} { return }
    lassign $runs($ch) cb buf
    if {[catch {append buf [read $ch]} m o]} {
        runKill $ch
        {*}$cb error $m $o
        return
    }
    set runs($ch) [list $cb $buf]
    if {![eof $ch]} { return }
    chan event $ch readable {}
    unset runs($ch)
    if {$buf ne ""} { log [string trimright $buf] }
    chan configure $ch -blocking 1
    if {[catch {close $ch} m o]} {
        {*}$cb error $m $o
    } else {
        {*}$cb ok {}
    }
}

proc ::pdfgui::runKill {ch} {
    variable runs
    if {![info exists runs($ch)]} { return }
    unset runs($ch)
    catch {chan event $ch readable {}}
    set pids {}
    catch {set pids [pid $ch]}
    foreach p $pids { catch {exec kill $p} }
    catch {chan configure $ch -blocking 1}
    catch {close $ch}
}

proc ::pdfgui::settingDir {} {
    if {[info exists ::env(XDG_CONFIG_HOME)] && $::env(XDG_CONFIG_HOME) ne ""} {
        set base $::env(XDG_CONFIG_HOME)
    } else {
        set base [file join $::env(HOME) .config]
    }
    return [file join $base tcltk-manuals pdfgui]
}

proc ::pdfgui::settingPath {name} {
    set name [string trim $name]
    if {$name eq "" || [regexp {[/\\\u0000]} $name] || $name in {. ..}} {
        return -code error [t "Name fehlt oder enthält einen Schrägstrich."]
    }
    return [file join [settingDir] $name.cfg]
}

proc ::pdfgui::settingNames {} {
    set dir [settingDir]
    if {![file isdirectory $dir]} { return {} }
    set names {}
    foreach f [lsort -dictionary [glob -nocomplain -directory $dir *.cfg]] {
        lappend names [file rootname [file tail $f]]
    }
    return $names
}

proc ::pdfgui::refreshSettings {} {
    if {![winfo exists .bar.setname]} return
    .bar.setname configure -values [settingNames]
}

proc ::pdfgui::collectSetting {} {
    return [dict create \
        langs [langs] \
        names [selectedNames] \
        srcde [srcPath de] \
        srcen [srcPath en] \
        ui $::pdfgui::uiLang \
        form [::tkutils::tkuform::values .form]]
}

# Auswahl zuerst, damit die Vorgaben stehen, danach die gespeicherten
# Felder. Ein abweichender Text bleibt damit eine Änderung.
proc ::pdfgui::applySetting {d} {
    if {![dict exists $d langs] || ![dict exists $d names] || ![dict exists $d form]} {
        return -code error [t "Die Datei enthält keine Einstellung."]
    }
    if {[dict exists $d ui] && [dict get $d ui] in {de en}} {
        variable uiLang
        set uiLang [dict get $d ui]
        ::msgcat::mclocale $uiLang
        applyTexts
    }
    set ::pdfgui::langDe [expr {"de" in [dict get $d langs]}]
    set ::pdfgui::langEn [expr {"en" in [dict get $d langs]}]
    .list selection clear 0 end
    foreach name [dict get $d names] {
        set i [lsearch -exact $::pdfgui::names $name]
        if {$i >= 0} { .list selection set $i }
    }
    fillDefaults
    ::tkutils::tkuform::setValues .form [dict get $d form]
    if {[dict exists $d srcde]} { setSrc de [dict get $d srcde] 0 }
    if {[dict exists $d srcen]} { setSrc en [dict get $d srcen] 0 }
    retargetChoices
}

proc ::pdfgui::writeSetting {name} {
    set path [settingPath $name]
    file mkdir [file dirname $path]
    set fh [open $path w]
    fconfigure $fh -encoding utf-8
    puts $fh [collectSetting]
    close $fh
    refreshSettings
    set ::pdfgui::settingName $name
    return $path
}

proc ::pdfgui::readSetting {name} {
    set path [settingPath $name]
    if {![file isfile $path]} {
        return -code error [t "Keine Einstellung „%s“." $name]
    }
    set fh [open $path r]
    fconfigure $fh -encoding utf-8
    set raw [read $fh]
    close $fh
    if {[catch {dict size $raw}]} {
        return -code error [t "Einstellung „%s“ ist keine gültige Datei." $name]
    }
    applySetting $raw
    set ::pdfgui::settingName $name
    refreshSettings
    return $path
}

proc ::pdfgui::saveSetting {} {
    set name [string trim $::pdfgui::settingName]
    if {[catch {set path [settingPath $name]} msg]} {
        ::tkutils::tkudialog::showError $msg -parent .
        return
    }
    if {[file exists $path]} {
        if {![::tkutils::tkudialog::confirm \
                [t "Einstellung „%s“ überschreiben?" $name] -parent .]} {
            return
        }
    }
    if {[catch {writeSetting $name} msg]} {
        ::tkutils::tkudialog::showError $msg -parent .
        return
    }
    log [t "Einstellung gespeichert: %s" $path]
    ::tkutils::tkustatus::setText .status [t "Gespeichert: %s" $name]
}

proc ::pdfgui::loadSetting {} {
    set name [string trim $::pdfgui::settingName]
    if {[catch {set path [readSetting $name]} msg]} {
        ::tkutils::tkudialog::showError $msg -parent .
        return
    }
    log [t "Einstellung geladen: %s" $path]
    ::tkutils::tkustatus::setText .status [t "Geladen: %s" $name]
}

proc ::pdfgui::forgetSetting {} {
    set name [string trim $::pdfgui::settingName]
    if {[catch {set path [settingPath $name]} msg]} {
        ::tkutils::tkudialog::showError $msg -parent .
        return
    }
    if {![file isfile $path]} {
        ::tkutils::tkudialog::showInfo [t "Keine Einstellung „%s“." $name] -parent .
        return
    }
    if {![::tkutils::tkudialog::confirm \
            [t "Einstellung „%s“ löschen?" $name] -parent .]} {
        return
    }
    file delete $path
    refreshSettings
    log [t "Einstellung gelöscht: %s" $path]
    ::tkutils::tkustatus::setText .status [t "Gelöscht: %s" $name]
}

proc ::pdfgui::setBusy {busy} {
    set idle [expr {$busy ? "disabled" : "normal"}]
    .drop configure -state $idle
    .sync configure -state $idle
    .go configure -state $idle
    .bar.save configure -state $idle
    .bar.load configure -state $idle
    .bar.forget configure -state $idle
    .bar.setname configure -state $idle
    .cancel configure -state [expr {$busy ? "normal" : "disabled"}]
    .list configure -state $idle
}

proc ::pdfgui::finish {t} {
    variable task
    set task ""
    setBusy 0
    set fail 0
    if {[$t state] eq "error"} {
        set msg ""
        catch {set msg [$t result]} err
        if {$msg eq ""} { set msg $err }
        ::tkutils::tkustatus::setText .status [t Fehler]
        ::tkutils::tkustatus::progress .status ""
        ::tkutils::tkudialog::showError $msg -parent .
    } elseif {[$t state] eq "cancelled"} {
        ::tkutils::tkustatus::setText .status [t Abgebrochen]
        ::tkutils::tkustatus::progress .status ""
    } else {
        set fail [$t result]
        if {$fail == 0} {
            ::tkutils::tkustatus::setText .status [t Fertig]
            ::tkutils::tkudialog::showInfo [t "Die PDFs sind geschrieben."] -parent .
        } else {
            ::tkutils::tkustatus::setText .status [t "%d fehlgeschlagen" $fail]
            ::tkutils::tkudialog::showWarning \
                [t "%d Lauf fehlgeschlagen. Das Protokoll steht unten." $fail] -parent .
        }
        ::tkutils::tkustatus::progress .status ""
    }
    catch {$t destroy}
}

proc ::pdfgui::go {} {
    variable task
    variable repo
    if {$task ne ""} { return }
    set tmp [file join [::pdfgui::tmpParent] pdfgui-[pid]]
    file delete -force $tmp
    file mkdir $tmp
    if {[catch {jobs .form $tmp} jobs msg]} {
        file delete -force $tmp
        ::tkutils::tkudialog::showError $msg -parent .
        return
    }
    setBusy 1
    ::tkutils::tkustatus::progress .status 0
    ::tkutils::tkustatus::setText .status [t Start]
    set task [::tclutils::tutask::spawn apply {{jobs tmp} {
        set n [llength $jobs]
        set i 0
        set fail 0
        foreach job $jobs {
            lassign $job label cmd
            incr i
            ::tkutils::tkustatus::setText .status "$label  ($i/$n)"
            ::tkutils::tkustatus::progress .status \
                [expr {int(100.0 * ($i - 1) / $n)}]
            ::pdfgui::log "== $label"
            if {![llength $cmd]} continue
            foreach flag {-o -pdf} {
                set at [lsearch -exact $cmd $flag]
                if {$at >= 0} {
                    file mkdir [file dirname [lindex $cmd $at+1]]
                }
            }
            if {[catch {
                ::tclutils::tutask::await [::pdfgui::runStart $cmd]
            } err]} {
                incr fail
                ::pdfgui::log [::pdfgui::t "Fehler: %s" $err]
            }
        }
        ::tkutils::tkustatus::progress .status 100
        file delete -force $tmp
        return $fail
    }} $jobs $tmp]
    $task ondone ::pdfgui::finish
}

proc ::pdfgui::tmpParent {} {
    if {[info exists ::env(TMPDIR)] && $::env(TMPDIR) ne ""} {
        return $::env(TMPDIR)
    }
    return /tmp
}

# Index-Tabellen der Auswahl. Nur der Gesamtindex: alle Tabellen der
# Tcl-Familie. Bücher haben keine solche Tabelle.
proc ::pdfgui::tsvTargets {} {
    set form .form
    set langs [langs]
    set handbooks {}
    set onlyIndex 1
    set sawIndex 0
    foreach name [selectedNames] {
        set row [row $name]
        if {$row eq ""} continue
        switch -- [lindex $row 6] {
            index    { set sawIndex 1 }
            handbuch {
                set onlyIndex 0
                lappend handbooks $name
            }
            default { set onlyIndex 0 }
        }
    }
    if {$sawIndex && $onlyIndex} {
        variable katalog
        foreach row $katalog {
            if {[lindex $row 1] eq "Tcl-family" && [lindex $row 6] eq "handbuch"} {
                lappend handbooks [lindex $row 0]
            }
        }
    }
    set files {}
    foreach name $handbooks {
        set row [row $name]
        lassign $row name gruppe ordner teile tde ten art
        foreach lang $langs {
            set pdf [outPath $gruppe $lang $name $form]
            lappend files [file rootname $pdf].index.tsv
        }
    }
    return $files
}

proc ::pdfgui::dropTsv {} {
    variable task
    if {$task ne ""} {
        ::tkutils::tkudialog::showWarning [t "Es läuft schon ein Bau."] -parent .
        return
    }
    if {![llength [langs]]} {
        ::tkutils::tkudialog::showError [t "Keine Sprache gewählt."] -parent .
        return
    }
    if {![llength [selectedNames]]} {
        ::tkutils::tkudialog::showWarning [t "Nichts gewählt."] -parent .
        return
    }
    set gone {}
    foreach f [tsvTargets] {
        if {[file isfile $f]} { lappend gone $f }
    }
    if {![llength $gone]} {
        ::tkutils::tkudialog::showInfo \
            [t "Für diese Auswahl liegt keine Index-Tabelle."] -parent .
        return
    }
    set n [llength $gone]
    set preview [join [lrange $gone 0 7] \n]
    if {$n > 8} { append preview "\n…" }
    if {![::tkutils::tkudialog::confirm \
            [t "%d Index-Tabellen entfernen?\nDie PDFs bleiben.\n\n%s" $n $preview] \
            -parent .]} {
        return
    }
    set nDel 0
    foreach f $gone {
        if {[catch {file delete $f} msg]} {
            log [t "nicht entfernt %s: %s" $f $msg]
        } else {
            incr nDel
            log [t "entfernt %s" $f]
        }
    }
    ::tkutils::tkustatus::setText .status [t "%d Index-Tabellen entfernt" $nDel]
    ::tkutils::tkudialog::showInfo [t "%d Index-Tabellen entfernt." $nDel] -parent .
}

proc ::pdfgui::cancel {} {
    variable task
    if {$task eq ""} { return }
    catch {$task cancel}
    ::tkutils::tkustatus::setText .status [t "Abbruch…"]
}

proc ::pdfgui::pickSrc {lang} {
    set cur [srcPath $lang]
    if {$cur eq "" || ![file isdirectory $cur]} {
        set cur [defaultSrc $lang]
    }
    if {![file isdirectory $cur]} {
        set cur [file dirname $cur]
    }
    set title [t Deutsch]
    if {$lang eq "en"} { set title [t Englisch] }
    set d [::tkutils::tkufiledialog::directory -parent . \
        -title $title -initialdir $cur]
    if {$d ne ""} { setSrc $lang $d 0 }
}

# Eine Spalte zwischen den beiden Formularspalten freimachen, damit
# der Auswahldialog direkt am Feld sitzt und keine Knopfreihe dazwischen.
proc ::pdfgui::openChooserColumn {} {
    foreach s [grid slaves .form] {
        set c [dict get [grid info $s] -column]
        if {$c >= 2} {
            grid configure $s -column [expr {$c + 1}]
        }
    }
    grid columnconfigure .form 3 -weight 0
    grid columnconfigure .form 1 -weight 1
    grid columnconfigure .form 4 -weight 1
}

proc ::pdfgui::chooser {field cmd} {
    set w [::tkutils::tkuform::widgetOf .form $field]
    set info [grid info $w]
    set row [dict get $info -row]
    set col [dict get $info -column]
    ttk::button .form.pick$field -text "…" -width 2 -command $cmd
    grid .form.pick$field -row $row -column [expr {$col + 1}] \
        -sticky ew -padx {2 8} -pady 3
}

proc ::pdfgui::pickDir {field} {
    set cur [string trim [::tkutils::tkuform::get .form $field]]
    if {$cur eq "" || ![file isdirectory $cur]} { set cur $::pdfgui::repo }
    set d [::tkutils::tkufiledialog::directory -parent . \
        -title [t Ordner] -initialdir $cur]
    if {$d ne ""} { ::tkutils::tkuform::setField .form $field $d }
}

proc ::pdfgui::pickPdf {} {
    set cur [string trim [::tkutils::tkuform::get .form customout]]
    set init $::pdfgui::repo
    set file ""
    if {$cur ne ""} {
        set init [file dirname $cur]
        set file [file tail $cur]
    }
    set s [::tkutils::tkufiledialog::save -parent . -title [t PDF] \
        -initialdir $init -initialfile $file \
        -filetypes {{PDF {.pdf}} {Alle *}}]
    if {$s ne ""} { ::tkutils::tkuform::setField .form customout $s }
}

proc ::pdfgui::pickNote {} {
    set s [::tkutils::tkufiledialog::open -parent . -title [t Vermerk] \
        -initialdir $::pdfgui::repo \
        -filetypes {{Text {.txt}} {Alle *}}]
    if {$s ne ""} {
        ::tkutils::tkuform::setField .form vermerk [choiceLabel vermerk file]
        ::tkutils::tkuform::setField .form notefile $s
    }
}

proc ::pdfgui::buildUi {} {
    variable katalog
    variable repo
    wm title . [t "Handbuch-PDFs"]
    wm geometry . 980x640
    wm minsize . 860 520
    ttk::frame .ui -padding {6 4 6 0}
    ttk::label .ui.cap -text [t Oberfläche]
    ttk::radiobutton .ui.de -text Deutsch -value de \
        -variable ::pdfgui::uiLang -command ::pdfgui::useLang
    ttk::radiobutton .ui.en -text English -value en \
        -variable ::pdfgui::uiLang -command ::pdfgui::useLang
    pack .ui.cap .ui.de .ui.en -in .ui -side left -padx 4

    ttk::panedwindow .top -orient horizontal
    ttk::frame .top.left -padding 6
    ttk::frame .top.right -padding 6
    .top add .top.left -weight 1
    .top add .top.right -weight 2

    ttk::label .top.left.cap -text "Handbücher"
    ttk::frame .top.left.lang
    ttk::checkbutton .top.left.lang.de -text "deutsch" \
        -variable ::pdfgui::langDe -command ::pdfgui::fillDefaults
    ttk::checkbutton .top.left.lang.en -text "englisch" \
        -variable ::pdfgui::langEn -command ::pdfgui::fillDefaults
    set ::pdfgui::langDe 1
    set ::pdfgui::langEn 1
    pack .top.left.lang.de .top.left.lang.en -side left -padx 4
    set ::pdfgui::names {}
    listbox .list -selectmode extended -exportselection 0 \
        -yscrollcommand {.scroll set} -height 12
    ttk::scrollbar .scroll -command {.list yview}
    foreach row $katalog {
        lappend ::pdfgui::names [lindex $row 0]
    }
    fillList
    ttk::frame .top.left.bt
    ttk::button .top.left.bt.all -text "Alle" -command {
        .list selection set 0 end
        ::pdfgui::fillDefaults
    }
    ttk::button .top.left.bt.none -text "Keine" -command {
        .list selection clear 0 end
        ::pdfgui::fillDefaults
    }
    pack .top.left.bt.all .top.left.bt.none -side left -padx 4
    pack .top.left.cap -side top -anchor w
    pack .top.left.lang -side top -anchor w -pady 2
    pack .scroll -in .top.left -side right -fill y
    pack .list -in .top.left -side top -fill both -expand 1
    pack .top.left.bt -side top -anchor w -pady 4

    set bookkit [::pdfgui::defaultBookkit]
    set ::pdfgui::srcDe ""
    set ::pdfgui::srcEn ""
    ttk::labelframe .top.right.src -text "Markdown-Quellen" -padding 4
    ttk::label .top.right.src.lde -text "Deutsch"
    ttk::entry .top.right.src.de -textvariable ::pdfgui::srcDe
    ttk::button .top.right.src.bde -text "Wählen…" -command {::pdfgui::pickSrc de}
    ttk::label .top.right.src.len -text "Englisch"
    ttk::entry .top.right.src.en -textvariable ::pdfgui::srcEn
    ttk::button .top.right.src.ben -text "Wählen…" -command {::pdfgui::pickSrc en}
    grid .top.right.src.lde -row 0 -column 0 -sticky w -padx 2 -pady 2
    grid .top.right.src.de  -row 0 -column 1 -sticky ew -padx 2 -pady 2
    grid .top.right.src.bde -row 0 -column 2 -sticky e -padx 2 -pady 2
    grid .top.right.src.len -row 1 -column 0 -sticky w -padx 2 -pady 2
    grid .top.right.src.en  -row 1 -column 1 -sticky ew -padx 2 -pady 2
    grid .top.right.src.ben -row 1 -column 2 -sticky e -padx 2 -pady 2
    grid columnconfigure .top.right.src 1 -weight 1

    set fields {
        {name title     label "Titel" type entry}
        {name subtitle  label "Untertitel" type entry}
        {name author    label "Autor" type entry}
        {name date      label "Datum" type entry}
        {name subject   label "Betreff" type entry}
        {name vermerk   label "Vermerk" type combo
            values {Vorgabe keine Datei} default Vorgabe state readonly}
        {name titlepage label "Titelseite" type check default 1}
        {name notefile  label "Vermerk-Datei" type entry}
        {name index     label "Stichwörter" type check default 1}
        {name header    label "Kopfzeile" type check default 1}
        {name groups    label "Teile je Ordner" type check default 1}
        {name license   label "Lizenzkapitel" type check default 1}
        {name cid       label "Unicode-Schrift" type check default 1}
        {name indextsv  label "Index-Tabelle" type check default 1}
        {name writemd   label "Markdown-Datei" type check default 0}
        {name outmode   label "Ablegen" type combo values {Bestand Ordner}
            default Bestand state readonly}
        {name customlang label "Sprache dazu" type combo
            values {de en} default de state readonly}
        {name outdir    label "Zielordner" type entry}
        {name customdir label "Eigener Ordner" type entry}
        {name customout label "Ausgabe dazu" type entry}
        {name bookkit   label "Bookkit" type entry default ""}
    }
    ::tkutils::tkuform::widget .form $fields -columns 2 -padding 4
    ::tkutils::tkuform::setField .form bookkit $bookkit
    ::pdfgui::openChooserColumn
    ::pdfgui::chooser notefile ::pdfgui::pickNote
    ::pdfgui::chooser outdir {::pdfgui::pickDir outdir}
    ::pdfgui::chooser customdir {::pdfgui::pickDir customdir}
    ::pdfgui::chooser customout ::pdfgui::pickPdf
    ::pdfgui::chooser bookkit {::pdfgui::pickDir bookkit}

    pack .top.right.src -in .top.right -side top -fill x -pady {0 4}
    pack .form -in .top.right -side top -fill both -expand 1

    ttk::frame .logf
    text .log -height 4 -wrap word -state disabled \
        -yscrollcommand {.logscroll set}
    ttk::scrollbar .logscroll -command {.log yview}
    pack .logscroll -in .logf -side right -fill y
    pack .log -in .logf -side left -fill both -expand 1

    ttk::frame .bar
    ttk::button .drop -text "TSV entfernen" -command ::pdfgui::dropTsv
    ttk::button .sync -text "Seiten übernehmen" -command ::pdfgui::syncSelected
    ttk::button .go -text "PDFs erzeugen" -command ::pdfgui::go
    ttk::button .cancel -text "Abbrechen" -command ::pdfgui::cancel \
        -state disabled
    set ::pdfgui::settingName ""
    ttk::combobox .bar.setname -textvariable ::pdfgui::settingName -width 16
    ttk::button .bar.save -text "Speichern" -command ::pdfgui::saveSetting
    ttk::button .bar.load -text "Laden" -command ::pdfgui::loadSetting
    ttk::button .bar.forget -text "Löschen" -command ::pdfgui::forgetSetting
    pack .drop .sync .go .cancel -in .bar -side left -padx 4
    pack .bar.forget .bar.load .bar.save .bar.setname -in .bar -side right -padx 2

    ::tkutils::tkustatus::widget .status
    ::tkutils::tkustatus::setText .status [t Bereit]

    pack .ui -side top -fill x
    pack .status -side bottom -fill x
    pack .bar -side bottom -fill x -pady 4
    pack .logf -side bottom -fill x
    pack .top -side top -fill both -expand 1

    bind .list <<ListboxSelect>> ::pdfgui::fillDefaults
    bind [::tkutils::tkuform::widgetOf .form vermerk] <<ComboboxSelected>> \
        ::pdfgui::fillDefaults
    ::pdfgui::fillDefaults
    ::pdfgui::applyTexts
    ::pdfgui::refreshSettings

    wm protocol . WM_DELETE_WINDOW {
        ::pdfgui::cancel
        destroy .
    }
}

::pdfgui::loadCatalog
::pdfgui::buildUi

if {[info exists env(PDFGUI_SELFTEST)]} {
    after idle {
        .list selection set 0
        if {[catch {::pdfgui::jobs .form [file join /tmp pdfgui-selftest]} jobs msg]} {
            puts "SELFTEST-ERROR $msg"
            exit 1
        }
        foreach job $jobs {
            puts "JOB [lindex $job 0]"
            puts "CMD [lindex $job 1]"
        }
        file delete -force [file join /tmp pdfgui-selftest]
        exit 0
    }
}
