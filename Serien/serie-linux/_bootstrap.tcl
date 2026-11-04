# ERZEUGT von werkzeug/stanze.tcl -- NICHT HIER AENDERN.
#
# Die Quelle ist _kern/kern.tcl. Wer diese Datei ändert, verliert die
# Änderung beim nächsten Stanzen, und "stanze.tcl --pruefen" meldet sie
# vorher als Abweichung.
#
# Was zu DIESER Serie gehört, steht in _serie.tcl daneben.

# kern.tcl -- die geteilte Infrastruktur der Lernserien.
#
# DIES IST DIE QUELLE. Sie wird nicht von den Serien geladen, sondern von
# werkzeug/stanze.tcl in jede Serie HINEINGESCHRIEBEN. Damit bleibt jede
# Serie autark (kein "source" nach oben) und es gibt trotzdem eine
# Stelle, an der ein Fehler behoben wird.
#
# Wer hier etwas ändert, ruft danach:
#     tclsh werkzeug/stanze.tcl --alle
# und prüft mit:
#     tclsh werkzeug/stanze.tcl --pruefen

namespace eval ::serie {
    variable root ""
    variable outDir ""
    variable auto 0
    variable titel ""
    variable shellGeo ""
    variable statusDefault ""
}

# --------------------------------------------------------------------
# Wo wir sind
# --------------------------------------------------------------------

proc ::serie::setzeRoot {skript} {
    variable root
    variable outDir
    variable auto
    set root [file dirname [file normalize $skript]]
    # Vom Kapitel aus ist die Serie eine Ebene höher.
    if {[file tail $root] eq "howto"} { set root [file dirname $root] }
    set outDir [file join $root out]
    file mkdir $outDir
    set auto [expr {[info exists ::env(SERIES_AUTO)]
                    && $::env(SERIES_AUTO) ne ""
                    && $::env(SERIES_AUTO) != 0}]
}

proc ::serie::out {name} {
    variable outDir
    file mkdir $outDir
    return [file join $outDir $name]
}

# Workspace-Wurzel: nach oben, bis $marker existiert (Pfadteile).
proc ::serie::findeWorkspace {marker} {
    variable root
    set d [file normalize $root]
    for {set i 0} {$i < 12} {incr i} {
        if {[file exists [file join $d {*}$marker]]} {
            return $d
        }
        set p [file dirname $d]
        if {$p eq $d} break
        set d $p
    }
    return [file normalize [file join $root .. .. ..]]
}

# Fremdpaketquellen: bibliosrc/<name> unter der Workspace-Wurzel.
# Fehlt das Verzeichnis, ist das kein Abbruch -- die Serie bleibt autark:
# der Aufrufer überspringt.
proc ::serie::bibliosrc {name} {
    set ws [::serie::findeWorkspace [list bibliosrc $name]]
    return [file join $ws bibliosrc $name]
}

# Optional scrollutil aus bibliosrc/serie-tablelist (vier Widget-Serien).
proc ::serie::maybeScrollutil {} {
    set cand [::serie::bibliosrc serie-tablelist]
    if {[file isdirectory $cand]} {
        foreach d [glob -nocomplain -types d [file join $cand scrollutil*]] {
            if {[file exists [file join $d pkgIndex.tcl]]} {
                set ::auto_path [linsert $::auto_path 0 $d]
            }
        }
    }
    if {![catch {package require scrollutil_tile} ver]} {
        return $ver
    }
    return ""
}

# --------------------------------------------------------------------
# Prüfen
# --------------------------------------------------------------------

# Eine Prüfung, die fehlschlägt, beendet mit 1 und sagt, was gemeint war.
proc ::serie::assert {ausdruck {was ""}} {
    if {[uplevel 1 [list expr $ausdruck]]} { return }
    if {$was eq ""} { set was $ausdruck }
    puts stderr "FAIL: $was"
    exit 1
}

proc ::serie::line {text} { puts $text }

# --------------------------------------------------------------------
# Voraussetzungen: überspringen, nicht scheitern
# --------------------------------------------------------------------

# Eine fehlende Voraussetzung ist KEIN Fehlschlag. Wer sie als einen
# meldet, hat eine Liste, in der Einträge nichts bedeuten -- und sieht
# dann auch bei den echten nicht mehr genau hin.
proc ::serie::skip {grund} {
    puts "SKIP: $grund"
    exit 0
}

