---
CommandName: canvas::edit::polyline
title: canvas::edit::polyline
ManualSection: n
Version: 0.2
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - editing
 - polyline
Copyright:
---

# Name

canvas::edit::polyline - Editing a polyline on a canvas

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.1]{.optlit}
[package]{.cmd} [require]{.sub} [canvas::edit::polyline]{.lit} [0.2]{.optlit}
[::canvas::edit]{.cmd} [polyline]{.lit} [objectName]{.arg} [canvas]{.arg} [options...]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [enable]{.lit}
[objectName]{.cmd} [disable]{.lit}
[objectName]{.cmd} [active]{.lit}
[objectName]{.cmd} [add]{.lit} [x]{.arg} [y]{.arg}
[objectName]{.cmd} [clear]{.lit}
[activeCmd]{.cmd} [editorObj]{.arg} [id]{.arg}
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg}
[dataCmd]{.cmd} [editorObj]{.arg} [coordinates]{.arg}
:::

# Description

This package provides a class whose instances handle editing a single poly-line (or -gon) on a canvas. Instances can be configured with regard to the visual appearance of the markers denoting the line's vertices, as well as if the line is to be closed or not, and further if a closed line has to be convex or not. Note that instances do not store the edited polyline themselves, but delegate this to a configurable object.

# Interaction

The polyline editor internally uses an instance of package **canvas::edit::points**, and inherits all the options and behaviours for it. The color options are additionally applied to the line element of this editor

Beyond that it provides 2 options to configure the editing mode, and one option to customize the line/polygon item used to render the line through the points.

The main editing mode is controlled by option **-closed** for *line* (i.e. open) versus *polygon* (i.e. closed). The default is line/open mode.

In polygon/closed mode the option **-convex** controls if the editor enforces convexity of the polygon, or not. The default is no enforcement of convexity.

The option **-line-config** enables basic customization of the line/polygon item. Note that it cannot overide the inherited color options.

# Class API

**::canvas::edit** **polyline** *objectName* *canvas* *options*...
: This, the class command, creates and configures a new instance of a polyline editor, named *objectName*. The instance will be connected to the specified *canvas* widget.

    The result of the command is the fully qualified name of the instance command.

    The options accepted here, and their values, are explained in the section [Options].


# Instance API

Instances of the polyline editors provide the following API:

**objectName** **destroy**
: This method destroys the polyline editor and releases all its internal resources.

    Note that this operation does not destroy the items the editor managed on the attached canvas, nor the canvas itself.

    The result of the method is an empty string.

**objectName** **enable**
: This method activates editing of the polyline on the canvas. This is the default after instance creation. A call is ignored if the editor is already active.

    The result of the method is an empty string.

    The complementary method is **disable**. The interogatory method for the current state is **active**.

**objectName** **disable**
: This method disables editing of the polyline on the canvas. A call is ignored if the editor is already disabled.

    The result of the method is an empty string.

    The complementary method is **enable**. The interogatory method for the current state is **active**.

**objectName** **active**
: This method queries the editor state.

    The result of the method is a boolean value, **true** if the editor is active, and **false** otherwise, i.e. disabled.

    The methods to change the state are **enable** and **disable**.

**objectName** **add** *x* *y*
: This method programmatically adds a vertex at the specified location to the line.

    The result of the method is an empty string.

    Note that this method goes through the whole set of callbacks invoked when the user interactively creates a vertex, i.e. **-create-cmd**, and, more importantly, **-data-cmd**.

    One important difference however. The new vertex is always added at the end of the line, whereas interactive creation uses heuristics to splice it into the line at a suitable location.

    This is the method through which to load the vertices of a pre-existing line into an editor instance.

**objectName** **clear**
: This method programmatically removes all vertices from the editor, essentially removing the whole line.

    The result of the method is an empty string.

    Note that this method goes through the same callbacks invoked when the user interactively removes a vertex, i.e. **-data-cmd**.


# Options

The class command accepts the following options

