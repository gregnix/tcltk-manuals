# katalog-test.tcl -- prüft scripts/katalog.tsv, die Quellen der Indizes
# (Teil-Index), das Spiegeln der Bücher und das Aufnehmen (lang aus
# book.tcl, Zeilen bauen, anhängen).
#
#   tclsh scripts/tests/katalog-test.tcl ?BUECHERBAUM? ?QUELLE ...?
#
# Ohne Argumente: Katalog lesen und prüfen, Spiegeln an einem kleinen
# erzeugten Buchordner, Aufnehmen an erzeugten Buchordnern und einer
# Kopie des Katalogs. Mit BUECHERBAUM zusätzlich jedes Buch des
# Katalogs, dessen Quellordner dort liegt, und jede weitere QUELLE
# (relativ zum Bücherbaum, etwa book-tkutils/Tkutils-de; die Sprache kommt
# aus der Endung -de/-en): in eine Kopie von Books/ unter einem
# Arbeitsordner spiegeln, Ergebnis vergleichen, zweiter Lauf muss alles
# unverändert lassen. Die Sammlung selbst bleibt unberührt.
# Ende mit Status 0, wenn alles stimmt.

set here [file dirname [file normalize [info script]]]
set repo [file dirname [file dirname $here]]
source [file join $repo scripts katalog.tcl]

set fehler 0
proc ok {cond text} {
    if {[uplevel 1 [list expr $cond]]} {
        puts "ok    $text"
    } else {
        puts "FEHLER $text"
        incr ::fehler
    }
}

# Arbeitsordner
if {[info exists env(TMPDIR)] && $env(TMPDIR) ne ""} {
    set tmp [file join $env(TMPDIR) katalog-test-[pid]]
} else {
    set tmp [file join /tmp katalog-test-[pid]]
}
file delete -force $tmp
file mkdir $tmp

# --- Katalog -----------------------------------------------------------
set rows [::katalog::lesen [file join $repo scripts katalog.tsv]]
ok {[llength $rows] > 0} "katalog.tsv: [llength $rows] Einträge"
set namen {}
foreach row $rows {
    lassign $row name gruppe ordner teile tde ten art sprachen quelle
    lappend namen $name
    ok {$gruppe in {Tcl-family Extensions Books}} "$name: Gruppe $gruppe"
    switch -- $art {
        handbuch {
            set da 0
            foreach l [split $sprachen ,] {
                if {[file isdirectory [file join $repo $gruppe $l-markdown $ordner]]} { set da 1 }
            }
            ok $da "$name: Ordner $gruppe/LANG-markdown/$ordner"
            ok {$tde ne "" && $ten ne "" && $quelle ne ""} "$name: Titel und Quelle"
        }
        buch {
            ok {$quelle ne ""} "$name: Quelle $quelle"
            ok {[file isfile [file join $repo $gruppe $sprachen-markdown $ordner book.tcl]]} \
                "$name: $gruppe/$sprachen-markdown/$ordner/book.tcl"
        }
        index {
            ok {$tde ne "" && $ten ne ""} "$name: Titel"
            set hb [::katalog::indexQuellen $rows $name]
            ok {[llength $hb] > 0} "$name: [llength $hb] Handbücher ([join $hb ,])"
        }
    }
}
ok {[llength $namen] == [llength [lsort -unique $namen]]} "Namen eindeutig"

# Fehlerhafte Zeile wird gemeldet
set bad [file join $tmp bad.tsv]
set fh [open $bad w]; puts $fh "# x\nname\tart\nx\tbuch\tBooks"; close $fh
ok {[catch {::katalog::lesen $bad}]} "falsche Spaltenzahl wird gemeldet"

# --- Indizes: Spalte quelle ------------------------------------------------
ok {[::katalog::indexQuellen $rows nemethi-index] eq {tablelist mentry scrollutil wcb tsw}} \
    "nemethi-index: die fünf Pakete in Reihenfolge der quelle"
