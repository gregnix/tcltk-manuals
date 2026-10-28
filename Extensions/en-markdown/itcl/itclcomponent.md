---
CommandName: component
title: component
ManualSection: n
Version: 4.0
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - component
 - widget
 - widgetadaptor
 - extendedclass
Copyright:
 - Copyright (c) 2008 Arnulf Wiedemann
---

# Name

itcl::component - define components for extendedclass, widget or widgetadaptor

Parts of this description are "borrowed" from Tcl extension \[snit\], as the functionality is mostly identical.

# Warning!

This is new functionality in \[incr Tcl\] where the API can still change!!

# Synopsis

::: {.synopsis} :::
[public]{.cmd} [component]{.sub} [comp]{.arg} [-inherit]{.optlit}
[protected]{.cmd} [component]{.sub} [comp]{.arg} [-inherit]{.optlit}
[private]{.cmd} [component]{.sub} [comp]{.arg} [-inherit]{.optlit}
:::

# Description

The **component** command is used inside an **\[incr Tcl\]** extendedclass/widget/widgetadaptor definition to define components.

Explicitly declares a component called comp, and automatically defines the component's instance variable.

If the *-inherit* option is specified then all unknown methods and options will be delegated to this component. The name -inherit implies that instances of this new type inherit, in a sense, the methods and options of the component. That is, -inherit yes is equivalent to:

```
component mycomp
delegate option * to mycomp
delegate method * to mycomp
```
