---
CommandName: doctoc_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - doctoc_lang_cmdref
 - doctoc_lang_faq
 - doctoc_lang_intro
 - doctoc_lang_syntax
 - doctoc_plugin_apiref
 - doctools::toc
 - doctools_intro
Keywords:
 - markup
 - semantic markup
 - table of contents
 - toc
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctoc_intro - doctoc introduction

# Description

*doctoc* (short for *documentation tables of contents*) stands for a set of related, yet different, entities which are working together for the easy creation and transformation of tables of contents for documentation. These are

**\[1\]**
: A tcl based language for the semantic markup of a table of contents. Markup is represented by Tcl commands.

**\[2\]**
: A package providing the ability to read and transform texts written in that markup language. It is important to note that the actual transformation of the input text is delegated to plugins.

**\[3\]**
: An API describing the interface between the package above and a plugin. Which of the more detailed documents are relevant to the reader of this introduction depends on their role in the documentation process.

**\[1\]**
: A *writer* of documentation has to understand the markup language itself. A beginner to doctoc should read the more informally written *doctoc language introduction* first. Having digested this the formal *doctoc language syntax* specification should become understandable. A writer experienced with doctoc may only need the *doctoc language command reference* from time to time to refresh her memory. While a document is written the **dtp** application can be used to validate it, and after completion it also performs the conversion into the chosen system of visual markup, be it \*roff, HTML, plain text, wiki, etc. The simpler **dtplite** application makes internal use of doctoc when handling directories of documentation, automatically generating a proper table of contents for them.

**\[2\]**
: A *processor* of documentation written in the *doctoc* markup language has to know which tools are available for use. The main tool is the aforementioned **dtp** application provided by Tcllib. The simpler **dtplite** does not expose doctoc to the user. At the bottom level, common to both applications, however sits the package **doctoools::toc**, providing the basic facilities to read and process files containing text in the doctoc format.

**\[3\]**
: At last, but not least, *plugin writers* have to understand the interaction between the **doctools::toc** package and its plugins, as described in the *doctoc plugin API reference*.


# Related formats

doctoc does not stand alone, it has two companion formats. These are called *docidx* and *doctools*, and they are for the markup of *keyword indices*, and general documentation, respectively. They are described in their own sets of documents, starting at the *docidx introduction* and the *doctools introduction*, respectively.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
