#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set term [auto_execok xfce4-terminal]
serie::assert {$term ne ""} "xfce4-terminal"
set ver [exec {*}$term --version 2>@1]
serie::assert {[string match *xfce4-terminal* $ver]} "xfce4-terminal --version"
serie::assert {[string match *Xfce* $ver]} "Terminal nennt Xfce"

serie::done "09 Terminal"
