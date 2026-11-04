#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "11 grab" {
    toplevel .t
    update
    grab .t
    set ::serie::g [grab current]
    grab release .t
    destroy .t
    ttk::label .f.l -text "grab=$::serie::g"
    pack .f.l -anchor w
    set ::serie::status "grab=$::serie::g"
} {
    serie::assert {$::serie::g eq ".t"} "grab current"
}
