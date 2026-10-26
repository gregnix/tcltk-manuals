---
CommandName: valtype::luhn
title: valtype::luhn
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Validation types
Keywords:
 - Checking
 - Testing
 - Type checking
 - Validation
 - Value checking
 - isA
 - luhn
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

valtype::luhn - Validation for plain number with a LUHN checkdigit

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [2]{.lit}
[package]{.cmd} [require]{.sub} [valtype::common]{.lit}
[package]{.cmd} [require]{.sub} [valtype::luhn]{.lit} [1.1]{.optlit}
[valtype::luhn]{.cmd} [validate]{.lit} [value]{.arg}
[valtype::luhn]{.cmd} [checkdigit]{.lit} [value]{.arg}
:::

# Description

This package implements a snit validation type for a plain number with a LUHN checkdigit.

A validation type is an object that can be used to validate Tcl values of a particular kind.  For example, **snit::integer**, a validation type defined by the **snit** package is used to validate that a Tcl value is an integer.

Every validation type has a **validate** method which is used to do the validation. This method must take a single argument, the value to be validated; further, it must do nothing if the value is valid, but throw an error if the value is invalid:

```
    valtype::luhn validate .... ;# Does nothing
    valtype::luhn validate .... ;# Throws an error (bad luhn checkdigit).
```

The **validate** method will always return the validated value on success, and throw the **-errorcode** INVALID on error, possibly with additional elements which provide more details about the problem.

# API

The API provided by this package satisfies the specification of snit validation types found in the documentation of *Snit's Not Incr Tcl*.

**valtype::luhn** **validate** *value*
: This method validates the *value* and returns it, possibly in a canonical form, if it passes. If the value does not pass the validation an error is thrown.

**valtype::luhn** **checkdigit** *value*
: This method computes a check digit for the *value*. Before doing so it is validated, except for a checkdigit. If the value does not pass the validation no check digit is calculated and an error is thrown instead.


# Error codes

As said in the package description, the errors thrown by the commands of this package in response to input validation failures use the **-errorcode** INVALID to distinguish themselves from package internal errors.

To provide more detailed information about why the validation failed the **-errorCode** goes actually beyond that. First, it will contain a code detailing the type itself. Here this is **LUHN**. This is then followed by values detailing the reason for the failure. The full set of **-errorCode**s which can be thrown by this package are:

INVALID LUHN CHARACTER
: The input value contained one or more bad characters, i.e. characters which must not occur in the input for it to be a plain number with a LUHN checkdigit.

INVALID LUHN CHECK-DIGIT
: The check digit of the input value is wrong. This usually signals a data-entry error, with digits transposed, forgotten, etc. Of course, th input may be an outright fake too.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *valtype* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Validation, Type checking

# Copyright

```
Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
