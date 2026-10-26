---
CommandName: math::decimal
ManualSection: n
Version: 1.0.5
TclPart: tcllib
TclDescription: Tcl Decimal Arithmetic Library
Keywords:
 - decimal
 - math
 - tcl
Copyright:
 - Copyright (c) 2011 Mark Alston <mark at beernut dot com>
---

# Name

math::decimal - General decimal arithmetic

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [math::decimal]{.lit} [1.0.3]{.lit} 
[::math::decimal::fromstr]{.cmd} [string]{.arg} 
[::math::decimal::tostr]{.cmd} [decimal]{.arg} 
[::math::decimal::setVariable]{.cmd} [variable]{.arg} [setting]{.arg} 
[::math::decimal::add]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::+]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::subtract]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::-]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::multiply]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::\*]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::divide]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::/]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::divideint]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::remainder]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::abs]{.cmd} [decimal]{.arg} 
[::math::decimal::compare]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::max]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::maxmag]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::min]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::minmag]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::plus]{.cmd} [a]{.arg} 
[::math::decimal::minus]{.cmd} [a]{.arg} 
[::math::decimal::copynegate]{.cmd} [a]{.arg} 
[::math::decimal::copysign]{.cmd} [a]{.arg} [b]{.arg} 
[::math::decimal::is-signed]{.cmd} [decimal]{.arg} 
[::math::decimal::is-zero]{.cmd} [decimal]{.arg} 
[::math::decimal::is-NaN]{.cmd} [decimal]{.arg} 
[::math::decimal::is-infinite]{.cmd} [decimal]{.arg} 
[::math::decimal::is-finite]{.cmd} [decimal]{.arg} 
[::math::decimal::fma]{.cmd} [a]{.arg} [b]{.arg} [c]{.arg} 
[::math::decimal::round_half_even]{.cmd} [decimal]{.arg} [digits]{.arg} 
[::math::decimal::round_half_up]{.cmd} [decimal]{.arg} [digits]{.arg} 
[::math::decimal::round_half_down]{.cmd} [decimal]{.arg} [digits]{.arg} 
[::math::decimal::round_down]{.cmd} [decimal]{.arg} [digits]{.arg} 
[::math::decimal::round_up]{.cmd} [decimal]{.arg} [digits]{.arg} 
[::math::decimal::round_floor]{.cmd} [decimal]{.arg} [digits]{.arg} 
[::math::decimal::round_ceiling]{.cmd} [decimal]{.arg} [digits]{.arg} 
[::math::decimal::round_05up]{.cmd} [decimal]{.arg} [digits]{.arg} 
:::

# Description

The decimal package provides decimal arithmetic support for both limited precision floating point and arbitrary precision floating point. Additionally, integer arithmetic is supported.

More information and the specifications on which this package depends can be found on the general decimal arithmetic page at http://speleotrove.com/decimal This package provides for:

**•**
: A new data type decimal which is represented as a list containing sign, mantissa and exponent.

**•**
: Arithmetic operations on those decimal numbers such as addition, subtraction, multiplication, etc... Numbers are converted to decimal format using the operation ::math::decimal::fromstr. Numbers are converted back to string format using the operation ::math::decimal::tostr.


# Examples

This section shows some simple examples. Since the purpose of this library is to perform decimal math operations, examples may be the simplest way to learn how to work with it and to see the difference between using this package and sticking with expr. Consult the API section of this man page for information about individual procedures.

```
    package require math::decimal

    # Various operations on two numbers.
    # We first convert them to decimal format.
    set a [::math::decimal::fromstr 8.2]
    set b [::math::decimal::fromstr .2]

    # Then we perform our operations. Here we add
    set c [::math::decimal::+ $a $b]

    # Finally we convert back to string format for presentation to the user.
    puts [::math::decimal::tostr $c] ; # => will output 8.4

    # Other examples
    #
    # Subtraction
    set c [::math::decimal::- $a $b]
    puts [::math::decimal::tostr $c] ; # => will output 8.0

    # Why bother using this instead of simply expr?
    puts [expr {8.2 + .2}] ; # => will output 8.399999999999999
    puts [expr {8.2 - .2}] ; # => will output 7.999999999999999
    # See http://speleotrove.com/decimal to learn more about why this happens.
```

# Api

**::math::decimal::fromstr** *string*
: Convert *string* into a decimal.

**::math::decimal::tostr** *decimal*
: Convert *decimal* into a string representing the number in base 10.

