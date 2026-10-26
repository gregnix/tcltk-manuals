---
CommandName: bench_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench
 - bench_lang_faq
 - bench_lang_intro
 - bench_lang_spec
Keywords:
 - bench language
 - benchmark
 - performance
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bench_intro - bench introduction

# Description

The *bench* (short for *benchmark tools*), is a set of related, yet different, entities which are working together for the easy creation and execution of performance test suites, also known as benchmarks. These are

**\[1\]**
: A tcl based language for the declaration of test cases. A test case is represented by a tcl command declaring the various parts needed to execute it, like setup, cleanup, the commands to test, etc.

**\[2\]**
: A package providing the ability to execute test cases written in that language. Which of the more detailed documents are relevant to the reader of this introduction depends on their role in the benchmarking process.

**\[1\]**
: A *writer* of benchmarks has to understand the bench language itself. A beginner to bench should read the more informally written *bench language introduction* first. Having digested this the formal *bench language specification* should become understandable. A writer experienced with bench may only need this last document from time to time, to refresh her memory.

**\[2\]**
: A *user* of benchmark suites written in the *bench* language has to know which tools are available for use. At the bottom level sits the package **bench**, providing the basic facilities to read and execute files containing benchmarks written in the bench language, and to manipulate benchmark results.


# Historical notes

This module and package have been derived from Jeff Hobbs' **tclbench** application for the benchmarking of the Tcl core and its ancestor "*runbench.tcl*".

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
