---
CommandName: transfer::connect
title: transfer::connect
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - active
 - channel
 - connection
 - passive
 - secure
 - ssl
 - tls
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::connect - Connection setup

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::connect]{.lit} [0.3]{.optlit}
[transfer::connect]{.cmd} [objectName]{.arg} [options...]{.optarg}
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [connect]{.sub} [command]{.arg}
:::

# Description

This package provides objects holding enough information to enable them to either actively connect to a counterpart, or to passively wait for a connection from said counterpart. I.e. any object created by this packages is always in one of two complementary modes, called *active* (the object initiates the connection) and *passive* (the object receives the connection).

Of the two objects in a connecting pair one has to be configured for *active* mode, and the other then has to be configured for *passive* mode. This establishes which of the two partners connects to whom (the *active* to the other), or, who is waiting on whom (the *passive* on the other). Note that this is completely independent of the direction of any data transmission using the connection after it has been established. An active object can, after establishing the connection, either transmit or receive data. Equivalently the passive object can do the same after the waiting for its partner has ended.

# API

## Package commands

**transfer::connect** *objectName* ?*options*...?
: This command creates a new connection object with an associated Tcl command whose name is *objectName*. This *object* command is explained in full detail in the sections [Object command] and [Object methods]. The set of supported *options* is explained in section [Options].

    The object command will be created under the current namespace if the *objectName* is not fully qualified, and in the specified namespace otherwise. The fully qualified name of the object command is returned as the result of the command.


## Object command

All objects created by the **::transfer::connect** command have the following general form:

*objectName* **method** ?*arg arg ...*?
: The method **method** and its *arg*'uments determine the exact behavior of the command. See section [Object methods] for the detailed specifications.


## Object methods

*objectName* **destroy**
: This method destroys the object. This is safe to do for an *active* object when a connection has been started, as the completion callback is synchronous. For a *passive* object currently waiting for its partner to establish the connection however this is not safe and will cause errors later on, when the connection setup completes and tries to access the now missing data structures of the destroyed object.

*objectName* **connect** *command*
: This method starts the connection setup per the configuration of the object. When the connection is established the callback *command* will be invoked with one additional argument, the channel handle of the socket over which data can be transfered.

    The detailed behaviour of the method depends on the configured mode.

    *active*
    : The connection setup is done synchronously. The object waits until the connection is established. The method returns the empty string as its result.

    *passive*
    : The connection setup is done asynchronously. The method returns immediately after a listening socket has been set up. The connection will be established in the background. The method returns the port number of the listening socket, for use by the caller. One important use is the transfer of this information to the counterpart so that it knows where it has to connect to.

        This is necessary as the object might have been configured for port **0**, allowing the operating system to choose the actual port it will listen on.

        The listening port is closed immediately when the connection was established by the partner, to keep the time interval small within which a third party can connect to the port too. Even so it is recommended to use additional measures in the protocol outside of the connect and transfer object to ensure that a connection is not used with an unidentified/unauthorized partner One possibility for this is the use of SSL/TLS. See the option **-socketcmd** and section [Secure connections] for information on how to do this.



## Options

Connection objects support the set of options listed below.

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
: This option allows the user to specify which command to use to open a socket. The default is to use the builtin **::socket**. Any compatible with that command is allowed.

    The envisioned main use is the specfication of **tls::socket**. I.e. this option allows the creation of secure transfer channels, without making this package explicitly dependent on the **tls** package.

    See also section [Secure connections].

**-encoding** encodingname
: see below ...

**-eofchar** eofspec
: see below ...

**-translation** transspec
: These options are the same as are recognized by the builtin command **fconfigure**. They provide the configuration to be set for the channel between the two partners after it has been established, but before the callback is invoked (See method **connect**).


# Secure connections

One way to secure connections made by objects of this package is to require the package **tls** and then configure the option **-socketcmd** to force the use of command **tls::socket** to open the socket.

```
    # Load and initialize tls
    package require tls
    tls::init -cafile /path/to/ca/cert -keyfile ...

    # Create a connector with secure socket setup,
    transfer::connect C -socketcmd tls::socket ...
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
