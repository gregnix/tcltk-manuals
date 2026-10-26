# The `scrollutil::scrollableframe` and  
 `scrollutil::adaptBtn2EventHandling` Commands

## For Scrollutil Version 2.11

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The scrollutil::scrollableframe Command – Quick Reference](#the-scrollutil-scrollableframe-command-quick-reference)
- [The scrollutil::scrollableframe Command – Detailed Reference](#the-scrollutil-scrollableframe-command-detailed-reference)
- [The scrollutil::adaptBtn2EventHandling Command](#the-scrollutil-adaptbtn2eventhandling-command)
- [Comparison with BWidget ScrollableFrame and iwidgets::scrolledframe](#comparison-with-bwidget-scrollableframe-and-iwidgets-scrolledframe)

[Start page](index.md)

---

## The `scrollutil::scrollableframe` Command – Quick Reference

[NAME](#the-scrollutil-scrollableframe-command-detailed-reference)
: `scrollutil::scrollableframe` – Create and manipulate scrollableframe widgets

[SYNOPSIS](#the-scrollutil-scrollableframe-command-detailed-reference)
: 

```
scrollutil::scrollableframe pathName ?options?
```

[STANDARD OPTIONS](#the-scrollutil-scrollableframe-command-detailed-reference)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor       -xscrollcommand
-cursor       -highlightthickness   -yscrollcommand
```

[WIDGET-SPECIFIC OPTIONS](#the-scrollutil-scrollableframe-command-detailed-reference)
: `-contentheight screenDistance`

: `-contentwidth screenDistance`

: `-fitcontentheight boolean`

: `-fitcontentwidth boolean`

: `-height screenDistance`

: `-takefocus 0|1|""|command`

: `-width screenDistance`

: `-xscrollincrement screenDistance`

: `-yscrollincrement screenDistance`

[WIDGET COMMAND](#the-scrollutil-scrollableframe-command-detailed-reference)
: `pathName attrib ?name ?value name value ...??`

: `pathName autofillx ?boolean?`

: `pathName autofilly ?boolean?`

: `pathName autosize ?w|h|wh?`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName contentframe`

: `pathName hasattrib name`

: `pathName preparescan`

: `pathName preparescroll`

: `pathName scan option args`

: `pathName scan mark x y`

: `pathName scan dragto x y ?gain?` 


: `pathName see widget ?nw|ne|sw|se?`

: `pathName seerect x1 y1 x2 y2 ?nw|ne|sw|se?`

: `pathName unsetattrib name`

: `pathName xview ?args?`

: `pathName xview`

: `pathName xview units`

: `pathName xview moveto fraction`

: `pathName xview scroll number units|pages`


: `pathName yview ?args?`

: `pathName yview`

: `pathName yview units`

: `pathName yview moveto fraction`

: `pathName yview scroll number units|pages`


[KEYWORDS](#the-scrollutil-scrollableframe-command-detailed-reference)
: scrollableframe, widget, frame, scrollable


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::scrollableframe` Command – Detailed Reference

**NAME**
: `scrollutil::scrollableframe` – Create and manipulate scrollableframe widgets

**SYNOPSIS**
: 

```
scrollutil::scrollableframe pathName ?options?
```

**DESCRIPTION**
: The `scrollutil::scrollableframe` command creates a new window named `pathName` and of the class `Scrollableframe`, and makes it into a **scrollableframe** widget.  Additional options, described below, may be specified on the command line or in the option database to configure aspects of the scrollableframe widget such as its width, height, and scrolling increments.  The `scrollutil::scrollableframe` command returns its `pathName` argument.  At the time this command is invoked, there must not exist a window named `pathName`, but `pathName`'s parent must exist.

: A scrollableframe is a mega-widget containing a **content frame**, whose dimensions may be larger than those of the widget itself.  Arbitrary regions of this frame can be brought into view by scrolling, being that the scrollableframe widget supports the `-xscrollcommand` and `-yscrollcommand` configuration options and the associated Tcl command has the `xview` and `yview` subcommands.  The content frame may contain any number of arbitrary widgets.  In other words, the `scrollutil::scrollableframe` command implements a **scrollable widget container**.

: In the Scrollutil package both the scrollableframe widget and its content frame are implemented as Tk core frames, while in Scrollutil_tile they are ttk::frame widgets.  The content frame can be accessed by means of the `contentframe` subcommand.  Individual widgets contained in it can be made visible in the scrollableframe window with the aid of the `see` subcommand.  In addition to scrolling, scrollableframe widgets also support scanning, with the aid of appropriate mouse event bindings that invoke the `scan` subcommand.

: A scrollableframe widget is typically created within a [scrollarea](scrollarea.md), like in the following example:

```
set sa [scrollutil::scrollarea ...]
set sf [scrollutil::scrollableframe $sa.sf ...]
$sa setwidget $sf

set cf [$sf contentframe]
<populate the content frame>

$sf autosize w
update idletasks
$sf configure -height ... -yscrollincrement ...

pack $sa -expand yes -fill both
```

: **REMARK:**  After creating the scrollableframe widget, the `scrollutil::scrollableframe` command automatically registers it for scrolling with the mouse wheel or touchpad, by passing its path name to the `scrollutil::enableScrollingByWheel` command.

**STANDARD OPTIONS**
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor       -xscrollcommand
-cursor       -highlightthickness   -yscrollcommand
```

: See the **options** manual entry for details on the standard Tk widget options.  The `-background`, `-highlightbackground`, `-highlightcolor`, and `-highlightthickness` options are only supported by the Scrollutil package, but not by Scrollutil_tile.  They have the same default values as the options of the same names for Tk frame widgets.  The default values of the remaining standard options are:


```
-borderwidth 0 -cursor "" -relief flat -xscrollcommand "" -yscrollcommand ""
```

**WIDGET-SPECIFIC OPTIONS**
: 

|   |   |
| --- | --- |
| Command-Line Name:  | `-contentheight` |
| Database Name: | ` contentHeight` |
| Database Class: | ` ContentHeight` |

Specifies the desired height for the content frame in any of the forms acceptable to `Tk_GetPixels`.  If the option's value is less than or equal to zero then the content frame's height is made just large enough to hold all its children.  This option is only relevant if the value of the `-fitcontentheight` option is false; otherwise the content frame will have the same height as the scrollableframe window (excluding the latter's border and highlight rectangle, if any), regardless of the value of the `-contentheight` option.  The default is `0`, which is suitable for the vast majority of applications.


|   |   |
| --- | --- |
| Command-Line Name:  | `-contentwidth` |
| Database Name: | ` contentWidth` |
| Database Class: | ` ContentWidth` |

Specifies the desired width for the content frame in any of the forms acceptable to `Tk_GetPixels`.  If the option's value is less than or equal to zero then the content frame's width is made just large enough to hold all its children.  This option is only relevant if the value of the `-fitcontentwidth` option is false; otherwise the content frame will have the same width as the scrollableframe window (excluding the latter's border and highlight rectangle, if any), regardless of the value of the `-contentwidth` option.  The default is `0`, which is suitable for the vast majority of applications.


|   |   |
| --- | --- |
| Command-Line Name:  | `-fitcontentheight` |
| Database Name: | ` fitContentHeight` |
| Database Class: | ` FitContentHeight` |

Specifies a boolean value indicating whether or not the content frame should have the same height as the scrollableframe window (excluding the latter's border and highlight rectangle, if any).  If true then the content frame's height will be kept in sync with that of the widget and the value of the `-contentheight` option will be ignored.  The default is `0`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-fitcontentwidth` |
| Database Name: | ` fitContentWidth` |
| Database Class: | ` FitContentWidth` |

Specifies a boolean value indicating whether or not the content frame should have the same width as the scrollableframe window (excluding the latter's border and highlight rectangle, if any).  If true then the content frame's width will be kept in sync with that of the widget and the value of the `-contentwidth` option will be ignored.  The default is `0`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-height` |
| Database Name: | ` height` |
| Database Class: | ` Height` |

Specifies the desired height for the scrollableframe widget in any of the forms acceptable to `Tk_GetPixels`.  Note that this sets the *inner* height, excluding the border and highlight rectangle (if any) drawn around the outside of the widget.  The default is `7c`, which should be overridden with a suitable application-specific value.


|   |   |
| --- | --- |
| Command-Line Name:  | `-takefocus` |
| Database Name: | ` takeFocus` |
| Database Class: | ` TakeFocus` |

This option determines whether the scrollableframe widget accepts the focus during keyboard traversal.  It is almost identical to the standard option of the same name (see the **options** manual entry for details).  The only difference is that not the scrollableframe widget itself but its content frame will receive the focus during keyboard traversal with the standard keys (`Tab` and `Shift-Tab`).  The default is `0`, being that a scrollableframe widget is esentially a frame used as a view for its content frame component.


|   |   |
| --- | --- |
| Command-Line Name:  | `-width` |
| Database Name: | ` width` |
| Database Class: | ` Width` |

Specifies the desired width for the scrollableframe widget in any of the forms acceptable to `Tk_GetPixels`.  Note that this sets the *inner* width, excluding the border and highlight rectangle (if any) drawn around the outside of the widget.  The default is `10c`, which should be overridden with a suitable application-specific value.


|   |   |
| --- | --- |
| Command-Line Name:  | `-xscrollincrement` |
| Database Name: | ` xScrollIncrement` |
| Database Class: | ` ScrollIncrement` |

Specifies an increment for horizontal scrolling, in any of the forms acceptable to `Tk_GetPixels`.  If the value of this option is greater than zero then the horizontal view in the window will be constrained so that the x coordinate within the content frame at the left edge of the window is always an even multiple of `xScrollIncrement`; furthermore, the units for horizontal scrolling (see the `xview` subcommad) will also be `xScrollIncrement`.  If the value is less than or equal to zero then the horizontal scrolling is unconstrained.  The default is `0`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-yscrollincrement` |
| Database Name: | ` yScrollIncrement` |
| Database Class: | ` ScrollIncrement` |

Specifies an increment for vertical scrolling, in any of the forms acceptable to `Tk_GetPixels`.  If the value of this option is greater than zero then the vertical view in the window will be constrained so that the y coordinate within the content frame at the top edge of the window is always an even multiple of `yScrollIncrement`; furthermore, the units for vertical scrolling (see the `yview` subcommad) will also be `yScrollIncrement`.  If the value is less than or equal to zero then the vertical scrolling is unconstrained.  The default is `0`.

**WIDGET COMMAND**
: The `scrollutil::scrollableframe` command creates a new Tcl command whose name is `pathName`.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

: `option` and the `arg`s determine the exact behavior of the command.  The following commands are possible for scrollableframe widgets:


`pathName attrib ?name ?value name value ...??`
: Queries or modifies the attributes of the widget.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for `pathName`.  If `name` is specified with no `value`, then the command returns the value of the one named attribute, or an empty string if no corresponding value exists (you can use the `hasattrib` subcommand to distinguish this case from the one that the value of an *existing* attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given widget attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName autofillx ?boolean?`
: Controls or queries whether the content frame will fill the widget's entire inner width.  If the optional boolean argument is true then the command sets the `-fitcontentwidth` option to true if the content frame's requested width is less than the scrollableframe's inner width and to false otherwise.  Moreover, the command makes sure that this action will be repeated whenever the content frame's requested width or the scrollableframe's inner width changes.  If the optional argument is false then the command clears the flag that controls this dynamic action.  In both cases, the return value is an empty string.  Without the optional argument the command returns the current value of the above-mentioned flag.

`pathName autofilly ?boolean?`
: Controls or queries whether the content frame will fill the widget's entire inner height.  If the optional boolean argument is true then the command sets the `-fitcontentheight` option to true if the content frame's requested height is less than the scrollableframe's inner height and to false otherwise.  Moreover, the command makes sure that this action will be repeated whenever the content frame's requested height or the scrollableframe's inner height changes.  If the optional argument is false then the command clears the flag that controls this dynamic action.  In both cases, the return value is an empty string.  Without the optional argument the command returns the current value of the above-mentioned flag.

`pathName autosize ?dimensions?`
: This command sets the `-width` and/or `-height` option of the scrollableframe to the requested width and/or height of its content frame, according to the optional `dimensions` argument, whose possible values are `w` (width), `h` (height), and `wh` (width and height).  The default is an empty string, meaning that neither the width nor the height is *explicitly* requested to be set.  Note that if the value of the `-fitcontentwidth` option is true then the command sets the widget's inner width to the requested width of its content frame, regardless of whether this was *explicitly* specified or not.  Similarly, if the value of the `-fitcontentheight` option is true then the command sets the widget's inner height to the requested height of its content frame, even if this was not *explicitly* specified.

: **REMARK:**  Setting the widget's inner width and/or height on behalf of this subcommand is executed as an  `"after 100"`  callback, to make sure that by the time the widget's width and/or height are set, the geometry management calculations in its content frame are finished.

`pathName cget option`
: Returns the current value of the configuration option given by `option`, which may have any of the values accepted by the `scrollutil::scrollableframe` command.

`pathName configure ?option ?value option value ...??`
: Queries or modifies the configuration options of the widget.  If no `option` is specified, the command returns a list describing all of the available options for `pathName` (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values accepted by the `scrollutil::scrollableframe` command.

`pathName contentframe`
: Returns the path name of the widget's content frame.

`pathName hasattrib name`
: Returns `1` if the attribute `name` exists and `0` otherwise.

`pathName preparescan`
: Prepares the scrollableframe for scanning, by passing its descendants located in the same toplevel and having bindings for mouse button 2 events to the `scrollutil::adaptBtn2EventHandling` command.

: **REMARK:**  If the scrollableframe has many descendants then it is much safer to invoke this subcommand than to manually pass a lot of widgets to `scrollutil::adaptBtn2EventHandling`, because deciding which descendants to process can become tedious and error-prone.

`pathName preparescroll`
: Prepares the scrollableframe for scrolling with the mouse wheel and touchpad, by passing its descendants located in the same toplevel and having bindings for mouse wheel or `<TouchpadScroll>` events to the `scrollutil::adaptWheelEventHandling` command.

: **REMARK:**  Invoking this subcommand is just a shortcut for passing `pathName` to the `scrollutil::prepareScrollingByWheel` command.

`pathName scan option args`
: This command is used to implement scanning on scrollableframe widgets.  It has two forms, depending on `option`:


`pathName scan mark x y`
: Records `x` and `y` and the current view in the scrollableframe window; used in conjunction with later  `scan dragto`  commands.  Typically this command is associated with a mouse button press in the widget and `x` and `y` are the coordinates of the mouse.  It returns an empty string.

`pathName scan dragto x y ?gain?`
: This command computes the difference between its `x` and `y` arguments (which are typically mouse coordinates) and the `x` and `y` arguments to the last  `scan mark`  command for the widget.  It then adjusts the view by `gain` times the difference in coordinates, where `gain` defaults to `10`, except on Android, where the default is `2`, being that this value suits better the emulation of mouse button 2 events with one-finger gestures.  This command is typically associated with mouse motion events in the widget, to produce the effect of dragging the content frame at high speed through the window.  The return value is an empty string.


`pathName see widget ?corner?`
: This command adjusts the view in the scrollableframe's window so that `widget` becomes visible in it.  The specified widget must be a descendant of the content frame and must have the same toplevel.  In addition, it must be managed by some geometry manager (such as `grid`, `pack`, `place`, `text`, or `canvas`).  The optional `corner` argument specifies which corner of `widget` should become visible if it is too large to fit into the window.  The possible values are `nw` (north-west), `ne` (north-east), `sw` (south-west), and `se` (south-east).  The default corner is `nw`.

: **REMARK:**  By using this subcommand you can make the keyboard navigation in the content frame more user-friendly, like in the following example, in which `$w` is a descendant of the content frame of the scrollableframe widget `$sf` (it is assumed that `$sf` doesn't contain `%` characters):


```
bind $w <<TraverseIn>> [list $sf see %W]
```

: If the widget `$w` was embedded into a [scrollarea](scrollarea.md) via the latter's `setwidget` subcommand, and the scrollarea in turn is a descendant of the content frame, then it is more user-friendly to bring the scrollarea into view rather than just the widget:


```
bind $w <<TraverseIn>> [list seeScrollarea $sf %W]

proc seeScrollarea {sf w} { $sf see [scrollutil::getscrollarea $w] }
```

`pathName seerect x1 y1 x2 y2 ?corner?`
: This command adjusts the view in the scrollableframe's window so that the rectangle given by `x1`, `y1`, `x2`, and `y2` becomes visible in it.  These coordinates are relative to the content frame and specify two diagonally opposite corners of the rectangle (which will include its upper and left edges but not its lower or right edges).  The optional `corner` argument specifies which corner of the rectangle should become visible if it is too large to fit into the window.  The possible values are `nw` (north-west), `ne` (north-east), `sw` (south-west), and `se` (south-east).  The default corner is `nw`.

`pathName unsetattrib name`
: Unsets the attribute `name`.  Returns an empty string.

`pathName xview ?args?`
: This command is used to query and change the horizontal position of the information displayed in the widget's window.  It can take any of the following forms:


`pathName xview`
: Returns a list containing two elements.  Each element is a real fraction between `0` and `1`; together they describe the horizontal span that is visible in the window.  For example, if the first element is `0.2` and the second element is `0.6` then 20% of the content frame is off-screen to the left, the middle 40% is visible in the window, and 40% of the content frame is off-screen to the right.  These are the same values passed to scrollbars via the `-xscrollcommand` option.

`pathName xview units`
: Adjusts the view in the window so that the content frame position given by `units` is displayed at the left edge of the window.  This argument specifies a number of units of the `xScrollIncrement` option if it is greater than zero, or of one-tenth the window's inner width otherwise.

`pathName xview moveto fraction`
: Adjusts the view in the window so that `fraction` of the total width of the content frame is off-screen to the left.  `fraction` must be a fraction between `0` and `1`.

`pathName xview scroll number what`
: This command shifts the view in the window left or right according to `number` and `what`.  `number` must be an integer or a float; if it is a float then it is converted to an integer, rounded away from `0`.  `what` must be either `units` or `pages` or an abbreviation of one of these.  If `what` is `units`, the view adjusts left or right in units of the `xScrollIncrement` option if it is greater than zero, or in units of one-tenth the window's inner width otherwise.  If `what` is `pages` then the view adjusts in units of nine-tenths the window's inner width.  If `number` is negative then information farther to the left becomes visible; if it is positive then information farther to the right becomes visible.


`pathName yview ?args?`
: This command is used to query and change the vertical position of the information displayed in the widget's window.  It can take any of the following forms:


`pathName yview`
: Returns a list containing two elements.  Each element is a real fraction between `0` and `1`; together they describe the vertical span that is visible in the window.  For example, if the first element is `0.2` and the second element is `0.6` then 20% of the content frame is off-screen to the top, the middle 40% is visible in the window, and 40% of the content frame is off-screen to the bottom.  These are the same values passed to scrollbars via the `-yscrollcommand` option.

`pathName yview units`
: Adjusts the view in the window so that the content frame position given by `units` is displayed at the top edge of the window.  This argument specifies a number of units of the `yScrollIncrement` option if it is greater than zero, or of one-tenth the window's inner height otherwise.

`pathName yview moveto fraction`
: Adjusts the view in the window so that `fraction` of the total height of the content frame is off-screen to the top.  `fraction` must be a fraction between `0` and `1`.

`pathName yview scroll number what`
: This command shifts the view in the window up or down according to `number` and `what`.  `number` must be an integer or a float; if it is a float then it is converted to an integer, rounded away from `0`.  `what` must be either `units` or `pages` or an abbreviation of one of these.  If `what` is `units`, the view adjusts up or down in units of the `yScrollIncrement` option if it is greater than zero, or in units of one-tenth the window's inner height otherwise.  If `what` is `pages` then the view adjusts in units of nine-tenths the window's inner height.  If `number` is negative then information farther to the top becomes visible; if it is positive then information farther to the bottom becomes visible.



**BINDINGS**
: Mouse button 2 may be used for scanning.  If it is pressed and dragged over a free area of the scrollableframe window, the content frame drags at high speed in the direction the mouse moves.  The same happens if a descendant was clicked that either has no bindings for mouse button 2 events, or was passed to the `scrollutil::adaptBtn2EventHandling` command, and the focus is outside the window  `[focusCheckWindow descendant]`.

: **REMARK:**  On Android, the support for scanning with mouse button 2 implies scan support via one-finger gestures, because fast wipes with one finger are translated by AndroWish to `<Button-2>`, `<B2-Motion>`, and `<ButtonRelease-2>` events.

**KEYWORDS**
: scrollableframe, widget, frame, scrollable


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::adaptBtn2EventHandling` Command

**NAME**
: `scrollutil::adaptBtn2EventHandling` – Adapt mouse button 2 event handling

**SYNOPSIS**
: 

```
scrollutil::adaptBtn2EventHandling ?widget widget ...?
```

**DESCRIPTION**
: For each `widget` argument, the command performs the following actions:


  -  If `widget` is the path name of a [tablelist](https://www.nemethi.de/tablelist/) widget then it sets the latter's `-button2window` option to the path name of the containing toplevel window, provided that the Tablelist version is 7.6 or later (for earlier Tablelist versions the command silently ignores any tablelist widget passed to it as argument).  As a result, a `<Button-2>`, `<B2-Motion>`, or `<ButtonRelease-2>` event sent to the tablelist's body or edit window (more precisely, a mouse button 2 event sent to any component of the tablelist having the binding tag `TablelistBody` or `TablelistEdit`) will be handled as follows:  
  -  Otherwise it locates the (first) binding tag that has mouse button 2 event bindings and is different from both the path name of the containing toplevel window and `all`.  If the search for this tag was successful then the command modifies the widget's list of binding tags by prepending the tag `Btn2EventRedir` and appending the tag `Btn2EventBreak` to this binding tag.  As a result, a `<Button-2>`, `<B2-Motion>`, or `<ButtonRelease-2>` event sent to this widget will be handled as follows:  

    - If the focus is inside the tablelist widget then the event will will trigger a scanning of the content of the tablelist or its edit window and no further processing of the event will take place.
    - If the focus is outside the tablelist widget then no scanning within the tablelist's body or edit window will happen.  Instead, the event will be redirected to the containing toplevel window via  `event generate`.  This in turn will trigger a scanning of the content of the (innermost) scrollableframe that is an ancestor of `widget` and has the same toplevel (if there is such a scrollableframe widget).

    - If the focus is on or inside the window  `[focusCheckWindow widget]`  then the event will be handled by the binding script associated with this tag and no further processing of the event will take place.
    - If the focus is outside the window  `[focusCheckWindow widget]`  then the event will be redirected to the containing toplevel window via  `event generate`  rather than being handled by the binding script associated with the above-mentioned tag.  This in turn will trigger a scanning of the content of the (innermost) scrollableframe that is an ancestor of `widget` and has the same toplevel (if there is such a scrollableframe widget).

: **REMARK 1:**  This command is designed to be invoked for widgets that have mouse button 2 event bindings and are descendants of a scrollableframe.  The Tk and tile widgets having class bindings for mouse button 2 events area: Tk core entry, ttk::entry, ttk::combobox, listbox, panedwindow, Tk core scale, ttk::scale, Tk core spinbox, ttk::spinbox, Tk core scrollbar, ttk::scrollbar, and text.  Examples of widgets with binding tags other than their class names that have mouse button 2 event bindings are ctext and tablelist widgets.  (In case of a ctext widget `w`, the binding tags mentioned in the description above refer to the widget's main text widget child `w.t` rather than to the widget itself.)

: **REMARK 2:**  As mentioned above, Tk core scrollbar and ttk::scrollbar widgets have class bindings for mouse button 2 events, hence this command should be invoked for them in case they are descendants of a scrollableframe widget.  Since this task can become tedious, Scrollutil makes sure that if you pass a widget to this command and that widget is embedded into a [scrollarea](scrollarea.md) via the latter's `setwidget` subcommand, then this command will automatically be invoked for the scrollbars of that scrollarea, too.

: **REMARK 3:**  When handling a mouse button 2 event sent to a Tk core or tile scrollbar whose path name was passed to this command, if the focus is on or inside the associated widget then the event will be processed by the scrollbar rather than being redirected to the containing toplevel, just as if the focus were on the scrollbar itself.

**KEYWORDS**
: mouse button 2 event, binding, event handling, scanning, scrollableframe, focus


[Contents](#contents)     [Start page](index.md)

---

## Comparison with BWidget ScrollableFrame and iwidgets::scrolledframe

The scrollutil::scrollableframe widget was designed as a lightweight, theme-able, and full-featured replacement for BWidget ScrollableFrame and iwidgets::scrolledframe.  The following table contains a comparison of the options and commands provided by the three widgets:

| scrollutil::scrollableframe | BWidget ScrollableFrame | iwidgets::scrolledframe |
| --- | --- | --- |
| `-background` | `-background` | `-background` |
| `-borderwidth` |  | `-borderwidth` |
| `-cursor` |  | `-cursor` |
| `-contentheight` | `-areaheight` | `[pathName component canvas] \ itemconfigure frameTag -height ...` |
| `-contentwidth` | `-areawidth` | `[pathName component canvas] \ itemconfigure frameTag -width ...` |
| `-fitcontentheight` | `-constrainedheight` | `bind [pathName component canvas] <Configure> \ { %W itemconfigure frameTag -height %h }` |
| `-fitcontentwidth` | `-constrainedwidth` | `bind [pathName component canvas] <Configure> \ { %W itemconfigure frameTag -width %w }` |
| `-height`  (sets the *inner* height, excluding    the border and highlight rectangle, if any) | `-height`  (inner height = total height) | `-height`  (sets the *total* height, including    the border and horizontal scrollbar, if any) |
| `-highlightbackground` |  |  |
| `-highlightcolor` |  |  |
| `-highlightthickness` |  |  |
| `-relief` |  | `-relief` |
| `-takefocus` |  |  |
| `-width`  (sets the *inner* width, excluding    the border and highlight rectangle, if any) | `-width`  (inner width = total width) | `-width`  (sets the *total* width, including    the border and vertical scrollbar, if any) |
| `-xscrollcommand` | `-xscrollcommand` |  |
| `-xscrollincrement` | `-xscrollincrement` | `-xscrollincrement` for `[pathName component canvas]` |
| `-yscrollcommand` | `-yscrollcommand` |  |
| `-yscrollincrement` | `-yscrollincrement` | `-yscrollincrement` for `[pathName component canvas]` |
|  |  |  |
| `attrib` |  |  |
| `autosize` |  |  |
| `autofillx` |  |  |
| `autofilly` |  |  |
| `cget` | `cget` | `cget` |
| `configure` | `configure` | `configure` |
| `contentframe` | `getframe` | `childsite` |
| `hasattrib` |  |  |
| `preparescan` |  |  |
| `preparescroll` |  |  |
| `scan`  (with mouse event bindings) |  |  |
| `see widget ?nw\|ne\|sw\|se?` | `see widget ?top\|bottom ?left\|right??` |  |
| `seerect x1 y1 x2 y2 ?nw\|ne\|sw\|se?` |  |  |
| `unsetattrib` |  |  |
| `xview` | `xview` | `xview` |
| `yview` | `yview` | `yview` |
| `xview\|yview units` |  |  |
| `xview\|yview moveto 0\|1` | `xview\|yview moveto 0\|1` | `justify left\|right\|top\|bottom`    (shortcut for  `xview\|yview moveto 0\|1`) |

**REMARK 1:**  For the `see` command provided by the BWidget ScrollableFrame widget one cannot specify the horizontal side without the vertical one.  More annoying is, however, that in the presence of a positive `-xscrollincrement` or `-yscrollincrement` value, widgets that are small enough to fit into the window are quite often just partially brought into view.  In addition, the command works only for direct children of the ScrollableFrame widget's content frame.

**REMARK 2:**  The iwidgets::scrolledframe widget has no equivalents of the scrollutil::scrollableframe options `-contentheight`, `-contentwidth`, `-fitcontentheight`, and `-fitcontentwidth`, but these can be emulated (using undocumented internal information!) as shown above.  It provides a `justify` command, which is, however, just a shortcut for  `xview|yview moveto 0|1`.  What this widget is really missing, is a `see` command for making individual widgets visible in the window (which is important for user-friendly keyboard navigation).

[Contents](#contents)     [Start page](index.md)
