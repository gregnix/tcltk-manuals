---
CommandName: math::bignum
ManualSection: n
Version: 3.1.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - bignums
 - math
 - multiprecision
 - tcl
Copyright:
 - Copyright (c) 2004 Salvatore Sanfilippo <antirez at invece dot org>
 - Copyright (c) 2004 Arjen Markus <arjenmarkus at users dot sourceforge dot net>
---

# Name

math::bignum - Arbitrary precision integer numbers

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [math::bignum]{.lit} [3.1.2]{.optlit} 
[::math::bignum::fromstr]{.cmd} [string]{.arg} [radix]{.optarg} 
[::math::bignum::tostr]{.cmd} [bignum]{.arg} [radix]{.optarg} 
[::math::bignum::sign]{.cmd} [bignum]{.arg} 
[::math::bignum::abs]{.cmd} [bignum]{.arg} 
[::math::bignum::cmp]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::iszero]{.cmd} [bignum]{.arg} 
[::math::bignum::lt]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::le]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::gt]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::ge]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::eq]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::ne]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::isodd]{.cmd} [bignum]{.arg} 
[::math::bignum::iseven]{.cmd} [bignum]{.arg} 
[::math::bignum::add]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::sub]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::mul]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::divqr]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::div]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::rem]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::mod]{.cmd} [n]{.arg} [m]{.arg} 
[::math::bignum::pow]{.cmd} [base]{.arg} [exp]{.arg} 
[::math::bignum::powm]{.cmd} [base]{.arg} [exp]{.arg} [m]{.arg} 
[::math::bignum::sqrt]{.cmd} [bignum]{.arg} 
[::math::bignum::rand]{.cmd} [bits]{.arg} 
[::math::bignum::lshift]{.cmd} [bignum]{.arg} [bits]{.arg} 
[::math::bignum::rshift]{.cmd} [bignum]{.arg} [bits]{.arg} 
[::math::bignum::bitand]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::bitor]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::bitxor]{.cmd} [a]{.arg} [b]{.arg} 
[::math::bignum::setbit]{.cmd} [bignumVar]{.arg} [bit]{.arg} 
[::math::bignum::clearbit]{.cmd} [bignumVar]{.arg} [bit]{.arg} 
[::math::bignum::testbit]{.cmd} [bignum]{.arg} [bit]{.arg} 
[::math::bignum::bits]{.cmd} [bignum]{.arg} 
:::

# Description

The bignum package provides arbitrary precision integer math (also known as "big numbers") capabilities to the Tcl language. Big numbers are internally represented at Tcl lists: this package provides a set of procedures operating against the internal representation in order to:

**•**
: perform math operations

**•**
: convert bignums from the internal representation to a string in the desired radix and vice versa. But the two constants "0" and "1" are automatically converted to the internal representation, in order to easily compare a number to zero, or increment a big number. The bignum interface is opaque, so operations on bignums that are not returned by procedures in this package (but created by hand) may lead to unspecified behaviours. It's safe to treat bignums as pure values, so there is no need to free a bignum, or to duplicate it via a special operation.


# Examples

This section shows some simple example. This library being just a way to perform math operations, examples may be the simplest way to learn how to work with it. Consult the API section of this man page for information about individual procedures.

```
    package require math::bignum

    # Multiplication of two bignums
    set a [::math::bignum::fromstr 88888881111111]
    set b [::math::bignum::fromstr 22222220000000]
    set c [::math::bignum::mul $a $b]
    puts [::math::bignum::tostr $c] ; # => will output 1975308271604953086420000000
    set c [::math::bignum::sqrt $c]
    puts [::math::bignum::tostr $c] ; # => will output 44444440277777

    # From/To string conversion in different radix
    set a [::math::bignum::fromstr 1100010101010111001001111010111 2]
    puts [::math::bignum::tostr $a 16] ; # => will output 62ab93d7

    # Factorial example
    proc fact n {
        # fromstr is not needed for 0 and 1
        set z 1
        for {set i 2} {$i <= $n} {incr i} {
            set z [::math::bignum::mul $z [::math::bignum::fromstr $i]]
        }
        return $z
    }

    puts [::math::bignum::tostr [fact 100]]
```

# Api

**::math::bignum::fromstr** *string* ?*radix*?
: Convert *string* into a bignum. If *radix* is omitted or zero, the string is interpreted in hex if prefixed with *0x*, in octal if prefixed with *ox*, in binary if it's pefixed with *bx*, as a number in radix 10 otherwise. If instead the *radix* argument is specified in the range 2-36, the *string* is interpreted in the given radix. Please note that this conversion is not needed for two constants : *0* and *1*. (see the example)

**::math::bignum::tostr** *bignum* ?*radix*?
: Convert *bignum* into a string representing the number in the specified radix. If *radix* is omitted, the default is 10.

**::math::bignum::sign** *bignum*
: Return the sign of the bignum. The procedure returns 0 if the number is positive, 1 if it's negative.

**::math::bignum::abs** *bignum*
: Return the absolute value of the bignum.

**::math::bignum::cmp** *a* *b*
: Compare the two bignums a and b, returning *0* if *a == b*, *1* if *a > b*, and *-1* if *a < b*.

**::math::bignum::iszero** *bignum*
: Return true if *bignum* value is zero, otherwise false is returned.

**::math::bignum::lt** *a* *b*
: Return true if *a < b*, otherwise false is returned.

**::math::bignum::le** *a* *b*
: Return true if *a <= b*, otherwise false is returned.

**::math::bignum::gt** *a* *b*
: Return true if *a > b*, otherwise false is returned.

**::math::bignum::ge** *a* *b*
: Return true if *a >= b*, otherwise false is returned.

**::math::bignum::eq** *a* *b*
: Return true if *a == b*, otherwise false is returned.

**::math::bignum::ne** *a* *b*
: Return true if *a != b*, otherwise false is returned.

**::math::bignum::isodd** *bignum*
: Return true if *bignum* is odd.

**::math::bignum::iseven** *bignum*
: Return true if *bignum* is even.

**::math::bignum::add** *a* *b*
: Return the sum of the two bignums *a* and *b*.

**::math::bignum::sub** *a* *b*
: Return the difference of the two bignums *a* and *b*.

**::math::bignum::mul** *a* *b*
: Return the product of the two bignums *a* and *b*. The implementation uses Karatsuba multiplication if both the numbers are bigger than a given threshold, otherwise the direct algorith is used.

**::math::bignum::divqr** *a* *b*
: Return a two-elements list containing as first element the quotient of the division between the two bignums *a* and *b*, and the remainder of the division as second element.

**::math::bignum::div** *a* *b*
: Return the quotient of the division between the two bignums *a* and *b*.

**::math::bignum::rem** *a* *b*
: Return the remainder of the division between the two bignums *a* and *b*.

**::math::bignum::mod** *n* *m*
: Return *n* modulo *m*. This operation is called modular reduction.

**::math::bignum::pow** *base* *exp*
: Return *base* raised to the exponent *exp*.

**::math::bignum::powm** *base* *exp* *m*
: Return *base* raised to the exponent *exp*, modulo *m*. This function is often used in the field of cryptography.

**::math::bignum::sqrt** *bignum*
: Return the integer part of the square root of *bignum*

**::math::bignum::rand** *bits*
: Return a random number of at most *bits* bits. The returned number is internally generated using Tcl's *expr rand()* function and is not suitable where an unguessable and cryptographically secure random number is needed.

**::math::bignum::lshift** *bignum* *bits*
: Return the result of left shifting *bignum*'s binary representation of *bits* positions on the left. This is equivalent to multiplying by 2^*bits* but much faster.

**::math::bignum::rshift** *bignum* *bits*
: Return the result of right shifting *bignum*'s binary representation of *bits* positions on the right. This is equivalent to dividing by *2^bits* but much faster.

**::math::bignum::bitand** *a* *b*
: Return the result of doing a bitwise AND operation on a and b. The operation is restricted to positive numbers, including zero. When negative numbers are provided as arguments the result is undefined.

**::math::bignum::bitor** *a* *b*
: Return the result of doing a bitwise OR operation on a and b. The operation is restricted to positive numbers, including zero. When negative numbers are provided as arguments the result is undefined.

**::math::bignum::bitxor** *a* *b*
: Return the result of doing a bitwise XOR operation on a and b. The operation is restricted to positive numbers, including zero. When negative numbers are provided as arguments the result is undefined.

**::math::bignum::setbit** *bignumVar* *bit*
: Set the bit at *bit* position to 1 in the bignum stored in the variable *bignumVar*. Bit 0 is the least significant.

**::math::bignum::clearbit** *bignumVar* *bit*
: Set the bit at *bit* position to 0 in the bignum stored in the variable *bignumVar*. Bit 0 is the least significant.

**::math::bignum::testbit** *bignum* *bit*
: Return true if the bit at the *bit* position of *bignum* is on, otherwise false is returned. If *bit* is out of range, it is considered as set to zero.

**::math::bignum::bits** *bignum*
: Return the number of bits needed to represent bignum in radix 2.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: bignum* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2004 Salvatore Sanfilippo <antirez at invece dot org>
Copyright (c) 2004 Arjen Markus <arjenmarkus at users dot sourceforge dot net>
```
