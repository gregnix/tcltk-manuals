---
CommandName: transfer::data::source
title: transfer::data::source
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - data source
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::data::source - Data source

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::data::source]{.lit} [0.3]{.optlit}
[transfer::data::source]{.cmd} [objectName]{.arg} [options...]{.optarg}
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [type]{.sub}
[objectName]{.ins} [data]{.sub}
[objectName]{.ins} [size]{.sub}
[objectName]{.ins} [valid]{.sub} [msgvar]{.arg}
[objectName]{.ins} [transmit]{.sub} [channel]{.arg} [blocksize]{.arg} [done]{.arg}
:::

# Description

This package provides objects mainly describing the origin of some data to transfer. They are also able to initiate transfers of the described information to a channel using the foundation package **transfer::copy**.

# API

## Package commands

**transfer::data::source** *objectName* ?*options*...?
: This command creates a new data source object with an associated Tcl command whose name is *objectName*. This *object* command is explained in full detail in the sections [Object command] and [Object methods]. The set of supported *options* is explained in section [Options].

    The object command will be created under the current namespace if the *objectName* is not fully qualified, and in the specified namespace otherwise. The fully qualified name of the object command is returned as the result of the command.


## Object command

All objects created by the **::transfer::data::source** command have the following general form:

*objectName* **method** ?*arg arg ...*?
: The method **method** and its *arg*'uments determine the exact behavior of the command. See section [Object methods] for the detailed specifications.


## Object methods

*objectName* **destroy**
: This method destroys the object. Doing so while a transfer initiated by the object is active is safe as all data required for the transfer itself was copied, and the completion of the transfer will not try to access the initiating object anymore. i.e. the transfer is completely separate from the source object itself.

*objectName* **type**
: This method returns a string describing the type of the data the object is refering to. The possible values and their meanings are:

    **undefined**
    : No data was specified at all, or it was specified incompletely. The object does not know the type.

    **string**
    : The data to transfer is contained in a string.

    **channel**
    : The data to transfer is contained in a channel.


*objectName* **data**
: This method returns a value depending on the type of the data the object refers to, through which the data can be accessed. The method throws an error if the type is **undefined**. For type **string** the returned result is the data itself, whereas for type **channel** the returned result is the handle of the channel containing the data.

*objectName* **size**
: This method returns a value depending on the type of the data the object refers to, the size of the data. The method throws an error if the type is **undefined**. Return of a negative value signals that the object is unable to determine an absolute size upfront (like for data in a channel).

*objectName* **valid** *msgvar*
: This method checks the configuration of the object for validity. It returns a boolean flag as result, whose value is **True** if the object is valid, and **False** otherwise. In the latter case the variable whose name is stored in *msgvar* is set to an error message describing the problem found with the configuration. Otherwise this variable is not touched.

*objectName* **transmit** *channel* *blocksize* *done*
: This method initiates a transfer of the referenced data to the specified *channel*. When the transfer completes the command prefix *done* is invoked, per the rules for the option **-command** of command [transfer::copy::do][copyops] in the package **transfer::copy**. The *blocksize* specifies the size of the chunks to transfer in one go. See the option **-blocksize** of command [transfer::copy::do][copyops] in the package **transfer::copy**.


## Options

All data sources support the options listed below. It should be noted that the first four options are semi-exclusive, each specifying a different type of data source and associated content. If these options are specified more than once then the last option specified is used to actually configure the object.

**-string** *text*
: This option specifies that the source of the data is an immediate string, and its associated argument contains the string in question.

**-channel** *handle*
: This option specifies that the source of the data is a channel, and its associated argument is the handle of the channel containing the data.

**-file** *path*
: This option specifies that the source of the data is a file, and its associated argument is the path of the file containing the data.

**-variable** *varname*
: This option specifies that the source of the data is a string stored in a variable, and its associated argument contains the name of the variable in question. The variable is assumed to be global or namespaced, anchored at the global namespace.

**-size** *int*
: This option specifies the size of the data transfer. It is optional and defaults to -1. This value, and any other value less than zero signals to transfer all the data from the source.

**-progress** *command*
: This option, if specified, defines a command to be invoked for each chunk of bytes transmitted, allowing the user to monitor the progress of the transmission of the data. The callback is always invoked with one additional argument, the number of bytes transmitted so far.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *transfer* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Transfer module

# Copyright

```
Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[copyops]: copyops.md
