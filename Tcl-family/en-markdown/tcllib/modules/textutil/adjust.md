---
CommandName: textutil::adjust
title: textutil::adjust
ManualSection: n
Version: 0.7.4
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - TeX
 - adjusting
 - formatting
 - hyphenation
 - indenting
 - justification
 - paragraph
 - string
 - undenting
Copyright:
---

# Name

textutil::adjust - Procedures to adjust, indent, and undent paragraphs

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::adjust]{.lit} [0.7.4]{.optlit}
[::textutil::adjust::adjust]{.cmd} [string]{.arg} [option value]{.optdot}
[::textutil::adjust::readPatterns]{.cmd} [filename]{.arg}
[::textutil::adjust::listPredefined]{.cmd}
[::textutil::adjust::getPredefined]{.cmd} [filename]{.arg}
[::textutil::adjust::indent]{.cmd} [string]{.arg} [prefix]{.arg} [skip]{.optarg}
[::textutil::adjust::undent]{.cmd} [string]{.arg}
:::

# Description

The **textutil::adjust** package provides commands to indent, unindent, and justify the text held in a string.

# API

**::textutil::adjust::adjust** *string* ?*option value ...*?
: Returns a copy of *string* modified according to the given options.

    Any newlines in the original *string* are treated as spaces, i.e., the input *string* is handled as a single paragraph of text. If the result string is shorter than the **-length**, it will not contain any newlines. Otherwise, the result will contain newlines as needed to perform the desired justification.

    Together with **::textutil::adjust::indent** it is possible to create properly wrapped paragraphs with arbitrary indentations.

    Under the hood, every newline, tab, or sequence of two or more spaces are treated as a single space, and single spaces are used to separate the line’s words. These are the algorithm’s *real* lines. Every *real* line is placed in a *logical* line, which is exactly **-length** characters wide (even if the *real* line is shorter). Every word in a *real* line is separated by a single space, except when the **-justify** **plain** option is used, in which case words are separated by one or more spaces as needed to fill the *real* line.

    By default, trailing spaces (including tabs which are first replaced by spaces) are trimmed. See the **-full** option below.

    The following options may be given after the *string* parameter. They control how the command places each *real* line in its corresponding *logical* line.

    **-full** *boolean*
    : If set to **0** (false; the default), any trailing spaces are deleted from each line before returning the string. If set to **1** (true), any trailing spaces are left at the end each line.

    **-hyphenate** *boolean*
    : If set to **0** (false; the default), no hyphenation will be done. If set to **1** (true), the command will try to hyphenate the last word of each line when appropriate.

        If **-hyphenate** is set to **1**, hyphenation patterns *must* have been loaded by calling the **::textutil::adjust::readPatterns** command, *before* the call to **::textutil::adjust::adjust**; otherwise **::textutil::adjust::adjust** will throw an error.

    **-justify** **center|left|plain|right**
    : Sets the justification applied to the returned string to any one of: **left** (the default), **center**, **plain** (justified), or **right**. The justification means that any line in the returned string (possibly excluding the last line), is justified according to the given justification.

        If the justification is set to **plain** (justified), and the number of printable characters in the last line is less than 90% of **-length**, then the last line is justified **left**, avoiding the padding of this line when it is too short. The meaning of each value is:

        **center**
        : Each *real* line is centered in the *logical* line by padding the *real* line with spaces at the beginning and end as needed. If the last line is less than 90% of **-length**, it will be aligned **left** instead of **center**. (See also the **-full** option.)

        **left**
        : Each *real* line is placed at the left of the *logical* line, with no preceding spaces. If **-full** is **1** (true), the *real* line will be padded with spaces at the end to make it **-length** characters wide.

        **plain**
        : Each line is fully justified. This means that each *real* line’s words are placed in the *logical* line, separated by one or more spaces, as needed to completely fill the line with no leading or trailing spaces.

        **right**
        : Each *real* line is placed at the right of the *logical* line, with no trailing spaces, and padded with leading spaces if needed to make the *real* line **-length** characters wide.


    **-length** *integer*
    : Sets the *logical* line length to be *integer*. The *integer* must be a positive integer *> 0*. The default is **72**.

    **-strictlength** *boolean*
    : If set to **0** (false; the default), a line can exceed the specified **-length** if a single word is longer than **-length**. If set to **1** (true), words that are longer than **-length** are split so that no line exceeds the specified **-length**.


