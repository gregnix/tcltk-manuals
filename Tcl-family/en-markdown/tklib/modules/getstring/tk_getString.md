---
CommandName: getstring
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: A dialog which prompts for a string input
Keywords:
 - dialog
 - entry
 - string
Copyright:
---

# Name

getstring - A string dialog

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [getstring]{.lit} [0.1]{.optlit} 
[::getstring::tk_getString]{.cmd} [pathName]{.arg} [variable]{.arg} [text]{.arg} [options]{.optarg} 
:::

# Description

This package provides a dialog which consists of an Entry, OK, and Cancel buttons.

**::getstring::tk_getString** *pathName* *variable* *text* ?options?
: Creates a dialog which prompts the user with *text* to input a text string. The contents of the entry are put in the *variable* upon closure of the dialog. The command returns a boolean indicating if the user pressed OK or not. If -geometry is not specified, the dialog is centered in its parent toplevel unless its parent is . in which case the dialog is centered in the screen. Options: -title -allowempty a boolean argument indicating if the dialog should accept an empty entry -entryoptions simply passes its arguments through to the entry widget. This is valuble for performing extra validation using the Entry widget validation hooks. -geometry specifies the geometry of the window


# Example

```
package require getstring
namespace import getstring::*

if {[tk_getString .gs text "Feed me a string please:"]} {
    puts "user entered: $text"
}
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *getstring* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
