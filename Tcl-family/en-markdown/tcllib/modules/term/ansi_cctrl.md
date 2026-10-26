---
CommandName: term::ansi::code::ctrl
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - attribute control
 - color control
 - control
 - terminal
Copyright:
 - Copyright (c) 2006-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::code::ctrl - ANSI control sequences

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [term::ansi::code]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [term::ansi::code::ctrl]{.lit} [0.3]{.optlit} 
[::term::ansi::code::ctrl::names]{.cmd} 
[::term::ansi::code::ctrl::import]{.cmd} [ns]{.optarg} [arg]{.optdot} 
[::term::ansi::code::ctrl::eeol]{.cmd} 
[::term::ansi::code::ctrl::esol]{.cmd} 
[::term::ansi::code::ctrl::el]{.cmd} 
[::term::ansi::code::ctrl::ed]{.cmd} 
[::term::ansi::code::ctrl::eu]{.cmd} 
[::term::ansi::code::ctrl::es]{.cmd} 
[::term::ansi::code::ctrl::sd]{.cmd} 
[::term::ansi::code::ctrl::su]{.cmd} 
[::term::ansi::code::ctrl::ch]{.cmd} 
[::term::ansi::code::ctrl::sc]{.cmd} 
[::term::ansi::code::ctrl::rc]{.cmd} 
[::term::ansi::code::ctrl::sca]{.cmd} 
[::term::ansi::code::ctrl::rca]{.cmd} 
[::term::ansi::code::ctrl::st]{.cmd} 
[::term::ansi::code::ctrl::ct]{.cmd} 
[::term::ansi::code::ctrl::cat]{.cmd} 
[::term::ansi::code::ctrl::qdc]{.cmd} 
[::term::ansi::code::ctrl::qds]{.cmd} 
[::term::ansi::code::ctrl::qcp]{.cmd} 
[::term::ansi::code::ctrl::rd]{.cmd} 
[::term::ansi::code::ctrl::elw]{.cmd} 
[::term::ansi::code::ctrl::dlw]{.cmd} 
[::term::ansi::code::ctrl::eg]{.cmd} 
[::term::ansi::code::ctrl::lg]{.cmd} 
[::term::ansi::code::ctrl::scs0]{.cmd} [tag]{.arg} 
[::term::ansi::code::ctrl::scs1]{.cmd} [tag]{.arg} 
[::term::ansi::code::ctrl::sda]{.cmd} [arg...]{.arg} 
[::term::ansi::code::ctrl::sda_fgblack]{.cmd} 
[::term::ansi::code::ctrl::sda_fgred]{.cmd} 
[::term::ansi::code::ctrl::sda_fggreen]{.cmd} 
[::term::ansi::code::ctrl::sda_fgyellow]{.cmd} 
[::term::ansi::code::ctrl::sda_fgblue]{.cmd} 
[::term::ansi::code::ctrl::sda_fgmagenta]{.cmd} 
[::term::ansi::code::ctrl::sda_fgcyan]{.cmd} 
[::term::ansi::code::ctrl::sda_fgwhite]{.cmd} 
[::term::ansi::code::ctrl::sda_fgdefault]{.cmd} 
[::term::ansi::code::ctrl::sda_bgblack]{.cmd} 
[::term::ansi::code::ctrl::sda_bgred]{.cmd} 
[::term::ansi::code::ctrl::sda_bggreen]{.cmd} 
[::term::ansi::code::ctrl::sda_bgyellow]{.cmd} 
[::term::ansi::code::ctrl::sda_bgblue]{.cmd} 
[::term::ansi::code::ctrl::sda_bgmagenta]{.cmd} 
[::term::ansi::code::ctrl::sda_bgcyan]{.cmd} 
[::term::ansi::code::ctrl::sda_bgwhite]{.cmd} 
[::term::ansi::code::ctrl::sda_bgdefault]{.cmd} 
[::term::ansi::code::ctrl::sda_bold]{.cmd} 
[::term::ansi::code::ctrl::sda_dim]{.cmd} 
[::term::ansi::code::ctrl::sda_italic]{.cmd} 
[::term::ansi::code::ctrl::sda_underline]{.cmd} 
[::term::ansi::code::ctrl::sda_blink]{.cmd} 
[::term::ansi::code::ctrl::sda_revers]{.cmd} 
[::term::ansi::code::ctrl::sda_hidden]{.cmd} 
[::term::ansi::code::ctrl::sda_strike]{.cmd} 
[::term::ansi::code::ctrl::sda_nobold]{.cmd} 
[::term::ansi::code::ctrl::sda_noitalic]{.cmd} 
[::term::ansi::code::ctrl::sda_nounderline]{.cmd} 
[::term::ansi::code::ctrl::sda_noblink]{.cmd} 
[::term::ansi::code::ctrl::sda_norevers]{.cmd} 
[::term::ansi::code::ctrl::sda_nohidden]{.cmd} 
[::term::ansi::code::ctrl::sda_nostrike]{.cmd} 
[::term::ansi::code::ctrl::sda_reset]{.cmd} 
[::term::ansi::send::fcp]{.cmd} [row]{.arg} [col]{.arg} 
[::term::ansi::code::ctrl::cu]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::cd]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::cf]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::cb]{.cmd} [n]{.optarg} 
[::term::ansi::code::ctrl::ss]{.cmd} [s e]{.optarg} 
[::term::ansi::code::ctrl::skd]{.cmd} [code]{.arg} [str]{.arg} 
[::term::ansi::code::ctrl::title]{.cmd} [str]{.arg} 
[::term::ansi::code::ctrl::gron]{.cmd} 
[::term::ansi::code::ctrl::groff]{.cmd} 
[::term::ansi::code::ctrl::tlc]{.cmd} 
[::term::ansi::code::ctrl::trc]{.cmd} 
[::term::ansi::code::ctrl::brc]{.cmd} 
[::term::ansi::code::ctrl::blc]{.cmd} 
[::term::ansi::code::ctrl::ltj]{.cmd} 
[::term::ansi::code::ctrl::ttj]{.cmd} 
[::term::ansi::code::ctrl::rtj]{.cmd} 
[::term::ansi::code::ctrl::btj]{.cmd} 
[::term::ansi::code::ctrl::fwj]{.cmd} 
[::term::ansi::code::ctrl::hl]{.cmd} 
[::term::ansi::code::ctrl::vl]{.cmd} 
[::term::ansi::code::ctrl::groptim]{.cmd} [str]{.arg} 
[::term::ansi::code::ctrl::clear]{.cmd} 
[::term::ansi::code::ctrl::init]{.cmd} 
[::term::ansi::code::ctrl::showat]{.cmd} [row]{.arg} [col]{.arg} [text]{.arg} 
:::

