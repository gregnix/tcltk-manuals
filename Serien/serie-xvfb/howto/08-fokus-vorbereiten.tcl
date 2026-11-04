#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "08 fokusVorbereiten" {
    set ::serie::k 0
    bind . <Control-s> {incr ::serie::k}
    serie::fokusVorbereiten
    event generate . <Control-s>
    ttk::label .f.l -text "Control-s n=$::serie::k"
    pack .f.l -anchor w
    set ::serie::status "k=$::serie::k"
} {
    serie::assert {$::serie::k == 1} "fokusVorbereiten reicht"
}