**::math::decimal::setVariable** *variable* *setting*
: Sets the *variable* to *setting*. Valid variables are:


**•**
: *rounding* - Method of rounding to use during rescale. Valid methods are round_half_even, round_half_up, round_half_down, round_down, round_up, round_floor, round_ceiling.

**•**
: *precision* - Maximum number of digits allowed in mantissa.

**•**
: *extended* - Set to 1 for extended mode. 0 for simplified mode.

**•**
: *maxExponent* - Maximum value for the exponent. Defaults to 999.

**•**
: *minExponent* - Minimum value for the exponent. Default to -998.


**::math::decimal::add** *a* *b*
: ...see next...

**::math::decimal::+** *a* *b*
: Return the sum of the two decimals *a* and *b*.

**::math::decimal::subtract** *a* *b*
: ...see next...

**::math::decimal::-** *a* *b*
: Return the differnece of the two decimals *a* and *b*.

**::math::decimal::multiply** *a* *b*
: ...see next...

**::math::decimal::\*** *a* *b*
: Return the product of the two decimals *a* and *b*.

**::math::decimal::divide** *a* *b*
: ...see next...

**::math::decimal::/** *a* *b*
: Return the quotient of the division between the two decimals *a* and *b*.

**::math::decimal::divideint** *a* *b*
: Return a the integer portion of the quotient of the division between decimals *a* and *b*

**::math::decimal::remainder** *a* *b*
: Return the remainder of the division between the two decimals *a* and *b*.

**::math::decimal::abs** *decimal*
: Return the absolute value of the decimal.

**::math::decimal::compare** *a* *b*
: Compare the two decimals a and b, returning *0* if *a == b*, *1* if *a > b*, and *-1* if *a < b*.

**::math::decimal::max** *a* *b*
: Compare the two decimals a and b, and return *a* if *a >= b*, and *b* if *a < b*.

**::math::decimal::maxmag** *a* *b*
: Compare the two decimals a and b while ignoring their signs, and return *a* if *abs(a) >= abs(b)*, and *b* if *abs(a) < abs(b)*.

**::math::decimal::min** *a* *b*
: Compare the two decimals a and b, and return *a* if *a <= b*, and *b* if *a > b*.

**::math::decimal::minmag** *a* *b*
: Compare the two decimals a and b while ignoring their signs, and return *a* if *abs(a) <= abs(b)*, and *b* if *abs(a) > abs(b)*.

**::math::decimal::plus** *a*
: Return the result from *::math::decimal::+ 0 \$a*.

**::math::decimal::minus** *a*
: Return the result from *::math::decimal::- 0 \$a*.

**::math::decimal::copynegate** *a*
: Returns *a* with the sign flipped.

**::math::decimal::copysign** *a* *b*
: Returns *a* with the sign set to the sign of the *b*.

**::math::decimal::is-signed** *decimal*
: Return the sign of the decimal. The procedure returns 0 if the number is positive, 1 if it's negative.

**::math::decimal::is-zero** *decimal*
: Return true if *decimal* value is zero, otherwise false is returned.

**::math::decimal::is-NaN** *decimal*
: Return true if *decimal* value is NaN (not a number), otherwise false is returned.

**::math::decimal::is-infinite** *decimal*
: Return true if *decimal* value is Infinite, otherwise false is returned.

**::math::decimal::is-finite** *decimal*
: Return true if *decimal* value is finite, otherwise false is returned.

**::math::decimal::fma** *a* *b* *c*
: Return the result from first multiplying *a* by *b* and then adding *c*. Rescaling only occurs after completion of all operations. In this way the result may vary from that returned by performing the operations individually.

**::math::decimal::round_half_even** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round to the nearest. If equidistant, round so the final digit is even.

**::math::decimal::round_half_up** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round to the nearest. If equidistant, round up.

**::math::decimal::round_half_down** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round to the nearest. If equidistant, round down.

**::math::decimal::round_down** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round toward 0.  (Truncate)

**::math::decimal::round_up** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round away from 0

**::math::decimal::round_floor** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round toward -Infinity.

**::math::decimal::round_ceiling** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round toward Infinity

**::math::decimal::round_05up** *decimal* *digits*
: Rounds *decimal* to *digits* number of decimal points with the following rules: Round zero or five away from 0. The same as round-up, except that rounding up only occurs if the digit to be rounded up is 0 or 5, and after overflow the result is the same as for round-down.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *decimal* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2011 Mark Alston <mark at beernut dot com>
```
