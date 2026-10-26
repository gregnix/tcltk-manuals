---
CommandName: ttk::label
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - label(n)
Copyright:
 - Copyright (c) 2004 Joe English
---

# NAME

ttk::label - Textzeichenkette und/oder Bild anzeigen

# ÜBERSICHT

::: {.synopsis} :::
[ttk::label]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::label**-Widget zeigt eine Textbeschriftung und/oder ein Bild an. Die Beschriftung kann mit einer Tcl-Variable verknüpft werden, damit sich der angezeigte Text automatisch ändert. Standardoptionen (siehe **ttk_widget**): **-anchor**, **-class**, **-compound**, **-cursor**, **-font**, **-foreground**, **-image**, **-justify**, **-padding**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**, **-wraplength**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-background** (frameColor/FrameColor)
: Hintergrundfarbe des Widgets. Ist sie nicht angegeben, gilt der Theme-Standard.

**-relief** (relief/Relief)
: Gewünschter 3D-Effekt für den Widget-Rahmen. Gültige Werte: **flat**, **groove**, **raised**, **ridge**, **solid** und **sunken**.

**-wraplength** (wrapLength/WrapLength)
: Maximale Zeilenlänge in Pixeln. Ist die Option negativ oder null, erfolgt kein automatischer Umbruch; andernfalls wird der Text so geteilt, dass keine Zeile länger als der angegebene Wert ist.


# WIDGET-BEFEHL

Label-Widgets unterstützen die Standardbefehle **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe **ttk::widget**).

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::label** ist **TLabel**.

Dynamische Zustände: **disabled**, **readonly**.

**TLabel**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können:

**-background** *color* .br **-compound** *compound* .br **-foreground** *color* .br **-font** *font*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.
