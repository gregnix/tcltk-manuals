---
CommandName: SASL::SCRAM
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Simple Authentication and Security Layer (SASL)
Keywords:
 - SASL
 - SCRAM
 - authentication
Copyright:
 - Copyright (c) 2013 Sergei Golovan <sgolovan@nes.ru>
---

# Name

SASL::SCRAM - Implementation of SASL SCRAM mechanism for Tcl

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [SASL::SCRAM]{.lit} [0.2]{.optlit} 
:::

# Description

This package provides the SCRAM authentication mechanism for the Simple Authentication and Security Layer (SASL).

Please read the documentation for package **sasl** for details.

# References

**\[1\]**
: Newman, C. et al., "Salted Challenge Response Authentication Mechanism (SCRAM) SASL and GSS-API Mechanisms", RFC 5802, July 2010, (*http://www.ieft.org/rfc/rfc5802.txt*)


# Authors

Sergei Golovan

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *sasl* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2013 Sergei Golovan <sgolovan@nes.ru>
```
