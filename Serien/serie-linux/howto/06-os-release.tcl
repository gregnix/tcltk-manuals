#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

serie::assert {[file exists /etc/os-release]} "/etc/os-release"
set rel [serie::parseOsRelease]
serie::assert {[dict exists $rel ID]} "ID"
serie::assert {[dict get $rel ID] ne ""} "ID nicht leer"

serie::assert {[file exists /proc/self/comm]} "/proc/self/comm"
set fh [open /proc/self/comm r]
set comm [string trim [read $fh]]
close $fh
serie::assert {[string match *tclsh* $comm]} "comm enthaelt tclsh"

set exe [file readlink /proc/self/exe]
serie::assert {[file exists $exe]} "exe"
serie::assert {[string match *tclsh* [file tail $exe]]} "exe-Name tclsh"

serie::done "06 os-release"
