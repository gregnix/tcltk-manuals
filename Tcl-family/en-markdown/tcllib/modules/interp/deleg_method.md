---
CommandName: deleg_method
title: deleg_method
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Interpreter utilities
Keywords:
 - comm
 - delegation
 - interpreter
 - method
 - snit
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

deleg\_method - Creation of comm delegates (snit methods)

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [interp::delegate::method]{.lit} [0.3]{.optlit}
[::interp::delegate::method]{.cmd} [-async]{.optlit} [name]{.arg} [arguments]{.arg} [comm]{.arg} [id]{.arg}
:::

# Description

This package provides a single command for use within **snit** type definition (i.e. actually a **snit::macro**) for the convenient creation of methods which delegate the actual work to a remote location via a "channel" created by the package **comm**.

# API

**::interp::delegate::method** ?**-async**? *name* *arguments* *comm* *id*
: This commands creates a method which is named by *name*. All invokations of this method will delegate the actual work to the remote location identified by the comm channel *comm* and the endpoint *id*.

    The name of the remote method invoked by the delegator is identical to the name of the method itself.

    Normally the generated method marshalls the *arguments*, and returns the result from the remote method as its own result. If however the option **-async** was specified then the generated method will not wait for a result and return immediately.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *interp* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
