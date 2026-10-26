---
CommandName: ttk::frame
title: ttk::frame
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

# Name

ttk::frame - Einfaches Container-Widget

# Übersicht

::: {.synopsis} :::
[ttk::frame]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::frame**-Widget ist ein Container zum Gruppieren anderer Widgets.

# Standardoptionen

**-class**, **-cursor**, **-padding**, **-style**, **-takefocus**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-borderwidth** (**borderWidth**/**BorderWidth**)
: Gewünschte Breite des Widget-Rahmens. Standard ist 0. Je nach Theme kann die Option ignoriert werden.

**-relief** (**relief**/**Relief**)
: Einer der Standard-Tk-Rahmenstile: **flat**, **groove**, **raised**, **ridge**, **solid** oder **sunken**. Standard ist **flat**.

**-width** (**width**/**Width**)
: Legt bei Angabe die gewünschte Widget-Breite in Pixeln fest.

**-height** (**height**/**Height**)
: Ist angegeben, die gewünschte Widget-Höhe in Pixeln.


# Widget-Befehl

Unterstützt die Standard-Widget-Befehle **configure**, **cget**, **identify**, **instate** und **state**; siehe *ttk::widget(n)*.

# Hinweise

Werden [pack], [grid] oder andere Geometrie-Manager für die Kinder des [frame] verwendet, hat die vom Manager gewünschte Größe meist Vorrang vor den Optionen **-width** und **-height** des [frame]. Mit [pack propagate][pack] und [grid propagate][grid] lässt sich das ändern.

# Styling-Optionen

Der Klassenname für ein **ttk::frame** ist **TFrame**.

**TFrame**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können:

**-background** *color*

**-relief** *relief*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.

# Bindings

Beim Erzeugen eines neuen **ttk::frame** gibt es keine Standard-Ereignis-Bindings; **ttk::frame**-Widgets sind nicht für Interaktion gedacht.


[frame]: frame.md
[grid]: grid.md
[pack]: pack.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
