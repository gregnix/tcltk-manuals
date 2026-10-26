---
CommandName: doctools_lang_cmdref
title: doctools_lang_cmdref
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - doctools_intro
 - doctools_lang_faq
 - doctools_lang_intro
 - doctools_lang_syntax
Keywords:
 - doctools commands
 - doctools language
 - doctools markup
 - markup
 - semantic markup
Copyright:
 - Copyright (c) 2007-2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools\_lang\_cmdref - doctools language command reference

# Synopsis

::: {.synopsis} :::
[arg]{.cmd} [text]{.arg}
[arg\_def]{.cmd} [type]{.arg} [name]{.arg} [mode]{.optarg}
[bullet]{.cmd} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [item)]{.lit}
[call]{.cmd} [args]{.arg}
[category]{.cmd} [text]{.arg}
[class]{.cmd} [text]{.arg}
[cmd]{.cmd} [text]{.arg}
[cmd\_def]{.cmd} [command]{.arg}
[comment]{.cmd} [plaintext]{.arg}
[const]{.cmd} [text]{.arg}
[copyright]{.cmd} [text]{.arg}
[def]{.cmd} [text]{.arg}
[description]{.cmd}
[enum]{.cmd}
[emph]{.cmd} [text]{.arg}
[example]{.cmd} [text]{.arg}
[example\_begin]{.cmd}
[example\_end]{.cmd}
[file]{.cmd} [text]{.arg}
[fun]{.cmd} [text]{.arg}
[image]{.cmd} [name]{.arg} [label]{.optarg}
[include]{.cmd} [filename]{.arg}
[item]{.cmd}
[keywords]{.cmd} [args]{.arg}
[lb]{.cmd}
[list\_begin]{.cmd} [what]{.arg}
[list\_end]{.cmd}
[lst\_item]{.cmd} [text]{.arg} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [def)]{.lit}
[manpage\_begin]{.cmd} [command]{.arg} [section]{.arg} [version]{.arg}
[manpage\_end]{.cmd}
[method]{.cmd} [text]{.arg}
[moddesc]{.cmd} [text]{.arg}
[namespace]{.cmd} [text]{.arg}
[nl]{.cmd} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [para)]{.lit}
[opt]{.cmd} [text]{.arg}
[opt\_def]{.cmd} [name]{.arg} [arg]{.optarg}
[option]{.cmd} [text]{.arg}
[package]{.cmd} [text]{.arg}
[para]{.cmd}
[rb]{.cmd}
[require]{.cmd} [package]{.arg} [version...]{.optarg}
[section]{.cmd} [name]{.arg}
[sectref]{.cmd} [id]{.arg} [text]{.optarg}
[sectref-external]{.cmd} [text]{.arg}
[see\_also]{.cmd} [args]{.arg}
[strong]{.cmd} [text]{.arg} [(deprecated]{.arg} [—]{.arg} [use]{.arg} [emph)]{.lit}
[subsection]{.cmd} [name]{.arg}
[syscmd]{.cmd} [text]{.arg}
[term]{.cmd} [text]{.arg}
[titledesc]{.cmd} [desc]{.arg}
[tkoption\_def]{.cmd} [name]{.arg} [dbname]{.arg} [dbclass]{.arg}
[type]{.cmd} [text]{.arg}
[uri]{.cmd} [text]{.arg} [text]{.optarg}
[usage]{.cmd} [args]{.arg}
[var]{.cmd} [text]{.arg}
[vset]{.cmd} [varname]{.arg} [value]{.arg}
[vset]{.cmd} [varname]{.arg}
[widget]{.cmd} [text]{.arg}
:::

# Description

This document specifies both names and syntax of all the commands which together are the doctools markup language, version 1. As this document is intended to be a reference the commands are listed in alphabetical order, and the descriptions are relatively short. A beginner should read the much more informally written *doctools language introduction* first.

# Commands

