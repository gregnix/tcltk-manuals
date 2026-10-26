---
CommandName: canvas::drag
title: canvas::drag
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - dragging
Copyright:
---

# Name

canvas::drag - Manage the dragging of canvas items or item groups

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::drag]{.lit} [0.1]{.optlit}
[::canvas::drag]{.cmd} [on]{.lit} [canvas]{.arg} [tagOrId]{.arg} [cmd]{.arg} [option...]{.arg}
[::canvas::drag]{.cmd} [off]{.lit} [canvas]{.arg} [tagOrId]{.arg}
[::canvas::drag]{.cmd} [item]{.lit} [canvas]{.arg} [tagOrId]{.arg} [option...]{.arg}
[::canvas::drag]{.cmd} [group]{.lit} [canvas]{.arg} [tagOrId]{.arg} [cmd]{.arg} [option...]{.arg}
[{\*}cmd]{.cmd} [start]{.lit} [canvas]{.arg} [item]{.arg}
[{\*}cmd]{.cmd} [move]{.lit} [canvas]{.arg} [clientdata]{.arg} [dx]{.arg} [dy]{.arg}
[{\*}cmd]{.cmd} [done]{.lit} [canvas]{.arg} [clientdata]{.arg}
:::

# Description

This package provides utility commands to setup and rmeove dragging of items or item groups on a canvas, hiding all complexity regarding bindings from the user.

# API

**::canvas::drag** **on** *canvas* *tagOrId* *cmd* *option*...
: This command initializes item dragging on the *canvas* widget, with the items used as drag handles identified by *tagOrId*. The command prefix *cmd*, invoked for drag start and movement, is responsible for the initialization and actual execution of the drag operation.

    The signature of the command prefix is described later, in section [Drag callback].

    Similarly, the accepted options and their values are described in section [Options]

    The result of the command is the empty string.

**::canvas::drag** **off** *canvas* *tagOrId*
: This command removes any drag operation set on the items of canvas *canvas* identified by *tagOrId*.

    The result of the command is the empty string.

**::canvas::drag** **item** *canvas* *tagOrId* *option*...
: This is a convenience command wrapped around method **on** (see above) to drag single items of the *canvas* widget, identified by *tagOrId*.

    It uses an internal standard callback for this.

    The result of the command is the empty string.

**::canvas::drag** **group** *canvas* *tagOrId* *cmd* *option*...
: This is a convenience command wrapped around method **on** (see above) to drag single items of the *canvas* widget, identified by *tagOrId*.

    It uses an internal standard callback for this. The callback *cmd* specified has the same signature as the [Drag callback], except that

    1. The **move** method is not invoked.

    2. The result of the **start** method *has to be* a canvas tag refering to the whole group of items to move. In other words, it must convert from drag handle (item id) to dragged groupt (tag).


    The result of the command is the empty string.


## Drag callback

The drag callback is a command prefix invoked in the following two ways:

**{\*}cmd** **start** *canvas* *item*
: This form is invoked when has initiated dragging using drag handle identified by the canvas *item* id. The callback now has to perform anything necessary for its type of drag operation.

    The result of the command can be anything. It is stored by the system as client information and passed unchanged to the movement callback for its use. In this manner the drag callback is able to maintain custom state from start to movement.

**{\*}cmd** **move** *canvas* *clientdata* *dx* *dy*
: This form is invoked when the mouse moved during a drag operation. It is invoked with the client data from the start callback (or the previous move callback) and the distances the mouse has traveled in horizontal and vertical directions.

    The result of the command can be anything. It is stored by the system as client information and passed unchanged to the next movement callback for its use. In this manner the drag callback is able to maintain custom state from movement to movement.

**{\*}cmd** **done** *canvas* *clientdata*
: This form is invoked when the drag operation ends. It is invoked with the client data from the last movement callback (or start callback if there had been no motion).

    The result of the command is ignored.


## Options

The commands to create drag operations (**on**, **item**, and **group**) all accept the following options to configure the new drag.

**-event** *spec*
: The value of this option specifies the mouse button used to initiate the drag operation, and the keyboard modifier, if any. Examples of specifications:

    To initiate a drag operation by pressing mouse button 3 on a drag handle, use:

    ```
     -event 3
    ```

    This is the default as well, if the option is not specified.

    To initiate a drag operation by pressing mouse button 2 on a drag handle while holding down the Control key, use:

    ```
     -event Control-2
    ```


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
