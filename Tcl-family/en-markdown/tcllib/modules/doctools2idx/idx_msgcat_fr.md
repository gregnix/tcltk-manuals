---
CommandName: doctools::msgcat::idx::fr
title: doctools::msgcat::idx::fr
ManualSection: n
Version: 0.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - FR
 - catalog package
 - docidx
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

doctools::msgcat::idx::fr - Message catalog for the docidx parser (FR)

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [msgcat]{.lit}
[package]{.cmd} [require]{.sub} [doctools::msgcat::idx::fr]{.lit} [0.1]{.optlit}
:::

# Description

The package **doctools::msgcat::idx::fr** is a support module providing the FR (french) language message catalog for the docidx parser in the doctools system version 2. As such it is an internal package a regular user (developer) should not be in direct contact with.

If you are such please go the documentation of either

1. **doctools::doc**,

2. **doctools::toc**, or

3. **doctools::idx**


Within the system architecture this package resides under the package **doctools::msgcat** providing the general message catalog management within the system. *Note* that there is *no* explicit dependency between the manager and catalog packages. The catalog is a plugin which is selected and loaded dynamically.

# API

This package has no exported API.

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
