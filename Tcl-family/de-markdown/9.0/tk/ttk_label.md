---
CommandName: ttk::label
title: ttk::label
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

# Name

ttk::label - Textzeichenkette und/oder Bild anzeigen

# Übersicht

::: {.synopsis} :::
[ttk::label]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::label**-Widget zeigt eine Textbeschriftung und/oder ein Bild an. Die Beschriftung kann mit einer Tcl-Variable verknüpft werden, damit sich der angezeigte Text automatisch ändert.

# Standardoptionen

**-anchor**, **-class**, **-compound**, **-cursor**, **-font**, **-foreground**, **-image**, **-justify**, **-padding**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**, **-wraplength**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-background** (**frameColor**/**FrameColor**)
: Hintergrundfarbe des Widgets. Ist sie nicht angegeben, gilt der Theme-Standard.

**-relief** (**relief**/**Relief**)
: Gewünschter 3D-Effekt für den Widget-Rahmen. Gültige Werte: **flat**, **groove**, **raised**, **ridge**, **solid** und **sunken**.

**-wraplength** (**wrapLength**/**WrapLength**)
: Maximale Zeilenlänge in Pixeln. Ist die Option negativ oder null, erfolgt kein automatischer Umbruch; andernfalls wird der Text so geteilt, dass keine Zeile länger als der angegebene Wert ist.


# Widget-Befehl

Label-Widgets unterstützen die Standardbefehle **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe [ttk::widget][ttk_widget]).

# Styling-Optionen

Der Klassenname für ein **ttk::label** ist **TLabel**.

Dynamische Zustände: **disabled**, **readonly**.

**TLabel**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können:

**-background** *color*

**-compound** *compound*

**-foreground** *color*

**-font** *font*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
