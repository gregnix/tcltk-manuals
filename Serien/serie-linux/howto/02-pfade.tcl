#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

serie::assert {[info exists ::env(HOME)] && $::env(HOME) ne ""} "HOME gesetzt"
serie::assert {[file isdirectory $::env(HOME)]} "HOME ist Verzeichnis"

set heim [file normalize $::env(HOME)]
if {[package vsatisfies [package provide Tcl] 9-]} {
    # TIP 602: ~ ist ein Dateiname
    serie::assert {[file normalize ~] eq [file join [pwd] ~]} "Tilde ist Dateiname (Tcl 9)"
    serie::assert {[file normalize [file home]] eq $heim} "file home = HOME"
    serie::assert {[file tildeexpand ~/x] eq [file join $heim x]} "file tildeexpand"
} else {
    serie::assert {[file normalize ~] eq $heim} "Tilde = HOME (Tcl 8.6)"
}

set native [file nativename $::env(HOME)]
serie::assert {$native eq $::env(HOME)} "nativename unix"

set testDir [file join $::serie::outDir pfad-test]
file mkdir $testDir
set f [file join $testDir ok.txt]
set fh [open $f w]
close $fh
serie::assert {[file exists $f]} "file join Schreibtest"
file delete -force $f
file delete -force $testDir

serie::done "02 Pfade"
