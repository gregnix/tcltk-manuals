---
CommandName: math::fuzzy
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - floating-point
 - math
 - rounding
Copyright:
---

# Name

math::fuzzy - Fuzzy comparison of floating-point numbers

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.3]{.optlit} 
[package]{.cmd} [require]{.sub} [math::fuzzy]{.lit} [0.2]{.optlit} 
[::math::fuzzy::teq]{.cmd} [value1]{.arg} [value2]{.arg} 
[::math::fuzzy::tne]{.cmd} [value1]{.arg} [value2]{.arg} 
[::math::fuzzy::tge]{.cmd} [value1]{.arg} [value2]{.arg} 
[::math::fuzzy::tle]{.cmd} [value1]{.arg} [value2]{.arg} 
[::math::fuzzy::tlt]{.cmd} [value1]{.arg} [value2]{.arg} 
[::math::fuzzy::tgt]{.cmd} [value1]{.arg} [value2]{.arg} 
[::math::fuzzy::tfloor]{.cmd} [value]{.arg} 
[::math::fuzzy::tceil]{.cmd} [value]{.arg} 
[::math::fuzzy::tround]{.cmd} [value]{.arg} 
[::math::fuzzy::troundn]{.cmd} [value]{.arg} [ndigits]{.arg} 
:::

# Description

The package Fuzzy is meant to solve common problems with floating-point numbers in a systematic way:

**•**
: Comparing two numbers that are "supposed" to be identical, like 1.0 and 2.1/(1.2+0.9) is not guaranteed to give the intuitive result.

**•**
: Rounding a number that is halfway two integer numbers can cause strange errors, like int(100.0\*2.8) != 28 but 27 The Fuzzy package is meant to help sorting out this type of problems by defining "fuzzy" comparison procedures for floating-point numbers. It does so by allowing for a small margin that is determined automatically - the margin is three times the "epsilon" value, that is three times the smallest number *eps* such that 1.0 and 1.0+\$eps canbe distinguished. In Tcl, which uses double precision floating-point numbers, this is typically 1.1e-16.


# Procedures

Effectively the package provides the following procedures:

**::math::fuzzy::teq** *value1* *value2*
: Compares two floating-point numbers and returns 1 if their values fall within a small range. Otherwise it returns 0.

**::math::fuzzy::tne** *value1* *value2*
: Returns the negation, that is, if the difference is larger than the margin, it returns 1.

**::math::fuzzy::tge** *value1* *value2*
: Compares two floating-point numbers and returns 1 if their values either fall within a small range or if the first number is larger than the second. Otherwise it returns 0.

**::math::fuzzy::tle** *value1* *value2*
: Returns 1 if the two numbers are equal according to \[teq\] or if the first is smaller than the second.

**::math::fuzzy::tlt** *value1* *value2*
: Returns the opposite of \[tge\].

**::math::fuzzy::tgt** *value1* *value2*
: Returns the opposite of \[tle\].

**::math::fuzzy::tfloor** *value*
: Returns the integer number that is lower or equal to the given floating-point number, within a well-defined tolerance.

**::math::fuzzy::tceil** *value*
: Returns the integer number that is greater or equal to the given floating-point number, within a well-defined tolerance.

**::math::fuzzy::tround** *value*
: Rounds the floating-point number off.

**::math::fuzzy::troundn** *value* *ndigits*
: Rounds the floating-point number off to the specified number of decimals (Pro memorie). Usage:


```
if { [teq $x $y] } { puts "x == y" }
if { [tne $x $y] } { puts "x != y" }
if { [tge $x $y] } { puts "x >= y" }
if { [tgt $x $y] } { puts "x > y" }
if { [tlt $x $y] } { puts "x < y" }
if { [tle $x $y] } { puts "x <= y" }

set fx      [tfloor $x]
set fc      [tceil  $x]
set rounded [tround $x]
set roundn  [troundn $x $nodigits]
```

# Test cases

The problems that can occur with floating-point numbers are illustrated by the test cases in the file "fuzzy.test":

**•**
: Several test case use the ordinary comparisons, and they fail invariably to produce understandable results

**•**
: One test case uses \[expr\] without braces ({ and }). It too fails. The conclusion from this is that any expression should be surrounded by braces, because otherwise very awkward things can happen if you need accuracy. Furthermore, accuracy and understandable results are enhanced by using these "tolerant" or fuzzy comparisons. Note that besides the Tcl-only package, there is also a C-based version.


# References

Original implementation in Fortran by dr. H.D. Knoble (Penn State University).

P. E. Hagerty, "More on Fuzzy Floor and Ceiling," APL QUOTE QUAD 8(4):20-24, June 1978. Note that TFLOOR=FL5 took five years of refereed evolution (publication).

L. M. Breed, "Definitions for Fuzzy Floor and Ceiling", APL QUOTE QUAD 8(3):16-23, March 1978.

D. Knuth, Art of Computer Programming, Vol. 1, Problem 1.2.4-5.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: fuzzy* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics
