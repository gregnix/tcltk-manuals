---
CommandName: math::probopt
title: math::probopt
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - mathematics
 - optimisation
 - probabilistic calculations
Copyright:
---

# Name

math::probopt - Probabilistic optimisation methods

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [math::probopt]{.lit} [1.1]{.lit}
[::math::probopt::pso]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg}
[::math::probopt::sce]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg}
[::math::probopt::diffev]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg}
[::math::probopt::lipoMax]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg}
[::math::probopt::adaLipoMax]{.cmd} [function]{.arg} [bounds]{.arg} [args]{.arg}
:::

# Description

The purpose of the **math::probopt** package is to provide various optimisation algorithms that are based on probabilistic techniques. The results of these algorithms may therefore vary from one run to the next. The algorithms are all well-known and well described and proponents generally claim they are efficient and reliable.

As most of these algorithms have one or more tunable parameters or even variations, the interface to each accepts options to set these parameters or the select the variation. These take the form of key-value pairs, for instance, *-iterations 100*.

This manual does not offer any recommendations with regards to these algorithms, nor does it provide much in the way of guidelines for the parameters. For this we refer to online articles on the algorithms in question.

A few notes, however:

- With the exception of LIPO, the algorithms are capable of dealing with irregular (non-smooth) and even discontinuous functions.

- The results depend on the random number seeding and are likely not to be very accurate, especially if the function varies slowly in the vicinty of the optimum. They do give a good starting point for a deterministic algorithm.


The collection consists of the following algorithms:

- PSO - particle swarm optimisation

- SCE - shuffled complexes evolution

- DE - differential evolution

- LIPO - Lipschitz optimisation


The various procedures have a uniform interface:

```
   set result [::math::probopt::algorithm function bounds args]
```

The arguments have the following meaning:

- The argument *function* is the name of the procedure that evaluates the function. Its interface is:

    ```
        set value [function coords]
    ```

- where *coords* is a list of coordinates at which to evaluate the function. It is supposed to return the function value.

- The argument *bounds* is a list of pairs of minimum and maximum for each coordinate. This list implicitly determines the dimension of the coordinate space in which the optimum is to be sought, for instance for a function like *x\*\*2 + (y-1)\*\*4*, you may specify the bounds as *{{-1 1} {-1 1}}*, that is, two pairs for the two coordinates.

- The rest (*args*) consists of zero or more key-value pairs to specify the options. Which options are supported by which algorithm, is documented below.


The result of the various optimisation procedures is a dictionary containing at least the following elements:

- *optimum-coordinates* is a list containing the coordinates of the optimum that was found.

- *optimum-value* is the function value at those coordinates.

- *evaluations* is the number of function evaluations.

- *best-values* is a list of successive best values, obtained as part of the iterations.


# Details on the algorithms

The algorithms in the package are the following:

**::math::probopt::pso** *function* *bounds* *args*
: The "particle swarm optimisation" algorithm uses the idea that the candidate optimum points should swarm around the best point found so far, with variations to allow for improvements.

    It recognises the following options:

    - *-swarmsize number*: Number of particles to consider (default: 50)

    - *-vweight    value*: Weight for the current "velocity" (0-1, default: 0.5)

    - *-pweight    value*: Weight for the individual particle's best position (0-1, default: 0.3)

    - *-gweight    value*: Weight for the "best" overall position as per particle (0-1, default: 0.3)

    - *-type       local/global*: Type of optimisation

    - *-neighbours number*: Size of the neighbourhood (default: 5, used if "local")

    - *-iterations number*: Maximum number of iterations

    - *-tolerance  value*: Absolute minimal improvement for minimum value


