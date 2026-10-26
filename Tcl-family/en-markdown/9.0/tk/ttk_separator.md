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

# Name

ttk::separator - Separator bar

# Synopsis

::: {.synopsis} :::
[ttk::separator]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# Description

A **ttk::separator** widget displays a horizontal or vertical separator bar.

# Standard options

|   |   |
| --- | --- |
| **-class** | **-cursor** |
| **-style** | **-takefocus** |

See the ttk_widget manual entry for details on the standard options.

# Widget-specific options

**-orient** (**orient**/**Orient**)
: One of **horizontal** or **vertical**. Specifies the orientation of the separator.


# Widget command

Separator widgets support the standard commands **cget**, **configure**, **identify element**, **instate**, **state** and **style** (see **ttk::widget**).

# Styling options

The class name for a **ttk::separator** is **TSeparator**.

**TSeparator** styling options configurable with **ttk::style** are:

**-background** *color*

Some options are only available for specific themes.

See the **ttk::style** manual page for information on how to configure ttk styles.
