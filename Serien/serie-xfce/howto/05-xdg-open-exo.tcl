#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

serie::assert {[auto_execok xdg-open] ne ""} "xdg-open"
serie::assert {[auto_execok exo-open] ne ""} "exo-open"

set help [exec {*}[auto_execok exo-open] --help 2>@1]
serie::assert {[string match *--launch* $help]} "exo-open --launch"

serie::done "05 xdg-open exo"
