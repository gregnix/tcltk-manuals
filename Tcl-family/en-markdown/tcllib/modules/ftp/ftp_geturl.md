---
CommandName: ftp::geturl
ManualSection: n
Version: 0.2.3
TclPart: tcllib
TclDescription: ftp client
Links:
 - ftpd
 - mime
 - pop3
 - smtp
Keywords:
 - ftp
 - internet
 - net
 - rfc 959
Copyright:
---

# Name

ftp::geturl - Uri handler for ftp urls

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [ftp::geturl]{.lit} [0.2.3]{.optlit} 
[::ftp::geturl]{.cmd} [url]{.arg} 
:::

# Description

This package provides a command which wraps around the client side of the *ftp* protocol provided by package **ftp** to allow the retrieval of urls using the *ftp* schema.

# Api

**::ftp::geturl** *url*
: This command can be used by the generic command **::uri::geturl** (See package **uri**) to retrieve the contents of ftp urls. Internally it uses the commands of the package **ftp** to fulfill the request. The contents of a *ftp* url are defined as follows:


*file*
: The contents of the specified file itself.

*directory*
: A listing of the contents of the directory in key value notation where the file name is the key and its attributes the associated value.

*link*
: The attributes of the link, including the path it refers to.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *ftp* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking
