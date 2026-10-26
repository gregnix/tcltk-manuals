---
CommandName: term::ansi::send
title: term::ansi::send
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character output
 - control
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::send - Output of ANSI control sequences to terminals

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::ansi::send]{.lit} [0.2]{.optlit}
[::term::ansi::send::import]{.cmd} [ns]{.optarg} [...]{.arg}
[::term::ansi::send::eeol]{.cmd}
[::term::ansi::send::esol]{.cmd}
[::term::ansi::send::el]{.cmd}
[::term::ansi::send::ed]{.cmd}
[::term::ansi::send::eu]{.cmd}
[::term::ansi::send::es]{.cmd}
[::term::ansi::send::sd]{.cmd}
[::term::ansi::send::su]{.cmd}
[::term::ansi::send::ch]{.cmd}
[::term::ansi::send::sc]{.cmd}
[::term::ansi::send::rc]{.cmd}
[::term::ansi::send::sca]{.cmd}
[::term::ansi::send::rca]{.cmd}
[::term::ansi::send::st]{.cmd}
[::term::ansi::send::ct]{.cmd}
[::term::ansi::send::cat]{.cmd}
[::term::ansi::send::qdc]{.cmd}
[::term::ansi::send::qds]{.cmd}
[::term::ansi::send::qcp]{.cmd}
[::term::ansi::send::rd]{.cmd}
[::term::ansi::send::elw]{.cmd}
[::term::ansi::send::dlw]{.cmd}
[::term::ansi::send::eg]{.cmd}
[::term::ansi::send::lg]{.cmd}
[::term::ansi::send::scs0]{.cmd} [tag]{.arg}
[::term::ansi::send::scs1]{.cmd} [tag]{.arg}
[::term::ansi::send::sda]{.cmd} [arg...]{.arg}
[::term::ansi::send::sda\_fgblack]{.cmd}
[::term::ansi::send::sda\_fgred]{.cmd}
[::term::ansi::send::sda\_fggreen]{.cmd}
[::term::ansi::send::sda\_fgyellow]{.cmd}
[::term::ansi::send::sda\_fgblue]{.cmd}
[::term::ansi::send::sda\_fgmagenta]{.cmd}
[::term::ansi::send::sda\_fgcyan]{.cmd}
[::term::ansi::send::sda\_fgwhite]{.cmd}
[::term::ansi::send::sda\_fgdefault]{.cmd}
[::term::ansi::send::sda\_bgblack]{.cmd}
[::term::ansi::send::sda\_bgred]{.cmd}
[::term::ansi::send::sda\_bggreen]{.cmd}
[::term::ansi::send::sda\_bgyellow]{.cmd}
[::term::ansi::send::sda\_bgblue]{.cmd}
[::term::ansi::send::sda\_bgmagenta]{.cmd}
[::term::ansi::send::sda\_bgcyan]{.cmd}
[::term::ansi::send::sda\_bgwhite]{.cmd}
[::term::ansi::send::sda\_bgdefault]{.cmd}
[::term::ansi::send::sda\_bold]{.cmd}
[::term::ansi::send::sda\_dim]{.cmd}
[::term::ansi::send::sda\_italic]{.cmd}
[::term::ansi::send::sda\_underline]{.cmd}
[::term::ansi::send::sda\_blink]{.cmd}
[::term::ansi::send::sda\_revers]{.cmd}
[::term::ansi::send::sda\_hidden]{.cmd}
[::term::ansi::send::sda\_strike]{.cmd}
[::term::ansi::send::sda\_nobold]{.cmd}
[::term::ansi::send::sda\_noitalic]{.cmd}
[::term::ansi::send::sda\_nounderline]{.cmd}
[::term::ansi::send::sda\_noblink]{.cmd}
[::term::ansi::send::sda\_norevers]{.cmd}
[::term::ansi::send::sda\_nohidden]{.cmd}
[::term::ansi::send::sda\_nostrike]{.cmd}
[::term::ansi::send::sda\_reset]{.cmd}
[::term::ansi::send::fcp]{.cmd} [row]{.arg} [col]{.arg}
[::term::ansi::send::cu]{.cmd} [n]{.optarg}
[::term::ansi::send::cd]{.cmd} [n]{.optarg}
[::term::ansi::send::cf]{.cmd} [n]{.optarg}
[::term::ansi::send::cb]{.cmd} [n]{.optarg}
[::term::ansi::send::ss]{.cmd} [s e]{.optarg}
[::term::ansi::send::skd]{.cmd} [code]{.arg} [str]{.arg}
[::term::ansi::send::title]{.cmd} [str]{.arg}
[::term::ansi::send::gron]{.cmd}
[::term::ansi::send::groff]{.cmd}
[::term::ansi::send::tlc]{.cmd}
[::term::ansi::send::trc]{.cmd}
[::term::ansi::send::brc]{.cmd}
[::term::ansi::send::blc]{.cmd}
[::term::ansi::send::ltj]{.cmd}
[::term::ansi::send::ttj]{.cmd}
[::term::ansi::send::rtj]{.cmd}
[::term::ansi::send::btj]{.cmd}
[::term::ansi::send::fwj]{.cmd}
[::term::ansi::send::hl]{.cmd}
[::term::ansi::send::vl]{.cmd}
[::term::ansi::send::groptim]{.cmd} [str]{.arg}
[::term::ansi::send::clear]{.cmd}
[::term::ansi::send::init]{.cmd}
[::term::ansi::send::showat]{.cmd} [row]{.arg} [col]{.arg} [text]{.arg}
:::

