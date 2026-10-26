---
CommandName: tcllib_install_guide
title: tcllib_install_guide
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription:
Copyright:
---

# Name

tcllib\_install\_guide - Tcllib - The Installer's Guide

# Description

Welcome to Tcllib, the Tcl Standard Library. Note that Tcllib is not a package itself. It is a collection of (semi-independent) *Tcl* packages that provide utility functions useful to a large collection of Tcl programmers.

This document is targeted at anybody wishing to build and install the packages found in Tcllib, for either themselves, or others.

We additionally provide

1. *Tcllib - The Developer's Guide*.


for developers wishing to work on the packages themselves.

Please read *Tcllib - How To Get The Sources* first, if that was not done already. Here we assume that the sources are already available in a directory of your choice.

# Requisites

Before Tcllib can be build and used a number of requisites must be installed. These are:

1. The scripting language Tcl. For details see [Tcl].

2. Optionally, the **critcl** package (C embedding) for [Tcl]. For details see [Critcl].


This list assumes that the machine where Tcllib is to be installed is essentially clean. Of course, if parts of the dependencies listed below are already installed the associated steps can be skipped. It is still recommended to read their sections though, to validate that the dependencies they talk about are indeed installed.

## Tcl

As we are installing a number of Tcl packages and applications it should be pretty much obvious that a working installation of Tcl itself is needed, and I will not belabor the point.

Out of the many possibilities use whatever you are comfortable with, as long as it provides at the very least Tcl 8.2, or higher. This may be a Tcl installation provided by your operating system distribution, from a distribution-independent vendor, or built by yourself.

*Note* that the packages in Tcllib have begun to require 8.4, 8.5, and even 8.6. Older versions of Tcl will not be able to use such packages. Trying to use them will result in *package not found* errors, as their package index files will not register them in versions of the core unable to use them.

Myself, I used (and still use) [ActiveState's](http://www.activestate.com) ActiveTcl 8.5 distribution during development, as I am most familiar with it.

*(Disclosure: I, Andreas Kupries, worked for ActiveState until 2016, maintaining ActiveTcl and TclDevKit for them).*. I am currently working for SUSE Software Canada ULC, although not in Tcl-related areas.

This distribution can be found at <http://www.activestate.com/activetcl>. Retrieve the archive of ActiveTcl 8.5 (or higher) for your platform and install it as directed by ActiveState.

For those wishing to build and install Tcl on their own, the relevant sources can be found at

Tcl
: <http://core.tcl-lang.org/tcl/>


together with the necessary instructions on how to build it.

If there are problems with building, installing, or using Tcl, please file a ticket against *Tcl*, or the vendor of your distribution, and *not* *Tcllib*.

## Critcl

The **critcl** tool is an *optional* dependency.

It is only required when trying to build the C-based *accelerators* for a number of packages, as explained in [Critcl & accelerators]

*Beware*: The C accelerators are *built by default*.

For Unix Tcllib's build system (**sak.tcl**) looks for it in the , using the name **critcl**.

On Windows on the other hand the search is more complex. The build system looks first looks for a proper application **critcl.exe**. When that is not found it looks for a combination of interpreter (**tclkitsh.exe**, **tclsh.exe**) and starkit (**critcl.kit**, **critcl**) instead. *Note* that the choice of starkit can be overriden via the environment variable .

Tcllib 1.21 and older requires Critcl version 2 or higher.

Tcllib 2.0 and newer on the other hand requires Critcl version 3.3 or higher.

The [Critcl](https://andreas-kupries.github.io/critcl) provides these releases and the associated sources.

Any branch of the repository can be used (if not using the prebuild starkit or starpack), although the use of the stable branch *master* is recommended.

At the above url is also an explanation on how to build and install Critcl, including a list of its dependencies.

Its instructions will not be repeated here. If there are problems with these directions please file a ticket against the *Critcl* project, and not Tcllib.

# Build & installation instructions

As Tcllib is mainly a bundle of packages written in pure Tcl building it is the same as installing it. The exceptions to this have their own subsection, [Critcl & accelerators], later on.

Before that however comes the standard case, differentiated by the platforms with material differences in the instruction, i.e. *Unix*-like, versus *Windows*.

Regarding the latter it should also be noted that it is possible set up an *Unix*-like environment using projects like *MSYS*, *Cygwin*, and others. In that case the user has the choice of which instructions to follow.

Regardless of environment or platform, a suitable *Tcl* has to be installed, and its **tclsh** should be placed on the  (*Unix*) or associated with "*.tcl*" files (*Windows*).

## Installing on Unix

For *Unix*-like environments Tcllib comes with the standard set of files to make

```
  ./configure
  make install
  # or just
  make
```

a suitable way of installing it. This is a standard non-interactive install automatically figuring out where to place everything, i.e. packages, applications, and the manpages.

*This includes the Tcllibc binary package*. Therefore requires an installation of Critcl.

To install only specific parts of the project use

```
  make install-binaries      # Tcllibc. Requires an installation of Critcl.
  make install-tcl           # Tcl packages and applications.
  make install-libraries     # Tcl packages alone.
  make install-applications  # Applications alone.
  make install-doc           # Nroff manpages.
```

For a graphical installer invoke

```
  ./installer.tcl
```

instead. *Note* however that this installer handles only the Tcl packages, applications, and the documentation. It does *not* handle the binary Tcllibc.

## Installing on Windows

In a Windows environment we have the **installer.tcl** script to perform installation.

If the desired **tclsh** is associated "*.tcl*" files then double-clicking / opening the **installer.tcl** is enough to invoke it in graphical mode. This assumes that *Tk* is installed and available as well.

Without *Tk* the only way to invoke the installer are to open a DOS window, i.e. **cmd.exe**, and then to invoke

```
  ./installer.tcl
```

inside it. *Note* that this installer handles only the Tcl packages, applications, and the documentation. It does *not* handle the binary Tcllibc.

## Critcl & accelerators

While the majority of Tcllib consists of packages written in pure Tcl a number of packages also have *accelerators* associated with them.

These are **critcl**-based C packages whose use will boost the performance of the packages using them. While they are built by default on Unix (see *make install*), they are not required, they are *optional*.

When building the accelerators the normally optional dependency on **critcl** becomes required. If they are built according to the instructions below then they will also be installed as well.

To build and install Tcllib with the accelerators in a Unix-like environment invoke:

```
  ./configure
  make
  # or
  make install
  # or
  make install-binaries
```

The underlying tool is "*sak.tcl*" in the toplevel directory of Tcllib and the **make install-binaries** target is just a wrapper around

```
  ./sak.tcl critcl
```

Therefore in a Windows environment instead invoke

```
  ./sak.tcl critcl
  ./installer.tcl
```

from within a DOS window, i.e. **cmd.exe**.

*Beware* that the directory tree generated by this command sequence differs from the directory tree generated by **make install** and variants.

**make install** generates two package directories, one for Tcllib, the other for Tcllibc.

The above sequence on the other hand places Tcllibc into a sub-directory of the Tcllib package directory.

## Tooling

The core of Tcllib's build system is the script "*installer.tcl*" found in the toplevel directory of a checkout or release.

The

```
         configure ; make install
```

setup available to developers on Unix-like systems is just a wrapper around it. To go beyond the standard embodied in the wrapper it is necessary to directly invoke this script.

On Windows system using it directly is the only way to invoke it.

For basic help invoke it as

```
         ./installer.tcl -help
```

This will print a short list of all the available options to the standard output channel.

The commands associated with the various *install* targets in the *Makefile.in* for Unix can be used as additional examples on how to use this tool as well.

The installer can operate in GUI and CLI modes. By default it chooses the mode automatically, based on if the Tcl package **Tk** can be used or not. The option **-no-gui** can be used to force CLI mode.

Note that it is possible to specify options on the command line even if the installer ultimatively selects GUI mode. In that case the hardwired defaults and the options determine the data presented to the user for editing.

The installer will select a number of defaults for the locations of packages, examples, and documentation, and also the format of the documentation. The user can overide these defaults in the GUI, or by specifying additional options. The defaults depend on the platform detected (Unix/Windows) and on the **tclsh** executable used to run the installer.

*Options*

**-help**
: Show the list of options explained here on the standard output channel and exit.

**+excluded**
: Include deprecated packages in the installation.

**-no-gui**
: Force command line operation of the installer

**-no-wait**
: In CLI mode the installer will by default ask the user to confirm that the chosen configuration (destination paths, things to install) is correct before performing any action. Using this option causes the installer to skip this query and immediately jump to installation.

**-app-path** *path*
: see below ...

**-example-path** *path*
: see below ...

**-html-path** *path*
: see below ...

**-nroff-path** *path*
: see below ...

**-pkg-path** *path*
: Declare the destination paths for the applications, examples, html documentation, nroff manpages, and packages. The defaults are derived from the location of the **tclsh** used to run the installer.

**-dry-run**
: see below ...

**-simulate**
: Run the installer without modifying the destination directories.

**-apps**
: see below ...

**-no-apps**
: see below ...

**-examples**
: see below ...

**-no-examples**
: see below ...

**-pkgs**
: see below ...

**-no-pkgs**
: see below ...

**-html**
: see below ...

**-no-html**
: see below ...

**-nroff**
: see below ...

**-no-nroff**
: (De)activate the installation of applications, examples, packages, html documentation, and nroff manpages.

    Applications, examples, and packages are installed by default.

    On Windows the html documentation is installed by default.

    On Unix the nroff manpages are installed by default.
