#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "17 Xvfb vorhanden" {
    set ::serie::x [auto_execok Xvfb]
    set ::serie::r [auto_execok xvfb-run]
    ttk::label .f.l -text "Xvfb=[list $::serie::x] run=[list $::serie::r]"
    pack .f.l -anchor w
    set ::serie::status "Xvfb=[list $::serie::x]"
} {
    if {$::serie::x eq "" && $::serie::r eq ""} {
        serie::skip "Xvfb nicht installiert"
    }
}
