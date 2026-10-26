---
CommandName: canvas::edit::points
title: canvas::edit::points
ManualSection: n
Version: 0.3
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - editing
 - point cloud
 - points
Copyright:
---

# Name

canvas::edit::points - Editing a cloud of points on a canvas

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.3]{.optlit}
[::canvas::edit]{.cmd} [points]{.lit} [objectName]{.arg} [canvas]{.arg} [options...]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [enable]{.lit}
[objectName]{.cmd} [disable]{.lit}
[objectName]{.cmd} [active]{.lit}
[objectName]{.cmd} [add]{.lit} [x]{.arg} [y]{.arg}
[objectName]{.cmd} [clear]{.lit}
[activeCmd]{.cmd} [editorObj]{.arg} [id]{.arg}
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg}
[dataCmd]{.cmd} [add]{.lit} [editorObj]{.arg} [id]{.arg} [x]{.arg} [y]{.arg}
[dataCmd]{.cmd} [remove]{.lit} [editorObj]{.arg} [id]{.arg}
[dataCmd]{.cmd} [move]{.lit} [start]{.lit} [editorObj]{.arg} [id]{.arg}
[dataCmd]{.cmd} [move]{.lit} [delta]{.lit} [editorObj]{.arg} [id]{.arg} [x]{.arg} [y]{.arg} [dx]{.arg} [dy]{.arg}
[dataCmd]{.cmd} [move]{.lit} [done]{.lit} [editorObj]{.arg} [id]{.arg}
:::

# Description

This package provides a class whose instances handle editing a cloud of point markers on a canvas. Instances can be configured with regard to the visual appearance of markers. Note that instances do not store the edited points themselves, but delegate this to a configurable object.

# Interaction

The default bindings enable the creation, removal and dragging of point (markers) using the mouse buttons 1, 2, and 3. Specifically:

1. Clicking anywhere with button 1 adds a new point.

2. Clicking on a point with button 2 removes that point.

3. Clicking on a point with button 3 starts a drag operation ending with the release of the button.


The option **-drag-point** can be used to change the button used to initiate drag operations. Note that the option value may not only contain the button number, but also modifier prefix separated from the button by a dash "**-**". The recognized modifiers are **Control**, **Shift**, and **Alt**.

The option **-add-remove-point** can be used to change the button used to add/remove points. This works because removal is an item binding, while adding is canvas global. The option recognizes the same syntax for button as **-drag-point**.

In the standard configuration the canvas item representing a point is a circle configured using the appearance options **-color**, **-hilit-color**, and **-radius**. Their defaults are **Skyblue2**, **red**, and **3**, repsectively.

The option **-kind** can be used to slightly customize the canvas item to any kind accepting the item options **-width**, **-outline**, **-fill**, and **-activefill**.

For more extensive customization its is necessary to configure a creation callback using option **-create-cmd**. The callback takes the canvas and x. y coordinates as arguments, in this order, and is expected to return a list of the canvas items representing the point.

Note the plural. With the callback it is possible to visualize a point using a group of items.

Further note that when the callback return an empty list no point is created. In other words, the callback can also be used to perform checks if a point at the given location is desirable, or not. This can be combined with the default creation behaviour as the option can be queried, and its default value is the callback for the default behaviour.

Keeping with the callback for a bit, the option **-active-cmd** sets a callback invoked whenever the mouse is over one of the created points, i.e. active. This can be used to drive derived displays. For example highlighting the point's entry in a table or other widget.

The last option of importance is **-tag**. Its value is the name of the canvas tag used to mark all the items owned, i.e. created and managed by an. The default is **POINT**.

When attaching multiple instances of this behaviour to the same canvas each instance has to be configured with a unique tag, to prevent them from interfering with each other.

# Class API

**::canvas::edit** **points** *objectName* *canvas* *options*...
: This, the class command, creates and configures a new instance of a point cloud editor, named *objectName*. The instance will be connected to the specified *canvas* widget.

    The result of the command is the fully qualified name of the instance command.

    The options accepted here, and their values, are explained in the section [Options].


# Instance API

Instances of the point cloud editors provide the following API:

**objectName** **destroy**
: This method destroys the point cloud editor and releases all its internal resources.

    Note that this operation does not destroy the items of the point markers the editor managed on the attached canvas, nor the canvas itself.

    The result of the method is an empty string.

**objectName** **enable**
: This method activates editing of the point cloud on the canvas. This is the default after instance creation. A call is ignored if the editor is already active.

    The result of the method is an empty string.

    The complementary method is **disable**. The interogatory method for the current state is **active**.

