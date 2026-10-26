---
CommandName: math::special
title: math::special
ManualSection: n
Version: 0.5.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - Bessel functions
 - error function
 - math
 - special functions
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::special - Special mathematical functions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::special]{.lit} [0.5.3]{.optlit}
[::math::special::eulerNumber]{.cmd} [index]{.arg}
[::math::special::bernoulliNumber]{.cmd} [index]{.arg}
[::math::special::Beta]{.cmd} [x]{.arg} [y]{.arg}
[::math::special::incBeta]{.cmd} [a]{.arg} [b]{.arg} [x]{.arg}
[::math::special::regIncBeta]{.cmd} [a]{.arg} [b]{.arg} [x]{.arg}
[::math::special::Gamma]{.cmd} [x]{.arg}
[::math::special::digamma]{.cmd} [x]{.arg}
[::math::special::erf]{.cmd} [x]{.arg}
[::math::special::erfc]{.cmd} [x]{.arg}
[::math::special::invnorm]{.cmd} [p]{.arg}
[::math::special::J0]{.cmd} [x]{.arg}
[::math::special::J1]{.cmd} [x]{.arg}
[::math::special::Jn]{.cmd} [n]{.arg} [x]{.arg}
[::math::special::J1/2]{.cmd} [x]{.arg}
[::math::special::J-1/2]{.cmd} [x]{.arg}
[::math::special::I\_n]{.cmd} [x]{.arg}
[::math::special::cn]{.cmd} [u]{.arg} [k]{.arg}
[::math::special::dn]{.cmd} [u]{.arg} [k]{.arg}
[::math::special::sn]{.cmd} [u]{.arg} [k]{.arg}
[::math::special::elliptic\_K]{.cmd} [k]{.arg}
[::math::special::elliptic\_E]{.cmd} [k]{.arg}
[::math::special::exponential\_Ei]{.cmd} [x]{.arg}
[::math::special::exponential\_En]{.cmd} [n]{.arg} [x]{.arg}
[::math::special::exponential\_li]{.cmd} [x]{.arg}
[::math::special::exponential\_Ci]{.cmd} [x]{.arg}
[::math::special::exponential\_Si]{.cmd} [x]{.arg}
[::math::special::exponential\_Chi]{.cmd} [x]{.arg}
[::math::special::exponential\_Shi]{.cmd} [x]{.arg}
[::math::special::fresnel\_C]{.cmd} [x]{.arg}
[::math::special::fresnel\_S]{.cmd} [x]{.arg}
[::math::special::sinc]{.cmd} [x]{.arg}
[::math::special::legendre]{.cmd} [n]{.arg}
[::math::special::chebyshev]{.cmd} [n]{.arg}
[::math::special::laguerre]{.cmd} [alpha]{.arg} [n]{.arg}
[::math::special::hermite]{.cmd} [n]{.arg}
:::

# Description

This package implements several so-called special functions, like the Gamma function, the Bessel functions and such.

Each function is implemented by a procedure that bears its name (well, in close approximation):

- J0 for the zeroth-order Bessel function of the first kind

- J1 for the first-order Bessel function of the first kind

- Jn for the nth-order Bessel function of the first kind

- J1/2 for the half-order Bessel function of the first kind

- J-1/2 for the minus-half-order Bessel function of the first kind

- I\_n for the modified Bessel function of the first kind of order n

- Gamma for the Gamma function, erf and erfc for the error function and the complementary error function

- fresnel\_C and fresnel\_S for the Fresnel integrals

- elliptic\_K and elliptic\_E (complete elliptic integrals)

- exponent\_Ei and other functions related to the so-called exponential integrals

- legendre, hermite: some of the classical orthogonal polynomials.


# Overview

In the following table several characteristics of the functions in this package are summarized: the domain for the argument, the values for the parameters and error bounds.

```
Family       | Function    | Domain x    | Parameter   | Error bound
-------------+-------------+-------------+-------------+--------------
Bessel       | J0, J1,     | all of R    | n = integer |   < 1.0e-8
             | Jn          |             |             |  (|x|<20, n<20)
Bessel       | J1/2, J-1/2,|  x > 0      | n = integer |   exact
Bessel       | I_n         | all of R    | n = integer |   < 1.0e-6
             |             |             |             |
Elliptic     | cn          | 0 <= x <= 1 |     --      |   < 1.0e-10
functions    | dn          | 0 <= x <= 1 |     --      |   < 1.0e-10
             | sn          | 0 <= x <= 1 |     --      |   < 1.0e-10
Elliptic     | K           | 0 <= x < 1  |     --      |   < 1.0e-6
integrals    | E           | 0 <= x < 1  |     --      |   < 1.0e-6
             |             |             |             |
Error        | erf         |             |     --      |
functions    | erfc        |             |             |
             |             |             |             |
Inverse      | invnorm     | 0 < x < 1   |     --      |   < 1.2e-9
normal       |             |             |             |
distribution |             |             |             |
             |             |             |             |
Exponential  | Ei          |  x != 0     |     --      |   < 1.0e-10 (relative)
integrals    | En          |  x >  0     |     --      |   as Ei
             | li          |  x > 0      |     --      |   as Ei
             | Chi         |  x > 0      |     --      |   < 1.0e-8
             | Shi         |  x > 0      |     --      |   < 1.0e-8
             | Ci          |  x > 0      |     --      |   < 2.0e-4
             | Si          |  x > 0      |     --      |   < 2.0e-4
             |             |             |             |
Fresnel      | C           |  all of R   |     --      |   < 2.0e-3
integrals    | S           |  all of R   |     --      |   < 2.0e-3
             |             |             |             |
general      | Beta        | (see Gamma) |     --      |   < 1.0e-9
             | Gamma       |  x != 0,-1, |     --      |   < 1.0e-9
             |             |  -2, ...    |             |
             | incBeta     |             |  a, b > 0   |   < 1.0e-9
             | regIncBeta  |             |  a, b > 0   |   < 1.0e-9
             | digamma     |  x != 0,-1  |             |   < 1.0e-9
             |             |  -2, ...    |             |
             |             |             |             |
             | sinc        |  all of R   |     --      |   exact
             |             |             |             |
orthogonal   | Legendre    |  all of R   | n = 0,1,... |   exact
polynomials  | Chebyshev   |  all of R   | n = 0,1,... |   exact
             | Laguerre    |  all of R   | n = 0,1,... |   exact
             |             |             | alpha el. R |
             | Hermite     |  all of R   | n = 0,1,... |   exact
```

*Note:* Some of the error bounds are estimated, as no "formal" bounds were available with the implemented approximation method, others hold for the auxiliary functions used for estimating the primary functions.

The following well-known functions are currently missing from the package:

- Bessel functions of the second kind (Y\_n, K\_n)

- Bessel functions of arbitrary order (and hence the Airy functions)

- Chebyshev polynomials of the second kind (U\_n)

- The incomplete gamma function


# Procedures

The package defines the following public procedures:

**::math::special::eulerNumber** *index*
: Return the index'th Euler number (note: these are integer values). As the size of these numbers grows very fast, only a limited number are available.

    int *index*
    : Index of the number to be returned (should be between 0 and 54)


**::math::special::bernoulliNumber** *index*
: Return the index'th Bernoulli number. As the size of the numbers grows very fast, only a limited number are available.

    int *index*
    : Index of the number to be returned (should be between 0 and 52)


**::math::special::Beta** *x* *y*
: Compute the Beta function for arguments "x" and "y"

    float *x*
    : First argument for the Beta function

    float *y*
    : Second argument for the Beta function


**::math::special::incBeta** *a* *b* *x*
: Compute the incomplete Beta function for argument "x" with parameters "a" and "b"

    float *a*
    : First parameter for the incomplete Beta function, a > 0

    float *b*
    : Second parameter for the incomplete Beta function, b > 0

    float *x*
    : Argument for the incomplete Beta function


**::math::special::regIncBeta** *a* *b* *x*
: Compute the regularized incomplete Beta function for argument "x" with parameters "a" and "b"

    float *a*
    : First parameter for the incomplete Beta function, a > 0

    float *b*
    : Second parameter for the incomplete Beta function, b > 0

    float *x*
    : Argument for the regularized incomplete Beta function


**::math::special::Gamma** *x*
: Compute the Gamma function for argument "x"

    float *x*
    : Argument for the Gamma function


**::math::special::digamma** *x*
: Compute the digamma function (psi) for argument "x"

    float *x*
    : Argument for the digamma function


**::math::special::erf** *x*
: Compute the error function for argument "x"

    float *x*
    : Argument for the error function


**::math::special::erfc** *x*
: Compute the complementary error function for argument "x"

    float *x*
    : Argument for the complementary error function


**::math::special::invnorm** *p*
: Compute the inverse of the normal distribution function for argument "p"

    float *p*
    : Argument for the inverse normal distribution function (p must be greater than 0 and lower than 1)


**::math::special::J0** *x*
: Compute the zeroth-order Bessel function of the first kind for the argument "x"

    float *x*
    : Argument for the Bessel function


**::math::special::J1** *x*
: Compute the first-order Bessel function of the first kind for the argument "x"

    float *x*
    : Argument for the Bessel function


**::math::special::Jn** *n* *x*
: Compute the nth-order Bessel function of the first kind for the argument "x"

    integer *n*
    : Order of the Bessel function

    float *x*
    : Argument for the Bessel function