proc ::serie::brauchtPaket {args} {
    foreach p $args {
        if {[catch {package require $p}]} { ::serie::skip "Paket $p fehlt" }
    }
}

# OHNE FENSTERMANAGER GIBT NIEMAND DEM HAUPTFENSTER DEN FOKUS.
#
# Ein "focus .e1" greift dann nicht: [focus] bleibt leer, und
# tk_focusNext bricht ab mit 'bad window path name ""'.
#
# Das ist KEIN Grund zu überspringen -- ein "focus -force ." davor
# behebt es. Unter Xvfb gehen focus und tk_focusNext, sobald das
# Hauptfenster den Fokus hat; ein Fenstermanager ist dafür nicht nötig.
proc ::serie::fokusVorbereiten {} {
    if {[catch {package present Tk}]} { return }
    focus -force .
    update
}

# Nur wenn etwas WIRKLICH einen Fenstermanager braucht -- Iconify,
# Rahmenmasse. Nicht für Fokus, nicht für wm geometry (ohne WM gilt
# die gesetzte Geometrie exakt).
#
# Die alte Prüfung ([winfo manager .] eq "" && [wm state .] ne "normal")
# griff nie: [winfo manager .] ist für Toplevels immer "wm", der Zustand
# ohne WM "normal".
#
# X11, gemessen unter Xvfb, Tk 8.6.14 und 9.0.4:
#   kein WM              wm frame == winfo id   iconify bleibt "normal"
#                                               (Tk wartet ~2 s darauf)
#   openbox (reparent.)  wm frame != winfo id   iconify -> "iconic"
#   WM ohne Reparenting  wm frame == winfo id   iconify -> "iconic"
# Ids NUMERISCH vergleichen: 8.6 liefert winfo id als 0x00200003,
# wm frame als 0x200003 -- mit "eq" wären sie immer verschieden.
#
# Windows/macOS: es gibt immer einen WM; kein Skip (dort nicht geprüft).
# SERIE_WM=0|1 erzwingt das Ergebnis (CI ohne Probe).

# 1, wenn ein WM das Fenster in einen Rahmen gehängt hat. Schnell.
proc ::serie::wmRahmen {} {
    variable wmRahmen
    if {[info exists wmRahmen]} { return $wmRahmen }
    if {[info exists ::env(SERIE_WM)] && $::env(SERIE_WM) ne ""} {
        return [set wmRahmen [string is true -strict $::env(SERIE_WM)]]
    }
    if {[tk windowingsystem] ne "x11"} { return [set wmRahmen 1] }
    update
    set w .
    if {![winfo ismapped .]} {
        # "." zurückgezogen: eigenes Probefenster.
        set w .__serieWmProbe
        toplevel $w -width 40 -height 20
        wm geometry $w +0+0
        update
    }
    # Mit WM wird erst nach MapRequest gemappt -- und vorher reparentiert.
    for {set i 0} {$i < 40 && ![winfo ismapped $w]} {incr i} {
        after 25
        update
    }
    set wmRahmen [expr {[wm frame $w] != [winfo id $w]}]
    if {$w ne "."} { destroy $w; update }
    return $wmRahmen
}

# 1, wenn überhaupt ein WM läuft (auch einer ohne Rahmen: dwm, xmonad …).
proc ::serie::wmDa {} {
    variable wmDa
    if {[info exists wmDa]} { return $wmDa }
    if {[info exists ::env(SERIE_WM)] && $::env(SERIE_WM) ne ""} {
        return [set wmDa [string is true -strict $::env(SERIE_WM)]]
    }
    if {[::serie::wmRahmen]} { return [set wmDa 1] }
    # Kein Rahmen: Iconify an einem Probefenster entscheidet.
    set w .__serieWmProbe
    toplevel $w -width 40 -height 20
    wm geometry $w +0+0
    update
    set wmDa [expr {![catch {wm iconify $w}] && [wm state $w] eq "iconic"}]
    destroy $w
    update
    return $wmDa
}

proc ::serie::brauchtWM {} {
    if {[catch {package present Tk}]} { ::serie::skip "Tk fehlt" }
    if {![::serie::wmDa]} { ::serie::skip "kein Fenstermanager" }
    ::serie::fokusVorbereiten
}

# Für Rahmenmessungen (wm frame, rooty minus geometry-y).
proc ::serie::brauchtRahmen {} {
    if {[catch {package present Tk}]} { ::serie::skip "Tk fehlt" }
    if {![::serie::wmRahmen]} {
        ::serie::skip "kein Fensterrahmen (kein oder nicht reparentierender WM)"
    }
    ::serie::fokusVorbereiten
}

