---
CommandName: math::complexnumbers
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - complex numbers
 - math
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::complexnumbers - Straightforward complex number package

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::complexnumbers]{.lit} [1.0.3]{.optlit} 
[::math::complexnumbers::+]{.cmd} [z1]{.arg} [z2]{.arg} 
[::math::complexnumbers::-]{.cmd} [z1]{.arg} [z2]{.arg} 
[::math::complexnumbers::\*]{.cmd} [z1]{.arg} [z2]{.arg} 
[::math::complexnumbers::/]{.cmd} [z1]{.arg} [z2]{.arg} 
[::math::complexnumbers::conj]{.cmd} [z1]{.arg} 
[::math::complexnumbers::real]{.cmd} [z1]{.arg} 
[::math::complexnumbers::imag]{.cmd} [z1]{.arg} 
[::math::complexnumbers::mod]{.cmd} [z1]{.arg} 
[::math::complexnumbers::arg]{.cmd} [z1]{.arg} 
[::math::complexnumbers::complex]{.cmd} [real]{.arg} [imag]{.arg} 
[::math::complexnumbers::tostring]{.cmd} [z1]{.arg} 
[::math::complexnumbers::exp]{.cmd} [z1]{.arg} 
[::math::complexnumbers::sin]{.cmd} [z1]{.arg} 
[::math::complexnumbers::cos]{.cmd} [z1]{.arg} 
[::math::complexnumbers::tan]{.cmd} [z1]{.arg} 
[::math::complexnumbers::log]{.cmd} [z1]{.arg} 
[::math::complexnumbers::sqrt]{.cmd} [z1]{.arg} 
[::math::complexnumbers::pow]{.cmd} [z1]{.arg} [z2]{.arg} 
:::

# Description

The mathematical module *complexnumbers* provides a straightforward implementation of complex numbers in pure Tcl. The philosophy is that the user knows he or she is dealing with complex numbers in an abstract way and wants as high a performance as can be had within the limitations of an interpreted language.

Therefore the procedures defined in this package assume that the arguments are valid (representations of) "complex numbers", that is, lists of two numbers defining the real and imaginary part of a complex number (though this is a mere detail: rely on the *complex* command to construct a valid number.)

Most procedures implement the basic arithmetic operations or elementary functions whereas several others convert to and from different representations:

```
    set z [complex 0 1]
    puts "z = [tostring $z]"
    puts "z**2 = [* $z $z]
```

would result in:

```
    z = i
    z**2 = -1
```

# Available procedures

The package implements all or most basic operations and elementary functions.

*The arithmetic operations are:*

**::math::complexnumbers::+** *z1* *z2*
: Add the two arguments and return the resulting complex number


complex *z1* (in)
: First argument in the summation

complex *z2* (in)
: Second argument in the summation


**::math::complexnumbers::-** *z1* *z2*
: Subtract the second argument from the first and return the resulting complex number. If there is only one argument, the opposite of z1 is returned (i.e. -z1)


complex *z1* (in)
: First argument in the subtraction

complex *z2* (in)
: Second argument in the subtraction (optional)


**::math::complexnumbers::\*** *z1* *z2*
: Multiply the two arguments and return the resulting complex number


complex *z1* (in)
: First argument in the multiplication

complex *z2* (in)
: Second argument in the multiplication


**::math::complexnumbers::/** *z1* *z2*
: Divide the first argument by the second and return the resulting complex number


complex *z1* (in)
: First argument (numerator) in the division

complex *z2* (in)
: Second argument (denominator) in the division


**::math::complexnumbers::conj** *z1*
: Return the conjugate of the given complex number


complex *z1* (in)
: Complex number in question


*Conversion/inquiry procedures:*

**::math::complexnumbers::real** *z1*
: Return the real part of the given complex number


complex *z1* (in)
: Complex number in question


**::math::complexnumbers::imag** *z1*
: Return the imaginary part of the given complex number


complex *z1* (in)
: Complex number in question


**::math::complexnumbers::mod** *z1*
: Return the modulus of the given complex number


complex *z1* (in)
: Complex number in question


**::math::complexnumbers::arg** *z1*
: Return the argument ("angle" in radians) of the given complex number


complex *z1* (in)
: Complex number in question


**::math::complexnumbers::complex** *real* *imag*
: Construct the complex number "real + imag\*i" and return it


float *real* (in)
: The real part of the new complex number

float *imag* (in)
: The imaginary part of the new complex number


**::math::complexnumbers::tostring** *z1*
: Convert the complex number to the form "real + imag\*i" and return the string


float *complex* (in)
: The complex number to be converted


*Elementary functions:*

**::math::complexnumbers::exp** *z1*
: Calculate the exponential for the given complex argument and return the result


complex *z1* (in)
: The complex argument for the function


**::math::complexnumbers::sin** *z1*
: Calculate the sine function for the given complex argument and return the result


complex *z1* (in)
: The complex argument for the function


**::math::complexnumbers::cos** *z1*
: Calculate the cosine function for the given complex argument and return the result


complex *z1* (in)
: The complex argument for the function


**::math::complexnumbers::tan** *z1*
: Calculate the tangent function for the given complex argument and return the result


complex *z1* (in)
: The complex argument for the function


**::math::complexnumbers::log** *z1*
: Calculate the (principle value of the) logarithm for the given complex argument and return the result


complex *z1* (in)
: The complex argument for the function


**::math::complexnumbers::sqrt** *z1*
: Calculate the (principle value of the) square root for the given complex argument and return the result


complex *z1* (in)
: The complex argument for the function


**::math::complexnumbers::pow** *z1* *z2*
: Calculate "z1 to the power of z2" and return the result


complex *z1* (in)
: The complex number to be raised to a power

complex *z2* (in)
: The complex power to be used


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: complexnumbers* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
