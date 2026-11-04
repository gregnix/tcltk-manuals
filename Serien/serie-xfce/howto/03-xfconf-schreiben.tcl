#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

proc ::serie::cleanupTest {} {
    catch {serie::xfconf -c serie-xfce -p /howto -r -R}
}

serie::cleanupTest
if {[catch {
    serie::xfconf -c serie-xfce -p /howto/demo -n -t string -s ok
    set v [serie::xfconf -c serie-xfce -p /howto/demo]
    serie::assert {$v eq "ok"} "geschrieben"
} err]} {
    serie::cleanupTest
    puts stderr $err
    exit 1
}
serie::cleanupTest

serie::done "03 xfconf schreiben"
