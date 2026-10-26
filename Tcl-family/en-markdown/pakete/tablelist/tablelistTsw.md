# Interactive Tablelist Cell Editing Using the Tsw Package

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::addToggleswitch Command](#the-tablelist-addtoggleswitch-command)

[Start page](index.md)

---

## Overview

The toggle switch widget package Tsw is a library extension for Tcl/Tk versions 8.6 or higher, written in pure Tcl/Tk code.  Its download location is

https://www.nemethi.de

Tablelist supports interactive cell editing with the aid of the toggleswitch widget implemented in the package mentioned above.  The steps needed for using this widget for editing the cells of a given column are as follows:

1. Register the toggleswitch widget for interactive cell editing by invoking the `tablelist::addToggleswitch` command described below.
2. Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to the value returned by the command mentioned above.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)

**REMARK:**  The temporary embedded toggleswitch widget used for interactive cell editing will appear properly scaled, according to the display's DPI scaling level and Tk's scaling factor given by  `[tk scaling]`.

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addToggleswitch` Command

**NAME**
: `tablelist::addToggleswitch` – Register the toggleswitch widget for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addToggleswitch ?name?
```

**DESCRIPTION**
: This command registers the toggleswitch widget for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the toggleswitch widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `toggleswitch`.  The command returns its `name` argument.

: The temporary embedded toggleswitch widget used for interactive cell editing will be created with its `-size` option set to `1`.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to override the initial settings according to your needs.

**KEYWORDS**
: tablelist, editing, Tsw, toggleswitch


[Start page](index.md)
