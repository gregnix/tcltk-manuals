---
CommandName: Tk_NameOfImage
title: Tk_NameOfImage
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - image manager
 - image name
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

Tk\_NameOfImage - Return name of image.

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[const char \*]{.ret} [Tk\_NameOfImage]{.ccmd} [imageModel]{.cargs}
:::

# Arguments

::: {.arguments} :::

[imageModel]{.carg .in type="Tk_ImageModel"}
: Token for image, which was passed to image manager's *createProc* when the image was created.

:::

# Description

This procedure is invoked by image managers to find out the name of an image.  Given the token for the image, it returns the string name for the image.
