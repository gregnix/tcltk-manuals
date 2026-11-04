#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set panel [auto_execok xfce4-panel]
serie::assert {$panel ne ""} "xfce4-panel"
set pv [exec {*}$panel --version 2>@1]
serie::assert {[string match *xfce4-panel* $pv]} "panel --version"

set sess [auto_execok xfce4-session]
serie::assert {$sess ne ""} "xfce4-session"
set sv [exec {*}$sess --version 2>@1]
serie::assert {[string match *xfce4-session* $sv]} "session --version"

if {[info exists ::env(XDG_MENU_PREFIX)]} {
    serie::assert {[string match xfce* $::env(XDG_MENU_PREFIX)]} "XDG_MENU_PREFIX"
}

set chans [serie::xfconf -l]
serie::assert {[string match *xfce4-panel* $chans]} "Kanal xfce4-panel"
serie::assert {[string match *xfce4-session* $chans]} "Kanal xfce4-session"

serie::done "11 Panel Session"
