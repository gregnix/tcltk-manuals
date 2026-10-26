---
CommandName: ttk::label
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - label(n)
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::label - Display a text string and/or image

# Synopsis

::: {.synopsis} :::
[ttk::label]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# Description

A **ttk::label** widget displays a textual label and/or image. The label may be linked to a Tcl variable to automatically change the displayed text.

# Standard options

|   |   |   |
| --- | --- | --- |
| **-class** | **-compound** | **-cursor** |
| **-image** | **-padding** | **-state** |
| **-style** | **-takefocus** | **-text** |
| **-textvariable** | **-underline** | **-width** |

See the ttk_widget manual entry for details on the standard options.

# Widget-specific options

**-anchor** (**anchor**/**Anchor**)
: Specifies how the information in the widget is positioned relative to the inner margins.  Legal values are **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw**, and **center**. See also **-justify**.

**-background** (**frameColor**/**FrameColor**)
: The widget's background color. If unspecified, the theme default is used.

**-font** (**font**/**Font**)
: Font to use for label text.

**-foreground** (**textColor**/**TextColor**)
: The widget's foreground color. If unspecified, the theme default is used.

**-justify** (**justify**/**Justify**)
: If there are multiple lines of text, specifies how the lines are laid out relative to one another. One of **left**, **center**, or **right**. See also **-anchor**.

**-relief** (**relief**/**Relief**)
: Specifies the 3-D effect desired for the widget border. Valid values are **flat**, **groove**, **raised**, **ridge**, **solid**, and **sunken**.

**-wraplength** (**wrapLength**/**WrapLength**)
: Specifies the maximum line length (in pixels). If this option is less than or equal to zero, then automatic wrapping is not performed; otherwise the text is split into lines such that no line is longer than the specified value.


# Widget command

Supports the standard widget commands **configure**, **cget**, **identify**, **instate**, and **state**; see *ttk::widget(n)*.

# Styling options

The class name for a **ttk::label** is **TLabel**.

Dynamic states: **disabled**, **readonly**.

**TLabel** styling options configurable with **ttk::style** are:

**-background** *color*

**-compound** *compound*

**-foreground** *color*

**-font** *font*

Some options are only available for specific themes.

See the **ttk::style** manual page for information on how to configure ttk styles.
