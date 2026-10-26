---
CommandName: stooop
ManualSection: n
Version: 4.4.2
TclPart: tcllib
TclDescription: Simple Tcl Only Object Oriented Programming
Keywords:
 - C++
 - class
 - object
 - object oriented
Copyright:
---

# Name

stooop - Object oriented extension.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [stooop]{.lit} [4.4.2]{.optlit} 
[::stooop::class]{.cmd} [name]{.arg} [body]{.arg} 
[::stooop::new]{.cmd} [class]{.arg} [arg arg]{.optdot} 
[::stooop::delete]{.cmd} [object]{.arg} [object]{.optdot} 
[::stooop::virtual]{.cmd} [proc]{.sub} [name]{.arg} { [this]{.lit} [arg arg]{.optdot} } [body]{.optarg} 
[::stooop::classof]{.cmd} [object]{.arg} 
[::stooop::new]{.cmd} [object]{.arg} 
[::stooop::printObjects]{.cmd} [pattern]{.optarg} 
[::stooop::record]{.cmd} 
[::stooop::report]{.cmd} [pattern]{.optarg} 
:::

# Description

This package provides commands to extend Tcl in an object oriented manner, using a familiar C++ like syntax and behaviour. Stooop only introduces a few new commands: **class**, **new**, **delete**, **virtual** and **classof**. Along with a few coding conventions, that is basically all you need to know to use stooop. Stooop is meant to be as simple to use as possible.

This manual is very succinct and is to be used as a quick reminder for the programmer, who should have read the thorough *stooop_man.html* HTML documentation at this point.

**::stooop::class** *name body*
: This command creates a class. The body, similar in contents to a Tcl namespace (which a class actually also is), contains member procedure definitions. Member procedures can also be defined outside the class body, by prefixing their name with **class::**, as you would proceed with namespace procedures.


**proc** *class* {**this** ?*arg arg ...*?} ?*base* {?*arg arg ...*?} ...? *body*
: This is the constructor procedure for the class. It is invoked following a **new** invocation on the class. It must have the same name as the class and a first argument named **this**. Any number of base classes specifications, including arguments to be passed to their constructor, are allowed before the actual body of the procedure.

**proc** ~*class* {**this**} *body*
: This is the destructor procedure for the class. It is invoked following a **delete** invocation. Its name must be the concatenation of a single **~** character followed by the class name (as in C++). It must have a single argument named **this**.

**proc** *name* {**this** ?*arg arg ...*?} *body*
: This is a member procedure of the class, as its first argument is named **this**. It allows a simple access of member data for the object referenced by **this** inside the procedure. For example:


```
   set ($this,data) 0
```

**proc** *name* {?*arg arg ...*?} *body*
: This is a static (as in C++) member procedure of the class, as its first argument is not named **this**. Static (global) class data can be accessed as in:


```
   set (data) 0
```

**proc** *class* {**this copy**} *body*
: This is the optional copy procedure for the class. It must have the same name as the class and exactly 2 arguments named **this** and **copy**. It is invoked following a **new** invocation on an existing object of the class.


**::stooop::new** *class* ?*arg arg ...*?
: This command is used to create an object. The first argument is the class name and is followed by the arguments needed by the corresponding class constructor. A unique identifier for the object just created is returned.

**::stooop::delete** *object* ?*object ...*?
: This command is used to delete one or several objects. It takes one or more object identifiers as argument(s).

**::stooop::virtual** **proc** *name* {**this** ?*arg arg ...*?} ?*body*?
: The **virtual** specifier may be used on member procedures to achieve dynamic binding. A procedure in a base class can then be redefined (overloaded) in the derived class(es). If the base class procedure is invoked on an object, it is actually the derived class procedure which is invoked, if it exists. If the base class procedure has no body, then it is considered to be a pure virtual and the derived class procedure is always invoked.

**::stooop::classof** *object*
: This command returns the class of the existing object passed as single parameter.

**::stooop::new** *object*
: This command is used to create an object by copying an existing object. The copy constructor of the corresponding class is invoked if it exists, otherwise a simple copy of the copied object data members is performed.


# Debugging

**Environment variables**
: 


**STOOOPCHECKDATA**
: Setting this variable to any true value will cause stooop to check for invalid member or class data access.

**STOOOPCHECKPROCEDURES**
: Setting this variable to any true value will cause stooop to check for invalid member procedure arguments and pure interface classes instanciation.

**STOOOPCHECKALL**
: Setting this variable to any true value will cause stooop to activate both procedure and data member checking.

**STOOOPCHECKOBJECTS**
: Setting this variable to any true value will cause stooop to activate object checking. The following stooop namespace procedures then become available for debugging: **printObjects**, **record** and **report**.

**STOOOPTRACEPROCEDURES**
: Setting this environment variable to either **stdout**, **stderr** or a file name, activates procedure tracing. The stooop library will then output to the specified channel 1 line of informational text for each member procedure invocation.

**STOOOPTRACEPROCEDURESFORMAT**
: Defines the trace procedures output format. Defaults to **"class: %C, procedure: %p, object: %O, arguments: %a"**.

**STOOOPTRACEDATA**
: Setting this environment variable to either **stdout**, **stderr** or a file name, activates data tracing. The stooop library will then output to the specified channel 1 line of informational text for each member data access.

**STOOOPTRACEDATAFORMAT**
: Defines the trace data output format. Defaults to **"class: %C, procedure: %p, array: %A, object: %O, member: %m, operation: %o, value: %v"**.

**STOOOPTRACEDATAOPERATIONS**
: When tracing data output, by default, all read, write and unsetting accesses are reported, but the user can set this variable to any combination of the letters **r**, **w**, and **u** for more specific tracing (please refer to the **trace** Tcl manual page for more information).

**STOOOPTRACEALL**
: Setting this environment variable to either **stdout**, **stderr** or a file name, enables both procedure and data tracing.


**::stooop::printObjects** ?*pattern*?
: Prints an ordered list of existing objects, in creation order, oldest first. Each output line contains the class name, object identifier and the procedure within which the creation occurred. The optional pattern argument (as in the Tcl **string match** command) can be used to limit the output to matching class names.

**::stooop::record**
: When invoked, a snapshot of all existing stooop objects is taken. Reporting can then be used at a later time to see which objects were created or deleted in the interval.

**::stooop::report** ?*pattern*?
: Prints the created and deleted objects since the **::stooop::record** procedure was invoked last. If present, the pattern argument limits the output to matching class names.


# Examples

Please see the full HTML documentation in *stooop_man.html*.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *stooop* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools
