---
CommandName: widget_toolbar
ManualSection: n
Version: 3.0
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - megawidget
 - snit
 - toolbar
 - widget
Copyright:
---

# Name

widget_toolbar - Toolbar Megawidget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.0]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::toolbar]{.lit} [1.0]{.optlit} 
[widget::toolbar]{.cmd} [pathname]{.arg} [options]{.optarg} 
:::

getframe

add ?item? ?args?

delete item1 ?item2? ?...?

itemcget symbol option

itemconfigure symbol ?args?

items ?pattern?

remove ?-destroy? item1 ?item2? ?...?

# Description

This package provides a toolbar megawidget (snidget). It makes use of the Tile/Ttk themed widget set.

**widget::toolbar** *pathname* ?options?
: ...see next...

**getframe**
: ...see next...

**add ?item? ?args?**
: ...see next...

**delete item1 ?item2? ?...?**
: ...see next...

**itemcget symbol option**
: ...see next...

**itemconfigure symbol ?args?**
: ...see next...

**items ?pattern?**
: ...see next...

**remove ?-destroy? item1 ?item2? ?...?**
: 


# Widget options

**-ipad**
: ...see next...

**-pad**
: ...see next...

**-separator**
: 


# Item options

**-pad**
: ...see next...

**-separator**
: ...see next...

**-sticky**
: ...see next...

**-weight**
: 


# Example

```
package require widget::toolbar ; # or widget::all
set t [widget::toolbar .t]
pack $t -fill x -expand 1
$t add button [button .b -text foo]
$t add separator -pad {2 4}
$t add button [button .c -text bar]
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widget::toolbar* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Widget
