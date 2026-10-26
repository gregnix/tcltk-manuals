---
CommandName: nameserv::server
ManualSection: n
Version: 0.3.3
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::client(n)
 - nameserv::common(n)
Keywords:
 - name service
 - server
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nameserv::server - Name service facility, Server

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [nameserv::server]{.lit} [0.3.3]{.optlit} 
[package]{.cmd} [require]{.sub} [comm]{.lit} 
[package]{.cmd} [require]{.sub} [interp]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[::nameserv::server::start]{.cmd} 
[::nameserv::server::stop]{.cmd} 
[::nameserv::server::active?]{.cmd} 
[::nameserv::server::cget]{.cmd} [-option]{.sub} 
[::nameserv::server::configure]{.cmd} 
[::nameserv::server::configure]{.cmd} [-option]{.sub} 
[::nameserv::server::configure]{.cmd} [-option]{.sub} [value...]{.arg} 
:::

# Description

Please read *Name service facility, introduction* first.

This package provides an implementation of the serviver side of the name service facility queried by the client provided by the package **nameserv**. All information required by the server will be held in memory. There is no persistent state.

This service is built in top of and for the package **comm**. It has nothing to do with the Internet's Domain Name System. If the reader is looking for a package dealing with that please see Tcllib's packages **dns** and **resolv**.

This server supports the *Core* protocol feature, and since version 0.3 the *Search/Continuous* feature as well.

# Api

The package exports five commands, as specified below:

**::nameserv::server::start**
: This command starts the server and causes it to listen on the configured port. From now on clients are able to connect and make requests. The result of the command is the empty string. Note that any incoming requests will only be handled if the application the server is part of does enter an event loop after this command has been run.

**::nameserv::server::stop**
: Invoking this command stops the server and releases all information it had. Existing connections are shut down, and no new connections will be accepted any longer. The result of the command is the empty string.

**::nameserv::server::active?**
: This command returns a boolean value indicating the state of the server. The result will be **true** if the server is active, i.e. has been started, and **false** otherwise.

**::nameserv::server::cget** **-option**
: This command returns the currently configured value for the specified **-option**. The list of supported options and their meaning can be found in section **OPTIONS**.

**::nameserv::server::configure**
: In this form the command returns a dictionary of all supported options, and their current values. The list of supported options and their meaning can be found in section **OPTIONS**.

**::nameserv::server::configure** **-option**
: In this form the command is an alias for "**::nameserv::server::cget** **-option**". The list of supported options and their meaning can be found in section **OPTIONS**.

**::nameserv::server::configure** **-option** *value*...
: In this form the command is used to configure one or more of the supported options. At least one option has to be specified, and each option is followed by its new value. The list of supported options and their meaning can be found in section **OPTIONS**. This form can be used only if the server is not active, i.e. has not been started yet, or has been stopped. While the server is active it cannot be reconfigured.


# Options

The options supported by the server are for the specification of the TCP port to listen on, and whether to accept non-local connections or not. They are:

**-localonly** *bool*
: This option specifies whether to accept only local connections (-localonly 1) or remote connections as well (-localonly 0). The default is to accept only local connections.

**-port** *number*
: This option specifies the port the name service will listen on after it has been started. It has to be a positive integer number (> 0) not greater than 65536 (unsigned short). The initial default is the number returned by the command **::nameserv::server::common::port**, as provided by the package **::nameserv::server::common**.


# History

**0.3**
: Extended the server with the ability to perform asynchronous and continuous searches.

**0.2**
: Changed name of -local switch to -localonly.

**0.1**
: Initial implementation of the server.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *nameserv* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
