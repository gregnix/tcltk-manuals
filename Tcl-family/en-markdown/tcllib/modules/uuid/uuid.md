---
CommandName: uuid
title: uuid
ManualSection: n
Version: 1.0.9
TclPart: tcllib
TclDescription: uuid
Keywords:
 - GUID
 - UUID
Copyright:
 - Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

uuid - UUID generation and comparison

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [uuid]{.lit} [1.0.9]{.optlit}
[::uuid::uuid]{.cmd} [generate]{.sub}
[::uuid::uuid]{.cmd} [equal]{.sub} [id1]{.arg} [id2]{.arg}
:::

# Description

This package provides a generator of universally unique identifiers (UUID) also known as globally unique identifiers (GUID). This implementation follows the draft specification from (1) although this is actually an expired draft document.

# Commands

**::uuid::uuid generate**
: Creates a type 4 uuid by MD5 hashing a number of bits of variant data including the time and hostname. Returns the string representation of the new uuid.

**::uuid::uuid equal** *id1* *id2*
: Compares two uuids and returns true if both arguments are the same uuid.


# Examples

```
% uuid::uuid generate
b12dc22c-5c36-41d2-57da-e29d0ef5839c
```

# References

1. Paul J. Leach, "UUIDs and GUIDs", February 1998. (<http://www.opengroup.org/dce/info/draft-leach-uuids-guids-01.txt>)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *uuid* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
```
