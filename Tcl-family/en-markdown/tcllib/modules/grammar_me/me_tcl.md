---
CommandName: grammar::me::tcl
title: grammar::me::tcl
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - grammar
 - parsing
 - virtual machine
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::me::tcl - Virtual machine implementation I for parsing token streams

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::me::tcl]{.lit} [0.2]{.optlit}
[::grammar::me::tcl]{.cmd} [cmd]{.lit} [...]{.arg}
[::grammar::me::tcl]{.cmd} [init]{.lit} [nextcmd]{.arg} [tokmap]{.optarg}
[::grammar::me::tcl]{.cmd} [lc]{.lit} [location]{.arg}
[::grammar::me::tcl]{.cmd} [tok]{.lit} [from]{.arg} [to]{.optarg}
[::grammar::me::tcl]{.cmd} [tokens]{.lit}
[::grammar::me::tcl]{.cmd} [sv]{.lit}
[::grammar::me::tcl]{.cmd} [ast]{.lit}
[::grammar::me::tcl]{.cmd} [astall]{.lit}
[::grammar::me::tcl]{.cmd} [ctok]{.lit}
[::grammar::me::tcl]{.cmd} [nc]{.lit}
[::grammar::me::tcl]{.cmd} [next]{.lit}
[::grammar::me::tcl]{.cmd} [ord]{.lit}
[::grammar::me::tcl::ict\_advance]{.cmd} [message]{.arg}
[::grammar::me::tcl::ict\_match\_token]{.cmd} [tok]{.arg} [message]{.arg}
[::grammar::me::tcl::ict\_match\_tokrange]{.cmd} [tokbegin]{.arg} [tokend]{.arg} [message]{.arg}
[::grammar::me::tcl::ict\_match\_tokclass]{.cmd} [code]{.arg} [message]{.arg}
[::grammar::me::tcl::inc\_restore]{.cmd} [nt]{.arg}
[::grammar::me::tcl::inc\_save]{.cmd} [nt]{.arg} [startlocation]{.arg}
[::grammar::me::tcl::iok\_ok]{.cmd}
[::grammar::me::tcl::iok\_fail]{.cmd}
[::grammar::me::tcl::iok\_negate]{.cmd}
[::grammar::me::tcl::icl\_get]{.cmd}
[::grammar::me::tcl::icl\_rewind]{.cmd} [oldlocation]{.arg}
[::grammar::me::tcl::ier\_get]{.cmd}
[::grammar::me::tcl::ier\_clear]{.cmd}
[::grammar::me::tcl::ier\_nonterminal]{.cmd} [message]{.arg} [location]{.arg}
[::grammar::me::tcl::ier\_merge]{.cmd} [olderror]{.arg}
[::grammar::me::tcl::isv\_clear]{.cmd}
[::grammar::me::tcl::isv\_terminal]{.cmd}
[::grammar::me::tcl::isv\_nonterminal\_leaf]{.cmd} [nt]{.arg} [startlocation]{.arg}
[::grammar::me::tcl::isv\_nonterminal\_range]{.cmd} [nt]{.arg} [startlocation]{.arg}
[::grammar::me::tcl::isv\_nonterminal\_reduce]{.cmd} [nt]{.arg} [startlocation]{.arg} [marker]{.optarg}
[::grammar::me::tcl::ias\_push]{.cmd}
[::grammar::me::tcl::ias\_mark]{.cmd}
[::grammar::me::tcl::ias\_pop2mark]{.cmd} [marker]{.arg}
:::

# Description

This package provides an implementation of the ME virtual machine. Please go and read the document [grammar::me\_intro][me_intro] first if you do not know what a ME virtual machine is.

This implementation is tied very strongly to Tcl. All the stacks in the machine state are handled through the Tcl stack, all control flow is handled by Tcl commands, and the remaining machine instructions are directly mapped to Tcl commands. Especially the matching of nonterminal symbols is handled by Tcl procedures as well, essentially extending the machine implementation with custom instructions.

Further on the implementation handles only a single machine which is uninteruptible during execution and hardwired for pull operation. I.e. it explicitly requests each new token through a callback, pulling them into its state.

