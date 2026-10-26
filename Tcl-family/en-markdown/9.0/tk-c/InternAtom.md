---
CommandName: Tk_InternAtom
title: Tk_InternAtom
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - atom
 - cache
 - display
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_InternAtom, Tk\_GetAtomName - manage cache of X atoms

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Atom]{.ret} [Tk\_InternAtom]{.ccmd} [tkwin, name]{.cargs}
[const char \*]{.ret} [Tk\_GetAtomName]{.ccmd} [tkwin, atom]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window.  Used to map atom or name relative to a particular display.

[\*name]{.carg .in type="const char"}
: String name for which atom is desired.

[atom]{.carg .in type="Atom"}
: Atom for which corresponding string name is desired.

:::

# Description

These procedures are similar to the Xlib procedures **XInternAtom** and **XGetAtomName**.  **Tk\_InternAtom** returns the atom identifier associated with string given by *name*;  the atom identifier is only valid for the display associated with *tkwin*. **Tk\_GetAtomName** returns the string associated with *atom* on *tkwin*'s display.  The string returned by **Tk\_GetAtomName** is in Tk's storage:  the caller need not free this space when finished with the string, and the caller should not modify the contents of the returned string. If there is no atom *atom* on *tkwin*'s display, then **Tk\_GetAtomName** returns the string "?bad atom?".

Tk caches the information returned by **Tk\_InternAtom** and **Tk\_GetAtomName** so that future calls for the same information can be serviced from the cache without contacting the server.  Thus **Tk\_InternAtom** and **Tk\_GetAtomName** are generally much faster than their Xlib counterparts, and they should be used in place of the Xlib procedures.
