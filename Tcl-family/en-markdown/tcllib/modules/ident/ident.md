---
CommandName: ident
ManualSection: n
Version: 0.44
TclPart: tcllib
TclDescription: Identification protocol client
Keywords:
 - ident
 - identification
 - rfc 1413
Copyright:
 - Copyright (c) 2004 Reinhard Max <max@tclers.tk>
---

# Name

ident - Ident protocol client

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [ident]{.lit} [0.44]{.optlit} 
[::ident::query]{.cmd} [socket]{.arg} [callback]{.optarg} 
:::

# Description

The **ident** package provides a client implementation of the ident protocol as defined in RFC 1413 (*http://www.rfc-editor.org/rfc/rfc1413.txt*).

**::ident::query** *socket* ?*callback*?
: This command queries the ident daemon on the remote side of the given socket, and returns the result of the query as a dictionary. Interpreting the dictionary as list the first key will always be **resp-type**, and can have one of the values **USERID**, **ERROR**, and **FATAL**.  These *response types* have the following meanings:


**USERID**
: This indicates a successful response. Two more keys and associated values are returned, **opsys**, and **user-id**.

**ERROR**
: This means the ident server has returned an error.  A second key named **error** is present whose value contains the **error-type** field from the server response.

**FATAL**
: Fatal errors happen when no ident server is listening on the remote side, or when the ident server gives a response that does not conform to the RFC. A detailed error message is returned under the **error** key.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *ident* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2004 Reinhard Max <max@tclers.tk>
```
