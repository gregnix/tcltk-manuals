---
CommandName: transfer::transmitter
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - data source
 - secure
 - ssl
 - tls
 - transfer
 - transmitter
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::transmitter - Data source

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::data::source]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::connect]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::transmitter]{.lit} [0.3]{.optlit} 
[transfer::transmitter]{.cmd} [objectName]{.arg} [options]{.optdot} 
[transfer::transmitter]{.cmd} [stream]{.sub} [channel]{.lit} [chan]{.arg} [host]{.arg} [port]{.arg} [arg]{.optdot} 
[transfer::transmitter]{.cmd} [stream]{.sub} [file]{.lit} [path]{.arg} [host]{.arg} [port]{.arg} [arg]{.optdot} 
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [start]{.sub} 
[objectName]{.ins} [busy]{.sub} 
:::

# Description

This package pulls data sources and connection setup together into a combined object for the transmission of information over a socket. These objects understand all the options from objects created by the packages **transfer::data::source** and **transfer::connect**.

# Api

## Package commands

**transfer::transmitter** *objectName* ?*options*...?
: This command creates a new transmitter object with an associated Tcl command whose name is *objectName*. This *object* command is explained in full detail in the sections **Object command** and **Object methods**. The set of supported *options* is explained in section **Options**. The object command will be created under the current namespace if the *objectName* is not fully qualified, and in the specified namespace otherwise. The fully qualified name of the object command is returned as the result of the command.

**transfer::transmitter** **stream channel** *chan* *host* *port* ?*arg*...?
: This method creates a fire-and-forget transfer for the data contained in the channel *chan*, starting at the current seek location. The channel is configured to use binary translation and encoding for the transfer. The channel is automatically closed when the transfer has completed. If both *host* and *port* are provided an **active** connection to the destination is made. If only a *port* is specified (with *host* the empty string) then a **passive** connection is made instead. Any arguments after the port are treated as options and are used to configure the internal transmitter object. See the section **Options** for a list of the supported options and their meaning. *Note* however that the signature of the command prefix specified for the **-command** callback differs from the signature for the same option of the transmitter object. This callback is only given the number of bytes and transfered, and possibly an error message. No reference to the internally used transmitter object is made. The result returned by the command is the empty string if it was set to make an *active* connection, and the port the internal transmitter object is listening on otherwise, i.e when it is configured to connect *passive*ly. See also the package **transfer::connect** and the description of the method **connect** for where this behaviour comes from.

**transfer::transmitter** **stream file** *path* *host* *port* ?*arg*...?
: This method is like **stream channel**, except that the data contained in the file *path* is transfered.


## Object command

All objects created by the **::transfer::transmitter** command have the following general form:

*objectName* **method** ?*arg arg ...*?
: The method **method** and its *arg*'uments determine the exact behavior of the command. See section **Object methods** for the detailed specifications.


## Object methods

*objectName* **destroy**
: This method destroys the object. Doing so while a transmission is in progress will cause errors later on, when the transmission completes and tries to access the now missing data structures of the destroyed object.

*objectName* **start**
: This method initiates the data transmission, setting up the connection first and then copying the information. The method will throw an error if a transmission is already/still in progress. I.e. it is not possible to run two transmissions in parallel on a single object, only in sequence. Multiple transmitter objects are needed to manage parallel transfers, one per transmission. Errors will also be thrown if the configuration of the data source is invalid, or if no completion callback was specified. The result returned by the method is the empty string for an object configured to make an *active* connection, and the port the object is listening on otherwise, i.e when it is configured to connect *passive*ly. See also the package **transfer::connect** and the description of the method **connect** for where this behaviour comes from.

*objectName* **busy**
: This method returns a boolean value telling us whether a transmission is in progress (**True**), or not (**False**).


## Options

All transmitter objects support the union of the options supported by their connect and data source components, plus two of their own. See also the documentation for the packages **transfer::data::source** and **transfer::connect**.

**-blocksize** *int*
: This option specifies the size of the chunks to be transmitted in one block. Usage is optional, its default value is **1024**.

**-command** *cmdprefix*
: This option specifies the command to invoke when the transmission of the information has been completed. The arguments given to this command are the same as given to the completion callback of the command **transfer::copy::do** provided by the package **transfer::copy**.

**-mode** *mode*
: This option specifies the mode the object is in. It is optional and defaults to **active** mode. The two possible modes are:


**active**
: In this mode the two options **-host** and **-port** are relevant and specify the host and TCP port the object has to connect to. The host is given by either name or IP address.

**passive**
: In this mode the option **-host** has no relevance and is ignored should it be configured. The only option the object needs is **-port**, and it specifies the TCP port on which the listening socket is opened to await the connection from the partner.


**-host** *hostname-or-ipaddr*
: This option specifies the host to connect to in *active* mode, either by name or ip-address. An object configured for *passive* mode ignores this option.

**-port** *int*
: For *active* mode this option specifies the port the object is expected to connect to. For *passive* mode however it is the port where the object creates the listening socket waiting for a connection. It defaults to **0**, which allows the OS to choose the actual port to listen on.

**-socketcmd** *command*
: This option allows the user to specify which command to use to open a socket. The default is to use the builtin **::socket**. Any compatible with that command is allowed. The envisioned main use is the specfication of **tls::socket**. I.e. this option allows the creation of secure transfer channels, without making this package explicitly dependent on the **tls** package. See also section **Secure connections**.

**-encoding** encodingname
: ...see next...

**-eofchar** eofspec
: ...see next...

**-translation** transspec
: These options are the same as are recognized by the builtin command **fconfigure**. They provide the configuration to be set for the channel between the two partners after it has been established, but before the callback is invoked (See method **connect**).

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


# Secure connections

One way to secure connections made by objects of this package is to require the package **tls** and then configure the option **-socketcmd** to force the use of command **tls::socket** to open the socket.

```
    # Load and initialize tls
    package require tls
    tls::init -cafile /path/to/ca/cert -keyfile ...

    # Create a connector with secure socket setup,
    transfer::transmitter T -socketcmd tls::socket ...
    ...
```

# Tls security considerations

This package uses the **TLS** package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

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
