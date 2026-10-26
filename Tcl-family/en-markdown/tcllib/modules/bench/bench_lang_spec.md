---
CommandName: bench_lang_spec
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - bench_intro
 - bench_lang_intro
Keywords:
 - bench language
 - benchmark
 - performance
 - specification
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bench_lang_spec - bench language specification

# Synopsis

::: {.synopsis} :::
[bench_rm]{.cmd} [path...]{.arg} 
[bench_tmpfile]{.cmd} 
[bench]{.cmd} [options...]{.arg} 
:::

# Description

This document specifies both names and syntax of all the commands which together are the bench language, version 1. As this document is intended to be a reference the commands are listed in alphabetical order, and the descriptions are relatively short. A beginner should read the more informally written *bench language introduction* first.

# Commands

**bench_rm** *path*...
: This command silently removes the files specified as its arguments and then returns the empty string as its result. The command is *trusted*, there is no checking if the specified files are outside of whatever restricted area the benchmarks are run in.

**bench_tmpfile**
: This command returns the path to a bench specific unique temporary file. The uniqueness means that multiple calls will return different paths. While the path may exist from previous runs, the command itself does *not* create aynthing. The base location of the temporary files is platform dependent:


**Unix, and indeterminate platform**
: "*/tmp*"

**Windows**
: **\$TEMP**

**Anything else**
: The current working directory.


**bench** *options*...
: This command declares a single benchmark. Its result is the empty string. All parts of the benchmark are declared via options, and their values. The options can occur in any order. The accepted options are:


**-body** script
: The argument of this option declares the body of the benchmark, the Tcl script whose performance we wish to measure. This option, and **-desc**, are the two required parts of each benchmark.

**-desc** msg
: The argument of this option declares the name of the benchmark. It has to be unique, or timing data from different benchmarks will be mixed together. *Beware!* This requirement is not checked when benchmarks are executed, and the system will silently produce bogus data. This option, and **-body**, are the two required parts of each benchmark.

**-ipost** script
: The argument of this option declares a script which is run immediately *after* each iteration of the body. Its responsibility is to release resources created by the body, or **-ipre**-bodym which we do not wish to live into the next iteration.

**-ipre** script
: The argument of this option declares a script which is run immediately *before* each iteration of the body. Its responsibility is to create the state of the system expected by the body so that we measure the right thing.

**-iterations** num
: The argument of this option declares the maximum number of times to run the **-body** of the benchmark. During execution this and the global maximum number of iterations are compared and the smaller of the two values is used. This option should be used only for benchmarks which are expected or known to take a long time per run. I.e. reduce the number of times they are run to keep the overall time for the execution of the whole benchmark within manageable limits.

**-post** script
: The argument of this option declares a script which is run *after* all iterations of the body have been run. Its responsibility is to release resources created by the body, or **-pre**-body.

**-pre** script
: The argument of this option declares a script which is run *before* any of the iterations of the body are run. Its responsibility is to create whatever resources are needed by the body to run without failing.


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
