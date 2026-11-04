#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "05 generate sofort" {
    toplevel .t
    bind .t <Escape> {incr ::serie::n}
    set ::serie::n 0
    event generate .t <Escape>
    set ::serie::ohne $::serie::n
    destroy .t
    ttk::label .f.l -text "ohne Fokus n=$::serie::ohne"
    pack .f.l -anchor w
    set ::serie::status "ohne=$::serie::ohne"
} {
    serie::assert {$::serie::ohne == 0} "ohne Fokus keine Taste"
}
