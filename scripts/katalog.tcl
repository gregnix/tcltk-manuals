# katalog.tcl -- scripts/katalog.tsv lesen und Bücher spiegeln.
#
# Ohne Tk, damit auch Tests mit tclsh es laden können. pdfgui.tcl
# lädt es mit source; build-pdfs.sh liest katalog.tsv selbst.
#
#   ::katalog::lesen PFAD
#       Liste der Einträge, je {name gruppe ordner teile titelDe titelEn
#       art sprachen quelle}; "-" in der Datei wird zu "".
#       Prüft bei art=index die Spalte quelle (siehe indexQuellen).
#   ::katalog::indexQuellen ROWS NAME
#       Die Handbücher, deren .index.tsv der Index NAME zusammenfasst:
#       die Namen aus seiner Spalte quelle (komma-getrennt, in dieser
#       Reihenfolge), bei leerer quelle alle Handbücher seiner Gruppe in
#       der Reihenfolge des Katalogs. Jeder genannte Name muss ein
#       Handbuch derselben Gruppe sein, sonst Fehler.
#   ::katalog::spiegeln QUELLE ZIEL STATSVAR
#       Buchordner QUELLE nach ZIEL spiegeln, ohne *.pdf, *.html,
#       .gitignore, nogit/, CONTRIBUTING.md und BUCHSTRUKTUR.md. Im Ziel fehlende oder geänderte Dateien
#       werden kopiert, gleiche bleiben unberührt, Dateien ohne
#       Gegenstück in der Quelle werden entfernt. Zählt in STATSVAR
#       (Array) copy, same, del.
#
# Ein Buch aufnehmen (pdfgui, Knopf „Buch aufnehmen…“):
#   ::katalog::buchSprache BOOKTCL
#       Wert von „set lang“ aus book.tcl; "" wenn nicht gesetzt. Gelesen
#       in einer sicheren Interp, in der nur „set“ bleibt.
#   ::katalog::ausgaben ORDNER
#       Ausgabeordner: ORDNER selbst, wenn er book.tcl hat, sonst seine
#       Unterordner mit book.tcl (sortiert). Keiner: Fehler.
#   ::katalog::relativ PFAD WURZEL
#       PFAD relativ zu WURZEL, mit "/"; liegt er nicht darunter: Fehler.
#   ::katalog::nameOk NAME
#       1, wenn NAME als Eintrag taugt (kein Leerzeichen, Tab, "/", "\\",
#       kein # oder - am Anfang).
#   ::katalog::buchZeile NAME SPRACHE QUELLE
#       Katalogzeile (Liste der Spalten) für ein Buch; prüft Name,
#       Sprache und Quelle.
#   ::katalog::abgleich ROWS ZEILEN
#       ZEILEN (von buchZeile) gegen ROWS (von lesen): dict mit neu (die
#       einzutragenden Zeilen), schon (Namen, die es gibt) und warnungen
#       ({neuerName alterName quelle}: gleiche Quelle, anderer Name).
#   ::katalog::anhaengen PFAD ZEILEN
#       ZEILEN hinter die letzte buch-Zeile von PFAD schreiben (sonst ans
#       Ende), Tabulatoren, UTF-8, Zeilenende wie die Datei. Prüft vorher
#       Schreibrecht und das Ergebnis (lesen), schreibt erst dann; die
#       Datei wird in einem Schritt ersetzt.

namespace eval ::katalog {
    variable spalten {name art gruppe ordner teile sprachen quelle titel_de titel_en}
}

proc ::katalog::lesen {path} {
    variable spalten
    set fh [open $path r]
    fconfigure $fh -encoding utf-8
    set text [read $fh]
    close $fh
    set rows {}
    set nr 0
    set kopf 1
    set indexZeilen {}
    foreach line [split $text \n] {
        incr nr
        set line [string trimright $line \r]
        if {[string trim $line] eq "" || [string index $line 0] eq "#"} continue
        set f [split $line \t]
        if {$kopf && [lindex $f 0] eq "name"} {
            set kopf 0
            continue
        }
        set kopf 0
        if {[llength $f] != [llength $spalten]} {
            return -code error "$path:$nr: [llength $spalten] Spalten erwartet, [llength $f] gefunden"
        }
        set f [lmap v $f {expr {$v eq "-" ? "" : $v}}]
        lassign $f name art gruppe ordner teile sprachen quelle tde ten
        if {$art ni {handbuch index buch}} {
            return -code error "$path:$nr: art „$art“ unbekannt"
        }
        foreach l [split $sprachen ,] {
            if {$l ni {de en}} {
                return -code error "$path:$nr: Sprache „$l“ unbekannt"
            }
        }
        if {$art eq "buch" && [llength [split $sprachen ,]] != 1} {
            return -code error "$path:$nr: ein Buch hat genau eine Sprache"
        }
        if {$art eq "index"} { lappend indexZeilen $name $nr }
        lappend rows [list $name $gruppe $ordner $teile $tde $ten $art $sprachen $quelle]
    }
    foreach {name nr} $indexZeilen {
        if {[catch {indexQuellen $rows $name} err]} {
            return -code error "$path:$nr: $err"
        }
    }
    return $rows
}

