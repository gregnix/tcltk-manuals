# Commands Related to Binding Scripts

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::convEventFields Command](#the-tablelist-conveventfields-command)
- [The tablelist::getTablelistPath Command](#the-tablelist-gettablelistpath-command)
- [The tablelist::getTablelistColumn Command](#the-tablelist-gettablelistcolumn-command)
- [The tablelist::delaySashPosUpdates Command](#the-tablelist-delaysashposupdates-command)

[Start page](index.md)

---

## Overview

The first three commands described in this reference page are designed to be used in binding scripts associated with the binding tags whose names are returned by the `bodytag` and `labeltag` subcommands of the Tcl command associated with a tablelist widget.  The first two of these commands are also used in the default binding scripts associated with the binding tag `TablelistBody`.  For details and examples see the sections [DEFAULT AND INDIVIDUAL BINDINGS FOR THE TABLELIST BODY](tablelistWidget.md#detailed-reference) and [DEFAULT AND INDIVIDUAL BINDINGS FOR THE HEADER LABELS](tablelistWidget.md#detailed-reference).

The last command is related to the default binding scripts for Tk core panedwindow and ttk::panedwindow widgets.  It can be used to control the frequency of the sash position updates, which might be necessary to eliminate some artifacts caused by dragging a sash if one or more of the panes contains a tablelist widget with embedded images.

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::convEventFields` Command

**NAME**
: `tablelist::convEventFields` – Convert event fields relative to a descendant of a tablelist widget

**SYNOPSIS**
: 

```
tablelist::convEventFields descendantPathName x y
```

**DESCRIPTION**
: This command gets the path name of a tablelist widget and the x and y coordinates relative to the latter from the path name `descendantPathName` of one of its descendants and from the x and y coordinates `x`, `y` relative to this descendant.  The command returns these values as the components of a list consisting of three elements.

: In a binding script, the descendant widget corresponds to the event field `%W`, which can be the tablelist's body, one of the separator frames, a label widget displaying an embedded image, or (a descendant of) an embedded window.  It can also be a header label or a Tk core or tile checkbutton embedded into a header label, or a sort arrow.  Likewise, the arguments `x` and `y` correspond to the event fields `%x` and `%y`.  The three elements of the list returned by the command are usually assigned to the help variables `tablelist::W`, `tablelist::x`, and `tablelist::y`, by using the statement

```
foreach {tablelist::W tablelist::x tablelist::y} \
    [tablelist::convEventFields %W %x %y] {}
```

**KEYWORDS**
: tablelist, event fields, binding script


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::getTablelistPath` Command

**NAME**
: `tablelist::getTablelistPath` – Get the path name of a tablelist widget from the path name of one of its descendants

**SYNOPSIS**
: 

```
tablelist::getTablelistPath descendantPathName
```

**DESCRIPTION**
: This command gets the path name of a tablelist widget from the path name `descendantPathName` of one of its descendants.

: In a binding script, the descendant widget corresponds to the event field `%W`, which can be the tablelist's body, one of the separator frames, a label widget displaying an embedded image, or (a descendant of) an embedded window.  It can also be a header label or a Tk core or tile checkbutton embedded into a header label, or a sort arrow.  The return value is often assigned to the help variable `tablelist::W`.

**KEYWORDS**
: tablelist, path name, binding script


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::getTablelistColumn` Command

**NAME**
: `tablelist::getTablelistColumn` – Get the column number from the path name of a tablelist header label

**SYNOPSIS**
: 

```
tablelist::getTablelistColumn headerLabelPathName
```

**DESCRIPTION**
: This command gets the column number from the path name `headerLabelPathName` of a tablelist header label or of a Tk core or tile checkbutton embedded into a header label, or of a sort arrow.  Returns the column number on success and `-1` on failure.

: In a binding script, the argument corresponds to the event field `%W`.  The return value is often assigned to the help variable `tablelist::col`.

**KEYWORDS**
: tablelist, path name, binding script


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::delaySashPosUpdates` Command

**NAME**
: `tablelist::delaySashPosUpdates` – Set a delay for the panedwindow sash position updates

**SYNOPSIS**
: 

```
tablelist::delaySashPosUpdates panedwindowPathName ms
```

**DESCRIPTION**
: This command sets a delay for the updates of the sash position caused by dragging a sash of the panedwindow widget specified by the first argument, which must be the path name of a Tk core panedwindow or ttk::panedwindow widget.  `ms` must be an integer giving the delay in milliseconds.  If this number is nonnegative then the sash position updates via  `sash place ...`  (for a Tk core panedwindow widget) or  `sashpos ...`  (for a ttk::panedwindow widget) will be scheduled for execution `ms` milliseconds later, in such a way that, until the time for an already scheduled update expires, new drag events won't schedule new update operations (only their data will be remembered).  This will reduce the frequency of the sash position updates caused by dragging a sash of the specified widget, depending on the value of `ms`.  If this number is negative then any dragging of a sash of the specified widget will immediately trigger an update of the sash position, as implemented in the default binding scripts for Tk core panedwindow and ttk::panedwindow widgets.

: This command can be used to control the frequency of the sash position updates for a given panedwindow widget, which might be necessary to eliminate some artifacts caused by dragging a sash if one or more of the panes contains a tablelist widget with embedded images.  The value of `ms` (typically a number between 10 and 100) is application- and platform-specific (on Windows and Mac OS X/11+ you will need a higher value than on X11).

**KEYWORDS**
: panedwindow, tablelist, path name, binding script


[Contents](#contents)     [Start page](index.md)
