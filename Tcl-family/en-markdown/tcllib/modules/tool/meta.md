---
CommandName: oo::util
title: oo::util
ManualSection: n
Version: 1.2.2
TclPart: tcllib
TclDescription: Utility commands for TclOO
Links:
 - snit(n)
Keywords:
 - TclOO
 - callback
 - class methods
 - class variables
 - command prefix
 - currying
 - method reference
 - my method
 - singleton
Copyright:
 - Copyright (c) 2011-2015 Andreas Kupries, BSD licensed
---

# Name

oo::util - Utility commands for TclOO

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [oo::util]{.lit} [1.2.2]{.optlit}
[mymethod]{.cmd} [method]{.arg} [arg...]{.optarg}
[classmethod]{.cmd} [name]{.arg} [arguments]{.arg} [body]{.arg}
[classvariable]{.cmd} [arg...]{.optarg}
[link]{.cmd} [method...]{.arg}
[link]{.cmd} {alias method}...
[ooutil::singleton]{.cmd} [arg...]{.optarg}
:::

# Description

This package provides a convenience command for the easy specification of instance methods as callback commands, like timers, file events, Tk bindings, etc.

# Commands

**mymethod** *method* ?*arg*...?
: This command is available within instance methods. It takes a method name and, possibly, arguments for the method and returns a command prefix which, when executed, will invoke the named method of the object we are in, with the provided arguments, and any others supplied at the time of actual invokation.

    Note: The command is equivalent to and named after the command provided by the OO package **snit** for the same purpose.

**classmethod** *name* *arguments* *body*
: This command is available within class definitions. It takes a method name and, possibly, arguments for the method and creates a method on the class, available to a user of the class and of derived classes.

    Note: The command is equivalent to the command **typemethod** provided by the OO package **snit** for the same purpose.

    Example

    ```
    oo::class create ActiveRecord {
        classmethod find args { puts "[self] called with arguments: $args" }
    }
    oo::class create Table {
        superclass ActiveRecord
    }
    puts [Table find foo bar]
    # ======
    # which will write
    # ======
    # ::Table called with arguments: foo bar
    ```

**classvariable** ?*arg*...?
: This command is available within instance methods. It takes a series of variable names and makes them available in the method's scope. The originating scope for the variables is the class (instance) the object instance belongs to. In other words, the referenced variables are shared between all instances of their class.

    Note: The command is roughly equivalent to the command **typevariable** provided by the OO package **snit** for the same purpose. The difference is that it cannot be used in the class definition itself.

    Example:

    ```
    % oo::class create Foo {
        method bar {z} {
            classvariable x y
            return [incr x $z],[incr y]
        }
    }
    ::Foo
    % Foo create a
    ::a
    % Foo create b
    ::b
    % a bar 2
    2,1
    % a bar 3
    5,2
    % b bar 7
    12,3
    % b bar -1
    11,4
    % a bar 0
    11,5
    ```

**link** *method*...
: see below ...

**link** {*alias* *method*}...
: This command is available within instance methods. It takes a list of method names and/or pairs of alias- and method-name and makes the named methods available to all instance methods without requiring the **my** command.

    The alias name under which the method becomes available defaults to the method name, except where explicitly specified through an alias/method pair.

    Examples:

    ```
        link foo
        # The method foo is now directly accessible as foo instead of my foo.

        link {bar foo}
        # The method foo is now directly accessible as bar.

        link a b c
        # The methods a, b, and c all become directly acessible under their
        # own names.
    ```

    The main use of this command is expected to be in instance constructors, for convenience, or to set up some methods for use in a mini DSL.

**ooutil::singleton** ?*arg*...?
: This command is a meta-class, i.e. a variant of the builtin **oo::class** which ensures that it creates only a single instance of the classes defined with it.

    Syntax and results are like for **oo::class**.

    Example:

    ```
    % oo::class create example {
       self mixin singleton
       method foo {} {self}
    }
    ::example
    % [example new] foo
    ::oo::Obj22
    % [example new] foo
    ::oo::Obj22
    ```


# Authors

Donal Fellows, Andreas Kupries

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *oo::util* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Utility

# Copyright

```
Copyright (c) 2011-2015 Andreas Kupries, BSD licensed
```
