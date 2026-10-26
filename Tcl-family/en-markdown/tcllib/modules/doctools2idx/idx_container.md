---
CommandName: doctools::idx
title: doctools::idx
ManualSection: n
Version: 2.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - HTML
 - TMML
 - conversion
 - docidx markup
 - documentation
 - formatting
 - generation
 - index
 - json
 - keyword index
 - latex
 - manpage
 - markup
 - nroff
 - parsing
 - plugin
 - reference
 - tcler's wiki
 - text
 - url
 - wiki
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx - Holding keyword indices

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx]{.lit} [2.1]{.optlit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::doctools::idx]{.cmd} [objectName]{.arg}
[objectName]{.cmd} [method]{.lit} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [key]{.sub} [add]{.lit} [name]{.arg}
[objectName]{.ins} [key]{.sub} [remove]{.lit} [name]{.arg}
[objectName]{.ins} [key]{.sub} [references]{.lit} [name]{.arg}
[objectName]{.ins} [keys]{.sub}
[objectName]{.ins} [reference]{.sub} [add]{.lit} [type]{.arg} [key]{.arg} [name]{.arg} [label]{.arg}
[objectName]{.ins} [reference]{.sub} [remove]{.lit} [name]{.arg}
[objectName]{.ins} [reference]{.sub} [label]{.lit} [name]{.arg}
[objectName]{.ins} [reference]{.sub} [keys]{.lit} [name]{.arg}
[objectName]{.ins} [reference]{.sub} [type]{.lit} [name]{.arg}
[objectName]{.ins} [references]{.sub}
[objectName]{.ins} [title]{.sub}
[objectName]{.ins} [title]{.sub} [text]{.arg}
[objectName]{.ins} [label]{.sub}
[objectName]{.ins} [label]{.sub} [text]{.arg}
[objectName]{.ins} [importer]{.sub}
[objectName]{.ins} [importer]{.sub} [object]{.arg}
[objectName]{.ins} [exporter]{.sub}
[objectName]{.ins} [exporter]{.sub} [object]{.arg}
[objectName]{.ins} [deserialize]{.sub} [=]{.lit} [data]{.arg} [format]{.optarg}
[objectName]{.ins} [deserialize]{.sub} [+=]{.lit} [data]{.arg} [format]{.optarg}
[objectName]{.ins} [serialize]{.sub} [format]{.optarg}
:::

# Description

This package provides a class to contain and programmatically manipulate keyword indices

This is one of the three public pillars the management of keyword indices resides on. The other two pillars are

1. *Exporting keyword indices*, and

2. *Importing keyword indices*


For information about the [Concepts] of keyword indices, and their parts, see the same-named section. For information about the data structure which is used to encode keyword indices as values see the section [Keyword index serialization format]. This is the only format directly known to this class. Conversions from and to any other format are handled by export and import manager objects. These may be attached to a container, but do not have to be, it is merely a convenience.

# Concepts

1. A *keyword index* consists of a (possibly empty) set of *keywords*.

2. Each keyword in the set is identified by its name.

3. Each keyword has a (possibly empty) set of *references*.

4. A reference can be associated with more than one keyword.

5. A reference not associated with at least one keyword is not possible however.

6. Each reference is identified by its target, specified as either an url or symbolic filename, depending on the type of reference (**url**, or **manpage**).

7. The type of a reference (url, or manpage) depends only on the reference itself, and not the keywords it is associated with.

8. In addition to a type each reference has a descriptive label as well. This label depends only on the reference itself, and not the keywords it is associated with.


A few notes

1. Manpage references are intended to be used for references to the documents the index is made for. Their target is a symbolic file name identifying the document, and export plugins may replace symbolic with actual file names, if specified.

2. Url references are intended on the othre hand are inteded to be used for links to anything else, like websites. Their target is an url.

3. While url and manpage references share a namespace for their identifiers, this should be no problem, given that manpage identifiers are symbolic filenames and as such they should never look like urls, the identifiers for url references.


# API

## Package commands

**::doctools::idx** *objectName*
: This command creates a new container object with an associated Tcl command whose name is *objectName*. This *object* command is explained in full detail in the sections [Object command] and [Object methods]. The object command will be created under the current namespace if the *objectName* is not fully qualified, and in the specified namespace otherwise.


## Object command

All objects created by the **::doctools::idx** command have the following general form:

