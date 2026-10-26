---
CommandName: tipstack
ManualSection: n
Version: 1.0.1
TclPart: tklib
TclDescription: Tooltip management
Keywords:
 - balloon
 - help
 - hover
 - tipstack
Copyright:
 - Copyright (c) 2003 ActiveState Corp
---

# Name

tipstack - Stacked tooltips

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [msgcat]{.lit} [1.3]{.lit} 
[package]{.cmd} [require]{.sub} [tooltip]{.lit} [1.7]{.optlit} 
[package]{.cmd} [require]{.sub} [tipstack]{.lit} [1.0.1]{.optlit} 
[::tipstack::push]{.cmd} [widget]{.arg} [-index index]{.optarg} [text]{.arg} 
[::tipstack::pop]{.cmd} [widget]{.arg} [-index index]{.optarg} 
[::tipstack::clear]{.cmd} [widget]{.arg} [-index index]{.optarg} 
[::tipstack::def]{.cmd} [widget]{.arg} [text]{.arg} ... 
[::tipstack::defsub]{.cmd} [base]{.arg} [widget]{.arg} [text]{.arg} ... 
[::tipstack::clearsub]{.cmd} [base]{.arg} 
:::

# Description

This package extends the functionality of package **tooltip**. It provides a dynamic stack of tip texts per widget. This enables dynamic transient changes to the tips, for example to temporarily replace a standard explanation of a field with an error message.

# Commands

**::tipstack::push** *widget* ?**-index** *index*? *text*
: Push a new *text* to the tooltip for the *widget*. In case of a list widget use


```
-index ...
```

**to address the particular entry to change the**
: tooltip for. The result of the command is the empty string


**::tipstack::pop** *widget* ?**-index** *index*?
: Pop the current tooltip for the *widget* from the stack and restore the previous text. This is a no-operation if this would leave an empty stack behind. In other words, the baseline tooltip text cannot be popped of. In case of a list widget use


```
-index ...
```

**to address the particular entry to change the**
: tooltip for. The result of the command is the empty string


**::tipstack::clear** *widget* ?**-index** *index*?
: Clear the stack for the *widget* and restore back to the baseline. In case of a list widget use


```
-index ...
```

**to address the particular entry to change the**
: tooltip for. The result of the command is the empty string


**::tipstack::def** *widget* *text* ...
: Perform multiple pushes for a number of independent *widget*s in a single call. This command cannot be used for list widgets, as it does not allow the passing of the necessary index information. Use with menus is not possible either. The result of the command is the empty string

**::tipstack::defsub** *base* *widget* *text* ...
: This command is a variant of **::tipstack::def** where all the widgets to push to are subwidgets of the *base*. This is good for mega-widgets. Note that either each *widget* has to be specified with a proper leading dot (**.**), or the *base* has to be specigfied with a trailing dot. The result of the command is the empty string

**::tipstack::clearsub** *base*
: This command is a variant of **::tipstack::clear** which clears all child widgets of the *base* text was pushed to. Use with menus is not possible. The result of the command is the empty string


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *tooltip* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 2003 ActiveState Corp
```
