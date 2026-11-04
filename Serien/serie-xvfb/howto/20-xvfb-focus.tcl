#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "20 Xvfb focus" {
    set ::serie::out [serie::aufEigenemXvfb {
        set n 0
        bind . <Escape> {incr n}
        update
        set f0 [focus]
        event generate . <Escape>
        set n0 $n
        focus -force .
        update
        event generate . <Escape>
        puts "[llength $f0] $n0 $n"
        exit
    }]
    lassign [lindex [split [string trim $::serie::out] \n] end] ::serie::f0 ::serie::n0 ::serie::n1
    ttk::label .f.l -text "eigener Xvfb: ohne Fokus n=$::serie::n0, mit focus -force n=$::serie::n1"
    pack .f.l -anchor w
    set ::serie::status "n0=$::serie::n0 n1=$::serie::n1"
} {
    serie::assert {$::serie::f0 == 0} "nackter Xvfb: kein Fokus nach update"
    serie::assert {$::serie::n0 == 0} "ohne Fokus keine Taste"
    serie::assert {$::serie::n1 == 1} "nach focus -force kommt sie an"
}