**::math::probopt::sce** *function* *bounds* *args*
: The "shuffled complex evolution" algorithm is an extension of the Nelder-Mead algorithm that uses multiple complexes and reorganises these complexes to find the "global" optimum.

    It recognises the following options:

    - *-complexes           number*: Number of particles to consider (default: 2)

    - *-mincomplexes        number*: Minimum number of complexes (default: 2; not currently used)

    - *-newpoints           number*: Number of new points to be generated (default: 1)

    - *-shuffle             number*: Number of iterations after which to reshuffle the complexes (if set to 0, the default, a number will be calculated from the number of dimensions)

    - *-pointspercomplex    number*: Number of points per complex (if set to 0, the default, a number will be calculated from the number of dimensions)

    - *-pointspersubcomplex number*: Number of points per subcomplex (used to select the best points in each complex; if set to 0, the default, a number will be calculated from the number of dimensions)

    - *-iterations          number*: Maximum number of iterations (default: 100)

    - *-maxevaluations      number*: Maximum number of function evaluations (when this number is reached the iteration is broken off. Default: 1000 million)

    - *-abstolerance        value*: Absolute minimal improvement for minimum value (default: 0.0)

    - *-reltolerance        value*: Relative minimal improvement for minimum value (default: 0.001)


**::math::probopt::diffev** *function* *bounds* *args*
: The "differential evolution" algorithm uses a number of initial points that are then updated using randomly selected points. It is more or less akin to genetic algorithms. It is controlled by two parameters, factor and lambda, where the first determines the update via random points and the second the update with the best point found sofar.

    It recognises the following options:

    - *-iterations          number*: Maximum number of iterations (default: 100)

    - *-number              number*: Number of point to work with (if set to 0, the default, it is calculated from the number of dimensions)

    - *-factor              value*: Weight of randomly selected points in the updating (0-1, default: 0.6)

    - *-lambda              value*: Weight of the best point found so far in the updating (0-1, default: 0.0)

    - *-crossover           value*: Fraction of new points to be considered for replacing the old ones (0-1, default: 0.5)

    - *-maxevaluations      number*: Maximum number of function evaluations (when this number is reached the iteration is broken off. Default: 1000 million)

    - *-abstolerance        value*: Absolute minimal improvement for minimum value (default: 0.0)

    - *-reltolerance        value*: Relative minimal improvement for minimum value (default: 0.001)


**::math::probopt::lipoMax** *function* *bounds* *args*
: The "Lipschitz optimisation" algorithm uses the "Lipschitz" property of the given function to find a *maximum* in the given bounding box. There are two variants, *lipoMax* assumes a fixed estimate for the Lipschitz parameter.

    It recognises the following options:

    - *-iterations          number*: Number of iterations (equals the actual number of function evaluations, default: 100)

    - *-lipschitz           value*: Estimate of the Lipschitz parameter (default: 10.0)


**::math::probopt::adaLipoMax** *function* *bounds* *args*
: The "adaptive Lipschitz optimisation" algorithm uses the "Lipschitz" property of the given function to find a *maximum* in the given bounding box. The adaptive variant actually uses two phases to find a suitable estimate for the Lipschitz parameter. This is controlled by the "Bernoulli" parameter.

    When you specify a large number of iterations, the algorithm may take a very long time to complete as it is trying to improve on the Lipschitz parameter and the chances of hitting a better estimate diminish fast.

    It recognises the following options:

    - *-iterations          number*: Number of iterations (equals the actual number of function evaluations, default: 100)

    - *-bernoulli           value*: Parameter for random decisions (exploration versus exploitation, default: 0.1)



# References

The various algorithms have been described in on-line publications. Here are a few:

- *PSO*: Maurice Clerc, Standard Particle Swarm Optimisation (2012) <https://hal.archives-ouvertes.fr/file/index/docid/764996/filename/SPSO_descriptions.pdf>

    Alternatively: <https://en.wikipedia.org/wiki/Particle_swarm_optimization>

- *SCE*: Qingyuan Duan, Soroosh Sorooshian, Vijai K. Gupta, Optimal use offo the SCE-UA global optimization method for calibrating watershed models (1994), Journal of Hydrology 158, pp 265-284

    <https://www.researchgate.net/publication/223408756_Optimal_Use_of_the_SCE-UA_Global_Optimization_Method_for_Calibrating_Watershed_Models>

- *DE*: Rainer Storn and Kenneth Price, Differential Evolution - A simple and efficient adaptivescheme for globaloptimization over continuous spaces (1996)

    <http://www1.icsi.berkeley.edu/~storn/TR-95-012.pdf>

- *LIPO*: Cedric Malherbe and Nicolas Vayatis, Global optimization of Lipschitz functions, (june 2017)

    <https://arxiv.org/pdf/1703.02628.pdf>


# Category

Mathematics
