---
CommandName: simulation::random
title: simulation::random
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Tcl Simulation Tools
Keywords:
 - math
 - random numbers
 - simulation
 - statistical distribution
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

simulation::random - Pseudo-random number generators

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [simulation::random]{.lit} [0.4]{.lit}
[::simulation::random::prng\_Bernoulli]{.cmd} [p]{.arg}
[::simulation::random::prng\_Discrete]{.cmd} [n]{.arg}
[::simulation::random::prng\_Poisson]{.cmd} [lambda]{.arg}
[::simulation::random::prng\_Uniform]{.cmd} [min]{.arg} [max]{.arg}
[::simulation::random::prng\_Triangular]{.cmd} [min]{.arg} [max]{.arg}
[::simulation::random::prng\_SymmTriangular]{.cmd} [min]{.arg} [max]{.arg}
[::simulation::random::prng\_Exponential]{.cmd} [min]{.arg} [mean]{.arg}
[::simulation::random::prng\_Normal]{.cmd} [mean]{.arg} [stdev]{.arg}
[::simulation::random::prng\_Pareto]{.cmd} [min]{.arg} [steep]{.arg}
[::simulation::random::prng\_Gumbel]{.cmd} [min]{.arg} [f]{.arg}
[::simulation::random::prng\_chiSquared]{.cmd} [df]{.arg}
[::simulation::random::prng\_Disk]{.cmd} [rad]{.arg}
[::simulation::random::prng\_Sphere]{.cmd} [rad]{.arg}
[::simulation::random::prng\_Ball]{.cmd} [rad]{.arg}
[::simulation::random::prng\_Rectangle]{.cmd} [length]{.arg} [width]{.arg}
[::simulation::random::prng\_Block]{.cmd} [length]{.arg} [width]{.arg} [depth]{.arg}
:::

# Description

This package consists of commands to generate pseudo-random number generators. These new commands deliver

- numbers that are distributed normally, uniformly, according to a Pareto or Gumbel distribution and so on

- coordinates of points uniformly spread inside a sphere or a rectangle


For example:

```
    set p [::simulation::random::prng_Normal -1.0 10.0]
```

produces a new command (whose name is stored in the variable "p") that generates normally distributed numbers with a mean of -1.0 and a standard deviation of 10.0.

# Procedures

The package defines the following public procedures for *discrete* distributions:

**::simulation::random::prng\_Bernoulli** *p*
: Create a command (PRNG) that generates numbers with a Bernoulli distribution: the value is either 1 or 0, with a chance p to be 1

    float *p*
    : Chance the outcome is 1


**::simulation::random::prng\_Discrete** *n*
: Create a command (PRNG) that generates numbers 0 to n-1 with equal probability.

    int *n*
    : Number of different values (ranging from 0 to n-1)


**::simulation::random::prng\_Poisson** *lambda*
: Create a command (PRNG) that generates numbers according to the Poisson distribution.

    float *lambda*
    : Mean number per time interval



The package defines the following public procedures for *continuous* distributions:

**::simulation::random::prng\_Uniform** *min* *max*
: Create a command (PRNG) that generates uniformly distributed numbers between "min" and "max".

    float *min*
    : Minimum number that will be generated

    float *max*
    : Maximum number that will be generated


**::simulation::random::prng\_Triangular** *min* *max*
: Create a command (PRNG) that generates triangularly distributed numbers between "min" and "max". If the argument min is lower than the argument max, then smaller values have higher probability and vice versa. In the first case the probability density function is of the form *f(x) = 2(1-x)* and the other case it is of the form *f(x) = 2x*.

    float *min*
    : Minimum number that will be generated

    float *max*
    : Maximum number that will be generated


**::simulation::random::prng\_SymmTriangular** *min* *max*
: Create a command (PRNG) that generates numbers distributed according to a symmetric triangle around the mean of "min" and "max".

    float *min*
    : Minimum number that will be generated

    float *max*
    : Maximum number that will be generated


**::simulation::random::prng\_Exponential** *min* *mean*
: Create a command (PRNG) that generates exponentially distributed numbers with a given minimum value and a given mean value.

    float *min*
    : Minimum number that will be generated

    float *mean*
    : Mean value for the numbers


**::simulation::random::prng\_Normal** *mean* *stdev*
: Create a command (PRNG) that generates normally distributed numbers with a given mean value and a given standard deviation.

    float *mean*
    : Mean value for the numbers

    float *stdev*
    : Standard deviation


**::simulation::random::prng\_Pareto** *min* *steep*
: Create a command (PRNG) that generates numbers distributed according to Pareto with a given minimum value and a given distribution steepness.

    float *min*
    : Minimum number that will be generated

    float *steep*
    : Steepness of the distribution


**::simulation::random::prng\_Gumbel** *min* *f*
: Create a command (PRNG) that generates numbers distributed according to Gumbel with a given minimum value and a given scale factor. The probability density function is:

    ```
         P(v) = exp( -exp(f*(v-min)))
    ```

    float *min*
    : Minimum number that will be generated

    float *f*
    : Scale factor for the values


**::simulation::random::prng\_chiSquared** *df*
: Create a command (PRNG) that generates numbers distributed according to the chi-squared distribution with df degrees of freedom. The mean is 0 and the standard deviation is 1.

    float *df*
    : Degrees of freedom



The package defines the following public procedures for random point sets:

**::simulation::random::prng\_Disk** *rad*
: Create a command (PRNG) that generates (x,y)-coordinates for points uniformly spread over a disk of given radius.

    float *rad*
    : Radius of the disk


**::simulation::random::prng\_Sphere** *rad*
: Create a command (PRNG) that generates (x,y,z)-coordinates for points uniformly spread over the surface of a sphere of given radius.

    float *rad*
    : Radius of the disk


**::simulation::random::prng\_Ball** *rad*
: Create a command (PRNG) that generates (x,y,z)-coordinates for points uniformly spread within a ball of given radius.

    float *rad*
    : Radius of the ball


**::simulation::random::prng\_Rectangle** *length* *width*
: Create a command (PRNG) that generates (x,y)-coordinates for points uniformly spread over a rectangle.

    float *length*
    : Length of the rectangle (x-direction)

    float *width*
    : Width of the rectangle (y-direction)


**::simulation::random::prng\_Block** *length* *width* *depth*
: Create a command (PRNG) that generates (x,y,z)-coordinates for points uniformly spread over a block

    float *length*
    : Length of the block (x-direction)

    float *width*
    : Width of the block (y-direction)

    float *depth*
    : Depth of the block (z-direction)



# Category

Mathematics

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
