---
CommandName: math::calculus
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Links:
 - romberg
Keywords:
 - calculus
 - differential equations
 - integration
 - math
 - roots
Copyright:
 - Copyright (c) 2002,2003,2004 Arjen Markus
---

# Name

math::calculus - Integration and ordinary differential equations

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::calculus]{.lit} [1.1]{.lit} 
[::math::calculus::integral]{.cmd} [begin]{.arg} [end]{.arg} [nosteps]{.arg} [func]{.arg} 
[::math::calculus::integralExpr]{.cmd} [begin]{.arg} [end]{.arg} [nosteps]{.arg} [expression]{.arg} 
[::math::calculus::integral2D]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [func]{.arg} 
[::math::calculus::integral2D_accurate]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [func]{.arg} 
[::math::calculus::integral3D]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [zinterval]{.arg} [func]{.arg} 
[::math::calculus::integral3D_accurate]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [zinterval]{.arg} [func]{.arg} 
[::math::calculus::qk15]{.cmd} [xstart]{.arg} [xend]{.arg} [func]{.arg} [nosteps]{.arg} 
[::math::calculus::qk15_detailed]{.cmd} [xstart]{.arg} [xend]{.arg} [func]{.arg} [nosteps]{.arg} 
[::math::calculus::eulerStep]{.cmd} [t]{.arg} [tstep]{.arg} [xvec]{.arg} [func]{.arg} 
[::math::calculus::heunStep]{.cmd} [t]{.arg} [tstep]{.arg} [xvec]{.arg} [func]{.arg} 
[::math::calculus::rungeKuttaStep]{.cmd} [t]{.arg} [tstep]{.arg} [xvec]{.arg} [func]{.arg} 
[::math::calculus::boundaryValueSecondOrder]{.cmd} [coeff_func]{.arg} [force_func]{.arg} [leftbnd]{.arg} [rightbnd]{.arg} [nostep]{.arg} 
[::math::calculus::solveTriDiagonal]{.cmd} [acoeff]{.arg} [bcoeff]{.arg} [ccoeff]{.arg} [dvalue]{.arg} 
[::math::calculus::newtonRaphson]{.cmd} [func]{.arg} [deriv]{.arg} [initval]{.arg} 
[::math::calculus::newtonRaphsonParameters]{.cmd} [maxiter]{.arg} [tolerance]{.arg} 
[::math::calculus::regula_falsi]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_bisection]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_secant]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_brent]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_chandrupatla]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
:::

# Description

This package implements several simple mathematical algorithms:

**•**
: The integration of a function over an interval

**•**
: The numerical integration of a system of ordinary differential equations.

**•**
: Estimating the root(s) of an equation of one variable. The package is fully implemented in Tcl. No particular attention has been paid to the accuracy of the calculations. Instead, well-known algorithms have been used in a straightforward manner. This document describes the procedures and explains their usage.


# Procedures

This package defines the following public procedures:

**::math::calculus::integral** *begin* *end* *nosteps* *func*
: Determine the integral of the given function using the Simpson rule. The interval for the integration is \[*begin*, *end*\]. The remaining arguments are:


*nosteps*
: Number of steps in which the interval is divided.

*func*
: Function to be integrated. It should take one single argument.


**::math::calculus::integralExpr** *begin* *end* *nosteps* *expression*
: Similar to the previous proc, this one determines the integral of the given *expression* using the Simpson rule. The interval for the integration is \[*begin*, *end*\]. The remaining arguments are:


*nosteps*
: Number of steps in which the interval is divided.

*expression*
: Expression to be integrated. It should use the variable "x" as the only variable (the "integrate")


**::math::calculus::integral2D** *xinterval* *yinterval* *func*
: ...see next...

**::math::calculus::integral2D_accurate** *xinterval* *yinterval* *func*
: The commands **integral2D** and **integral2D_accurate** calculate the integral of a function of two variables over the rectangle given by the first two arguments, each a list of three items, the start and stop interval for the variable and the number of steps. The command **integral2D** evaluates the function at the centre of each rectangle, whereas the command **integral2D_accurate** uses a four-point quadrature formula. This results in an exact integration of polynomials of third degree or less. The function must take two arguments and return the function value.

