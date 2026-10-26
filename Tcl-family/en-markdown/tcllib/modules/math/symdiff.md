---
CommandName: math::calculus::symdiff
title: math::calculus::symdiff
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Symbolic differentiation for Tcl
Links:
 - math::calculus
 - math::interpolate
Copyright:
 - Copyright (c) 2010 by Kevin B. Kenny <kennykb@acm.org>
---

# Name

math::calculus::symdiff - Symbolic differentiation for Tcl

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::aycock]{.lit} [1.0]{.lit}
[package]{.cmd} [require]{.sub} [math::calculus::symdiff]{.lit} [1.0.2]{.lit}
[math::calculus::symdiff::symdiff]{.cmd} [expression]{.arg} [variable]{.arg}
[math::calculus::jacobian]{.cmd} [variableDict]{.arg}
:::

# Description

The **math::calculus::symdiff** package provides a symbolic differentiation facility for Tcl math expressions. It is useful for providing derivatives to packages that either require the Jacobian of a set of functions or else are more efficient or stable when the Jacobian is provided.

# Procedures

The **math::calculus::symdiff** package exports the two procedures:

**math::calculus::symdiff::symdiff** *expression* *variable*
: Differentiates the given *expression* with respect to the specified *variable*. (See [Expressions] below for a discussion of the subset of Tcl math expressions that are acceptable to **math::calculus::symdiff**.) The result is a Tcl expression that evaluates the derivative. Returns an error if *expression* is not a well-formed expression or is not differentiable.

**math::calculus::jacobian** *variableDict*
: Computes the Jacobian of a system of equations. The system is given by the dictionary *variableDict*, whose keys are the names of variables in the system, and whose values are Tcl expressions giving the values of those variables. (See [Expressions] below for a discussion of the subset of Tcl math expressions that are acceptable to **math::calculus::symdiff**. The result is a list of lists: the i'th element of the j'th sublist is the partial derivative of the i'th variable with respect to the j'th variable. Returns an error if any of the expressions cannot be differentiated, or if *variableDict* is not a well-formed dictionary.


# Expressions

The **math::calculus::symdiff** package accepts only a small subset of the expressions that are acceptable to Tcl commands such as **expr** or **if**. Specifically, the only constructs accepted are:

- Floating-point constants such as **5** or **3.14159e+00**.

- References to Tcl variable using $-substitution. The variable names must consist of alphanumerics and underscores: the **${...}** notation is not accepted.

- Parentheses.

- The **+**, **-**, **\***, **/**. and **\*\*** operators.

- Calls to the functions [acos][bigfloat], [asin][bigfloat], [atan][bigfloat], **atan2**, [cos][bigfloat], [cosh][bigfloat], [exp][bigfloat], **hypot**, **log**, **log10**, [pow][bigfloat], [sin][bigfloat], [sinh][bigfloat]. [sqrt][bigfloat], [tan][bigfloat], and [tanh][bigfloat].


Command substitution, backslash substitution, and argument expansion are not accepted.

# Examples

```
math::calculus::symdiff::symdiff {($a*$x+$b)*($c*$x+$d)} x
==> (($c * (($a * $x) + $b)) + ($a * (($c * $x) + $d)))
math::calculus::symdiff::jacobian {x {$a * $x + $b * $y}
                         y {$c * $x + $d * $y}}
==> {{$a} {$b}} {{$c} {$d}}
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: calculus* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Copyright

```
Copyright (c) 2010 by Kevin B. Kenny <kennykb@acm.org>
Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
```


[bigfloat]: bigfloat.md
