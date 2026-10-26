---
CommandName: math::figurate
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - figurate numbers
 - mathematics
Copyright:
---

# Name

math::figurate - Evaluate figurate numbers

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::figurate]{.lit} [1.0]{.lit} 
[::math::figurate::sum_sequence]{.cmd} [n]{.arg} 
[::math::figurate::sum_squares]{.cmd} [n]{.arg} 
[::math::figurate::sum_cubes]{.cmd} [n]{.arg} 
[::math::figurate::sum_4th_power]{.cmd} [n]{.arg} 
[::math::figurate::sum_5th_power]{.cmd} [n]{.arg} 
[::math::figurate::sum_6th_power]{.cmd} [n]{.arg} 
[::math::figurate::sum_7th_power]{.cmd} [n]{.arg} 
[::math::figurate::sum_8th_power]{.cmd} [n]{.arg} 
[::math::figurate::sum_9th_power]{.cmd} [n]{.arg} 
[::math::figurate::sum_10th_power]{.cmd} [n]{.arg} 
[::math::figurate::sum_sequence_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_squares_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_cubes_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_4th_power_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_5th_power_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_6th_power_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_7th_power_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_8th_power_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_9th_power_odd]{.cmd} [n]{.arg} 
[::math::figurate::sum_10th_power_odd]{.cmd} [n]{.arg} 
[::math::figurate::oblong]{.cmd} [n]{.arg} 
[::math::figurate::pronic]{.cmd} [n]{.arg} 
[::math::figurate::triangular]{.cmd} [n]{.arg} 
[::math::figurate::square]{.cmd} [n]{.arg} 
[::math::figurate::cubic]{.cmd} [n]{.arg} 
[::math::figurate::biquadratic]{.cmd} [n]{.arg} 
[::math::figurate::centeredTriangular]{.cmd} [n]{.arg} 
[::math::figurate::centeredSquare]{.cmd} [n]{.arg} 
[::math::figurate::centeredPentagonal]{.cmd} [n]{.arg} 
[::math::figurate::centeredHexagonal]{.cmd} [n]{.arg} 
[::math::figurate::centeredCube]{.cmd} [n]{.arg} 
[::math::figurate::decagonal]{.cmd} [n]{.arg} 
[::math::figurate::heptagonal]{.cmd} [n]{.arg} 
[::math::figurate::hexagonal]{.cmd} [n]{.arg} 
[::math::figurate::octagonal]{.cmd} [n]{.arg} 
[::math::figurate::octahedral]{.cmd} [n]{.arg} 
[::math::figurate::pentagonal]{.cmd} [n]{.arg} 
[::math::figurate::squarePyramidral]{.cmd} [n]{.arg} 
[::math::figurate::tetrahedral]{.cmd} [n]{.arg} 
[::math::figurate::pentatope]{.cmd} [n]{.arg} 
:::

# Description

Sums of numbers that follow a particular pattern are called figurate numbers. A simple example is the sum of integers 1, 2, ... up to n. You can arrange 1, 1+2=3, 1+2+3=6, ... objects in a triangle, hence the name triangular numbers:

```
       *
       *  *
       *  *  *
       *  *  *  *
       ...
```

The **math::figurate** package consists of a collection of procedures to evaluate a wide variety of figurate numbers. While all formulae are straightforward, the details are sometimes puzzling. *Note:* The procedures consider arguments lower than zero as to mean "no objects to be counted" and therefore return 0.

# Procedures

The procedures can be arranged in a few categories: sums of integers raised to a particular power, sums of odd integers and general figurate numbers, for instance the pentagonal numbers.

**::math::figurate::sum_sequence** *n*
: Return the sum of integers 1, 2, ..., n.


int *n*
: Highest integer in the sum


**::math::figurate::sum_squares** *n*
: Return the sum of squares 1\*\*2, 2\*\*2, ..., n\*\*2.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_cubes** *n*
: Return the sum of cubes 1\*\*3, 2\*\*3, ..., n\*\*3.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_4th_power** *n*
: Return the sum of 4th powers 1\*\*4, 2\*\*4, ..., n\*\*4.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_5th_power** *n*
: Return the sum of 5th powers 1\*\*5, 2\*\*5, ..., n\*\*5.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_6th_power** *n*
: Return the sum of 6th powers 1\*\*6, 2\*\*6, ..., n\*\*6.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_7th_power** *n*
: Return the sum of 7th powers 1\*\*7, 2\*\*7, ..., n\*\*7.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_8th_power** *n*
: Return the sum of 8th powers 1\*\*8, 2\*\*8, ..., n\*\*8.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_9th_power** *n*
: Return the sum of 9th powers 1\*\*9, 2\*\*9, ..., n\*\*9.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_10th_power** *n*
: Return the sum of 10th powers 1\*\*10, 2\*\*10, ..., n\*\*10.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_sequence_odd** *n*
: Return the sum of odd integers 1, 3, ..., 2n-1


