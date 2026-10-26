---
CommandName: toplevel
title: toplevel
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - bindtags(n)
 - frame(n)
 - wm(n)
Keywords:
 - toplevel
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

toplevel - Create and manipulate 'toplevel' main and popup window widgets

# Synopsis

::: {.synopsis} :::
[toplevel]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standard options

**-borderwidth**, **-highlightcolor**, **-pady**, **-cursor**, **-highlightthickness**, **-relief**, **-highlightbackground**, **-padx**, **-takefocus**

See the [options] manual entry for details on the standard options.

# Widget-specific options

**-background** (**background**/**Background**)
: This option is the same as the standard **-background** option except that its value may also be specified as an empty string. In this case, the widget will display no background or border, and no colors will be consumed from its colormap for its background and border.

**-class** (**class**/**Class**)
: Specifies a class for the window. This class will be used when querying the option database for the window's other options, and it will also be used later for other purposes such as bindings. Some window managers display the class name for windows in their dock while some others display the window title. The **-class** option may not be changed with the **configure** widget command.

**-colormap** (**colormap**/**Colormap**)
: Specifies a colormap to use for the window. The value may be either **new**, in which case a new colormap is created for the window and its children, or the name of another window (which must be on the same screen and have the same visual as *pathName*), in which case the new window will use the colormap from the specified window. If the **-colormap** option is not specified, the new window uses the default colormap of its screen. This option may not be changed with the **configure** widget command.

**-container** (**container**/**Container**)
: The value must be a boolean.  If true, it means that this window will be used as a container in which some other application will be embedded (for example, a Tk toplevel can be embedded using the **-use** option). The window will support the appropriate window manager protocols for things like geometry requests.  The window should not have any children of its own in this application. This option may not be changed with the **configure** widget command.

**-height** (**height**/**Height**)
: Specifies the desired height for the window in any of the forms acceptable to [Tk\_GetPixels][GetPixels]. If this option is less than or equal to zero then the window will not request any size at all.

**-menu** ([menu]/**Menu**)
: Specifies a menu widget to be used as a menubar. On the Macintosh, the menubar will be displayed across the top of the main monitor. On Microsoft Windows and all UNIX platforms, the menu will appear across the toplevel window as part of the window dressing maintained by the window manager.

**-screen**
: Specifies the screen on which to place the new window. Any valid screen name may be used, even one associated with a different display. Defaults to the same screen as its parent. This option is special in that it may not be specified via the option database, and it may not be modified with the **configure** widget command.

**-use** (**use**/**Use**)
: This option is used for embedding. If the value is not an empty string, it must be the window identifier of a container window, specified as a hexadecimal string like the ones returned by the [winfo id][winfo] command. The toplevel widget will be created as a child of the given container instead of the root window for the screen.  If the container window is in a Tk application, it must be a frame or toplevel widget for which the **-container** option was specified. This option may not be changed with the **configure** widget command.

**-visual** (**visual**/**Visual**)
: Specifies visual information for the new window in any of the forms accepted by [Tk\_GetVisual][GetVisual]. If this option is not specified, the new window will use the default visual for its screen. The **-visual** option may not be modified with the **configure** widget command.

**-width** (**width**/**Width**)
: Specifies the desired width for the window in any of the forms acceptable to [Tk\_GetPixels][GetPixels]. If this option is less than or equal to zero then the window will not request any size at all.


# Description

The **toplevel** command creates a new toplevel widget (given by the *pathName* argument).  Additional options, described above, may be specified on the command line or in the option database to configure aspects of the toplevel such as its background color and relief.  The **toplevel** command returns the path name of the new window.

A toplevel is similar to a [frame] except that it is created as a top-level window:  its X parent is the root window of a screen rather than the logical parent from its Tk path name.  The primary purpose of a toplevel is to serve as a container for dialog boxes and other collections of widgets.  The only visible features of a toplevel are its background color and an optional 3-D border to make the toplevel appear raised or sunken.

# Widget command

The **toplevel** command creates a new Tcl command whose name is the same as the path name of the toplevel's window.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

*PathName* is the name of the command, which is the same as the toplevel widget's path name.  *Option* and the *arg*s determine the exact behavior of the command.  The following commands are possible for toplevel widgets:

*pathName* **cget** *option*
: Returns the current value of the configuration option given by *option*. *Option* may have any of the values accepted by the **toplevel** command.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Query or modify the configuration options of the widget. If no *option* is specified, returns a list describing all of the available options for *pathName* (see [Tk\_ConfigureInfo][ConfigWidg] for information on the format of this list).  If *option* is specified with no *value*, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no *option* is specified).  If one or more *option-value* pairs are specified, then the command modifies the given widget option(s) to have the given value(s);  in this case the command returns an empty string. *Option* may have any of the values accepted by the **toplevel** command.


# Bindings

When a new toplevel is created, it has no default event bindings: toplevels are not intended to be interactive.

Be aware that bindings on toplevels may receive events from subwidgets.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[frame]: frame.md
[GetPixels]: ../tk-c/GetPixels.md
[GetVisual]: ../tk-c/GetVisual.md
[menu]: menu.md
[options]: options.md
[winfo]: winfo.md