set alle {}
foreach row $rows {
    if {[lindex $row 1] eq "Tcl-family" && [lindex $row 6] eq "handbuch"} { lappend alle [lindex $row 0] }
}
ok {[::katalog::indexQuellen $rows tcl-family-index] eq $alle} \
    "tcl-family-index: quelle leer = alle Handbücher der Gruppe ([llength $alle])"
# kleiner Katalog mit wechselnder Index-Zeile
proc indexKatalog {quelle {gruppe Tcl-family}} {
    set k [file join $::tmp idx.tsv]
    set fh [open $k w]
    fconfigure $fh -encoding utf-8
    puts $fh "name\tart\tgruppe\tordner\tteile\tsprachen\tquelle\ttitel_de\ttitel_en"
    puts $fh "a\thandbuch\tTcl-family\ta\t*\tde,en\ta\tA\tA"
    puts $fh "b\thandbuch\tTcl-family\tb\t*\tde,en\tb\tB\tB"
    puts $fh "c\thandbuch\tTcl-family\tc\t*\tde,en\tc\tC\tC"
    puts $fh "x\thandbuch\tExtensions\t.\t*\tde,en\tx\tX\tX"
    puts $fh "alle\tindex\tTcl-family\t.\t*\tde,en\t-\tAlle\tAll"
    puts $fh "buch-de\tbuch\tBooks\tbuch-de\t*\tde\tbook/buch-de\t-\t-"
    puts $fh "teil\tindex\t$gruppe\t.\t*\tde,en\t$quelle\tTeil\tPart"
    close $fh
    return $k
}
set k [indexKatalog c,a]
ok {[::katalog::indexQuellen [::katalog::lesen $k] teil] eq {c a}} "Teil-Index c,a: gültig, Reihenfolge der quelle"
ok {[::katalog::indexQuellen [::katalog::lesen $k] alle] eq {a b c}} "Index mit quelle -: alle der Gruppe (ohne Extensions)"
set k [indexKatalog -]
ok {[::katalog::indexQuellen [::katalog::lesen $k] teil] eq {a b c}} "Teil-Index mit -: wie bisher alle"
set k [indexKatalog x Extensions]
ok {[::katalog::indexQuellen [::katalog::lesen $k] teil] eq {x}} "Index der Gruppe Extensions: x"
foreach {quelle gruppe muster text} {
    a,fehlt   Tcl-family {*„fehlt“ steht nicht im Katalog*}   "unbekannter Name"
    a,x       Tcl-family {*„x“ gehört zur Gruppe Extensions*} "Handbuch einer anderen Gruppe"
    a         Extensions {*„a“ gehört zur Gruppe Tcl-family*} "Index in anderer Gruppe als seine Quelle"
    a,buch-de Tcl-family {*„buch-de“ ist kein Handbuch*}      "Buch statt Handbuch"
    a,alle    Tcl-family {*„alle“ ist kein Handbuch*}         "Index statt Handbuch"
    a,b,a     Tcl-family {*„a“ doppelt*}                      "doppelt genannt"
    ,         Tcl-family {*keine Handbücher*}                 "nur Kommas"
} {
    set k [indexKatalog $quelle $gruppe]
    set r [catch {::katalog::lesen $k} err]
    ok {$r && [string match $muster $err] && [string match *idx.tsv:8:* $err]} "Index-quelle: $text gemeldet ($err)"
}

# --- Spiegeln, Vergleich ---------------------------------------------------
# Dateien relativ zu dir, ohne die ausgelassenen
proc dateien {dir {prefix ""}} {
    set out {}
    foreach f [::katalog::eintraege $dir] {
        set t [file tail $f]
        if {[::katalog::ausgelassen $t]} continue
        set rel [expr {$prefix eq "" ? $t : "$prefix/$t"}]
        if {[file isdirectory $f]} {
            lappend out {*}[dateien $f $rel]
        } else {
            lappend out $rel
        }
    }
    return [lsort $out]
}

