---
CommandName: widget
title: widget
ManualSection: n
Version: 3.2
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - bundle
 - calendar
 - dateentry
 - dialog
 - megawidget
 - menu
 - panelframe
 - ruler
 - screenruler
 - scrolledwindow
 - snit
 - statusbar
 - superframe
 - toolbar
 - widget
Copyright:
---

# Name

widget - Megawidget bundle

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[widget::validate]{.cmd} [as]{.arg} [options]{.optarg}
[widget::calendar]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::dateentry]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::dialog]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::menuentry]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::panelframe]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::ruler]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::screenruler]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::scrolledwindow]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::statusbar]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::superframe]{.cmd} [pathname]{.arg} [options]{.optarg}
[widget::toolbar]{.cmd} [pathname]{.arg} [options]{.optarg}
:::

# Description

This package provides megawidgets based on the snit oo system (snidgets). It makes use of the Tile/Ttk themed widget set.

**widget::validate** *as* ?options?
: commands:


# Widgets

**widget::calendar** *pathname* ?options?
: options:

**widget::dateentry** *pathname* ?options?
: options:

**widget::dialog** *pathname* ?options?
: options:

**widget::menuentry** *pathname* ?options?
: options:

**widget::panelframe** *pathname* ?options?
: options:

**widget::ruler** *pathname* ?options?
: options:

**widget::screenruler** *pathname* ?options?
: options:

**widget::scrolledwindow** *pathname* ?options?
: options:

**widget::statusbar** *pathname* ?options?
: options:

**widget::superframe** *pathname* ?options?
: options:

**widget::toolbar** *pathname* ?options?
: options:


# Example

```
package require widget::superframe ; # or widget::all
pack [widget::superframe .f -type separator -text "SuperFrame:"]
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widget* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Widget
