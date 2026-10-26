---
CommandName: tool::dict_ensemble
ManualSection: n
Version: 0.4.2
TclPart: tcllib
TclDescription: Standardized OO Framework for development
Keywords:
 - TOOL
 - TclOO
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# Name

tool::dict_ensemble - Dictionary Tools

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tool]{.lit} [0.4.2]{.optlit} 
:::

*object* *ensemble* **add** *field*

# Description

The **dict_ensemble** command is a keyword added by **tool**. It defines a public variable (stored as a dict), and an access function to manipulated and access the values stored in that dict.

*object* *ensemble* **add** *field*
: \] *value* *value ...*\] Adds elements to a list maintained with the *field* leaf of the dict maintained my this ensemble. Declares a variable *name* which will be initialized as an array, populated with *contents* for objects of this class, as well as any objects for classes which are descendents of this class.


# Authors

Sean Woods

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *tool* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Utility

# Copyright

```
Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
```