**-active-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when the mouse enters or leaves the line or a point managed by the instance.

    If not specified it defaults to an empty command which does nothing.

    The signature of this command prefix is

    **activeCmd** *editorObj* *id*
    : The *id* identifies the entered object.

        An empty *id* indicates that the last entered object was left.

        The value **line** indicates that the line was entered.

        A numeric value **N** indicates that the **N**'th vertex of the line was entered, counting from **0**.

        The result of this method is ignored.


**-add-remove-point** *eventspec*
: The value of this option is an event specification (without bracketing angles) declaring which event will trigger adding and removing a point.

    This option can only be set at construction time.

    The default setup uses different events for adding and removing points, **ButtonPress-1** and **ButtonPress-2** respectively.

    When using this option the same event is used for both operations. This is no problem because adding is bound as canvas-global event while removal is bound to the relevant canvas items.

**-closed** *boolean*
: The value of this option is a boolean flag indicating if the edited polyline is closed, i.e. a loop, or not. *NOTE* that a proper loop requires at least 3 points. For less than that an open line is shown, or even just a point.

    This option can only be set at construction time.

    If not specified it defaults to **false**

**-color** *colorspec*
: The value of this option is the fill color for the default item created when adding a point, and no **-create-cmd** is specified.

    The default value is **SkyBlue2**.

**-convex** *boolean*
: The value of this option is a boolean flag indicating if the edited polyline is strictly convex, or not. This option has meaning if and only if option **-closed** is configured to be **true**.

    This option can only be set at construction time.

    If not specified it defaults to **false**

**-create-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when it has to create a new vertex.

    While this option can be set after construction, it is recommended to use this feature only as a means of inserting custom processing to be done at creation time which remembers and calls the previous value of the option.

    If not specified it defaults to a command which will create a black-bordered blue circle of radius 3 centered on the location of the new point.

    The signature of this command prefix is

    **createCmd** *canvas* *x* *y*
    : The result of the command prefix *must* be a list of the canvas items it created to represent the marker. Note here that the visual representation of a "vertex" may consist of multiple canvas items in an arbitrary shape.

        The returned list of items is allowed to be empty, and such is taken as signal that the callback vetoed the creation of the vertex.


**-data-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when the line was edited in some way (vertex added, removed, moved). This is how the editor delegates the actual storage of the line information to an outside object.

    This option can only be set at construction time.

    If not specified it defaults to an empty string and is ignored by the editor, i.e. not invoked.

    The signature of this command prefix is

    **dataCmd** *editorObj* *coordinates*
    : This callback is invoked when the line was changed either interactively, or programmatically. See instance method **add** for the latter.

        The *editorObj* identifies the instance invoking the callback, whereas *coordinates* is a list of vertex locations, with each location a pair of x- and y-coordinates.

        The result of this method is ignored.


**-drag-point** *eventspec*
: The value of this option is an event specification (without bracketing angles) declaring which event will trigger a drag action on points.

    This option can only be set at construction time.

    The default specification is **ButtonPress-3**.

**-hilit-color** *colorspec*
: The value of this option is the highlight color for the default item created when adding a point, and no **-highlight-cmd** is specified.

    The default value is **red**.

**-kind** *name*
: The value of this option is the canvas item type for the default item created when adding a point, and no **-create-cmd** is specified. Only item types specified through a bounding box are suitable.

    The default value is **oval**.

**-line-config** *list*
: The value of this option is a list of options and their values to be applied to the internal line/polygon item whenever it is regenerated after changes. Note that these options *cannot* override the principal coloring of the line/polygon as applied by the main options **-color** and **-hilit-color**.

    If not specified it defaults to the empty list.

**-radius** *int*
: The value of this option is the radius for the default item created when adding a point, and no **-create-cmd** is specified.

    The default value is **3**.

**-tag** *string*
: The value of this option is the name of the canvas tag with which to identify all items of all vertices managed by the editor.

    This option can only be set at construction time.

    If not specified it defaults to **POLYLINE**


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
