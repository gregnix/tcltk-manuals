---
CommandName: usual
title: usual
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr Tk]"
Keywords:
 - itk
 - Archetype
 - component
 - mega-widget
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

usual - access default option-handling commands

```
	for a mega-widget component
```

# Synopsis

::: {.synopsis} :::
[usual]{.cmd} [tag]{.optarg} [commands]{.optarg}
:::

# Description

The **usual** command is used outside of an **\[incr Tcl\]** class definition to define the usual set of option-handling commands for a component widget.  Option-handling commands are used when a component is registered with the [Archetype] base class via the "**itk\_component add**" method.  They specify how the component's configuration options should be integrated into the composite option list for the mega-widget. Options can be kept, renamed, or ignored, as described in the [Archetype] man page.

It is tedious to include the same declarations again and again whenever components are added.  The **usual** command allows a standard code fragment to be registered for each widget class, which is used by default to handle the options.  All of the standard Tk widgets have **usual** declarations defined in the **\[incr Tk\]** library.  Similar **usual** declarations should be created whenever a new mega-widget class is conceived. Only the most-generic options should be included in the **usual** declaration.

The *tag* name is usually the name of a widget class, which starts with a capital letter; however, any string registered here can be used later with the **usual** command described on the [Archetype] man page.

If the *commands* argument is specified, it is associated with the *tag* string, and can be accessed later via **itk\_component add**.

If only the *tag* argument is specified, this command looks for an existing *tag* name and returns the commands associated with it.  If there are no commands associated with *tag*, this command returns the null string.

If no arguments are specified, this command returns a list of all *tag* names previously registered.

# Example

Following is the **usual** declaration for the standard Tk button widget:

```
itk::usual Button {
    keep -background -cursor -foreground -font
    keep -activebackground -activeforeground -disabledforeground
    keep -highlightcolor -highlightthickness
    rename -highlightbackground -background background Background
}
```

Only the options that would be common to all buttons in a single mega-widget are kept or renamed.  Options like "-text" that would be unique to a particular button are ignored.


[Archetype]: Archetype.md
