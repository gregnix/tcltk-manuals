---
CommandName: eval
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - catch(n)
 - concat(n)
 - error(n)
 - errorCode(n)
 - errorInfo(n)
 - interp(n)
 - list(n)
 - namespace(n)
 - subst(n)
 - uplevel(n)
Keywords:
 - concatenate
 - evaluate
 - script
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

eval - Wertet ein Tcl-Skript aus

# ÜBERSICHT

::: {.synopsis} :::
[eval]{.cmd} [arg]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

**eval** nimmt ein oder mehrere Argumente, die zusammen ein Tcl-Skript mit einem oder mehreren Befehlen bilden. **eval** verkettet alle Argumente wie **concat**, übergibt die Zeichenkette rekursiv an den Tcl-Interpreter und gibt das Auswertungsergebnis (oder einen dabei erzeugten Fehler) zurück.

Der Befehl **list** quotiert Wortfolgen so, dass **eval** sie nicht weiter aufsplittet.

# BEISPIELE

Oft speichert man ein Skriptfragment in einer Variable und führt es später mit angehängten Werten aus (z. B. in **fcopy**, **lsort**, **trace**-Callbacks):

```
set script {
    puts "logging now"
    lappend $myCurrentLogVar
}
set myCurrentLogVar log1
# Logging-Variable nach 20 s umschalten
after 20000 set myCurrentLogVar log2

for {set i 0} {$i<10} {incr i} {
    after [expr {int(5000 * rand())}]
    update    ;# asynchronen Log-Wechsel prüfen
    eval $script $i [clock clicks]
}
```

Ist das Fragment nur ein Befehlspräfix (Liste von Wörtern), ist **{*}$script** meist robuster als **eval**. Eine Prozedur analog zu **lappend**, die Argumente am Listenanfang einfügt:

```
proc lprepend {varName args} {
    upvar 1 $varName var
    lappend var
    set var [eval [list linsert $var 0] $args]
}
```

Heute üblicher ohne **eval**:

```
set var [linsert $var 0 {*}$args]
```
