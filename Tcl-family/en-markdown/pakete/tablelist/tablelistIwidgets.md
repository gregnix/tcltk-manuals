# Interactive Tablelist Cell Editing Using the Iwidgets Package

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::addIncrEntryfield Command](#the-tablelist-addincrentryfield-command)
- [The tablelist::addIncrDateTimeWidget Command](#the-tablelist-addincrdatetimewidget-command)
- [The tablelist::addIncrSpinner Command](#the-tablelist-addincrspinner-command)
- [The tablelist::addIncrSpinint Command](#the-tablelist-addincrspinint-command)
- [The tablelist::addIncrCombobox Command](#the-tablelist-addincrcombobox-command)

[Start page](index.md)

---

## Overview

The Iwidgets package (also known as \[incr Widgets\]) is a library extension for Tcl/Tk versions 8.0 or higher, written in pure Tcl/Tk code.  It requires the compiled packages Itcl and Itk (also known as \[incr Tcl\] and \[incr Tk\], respectively).  The download location of these three library packages is

https://sourceforge.net/projects/incrtcl/files

Tablelist supports interactive cell editing with the aid of the entryfield, datefield, dateentry, timefield, timeentry, spinner, spinint, and combobox widgets from the Iwidgets package.  The steps needed for using one of these widgets for editing the cells of a given column are as follows:

1. Register the desired widget for interactive cell editing by invoking one of the commands described in this reference page.
2. Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to the value returned by the command mentioned above.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)

**REMARK:**  The temporary embedded Iwidgets widget used for interactive cell editing will appear properly scaled, according to the display's DPI scaling level and Tk's scaling factor given by  `[tk scaling]`.

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addIncrEntryfield` Command

**NAME**
: `tablelist::addIncrEntryfield` – Register the entryfield widget from the Iwidgets package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addIncrEntryfield ?name?
```

**DESCRIPTION**
: This command registers the entryfield widget from the Iwidgets package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the entryfield widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `entryfield`.  The command returns its `name` argument.

**KEYWORDS**
: tablelist, editing, Iwidgets, entryfield


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addIncrDateTimeWidget` Command

**NAME**
: `tablelist::addIncrDateTimeWidget` – Register the datefield, dateentry, timefield, or timeentry widget from the Iwidgets package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addIncrDateTimeWidget datefield|dateentry|timefield|timeentry ?-seconds? ?name?
```

**DESCRIPTION**
: This command registers the datefield, dateentry, timefield, or timeentry widget from the Iwidgets package for interactive cell editing in tablelist widgets.  If the `-seconds` argument is present then the `finishediting` subcommand of the Tcl command associated with the tablelist widget will retrieve the content of the embedded window used for interactive cell editing as an integer clock value (in seconds), otherwise as a string.  Use this option for tablelist widgets whose internal list contains date or time information in seconds (displayed with the aid of commands given by the `-formatcommand` column configuration option).  The second optional argument specifies the name to be used for the datefield, dateentry, timefield, or timeentry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `datefield`, `dateentry`, `timefield`, or `timeentry`, as given by the first argument.  The command returns its `name` argument.

: When editing a cell with the aid of the temporary embedded datefield, dateentry, timefield, or timeentry widget associated with the above `name`, you can use the script corresponding to the `-editstartcommand` tablelist configuration option to set any of the widget's options, like `-gmt`, `-iq`, `-int` ("international" date format, supported by datefield and dateentry widgets), or `-format` (for timefield and timeentry widgets, with the values `civilian` and `military`).  For the dateentry widget you might also set the `-startday` option to `monday` and the `-days` option, e.g., to  `{Mo Tu We Th Fr Sa Su}`.

**KEYWORDS**
: tablelist, editing, Iwidgets, datefield, dateentry, timefield, timeentry


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addIncrSpinner` Command

**NAME**
: `tablelist::addIncrSpinner` – Register the spinner widget from the Iwidgets package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addIncrSpinner ?name?
```

**DESCRIPTION**
: This command registers the spinner widget from the Iwidgets package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the spinner widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `spinner`.  The command returns its `name` argument.

: When editing a cell with the aid of the temporary embedded spinner widget associated with the above `name`, you can use the script corresponding to the `-editstartcommand` tablelist configuration option to define validations for the widget or set any of its other options, like `-decrement` and `-increment`.

**KEYWORDS**
: tablelist, editing, Iwidgets, spinner


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addIncrSpinint` Command

**NAME**
: `tablelist::addIncrSpinint` – Register the spinint widget from the Iwidgets package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addIncrSpinint ?name?
```

**DESCRIPTION**
: This command registers the spinint widget from the Iwidgets package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the spinint widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `spinint`.  The command returns its `name` argument.

: When editing a cell with the aid of the temporary embedded spinint widget associated with the above `name`, you can use the script corresponding to the `-editstartcommand` tablelist configuration option to define validations for the widget or set any of its other options, like `-range`, `-step`, and `-wrap`.

**KEYWORDS**
: tablelist, editing, Iwidgets, spinint


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addIncrCombobox` Command

**NAME**
: `tablelist::addIncrCombobox` – Register the combobox widget from the Iwidgets package for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addIncrCombobox ?name?
```

**DESCRIPTION**
: This command registers the dropdown-style combobox widget from the Iwidgets package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the combobox widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `combobox`.  The command returns its `name` argument.

: The temporary embedded combobox widget associated with the above `name` will be created with its `-editable` option set to `1` and its `-grab` option set to `global`.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to make the combobox non-editable or define validations for it, as well as for populating its listbox component (by using the combobox widget's  `insert list`  subcommand and `-listheight` option).

**KEYWORDS**
: tablelist, editing, Iwidgets, combobox


[Contents](#contents)     [Start page](index.md)
