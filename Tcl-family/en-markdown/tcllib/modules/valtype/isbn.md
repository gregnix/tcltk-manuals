---
CommandName: valtype::isbn
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Validation types
Keywords:
 - Book Number
 - Checking
 - EAN
 - EAN13
 - European Article Number
 - ISBN
 - International Article Number
 - International Standard Book Number
 - Testing
 - Type checking
 - Validation
 - Value checking
 - isA
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

valtype::isbn - Validation for ISBN

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [2]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::common]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::isbn]{.lit} [1.1]{.optlit} 
[valtype::isbn]{.cmd} [validate]{.sub} [value]{.arg} 
[valtype::isbn]{.cmd} [checkdigit]{.sub} [value]{.arg} 
[valtype::isbn]{.cmd} [13of]{.sub} [value]{.arg} 
:::

# Description

This package implements a snit validation type for an ISBN.

A validation type is an object that can be used to validate Tcl values of a particular kind.  For example, **snit::integer**, a validation type defined by the **snit** package is used to validate that a Tcl value is an integer.

Every validation type has a **validate** method which is used to do the validation. This method must take a single argument, the value to be validated; further, it must do nothing if the value is valid, but throw an error if the value is invalid:

```
    valtype::isbn validate .... ;# Does nothing
    valtype::isbn validate .... ;# Throws an error (bad ISBN).
```

The **validate** method will always return the validated value on success, and throw the **-errorcode** INVALID on error, possibly with additional elements which provide more details about the problem.

# Api

The API provided by this package satisfies the specification of snit validation types found in the documentation of *Snit's Not Incr Tcl*.

**valtype::isbn** **validate** *value*
: This method validates the *value* and returns it, possibly in a canonical form, if it passes. If the value does not pass the validation an error is thrown.

**valtype::isbn** **checkdigit** *value*
: This method computes a check digit for the *value*. Before doing so it is validated, except for a checkdigit. If the value does not pass the validation no check digit is calculated and an error is thrown instead.

**valtype::isbn** **13of** *value*
: This method expects an old-style 10-digit ISBN and returns the canonical modern 13-digit ISBN. This is used by **validate** to canonicalize the input, so that all parts of the system after the validation can expect to work with modern 13-digit ISBNs.


# Error codes

As said in the package description, the errors thrown by the commands of this package in response to input validation failures use the **-errorcode** INVALID to distinguish themselves from package internal errors.

To provide more detailed information about why the validation failed the **-errorCode** goes actually beyond that. First, it will contain a code detailing the type itself. Here this is **ISBN**. This is then followed by values detailing the reason for the failure. The full set of **-errorCode**s which can be thrown by this package are:

**INVALID ISBN CHARACTER**
: The input value contained one or more bad characters, i.e. characters which must not occur in the input for it to be an ISBN.

**INVALID ISBN CHECK-DIGIT**
: The check digit of the input value is wrong. This usually signals a data-entry error, with digits transposed, forgotten, etc. Of course, th input may be an outright fake too.

**INVALID ISBN LENGTH**
: The input value is of the wrong length to be an ISBN.


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
