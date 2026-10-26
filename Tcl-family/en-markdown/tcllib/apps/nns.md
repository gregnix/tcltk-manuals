---
CommandName: nns
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv(n)
 - nameserv::common(n)
Keywords:
 - application
 - client
 - name service
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nns - Name service facility, Commandline Client Application

# Synopsis

::: {.synopsis} :::
[nns]{.cmd} [bind]{.sub} [-host host]{.optarg} [-port port]{.optarg} [name]{.arg} [data]{.arg} 
[nns]{.cmd} [search]{.sub} [-host host]{.optarg} [-port port]{.optarg} [-continuous]{.optlit} [pattern]{.optarg} 
[nns]{.cmd} [ident]{.sub} [-host host]{.optarg} [-port port]{.optarg} 
[nns]{.cmd} [who]{.sub} 
:::

# Description

Please read *Name service facility, introduction* first.

The application described by this document, **nns**, is a simple command line client for the nano name service facility provided by the Tcllib packages **nameserv**, and **nameserv::server**. Beyond that the application's sources also serve as an example of how to use the client package **nameserv**. All abilities of a client are covered, from configuration to registration of names to searching.

This name service facility has nothing to do with the Internet's *Domain Name System*, otherwise known as *DNS*. If the reader is looking for a package dealing with that please see either of the packages **dns** and **resolv**, both found in Tcllib too.

## Use cases

**nns** was written with the following two main use cases in mind.

**\[1\]**
: Registration of a name/data pair in the name service.

**\[2\]**
: Searching the name service for entries matching a glob pattern. Beyond the above we also want to be able to identify the client, and get information about the name service.


## Command line

**nns** **bind** ?**-host** *host*? ?**-port** *port*? *name* *data*
: This form registers the *name*/*data* pair in the specified name service. In this form the command will *not* exit to keep the registration alive. The user has to kill it explicitly, either by sending a signal, or through the job-control facilities of the shell in use. It will especially survive the loss of the connection to the name service and reestablish the *name*/*data* pair when the connection is restored. The options to specify the name service will be explained later, in section **OPTIONS**.

**nns** **search** ?**-host** *host*? ?**-port** *port*? ?**-continuous**? ?*pattern*?
: This form searches the specified name service for entries matching the glob-*pattern* and prints them to stdout, with each entry on its own line. If no pattern is specified it defaults to **\***, matching everything. The options to specify the name service will be explained later, in section **OPTIONS**. If the option **-continuous** is specified the client will not exit after performing the search, but start to continuously monitor the service for changes to the set of matching entries, appropriately updating the display as changes arrive. In that form it will especially also survive the loss of the connection to the name service and reestablish the search when the connection is restored.

**nns** **ident** ?**-host** *host*? ?**-port** *port*?
: This form asks the specified name service for the version and features of the name service protocol it supports and prints the results to stdout. The options to specify the name service will be explained later, in section **OPTIONS**.

**nns** **who**
: This form prints name, version, and protocol version of the application to stdout.


## Options

This section describes all the options available to the user of the application

**-host** name|ipaddress
: If this option is not specified it defaults to **localhost**. It specifies the name or ip-address of the host the name service to talk to is running on.

**-port** number
: If this option is not specified it defaults to **38573**. It specifies the TCP port the name service to talk to is listening on for requests.


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
