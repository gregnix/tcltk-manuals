#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set ns [auto_execok notify-send]
serie::assert {$ns ne ""} "notify-send"
set ver [exec {*}$ns --version 2>@1]
serie::assert {[string match *notify-send* $ver]} "notify-send --version"

if {!$::serie::auto} {
    exec {*}$ns -t 1000 -e --app-name serie-xfce \
        "serie-xfce" "Howto 06 notify-send"
}

serie::done "06 notify-send"
