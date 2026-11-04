#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "16 Test stellt her" {
    toplevel .t
    bind .t <Escape> {incr ::serie::n}
    set ::serie::n 0
    serie::fokusVorbereiten
    focus -force .t
    update
    event generate .t <Escape>
    update
    set ::serie::ok $::serie::n
    destroy .t
    ttk::label .f.l -text "n=$::serie::ok"
    pack .f.l -anchor w
    set ::serie::status "n=$::serie::ok"
} {
    serie::assert {$::serie::ok == 1} "Test hat Fokus selbst gesetzt"
}
