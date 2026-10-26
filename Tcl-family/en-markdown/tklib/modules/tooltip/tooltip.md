---
CommandName: tooltip
title: tooltip
ManualSection: n
Version: 2.0.4
TclPart: tklib
TclDescription: Tooltip management
Keywords:
 - balloon
 - help
 - hover
 - tooltip
Copyright:
 - Copyright (c) 1996-2008, Jeffrey Hobbs
 - Copyright (c) 2024 Emmanuel Frecon
---

# Name

tooltip - Tooltip management

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [tooltip]{.lit} [2.0.4]{.optlit}
[::tooltip::tooltip]{.cmd} [command]{.arg} [options]{.optarg}
[::tooltip::tooltip]{.cmd} [pathName]{.arg} [option value...]{.optarg} [--]{.optlit} [message]{.arg}
:::

# Description

This package provides tooltips, i.e., small text messages that can be displayed when the mouse hovers over a widget, menu item, canvas item, listbox item, ttk::treeview item or column heading, ttk::notebook tab, or text widget tag.

# Commands

**::tooltip::tooltip** *command* ?*options*?
: Manage the tooltip package using the following subcommands.

    **clear** ?*pattern*?
    : Prevents the specified widgets from showing tooltips. *pattern* is a glob pattern and defaults to matching all widgets.

    **configure** ?*option* ?*value option value* ...??
    : Queries or modifies the configuration options of the tooltip. The supported options are **-backgroud**, **-foreground** and **-font**. If no *option* is specified, returns a dictionary of the option values. If one *option* is specified with no value, returns the value of that option. Otherwise, sets the given *option*s to the corresponding *value*s.

    **delay** ?*millisecs*?
    : Query or set the hover delay. This is the interval that the pointer must remain over the widget before the tooltip is displayed. The delay is specified in milliseconds and must be greater than or equal to 50 ms. With no argument the current delay is returned.

    **fade** ?*boolean*?
    : Enable or disable fading of the tooltip.  The fading is enabled by default on Win32 and Aqua.  The tooltip will fade away on Leave events instead disappearing.

    **disable**
    : see below ...

    **off**
    : Disable all tooltips

    **enable**
    : see below ...

    **on**
    : Enables tooltips for defined widgets.


**::tooltip::tooltip** *pathName* ?*option value*...? ?**--**? *message*
: This command arranges for widget *pathName* to display a tooltip with a *message*.

    If the specified widget is a **menu**, **canvas**, **listbox**, **ttk::treeview**, **ttk::notebook** or **text** widget then additional options are used to tie the tooltip to specific menu, canvas or listbox items, ttk::treeview items or column headings, ttk::notebook tabs, or text widget tags.

    **-heading** *columnId*
    : This option is used to set a tooltip for a ttk::treeview column heading. The column does not need to already exist. You should not use the same identifiers for columns and items in a widget for which you are using tooltips as their tooltips will be mixed. The widget must be a ttk::treeview widget.

    **-image** *image*
    : The specified (photo) image will be displayed to the left of the primary tooltip *message*.

    **-index** *index*
    : This option is used to set a tooltip on a menu item. The index may be either the entry index or the entry label. The widget must be a menu widget but the entries do not have to exist when the tooltip is set.

    **-info** *info*
    : The specified *info* text will be displayed as additional information below the primary tooltip *message*.

    **-items** *items*
    : This option is used to set a tooltip for canvas, listbox or ttk::treview items. For the canvas widget, the item must already be present in the canvas and will be found with a **find withtag** lookup. For listbox and ttk::treview widgets the item(s) may be created later but the programmer is responsible for managing the link between the listbox or ttk::treview item index and the corresponding tooltip. If the listbox or ttk::treview items are re-ordered, the tooltips will need amending.

        If the widget is not a canvas, listbox or ttk::treview then an error is raised.

    **-tab** *tabId*
    : The **-tab** option can be used to set a tooltip for a ttk::notebook tab. The tab should already be present when this command is called, or an error will be returned. The widget must be a ttk::notebook widget.

    **-tag** *name*
    : The **-tag** option can be used to set a tooltip for a text widget tag. The tag should already be present when this command is called, or an error will be returned. The widget must be a text widget.

    **--**
    : The **--** option marks the end of options. The argument following this one will be treated as *message* even if it starts with a **-**.



# Example

```
# Demonstrate widget tooltip
package require tooltip
pack [label .l -text "label"]
tooltip::tooltip .l "This is a label widget"
```

```
# Demonstrate menu tooltip
package require tooltip
. configure -menu [menu .menu]
.menu add cascade -label Test -menu [menu .menu.test -tearoff 0]
.menu.test add command -label Tooltip
tooltip::tooltip .menu.test -index 0 "This is a menu tooltip"
```

```
# Demonstrate canvas item tooltip
package require tooltip
pack [canvas .c]
set item [.c create rectangle 10 10 80 80 -fill red]
tooltip::tooltip .c -item $item "Canvas item tooltip"
```

```
# Demonstrate listbox item tooltip
package require tooltip
pack [listbox .lb]
.lb insert 0 "item one"
tooltip::tooltip .lb -item 0 "Listbox item tooltip"
```

```
# Demonstrate ttk::notebook tab tooltip
package require tooltip
pack [ttk::notebook .nb]
.nb add [frame .nb.f1 -height 50] -text "First tab"
.nb add [frame .nb.f2 -height 50] -text "Second tab"
tooltip::tooltip .nb -tab 0 "Tooltip for the 1st notebook tab"
tooltip::tooltip .nb -tab 1 "Tooltip for the 2nd notebook tab"
```

```
# Demonstrate text tag tooltip
package require tooltip
pack [text .txt]
.txt tag configure TIP-1 -underline 1
tooltip::tooltip .txt -tag TIP-1 "tooltip one text"
.txt insert end "An example of a " {} "tooltip" TIP-1 " tag.\n" {}
```

# Migration from version 1

Version 1.3 to 1.7 called **msgcat::mc** before a tooltip was shown, using the tooltip namespace. **msgcat::mc** requires the caller environment. Due to that, version 1.8 recorded the caller namespace and used this in the call. In version 2.0, any **msgcat::mc** support was removed. The options **-namespace**, **-msgargs** and **-infoargs** were removed. Starting with TCL 8.7, **msgcat::mc** supports oo classes and oo methods. But the oo caller environment is not present when the **msgcat::mc** was invoked on tooltip display, resulting in runtime errors. It was concluded as bad design to call **msgcat::mc** late. The caller should reinstall the tooltips on eventual message change.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *tooltip* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 1996-2008, Jeffrey Hobbs
Copyright (c) 2024 Emmanuel Frecon
```
