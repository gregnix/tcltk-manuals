---
CommandName: textutil::expander
title: textutil::expander
ManualSection: n
Version: 1.3.2
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - http://www.wjduquette.com/expand
 - regexp
 - split
 - string
Keywords:
 - string
 - template processing
 - text expansion
Copyright:
 - Copyright (c) William H. Duquette https://github.com/wjduquette
---

# Name

textutil::expander - Procedures to process templates and expand text.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::expander]{.lit} [1.3.2]{.optlit}
[::textutil::expander]{.cmd} [expanderName]{.arg}
[expanderName]{.ins} [cappend]{.sub} [text]{.arg}
[expanderName]{.ins} [cget]{.sub} [varname]{.arg}
[expanderName]{.ins} [cis]{.sub} [cname]{.arg}
[expanderName]{.ins} [cname]{.sub}
[expanderName]{.ins} [cpop]{.sub} [cname]{.arg}
[expanderName]{.ins} [ctopandclear]{.sub}
[expanderName]{.ins} [cpush]{.sub} [cname]{.arg}
[expanderName]{.ins} [cset]{.sub} [varname]{.arg} [value]{.arg}
[expanderName]{.ins} [cvar]{.sub} [varname]{.arg}
[expanderName]{.ins} [errmode]{.sub} [newErrmode]{.arg}
[expanderName]{.ins} [evalcmd]{.sub} [newEvalCmd]{.optarg}
[expanderName]{.ins} [expand]{.sub} [string]{.arg} [brackets]{.optarg}
[expanderName]{.ins} [lb]{.sub} [newbracket]{.optarg}
[expanderName]{.ins} [rb]{.sub} [newbracket]{.optarg}
[expanderName]{.ins} [reset]{.sub}
[expanderName]{.ins} [setbrackets]{.sub} [lbrack]{.arg} [rbrack]{.arg}
[expanderName]{.ins} [textcmd]{.sub} [newTextCmd]{.optarg}
[expanderName]{.ins} [where]{.sub}
:::

# Description