# Description

This package provides commands to send ANSI terminal control sequences to a terminal. All commands come in two variants, one for sending to any channel, the other for sending to *stdout*.

The commands are defined using the control sequences provided by the package **term::ansi::code::ctrl**. They have the same arguments as the commands they are based on, with the exception of the variant for sending to any channel. Their first argument is always a channel handle, then followed by the original arguments. Below we will list only the variant sending to *stdout*.

**::term::ansi::send::import** ?*ns*? *...*
: Imports the commands of this package into the namespace *ns*. If not specified it defaults to *send*. Note that this default is a relative namespace name, i.e. the actual namespace will be created under the current namespace.

    By default all commands will be imported, this can however be restricted to specific commands, by listing them after the namespace to import them into.

**::term::ansi::send::eeol**
: Erase (to) End Of Line.

**::term::ansi::send::esol**
: Erase (to) Start Of Line.

**::term::ansi::send::el**
: Erase (current) Line.

**::term::ansi::send::ed**
: Erase Down (to bottom).

**::term::ansi::send::eu**
: Erase Up (to top).

**::term::ansi::send::es**
: Erase Screen.

**::term::ansi::send::sd**
: Scroll Down.

**::term::ansi::send::su**
: Scroll Up.

**::term::ansi::send::ch**
: Cursor Home.

**::term::ansi::send::sc**
: Save Cursor. Note: Only one saved position can be handled. This is no unlimited stack. Saving before restoring will overwrite the saved data.

**::term::ansi::send::rc**
: Restore Cursor (Unsave).

**::term::ansi::send::sca**
: Save Cursor + Attributes.

**::term::ansi::send::rca**
: Restore Cursor + Attributes.

**::term::ansi::send::st**
: Set Tab (@ current position).

**::term::ansi::send::ct**
: Clear Tab (@ current position).

**::term::ansi::send::cat**
: Clear All Tabs.

**::term::ansi::send::qdc**
: Query Device Code.

**::term::ansi::send::qds**
: Query Device Status.

**::term::ansi::send::qcp**
: Query Cursor Position.

**::term::ansi::send::rd**
: Reset Device.

**::term::ansi::send::elw**
: Enable Line Wrap.

**::term::ansi::send::dlw**
: Disable Line Wrap.

**::term::ansi::send::eg**
: Enter Graphics Mode.

**::term::ansi::send::lg**
: Exit Graphics Mode.

**::term::ansi::send::scs0** *tag*
: see below ...

**::term::ansi::send::scs1** *tag*
: Select Character Set.

    Choose which character set is used for default (scs0) and alternate font (scs1). This does not change whether default or alternate font are used, just their definitions.

    The legal tags, and their meanings, are:

    A
    : United Kingdom Set

    B
    : ASCII Set

    0
    : Special Graphics

    1
    : Alternate Character ROM Standard Character Set

    2
    : Alternate Character ROM Special Graphics


**::term::ansi::send::sda** *arg*...
: Set Display Attributes. The arguments are the code sequences for the possible attributes, as provided by the package **term::ansi::code::attr**. For convenience this package also provides additional commands each setting a single specific attribute.

**::term::ansi::send::sda\_fgblack**
: Set text color to *Black*.

**::term::ansi::send::sda\_fgred**
: Set text color to *Red*.

**::term::ansi::send::sda\_fggreen**
: Set text color to *Green*.

**::term::ansi::send::sda\_fgyellow**
: Set text color to *Yellow*.

**::term::ansi::send::sda\_fgblue**
: Set text color to *Blue*.

