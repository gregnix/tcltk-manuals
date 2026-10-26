# Interactive Tablelist Cell Editing Using the Mentry Package

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::addDateMentry Command](#the-tablelist-adddatementry-command)
- [The tablelist::addTimeMentry Command](#the-tablelist-addtimementry-command)
- [The tablelist::addDateTimeMentry Command](#the-tablelist-adddatetimementry-command)
- [The tablelist::addFixedPointMentry Command](#the-tablelist-addfixedpointmentry-command)
- [The tablelist::addIPAddrMentry Command](#the-tablelist-addipaddrmentry-command)
- [The tablelist::addIPv6AddrMentry Command](#the-tablelist-addipv6addrmentry-command)

[Start page](index.md)

---

## Overview

The multi-entry package Mentry is a library extension for Tcl/Tk versions 8.4 or higher, written in pure Tcl/Tk code.  Its download location is

https://www.nemethi.de

Starting with version 3.0, the Mentry distribution provides not only the package Mentry, but also its tile-based equivalent Mentry_tile, which enables the theme-specific appearance of mentry widgets; this package requires Tcl/Tk 8.4 or higher and tile 0.6 or higher.

Tablelist supports interactive cell editing with the aid of mentry widgets of type `"Date"`, `"Time"`, `"DateTime`, `"FixedPoint"`, `"IPAddr"`, and `"IPv6Addr"`.  The steps needed for using one of these widgets for editing the cells of a given column are as follows:

1. Register the desired widget for interactive cell editing by invoking one of the commands described in this reference page.
2. Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to the value returned by the command mentioned above.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addDateMentry` Command

**NAME**
: `tablelist::addDateMentry` – Register the mentry widget of type `"Date"` for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addDateMentry format separator ?-gmt? ?name?
```

**DESCRIPTION**
: This command registers the widget created by the `mentry::dateMentry` command from the Mentry (or Mentry_tile) package for interactive cell editing in tablelist widgets.  The `format` and `separator` arguments have the same meanings as in the `mentry::dateMentry` command.  If the `-gmt` argument is present then both the internal clock value and its external date representation in the mentry widget will be viewed as Greenwich Mean Time, otherwise as local time.  The second optional argument specifies the name to be used for the mentry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `dateMentry`.  The command returns its `name` argument.

: A tablelist column having the above `name` as the value of its `-editwindow` option must contain as internal cell values date information in seconds (displayed with the aid of a command given by the `-formatcommand` column configuration option).  The `finishediting` subcommand of the Tcl command associated with the tablelist widget will retrieve the content of the embedded window used for interactive cell editing by invoking the `mentry::getClockVal` command.  The value returned by this command (a clock value in seconds or one of the error strings `"EMPTY"`, `"BAD"`, `"BAD_DATE"`, or `"BAD_YEAR"`) will be passed to the script corresponding to the `-editendcommand` tablelist configuration option (if any), as its last argument.  If this value is one of the above error strings then the script should reject the mentry's content by invoking the `rejectinput` subcommand.

**KEYWORDS**
: tablelist, editing, Mentry, date


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addTimeMentry` Command

**NAME**
: `tablelist::addTimeMentry` – Register the mentry widget of type `"Time"` for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addTimeMentry format separator ?-gmt? ?name?
```

**DESCRIPTION**
: This command registers the widget created by the `mentry::timeMentry` command from the Mentry (or Mentry_tile) package for interactive cell editing in tablelist widgets.  The `format` and `separator` arguments have the same meanings as in the `mentry::timeMentry` command.  If the `-gmt` argument is present then both the internal clock value and its external time representation in the mentry widget will be viewed as Greenwich Mean Time, otherwise as local time.  The second optional argument specifies the name to be used for the mentry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `timeMentry`.  The command returns its `name` argument.

: A tablelist column having the above `name` as the value of its `-editwindow` option must contain as internal cell values time information in seconds (displayed with the aid of a command given by the `-formatcommand` column configuration option).  The `finishediting` subcommand of the Tcl command associated with the tablelist widget will retrieve the content of the embedded window used for interactive cell editing by invoking the `mentry::getClockVal` command.  The value returned by this command (a clock value in seconds or one of the error strings `"EMPTY"` or `"BAD"`) will be passed to the script corresponding to the `-editendcommand` tablelist configuration option (if any), as its last argument.  If this value is one of the above error strings then the script should reject the mentry's content by invoking the `rejectinput` subcommand.

**KEYWORDS**
: tablelist, editing, Mentry, time


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addDateTimeMentry` Command

**NAME**
: `tablelist::addDateTimeMentry` – Register the mentry widget of type `"DateTime"` for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addDateTimeMentry format dateSeparator timeSeparator ?-gmt? ?name?
```

**DESCRIPTION**
: This command registers the widget created by the `mentry::dateTimeMentry` command from the Mentry (or Mentry_tile) package for interactive cell editing in tablelist widgets.  The `format`, `dateSeparator`, and `timeSeparator` arguments have the same meanings as in the `mentry::dateTimeMentry` command.  If the `-gmt` argument is present then both the internal clock value and its external date & time representation in the mentry widget will be viewed as Greenwich Mean Time, otherwise as local time.  The second optional argument specifies the name to be used for the mentry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `dateTimeMentry`.  The command returns its `name` argument.

: A tablelist column having the above `name` as the value of its `-editwindow` option must contain as internal cell values date & time information in seconds (displayed with the aid of a command given by the `-formatcommand` column configuration option).  The `finishediting` subcommand of the Tcl command associated with the tablelist widget will retrieve the content of the embedded window used for interactive cell editing by invoking the `mentry::getClockVal` command.  The value returned by this command (a clock value in seconds or one of the error strings `"EMPTY"`, `"BAD"`, `"BAD_DATE"`, or `"BAD_YEAR"`) will be passed to the script corresponding to the `-editendcommand` tablelist configuration option (if any), as its last argument.  If this value is one of the above error strings then the script should reject the mentry's content by invoking the `rejectinput` subcommand.

**KEYWORDS**
: tablelist, editing, Mentry, date, time


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addFixedPointMentry` Command

**NAME**
: `tablelist::addFixedPointMentry` – Register the mentry widget of type `"FixedPoint"` for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addFixedPointMentry count1 count2 ?-comma? ?name?
```

**DESCRIPTION**
: This command registers the widget created by the `mentry::fixedPointMentry` command from the Mentry (or Mentry_tile) package for interactive cell editing in tablelist widgets.  The `count1`, `count2`, and `-comma` arguments have the same meanings as in the `mentry::fixedPointMentry` command.  The second optional argument specifies the name to be used for the mentry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `fixedPointMentry_count1.count2` (e.g., `fixedPointMentry_6.2`) or `fixedPointMentry_count1,count2` (e.g., `fixedPointMentry_6,2`), depending on the presence of the optional `-comma` argument.  The command returns its `name` argument.

: A tablelist column having the above `name` as the value of its `-editwindow` option must contain real numbers as internal cell values.  The `finishediting` subcommand of the Tcl command associated with the tablelist widget will retrieve the content of the embedded window used for interactive cell editing by invoking the `mentry::getReal` command.  The value returned by this command (a real number or the error string `"EMPTY"`) will be passed to the script corresponding to the `-editendcommand` tablelist configuration option (if any), as its last argument.  If this value is the above error string then the script should reject the mentry's content by invoking the `rejectinput` subcommand.

**KEYWORDS**
: tablelist, editing, Mentry, real number


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addIPAddrMentry` Command

**NAME**
: `tablelist::addIPAddrMentry` – Register the mentry widget of type `"IPAddr"` for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addIPAddrMentry ?name?
```

**DESCRIPTION**
: This command registers the widget created by the `mentry::ipAddrMentry` command from the Mentry (or Mentry_tile) package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the mentry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `ipAddrMentry`.  The command returns its `name` argument.

: A tablelist column having the above `name` as the value of its `-editwindow` option must contain IP addresses as internal cell values.  The `finishediting` subcommand of the Tcl command associated with the tablelist widget will retrieve the content of the embedded window used for interactive cell editing by invoking the `mentry::getIPAddr` command.  The value returned by this command (an IP address or the error string `"EMPTY"`) will be passed to the script corresponding to the `-editendcommand` tablelist configuration option (if any), as its last argument.  If this value is the above error string then the script should reject the mentry's content by invoking the `rejectinput` subcommand.

**KEYWORDS**
: tablelist, editing, Mentry, IP address


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addIPv6AddrMentry` Command

**NAME**
: `tablelist::addIPv6AddrMentry` – Register the mentry widget of type `"IPv6Addr"` for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addIPv6AddrMentry ?name?
```

**DESCRIPTION**
: This command registers the widget created by the `mentry::ipv6AddrMentry` command from the Mentry (or Mentry_tile) package for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the mentry widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `ipv6AddrMentry`.  The command returns its `name` argument.

: A tablelist column having the above `name` as the value of its `-editwindow` option must contain IPv6 addresses as internal cell values.  The `finishediting` subcommand of the Tcl command associated with the tablelist widget will retrieve the content of the embedded window used for interactive cell editing by invoking the `mentry::getIPv6Addr` command.  The value returned by this command (an IPv6 address or the error string `"EMPTY"`) will be passed to the script corresponding to the `-editendcommand` tablelist configuration option (if any), as its last argument.  If this value is the above error string then the script should reject the mentry's content by invoking the `rejectinput` subcommand.

**KEYWORDS**
: tablelist, editing, Mentry, IPv6 address


[Contents](#contents)     [Start page](index.md)