# Description

This package provides symbolic names for the ANSI control sequences. For each sequence a single command is provided which returns the sequence as its result. None of the commands of this package write to a channel; that is handled by higher level packages, like **term::ansi::send**.

# Api

## Introspection

**::term::ansi::code::ctrl::names**
: This command is for introspection. It returns as its result a list containing the names of all attribute commands.

**::term::ansi::code::ctrl::import** ?*ns*? ?*arg*...?
: This command imports some or all attribute commands into the namespace *ns*. This is by default the namespace *ctrl*. Note that this is relative namespace name, placing the imported command into a child of the current namespace. By default all commands are imported, this can howver be restricted by listing the names of the wanted commands after the namespace argument.


## Sequences

**::term::ansi::code::ctrl::eeol**
: Erase (to) End Of Line

**::term::ansi::code::ctrl::esol**
: Erase (to) Start Of Line

**::term::ansi::code::ctrl::el**
: Erase (current) Line

**::term::ansi::code::ctrl::ed**
: Erase Down (to bottom)

**::term::ansi::code::ctrl::eu**
: Erase Up (to top)

**::term::ansi::code::ctrl::es**
: Erase Screen

**::term::ansi::code::ctrl::sd**
: Scroll Down

**::term::ansi::code::ctrl::su**
: Scroll Up

