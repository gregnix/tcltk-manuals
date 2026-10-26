---
CommandName: docidx_lang_cmdref
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_faq
 - docidx_lang_intro
 - docidx_lang_syntax
Keywords:
 - docidx commands
 - docidx language
 - docidx markup
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

docidx_lang_cmdref - docidx language command reference

# Synopsis

::: {.synopsis} :::
[comment]{.cmd} [plaintext]{.arg} 
[include]{.cmd} [filename]{.arg} 
[index_begin]{.cmd} [text]{.arg} [title]{.arg} 
[index_end]{.cmd} 
[key]{.cmd} [text]{.arg} 
[lb]{.cmd} 
[manpage]{.cmd} [file]{.arg} [text]{.arg} 
[rb]{.cmd} 
[url]{.cmd} [url]{.arg} [label]{.arg} 
[vset]{.cmd} [varname]{.arg} [value]{.arg} 
[vset]{.cmd} [varname]{.arg} 
:::

# Description

This document specifies both names and syntax of all the commands which together are the docidx markup language, version 1. As this document is intended to be a reference the commands are listed in alphabetical order, and the descriptions are relatively short. A beginner should read the much more informally written *docidx language introduction* first.

# Commands

**comment** *plaintext*
: Index markup. The argument text is marked up as a comment standing outside of the actual text of the document. Main use is in free-form text.

**include** *filename*
: Templating. The contents of the named file are interpreted as text written in the docidx markup and processed in the place of the include command. The markup in the file has to be self-contained. It is not possible for a markup command to cross the file boundaries.

**index_begin** *text* *title*
: Document structure. The command to start an index. The arguments are a label for the whole group of documents the index refers to (*text*) and the overall title text for the index (*title*), without markup. The label often is the name of the package (or extension) the documents belong to.

**index_end**
: Document structure. Command to end an index. Anything in the document coming after this command is in error.

**key** *text*
: Index structure. This command adds the keyword *text* to the index.

**lb**
: Text. The command is replaced with a left bracket. Use in free-form text. Required to avoid interpretation of a left bracket as the start of a markup command. Its usage is restricted to the arguments of other markup commands.

**manpage** *file* *text*
: Index structure. This command adds an element to the index which refers to a document. The document is specified through the symbolic name *file*. The *text* argument is used to label the reference. Symbolic names are used to preserve the convertibility of this format to any output format. The actual name of the file will be inserted by the chosen formatting engine when converting the input. This will be based on a mapping from symbolic to actual names given to the engine.

**rb**
: Text. The command is replaced with a right bracket. Use in free-form text. Required to avoid interpretation of a right bracket as the end of a markup command. Its usage is restricted to the arguments of other commands.

**url** *url* *label*
: Index structure. This is the second command to add an element to the index. To refer to a document it is not using a symbolic name however, but a (possibly format-specific) url describing the exact location of the document indexed here.

**vset** *varname* *value*
: Templating. In this form the command sets the named document variable to the specified *value*. It does not generate output. I.e. the command is replaced by the empty string.

**vset** *varname*
: Templating. In this form the command is replaced by the value of the named document variable


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
