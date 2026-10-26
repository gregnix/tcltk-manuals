---
CommandName: doctools::idx::parse
title: doctools::idx::parse
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - docidx
 - doctools
 - lexer
 - parser
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx::parse - Parsing text in docidx format

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx::parse]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit}
[package]{.cmd} [require]{.sub} [doctools::msgcat]{.lit}
[package]{.cmd} [require]{.sub} [doctools::tcl::parse]{.lit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit}
[package]{.cmd} [require]{.sub} [struct::stack]{.lit}
[::doctools::idx::parse]{.cmd} [text]{.lit} [text]{.arg}
[::doctools::idx::parse]{.cmd} [file]{.lit} [path]{.arg}
[::doctools::idx::parse]{.cmd} [includes]{.lit}
[::doctools::idx::parse]{.cmd} [include]{.lit} [add]{.lit} [path]{.arg}
[::doctools::idx::parse]{.cmd} [include]{.lit} [remove]{.lit} [path]{.arg}
[::doctools::idx::parse]{.cmd} [include]{.lit} [clear]{.lit}
[::doctools::idx::parse]{.cmd} [vars]{.lit}
[::doctools::idx::parse]{.cmd} [var]{.lit} [set]{.lit} [name]{.arg} [value]{.arg}
[::doctools::idx::parse]{.cmd} [var]{.lit} [unset]{.lit} [name]{.arg}
[::doctools::idx::parse]{.cmd} [var]{.lit} [clear]{.lit} [pattern]{.optarg}
:::

# Description

This package provides commands to parse text written in the *docidx* markup language and convert it into the canonical serialization of the keyword index encoded in the text. See the section [Keyword index serialization format] for specification of their format.

This is an internal package of doctools, for use by the higher level packages handling *docidx* documents.

# API

**::doctools::idx::parse** **text** *text*
: The command takes the string contained in *text* and parses it under the assumption that it contains a document written using the *docidx* markup language. An error is thrown if this assumption is found to be false. The format of these errors is described in section [Parse errors].

    When successful the command returns the canonical serialization of the keyword index which was encoded in the text. See the section [Keyword index serialization format] for specification of that format.

**::doctools::idx::parse** **file** *path*
: The same as **text**, except that the text to parse is read from the file specified by *path*.

**::doctools::idx::parse** **includes**
: This method returns the current list of search paths used when looking for include files.

**::doctools::idx::parse** **include add** *path*
: This method adds the *path* to the list of paths searched when looking for an include file. The call is ignored if the path is already in the list of paths. The method returns the empty string as its result.

**::doctools::idx::parse** **include remove** *path*
: This method removes the *path* from the list of paths searched when looking for an include file. The call is ignored if the path is not contained in the list of paths. The method returns the empty string as its result.

**::doctools::idx::parse** **include clear**
: This method clears the list of search paths for include files.

**::doctools::idx::parse** **vars**
: This method returns a dictionary containing the current set of predefined variables known to the **vset** markup command during processing.

**::doctools::idx::parse** **var set** *name* *value*
: This method adds the variable *name* to the set of predefined variables known to the **vset** markup command during processing, and gives it the specified *value*. The method returns the empty string as its result.

**::doctools::idx::parse** **var unset** *name*
: This method removes the variable *name* from the set of predefined variables known to the **vset** markup command during processing. The method returns the empty string as its result.

**::doctools::idx::parse** **var clear** ?*pattern*?
: This method removes all variables matching the *pattern* from the set of predefined variables known to the **vset** markup command during processing. The method returns the empty string as its result.

    The pattern matching is done with **string match**, and the default pattern used when none is specified, is **\***.


# Parse errors

The format of the parse error messages thrown when encountering violations of the *docidx* markup syntax is human readable and not intended for processing by machines. As such it is not documented.

*However*, the errorCode attached to the message is machine-readable and has the following format:

1. The error code will be a list, each element describing a single error found in the input. The list has at least one element, possibly more.

2. Each error element will be a list containing six strings describing an error in detail. The strings will be

    1. The path of the file the error occurred in. This may be empty.

    2. The range of the token the error was found at. This range is a two-element list containing the offset of the first and last character in the range, counted from the beginning of the input (file). Offsets are counted from zero.

    3. The line the first character after the error is on. Lines are counted from one.

    4. The column the first character after the error is at. Columns are counted from zero.

    5. The message code of the error. This value can be used as argument to **msgcat::mc** to obtain a localized error message, assuming that the application had a suitable call of **doctools::msgcat::init** to initialize the necessary message catalogs (See package **doctools::msgcat**).

    6. A list of details for the error, like the markup command involved. In the case of message code **docidx/include/syntax** this value is the set of errors found in the included file, using the format described here.



# \[docidx\] notation of keyword indices

The docidx format for keyword indices, also called the *docidx markup language*, is too large to be covered in single section. The interested reader should start with the document

1. *docidx language introduction*


and then proceed from there to the formal specifications, i.e. the documents

1. *docidx language syntax* and

2. *docidx language command reference*.


to get a thorough understanding of the language.

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
