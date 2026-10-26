---
CommandName: ttk::menubutton
title: ttk::menubutton
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - menu(n)
 - menubutton(n)
Keywords:
 - widget
 - button
 - menu
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::menubutton - Widget, das beim Drücken ein Menü öffnet

# Übersicht

::: {.synopsis} :::
[ttk::menubutton]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::menubutton**-Widget zeigt eine Textbeschriftung und/oder ein Bild und öffnet beim Drücken ein Menü.

# Standardoptionen

**-class**, **-compound**, **-cursor**, **-image**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-direction** (**direction**/**Direction**)
: Gibt an, wo das Menü relativ zum Menubutton geöffnet wird. Einer von: **above**, **below**, **left**, **right** oder **flush**. Standard ist **below**. **flush** öffnet das Menü direkt über dem Menubutton.

**-menu** ([menu]/**Menu**)
: Pfadname des zugehörigen Menüs. Zur Sicherheit sollte das Menü ein direktes Kind des Menubuttons sein.


# Widget-Befehl

Menubutton-Widgets unterstützen die Standardmethoden **cget**, **configure**, **identify**, **instate** und **state**. Weitere Widget-Methoden werden nicht verwendet.

# Standard-Stile

**Ttk::menubutton**-Widgets unterstützen in allen Standard-Themes den Stil **Toolbutton** — nützlich für Symbolleisten.

# Styling-Optionen

Der Klassenname für ein **ttk::menubutton** ist **TMenubutton**.

Dynamische Zustände: **active**, **disabled**, **readonly**.

**TMenubutton**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können:

**-arrowsize** *amount*

**-background** *color*

**-compound** *compound*

**-foreground** *color*

**-font** *font*

**-padding** *padding*

**-relief** *relief*

**-width** *amount*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[menu]: menu.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
