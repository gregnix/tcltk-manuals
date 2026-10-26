# Interactive Tablelist Cell Editing Using the ctext Package

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::addCtext Command](#the-tablelist-addctext-command)

[Start page](index.md)

---

## Overview

George Peter Staplin's ctext package is a library extension for Tcl/Tk versions 8.0 or higher, written in pure Tcl/Tk code.  It is part of tklib, which has the address

https://core.tcl.tk/tklib

Tablelist supports interactive cell editing with the aid of the ctext widget implemented in the package mentioned above.  The steps needed for using this widget for editing the cells of a given column are as follows:

1. Register the ctext widget for interactive cell editing by invoking the `tablelist::addCtext` command described below.
2. Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to the value returned by the command mentioned above.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::addCtext` Command

**NAME**
: `tablelist::addCtext` – Register the ctext widget for interactive cell editing

**SYNOPSIS**
: 

```
tablelist::addCtext ?name?
```

**DESCRIPTION**
: This command registers the ctext widget for interactive cell editing in tablelist widgets.  The optional argument specifies the name to be used for the ctext widget as the value of the `-editwindow` column or cell configuration option.  It may be any string that is different from the [Tk core](tablelistTkCore.md) and [tile](tablelistTile.md) edit window names.  The default is `ctext`.  The command returns its `name` argument.

: The temporary embedded ctext widget used for interactive cell editing will be created with its `-padx` and `-pady` options set to `2`, its `-wrap` option set to `none`, and its initial height set to the number of lines contained in it.  There is, however, an exception from this rule:  If the `-wrap` option of the cell's column was set to true and Tk version 8.5 or higher is being used, then the ctext widget's `-wrap` option will be set to `word` and its initial height will equal the number of *display* lines (taking into account the line wraps) contained in it.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to override the initial settings (except the height) according to your needs.

: If the ctext widget's `-wrap` option was set to `word` or `char` (either by Tablelist or from within the above-mentioned script) and Tk version 8.5 or higher is being used, then, whenever its width changes (e.g., due to interactive column resizing), its height will be set automatically to the number of display lines contained in it.  (The number of display lines is retrieved with the aid of the  `count -displaylines`  text widget subcommand, introduced in Tk 8.5.)

: If the widget callback package Wcb was loaded into the interpreter (via  `package require Wcb`  or  `package require wcb`)  then the ctext widget's height will be updated automatically whenever text is inserted into or deleted from it, which makes the editing much more user-friendly.  This is achieved by using an appropriately defined after-`insert` and after-`delete` callback for the edit window.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to define further callbacks for the ctext widget.  (The above-mentioned callback is created via `wcb::cbappend`, *after* returning from that script.)

: The `Tab` key is reserved for navigation between the editable cells, but the user can insert a tabulator character into the ctext widget by pressing `Control-i`.

: Unlike in the case of the other widgets used for interactive cell editing (except the Tk core text widget), the `Return` and `KP_Enter` keys insert a newline character into the ctext widget.  `Control-j` can also be used for inserting a newline.  `Control-Return` and `Control-KP_Enter` terminate the editing and destroy the edit window.

: `Control-Home` and `Control-End` have their well-known text widget-specific bindings, just like `Meta-<` and `Meta->` if `tk_strictMotif` is false.  Again, this is different from the behavior of the other widgets used for interactive cell editing (except the Tk core text widget).  For jumping into the first/last editable cell, the user can press `Alt-Home`/`Alt-End` or `Meta-Home`/`Meta-End` (`Command-Home`/`Command-End` on Mac OS X/11+ Aqua).

**KEYWORDS**
: tablelist, editing, ctext


[Start page](index.md)
