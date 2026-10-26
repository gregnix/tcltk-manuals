---
CommandName: autoscroll
ManualSection: n
Version: 1.1
TclPart: tklib
TclDescription: Automatic mapping of scrollbars
Keywords:
 - scroll
 - scrollbar
Copyright:
---

# Name

autoscroll - Provides for a scrollbar to automatically mapped and unmapped as needed

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} 
[package]{.cmd} [require]{.sub} [autoscroll]{.lit} [1.1]{.optlit} 
[::autoscroll::autoscroll]{.cmd} [scrollbar]{.arg} 
[::autoscroll::unautoscroll]{.cmd} [scrollbar]{.arg} 
[::autoscroll::wrap]{.cmd} 
[::autoscroll::unwrap]{.cmd} 
:::

# Description

This package allows scrollbars to be mapped and unmapped as needed depending on the size and content of the scrollbars scrolled widget. The scrollbar must be managed by either pack or grid, other geometry managers are not supported.

When managed by pack, any geometry changes made in the scrollbars parent between the time a scrollbar is unmapped, and when it is mapped will be lost. It is an error to destroy any of the scrollbars siblings while the scrollbar is unmapped. When managed by grid, if anything becomes gridded in the same row and column the scrollbar occupied it will be replaced by the scrollbar when remapped.

This package may be used on any scrollbar-like widget as long as it supports the **set** subcommand in the same style as scrollbar. If the **set** subcommand is not used then this package will have no effect.

**::autoscroll::autoscroll** *scrollbar*
: Arranges for the already existing scrollbar **scrollbar** to be mapped and unmapped as needed.

**::autoscroll::unautoscroll** *scrollbar*
: Returns the named scrollbar to its original static state.

**::autoscroll::wrap**
: Arranges for all scrollbars created after this command is run to be automatically mapped and unmapped as needed.

**::autoscroll::unwrap**
: Turns off the automatic autoscrolling of all new scrollbars. Does not effect existing scrollbars


```
text .t -yscrollcommand ".scrolly set"
scrollbar .scrolly -orient v -command ".t yview"
pack .scrolly -side right -fill y
pack .t -side left -fill both -expand 1
::autoscroll::autoscroll .scrolly
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *autoscroll* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
