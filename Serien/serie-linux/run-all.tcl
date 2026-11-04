#!/usr/bin/env tclsh
# ERZEUGT von werkzeug/stanze.tcl -- NICHT HIER AENDERN.
#
# Die Quelle ist _kern/run-all.tcl.

# run-all.tcl -- Läufer einer Serie (Quelle, wird gestanzt).
#
# Interpreter der eigenen Fassung, ein Prozess je Kapitel, SKIP
# getrennt von FAIL, FAIL>0 beendet mit 1.
#
# Die erste Zeile des Kapitels entscheidet: steht "wish" darin
# (#!/usr/bin/env wish, wish9.0, …), läuft es unter dem zugehörigen
# wish -- sonst unter diesem tclsh.

set here [file dirname [file normalize [info script]]]
set ::env(SERIES_AUTO) 1

proc waehleWish {} {
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

proc ersteZeile {skript} {
    set ch [open $skript r]
    set line [gets $ch]
    close $ch
    return $line
}

proc brauchtWish {skript} {
    string match {*wish*} [ersteZeile $skript]
}

set scripts [lsort [glob -nocomplain [file join $here howto *.tcl]]]
if {![llength $scripts]} {
    puts stderr "Keine howto/*.tcl gefunden."
    exit 1
}

set wishGew [waehleWish]
puts "tclsh: [info nameofexecutable]"
if {$wishGew ne ""} {
    puts "wish: $wishGew"
} else {
    puts "wish: (keiner zur gleichen Fassung)"
}

set irgendWish 0
foreach s $scripts {
    if {[brauchtWish $s]} {
        set irgendWish 1
        break
    }
}
if {$irgendWish && $wishGew eq ""} {
    puts stderr "kein wish zur Tcl-Fassung [info patchlevel]"
    exit 1
}

set ok 0
set skip 0
set fail 0
foreach s $scripts {
    puts "==> [file tail $s]"
    if {[brauchtWish $s]} {
        set exe $wishGew
    } else {
        set exe [info nameofexecutable]
    }
    set out ""
    if {[catch {exec $exe $s << "" 2>@stderr} out opts]} {
        puts stderr "FAIL: [file tail $s]: $out"
        incr fail
    } elseif {[string match *SKIP:* $out]} {
        incr skip
    } else {
        incr ok
    }
}

puts "OK   = $ok"
puts "SKIP = $skip"
puts "FAIL = $fail"
if {$fail > 0} {
    exit 1
}
exit 0
