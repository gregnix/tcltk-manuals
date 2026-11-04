# auswahl-probe.tcl -- PRIMARY und CLIPBOARD unter X11
#
# Markiert Text in einem Entry, liest PRIMARY von innen und von außen
# (xclip), kopiert mit <<Copy>> und liest CLIPBOARD. Endet selbst.
#
#   LANG=C.UTF-8 wish9.0 auswahl-probe.tcl
#   danach: xclip -o -selection clipboard   (Inhalt ist weg)
#
# Kapitel "Maus, Tastatur, Zwischenablage".
#
# Wichtig: xclip nie mit einem blockierenden exec lesen, solange dieses
# Programm selbst Besitzer der Auswahl ist. exec wartet auf xclip, xclip
# wartet auf die Antwort dieses Programms, und die kommt nie, weil die
# Ereignisschleife steht. Deshalb hier eine Pipe mit fileevent.

proc fremdLesen {auswahl} {
    if {[auto_execok xclip] eq ""} { return "(xclip fehlt)" }
    set ch [open [list |xclip -o -selection $auswahl 2>@1]]
    fconfigure $ch -blocking 0 -encoding utf-8
    set ::puffer ""
    set ::fertig 0
    fileevent $ch readable [list apply {{ch} {
        append ::puffer [read $ch]
        if {[eof $ch]} {
            fconfigure $ch -blocking 1
            catch {close $ch}
            set ::fertig 1
        }
    }} $ch]
    set id [after 3000 {set ::fertig timeout}]
    vwait ::fertig
    after cancel $id
    if {$::fertig eq "timeout"} { return "(timeout)" }
    return $::puffer
}

entry .e
pack .e
.e insert 0 "Auswahl-Ü"
update
.e selection range 0 end
update

puts "PRIMARY von innen:   [selection get -selection PRIMARY]"
puts "PRIMARY über xclip:  [fremdLesen primary]"
if {[catch {clipboard get} m]} {
    puts "CLIPBOARD vorher:    leer ($m)"
} else {
    puts "CLIPBOARD vorher:    $m"
}
event generate .e <<Copy>>
update
puts "CLIPBOARD nachher:   [clipboard get]"
puts "CLIPBOARD über xclip: [fremdLesen clipboard]"
puts "TARGETS:             [selection get -selection CLIPBOARD TARGETS]"
exit 0