proc mtimes {dir} {
    set out {}
    foreach rel [dateien $dir] {
        lappend out $rel [file mtime [file join $dir $rel]]
    }
    return $out
}

proc pruefeSpiegel {label src dest} {
    array set st {copy 0 same 0 del 0}
    ::katalog::spiegeln $src $dest st
    set q [dateien $src]
    set z [dateien $dest]
    ok {$q eq $z} "$label: gleiche Dateien ([llength $q]); kopiert $st(copy), unverändert $st(same), entfernt $st(del)"
    set gleich 1
    foreach rel $q {
        if {![::katalog::gleich [file join $src $rel] [file join $dest $rel]]} { set gleich 0 }
    }
    ok $gleich "$label: Inhalte gleich"
    set leer 1
    foreach f [::katalog::eintraege $dest] {
        if {[::katalog::ausgelassen [file tail $f]]} { set leer 0 }
    }
    ok $leer "$label: keine PDF, HTML, .gitignore, nogit im Ziel"
    set vorher [mtimes $dest]
    after 1100
    array set st2 {copy 0 same 0 del 0}
    ::katalog::spiegeln $src $dest st2
    ok {$st2(copy) == 0 && $st2(del) == 0 && $st2(same) == [llength $q]} \
        "$label: zweiter Lauf unverändert ($st2(same) gleich)"
    ok {[mtimes $dest] eq $vorher} "$label: Dateizeiten unverändert"
}

proc schreibe {path text} {
    file mkdir [file dirname $path]
    set fh [open $path w]; puts -nonewline $fh $text; close $fh
}

# erzeugter Buchordner
set src [file join $tmp quelle Buch-de]
schreibe [file join $src book.tcl] "set title Test\n"
schreibe [file join $src 010-a.md] "# A\n"
schreibe [file join $src bilder x.png] "png"
schreibe [file join $src Buch-de.pdf] "pdf"
schreibe [file join $src seite.html] "html"
schreibe [file join $src .gitignore] "*.pdf\n"
schreibe [file join $src nogit notiz.md] "privat"
schreibe [file join $src CONTRIBUTING.md] "intern"
schreibe [file join $src BUCHSTRUKTUR.md] "intern"
set dest [file join $tmp ziel Books de-markdown Buch-de]
schreibe [file join $dest 010-a.md] "# alt\n"
schreibe [file join $dest weg.md] "weg"
schreibe [file join $dest CONTRIBUTING.md] "alt"
schreibe [file join $dest altordner y.md] "weg"
pruefeSpiegel "erzeugtes Buch" $src $dest
ok {![file exists [file join $dest weg.md]] && ![file exists [file join $dest altordner]]} \
    "erzeugtes Buch: fehlende Dateien entfernt"
ok {![file exists [file join $dest CONTRIBUTING.md]] && ![file exists [file join $dest BUCHSTRUKTUR.md]]} \
    "erzeugtes Buch: CONTRIBUTING.md und BUCHSTRUKTUR.md nicht im Ziel"

# --- Buch aufnehmen: lang lesen, Zeilen bauen, anhängen --------------------
proc lies {path} {
    set fh [open $path rb]; set d [read $fh]; close $fh
    return $d
}
set bt [file join $tmp aufnehmen]
schreibe [file join $bt book-a A-de book.tcl] "# Kommentar\nset title \"A\"\nset lang      \"de\"\nset chapters {a.md}\n"
schreibe [file join $bt book-a A-en book.tcl] "set lang en\n"
schreibe [file join $bt book-a notizen x.md] "kein Buch"
schreibe [file join $bt book-b Ohne book.tcl] "set title B\n"
schreibe [file join $bt book-c C-de book.tcl] "set lang \[exec touch [file join $tmp boese]\]\n"
schreibe [file join $bt book-c D-de book.tcl] "proc x {} {}\nset lang de\n"
schreibe [file join $bt leer x.md] "x"
ok {[::katalog::buchSprache [file join $bt book-a A-de book.tcl]] eq "de"} "buchSprache: de aus book.tcl"
ok {[::katalog::buchSprache [file join $bt book-a A-en book.tcl]] eq "en"} "buchSprache: en"
ok {[::katalog::buchSprache [file join $bt book-b Ohne book.tcl]] eq ""} "buchSprache: ohne lang leer"
ok {[catch {::katalog::buchSprache [file join $bt book-c C-de book.tcl]}] && ![file exists [file join $tmp boese]]} \
    "buchSprache: Befehle außer set laufen nicht (exec)"