**objectName** **disable**
: This method disables editing of the point cloud on the canvas. A call is ignored if the editor is already disabled.

    The result of the method is an empty string.

    The complementary method is **enable**. The interogatory method for the current state is **active**.

**objectName** **active**
: This method queries the editor state.

    The result of the method is a boolean value, **true** if the editor is active, and **false** otherwise, i.e. disabled.

    The methods to change the state are **enable** and **disable**.

**objectName** **add** *x* *y*
: This method programmatically creates a point at the specified location.

    The result of the method is an empty string.

    Note that this method goes through the whole set of callbacks invoked when the user interactively creates a point, i.e. **-create-cmd**, and, more importantly, **-data-cmd**.

    This is the method through which to load pre-existing points into an editor instance.

**objectName** **clear**
: This method programmatically removes all points from the editor.

    The result of the method is an empty string.

    Note that this method goes through the same callback invoked when the user interactively removes a point, i.e. **-data-cmd**.


# Options

The class command accepts the following options

**-active-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when the mouse enters or leaves a point managed by the instance.

    If not specified it defaults to an empty command which does nothing.

    The signature of this command prefix is

    **activeCmd** *editorObj* *id*
    : The *id* identifies the point within the editor.

        An empty *id* indicates that the last entered point was left.

        The result of this method is ignored.


**-add-remove-point** *eventspec*
: The value of this option is an event specification (without bracketing angles) declaring which event will trigger adding and removing a point.

    This option can only be set at construction time.

    The default setup uses different events for adding and removing points, **ButtonPress-1** and **ButtonPress-2** respectively.

    When using this option the same event is used for both operations. This is no problem because adding is bound as canvas-global event while removal is bound to the relevant canvas items.

**-color** *colorspec*
: The value of this option is the fill color for the default item created when adding a point, and no **-create-cmd** is specified.

    The default value is **SkyBlue2**.

**-create-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when it has to create a new point.

    While this option can be set after construction, it is recommended to use this feature only as a means of inserting custom processing to be done at creation time which remembers and calls the previous value of the option.

    If not specified it defaults to a command which will create a black-bordered blue circle of radius 3 centered on the location of the new point.

    The signature of this command prefix is

    **createCmd** *canvas* *x* *y*
    : The result of the command prefix *must* be a list of the canvas items it created to represent the marker. Note here that the visual representation of a "point" may consist of multiple canvas items in an arbitrary shape.

        The returned list of items is allowed to be empty, and such is taken as signal that the callback vetoed the creation of the point.


**-data-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when a point was edited in some way. This is how the editor delegates the actual storage of point information to an outside object.

    This option can only be set at construction time.

    If not specified it defaults to an empty string and is ignored by the editor, i.e. not invoked.

    The signatures of this command prefix are

    **dataCmd** **add** *editorObj* *id* *x* *y*
    : This callback is invoked when a new point was added to the instance, either interactively, or programmatically. See instance method **add** for the latter.

        The *id* identifies the point within the editor and will be used by the two other callbacks to specify which point to modify.

        The last two arguments *x* and *y* specify the location of the new point in canvas coordinates.

        The result of this method is ignored.

    **dataCmd** **remove** *editorObj* *id*
    : This callback is invoked when a point removed from the editor instance.

        The *id* identifies the removed point within the editor.

        The result of this method is ignored.

    **dataCmd** **move start** *editorObj* *id*
    : This callback is invoked when the movement of a point in the editor instance has started.

        The *id* identifies the point within the editor about to be moved.

        The result of this method is ignored.

    **dataCmd** **move delta** *editorObj* *id* *x* *y* *dx* *dy*
    : This callback is invoked when the point moved in the editor instance.

        The *id* identifies the moved point within the editor, and the remaining arguments *x*, *y*, *dx*, and *dy* provide the new absolute location of the point, and full delta to the original location.

        At the time of the calls the system is *not* committed to the move yet. Only after method **move done** was invoked and has accepted or rejected the last position will the editor update its internal data structures, either committing to the new location, or rolling the move back to the original one.

        Given this the location data provided here should be saved only in temporary storage until then.

        The result of this method is ignored.

    **dataCmd** **move done** *editorObj* *id*
    : This callback is invoked when the movement of a point in the editor instance is complete.

        The *id* identifies the moved point within the editor.

        The result of this method must be a boolean value. If the method returns **false** the move is vetoed and rollbed back.


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

**-radius** *int*
: The value of this option is the radius for the default item created when adding a point, and no **-create-cmd** is specified.

    The default value is **3**.

**-tag** *string*
: The value of this option is the name of the canvas tag with which to identify all items of all points managed by the editor.

    This option can only be set at construction time.

    If not specified it defaults to **POINT**


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
