---
CommandName: markdown
ManualSection: n
Version: 1.2.4
TclPart: tcllib
TclDescription: Markdown to HTML Converter
Copyright:
---

# Name

markdown - Converts Markdown text to HTML

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [Markdown]{.lit} [1.2.4]{.lit} 
[package]{.cmd} [require]{.sub} [textutil]{.lit} [0.8]{.optlit} 
[::Markdown::convert]{.cmd} [markdown]{.arg} 
[::Markdown::register]{.cmd} [langspec]{.arg} [converter]{.arg} 
[::Markdown::get_lang_counter]{.cmd} 
[::Markdown::reset_lang_counter]{.cmd} 
:::

# Description

The package **Markdown** provides a command to convert Markdown annotated text into HMTL.

**::Markdown::convert** *markdown*
: This command takes in a block of Markdown text, and returns a block of HTML. The converter supports two types of syntax highlighting for fenced code blocks: highlighting via a registered converter (see **::Markdown::register**), or pure JavaScript highlighting, e.g. via "highlight.js", where the language specifier used in the markup is set as CSS class of the "code" element in the returned markup.

**::Markdown::register** *langspec* *converter*
: Register a language specific converter for prettifying a code block (e.g. syntax highlighting).  Markdown supports fenced code blocks with an optional language specifier (e.g. "tcl"). When the markdown parser processes such a code block and a converter for the specified langspec is registered, the converter is called with the raw code block as argument. The converter is supposed to return the markup of the code block as result. The specified converter can be an arbitrary Tcl command, the raw text block is added as last argument upon invocation.

**::Markdown::get_lang_counter**
: Return a dict of language specifier and number of occurrences in fenced code blocks. This function can be used e.g. to detect, whether some CSS or JavaScript headers should be included for rendering without the need of postprocessing the rendered result.

**::Markdown::reset_lang_counter**
: Reset the language counters.


# Supported markdown syntax

This markdown converter supports the original markdown by Gruber and Swartz(see their [syntax](https://daringfireball.net/projects/markdown/syntax) page for details):

**•**
: paragraphs

**•**
: atx- and setext-style headers

**•**
: blockquotes

**•**
: emphasis and strong emphasis

**•**
: unordered and ordered lists

**•**
: inline-style, reference-style and automatic links

**•**
: inline- and reference-style images

**•**
: inline code

**•**
: code blocks (with four indent spaces or one tab)

**•**
: inline HTML

**•**
: backslash escapes

**•**
: horizontal rules In addition, the following extended markdown sytax is supported, taken from [PHP Markdown Extra](https://michelf.ca/projects/php-markdown/extra/) and [GFM (Github Flavoured Markdown)](https://github.github.com/gfm/):

**•**
: pipe tables

**•**
: fenced code blocks (with an optional language specifier)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
