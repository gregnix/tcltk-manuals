---
CommandName: hook
title: hook
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Hooks
Links:
 - uevent(n)
Keywords:
 - callback
 - event
 - hook
 - observer
 - producer
 - publisher
 - subject
 - subscriber
 - uevent
Copyright:
 - Copyright (c) 2010, by William H. Duquette
---

# Name

hook - Hooks

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [hook]{.lit} [0.3]{.optlit}
[hook]{.cmd} [bind]{.lit} [subject]{.optarg} [hook]{.optarg} [observer]{.optarg} [cmdPrefix]{.optarg}
[hook]{.cmd} [call]{.lit} [subject]{.arg} [hook]{.arg} [args...]{.optarg}
[hook]{.cmd} [forget]{.lit} [object]{.arg}
[hook]{.cmd} [cget]{.lit} [option]{.arg}
[hook]{.cmd} [configure]{.lit} [option]{.lit} [value]{.arg} ...
:::

# Description

This package provides the **hook** ensemble command, which implements the Subject/Observer pattern. It allows *subjects*, which may be *modules*, *objects*, *widgets*, and so forth, to synchronously call *hooks* which may be bound to an arbitrary number of subscribers, called *observers*. A subject may call any number of distinct hooks, and any number of observers can bind callbacks to a particular hook called by a particular subject. Hook bindings can be queried and deleted.

This man page is intended to be a reference only.

# Concepts

## Introduction

Tcl modules usually send notifications to other modules in two ways: via Tk events, and via callback options like the text widget's **-yscrollcommand** option. Tk events are available only in Tk, and callback options require tight coupling between the modules sending and receiving the notification.

Loose coupling between sender and receiver is often desirable, however.  In Model/View/Controller terms, a View can send a command (stemming from user input) to the Controller, which updates the Model. The Model can then call a hook *to which all relevant Views subscribe.* The Model is decoupled from the Views, and indeed need not know whether any Views actually exist. At present, Tcl/Tk has no standard mechanism for implementing loose coupling of this kind. This package defines a new command, **hook**, which implements just such a mechanism.

## Bindings

The **hook** command manages a collection of hook bindings. A hook binding has four elements:

1. A *subject*: the name of the entity that will be calling the hook.

2. The *hook* itself. A hook usually reflects some occurrence in the life of the *subject* that other entities might care to know about. A *hook* has a name, and may also have arguments. Hook names are arbitrary strings. Each *subject* must document the names and arguments of the hooks it can call.

3. The name of the *observer* that wishes to receive the *hook* from the *subject*.

4. A command prefix to which the *hook* arguments will be appended when the binding is executed.


## Subjects and observers

For convenience, this document collectively refers to subjects and observers as *objects*, while placing no requirements on how these *objects* are actually implemented. An object can be a **TclOO** or **Snit** or **XOTcl** object, a Tcl command, a namespace, a module, a pseudo-object managed by some other object (as tags are managed by the Tk text widget) or simply a well-known name.

Subject and observer names are arbitrary strings; however, as **hook** might be used at the package level, it's necessary to have conventions that avoid name collisions between packages written by different people.

Therefore, any subject or observer name used in core or package level code should look like a Tcl command name, and should be defined in a namespace owned by the package. Consider, for example, an ensemble command **::foo** that creates a set of pseudo-objects and uses **hook** to send notifications. The pseudo-objects have names that are not commands and exist in their own namespace, rather like file handles do. To avoid name collisions with subjects defined by other packages, users of **hook**, these **::foo** handles should have names like **::foo::1**, **::foo::2**, and so on.

Because object names are arbitrary strings, application code can use whatever additional conventions are dictated by the needs of the application.

# Reference

Hook provides the following commands:

