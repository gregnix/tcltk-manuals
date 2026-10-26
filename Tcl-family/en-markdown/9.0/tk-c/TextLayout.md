---
CommandName: Tk_ComputeTextLayout
title: Tk_ComputeTextLayout
ManualSection: 3
Version: 8.1
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - font
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

Tk\_ComputeTextLayout, Tk\_FreeTextLayout, Tk\_DrawTextLayout, Tk\_UnderlineTextLayout, Tk\_PointToChar, Tk\_CharBbox, Tk\_DistanceToTextLayout, Tk\_IntersectTextLayout, Tk\_TextLayoutToPostscript - routines to measure and display single-font, multi-line, justified text.

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[Tk\_TextLayout]{.ret} [Tk\_ComputeTextLayout]{.ccmd} [tkfont, string, numChars, wrapLength, justify, flags, widthPtr, heightPtr]{.cargs}
[Tk\_FreeTextLayout]{.ccmd} [layout]{.cargs}
[Tk\_DrawTextLayout]{.ccmd} [display, drawable, gc, layout, x, y, firstChar, lastChar]{.cargs}
[Tk\_UnderlineTextLayout]{.ccmd} [display, drawable, gc, layout, x, y, underline]{.cargs}
[int]{.ret} [Tk\_PointToChar]{.ccmd} [layout, x, y]{.cargs}
[int]{.ret} [Tk\_CharBbox]{.ccmd} [layout, index, xPtr, yPtr, widthPtr, heightPtr]{.cargs}
[int]{.ret} [Tk\_DistanceToTextLayout]{.ccmd} [layout, x, y]{.cargs}
[int]{.ret} [Tk\_IntersectTextLayout]{.ccmd} [layout, x, y, width, height]{.cargs}
[Tk\_TextLayoutToPostscript]{.ccmd} [interp, layout]{.cargs}
:::

# Arguments

::: {.arguments} :::

[tkfont]{.carg .in type="Tk_Font"}
: Font to use when constructing and displaying a text layout.  The *tkfont* must remain valid for the lifetime of the text layout.  Must have been returned by a previous call to [Tk\_GetFont][GetFont].

[\*string]{.carg .in type="const char"}
: Potentially multi-line string whose dimensions are to be computed and stored in the text layout.  The *string* must remain valid for the lifetime of the text layout.

[numChars]{.carg .in type="int"}
: The number of characters to consider from *string*.  If *numChars* is negative, then assumes *string* is null terminated and uses [Tcl\_NumUtfChars][Utf] to determine the length of *string*.

[wrapLength]{.carg .in type="int"}
: Longest permissible line length, in pixels.  Lines in *string* will automatically be broken at word boundaries and wrapped when they reach this length.  If *wrapLength* is too small for even a single character to fit on a line, it will be expanded to allow one character to fit on each line.  If *wrapLength* is <= 0, there is no automatic wrapping; lines will get as long as they need to be and only wrap if a newline/return character is encountered.

[justify]{.carg .in type="Tk_Justify"}
: How to justify the lines in a multi-line text layout.  Possible values are **TK\_JUSTIFY\_LEFT**, **TK\_JUSTIFY\_CENTER**, or **TK\_JUSTIFY\_RIGHT**. If the text layout only occupies a single line, then *justify* is irrelevant.

[flags]{.carg .in type="int"}
: Various flag bits OR-ed together. **TK\_IGNORE\_TABS** means that tab characters should not be expanded to the next tab stop. **TK\_IGNORE\_NEWLINES** means that newline/return characters should not cause a line break.  If either tabs or newlines/returns are ignored, then they will be treated as regular characters, being measured and displayed in a platform-dependent manner as described in [Tk\_MeasureChars][MeasureChar], and will not have any special behaviors.

[\*widthPtr]{.carg .out type="int"}
: If non-NULL, filled with either the width, in pixels, of the widest line in the text layout, or the width, in pixels, of the bounding box for the character specified by *index*.

[\*heightPtr]{.carg .out type="int"}
: If non-NULL, filled with either the total height, in pixels, of all the lines in the text layout, or the height, in pixels, of the bounding box for the character specified by *index*.

[layout]{.carg .in type="Tk_TextLayout"}
: A token that represents the cached layout information about the single-font, multi-line, justified piece of text.  This token is returned by **Tk\_ComputeTextLayout**.

[\*display]{.carg .in type="Display"}
: Display on which to draw.

[drawable]{.carg .in type="Drawable"}
: Window or pixmap in which to draw.

[gc]{.carg .in type="GC"}
: Graphics context to use for drawing text layout.  The font selected in this GC must correspond to the *tkfont* used when constructing the text layout.

[x, y]{.carg .in type="int"}
: Point, in pixels, at which to place the upper-left hand corner of the text layout when it is being drawn, or the coordinates of a point (with respect to the upper-left hand corner of the text layout) to check against the text layout.

[firstChar]{.carg .in type="Tcl_Size"}
: The index of the first character to draw from the given text layout. The number 0 means to draw from the beginning.

[lastChar]{.carg .in type="Tcl_Size"}
: The index of the last character up to which to draw.  The character specified by *lastChar* itself will not be drawn.  A number less than 0 means to draw all characters in the text layout.

[underline]{.carg .in type="int"}
: Index of the single character to underline in the text layout, or a negative number counting backwards from the end of the string. Any out-of-range number (e.g. INT\_MIN) means no underline.

[index]{.carg .in type="Tcl_Size"}
: The index of the character whose bounding box is desired.  The bounding box is computed with respect to the upper-left hand corner of the text layout.

[\*xPtr, \*yPtr]{.carg .out type="int"}
: Filled with the upper-left hand corner, in pixels, of the bounding box for the character specified by *index*.  Either or both *xPtr* and *yPtr* may be NULL, in which case the corresponding value is not calculated.

[width, height]{.carg .in type="int"}
: Specifies the width and height, in pixels, of the rectangular area to compare for intersection against the text layout.

[\*interp]{.carg .out type="Tcl_Interp"}
: Postscript code that will print the text layout is appended to the result of interpreter *interp*.

:::

# Description

These routines are for measuring and displaying single-font, multi-line, justified text.  To measure and display simple single-font, single-line strings, refer to the documentation for [Tk\_MeasureChars][MeasureChar].  There is no programming interface in the core of Tk that supports multi-font, multi-line text; support for that behavior must be built on top of simpler layers. Note that unlike the lower level text display routines, the functions described here all operate on character-oriented lengths and indices rather than byte-oriented values.  See the description of [Tcl\_UtfAtIndex][Utf] for more details on converting between character and byte offsets.

The routines described here are built on top of the programming interface described in the [Tk\_MeasureChars][MeasureChar] documentation.  Tab characters and newline/return characters may be treated specially by these procedures, but all other characters are passed through to the lower level.

**Tk\_ComputeTextLayout** computes the layout information needed to display a single-font, multi-line, justified *string* of text and returns a Tk\_TextLayout token that holds this information.  This token is used in subsequent calls to procedures such as **Tk\_DrawTextLayout**, **Tk\_DistanceToTextLayout**, and **Tk\_FreeTextLayout**.  The *string* and *tkfont* used when computing the layout must remain valid for the lifetime of this token.

**Tk\_FreeTextLayout** is called to release the storage associated with *layout* when it is no longer needed.  A *layout* should not be used in any other text layout procedures once it has been released.

**Tk\_DrawTextLayout** uses the information in *layout* to display a single-font, multi-line, justified string of text at the specified location.

**Tk\_UnderlineTextLayout** uses the information in *layout* to display an underline below an individual character.  This procedure does not draw the text, just the underline.  To produce natively underlined text, an underlined font should be constructed and used.  All characters, including tabs, newline/return characters, and spaces at the ends of lines, can be underlined using this method.  However, the underline will never be drawn outside of the computed width of *layout*; the underline will stop at the edge for any character that would extend partially outside of *layout*, and the underline will not be visible at all for any character that would be located completely outside of the layout.

**Tk\_PointToChar** uses the information in *layout* to determine the character closest to the given point.  The point is specified with respect to the upper-left hand corner of the *layout*, which is considered to be located at (0, 0).  Any point whose *y*-value is less that 0 will be considered closest to the first character in the text layout; any point whose *y*-value is greater than the height of the text layout will be considered closest to the last character in the text layout.  Any point whose *x*-value is negative will be considered closest to the first character on that line; any point whose *x*-value is greater than the width of the text layout will be considered closest to the last character on that line.  The return value is the index of the character that was closest to the point, or one more than the index of any character (to indicate that the point was after the end of the string and that the corresponding caret would be at the end of the string).  Given a *layout* with no characters, the value 0 will always be returned, referring to a hypothetical zero-width placeholder character.