**::math::calculus::integral3D** *xinterval* *yinterval* *zinterval* *func*
: ...see next...

**::math::calculus::integral3D_accurate** *xinterval* *yinterval* *zinterval* *func*
: The commands **integral3D** and **integral3D_accurate** are the three-dimensional equivalent of **integral2D** and **integral3D_accurate**. The function *func* takes three arguments and is integrated over the block in 3D space given by three intervals.

**::math::calculus::qk15** *xstart* *xend* *func* *nosteps*
: Determine the integral of the given function using the Gauss-Kronrod 15 points quadrature rule. The returned value is the estimate of the integral over the interval \[*xstart*, *xend*\]. The remaining arguments are:


*func*
: Function to be integrated. It should take one single argument.

**?nosteps?**
: Number of steps in which the interval is divided. Defaults to 1.


**::math::calculus::qk15_detailed** *xstart* *xend* *func* *nosteps*
: Determine the integral of the given function using the Gauss-Kronrod 15 points quadrature rule. The interval for the integration is \[*xstart*, *xend*\]. The procedure returns a list of four values:


**•**
: The estimate of the integral over the specified interval (I).

**•**
: An estimate of the absolute error in I.

**•**
: The estimate of the integral of the absolute value of the function over the interval.

**•**
: The estimate of the integral of the absolute value of the function minus its mean over the interval.


: The remaining arguments are:


*func*
: Function to be integrated. It should take one single argument.

**?nosteps?**
: Number of steps in which the interval is divided. Defaults to 1.


**::math::calculus::eulerStep** *t* *tstep* *xvec* *func*
: Set a single step in the numerical integration of a system of differential equations. The method used is Euler's.


*t*
: Value of the independent variable (typically time) at the beginning of the step.

*tstep*
: Step size for the independent variable.

*xvec*
: List (vector) of dependent values

*func*
: Function of t and the dependent values, returning a list of the derivatives of the dependent values. (The lengths of xvec and the return value of "func" must match).


**::math::calculus::heunStep** *t* *tstep* *xvec* *func*
: Set a single step in the numerical integration of a system of differential equations. The method used is Heun's.


*t*
: Value of the independent variable (typically time) at the beginning of the step.

*tstep*
: Step size for the independent variable.

*xvec*
: List (vector) of dependent values

*func*
: Function of t and the dependent values, returning a list of the derivatives of the dependent values. (The lengths of xvec and the return value of "func" must match).


**::math::calculus::rungeKuttaStep** *t* *tstep* *xvec* *func*
: Set a single step in the numerical integration of a system of differential equations. The method used is Runge-Kutta 4th order.


*t*
: Value of the independent variable (typically time) at the beginning of the step.

*tstep*
: Step size for the independent variable.

*xvec*
: List (vector) of dependent values

*func*
: Function of t and the dependent values, returning a list of the derivatives of the dependent values. (The lengths of xvec and the return value of "func" must match).


**::math::calculus::boundaryValueSecondOrder** *coeff_func* *force_func* *leftbnd* *rightbnd* *nostep*
: Solve a second order linear differential equation with boundary values at two sides. The equation has to be of the form (the "conservative" form):


```
         d      dy     d
         -- A(x)--  +  -- B(x)y + C(x)y  =  D(x)
         dx     dx     dx
```

: Ordinarily, such an equation would be written as:


```
             d2y        dy
         a(x)---  + b(x)-- + c(x) y  =  D(x)
             dx2        dx
```

: The first form is easier to discretise (by integrating over a finite volume) than the second form. The relation between the two forms is fairly straightforward:


```
         A(x)  =  a(x)
         B(x)  =  b(x) - a'(x)
         C(x)  =  c(x) - B'(x)  =  c(x) - b'(x) + a''(x)
```

