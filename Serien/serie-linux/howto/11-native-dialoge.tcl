#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux
package require Tk

wm withdraw .

serie::assert {[info exists ::tk_version]} "Tk geladen"
serie::assert {[llength [info commands tk_getOpenFile]] > 0} "tk_getOpenFile"
serie::assert {[llength [info commands tk_getSaveFile]] > 0} "tk_getSaveFile"
serie::assert {[llength [info commands tk_chooseDirectory]] > 0} "tk_chooseDirectory"

clipboard clear
clipboard append "serie-linux"
serie::assert {[clipboard get] eq "serie-linux"} "CLIPBOARD roundtrip"
if {[catch {selection get -selection PRIMARY} prim]} {
    # erwartet: PRIMARY fehlt ohne Mausauswahl
    serie::assert {[string length $prim] > 0} "PRIMARY-Fehlertext"
}

if {!$::serie::auto} {
    tk_messageBox -title "serie-linux" -message "Native Dialoge — OK zum Schliessen"
}

serie::done "11 Native Dialoge"
