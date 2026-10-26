---
CommandName: widget_toolbar
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

# NAME

widget_toolbar – Toolbar-Megawidget

# ÜBERSICHT

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

# BESCHREIBUNG

Dieses Paket stellt ein Toolbar-Megawidget (snidget) bereit. Es nutzt den thematisierten Widget-Satz von Tile/Ttk.

**widget::toolbar** *pathname* ?options?
: ...siehe nächstes...

**getframe**
: ...siehe nächstes...

**add ?item? ?args?**
: ...siehe nächstes...

**delete item1 ?item2? ?...?**
: ...siehe nächstes...

**itemcget symbol option**
: ...siehe nächstes...

**itemconfigure symbol ?args?**
: ...siehe nächstes...

**items ?pattern?**
: ...siehe nächstes...

**remove ?-destroy? item1 ?item2? ?...?**
: 


# WIDGET-OPTIONEN

**-ipad**
: ...siehe nächstes...

**-pad**
: ...siehe nächstes...

**-separator**
: 


# ELEMENT-OPTIONEN

**-pad**
: ...siehe nächstes...

**-separator**
: ...siehe nächstes...

**-sticky**
: ...siehe nächstes...

**-weight**
: 


# BEISPIEL

```
package require widget::toolbar ; # or widget::all
set t [widget::toolbar .t]
pack $t -fill x -expand 1
$t add button [button .b -text foo]
$t add separator -pad {2 4}
$t add button [button .c -text bar]
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widget::toolbar* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Widget
