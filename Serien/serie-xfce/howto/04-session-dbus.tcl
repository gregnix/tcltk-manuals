#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

serie::assert {[info exists ::env(DBUS_SESSION_BUS_ADDRESS)]} "DBUS_SESSION_BUS_ADDRESS"
serie::assert {[string match unix:path=* $::env(DBUS_SESSION_BUS_ADDRESS)]} "unix:path"

if {[info exists ::env(XDG_SESSION_TYPE)]} {
    serie::assert {$::env(XDG_SESSION_TYPE) in {x11 wayland}} "SESSION_TYPE"
}

if {[info exists ::env(XDG_RUNTIME_DIR)] && $::env(XDG_RUNTIME_DIR) ne ""} {
    serie::assert {[file isdirectory $::env(XDG_RUNTIME_DIR)]} "XDG_RUNTIME_DIR"
}

set dbus [auto_execok dbus-send]
serie::assert {$dbus ne ""} "dbus-send"
set reply [exec {*}$dbus --session --print-reply \
    --dest=org.xfce.Xfconf /org/xfce/Xfconf org.xfce.Xfconf.ListChannels]
serie::assert {[string match *xfwm4* $reply]} "DBus ListChannels xfwm4"

serie::done "04 Session DBus"
