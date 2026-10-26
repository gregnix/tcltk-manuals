---
CommandName: transfer::copy
title: transfer::copy
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::copy - Data transfer foundation

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit}
[transfer::copy::do]{.cmd} [chan|string]{.lit} [data]{.arg} [outchannel]{.arg} [options...]{.optarg}
[transfer::copy::chan]{.cmd} [channel]{.arg} [outchannel]{.arg} [options...]{.optarg}
[transfer::copy::string]{.cmd} [string]{.arg} [outchannel]{.arg} [options...]{.optarg}
[transfer::copy::doChan]{.cmd} [channel]{.arg} [outchannel]{.arg} [optvar]{.arg}
[transfer::copy::doString]{.cmd} [string]{.arg} [outchannel]{.arg} [optvar]{.arg}
[transfer::copy::options]{.cmd} [outchannel]{.arg} [optionlist]{.arg} [optvar]{.arg}
:::

# Description

This package provides a number of commands for the asynchronous of information contained in either a string or channel. The main point of this package is that the commands here provide a nicer callback API than the builtin command **fcopy**, making the use of these facilities simpler than the builtin.

# API

**transfer::copy::do** **chan**|**string** *data* *outchannel* ?*options*...?
: This command transfers the information in *data* to the *outchannel*, according to the *options*. The type of the information in *data* is determined by the first argument.

    The options available to this command are the same as are available to the command **transfer::copy::options**, and explained there.

    **chan**
    : The argument *data* contains the handle of a channel and the actual infomration to transfer is read from that channel.

    **string**
    : The argument *data* contains a string and this is the information to be transfered.


**transfer::copy::chan** *channel* *outchannel* ?*options*...?
: This command is a shorter and more direct form for the command **transfer::copy::do chan**.

**transfer::copy::string** *string* *outchannel* ?*options*...?
: This command is a shorter and more direct form for the command **transfer::copy::do string**.

**transfer::copy::doChan** *channel* *outchannel* *optvar*
: This command is an alternate form of **transfer::copy::chan** which reads its options out of the array variable named by *optvar* instead of from a variable length argument list.

**transfer::copy::doString** *string* *outchannel* *optvar*
: This command is an alternate form of **transfer::copy::string** which reads its options out of the array variable named by *optvar* instead of from a variable length argument list.

**transfer::copy::options** *outchannel* *optionlist* *optvar*
: This command is the option processor used by all the commands above which read their options from a variable length argument list. It first reads default settings from the channel handle *outchannel*, then processes the list of options in *optionlist*, at last stores the results in the array variable named by *optvar*. The contents of that variable are in a format which is directly understood by all the commands above which read their options out of an array variable.

    The recognized options are:

    **-blocksize** *int*
    : This option specifies the size of the chunks to transfer in one operation. It is optional and defaults to the value of **-buffersize** as configured for the output channel.

        If specified its value has to be an integer number greater than zero.

    **-command** *commandprefix*
    : This option specifies the completion callback of the operation. This option has to be specified. An error will be thrown if it is not, or if the empty list was specified as argument to it.

        Its value has to be a command prefix, i.e. a list whose first word is the command to execute, followed by words containing fixed arguments. When the callback is invoked one or two additional arguments are appended to the prefix. The first argument is the number of bytes which were transfered. The optional second argument is an error message and added if and only if an error occured during the the transfer.

    **-progress** *commandprefix*
    : This option specifies the progress callback of the operation. It is optional and defaults to the empty list. This last possibility signals that no feedback was asked for and disabled it.

        Its value has to be a command prefix, see above, **-command** for a more detailed explanation. When the callback is invoked a single additional arguments is appended to the prefix. This argument is the number of bytes which were transfered so far.

    **-size** *int*
    : This option specifies the number of bytes to read from the input data and transfer. It is optional and defaults to "Transfer everything". Its value has to be an integer number and any value less than zero has the same meaning, i.e. to transfer all available data. Any other value is the amount of bytes to transfer.

        All transfer commands will throw error an when their user tries to transfer more data than is available in the input. This happens immediately, before the transfer is actually started, should the input be a string. Otherwise the, i.e. for a channel as input, the error is thrown the moment the underflow condition is actually detected.

    **-encoding** *encodingname*
    : see below ...

    **-eofchar** *eofspec*
    : see below ...

    **-translation** *transspec*
    : These options are the same as are recognized by the builtin command **fconfigure** and provide the settings for the output channel which are to be active during the transfer, and only then. I.e. the settings of the output channel before the transfer are saved, and restored at the end of a transfer, regardless of its success or failure. None of these options are required, and they default to the settings of the output channel if not specified.



# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *transfer* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Transfer module

# Copyright

```
Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