ok {[catch {::katalog::buchSprache [file join $bt book-c D-de book.tcl]}]} "buchSprache: proc wird abgewiesen"
ok {[catch {::katalog::buchSprache [file join $bt fehlt book.tcl]}]} "buchSprache: fehlendes book.tcl gemeldet"
set aus [::katalog::ausgaben [file join $bt book-a]]
ok {[lmap a $aus {file tail $a}] eq {A-de A-en}} "ausgaben: Buchordner -> A-de A-en"
ok {[lmap a [::katalog::ausgaben [file join $bt book-a A-en]] {file tail $a}] eq {A-en}} "ausgaben: Ausgabeordner selbst"
ok {[catch {::katalog::ausgaben [file join $bt leer]}]} "ausgaben: ohne book.tcl gemeldet"
ok {[::katalog::relativ [file join $bt book-a A-de] $bt] eq "book-a/A-de"} "relativ: book-a/A-de"
ok {[catch {::katalog::relativ $tmp $bt}] && [catch {::katalog::relativ $bt $bt}]} "relativ: außerhalb gemeldet"
ok {[::katalog::buchZeile A-de de book-a/A-de] eq {A-de buch Books A-de * de book-a/A-de - -}} "buchZeile"
foreach {n l q text} {
    "Mit Leer" de x/y "Name mit Leerzeichen"
    "Mit\tTab" de x/y "Name mit Tab"
    a/b de x/y "Name mit Schrägstrich"
    "#x" de x/y "Name mit #"
    "" de x/y "leerer Name"
    A-de fr x/y "Sprache unbekannt"
    A-de de "" "leere Quelle"
} {
    ok {[catch {::katalog::buchZeile $n $l $q}]} "buchZeile: $text gemeldet"
}
set k [file join $tmp katalog.tsv]
file copy [file join $repo scripts katalog.tsv] $k
set alt [lies $k]
set altRows [::katalog::lesen $k]
set z1 [::katalog::buchZeile A-de de book-a/A-de]
set z2 [::katalog::buchZeile A-en en book-a/A-en]
set ab [::katalog::abgleich $altRows [list $z1 $z2]]
ok {[dict get $ab neu] eq [list $z1 $z2] && [dict get $ab schon] eq ""} "abgleich: beide neu"
ok {[::katalog::anhaengen $k [dict get $ab neu]] == 2} "anhaengen: 2 Zeilen"
set neuText [lies $k]
set neuRows [::katalog::lesen $k]
ok {[llength $neuRows] == [llength $altRows] + 2} "anhaengen: Katalog lesbar, 2 Einträge mehr"
# Position: direkt hinter der letzten buch-Zeile, Rest unverändert
set altL [split $alt \n]
set letzte -1; set i 0
foreach l $altL { if {[lindex [split $l \t] 1] eq "buch"} { set letzte $i }; incr i }
set erwartet [join [linsert $altL [expr {$letzte + 1}] [join $z1 \t] [join $z2 \t]] \n]
ok {$neuText eq $erwartet} "anhaengen: hinter der letzten buch-Zeile, sonst unverändert"
ok {[string first "A-de\tbuch\tBooks\tA-de\t*\tde\tbook-a/A-de\t-\t-\n" $neuText] >= 0} "anhaengen: Tabulatoren, \"-\" für leer"
set ab [::katalog::abgleich $neuRows [list $z1 [::katalog::buchZeile X-de de book-a/A-de]]]
ok {[dict get $ab schon] eq "A-de"} "abgleich: gleicher Name schon da"
ok {[llength [dict get $ab neu]] == 1 && [lindex [dict get $ab warnungen] 0] eq {X-de A-de book-a/A-de}} \
    "abgleich: gleiche Quelle unter anderem Namen -> Warnung"
