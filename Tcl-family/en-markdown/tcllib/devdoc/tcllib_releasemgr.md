---
CommandName: tcllib_releasemgr
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: 
Copyright:
---

# Name

tcllib_releasemgr - Tcllib - The Release Manager's Guide

# Description

Welcome to Tcllib, the Tcl Standard Library. Note that Tcllib is not a package itself. It is a collection of (semi-independent) *Tcl* packages that provide utility functions useful to a large collection of Tcl programmers.

The audience of this document is the release manager for Tcllib, their deputies, and anybody else interested in the task of creating an official release of Tcllib for distribution.

Please read *Tcllib - How To Get The Sources* first, if that was not done already. Here we assume that the sources are already available in a directory of your choice.

# Tools

The "*sak.tcl*" script in the toplevel directory of a Tcllib checkout is the one tool used by the release manager to perform its **Tasks**.

The main commands to be used are

```
    sak.tcl validate
    sak.tcl test run
    sak.tcl review
    sak.tcl readme
    sak.tcl localdoc
    sak.tcl release
```

More detail will be provided in the explanations of the various **Tasks**.

# Tasks

## Start a release candidate

todo: open a candidate for release

## Ready the candidate

todo: test, validate and check that the candidate is worthy of release fix testsuites, possibly fix packages, documentation regenerate docs coordinate with package maintainers wrt fixes big thing: going over the packages, classify changes since last release to generate a nice readme.

## Make it official

todo: finalize release, make candidate official

## Distribute the release

With the release made it has to be published and the world notified of its existence.

**\[1\]**
: Create a proper fossil event for the release, via *http://core.tcl-lang.org/tcllib/eventedit*. An [existing event](http://core.tcl-lang.org/tcllib/event/dac0ddcd2e990234143196b4dc438fe01e7b9817) should be used as template.

**\[2\]**
: Update a number of web locations:


**\[1\]**
: [Home page](http://core.tcl-lang.org/tcllib/doc/trunk/embedded/index.md)

**\[2\]**
: [Downloads](http://core.tcl-lang.org/tcllib/wiki?name=Downloads)

**\[3\]**
: [Past Releases](http://core.tcl-lang.org/tcllib/wiki?name=Past+Releases)

**\[4\]**
: *http://www.tcl-lang.org/home/release.txt*

**\[5\]**
: *http://www.tcl-lang.org/software/tcllib/\*.tml*

**\[6\]**
: *http://wiki.tcl-lang.org/page/Tcllib*


: The first location maps to the file "*embedded/index.md*" in the repository itself, as such it can edited as part of the release process. This is where reference to the new fossil event is added, as the new current release. The next two locations are in the fossil tcllib wiki and require admin or wiki write permissions for *http://core.tcl-lang.org/tcllib*. The last two locations require ssh access to *http://www.tcl-lang.org* and permission to edit files in the web area.

**\[3\]**
: \*\*\*TODO\*\*\* mailing lists and other places to send notes to.
