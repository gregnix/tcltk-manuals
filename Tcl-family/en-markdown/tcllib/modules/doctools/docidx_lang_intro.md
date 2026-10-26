---
CommandName: docidx_lang_intro
title: docidx_lang_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_cmdref
 - docidx_lang_syntax
Keywords:
 - docidx commands
 - docidx language
 - docidx markup
 - docidx syntax
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

docidx\_lang\_intro - docidx language introduction

# Description

This document is an informal introduction to version 1 of the docidx markup language based on a multitude of examples. After reading this a writer should be ready to understand the two parts of the formal specification, i.e. the *docidx language syntax* specification and the *docidx language command reference*.

## Fundamentals

While the *docidx markup language* is quite similar to the *doctools markup language*, in the broadest terms possible, there is one key difference. An index consists essentially only of markup commands, with no plain text interspersed between them, except for whitespace.

Each markup command is a Tcl command surrounded by a matching pair of **\[** and **\]**. Inside of these delimiters the usual rules for a Tcl command apply with regard to word quotation, nested commands, continuation lines, etc. I.e.

```
    ... [key {markup language}] ...
```

```
  ... [manpage thefile \
          {file description}] ...
```

## Basic structure

The most simple document which can be written in docidx is

```
    [index_begin GROUPTITLE TITLE]
    [index_end]
```

Not very useful, but valid. This also shows us that all docidx documents consist of only one part where we will list all keys and their references.

A more useful index will contain at least keywords, or short 'keys', i.e. the phrases which were indexed. So:

```
[index_begin GROUPTITLE TITLE]
[key markup]
[key {semantic markup}]]
[key {docidx markup}]
[key {docidx language}]
[key {docidx commands}]
[index_end]
```

In the above example the command [key][docidx_lang_cmdref] is used to declare the keyword phrases we wish to be part of the index.

However a truly useful index does not only list the keyword phrases, but will also contain references to documents associated with the keywords. Here is a made-up index for all the manpages in the module *base64*:

```
[index_begin tcllib/base64 {De- & Encoding}]
[key base64]
[manpage base64]
[key encoding]
[manpage base64]
[manpage uuencode]
[manpage yencode]
[key uuencode]
[manpage uuencode]
[key yEnc]
[manpage yencode]
[key ydecode]
[manpage yencode]
[key yencode]
[manpage yencode]
[index_end]
```

In the above example the command [manpage][docidx_lang_cmdref] is used to insert references to documents, using symbolic file names, with each command belonging to the last [key][docidx_lang_cmdref] command coming before it.

The other command to insert references is **url**. In contrast to [manpage][docidx_lang_cmdref] it uses explicit (possibly format-specific) urls to describe the location of the referenced document. As such this command is intended for the creation of references to external documents which could not be handled in any other way.

## Advanced structure

In all previous examples we fudged a bit regarding the markup actually allowed to be used before the [index\_begin][docidx_lang_cmdref] command opening the document.

Instead of only whitespace the two templating commands [include][docidx_lang_cmdref] and [vset][docidx_lang_cmdref] are also allowed, to enable the writer to either set and/or import configuration settings relevant to the table of contents. I.e. it is possible to write

```
[include FILE]
[vset VAR VALUE]
[index_begin GROUPTITLE TITLE]
...
[index_end]
```

Even more important, these two commands are allowed anywhere where a markup command is allowed, without regard for any other structure.

```
[index_begin GROUPTITLE TITLE]
[include FILE]
[vset VAR VALUE]
...
[index_end]
```

The only restriction [include][docidx_lang_cmdref] has to obey is that the contents of the included file must be valid at the place of the inclusion. I.e. a file included before [index\_begin][docidx_lang_cmdref] may contain only the templating commands [vset][docidx_lang_cmdref] and [include][docidx_lang_cmdref], a file included after a key may contain only manape or url references, and other keys, etc.

## Escapes

Beyond the 6 commands shown so far we have two more available. However their function is not the marking up of index structure, but the insertion of characters, namely **\[** and **\]**. These commands, [lb][docidx_lang_cmdref] and [rb][docidx_lang_cmdref] respectively, are required because our use of \[ and \] to bracket markup commands makes it impossible to directly use \[ and \] within the text.

Our example of their use are the sources of the last sentence in the previous paragraph, with some highlighting added.

```
  ...
  These commands, [cmd lb] and [cmd lb] respectively, are required
  because our use of [lb] and [rb] to bracket markup commands makes it
  impossible to directly use [lb] and [rb] within the text.
  ...
```

# Further reading

Now that this document has been digested the reader, assumed to be a *writer* of documentation should be fortified enough to be able to understand the formal *docidx language syntax* specification as well. From here on out the *docidx language command reference* will also serve as the detailed specification and cheat sheet for all available commands and their syntax.

To be able to validate a document while writing it, it is also recommended to familiarize oneself with Tclapps' ultra-configurable **dtp**.

On the other hand, docidx is perfectly suited for the automatic generation from doctools documents, and this is the route Tcllib's easy and simple **dtplite** goes, creating an index for a set of documents behind the scenes, without the writer having to do so on their own.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2007-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[docidx_lang_cmdref]: docidx_lang_cmdref.md
