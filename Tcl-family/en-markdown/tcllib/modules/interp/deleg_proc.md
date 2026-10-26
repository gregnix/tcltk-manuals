---
CommandName: deleg_proc
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Interpreter utilities
Keywords:
 - comm
 - delegation
 - interpreter
 - procedure
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

deleg_proc - Creation of comm delegates (procedures)

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [interp::delegate::proc]{.lit} [0.3]{.optlit} 
[::interp::delegate::proc]{.cmd} [-async]{.optlit} [name]{.arg} [arguments]{.arg} [comm]{.arg} [id]{.arg} 
:::

# Description

This package provides a single command for the convenient creation of procedures which delegate the actual work to a remote location via a "channel" created by the package **comm**.

# Api

**::interp::delegate::proc** ?**-async**? *name* *arguments* *comm* *id*
: This commands creates a procedure which is named by *name* and returns its fully-qualified name. All invokations of this procedure will delegate the actual work to the remote location identified by the comm channel *comm* and the endpoint *id*. The name of the remote procedure invoked by the delegator is \[namespace tail *name*\]. I.e., namespace information is stripped from the call. Normally the generated procedure marshalls the *arguments*, and returns the result from the remote procedure as its own result. If however the option **-async** was specified then the generated procedure will not wait for a result and return immediately.


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
