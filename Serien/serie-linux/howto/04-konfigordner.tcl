#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

set cfg [serie::xdgDir config]
set data [serie::xdgDir data]
set cache [serie::xdgDir cache]
serie::assert {[file isdirectory $cfg]} "configDir"
serie::assert {[file isdirectory $data]} "dataDir"
serie::assert {[file isdirectory $cache]} "cacheDir"
serie::assert {[string match */.config $cfg] || [info exists ::env(XDG_CONFIG_HOME)]} \
    "config unter .config oder XDG"

# Schreibtest in out/, nicht in ~/.config (kein Restmuell, Sandbox)
set dir [file join $::serie::outDir howto-config]
file mkdir $dir
set f [file join $dir settings.txt]
set fh [open $f w]
puts $fh "demo=1"
close $fh
serie::assert {[file exists $f]} "settings geschrieben"
file delete -force $f
file delete -force $dir

serie::done "04 Konfigordner"
