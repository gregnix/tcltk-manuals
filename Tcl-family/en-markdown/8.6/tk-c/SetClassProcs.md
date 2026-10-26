---
CommandName: Tk_SetClassProcs
title: Tk_SetClassProcs
ManualSection: 3
Version: 8.4
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - callback
 - class
Copyright:
 - Copyright (c) 2000 Ajuba Solutions.
---

# Name

Tk\_SetClassProcs - register widget specific procedures

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_SetClassProcs]{.ccmd} [tkwin, procs, instanceData]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkwin]{.carg .in type="Tk_Window"}
: Token for window to modify.

[\*procs]{.carg .in type="const Tk_ClassProcs"}
: Pointer to data structure containing widget specific procedures. The data structure pointed to by *procs* must be static: Tk keeps a reference to it as long as the window exists.

[instanceData]{.carg .in type="ClientData"}
: Arbitrary one-word value to pass to widget callbacks.

:::

# Description

**Tk\_SetClassProcs** is called to register a set of procedures that are used as callbacks in different places.

The structure pointed to by *procs* contains the following:

```
typedef struct Tk_ClassProcs {
    unsigned int size;
    Tk_ClassWorldChangedProc *worldChangedProc;
    Tk_ClassCreateProc *createProc;
    Tk_ClassModalProc *modalProc;
} Tk_ClassProcs;
```

The *size* field is used to simplify future expansion of the structure. It should always be set to (literally) **sizeof(Tk\_ClassProcs)**.

*worldChangedProc* is invoked when the system has altered in some way that requires some reaction from the widget.  For example, when a font alias (see the [font] manual entry) is reconfigured, widgets configured to use that font alias must update their display accordingly.  *worldChangedProc* should have arguments and results that match the type **Tk\_ClassWorldChangedProc**:

```
typedef void Tk_ClassWorldChangedProc(
        ClientData instanceData);
```

The *instanceData* parameter passed to the *worldChangedProc* will be identical to the *instanceData* parameter passed to **Tk\_SetClassProcs**.

*createProc* is used to create platform-dependent windows.  It is invoked by [Tk\_MakeWindowExist][CrtWindow].  *createProc* should have arguments and results that match the type **Tk\_ClassCreateProc**:

```
typedef Window Tk_ClassCreateProc(
        Tk_Window tkwin,
        Window parent,
        ClientData instanceData);
```

The *tkwin* and *instanceData* parameters will be identical to the *tkwin* and *instanceData* parameters passed to **Tk\_SetClassProcs**.  The *parent* parameter will be the parent of the window to be created.  The *createProc* should return the created window.

*modalProc* is invoked after all bindings on a widget have been triggered in order to handle a modal loop.  *modalProc* should have arguments and results that match the type **Tk\_ClassModalProc**:

```
typedef void Tk_ClassModalProc(
        Tk_Window tkwin,
        XEvent *eventPtr);
```

The *tkwin* parameter to *modalProc* will be identical to the *tkwin* parameter passed to **Tk\_SetClassProcs**.  The *eventPtr* parameter will be a pointer to an XEvent structure describing the event being processed.


[CrtWindow]: CrtWindow.md
[font]: ../tk/font.md
