#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "10 iconify" {
    serie::brauchtWM
    toplevel .t
    update
    wm iconify .t
    update
    set ::serie::st [wm state .t]
    wm deiconify .t
    destroy .t
    ttk::label .f.l -text "state=$::serie::st"
    pack .f.l -anchor w
    set ::serie::status "state=$::serie::st"
} {
    serie::assert {$::serie::st eq "iconic"} "iconify"
}
