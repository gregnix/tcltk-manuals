---
CommandName: Tk_NameOfImage
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

Tk_NameOfImage - Return name of image.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tk.h>]{.lit}

const char \*
[Tk_NameOfImage]{.cmd}([imageMaster]{.arg})
:::

# Arguments

Tk_ImageMaster *imageMaster* (in)
: Token for image, which was passed to image manager's *createProc* when the image was created.


# Description

This procedure is invoked by image managers to find out the name of an image.  Given the token for the image, it returns the string name for the image.

::: {.info -version="TIP 581"}
*Tk_ImageModel* is synonym for *Tk_ImageMaster*
:::
