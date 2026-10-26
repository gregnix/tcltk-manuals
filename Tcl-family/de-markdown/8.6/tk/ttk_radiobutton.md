---
CommandName: ttk::radiobutton
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::checkbutton(n)
 - radiobutton(n)
Keywords:
 - widget
 - button
 - option
Copyright:
 - Copyright (c) 2004 Joe English
---

# NAME

ttk::radiobutton - Widget für sich gegenseitig ausschließende Optionen

# ÜBERSICHT

::: {.synopsis} :::
[ttk::radiobutton]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

**ttk::radiobutton**-Widgets werden in Gruppen verwendet, um eine Menge sich gegenseitig ausschließender Optionen anzuzeigen oder zu ändern. Radiobuttons sind mit einer Tcl-Variable verknüpft und haben einen zugehörigen Wert; beim Klick setzt ein Radiobutton die Variable auf diesen Wert. Standardoptionen (siehe **ttk_widget**): **-class**, **-compound**, **-cursor**, **-image**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-command** (command/Command)
: Tcl-Skript, das bei jedem Aufruf des Widgets ausgewertet wird.

**-value** (Value/Value)
: Wert, der in der zugehörigen **-variable** gespeichert wird, wenn das Widget ausgewählt ist.

**-variable** (variable/Variable)
: Name einer globalen Variable, deren Wert mit dem Widget verknüpft ist. Standard ist **::selectedButton**.


# WIDGET-BEFEHL

Zusätzlich zu **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe **ttk_widget**) unterstützen Radiobutton-Widgets:

*pathname* **invoke**
: Setzt **-variable** auf **-value**, wählt das Widget aus und wertet **-command** aus. Liefert das Ergebnis von **-command** oder einen leeren String, wenn kein **-command** angegeben ist.


# WIDGET-ZUSTÄNDE

Bei gesetztem Zustand **disabled** reagiert das Widget nicht auf Benutzereingaben. Der Zustand **selected** wird gesetzt, wenn die verknüpfte **-variable** dem **-value** des Widgets entspricht, sonst gelöscht. Der Zustand **alternate** wird gesetzt, wenn die verknüpfte **-variable** nicht gesetzt ist (**alternate** kann eine „Drei-Zustand“- oder unbestimmte Auswahl anzeigen).

# STANDARD-STILE

**Ttk::radiobutton**-Widgets unterstützen in allen Standard-Themes den Stil **Toolbutton** — nützlich für Symbolleisten.

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::radiobutton** ist **TRadiobutton**.

Dynamische Zustände: **active**, **alternate**, **disabled**, **pressed**, **readonly**, **selected**.

**TRadiobutton**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können:

**-background** *color* .br **-compound** *compound* .br **-foreground** *color* .br **-indicatorbackground** *color* .br **-indicatorcolor** *color* .br **-indicatormargin** *padding* .br **-indicatorrelief** *relief* .br **-padding** *padding*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.
