---
CommandName: doctools::toc::structure
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - deserialization
 - doctoc
 - doctools
 - serialization
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::toc::structure - Doctoc serialization utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::toc::structure]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[::doctools::toc::structure]{.cmd} [verify]{.sub} [serial]{.arg} [canonvar]{.optarg} 
[::doctools::toc::structure]{.cmd} [verify-as-canonical]{.sub} [serial]{.arg} 
[::doctools::toc::structure]{.cmd} [canonicalize]{.sub} [serial]{.arg} 
[::doctools::toc::structure]{.cmd} [print]{.sub} [serial]{.arg} 
[::doctools::toc::structure]{.cmd} [merge]{.sub} [seriala]{.arg} [serialb]{.arg} 
:::

# Description

This package provides commands to work with the serializations of tables of contents as managed by the doctools system v2, and specified in section **ToC serialization format**.

This is an internal package of doctools, for use by the higher level packages handling tables of contents and their conversion into and out of various other formats, like documents written using *doctoc* markup.

# Api

**::doctools::toc::structure** **verify** *serial* ?*canonvar*?
: This command verifies that the content of *serial* is a valid *regular* serialization of a table of contents and will throw an error if that is not the case. The result of the command is the empty string. If the argument *canonvar* is specified it is interpreted as the name of a variable in the calling context. This variable will be written to if and only if *serial* is a valid regular serialization. Its value will be a boolean, with **True** indicating that the serialization is not only valid, but also *canonical*. **False** will be written for a valid, but non-canonical serialization. For the specification of regular and canonical serializations see the section **ToC serialization format**.

**::doctools::toc::structure** **verify-as-canonical** *serial*
: This command verifies that the content of *serial* is a valid *canonical* serialization of a table of contents and will throw an error if that is not the case. The result of the command is the empty string. For the specification of canonical serializations see the section **ToC serialization format**.

**::doctools::toc::structure** **canonicalize** *serial*
: This command assumes that the content of *serial* is a valid *regular* serialization of a table of contents and will throw an error if that is not the case. It will then convert the input into the *canonical* serialization of the contained table of contents and return it as its result. If the input is already canonical it will be returned unchanged. For the specification of regular and canonical serializations see the section **ToC serialization format**.

**::doctools::toc::structure** **print** *serial*
: This command assumes that the argument *serial* contains a valid regular serialization of a table of contents and returns a string containing that table in a human readable form. The exact format of this form is not specified and cannot be relied on for parsing or other machine-based activities. For the specification of regular serializations see the section **ToC serialization format**.

**::doctools::toc::structure** **merge** *seriala* *serialb*
: This command accepts the regular serializations of two tables of contents and uses them to create their union.  The result of the command is the canonical serialization of this unified table of contents. Title and label of the resulting table are taken from the table contained in *serialb*. The whole table and its divisions are merged recursively in the same manner:


**\[1\]**
: All reference elements which occur in both divisions (identified by their label) are unified with document id's and descriptions taken from the second table.

**\[2\]**
: All division elements which occur in both divisions (identified by their label) are unified with the optional document id taken from the second table, if any, or from the first if none is in the second. The elements in the division are merged recursively using the same algorithm as described in this list.

**\[3\]**
: Type conflicts between elements, i.e. finding two elements with the same label but different types result in a merge error.

**\[4\]**
: All elements found in the second division but not in the first are added to the end of the list of elements in the merge result.


For the specification of regular and canonical serializations see the section **ToC serialization format**.

# Toc serialization format

Here we specify the format used by the doctools v2 packages to serialize tables of contents as immutable values for transport, comparison, etc.

We distinguish between *regular* and *canonical* serializations. While a table of contents may have more than one regular serialization only exactly one of them will be *canonical*.

**regular serialization**
: 


**\[1\]**
: The serialization of any table of contents is a nested Tcl dictionary.

**\[2\]**
: This dictionary holds a single key, **doctools::toc**, and its value. This value holds the contents of the table of contents.

**\[3\]**
: The contents of the table of contents are a Tcl dictionary holding the title of the table of contents, a label, and its elements. The relevant keys and their values are


**title**
: The value is a string containing the title of the table of contents.

**label**
: The value is a string containing a label for the table of contents.

**items**
: The value is a Tcl list holding the elements of the table, in the order they are to be shown. Each element is a Tcl list holding the type of the item, and its description, in this order. An alternative description would be that it is a Tcl dictionary holding a single key, the item type, mapped to the item description. The two legal item types and their descriptions are


**reference**
: This item describes a single entry in the table of contents, referencing a single document. To this end its value is a Tcl dictionary containing an id for the referenced document, a label, and a longer textual description which can be associated with the entry. The relevant keys and their values are


**id**
: The value is a string containing the id of the document associated with the entry.

**label**
: The value is a string containing a label for this entry. This string also identifies the entry, and no two entries (references and divisions) in the containing list are allowed to have the same label.

**desc**
: The value is a string containing a longer description for this entry.


**division**
: This item describes a group of entries in the table of contents, inducing a hierarchy of entries. To this end its value is a Tcl dictionary containing a label for the group, an optional id to a document for the whole group, and the list of entries in the group. The relevant keys and their values are


**id**
: The value is a string containing the id of the document associated with the whole group. This key is optional.

**label**
: The value is a string containing a label for the group. This string also identifies the entry, and no two entries (references and divisions) in the containing list are allowed to have the same label.

**items**
: The value is a Tcl list holding the elements of the group, in the order they are to be shown. This list has the same structure as the value for the keyword **items** used to describe the whole table of contents, see above. This closes the recusrive definition of the structure, with divisions holding the same type of elements as the whole table of contents, including other divisions.


**canonical serialization**
: The canonical serialization of a table of contents has the format as specified in the previous item, and then additionally satisfies the constraints below, which make it unique among all the possible serializations of this table of contents.


**\[1\]**
: The keys found in all the nested Tcl dictionaries are sorted in ascending dictionary order, as generated by Tcl's builtin command **lsort -increasing -dict**.


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
