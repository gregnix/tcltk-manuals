---
CommandName: math::polynomials
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - math
 - polynomial functions
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::polynomials - Polynomial functions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.optlit} 
[package]{.cmd} [require]{.sub} [math::polynomials]{.lit} [1.0.2]{.optlit} 
[::math::polynomials::polynomial]{.cmd} [coeffs]{.arg} 
[::math::polynomials::polynCmd]{.cmd} [coeffs]{.arg} 
[::math::polynomials::evalPolyn]{.cmd} [polynomial]{.arg} [x]{.arg} 
[::math::polynomials::addPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg} 
[::math::polynomials::subPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg} 
[::math::polynomials::multPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg} 
[::math::polynomials::divPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg} 
[::math::polynomials::remainderPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg} 
[::math::polynomials::derivPolyn]{.cmd} [polyn]{.arg} 
[::math::polynomials::primitivePolyn]{.cmd} [polyn]{.arg} 
[::math::polynomials::degreePolyn]{.cmd} [polyn]{.arg} 
[::math::polynomials::coeffPolyn]{.cmd} [polyn]{.arg} [index]{.arg} 
[::math::polynomials::allCoeffsPolyn]{.cmd} [polyn]{.arg} 
:::

# Description

This package deals with polynomial functions of one variable:

**•**
: the basic arithmetic operations are extended to polynomials

**•**
: computing the derivatives and primitives of these functions

**•**
: evaluation through a general procedure or via specific procedures)


# Procedures

The package defines the following public procedures:

**::math::polynomials::polynomial** *coeffs*
: Return an (encoded) list that defines the polynomial. A polynomial


```
   f(x) = a + b.x + c.x**2 + d.x**3
```

: can be defined via:


```
   set f [::math::polynomials::polynomial [list $a $b $c $d]
```

list *coeffs*
: Coefficients of the polynomial (in ascending order)


**::math::polynomials::polynCmd** *coeffs*
: Create a new procedure that evaluates the polynomial. The name of the polynomial is automatically generated. Useful if you need to evualuate the polynomial many times, as the procedure consists of a single \[expr\] command.


list *coeffs*
: Coefficients of the polynomial (in ascending order) or the polynomial definition returned by the *polynomial* command.


**::math::polynomials::evalPolyn** *polynomial* *x*
: Evaluate the polynomial at x.


list *polynomial*
: The polynomial's definition (as returned by the polynomial command). order)

float *x*
: The coordinate at which to evaluate the polynomial


**::math::polynomials::addPolyn** *polyn1* *polyn2*
: Return a new polynomial which is the sum of the two others.


list *polyn1*
: The first polynomial operand

list *polyn2*
: The second polynomial operand


**::math::polynomials::subPolyn** *polyn1* *polyn2*
: Return a new polynomial which is the difference of the two others.


list *polyn1*
: The first polynomial operand

list *polyn2*
: The second polynomial operand


**::math::polynomials::multPolyn** *polyn1* *polyn2*
: Return a new polynomial which is the product of the two others. If one of the arguments is a scalar value, the other polynomial is simply scaled.


list *polyn1*
: The first polynomial operand or a scalar

list *polyn2*
: The second polynomial operand or a scalar


**::math::polynomials::divPolyn** *polyn1* *polyn2*
: Divide the first polynomial by the second polynomial and return the result. The remainder is dropped


list *polyn1*
: The first polynomial operand

list *polyn2*
: The second polynomial operand


**::math::polynomials::remainderPolyn** *polyn1* *polyn2*
: Divide the first polynomial by the second polynomial and return the remainder.


list *polyn1*
: The first polynomial operand

list *polyn2*
: The second polynomial operand


**::math::polynomials::derivPolyn** *polyn*
: Differentiate the polynomial and return the result.


list *polyn*
: The polynomial to be differentiated


**::math::polynomials::primitivePolyn** *polyn*
: Integrate the polynomial and return the result. The integration constant is set to zero.


list *polyn*
: The polynomial to be integrated


**::math::polynomials::degreePolyn** *polyn*
: Return the degree of the polynomial.


list *polyn*
: The polynomial to be examined


**::math::polynomials::coeffPolyn** *polyn* *index*
: Return the coefficient of the term of the index'th degree of the polynomial.


list *polyn*
: The polynomial to be examined

int *index*
: The degree of the term


**::math::polynomials::allCoeffsPolyn** *polyn*
: Return the coefficients of the polynomial (in ascending order).


list *polyn*
: The polynomial in question


# Remarks on the implementation

The implementation for evaluating the polynomials at some point uses Horn's rule, which guarantees numerical stability and a minimum of arithmetic operations. To recognise that a polynomial definition is indeed a correct definition, it consists of a list of two elements: the keyword "POLYNOMIAL" and the list of coefficients in descending order. The latter makes it easier to implement Horner's rule.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: polynomials* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
