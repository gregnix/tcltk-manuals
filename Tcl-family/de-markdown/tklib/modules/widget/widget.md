---
CommandName: widget
title: widget
ManualSection: n
Version: 3.2
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - bundle
 - calendar
 - dateentry
 - dialog
 - megawidget
 - menu
 - panelframe
 - ruler
 - screenruler
 - scrolledwindow
 - snit
 - statusbar
 - superframe
 - toolbar
 - widget
Copyright:
---

# Name

widget – Megawidget-Bündel

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[widget::validate]{.cmd} [as]{.arg} [options]{.optarg}
[widget::calendar]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::dateentry]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::dialog]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::menuentry]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::panelframe]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::ruler]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::screenruler]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::scrolledwindow]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::statusbar]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::superframe]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::toolbar]{.cmd} [pathname]{.arg} [options]{.optarg}
:::

# Beschreibung

Dieses Paket stellt Megawidgets bereit, die auf dem snit-OO-System (snidgets) basieren. Es nutzt den thematisierten Widget-Satz von Tile/Ttk.

**widget::validate** *as* ?options?
: Befehle:


# Widgets

**widget::calendar** *pathname* ?options?
: Optionen:

**widget::dateentry** *pathname* ?options?
: Optionen:

**widget::dialog** *pathname* ?options?
: Optionen:

**widget::menuentry** *pathname* ?options?
: Optionen:

**widget::panelframe** *pathname* ?options?
: Optionen:

**widget::ruler** *pathname* ?options?
: Optionen:

**widget::screenruler** *pathname* ?options?
: Optionen:

**widget::scrolledwindow** *pathname* ?options?
: Optionen:

**widget::statusbar** *pathname* ?options?
: Optionen:

**widget::superframe** *pathname* ?options?
: Optionen:

**widget::toolbar** *pathname* ?options?
: Optionen:


# Beispiel

```
package require widget::superframe ; # or widget::all
pack [widget::superframe .f -type separator -text "SuperFrame:"]
```

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widget* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Widget