proc ::katalog::indexQuellen {rows iname} {
    set irow {}
    foreach row $rows {
        if {[lindex $row 0] eq $iname && [lindex $row 6] eq "index"} {
            set irow $row
            break
        }
    }
    if {$irow eq ""} {
        return -code error "kein Index „$iname“ im Katalog"
    }
    set igruppe [lindex $irow 1]
    set quelle [lindex $irow 8]
    set out {}
    if {$quelle eq ""} {
        foreach row $rows {
            if {[lindex $row 1] eq $igruppe && [lindex $row 6] eq "handbuch"} {
                lappend out [lindex $row 0]
            }
        }
        return $out
    }
    foreach n [split $quelle ,] {
        set n [string trim $n]
        if {$n eq ""} continue
        set gefunden {}
        foreach row $rows {
            if {[lindex $row 0] eq $n} { set gefunden $row; break }
        }
        if {$gefunden eq ""} {
            return -code error "Index $iname: „$n“ steht nicht im Katalog"
        }
        if {[lindex $gefunden 6] ne "handbuch"} {
            return -code error "Index $iname: „$n“ ist kein Handbuch (art [lindex $gefunden 6])"
        }
        if {[lindex $gefunden 1] ne $igruppe} {
            return -code error "Index $iname: „$n“ gehört zur Gruppe [lindex $gefunden 1], nicht $igruppe"
        }
        if {$n in $out} {
            return -code error "Index $iname: „$n“ doppelt genannt"
        }
        lappend out $n
    }
    if {![llength $out]} {
        return -code error "Index $iname: keine Handbücher in quelle"
    }
    return $out
}

# Bleibt beim Spiegeln draußen: gebaute Dateien und Arbeitsdateien
# (Anleitungen fürs Schreiben am Buch gehören nicht in die Sammlung).
proc ::katalog::ausgelassen {name} {
    if {$name in {.gitignore nogit CONTRIBUTING.md BUCHSTRUKTUR.md}} { return 1 }
    return [expr {[string tolower [file extension $name]] in {.pdf .html}}]
}

proc ::katalog::eintraege {dir} {
    set out {}
    foreach f [concat [glob -nocomplain -directory $dir *] \
                      [glob -nocomplain -directory $dir -types hidden *]] {
        if {[file tail $f] in {. ..}} continue
        lappend out $f
    }
    return [lsort -unique $out]
}

