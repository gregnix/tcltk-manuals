#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

set xo [auto_execok xdg-open]
serie::assert {$xo ne ""} "auto_execok xdg-open"

set uname [string trim [exec uname -s]]
serie::assert {$uname eq "Linux"} "uname Linux"

set out [string trim [exec echo serie-linux]]
serie::assert {$out eq "serie-linux"} "exec echo"

serie::done "07 exec xdg"
