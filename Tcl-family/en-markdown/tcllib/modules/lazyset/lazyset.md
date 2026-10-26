---
CommandName: lazyset
title: lazyset
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Lazy evaluation for variables and arrays
Copyright:
 - Copyright (c) 2018 Roy Keene
---

# Name

lazyset - Lazy evaluation

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [lazyset]{.lit} [1.1]{.optlit}
[::lazyset::variable]{.cmd} [-array boolean]{.optarg} [-appendArgs boolean]{.optarg} [someVar]{.arg} [commandPrefix]{.arg}
:::

# Description

The **lazyset** package provides a mechanism for deferring code execution until a specific variable or any index of an array is referenced.

*(Another way to defer execution is to create a singleton class. The first time its constructor is called—if ever—the object will be created. Any subsequent constructor call will get back the first created object. See* [oo::singleton](https://www.tcl-lang.org/man/tcl/TclCmd/singleton.html).)

# API

**::lazyset::variable** ?*-array boolean*? ?*-appendArgs boolean*? *someVar* *commandPrefix*
: Arrange for the code specified as *commandPrefix* to be executed when the variable whose name is specified by *someVar* is read for the first time.

    If the optional argument *-array boolean* is specified as true, then the variable specified as *someVar* is treated as an array and attempting to read any index of the array causes that index to be set by the *commandPrefix* as they are read.

    If the optional argument *-appendArgs boolean* is specified as false, then the variable name and subnames are not appended to the *commandPrefix* before it is evaluated.

    If the argument *-appendArgs boolean* is not specified or is specified as true, then 1 or 2 additional arguments are appended to the *commandPrefix*. If *-array boolean* is specified as true, then 2 arguments are appended corresponding to the name of the variable and the index; otherwise 1 argument is appended containing the name of the variable.

    The *commandPrefix* code is run in the same scope as the variable that is read.


# Examples

```
	::lazyset::variable page {apply {{name} {
		package require http
		set token [http::geturl http://www.tcl-lang.org/]
		set data [http::data $token]
		return $data
	}}}

	puts $page
```

```
	::lazyset::variable -array true page {apply {{name index} {
		package require http
		set token [http::geturl $index]
		set data [http::data $token]
		return $data
	}}}

	puts $page(http://www.tcl-lang.org/)
```

```
	::lazyset::variable -appendArgs false simple {
		return -level 0 42
	}

	puts $simple
```

# Authors

Roy Keene

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *utility* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Utility

# Copyright

```
Copyright (c) 2018 Roy Keene
```
