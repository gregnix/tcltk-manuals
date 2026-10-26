---
CommandName: canvas::edit::quadrilateral
title: canvas::edit::quadrilateral
ManualSection: n
Version: 0.2
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - concave
 - convex
 - editing
 - non-convex
 - quadrilateral
Copyright:
---

# Name

canvas::edit::quadrilateral - Editing a quadrilateral on a canvas

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.1]{.optlit}
[package]{.cmd} [require]{.sub} [canvas::edit::quadrilateral]{.lit} [0.2]{.optlit}
[::canvas::edit]{.cmd} [quadrilateral]{.lit} [objectName]{.arg} [canvas]{.arg} [options...]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [enable]{.lit}
[objectName]{.cmd} [disable]{.lit}
[objectName]{.cmd} [active]{.lit}
[objectName]{.cmd} [add]{.lit} [x]{.arg} [y]{.arg}
[objectName]{.cmd} [clear]{.lit}
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg}
[highlightCmd]{.cmd} [on]{.lit} [canvas]{.arg} [item]{.arg}
[highlightCmd]{.cmd} [off]{.lit} [canvas]{.arg} [state]{.arg}
[dataCmd]{.cmd} [editorObj]{.arg} [coordinates]{.arg}
:::

# Description

This package provides a class whose instances handle the editing of a quadrilateral on a canvas. Instances can be configured with regard to the visual appearance (regular, and highlighted) of vertex markers. Note that instances do not store the edited quadrilateral themselves, but delegate this to a configurable object.

# Class API

**::canvas::edit** **quadrilateral** *objectName* *canvas* *options*...
: This, the class command, creates and configures a new instance of a quadrilateral editor, named *objectName*. The instance will be connected to the specified *canvas* widget.

    The result of the command is the fully qualified name of the instance command.

    The options accepted here, and their values, are explained in the section [Options].


# Instance API

Instances of the quadrilateral editors provide the following API:

**objectName** **destroy**
: This method destroys the quadrilateral editor and releases all its internal resources.

    Note that this operation does not destroy the items the editor managed on the attached canvas, nor the canvas itself.

    The result of the method is an empty string.

**objectName** **enable**
: This method activates editing of the quadrilateral on the canvas. This is the default after instance creation. A call is ignored if the editor is already active.

    The result of the method is an empty string.

    The complementary method is **disable**. The interogatory method for the current state is **active**.

**objectName** **disable**
: This method disables editing of the quadrilateral on the canvas. A call is ignored if the editor is already disabled.

    The result of the method is an empty string.

    The complementary method is **enable**. The interogatory method for the current state is **active**.

**objectName** **active**
: This method queries the editor state.

    The result of the method is a boolean value, **true** if the editor is active, and **false** otherwise, i.e. disabled.

    The methods to change the state are **enable** and **disable**.

**objectName** **add** *x* *y*
: This method programmatically adds a vertex at the specified location to the quadrilateral.

    The result of the method is an empty string.

    Note that this method goes through the whole set of callbacks invoked when the user interactively creates a vertex, i.e. **-create-cmd**, and, more importantly, **-data-cmd**.

    This is the method through which to load the vertices of a pre-existing quadrilateral into an editor instance.

    Note that at most 4 vertices can be specified, and at least 4 must be specified for the quadrilateral to be complete.

**objectName** **clear**
: This method programmatically unset the quadrilateral in the editor.

    The result of the method is an empty string.

    Note that this method goes through the same callback invoked when the user interactively removes a vertex, i.e. **-data-cmd**.


# Options

The class command accepts the following options

**-convex** *boolean*
: The value of this option is a boolean flag. When the flag is set the editor will accept only convex quadrilaterals and reject all operations which would result in a violation of convexity.

    This option can only be set at construction time.

    If not specified it defaults to **false**, i.e. acceptance of any quadrilateral.

**-tag** *string*
: The value of this option is the name of the canvas tag with which to identify all items of all quadrilateral managed by the editor.

    This option can only be set at construction time.

    If not specified it defaults to **QUADRILATERAL**

**-create-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when it has to create a new vertex.

    This option can only be set at construction time.

    If not specified it defaults to a command which will create a black-bordered blue circle of radius 3 centered on the location of the new point.

    The signature of this command prefix is

    **createCmd** *canvas* *x* *y*
    : The result of the command prefix *must* be a list of the canvas items it created to represent the marker. Note here that the visual representation of a "vertex" may consist of multiple canvas items in an arbitrary shape.


**-highlight-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when it has to (un)highlight a vertex.

    This option can only be set at construction time.

    If not specified it defaults to a command which will re-color the item to highlight in red (and restores the color for unhighlighting).

    The two signatures of this command prefix are

    **highlightCmd** **on** *canvas* *item*
    : This method of the command prefix has to perform whatever is needed to highlight the vertex the *item* is a part of (remember the note above about quadrilateral allowed to be constructed from multiple canvas items).

        The result of the command can be anything and will be passed as is as argument *state* to the **off** method.

    **highlightCmd** **off** *canvas* *state*
    : This method is invoked to unhighlight a vertex described by the *state*, which is the unchanged result of the **on** method of the command prefix. The result of this method is ignored.

        Note any interaction between dragging and highlighting of quadrilateral is handled within the editor, and that the callback bears no responsibility for doing such.


**-data-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when the quadrilateral was edited in some way. This is how the editor delegates the actual storage of quadrilateral information to an outside object.

    This option can only be set at construction time.

    If not specified it defaults to an empty string and is ignored by the editor, i.e. not invoked.

    The signatures of this command prefix are

    **dataCmd** *editorObj* *coordinates*
    : This callback is invoked when the quarilateral was changed either interactively, or programmatically. See instance method **add** for the latter.

        The *editorObj* identifies the instance invoking the callback, whereas *coordinates* is a list of vertex locations, with each location a pair of x- and y-coordinates.

        The result of this method is ignored.



# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
