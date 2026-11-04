#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set linuxRoot [file normalize [file join $::serie::root .. serie-linux]]
serie::assert {[file isdirectory $linuxRoot]} "serie-linux vorhanden"
serie::assert {[file exists [file join $linuxRoot howto 01-erste-schritte.tcl]]} \
    "serie-linux Howto 01"

serie::done "12 Weiter Linux"
