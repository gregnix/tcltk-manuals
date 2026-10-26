---
CommandName: bench_lang_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench_intro
 - bench_lang_spec
Keywords:
 - bench language
 - benchmark
 - examples
 - performance
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bench_lang_intro - bench language introduction

# Description

This document is an informal introduction to version 1 of the bench language based on a multitude of examples. After reading this a benchmark writer should be ready to understand the formal *bench language specification*.

## Fundamentals

In the broadest terms possible the *bench language* is essentially Tcl, plus a number of commands to support the declaration of benchmarks. A document written in this language is a Tcl script and has the same syntax.

## Basics

One of the most simplest benchmarks which can be written in bench is

```
bench -desc LABEL -body {
    set a b
}
```

This code declares a benchmark named **LABEL** which measures the time it takes to assign a value to a variable. The Tcl code doing this assignment is the **-body** of the benchmark.

## Pre- and postprocessing

Our next example demonstrates how to declare *initialization* and *cleanup* code, i.e. code computing information for the use of the **-body**, and for releasing such resources after the measurement is done. They are the **-pre**- and the **-post**-body, respectively.

In our example, directly drawn from the benchmark suite of Tcllib's **aes** package, the concrete initialization code constructs the key schedule used by the encryption command whose speed we measure, and the cleanup code releases any resources bound to that schedule.

```
bench -desc "AES-${len} ECB encryption core" -pre {
    set key [aes::Init ecb $k $i]
} -body {
    aes::Encrypt $key $p
} -post {
    aes::Final $key
}
```

## Advanced pre- and postprocessing

Our last example again deals with initialization and cleanup code. To see the difference to the regular initialization and cleanup discussed in the last section it is necessary to know a bit more about how bench actually measures the speed of the the **-body**.

Instead of running the **-body** just once the system actually executes the **-body** several hundred times and then returns the average of the found execution times. This is done to remove environmental effects like machine load from the result as much as possible, with outliers canceling each other out in the average.

The drawback of doing things this way is that when we measure operations which are not idempotent we will most likely not measure the time for the operation we want, but of the state(s) the system is in after the first iteration, a mixture of things we have no interest in.

Should we wish, for example, to measure the time it takes to include an element into a set, with the element not yet in the set, and the set having specific properties like being a shared Tcl_Obj, then the first iteration will measure the time for this. *However* all subsequent iterations will measure the time to include an element which is already in the set, and the Tcl_Obj holding the set will not be shared anymore either. In the end the timings taken for the several hundred iterations of this state will overwhelm the time taken from the first iteration, the only one which actually measured what we wanted.

The advanced initialization and cleanup codes, **-ipre**- and the **-ipost**-body respectively, are present to solve this very problem. While the regular initialization and cleanup codes are executed before and after the whole series of iterations the advanced codes are executed before and after each iteration of the body, without being measured themselves. This allows them to bring the system into the exact state the body wishes to measure.

Our example, directly drawn from the benchmark suite of Tcllib's **struct::set** package, is for exactly the example we used above to demonstrate the necessity for the advanced initialization and cleanup. Its concrete initialization code constructs a variable refering to a set with specific properties (The set has a string representation, which is shared) affecting the speed of the inclusion command, and the cleanup code releases the temporary variables created by this initialization.

```
bench -desc "set include, missing <SC> x$times $n" -ipre {
    set A $sx($times,$n)
    set B $A
} -body {
    struct::set include A x
} -ipost {
    unset A B
}
```

# Further reading

Now that this document has been digested the reader, assumed to be a *writer* of benchmarks, he should be fortified enough to be able to understand the formal *bench language specfication*. It will also serve as the detailed specification and cheat sheet for all available commands and their syntax.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *bench* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Benchmark tools

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
