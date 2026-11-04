#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "06 withdraw" {
    toplevel .t
    bind .t <Escape> {incr ::serie::n}
    wm withdraw .t
    focus -force .
    update
    set ::serie::n 0
    event generate .t <Escape>
    update
    set ::serie::a $::serie::n
    wm deiconify .t
    focus -force .t
    update
    event generate .t <Escape>
    update
    set ::serie::b $::serie::n
    destroy .t
    ttk::label .f.l -text "withdraw=$::serie::a deicon=$::serie::b"
    pack .f.l -anchor w
    set ::serie::status "withdraw=$::serie::a deicon=$::serie::b"
} {
    serie::assert {$::serie::a == 0} "withdraw keine Taste"
    serie::assert {$::serie::b == 1} "nach focus -force"
}
