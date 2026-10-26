---
CommandName: ttk::menubutton
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - menu(n)
 - menubutton(n)
Keywords:
 - widget
 - button
 - menu
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::menubutton - Widget that pops down a menu when pressed

# Synopsis

::: {.synopsis} :::
[ttk::menubutton]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# Description

A **ttk::menubutton** widget displays a textual label and/or image, and displays a menu when pressed.

# Standard options

|   |   |   |
| --- | --- | --- |
| **-class** | **-compound** | **-cursor** |
| **-image** | **-state** | **-style** |
| **-takefocus** | **-text** | **-textvariable** |
| **-underline** | **-width** |  |

See the ttk_widget manual entry for details on the standard options.

# Widget-specific options

**-direction** (**direction**/**Direction**)
: Specifies where the menu is to be popped up relative to the menubutton. One of: **above**, **below**, **left**, **right**, or **flush**.  The default is **below**. **flush** pops the menu up directly over the menubutton.

**-menu** (**menu**/**Menu**)
: Specifies the path name of the menu associated with the menubutton. To be on the safe side, the menu ought to be a direct child of the menubutton.


# Widget command

Menubutton widgets support the standard **cget**, **configure**, **identify**, **instate**, and **state** methods.  No other widget methods are used.

# Standard styles

**Ttk::menubutton** widgets support the **Toolbutton** style in all standard themes, which is useful for creating widgets for toolbars.

# Styling options

The class name for a **ttk::menubutton** is **TMenubutton**.

Dynamic states: **active**, **disabled**, **readonly**.

**TMenubutton** styling options configurable with **ttk::style** are:

**-arrowsize** *amount*

**-background** *color*

**-compound** *compound*

**-foreground** *color*

**-font** *font*

**-padding** *padding*

**-relief** *relief*

**-width** *amount*

Some options are only available for specific themes.

See the **ttk::style** manual page for information on how to configure ttk styles.
