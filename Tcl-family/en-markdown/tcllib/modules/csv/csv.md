---
CommandName: csv
title: csv
ManualSection: n
Version: 0.8.1
TclPart: tcllib
TclDescription: CSV processing
Links:
 - matrix
 - queue
Keywords:
 - csv
 - matrix
 - package
 - queue
 - tcllib
Copyright:
 - Copyright (c) 2002-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

csv - Procedures to handle CSV data.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [csv]{.lit} [0.8.1]{.optlit}
[::csv::iscomplete]{.cmd} [data]{.arg}
[::csv::join]{.cmd} [values]{.arg} [sepChar]{.optarg} [delChar]{.optarg} [delMode]{.optarg}
[::csv::joinlist]{.cmd} [values]{.arg} [sepChar]{.optarg} [delChar]{.optarg} [delMode]{.optarg}
[::csv::joinmatrix]{.cmd} [matrix]{.arg} [sepChar]{.optarg} [delChar]{.optarg} [delMode]{.optarg}
[::csv::read2matrix]{.cmd} [-alternate]{.optlit} [chan]{.arg} [m]{.arg} [{sepChar ,}]{.arg} [{expand none}]{.arg}
[::csv::read2queue]{.cmd} [-alternate]{.optlit} [chan]{.arg} [q]{.arg} [{sepChar ,}]{.arg}
[::csv::report]{.cmd} [cmd]{.arg} [matrix]{.arg} [chan]{.optarg}
[::csv::split]{.cmd} [-alternate]{.optlit} [line]{.arg} [sepChar]{.optarg} [delChar]{.optarg}
[::csv::split2matrix]{.cmd} [-alternate]{.optlit} [m]{.arg} [line]{.arg} [{sepChar ,}]{.arg} [{expand none}]{.arg}
[::csv::split2queue]{.cmd} [-alternate]{.optlit} [q]{.arg} [line]{.arg} [{sepChar ,}]{.arg}
[::csv::writematrix]{.cmd} [m]{.arg} [chan]{.arg} [sepChar]{.optarg} [delChar]{.optarg}
[::csv::writequeue]{.cmd} [q]{.arg} [chan]{.arg} [sepChar]{.optarg} [delChar]{.optarg}
:::

# Description

The **csv** package provides commands to manipulate information in CSV [Format] (CSV = Comma Separated Values).

# Commands

The following commands are available:

**::csv::iscomplete** *data*
: A predicate checking if the argument *data* is a complete csv record. The result is a boolean flag indicating the completeness of the data. The result is true if the data is complete.

**::csv::join** *values* ?*sepChar*? ?*delChar*? ?*delMode*?
: Takes a list of values and returns a string in CSV format containing these values. The separator character can be defined by the caller, but this is optional. The default is ",". The quoting aka delimiting character can be defined by the caller, but this is optional. The default is '"'. By default the quoting mode *delMode* is "auto", surrounding values with *delChar* only when needed. When set to "always" however, values are always surrounded by the *delChar* instead.

**::csv::joinlist** *values* ?*sepChar*? ?*delChar*? ?*delMode*?
: Takes a list of lists of values and returns a string in CSV format containing these values. The separator character can be defined by the caller, but this is optional. The default is ",". The quoting character can be defined by the caller, but this is optional. The default is '"'. By default the quoting mode *delMode* is "auto", surrounding values with *delChar* only when needed. When set to "always" however, values are always surrounded by the *delChar* instead. Each element of the outer list is considered a record, these are separated by newlines in the result. The elements of each record are formatted as usual (via **::csv::join**).

**::csv::joinmatrix** *matrix* ?*sepChar*? ?*delChar*? ?*delMode*?
: Takes a *matrix* object following the API specified for the struct::matrix package and returns a string in CSV format containing these values. The separator character can be defined by the caller, but this is optional. The default is ",". The quoting character can be defined by the caller, but this is optional. The default is '"'. By default the quoting mode *delMode* is "auto", surrounding values with *delChar* only when needed. When set to "always" however, values are always surrounded by the *delChar* instead. Each row of the matrix is considered a record, these are separated by newlines in the result. The elements of each record are formatted as usual (via **::csv::join**).

