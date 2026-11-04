#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

# Ohne Anmeldung (Container, CI, cron) fehlen USER, SHELL oder LANG oft.
foreach var {USER SHELL LANG} {
    if {![info exists ::env($var)]} {
        serie::skip "env $var fehlt (kein Anmelde-Umfeld)"
    }
}
foreach var {HOME USER SHELL PATH LANG} {
    serie::assert {[info exists ::env($var)]} "env $var gesetzt"
    serie::assert {[string length $::env($var)] > 0} "env $var nicht leer"
}
serie::assert {[file isdirectory $::env(HOME)]} "HOME Verzeichnis"
serie::assert {[file exists $::env(SHELL)] || [auto_execok [file tail $::env(SHELL)]] ne ""} \
    "SHELL existiert"

serie::assert {[string length $::tcl_platform(user)] > 0} "tcl_platform(user)"
# USER und tcl_platform(user) nicht gleichsetzen — Sandbox/sudo

if {[info exists ::env(DISPLAY)] && $::env(DISPLAY) ne ""} {
    serie::assert {[string match {:*} $::env(DISPLAY)] || [string match *:* $::env(DISPLAY)]} \
        "DISPLAY Form"
}

serie::done "03 Umgebung"
