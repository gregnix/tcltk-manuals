---
CommandName: ttk::checkbutton
title: ttk::checkbutton
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::radiobutton(n)
 - checkbutton(n)
Keywords:
 - widget
 - button
 - toggle
 - check
 - option
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::checkbutton - Ein/Aus-Widget

# Übersicht

::: {.synopsis} :::
[ttk::checkbutton]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::checkbutton**-Widget zeigt eine Einstellung an oder ändert sie. Es hat zwei Zustände: ausgewählt und abgewählt. Der Zustand kann mit einer Tcl-Variable verknüpft sein.

# Standardoptionen

**-class**, **-compound**, **-cursor**, **-image**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Tcl-Skript bei jedem Aufruf des Widgets.

**-offvalue** (**offValue**/**OffValue**)
: Wert in der zugehörigen **-variable**, wenn das Widget abgewählt ist. Standard **0**.

**-onvalue** (**onValue**/**OnValue**)
: Wert in der zugehörigen **-variable**, wenn das Widget ausgewählt ist. Standard **1**.

**-variable** (**variable**/**Variable**)
: Name einer globalen Variable, deren Wert mit dem Widget verknüpft ist. Standard ist der Widget-Pfadname, falls nicht angegeben.


# Widget-Befehl

Zusätzlich zu den Standardbefehlen **cget**, **configure**, **identify**, **instate** und **state** unterstützen Checkbuttons folgende zusätzliche Widget-Befehle:

*pathname* **invoke**
: Wechselt zwischen ausgewählt und abgewählt und wertet **-command** aus. Ist das Widget ausgewählt, setzt **-variable** auf **-offvalue** und wählt ab; andernfalls **-onvalue**. Liefert das Ergebnis von **-command**.


# Widget-Zustände

Bei **disabled** reagiert das Widget nicht auf Benutzereingaben. **selected** wird gesetzt, wenn **-variable** dem **-onvalue** entspricht, sonst gelöscht. **alternate** wird gesetzt, wenn **-variable** nicht gesetzt ist (Drei-Zustand / unbestimmt).

# Standardstile

**Ttk::checkbutton**-Widgets unterstützen in allen Standard-Themes den Stil **Toolbutton** — nützlich für Symbolleisten.

# Styling-Optionen

Der Klassenname für ein **ttk::checkbutton** ist **TCheckbutton**.

Dynamische Zustände: **active**, **alternate**, **disabled**, **pressed**, **selected**, **readonly**.

**TCheckbutton**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können:

**-background** *color*

**-compound** *compound*

**-foreground** *color*

**-indicatorbackground** *color*

**-indicatorcolor** *color*

**-indicatormargin** *padding*

**-indicatorrelief** *relief*

**-padding** *padding*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