**hook** **bind** ?*subject*? ?*hook*? ?*observer*? ?*cmdPrefix*?
: This subcommand is used to create, update, delete, and query hook bindings.

    Called with no arguments it returns a list of the subjects with hooks to which observers are currently bound.

    Called with one argument, a *subject*, it returns a list of the subject's hooks to which observers are currently bound.

    Called with two arguments, a *subject* and a *hook*, it returns a list of the observers which are currently bound to this *subject* and *hook*.

    Called with three arguments, a *subject*, a *hook*, and an *observer*, it returns the binding proper, the command prefix to be called when the hook is called, or the empty string if there is no such binding.

    Called with four arguments, it creates, updates, or deletes a binding. If *cmdPrefix* is the empty string, it deletes any existing binding for the *subject*, *hook*, and *observer*; nothing is returned. Otherwise, *cmdPrefix* must be a command prefix taking as many additional arguments as are documented for the *subject* and *hook*. The binding is added or updated, and the observer is returned.

    If the *observer* is the empty string, "", it will create a new binding using an automatically generated observer name of the form **::hook::ob**<**number**>. The automatically generated name will be returned, and can be used to query, update, and delete the binding as usual. If automated observer names are always used, the observer name effectively becomes a unique binding ID.

    It is possible to call **hook bind** to create or delete a binding to a *subject* and *hook* while in an observer binding for that same *subject* and *hook*. The following rules determine what happens when

    ```
        hook bind $s $h $o $binding
    ```

    is called during the execution of

    ```
        hook call $s $h
    ```

    1. No binding is ever called after it is deleted.

    2. When a binding is called, the most recently given command prefix is always used.

    3. The set of observers whose bindings are to be called is determined when this method begins to execute, and does not change thereafter, except that deleted bindings are not called.


    In particular:

    1. If **$o**s binding to **$s** and **$h** is deleted, and **$o**s binding has not yet been called during this execution of

        ```
            hook call $s $h
        ```

    2. it will not be called. (Note that it might already have been called; and in all likelihood, it is probably deleting itself.)

    3. If **$o** changes the command prefix that's bound to **$s** and **$h**, and if **$o**s binding has not yet been called during this execution of

        ```
            hook call $s $h
        ```

    4. the new binding will be called when the time comes. (But again, it is probably **$o**s binding that is is making the change.)

    5. If a new observer is bound to **$s** and **$h**, its binding will not be called until the next invocation of

        ```
            hook call $s $h
        ```


**hook** **call** *subject* *hook* ?*args*...?
: This command is called when the named *subject* wishes to call the named *hook*. All relevant bindings are called with the specified arguments in the global namespace. Note that the bindings are called synchronously, before the command returns; this allows the *args* to include references to entities that will be cleaned up as soon as the hook has been called.

    The order in which the bindings are called is not guaranteed. If sequence among observers must be preserved, define one observer and have its bindings call the other callbacks directly in the proper sequence.

    Because the **hook** mechanism is intended to support loose coupling, it is presumed that the *subject* has no knowledge of the observers, nor any expectation regarding return values. This has a number of implications:

    1. **hook call** returns the empty string.

    2. Normal return values from observer bindings are ignored.

    3. Errors and other exceptional returns propagate normally by default. This will rarely be what is wanted, because the subjects usually have no knowledge of the observers and will therefore have no particular competence at handling their errors. That makes it an application issue, and so applications will usually want to define an **-errorcommand**.


    If the **-errorcommand** configuration option has a non-empty value, its value will be invoked for all errors and other exceptional returns in observer bindings. See **hook configure**, below, for more information on configuration options.

**hook** **forget** *object*
: This command deletes any existing bindings in which the named *object* appears as either the *subject* or the *observer*. Bindings deleted by this method will never be called again. In particular,

    1. If an observer is forgotten during a call to **hook call**, any uncalled binding it might have had to the relevant subject and hook will *not* be called subsequently.

    2. If a subject **$s** is forgotten during a call to

        ```
        hook call $s $h
        ```

    3. then **hook call** will return as soon as the current binding returns.  No further bindings will be called.


**hook** **cget** *option*
: This command returns the value of one of the **hook** command's configuration options.

**hook** **configure** **option** *value* ...
: This command sets the value of one or more of the **hook** command's configuration options:

    **-errorcommand** *cmdPrefix*
    : If the value of this option is the empty string, "", then errors and other exception returns in binding scripts are propagated normally. Otherwise, it must be a command prefix taking three additional arguments:

        1. a 4-element list {subject hook arglist observer},

        2. the result string, and

        3. the return options dictionary.


        Given this information, the **-errorcommand** can choose to log the error, call **interp bgerror**, delete the errant binding (thus preventing the error from arising a second time) and so forth.

    **-tracecommand** *cmdPrefix*
    : The option's value should be a command prefix taking four arguments:

        1. a *subject*,

        2. a *hook*,

        3. a list of the hook's argument values, and

        4. a list of *objects* the hook was called for.


        The command will be called for each hook that is called. This allows the application to trace hook execution for debugging purposes.



# Example

The **::model** module calls the <Update> hook in response to commands that change the model's data:

```
     hook call ::model <Update>
```

The **.view** megawidget displays the model state, and needs to know about model updates. Consequently, it subscribes to the ::model's <Update> hook.

```
     hook bind ::model <Update> .view [list .view ModelUpdate]
```

When the **::model** calls the hook, the **.view**s ModelUpdate subcommand will be called.

Later the **.view** megawidget is destroyed. In its destructor, it tells the *hook* that it no longer exists:

```
     hook forget .view
```

All bindings involving **.view** are deleted.

# Credits

Hook has been designed and implemented by William H. Duquette.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *hook* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools

# Copyright

```
Copyright (c) 2010, by William H. Duquette
```
