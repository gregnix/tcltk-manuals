---
CommandName: transfer::data::destination
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - data destination
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::data::destination - Data destination

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::data::destination]{.lit} [0.3]{.optlit} 
[transfer::data::destination]{.cmd} [objectName]{.arg} [options]{.optdot} 
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [put]{.sub} [chunk]{.arg} 
[objectName]{.ins} [done]{.sub} 
[objectName]{.ins} [valid]{.sub} [msgvar]{.arg} 
[objectName]{.ins} [receive]{.sub} [channel]{.arg} [done]{.arg} 
:::

# Description

This package provides objects mainly describing the destination of a data transfer. They are also able to initiate the reception of information from a channel into the described destination.

# Api

**transfer::data::destination** *objectName* ?*options*...?
: This command creates a new data destination object with an associated Tcl command whose name is *objectName*. This *object* command is explained in full detail in the sections **Object command** and **Object methods**. The set of supported *options* is explained in section **Options**. The object command will be created under the current namespace if the *objectName* is not fully qualified, and in the specified namespace otherwise. The fully qualified name of the object command is returned as the result of the command.


## Object command

All objects created by the **::transfer::data::destination** command have the following general form:

*objectName* **method** ?*arg arg ...*?
: The method **method** and its *arg*'uments determine the exact behavior of the command. See section **Object methods** for the detailed specifications.


## Object methods

*objectName* **destroy**
: This method destroys the object. Doing so while the object is busy with the reception of information from a channel will cause errors later on, when the reception completes and tries to access the now missing data structures of the destroyed object.

*objectName* **put** *chunk*
: The main receptor method. Saves the received *chunk* of data into the configured destination. It has to be called for each piece of data received.

*objectName* **done**
: The secondary receptor method. Finalizes the receiver. It has to be called when the receiving channel signals EOF. Afterward neither itself nor method **put** can be called anymore.

*objectName* **valid** *msgvar*
: This method checks the configuration of the object for validity. It returns a boolean flag as result, whose value is **True** if the object is valid, and **False** otherwise. In the latter case the variable whose name is stored in *msgvar* is set to an error message describing the problem found with the configuration. Otherwise this variable is not touched.

*objectName* **receive** *channel* *done*
: This method initiates the reception of data from the specified *channel*. The received data will be stored into the configured destination, via calls to the methods **put** and **done**. When the reception completes the command prefix *done* is invoked, with the number of received characters appended to it as the sole additional argument.


## Options

All data destinations support the options listed below. It should be noted that all are semi-exclusive, each specifying a different type of destination and associated information. If these options are specified more than once then the last option specified is used to actually configure the object.

**-channel** *handle*
: This option specifies that the destination of the data is a channel, and its associated argument is the handle of the channel to write the received data to.

**-file** *path*
: This option specifies that the destination of the data is a file, and its associated argument is the path of the file to write the received data to.

**-variable** *varname*
: This option specifies that the destination of the data is a variable, and its associated argument contains the name of the variable to write the received data to. The variable is assumed to be global or namespaced, anchored at the global namespace.

**-progress** *command*
: This option, if specified, defines a command to be invoked for each chunk of bytes received, allowing the user to monitor the progress of the reception of the data. The callback is always invoked with one additional argument, the number of bytes received so far.


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
