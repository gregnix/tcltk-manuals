---
CommandName: stringprep
title: stringprep
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Preparation of Internationalized Strings
Links:
 - unicode(n)
Keywords:
 - stringprep
 - unicode
Copyright:
 - Copyright (c) 2007-2009, Sergei Golovan <sgolovan@nes.ru>
---

# Name

stringprep - Implementation of stringprep

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [stringprep]{.lit} [1.0.3]{.lit}
[::stringprep::register]{.cmd} [profile]{.arg} [-mapping list]{.optarg} [-normalization form]{.optarg} [-prohibited list]{.optarg} [-prohibitedList list]{.optarg} [-prohibitedCommand command]{.optarg} [-prohibitedBidi boolean]{.optarg}
[::stringprep::stringprep]{.cmd} [profile]{.arg} [string]{.arg}
[::stringprep::compare]{.cmd} [profile]{.arg} [string1]{.arg} [string2]{.arg}
:::

# Description

This is a Tcl implementation of the Preparation of Internationalized Strings (“stringprep”). It supports the definition of stringprep profiles and their use to prepare Unicode strings for comparisons as defined in [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454).

*Note that RFC 3454 (2002) was superceded by RFC 7564 (2015), which itself was superceded by* [RFC 8264](https://www.rfc-editor.org/rfc/rfc8264) *(2017).*

*This package is currently unmaintained; see* [ticket](https://core.tcl-lang.org/tcllib/tktview/b192bd4149e07ddf4e000f894100700c2ec35e1e).

# API

If the only string preparation needed is Unicode normalization, the **unicode** package’s commands are sufficient.

**::stringprep::register** *profile* ?*-mapping list*? ?*-normalization form*? ?*-prohibited list*? ?*-prohibitedList list*? ?*-prohibitedCommand command*? ?*-prohibitedBidi boolean*?
: Register a **stringprep** profile called *profile* that will apply the specified options.

    **-mapping** *list*
    : This option specifies **stringprep** mapping tables. The tables are those specified in [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454)’s Appendix B. The usual list values are {B.1 B.2} or {B.1 B.3} where B.1 contains characters which commonly map to nothing, B.2 is used in profiles with unicode normalization form KC, and B.3 specifies case folding. The default is an empty list which means no mapping.

    **-normalization** *form*
    : This option specifies which normalization form to apply. The *form* is a string which may be any of "D", "C", "KD", or "KC". Note that formally, [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454) supports either no normalization or "KC". The default is no normalization.

    **-prohibited** *list*
    : This option specifies a list of [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454) tables with prohibited characters. For example, the list from [RFC 3491](https://www.rfc-editor.org/rfc/rfc3491) is {A.1 C.1.2 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}. Formally, [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454) allows prohibiting either all the tables from C.3 to C.9, or none of them. The default is to to prohibit none of them.

    **-prohibitedList** *list*
    : This option specifies a list of prohibited characters as Unicode code points. For example to prohibit the characters **" & ' / : < > @**, provide a list of their code points: {0x22 0x26 0x27 0x2F 0x3A 0x3C 0x3E 0x40}. The default is an empty list. (If these are specified they are in addition to any prohibited by the *-prohibited* option.)

    **-prohibitedCommand** *command*
    : This option specifies a *command* to be called with a unicode code point whenever a character is mapped and normalized. If the *command* returns **1** (true), then the character is treated as prohibited. A return value of **0** (false) ensures normal processing. This option is a useful alternative to providing a very large list to the *-prohibitedList* option. The default is no command.

    **-prohibitedBidi** *boolean*
    : If this option is specified and passed nonzero (e.g., **1**; true), then the bidirectional character processing rules defined in [RFC 3454](https://www.rfc-editor.org/rfc/rfc3454)’s section 6 are used. The default is not to use the bidirectional rules.


**::stringprep::stringprep** *profile* *string*
: Returns a possibly modified copy of *string* based on the given *profile*; or throws an error.

    The possible errors are: *invalid\_profile*—the given *profile* is not defined; *prohibited\_character*—the given *string* contains a prohibited character; *prohibited\_bidi*—the given *string* contains a prohibited bidirectional sequence.

**::stringprep::compare** *profile* *string1* *string2*
: Performs a comparison of the two given strings by comparing the result of string-preparing each of them in accordance with the given *profile*. Returns **0** if the strings are equal (in terms of the given *profile*), or **-1** if *string1* is lexicographically less than *string2*, or **1** if *string1* is lexicographically greater than *string2*.


# Examples

This example shows how to use **stringprep** to compare strings.

```
::stringprep::register basicprep -mapping {B.1 B.2} -normalization KC
# Three poor UTF-8 byte sequences (to illustrate stringprep, not to use in practice):
const EACUTE [encoding convertfrom utf-8 \x65\xCC\x81]
const ANGSTROM [encoding convertfrom utf-8 \xE2\x84\xAB]
const ODOTS [encoding convertfrom utf-8 \x6F\xCC\x88]
const A "Caf${EACUTE} ${ANGSTROM}ngstr${ODOTS}m"
# Best to either use a UTF-8-savvy editor:
const B "Café Ångström"
# Or to use Tcl’s Unicode escapes:
const C "Caf\u00E9 \u212Bngstr\u00F6m"

puts "A '$A' hex: [binary encode hex [encoding convertto utf-8 $A]]"
puts "B '$B' hex: [binary encode hex [encoding convertto utf-8 $B]]"
puts "C '$C' hex: [binary encode hex [encoding convertto utf-8 $C]]"
puts "string compare \$A \$B → [expr {[string compare $A $B] ? "unequal" : "equal"}]"
puts "string compare \$A \$C → [expr {[string compare $A $C] ? "unequal" : "equal"}]"
puts "stringprep::compare basicprep \$A \$B → [expr {[stringprep::compare basicprep $A $B] ? "unequal" : "equal"}]"
puts "stringprep::compare basicprep \$A \$C → [expr {[stringprep::compare basicprep $A $C] ? "unequal" : "equal"}]"
=>
A 'Café Ångström' hex: 43616665cc8120e284ab6e677374726fcc886d
B 'Café Ångström' hex: 436166c3a920c3856e67737472c3b66d
C 'Café Ångström' hex: 436166c3a920e284ab6e67737472c3b66d
string compare $A $B → unequal
string compare $A $C → unequal
stringprep::compare basicprep $A $B → equal
stringprep::compare basicprep $A $C → equal
```

## Legacy examples

Nameprep profile definition (see [RFC 3491](https://www.rfc-editor.org/rfc/rfc3491)).

```
::stringprep::register nameprep  -mapping {B.1 B.2}  -normalization KC  -prohibited {A.1 C.1.2 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}  -prohibitedBidi 1
```

Nodeprep and resourceprep profile definitions (see [RFC 3920](https://www.rfc-editor.org/rfc/rfc3920)).

```
::stringprep::register nodeprep  -mapping {B.1 B.2}  -normalization KC  -prohibited {A.1 C.1.1 C.1.2 C.2.1 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}  -prohibitedList {0x22 0x26 0x27 0x2f 0x3a 0x3c 0x3e 0x40}  -prohibitedBidi 1

::stringprep::register resourceprep  -mapping {B.1}  -normalization KC  -prohibited {A.1 C.1.2 C.2.1 C.2.2 C.3 C.4 C.5 C.6 C.7 C.8 C.9}  -prohibitedBidi 1
```

# Authors

Sergei Golovan

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *stringprep* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Copyright

```
Copyright (c) 2007-2009, Sergei Golovan <sgolovan@nes.ru>
```
