# utf8-wache.tcl -- UTF-8-Skript, das auch unter Tcl 8.6 mit LANG=C stimmt
#
# Diese Datei ist UTF-8. Tcl 9 liest Skripte immer als UTF-8. Tcl 8.6
# liest sie in [encoding system]; unter LANG=C ist das iso8859-1, und
# "ü" wird zu zwei Zeichen. Die Wache erkennt das und liest die Datei
# neu ein, diesmal ausdrücklich als UTF-8.
#
#   LANG=C       tclsh8.6 utf8-wache.tcl
#   LANG=C.UTF-8 tclsh8.6 utf8-wache.tcl
#   LANG=C       tclsh9.0 utf8-wache.tcl
#
# Kapitel "Kodierung und Locale". Vorlage: serie-linux, Howto 08.

if {[string length "ü"] != 1} {
    source -encoding utf-8 [file normalize [info script]]
    return
}

set text "Rückgängig"
puts "Tcl [info patchlevel], encoding system [encoding system]"
puts "Länge von \"Rückgängig\": [string length $text] (soll 10)"

# Ausgabe: stdout folgt [encoding system]. Unter LANG=C kann das
# Terminal die Umlaute nicht zeigen, der String im Programm stimmt
# trotzdem. Dateien immer mit ausdrücklicher Kodierung schreiben.
set f [file join [expr {[info exists env(TMPDIR)] ? $env(TMPDIR) : "/tmp"}] utf8-wache.txt]
set ch [open $f w]
fconfigure $ch -encoding utf-8
puts $ch $text
close $ch
puts "geschrieben: $f ([file size $f] Byte, soll 13: 10 Zeichen, zwei davon mit 2 Byte, plus Zeilenende)"
file delete $f
