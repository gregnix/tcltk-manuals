#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "15 viewable" {
    ttk::label .f.l -text Hi
    pack .f.l
    update
    set ::serie::before [winfo viewable .f]
    wm withdraw .
    update
    set ::serie::after [winfo viewable .f]
    wm deiconify .
    update
    set ::serie::status "before=$::serie::before after=$::serie::after"
} {
    serie::assert {$::serie::before} "vorher viewable"
    serie::assert {!$::serie::after} "withdraw . macht Kind unsichtbar"
}