ok {[catch {::katalog::abgleich $neuRows [list $z1 $z1]}]} "abgleich: doppelter Name in der Auswahl gemeldet"
# CRLF bleibt CRLF, Datei ohne buch-Zeile: ans Ende
set kc [file join $tmp crlf.tsv]
set fh [open $kc wb]; puts -nonewline $fh "# k\r\nname\tart\tgruppe\tordner\tteile\tsprachen\tquelle\ttitel_de\ttitel_en\r\nx\thandbuch\tTcl-family\tx\t*\tde\tx\tX\tX\r\n# Ende\r\n"; close $fh
::katalog::anhaengen $kc [list $z1]
set t [lies $kc]
ok {[regexp {\nx\t[^\n]*\r\nA-de\t[^\n]*\r\n# Ende\r\n$} $t] && ![regexp {[^\r]\n} $t]} "anhaengen: CRLF bleibt, hinter letzter Datenzeile"
# nicht schreibbar: nichts geschrieben
if {$tcl_platform(platform) eq "unix" && [exec id -u] != 0} {
    set ro [file join $tmp ro.tsv]
    file copy [file join $repo scripts katalog.tsv] $ro
    file attributes $ro -permissions 0444
    ok {[catch {::katalog::anhaengen $ro [list $z1]}] && [lies $ro] eq $alt} "anhaengen: nicht schreibbar gemeldet, Datei unverändert"
} else {
    puts "--    nicht-schreibbar-Test übersprungen (root oder nicht Unix)"
}
# kaputte Zeile: nichts geschrieben
set vorher [lies $k]
ok {[catch {::katalog::anhaengen $k [list {A b c}]}] && [lies $k] eq $vorher} "anhaengen: falsche Zeile gemeldet, Datei unverändert"
ok {[glob -nocomplain -directory $tmp *.neu-*] eq ""} "anhaengen: keine Zwischendatei liegen geblieben"

# --- Bücherbaum ----------------------------------------------------------
set baum [lindex $argv 0]
if {$baum ne ""} {
    set baum [file normalize $baum]
    set paare {}
    foreach row $rows {
        lassign $row name gruppe ordner teile tde ten art sprachen quelle
        if {$art ne "buch"} continue
        if {![file isdirectory [file join $baum $quelle]]} {
            puts "--    $name: $quelle fehlt im Bücherbaum, übersprungen"
            continue
        }
        lappend paare $name $quelle $gruppe/$sprachen-markdown/$ordner
    }
    foreach quelle [lrange $argv 1 end] {
        set tail [file tail $quelle]
        if {![regexp -- {-(de|en)$} $tail -> lang]} {
            ok 0 "$quelle: Sprache (-de/-en) nicht erkennbar"
            continue
        }
        lappend paare $tail $quelle Books/$lang-markdown/$tail
    }
    foreach {name quelle ziel} $paare {
        set s [file join $baum $quelle]
        ok {[file isdirectory $s]} "$name: Quelle $s"
        if {![file isdirectory $s]} continue
        set d [file join $tmp sammlung $ziel]
        # Ausgangslage: der Stand der Sammlung, falls vorhanden
        set alt [file join $repo $ziel]
        if {[file isdirectory $alt]} {
            file mkdir [file dirname $d]
            file copy $alt $d
        }
        pruefeSpiegel $name $s $d
        ok {[file isfile [file join $d book.tcl]]} "$name: book.tcl vorhanden (zum Bauen nötig)"
    }
}

file delete -force $tmp
puts [expr {$fehler ? "$fehler Fehler" : "alles ok"}]
exit [expr {$fehler ? 1 : 0}]
