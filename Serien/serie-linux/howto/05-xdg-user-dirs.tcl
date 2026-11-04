#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

set xdg [auto_execok xdg-user-dir]
if {$xdg eq ""} { serie::skip "xdg-user-dir fehlt (Paket xdg-user-dirs)" }

foreach key {DOCUMENTS DESKTOP DOWNLOAD} {
    set dir [string trim [exec {*}$xdg $key]]
    serie::assert {[file isdirectory $dir]} "xdg-user-dir $key"
}

set dirsFile [file join [serie::xdgDir config] user-dirs.dirs]
serie::assert {[file exists $dirsFile]} "user-dirs.dirs"

serie::done "05 XDG-Benutzerordner"
