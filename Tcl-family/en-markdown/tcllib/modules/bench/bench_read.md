---
CommandName: bench::in
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench
 - bench::out::csv
 - bench::out::text
 - bench_intro
Keywords:
 - benchmark
 - csv
 - formatting
 - human readable
 - parsing
 - performance
 - reading
 - testing
 - text
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bench::in - bench::in - Reading benchmark results

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [csv]{.lit} 
[package]{.cmd} [require]{.sub} [bench::in]{.lit} [0.2]{.optlit} 
[::bench::in::read]{.cmd} [file]{.arg} 
:::

# Description

This package provides a command for reading benchmark results from files, sockets, etc.

A reader interested in the creation, processing or writing of such results should go and read *bench - Processing benchmark suites* instead.

If the bench language itself is the actual interest please start with the *bench language introduction* and then proceed from there to the formal *bench language specification*.

# Public api

**::bench::in::read** *file*
: This command reads a benchmark result from the specified *file* and returns it as its result. The command understands the three formats created by the commands


**bench::out::raw**
: Provided by package **bench**.

**bench::out::csv**
: Provided by package **bench::out::csv**.

**bench::out::text**
: Provided by package **bench::out::text**.


and automatically detects which format is used by the input file.

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