**::math::special::J1/2** *x*
: Compute the half-order Bessel function of the first kind for the argument "x"

    float *x*
    : Argument for the Bessel function


**::math::special::J-1/2** *x*
: Compute the minus-half-order Bessel function of the first kind for the argument "x"

    float *x*
    : Argument for the Bessel function


**::math::special::I\_n** *x*
: Compute the modified Bessel function of the first kind of order n for the argument "x"

    int *x*
    : Positive integer order of the function

    float *x*
    : Argument for the function


**::math::special::cn** *u* *k*
: Compute the elliptic function *cn* for the argument "u" and parameter "k".

    float *u*
    : Argument for the function

    float *k*
    : Parameter


**::math::special::dn** *u* *k*
: Compute the elliptic function *dn* for the argument "u" and parameter "k".

    float *u*
    : Argument for the function

    float *k*
    : Parameter


**::math::special::sn** *u* *k*
: Compute the elliptic function *sn* for the argument "u" and parameter "k".

    float *u*
    : Argument for the function

    float *k*
    : Parameter


**::math::special::elliptic\_K** *k*
: Compute the complete elliptic integral of the first kind for the argument "k"

    float *k*
    : Argument for the function


**::math::special::elliptic\_E** *k*
: Compute the complete elliptic integral of the second kind for the argument "k"

    float *k*
    : Argument for the function


**::math::special::exponential\_Ei** *x*
: Compute the exponential integral of the second kind for the argument "x"

    float *x*
    : Argument for the function (x != 0)


**::math::special::exponential\_En** *n* *x*
: Compute the exponential integral of the first kind for the argument "x" and order n

    int *n*
    : Order of the integral (n >= 0)

    float *x*
    : Argument for the function (x >= 0)


**::math::special::exponential\_li** *x*
: Compute the logarithmic integral for the argument "x"

    float *x*
    : Argument for the function (x > 0)


**::math::special::exponential\_Ci** *x*
: Compute the cosine integral for the argument "x"

    float *x*
    : Argument for the function (x > 0)


**::math::special::exponential\_Si** *x*
: Compute the sine integral for the argument "x"

    float *x*
    : Argument for the function (x > 0)


**::math::special::exponential\_Chi** *x*
: Compute the hyperbolic cosine integral for the argument "x"

    float *x*
    : Argument for the function (x > 0)


**::math::special::exponential\_Shi** *x*
: Compute the hyperbolic sine integral for the argument "x"

    float *x*
    : Argument for the function (x > 0)


**::math::special::fresnel\_C** *x*
: Compute the Fresnel cosine integral for real argument x

    float *x*
    : Argument for the function


**::math::special::fresnel\_S** *x*
: Compute the Fresnel sine integral for real argument x

    float *x*
    : Argument for the function


**::math::special::sinc** *x*
: Compute the sinc function for real argument x

    float *x*
    : Argument for the function


**::math::special::legendre** *n*
: Return the Legendre polynomial of degree n (see [The orthogonal polynomials])

    int *n*
    : Degree of the polynomial


**::math::special::chebyshev** *n*
: Return the Chebyshev polynomial of degree n (of the first kind)

    int *n*
    : Degree of the polynomial


**::math::special::laguerre** *alpha* *n*
: Return the Laguerre polynomial of degree n with parameter alpha

    float *alpha*
    : Parameter of the Laguerre polynomial

    int *n*
    : Degree of the polynomial


**::math::special::hermite** *n*
: Return the Hermite polynomial of degree n

    int *n*
    : Degree of the polynomial



# The orthogonal polynomials

For dealing with the classical families of orthogonal polynomials, the package relies on the *math::polynomials* package. To evaluate the polynomial at some coordinate, use the *evalPolyn* command:

```
   set leg2 [::math::special::legendre 2]
   puts "Value at x=$x: [::math::polynomials::evalPolyn $leg2 $x]"
```

The return value from the *legendre* and other commands is actually the definition of the corresponding polynomial as used in that package.

# Remarks on the implementation

It should be noted, that the actual implementation of J0 and J1 depends on straightforward Gaussian quadrature formulas. The (absolute) accuracy of the results is of the order 1.0e-4 or better. The main reason to implement them like that was that it was fast to do (the formulas are simple) and the computations are fast too.

The implementation of J1/2 does not suffer from this: this function can be expressed exactly in terms of elementary functions.

The functions J0 and J1 are the ones you will encounter most frequently in practice.

The computation of I\_n is based on Miller's algorithm for computing the minimal function from recurrence relations.

The computation of the Gamma and Beta functions relies on the combinatorics package, whereas that of the error functions relies on the statistics package.

The computation of the complete elliptic integrals uses the AGM algorithm.

Much information about these functions can be found in:

Abramowitz and Stegun: *Handbook of Mathematical Functions* (Dover, ISBN 486-61272-4)

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: special* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
