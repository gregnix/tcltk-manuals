---
CommandName: tool
title: tool
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Standardized OO Framework for development
Keywords:
 - TOOL
 - TclOO
 - framework
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# Name

tool - TclOO Library (TOOL) Framework

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [sha1]{.lit}
[package]{.cmd} [require]{.sub} [dicttool]{.lit}
[package]{.cmd} [require]{.sub} [oo::meta]{.lit}
[package]{.cmd} [require]{.sub} [oo::dialect]{.lit}
[object]{.ins} [cget]{.sub} [option]{.arg}
[object]{.ins} [configure]{.sub} [keyvaluelist]{.optarg}
[object]{.ins} [configure]{.sub} [field]{.arg} [value]{.arg} [field]{.optarg} [value]{.optarg} [...]{.optarg}
[object]{.ins} [configurelist]{.sub} [keyvaluelist]{.optarg}
[object]{.ins} [forward]{.sub} [stub]{.arg} [forward]{.arg}
[object]{.ins} [graft]{.sub} [stub]{.arg} [forward]{.arg}
[object]{.ins} [InitializePublic]{.sub}
[object]{.ins} [Eval\_Script]{.sub} [script]{.optarg}
[object]{.ins} [Option\_Default]{.sub} [field]{.arg}
:::

tool::define **class\_method** *arglist* *body*

tool::define **array** *name* *contents*

tool::define **array\_ensemble** *methodname* *varname* ?cases?

tool::define **dict\_ensemble** *methodname* *varname* ?cases?

tool::define **method** *methodname* *arglist* *body*

tool::define **option** *name* *dictopts*

tool::define **property** ?branch? *field* *value*

tool::define **variable** *name* *value*

# Description

This module implements the Tcl Object Oriented Library framework, or *TOOL*. It is intended to be a general purpose framework that is useable in its own right, and easily extensible.

TOOL defines a metaclass with provides several additional keywords to the TclOO description langauge, default behaviors for its consituent objects, and top-down integration with the capabilities provided by the **oo::meta** package.

The TOOL metaclass was build with the **oo::dialect** package, and thus can be used as the basis for additional metaclasses. As a metaclass, TOOL has it's own "class" class, "object" class, and define namespace.

```
package require tool

# tool::class workds just like oo::class
tool::class create myclass {
}

# tool::define works just like oo::define
tool::define myclass method noop {} {}

# tool::define and tool::class understand additional keywords
tool::define myclass array_ensemble mysettings mysettings {}

# And tool interoperates with oo::define
oo::define myclass method do_something {} { return something }

# TOOL and TclOO objects are interchangeable
oo::class create myooclass {
  superclass myclass
}
```

Several manual pages go into more detail about specific keywords and methods.

- **tool::array\_ensemble**
- [tool::dict\_ensemble][tool_dict_ensemble]
- **tool::method\_ensemble**
- **tool::object**
- **tool::option\_handling**


# Keywords

TOOL adds new (or modifies) keywords used in the definitions of classes. However, the new keywords are only available via calls to *tool::class create* or *tool::define*

tool::define **class\_method** *arglist* *body*
: Defines a method for the class object itself. This method will be passed on to descendents of the class, unlike **self method**.

tool::define **array** *name* *contents*
: Declares a variable *name* which will be initialized as an array, populated with *contents* for objects of this class, as well as any objects for classes which are descendents of this class.

tool::define **array\_ensemble** *methodname* *varname* ?cases?
: Declares a method ensemble *methodname* which will control access to variable *varname*. Cases are a key/value list of method names and bodies which will be overlaid on top of the standard template. See **tool::array\_ensemble**.

    One method name is reserved: **initialize**. **initialize** Declares the initial values to be populated in the array, as a key/value list, and will not be expressed as a method for the ensemble.

