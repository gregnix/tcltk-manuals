#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

serie::assert {[string match -nocase *XFCE* $::env(XDG_CURRENT_DESKTOP)]} \
    "XDG_CURRENT_DESKTOP XFCE"

set aboutCmd [auto_execok xfce4-about]
serie::assert {$aboutCmd ne ""} "xfce4-about"
set about [exec {*}$aboutCmd --version 2>@1]
serie::assert {[string match *Xfce* $about]} "xfce4-about nennt Xfce"

serie::done "01 Erste Schritte"