The **textutil::expander** package provides a string templating facility that is more powerful and flexible than using the built-in [subst](https://www.tcl-lang.org/man/tcl/TclCmd/subst.html) command.

See the [Tutorial] section to learn the package, and the [API] section for the complete details.

# Expander vs. subst

The Tcl **subst** command is often used to support a kind of template processing. Given a string with embedded variables or function calls, **subst** will interpolate the variable and function values, returning the new string:

```
    % set greeting "Howdy"
    Howdy
    % proc place {} {return "World"}
    % subst {$greeting, [place]!}
    Howdy, World!
    %
```

By defining a suitable set of Tcl commands, **subst** can be used to implement a markup language similar to HTML.

The **subst** command is efficient, but it has three drawbacks for this kind of template processing:

- There’s no way to identify and process the plain text between two embedded Tcl commands; that makes it difficult to handle plain text in a context-sensitive way.

- Embedded commands are necessarily bracketed by **\[** and **\]**; it’s convenient to be able to choose different brackets in special cases.  Someone producing web pages that include a large quantity of Tcl code examples might easily prefer to use **<<** and **>>** as the embedded code delimiters instead.

- There’s no easy way to handle incremental input, as one might wish to do when reading data from a socket.


At present, expander solves the first two problems.

The following section describes the command API to the expander; this is followed by the tutorial sections, see [Tutorial].

# API

The **textutil::expander** package provides only one command, described below. The rest of the section is taken by a description of the methods for the expander objects created by this command.

**::textutil::expander** *expanderName*
: The command creates a new expander object with an associated Tcl command whose name is *expanderName*. This command may be used to invoke various methods. If the *expanderName* is not fully qualified it is interpreted as relative to the current namespace. The method calls have the following general form:

    ```
    expanderName method ?arg ...?
    ```


Expander objects support the following methods:

*expanderName* **cappend** *text*
: Appends a string to the output in the current context.  This command should rarely be used by macros or application code.

*expanderName* **cget** *varname*
: Returns the value of variable *varname*, defined in the current context.

*expanderName* **cis** *cname*
: Returns **1** (true) if the current context’s name is *cname*; otherwise returns **0** (false). *cname*.

*expanderName* **cname**
: Returns the name of the current context.

*expanderName* **cpop** *cname*
: Pops a context from the context stack, returning all accumulated output in that context. The context must be called *cname*, or an error is thrown.

*expanderName* **ctopandclear**
: Returns the output currently captured in the topmost context and clears that buffer. This is similar to a combination of **cpop** followed by **cpush**, except that the internal state (brackets) is preserved here.

*expanderName* **cpush** *cname*
: Pushes a context called *cname* onto the context stack.  The context must be popped by **cpop** before expansion ends or an error is thrown.

*expanderName* **cset** *varname* *value*
: Sets variable *varname* to *value* in the current context.

*expanderName* **cvar** *varname*
: Returns the internal variable name of context variable *varname*; this allows the variable to be passed to commands like **lappend**.

*expanderName* **errmode** *newErrmode*
: Sets the macro expansion error mode to one of **nothing**, **macro**, **error**, or **fail**; the default value is **fail**.  The value determines what the expander does if an error is detected during the expansion of a macro.

    **fail**
    : The error propagates normally (i.e., is thrown), and can be caught or ignored by the application.

    **error**
    : The macro expands into a detailed error message, and expansion continues.

    **macro**
    : The macro expands to itself; that is, it is passed along to the output unchanged.

    **nothing**
    : The macro expands to the empty string, and is effectively ignored.


*expanderName* **evalcmd** ?*newEvalCmd*?
: Returns the current evaluation command, which defaults to **uplevel #0**.  If specified, *newEvalCmd* will be saved for future use and then returned; it must be a Tcl command expecting one additional argument: the macro to evaluate.

*expanderName* **expand** *string* ?*brackets*?
: Expands the input string, replacing embedded macros with their expanded values, and returns the expanded string.

    Note that this method pushes a new (empty) context on the stack of contexts while it is running, and removes it on return.

    If *brackets* is given, it must be a list of two strings; the items will be used as the left and right macro expansion bracket sequences for this expansion only.

*expanderName* **lb** ?*newbracket*?
: Returns the current value of the left macro expansion bracket; this is for use as or within a macro, when the bracket needs to be included in the output text.  If *newbracket* is specified, it becomes the new bracket, and is returned.

*expanderName* **rb** ?*newbracket*?
: Returns the current value of the right macro expansion bracket; this is for use as or within a macro, when the bracket needs to be included in the output text.  If *newbracket* is specified, it becomes the new bracket, and is returned.

*expanderName* **reset**
: Resets all expander settings to their initial values. Unexpected results are likely if this command is called from within a call to **expand**.

*expanderName* **setbrackets** *lbrack rbrack*
: Sets the left and right macro expansion brackets.  This command is for use as or within a macro, or to permanently change the bracket definitions.  By default, the brackets are **\[** and **\]**, but any non-empty string can be used; for example, **<** and **>** or **(\*** and **\*)** or even **Hello,** and **World!**.

*expanderName* **textcmd** ?*newTextCmd*?
: Returns the current command for processing plain text, which defaults to the empty string, meaning *identity*. If specified, *newTextCmd* will be saved for future use and then returned; it must be a Tcl command expecting one additional argument: the text to process. The expander object will use this command for all plain text it encounters, giving the user of the object the ability to process all plain text in some standard way before writing it to the output. The object expects that the command returns the processed plain text.

    *Note* that the combination of "**textcmd** *plaintext*" is run through the *evalcmd* for the actual evaluation. In other words, the *textcmd* is treated as a special macro implicitly surrounding all plain text in the template.

*expanderName* **where**
: Returns a three-element list containing the current character position, line, and column the expander has reached in the processing of the current input string.


# Tutorial

## Basics

To begin, create an expander object:

```
    % package require textutil::expander
    1.2
    % ::textutil::expander myexp
    ::myexp
    %
```

The created **::myexp** object can be used to expand text strings containing embedded Tcl commands.  By default, embedded commands are delimited by square brackets.  Note that expander doesn’t attempt to interpolate variables, since variables can be referenced by embedded commands:

```
    % set greeting "Howdy"
    Howdy
    % proc place {} {return "World"}
    % ::myexp expand {[set greeting], [place]!}
    Howdy, World!
    %
```

## Embedding macros

An expander macro is simply a Tcl script embedded within a text string.  Expander evaluates the script in the global context, and replaces it with its result string.  For example,

```
    % set greetings {Howdy Hi "What's up"}
    Howdy Hi "What's up"
    % ::myexp expand {There are many ways to say "Hello, World!":
    [set result {}
    foreach greeting $greetings {
	append result "$greeting, World!\\n"
    }
    set result]
    And that's just a small sample!}
    There are many ways to say "Hello, World!":
    Howdy, World!
    Hi, World!
    What's up, World!

    And that's just a small sample!
    %
```

## Writing macro commands

More typically, *macro commands* are used to create a markup language.  A macro command is just a Tcl command that returns an output string.  For example, expand can be used to implement a generic document markup language that can be retargeted to HTML or any other output format:

```
    % proc bold {} {return "<b>"}
    % proc /bold {} {return "</b>"}
    % ::myexp expand {Some of this text is in [bold]boldface[/bold]}
    Some of this text is in <b>boldface</b>
    %
```

The above definitions of **bold** and **/bold** returns HTML, but such commands can be as complicated as needed; they could, for example, decide what to return based on the desired output format.

## Changing the expansion brackets

By default, embedded macros are enclosed in square brackets, **\[** and **\]**.  If square brackets must be included in the output, the input can use the **lb** and **rb** commands.  Alternatively, or if square brackets are unwanted for some other reason, the macro expansion brackets can be changed to any pair of nonempty strings.

The **setbrackets** method changes the brackets for all subsequent expansions applied to the current expansion object. For example, you can write pseudo-html by change them to **<** and **>**:

```
    % ::myexp setbrackets < >
    % ::myexp expand {<bold>This is boldface</bold>}
    <b>This is boldface</b>
```

Alternatively, you can change the expansion brackets temporarily by passing the desired brackets to the **expand** method:

```
    % ::myexp setbrackets "\\[" "\\]"
    % ::myexp expand {<bold>This is boldface</bold>} {< >}
    <b>This is boldface</b>
    %
```

## Customized macro expansion

By default, macros are evaluated using the Tcl **uplevel #0** command, so that the embedded code executes in the global context. The application can provide a different evaluation command using the **evalcmd** method; this allows the application to use a safe interpreter, for example, or even to evaluate something other than Tcl code.  There is one caveat: to be recognized as valid, a macro must return **1** (true) when passed to Tcl’s [info complete](https://www.tcl-lang.org/man/tcl9.0/TclCmd/info.html) subcommand.

For example, the following code “evaluates” each macro by returning the macro text itself.

```
    proc identity {macro} {return $macro}
    ::myexp evalcmd identity
```

## Using the context stack

Often it’s desirable to define a pair of macros which operate in some way on the plain text between them.  Consider a set of macros for adding footnotes to a web page: one could have implemented something like this:

```
    Dr. Pangloss, however, thinks that this is the best of all
    possible worlds.[footnote "See Candide, by Voltaire"]
```

The **footnote** macro would, presumably, assign a number to this footnote and save the text to be formatted later on.  However, this solution is ugly if the footnote text is long or should contain additional markup.  Consider the following instead:

```
    Dr. Pangloss, however, thinks that this is the best of all
    possible worlds.[footnote]See [bookTitle "Candide"], by
    [authorsName "Voltaire"], for more information.[/footnote]
```

Here the footnote text is contained between **footnote** and **/footnote** macros, continues onto a second line, and contains several macros of its own.  This is both clearer and more flexible; however, with the features presented so far there’s no easy way to do it.  That’s the purpose of the context stack.

All macro expansion takes place in a particular context.  Here, the **footnote** macro pushes a new context onto the context stack. Then, all expanded text gets placed in that new context. **/footnote** retrieves it by popping the context.  Here’s a skeleton implementation of these two macros:

```
    proc footnote {} {
        ::myexp cpush footnote
    }

    proc /footnote {} {
        set footnoteText [::myexp cpop footnote]

        # Save the footnote text, and return an appropriate footnote
        # number and link.
    }
```

The **cpush** method pushes a new context onto the stack; the argument is the context’s name.  It can be any string, but would typically be the name of the macro itself.  Then, **cpop** verifies that the current context has the expected name, pops it off of the stack, and returns the accumulated text.

Expand provides several other tools related to the context stack. Suppose the first macro in a context pair takes arguments or computes values which the second macro in the pair needs.  After calling **cpush**, the first macro can define one or more context variables; the second macro can retrieve their values any time before calling **cpop**.  For example, suppose the document must specify the footnote number explicitly:

```
    proc footnote {footnoteNumber} {
        ::myexp cpush footnote
        ::myexp csave num $footnoteNumber
        # Return an appropriate link
    }

    proc /footnote {} {
        set footnoteNumber [::myexp cget num]
        set footnoteText [::myexp cpop footnote]

        # Save the footnote text and its footnoteNumber for future
        # output.
    }
```

At times, it might be desirable to define macros that are valid only within a particular context pair; such macros should verify that they are only called within the correct context using either **cis** or **cname**.

# History

The **expander** package was written by William H. Duquette; it is a repackaging of the central algorithm of the expand macro processing tool.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) William H. Duquette https://github.com/wjduquette
```
