# Interactive Tablelist Cell Editing Using the combobox Package

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::addOakleyCombobox Command](#the-tablelist-addoakleycombobox-command)

[Start page](index.md)

---

## Overview

Bryan Oakley's combobox package is a library extension for Tcl/Tk versions 8.0 or higher, written in pure Tcl/Tk code.  Its download location is

http://www1.clearlight.com/~oakley/tcl/combobox

Tablelist supports interactive cell editing with the aid of the combobox widget implemented in the package mentioned above.  The steps needed for using this widget for editing the cells of a given column are as follows:

1. Register the combobox widget for interactive cell editing by invoking the `tablelist::addOakleyCombobox` command described below.
2. Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to the value returned by the command mentioned above.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)

**REMARK:**  The arrow and scrollbar components of the temporary embedded combobox widget used for interactive cell editing will appear properly scaled, according to the display's DPI scaling level and Tk's scaling factor given by  `[tk scaling]`.

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addOakleyCombobox` Command

**NAME**
: `tablelist::addOakleyCombobox` – Register Bryan Oakley's combobox widget for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addOakleyCombobox ?name?
```

**DESCRIPTION**
: This command registers Bryan Oakley's combobox widget for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the combobox widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `combobox`.  The command returns its `name` argument.

: The temporary embedded combobox widget associated with the above `name` will be created with its `-editable` option set to `1`.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to make the combobox non-editable or define validations for its entry child (whose path name can be obtained by invoking the tablelist widget's `entrypath` subcommand, or by appending `.entry` to the path name of the combobox widget, or, if using combobox version 2.3 or later, with the aid of the combobox widget's  `subwidget entry`  subcommand), as well as for populating its listbox component (by using the combobox widget's  `list insert`  subcommand).

**KEYWORDS**
: tablelist, editing, combobox


[Start page](index.md)
