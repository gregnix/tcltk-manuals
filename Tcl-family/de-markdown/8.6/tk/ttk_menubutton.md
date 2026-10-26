---
CommandName: ttk::menubutton
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

# NAME

ttk::menubutton - Widget, das beim Drücken ein Menü öffnet

# ÜBERSICHT

::: {.synopsis} :::
[ttk::menubutton]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::menubutton**-Widget zeigt eine Textbeschriftung und/oder ein Bild und öffnet beim Drücken ein Menü. Standardoptionen (siehe **ttk_widget**): **-class**, **-compound**, **-cursor**, **-image**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-direction** (direction/Direction)
: Gibt an, wo das Menü relativ zum Menubutton geöffnet wird. Einer von: **above**, **below**, **left**, **right** oder **flush**. Standard ist **below**. **flush** öffnet das Menü direkt über dem Menubutton.

**-menu** (menu/Menu)
: Pfadname des zugehörigen Menüs. Zur Sicherheit sollte das Menü ein direktes Kind des Menubuttons sein.


# WIDGET-BEFEHL

Menubutton-Widgets unterstützen die Standardbefehle **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe **ttk_widget**).

# STANDARD-STILE

**Ttk::menubutton**-Widgets unterstützen in allen Standard-Themes den Stil **Toolbutton** — nützlich für Symbolleisten.

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::menubutton** ist **TMenubutton**.

Dynamische Zustände: **active**, **disabled**, **readonly**.

**TMenubutton**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können:

**-arrowsize** *amount* .br **-background** *color* .br **-compound** *compound* .br **-foreground** *color* .br **-font** *font* .br **-padding** *padding* .br **-relief** *relief* .br **-width** *amount*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.
