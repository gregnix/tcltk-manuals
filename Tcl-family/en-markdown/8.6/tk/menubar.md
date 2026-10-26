---
CommandName: tk_menuBar
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - menu(n)
 - toplevel(n)
Keywords:
 - keyboard traversal
 - menu
 - menu bar
 - post
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

tk_menuBar, tk_bindForTraversal - Obsolete support for menu bars

# Synopsis

::: {.synopsis} :::
[tk_menuBar]{.cmd} [frame]{.arg} [menu menu]{.optdot} 
[tk_bindForTraversal]{.cmd} [arg]{.arg} [arg]{.arg} [...]{.arg} 
:::

# Description

These procedures were used in Tk 3.6 and earlier releases to help manage pulldown menus and to implement keyboard traversal of menus. In Tk 4.0 and later releases they are no longer needed.  Stubs for these procedures have been retained for backward compatibility, but they have no effect.  You should remove calls to these procedures from your code, since eventually the procedures will go away.

From Tk 8.0 onwards, you should instead construct your menubar as a normal **menu** and then attach it to the **toplevel** of your choice using the **-menu** option of that widget.
