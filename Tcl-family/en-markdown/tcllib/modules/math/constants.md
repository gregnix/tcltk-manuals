---
CommandName: math::constants
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - constants
 - degrees
 - e
 - math
 - pi
 - radians
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::constants - Mathematical and numerical constants

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.3]{.optlit} 
[package]{.cmd} [require]{.sub} [math::constants]{.lit} [1.0.4]{.optlit} 
[::math::constants::constants]{.cmd} [args]{.arg} 
[::math::constants::print-constants]{.cmd} [args]{.arg} 
:::

# Description

This package defines some common mathematical and numerical constants. By using the package you get consistent values for numbers like pi and ln(10).

It defines two commands:

**•**
: One for importing the constants

**•**
: One for reporting which constants are defined and what values they actually have. The motivation for this package is that quite often, with (mathematical) computations, you need a good approximation to, say, the ratio of degrees to radians. You can, of course, define this like:


```
    variable radtodeg [expr {180.0/(4.0*atan(1.0))}]
```

and use the variable radtodeg whenever you need the conversion.

This has two drawbacks:

**•**
: You need to remember the proper formula or value and that is error-prone.

**•**
: Especially with the use of mathematical functions like *atan* you assume that they have been accurately implemented. This is seldom or never the case and for each platform you can get subtle differences. Here is the way you can do it with the *math::constants* package:


```
    package require math::constants
    ::math::constants::constants radtodeg degtorad
```

which creates two variables, radtodeg and (its reciprocal) degtorad in the calling namespace.

Constants that have been defined (their values are mostly taken from mathematical tables with more precision than usually can be handled) include:

**•**
: basic constants like pi, e, gamma (Euler's constant)

**•**
: derived values like ln(10) and sqrt(2)

**•**
: purely numerical values such as 1/3 that are included for convenience and for the fact that certain seemingly trivial computations like:


```
    set value [expr {3.0*$onethird}]
```

: give *exactly* the value you expect (if IEEE arithmetic is available). The full set of named constants is listed in section **Constants**.


# Procedures

The package defines the following public procedures:

**::math::constants::constants** *args*
: Import the constants whose names are given as arguments

**::math::constants::print-constants** *args*
: Print the constants whose names are given as arguments on the screen (name, value and description) or, if no arguments are given, print all defined constants. This is mainly a convenience procedure.


# Constants

**pi**
: Ratio of circle circumference to diameter

**e**
: Base for natural logarithm

**ln10**
: Natural logarithm of 10

**phi**
: Golden ratio

**gamma**
: Euler's constant

**sqrt2**
: Square root of 2

**thirdrt2**
: One-third power of 2

**sqrt3**
: Square root of 3

**radtodeg**
: Conversion from radians to degrees

**degtorad**
: Conversion from degrees to radians

**onethird**
: One third (0.3333....)

**twothirds**
: Two thirds (0.6666....)

**onesixth**
: One sixth (0.1666....)

**huge**
: (Approximately) largest number

**tiny**
: (Approximately) smallest number not equal zero

**eps**
: Smallest number such that 1+eps != 1


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: constants* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
