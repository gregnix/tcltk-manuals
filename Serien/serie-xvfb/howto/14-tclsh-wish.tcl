#!/usr/bin/env wish
source [file join [file dirname [info script]] .. _bootstrap.tcl]

# Vor shell: noch kein update gelaufen
set ::serie::map0 [winfo ismapped .]

serie::shell "14 tclsh wish" {
    set ::serie::exe [file tail [info nameofexecutable]]
    set ::serie::hasTk [expr {[info commands tk] ne ""}]
    ttk::label .f.l -text "exe=$::serie::exe Tk=$::serie::hasTk"
    pack .f.l -anchor w
    set ::serie::status "exe=$::serie::exe"
} {
    serie::assert {$::serie::hasTk} "Tk geladen"
    serie::assert {!$::serie::map0} ". beim Skriptlauf noch nicht gemappt"
    serie::assert {[winfo ismapped .]} "nach update gemappt"
}
