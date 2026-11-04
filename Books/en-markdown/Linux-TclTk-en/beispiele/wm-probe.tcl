# wm-probe.tcl -- was der Fenstermanager beisteuert
#
# Misst Fokus nach update, Rahmenhöhe, wm frame gegen winfo id,
# Iconify, Vollbild und WM_CLASS. Endet selbst.
#
#   wish9.0 wm-probe.tcl
#   xvfb-run -a wish9.0 wm-probe.tcl                    ;# ohne WM
#   xvfb-run -a sh -c 'openbox & sleep 1; wish9.0 wm-probe.tcl'
#
# Kapitel "X11, Fenstermanager und Wayland" und "GUI-Tests mit Xvfb".

wm title . WmProbe
wm geometry . 300x200+30+40
update
puts "Tk [package provide Tk], Display [winfo screen .]"
puts "focus nach update:     '[focus]'"
scan [wm geometry .] {%dx%d+%d+%d} w h gx gy
puts "wm geometry:           [wm geometry .]"
puts "rooty - gy (Rahmen):   [expr {[winfo rooty .] - $gy}]"
set rahmen [expr {[wm frame .] != [winfo id .]}]
puts "wm frame / winfo id:   [wm frame .] / [winfo id .] -> Rahmen=$rahmen"

set t0 [clock milliseconds]
wm iconify .
update
puts "wm iconify:            [wm state .] nach [expr {[clock milliseconds] - $t0}] ms"
wm deiconify .
update

bind . <Key-x> {set ::taste 1}
set ::taste 0
event generate . <Key-x>
update
puts "Taste ohne focus -force: $::taste"
focus -force .
update
event generate . <Key-x>
update
puts "Taste mit focus -force:  $::taste"

wm attributes . -fullscreen 1
update
after 300
update
puts "-fullscreen 1:         Attribut [wm attributes . -fullscreen], [wm geometry .]"

if {[auto_execok xdotool] ne "" && [auto_execok xprop] ne ""} {
    foreach id [exec xdotool search --name WmProbe] {
        puts "WM_CLASS:              [exec xprop -id $id WM_CLASS]"
    }
}
exit 0
