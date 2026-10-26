---
CommandName: uri_urn
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Tcl Uniform Resource Identifier Management
Keywords:
 - rfc 2141
 - uri
 - url
 - urn
Copyright:
---

# Name

uri_urn - URI utilities, URN scheme

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uri::urn]{.lit} [1.0.4]{.optlit} 
[uri::urn::quote]{.cmd} [url]{.arg} 
[uri::urn::unquote]{.cmd} [url]{.arg} 
:::

# Description

This package provides two commands to quote and unquote the disallowed characters for url using the *urn* scheme, registers the scheme with the package **uri**, and provides internal helpers which will be automatically used by the commands **uri::split** and **uri::join** of package **uri** to handle urls using the *urn* scheme.

# Commands

**uri::urn::quote** *url*
: This command quotes the characters disallowed by the *urn* scheme (per RFC 2141 sec2.2) in the *url* and returns the modified url as its result.

**uri::urn::unquote** *url*
: This commands performs the reverse of **::uri::urn::quote**. It takes an *urn* url, removes the quoting from all disallowed characters, and returns the modified urls as its result.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *uri* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking
