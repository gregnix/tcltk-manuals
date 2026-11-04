#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set wm [auto_execok xfwm4]
serie::assert {$wm ne ""} "xfwm4"
set ver [exec {*}$wm --version 2>@1]
serie::assert {[string match *xfwm4* $ver]} "xfwm4 --version"
serie::assert {[string match *Xfce* $ver]} "xfwm4 nennt Xfce"

set n [serie::xfconf -c xfwm4 -p /general/workspace_count]
serie::assert {[string is integer -strict $n] && $n >= 1} "workspace_count"
set theme [serie::xfconf -c xfwm4 -p /general/theme]
serie::assert {[string length $theme] > 0} "theme"

serie::done "10 xfwm4"
