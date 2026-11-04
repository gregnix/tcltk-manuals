#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set th [auto_execok thunar]
serie::assert {$th ne ""} "thunar"
set ver [exec {*}$th --version 2>@1]
serie::assert {[string match *thunar* $ver]} "thunar --version"
serie::assert {[string match *Xfce* $ver]} "Thunar nennt Xfce"

set mime [auto_execok xdg-mime]
serie::assert {$mime ne ""} "xdg-mime"
set def [string trim [exec {*}$mime query default inode/directory]]
serie::assert {$def eq "thunar.desktop"} "inode/directory = thunar.desktop"

serie::done "08 Thunar"
