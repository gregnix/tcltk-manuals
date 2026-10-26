# Interactive Tablelist Cell Editing Using the BWidget Package

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::addBWidgetEntry Command](#the-tablelist-addbwidgetentry-command)
- [The tablelist::addBWidgetSpinBox Command](#the-tablelist-addbwidgetspinbox-command)
- [The tablelist::addBWidgetComboBox Command](#the-tablelist-addbwidgetcombobox-command)

[Start page](index.md)

---

## Overview

The BWidget package is a library extension for Tcl/Tk versions 8.1.1 or higher, written in pure Tcl/Tk code.  Its download location is

https://sourceforge.net/projects/tcllib/files

Tablelist supports interactive cell editing with the aid of the Entry, SpinBox, and ComboBox widgets from the BWidget package.  The steps needed for using one of these widgets for editing the cells of a given column are as follows:

1. Register the desired widget for interactive cell editing by invoking one of the commands described in this reference page.
2. Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to the value returned by the command mentioned above.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)

**REMARK:**  The temporary embedded BWidget widget used for interactive cell editing will appear properly scaled, according to the display's DPI scaling level and Tk's scaling factor given by  `[tk scaling]`.

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addBWidgetEntry` Command

**NAME**
: `tablelist::addBWidgetEntry` – Register the Entry widget from the BWidget package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addBWidgetEntry ?name?
```

**DESCRIPTION**
: This command registers the Entry widget from the BWidget package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the Entry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `Entry`.  The command returns its `name` argument.

**KEYWORDS**
: tablelist, editing, BWidget, Entry


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addBWidgetSpinBox` Command

**NAME**
: `tablelist::addBWidgetSpinBox` – Register the SpinBox widget from the BWidget package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addBWidgetSpinBox ?name?
```

**DESCRIPTION**
: This command registers the SpinBox widget from the BWidget package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the SpinBox widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `SpinBox`.  The command returns its `name` argument.

: The temporary embedded SpinBox widget associated with the above `name` will be created with its `-editable` option set to `1`.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to make the SpinBox non-editable or define validations for it, as well as for setting its (range of) values and its `-wrap` option.

**KEYWORDS**
: tablelist, editing, BWidget, SpinBox


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addBWidgetComboBox` Command

**NAME**
: `tablelist::addBWidgetComboBox` – Register the ComboBox widget from the BWidget package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addBWidgetComboBox ?name?
```

**DESCRIPTION**
: This command registers the ComboBox widget from the BWidget package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the ComboBox widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `ComboBox`.  The command returns its `name` argument.

: The temporary embedded ComboBox widget associated with the above `name` will be created with its `-editable` option set to `1`.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to make the ComboBox non-editable or define validations for it, as well as for populating its listbox component (with the aid of the ComboBox widget's `-values` option).

**KEYWORDS**
: tablelist, editing, BWidget, ComboBox


[Contents](#contents)     [Start page](index.md)
