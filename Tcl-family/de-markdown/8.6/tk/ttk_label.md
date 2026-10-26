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

**-class**, **-compound**, **-cursor**, **-image**, **-padding**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-anchor** (**anchor**/**Anchor**)
: Gibt an, wie die Information im Widget relativ zu den inneren Rändern positioniert wird. Gültige Werte sind **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw** und **center**. Siehe auch **-justify**.

**-background** (**frameColor**/**FrameColor**)
: Hintergrundfarbe des Widgets. Ist sie nicht angegeben, gilt der Theme-Standard.

**-font** (**font**/**Font**)
: Schriftart für den Beschriftungstext.

**-foreground** (**textColor**/**TextColor**)
: Vordergrundfarbe des Widgets. Ist sie nicht angegeben, gilt der Theme-Standard.

**-justify** (**justify**/**Justify**)
: Gibt bei mehrzeiligem Text an, wie die Zeilen zueinander ausgerichtet werden. Einer der Werte **left**, **center** oder **right**. Siehe auch **-anchor**.

**-relief** (**relief**/**Relief**)
: Gewünschter 3D-Effekt für den Widget-Rahmen. Gültige Werte: **flat**, **groove**, **raised**, **ridge**, **solid** und **sunken**.

**-wraplength** (**wrapLength**/**WrapLength**)
: Maximale Zeilenlänge in Pixeln. Ist die Option kleiner oder gleich null, erfolgt kein automatischer Umbruch; andernfalls wird der Text so geteilt, dass keine Zeile länger als der angegebene Wert ist.


# Widget-Befehl

Unterstützt die Standard-Widget-Befehle **configure**, **cget**, **identify**, **instate** und **state**; siehe *ttk::widget(n)*.

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
