---
CommandName: ttk::spinbox
title: ttk::spinbox
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::entry(n)
 - spinbox(n)
Keywords:
 - entry
 - spinbox
 - widget
 - text field
Copyright:
 - Copyright (c) 2008 Pat Thoyts
---

# Name

ttk::spinbox - Widget mit auswählbarem Textfeld

# Übersicht

::: {.synopsis} :::
[ttk::spinbox]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::spinbox**-Widget ist ein [ttk::entry][ttk_entry]-Widget mit eingebauten Auf- und Ab-Schaltflächen, mit denen entweder ein numerischer Wert geändert oder aus einer Menge von Werten ausgewählt werden kann. Das Widget implementiert alle Funktionen des [ttk::entry][ttk_entry]-Widgets, einschließlich der Unterstützung der Option **-textvariable**, um den angezeigten Wert mit einer Tcl-Variable zu verknüpfen.

# Standardoptionen

**-class**, **-cursor**, **-state**, **-style**, **-takefocus**, **-xscrollcommand**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

**-validate**, **-validatecommand**

Siehe die Handbuchseite [ttk\_entry][ttk_entry] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Legt ein Tcl-Skript fest, das ausgewertet wird, wenn eine Spin-Schaltfläche betätigt wird.

**-format** (**format**/**Format**)
: Legt ein alternatives Format fest, das beim Setzen des Zeichenkettenwerts im Bereich **-from** und **-to** verwendet wird. Es muss ein Formatbezeichner der Form **%<pad>.<pad>f** sein, da damit eine Gleitkommazahl formatiert wird.

**-from** (**from**/**From**)
: Gleitkommazahl für den kleinsten Wert der Spinbox. Wird zusammen mit **-to** und **-increment** verwendet, um einen numerischen Bereich festzulegen.

**-increment** (**increment**/**Increment**)
: Gleitkommazahl für die Wertänderung bei jedem Drücken einer Spin-Schaltfläche. Die Auf-Schaltfläche wendet ein positives Inkrement an, die Ab-Schaltfläche ein negatives.

**-to** (**to**/**To**)
: Gleitkommazahl für den höchsten zulässigen Wert des Widgets. Siehe auch **-from** und **-increment**.

**-values** (**values**/**Values**)
: Muss eine Tcl-Liste von Werten sein. Ist diese Option gesetzt, überschreibt sie jeden mit **-from**, **-to** und **-increment** festgelegten Bereich; das Widget verwendet stattdessen die angegebenen Werte, beginnend mit dem ersten.

**-wrap** (**wrap**/**Wrap**)
: Muss ein gültiger boolescher Wert sein. Ist er an, springt die Spinbox an den Enden der Daten im Widget um.


# Indizes

Siehe die Handbuch-Seite [ttk::entry][ttk_entry] für Informationen zur Indizierung von Zeichen.

# Validierung

Siehe die Handbuch-Seite [ttk::entry][ttk_entry] für Informationen zur Verwendung der Optionen **-validate** und **-validatecommand**.

# Widget-Befehl

Für Spinbox-Widgets sind zusätzlich zu den in der Handbuch-Seite [ttk::entry][ttk_entry] beschriebenen Befehlen folgende Unterbefehle möglich:

*pathName* **get**
: Gibt den aktuellen Wert der Spinbox zurück.

*pathName* **set** *value*
: Setzt die Zeichenkette der Spinbox auf *value*. Ist die Option **-format** konfiguriert, wird dieses Format angewendet. Schlägt die Formatierung fehl, ist keine Formatierung gesetzt oder wurde die Option **-values** verwendet, wird der Wert direkt gesetzt.


# Virtuelle Ereignisse

Das Spinbox-Widget erzeugt ein virtuelles Ereignis **<<Increment>>**, wenn der Benutzer <Up> drückt, und ein virtuelles Ereignis **<<Decrement>>**, wenn er <Down> drückt.

# Styling-Optionen

Der Klassenname für ein **ttk::spinbox** ist **TSpinbox**.

Dynamische Zustände: **active**, **disabled**, **focus**, **readonly**.

**TSpinbox**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-arrowcolor** *color*

**-arrowsize** *amount*

**-background** *color*
: Aus Kompatibilitätsgründen verhält sich diese Option beim Aqua-Theme (für macOS) als Alias für **-fieldbackground**, sofern für **-fieldbackground** kein Wert angegeben ist; andernfalls wird sie ignoriert.


**-bordercolor** *color*

**-darkcolor** *color*

**-fieldbackground** *color*

**-foreground** *color*

**-insertcolor** *color*

**-insertwidth** *amount*

**-lightcolor** *color*

**-padding** *padding*

**-selectbackground** *color*

**-selectforeground** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_entry]: ttk_entry.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
