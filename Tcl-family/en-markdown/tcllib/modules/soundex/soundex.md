---
CommandName: soundex
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Soundex
Keywords:
 - knuth
 - soundex
 - text comparison
 - text likeness
Copyright:
 - "Copyright (c) ????, Algorithm: Donald E. Knuth"
 - "Copyright (c) 2003, Documentation: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
 - "Copyright (c) 1998, Tcl port: Evan Rempel <erempel@uvic.ca>"
---

# Name

soundex - Soundex

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [soundex]{.lit} [1.1]{.optlit} 
[::soundex::knuth]{.cmd} [string]{.arg} 
:::

# Description

This package provides soundex algorithms which allow the comparison of words based on their phonetic likeness.

Currently only an algorithm by Knuth is provided, which is tuned to english names and words.

**::soundex::knuth** *string*
: Computes the soundex code of the input *string* using Knuth's algorithm and returns it as the result of the command.


# Examples

```
    % ::soundex::knuth Knuth
    K530
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *soundex* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) ????, Algorithm: Donald E. Knuth
Copyright (c) 2003, Documentation: Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 1998, Tcl port: Evan Rempel <erempel@uvic.ca>
```