: Because of the differentiation, however, it is much easier to ask the user to provide the functions A, B and C directly.


*coeff_func*
: Procedure returning the three coefficients (A, B, C) of the equation, taking as its one argument the x-coordinate.

*force_func*
: Procedure returning the right-hand side (D) as a function of the x-coordinate.

*leftbnd*
: A list of two values: the x-coordinate of the left boundary and the value at that boundary.

*rightbnd*
: A list of two values: the x-coordinate of the right boundary and the value at that boundary.

*nostep*
: Number of steps by which to discretise the interval. The procedure returns a list of x-coordinates and the approximated values of the solution.


**::math::calculus::solveTriDiagonal** *acoeff* *bcoeff* *ccoeff* *dvalue*
: Solve a system of linear equations Ax = b with A a tridiagonal matrix. Returns the solution as a list.


*acoeff*
: List of values on the lower diagonal

*bcoeff*
: List of values on the main diagonal

*ccoeff*
: List of values on the upper diagonal

*dvalue*
: List of values on the righthand-side


**::math::calculus::newtonRaphson** *func* *deriv* *initval*
: Determine the root of an equation given by


```
    func(x) = 0
```

: using the method of Newton-Raphson. The procedure takes the following arguments:


*func*
: Procedure that returns the value the function at x

*deriv*
: Procedure that returns the derivative of the function at x

*initval*
: Initial value for x


**::math::calculus::newtonRaphsonParameters** *maxiter* *tolerance*
: Set the numerical parameters for the Newton-Raphson method:


*maxiter*
: Maximum number of iteration steps (defaults to 20)

*tolerance*
: Relative precision (defaults to 0.001)


**::math::calculus::regula_falsi** *f* *xb* *xe* *eps*
: Return an estimate of the zero or one of the zeros of the function contained in the interval \[xb,xe\]. The error in this estimate is of the order of eps\*abs(xe-xb), the actual error may be slightly larger. The method used is the so-called *regula falsi* or *false position* method. It is a straightforward implementation. The method is robust, but requires that the interval brackets a zero or at least an uneven number of zeros, so that the value of the function at the start has a different sign than the value at the end. In contrast to Newton-Raphson there is no need for the computation of the function's derivative.


command *f*
: Name of the command that evaluates the function for which the zero is to be returned

float *xb*
: Start of the interval in which the zero is supposed to lie

float *xe*
: End of the interval

float *eps*
: Relative allowed error (defaults to 1.0e-4)


**::math::calculus::root_bisection** *f* *xb* *xe* *eps*
: Return an estimate of the zero or one of the zeros of the function contained in the interval \[xb,xe\]. The error in this estimate is of the order of eps\*abs(xe-xb), the actual error may be slightly larger. The method used is the so-called *bisection*. For properties: see the *regula falsi* procedure.


command *f*
: Name of the command that evaluates the function for which the zero is to be returned

float *xb*
: Start of the interval in which the zero is supposed to lie

float *xe*
: End of the interval

float *eps*
: Relative allowed error (defaults to 1.0e-7)


**::math::calculus::root_secant** *f* *xb* *xe* *eps*
: Return an estimate of the zero or one of the zeros of the function contained in the interval \[xb,xe\]. The error in this estimate is of the order of eps\*abs(xe-xb), the actual error may be slightly larger. The method used is the so-called *secant* method. For properties: see the *regula falsi* procedure. Note that this method is not guaranteed to produce a zero, but it is fast.


command *f*
: Name of the command that evaluates the function for which the zero is to be returned

float *xb*
: Start of the interval in which the zero is supposed to lie

float *xe*
: End of the interval

float *eps*
: Relative allowed error (defaults to 1.0e-7)


**::math::calculus::root_brent** *f* *xb* *xe* *eps*
: Return an estimate of the zero or one of the zeros of the function contained in the interval \[xb,xe\]. The error in this estimate is of the order of eps\*abs(xe-xb), the actual error may be slightly larger. The method used is the so-called *Brent* method. For properties: see the *regula falsi* procedure.


