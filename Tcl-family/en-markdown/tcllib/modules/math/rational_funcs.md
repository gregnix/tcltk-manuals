---
CommandName: math::rationalfunctions
title: math::rationalfunctions
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Math
Keywords:
 - math
 - rational functions
Copyright:
 - Copyright (c) 2005 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::rationalfunctions - Polynomial functions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::rationalfunctions]{.lit} [1.0.2]{.optlit}
[::math::rationalfunctions::rationalFunction]{.cmd} [num]{.arg} [den]{.arg}
[::math::rationalfunctions::ratioCmd]{.cmd} [num]{.arg} [den]{.arg}
[::math::rationalfunctions::evalRatio]{.cmd} [rational]{.arg} [x]{.arg}
[::math::rationalfunctions::addRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg}
[::math::rationalfunctions::subRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg}
[::math::rationalfunctions::multRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg}
[::math::rationalfunctions::divRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg}
[::math::rationalfunctions::derivPolyn]{.cmd} [ratio]{.arg}
[::math::rationalfunctions::coeffsNumerator]{.cmd} [ratio]{.arg}
[::math::rationalfunctions::coeffsDenominator]{.cmd} [ratio]{.arg}
:::

# Description

This package deals with rational functions of one variable:

- the basic arithmetic operations are extended to rational functions

- computing the derivatives of these functions

- evaluation through a general procedure or via specific procedures)


# Procedures

The package defines the following public procedures:

**::math::rationalfunctions::rationalFunction** *num* *den*
: Return an (encoded) list that defines the rational function. A rational function

    ```
                 1 + x^3
       f(x) = ------------
              1 + 2x + x^2
    ```

    can be defined via:

    ```
       set f [::math::rationalfunctions::rationalFunction [list 1 0 0 1]  [list 1 2 1]]
    ```

    list *num*
    : Coefficients of the numerator of the rational function (in ascending order)

    list *den*
    : Coefficients of the denominator of the rational function (in ascending order)


**::math::rationalfunctions::ratioCmd** *num* *den*
: Create a new procedure that evaluates the rational function. The name of the function is automatically generated. Useful if you need to evaluate the function many times, as the procedure consists of a single \[expr\] command.

    list *num*
    : Coefficients of the numerator of the rational function (in ascending order)

    list *den*
    : Coefficients of the denominator of the rational function (in ascending order)


**::math::rationalfunctions::evalRatio** *rational* *x*
: Evaluate the rational function at x.

    list *rational*
    : The rational function's definition (as returned by the rationalFunction command). order)

    float *x*
    : The coordinate at which to evaluate the function


**::math::rationalfunctions::addRatio** *ratio1* *ratio2*
: Return a new rational function which is the sum of the two others.

    list *ratio1*
    : The first rational function operand

    list *ratio2*
    : The second rational function operand


**::math::rationalfunctions::subRatio** *ratio1* *ratio2*
: Return a new rational function which is the difference of the two others.

    list *ratio1*
    : The first rational function operand

    list *ratio2*
    : The second rational function operand


**::math::rationalfunctions::multRatio** *ratio1* *ratio2*
: Return a new rational function which is the product of the two others. If one of the arguments is a scalar value, the other rational function is simply scaled.

    list *ratio1*
    : The first rational function operand or a scalar

    list *ratio2*
    : The second rational function operand or a scalar


**::math::rationalfunctions::divRatio** *ratio1* *ratio2*
: Divide the first rational function by the second rational function and return the result. The remainder is dropped

    list *ratio1*
    : The first rational function operand

    list *ratio2*
    : The second rational function operand


**::math::rationalfunctions::derivPolyn** *ratio*
: Differentiate the rational function and return the result.

    list *ratio*
    : The rational function to be differentiated


**::math::rationalfunctions::coeffsNumerator** *ratio*
: Return the coefficients of the numerator of the rational function.

    list *ratio*
    : The rational function to be examined


**::math::rationalfunctions::coeffsDenominator** *ratio*
: Return the coefficients of the denominator of the rational function.

    list *ratio*
    : The rational function to be examined



# Remarks on the implementation

The implementation of the rational functions relies on the math::polynomials package. For further remarks see the documentation on that package.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: rationalfunctions* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2005 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
