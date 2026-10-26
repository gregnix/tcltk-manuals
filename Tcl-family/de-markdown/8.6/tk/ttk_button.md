---
CommandName: ttk::button
title: ttk::button
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - button(n)
Keywords:
 - widget
 - button
 - default
 - command
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::button - Widget, das beim Drücken einen Befehl ausführt

# Übersicht

::: {.synopsis} :::
[ttk::button]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::button**-Widget zeigt eine Textbeschriftung und/oder ein Bild an und wertet beim Drücken einen Befehl aus.

# Standardoptionen

**-class**, **-compound**, **-cursor**, **-image**, **-state**, **-style**, **-takefocus**, **-text**, **-textvariable**, **-underline**, **-width**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Legt ein Skript fest, das ausgewertet wird, wenn das Widget aufgerufen wird.

**-default** (**default**/**Default**)
: Kann auf einen von **normal**, **active** oder **disabled** gesetzt werden. In einem Dialogfeld kann ein Button als „Standard"-Button bezeichnet werden (gemeint ist ungefähr „derjenige, der aufgerufen wird, wenn der Benutzer <Enter> drückt"). **active** bedeutet, dass dies derzeit der Standard-Button ist; **normal** bedeutet, dass er der Standard-Button werden kann, und **disabled** bedeutet, dass er nicht als Standard festgelegt werden kann. Der Standardwert ist **normal**.

    Je nach Theme kann der Standard-Button mit einem zusätzlichen Hervorhebungsring oder mit einer anderen Rahmenfarbe angezeigt werden.


# Widget-Befehl

Zusätzlich zu den Standardbefehlen **cget**, **configure**, **identify**, **instate** und **state** unterstützen Buttons folgende zusätzliche Widget-Befehle:

*pathName* **invoke**
: Ruft den mit dem Button verknüpften Befehl auf.


# Standard-Stile

**Ttk::button**-Widgets unterstützen den Stil **Toolbutton** in allen Standard-Themes, was nützlich ist, um Widgets für Symbolleisten zu erstellen.

# Styling-Optionen

Der Klassenname für ein **ttk::button** ist **TButton**.

Dynamische Zustände: **active**, **disabled**, **pressed**, **readonly**.

**TButton**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-anchor** *anchor*

**-background** *color*

**-bordercolor** *color*

**-compound** *compound*

**-darkcolor** *color*

**-foreground** *color*

**-font** *font*

**-highlightcolor** *color*

**-highlightthickness** *amount*

**-lightcolor** *color*

**-padding** *padding*

**-relief** *relief*

**-shiftrelief** *amount*
: **-shiftrelief** legt fest, wie weit der Button-Inhalt im Zustand *pressed* nach unten und rechts verschoben wird. Diese Aktion liefert zusätzliches skeuomorphes Feedback.


**-width** *amount*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
