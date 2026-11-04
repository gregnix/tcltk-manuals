#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "04 deko" {
    wm geometry . 360x220+30+40
    update
    set n [scan [wm geometry .] {%dx%d%[+-]%d%[+-]%d} gw gh sx gx sy gy]
    set ::serie::form [expr {$n == 6 && $sx eq "+" && $sy eq "+"}]
    set ::serie::dekoX [expr {[winfo rootx .] - $gx}]
    set ::serie::dekoY [expr {[winfo rooty .] - $gy}]
    set ::serie::rahmen [serie::wmRahmen]
    set ::serie::status "dekoX=$::serie::dekoX dekoY=$::serie::dekoY rahmen=$::serie::rahmen"
} {
    serie::assert {$::serie::form} "Geometrie in der Form WxH+X+Y"
    if {$::serie::rahmen} {
        serie::assert {$::serie::dekoX >= 0 && $::serie::dekoY >= 0} "Rahmen nicht negativ"
    } else {
        serie::assert {$::serie::dekoX == 0 && $::serie::dekoY == 0} "ohne Rahmen: Deko 0"
    }
}
