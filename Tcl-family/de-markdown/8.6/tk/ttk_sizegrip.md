---
CommandName: ttk::sizegrip
title: ttk::sizegrip
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
Keywords:
 - widget
 - sizegrip
 - grow box
Copyright:
 - Copyright (c) 2006 Joe English
---

# Name

ttk::sizegrip - Widget zum Vergrößern in der unteren rechten Ecke

# Übersicht

::: {.synopsis} :::
[ttk::sizegrip]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::sizegrip**-Widget (auch *grow box* genannt) ermöglicht dem Benutzer, das enthaltende Toplevel-Fenster durch Drücken und Ziehen des Griffs zu vergrößern oder zu verkleinern.

# Standardoptionen

**-class**, **-cursor**, **-style**, **-takefocus**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-Befehl

Sizegrip-Widgets unterstützen die Standardmethoden **cget**, **configure**, **identify**, **instate** und **state**. Weitere Widget-Methoden werden nicht verwendet.

# Plattform-Hinweise

Unter macOS enthalten Toplevel-Fenster standardmäßig einen eingebauten Sizegrip. Ein zusätzliches **ttk::sizegrip** ist dort unkritisch, da der eingebaute Griff das Widget einfach überdeckt.

# Beispiele

Mit **pack**:

```
pack [ttk::frame $top.statusbar] -side bottom -fill x
pack [ttk::sizegrip $top.statusbar.grip] -side right -anchor se
```

Mit **grid**:

```
grid [ttk::sizegrip $top.statusbar.grip] \
    -row $lastRow -column $lastColumn -sticky se
# ... optional: vertikale Scrollbar in $lastColumn,
# ... optional: horizontale Scrollbar in $lastRow
```

# Bugs

Wurde die Position des enthaltenden Toplevels relativ zur rechten oder unteren Bildschirmkante angegeben (z. B. „**wm geometry ...** *w*__x__*h*__-__*x*__-__*y*“ statt „**wm geometry ...** *w*__x__*h*__+__*x*__+__*y*“), vergrößert das Sizegrip-Widget das Fenster nicht.

**ttk::sizegrip**-Widgets unterstützen nur die Vergrößerung in Richtung „southeast“.

# Styling-Optionen

Der Klassenname für ein **ttk::sizegrip** ist **TSizegrip**.

**TSizegrip**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-background** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
