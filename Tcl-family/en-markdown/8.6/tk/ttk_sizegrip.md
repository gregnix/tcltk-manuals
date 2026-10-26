---
CommandName: ttk::sizegrip
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
Keywords:
 - widget
 - sizegrip
 - grow box
Copyright:
 - Copyright (c) 2006 Joe English
---

# Name

ttk::sizegrip - Bottom-right corner resize widget

# Synopsis

::: {.synopsis} :::
[ttk::sizegrip]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# Description

A **ttk::sizegrip** widget (also known as a *grow box*) allows the user to resize the containing toplevel window by pressing and dragging the grip.

# Standard options

|   |   |
| --- | --- |
| **-class** | **-cursor** |
| **-style** | **-takefocus** |

See the ttk_widget manual entry for details on the standard options.

# Widget command

Sizegrip widgets support the standard **cget**, **configure**, **identify**, **instate**, and **state** methods.  No other widget methods are used.

# Platform-specific notes

On macOS, toplevel windows automatically include a built-in size grip by default. Adding a **ttk::sizegrip** there is harmless, since the built-in grip will just mask the widget.

# Examples

Using pack:

```
pack [ttk::frame $top.statusbar] -side bottom -fill x
pack [ttk::sizegrip $top.statusbar.grip] -side right -anchor se
```

Using grid:

```
grid [ttk::sizegrip $top.statusbar.grip] \
    -row $lastRow -column $lastColumn -sticky se
# ... optional: add vertical scrollbar in $lastColumn,
# ... optional: add horizontal scrollbar in $lastRow
```

# Bugs

If the containing toplevel's position was specified relative to the right or bottom of the screen (e.g., "**wm geometry ...** *w*__x__*h*__-__*x*__-__*y*" instead of "**wm geometry ...** *w*__x__*h*__+__*x*__+__*y*"), the sizegrip widget will not resize the window.

**ttk::sizegrip** widgets only support "southeast" resizing.

# Styling options

The class name for a **ttk::sizegrip** is **TSizegrip**.

**TSizegrip** styling options configurable with **ttk::style** are:

**-background** *color*

Some options are only available for specific themes.

See the **ttk::style** manual page for information on how to configure ttk styles.