**::csv::read2matrix** ?**-alternate**? *chan m* {*sepChar* ,} {*expand* none}
: A wrapper around **::csv::split2matrix** (see below) reading CSV-formatted lines from the specified channel (until EOF) and adding them to the given matrix. For an explanation of the *expand* argument see **::csv::split2matrix**.

**::csv::read2queue** ?**-alternate**? *chan q* {*sepChar* ,}
: A wrapper around **::csv::split2queue** (see below) reading CSV-formatted lines from the specified channel (until EOF) and adding them to the given queue.

**::csv::report** *cmd matrix* ?*chan*?
: A report command which can be used by the matrix methods **format 2string** and **format 2chan**. For the latter this command delegates the work to **::csv::writematrix**. *cmd* is expected to be either **printmatrix** or **printmatrix2channel**. The channel argument, *chan*, has to be present for the latter and must not be present for the first.

**::csv::split** ?**-alternate**? *line* ?*sepChar*? ?*delChar*?
: converts a *line* in CSV format into a list of the values contained in the line. The character used to separate the values from each other can be defined by the caller, via *sepChar*, but this is optional. The default is ",". The quoting character can be defined by the caller, but this is optional. The default is '"'.

    If the option **-alternate** is specified a slightly different syntax is used to parse the input. This syntax is explained below, in the section [Format].

**::csv::split2matrix** ?**-alternate**? *m line* {*sepChar* ,} {*expand* none}
: The same as **::csv::split**, but appends the resulting list as a new row to the matrix *m*, using the method **add row**. The expansion mode specified via *expand* determines how the command handles a matrix with less columns than contained in *line*. The allowed modes are:

    **none**
    : This is the default mode. In this mode it is the responsibility of the caller to ensure that the matrix has enough columns to contain the full line. If there are not enough columns the list of values is silently truncated at the end to fit.

    **empty**
    : In this mode the command expands an empty matrix to hold all columns of the specified line, but goes no further. The overall effect is that the first of a series of lines determines the number of columns in the matrix and all following lines are truncated to that size, as if mode **none** was set.

    **auto**
    : In this mode the command expands the matrix as needed to hold all columns contained in *line*. The overall effect is that after adding a series of lines the matrix will have enough columns to hold all columns of the longest line encountered so far.


**::csv::split2queue** ?**-alternate**? *q line* {*sepChar* ,}
: The same as **::csv::split**, but appending the resulting list as a single item to the queue *q*, using the method **put**.

**::csv::writematrix** *m chan* ?*sepChar*? ?*delChar*?
: A wrapper around **::csv::join** taking all rows in the matrix *m* and writing them CSV formatted into the channel *chan*.

**::csv::writequeue** *q chan* ?*sepChar*? ?*delChar*?
: A wrapper around **::csv::join** taking all items in the queue *q* (assumes that they are lists) and writing them CSV formatted into the channel *chan*.


# Format

The format of regular CSV files is specified as

1. Each record of a csv file (comma-separated values, as exported e.g. by Excel) is a set of ASCII values separated by ",". For other languages it may be ";" however, although this is not important for this case as the functions provided here allow any separator character.

2. If and only if a value contains itself the separator ",", then it (the value) has to be put between "". If the value does not contain the separator character then quoting is optional.

3. If a value contains the character ", that character is represented by "".

4. The output string "" represents the value ". In other words, it is assumed that it was created through rule 3, and only this rule, i.e. that the value was not quoted.


An alternate format definition mainly used by MS products specifies that the output string "" is a representation of the empty string. In other words, it is assumed that the output was generated out of the empty string by quoting it (i.e. rule 2), and not through rule 3. This is the only difference between the regular and the alternate format.

The alternate format is activated through specification of the option **-alternate** to the various split commands.

# Example

Using the regular format the record

```
123,"123,521.2","Mary says ""Hello, I am Mary""",""
```

is parsed into the items

```
a) 123
b) 123,521.2
c) Mary says "Hello, I am Mary"
d) "
```

Using the alternate format the result is

```
a) 123
b) 123,521.2
c) Mary says "Hello, I am Mary"
d) (the empty string)
```

instead. As can be seen only item (d) is different, now the empty string instead of a ".

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *csv* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing

# Copyright

```
Copyright (c) 2002-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