command *f*
: Name of the command that evaluates the function for which the zero is to be returned

float *xb*
: Start of the interval in which the zero is supposed to lie

float *xe*
: End of the interval

float *eps*
: Relative allowed error (defaults to 1.0e-7)


**::math::calculus::root_chandrupatla** *f* *xb* *xe* *eps*
: Return an estimate of the zero or one of the zeros of the function contained in the interval \[xb,xe\]. The error in this estimate is of the order of eps\*abs(xe-xb), the actual error may be slightly larger. The method used is the so-called *Chandrupatla* method. It is a variant of the Brent method and is reputed to be faster. See *https://www.embeddedrelated.com/showarticle/855.php* for a discussion.


command *f*
: Name of the command that evaluates the function for which the zero is to be returned

float *xb*
: Start of the interval in which the zero is supposed to lie

float *xe*
: End of the interval

float *eps*
: Relative allowed error (defaults to 1.0e-7)


*Notes:*

Several of the above procedures take the *names* of procedures as arguments. To avoid problems with the *visibility* of these procedures, the fully-qualified name of these procedures is determined inside the calculus routines. For the user this has only one consequence: the named procedure must be visible in the calling procedure. For instance:

```
    namespace eval ::mySpace {
       namespace export calcfunc
       proc calcfunc { x } { return $x }
    }
    #
    # Use a fully-qualified name
    #
    namespace eval ::myCalc {
       proc detIntegral { begin end } {
          return [integral $begin $end 100 ::mySpace::calcfunc]
       }
    }
    #
    # Import the name
    #
    namespace eval ::myCalc {
       namespace import ::mySpace::calcfunc
       proc detIntegral { begin end } {
          return [integral $begin $end 100 calcfunc]
       }
    }
```

Enhancements for the second-order boundary value problem:

**•**
: Other types of boundary conditions (zero gradient, zero flux)

**•**
: Other schematisation of the first-order term (now central differences are used, but upstream differences might be useful too).

**•**
: The various root finding methods differ in robustness, ease of use and convergence rates. While the Newton-Raphson method is quite fast (quadratic convergence), it is not guaranteed to produce an answer. The methods that bracket the root, require two starting points, but except for the secant method are guaranteed to deliver a good estimate.


# Examples

Let us take a few simple examples:

Integrate x over the interval \[0,100\] (20 steps):

```
proc linear_func { x } { return $x }
puts "Integral: [::math::calculus::integral 0 100 20 linear_func]"
```

For simple functions, the alternative could be:

```
puts "Integral: [::math::calculus::integralExpr 0 100 20 {$x}]"
```

Do not forget the braces!

The differential equation for a dampened oscillator:

```
x'' + rx' + wx = 0
```

can be split into a system of first-order equations:

```
x' = y
y' = -ry - wx
```

Then this system can be solved with code like this:

```
proc dampened_oscillator { t xvec } {
   set x  [lindex $xvec 0]
   set x1 [lindex $xvec 1]
   return [list $x1 [expr {-$x1-$x}]]
}

set xvec   { 1.0 0.0 }
set t      0.0
set tstep  0.1
for { set i 0 } { $i < 20 } { incr i } {
   set result [::math::calculus::eulerStep $t $tstep $xvec dampened_oscillator]
   puts "Result ($t): $result"
   set t      [expr {$t+$tstep}]
   set xvec   $result
}
```

Suppose we have the boundary value problem:

```
    Dy'' + ky = 0
    x = 0: y = 1
    x = L: y = 0
```

This boundary value problem could originate from the diffusion of a decaying substance.

It can be solved with the following fragment:

```
   proc coeffs { x } { return [list $::Diff 0.0 $::decay] }
   proc force  { x } { return 0.0 }

   set Diff   1.0e-2
   set decay  0.0001
   set length 100.0

   set y [::math::calculus::boundaryValueSecondOrder \
      coeffs force {0.0 1.0} [list $length 0.0] 100]
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: calculus* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2002,2003,2004 Arjen Markus
```
