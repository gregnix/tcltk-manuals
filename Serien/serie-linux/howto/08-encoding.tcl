#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireLinux

serie::assert {"utf-8" in [encoding names]} "utf-8 verfuegbar"

# Daten-Datei: UTF-8-Bytes. Das Kind-Skript bleibt ASCII (Tcl 8.6
# liest Skripte als encoding system). Quelle ohne Umlaute: \u.
set text "Gr\u00fc\u00dfe"
set data [serie::out enc08.txt]
set fh [open $data w]
fconfigure $fh -encoding utf-8
puts -nonewline $fh $text
close $fh

set script [serie::out enc08.tcl]
set fh [open $script w]
puts $fh {
set path [lindex $argv 0]
set fh [open $path r]
fconfigure $fh -encoding utf-8
puts "utf=[string length [read $fh]]"
close $fh
set fh [open $path r]
puts "roh=[string length [read $fh]]"
close $fh
puts "enc=[encoding system]"
}
close $fh

foreach lang {C C.UTF-8} {
    set ::env(LANG) $lang
    set ::env(LC_ALL) $lang
    set out [exec [info nameofexecutable] $script $data << ""]
    serie::assert {[string match *utf=5* $out]} "Datei utf-8 (LANG=$lang)"
    if {$lang eq "C"} {
        serie::assert {[string match *roh=7* $out]} "ohne fconfigure Latin-1"
    } else {
        serie::assert {[string match *roh=5* $out]} "ohne fconfigure utf-8"
    }
    serie::line "LANG=$lang: [regexp -inline {roh=\d+} $out] [regexp -inline {enc=\S+} $out]"
}

# Skript-Falle: UTF-8-app.tcl als iso8859-1 gelesen (8.6 / LANG=C, und
# Windows cp1252). Wache laedt neu mit -encoding utf-8.
set u \u00fc
set lbl "R${u}ckg\u00e4ngig"
set body [format {if {[string length "%s"] != 1} {
    source -encoding utf-8 [file normalize [info script]]
    return
}
set ::lbl "%s"
} $u $lbl]
set watched [serie::out enc08-watch.tcl]
set fh [open $watched w]
fconfigure $fh -encoding utf-8 -translation lf
puts -nonewline $fh $body
close $fh
set i [interp create]
$i eval [list source -encoding iso8859-1 $watched]
serie::assert {[$i eval {string length $::lbl}] == 10} "Wache: Rueckgaengig 10"
serie::assert {[$i eval {scan [string index $::lbl 1] %c}] == 252} "Wache: U+00FC"
interp delete $i

set naked [serie::out enc08-naked.tcl]
set fh [open $naked w]
fconfigure $fh -encoding utf-8 -translation lf
puts -nonewline $fh [format {set ::lbl "%s"} $lbl]
close $fh
set i [interp create]
$i eval [list source -encoding iso8859-1 $naked]
serie::assert {[$i eval {string length $::lbl}] == 12} "ohne Wache 12 Zeichen"
serie::assert {[$i eval {scan [string index $::lbl 1] %c}] == 195} "ohne Wache U+00C3"
interp delete $i
serie::line "Skript: Wache 10/U+00FC, nackt 12/U+00C3"

serie::done "08 Encoding"
