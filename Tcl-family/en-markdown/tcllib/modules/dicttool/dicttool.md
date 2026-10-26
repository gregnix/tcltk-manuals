---
CommandName: dicttool
title: dicttool
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Extensions to the standard
Keywords:
 - dict
Copyright:
 - Copyright (c) 2017 Sean Woods <yoda@etoyoc.com>
---

# Name

dicttool - Dictionary Tools

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [dicttool]{.lit} [1.2]{.optlit}
[ladd]{.cmd} [dictVar]{.arg} [key value]{.optdot}
[ldelete]{.cmd} [dictVar]{.arg} [key value]{.optdot}
[dict]{.cmd} [getnull]{.sub} [key]{.arg}
[dict]{.cmd} [print]{.sub} [aDict]{.arg}
[dict]{.cmd} [is\_dict]{.sub} [value]{.arg}
[dict]{.cmd} [rmerge]{.sub} [dict1]{.arg} [dict2]{.arg} [dict3]{.optdot}
:::

# Description

This package enhances the built-in [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html) command with several new commands. In addition, the package also defines several convenient list commands. (Each command only adds itself if a command of the same name doesn’t already exist, in case any of these are added to the core.)

# API

**ladd** *dictVar* ?*key value ...*?
: This command adds every pair of *key value* elements to *dictVar*, but only if that element is not already present (whether as a key or a value). This command *must* be given pairs of *key value* elements to preserve *dictVar* as a **dict**.

**ldelete** *dictVar* ?*key value ...*?
: This command deletes every pair of *key value* elements from *dictVar*. Harmlessly does nothing if the pair is not already in *dictVar*. This command *must* be given pairs of *key value* elements to preserve *dictVar* as a **dict**.

    Use the built-in [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html) command’s **dict remove** subcommand to remove elements by key alone.

**dict getnull** *key*
: Operates like **dict get**, however if the key *key* does not exist, it returns an empty list instead of throwing an error.

    An alternative to this command is the built-in [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html) command’s **dict getwithdefault** subcommand *or its alias* **dict getdef**. Using **dict getdef** with a default of an empty list, *{}*, is equivalent to using **dict getnull**.

**dict print** *aDict*
: Returns a “pretty printed” string representation of **dict** *aDict*, with each nested branch on a newline, and indented with two spaces for every level.

**dict is\_dict** *value*
: Returns **1** (true) if *value* can be interpreted as a **dict**; otherwise **0** (false).

    This command does *not* force an existing **dict** representation to change into another internal representation.

**dict rmerge** *dict1* *dict2* ?*dict3 ...*?
: Returns a **dict** which is the result of a recursive merge of all of the **dict** arguments. Unlike the built-in [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html) command’s **dict merge** subcommand, this command descends into all of the **dict**’s levels. Note that **dict** keys which end in a : indicate a leaf, which will be interpreted as a literal value, and not descended into further.

    ```
    set items [dict rmerge {
      option {color {default: green}}
    } {
      option {fruit {default: mango}}
    } {
      option {color {default: blue} fruit {widget: select values: {mango apple cherry grape}}}
    }]
    puts [dict print $items]
    =>
    option {
      color {
        default: blue
      }
      fruit {
        default: mango
        widget: select
        values: {mango apple cherry grape}
      }
    }
    ```

    If the built-in [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html) command’s **dict merge** subcommand had been used above, the *fruit* item’s *default* key-value entry would have been lost.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *dict* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Utilities

# Copyright

```
Copyright (c) 2017 Sean Woods <yoda@etoyoc.com>
```
