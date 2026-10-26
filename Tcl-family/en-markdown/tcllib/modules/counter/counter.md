---
CommandName: counter
title: counter
ManualSection: n
Version: 2.0.6
TclPart: tcllib
TclDescription: Counters and Histograms
Keywords:
 - counting
 - histogram
 - statistics
 - tallying
Copyright:
---

# Name

counter - Procedures for counters and histograms

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [counter]{.lit} [2.0.6]{.optlit}
[::counter::init]{.cmd} [tag]{.arg} [args]{.arg}
[::counter::count]{.cmd} [tag]{.arg} [delta]{.optarg} [instance]{.optarg}
[::counter::start]{.cmd} [tag]{.arg} [instance]{.arg}
[::counter::stop]{.cmd} [tag]{.arg} [instance]{.arg}
[::counter::get]{.cmd} [tag]{.arg} [args]{.arg}
[::counter::exists]{.cmd} [tag]{.arg}
[::counter::names]{.cmd}
[::counter::histHtmlDisplay]{.cmd} [tag]{.arg} [args]{.arg}
[::counter::reset]{.cmd} [tag]{.arg} [args]{.arg}
:::

# Description

The **counter** package provides a counter facility and can compute statistics and histograms over the collected data.

**::counter::init** *tag args*
: This defines a counter with the name *tag*.  The *args* determines the characteristics of the counter.  The *args* are

    **-group** *name*
    : Keep a grouped counter where the name of the histogram bucket is passed into **::counter::count**.

    **-hist** *bucketsize*
    : Accumulate the counter into histogram buckets of size *bucketsize*.  For example, if the samples are millisecond time values and *bucketsize* is 10, then each histogram bucket represents time values of 0 to 10 msec, 10 to 20 msec, 20 to 30 msec, and so on.

    **-hist2x** *bucketsize*
    : Accumulate the statistic into histogram buckets.  The size of the first bucket is *bucketsize*, each other bucket holds values 2 times the size of the previous bucket.  For example, if *bucketsize* is 10, then each histogram bucket represents time values of 0 to 10 msec, 10 to 20 msec, 20 to 40 msec, 40 to 80 msec, and so on.

    **-hist10x** *bucketsize*
    : Accumulate the statistic into histogram buckets.  The size of the first bucket is *bucketsize*, each other bucket holds values 10 times the size of the previous bucket.  For example, if *bucketsize* is 10, then each histogram bucket represents time values of 0 to 10 msec, 10 to 100 msec, 100 to 1000 msec, and so on.

    **-lastn** *N*
    : Save the last *N* values of the counter to maintain a "running average" over the last *N* values.

    **-timehist** *secsPerMinute*
    : Keep a time-based histogram.  The counter is summed into a histogram bucket based on the current time.  There are 60 per-minute buckets that have a size determined by *secsPerMinute*, which is normally 60, but for testing purposes can be less.  Every "hour" (i.e., 60 "minutes") the contents of the per-minute buckets are summed into the next hourly bucket.  Every 24 "hours" the contents of the per-hour buckets are summed into the next daily bucket.  The counter package keeps all time-based histograms in sync, so the first *secsPerMinute* value seen by the package is used for all subsequent time-based histograms.


**::counter::count** *tag* ?*delta*? ?*instance*?
: Increment the counter identified by *tag*.  The default increment is 1, although you can increment by any value, integer or real, by specifying *delta*.  You must declare each counter with **::counter::init** to define the characteristics of counter before you start to use it.  If the counter type is **-group**, then the counter identified by *instance* is incremented.

**::counter::start** *tag instance*
: Record the starting time of an interval.  The *tag* is the name of the counter defined as a **-hist** value-based histogram.  The *instance* is used to distinguish this interval from any other intervals that might be overlapping this one.

**::counter::stop** *tag instance*
: Record the ending time of an interval.  The delta time since the corresponding **::counter::start** call for *instance* is recorded in the histogram identified by *tag*.

**::counter::get** *tag args*
: Return statistics about a counter identified by *tag*.  The *args* determine what value to return:

    **-total**
    : Return the total value of the counter.  This is the default if *args* is not specified.

    **-totalVar**
    : Return the name of the total variable.  Useful for specifying with -textvariable in a Tk widget.

    **-N**
    : Return the number of samples accumulated into the counter.

    **-avg**
    : Return the average of samples accumulated into the counter.

    **-avgn**
    : Return the average over the last *N* samples taken.  The *N* value is set in the **::counter::init** call.

    **-hist** *bucket*
    : If *bucket* is specified, then the value in that bucket of the histogram is returned.  Otherwise the complete histogram is returned in array get format sorted by bucket.

    **-histVar**
    : Return the name of the histogram array variable.

    **-histHour**
    : Return the complete hourly histogram in array get format sorted by bucket.

    **-histHourVar**
    : Return the name of the hourly histogram array variable.

    **-histDay**
    : Return the complete daily histogram in array get format sorted by bucket.

    **-histDayVar**
    : Return the name of the daily histogram array variable.

    **-resetDate**
    : Return the clock seconds value recorded when the counter was last reset.

    **-all**
    : Return an array get of the array used to store the counter.  This includes the total, the number of samples (N), and any type-specific information.  This does not include the histogram array.


**::counter::exists** *tag*
: Returns 1 if the counter is defined.

**::counter::names**
: Returns a list of all counters defined.

**::counter::histHtmlDisplay** *tag args*
: Generate HTML to display a histogram for a counter.  The *args* control the format of the display.  They are:

    **-title** *string*
    : Label to display above bar chart

    **-unit** *unit*
    : Specify **minutes**, **hours**, or **days** for the time-base histograms.  For value-based histograms, the *unit* is used in the title.

    **-images** *url*
    : URL of /images directory.

    **-gif** *filename*
    : Image for normal histogram bars.  The *filename* is relative to the **-images** directory.

    **-ongif** *filename*
    : Image for the active histogram bar.  The *filename* is relative to the **-images** directory.

    **-max** *N*
    : Maximum number of value-based buckets to display.

    **-height** *N*
    : Pixel height of the highest bar.

    **-width** *N*
    : Pixel width of each bar.

    **-skip** *N*
    : Buckets to skip when labeling value-based histograms.

    **-format** *string*
    : Format used to display labels of buckets.

    **-text** *boolean*
    : If 1, a text version of the histogram is dumped, otherwise a graphical one is generated.


**::counter::reset** *tag args*
: Resets the counter with the name *tag* to an initial state. The *args* determine the new characteristics of the counter. They have the same meaning as described for **::counter::init**.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *counter* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Data structures
