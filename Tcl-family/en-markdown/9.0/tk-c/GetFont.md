---
CommandName: Tk_AllocFontFromObj
title: Tk_AllocFontFromObj
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Links:
 - Tk_FontId(3)
Keywords:
 - font
Copyright:
 - Copyright (c) 1990-1992 The Regents of the University of California.
 - Copyright (c) 1994-1998 Sun Microsystems, Inc.
---

# Name

Tk\_AllocFontFromObj, Tk\_GetFont, Tk\_GetFontFromObj, Tk\_NameOfFont, Tk\_FontGetDescription, Tk\_FreeFontFromObj, Tk\_FreeFont - maintain database of fonts

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_Font]{.ret} [Tk\_AllocFontFromObj]{.ccmd} [interp, tkwin, objPtr]{.cargs}
[Tk\_Font]{.ret} [Tk\_GetFont]{.ccmd} [interp, tkwin, string]{.cargs}
[Tk\_Font]{.ret} [Tk\_GetFontFromObj]{.ccmd} [tkwin, objPtr]{.cargs}
[Tcl\_Obj \*]{.ret} [Tk\_FontGetDescription]{.ccmd} [tkfont]{.cargs}
[const char \*]{.ret} [Tk\_NameOfFont]{.ccmd} [tkfont]{.cargs}
[Tk\_Font]{.ret} [Tk\_FreeFontFromObj]{.ccmd} [tkwin, objPtr]{.cargs}
[Tk\_FreeFont]{.ccmd} [tkfont]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for error reporting.  If **NULL**, then no error messages are left after errors.

[tkwin]{.carg .in type="Tk_Window"}
: Token for window in which font will be used.

[\*objPtr]{.carg .in/out type="Tcl_Obj"}
: Gives name or description of font.  See documentation for the [font] command for details on acceptable formats. Internal rep will be modified to cache corresponding Tk\_Font.

[\*string]{.carg .in type="const char"}
: Same as *objPtr* except description of font is passed as a string and resulting Tk\_Font is not cached.

[tkfont]{.carg .in type="Tk_Font"}
: Opaque font token.

:::

# Description

**Tk\_AllocFontFromObj** finds the font indicated by *objPtr* and returns a token that represents the font.  The return value can be used in subsequent calls to procedures such as [Tk\_GetFontMetrics][FontId], [Tk\_MeasureChars][MeasureChar], and **Tk\_FreeFont**.  The Tk\_Font token will remain valid until **Tk\_FreeFontFromObj** or **Tk\_FreeFont** is called to release it. *ObjPtr* can contain either a symbolic name or a font description; see the documentation for the [font] command for a description of the valid formats.  If **Tk\_AllocFontFromObj** is unsuccessful (because, for example, *objPtr* did not contain a valid font specification) then it returns **NULL** and leaves an error message in *interp*'s result if *interp* is not **NULL**.  **Tk\_AllocFontFromObj** caches information about the return value in *objPtr*, which speeds up future calls to procedures such as **Tk\_AllocFontFromObj** and **Tk\_GetFontFromObj**.

**Tk\_GetFont** is identical to **Tk\_AllocFontFromObj** except that the description of the font is specified with a string instead of an object.  This prevents **Tk\_GetFont** from caching the matching Tk\_Font, so **Tk\_GetFont** is less efficient than **Tk\_AllocFontFromObj**.

**Tk\_GetFontFromObj** returns the token for an existing font, given the window and description used to create the font. **Tk\_GetFontFromObj** does not actually create the font; the font must already have been created with a previous call to **Tk\_AllocFontFromObj** or **Tk\_GetFont**.  The return value is cached in *objPtr*, which speeds up future calls to **Tk\_GetFontFromObj** with the same *objPtr* and *tkwin*.

**Tk\_AllocFontFromObj** and **Tk\_GetFont** maintain a database of all fonts they have allocated.  If the same font is requested multiple times (e.g. by different windows or for different purposes), then a single Tk\_Font will be shared for all uses.  The underlying resources will be freed automatically when no-one is using the font anymore.

The procedure **Tk\_FontGetDescription** returns information about the font description as a Tcl list. One possible result is "{{DejaVu Sans} -16 bold underline}".

The procedure **Tk\_NameOfFont** is roughly the inverse of **Tk\_GetFont**.  Given a *tkfont* that was created by **Tk\_GetFont** (or **Tk\_AllocFontFromObj**), the return value is the *string* argument that was passed to **Tk\_GetFont** to create the font.  The string returned by **Tk\_NameOfFont** is only guaranteed to persist until the *tkfont* is deleted.  The caller must not modify this string.

When a font is no longer needed, **Tk\_FreeFontFromObj** or **Tk\_FreeFont** should be called to release it.  For **Tk\_FreeFontFromObj** the font to release is specified with the same information used to create it; for **Tk\_FreeFont** the font to release is specified with its Tk\_Font token.  There should be exactly one call to **Tk\_FreeFontFromObj** or **Tk\_FreeFont** for each call to **Tk\_AllocFontFromObj** or **Tk\_GetFont**.


[font]: ../tk/font.md
[FontId]: FontId.md
[MeasureChar]: MeasureChar.md
