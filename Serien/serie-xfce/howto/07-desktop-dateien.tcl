#!/usr/bin/env tclsh
source [file join [file dirname [info script]] .. _bootstrap.tcl]
serie::requireXfce

set val [auto_execok desktop-file-validate]
serie::assert {$val ne ""} "desktop-file-validate"

set sys [file join /usr/share/applications xfce4-about.desktop]
serie::assert {[file exists $sys]} "xfce4-about.desktop"
set fh [open $sys r]
set txt [read $fh]
close $fh
serie::assert {[string match {*[Desktop Entry]*} $txt]} "Desktop Entry"
serie::assert {[string match *OnlyShowIn=XFCE* $txt]} "OnlyShowIn XFCE"

set path [serie::out serie-xfce-demo.desktop]
set fh [open $path w]
fconfigure $fh -encoding utf-8
puts $fh "\[Desktop Entry\]"
puts $fh "Type=Application"
puts $fh "Name=SerieXfceDemo"
puts $fh "Exec=true"
puts $fh "Terminal=false"
puts $fh "Categories=Utility;"
close $fh
exec {*}$val $path
file delete -force $path

serie::done "07 Desktop-Dateien"
