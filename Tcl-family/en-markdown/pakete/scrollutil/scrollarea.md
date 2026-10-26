# The `scrollutil::scrollarea` and  
 `scrollutil::getscrollarea` Commands

## For Scrollutil Version 2.11

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The scrollutil::scrollarea Command – Quick Reference](#the-scrollutil-scrollarea-command-quick-reference)
- [The scrollutil::scrollarea Command – Detailed Reference](#the-scrollutil-scrollarea-command-detailed-reference)
- [The scrollutil::getscrollarea Command](#the-scrollutil-getscrollarea-command)

[Start page](index.md)

---

## The `scrollutil::scrollarea` Command – Quick Reference

[NAME](#the-scrollutil-scrollarea-command-detailed-reference)
: `scrollutil::scrollarea` – Create and manipulate scrollarea widgets

[SYNOPSIS](#the-scrollutil-scrollarea-command-detailed-reference)
: 

```
scrollutil::scrollarea pathName ?options?
```

[STANDARD OPTIONS](#the-scrollutil-scrollarea-command-detailed-reference)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

[WIDGET-SPECIFIC OPTIONS](#the-scrollutil-scrollarea-command-detailed-reference)
: `-autohidescrollbars boolean`

: `-lockinterval milliseconds`

: `-respectheader boolean`

: `-respecttitlecolumns boolean`

: `-setfocus boolean`

: `-takefocus 0|1|""|command`

: `-xscrollbarmode static|dynamic|none`

: `-yscrollbarmode static|dynamic|none`

[WIDGET COMMAND](#the-scrollutil-scrollarea-command-detailed-reference)
: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName hasattrib name`

: `pathName setwidget widget`

: `pathName unsetattrib name`

: `pathName widget`

[KEYWORDS](#the-scrollutil-scrollarea-command-detailed-reference)
: scrollarea, widget, scrollbar


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::scrollarea` Command – Detailed Reference

**NAME**
: `scrollutil::scrollarea` – Create and manipulate scrollarea widgets

**SYNOPSIS**
: 

```
scrollutil::scrollarea pathName ?options?
```

**DESCRIPTION**
: The `scrollutil::scrollarea` command creates a new window named `pathName` and of the class `Scrollarea`, and makes it into a **scrollarea** widget.  Additional options, described below, may be specified on the command line or in the option database to configure aspects of the scrollarea such as its borderwidth, relief, and display mode to be used for the scrollbars.  The `scrollutil::scrollarea` command returns its `pathName` argument.  At the time this command is invoked, there must not exist a window named `pathName`, but `pathName`'s parent must exist.

: A scrollarea is a mega-widget consisting of a scrollable widget specified with the aid of the `setwidget` subcommand of the associated Tcl command as well as two scrollbars connected with that widget.  These components are managed within the scrollarea using `grid`.  The scrollbars, named `hsb` (with  `-orient horizontal`)  and `vsb` (with  `-orient vertical`)  are direct children of the scrollarea.  The display mode of each scrollbar can be `static`, `dynamic`, or `none` (see the `-xscrollbarmode` and `-yscrollbarmode` configuration options).  The `-takefocus` option of both scrollbars is set to `0`.  In the Scrollutil_tile package the scrollbars are created as ttk::scrollbar widgets, except on Mac OS X/11+ when using a Tk release earlier than 8.6.10, where the native ttk::scrollbar widget of the `aqua` theme didn't yet look as expected.

: If the widget embedded into the scrollarea via `setwidget` is a [tablelist](https://www.nemethi.de/tablelist/) and Tablelist version 6.5 or later is being used then the scrollarea can also contain siblings of the tablelist widget above the vertical scrollbar and/or to the left of the horizontal one, causing the vertical scrollbar to be displayed below the tablelist's header and/or the horizontal scrollbar to appear to the right of the tablelist's title column area, depending on the values of the `-respectheader` and `-respecttitlecolumns` configuration options.

: The following example shows the typical steps involved in creating a widget within a scrollarea:

```
set sa [scrollutil::scrollarea ...]
set lb [listbox $sa.lb ...]
$sa setwidget $lb

pack $sa -expand yes -fill both
```

**STANDARD OPTIONS**
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

: See the **options** manual entry for details on the standard Tk widget options.  The `-background`, `-highlightbackground`, `-highlightcolor`, and `-highlightthickness` options are only supported by the Scrollutil package, but not by Scrollutil_tile.  They have the same default values as the options of the same names for Tk frame widgets.  The default values of the remaining standard options are:


```
-borderwidth 1 -cursor "" -relief sunken
```

: **REMARK:**  When configuring the `-borderwidth` or `-relief` option, if as a result of this action the scrollarea has a positive `-borderwidth` value (e.g., the default `1`) and a `-relief` value other than `flat` (e.g., the default `sunken`), then the `-borderwidth` option of the widget embedded into the scrollarea via the `setwidget` subcommand of the associated Tcl command will automatically be set to `0`, provided that the embedded widget supports this option.

**WIDGET-SPECIFIC OPTIONS**
: 

|   |   |
| --- | --- |
| Command-Line Name:  | `-autohidescrollbars` |
| Database Name: | ` autoHideScrollbars` |
| Database Class: | ` AutoHideScrollbars` |

Specifies a boolean value indicating whether the scrollbars should be obscured if the focus is outside the toplevel window containing the scrollarea or the mouse pointer is outside the scrollarea widget.  The default is `0`.

**REMARK 1:**  The easiest way to override the default value for all scrollarea instances of your application is to insert the line

```
option add *Scrollarea.autoHideScrollbars 1
```

somewhere at the top of your script (before creating any scrollarea widgets).

**REMARK 2:**  To obscure a scrollbar, Scrollutil just lays a frame over it, thus keeping the area occupied by it reserved (if it was previously mapped).  This is different from unmapping a dynamic scrollbar when there is nothing to scroll in the widget embedded into the scrollarea.  Obscuring or unobscuring a scrollbar doesn't change its mapped/unmapped state.

**REMARK 3:**  Regardless of the focus and the value of this option, if the mouse pointer is inside the scrollarea and the widget embedded into it via `setwidget` gets scrolled (e.g., with the aid of the mouse wheel or touchpad), then the scrollbars will be unobscured.


|   |   |
| --- | --- |
| Command-Line Name:  | `-lockinterval` |
| Database Name: | ` lockInterval` |
| Database Class: | ` LockInterval` |

Specifies the time interval in milliseconds for which the scrollbars having the display mode `dynamic` (see the `-xscrollbarmode` and `-yscrollbarmode` options) will be protected from being unmapped after being mapped, in order to avoid any shimmering effects.  This is also the time interval for which the dynamic scrollbars will mutually protect each other from being mapped after one of them got mapped.  Without this locking mechanism, under some rare circumstances a dynamic scrollbar could get mapped and unmapped in an endless loop, thus giving rise to an annoying and often dangerous flickering effect.  The same problem can arise due to a too small `-lockinterval` value.  The default is `1`, which works as expected in the vast majority of cases.  Should you experience any shimmering in one of your scrollarea widgets, just set this option for that scrollarea to a sufficiently large value (e.g., `100`).  Note, however, that this value should not be greater than `300`, because, for implementation-specific reasons, a `-lockinterval` value greater than `300` can prevent a dynamic scrollbar that should be hidden from being unmapped, or one that should be shown from being mapped.


|   |   |
| --- | --- |
| Command-Line Name:  | `-respectheader` |
| Database Name: | ` respectHeader` |
| Database Class: | ` RespectHeader` |

This option is only relevant if the widget embedded into the scrollarea with the aid of the `setwidget` subcommand of the associated Tcl command is a [tablelist](https://www.nemethi.de/tablelist/) and the Tablelist version being used is 6.5 or later.  Its value must be a boolean specifying whether the vertical scrollbar should appear below the tablelist widget's header, thus respecting the native look & feel on Mac OS X/11+ and on many modern Linux systems.  The default is `1` on the windowing systems `aqua` and `x11`, and `0` on `win32`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-respecttitlecolumns` |
| Database Name: | ` respectTitleColumns` |
| Database Class: | ` RespectTitleColumns` |

This option is only relevant if the widget embedded into the scrollarea with the aid of the `setwidget` subcommand of the associated Tcl command is a [tablelist](https://www.nemethi.de/tablelist/) and the Tablelist version being used is 6.5 or later.  Its value must be a boolean specifying whether the horizontal scrollbar should start to the right of the tablelist widget's non-scrollable title column area if the value of the `-titlecolumns` tablelist option is positive.  The default is `1`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-setfocus` |
| Database Name: | ` setFocus` |
| Database Class: | ` SetFocus` |

Specifies a boolean value that determines whether a click with mouse button 1 or 2 on one of the scrollbars should set the focus to the widget embedded into the scrollarea with the aid of the `setwidget` subcommand if that widget is not in disabled state.  The default is `0`.

**REMARK 1:**  If the option's value is `1` and the embedded widget is a text or ctext widget then a click with mouse button 1 or 2 on one of the scrollbars will set the focus to that widget regardless of the latter's state, provided that the windowing system is `win32` or the Tk version is at least 8.6.11 or 8.7a4.  This is the same behavior as the one exhibited by the default bindings of these widgets for `<Button-1>` events.  (In case of a ctext widget `w`, the focus is set to the widget's main text widget child `w.t` rather than to the widget itself.)

**REMARK 2:**  If the option's value is `1` and the embedded widget is a ttk::treeview widget then a click with mouse button 1 or 2 on one of the scrollbars will set the focus to that widget regardless of the latter's state, on all windowing systems and for all Tk versions.  Again, this is the same behavior as the one exhibited by the default bindings of this widget for `<Button-1>` events.

**REMARK 3:**  The easiest way to override the default value for all scrollarea instances of your application is to insert the line

```
option add *Scrollarea.setFocus 1
```

somewhere at the top of your script (before creating any scrollarea widgets).


|   |   |
| --- | --- |
| Command-Line Name:  | `-takefocus` |
| Database Name: | ` takeFocus` |
| Database Class: | ` TakeFocus` |

This option determines whether the scrollarea accepts the focus during keyboard traversal.  It is almost identical to the standard option of the same name (see the **options** manual entry for details).  The only difference is that not the scrollarea itself but the widget embedded into it via the `setwidget` subcommand of the associated Tcl command will receive the focus during keyboard traversal with the standard keys (`Tab` and `Shift-Tab`).  The default is `0`, being that a scrollarea is esentially a frame containing the above-mentioned widget and two scrollbars.


|   |   |
| --- | --- |
| Command-Line Name:  | `-xscrollbarmode` |
| Database Name: | ` xScrollbarMode` |
| Database Class: | ` ScrollbarMode` |

Specifies the display mode to be used for the horizontal scrollbar.  The allowed values are `static`, `dynamic`, and `none`.  In `static` mode the scrollbar is displayed at all times.  In `dynamic` mode (which is the default) the scrollbar is mapped and unmapped as needed.  The display mode `none` disables the scrollbar display.


|   |   |
| --- | --- |
| Command-Line Name:  | `-yscrollbarmode` |
| Database Name: | ` yScrollbarMode` |
| Database Class: | ` ScrollbarMode` |

Specifies the display mode to be used for the vertical scrollbar.  The allowed values are `static`, `dynamic`, and `none`.  In `static` mode the scrollbar is displayed at all times.  In `dynamic` mode (which is the default) the scrollbar is mapped and unmapped as needed.  The display mode `none` disables the scrollbar display.

**WIDGET COMMAND**
: The `scrollutil::scrollarea` command creates a new Tcl command whose name is `pathName`.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

: `option` and the `arg`s determine the exact behavior of the command.  The following commands are possible for scrollarea widgets:


`pathName attrib ?name ?value name value ...??`
: Queries or modifies the attributes of the widget.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for `pathName`.  If `name` is specified with no `value`, then the command returns the value of the one named attribute, or an empty string if no corresponding value exists (you can use the `hasattrib` subcommand to distinguish this case from the one that the value of an *existing* attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given widget attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName cget option`
: Returns the current value of the configuration option given by `option`, which may have any of the values accepted by the `scrollutil::scrollarea` command.

`pathName configure ?option ?value option value ...??`
: Queries or modifies the configuration options of the widget.  If no `option` is specified, the command returns a list describing all of the available options for `pathName` (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values accepted by the `scrollutil::scrollarea` command.

`pathName hasattrib name`
: Returns `1` if the attribute `name` exists and `0` otherwise.

`pathName setwidget widget`
: The `widget` argument must be the path name of an existing widget or an empty string.  In the first case, the command manages the widget to fill the top-left part of the scrollarea and connects it with the scrollbars by setting its `-xscrollcommand` and `-yscrollcommand` options to appropriate wrappers for the `set` command of the two scrollbars and setting the `-command` option of the scrollbars to  `[list widget xview]`  and  `[list widget yview]`,  respectively.  If `widget` is an empty string then the widget passed to the most recent `setwidget` invocation (if any) is unmanaged and unconnected from the scrollbars.  The return value is the argument passed to the previous successful invocation of this subcommand, or an empty string if there was no successful `setwidget` invocation before.

: **REMARK 1:**  If `widget` is nonempty and the value of the `-xscrollbarmode` option is different from `none` then `widget` must be a horizontally scrollable widget, meaning that it must support the `-xscrollcommand` configuration option and the associated Tcl command must have the `xview` subcommand.  Similarly, if `widget` is nonempty and the value of the `-yscrollbarmode` option is different from `none` then `widget` must be a vertically scrollable widget, meaning that it must support the `-yscrollcommand` configuration option and the associated Tcl command must have the `yview` subcommand.  Consequently, if `widget` is an entry or ttk::entry then this subcommand will only be successful if the `-yscrollbarmode` option was previously set to `none`.

: **REMARK 2:**  The widget identified by the `widget` argument must be a child of the scrollarea or of one of the latter's ascendants.  This minor restriction is imposed by the `grid` geometry manager.

: **REMARK 3:**  When the widget whose path name was passed to `setwidget` gets destroyed, this subcommand is automatically invoked with an empty string as argument.

: **REMARK 4:**  This subcommand sets the `-highlightthickness` option of `widget` to `0` if `widget` supports this configuration option.  In addition, if the scrollarea has a positive `-borderwidth` value (e.g., the default `1`) and a `-relief` value other than `flat` (e.g., the default `sunken`) then this subcommand sets the `-borderwidth` option of `widget` to `0`, provided that `widget` supports this option.

: **REMARK 5:**  This subcommand is the only supported way to embed a widget into a scrollarea.  Any attempt to embed further widgets, using any geometry manager, will lead to unpredictable results!

`pathName unsetattrib name`
: Unsets the attribute `name`.  Returns an empty string.

`pathName widget`
: Returns the argument passed to the most recent successful invocation of the `setwidget` subcommand, or an empty string if there was no successful invocation of that subcommand yet.


**BINDINGS**
: When a new scrollarea is created, it has no default event bindings: scrollareas are not intended to be interactive.

**KEYWORDS**
: scrollarea, widget, scrollbar


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::getscrollarea` Command

**NAME**
: `scrollutil::getscrollarea` – Query the scrollarea containing a given widget

**SYNOPSIS**
: 

```
scrollutil::getscrollarea widget
```

**DESCRIPTION**
: Returns the path name of the scrollarea into which the widget given by the `widget` argument is embedded via the scrollarea's `setwidget` subcommand, or an empty string if there is no such scrollarea widget.

**KEYWORDS**
: scrollarea, widget


[Contents](#contents)     [Start page](index.md)
