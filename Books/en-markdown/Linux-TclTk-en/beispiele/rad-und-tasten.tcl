# rad-und-tasten.tcl -- Mausrad und Modifier unter X11 ohne Handarbeit messen
#
# Braucht ein X11-Display und xdotool. Das Skript schickt echte
# X-Ereignisse (Rad-Tasten 4 bis 7, Strg/Alt/Super+C) an sein eigenes
# Fenster und druckt, welche Bindung greift. Endet selbst.
#
#   wish8.6 rad-und-tasten.tcl
#   wish9.0 rad-und-tasten.tcl
#   xvfb-run -a wish9.0 rad-und-tasten.tcl
#
# Kapitel "Maus, Tastatur, Zwischenablage".

if {[auto_execok xdotool] eq ""} {
    puts "SKIP: xdotool fehlt (Debian: apt install xdotool)"
    exit 0
}

puts "Tk [package provide Tk], [tk windowingsystem]"
wm geometry . 300x200+0+0
label .l -text "Messfenster" -width 30 -height 10
pack .l
update
focus -force .l
update

# --- Mausrad -----------------------------------------------------------
foreach ev {<Button-4> <Button-5> <MouseWheel> <Shift-MouseWheel>} {
    bind .l $ev [list lappend ::rad "$ev b=%b D=%D s=%s"]
}
exec xdotool mousemove 100 100
puts "== Mausrad (xdotool click N)"
foreach b {4 5 6 7} {
    set ::rad {}
    exec xdotool click $b
    after 150
    update
    puts [format "  Taste %d -> %s" $b [join $::rad {; }]]
}
set ::rad {}
event generate .l <Button-4> -x 5 -y 5
update
puts "  event generate <Button-4> -> [join $::rad {; }]"
foreach ev {<Button-4> <Button-5> <MouseWheel> <Shift-MouseWheel>} {
    bind .l $ev {}
}

# --- Modifier ----------------------------------------------------------
puts "== Modifier: welche Bindung greift bei welcher Taste"
foreach m {Control Alt Meta Command Option Mod1 Mod4} {
    set treffer {}
    foreach k {ctrl+c alt+c super+c} {
        bind .l <$m-c> {set ::hit 1}
        set ::hit 0
        exec xdotool key $k
        after 100
        update
        if {$::hit} { lappend treffer $k }
        bind .l <$m-c> {}
    }
    puts [format "  <%s-c> %s" $m [expr {$treffer eq "" ? "-" : $treffer}]]
}
exit 0
