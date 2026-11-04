# xdg-ordner.tcl -- Konfigurations-, Daten- und Cache-Ordner nach XDG
#
# Läuft unter Tcl 8.6 und 9. Legt nichts an, druckt nur.
#
#   tclsh8.6 xdg-ordner.tcl meineapp
#   tclsh9.0 xdg-ordner.tcl meineapp
#
# Kapitel "Pfade, Umgebung, XDG".

# Heimatordner ohne Tilde: $env(HOME) gilt unter 8.6 und 9.
# [file home] gibt es erst ab Tcl 9.
proc heim {} {
    if {[info exists ::env(HOME)] && $::env(HOME) ne ""} {
        return $::env(HOME)
    }
    if {![catch {file home} h]} {
        return $h
    }
    error "HOME ist nicht gesetzt"
}

# XDG Base Directory: Variable, sonst Vorgabe. Ein relativer Wert ist
# laut Spezifikation ungültig und wird übergangen.
proc xdgOrdner {var vorgabe app} {
    set basis ""
    if {[info exists ::env($var)]} { set basis $::env($var) }
    if {$basis eq "" || [file pathtype $basis] ne "absolute"} {
        set basis [file join [heim] {*}$vorgabe]
    }
    return [file join $basis $app]
}

proc konfigOrdner {app} { xdgOrdner XDG_CONFIG_HOME {.config} $app }
proc datenOrdner  {app} { xdgOrdner XDG_DATA_HOME {.local share} $app }
proc cacheOrdner  {app} { xdgOrdner XDG_CACHE_HOME {.cache} $app }
proc zustandOrdner {app} { xdgOrdner XDG_STATE_HOME {.local state} $app }

# Benutzerordner (Dokumente, Desktop) sind lokalisiert. xdg-user-dir
# liest ~/.config/user-dirs.dirs; fehlt das Werkzeug, bleibt HOME.
proc benutzerOrdner {name} {
    set cmd [auto_execok xdg-user-dir]
    if {$cmd ne "" && ![catch {exec {*}$cmd $name} p] && $p ne ""} {
        return $p
    }
    return [heim]
}

set app [expr {[llength $argv] ? [lindex $argv 0] : "meineapp"}]
puts "Tcl         [info patchlevel]"
puts "Konfig      [konfigOrdner $app]"
puts "Daten       [datenOrdner $app]"
puts "Cache       [cacheOrdner $app]"
puts "Zustand     [zustandOrdner $app]"
puts "Dokumente   [benutzerOrdner DOCUMENTS]"
puts "Desktop     [benutzerOrdner DESKTOP]"
