#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "03 ismapped" {
    ttk::label .f.l -text Hi
    pack .f.l
    update
    set ::serie::map [winfo ismapped .]
    set ::serie::view [winfo viewable .]
    set ::serie::status "mapped=$::serie::map viewable=$::serie::view"
} {
    serie::assert {$::serie::map} "ismapped"
    serie::assert {$::serie::view} "viewable"
}