proc ::katalog::gleich {a b} {
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

# Datei kopieren, wenn sie im Ziel fehlt oder anders ist.
proc ::katalog::kopieren {src dest statsName} {
    upvar 1 $statsName st
    file mkdir [file dirname $dest]
    if {[gleich $src $dest]} {
        incr st(same)
        return
    }
    file copy -force $src $dest
    catch {file mtime $dest [file mtime $src]}
    incr st(copy)
}

proc ::katalog::dateienIn {path} {
    if {![file isdirectory $path] || [file type $path] eq "link"} { return 1 }
    set n 0
    foreach f [eintraege $path] { incr n [dateienIn $f] }
    return $n
}

proc ::katalog::entfernen {path statsName} {
    upvar 1 $statsName st
    incr st(del) [dateienIn $path]
    file delete -force $path
}

proc ::katalog::spiegeln {src dest statsName} {
    upvar 1 $statsName st
    foreach k {copy same del} {
        if {![info exists st($k)]} { set st($k) 0 }
    }
    if {[file exists $dest] && ![file isdirectory $dest]} {
        entfernen $dest st
    }
    file mkdir $dest
    set behalten {}
    foreach f [eintraege $src] {
        set tail [file tail $f]
        if {[ausgelassen $tail]} continue
        lappend behalten $tail
        set to [file join $dest $tail]
        if {[file isdirectory $f]} {
            spiegeln $f $to st
        } else {
            if {[file isdirectory $to]} { entfernen $to st }
            kopieren $f $to st
        }
    }
    foreach f [eintraege $dest] {
        if {[file tail $f] ni $behalten} { entfernen $f st }
    }
}

# --- Ein Buch aufnehmen ------------------------------------------------

proc ::katalog::buchSprache {booktcl} {
    if {![file isfile $booktcl]} {
        return -code error "kein book.tcl: $booktcl"
    }
    set fh [open $booktcl r]
    fconfigure $fh -encoding utf-8
    set script [read $fh]
    close $fh
    # book.tcl ist Daten, kein Programm: nur „set“ bleibt übrig.
    set ip [interp create -safe]
    set cmds [interp eval $ip {info commands}]
    interp eval $ip {
        foreach ns [namespace children ::] { catch {namespace delete $ns} }
    }
    foreach a [interp aliases $ip] { catch {interp alias $ip $a {}} }
    foreach c $cmds {
        if {$c ne "set"} { catch {interp hide $ip $c} }
    }
    if {[catch {interp eval $ip $script} err]} {
        interp delete $ip
        return -code error "$booktcl: $err"
    }
    set lang ""
    catch {set lang [interp eval $ip {set lang}]}
    interp delete $ip
    return [string trim $lang]
}

proc ::katalog::ausgaben {dir} {
    if {![file isdirectory $dir]} {
        return -code error "kein Ordner: $dir"
    }
    if {[file isfile [file join $dir book.tcl]]} {
        return [list $dir]
    }
    set out {}
    foreach d [lsort [glob -nocomplain -directory $dir -types d *]] {
        if {[file isfile [file join $d book.tcl]]} { lappend out $d }
    }
    if {![llength $out]} {
        return -code error "kein book.tcl in $dir oder seinen Unterordnern"
    }
    return $out
}

proc ::katalog::relativ {path root} {
    set p [file split [file normalize $path]]
    set r [file split [file normalize $root]]
    set n [llength $r]
    if {[llength $p] <= $n || [lrange $p 0 $n-1] ne $r} {
        return -code error "$path liegt nicht unter $root"
    }
    return [join [lrange $p $n end] /]
}

# Name eines Eintrags: nicht leer, ohne Leerzeichen, Tab, Schrägstrich,
# nicht mit # oder - am Anfang (Kommentar, „nichts“), nicht „name“ (Kopf).
proc ::katalog::nameOk {name} {
    return [expr {$name ne "" && ![regexp {[\s/\\]} $name]
        && [string index $name 0] ni {# -} && $name ne "name"}]
}

proc ::katalog::buchZeile {name lang quelle} {
    if {![nameOk $name]} {
        return -code error "Name „$name“ geht nicht (leer, Leerzeichen, Tab, Schrägstrich oder # / - am Anfang)"
    }
    if {$lang ni {de en}} {
        return -code error "$name: Sprache „$lang“ unbekannt (de oder en)"
    }
    if {$quelle eq "" || [regexp {[\t\n\r]} $quelle]} {
        return -code error "$name: Quelle „$quelle“ geht nicht"
    }
    return [list $name buch Books $name * $lang $quelle - -]
}

proc ::katalog::abgleich {rows zeilen} {
    set neu {}
    set schon {}
    set warn {}
    set namen {}
    foreach z $zeilen {
        lassign $z name - - - - - quelle
        if {$name in $namen} {
            return -code error "Name „$name“ doppelt in der Auswahl"
        }
        lappend namen $name
        set da 0
        foreach row $rows {
            lassign $row rname - - - - - - - rquelle
            if {$rname eq $name} {
                set da 1
            } elseif {$rquelle ne "" && $rquelle eq $quelle} {
                lappend warn [list $name $rname $quelle]
            }
        }
        if {$da} {
            lappend schon $name
        } else {
            lappend neu $z
        }
    }
    return [dict create neu $neu schon $schon warnungen $warn]
}

proc ::katalog::anhaengen {path zeilen} {
    if {![file isfile $path]} {
        return -code error "Katalog fehlt: $path"
    }
    if {![file writable $path] || ![file writable [file dirname $path]]} {
        return -code error "Katalog nicht schreibbar: $path"
    }
    set fh [open $path r]
    fconfigure $fh -encoding utf-8 -translation binary
    set text [read $fh]
    close $fh
    set nl [expr {[string first \r\n $text] >= 0 ? "\r\n" : "\n"}]
    set lines [split $text \n]
    set schluss [expr {[lindex $lines end] eq ""}]
    if {$schluss} { set lines [lrange $lines 0 end-1] }
    # hinter die letzte buch-Zeile, sonst hinter die letzte Datenzeile
    set nach -1
    set letzte -1
    set i 0
    foreach line $lines {
        set l [string trimright $line \r]
        if {[string trim $l] ne "" && [string index $l 0] ne "#"} {
            set letzte $i
            if {[lindex [split $l \t] 1] eq "buch"} { set nach $i }
        }
        incr i
    }
    if {$nach < 0} { set nach $letzte }
    if {$nach < 0} { set nach [expr {[llength $lines] - 1}] }
    set cr [expr {$nl eq "\r\n" ? "\r" : ""}]
    set neu {}
    foreach z $zeilen {
        if {[llength $z] != 9} {
            return -code error "Zeile mit [llength $z] statt 9 Spalten: $z"
        }
        lappend neu "[join $z \t]$cr"
    }
    set lines [linsert $lines [expr {$nach + 1}] {*}$neu]
    set out [join $lines \n]
    if {$schluss} { append out \n }
    # erst prüfen, dann in einem Schritt ersetzen
    set tmp $path.neu-[pid]
    if {[catch {
        set fh [open $tmp w]
        fconfigure $fh -encoding utf-8 -translation binary
        puts -nonewline $fh $out
        close $fh
        lesen $tmp
    } err]} {
        catch {close $fh}
        catch {file delete $tmp}
        return -code error "Katalog nicht geschrieben: $err"
    }
    catch {file attributes $tmp -permissions [file attributes $path -permissions]}
    if {[catch {file rename -force $tmp $path} err]} {
        catch {file delete $tmp}
        return -code error "Katalog nicht geschrieben: $err"
    }
    return [llength $neu]
}
