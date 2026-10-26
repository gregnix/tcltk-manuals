---
CommandName: math::interpolate
title: math::interpolate
ManualSection: n
Version: 1.1.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - interpolation
 - math
 - spatial interpolation
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
 - Copyright (c) 2004 Kevn B. Kenny <kennykb@users.sourceforge.net>
---

# Name

math::interpolate - Interpolation routines

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [struct]{.lit}
[package]{.cmd} [require]{.sub} [math::interpolate]{.lit} [1.1.4]{.optlit}
[::math::interpolate::defineTable]{.cmd} [name]{.arg} [colnames]{.arg} [values]{.arg}
[::math::interpolate::interp-1d-table]{.cmd} [name]{.arg} [xval]{.arg}
[::math::interpolate::interp-table]{.cmd} [name]{.arg} [xval]{.arg} [yval]{.arg}
[::math::interpolate::interp-linear]{.cmd} [xyvalues]{.arg} [xval]{.arg}
[::math::interpolate::interp-lagrange]{.cmd} [xyvalues]{.arg} [xval]{.arg}
[::math::interpolate::prepare-cubic-splines]{.cmd} [xcoord]{.arg} [ycoord]{.arg}
[::math::interpolate::interp-cubic-splines]{.cmd} [coeffs]{.arg} [x]{.arg}
[::math::interpolate::interp-spatial]{.cmd} [xyvalues]{.arg} [coord]{.arg}
[::math::interpolate::interp-spatial-params]{.cmd} [max\_search]{.arg} [power]{.arg}
[::math::interpolate::neville]{.cmd} [xlist]{.arg} [ylist]{.arg} [x]{.arg}
:::

# Description

This package implements several interpolation algorithms:

- Interpolation into a table (one or two independent variables), this is useful for example, if the data are static, like with tables of statistical functions.

- Linear interpolation into a given set of data (organised as (x,y) pairs).

- Lagrange interpolation. This is mainly of theoretical interest, because there is no guarantee about error bounds. One possible use: if you need a line or a parabola through given points (it will calculate the values, but not return the coefficients).

    A variation is Neville's method which has better behaviour and error bounds.

- Spatial interpolation using a straightforward distance-weight method. This procedure allows any number of spatial dimensions and any number of dependent variables.

- Interpolation in one dimension using cubic splines.


This document describes the procedures and explains their usage.

# Incompatibility with version 1.0.3

The interpretation of the tables in the **::math::interpolate::interpolate-1d-table** command has been changed to be compatible with the interpretation for 2D interpolation in the **::math::interpolate::interpolate-table** command. As a consequence this version is incompatible with the previous versions of the command (1.0.x).

# Procedures

The interpolation package defines the following public procedures:

**::math::interpolate::defineTable** *name* *colnames* *values*
: Define a table with one or two independent variables (the distinction is implicit in the data). The procedure returns the name of the table - this name is used whenever you want to interpolate the values. *Note:* this procedure is a convenient wrapper for the struct::matrix procedure. Therefore you can access the data at any location in your program.

    string *name* (in)
    : Name of the table to be created

    list *colnames* (in)
    : List of column names

    list *values* (in)
    : List of values (the number of elements should be a multiple of the number of columns. See [Examples] for more information on the interpretation of the data.

        The values must be sorted with respect to the independent variable(s).


**::math::interpolate::interp-1d-table** *name* *xval*
: Interpolate into the one-dimensional table "name" and return a list of values, one for each dependent column.

    string *name* (in)
    : Name of an existing table

    float *xval* (in)
    : Value of the independent *row* variable


**::math::interpolate::interp-table** *name* *xval* *yval*
: Interpolate into the two-dimensional table "name" and return the interpolated value.

    string *name* (in)
    : Name of an existing table

    float *xval* (in)
    : Value of the independent *row* variable

    float *yval* (in)
    : Value of the independent *column* variable


**::math::interpolate::interp-linear** *xyvalues* *xval*
: Interpolate linearly into the list of x,y pairs and return the interpolated value.

    list *xyvalues* (in)
    : List of pairs of (x,y) values, sorted to increasing x. They are used as the breakpoints of a piecewise linear function.

    float *xval* (in)
    : Value of the independent variable for which the value of y must be computed.


**::math::interpolate::interp-lagrange** *xyvalues* *xval*
: Use the list of x,y pairs to construct the unique polynomial of lowest degree that passes through all points and return the interpolated value.

    list *xyvalues* (in)
    : List of pairs of (x,y) values

    float *xval* (in)
    : Value of the independent variable for which the value of y must be computed.


**::math::interpolate::prepare-cubic-splines** *xcoord* *ycoord*
: Returns a list of coefficients for the second routine *interp-cubic-splines* to actually interpolate.

    list *xcoord*
    : List of x-coordinates for the value of the function to be interpolated is known. The coordinates must be strictly ascending. At least three points are required.

    list *ycoord*
    : List of y-coordinates (the values of the function at the given x-coordinates).


**::math::interpolate::interp-cubic-splines** *coeffs* *x*
: Returns the interpolated value at coordinate x. The coefficients are computed by the procedure *prepare-cubic-splines*.

    list *coeffs*
    : List of coefficients as returned by prepare-cubic-splines

    float *x*
    : x-coordinate at which to estimate the function. Must be between the first and last x-coordinate for which values were given.


**::math::interpolate::interp-spatial** *xyvalues* *coord*
: Use a straightforward interpolation method with weights as function of the inverse distance to interpolate in 2D and N-dimensional space

    The list xyvalues is a list of lists:

    ```
        {   {x1 y1 z1 {v11 v12 v13 v14}}
    	{x2 y2 z2 {v21 v22 v23 v24}}
    	...
        }
    ```

    The last element of each inner list is either a single number or a list in itself. In the latter case the return value is a list with the same number of elements.

    The method is influenced by the search radius and the power of the inverse distance

    list *xyvalues* (in)
    : List of lists, each sublist being a list of coordinates and of dependent values.

    list *coord* (in)
    : List of coordinates for which the values must be calculated


**::math::interpolate::interp-spatial-params** *max\_search* *power*
: Set the parameters for spatial interpolation

    float *max\_search* (in)
    : Search radius (data points further than this are ignored)

    integer *power* (in)
    : Power for the distance (either 1 or 2; defaults to 2)


**::math::interpolate::neville** *xlist* *ylist* *x*
: Interpolates between the tabulated values of a function whose abscissae are *xlist* and whose ordinates are *ylist* to produce an estimate for the value of the function at *x*.  The result is a two-element list; the first element is the function's estimated value, and the second is an estimate of the absolute error of the result.  Neville's algorithm for polynomial interpolation is used.  Note that a large table of values will use an interpolating polynomial of high degree, which is likely to result in numerical instabilities; one is better off using only a few tabulated values near the desired abscissa.


# Examples

*Example of using one-dimensional tables:*

Suppose you have several tabulated functions of one variable:

```
    x     y1     y2
  0.0    0.0    0.0
  1.0    1.0    1.0
  2.0    4.0    8.0
  3.0    9.0   27.0
  4.0   16.0   64.0
```

Then to estimate the values at 0.5, 1.5, 2.5 and 3.5, you can use:

```
   set table [::math::interpolate::defineTable table1  {x y1 y2} {   -      1      2
                   0.0    0.0    0.0
                   1.0    1.0    1.0
                   2.0    4.0    8.0
                   3.0    9.0   27.0
                   4.0   16.0   64.0}]
   foreach x {0.5 1.5 2.5 3.5} {
       puts "$x: [::math::interpolate::interp-1d-table $table $x]"
   }
```

For one-dimensional tables the first row is not used. For two-dimensional tables, the first row represents the values for the second independent variable.

*Example of using the cubic splines:*

Suppose the following values are given:

```
    x       y
  0.1     1.0
  0.3     2.1
  0.4     2.2
  0.8     4.11
  1.0     4.12
```

Then to estimate the values at 0.1, 0.2, 0.3, ... 1.0, you can use:

```
   set coeffs [::math::interpolate::prepare-cubic-splines  {0.1 0.3 0.4 0.8  1.0}  {1.0 2.1 2.2 4.11 4.12}]
   foreach x {0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0} {
      puts "$x: [::math::interpolate::interp-cubic-splines $coeffs $x]"
   }
```

to get the following output:

```
0.1: 1.0
0.2: 1.68044117647
0.3: 2.1
0.4: 2.2
0.5: 3.11221507353
0.6: 4.25242647059
0.7: 5.41804227941
0.8: 4.11
0.9: 3.95675857843
1.0: 4.12
```

As you can see, the values at the abscissae are reproduced perfectly.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: interpolate* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
Copyright (c) 2004 Kevn B. Kenny <kennykb@users.sourceforge.net>
```