**arg** *text*
: Text markup. The argument text is marked up as the *argument* of a command. Main uses are the highlighting of command arguments in free-form text, and for the argument parameters of the markup commands **call** and **usage**.

**arg\_def** *type* *name* ?*mode*?
: Text structure. List element. Argument list. Automatically closes the previous list element. Specifies the data-*type* of the described argument of a command, its *name* and its i/o-*mode*. The latter is optional.

**bullet** *(deprecated — use* **item***)*
: *Deprecated*. Text structure. List element. Itemized list. See **item** for the canonical command to open a list item in an itemized list.

**call** *args*
: Text structure. List element. Definition list. Automatically closes the previous list element. Defines the term as a command and its arguments. The first argument is the name of the command described by the following free-form text, and all arguments coming after that are descriptions of the command's arguments. It is expected that the arguments are marked up with **arg**, **method**, **option** etc., as is appropriate, and that the command itself is marked up with **cmd**. It is expected that the formatted term is not only printed in place, but also in the table of contents of the document, or synopsis, depending on the output format.

**category** *text*
: Document information. Anywhere. This command registers its plain text arguments as the category this document belongs to. If this command is used multiple times the last value specified is used.

**class** *text*
: Text markup. The argument is marked up as the name of a *class*. The text may have other markup already applied to it. Main use is the highlighting of class names in free-form text.

**cmd** *text*
: Text markup. The argument text is marked up as the name of a *Tcl command*. The text may have other markup already applied to it. Main uses are the highlighting of commands in free-form text, and for the command parameters of the markup commands **call** and **usage**.

**cmd\_def** *command*
: Text structure. List element. Command list. Automatically closes the previous list element. The argument specifies the name of the *Tcl command* to be described by the list element. Expected to be marked up in the output as if it had been formatted with **cmd**.

**comment** *plaintext*
: Text markup. The argument text is marked up as a comment standing outside of the actual text of the document. Main use is in free-form text.

**const** *text*
: Text markup. The argument is marked up as a *constant* value. The text may have other markup already applied to it. Main use is the highlighting of constants in free-form text.

**copyright** *text*
: Document information. Anywhere. The command registers the plain text argument as a copyright assignment for the manpage. When invoked more than once the assignments are accumulated.

**def** *text*
: Text structure. List element. Definition list. Automatically closes the previous list element. The argument text is the term defined by the new list element. Text markup can be applied to it.

**description**
: Document structure. This command separates the header from the document body.  Implicitly starts a section named "DESCRIPTION" (See command **section**).

**enum**
: Text structure. List element. Enumerated list. Automatically closes the previous list element.

**emph** *text*
: Text markup. The argument text is marked up as emphasized. Main use is for general highlighting of pieces of free-form text without attaching special meaning to the pieces.

**example** *text*
: Text structure, Text markup. This command marks its argument up as an *example*. Main use is the simple embedding of examples in free-form text. It should be used if the example does *not* need special markup of its own. Otherwise use a sequence of **example\_begin** ... **example\_end**.

**example\_begin**
: Text structure. This commands starts an example. All text until the next **example\_end** belongs to the example. Line breaks, spaces, and tabs have to be preserved literally. Examples cannot be nested.

**example\_end**
: Text structure. This command closes the example started by the last **example\_begin**.

**file** *text*
: Text markup. The argument is marked up as a *file* or *directory*, i.e. in general a *path*. The text may have other markup already applied to it. Main use is the highlighting of paths in free-form text.

**fun** *text*
: Text markup. The argument is marked up as the name of a *function*. The text may have other markup already applied to it. Main use is the highlighting of function names in free-form text.

**image** *name* ?*label*?
: Text markup. The argument is the symbolic name of an *image* and replaced with the image itself, if a suitable variant is found by the backend. The second argument, should it be present, will be interpreted the human-readable description of the image, and put into the output in a suitable position, if such is supported by the format. The HTML format, for example, can place it into the *alt* attribute of image references.

