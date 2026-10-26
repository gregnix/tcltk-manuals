---
CommandName: notifywindow
ManualSection: n
Version: 1.0.2
TclPart: tklib
TclDescription: notifywindow
Keywords:
 - alert
 - notification
 - tk
Copyright:
 - Copyright (c) 2015 Kevin Walzer/WordTech Communications LLC <kw@codebykevin.com>
---

# Name

notifywindow - Provides unobtrusive window for alerts/notifications from Tk applications

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tk]{.lit} 
[package]{.cmd} [require]{.sub} [notifywindow]{.lit} [1.0.2]{.optlit} 
[::notifywindow::notifywindow]{.cmd} [msg]{.arg} [img]{.arg} 
[::notifywindow::demo]{.cmd} 
:::

# Description

This package provides a low-key, unobtrusive window for alerts and notifications from Tk applications that briefly appears in the upper-right hand corner of the screen. Modeled after the "Growl" framework on Mac OS X, the window fades in and out on platforms that support such effects, and appears and disappears on other platforms.

**::notifywindow::notifywindow** *msg* *img*
: Posts the toplevel notification window with the *msg* string, which should not exceed 40 characters, and an optional image, which should be 16x16 pixels.

**::notifywindow::demo**
: Simple demo that illustrates how the package works.


# Acknowledgments

While **notifywindow** was inspired by the Growl notification package for Mac OS X, it shares no code with that project whatsoever.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *notifywindow* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) 2015 Kevin Walzer/WordTech Communications LLC <kw@codebykevin.com>
```
