---
CommandName: tcllib_sources
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: 
Copyright:
---

# Name

tcllib_sources - Tcllib - How To Get The Sources

# Description

Welcome to Tcllib, the Tcl Standard Library. Note that Tcllib is not a package itself. It is a collection of (semi-independent) *Tcl* packages that provide utility functions useful to a large collection of Tcl programmers.

The audience of this document is anyone wishing to either have just a look at Tcllib's source code, or build the packages, or to extend and modify them.

For builders and developers we additionally provide

**\[1\]**
: *Tcllib - The Installer's Guide*.

**\[2\]**
: *Tcllib - The Developer's Guide*. respectively.


# Source location

The official repository for Tcllib is found at *http://core.tcl-lang.org/tcllib*. This repository is managed by the [Fossil SCM](http://www.fossil-scm.org).

# Get archives for head and releases

This is done easiest by going to the [official repository](http://core.tcl-lang.org/tcllib) and following the links in the *Releases* section at the top, immediately underneath the entry field for searching the package documentation.

# Retrieval of arbitrary commits

For anything beyond head state and releases the process is a bit more involved.

If the commit id (commit hash) **((ID))** of the revision of interest is already known then links to the desired archives can be constructed using the forms below:

```
    https://core.tcl-lang.org/tcllib/tarball/((ID))/Tcl+Library+Source+Code.tar.gz
    https://core.tcl-lang.org/tcllib/zip/((ID))/Tcl+Library+Source+Code.zip
```

Note that branch names can be used for the **((ID))** also, this returns archives containing the head revision of the named branch.

The part of of the url after the **((ID))** is the name of the file to return and can be modified to suit.

Without a known commit id the process is longer again:

**\[1\]**
: Go to the [official repository](http://core.tcl-lang.org/tcllib).

**\[2\]**
: Find the login link/button in the top right corner of the page.

**\[3\]**
: Log in as "anonymous", using the semi-random password in the captcha.

**\[4\]**
: Go to the "Timeline" following the link/button in the middle of the nav bar.

**\[5\]**
: Choose the revision you wish to have.

**\[6\]**
: Follow its link to its detailed information page.

**\[7\]**
: On that page, choose either the "ZIP" or "Tarball" link to get a copy of this revision in the format of your choice.


# Source code management

The sources are managed with the [Fossil SCM](http://www.fossil-scm.org). Binaries for popular platforms can be found directly at its [download page](http://www.fossil-scm.org/download.html).

With that tool available the full history can be retrieved via:

```
    fossil clone  http://core.tcl-lang.org/tcllib  tcllib.fossil
```

followed by

```
    mkdir tcllib
    cd tcllib
    fossil open ../tcllib.fossil
```

to get a checkout of the head of the trunk.
