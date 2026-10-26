---
CommandName: valtype::common
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
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

valtype::common - Validation, common code

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [valtype::common]{.lit} [1.1]{.optlit} 
[valtype::common::reject]{.cmd} [code]{.arg} [text]{.arg} 
[valtype::common::badchar]{.cmd} [code]{.arg} [text]{.optarg} 
[valtype::common::badcheck]{.cmd} [code]{.arg} [text]{.optarg} 
[valtype::common::badlength]{.cmd} [code]{.arg} [lengths]{.arg} [text]{.optarg} 
[valtype::common::badprefix]{.cmd} [code]{.arg} [prefixes]{.arg} [text]{.optarg} 
:::

# Description

This package implements a number of common commands used by the validation types in this module. These commands essentially encapsulate the throwing of validation errors, ensuring that a proper **-errorcode** is used. See section **Error Codes**.

# Api

**valtype::common::reject** *code* *text*
: The core command of this package it throws an **INVALID** error with the specified *text*. The first argument is a list of codes extending the **INVALID** with detail information.

**valtype::common::badchar** *code* ?*text*?
: This command throws an **INVALID CHAR** error with the specified *text*. The first argument is a list of codes providing details. These are inserted between the codes **INVALID** and **CHARACTER**.

**valtype::common::badcheck** *code* ?*text*?
: This command throws an **INVALID CHECK-DIGIT** error with the specified *text*, if any, extended by the standard text "the check digit is incorrect". The first argument is a list of codes providing details. These are inserted between the codes **INVALID** and **CHECK_DIGIT**.

**valtype::common::badlength** *code* *lengths* ?*text*?
: This command throws an **INVALID LENGTH** error with the specified *text*, if any, extended by the standard text "incorrect length, expected ... character(s)". The first argument is a list of codes providing details. These are inserted between the codes **INVALID** and **LENGTH**. The argument *lengths* is a list of the input lengths which had been expected, i.e. these are the valid lengths.

**valtype::common::badprefix** *code* *prefixes* ?*text*?
: This command throws an **INVALID PREFIX** error with the specified *text*, if any, extended by the standard text "incorrect prefix, expected ...". The first argument is a list of codes providing details. These are inserted between the codes **INVALID** and **PREFIX**. The argument *prefixes* is a list of the input prefixes which had been expected, i.e. these are the valid prefixes.


# Error codes

The errors thrown by the commands of this package all use the **-errorcode** **INVALID** to distinguish the input validation failures they represent from package internal errors.

To provide more detailed information about why the validation failed the **-errorCode** goes actually beyond that. First, it will contain a code detailing the type itself. This is supplied by the caller. This is then followed by values detailing the reason for the failure. The full set of **-errorCode**s which can be thrown by this package are shown below, with **<>** a placeholder for both the caller-supplied type-information, the type description.

INVALID **<>** CHARACTER
: The input value contained one or more bad characters, i.e. characters which must not occur in the input for it to be a **<>**.

INVALID **<>** CHECK-DIGIT
: The check digit of the input value is wrong. This usually signals a data-entry error, with digits transposed, forgotten, etc. Of course, th input may be an outright fake too.

INVALID **<>** LENGTH
: The input value is of the wrong length to be a **<>**.

INVALID **<>** PREFIX
: The input value does not start with the magic value(s) required for it to be a **<>**.


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
