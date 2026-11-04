#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

serie::assert {$::tcl_platform(platform) eq "unix"} "platform"
serie::assert {$::tcl_platform(os) eq "Linux"} "os"
serie::assert {[string length $::tcl_platform(osVersion)] > 0} "osVersion"
serie::assert {[string length $::tcl_platform(user)] > 0} "user"
serie::assert {$::tcl_platform(machine) in {x86_64 amd64 aarch64 i686}} "machine"
serie::assert {$::tcl_platform(wordSize) in {4 8}} "wordSize"
serie::assert {$::tcl_platform(byteOrder) in {littleEndian bigEndian}} "byteOrder"
serie::assert {[string length [info hostname]] > 0} "hostname"

serie::done "10 tcl_platform"
