---
CommandName: math::quasirandom
title: math::quasirandom
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - mathematics
 - quasi-random
Copyright:
---

# Name

math::quasirandom - Quasi-random points for integration and Monte Carlo type methods

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [math::quasirandom]{.lit} [1.1]{.lit}
[::math::quasirandom::qrpoint]{.cmd} [create]{.sub} [NAME]{.arg} [DIM]{.arg} [ARGS]{.optarg}
[gen]{.cmd} [next]{.sub}
[gen]{.cmd} [set-start]{.sub} [index]{.arg}
[gen]{.cmd} [set-evaluations]{.sub} [number]{.arg}
[gen]{.cmd} [integral]{.sub} [func]{.arg} [minmax]{.arg} [args]{.arg}
:::

# Description

In many applications pseudo-random numbers and pseudo-random points in a (limited) sample space play an important role. For instance in any type of Monte Carlo simulation. Pseudo-random numbers, however, may be too random and as a consequence a large number of data points is required to reduce the error or fluctuation in the results to the desired value.

Quasi-random numbers can be used as an alternative: instead of "completely" arbitrary points, points are generated that are diverse enough to cover the entire sample space in a more or less uniform way. As a consequence convergence to the limit can be much faster, when such quasi-random numbers are well-chosen.

The package defines a *class* "qrpoint" that creates a command to generate quasi-random points in 1, 2 or more dimensions. The command can either generate separate points, so that they can be used in a user-defined algorithm or use these points to calculate integrals of functions defined over 1, 2 or more dimensions. It also holds several other common algorithms. (NOTE: these are not implemented yet)

One particular characteristic of the generators is that there are no tuning parameters involved, which makes the use particularly simple.

# Commands

A quasi-random point generator is created using the *qrpoint* class:

**::math::quasirandom::qrpoint create** *NAME* *DIM* ?ARGS?
: This command takes the following arguments:

    string *NAME*
    : The name of the command to be created (alternatively: the *new* subcommand will generate a unique name)

    integer/string *DIM*
    : The number of dimensions or one of: "circle", "disk", "sphere" or "ball"

    strings *ARGS*
    : Zero or more key-value pairs. The supported options are:

        - *-start index*: The index for the next point to be generated (default: 1)

        - *-evaluations number*: The number of evaluations to be used by default (default: 100)




The points that are returned lie in the hyperblock \[0,1\[^n (n the number of dimensions) or on the unit circle, within the unit disk, on the unit sphere or within the unit ball.

Each generator supports the following subcommands:

**gen next**
: Return the coordinates of the next quasi-random point

**gen set-start** *index*
: Reset the index for the next quasi-random point. This is useful to control which list of points is returned. Returns the new or the current value, if no value is given.

**gen set-evaluations** *number*
: Reset the default number of evaluations in compound algorithms. Note that the actual number is the smallest 4-fold larger or equal to the given number. (The 4-fold plays a role in the detailed integration routine.)

**gen integral** *func* *minmax* *args*
: Calculate the integral of the given function over the block (or the circle, sphere etc.)

    string *func*
    : The name of the function to be integrated

    list *minmax*
    : List of pairs of minimum and maximum coordinates. This can be used to map the quasi-random coordinates to the desired hyper-block.

        If the space is a circle, disk etc. then this argument should be a single value, the radius. The circle, disk, etc. is centred at the origin. If this is not what is required, then a coordinate transformation should be made within the function.

    strings *args*
    : Zero or more key-value pairs. The following options are supported:

        - *-evaluations number*: The number of evaluations to be used. If not specified use the default of the generator object.




# Todo

Implement other algorithms and variants

Implement more unit tests.

Comparison to pseudo-random numbers for integration.

# References

Various algorithms exist for generating quasi-random numbers. The generators created in this package are based on: <http://extremelearning.com.au/unreasonable-effectiveness-of-quasirandom-sequences/>

# Category

Mathematics
