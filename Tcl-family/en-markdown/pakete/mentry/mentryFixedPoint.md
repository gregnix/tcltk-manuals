# Multi-Entry Widgets for Real Numbers  
 in Fixed-Point Format

## For Mentry Version 4.5

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The mentry::fixedPointMentry Command](#the-mentry-fixedpointmentry-command)
- [The mentry::putReal Command](#the-mentry-putreal-command)
- [The mentry::getReal Command](#the-mentry-getreal-command)

[Start page](index.md)

---

## The `mentry::fixedPointMentry` Command

**NAME**
: `mentry::fixedPointMentry` – Create and manipulate mentry widgets for real numbers in fixed-point format

**SYNOPSIS**
: 

```
mentry::fixedPointMentry pathName count1 count2 ?-comma? ?options?
```

**DESCRIPTION**
: This command creates a new mentry widget `pathName` for displaying and editing real numbers in fixed-point format, with `count1` characters before and `count2` digits after the decimal point.  Both `count1` and `count2` must be positive integers.  The mentry will have two entry components, separated by a label displaying a `"."` character by default; the optional `-comma` switch changes the label text to `","`.  The supported `options` are the same as in the case of the `mentry::mentry` command.

: The command sets the `type` attribute of the widget to the value `"FixedPoint"` and returns the name of the newly created widget.

**KEYWORDS**
: mentry, widget, real number


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::putReal` Command

**NAME**
: `mentry::putReal` – Output a real number to a mentry of type `"FixedPoint"`

**SYNOPSIS**
: 

```
mentry::putReal number pathName
```

**DESCRIPTION**
: This command outputs the real number `number` to the mentry widget `pathName`, which must have been created with the `mentry::fixedPointMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"FixedPoint"`).

: The command generates an error if the number does not fit into the widget because it has too many characters before the decimal point.

**KEYWORDS**
: mentry, widget, real number


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::getReal` Command

**NAME**
: `mentry::getReal` – Get a real number from a mentry of type `"FixedPoint"`

**SYNOPSIS**
: 

```
mentry::getReal pathName
```

**DESCRIPTION**
: This command returns the number contained in the mentry widget `pathName`, which must have been created with the `mentry::fixedPointMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"FixedPoint"`).

: If both entry components of the widget are empty, the command sets the focus to the first entry component, generates an error, and returns the string `"EMPTY"`.

**KEYWORDS**
: mentry, widget, real number


[Contents](#contents)     [Start page](index.md)
