---
CommandName: struct::set
title: struct::set
ManualSection: n
Version: 2.2.5
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - cardinality
 - difference
 - emptiness
 - exclusion
 - inclusion
 - intersection
 - membership
 - set
 - symmetric difference
 - union
Copyright:
 - Copyright (c) 2004-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

struct::set - Commands for manipulating sets

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit} [2.2.4]{.optlit}
[::struct::set]{.cmd} [empty]{.lit} [set]{.arg}
[::struct::set]{.cmd} [size]{.lit} [set]{.arg}
[::struct::set]{.cmd} [contains]{.lit} [set]{.arg} [value]{.arg}
[::struct::set]{.cmd} [union]{.lit} [set1...]{.optarg}
[::struct::set]{.cmd} [intersect]{.lit} [set1...]{.optarg}
[::struct::set]{.cmd} [difference]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [symdiff]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [intersect3]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [equal]{.lit} [set1]{.arg} [set2]{.arg}
[::struct::set]{.cmd} [include]{.lit} [setVar]{.arg} [value]{.arg}
[::struct::set]{.cmd} [exclude]{.lit} [setVar]{.arg} [value]{.arg}
[::struct::set]{.cmd} [add]{.lit} [setVar]{.arg} [set]{.arg}
[::struct::set]{.cmd} [subtract]{.lit} [setVar]{.arg} [set]{.arg}
[::struct::set]{.cmd} [subsetof]{.lit} [A]{.arg} [B]{.arg}
:::

# Description

The **::struct::set** namespace contains several useful commands for processing finite sets.

It exports only a single command, **struct::set**. All the functionality is available through this command’s subcommands.

A new empty set can be created using **::struct::set add** *setVar {}*.

*Note:* As of version 2.2 of this package a critcl based C implementation will be used where available, with Tcl 8.4 or later.

# Commands

In the following, *set*, *set1*, and *set2* are **set** values and *setVar* is a **set**’s variable name.

**::struct::set** **empty** *set*
: Returns **1** (true) if the *set* is empty; otherwise returns **0** (false).

**::struct::set** **size** *set*
: Returns the *set*’s cardinality, i.e., the number of elements in the *set*. This could be zero.

**::struct::set** **contains** *set* *value*
: Returns **1** (true) if the *set* contains the element *value*; otherwise returns **0** (false).

**::struct::set** **union** ?*set1*...?
: Returns a **set** consisting of the union of the given **set**s, i.e. *set1* ∪ *set2* ∪ …. The resulting **set** will contain every value in every given **set**, with no duplicates.

**::struct::set** **intersect** ?*set1*...?
: Returns a **set** consisting of the intersection of the given **set**s, i.e. *set1* ∩ *set2* ∩ …. The resulting **set** will contain every value that *every* one of the given **set**s has in common, with no duplicates.

**::struct::set** **difference** *set1* *set2*
: Returns a **set** consisting of the difference between *set1* and *set2*, i.e., *set1* - *set2*. The resulting **set** will contain every value that is in *set1* but that is *not* in *set2*.

**::struct::set** **symdiff** *set1* *set2*
: Returns a **set** consisting of the symmetric difference between *set1* and *set2*, i.e., *set1* Δ *set2*. The resulting **set** will contain every value that is in *set1* *or* is in *set2*, but *not* in both.

**::struct::set** **intersect3** *set1* *set2*
: Returns a combination of the methods **intersect** and **difference**.

    The return value is a three-element list containing "*set1* ∩ *set2*", "*set1* - *set2*", and "*set2* - *set1*", in this order. In other words, the intersection of *set1* and *set2*, and their differences.

**::struct::set** **equal** *set1* *set2*
: Returns **1** (true) if the two **set**s contain exactly the same values; otherwise returns **0** (false).

**::struct::set** **include** *setVar* *value*
: Adds element *value* to the **set** called *setVar*, creating *setVar* if it doesn’t exist. Harmlessly does nothing if *value* is already in **set** *setVar*. Returns nothing. This command can be used to create new **set**s.

**::struct::set** **exclude** *setVar* *value*
: Removes element *value* from the **set** called *setVar*. If *value* isn’t in *setVar*, the command harmlessly does nothing. Returns nothing.

**::struct::set** **add** *setVar* *set*
: Adds every element from the **set** value *set* to the **set** called *setVar*, excluding duplicates. The **set** *setVar* is created if it doesn’t exist. Returns nothing.

    Use **::struct::set add** *setVar {}* to create a new empty set. Use **::struct::set include** to add individual values.

**::struct::set** **subtract** *setVar* *set*
: Removes every element from the **set** value *set* from the **set** called *setVar*. Returns nothing. Use **::struct::set exclude** to remove individual values.

**::struct::set** **subsetof** *A* *B*
: Returns **1** (true) if *A* ⊆ *B*, i.e., if **set** *A* is a true subset of or equal to the **set** *B*; otherwise returns **0** (false).


# Examples

Creating and populating a new **set** from scratch. The **earth\_metals** **set** will be created on the first iteration of the loop and added to on subsequent iterations.

```
foreach element {Be Mg Ca Sr Ba Ra} {
    struct::set include earth_metals $element
}
```

Creating a **set** by unioning a couple of existing **set**s.

```
set metals [struct::set union $alkali_metals $earth_metals]
```

Querying a **set**’s properties.

```
if {[struct::set empty $metals]} {
    puts "empty"
} else {
    puts "[struct::set size $metals] elements"
}
```

# References

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *struct :: set* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures

# Copyright

```
Copyright (c) 2004-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
