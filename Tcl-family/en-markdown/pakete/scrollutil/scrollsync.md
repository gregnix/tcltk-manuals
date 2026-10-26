# The `scrollutil::scrollsync` and  
 `scrollutil::getscrollsync` Commands

## For Scrollutil Version 2.11

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The scrollutil::scrollsync Command – Quick Reference](#the-scrollutil-scrollsync-command-quick-reference)
- [The scrollutil::scrollsync Command – Detailed Reference](#the-scrollutil-scrollsync-command-detailed-reference)
- [The scrollutil::getscrollsync Command](#the-scrollutil-getscrollsync-command)

[Start page](index.md)

---

## The `scrollutil::scrollsync` Command – Quick Reference

[NAME](#the-scrollutil-scrollsync-command-detailed-reference)
: `scrollutil::scrollsync` – Create and manipulate scrollsync widgets

[SYNOPSIS](#the-scrollutil-scrollsync-command-detailed-reference)
: 

```
scrollutil::scrollsync pathName ?options?
```

[STANDARD OPTIONS](#the-scrollutil-scrollsync-command-detailed-reference)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor       -xscrollcommand
-cursor       -highlightthickness   -yscrollcommand
```

[WIDGET-SPECIFIC OPTIONS](#the-scrollutil-scrollsync-command-detailed-reference)
: `-takefocus 0|1|""|command`

[WIDGET COMMAND](#the-scrollutil-scrollsync-command-detailed-reference)
: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName hasattrib name`

: `pathName setwidgets widgetList`

: `pathName unsetattrib name`

: `pathName widgets`

: `pathName xview ?args?`

: `pathName xview`

: `pathName xview moveto fraction`

: `pathName xview scroll number units|pages`


: `pathName yview ?args?`

: `pathName yview`

: `pathName yview moveto fraction`

: `pathName yview scroll number units|pages`


[KEYWORDS](#the-scrollutil-scrollsync-command-detailed-reference)
: scrollsync, widget, scrolling


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::scrollsync` Command – Detailed Reference

**NAME**
: `scrollutil::scrollsync` – Create and manipulate scrollsync widgets

**SYNOPSIS**
: 

```
scrollutil::scrollsync pathName ?options?
```

**DESCRIPTION**
: The `scrollutil::scrollsync` command creates a new window named `pathName` and of the class `Scrollsync`, and makes it into a **scrollsync** widget.  Additional options, described below, may be specified on the command line or in the option database to configure aspects of the scrollsync widget such as its borderwidth and relief.  The `scrollutil::scrollsync` command returns its `pathName` argument.  At the time this command is invoked, there must not exist a window named `pathName`, but `pathName`'s parent must exist.

: A scrollsync is a mega-widget, designed for scrolling several widgets simultaneously.  It is both horizontally and vertically scrollable, meaning that it supports the `-xscrollcommand` and `-yscrollcommand` configuration options and the associated Tcl command has the `xview` and `yview` subcommands.  Whenever the horizontal/vertical position of the view in the window of one of the horizontally/vertically scrollable widgets contained in the list passed to the `setwidgets` subcommand of the associated Tcl command changes, the view in the windows of all the other horizontally/vertically scrollable elements of that list is automatically adjusted accordingly, thus making sure that the view's position in these windows is kept in sync.

: A scrollsync widget is typically created within a [scrollarea](scrollarea.md), like in the following example:

```
set sa [scrollutil::scrollarea ...]
set ss [scrollutil::scrollsync $sa.ss ...]
$sa setwidget $ss

set lb1 [listbox $ss.lb1 ...]
set lb2 [listbox $ss.lb2 ...]
$ss setwidgets [list $lb1 $lb2]

grid $lb1 $lb2 -sticky news -padx {0 2}
grid rowconfigure    $ss 0   -weight 1
grid columnconfigure $ss all -weight 1

pack $sa -expand yes -fill both
```

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
| Command-Line Name:  | `-takefocus` |
| Database Name: | ` takeFocus` |
| Database Class: | ` TakeFocus` |

This option determines whether the scrollsync widget accepts the focus during keyboard traversal.  It is almost identical to the standard option of the same name (see the **options** manual entry for details).  The only difference is that not the scrollsync widget itself but the first element of the widget list passed to the `setwidgets` subcommand of the associated Tcl command will receive the focus during keyboard traversal with the standard keys (`Tab` and `Shift-Tab`).  The default is `0`, being that a scrollsync widget is esentially a frame containing the above-mentioned widgets.

**WIDGET COMMAND**
: The `scrollutil::scrollsync` command creates a new Tcl command whose name is `pathName`.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

: `option` and the `arg`s determine the exact behavior of the command.  The following commands are possible for scrollsync widgets:


`pathName attrib ?name ?value name value ...??`
: Queries or modifies the attributes of the widget.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for `pathName`.  If `name` is specified with no `value`, then the command returns the value of the one named attribute, or an empty string if no corresponding value exists (you can use the `hasattrib` subcommand to distinguish this case from the one that the value of an *existing* attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given widget attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName cget option`
: Returns the current value of the configuration option given by `option`, which may have any of the values accepted by the `scrollutil::scrollsync` command.

`pathName configure ?option ?value option value ...??`
: Queries or modifies the configuration options of the widget.  If no `option` is specified, the command returns a list describing all of the available options for `pathName` (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values accepted by the `scrollutil::scrollsync` command.

`pathName hasattrib name`
: Returns `1` if the attribute `name` exists and `0` otherwise.

`pathName setwidgets widgetList`
: Sets the widgets in whose windows the view's position is to be kept in sync.  The `widgetList` argument must be a valid list consisting of path names of existing widgets.  Whenever the horizontal/vertical position of the view in the window of one of the horizontally/vertically scrollable widgets contained in this list changes, the view in the windows of all the other horizontally/vertically scrollable elements of the list will be automatically adjusted accordingly, thus making sure that the view's position in these windows is kept in sync.  The return value is the argument passed to the previous successful invocation of this subcommand, or an empty list if there was no successful `setwidgets` invocation before.

: **REMARK:**  When one of the widgets whose path name is contained in `widgetList` gets destroyed, that widget is automatically removed from the internal list of widgets in whose windows the view's position is kept in sync.

`pathName unsetattrib name`
: Unsets the attribute `name`.  Returns an empty string.

`pathName widgets`
: Returns the argument passed to the most recent successful invocation of the `setwidgets` subcommand, or an empty list if there was no successful invocation of that subcommand yet.

`pathName xview ?args?`
: `pathName xview`

: `pathName xview moveto fraction`

: `pathName xview scroll number units|pages`

: This command passes its arguments to the `xview` command of the current **master widget for the x axis** and returns the result of that command invocation.  The master widget for the x axis is the element of the widget list passed to the `setwidgets` subcommand having the smallest relative view width among the horizontally scrollable widgets in that list, i.e., the least difference between the last and first elements of the two-element list returned by its `xview` command.  This master widget can vary during program execution (in case of text widgets it can even change depending on the current vertical view position).

`pathName yview ?args?`
: `pathName yview`

: `pathName yview moveto fraction`

: `pathName yview scroll number units|pages`

: This command passes its arguments to the `yview` command of the current **master widget for the y axis** and returns the result of that command invocation.  The master widget for the y axis is the element of the widget list passed to the `setwidgets` subcommand having the smallest relative view height among the vertically scrollable widgets in that list, i.e., the least difference between the last and first elements of the two-element list returned by its `yview` command.  This master widget can vary during program execution.


**BINDINGS**
: When a new scrollsync widget is created, it has no default event bindings: scrollsync widgets are not intended to be interactive.

**KEYWORDS**
: scrollsync, widget, scrolling


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::getscrollsync` Command

**NAME**
: `scrollutil::getscrollsync` – Query the scrollsync containing a given widget

**SYNOPSIS**
: 

```
scrollutil::getscrollsync widget
```

**DESCRIPTION**
: Returns the path name of the scrollsync into which the widget given by the `widget` argument is embedded via the scrollsync's `setwidgets` subcommand, or an empty string if there is no such scrollsync widget.

**KEYWORDS**
: scrollsync, widget


[Contents](#contents)     [Start page](index.md)
