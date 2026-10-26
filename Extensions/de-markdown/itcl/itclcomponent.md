---
CommandName: component
ManualSection: n
Version: 4.0
TclPart: itcl
TclDescription: "[incr\\ Tcl]"
Keywords:
 - component
 - widget
 - widgetadaptor
 - extendedclass
Copyright:
 - Copyright (c) 2008 Arnulf Wiedemann
---

# NAME

itcl::component - Komponenten für extendedclass, widget oder widgetadaptor definieren

Teile dieser Beschreibung sind von der Tcl-Erweiterung \[snit\] „entliehen“, weil die Funktion weitgehend gleich ist.

# WARNUNG

Das ist neue Funktionalität in \[incr Tcl\], bei der sich die API noch ändern kann!!

# ÜBERSICHT

::: {.synopsis} :::
[public]{.cmd} [component]{.sub} [comp]{.arg} [-inherit]{.optlit} 
[protected]{.cmd} [component]{.sub} [comp]{.arg} [-inherit]{.optlit} 
[private]{.cmd} [component]{.sub} [comp]{.arg} [-inherit]{.optlit} 
:::

# BESCHREIBUNG

Der Befehl **component** wird innerhalb einer Definition extendedclass/widget/widgetadaptor von **\[incr**\\ **Tcl\]** verwendet, um Komponenten zu definieren.

Deklariert ausdrücklich eine Komponente namens comp und definiert automatisch die Instanzvariable der Komponente.

Wenn die Option *-inherit* angegeben ist, werden alle unbekannten Methoden und Optionen an diese Komponente weitergeleitet. Der Name -inherit besagt, dass Instanzen dieses neuen Typs in gewissem Sinn die Methoden und Optionen der Komponente erben. Das heißt, -inherit yes entspricht:

```
component mycomp
delegate option * to mycomp
delegate method * to mycomp
```