**objectName** **method** ?*arg arg ...*?
: The method **method** and its *arg*'uments determine the exact behavior of the command. See section [Object methods] for the detailed specifications.


## Object methods

*objectName* **destroy**
: This method destroys the object it is invoked for.

*objectName* **key add** *name*
: This method adds the keyword *name* to the index. If the keyword is already known nothing is done. The result of the method is the empty string.

*objectName* **key remove** *name*
: This method removes the keyword *name* from the index. If the keyword is already gone nothing is done. Any references for whom this keyword was the last association are removed as well.  The result of the method is the empty string.

*objectName* **key references** *name*
: This method returns a list containing the names of all references associated with the keyword *name*. An error is thrown in the keyword is not known to the index. The order of the references in the list is undefined.

*objectName* **keys**
: This method returns a list containing the names of all keywords known to the index. The order of the keywords in the list is undefined.

*objectName* **reference add** *type* *key* *name* *label*
: This method adds the reference *name* to the index and associates it with the keyword *key*. The other two arguments hold the *type* and *label* of the reference, respectively. The type has to match the stored information, should the reference exist already, i.e. this information is immutable after the reference is known. The only way to change it is delete and recreate the reference. The label on the other hand is automatically updated to the value of the argument, overwriting any previously stored information. Should the reference exists already it is simply associated with the *key*.  If that is true already as well nothing is done, but the *label* updated to the new value.  The result of the method is the empty string.

    The *type* argument has be to one of **manpage** or **url**.

*objectName* **reference remove** *name*
: The reference *name* is removed from the index. All associations with keywords are released and the relevant reference labels removed. The result of the method is the empty string.

*objectName* **reference label** *name*
: This method returns the label associated with the reference *name*. An error is thrown if the reference is not known.

*objectName* **reference keys** *name*
: This method returns a list containing the names of all keywords associated with the reference *name*. An error is thrown in the reference is not known to the index. The order of the keywords in the list is undefined.

*objectName* **reference type** *name*
: This method returns the type of the reference *name*. An error is thrown in the reference is not known to the index.

*objectName* **references**
: This method returns a list containing the names of all references known to the index. The order of the references in the list is undefined.

*objectName* **title**
: Returns the currently defined title of the keyword index.

*objectName* **title** *text*
: Sets the title of the keyword index to *text*, and returns it as the result of the command.

*objectName* **label**
: Returns the currently defined label of the keyword index.

*objectName* **label** *text*
: Sets the label of the keyword index to *text*, and returns it as the result of the command.

*objectName* **importer**
: Returns the import manager object currently attached to the container, if any.

*objectName* **importer** *object*
: Attaches the *object* as import manager to the container, and returns it as the result of the command. Note that the *object* is *not* put into ownership of the container. I.e., destruction of the container will *not* destroy the *object*.

    It is expected that *object* provides a method named **import text** which takes a text and a format name, and returns the canonical serialization of the keyword index contained in the text, assuming the given format.

*objectName* **exporter**
: Returns the export manager object currently attached to the container, if any.

*objectName* **exporter** *object*
: Attaches the *object* as export manager to the container, and returns it as the result of the command. Note that the *object* is *not* put into ownership of the container. I.e., destruction of the container will *not* destroy the *object*.

    It is expected that *object* provides a method named **export object** which takes the container and a format name, and returns a text encoding keyword index stored in the container, in the given format. It is further expected that the *object* will use the container's method **serialize** to obtain the serialization of the keyword index from which to generate the text.

*objectName* **deserialize =** *data* ?*format*?
: This method replaces the contents of the index object with the index contained in the *data*. If no *format* was specified it is assumed to be the regular serialization of a keyword index.

    Otherwise the object will use the attached import manager to convert the data from the specified format to a serialization it can handle. In that case an error will be thrown if the container has no import manager attached to it.

    The result of the method is the empty string.

*objectName* **deserialize +=** *data* ?*format*?
: This method behaves like **deserialize =** in its essentials, except that it merges the keyword index in the *data* to its contents instead of replacing it. The method will throw an error if merging is not possible, i.e. would produce an invalid index. The existing content is left unchanged in that case.

    The result of the method is the empty string.

*objectName* **serialize** ?*format*?
: This method returns the keyword index contained in the object. If no *format* is not specified the returned result is the canonical serialization of its contents.

    Otherwise the object will use the attached export manager to convert the data to the specified format. In that case an error will be thrown if the container has no export manager attached to it.


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
