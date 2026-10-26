---
CommandName: canvas::highlight
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - enter callback
 - highlighting
 - leave callback
Copyright:
---

# Name

canvas::highlight - Manage the highlighting of canvas items or item groups

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::highlight]{.lit} [0.1]{.optlit} 
[::canvas::highlight]{.cmd} [on]{.sub} [canvas]{.arg} [tagOrId]{.arg} [cmd]{.arg} 
[::canvas::highlight]{.cmd} [off]{.sub} [canvas]{.arg} [tagOrId]{.arg} 
:::

**{\*}cmd** **on** *canvas* *item*

**{\*}cmd** **off** *canvas* *clientdata*

# Description

This package provides utility commands for setting up and tearing down of highlights for canvas items or item groups, the latter identified by a tag.

# Api

**::canvas::highlight** **on** *canvas* *tagOrId* *cmd*
: This command sets up a general highlight, with the items of canvas *canvas* to highlight in this manner identified by *tagOrId* and the *cmd* prefix providing the implementation, i.e. the how to perform the highlight. The signature of the command prefix is described later, in section **Highlight callback**. The result of the command is the empty string. Limitations:


**\[1\]**
: When a highlight is active no other highlight can be activated. This means that nested highlights are not possible.

**\[2\]**
: The system may break if a highlight is removed from within its highlight callback.


**::canvas::highlight** **off** *canvas* *tagOrId*
: This command removes any highlight set on the items of canvas *canvas* identified by *tagOrId*. The result of the command is the empty string.


## Highlight callback

The highlight callback is a command prefix invoked in the following two ways:

**{\*}cmd** **on** *canvas* *item*
: This form is invoked when the mouse has entered (one of) the item(s) the highlight was set up for. The callback now has to perform any reconfiguration necessary to highlight the item (group). The result of the command can be anything. It is stored by the system as client information and passed unchanged to the un-highlight callback for its use. In this manner the highlight callback is able to maintain custom state from highlighting to un-highlighting. Note that the callback does not have to maintain state, nor does it have to actually reconfigure the item (group). In the latter case the callback simply serves as easy enter/leave notification.

**{\*}cmd** **off** *canvas* *clientdata*
: This form is invoked when the mouse has left (one of) the item(s) of the currently active the highlight. The callback now has to perform any reconfiguration necessary to un-highlight the item (group). The result of the command must be a boolean value with the usual value to be **true**. By returning **false** instead the callback can veto the removal of the highlight.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