A related package is **grammar::peg::interp** which provides a generic interpreter / parser for parsing expression grammars (PEGs), implemented on top of this implementation of the ME virtual machine.

# API

The commands documented in this section do not implement any of the instructions of the ME virtual machine. They provide the facilities for the initialization of the machine and the retrieval of important information.

**::grammar::me::tcl** **cmd** *...*
: This is an ensemble command providing access to the commands listed in this section. See the methods themselves for detailed specifications.

**::grammar::me::tcl** **init** *nextcmd* ?*tokmap*?
: This command (re)initializes the machine. It returns the empty string. This command has to be invoked before any other command of this package.

    The command prefix *nextcmd* represents the input stream of characters and is invoked by the machine whenever the a new character from the stream is required. The instruction for handling this is *ict\_advance*. The callback has to return either the empty list, or a list of 4 elements containing the token, its lexeme attribute, and its location as line number and column index, in this order. The empty list is the signal that the end of the input stream has been reached. The lexeme attribute is stored in the terminal cache, but otherwise not used by the machine.

    The optional dictionary *tokmap* maps from tokens to integer numbers. If present the numbers impose an order on the tokens, which is subsequently used by *ict\_match\_tokrange* to determine if a token is in the specified range or not. If no token map is specified the lexicographic order of th token names will be used instead. This choice is especially asensible when using characters as tokens.

**::grammar::me::tcl** **lc** *location*
: This command converts the location of a token given as offset in the input stream into the associated line number and column index. The result of the command is a 2-element list containing the two values, in the order mentioned in the previous sentence. This allows higher levels to convert the location information found in the error status and the generated AST into more human readable data.

    *Note* that the command is not able to convert locations which have not been reached by the machine yet. In other words, if the machine has read 7 tokens the command is able to convert the offsets **0** to **6**, but nothing beyond that. This also shows that it is not possible to convert offsets which refer to locations before the beginning of the stream.

    After a call of **init** the state used for the conversion is cleared, making further conversions impossible until the machine has read tokens again.

**::grammar::me::tcl** **tok** *from* ?*to*?
: This command returns a Tcl list containing the part of the input stream between the locations *from* and *to* (both inclusive). If *to* is not specified it will default to the value of *from*.

    Each element of the returned list is a list of four elements, the token, its associated lexeme, line number, and column index, in this order. In other words, each element has the same structure as the result of the *nextcmd* callback given to **::grammar::me::tcl::init**

    This command places the same restrictions on its location arguments as **::grammar::me::tcl::lc**.

**::grammar::me::tcl** **tokens**
: This command returns the number of tokens currently known to the ME virtual machine.

**::grammar::me::tcl** **sv**
: This command returns the current semantic value *SV* stored in the machine. This is an abstract syntax tree as specified in the document [grammar::me\_ast][me_ast], section **AST VALUES**.

**::grammar::me::tcl** **ast**
: This method returns the abstract syntax tree currently at the top of the AST stack of the ME virtual machine. This is an abstract syntax tree as specified in the document [grammar::me\_ast][me_ast], section **AST VALUES**.

**::grammar::me::tcl** **astall**
: This method returns the whole stack of abstract syntax trees currently known to the ME virtual machine. Each element of the returned list is an abstract syntax tree as specified in the document [grammar::me\_ast][me_ast], section **AST VALUES**. The top of the stack resides at the end of the list.

**::grammar::me::tcl** **ctok**
: This method returns the current token considered by the ME virtual machine.

**::grammar::me::tcl** **nc**
: This method returns the contents of the nonterminal cache as a dictionary mapping from "**symbol**,**location**" to match information.

**::grammar::me::tcl** **next**
: This method returns the next token callback as specified during initialization of the ME virtual machine.

**::grammar::me::tcl** **ord**
: This method returns a dictionary containing the *tokmap* specified during initialization of the ME virtual machine. **::grammar::me::tcl::ok** This variable contains the current match status *OK*. It is provided as variable instead of a command because that makes access to this information faster, and the speed of access is considered very important here as this information is used constantly to determine the control flow.


# Machine state

Please go and read the document [grammar::me\_vm][me_vm] first for a specification of the basic ME virtual machine and its state.