**::term::ansi::code::ctrl::ch**
: Cursor Home

**::term::ansi::code::ctrl::sc**
: Save Cursor

**::term::ansi::code::ctrl::rc**
: Restore Cursor (Unsave)

**::term::ansi::code::ctrl::sca**
: Save Cursor + Attributes

**::term::ansi::code::ctrl::rca**
: Restore Cursor + Attributes

**::term::ansi::code::ctrl::st**
: Set Tab (@ current position)

**::term::ansi::code::ctrl::ct**
: Clear Tab (@ current position)

**::term::ansi::code::ctrl::cat**
: Clear All Tabs

**::term::ansi::code::ctrl::qdc**
: Query Device Code

**::term::ansi::code::ctrl::qds**
: Query Device Status

**::term::ansi::code::ctrl::qcp**
: Query Cursor Position

**::term::ansi::code::ctrl::rd**
: Reset Device

**::term::ansi::code::ctrl::elw**
: Enable Line Wrap

**::term::ansi::code::ctrl::dlw**
: Disable Line Wrap

**::term::ansi::code::ctrl::eg**
: Enter Graphics Mode

**::term::ansi::code::ctrl::lg**
: Exit Graphics Mode

**::term::ansi::code::ctrl::scs0** *tag*
: Set default character set

**::term::ansi::code::ctrl::scs1** *tag*
: Set alternate character set Select Character Set. Choose which character set is used for either default (scs0) or alternate font (scs1). This does not change whether default or alternate font are used, only their definition. The legal tags, and their meanings, are:


**A**
: United Kingdom Set

**B**
: ASCII Set

**0**
: Special Graphics

**1**
: Alternate Character ROM Standard Character Set

**2**
: Alternate Character ROM Special Graphics


**::term::ansi::code::ctrl::sda** *arg*...
: Set Display Attributes. The arguments are the code sequences for the possible attributes, as provided by the package **term::ansi::code::attr**. For convenience this package also provides additional commands each setting a single specific attribute.

**::term::ansi::code::ctrl::sda_fgblack**
: Set text color to *Black*.

**::term::ansi::code::ctrl::sda_fgred**
: Set text color to *Red*.

**::term::ansi::code::ctrl::sda_fggreen**
: Set text color to *Green*.

**::term::ansi::code::ctrl::sda_fgyellow**
: Set text color to *Yellow*.

**::term::ansi::code::ctrl::sda_fgblue**
: Set text color to *Blue*.

**::term::ansi::code::ctrl::sda_fgmagenta**
: Set text color to *Magenta*.

**::term::ansi::code::ctrl::sda_fgcyan**
: Set text color to *Cyan*.

**::term::ansi::code::ctrl::sda_fgwhite**
: Set text color to *White*.

**::term::ansi::code::ctrl::sda_fgdefault**
: Set default text color (*Black*).

**::term::ansi::code::ctrl::sda_bgblack**
: Set background to *Black*.

**::term::ansi::code::ctrl::sda_bgred**
: Set background to *Red*.

**::term::ansi::code::ctrl::sda_bggreen**
: Set background to *Green*.

**::term::ansi::code::ctrl::sda_bgyellow**
: Set background to *Yellow*.

**::term::ansi::code::ctrl::sda_bgblue**
: Set background to *Blue*.

**::term::ansi::code::ctrl::sda_bgmagenta**
: Set background to *Magenta*.

**::term::ansi::code::ctrl::sda_bgcyan**
: Set background to *Cyan*.

**::term::ansi::code::ctrl::sda_bgwhite**
: Set background to *White*.

**::term::ansi::code::ctrl::sda_bgdefault**
: Set default background (Transparent).

**::term::ansi::code::ctrl::sda_bold**
: Bold on.

