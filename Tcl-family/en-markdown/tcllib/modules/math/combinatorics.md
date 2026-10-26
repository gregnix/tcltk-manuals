---
CommandName: math::combinatorics
ManualSection: n
Version: 2.1
TclPart: tcllib
TclDescription: Tcl Math Library
Copyright:
---

# Name

math::combinatorics - Combinatorial functions in the Tcl Math Library

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math]{.lit} [1.2.6]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [math::combinatorics]{.lit} [2.1]{.optlit} 
[::math::ln_Gamma]{.cmd} [z]{.arg} 
[::math::factorial]{.cmd} [x]{.arg} 
[::math::choose]{.cmd} [n]{.arg} [k]{.arg} 
[::math::Beta]{.cmd} [z]{.arg} [w]{.arg} 
[::math::combinatorics::permutations]{.cmd} [n]{.arg} 
[::math::combinatorics::variations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::combinations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::derangements]{.cmd} [n]{.arg} 
[::math::combinatorics::catalan]{.cmd} [n]{.arg} 
[::math::combinatorics::firstStirling]{.cmd} [n]{.arg} [m]{.arg} 
[::math::combinatorics::secondStirling]{.cmd} [n]{.arg} [m]{.arg} 
[::math::combinatorics::partitionP]{.cmd} [n]{.arg} 
[::math::combinatorics::list-permutations]{.cmd} [n]{.arg} 
[::math::combinatorics::list-variations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::list-combinations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::list-derangements]{.cmd} [n]{.arg} 
[::math::combinatorics::list-powerset]{.cmd} [n]{.arg} 
[::math::combinatorics::permutationObj]{.cmd} new/create NAME [n]{.arg} 
[\$perm]{.cmd} next 
[\$perm]{.cmd} reset 
[\$perm]{.cmd} setElements [elements]{.arg} 
[\$perm]{.cmd} setElements 
[::math::combinatorics::combinationObj]{.cmd} new/create NAME [n]{.arg} [k]{.arg} 
[\$combin]{.cmd} next 
[\$combin]{.cmd} reset 
[\$combin]{.cmd} setElements [elements]{.arg} 
[\$combin]{.cmd} setElements 
:::

# Description