**Tk\_CharBbox** uses the information in *layout* to return the bounding box for the character specified by *index*.  The width of the bounding box is the advance width of the character, and does not include any left or right bearing.  Any character that extends partially outside of *layout* is considered to be truncated at the edge.  Any character that would be located completely outside of *layout* is considered to be zero-width and pegged against the edge.  The height of the bounding box is the line height for this font, extending from the top of the ascent to the bottom of the descent; information about the actual height of individual letters is not available.  For measurement purposes, a *layout* that contains no characters is considered to contain a single zero-width placeholder character at index 0.  If *index* was not a valid character index, the return value is 0 and *\*xPtr*, *\*yPtr*, *\*widthPtr*, and *\*heightPtr* are unmodified. Otherwise, if *index* did specify a valid, the return value is non-zero, and *\*xPtr*, *\*yPtr*, *\*widthPtr*, and *\*heightPtr* are filled with the bounding box information for the character.  If any of *xPtr*, *yPtr*, *widthPtr*, or *heightPtr* are NULL, the corresponding value is not calculated or stored.

**Tk\_DistanceToTextLayout** computes the shortest distance in pixels from the given point (*x, y*) to the characters in *layout*. Newline/return characters and non-displaying space characters that occur at the end of individual lines in the text layout are ignored for hit detection purposes, but tab characters are not.  The return value is 0 if the point actually hits the *layout*.  If the point did not hit the *layout* then the return value is the distance in pixels from the point to the *layout*.

**Tk\_IntersectTextLayout** determines whether a *layout* lies entirely inside, entirely outside, or overlaps a given rectangle. Newline/return characters and non-displaying space characters that occur at the end of individual lines in the *layout* are ignored for intersection calculations.  The return value is -1 if the *layout* is entirely outside of the rectangle, 0 if it overlaps, and 1 if it is entirely inside of the rectangle.

**Tk\_TextLayoutToPostscript** outputs code consisting of a Postscript array of strings that represent the individual lines in *layout*.  It is the responsibility of the caller to take the Postscript array of strings and add some Postscript function operate on the array to render each of the lines.  The code that represents the Postscript array of strings is appended to interpreter *interp*'s result.

# Display model

When measuring a text layout, space characters that occur at the end of a line are ignored.  The space characters still exist and the insertion point can be positioned amongst them, but their additional width is ignored when justifying lines or returning the total width of a text layout.  All end-of-line space characters are considered to be attached to the right edge of the line; this behavior is logical for left-justified text and reasonable for center-justified text, but not very useful when editing right-justified text.  Spaces are considered variable width characters; the first space that extends past the edge of the text layout is clipped to the edge, and any subsequent spaces on the line are considered zero width and pegged against the edge.  Space characters that occur in the middle of a line of text are not suppressed and occupy their normal space width.

Tab characters are not ignored for measurement calculations.  If wrapping is turned on and there are enough tabs on a line, the next tab will wrap to the beginning of the next line.  There are some possible strange interactions between tabs and justification; tab positions are calculated and the line length computed in a left-justified world, and then the whole resulting line is shifted so it is centered or right-justified, causing the tab columns not to align any more.

When wrapping is turned on, lines may wrap at word breaks (space or tab characters) or newline/returns.  A dash or hyphen character in the middle of a word is not considered a word break.  **Tk\_ComputeTextLayout** always attempts to place at least one word on each line.  If it cannot because the *wrapLength* is too small, the word will be broken and as much as fits placed on the line and the rest on subsequent line(s).  If *wrapLength* is so small that not even one character can fit on a given line, the *wrapLength* is ignored for that line and one character will be placed on the line anyhow.  When wrapping is turned off, only newline/return characters may cause a line break.

When a text layout has been created using an underlined *tkfont*, then any space characters that occur at the end of individual lines, newlines/returns, and tabs will not be displayed underlined when **Tk\_DrawTextLayout** is called, because those characters are never actually drawn - they are merely placeholders maintained in the *layout*.


[GetFont]: GetFont.md
[MeasureChar]: MeasureChar.md
[Utf]: ../tcl-c/Utf.md