**::textutil::adjust::readPatterns** *filename*
: Reads hyphenation patterns from the file called *filename*.

    This command is needed only if command **::textutil::adjust::adjust** is used with **-hyphenate** **1** (true). In this case the call to **::textutil::adjust::readPatterns** *must* be done *before* calling **::textutil::adjust::adjust**.

    The **textutil::adjust** package comes with a number of predefined pattern files. Use the **::textutil::adjust::listPredefined** command to list their names.

**::textutil::adjust::listPredefined**
: Returns a list of the names of the hyphenation files provided by this package.

**::textutil::adjust::getPredefined** *filename*
: Returns the full path and filename of the *filename* hyphenation file. *Note* that *filename* *must* be one of the names returned by **::textutil::adjust::listPredefined**.

**::textutil::adjust::indent** *string* *prefix* ?*skip*?
: Returns a modified copy of *string* with every non-skipped line prefixed with *prefix* and whitespace (except for the newline), trimmed from the end. By default no lines are skipped, so all are prefixed.

    The **skip** option specifies how many lines to skip at the start of the string; its default is **0**, in which case none are skipped and all are prefixed. If **skip** is set to a value *> 0*, then that many initial lines in the string are skipped, i.e., not prefixed, while all the subsequent lines are prefixed. Setting **skip** to **1** will create a conventional hanging indent.

    Together with **::textutil::adjust::adjust** it is possible to create properly wrapped paragraphs with arbitrary indentations.

**::textutil::adjust::undent** *string*
: Returns a modified copy of *string* with any common prefix of whitespace removed from each line.

    Empty lines and lines containing only whitespace are ignored for the computation of the prefix and all these lines are returned as empty lines.

    *Note that this command’s name is* **undent** *not unindent.*


# Examples

The following examples show some of the **::textutil::adjust** package’s commands in action.

The following **proc** and **const** are used by the examples below.

```
proc replace_spc {s {sub ▴}} { regsub -all { } $s $sub }
const LINES "Four\nsiamese cats\nheard barks\nand bolted."
```

The **replace\_spc** command replaces every space in the string it is passed with the ▴ symbol. The **LINES** constant provides some text for the examples to work with.

## Justifying

The following example show every justification option in use. Spaces have been made visible by preserving them using **-full** **1** and replacing them with the ▴ symbol.

Normally, **-full** would *not* be used and there would be *no* trailing spaces in each line.

```
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify left]
puts "======= left =======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify center]
puts "====== center ======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify plain]
puts "======= plain ======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify right]
puts "======= right ======\n[replace_spc $lines]"
=>
======= left =======
Four▴siamese▴cats▴▴▴
heard▴barks▴and▴▴▴▴▴
bolted.▴▴▴▴▴▴▴▴▴▴▴▴▴

====== center ======
▴▴Four▴siamese▴cats▴
▴▴▴heard▴barks▴and▴▴
▴▴▴▴▴▴▴bolted.▴▴▴▴▴▴

======= plain ======
Four▴siamese▴▴▴▴cats
heard▴▴▴barks▴▴▴▴and
bolted.▴▴▴▴▴▴▴▴▴▴▴▴▴

======= right ======
▴▴▴Four▴siamese▴cats
▴▴▴▴▴heard▴barks▴and
▴▴▴▴▴▴▴▴▴▴▴▴▴bolted.
```

## Indenting and unindenting

In the following example leading spaces have been made visible by using an indent of **··** rather than, say, two spaces, and other spaces have been made visible by replacing them with the ▴ symbol. There are no trailing spaces since **textutil::adjust::indent** trims them.

```
set lines [textutil::adjust::adjust $LINES -length 20 -justify left]
puts "======== left =========\n[replace_spc $lines]"
set indented [textutil::adjust::indent $lines "··"]
puts "======== indent =======\n[replace_spc $indented]"
# undent only unindents spaces
set indented [regsub -all · $indented " "]
set unindented [textutil::adjust::undent $indented]
puts "======== undent =======\n[replace_spc $unindented]"
set hanging [textutil::adjust::indent $lines "··" 1]
puts "==== hanging indent ===\n[replace_spc $hanging]"
=>
======== left =========
Four▴siamese▴cats
heard▴barks▴and
bolted.
======== indent =======
··Four▴siamese▴cats
··heard▴barks▴and
··bolted.
======== undent =======
Four▴siamese▴cats
heard▴barks▴and
bolted.
==== hanging indent ===
Four▴siamese▴cats
··heard▴barks▴and
··bolted.
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
