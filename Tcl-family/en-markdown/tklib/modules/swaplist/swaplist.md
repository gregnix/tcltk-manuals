---
CommandName: swaplist
title: swaplist
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: A dialog which allows a user to move options between two lists
Keywords:
 - dialog
 - disjointlistbox
 - listbox
Copyright:
---

# Name

swaplist - A dialog which allows a user to move options between two lists

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [swaplist]{.lit} [0.1]{.optlit}
[::swaplist::swaplist]{.cmd} [pathName]{.arg} [variable]{.arg} [completeList]{.arg} [selectedList]{.arg} [options]{.optarg}
:::

# Description

This package provides a dialog which consists of 2 listboxes, along with buttons to move items between them and reorder the right list.

**::swaplist::swaplist** *pathName* *variable* *completeList* *selectedList* ?options?
: Creates a dialog which presents the user with a pair of listboxes. Items are selected by using the buttons to move them to the right list. The contents of the right list are put in the *variable* upon closure of the dialog. The command returns a boolean indicating if the user pressed OK or not. If -geometry is not specified, the dialog is centered in its parent toplevel unless its parent is . in which case the dialog is centered in the screen.

    Options:

    **-embed**
    : if this flag is supplied, the procedure will create a swaplist widget named *pathName*, with the *variable* set as the listvariable for the right side listbox. This flag will also cause the -title and -geometry flags to be ignored.

    **-reorder**
    : boolean specifying if buttons allowing the user to change the order of the right listbox should appear or not. defaults to true

    **-title**
    : sets the title of the dialog window. defaults to "Configuration"

    **-llabel**
    : sets the heading above the left list. defaults to "Available:"

    **-rlabel**
    : sets the heading above the right list. defaults to "Selected:"

    **-lbuttontext**
    : sets the text on the "move left" button. defaults to "<<"

    **-rbuttontext**
    : sets the text on the "move right" button. defaults to ">>"

    **-ubuttontext**
    : sets the text on the "move up" button. defaults to "Move Up"

    **-dbuttontext**
    : sets the text on the "move down" button. defaults to "Move Down"

    **-geometry**
    : sets the geometry of the dialog window.



# Example

```
package require swaplist
namespace import swaplist::*

if {[swaplist .slist opts "1 2 3 4 5 6 7 8 9" "1 3 5"]} {
    puts "user chose numbers: $opts"
}
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *swaplist* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Widget
