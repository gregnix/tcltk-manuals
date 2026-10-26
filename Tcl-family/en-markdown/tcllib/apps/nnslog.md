---
CommandName: nnslog
ManualSection: n
Version: 1.0
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
 - Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nnslog - Name service facility, Commandline Logging Client Application

# Synopsis

::: {.synopsis} :::
[nnslog]{.cmd} [-host host]{.optarg} [-port port]{.optarg} 
:::

# Description

Please read *Name service facility, introduction* first.

The application described by this document, **nnslog**, is a simple command line client for the nano name service facility provided by the Tcllib packages **nameserv**, and **nameserv::server**.

It essentially implements "**nns** search -continuous \*", but uses a different output formatting. Instead of continuously showing the current contents of the server in the terminal it simply logs all received add/remove events to **stdout**.

This name service facility has nothing to do with the Internet's *Domain Name System*, otherwise known as *DNS*. If the reader is looking for a package dealing with that please see either of the packages **dns** and **resolv**, both found in Tcllib too.

## Use cases

**nnslog** was written with the following main use case in mind.

**\[1\]**
: Monitoring the name service for all changes and logging them in a text terminal.


## Command line

**nnslog** ?**-host** *host*? ?**-port** *port*?
: The command connects to the specified name service, sets up a search for all changes and then prints all received events to stdout, with each events on its own line. The command will not exit until it is explicitly terminated by the user. It will especially survive the loss of the connection to the name service and reestablish the search and log when the connection is restored. The options to specify the name service will be explained later, in section **OPTIONS**.


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
Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
