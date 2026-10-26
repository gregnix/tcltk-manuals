---
CommandName: canvas::edit::rectangle
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - editing
 - rectangle
Copyright:
---

# Name

canvas::edit::rectangle - Editing a rectangle on a canvas

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} [0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [canvas::edit::rectangle]{.lit} [0.1]{.optlit} 
[::canvas::edit]{.cmd} [rectangle]{.sub} [objectName]{.arg} [canvas]{.arg} [options...]{.arg} 
[objectName]{.cmd} [destroy]{.sub} 
[objectName]{.cmd} [enable]{.sub} 
[objectName]{.cmd} [disable]{.sub} 
[objectName]{.cmd} [active]{.sub} 
[objectName]{.cmd} [set]{.sub} [minx]{.arg} [miny]{.arg} [maxx]{.arg} [maxy]{.arg} 
[objectName]{.cmd} [clear]{.sub} 
[activeCmd]{.cmd} [editorObj]{.arg} [id]{.arg} 
[createCmd]{.cmd} [canvas]{.arg} [x]{.arg} [y]{.arg} 
[dataCmd]{.cmd} [editorObj]{.arg} [coordinates]{.arg} 
:::

# Description

This package provides a class whose instances handle editing a rectangle on a canvas. Instances can be configured with regard to the visual appearance of the markers denoting the rectangle's corners. Note that instances do not store the edited rectangle themselves, but delegate this to a configurable object.

# Interaction

The rectangle editor internally uses an instance of package **canvas::edit::points**, and inherits all the options and behaviours for it. The color options are additionally applied to the rectangle element of this editor

Beyond that it provides an option, **-rect-config**, to customize the rectangle item used to render the rectangle through its corners. Note that it cannot overide the inherited color options.

During interaction instances execute a state machine where the user creates two points, at which point the system completes the rectangle with the missing corners and reports it. At that point the system prevents adding more points. Dragging the points is still possible, enabling resizing and moving the rectangle. Deleting any corner deletes the entire rectangle, at which point the system is again ready for the creation of a new rectangle from two points.

# Class api

**::canvas::edit** **rectangle** *objectName* *canvas* *options*...
: This, the class command, creates and configures a new instance of a rectangle editor, named *objectName*. The instance will be connected to the specified *canvas* widget. The result of the command is the fully qualified name of the instance command. The options accepted here, and their values, are explained in the section **Options**.


# Instance api

Instances of the rectangle editors provide the following API:

**objectName** **destroy**
: This method destroys the rectangle editor and releases all its internal resources. Note that this operation does not destroy the items the editor managed on the attached canvas, nor the canvas itself. The result of the method is an empty string.

**objectName** **enable**
: This method activates editing of the rectangle on the canvas. This is the default after instance creation. A call is ignored if the editor is already active. The result of the method is an empty string. The complementary method is **disable**. The interogatory method for the current state is **active**.

**objectName** **disable**
: This method disables editing of the rectangle on the canvas. A call is ignored if the editor is already disabled. The result of the method is an empty string. The complementary method is **enable**. The interogatory method for the current state is **active**.

**objectName** **active**
: This method queries the editor state. The result of the method is a boolean value, **true** if the editor is active, and **false** otherwise, i.e. disabled. The methods to change the state are **enable** and **disable**.

**objectName** **set** *minx* *miny* *maxx* *maxy*
: This method programmatically set the rectangle from the border coordinates. This writes over a previous (possibly partial) rectangle. The result of the method is an empty string. Note that this method goes through the whole set of callbacks invoked when corners are created, i.e.  **-create-cmd**, and, more importantly, **-data-cmd**. This is the method through which to load a pre-existing rectangle into an editor instance.

**objectName** **clear**
: This method programmatically removes the rectangle from the editor, making the way free for creating a new one. The result of the method is an empty string. Note that this method goes through the same callbacks invoked when the user interactively removes a corner, i.e. **-data-cmd**.


# Options

The class command accepts the following options

**-active-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when the mouse enters or leaves the rectangle or a corner managed by the instance. If not specified it defaults to an empty command which does nothing. The signature of this command prefix is


**activeCmd** *editorObj* *id*
: The *id* identifies the entered object. An empty *id* indicates that the last entered object was left. The value **rect** indicates that the rectangle's outline was entered. Any other value is a code for one of the rectangle's corner, i.e. **tl**, **tr**, **bl**, and **br**. The result of this method is ignored.


**-add-remove-point** *eventspec*
: The value of this option is an event specification (without bracketing angles) declaring which event will trigger adding and removing a point. This option can only be set at construction time. The default setup uses different events for adding and removing points, **ButtonPress-1** and **ButtonPress-2** respectively. When using this option the same event is used for both operations. This is no problem because adding is bound as canvas-global event while removal is bound to the relevant canvas items.

**-color** *colorspec*
: The value of this option is the fill color for the default item created when adding a point, and no **-create-cmd** is specified. The default value is **SkyBlue2**.

**-create-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when it has to create a new corner. While this option can be set after construction, it is recommended to use this feature only as a means of inserting custom processing to be done at creation time which remembers and calls the previous value of the option. If not specified it defaults to a command which will create a black-bordered blue circle of radius 3 centered on the location of the new point. The signature of this command prefix is


**createCmd** *canvas* *x* *y*
: The result of the command prefix *must* be a list of the canvas items it created to represent the marker. Note here that the visual representation of a "corner" may consist of multiple canvas items in an arbitrary shape. The returned list of items is allowed to be empty, and such is taken as signal that the callback vetoed the creation of the corner.


**-data-cmd** *command-prefix*
: The value of this option is a command prefix the editor will invoke when the rectangle was edited in some way (created, modified, deleted). This is how the editor delegates the actual storage of the rectangle information to an outside object. This option can only be set at construction time. If not specified it defaults to an empty string and is ignored by the editor, i.e. not invoked. The signature of this command prefix is


**dataCmd** *editorObj* *coordinates*
: This callback is invoked when the rectangle was changed either interactively, or programmatically. See instance method **set** for the latter. The *editorObj* identifies the instance invoking the callback, whereas *coordinates* is a list of 4 elements, containing the min x, and y, and the max x and y coordinates of the rectangle, in this order. The result of this method is ignored.


**-drag-point** *eventspec*
: The value of this option is an event specification (without bracketing angles) declaring which event will trigger a drag action on points. This option can only be set at construction time. The default specification is **ButtonPress-3**.

**-hilit-color** *colorspec*
: The value of this option is the highlight color for the default item created when adding a point, and no **-highlight-cmd** is specified. The default value is **red**.

**-kind** *name*
: The value of this option is the canvas item type for the default item created when adding a point, and no **-create-cmd** is specified. Only item types specified through a bounding box are suitable. The default value is **oval**.

**-radius** *int*
: The value of this option is the radius for the default item created when adding a point, and no **-create-cmd** is specified. The default value is **3**.

**-rect-config** *list*
: The value of this option is a list of options and their values to be applied to the internal rectangle item whenever it is regenerated after changes. Note that these options *cannot* override the principal coloring of the rectangle as applied by the main options **-color** and **-hilit-color**. If not specified it defaults to the empty list.

**-tag** *string*
: The value of this option is the name of the canvas tag with which to identify all items of all vertices managed by the editor. This option can only be set at construction time. If not specified it defaults to **RECTANGLE**


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