This implementation manages the state described in that document, except for the stacks minus the AST stack. In other words, location stack, error stack, return stack, and ast marker stack are implicitly managed through standard Tcl scoping, i.e. Tcl variables in procedures, outside of this implementation.

# Machine instructions

Please go and read the document [grammar::me\_vm][me_vm] first for a specification of the basic ME virtual machine and its instruction set.

This implementation maps all instructions to Tcl commands in the namespace "::grammar::me::tcl", except for the stack related commands, nonterminal symbols and control flow. Here we simply list the commands and explain the differences to the specified instructions, if there are any. For their semantics see the aforementioned specification. The machine commands are *not* reachable through the ensemble command **::grammar::me::tcl**.

**::grammar::me::tcl::ict\_advance** *message*
: No changes.

**::grammar::me::tcl::ict\_match\_token** *tok* *message*
: No changes.

**::grammar::me::tcl::ict\_match\_tokrange** *tokbegin* *tokend* *message*
: If, and only if a token map was specified during initialization then the arguments are the numeric representations of the smallest and largest tokens in the range. Otherwise they are the relevant tokens themselves and lexicographic comparison is used.

**::grammar::me::tcl::ict\_match\_tokclass** *code* *message*
: No changes.

**::grammar::me::tcl::inc\_restore** *nt*
: Instead of taking a branchlabel the command returns a boolean value. The result will be **true** if and only if cached information was found. The caller has to perform the appropriate branching.

**::grammar::me::tcl::inc\_save** *nt* *startlocation*
: The command takes the start location as additional argument, as it is managed on the Tcl stack, and not in the machine state.

**icf\_ntcall** *branchlabel*
: see below ...

**icf\_ntreturn**
: These two instructions are not mapped to commands. They are control flow instructions and handled in Tcl.

**::grammar::me::tcl::iok\_ok**
: No changes.

**::grammar::me::tcl::iok\_fail**
: No changes.

**::grammar::me::tcl::iok\_negate**
: No changes.

**icf\_jalways** *branchlabel*
: see below ...

**icf\_jok** *branchlabel*
: see below ...

**icf\_jfail** *branchlabel*
: see below ...

**icf\_halt**
: These four instructions are not mapped to commands. They are control flow instructions and handled in Tcl.

**::grammar::me::tcl::icl\_get**
: This command returns the current location *CL* in the input. It replaces *icl\_push*.

**::grammar::me::tcl::icl\_rewind** *oldlocation*
: The command takes the location as argument as it comes from the Tcl stack, not the machine state.

**icl\_pop**
: Not mapped, the stacks are not managed by the package.

**::grammar::me::tcl::ier\_get**
: This command returns the current error state *ER*. It replaces *ier\_push*.

**::grammar::me::tcl::ier\_clear**
: No changes.

**::grammar::me::tcl::ier\_nonterminal** *message* *location*
: The command takes the location as argument as it comes from the Tcl stack, not the machine state.

**::grammar::me::tcl::ier\_merge** *olderror*
: The command takes the second error state to merge as argument as it comes from the Tcl stack, not the machine state.

**::grammar::me::tcl::isv\_clear**
: No changes.

**::grammar::me::tcl::isv\_terminal**
: No changes.

**::grammar::me::tcl::isv\_nonterminal\_leaf** *nt* *startlocation*
: The command takes the start location as argument as it comes from the Tcl stack, not the machine state.

**::grammar::me::tcl::isv\_nonterminal\_range** *nt* *startlocation*
: The command takes the start location as argument as it comes from the Tcl stack, not the machine state.

**::grammar::me::tcl::isv\_nonterminal\_reduce** *nt* *startlocation* ?*marker*?
: The command takes start location and marker as argument as it comes from the Tcl stack, not the machine state.

**::grammar::me::tcl::ias\_push**
: No changes.

**::grammar::me::tcl::ias\_mark**
: This command returns a marker for the current state of the AST stack *AS*. The marker stack is not managed by the machine.

**::grammar::me::tcl::ias\_pop2mark** *marker*
: The command takes the marker as argument as it comes from the Tcl stack, not the machine state. It replaces *ias\_mpop*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *grammar\_me* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[me_ast]: me_ast.md
[me_intro]: me_intro.md
[me_vm]: me_vm.md
