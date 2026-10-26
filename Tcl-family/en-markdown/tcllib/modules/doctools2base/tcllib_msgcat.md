---
CommandName: doctools::msgcat
title: doctools::msgcat
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - catalog package
 - docidx
 - doctoc
 - doctools
 - i18n
 - internationalization
 - l10n
 - localization
 - message catalog
 - message package
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::msgcat - Message catalog management for the various document parsers

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [msgcat]{.lit}
[package]{.cmd} [require]{.sub} [doctools::msgcat]{.lit} [0.2]{.optlit}
[::doctools::msgcat::init]{.cmd} [prefix]{.arg}
:::

# Description

The package **doctools::msgcat** is a support module handling the selection of message catalogs for the various document processing packages in the doctools system version 2. As such it is an internal package a regular user (developer) should not be in direct contact with.

If you are such please go the documentation of either

1. **doctools::doc**,

2. **doctools::toc**, or

3. **doctools::idx**


Within the system architecture this package resides under the various parser packages, and is shared by them. Underneath it, but not explicit dependencies, are the packages providing the message catalogs for the various languages.

# API

**::doctools::msgcat::init** *prefix*
: The command locates and loads the message catalogs for all the languages returned by **msgcat::mcpreferences**, provided that they could be found. It returns an integer number describing how many packages were found and loaded.

    The names of the packages the command will look for have the form "doctools::msgcat::*prefix*::**langcode**", with *prefix* the argument to the command, and the **langcode** supplied by the result of **msgcat::mcpreferences**.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
