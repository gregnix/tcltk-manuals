#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

serie::assert {$::tcl_platform(platform) eq "unix"} "platform unix"
serie::assert {$::tcl_platform(os) eq "Linux"} "os Linux"
serie::assert {[string match 8.6* [info patchlevel]] || [string match 9.* [info patchlevel]]} \
    "Tcl 8.6+ oder 9"

serie::done "01 Erste Schritte"
