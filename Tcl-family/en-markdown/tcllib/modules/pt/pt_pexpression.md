---
CommandName: pt::pe
title: pt::pe
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

pt::pe - Parsing Expression Serialization

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::pe]{.lit} [1.0.2]{.optlit}
[package]{.cmd} [require]{.sub} [char]{.lit}
[::pt::pe]{.cmd} [verify]{.lit} [serial]{.arg} [canonvar]{.optarg}
[::pt::pe]{.cmd} [verify-as-canonical]{.lit} [serial]{.arg}
[::pt::pe]{.cmd} [canonicalize]{.lit} [serial]{.arg}
[::pt::pe]{.cmd} [print]{.lit} [serial]{.arg}
[::pt::pe]{.cmd} [bottomup]{.lit} [cmdprefix]{.arg} [pe]{.arg}
[cmdprefix]{.cmd} [pe]{.arg} [op]{.arg} [arguments]{.arg}
[::pt::pe]{.cmd} [topdown]{.lit} [cmdprefix]{.arg} [pe]{.arg}
[::pt::pe]{.cmd} [equal]{.lit} [seriala]{.arg} [serialb]{.arg}
[::pt::pe]{.cmd} [epsilon]{.lit}
[::pt::pe]{.cmd} [dot]{.lit}
[::pt::pe]{.cmd} [alnum]{.lit}
[::pt::pe]{.cmd} [alpha]{.lit}
[::pt::pe]{.cmd} [ascii]{.lit}
[::pt::pe]{.cmd} [control]{.lit}
[::pt::pe]{.cmd} [digit]{.lit}
[::pt::pe]{.cmd} [graph]{.lit}
[::pt::pe]{.cmd} [lower]{.lit}
[::pt::pe]{.cmd} [print]{.lit}
[::pt::pe]{.cmd} [punct]{.lit}
[::pt::pe]{.cmd} [space]{.lit}
[::pt::pe]{.cmd} [upper]{.lit}
[::pt::pe]{.cmd} [wordchar]{.lit}
[::pt::pe]{.cmd} [xdigit]{.lit}
[::pt::pe]{.cmd} [ddigit]{.lit}
[::pt::pe]{.cmd} [terminal]{.lit} [t]{.arg}
[::pt::pe]{.cmd} [range]{.lit} [ta]{.arg} [tb]{.arg}
[::pt::pe]{.cmd} [nonterminal]{.lit} [nt]{.arg}
[::pt::pe]{.cmd} [choice]{.lit} [pe...]{.arg}
[::pt::pe]{.cmd} [sequence]{.lit} [pe...]{.arg}
[::pt::pe]{.cmd} [repeat0]{.lit} [pe]{.arg}
[::pt::pe]{.cmd} [repeat1]{.lit} [pe]{.arg}
[::pt::pe]{.cmd} [optional]{.lit} [pe]{.arg}
[::pt::pe]{.cmd} [ahead]{.lit} [pe]{.arg}
[::pt::pe]{.cmd} [notahead]{.lit} [pe]{.arg}
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package provides commands to work with the serializations of parsing expressions as managed by the Parser Tools, and specified in section [Pe serialization format].

This is a supporting package in the Core Layer of Parser Tools.

IMAGE: arch\_core\_support

# API

**::pt::pe** **verify** *serial* ?*canonvar*?
: This command verifies that the content of *serial* is a valid serialization of a parsing expression and will throw an error if that is not the case. The result of the command is the empty string.

    If the argument *canonvar* is specified it is interpreted as the name of a variable in the calling context. This variable will be written to if and only if *serial* is a valid regular serialization. Its value will be a boolean, with **True** indicating that the serialization is not only valid, but also *canonical*. **False** will be written for a valid, but non-canonical serialization.

    For the specification of serializations see the section [Pe serialization format].

**::pt::pe** **verify-as-canonical** *serial*
: This command verifies that the content of *serial* is a valid *canonical* serialization of a parsing expression and will throw an error if that is not the case. The result of the command is the empty string.

    For the specification of canonical serializations see the section [Pe serialization format].

**::pt::pe** **canonicalize** *serial*
: This command assumes that the content of *serial* is a valid *regular* serialization of a parsing expression and will throw an error if that is not the case.

    It will then convert the input into the *canonical* serialization of this parsing expression and return it as its result. If the input is already canonical it will be returned unchanged.

    For the specification of regular and canonical serializations see the section [Pe serialization format].

