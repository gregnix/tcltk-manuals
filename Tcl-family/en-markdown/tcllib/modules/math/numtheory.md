---
CommandName: math::numtheory
ManualSection: n
Version: 1.1.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - number theory
 - prime
Copyright:
 - Copyright (c) 2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
---

# Name

math::numtheory - Number Theory

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [math::numtheory]{.lit} [1.1.4]{.optlit} 
[math::numtheory::isprime]{.cmd} [N]{.arg} [option value]{.optdot} 
[math::numtheory::firstNprimes]{.cmd} [N]{.arg} 
[math::numtheory::primesLowerThan]{.cmd} [N]{.arg} 
[math::numtheory::primeFactors]{.cmd} [N]{.arg} 
[math::numtheory::primesLowerThan]{.cmd} [N]{.arg} 
[math::numtheory::primeFactors]{.cmd} [N]{.arg} 
[math::numtheory::uniquePrimeFactors]{.cmd} [N]{.arg} 
[math::numtheory::factors]{.cmd} [N]{.arg} 
[math::numtheory::totient]{.cmd} [N]{.arg} 
[math::numtheory::moebius]{.cmd} [N]{.arg} 
[math::numtheory::legendre]{.cmd} [a]{.arg} [p]{.arg} 
[math::numtheory::jacobi]{.cmd} [a]{.arg} [b]{.arg} 
[math::numtheory::gcd]{.cmd} [m]{.arg} [n]{.arg} 
[math::numtheory::lcm]{.cmd} [m]{.arg} [n]{.arg} 
[math::numtheory::numberPrimesGauss]{.cmd} [N]{.arg} 
[math::numtheory::numberPrimesLegendre]{.cmd} [N]{.arg} 
[math::numtheory::numberPrimesLegendreModified]{.cmd} [N]{.arg} 
[math::numtheory::differenceNumberPrimesLegendreModified]{.cmd} [lower]{.arg} [upper]{.arg} 
[math::numtheory::listPrimePairs]{.cmd} [lower]{.arg} [upper]{.arg} [step]{.arg} 
[math::numtheory::listPrimeProgressions]{.cmd} [lower]{.arg} [upper]{.arg} [step]{.arg} 
:::

# Description

This package is for collecting various number-theoretic operations, with a slight bias to prime numbers.

**math::numtheory::isprime** *N* ?*option* *value* ...?
: The **isprime** command tests whether the integer *N* is a prime, returning a boolean true value for prime *N* and a boolean false value for non-prime *N*. The formal definition of \\'prime' used is the conventional, that the number being tested is greater than 1 and only has trivial divisors. To be precise, the return value is one of **0** (if *N* is definitely not a prime), **1** (if *N* is definitely a prime), and **on** (if *N* is probably prime); the latter two are both boolean true values. The case that an integer may be classified as "probably prime" arises because the Miller-Rabin algorithm used in the test implementation is basically probabilistic, and may if we are unlucky fail to detect that a number is in fact composite. Options may be used to select the risk of such "false positives" in the test. **1** is returned for "small" *N* (which currently means *N* < 118670087467), where it is known that no false positives are possible. The only option currently defined is:


**-randommr** *repetitions*
: which controls how many times the Miller-Rabin test should be repeated with randomly chosen bases. Each repetition reduces the probability of a false positive by a factor at least 4. The default for *repetitions* is 4.


: Unknown options are silently ignored.


**math::numtheory::firstNprimes** *N*
: Return the first N primes


integer *N* (in)
: Number of primes to return


**math::numtheory::primesLowerThan** *N*
: Return the prime numbers lower/equal to N


integer *N* (in)
: Maximum number to consider


**math::numtheory::primeFactors** *N*
: Return a list of the prime numbers in the number N


integer *N* (in)
: Number to be factorised


**math::numtheory::primesLowerThan** *N*
: Return the prime numbers lower/equal to N


integer *N* (in)
: Maximum number to consider


**math::numtheory::primeFactors** *N*
: Return a list of the prime numbers in the number N


integer *N* (in)
: Number to be factorised


**math::numtheory::uniquePrimeFactors** *N*
: Return a list of the *unique* prime numbers in the number N


integer *N* (in)
: Number to be factorised


**math::numtheory::factors** *N*
: Return a list of all *unique* factors in the number N, including 1 and N itself


integer *N* (in)
: Number to be factorised


**math::numtheory::totient** *N*
: Evaluate the Euler totient function for the number N (number of numbers relatively prime to N)


integer *N* (in)
: Number in question


**math::numtheory::moebius** *N*
: Evaluate the Moebius function for the number N


integer *N* (in)
: Number in question


**math::numtheory::legendre** *a* *p*
: Evaluate the Legendre symbol (a/p)


integer *a* (in)
: Upper number in the symbol

integer *p* (in)
: Lower number in the symbol (must be non-zero)


**math::numtheory::jacobi** *a* *b*
: Evaluate the Jacobi symbol (a/b)


integer *a* (in)
: Upper number in the symbol

integer *b* (in)
: Lower number in the symbol (must be odd)


**math::numtheory::gcd** *m* *n*
: Return the greatest common divisor of *m* and *n*


integer *m* (in)
: First number

integer *n* (in)
: Second number


**math::numtheory::lcm** *m* *n*
: Return the lowest common multiple of *m* and *n*


integer *m* (in)
: First number

integer *n* (in)
: Second number


**math::numtheory::numberPrimesGauss** *N*
: Estimate the number of primes according the formula by Gauss.


integer *N* (in)
: Number in question, should be larger than 0


**math::numtheory::numberPrimesLegendre** *N*
: Estimate the number of primes according the formula by Legendre.


integer *N* (in)
: Number in question, should be larger than 0


**math::numtheory::numberPrimesLegendreModified** *N*
: Estimate the number of primes according the modified formula by Legendre.


integer *N* (in)
: Number in question, should be larger than 0


**math::numtheory::differenceNumberPrimesLegendreModified** *lower* *upper*
: Estimate the number of primes between tow limits according the modified formula by Legendre.


integer *lower* (in)
: Lower limit for the primes, should be larger than 0

integer *upper* (in)
: Upper limit for the primes, should be larger than 0


**math::numtheory::listPrimePairs** *lower* *upper* *step*
: Return a list of pairs of primes each differing by the given step.


integer *lower* (in)
: Lower limit for the primes, should be larger than 0

integer *upper* (in)
: Upper limit for the primes, should be larger than the lower limit

integer *step* (in)
: Step by which the primes should differ, defaults to 2


**math::numtheory::listPrimeProgressions** *lower* *upper* *step*
: Return a list of lists of primes each differing by the given step from the previous one.


integer *lower* (in)
: Lower limit for the primes, should be larger than 0

integer *upper* (in)
: Upper limit for the primes, should be larger than the lower limit

integer *step* (in)
: Step by which the primes should differ, defaults to 2


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: numtheory* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
```
