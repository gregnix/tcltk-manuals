---
CommandName: string::token::shell
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Text and string utilities
Keywords:
 - bash
 - lexing
 - parsing
 - shell
 - string
 - tokenization
Copyright:
---

# Name

string::token::shell - Parsing of shell command line

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [string::token::shell]{.lit} [1.3]{.optlit} 
[package]{.cmd} [require]{.sub} [string::token]{.lit} [1]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[::string]{.cmd} [token]{.sub} [shell]{.lit} [-indices]{.optlit} [-partial]{.optlit} [--]{.optarg} [string]{.arg} 
:::

# Description

This package provides a command which parses a line of text using basic **sh**-syntax into a list of words.

# Api

**::string token shell** ?**-indices**? ?**-partial**? ?--? *string*
: By default, returns a list of words from the input *string*. The words are split from *string* in accordance with basic [sh(1p)](https://man7.org/linux/man-pages/man1/sh.1p.html)-syntax. An error is thrown if the input does not follow the expected syntax. The command’s behaviour can be modified by specifying any of the two options **-indices** and **-partial**.


**--**
: When specified option parsing stops at this point. This option is needed if the input *string* may start with dash. In other words, this is pretty much required if *string* is user input.

**-indices**
: When specified the command returns a list of 4-element lists. Each 4-element list contains the type of the word, its start and end indexes in the *string*, and the word itself (copied from the *string*). For any given 4-element list, the length of the word as calculated by the difference between the indices may not match the length of the word in the last element. This is because the indices include delimeters, intra-word quoting, etc., whereas the word in the last element has all these stripped away. The possible token types are


**PLAIN**
: Plain word, not quoted.

**D:QUOTED**
: Word was delimited by double-quotes.

**S:QUOTED**
: Word was delimited by single-quotes.

**D:QUOTED:PART**
: ...see next...

**S:QUOTED:PART**
: Like the previous types, but the word has no closing quote, i.e., is incomplete. These token types can only occur if the **-partial** option was specified, and then only for the last word of the result. If the option **-partial** is *not* specified, an incomplete last word will cause the command to throw an error instead.


**-partial**
: When specified, the parser will accept an incomplete quoted word (i.e., with an opening quote but no matching closing quote), at the end of the *string*, without throwing an error.


The basic shell syntax accepted by this command are unquoted, single- and double-quoted words, separated by whitespace. Leading and trailing whitespace are permitted too, and if present are stripped.

Shell variables in their various forms are *not* recognized, nor are sub-shells.

Here are the recognized forms of words:

**single-quoted word**
: A single-quoted word begins with a single-quote character, i.e. **'** (ASCII 39; U+0027) followed by zero or more unicode characters excluding single-quote, and ending with a single-quote. The word must be followed by either the end of the *string*, or by whitespace. A word cannot directly follow another word with nothing inbetween.

**double-quoted word**
: A double-quoted word begins with a double-quote character, i.e. **"** (ASCII 34; U+0022) followed by zero or more unicode characters excluding double-quote, and ending with a double-quote. Unlike for single-quoted words, double-quotes can be embedded in double-quoted words by escaping them using a backslash character **\\** (ASCII 92; U+005C), e.g., **"…\\"…"**. Similarly, any literal backslash can be embedded by being backslash-escaped, e.g., **"…\\\\…"**.

**unquoted word**
: Unquoted words are not delimited by quotes and thus cannot contain whitespace or single-quote characters. However, double-quote and backslash characters can be put into unquoted words by escaping them as for double-quoted words.

**whitespace**
: Whitespace is any unicode whiespace character, i.e., any character for which [string is space](https://www.tcl-lang.org/man/tcl/TclCmd/string.html) returns **1** (true), or which matches the regular expression **\\\\s**. Whitespace *may* occur before the first word, and after the last word. Whitespace *must* occur between adjacent words.


# Examples

An example of a command line parsed into its constituent words.

```
const CMDLINE "grep --include=*.{tcl,tm,tk} -rl * | grep -v \"The Cloud\""
puts "CMDLINE=«$CMDLINE»"
foreach word [string token shell $CMDLINE] {
    puts "word=«$word»"
}
=>
CMDLINE=«grep --include=*.{tcl,tm,tk} -rl * | grep -v "The Cloud"»
word=«grep»
word=«--include=*.{tcl,tm,tk}»
word=«-rl»
word=«*»
word=«|»
word=«grep»
word=«-v»
word=«The Cloud»
```

An example of the same command line used above, parsed into its constituent words, with tokens and string indices.

```
foreach element [string token shell -indices $CMDLINE] {
    lassign $element token i j word
    puts "token=$token i=$i j=$j word=«$word»"
}
=>
token=PLAIN i=0 j=3 word=«grep»
token=PLAIN i=5 j=27 word=«--include=*.{tcl,tm,tk}»
token=PLAIN i=29 j=31 word=«-rl»
token=PLAIN i=33 j=33 word=«*»
token=PLAIN i=35 j=35 word=«|»
token=PLAIN i=37 j=40 word=«grep»
token=PLAIN i=42 j=43 word=«-v»
token=D:QUOTED i=45 j=55 word=«The Cloud»
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
