#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "19 Xvfb deko" {
    set ::serie::out [serie::aufEigenemXvfb {
        wm geometry . 200x100+30+40
        update
        puts "[expr {[winfo rooty .] - 40}] [expr {[wm frame .] == [winfo id .]}]"
        exit
    }]
    lassign [lindex [split [string trim $::serie::out] \n] end] ::serie::dekoY ::serie::gleich
    ttk::label .f.l -text "eigener Xvfb: dekoY=$::serie::dekoY frame==id: $::serie::gleich"
    pack .f.l -anchor w
    set ::serie::status "dekoY=$::serie::dekoY"
} {
    serie::assert {$::serie::dekoY == 0} "nackter Xvfb: kein Rahmen oben"
    serie::assert {$::serie::gleich == 1} "nackter Xvfb: wm frame == winfo id"
}