tool::define **dict\_ensemble** *methodname* *varname* ?cases?
: Declares a method ensemble *methodname* which will control access to variable *varname*. Cases are a key/value list of method names and bodies which will be overlaid on top of the standard template. See [tool::dict\_ensemble][tool_dict_ensemble].

    One method name is reserved: **initialize**. **initialize** Declares the initial values to be populated in the array, as a key/value list, and will not be expressed as a method for the ensemble.

tool::define **method** *methodname* *arglist* *body*
: If *methodname* contains ::, the method is considered to be part of a method ensemble. See **tool::method\_ensembles**. Otherwise this command behaves exactly like the standard **oo::define** **method** command.

tool::define **option** *name* *dictopts*
: Declares an option. *dictopts* is a key/value list defining parameters for the option. See **tool::option\_handling**.

    ```
    tool::class create myclass {
      option color {
        post-command: {puts [list %self%'s %field% is now %value%]}
        default: green
      }
    }
    myclass create foo
    foo configure color purple
    > foo's color is now purple
    ```

tool::define **property** ?branch? *field* *value*
: Defines a new leaf in the class metadata tree. With no branch, the leaf will appear in the *const* section, accessible by either the object's **property** method, or via **oo::meta::info** *class* **get const** *field*:

tool::define **variable** *name* *value*
: Declares a variable *name* which will be initialized with the value *value* for objects of this class, as well as any objects for classes which are descendents of this class.


# Public object methods

The TOOL object mother of all classes defines several methods to enforces consistent behavior throughout the framework.

*object* **cget** *option*
: Return the value of this object's option *option*. If the **property options\_strict** is true for this class, calling an option which was not declared by the **option** keyword will throw an error. In all other cases if the value is present in the object's *options* array that value is returned. If it does not exist, the object will attempt to retrieve a property of the same name.

*object* **configure** ?keyvaluelist?
: see below ...

*object* **configure** *field* *value* ?field? ?value? ?...?
: This command will inject new values into the objects *options* array, according to the rules as set forth by the option descriptions. See **tool::option\_handling** for details. **configure** will strip leading -'s off of field names, allowing it to behave in a quasi-backward compatible manner to tk options.

*object* **configurelist** ?keyvaluelist?
: This command will inject new values into the objects *options* array, according to the rules as set forth by the option descriptions. This command will perform validation and alternate storage rules. It will not invoke trigger rules. See **tool::option\_handling** for details.

*object* **forward** *stub* *forward*
: A passthrough to **oo:objdefine \[self\] forward**

*object* **graft** *stub* *forward*
: Delegates the *<stub>* method to the object or command designated by *forward*

    ```
    tool::object create A
    tool::object create B
    A graft buddy B
    A configure color red
    B configure color blue
    A cget color
    > red
    A <buddy> cget color
    > blue
    ```


# Private object methods

*object* **InitializePublic**
: Consults the metadata for the class to ensure every array, option, and variable which has been declared but not initialized is initialized with the default value. This method is called by the constructor and the morph method. It is safe to invoke multiple times.

*object* **Eval\_Script** ?script?
: Executes a block of text within the namespace of the object. Lines that begin with a # are ignored as comments. Commands that begin with :: are interpreted as calling a global command. All other Tcl commands that lack a "my" prefix are given one, to allow the script to exercise internal methods. This method is intended for configuration scripts, where the object's methods are intepreting a domain specific language.

    ```
    tool::class myclass {
      constructor script {
        my Eval_Script $script
      }
      method node {nodename info} {
        my variable node
        dict set node $nodename $info
      }
      method get {args} {
        my variable node
        return [dict get $node $args]
      }
    }
    myclass create movies {
      # This block of code is executed by the object
      node {The Day the Earth Stood Still} {
        date: 1952
        characters: {GORT Klatoo}
      }
    }
    movies get {The Day the Earth Stood Still} date:
    > 1952
    ```

*object* **Option\_Default** *field*
: Computes the default value for an option. See **tool::option\_handling**.


# Authors

Sean Woods

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *tcloo* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

TclOO

# Copyright

```
Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
```


[tool_dict_ensemble]: tool_dict_ensemble.md
