#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set channels [serie::xfconf -l]
foreach ch {xfwm4 thunar xfce4-panel xfce4-session xsettings} {
    serie::assert {[string match *$ch* $channels]} "Kanal $ch"
}

set theme [serie::xfconf -c xfwm4 -p /general/theme]
serie::assert {[string length $theme] > 0} "xfwm4 theme"

set n [serie::xfconf -c xfwm4 -p /general/workspace_count]
serie::assert {[string is integer -strict $n] && $n >= 1} "workspace_count"

serie::done "02 xfconf lesen"