**::term::ansi::code::ctrl::sda_dim**
: Dim on.

**::term::ansi::code::ctrl::sda_italic**
: Italics on.

**::term::ansi::code::ctrl::sda_underline**
: Underscore on.

**::term::ansi::code::ctrl::sda_blink**
: Blink on.

**::term::ansi::code::ctrl::sda_revers**
: Reverse on.

**::term::ansi::code::ctrl::sda_hidden**
: Hidden on.

**::term::ansi::code::ctrl::sda_strike**
: Strike-through on.

**::term::ansi::code::ctrl::sda_nobold**
: Bold off.

**::term::ansi::code::ctrl::sda_noitalic**
: Italics off.

**::term::ansi::code::ctrl::sda_nounderline**
: Underscore off.

**::term::ansi::code::ctrl::sda_noblink**
: Blink off.

**::term::ansi::code::ctrl::sda_norevers**
: Reverse off.

**::term::ansi::code::ctrl::sda_nohidden**
: Hidden off.

**::term::ansi::code::ctrl::sda_nostrike**
: Strike-through off.

**::term::ansi::code::ctrl::sda_reset**
: Reset all attributes to their default values.

**::term::ansi::send::fcp** *row* *col*
: Force Cursor Position (aka Go To).

**::term::ansi::code::ctrl::cu** ?*n*?
: Cursor Up. *n* defaults to 1.

**::term::ansi::code::ctrl::cd** ?*n*?
: Cursor Down. *n* defaults to 1.

**::term::ansi::code::ctrl::cf** ?*n*?
: Cursor Forward. *n* defaults to 1.

**::term::ansi::code::ctrl::cb** ?*n*?
: Cursor Backward. *n* defaults to 1.

**::term::ansi::code::ctrl::ss** ?*s* *e*?
: Scroll Screen (entire display, or between rows start end, inclusive).

**::term::ansi::code::ctrl::skd** *code* *str*
: Set Key Definition.

**::term::ansi::code::ctrl::title** *str*
: Set the terminal title.

**::term::ansi::code::ctrl::gron**
: Switch to character/box graphics. I.e. switch to the alternate font.

**::term::ansi::code::ctrl::groff**
: Switch to regular characters. I.e. switch to the default font.

**::term::ansi::code::ctrl::tlc**
: Character graphics, Top Left Corner.

**::term::ansi::code::ctrl::trc**
: Character graphics, Top Right Corner.

**::term::ansi::code::ctrl::brc**
: Character graphics, Bottom Right Corner.

**::term::ansi::code::ctrl::blc**
: Character graphics, Bottom Left Corner.

**::term::ansi::code::ctrl::ltj**
: Character graphics, Left T Junction.

**::term::ansi::code::ctrl::ttj**
: Character graphics, Top T Junction.

**::term::ansi::code::ctrl::rtj**
: Character graphics, Right T Junction.

**::term::ansi::code::ctrl::btj**
: Character graphics, Bottom T Junction.

**::term::ansi::code::ctrl::fwj**
: Character graphics, Four-Way Junction.

**::term::ansi::code::ctrl::hl**
: Character graphics, Horizontal Line.

**::term::ansi::code::ctrl::vl**
: Character graphics, Vertical Line.

**::term::ansi::code::ctrl::groptim** *str*
: Optimize character graphics. The generator commands above create way to many superfluous commands shifting into and out of the graphics mode. This command removes all shifts which are not needed. To this end it also knows which characters will look the same in both modes, to handle strings created outside of this package.

**::term::ansi::code::ctrl::clear**
: Clear screen. In essence a sequence of CursorHome + EraseDown.

**::term::ansi::code::ctrl::init**
: Initialize default and alternate fonts to ASCII and box graphics.

**::term::ansi::code::ctrl::showat** *row* *col* *text*
: Format the block of text for display at the specified location.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *term* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Terminal control

# Copyright

```
Copyright (c) 2006-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
