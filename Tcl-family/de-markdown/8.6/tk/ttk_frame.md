---
CommandName: ttk::frame
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::labelframe(n)
 - frame(n)
Keywords:
 - widget
 - frame
 - container
Copyright:
 - Copyright (c) 2005 Joe English
---

# NAME

ttk::frame - Einfaches Container-Widget

# ÜBERSICHT

::: {.synopsis} :::
[ttk::frame]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::frame**-Widget ist ein Container zum Gruppieren anderer Widgets. Standardoptionen (siehe **ttk_widget**): **-class**, **-cursor**, **-padding**, **-style**, **-takefocus**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-borderwidth** (borderWidth/BorderWidth)
: Gewünschte Breite des Widget-Rahmens. Standard ist 0. Je nach Theme kann die Option ignoriert werden.

**-relief** (relief/Relief)
: Einer der Standard-Tk-Rahmenstile: **flat**, **groove**, **raised**, **ridge**, **solid** oder **sunken**. Standard ist **flat**.

**-width** (width/Width)
: Legt bei Angabe die gewünschte Widget-Breite in Pixeln fest.

**-height** (height/Height)
: Ist angegeben, die gewünschte Widget-Höhe in Pixeln.


# WIDGET-BEFEHL

Frame-Widgets unterstützen die Standardbefehle **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe **ttk::widget**).

# HINWEISE

Werden **pack**, **grid** oder andere Geometrie-Manager für die Kinder des **frame** verwendet, hat die vom Manager gewünschte Größe meist Vorrang vor den Optionen **-width** und **-height** des **frame**. Mit **pack propagate** und **grid propagate** lässt sich das ändern.

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::frame** ist **TFrame**.

**TFrame**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können:

**-background** *color* .br **-relief** *relief*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.

# BINDINGS

Beim Erzeugen eines neuen **ttk::frame** gibt es keine Standard-Ereignis-Bindings; **ttk::frame**-Widgets sind nicht für Interaktion gedacht.
