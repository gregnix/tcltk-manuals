---
CommandName: doctools::toc::import::doctoc
title: doctools::toc::import::doctoc
ManualSection: n
Version: 0.2.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - deserialization
 - doctoc
 - doctools
 - import
 - table of contents
 - toc
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::toc::import::doctoc - doctoc import plugin

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [doctools::toc::import::doctoc]{.lit} [0.2.1]{.optlit}
[package]{.cmd} [require]{.sub} [doctools::toc::parse]{.lit}
[package]{.cmd} [require]{.sub} [doctools::toc::structure]{.lit}
[package]{.cmd} [require]{.sub} [doctools::msgcat]{.lit}
[package]{.cmd} [require]{.sub} [doctools::tcl::parse]{.lit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[package]{.cmd} [require]{.sub} [struct::stack]{.lit}
[package]{.cmd} [require]{.sub} [struct::tree]{.lit}
[package]{.cmd} [require]{.sub} [treeql]{.lit}
[import]{.cmd} [string]{.arg} [configuration]{.arg}
:::

# Description

This package implements the doctools table of contents import plugin for the parsing of doctoc markup.

This is an internal package of doctools, for use by the higher level management packages handling tables of contents, especially **doctools::toc::import**, the import manager.

Using it from a regular interpreter is possible, however only with contortions, and is not recommended. The proper way to use this functionality is through the package **doctools::toc::import** and the import manager objects it provides.

# API

The API provided by this package satisfies the specification of the doctoc import plugin API version 2.

**import** *string* *configuration*
: This command takes the *string* and parses it as doctoc markup encoding a table of contents, in the context of the specified *configuration* (a dictionary). The result of the command is the canonical serialization of that table of contents, in the form specified in section [Toc serialization format].


# \[doctoc\] notation of tables of contents

The doctoc format for tables of contents, also called the *doctoc markup language*, is too large to be covered in single section. The interested reader should start with the document

1. *doctoc language introduction*


and then proceed from there to the formal specifications, i.e. the documents

1. *doctoc language syntax* and

2. *doctoc language command reference*.


to get a thorough understanding of the language.

# Toc serialization format

Here we specify the format used by the doctools v2 packages to serialize tables of contents as immutable values for transport, comparison, etc.

We distinguish between *regular* and *canonical* serializations. While a table of contents may have more than one regular serialization only exactly one of them will be *canonical*.

regular serialization
: 1. The serialization of any table of contents is a nested Tcl dictionary.

    2. This dictionary holds a single key, **doctools::toc**, and its value. This value holds the contents of the table of contents.

    3. The contents of the table of contents are a Tcl dictionary holding the title of the table of contents, a label, and its elements. The relevant keys and their values are

        **title**
        : The value is a string containing the title of the table of contents.

        **label**
        : The value is a string containing a label for the table of contents.

        **items**
        : The value is a Tcl list holding the elements of the table, in the order they are to be shown.

            Each element is a Tcl list holding the type of the item, and its description, in this order. An alternative description would be that it is a Tcl dictionary holding a single key, the item type, mapped to the item description.

            The two legal item types and their descriptions are

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





canonical serialization
: The canonical serialization of a table of contents has the format as specified in the previous item, and then additionally satisfies the constraints below, which make it unique among all the possible serializations of this table of contents.

    1. The keys found in all the nested Tcl dictionaries are sorted in ascending dictionary order, as generated by Tcl's builtin command **lsort -increasing -dict**.



# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text formatter plugin

# Copyright

```
Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