The **math** package contains implementations of several functions useful in combinatorial problems. The **math::combinatorics** extends the collections based on features in Tcl 8.6. Note: the meaning of the partitionP function, Catalan and Stirling numbers is explained on the [MathWorld website](http://mathworld.wolfram.com)

# Commands

**::math::ln_Gamma** *z*
: Returns the natural logarithm of the Gamma function for the argument *z*. The Gamma function is defined as the improper integral from zero to positive infinity of


```
  t**(x-1)*exp(-t) dt
```

The approximation used in the Tcl Math Library is from Lanczos, *ISIAM J. Numerical Analysis, series B,* volume 1, p. 86. For "**x** > 1", the absolute error of the result is claimed to be smaller than 5.5\*10\*\*-10 -- that is, the resulting value of Gamma when

```
  exp( ln_Gamma( x) )
```

: is computed is expected to be precise to better than nine significant figures.


**::math::factorial** *x*
: Returns the factorial of the argument *x*. For integer *x*, 0 <= *x* <= 12, an exact integer result is returned. For integer *x*, 13 <= *x* <= 21, an exact floating-point result is returned on machines with IEEE floating point. For integer *x*, 22 <= *x* <= 170, the result is exact to 1 ULP. For real *x*, *x* >= 0, the result is approximated by computing *Gamma(x+1)* using the **::math::ln_Gamma** function, and the result is expected to be precise to better than nine significant figures. It is an error to present *x* <= -1 or *x* > 170, or a value of *x* that is not numeric.

**::math::choose** *n k*
: Returns the binomial coefficient *C(n, k)*


```
   C(n,k) = n! / k! (n-k)!
```

: If both parameters are integers and the result fits in 32 bits, the result is rounded to an integer. Integer results are exact up to at least *n* = 34.  Floating point results are precise to better than nine significant figures.


**::math::Beta** *z w*
: Returns the Beta function of the parameters *z* and *w*.


```
   Beta(z,w) = Beta(w,z) = Gamma(z) * Gamma(w) / Gamma(z+w)
```

: Results are returned as a floating point number precise to better than nine significant digits provided that *w* and *z* are both at least 1.


**::math::combinatorics::permutations** *n*
: Return the number of permutations of n items. The returned number is always an integer, it is not limited by the range of 32-or 64-bits integers using the arbitrary precision integers available in Tcl 8.5 and later.


int *n*
: The number of items to be permuted.


**::math::combinatorics::variations** *n* *k*
: Return the number of variations k items selected from the total of n items. The order of the items is taken into account.


int *n*
: The number of items to be selected from.

int *k*
: The number of items to be selected in each variation.


**::math::combinatorics::combinations** *n* *k*
: Return the number of combinations of k items selected from the total of n items. The order of the items is not important.


int *n*
: The number of items to be selected from.

int *k*
: The number of items to be selected in each combination.


**::math::combinatorics::derangements** *n*
: Return the number of derangements of n items. A derangement is a permutation where each item is displaced from the original position.


int *n*
: The number of items to be rearranged.


**::math::combinatorics::catalan** *n*
: Return the n'th Catalan number. The number n is expected to be 1 or larger. These numbers occur in various combinatorial problems.


int *n*
: The index of the Catalan number


**::math::combinatorics::firstStirling** *n* *m*
: Calculate a Stirling number of the first kind (signed version, m cycles in a permutation of n items)


int *n*
: Number of items

int *m*
: Number of cycles


**::math::combinatorics::secondStirling** *n* *m*
: Calculate a Stirling number of the second kind (m non-empty subsets from n items)


int *n*
: Number of items

int *m*
: Number of subsets


**::math::combinatorics::partitionP** *n*
: Calculate the number of ways an integer n can be written as the sum of positive integers.


int *n*
: Number in question


**::math::combinatorics::list-permutations** *n*
: Return the list of permutations of the numbers 0, ..., n-1.


int *n*
: The number of items to be permuted.


**::math::combinatorics::list-variations** *n* *k*
: Return the list of variations of k numbers selected from the numbers 0, ..., n-1. The order of the items is taken into account.


int *n*
: The number of items to be selected from.

int *k*
: The number of items to be selected in each variation.


**::math::combinatorics::list-combinations** *n* *k*
: Return the list of combinations of k numbers selected from the numbers 0, ..., n-1. The order of the items is ignored.


int *n*
: The number of items to be selected from.

int *k*
: The number of items to be selected in each combination.


**::math::combinatorics::list-derangements** *n*
: Return the list of derangements of the numbers 0, ..., n-1.


int *n*
: The number of items to be rearranged.


**::math::combinatorics::list-powerset** *n*
: Return the list of all subsets of the numbers 0, ..., n-1.


int *n*
: The number of items to be rearranged.


**::math::combinatorics::permutationObj** new/create NAME *n*
: Create a TclOO object for returning permutations one by one. If the last permutation has been reached an empty list is returned.


int *n*
: The number of items to be rearranged.


**\$perm** next
: Return the next permutation of n objects.

**\$perm** reset
: Reset the object, so that the command *next* returns the complete list again.

**\$perm** setElements *elements*
: Register a list of items to be permuted, using the *nextElements* command.


list *elements*
: The list of n items that will be permuted.


**\$perm** setElements
: Return the next permulation of the registered items.

**::math::combinatorics::combinationObj** new/create NAME *n* *k*
: Create a TclOO object for returning combinations one by one. If the last combination has been reached an empty list is returned.


int *n*
: The number of items to be rearranged.


**\$combin** next
: Return the next combination of n objects.

**\$combin** reset
: Reset the object, so that the command *next* returns the complete list again.

**\$combin** setElements *elements*
: Register a list of items to be permuted, using the *nextElements* command.


list *elements*
: The list of n items that will be permuted.


**\$combin** setElements
: Return the next combination of the registered items.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics
