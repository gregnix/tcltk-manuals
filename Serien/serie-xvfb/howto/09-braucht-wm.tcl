#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "09 brauchtWM" {
    serie::brauchtX11
    update
    set ::serie::rahmen [serie::wmRahmen]
    set ::serie::da [serie::wmDa]
    set ::serie::fr [wm frame .]
    set ::serie::id [winfo id .]
    ttk::label .f.l -text "WM=$::serie::da Rahmen=$::serie::rahmen frame=$::serie::fr id=$::serie::id"
    pack .f.l -anchor w
    set ::serie::status "WM=$::serie::da Rahmen=$::serie::rahmen"
} {
    serie::assert {[winfo manager .] eq "wm"} "winfo manager . ist immer wm"
    if {![info exists ::env(SERIE_WM)] || $::env(SERIE_WM) eq ""} {
        serie::assert {$::serie::rahmen == ($::serie::fr != $::serie::id)} \
            "Rahmen = frame != id (numerisch)"
    }
    serie::assert {!$::serie::rahmen || $::serie::da} "Rahmen heisst WM"
}
