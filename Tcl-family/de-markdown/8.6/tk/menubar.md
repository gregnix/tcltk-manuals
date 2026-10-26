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

# NAME

tk_menuBar, tk_bindForTraversal - Veraltete Unterstützung für Menüleisten

# ÜBERSICHT

::: {.synopsis} :::
[tk_menuBar]{.cmd} [frame]{.arg} [menu menu]{.optdot} 
[tk_bindForTraversal]{.cmd} [arg]{.arg} [arg]{.arg} [...]{.arg} 
:::

# BESCHREIBUNG

Diese Prozeduren wurden in Tk 3.6 und früheren Versionen verwendet, um Pulldown-Menüs zu verwalten und die Tastatur-Navigation in Menüs zu implementieren. Ab Tk 4.0 sind sie nicht mehr nötig. Stubs dieser Prozeduren wurden aus Gründen der Abwärtskompatibilität beibehalten, haben aber keine Wirkung. Aufrufe dieser Prozeduren sollten aus dem Code entfernt werden, da die Prozeduren irgendwann entfallen werden.

Ab Tk 8.0 sollte die Menüleiste stattdessen als normales **menu** aufgebaut und mit der Option **-menu** des gewünschten **toplevel**-Widgets verknüpft werden.
