---
CommandName: pt::pe::op
title: pt::pe::op
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pt::pe::op - Parsing Expression Utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::pe::op]{.lit} [1.0.2]{.optlit}
[package]{.cmd} [require]{.sub} [pt::pe]{.lit} [1]{.optlit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[::pt::pe::op]{.cmd} [drop]{.lit} [dropset]{.arg} [pe]{.arg}
[::pt::pe::op]{.cmd} [rename]{.lit} [nt]{.arg} [ntnew]{.arg} [pe]{.arg}
[::pt::pe::op]{.cmd} [called]{.lit} [pe]{.arg}
[::pt::pe::op]{.cmd} [flatten]{.lit} [pe]{.arg}
[::pt::pe::op]{.cmd} [fusechars]{.lit} [pe]{.arg}
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package provides additional commands to work with the serializations of parsing expressions as managed by the PEG and related packages, and specified in section [Pe serialization format].

This is an internal package, for use by the higher level packages handling PEGs, their conversion into and out of various other formats, or other uses.

# API

**::pt::pe::op** **drop** *dropset* *pe*
: This command removes all occurences of any of the nonterminals symbols in the set *dropset* from the parsing expression *pe*, and simplifies it. This may result in the expression becoming "epsilon", i.e. matching nothing.

**::pt::pe::op** **rename** *nt* *ntnew* *pe*
: This command renames all occurences of the nonterminal *nt* in the parsing expression *pe* into *ntnew*.

**::pt::pe::op** **called** *pe*
: This command extracts the set of all nonterminal symbols used, i.e. 'called', in the parsing expression *pe*.

**::pt::pe::op** **flatten** *pe*
: This command transforms the parsing expression by eliminating sequences nested in sequences, and choices in choices, lifting the children of the nested expression into the parent. It further eliminates all sequences and choices with only one child, as these are redundant.

    The resulting parsing expression is returned as the result of the command.

**::pt::pe::op** **fusechars** *pe*
: This command transforms the parsing expression by fusing adjacent terminals in sequences and adjacent terminals and ranges in choices, it (re)constructs highlevel *strings* and *character classes*.

    The resulting pseudo-parsing expression is returned as the result of the command and may contain the pseudo-operators **str** for character sequences, aka strings, and **cl** for character choices, aka character classes.

    The result is called a *pseudo-parsing expression* because it is not a true parsing expression anymore, and will fail a check with [::pt::peg verify][pt_peg_container] if the new pseudo-operators are present in the result, but is otherwise of sound structure for a parsing expression. Notably, the commands [::pt::peg bottomup][pt_peg_container] and [::pt::peg topdown][pt_peg_container] will process them without trouble.


# Pe serialization format

Here we specify the format used by the Parser Tools to serialize Parsing Expressions as immutable values for transport, comparison, etc.

We distinguish between *regular* and *canonical* serializations. While a parsing expression may have more than one regular serialization only exactly one of them will be *canonical*.

Regular serialization
: see below ...

    **Atomic Parsing Expressions**
    : 1. The string **epsilon** is an atomic parsing expression. It matches the empty string.

        2. The string **dot** is an atomic parsing expression. It matches any character.

        3. The string **alnum** is an atomic parsing expression. It matches any Unicode alphabet or digit character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        4. The string **alpha** is an atomic parsing expression. It matches any Unicode alphabet character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        5. The string **ascii** is an atomic parsing expression. It matches any Unicode character below U0080. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        6. The string **control** is an atomic parsing expression. It matches any Unicode control character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        7. The string **digit** is an atomic parsing expression. It matches any Unicode digit character. Note that this includes characters outside of the \[0..9\] range. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        8. The string **graph** is an atomic parsing expression. It matches any Unicode printing character, except for space. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        9. The string **lower** is an atomic parsing expression. It matches any Unicode lower-case alphabet character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        10. The string **print** is an atomic parsing expression. It matches any Unicode printing character, including space. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        11. The string **punct** is an atomic parsing expression. It matches any Unicode punctuation character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        12. The string **space** is an atomic parsing expression. It matches any Unicode space character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        13. The string **upper** is an atomic parsing expression. It matches any Unicode upper-case alphabet character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        14. The string **wordchar** is an atomic parsing expression. It matches any Unicode word character. This is any alphanumeric character (see alnum), and any connector punctuation characters (e.g. underscore). This is a custom extension of PEs based on Tcl's builtin command **string is**.

        15. The string **xdigit** is an atomic parsing expression. It matches any hexadecimal digit character. This is a custom extension of PEs based on Tcl's builtin command **string is**.

        16. The string **ddigit** is an atomic parsing expression. It matches any decimal digit character. This is a custom extension of PEs based on Tcl's builtin command **regexp**.

        17. The expression \[list t **x**\] is an atomic parsing expression. It matches the terminal string **x**.

        18. The expression \[list n **A**\] is an atomic parsing expression. It matches the nonterminal **A**.


    **Combined Parsing Expressions**
    : 1. For parsing expressions **e1**, **e2**, ... the result of \[list / **e1** **e2** ... \] is a parsing expression as well. This is the *ordered choice*, aka *prioritized choice*.

        2. For parsing expressions **e1**, **e2**, ... the result of \[list x **e1** **e2** ... \] is a parsing expression as well. This is the *sequence*.

        3. For a parsing expression **e** the result of \[list \* **e**\] is a parsing expression as well. This is the *kleene closure*, describing zero or more repetitions.

        4. For a parsing expression **e** the result of \[list + **e**\] is a parsing expression as well. This is the *positive kleene closure*, describing one or more repetitions.

        5. For a parsing expression **e** the result of \[list & **e**\] is a parsing expression as well. This is the *and lookahead predicate*.

        6. For a parsing expression **e** the result of \[list ! **e**\] is a parsing expression as well. This is the *not lookahead predicate*.

        7. For a parsing expression **e** the result of \[list ? **e**\] is a parsing expression as well. This is the *optional input*.



Canonical serialization
: The canonical serialization of a parsing expression has the format as specified in the previous item, and then additionally satisfies the constraints below, which make it unique among all the possible serializations of this parsing expression.

    1. The string representation of the value is the canonical representation of a pure Tcl list. I.e. it does not contain superfluous whitespace.

    2. Terminals are *not* encoded as ranges (where start and end of the range are identical).



## Example

Assuming the parsing expression shown on the right-hand side of the rule

```
    Expression <- Term (AddOp Term)*
```

then its canonical serialization (except for whitespace) is

```
    {x {n Term} {* {x {n AddOp} {n Term}}}}
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *pt* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Parsing and Grammars

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[pt_peg_container]: pt_peg_container.md
