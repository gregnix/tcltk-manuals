---
CommandName: grammar::me::cpu
title: grammar::me::cpu
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Grammar operations and usage
Keywords:
 - grammar
 - parsing
 - virtual machine
Copyright:
 - Copyright (c) 2005-2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

grammar::me::cpu - Virtual machine implementation II for parsing token streams

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::me::cpu]{.lit} [0.3]{.optlit}
[::grammar::me::cpu]{.cmd} [meName]{.arg} [matchcode]{.arg}
[meName]{.cmd} [option]{.lit} [arg arg]{.optdot}
[meName]{.ins} [lc]{.sub} [location]{.arg}
[meName]{.ins} [tok]{.sub} [from ?to]{.optarg}
[meName]{.ins} [pc]{.sub} [state]{.arg}
[meName]{.ins} [iseof]{.sub} [state]{.arg}
[meName]{.ins} [at]{.sub} [state]{.arg}
[meName]{.ins} [cc]{.sub} [state]{.arg}
[meName]{.ins} [sv]{.sub}
[meName]{.ins} [ok]{.sub}
[meName]{.ins} [error]{.sub}
[meName]{.ins} [lstk]{.sub} [state]{.arg}
[meName]{.ins} [astk]{.sub} [state]{.arg}
[meName]{.ins} [mstk]{.sub} [state]{.arg}
[meName]{.ins} [estk]{.sub} [state]{.arg}
[meName]{.ins} [rstk]{.sub} [state]{.arg}
[meName]{.ins} [nc]{.sub} [state]{.arg}
[meName]{.ins} [ast]{.sub}
[meName]{.ins} [halted]{.sub}
[meName]{.ins} [code]{.sub}
[meName]{.ins} [eof]{.sub}
[meName]{.ins} [put]{.sub} [tok]{.arg} [lex]{.arg} [line]{.arg} [col]{.arg}
[meName]{.ins} [putstring]{.sub} [string]{.arg} [lvar]{.arg} [cvar]{.arg}
[meName]{.ins} [run]{.sub} [n]{.optarg}
[meName]{.ins} [pull]{.sub} [nextcmd]{.arg}
[meName]{.ins} [reset]{.sub}
[meName]{.ins} [destroy]{.sub}
:::

# Description

This package provides an implementation of the ME virtual machine. Please go and read the document [grammar::me\_intro][me_intro] first if you do not know what a ME virtual machine is.

This implementation provides an object-based API and the machines are not truly tied to Tcl. A C implementation of the same API is quite possible.

Internally the package actually uses the value-based machine manipulation commands as provided by the package **grammar::me::cpu::core** to perform its duties.

# API

## Class API

The package directly provides only a single command for the construction of ME virtual machines.

**::grammar::me::cpu** *meName* *matchcode*
: The command creates a new ME machine object with an associated global Tcl command whose name is *meName*. This command may be used to invoke various operations on the machine. It has the following general form:

    **meName** **option** ?*arg arg ...*?
    : *Option* and the *arg*s determine the exact behavior of the command.


    The argument *matchcode* contains the match instructions the machine has to execute while parsing the input stream. Please read section **MATCH CODE REPRESENTATION** of the documentation for the package **grammar::me::cpu::core** for the specification of the structure of this value.

    The *tokmap* argument taken by the implementation provided by the package **grammar::me::tcl** is here hidden inside of the match instructions and therefore not needed.


## Object API

All ME virtual machine objects created by the class command specified in section [Class API] support the methods listed below.

The machines provided by this package provide methods for operation in both push- and pull-styles. Push-style means that tokens are pushed into the machine state when they arrive, triggering further execution until they are consumed. In other words, this allows the machine to be suspended and resumed at will and an arbitrary number of times, the quasi-parallel operation of several machines, and the operation as part of the event loop.

*meName* **lc** *location*
: This method converts the location of a token given as offset in the input stream into the associated line number and column index. The result of the command is a 2-element list containing the two values, in the order mentioned in the previous sentence. This allows higher levels to convert the location information found in the error status and the generated AST into more human readable data.

    *Note* that the command is not able to convert locations which have not been reached by the machine yet. In other words, if the machine has read 7 tokens the command is able to convert the offsets **0** to **6**, but nothing beyond that. This also shows that it is not possible to convert offsets which refer to locations before the beginning of the stream.

