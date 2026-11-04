#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "18 xvfb-run" {
    set ::serie::out [serie::aufEigenemXvfb {
        puts "[winfo screenwidth .] [winfo screenheight .] [winfo screendepth .] [tk scaling]"
        exit
    } {-screen 0 800x600x16 -dpi 50}]
    lassign [lindex [split [string trim $::serie::out] \n] end] w h d sc
    set ::serie::w $w
    set ::serie::h $h
    set ::serie::d $d
    set ::serie::sc $sc
    ttk::label .f.l -text "eigener Xvfb: ${w}x${h}x$d scaling=$sc"
    pack .f.l -anchor w
    set ::serie::status "eigener Xvfb: ${w}x${h}x$d"
} {
    serie::assert {$::serie::w == 800 && $::serie::h == 600} "-screen 0 800x600"
    serie::assert {$::serie::d == 16} "Farbtiefe 16"
    serie::assert {abs($::serie::sc - 50 / 72.0) < 0.02} "-dpi 50 -> tk scaling 50/72"
}
