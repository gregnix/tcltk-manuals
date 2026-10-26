---
CommandName: nnsd
ManualSection: n
Version: 1.0.1
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::common(n)
 - nameserv::server(n)
Keywords:
 - application
 - name service
 - server
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nnsd - Name service facility, Commandline Server Application

# Synopsis

::: {.synopsis} :::
[nnsd]{.cmd} [-localonly flag]{.optarg} [-port port]{.optarg} 
:::

# Description

Please read *Name service facility, introduction* first.

The application described by this document, **nns**, is a simple command line server for the nano name service facility provided by the Tcllib packages **nameserv**, and **nameserv::server**. Beyond that the application's sources also serve as an example of how to use the server package **nameserv::server**.

This name service facility has nothing to do with the Internet's *Domain Name System*, otherwise known as *DNS*. If the reader is looking for a package dealing with that please see either of the packages **dns** and **resolv**, both found in Tcllib too.

## Use cases

**nnsd** was written with the following main use case in mind.

**\[1\]**
: Run a nano name service on some host.


## Command line

**nnsd** ?**-localonly** *flag*? ?**-port** *port*?
: The command configures a server per the specified options and starts it. The command will not exit on its own, as it keeps the name service database wholly in memory. The user has to kill it explicitly, either by sending a a signal, or through the job-control facilities of the shell in use. The options to configure the name service are explained in section **OPTIONS**.


## Options

This section describes all the options available to the user of the application

**-localonly** bool
: If this option is not specified it defaults to **true**, i.e. acceptance of only local connections. The server will accept remote connections, i.e. connections from other hosts, if and only if this option is configured to **false**.

**-port** number
: If this option is not specified it defaults to **38573**. It specifies the TCP port the server has to listen on for requests.


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
