---
CommandName: widget_toolbar
title: widget_toolbar
ManualSection: n
Version: 3.0
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - megawidget
 - snit
 - toolbar
 - widget
Copyright:
---

# Name

widget\_toolbar – Toolbar-Megawidget

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.0]{.optlit}
[package]{.cmd} [require]{.sub} [widget::toolbar]{.lit} [1.0]{.optlit}
[widget::toolbar]{.cmd} [pathname]{.arg} [options]{.optarg}
:::

getframe

add ?item? ?args?

delete item1 ?item2? ?...?

itemcget symbol option

itemconfigure symbol ?args?

items ?pattern?

remove ?-destroy? item1 ?item2? ?...?

# Beschreibung

Dieses Paket stellt ein Toolbar-Megawidget (snidget) bereit. Es nutzt den thematisierten Widget-Satz von Tile/Ttk.

- **widget::toolbar** *pathname* ?options?
- getframe
- add ?item? ?args?
- delete item1 ?item2? ?...?
- itemcget symbol option
- itemconfigure symbol ?args?
- items ?pattern?
- remove ?-destroy? item1 ?item2? ?...?


# Widget-Optionen

- **-ipad**
- **-pad**
- **-separator**


# Element-Optionen

- **-pad**
- **-separator**
- **-sticky**
- **-weight**


# Beispiel

```
package require widget::toolbar ; # or widget::all
set t [widget::toolbar .t]
pack $t -fill x -expand 1
$t add button [button .b -text foo]
$t add separator -pad {2 4}
$t add button [button .c -text bar]
```

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widget::toolbar* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Widget
