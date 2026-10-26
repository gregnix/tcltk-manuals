---
CommandName: nmea
ManualSection: n
Version: 1.1.0
TclPart: tcllib
TclDescription: NMEA protocol implementation
Keywords:
 - gps
 - nmea
Copyright:
 - Copyright (c) 2006-2009, Aaron Faupell <afaupell@users.sourceforge.net>
---

# Name

nmea - Process NMEA data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [nmea]{.lit} [1.1.0]{.optlit} 
[::nmea::input]{.cmd} [sentence]{.arg} 
[::nmea::open_port]{.cmd} [port]{.arg} [speed]{.optarg} 
[::nmea::close_port]{.cmd} 
[::nmea::configure_port]{.cmd} [settings]{.arg} 
[::nmea::open_file]{.cmd} [file]{.arg} [rate]{.optarg} 
[::nmea::close_file]{.cmd} 
[::nmea::do_line]{.cmd} 
[::nmea::rate]{.cmd} 
[::nmea::log]{.cmd} [file]{.optarg} 
[::nmea::checksum]{.cmd} [data]{.arg} 
[::nmea::write]{.cmd} [sentence]{.arg} [data]{.arg} 
[::nmea::event]{.cmd} [setence]{.arg} [command]{.optarg} 
:::

# Description

This package provides a standard interface for writing software which recieves NMEA standard input data. It allows for reading data from COM ports, files, or programmatic input. It also supports the checksumming and logging of incoming data. After parsing, input is dispatched to user defined handler commands for processing. To define a handler, see the **event** command. There are no GPS specific functions in this package. NMEA data consists of a sentence type, followed by a list of data.

# Commands

**::nmea::input** *sentence*
: Processes and dispatches the supplied sentence. If *sentence* contains no commas it is treated as a Tcl list, otherwise it must be standard comma delimited NMEA data, with an optional checksum and leading **\$**.


```
nmea::input {$GPGSA,A,3,04,05,,09,12,,,24,,,,,2.5,1.3,2.1*39}
nmea::input [list GPGSA A 3 04 05  09 12 "" "" 24 "" "" ""  2.5 1.3 2.1]
```

**::nmea::open_port** *port* ?speed?
: Open the specified COM port and read NMEA sentences when available. Port speed is set to 4800bps by default or to *speed*.

**::nmea::close_port**
: Close the com port connection if one is open.

**::nmea::configure_port** *settings*
: Changes the current port settings. *settings* has the same format as fconfigure -mode.

**::nmea::open_file** *file* ?rate?
: Open file *file* and read NMEA sentences, one per line, at the rate specified by ?rate? in milliseconds. The file format may omit the leading **\$** and/or the checksum. If rate is <= 0 (the default) then lines will only be processed when a call to **do_line** is made.

**::nmea::close_file**
: Close the open file if one exists.

**::nmea::do_line**
: If there is a currently open file, this command will read and process a single line from it. Returns the number of lines read.

**::nmea::rate**
: Sets the rate at which lines are processed from the open file, in milliseconds. The rate remains consistant across files, there does not need to be a file currently open to use this command. Set to 0 to disable automatic line processing.

**::nmea::log** ?file?
: Starts or stops input logging. If a file name is specified then all NMEA data recieved on the open port will be logged to the ?file? in append mode. If file is an empty string then any logging will be stopped. If no file is specified then returns a boolean value indicating if logging is currently enabled. Data written to the port by **write**, data read from files, or input made using **input**, is not logged.

**::nmea::checksum** *data*
: Returns the checksum of the supplied data.

**::nmea::write** *sentence* *data*
: If there is a currently open port, this command will write the specified sentence and data to the port in proper NMEA checksummed format.

**::nmea::event** *setence* ?command?
: Registers a handler proc for a given NMEA *sentence*. There may be at most one handler per sentence, any existing handler is replaced. If no command is specified, returns the name of the current handler for the given *setence* or an empty string if none exists. In addition to the incoming sentences there are 2 builtin types, EOF and DEFAULT. The handler for the DEFAULT setence is invoked if there is not a specific handler for that sentence. The EOF handler is invoked when End Of File is reached on the open file or port. The handler procedures, with the exception of the builtin types,must take exactly one argument, which is a list of the data values. The DEFAULT handler should have two arguments, the sentence type and the data values. The EOF handler has no arguments.


```
nmea::event gpgsa parse_sat_detail
nmea::event default handle_unknown

proc parse_sat_detail {data} {
    puts [lindex $data 1]
}

proc handle_unknown {name data} {
    puts "unknown data type $name"
}
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *nmea* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2006-2009, Aaron Faupell <afaupell@users.sourceforge.net>
```
