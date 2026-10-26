---
CommandName: bench::out::csv
ManualSection: n
Version: 0.1.3
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench
 - bench::out::text
Keywords:
 - benchmark
 - csv
 - formatting
 - performance
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bench::out::csv - bench::out::csv - Formatting benchmark results as CSV

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [bench::out::csv]{.lit} [0.1.3]{.optlit} 
[::bench::out::csv]{.cmd} [bench_result]{.arg} 
:::

# Description

This package provides commands for fomatting of benchmark results into a CSV table importable by spread sheets.

A reader interested in the generation or processing of such results should go and read *bench - Processing benchmark suites* instead.

If the bench language itself is the actual interest please start with the *bench language introduction* and then proceed from there to the formal *bench language specification*.

# Public api

**::bench::out::csv** *bench_result*
: This command formats the specified benchmark result for output to a file, socket, etc. This specific command generates CSV data importable by spread sheets. For other formatting styles see the packages **bench** and **bench::out::text** which provide commands to format benchmark results in raw form, or for human consumption, respectively.


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