**::term::ansi::send::sda\_fgmagenta**
: Set text color to *Magenta*.

**::term::ansi::send::sda\_fgcyan**
: Set text color to *Cyan*.

**::term::ansi::send::sda\_fgwhite**
: Set text color to *White*.

**::term::ansi::send::sda\_fgdefault**
: Set default text color (*Black*).

**::term::ansi::send::sda\_bgblack**
: Set background to *Black*.

**::term::ansi::send::sda\_bgred**
: Set background to *Red*.

**::term::ansi::send::sda\_bggreen**
: Set background to *Green*.

**::term::ansi::send::sda\_bgyellow**
: Set background to *Yellow*.

**::term::ansi::send::sda\_bgblue**
: Set background to *Blue*.

**::term::ansi::send::sda\_bgmagenta**
: Set background to *Magenta*.

**::term::ansi::send::sda\_bgcyan**
: Set background to *Cyan*.

**::term::ansi::send::sda\_bgwhite**
: Set background to *White*.

**::term::ansi::send::sda\_bgdefault**
: Set default background (Transparent).

**::term::ansi::send::sda\_bold**
: Bold on.

**::term::ansi::send::sda\_dim**
: Dim on.

**::term::ansi::send::sda\_italic**
: Italics on.

**::term::ansi::send::sda\_underline**
: Underscore on.

**::term::ansi::send::sda\_blink**
: Blink on.

**::term::ansi::send::sda\_revers**
: Reverse on.

**::term::ansi::send::sda\_hidden**
: Hidden on.

**::term::ansi::send::sda\_strike**
: Strike-through on.

**::term::ansi::send::sda\_nobold**
: Bold off.

**::term::ansi::send::sda\_noitalic**
: Italics off.

**::term::ansi::send::sda\_nounderline**
: Underscore off.

**::term::ansi::send::sda\_noblink**
: Blink off.

**::term::ansi::send::sda\_norevers**
: Reverse off.

**::term::ansi::send::sda\_nohidden**
: Hidden off.

**::term::ansi::send::sda\_nostrike**
: Strike-through off.

**::term::ansi::send::sda\_reset**
: Reset all attributes to their default values.

**::term::ansi::send::fcp** *row* *col*
: Force Cursor Position (aka Go To).

**::term::ansi::send::cu** ?*n*?
: Cursor Up. *n* defaults to 1.

**::term::ansi::send::cd** ?*n*?
: Cursor Down. *n* defaults to 1.

**::term::ansi::send::cf** ?*n*?
: Cursor Forward. *n* defaults to 1.

**::term::ansi::send::cb** ?*n*?
: Cursor Backward. *n* defaults to 1.

**::term::ansi::send::ss** ?*s* *e*?
: Scroll Screen (entire display, or between rows start end, inclusive).

**::term::ansi::send::skd** *code* *str*
: Set Key Definition.

**::term::ansi::send::title** *str*
: Set the terminal title.

**::term::ansi::send::gron**
: Switch to character/box graphics. I.e. switch to the alternate font.

**::term::ansi::send::groff**
: Switch to regular characters. I.e. switch to the default font.

**::term::ansi::send::tlc**
: Character graphics, Top Left Corner.

**::term::ansi::send::trc**
: Character graphics, Top Right Corner.

**::term::ansi::send::brc**
: Character graphics, Bottom Right Corner.

**::term::ansi::send::blc**
: Character graphics, Bottom Left Corner.

**::term::ansi::send::ltj**
: Character graphics, Left T Junction.

**::term::ansi::send::ttj**
: Character graphics, Top T Junction.

**::term::ansi::send::rtj**
: Character graphics, Right T Junction.

**::term::ansi::send::btj**
: Character graphics, Bottom T Junction.

**::term::ansi::send::fwj**
: Character graphics, Four-Way Junction.

**::term::ansi::send::hl**
: Character graphics, Horizontal Line.

**::term::ansi::send::vl**
: Character graphics, Vertical Line.

**::term::ansi::send::groptim** *str*
: Optimize character graphics. The generator commands above create way to many superfluous commands shifting into and out of the graphics mode. This command removes all shifts which are not needed. To this end it also knows which characters will look the same in both modes, to handle strings created outside of this package.

**::term::ansi::send::clear**
: Clear screen. In essence a sequence of CursorHome + EraseDown.

**::term::ansi::send::init**
: Initialize default and alternate fonts to ASCII and box graphics.

**::term::ansi::send::showat** *row* *col* *text*
: Show the block of text at the specified location.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *term* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Terminal control

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
