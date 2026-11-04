#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

set vols [file volumes]
serie::assert {"/" in $vols} "volume /"

serie::assert {[file isdirectory /tmp]} "/tmp"
serie::assert {[file writable /tmp]} "/tmp schreibbar"

set f [serie::out attr-test.txt]
set fh [open $f w]
close $fh
set attrs [file attributes $f]
serie::assert {"-owner" in $attrs} "-owner"
serie::assert {"-permissions" in $attrs} "-permissions"
file delete -force $f

serie::assert {$::tcl_platform(pathSeparator) eq ":"} "PATH-Separator"

serie::done "09 Dateisystem"