**::pt::pe** **print** *serial*
: This command assumes that the argument *serial* contains a valid serialization of a parsing expression and returns a string containing that PE in a human readable form.

    The exact format of this form is not specified and cannot be relied on for parsing or other machine-based activities.

    For the specification of serializations see the section [Pe serialization format].

**::pt::pe** **bottomup** *cmdprefix* *pe*
: This command walks the parsing expression *pe* from the bottom up to the root, invoking the command prefix *cmdprefix* for each partial expression. This implies that the children of a parsing expression PE are handled before PE.

    The command prefix has the signature

    **cmdprefix** *pe* *op* *arguments*
    : I.e. it is invoked with the parsing expression *pe* the walk is currently at, the *op*'erator in the *pe*, and the operator's *arguments*.

        The result returned by the command prefix replaces *pe* in the parsing expression it was a child of, allowing transformations of the expression tree.

        This also means that for all inner parsing expressions the contents of *arguments* are the results of the command prefix invoked for the children of this inner parsing expression.


**::pt::pe** **topdown** *cmdprefix* *pe*
: This command walks the parsing expression *pe* from the root down to the leaves, invoking the command prefix *cmdprefix* for each partial expression. This implies that the children of a parsing expression PE are handled after PE.

    The command prefix has the same signature as for **bottomup**, see above.

    The result returned by the command prefix is *ignored*.

**::pt::pe** **equal** *seriala* *serialb*
: This command tests the two parsing expressions *seriala* and *serialb* for structural equality. The result of the command is a boolean value. It will be set to **true** if the expressions are identical, and **false** otherwise.

    String equality is usable only if we can assume that the two parsing expressions are pure Tcl lists.

**::pt::pe** **epsilon**
: This command constructs the atomic parsing expression for epsilon.

**::pt::pe** **dot**
: This command constructs the atomic parsing expression for dot.

**::pt::pe** **alnum**
: This command constructs the atomic parsing expression for alnum.

**::pt::pe** **alpha**
: This command constructs the atomic parsing expression for alpha.

**::pt::pe** **ascii**
: This command constructs the atomic parsing expression for ascii.

**::pt::pe** **control**
: This command constructs the atomic parsing expression for control.

**::pt::pe** **digit**
: This command constructs the atomic parsing expression for digit.

**::pt::pe** **graph**
: This command constructs the atomic parsing expression for graph.

**::pt::pe** **lower**
: This command constructs the atomic parsing expression for lower.

**::pt::pe** **print**
: This command constructs the atomic parsing expression for print.

**::pt::pe** **punct**
: This command constructs the atomic parsing expression for punct.

**::pt::pe** **space**
: This command constructs the atomic parsing expression for space.

**::pt::pe** **upper**
: This command constructs the atomic parsing expression for upper.

**::pt::pe** **wordchar**
: This command constructs the atomic parsing expression for wordchar.

**::pt::pe** **xdigit**
: This command constructs the atomic parsing expression for xdigit.

**::pt::pe** **ddigit**
: This command constructs the atomic parsing expression for ddigit.

**::pt::pe** **terminal** *t*
: This command constructs the atomic parsing expression for the terminal symbol *t*.

**::pt::pe** **range** *ta* *tb*
: This command constructs the atomic parsing expression for the range of terminal symbols *ta* ... *tb*.

**::pt::pe** **nonterminal** *nt*
: This command constructs the atomic parsing expression for the nonterminal symbol *nt*.

**::pt::pe** **choice** *pe*...
: This command constructs the parsing expression representing the ordered or prioritized choice between the argument parsing expressions. The first argument has the highest priority.

**::pt::pe** **sequence** *pe*...
: This command constructs the parsing expression representing the sequence of the argument parsing expression. The first argument is the first element of the sequence.

**::pt::pe** **repeat0** *pe*
: This command constructs the parsing expression representing the zero or more repetition of the argument parsing expression *pe*, also known as the kleene closure.

**::pt::pe** **repeat1** *pe*
: This command constructs the parsing expression representing the one or more repetition of the argument parsing expression *pe*, also known as the positive kleene closure.

**::pt::pe** **optional** *pe*
: This command constructs the parsing expression representing the optionality of the argument parsing expression *pe*.

**::pt::pe** **ahead** *pe*
: This command constructs the parsing expression representing the positive lookahead of the argument parsing expression *pe*.

**::pt::pe** **notahead** *pe*
: This command constructs the parsing expression representing the negative lookahead of the argument parsing expression *pe*.


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
