---
CommandName: math::trig
title: math::trig
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - math
 - trigonometry
Copyright:
 - Copyright (c) 2018 Arjen Markus
---

# Name

math::trig - Trigonometric anf hyperbolic functions

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [math::trig]{.lit} [1.1]{.lit}
[::math::trig::radian\_reduced]{.cmd} [angle]{.arg}
[::math::trig::degree\_reduced]{.cmd} [angle]{.arg}
[::math::trig::cosec]{.cmd} [angle]{.arg}
[::math::trig::sec]{.cmd} [angle]{.arg}
[::math::trig::cotan]{.cmd} [angle]{.arg}
[::math::trig::acosec]{.cmd} [value]{.arg}
[::math::trig::asec]{.cmd} [value]{.arg}
[::math::trig::acotan]{.cmd} [value]{.arg}
[::math::trig::cosech]{.cmd} [value]{.arg}
[::math::trig::sech]{.cmd} [value]{.arg}
[::math::trig::cotanh]{.cmd} [value]{.arg}
[::math::trig::asinh]{.cmd} [value]{.arg}
[::math::trig::acosh]{.cmd} [value]{.arg}
[::math::trig::atanh]{.cmd} [value]{.arg}
[::math::trig::acosech]{.cmd} [value]{.arg}
[::math::trig::asech]{.cmd} [value]{.arg}
[::math::trig::acotanh]{.cmd} [value]{.arg}
[::math::trig::sind]{.cmd} [angle]{.arg}
[::math::trig::cosd]{.cmd} [angle]{.arg}
[::math::trig::tand]{.cmd} [angle]{.arg}
[::math::trig::cosecd]{.cmd} [angle]{.arg}
[::math::trig::secd]{.cmd} [angle]{.arg}
[::math::trig::cotand]{.cmd} [angle]{.arg}
:::

# Description

The *math::trig* package defines a set of trigonomic and hyperbolic functions and their inverses. In addition it defines versions of the trigonomic functions that take arguments in degrees instead of radians.

For easy use these functions may be imported into the *tcl::mathfunc* namespace, so that they can be used directly in the *expr* command.

# Functions

The functions *radian\_reduced* and *degree\_reduced* return a reduced angle, in respectively radians and degrees, in the intervals \[0, 2pi) and \[0, 360):

**::math::trig::radian\_reduced** *angle*
: Return the equivalent angle in the interval \[0, 2pi).

    float *angle*
    : Angle (in radians)


**::math::trig::degree\_reduced** *angle*
: Return the equivalent angle in the interval \[0, 360).

    float *angle*
    : Angle (in degrees)



The following trigonomic functions are defined in addition to the ones defined in the *expr* command:

**::math::trig::cosec** *angle*
: Calculate the cosecant of the angle (1/cos(angle))

    float *angle*
    : Angle (in radians)


**::math::trig::sec** *angle*
: Calculate the secant of the angle (1/sin(angle))

    float *angle*
    : Angle (in radians)


**::math::trig::cotan** *angle*
: Calculate the cotangent of the angle (1/tan(angle))

    float *angle*
    : Angle (in radians)



For these functions also the inverses are defined:

**::math::trig::acosec** *value*
: Calculate the arc cosecant of the value

    float *value*
    : Value of the argument


**::math::trig::asec** *value*
: Calculate the arc secant of the value

    float *value*
    : Value of the argument


**::math::trig::acotan** *value*
: Calculate the arc cotangent of the value

    float *value*
    : Value of the argument



The following hyperbolic and inverse hyperbolic functions are defined:

**::math::trig::cosech** *value*
: Calculate the hyperbolic cosecant of the value (1/sinh(value))

    float *value*
    : Value of the argument


**::math::trig::sech** *value*
: Calculate the hyperbolic secant of the value (1/cosh(value))

    float *value*
    : Value of the argument


**::math::trig::cotanh** *value*
: Calculate the hyperbolic cotangent of the value (1/tanh(value))

    float *value*
    : Value of the argument


**::math::trig::asinh** *value*
: Calculate the arc hyperbolic sine of the value

    float *value*
    : Value of the argument


**::math::trig::acosh** *value*
: Calculate the arc hyperbolic cosine of the value

    float *value*
    : Value of the argument


**::math::trig::atanh** *value*
: Calculate the arc hyperbolic tangent of the value

    float *value*
    : Value of the argument


**::math::trig::acosech** *value*
: Calculate the arc hyperbolic cosecant of the value

    float *value*
    : Value of the argument


**::math::trig::asech** *value*
: Calculate the arc hyperbolic secant of the value

    float *value*
    : Value of the argument


**::math::trig::acotanh** *value*
: Calculate the arc hyperbolic cotangent of the value

    float *value*
    : Value of the argument



The following versions of the common trigonometric functions and their inverses are defined:

**::math::trig::sind** *angle*
: Calculate the sine of the angle (in degrees)

    float *angle*
    : Angle (in degrees)


**::math::trig::cosd** *angle*
: Calculate the cosine of the angle (in degrees)

    float *angle*
    : Angle (in radians)


**::math::trig::tand** *angle*
: Calculate the cotangent of the angle (in degrees)

    float *angle*
    : Angle (in degrees)


**::math::trig::cosecd** *angle*
: Calculate the cosecant of the angle (in degrees)

    float *angle*
    : Angle (in degrees)


**::math::trig::secd** *angle*
: Calculate the secant of the angle (in degrees)

    float *angle*
    : Angle (in degrees)


**::math::trig::cotand** *angle*
: Calculate the cotangent of the angle (in degrees)

    float *angle*
    : Angle (in degrees)



# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: trig* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2018 Arjen Markus
```