*meName* **tok** ?*from* ?*to*??
: This method returns a Tcl list containing the part of the input stream between the locations *from* and *to* (both inclusive). If *to* is not specified it will default to the value of *from*. If *from* is not specified either the whole input stream is returned.

    Each element of the returned list is a list of four elements, the token, its associated lexeme, line number, and column index, in this order. This command places the same restrictions on its location arguments as the method **lc**.

*meName* **pc** *state*
: This method takes the state value of a ME virtual machine and returns the current value of the stored program counter.

*meName* **iseof** *state*
: This method takes the state value of a ME virtual machine and returns the current value of the stored eof flag.

*meName* **at** *state*
: This method takes the state value of a ME virtual machine and returns the current location in the input stream.

*meName* **cc** *state*
: This method takes the state value of a ME virtual machine and returns the current token.

*meName* **sv**
: This command returns the current semantic value *SV* stored in the machine. This is an abstract syntax tree as specified in the document [grammar::me\_ast][me_ast], section **AST VALUES**.

*meName* **ok**
: This method returns the current match status *OK*.

*meName* **error**
: This method returns the current error status *ER*.

*meName* **lstk** *state*
: This method takes the state value of a ME virtual machine and returns the location stack.

*meName* **astk** *state*
: This method takes the state value of a ME virtual machine and returns the AST stack.

*meName* **mstk** *state*
: This method takes the state value of a ME virtual machine and returns the AST marker stack.

*meName* **estk** *state*
: This method takes the state value of a ME virtual machine and returns the error stack.

*meName* **rstk** *state*
: This method takes the state value of a ME virtual machine and returns the subroutine return stack.

*meName* **nc** *state*
: This method takes the state value of a ME virtual machine and returns the nonterminal match cache as a dictionary.

*meName* **ast**
: This method returns the current top entry of the AST stack *AS*. This is an abstract syntax tree as specified in the document [grammar::me\_ast][me_ast], section **AST VALUES**.

*meName* **halted**
: This method returns a boolean value telling the caller whether the engine has halted execution or not. Halt means that no further matching is possible, and the information retrieved via the other method is final. Attempts to **run** the engine will be ignored, until a **reset** is made.

*meName* **code**
: This method returns the *code* information used to construct the object. In other words, the match program executed by the machine.

*meName* **eof**
: This method adds an end of file marker to the end of the input stream. This signals the machine that the current contents of the input queue are the final parts of the input and nothing will come after. Attempts to put more characters into the queue will fail.

*meName* **put** *tok* *lex* *line* *col*
: This method adds the token *tok* to the end of the input stream, with associated lexeme data *lex* and *line*/*col*umn information.

*meName* **putstring** *string* *lvar* *cvar*
: This method adds each individual character in the *string* as a token to the end of the input stream, from first to last. The lexemes will be empty and the line/col information is computed based on the characters encountered and the data in the variables *lvar* and *cvar*.

*meName* **run** ?*n*?
: This methods causes the engine to execute match instructions until either

    - *n* instructions have been executed, or

    - a halt instruction was executed, or

    - the input queue is empty and the code is asking for more tokens to process.


    If no limit *n* was set only the last two conditions are checked for.

*meName* **pull** *nextcmd*
: This method implements pull-style operation of the machine. It causes it to execute match instructions until either a halt instruction is reached, or the command prefix *nextcmd* ceases to deliver more tokens.

    The command prefix *nextcmd* represents the input stream of characters and is invoked by the machine whenever the a new character from the stream is required. The instruction for handling this is *ict\_advance*. The callback has to return either the empty list, or a list of 4 elements containing the token, its lexeme attribute, and its location as line number and column index, in this order. The empty list is the signal that the end of the input stream has been reached. The lexeme attribute is stored in the terminal cache, but otherwise not used by the machine.

    The end of the input stream for this method does not imply that method **eof** is called for the machine as a whole. By avoiding this and still asking for an explicit call of the method it is possible to mix push- and pull-style operation during the lifetime of the machine.

*meName* **reset**
: This method resets the machine to its initial state, discarding any state it may have.

*meName* **destroy**
: This method deletes the object and releases all resurces it claimed.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *grammar\_me* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Grammars and finite automata

# Copyright

```
Copyright (c) 2005-2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[me_ast]: me_ast.md
[me_intro]: me_intro.md
