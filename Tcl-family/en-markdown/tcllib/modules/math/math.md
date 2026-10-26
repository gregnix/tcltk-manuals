---
CommandName: math
ManualSection: n
Version: 1.2.6
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - math
 - statistics
Copyright:
---

# Name

math - Tcl Math Library

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math]{.lit} [1.2.6]{.optlit} 
[::math::cov]{.cmd} [value]{.arg} [value]{.arg} [value]{.optdot} 
[::math::integrate]{.cmd} [list]{.arg} [of]{.arg} [xy]{.arg} [value]{.arg} [pairs]{.arg} 
[::math::fibonacci]{.cmd} [n]{.arg} 
[::math::max]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::mean]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::min]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::product]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::random]{.cmd} [value1]{.optarg} [value2]{.optarg} 
[::math::sigma]{.cmd} [value]{.arg} [value]{.arg} [value]{.optdot} 
[::math::stats]{.cmd} [value]{.arg} [value]{.arg} [value]{.optdot} 
[::math::sum]{.cmd} [value]{.arg} [value]{.optdot} 
:::

# Description

The **math** package provides utility math functions.

Besides a set of basic commands, available via the package *math*, there are more specialised packages:

**•**
: **math::bigfloat** - Arbitrary-precision floating-point arithmetic

**•**
: **math::bignum** - Arbitrary-precision integer arithmetic

**•**
: **math::calculus::romberg** - Robust integration methods for functions of one variable, using Romberg integration

**•**
: **math::calculus** - Integration of functions, solving ordinary differential equations

**•**
: **math::combinatorics** - Procedures for various combinatorial functions (for instance the Gamma function and "k out of n")

**•**
: **math::complexnumbers** - Complex number arithmetic

**•**
: **math::constants** - A set of well-known mathematical constants, such as Pi, E, and the golden ratio

**•**
: **math::fourier** - Discrete Fourier transforms

**•**
: **math::fuzzy** - Fuzzy comparisons of floating-point numbers

**•**
: **math::geometry** - 2D geometrical computations

**•**
: **math::interpolate** - Various interpolation methods

**•**
: **math::linearalgebra** - Linear algebra package

**•**
: **math::optimize** - Optimization methods

**•**
: **math::polynomials** - Polynomial arithmetic (includes families of classical polynomials)

**•**
: **math::rationalfunctions** - Arithmetic of rational functions

**•**
: **math::roman** - Manipulation (including arithmetic) of Roman numerals

**•**
: **math::special** - Approximations of special functions from mathematical physics

**•**
: **math::statistics** - Statistical operations and tests


# Basic commands

**::math::cov** *value* *value* ?*value ...*?
: Return the coefficient of variation expressed as percent of two or more numeric values.

**::math::integrate** *list of xy value pairs*
: Return the area under a "curve" defined by a set of x,y pairs and the error bound as a list.

**::math::fibonacci** *n*
: Return the *n*'th Fibonacci number.

**::math::max** *value* ?*value ...*?
: Return the maximum of one or more numeric values.

**::math::mean** *value* ?*value ...*?
: Return the mean, or "average" of one or more numeric values.

**::math::min** *value* ?*value ...*?
: Return the minimum of one or more numeric values.

**::math::product** *value* ?*value ...*?
: Return the product of one or more numeric values.

**::math::random** ?*value1*? ?*value2*?
: Return a random number.  If no arguments are given, the number is a floating point value between 0 and 1.  If one argument is given, the number is an integer value between 0 and *value1*.  If two arguments are given, the number is an integer value between *value1* and *value2*.

**::math::sigma** *value* *value* ?*value ...*?
: Return the sample standard deviation of two or more numeric values.

**::math::stats** *value* *value* ?*value ...*?
: Return the mean, standard deviation, and coefficient of variation (as percent) as a list.

**::math::sum** *value* ?*value ...*?
: Return the sum of one or more numeric values.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics
