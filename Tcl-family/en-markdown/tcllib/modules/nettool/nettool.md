---
CommandName: nettool
title: nettool
ManualSection: n
Version: 0.5.4
TclPart: tcllib
TclDescription: nettool
Keywords:
 - nettool
 - odie
Copyright:
 - Copyright (c) 2015-2018 Sean Woods <yoda@etoyoc.com>
---

# Name

nettool - Tools for networked applications

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [nettool]{.lit} [0.5.4]{.optlit}
[package]{.cmd} [require]{.sub} [twapi]{.lit} [3.1]{.lit}
[package]{.cmd} [require]{.sub} [ip]{.lit} [0.2]{.lit}
[package]{.cmd} [require]{.sub} [platform]{.lit} [0.2]{.lit}
[::cat]{.cmd} [filename]{.arg}
[::nettool::allocate\_port]{.cmd} [startingport]{.arg}
[::nettool::arp\_table]{.cmd}
[::nettool::broadcast\_list]{.cmd}
[::nettool::claim\_port]{.cmd} [port]{.arg} [protocol]{.optarg}
[::nettool::cpuinfo]{.cmd} [args]{.arg}
[::nettool::find\_port]{.cmd} [startingport]{.arg}
[::nettool::hwid\_list]{.cmd}
[::nettool::ip\_list]{.cmd}
[::nettool::mac\_list]{.cmd}
[::nettool::network\_list]{.cmd}
[::nettool::port\_busy]{.cmd} [port]{.arg}
[::nettool::release\_port]{.cmd} [port]{.arg} [protocol]{.optarg}
[::nettool::status]{.cmd}
[::nettool::user\_data\_root]{.cmd} [appname]{.arg}
:::

# Description

The **nettool** package consists of a Pure-tcl set of tools to perform common network functions that would normally require different packages or calls to exec, in a standard Tcl interface. At present nettool has reference implementations for the following operating systems: Windows, MacOSX, and Linux (debian).

# Commands

**::cat** *filename*
: Dump the contents of a file as a result.

**::nettool::allocate\_port** *startingport*
: Attempt to allocate *startingport*, or, if busy, advance the port number sequentially until a free port is found, and claim that port. This command uses a built-in database of known ports to avoid returning a port which is in common use. (For example: http (80))

**::nettool::arp\_table**
: Dump the contents of this computer's Address Resolution Protocol (ARP) table. The result will be a Tcl formatted list: *macid* *ipaddrlist* ...

**::nettool::broadcast\_list**
: Returns a list of broadcast addresses (suitable for UDP multicast) that this computer is associated with.

**::nettool::claim\_port** *port* ?*protocol*?
: Mark *port* as busy, optionally as either **tcp** (default) or **udp**.

**::nettool::cpuinfo** *args*
: If no arguments are given, return a key/value list describing the CPU of the present machine. Included in the matrix is info on the number of cores/processors that are available for parallel tasking, installed physical RAM, and processor family.

    The exact contents are platform specific.

    For Linux, information is drawn from /proc/cpuinfo and /proc/meminfo.

    For MacOSX, information is drawn from sysctl

    For Windows, information is draw from TWAPI.

    If arguments are given, the result with be a key/value list limited to the fields requested.

    Canonical fields for all platforms:

    cpus
    : Count of CPUs/cores/execution units

    speed
    : Clock speed of processor(s) in Mhz

    memory
    : Installed RAM (in MB)

    vendor
    : Manufacturer


**::nettool::find\_port** *startingport*
: Return *startingport* if it is available, or the next free port after *startingport*. Note: Unlike **::nettool::allocate\_port**, this command does not claim the port.

    This command uses a built-in database of known ports to avoid returning a port which is in common use. (For example: http (80))

**::nettool::hwid\_list**
: Return a list of hardware specific identifiers from this computer. The source and content will vary by platform.

    For MacOSX, the motherboard serial number and macids for all network devices is returned.

    For Windows, the volume serial number of C and macids for all network devices is returned.

    For Linux, macids for all network devices is returned.

**::nettool::ip\_list**
: Return a list of IP addresses associated with this computer.

**::nettool::mac\_list**
: Return a list of MACIDs for the network cards attached to this machine. The MACID of the primary network card is returned first.

**::nettool::network\_list**
: Return a list of networks associated with this computer. Networks are formated with **ip::nativeToPrefix**.

**::nettool::port\_busy** *port*
: Return true if *port* is claimed, false otherwise.

**::nettool::release\_port** *port* ?*protocol*?
: Mark *port* as not busy, optionally as either **tcp** (default) or **udp**.

**::nettool::status**
: Return a key/value list describing the status of the computer. The output is designed to be comparable to the output of **top** for all platforms.

    Common fields include:

    load
    : Processes per processing unit

    memory\_total
    : Total physical RAM (MB)

    memory\_free
    : Total physical RAM unused (MB)


**::nettool::user\_data\_root** *appname*
: Return a fully qualified path to a folder where *appname* should store it's data. The path is not created, only computed, by this command.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *odie* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

System

# Copyright

```
Copyright (c) 2015-2018 Sean Woods <yoda@etoyoc.com>
```