**include** *filename*
: Templating. The contents of the named file are interpreted as text written in the doctools markup and processed in the place of the include command. The markup in the file has to be self-contained. It is not possible for a markup command to cross the file boundaries.

**item**
: Text structure. List element. Itemized list. Automatically closes the previous list element.

**keywords** *args*
: Document information. Anywhere. This command registers all its plain text arguments as keywords applying to this document. Each argument is a single keyword. If this command is used multiple times all the arguments accumulate.

**lb**
: Text. The command is replaced with a left bracket. Use in free-form text. Required to avoid interpretation of a left bracket as the start of a markup command.

**list\_begin** *what*
: Text structure. This command starts a list. The exact nature of the list is determined by the argument *what* of the command. This further determines which commands are have to be used to start the list elements. Lists can be nested, i.e. it is allowed to start a new list within a list element.

    The allowed types (and their associated item commands) are:

    **arguments**
    : **arg\_def**.

    **commands**
    : **cmd\_def**.

    **definitions**
    : **def** and **call**.

    **enumerated**
    : **enum**

    **itemized**
    : **item**

    **options**
    : **opt\_def**

    **tkoptions**
    : **tkoption\_def**


    Additionally the following names are recognized as shortcuts for some of the regular types:

    **args**
    : Short for **arguments**.

    **cmds**
    : Short for **commands**.

    **enum**
    : Short for **enumerated**.

    **item**
    : Short for **itemized**.

    **opts**
    : Short for **options**.


    At last the following names are still recognized for backward compatibility, but are otherwise considered to be *deprecated*.

    **arg**
    : *Deprecated*. See **arguments**.

    **bullet**
    : *Deprecated*. See **itemized**.

    **cmd**
    : *Deprecated*. See **commands**.

    **opt**
    : *Deprecated*. See **options**.

    **tkoption**
    : *Deprecated*. See **tkoptions**.


**list\_end**
: Text structure. This command closes the list opened by the last **list\_begin** command coming before it.

**lst\_item** *text* *(deprecated — use* **def***)*
: *Deprecated*. Text structure. List element. Definition list. See **def** for the canonical command to open a general list item in a definition list.

**manpage\_begin** *command* *section* *version*
: Document structure. The command to start a manpage. The arguments are the name of the *command* described by the manpage, the *section* of the manpages this manpage resides in, and the *version* of the module containing the command. All arguments have to be plain text, without markup.

**manpage\_end**
: Document structure. Command to end a manpage/document. Anything in the document coming after this command is in error.

**method** *text*
: Text markup. The argument text is marked up as the name of an *object* *method*, i.e. subcommand of a Tcl command. The text may have other markup already applied to it. Main uses are the highlighting of method names in free-form text, and for the command parameters of the markup commands **call** and **usage**.

**moddesc** *text*
: Document information. Header. Registers the plain text argument as a short description of the module the manpage resides in.

**namespace** *text*
: Text markup. The argument text is marked up as a namespace name. The text may have other markup already applied to it. Main use is the highlighting of namespace names in free-form text.

**nl** *(deprecated — use* **para***)*
: *Deprecated*. Text structure. See **para** for the canonical command to insert paragraph breaks into the text.

**opt** *text*
: Text markup. The argument text is marked up as *optional*. The text may have other markup already applied to it. Main use is the highlighting of optional arguments, see the command arg **arg**.

**opt\_def** *name* ?*arg*?
: Text structure. List element. Option list. Automatically closes the previous list element. Specifies *name* and arguments of the *option* described by the list element. It is expected that the name is marked up using **option**.

**option** *text*
: Text markup. The argument is marked up as *option*. The text may have other markup already applied to it. Main use is the highlighting of options, also known as command-switches, in either free-form text, or the arguments of the **call** and **usage** commands.

