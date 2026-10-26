---
CommandName: transfer::copy::queue
title: transfer::copy::queue
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - queue
 - transfer
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::copy::queue - Queued transfers

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit}
[package]{.cmd} [require]{.sub} [struct::queue]{.lit} [1.4]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::copy::queue]{.lit} [0.2]{.optlit}
[transfer::copy::queue]{.cmd} [objectName]{.arg} [outchannel]{.arg} [options...]{.optarg}
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [busy]{.sub}
[objectName]{.ins} [pending]{.sub}
[objectName]{.ins} [put]{.sub} [request]{.arg}
:::

# Description

This package provides objects which serialize transfer requests for a single channel by means of a fifo queue. Accumulated requests are executed in order of entrance, with the first request reaching an idle object starting the execution in general. New requests can be added while the object is active and are defered until all requests entered before them have been completed successfully.

When a request causes a transfer error execution stops and all requests coming after it are not served. Currently this means that their completion callbacks are never triggered at all.

*NOTE*: Not triggering the completion callbacks of the unserved requests after an error stops the queue object is something I am not fully sure that it makes sense. It forces the user of the queue to remember the callbacks as well and run them. Because otherwise everything in the system which depends on getting a notification about the status of a request will hang in the air. I am slowly convincing myself that it is more sensible to trigger the relevant completion callbacks with an error message about the queue abort, and 0 bytes transfered.

All transfer requests are of the form

```
	{type data options...}
```

where *type* is in {**chan**, **string**}, and *data* specifies the information to transfer. For **chan** the data is the handle of the channel containing the actual information to transfer, whereas for **string** *data* contains directly the information to transfer. The *options* are a list of them and their values, and are the same as are accepted by the low-level copy operations of the package **transfer::copy**. Note how just prepending the request with [transfer::copy::do][copyops] and inserting a channel handle in between *data* and *options* easily transforms it from a pure data structure into a command whose evaluation will perform the request.

# API

## Package commands

**transfer::copy::queue** *objectName* *outchannel* ?*options*...?
: This command creates a new queue object for the management of the channel *outchannel*, with an associated Tcl command whose name is *objectName*. This *object* command is explained in full detail in the sections [Object command] and [Object methods]. The set of supported *options* is explained in section [Options].

    The object command will be created under the current namespace if the *objectName* is not fully qualified, and in the specified namespace otherwise. The fully qualified name of the object command is returned as the result of the command.


## Object command

All objects created by the **::transfer::copy::queue** command have the following general form:

*objectName* **method** ?*arg arg ...*?
: The method **method** and its *arg*'uments determine the exact behavior of the command. See section [Object methods] for the detailed specifications.


## Object methods

*objectName* **destroy**
: This method destroys the object. Doing so while the object is busy will cause errors later on, when the currently executed request completes and tries to access the now missing data structures of the destroyed object.

*objectName* **busy**
: This method returns a boolean value telling us if the object is currently serving a request (i.e. *busy*, value **True**), or not (i.e. *idle*, value **False**).

*objectName* **pending**
: This method returns the number of requests currently waiting in the queue for their execution. A request currently served is not counted as waiting.

*objectName* **put** *request*
: This method enters the transfer *request* into the object's queue of waiting requests. If the object is *idle* it will become *busy*, immediately servicing the request. Otherwise servicing the new request will be defered until all preceding requests have been served.


# Options

The only option known is **-on-status-change**. It is optional and defaults to the empty list, disabling the reporting of status changes. Otherwise its argument is a command prefix which is invoked whenever the internal status of the object changed. The callback is invoked with two additional arguments, the result of the methods **pending** and **busy**, in this order. This allows any user to easily know, for example, when the object has processed all outstanding requests.

# Use

A possible application of this package and class is within a HTTP 1.1 server, managing the results waiting for transfer to the client.

It should be noted that in this application the system also needs an additional data structure which keeps track of outstanding results as they may come back in a different order than the requests from the client, and releases them to the actual queue in the proper order.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *transfer* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Transfer module

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[copyops]: copyops.md
