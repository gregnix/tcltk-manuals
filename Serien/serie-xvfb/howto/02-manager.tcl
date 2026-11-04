#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "02 manager" {
    update
    set ::serie::m [winfo manager .]
    set ::serie::st [wm state .]
    toplevel .t
    update
    set ::serie::mt [winfo manager .t]
    destroy .t
    ttk::label .f.l -text "manager=[list $::serie::m] state=$::serie::st"
    pack .f.l -anchor w
    set ::serie::status "manager=[list $::serie::m] state=$::serie::st"
} {
    serie::assert {$::serie::m eq "wm"} "winfo manager . ist wm"
    serie::assert {$::serie::mt eq "wm"} "auch fuer jedes Toplevel"
    serie::assert {$::serie::st eq "normal"} "state normal"
}
