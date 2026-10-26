---
CommandName: doctools::idx::structure
title: doctools::idx::structure
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - deserialization
 - docidx
 - doctools
 - serialization
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx::structure - Docidx serialization utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::doctools::idx::structure]{.cmd} [verify]{.lit} [serial]{.arg} [canonvar]{.optarg}
[::doctools::idx::structure]{.cmd} [verify-as-canonical]{.lit} [serial]{.arg}
[::doctools::idx::structure]{.cmd} [canonicalize]{.lit} [serial]{.arg}
[::doctools::idx::structure]{.cmd} [print]{.lit} [serial]{.arg}
[::doctools::idx::structure]{.cmd} [merge]{.lit} [seriala]{.arg} [serialb]{.arg}
:::

# Description

This package provides commands to work with the serializations of keyword indices as managed by the doctools system v2, and specified in section [Keyword index serialization format].

This is an internal package of doctools, for use by the higher level packages handling keyword indices and their conversion into and out of various other formats, like documents written using *docidx* markup.

# API

**::doctools::idx::structure** **verify** *serial* ?*canonvar*?
: This command verifies that the content of *serial* is a valid *regular* serialization of a keyword index and will throw an error if that is not the case. The result of the command is the empty string.

    If the argument *canonvar* is specified it is interpreted as the name of a variable in the calling context. This variable will be written to if and only if *serial* is a valid regular serialization. Its value will be a boolean, with **True** indicating that the serialization is not only valid, but also *canonical*. **False** will be written for a valid, but non-canonical serialization.

    For the specification of regular and canonical keyword index serializations see the section [Keyword index serialization format].

**::doctools::idx::structure** **verify-as-canonical** *serial*
: This command verifies that the content of *serial* is a valid *canonical* serialization of a keyword index and will throw an error if that is not the case. The result of the command is the empty string.

    For the specification of canonical keyword index serializations see the section [Keyword index serialization format].

**::doctools::idx::structure** **canonicalize** *serial*
: This command assumes that the content of *serial* is a valid *regular* serialization of a keyword index and will throw an error if that is not the case.

    It will then convert the input into the *canonical* serialization of the contained keyword index and return it as its result. If the input is already canonical it will be returned unchanged.

    For the specification of regular and canonical keyword index serializations see the section [Keyword index serialization format].

**::doctools::idx::structure** **print** *serial*
: This command assumes that the argument *serial* contains a valid regular serialization of a keyword index and returns a string containing that index in a human readable form.

    The exact format of this form is not specified and cannot be relied on for parsing or other machine-based activities.

    For the specification of regular keyword index serializations see the section [Keyword index serialization format].

**::doctools::idx::structure** **merge** *seriala* *serialb*
: This command accepts the regular serializations of two keyword indices and uses them to create their union.  The result of the command is the canonical serialization of this unified keyword index.

    Title and label of the resulting index are taken from the index contained in *serialb*. The set of keys, references and their connections is the union of the set of keys and references of the two inputs.

    For the specification of regular and canonical keyword index serializations see the section [Keyword index serialization format].


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

Documentation tools

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
