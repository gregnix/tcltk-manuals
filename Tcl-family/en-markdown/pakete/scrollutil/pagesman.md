# The `scrollutil::pagesman` Command

## For Scrollutil Version 2.11

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Quick Reference](#quick-reference)
- [Detailed Reference](#detailed-reference)

[Start page](index.md)

---

## Quick Reference

[NAME](#detailed-reference)
: `scrollutil::pagesman` – Create and manipulate pagesman widgets

[SYNOPSIS](#detailed-reference)
: 

```
scrollutil::pagesman pathName ?options?
```

[STANDARD OPTIONS](#detailed-reference)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

[WIDGET-SPECIFIC OPTIONS](#detailed-reference)
: `-forgetcommand command`

: `-height screenDistance`

: `-leavecommand command`

: `-takefocus 0|1|""|command`

: `-width screenDistance`

[PAGE CONFIGURATION OPTIONS](#detailed-reference)
: `-padding padding`

: `-sticky stickyness`

[WIDGET COMMAND](#detailed-reference)
: `pathName add window ?option value option value ...?`

: `pathName adjustsize`

: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName forget pageIndex`

: `pathName hasattrib name`

: `pathName haspageattrib pageIndex name`

: `pathName index window`

: `pathName insert pageIndex window ?option value option value ...?`

: `pathName pageattrib pageIndex ?name ?value name value ...??`

: `pathName pagecget pageIndex option`

: `pathName pageconfigure pageIndex ?option ?value option value ...??`

: `pathName pages`

: `pathName select ?pageIndex?`

: `pathName size`

: `pathName unsetattrib name`

: `pathName unsetpageattrib pageIndex name`

: `pathName window pageIndex`

[KEYWORDS](#detailed-reference)
: pagesman, widget


[Contents](#contents)     [Start page](index.md)

---

## Detailed Reference

**NAME**
: `scrollutil::pagesman` – Create and manipulate pagesman widgets

**SYNOPSIS**
: 

```
scrollutil::pagesman pathName ?options?
```

**DESCRIPTION**
: The `scrollutil::pagesman` command creates a new window named `pathName` and of the class `Pagesman`, and makes it into a **pagesman** widget.  Additional options, described below, may be specified on the command line or in the option database to configure aspects of the pagesman widget such as its width, height, borderwidth, and relief.  The `scrollutil::pagesman` command returns its `pathName` argument.  At the time this command is invoked, there must not exist a window named `pathName`, but `pathName`'s parent must exist.

: A pagesman is a mega-widget that provides the basic functionality of a pages manager, meaning that it manages a list of windows, called **pages**, of which only one is visible at a time.  By using it with [plainnotebook](plainnotebook.md) widgets as pages, it is quite easy to write applications in which the user can descend from a plainnotebook to another one with a single mouse click and switch back in the same way to the original one.  Everything needed for this navigation is provided by appropriate options and subcommands of the plainnotebook widget.

**STANDARD OPTIONS**
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor
-cursor       -highlightthickness
```

: See the **options** manual entry for details on the standard Tk widget options.  The `-background`, `-highlightbackground`, `-highlightcolor`, and `-highlightthickness` options are only supported by the Scrollutil package, but not by Scrollutil_tile.  They have the same default values as the options of the same names for Tk frame widgets.  The default values of the remaining standard options are:


```
-borderwidth 0 -cursor "" -relief flat
```

**WIDGET-SPECIFIC OPTIONS**
: 

|   |   |
| --- | --- |
| Command-Line Name:  | `-forgetcommand` |
| Database Name: | ` forgetCommand` |
| Database Class: | ` ForgetCommand` |

Specifies a command to be invoked when attempting to unmanage a window with the aid of the `forget` subcommand.  If the option's value is a nonempty string then it is concatenated with the path name of the pagesman widget and that of the window to be unmanaged, and the resulting script, which must return a boolean, is evaluated in the global scope.  If the return value of this script is false then the `forget` subcommand is aborted, i.e., the window is not unmanaged.  The default is an empty string.


|   |   |
| --- | --- |
| Command-Line Name:  | `-height` |
| Database Name: | ` height` |
| Database Class: | ` Height` |

If present and greater than zero, specifies the desired total height for the widget, including the border and highlight rectangle (if any) drawn around the outside of the widget, in any of the forms acceptable to `Tk_GetPixels`.  Otherwise, the maximum requested height of all pages is used.  The default is `0`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-leavecommand` |
| Database Name: | ` leaveCommand` |
| Database Class: | ` LeaveCommand` |

Specifies a command to be invoked when attempting to leave the currently selected window by selecting a different one with the aid of the `select` subcommand.  If the option's value is a nonempty string then it is concatenated with the path name of the pagesman widget and that of the currently selected window, and the resulting script, which must return a boolean, is evaluated in the global scope.  If the return value of this script is false then the operation of selecting a different window is aborted.  The default is an empty string.


|   |   |
| --- | --- |
| Command-Line Name:  | `-takefocus` |
| Database Name: | ` takeFocus` |
| Database Class: | ` TakeFocus` |

This option determines whether the pagesman widget accepts the focus during keyboard traversal.  It is almost identical to the standard option of the same name (see the **options** manual entry for details).  The only difference is that not the pagesman widget itself but the currently selected window (if any) will receive the focus during keyboard traversal with the standard keys (`Tab` and `Shift-Tab`).  The default is an empty string.


|   |   |
| --- | --- |
| Command-Line Name:  | `-width` |
| Database Name: | ` width` |
| Database Class: | ` Width` |

If present and greater than zero, specifies the desired total width for the widget, including the border and highlight rectangle (if any) drawn around the outside of the widget, in any of the forms acceptable to `Tk_GetPixels`.  Otherwise, the maximum requested width of all pages is used.  The default is `0`.

**PAGE CONFIGURATION OPTIONS**
: The following options are currently supported by the `add`, `insert`, `pagecget`, and `pageconfigure` commands:


`-padding padding`
: Specifies the amount of extra space to add between the widget and this page.  `padding` must be a list of up to four nonnegative screen distances  `{left top right bottom}`.  If fewer than four elements are specified, `bottom` defaults to `top`, `right` defaults to `left`, and `top` defaults to `left`.  A padding value specified as an empty list is equivalent to `0`, which is the default.

`-sticky stickyness`
: Specifies how the page window will be positioned within the widget.  `stickyness` must be a string containing zero or more of the characters `n`, `s`, `e`, or `w`.  Each letter refers to a side (north, south, east, or west) that the page window will “stick” to, as per the `grid` geometry manager.  The default stickyness is `nsew`.


**WIDGET COMMAND**
: The `scrollutil::pagesman` command creates a new Tcl command whose name is `pathName`.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

: `option` and the `arg`s determine the exact behavior of the command.  In the subcommand descriptions below, `pageIndex` always denotes a numerical page index, which, with the exception of the `insert` subcommand, must be greater than or equal to zero and less than the number of pages.  The following subcommands are possible for pagesman widgets:


`pathName add window ?option value option value ...?`
: Adds a new page consisting of the specified window to the pagesman widget.  See the [PAGE CONFIGURATION OPTIONS](#detailed-reference) section for the list of available options.  If `window` is already managed by the pagesman widget, then the subcommand uses its optional arguments to update the options of the corresponding page.

`pathName adjustsize`
: Sets the pagesman widget's `-height` option to the maximum requested height of all pages and its `-width` option to the maximum requested width of all pages.

: **REMARK:**  If all pages of the pagesman widget are plainnotebooks whose `-height` and `-width` options have their default value `0` then in many cases there is no need to precede an invocation of this subcommand for the pagesman widget by invocations of the subcommand of the same name for its pages, because each plainnotebook will automatically adapt its requested size to the maximum requested size of its panes.  For example, a font size change in some panes of some of the pages might make it necessary to invoke this subcommand for the pagesman widget, and at the invocation time its pages will already have their requested sizes automatically adapted to the new font size.

`pathName attrib ?name ?value name value ...??`
: Queries or modifies the attributes of the widget.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for `pathName`.  If `name` is specified with no `value`, then the command returns the value of the one named attribute, or an empty string if no corresponding value exists (you can use the `hasattrib` subcommand to distinguish this case from the one that the value of an *existing* attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given widget attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName cget option`
: Returns the current value of the configuration option given by `option`, which may have any of the values accepted by the `scrollutil::pagesman` command.

`pathName configure ?option ?value option value ...??`
: Queries or modifies the configuration options of the widget.  If no `option` is specified, the command returns a list describing all of the available options for `pathName` (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values accepted by the `scrollutil::pagesman` command.

`pathName forget pageIndex`
: Unmaps and unmanages the page identified by `pageIndex`.  The subcommand returns `0` if it was aborted by the command specified as the value of the `-forgetcommand` option, and `1` otherwise.

`pathName hasattrib name`
: Returns `1` if the attribute `name` exists and `0` otherwise.

`pathName haspageattrib pageIndex name`
: Returns `1` if the attribute `name` for the page given by `pageIndex` exists and `0` otherwise.

`pathName index window`
: Returns the numerical index of the page identified by the specified window, which must have been added to the widget with the aid of the `add` or `insert` subcommand.

`pathName insert pageIndex window ?option value option value ...?`
: Inserts a new page consisting of the specified window at the position given by `pageIndex`.  See the [PAGE CONFIGURATION OPTIONS](#detailed-reference) section for the list of available options.  If `window` is already managed by the pagesman widget, then the subcommand moves it to the specified position and uses its optional arguments to update the options of the corresponding page.  If `pageIndex` is less than or equal to zero then the window is prepended to the list of pages; if it is greater than or equal to the number of pages then the window is appended to the list of pages.

`pathName pageattrib pageIndex ?name ?value name value ...??`
: Queries or modifies the attributes of the page given by `pageIndex`.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for the page.  If `name` is specified with no `value`, then the command returns the value of the one named page attribute, or an empty string if no corresponding value exists (you can use the `haspageattrib` subcommand to distinguish this case from the one that the value of an *existing* page attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given page attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName pagecget pageIndex option`
: Returns the current value of the page configuration option given by `option` for the page specified by `pageIndex`.  `option` may have any of the values accepted by the `pageconfigure` command.

`pathName pageconfigure pageIndex ?option ?value option value ...??`
: Queries or modifies the configuration options of the page given by `pageIndex`.  If no `option` is specified, the command returns a list describing all of the available options for the page (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given page option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values described in the [PAGE CONFIGURATION OPTIONS](#detailed-reference) section.

`pathName pages`
: Returns the list of all windows managed by the pagesman widget, in the order of their numerical page indices.

`pathName select ?pageIndex?`
: If `pageIndex` is omitted, the subcommand returns the path name of the currently selected window.  Otherwise it selects the specified page by mapping the corresponding window and unmapping the previously-selected one (if different).  In this case, the return value is `0` if the operation of selecting a different window was aborted by the command specified as the value of the `-leavecommand` option, and `1` otherwise.

`pathName size`
: Returns the number of pages, i.e., the number of windows managed by the pagesman widget.

`pathName unsetattrib name`
: Unsets the attribute `name`.  Returns an empty string.

`pathName unsetpageattrib pageIndex name`
: Unsets the attribute `name` for the page given by `pageIndex`.  Returns an empty string.

`pathName window pageIndex`
: Returns the path name of the page window identified by `pageIndex`.


**VIRTUAL EVENTS**
: After a new page is selected, the widget generates a `<<PagesmanPageChanged>>` virtual event.

**BINDINGS**
: When a new pagesman widget is created, it has no default event bindings: pagesman widgets are not intended to be interactive.

**KEYWORDS**
: pagesman, pages manager, widget


[Contents](#contents)     [Start page](index.md)
