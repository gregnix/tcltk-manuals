#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "13 keine 80" {
    wm geometry . 360x220+30+40
    update
    scan [wm geometry .] {%dx%d%[+-]%d%[+-]%d} gw gh sx gx sy gy
    set ::serie::gy $gy
    set ::serie::dekoY [expr {[winfo rooty .] - $gy}]
    set ::serie::wrong [expr {$gy + 80}]
    set ::serie::right [winfo rooty .]
    set ::serie::rahmen [serie::wmRahmen]
    ttk::label .f.l -text "dekoY=$::serie::dekoY"
    pack .f.l -anchor w
    set ::serie::status "dekoY=$::serie::dekoY wrong=$::serie::wrong right=$::serie::right"
} {
    if {$::serie::dekoY == 80} {
        serie::skip "Titelleiste hier zufaellig 80 px"
    }
    serie::assert {$::serie::right != $::serie::wrong} "feste +80 trifft nicht"
    if {!$::serie::rahmen} {
        serie::assert {$::serie::right == $::serie::gy} "ohne Rahmen: rooty = gy"
    }
}
