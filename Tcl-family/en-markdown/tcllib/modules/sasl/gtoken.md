---
CommandName: SASL::XGoogleToken
title: SASL::XGoogleToken
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Simple Authentication and Security Layer (SASL)
Keywords:
 - SASL
 - XGoogleToken
 - authentication
Copyright:
 - Copyright (c) 2006, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

SASL::XGoogleToken - Implementation of SASL NTLM mechanism for Tcl

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [SASL::XGoogleToken]{.lit} [1.0.2]{.optlit}
:::

# Description

This package provides the XGoogleToken authentication mechanism for the Simple Authentication and Security Layer (SASL).

Please read the documentation for package **sasl** for details.

# TLS security considerations

This package uses the **TLS** package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Authors

Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *sasl* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2006, Pat Thoyts <patthoyts@users.sourceforge.net>
```
