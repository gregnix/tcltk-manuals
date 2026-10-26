---
CommandName: nameserv::auto
title: nameserv::auto
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv(n)
Keywords:
 - automatic
 - client
 - name service
 - reconnect
 - restore
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nameserv::auto - Name service facility, Client Extension

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [nameserv::auto]{.lit} [0.4]{.optlit}
[package]{.cmd} [require]{.sub} [nameserv]{.lit}
:::

# Description

Please read the document *Name service facility, introduction* first.

This package provides the *exact* same API as is provided by package **nameserv**, i.e. the regular name service client. It differs from the former by taking measures to ensure that longer-lived data, i.e. bound names, continuous and unfullfilled async searches, survive the loss of the connection to the name server as much as is possible.

This means that the bound names and continuous and unfullfilled async searches are remembered client-side and automatically re-entered into the server when the connection comes back after its loss. For bound names there is one important limitation to such restoration: It is possible that a name of this client was bound by a different client while the connection was gone. Such names are fully lost, and the best the package can and will do is to inform the user of this.

# API

The user-visible API is mainly identical to the API of **nameserv** and is therefore not described here. Please read the documentation of **nameserv**.

The differences are explained below, in the sections [Options] and [Events].

# Options

This package supports all the options of package **nameserv**, plus one more. The additional option allows the user to specify the time interval between attempts to restore a lost connection.

**-delay** *milliseconds*
: The value of this option is an integer value > 0 which specifies the interval to wait between attempts to restore a lost connection, in milliseconds. The default value is **1000**, i.e. one second.


# Events

This package generates all of the events of package **nameserv**, plus two more. Both events are generated for the tag *nameserv*.

*lost-name*
: This event is generated when a bound name is truly lost, i.e. could not be restored after the temporary loss of the connection to the name server. It indicates that a different client took ownership of the name while this client was out of contact.

    The detail information of the event will be a Tcl dictionary containing two keys, **name**, and **data**. Their values hold all the information about the lost name.

*re-connection*
: This event is generated when the connection to the server is restored. The remembered data has been restored when the event is posted.

    The event has no detail information.


# Design

The package is implemented on top of the regular nameservice client, i.e. package **nameserv**. It detects the loss of the connection by listening for *lost-connection* events, on the tag *nameserv*.

It reacts to such events by starting a periodic timer and trying to reconnect to the server whenver this timer triggers. On success the timer is canceled, a *re-connection* event generated, and the package proceeds to re-enter the remembered bound names and continuous searches.

Another loss of the connection, be it during or after re-entering the remembered information simply restarts the timer and subsequent reconnection attempts.

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
