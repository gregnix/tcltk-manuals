---
CommandName: pt::pgen
ManualSection: n
Version: 1.2
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

pt::pgen - Parser Generator

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::pgen]{.lit} [1.2]{.optlit} 
[::pt::pgen]{.cmd} [inputformat]{.arg} [text]{.arg} [resultformat]{.arg} [options]{.optdot} 
:::

# Description

Are you lost ? Do you have trouble understanding this document ? In that case please read the overview provided by the *Introduction to Parser Tools*. This document is the entrypoint to the whole system the current package is a part of.

This package provides a command implementing a *parser generator* taking parsing expression grammars as input.

It is the implementation of method **generate** of **pt**, the *Parser Tools Application*.

As such the intended audience of this document are people wishing to modify and/or extend this part of **pt**'s functionality. Users of **pt** on the other hand are hereby refered to the applications' manpage, i.e. *Parser Tools Application*.

It resides in the User Package Layer of Parser Tools.

IMAGE: arch_user_pkg

# Api

**::pt::pgen** *inputformat* *text* *resultformat* ?*options...*?
: This command takes the parsing expression grammar in *text* (in the format specified by *inputformat*), and returns the same grammar in the format *resultformat* as the result of the command. The two known input formats are **peg** and **json**. Introductions to them, including their formal specifications, can be found in the *PEG Language Tutorial* and *The JSON Grammar Exchange Format*. The packages used to parse these formats are


**peg**
: **pt::peg::from::peg**

**json**
: **pt::peg::from::json**


On the output side the known formats, and the packages used to generate them are

**c**
: **pt::peg::to::cparam**

**container**
: **pt::peg::to::container**

**critcl**
: **pt::peg::to::cparam** + **pt::cparam::configuration::critcl**

**json**
: **pt::peg::to::json**

**oo**
: **pt::peg::to::tclparam** + **pt::tclparam::configuration::tcloo**

**peg**
: **pt::peg::to::peg**

**snit**
: **pt::peg::to::tclparam** + **pt::tclparam::configuration::snit**


: The options supported by each of these formats are documented with their respective packages.


# Example

In this section we are working a complete example, starting with a PEG grammar and ending with running the parser generated from it over some input, following the outline shown in the figure below:

IMAGE: flow

Our grammar, assumed to the stored in the file "*calculator.peg*" is

```
PEG calculator (Expression)
    Digit      <- '0'/'1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'       ;
    Sign       <- '-' / '+'                                     ;
    Number     <- Sign? Digit+                                  ;
    Expression <- Term (AddOp Term)*                            ;
    MulOp      <- '*' / '/'                                     ;
    Term       <- Factor (MulOp Factor)*                        ;
    AddOp      <- '+'/'-'                                       ;
    Factor     <- '(' Expression ')' / Number                   ;
END;
```

From this we create a snit-based parser using the script "*gen*"

```
package require Tcl 8.5
package require fileutil
package require pt::pgen

lassign $argv name
set grammar [fileutil::cat $name.peg]
set pclass  [pt::pgen peg $gr snit -class $name -file  $name.peg -name  $name]
fileutil::writeFile $name.tcl $pclass
exit 0
```

calling it like

```
 tclsh8.5 gen calculator
```

which leaves us with the parser package and class written to the file "*calculator.tcl*". Assuming that this package is then properly installed in a place where Tcl can find it we can now use this class via a script like

```
    package require calculator

    lassign $argv input
    set channel [open $input r]

    set parser [calculator]
    set ast [$parser parse $channel]
    $parser destroy
    close $channel

    ... now process the returned abstract syntax tree ...
```

where the abstract syntax tree stored in the variable will look like

```
set ast {Expression 0 4
    {Factor 0 4
        {Term 0 2
            {Number 0 2
                {Digit 0 0}
                {Digit 1 1}
                {Digit 2 2}
            }
        }
        {AddOp 3 3}
        {Term 4 4
            {Number 4 4
                {Digit 4 4}
            }
        }
    }
}
```

assuming that the input file and channel contained the text

```
 120+5
```

A more graphical representation of the tree would be

```
+- Digit 0 0 | 1
|            |
+- Term 0 2 --- Number 0 2 -+- Digit 1 1 | 2
|                           |            |
|                           +- Digit 2 2 | 0
|                                        |
Expression 0 4 --- Factor 0 4 -+----------------------------- AddOp 3 3 | +
|                                        |
+- Term 4 4 --- Number 4 4 --- Digit 4 4 | 5
```

Regardless, at this point it is the user's responsibility to work with the tree to reach whatever goal she desires. I.e. analyze it, transform it, etc. The package **pt::ast** should be of help here, providing commands to walk such ASTs structures in various ways.

One important thing to note is that the parsers used here return a data structure representing the structure of the input per the grammar underlying the parser. There are *no* callbacks during the parsing process, i.e. no *parsing actions*, as most other parsers will have.

Going back to the last snippet of code, the execution of the parser for some input, note how the parser instance follows the specified *Parser API*.

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
