---
CommandName: ttk::separator
title: ttk::separator
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
Keywords:
 - widget
 - separator
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::separator - Trennlinie

# Übersicht

::: {.synopsis} :::
[ttk::separator]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::separator**-Widget zeigt einen horizontalen oder vertikalen Trennstrich an.

# Standardoptionen

**-class**, **-cursor**, **-style**, **-takefocus**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-orient** (**orient**/**Orient**)
: Einer von **horizontal** oder **vertical**. Legt die Ausrichtung des Trennstrichs fest.


# Widget-Befehl

Separator-Widgets unterstützen die Standardbefehle **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe [ttk::widget][ttk_widget]).

# Styling-Optionen

Der Klassenname für ein **ttk::separator** ist **TSeparator**.

**TSeparator**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können:

**-background** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
