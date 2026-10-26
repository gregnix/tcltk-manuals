---
CommandName: doctools::toc::export::json
title: doctools::toc::export::json
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - JSON
 - doctools
 - export
 - serialization
 - table of contents
 - toc
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::toc::export::json - JSON export plugin

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [doctools::toc::export::json]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [textutil::adjust]{.lit}
[export]{.cmd} [serial]{.arg} [configuration]{.arg}
:::

# Description

This package implements the doctools table of contents export plugin for the generation of JSON markup.

This is an internal package of doctools, for use by the higher level management packages handling tables of contents, especially **doctools::toc::export**, the export manager.

Using it from a regular interpreter is possible, however only with contortions, and is not recommended. The proper way to use this functionality is through the package **doctools::toc::export** and the export manager objects it provides.

# API

The API provided by this package satisfies the specification of the doctoc export plugin API version 2.

**export** *serial* *configuration*
: This command takes the canonical serialization of a table of contents, as specified in section [Toc serialization format], and contained in *serial*, the *configuration*, a dictionary, and generates JSON markup encoding the table. The created string is then returned as the result of the command.


# JSON notation of tables of contents

The JSON format used for tables of contents is a direct translation of the [Toc serialization format], mapping Tcl dictionaries as JSON objects and Tcl lists as JSON arrays. For example, the Tcl serialization

```
doctools::toc {
    items {
        {reference {
	    desc {DocTools - Tables of Contents}
	     id introduction.man
	     label doctools::toc::introduction
	}}
	{division {
	     id processing.man
	     items {
	         {reference {
		     desc {doctoc serialization utilities}
		     id structure.man
		     label doctools::toc::structure
		 }}
		 {reference {
		     desc {Parsing text in doctoc format}
		     id parse.man
		     label doctools::toc::parse
		 }}
	     }
             label Processing
        }}
    }
    label {Table of Contents}
    title TOC
}
```

is equivalent to the JSON string

```
{
    "doctools::toc" : {
        "items" : [{
            "reference" : {
                "desc"  : "DocTools - Tables of Contents",
                "id"    : "introduction.man",
                "label" : "doctools::toc::introduction"
            }
        },{
            "division" : {
                "id"    : "processing.man",
                "items" : [{
                    "reference" : {
                        "desc"  : "doctoc serialization utilities",
                        "id"    : "structure.man",
                        "label" : "doctools::toc::structure"
                    }
                },{
                    "reference" : {
                        "desc"  : "Parsing text in doctoc format",
                        "id"    : "parse.man",
                        "label" : "doctools::toc::parse"
                    }
                }],
                "label" : "Processing"
            }
        }],
        "label" : "Table of Contents",
        "title" : "TOC"
    }
}
```

# Configuration

The JSON export plugin recognizes the following configuration variables and changes its behaviour as they specify.

boolean *indented*
: If this flag is set the plugin will break the generated JSON code across lines and indent it according to its inner structure, with each key of a dictionary on a separate line.

    If this flag is not set (the default), the whole JSON object will be written on a single line, with minimum spacing between all elements.

boolean *aligned*
: If this flag is set the generator ensures that the values for the keys in a dictionary are vertically aligned with each other, for a nice table effect. To make this work this also implies that **indented** is set.

    If this flag is not set (the default), the output is formatted as per the value of **indented**, without trying to align the values for dictionary keys.


*Note* that this plugin ignores the standard configuration variables **user**, **format**, **file**, and **map** and their values.

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
