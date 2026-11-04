#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "01 DISPLAY" {
    serie::brauchtX11
    set ::serie::d [expr {[info exists ::env(DISPLAY)] ? $::env(DISPLAY) : ""}]
    set ::serie::sw [winfo screenwidth .]
    set ::serie::sh [winfo screenheight .]
    set ::serie::mm [winfo screenmmwidth .]
    set ::serie::sc [tk scaling]
    set ::serie::font [font actual TkDefaultFont]
    # Pixelbreite einer Punkt-Schrift folgt tk scaling
    set ::serie::lin [font metrics TkDefaultFont -linespace]
    ttk::label .f.l -text "DISPLAY=$::serie::d ${::serie::sw}x${::serie::sh} scaling=$::serie::sc"
    pack .f.l -anchor w
    set ::serie::status "DISPLAY=$::serie::d ${::serie::sw}x${::serie::sh}"
} {
    serie::assert {$::serie::d ne ""} "DISPLAY gesetzt"
    serie::assert {$::serie::sw > 0} "screenwidth"
    set erwartet [expr {$::serie::sw / ($::serie::mm / 25.4) / 72.0}]
    serie::assert {abs($::serie::sc - $erwartet) < 0.02 * $erwartet} \
        "tk scaling = Pixel / (mm / 25.4) / 72"
    serie::assert {$::serie::lin > 0} "Schrift vorhanden"
}