# Identify-Namen (padding, label, trough, Button.border) gelten unter
# dem ttk-Theme **default** (Linux-Default). Windows-Tk nimmt
# vista/xpnative; dieselben Pixel treffen andere Elemente. Howtos, die
# Namen fest verdrahten, rufen das VOR dem Erzeugen auf.
# Unter vista (Windows) und clam (Linux) treffen dieselben Pixel andere
# Elemente; unter default laufen die Howtos durch.
proc ::serie::themeDefault {} {
    if {[catch {package present Tk}]} { return 0 }
    if {"default" ni [ttk::style theme names]} {
        ::serie::skip "Theme default fehlt"
    }
    ttk::style theme use default
    return 1
}

# --------------------------------------------------------------------
# Der Rahmen einer Demo
# --------------------------------------------------------------------

proc ::serie::shell {name aufbau {pruefung {}}} {
    variable auto
    variable titel
    variable shellGeo
    variable statusDefault
    # Der Parameter heisst NICHT wie die Namensraumvariable -- "variable
    # titel" nach einem gleichnamigen Argument ist ein Fehler
    # ("variable already exists"), und er faellt erst beim ersten Aufruf
    # auf, nicht beim Laden.
    set titel $name
    if {![catch {package present Tk}]} {
        package require Ttk
        wm title . $name
        if {$shellGeo ne ""} {
            wm geometry . $shellGeo
        } else {
            wm geometry . 720x420
        }
        if {![winfo exists .f]} {
            ttk::frame .f -padding 8
            pack .f -fill both -expand 1
        }
        uplevel 1 $aufbau
        if {![winfo exists .f.status]} {
            ttk::label .f.status -textvariable ::serie::status -anchor w
            ttk::button .f.quit -text Quit -command exit
            pack .f.status -side bottom -fill x -pady {8 0}
            pack .f.quit -side bottom -anchor e
        }
        if {![info exists ::serie::status] || $::serie::status eq ""} {
            if {$statusDefault ne ""} {
                set ::serie::status $statusDefault
            } else {
                set ::serie::status "Tk $::tk_patchLevel"
            }
        }
    } else {
        uplevel 1 $aufbau
    }
    if {!$auto} { return }
    update
    ::serie::fokusVorbereiten
    if {$pruefung ne ""} { uplevel 1 $pruefung }
    puts "OK: $name"
    exit 0
}

# Für Kapitel ohne Fenster.
proc ::serie::measure {titel ausgabe {pruefung {}}} {
    uplevel 1 $ausgabe
    if {$pruefung ne ""} { uplevel 1 $pruefung }
    puts "OK: $titel"
}

# Kapitel ohne Fenster, die danach enden.
proc ::serie::done {titel} {
    puts "OK: $titel  (Tcl [info patchlevel])"
    exit 0
}

# --------------------------------------------------------------------
# Der Interpreter, der zu diesem gehört
# --------------------------------------------------------------------

# Erste Wahl ist der Nachbar des laufenden Interpreters. Der PATH wird
# BEFRAGT, nicht geglaubt: ein "wish" darauf kann eine andere Fassung
# sein, und dann mißt man die falsche, ohne es zu erfahren.
#
# Beispiel mit PATH=/usr/bin unter Tcl 9.0.4:
#     uebergangen: /usr/bin/wish ist 8.6.14, gebraucht 9.0.4
#
# Leer ist besser als falsch.
proc ::serie::waehleWish {} {
    set selbst [info nameofexecutable]
    if {$selbst ne ""} {
        set k [file join [file dirname $selbst] \
                [string map {tclsh wish} [file tail $selbst]]]
        if {[file executable $k]} { return $k }
    }
    set soll [info patchlevel]
    foreach name [list wish[info tclversion] wish] {
        set p [auto_execok $name]
        if {$p eq ""} continue
        set p [lindex $p 0]
        if {[catch {exec $p << {puts [info patchlevel]; exit 0}} ist]} continue
        if {$ist eq $soll} { return $p }
        puts stderr "uebergangen: $p ist $ist, gebraucht $soll"
    }
    return ""
}


# --- Eigenes dieser Serie ------------------------------------------
::serie::setzeRoot [info script]
set _eigen [file join [file dirname [file normalize [info script]]] _serie.tcl]
if {[file readable $_eigen]} { source $_eigen }
unset _eigen