**package** *text*
: Text markup. The argument is marked up as the name of a *package*. The text may have other markup already applied to it. Main use is the highlighting of package names in free-form text.

**para**
: Text structure. This command breaks free-form text into paragraphs. Each command closes the paragraph coming before it and starts a new paragraph for the text coming after it. Higher-level forms of structure are sections and subsections.

**rb**
: Text. The command is replaced with a right bracket. Use in free-form text. Required to avoid interpretation of a right bracket as the end of a markup command.

**require** *package* ?*version*...?
: Document information. Header. This command registers its argument *package* as the name of a package or application required by the described package or application. A set of required versions can be provided as well. This argument can be marked up. The usual markup is **opt**.

**section** *name*
: Text structure. This command starts a new named document section. The argument has to be plain text. Implicitly closes the last paragraph coming before it and also implicitly opens the first paragraph of the new section.

**sectref** *id* ?*text*?
: Text markup. Formats a reference to the section identified by *id*. If no *text* is specified the title of the referenced section is used in the output, otherwise *text* is used.

**sectref-external** *text*
: Text markup. Like **sectref**, except that the section is assumed to be in a different document and therefore doesn't need to be identified, nor are any checks for existence made. Only the text to format is needed.

**see\_also** *args*
: Document information. Anywhere. The command defines direct cross-references to other documents. Each argument is a plain text label identifying the referenced document. If this command is used multiple times all the arguments accumulate.

**strong** *text* *(deprecated — use* **emph***)*
: *Deprecated*. Text markup. See **emph** for the canonical command to emphasize text.

**subsection** *name*
: Text structure. This command starts a new named subsection of a section. The argument has to be plain text. Implicitly closes the last paragraph coming before it and also implicitly opens the first paragraph of the new subsection.

**syscmd** *text*
: Text markup. The argument text is marked up as the name of an external command. The text may have other markup already applied to it. Main use is the highlighting of external commands in free-form text.

**term** *text*
: Text markup. The argument is marked up as unspecific terminology.  The text may have other markup already applied to it. Main use is the highlighting of important terms and concepts in free-form text.

**titledesc** *desc*
: Document information. Header. Optional. Registers the plain text argument as the title of the manpage. Defaults to the value registered by **moddesc**.

**tkoption\_def** *name* *dbname* *dbclass*
: Text structure. List element. Widget option list. Automatically closes the previous list element. Specifies the *name* of the option as used in scripts, the name used by the option database (*dbname*), and its class (*dbclass*), i.e. its type. It is expected that the name is marked up using **option**.

**type** *text*
: Text markup. The argument is marked up as the name of a *data type*. The text may have other markup already applied to it. Main use is the highlighting of data types in free-form text.

**uri** *text* ?*text*?
: Text markup. The argument is marked up as an *uri* (i.e. a *uniform resource identifier*. The text may have other markup already applied to it. Main use is the highlighting of uris in free-form text. The second argument, should it be present, will be interpreted the human-readable description of the uri. In other words, as its label. Without an explicit label the uri will be its own label.

**usage** *args*
: Text markup. See **call** for the full description, this command is syntactically identical, as it is in its expectations for the markup of its arguments. In contrast to **call** it is however not allowed to generate output where this command occurs in the text. The command is *silent*. The formatted text may only appear in a different section of the output, for example a table of contents, or synopsis, depending on the output format.

**var** *text*
: Text markup. The argument is marked up as the name of a *variable*. The text may have other markup already applied to it. Main use is the highlighting of variables in free-form text.

**vset** *varname* *value*
: Templating. In this form the command sets the named document variable to the specified *value*. It does not generate output. I.e. the command is replaced by the empty string.

**vset** *varname*
: Templating. In this form the command is replaced by the value of the named document variable

**widget** *text*
: Text markup. The argument is marked up as the name of a *widget*. The text may have other markup already applied to it. Main use is the highlighting of widget names in free-form text.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2007-2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
