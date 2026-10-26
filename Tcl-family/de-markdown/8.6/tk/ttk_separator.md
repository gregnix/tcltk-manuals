---
CommandName: ttk::separator
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

# NAME

ttk::separator - Trennlinie

# ÜBERSICHT

::: {.synopsis} :::
[ttk::separator]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::separator**-Widget zeigt einen horizontalen oder vertikalen Trennstrich an. Standardoptionen (siehe **ttk_widget**): **-class**, **-cursor**, **-style**, **-takefocus**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-orient** (orient/Orient)
: Einer von **horizontal** oder **vertical**. Legt die Ausrichtung des Trennstrichs fest.


# WIDGET-BEFEHL

Separator-Widgets unterstützen die Standardbefehle **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe **ttk_widget**).

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::separator** ist **TSeparator**.

**TSeparator**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können:

**-background** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.
