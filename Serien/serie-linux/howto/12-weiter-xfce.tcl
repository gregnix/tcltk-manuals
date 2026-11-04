#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

set xfceRoot [file normalize [file join $::serie::root .. serie-xfce]]
serie::assert {[file isdirectory $xfceRoot]} "serie-xfce vorhanden"
serie::assert {[file exists [file join $xfceRoot howto 01-erste-schritte.tcl]]} \
    "serie-xfce Howto 01"

if {[info exists ::env(XDG_CURRENT_DESKTOP)] \
        && [string match -nocase *XFCE* $::env(XDG_CURRENT_DESKTOP)]} {
    puts "Desktop XFCE — siehe serie-xfce"
} else {
    puts "Kein XFCE in XDG_CURRENT_DESKTOP (serie-xfce braucht eine Sitzung)"
}

serie::done "12 Weiter XFCE"
