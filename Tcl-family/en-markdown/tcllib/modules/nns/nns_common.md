---
CommandName: nameserv::common
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::client(n)
 - nameserv::server(n)
Keywords:
 - client
 - name service
 - server
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nameserv::common - Name service facility, shared definitions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [nameserv::common]{.lit} [0.2]{.optlit} 
[::nameserv::common::port]{.cmd} 
:::

# Description

Please read *Name service facility, introduction* first.

This package is internal and of no interest to users. It provides the commands of the name service facility which are shared by the client and server implemented by the packages **nameserv::server** and **nameserv** (the client).

This service is built in top of and for the package **comm**. It has nothing to do with the Internet's Domain Name System. If the reader is looking for a package dealing with that please see Tcllib's packages **dns** and **resolv**.

# Api

The package exports a single command, as specified below:

**::nameserv::common::port**
: The result returned by the command is the id of the default TCP/IP port a nameservice server will listen on, and a name service client will try to connect to.


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
