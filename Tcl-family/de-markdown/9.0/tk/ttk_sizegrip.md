---
CommandName: ttk::sizegrip
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

# NAME

ttk::sizegrip - Widget zum Vergrößern in der unteren rechten Ecke

# ÜBERSICHT

::: {.synopsis} :::
[ttk::sizegrip]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::sizegrip**-Widget (auch *grow box* genannt) ermöglicht dem Benutzer, das enthaltende Toplevel-Fenster durch Drücken und Ziehen des Griffs zu vergrößern oder zu verkleinern. Standardoptionen (siehe **ttk_widget**): **-class**, **-cursor**, **-style**, **-takefocus**.

# WIDGET-BEFEHL

Sizegrip-Widgets unterstützen die Standardbefehle **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe **ttk::widget**).

# PLATTFORM-HINWEISE

Unter macOS enthalten Toplevel-Fenster standardmäßig einen eingebauten Sizegrip. Ein zusätzliches **ttk::sizegrip** ist dort unkritisch, da der eingebaute Griff das Widget einfach überdeckt.

# BEISPIELE

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

# BUGS

Wurde die Position des enthaltenden Toplevels relativ zur rechten oder unteren Bildschirmkante angegeben (z. B. „**wm geometry ...** *w*__x__*h*__-__*x*__-__*y*“ statt „**wm geometry ...** *w*__x__*h*__+__*x*__+__*y*“), vergrößert das Sizegrip-Widget das Fenster nicht.

**ttk::sizegrip**-Widgets unterstützen nur die Vergrößerung in Richtung „southeast“.

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::sizegrip** ist **TSizegrip**.

**TSizegrip**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können, sind:

**-background** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.

