# spaeter-rahmen.tcl -- ein Fenstermanager, der seinen Rahmen spät anlegt
#
# Setzt einen Dialog mittig über das Hauptfenster und verschiebt ihn
# 300 ms später um 5 und 29 Pixel, wie es ein später Rahmen tut.
# Geprüft wird nach 600 ms, einmal mit einer einzigen Korrektur nach
# 100 ms, einmal mit Beobachtung über <Configure>. Endet selbst.
#
#   xvfb-run -a wish9.0 spaeter-rahmen.tcl              ;# ohne WM
#   xvfb-run -a sh -c 'openbox & sleep 1; wish9.0 spaeter-rahmen.tcl'
#
# Kapitel "Was der Test selbst herstellt".
package require Tk

proc mitte {w} {
    list [expr {[winfo rootx $w] + [winfo width $w] / 2}] \
         [expr {[winfo rooty $w] + [winfo height $w] / 2}]
}

proc setzen {d} {
    update idletasks
    lassign [mitte .] mx my
    set x [expr {$mx - [winfo reqwidth $d] / 2}]
    set y [expr {$my - [winfo reqheight $d] / 2}]
    set ::ziel($d) [list $x $y]
    wm geometry $d +$x+$y
}

# Rahmenecke so setzen, dass die Clientfläche am Ziel liegt
proc korrigieren {d} {
    lassign $::ziel($d) x y
    regexp {\+(-?\d+)\+(-?\d+)$} [wm geometry $d] -> fx fy
    set dx [expr {[winfo rootx $d] - $x}]
    set dy [expr {[winfo rooty $d] - $y}]
    if {abs($dx) > 1 || abs($dy) > 1} {
        wm geometry $d +[expr {$fx - $dx}]+[expr {$fy - $dy}]
    }
}

proc lauf {art} {
    destroy .d
    toplevel .d
    label .d.l -text Dialog -padx 60 -pady 30
    pack .d.l
    wm transient .d .
    setzen .d
    update
    if {$art eq "einmal"} {
        after 100 [list korrigieren .d]
    } else {
        bind .d <Configure> {
            if {"%W" eq ".d"} {
                after cancel [list korrigieren .d]
                after 50 [list korrigieren .d]
            }
        }
        after 1000 {bind .d <Configure> {}}
    }
    # der späte Rahmen
    after 300 {
        regexp {\+(-?\d+)\+(-?\d+)$} [wm geometry .d] -> fx fy
        wm geometry .d +[expr {$fx + 5}]+[expr {$fy + 29}]
    }
    after 600 {set ::fertig 1}
    vwait ::fertig
    lassign [mitte .d] dx dy
    lassign [mitte .] px py
    puts [format "%-10s Abstand der Mitten: %d,%d" $art \
        [expr {$dx - $px}] [expr {$dy - $py}]]
}

wm geometry . 600x400+200+150
update
lauf einmal
lauf beobachten
exit