int *n*
: Highest integer in the sum


**::math::figurate::sum_squares_odd** *n*
: Return the sum of odd squares 1\*\*2, 3\*\*2, ..., (2n-1)\*\*2.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_cubes_odd** *n*
: Return the sum of odd cubes 1\*\*3, 3\*\*3, ..., (2n-1)\*\*3.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_4th_power_odd** *n*
: Return the sum of odd 4th powers 1\*\*4, 2\*\*4, ..., (2n-1)\*\*4.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_5th_power_odd** *n*
: Return the sum of odd 5th powers 1\*\*5, 2\*\*5, ..., (2n-1)\*\*5.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_6th_power_odd** *n*
: Return the sum of odd 6th powers 1\*\*6, 2\*\*6, ..., (2n-1)\*\*6.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_7th_power_odd** *n*
: Return the sum of odd 7th powers 1\*\*7, 2\*\*7, ..., (2n-1)\*\*7.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_8th_power_odd** *n*
: Return the sum of odd 8th powers 1\*\*8, 2\*\*8, ..., (2n-1)\*\*8.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_9th_power_odd** *n*
: Return the sum of odd 9th powers 1\*\*9, 2\*\*9, ..., (2n-1)\*\*9.


int *n*
: Highest base integer in the sum


**::math::figurate::sum_10th_power_odd** *n*
: Return the sum of odd 10th powers 1\*\*10, 2\*\*10, ..., (2n-1)\*\*10.


int *n*
: Highest base integer in the sum


**::math::figurate::oblong** *n*
: Return the nth oblong number (twice the nth triangular number)


int *n*
: Required index


**::math::figurate::pronic** *n*
: Return the nth pronic number (synonym for oblong)


int *n*
: Required index


**::math::figurate::triangular** *n*
: Return the nth triangular number


int *n*
: Required index


**::math::figurate::square** *n*
: Return the nth square number


int *n*
: Required index


**::math::figurate::cubic** *n*
: Return the nth cubic number


int *n*
: Required index


**::math::figurate::biquadratic** *n*
: Return the nth biquaratic number (i.e. n\*\*4)


int *n*
: Required index


**::math::figurate::centeredTriangular** *n*
: Return the nth centered triangular number (items arranged in concentric squares)


int *n*
: Required index


**::math::figurate::centeredSquare** *n*
: Return the nth centered square number (items arranged in concentric squares)


int *n*
: Required index


**::math::figurate::centeredPentagonal** *n*
: Return the nth centered pentagonal number (items arranged in concentric pentagons)


int *n*
: Required index


**::math::figurate::centeredHexagonal** *n*
: Return the nth centered hexagonal number (items arranged in concentric hexagons)


int *n*
: Required index


**::math::figurate::centeredCube** *n*
: Return the nth centered cube number (items arranged in concentric cubes)


int *n*
: Required index


**::math::figurate::decagonal** *n*
: Return the nth decagonal number (items arranged in decagons with one common vertex)


int *n*
: Required index


**::math::figurate::heptagonal** *n*
: Return the nth heptagonal number (items arranged in heptagons with one common vertex)


int *n*
: Required index


**::math::figurate::hexagonal** *n*
: Return the nth hexagonal number (items arranged in hexagons with one common vertex)


int *n*
: Required index


**::math::figurate::octagonal** *n*
: Return the nth octagonal number (items arranged in octagons with one common vertex)


int *n*
: Required index


**::math::figurate::octahedral** *n*
: Return the nth octahedral number (items arranged in octahedrons with a common centre)


int *n*
: Required index


**::math::figurate::pentagonal** *n*
: Return the nth pentagonal number (items arranged in pentagons with one common vertex)


int *n*
: Required index


**::math::figurate::squarePyramidral** *n*
: Return the nth square pyramidral number (items arranged in a square pyramid)


int *n*
: Required index


**::math::figurate::tetrahedral** *n*
: Return the nth tetrahedral number (items arranged in a triangular pyramid)


int *n*
: Required index


**::math::figurate::pentatope** *n*
: Return the nth pentatope number (items arranged in the four-dimensional analogue of a triangular pyramid)


int *n*
: Required index


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: figurate* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics
