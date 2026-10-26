---
CommandName: ntextWordBreak
title: ntextWordBreak
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: ntext Word Boundary Detection for the Text Widget
Links:
 - bindtags
 - ntext
 - re_syntax
 - regexp
 - text
Keywords:
 - bindtags
 - re_syntax
 - regexp
 - text
Copyright:
---

# Name

ntextWordBreak - ntext Word Boundary Detection for the Text Widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit}
:::

# Description

The **ntext** package provides a binding tag named *Ntext* for use by text widgets in place of the default *Text* binding tag.

Navigation and selection in a text widget require the detection of words and their boundaries.  The word boundary detection facilities provided by Tcl/Tk through the *Text* binding tag are limited because they define only one class of "word" characters and one class of "non-word" characters.  The *Ntext* binding tag uses more general rules for word boundary detection, that define *two* classes of "word" characters and one class of "non-word" characters.

# Configuration options

The behaviour of *Ntext* may be configured application-wide by setting the values of a number of namespace variables.  One of these is relevant to word boundary detection:

**::ntext::classicWordBreak**

- **0** - (default value) selects *Ntext* behaviour, i.e. platform-independent, two classes of word characters and one class of non-word characters.

- **1** - selects classic *Text* behaviour, i.e. platform-dependent, one class of word characters and one class of non-word characters

- After changing this value, *Ntext* 's regexp matching patterns should be recalculated.  See [Functions] for details and advanced configuration options.


# Advanced use

# Variables (advanced use)

**::ntext::tcl\_match\_wordBreakAfter**

**::ntext::tcl\_match\_wordBreakBefore**

**::ntext::tcl\_match\_endOfWord**

**::ntext::tcl\_match\_startOfNextWord**

**::ntext::tcl\_match\_startOfPreviousWord**

These variables hold the regexp patterns that are used by *Ntext* to search for word boundaries.  If they are changed, subsequent searches are immediately altered.  In many situations, it it unnecessary to alter the values of these variables directly: instead call one of the functions **::ntext::initializeMatchPatterns**, **::ntext::createMatchPatterns**.

In the *Text* binding tag one can change the search rules by changing the values of the global variables **tcl\_wordchars** and **tcl\_nonwordchars**.  The equivalent operation in the *Ntext* binding tag is to call **::ntext::createMatchPatterns** with appropriate arguments.

# Functions (advanced use)

If a simple regexp search should prove insufficient, the following functions (analogous to the Tcl/Tk core's **tcl\_wordBreakAfter** etc) may be replaced by the developer:

**ntext::new\_wordBreakAfter**

**ntext::new\_wordBreakBefore**

**ntext::new\_endOfWord**

**ntext::new\_startOfNextWord**

**ntext::new\_startOfPreviousWord**

# Functions

Each function calculates the five regexp search patterns that define the word boundary searches.  These values are stored in the namespace variables listed above.

**::ntext::initializeMatchPatterns**

- This function is called when *Ntext* is first used, and needs to be called again only if the script changes the value of either **::ntext::classicWordBreak** or **::tcl\_platform(platform)**.  The function is called with no arguments.  It is useful when the desired search patterns are the default patterns for either the *Ntext* or *Text* binding tag, and so are implicitly specified by the values of **::ntext::classicWordBreak** and **::tcl\_platform(platform)** alone.


**::ntext::createMatchPatterns** *new\_nonwordchars* *new\_word1chars* ?new\_word2chars?

- This function is useful in a wider range of situations than **::ntext::initializeMatchPatterns**.  It calculates the regexp search patterns for any case with one class of "non-word" characters and one or two classes of "word" characters.

    Each argument should be a regexp expression defining a class of characters.  An argument will usually be a bracket expression, but might alternatively be a class-shorthand escape, or a single character.  The third argument may be omitted, or supplied as the empty string, in which case it is unused.

    The first argument is interpreted as the class of non-word characters; the second argument (and the third, if present) are classes of word characters.  The classes should include all possible characters and will normally be mutually exclusive: it is often convenient to define one class as the negation of the other two.


# Word boundary matching

The problem of word boundary selection is a vexed one, because text is used to represent a universe of different types of information, and there are no simple rules that are useful for all data types or for all purposes.

*Ntext* attempts to improve on the facilities available in classic *Text* by providing facilities for more complex definitions of words (with three classes of characters instead of two).

*What is a word?  Why two classes of word?*

When using the modified cursor keys <Control-Left> and <Control-Right> to navigate through a *Ntext* widget, the cursor is placed at the start of a word.  A word is defined as a sequence of one or more characters from only one of the two defined "word" classes; it may be preceded by a character from the other "word" class or from the "non-word" class.

The double-click of mouse button 1 selects a word of text, where in this case a "word" may be as defined above, or alternatively may be a sequence of one or more characters from the "non-word" class of characters.

Traditionally Tcl has defined only one word class and one non-word class: on Windows, the non-word class is whitespace, and so alphanumerics and punctuation belong to the same class.  On other platforms, punctuation is bundled with whitespace as "non-word" characters.  In either case, the navigation and selection of text are unnecessarily coarse-grained, and sometimes give unhelpful results.

The use of three classes of characters might make selection too fine-grained; but in this case, holding down the *Shift* key and double-clicking another word is an excellent way to select a longer range of text (a useful binding that Tcl/Tk has long provided but which is missing in other systems).

As well as its defaults, *Ntext* permits the developer to define their own classes of characters, or to revert to the classic *Text* definitions, or to specify their own regexp matching patterns.

# Bugs

This version of **ntext** is intended to be compatible with all releases of **Tk** 8.5, 8.6, and 8.7, and with the branches *core-8-5-branch*, *core-8-6-branch*, and *trunk* in the source code repository for **Tk**.  Any incompatibility with any of these versions, for any **Tk** windowing system, should be reported as a bug. Please report such in the category *ntext* of the [Tklib Trackers](https://core.tcl-lang.org/tklib/reportlist).

# Example

To use *Ntext* with Tcl/Tk's usual word-boundary detection rules:

```
package require ntext
text .t
bindtags .t {.t Ntext . all}
set ::ntext::classicWordBreak 1
::ntext::initializeMatchPatterns
```

See bindtags for more information.

To define a different set of word-boundary detection rules:

```
package require ntext
text .t
bindtags .t {.t Ntext . all}
::ntext::createMatchPatterns  {[[:space:][:cntrl:]]} {[[:punct:]]} {[^[:punct:][:space:][:cntrl:]]}
```

See regexp, re\_syntax for more information.
