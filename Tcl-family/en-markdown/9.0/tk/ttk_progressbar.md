---
CommandName: ttk::progressbar
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
Copyright:
 - Copyright (c) 2005 Joe English
---

# Name

ttk::progressbar - Provide progress feedback

# Synopsis

::: {.synopsis} :::
[ttk::progressbar]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# Description

A **ttk::progressbar** widget shows the status of a long-running operation.  They can operate in two modes: *determinate* mode shows the amount completed relative to the total amount of work to be done, and *indeterminate* mode provides an animated display to let the user know that something is happening.

If the value of **-orient** is **horizontal** a text string can be displayed inside the progressbar. This string can be configured using the **-anchor**, **-font**, **-foreground**, **-justify**, **-text** and **-wraplength** options. If the value of **-orient** is **vertical** then these options are ignored.

# Standard options

|   |   |   |   |
| --- | --- | --- | --- |
| **-anchor** | **-class** | **-cursor** |  |
| **-font** | **-foreground** | **-justify** | **-style** |
| **-takefocus** | **-text** | **-wraplength** |  |

See the ttk_widget manual entry for details on the standard options.

# Widget-specific options

**-length** (**length**/**Length**)
: Specifies the length of the long axis of the progress bar (width if horizontal, height if vertical). The value may have any of the forms acceptable to **Tk_GetPixels**.

**-maximum** (**maximum**/**Maximum**)
: A floating point number specifying the maximum **-value**. Defaults to 100.

**-mode** (**mode**/**Mode**)
: One of **determinate** or **indeterminate**.

**-orient** (**orient**/**Orient**)
: One of **horizontal** or **vertical**. Specifies the orientation of the progress bar.

**-phase** (**phase**/**Phase**)
: Read-only option. The widget periodically increments the value of this option whenever the **-value** is greater than 0 and, in *determinate* mode, less than **-maximum**. This option may be used by the current theme to provide additional animation effects.

**-value** (**value**/**Value**)
: The current value of the progress bar. In *determinate* mode, this represents the amount of work completed. In *indeterminate* mode, it is interpreted modulo **-maximum**; that is, the progress bar completes one "cycle" when the **-value** increases by **-maximum**. If **-variable** is set to an existing variable, specifying **-value** has no effect (the variable value takes precedence).

**-variable** (**variable**/**Variable**)
: The name of a global Tcl variable which is linked to the **-value**. If specified to an existing variable, the **-value** of the progress bar is automatically set to the value of the variable whenever the latter is modified.


# Widget command

In addition to the standard **cget**, **configure**, **identify element**, **instate**, **state** and **style** commands (see **ttk::widget**), progressbar widgets support the following additional commands:

*pathName* **start** ?*interval*?
: Begin autoincrement mode: schedules a recurring timer event that calls **step** every *interval* milliseconds. If omitted, *interval* defaults to 50 milliseconds (20 steps/second).

*pathName* **step** ?*amount*?
: Increments the **-value** by *amount*. *amount* defaults to 1.0 if omitted.

*pathName* **stop**
: Stop autoincrement mode: cancels any recurring timer event initiated by *pathName* **start**.


# Styling options

The class name for a **ttk::progressbar** is **TProgressbar**.

**TProgressbar** styling options configurable with **ttk::style** are:

**-background** *color*

**-bordercolor** *color*

**-darkcolor** *color*

**-lightcolor** *color*

**-maxphase**

For the aqua theme.

**-period**

For the aqua theme.

**-troughcolor** *color*

Some options are only available for specific themes.

See the **ttk::style** manual page for information on how to configure ttk styles.
