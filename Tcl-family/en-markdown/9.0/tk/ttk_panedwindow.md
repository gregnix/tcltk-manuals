---
CommandName: ttk::panedwindow
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::notebook(n)
 - panedwindow(n)
Copyright:
 - Copyright (c) 2005 Joe English
---

# Name

ttk::panedwindow - Multi-pane container window

# Synopsis

::: {.synopsis} :::
[ttk::panedwindow]{.cmd} [pathname]{.arg} [options]{.optarg} 
[pathname]{.ins} [add]{.sub} [window]{.arg} [options]{.optdot} 
[pathname]{.ins} [insert]{.sub} [index]{.arg} [window]{.arg} [options]{.optdot} 
:::

# Description

A **ttk::panedwindow** widget displays a number of subwindows, stacked either vertically or horizontally. The user may adjust the relative sizes of the subwindows by dragging the sash between panes.

If a pane is not a child of the panedwindow, it must be higher in the stacking order than the panedwindow, otherwise the panedwindow will obscure it.  The easiest way to ensure this is to create the panedwindow first: the most recently created window is highest in the stacking order. Or, you can use the **raise** and **lower** commands.

# Standard options

|   |   |   |
| --- | --- | --- |
| **-class** | **-cursor** | **-takefocus** |
| **-style** |  |  |

See the ttk_widget manual entry for details on the standard options.

# Widget-specific options

**-orient** (**orient**/**Orient**)
: Specifies the orientation of the window. If **vertical**, subpanes are stacked top-to-bottom; if **horizontal**, subpanes are stacked left-to-right.

**-width** (**width**/**Width**)
: If present and greater than zero, specifies the desired width of the widget in pixels. Otherwise, the requested width is determined by the width of the managed windows.

**-height** (**height**/**Height**)
: If present and greater than zero, specifies the desired height of the widget in pixels. Otherwise, the requested height is determined by the height of the managed windows.


# Pane options

The following options may be specified for each pane:

**-weight** (**weight**/**Weight**)
: An integer specifying the relative stretchability of the pane. When the paned window is resized, the extra space is added or subtracted to each pane proportionally to its **-weight**.


# Widget command

In addition to the standard **cget**, **configure**, **instate**, **state** and **style** commands (see **ttk::widget**), panedwindow widgets support the following additional commands:

*pathname* **add** *subwindow options...*
: Adds a new pane to the window. See **PANE OPTIONS** for the list of available options.

*pathname* **forget** *pane*
: Removes the specified subpane from the widget. *pane* is either an integer index or the name of a managed subwindow.

*pathname* **identify** *component x y*
: Returns the name of the element under the point given by *x* and *y*, or the empty string if no component is present at that location. If *component* is omitted, it defaults to **sash**. The following subcommands are supported:


*pathname* **identify element** *x y*
: Returns the name of the element at the specified location.

*pathname* **identify sash** *x y*
: Returns the index of the sash at the specified location.


*pathname* **insert** *pos subwindow options...*
: Inserts a pane at the specified position. *pos* is either the string **end**, an integer index, or the name of a managed subwindow. If *subwindow* is already managed by the paned window, moves it to the specified position. See **PANE OPTIONS** for the list of available options.

*pathname* **pane** *pane -option* ?*value* ?*-option value...*
: Query or modify the options of the specified *pane*, where *pane* is either an integer index or the name of a managed subwindow. If no *-option* is specified, returns a dictionary of the pane option values. If one *-option* is specified, returns the value of that *option*. Otherwise, sets the *-option*s to the corresponding *value*s.

*pathname* **panes**
: Returns the list of all windows managed by the widget, in the index order of their associated panes.

*pathname* **sashpos** *index* ?*newpos*?
: If *newpos* is specified, sets the position of sash number *index*. May adjust the positions of adjacent sashes to ensure that positions are monotonically increasing. Sash positions are further constrained to be between 0 and the total size of the widget. Returns the new position of sash number *index*.


# Virtual events

The panedwindow widget generates an **<\<EnteredChild>>** virtual event on LeaveNotify/NotifyInferior events.

# Styling options

The class name for a **ttk::panedwindow** is **TPanedwindow**.  The sash has a class name of **Sash**.

**TPanedwindow** styling options configurable with **ttk::style** are:

**-background** *color*

**Sash** styling options configurable with **ttk::style** are:

**-background** *color*

**-bordercolor** *color*

**-gripsize** *size* (number of screen units)

**-handlepad** *amount*

**-handlesize** *amount*

**-lightcolor** *color*

**-sashpad** *amount*

**-sashrelief** *relief*

**-sashthickness** *amount*

Some options are only available for specific themes.

See the **ttk::style** manual page for information on how to configure ttk styles.
