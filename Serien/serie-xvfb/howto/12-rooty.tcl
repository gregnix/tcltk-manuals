#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

serie::shell "12 rooty" {
    wm geometry . 360x220+30+40
    update
    set ry [winfo rooty .]
    toplevel .dlg
    wm geometry .dlg +30+${ry}
    update
    set ::serie::used $ry
    set ::serie::got [winfo rooty .dlg]
    set ::serie::dlgGeo [wm geometry .dlg]
    set ::serie::rahmen [serie::wmRahmen]
    destroy .dlg
    ttk::label .f.l -text "rooty=$ry dlg=$::serie::got"
    pack .f.l -anchor w
    set ::serie::status "used=$::serie::used got=$::serie::got"
} {
    serie::assert {[string match *+30+$::serie::used $::serie::dlgGeo]} "Rahmenecke des Dialogs = rooty des Owners"
    if {$::serie::rahmen} {
        serie::assert {$::serie::got >= $::serie::used} "Client des Dialogs unter seiner Titelleiste"
    } else {
        serie::assert {$::serie::got == $::serie::used} "ohne Rahmen exakt"
    }
}
