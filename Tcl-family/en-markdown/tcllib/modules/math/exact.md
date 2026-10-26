---
CommandName: math::exact
title: math::exact
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Copyright:
 - Copyright (c) 2015 Kevin B. Kenny <kennykb@acm.org>
---

# Name

math::exact - Exact Real Arithmetic

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::aycock]{.lit} [1.0]{.lit}
[package]{.cmd} [require]{.sub} [math::exact]{.lit} [1.0.2]{.lit}
[::math::exact::exactexpr]{.cmd} [expr]{.arg}
[number]{.ins} [ref]{.sub}
[number]{.ins} [unref]{.sub}
[number]{.ins} [asPrint]{.sub} [precision]{.arg}
[number]{.ins} [asFloat]{.sub} [precision]{.arg}
:::

# Description

The **exactexpr** command in the **math::exact** package allows for exact computations over the computable real numbers. These are not arbitrary-precision calculations; rather they are exact, with numbers represented by algorithms that produce successive approximations. At the end of a calculation, the caller can request a given precision for the end result, and intermediate results are computed to whatever precision is necessary to satisfy the request.

# Procedures

The following procedure is the primary entry into the **math::exact** package.

**::math::exact::exactexpr** *expr*
: Accepts a mathematical expression in Tcl syntax, and returns an object that represents the program to calculate successive approximations to the expression's value. The result will be referred to as an exact real number.

*number* **ref**
: Increases the reference count of a given exact real number.

*number* **unref**
: Decreases the reference count of a given exact real number, and destroys the number if the reference count is zero.

*number* **asPrint** *precision*
: Formats the given *number* for printing, with the specified *precision*. (See below for how *precision* is interpreted). Numbers that are known to be rational are formatted as fractions.

*number* **asFloat** *precision*
: Formats the given *number* for printing, with the specified *precision*. (See below for how *precision* is interpreted). All numbers are formatted in floating-point E format.


# Parameters

*expr*
: Expression to evaluate. The syntax for expressions is the same as it is in Tcl, but the set of operations is smaller. See [Expressions] below for details.

*number*
: The object returned by an earlier invocation of **math::exact::exactexpr**

*precision*
: The requested 'precision' of the result. The precision is (approximately) the absolute value of the binary exponent plus the number of bits of the binary significand. For instance, to return results to IEEE-754 double precision, 56 bits plus the exponent are required. Numbers between 1/2 and 2 will require a precision of 57; numbers between 1/4 and 1/2 or between 2 and 4 will require 58; numbers between 1/8 and 1/4 or between 4 and 8 will require 59; and so on.


# Expressions

The **math::exact::exactexpr** command accepts expressions in a subset of Tcl's syntax. The following components may be used in an expression.

- Decimal integers.

- Variable references with the dollar sign (**$**). The value of the variable must be the result of another call to **math::exact::exactexpr**. The reference count of the value will be increased by one for each position at which it appears in the expression.

- The exponentiation operator (**\*\***).

- Unary plus (**+**) and minus (**-**) operators.

- Multiplication (**\***) and division (**/**) operators.

- Parentheses used for grouping.

- Functions. See [Functions] below for the functions that are available.


# Functions

The following functions are available for use within exact real expressions.

**acos(***x***)**
: The inverse cosine of *x*. The result is expressed in radians. The absolute value of *x* must be less than 1.

**acosh(***x***)**
: The inverse hyperbolic cosine of *x*. *x* must be greater than 1.

**asin(***x***)**
: The inverse sine of *x*. The result is expressed in radians. The absolute value of *x* must be less than 1.

**asinh(***x***)**
: The inverse hyperbolic sine of *x*.

**atan(***x***)**
: The inverse tangent of *x*. The result is expressed in radians.

**atanh(***x***)**
: The inverse hyperbolic tangent of *x*. The absolute value of *x* must be less than 1.

**cos(***x***)**
: The cosine of *x*. *x* is expressed in radians.

**cosh(***x***)**
: The hyperbolic cosine of *x*.

**e()**
: The base of the natural logarithms = **2.71828...**

**exp(***x***)**
: The exponential function of *x*.

**log(***x***)**
: The natural logarithm of *x*. *x* must be positive.

**pi()**
: The value of pi = **3.15159...**

**sin(***x***)**
: The sine of *x*. *x* is expressed in radians.

**sinh(***x***)**
: The hyperbolic sine of *x*.

**sqrt(***x***)**
: The square root of *x*. *x* must be positive.

**tan(***x***)**
: The tangent of *x*. *x* is expressed in radians.

**tanh(***x***)**
: The hyperbolic tangent of *x*.


# Summary

The **math::exact::exactexpr** command provides a system that performs exact arithmetic over computable real numbers, representing the numbers as algorithms for successive approximation. An example, which implements the high-school quadratic formula, is shown below.

```
namespace import math::exact::exactexpr
proc exactquad {a b c} {
    set d [[exactexpr {sqrt($b*$b - 4*$a*$c)}] ref]
    set r0 [[exactexpr {(-$b - $d) / (2 * $a)}] ref]
    set r1 [[exactexpr {(-$b + $d) / (2 * $a)}] ref]
    $d unref
    return [list $r0 $r1]
}

set a [[exactexpr 1] ref]
set b [[exactexpr 200] ref]
set c [[exactexpr {(-3/2) * 10**-12}] ref]
lassign [exactquad $a $b $c] r0 r1
$a unref; $b unref; $c unref
puts [list [$r0 asFloat 70] [$r1 asFloat 110]]
$r0 unref; $r1 unref
```

The program prints the result:

```
-2.000000000000000075e2 7.499999999999999719e-15
```

Note that if IEEE-754 floating point had been used, a catastrophic roundoff error would yield a smaller root that is a factor of two too high:

```
-200.0 1.4210854715202004e-14
```

The invocations of **exactexpr** should be fairly self-explanatory. The other commands of note are **ref** and **unref**. It is necessary for the caller to keep track of references to exact expressions - to call **ref** every time an exact expression is stored in a variable and **unref** every time the variable goes out of scope or is overwritten. The **asFloat** method emits decimal digits as long as the requested precision supports them. It terminates when the requested precision yields an uncertainty of more than one unit in the least significant digit.

# Category

Mathematics

# Copyright

```
Copyright (c) 2015 Kevin B. Kenny <kennykb@acm.org>
Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
```
