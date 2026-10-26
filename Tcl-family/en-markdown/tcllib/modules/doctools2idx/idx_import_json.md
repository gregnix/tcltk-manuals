---
CommandName: doctools::idx::import::json
title: doctools::idx::import::json
ManualSection: n
Version: 0.2.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - JSON
 - deserialization
 - doctools
 - import
 - index
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx::import::json - JSON import plugin

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [doctools::idx::import::json]{.lit} [0.2.1]{.optlit}
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit}
[package]{.cmd} [require]{.sub} [json]{.lit}
[import]{.cmd} [string]{.arg} [configuration]{.arg}
:::

# Description

This package implements the doctools keyword index import plugin for the parsing of JSON markup.

This is an internal package of doctools, for use by the higher level management packages handling keyword indices, especially **doctools::idx::import**, the import manager.

Using it from a regular interpreter is possible, however only with contortions, and is not recommended. The proper way to use this functionality is through the package **doctools::idx::import** and the import manager objects it provides.

# API

The API provided by this package satisfies the specification of the docidx import plugin API version 2.

**import** *string* *configuration*
: This command takes the *string* and parses it as JSON markup encoding a keyword index, in the context of the specified *configuration* (a dictionary). The result of the command is the canonical serialization of that keyword index, in the form specified in section [Keyword index serialization format].


# JSON notation of keyword indices

The JSON format used for keyword indices is a direct translation of the [Keyword index serialization format], mapping Tcl dictionaries as JSON objects and Tcl lists as JSON arrays. For example, the Tcl serialization

```
doctools::idx {
	label {Keyword Index}
	keywords {
		changelog  {changelog.man cvs.man}
		conversion {doctools.man docidx.man doctoc.man apps/dtplite.man mpexpand.man}
		cvs        cvs.man
	}
	references {
		apps/dtplite.man {manpage dtplite}
		changelog.man    {manpage doctools::changelog}
		cvs.man          {manpage doctools::cvs}
		docidx.man       {manpage doctools::idx}
		doctoc.man       {manpage doctools::toc}
		doctools.man     {manpage doctools}
		mpexpand.man     {manpage mpexpand}
	}
	title {}
}
```

is equivalent to the JSON string

```
{
    "doctools::idx" : {
        "label"      : "Keyword Index",
        "keywords"   : {
            "changelog"  : ["changelog.man","cvs.man"],
            "conversion" : ["doctools.man","docidx.man","doctoc.man","apps\/dtplite.man","mpexpand.man"],
            "cvs"        : ["cvs.man"],
        },
        "references" : {
            "apps\/dtplite.man" : ["manpage","dtplite"],
            "changelog.man"     : ["manpage","doctools::changelog"],
            "cvs.man"           : ["manpage","doctools::cvs"],
            "docidx.man"        : ["manpage","doctools::idx"],
            "doctoc.man"        : ["manpage","doctools::toc"],
            "doctools.man"      : ["manpage","doctools"],
            "mpexpand.man"      : ["manpage","mpexpand"]
        },
        "title"      : ""
    }
}
```

# Keyword index serialization format

Here we specify the format used by the doctools v2 packages to serialize keyword indices as immutable values for transport, comparison, etc.

We distinguish between *regular* and *canonical* serializations. While a keyword index may have more than one regular serialization only exactly one of them will be *canonical*.

regular serialization
: 1. An index serialization is a nested Tcl dictionary.

    2. This dictionary holds a single key, **doctools::idx**, and its value. This value holds the contents of the index.

    3. The contents of the index are a Tcl dictionary holding the title of the index, a label, and the keywords and references. The relevant keys and their values are

        **title**
        : The value is a string containing the title of the index.

        **label**
        : The value is a string containing a label for the index.

        **keywords**
        : The value is a Tcl dictionary, using the keywords known to the index as keys. The associated values are lists containing the identifiers of the references associated with that particular keyword.

            Any reference identifier used in these lists has to exist as a key in the **references** dictionary, see the next item for its definition.

        **references**
        : The value is a Tcl dictionary, using the identifiers for the references known to the index as keys. The associated values are 2-element lists containing the type and label of the reference, in this order.

            Any key here has to be associated with at least one keyword, i.e. occur in at least one of the reference lists which are the values in the **keywords** dictionary, see previous item for its definition.


    4. The *type* of a reference can be one of two values,

        **manpage**
        : The identifier of the reference is interpreted as symbolic file name, referring to one of the documents the index was made for.

        **url**
        : The identifier of the reference is interpreted as an url, referring to some external location, like a website, etc.



canonical serialization
: The canonical serialization of a keyword index has the format as specified in the previous item, and then additionally satisfies the constraints below, which make it unique among all the possible serializations of the keyword index.

    1. The keys found in all the nested Tcl dictionaries are sorted in ascending dictionary order, as generated by Tcl's builtin command **lsort -increasing -dict**.

    2. The references listed for each keyword of the index, if any, are listed in ascending dictionary order of their *labels*, as generated by Tcl's builtin command **lsort -increasing -dict**.



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
