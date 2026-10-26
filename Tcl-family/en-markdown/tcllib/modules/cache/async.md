---
CommandName: cache::async
ManualSection: n
Version: 0.3.2
TclPart: tcllib
TclDescription: In-memory caches
Keywords:
 - asynchronous
 - cache
 - callback
 - synchronous
Copyright:
 - Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

cache::async - Asynchronous in-memory cache

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [cache::async]{.lit} [0.3.2]{.optlit} 
[::cache::async]{.cmd} [objectName]{.arg} [commandprefix]{.arg} [options]{.optdot} 
[objectName]{.ins} [get]{.sub} [key]{.arg} [donecmdprefix]{.arg} 
[objectName]{.ins} [set]{.sub} [key]{.arg} [value]{.arg} 
[objectName]{.ins} [unset]{.sub} [key]{.arg} 
[objectName]{.ins} [exists]{.sub} [key]{.arg} 
[objectName]{.ins} [clear]{.sub} [key]{.optarg} 
:::

# Description

This package provides objects which cache data in memory, and operate asynchronously with regard to request and responses. The objects are agnostic with regard to cache keys and values, and unknown methods are delegated to the provider of cached data. These two properties make it easy to use caches as a facade for any data provider.

# Api

The package exports a class, **cache::async**, as specified below.

**::cache::async** *objectName* *commandprefix* ?*options*...?
: The command creates a new *cache* object with an associated global Tcl command whose name is *objectName*.  This command may be used to invoke various operations on the object. The *commandprefix* is the action to perform when an user asks for data in the cache and the cache doesn't yet know about the key. When run the commandprefix is given three additional arguments, the string **get**, the key requested, and the cache object itself, in the form of its object command, in this order. The execution of the action is done in an idle-handler, decoupling it from the original request. The only supported option is


**-full-async-results**
: This option defines the behaviour of the cache for when requested keys are known to the cache at the time of **get** request. By default such requeste are responded to asynchronously as well. Setting this option to **false** forces the cache to respond to them synchronuously, although still through the specified callback.


The object commands created by the class commands above have the form:

*objectName* **get** *key* *donecmdprefix*
: This method requests the data for the *key* from the cache. If the data is not yet known the command prefix specified during construction of the cache object is used to ask for this information. Whenever the information is/becomes available the *donecmdprefix* will be run to transfer the result to the caller. This command prefix is invoked with either 2 or 3 arguments, i.e.


**\[1\]**
: The string **set**, the *key*, and the value.

**\[2\]**
: The string **unset**, and the *key*.


: These two possibilities are used to either signal the value for the *key*, or that the *key* has no value defined for it. The latter is distinct from the cache not knowing about the *key*. For a cache object configured to be fully asynchronous (default) the *donecmdprefix* is always run in an idle-handler, decoupling it from the request. Otherwise the callback will be invoked synchronously when the *key* is known to the cache at the time of the invokation. Another important part of the cache's behaviour, as it is asynchronous it is possible that multiple **get** requests are issued for the same *key* before it can respond. In that case the cache will issue only one data request to the provider, for the first of these, and suspend the others, and then notify all of them when the data becomes available.


*objectName* **set** *key* *value*
: ...see next...

*objectName* **unset** *key*
: These two methods are provided to allow users of the cache to make keys known to the cache, as either having a *value*, or as undefined. It is expected that the data provider (see *commandprefix* of the constructor) uses them in response to data requests for unknown keys. Note how this matches the cache's own API towards its caller, calling the *donecmd* of **get**-requests issued to itself with either "set key value" or "unset key", versus issuing **get**-requests to its own provider with itself in the place of the *donecmd*, expecting to be called with either "set key value" or "unset key". This also means that these methods invoke the *donecmd* of all **get**-requests waiting for information about the modified *key*.

*objectName* **exists** *key*
: This method queries the cache for knowledge about the *key* and returns a boolean value. The result is **true** if the key is known, and **false** otherwise.

*objectName* **clear** ?*key*?
: This method resets the state of either the specified *key* or of all keys known to the cache, making it unkown. This forces future **get**-requests to reload the information from the provider.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *cache* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Copyright

```
Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
