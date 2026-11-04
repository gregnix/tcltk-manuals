#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "07 focus -force" {
    toplevel .t
    bind .t <Escape> {incr ::serie::n}
    set ::serie::n 0
    focus -force .t
    update
    event generate .t <Escape>
    update
    # Umleitung: die Taste geht ans Fokus-Widget
    entry .t.e1
    entry .t.e2
    pack .t.e1 .t.e2
    set ::serie::hit {}
    bind .t.e1 <Key-x> {lappend ::serie::hit e1}
    bind .t.e2 <Key-x> {lappend ::serie::hit e2}
    focus -force .t.e1
    update
    event generate .t.e2 <Key-x>
    update
    set ::serie::status "n=$::serie::n focus=[focus] hit=$::serie::hit"
    destroy .t
} {
    serie::assert {$::serie::n == 1} "Taste nach focus -force"
    serie::assert {$::serie::hit eq "e1"} "Taste an .e2 landet beim Fokus-Widget .e1"
}
