---
CommandName: Utf
title: Utf
ManualSection: 3
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Library Procedures
Keywords:
 - utf
 - unicode
 - backslash
Copyright:
 - Copyright (c) 1997 Sun Microsystems, Inc.
---

# Name

Tcl\_UniChar, Tcl\_UniCharToUtf, Tcl\_UtfToUniChar, Tcl\_UniCharToUtfDString, Tcl\_UtfToUniCharDString, Tcl\_UniCharLen, Tcl\_UniCharNcmp, Tcl\_UniCharNcasecmp, Tcl\_UniCharCaseMatch, Tcl\_UtfNcmp, Tcl\_UtfNcasecmp, Tcl\_UtfCharComplete, Tcl\_NumUtfChars, Tcl\_UtfFindFirst, Tcl\_UtfFindLast, Tcl\_UtfNext, Tcl\_UtfPrev, Tcl\_UniCharAtIndex, Tcl\_UtfAtIndex, Tcl\_UtfBackslash - routines for manipulating UTF-8 strings

# Synopsis

::: {.synopsis} :::
**#include <tcl.h>**
typedef ... Tcl\_UniChar;
[int]{.ret} [Tcl\_UniCharToUtf]{.ccmd} [ch, buf]{.cargs}
[int]{.ret} [Tcl\_UtfToUniChar]{.ccmd} [src, chPtr]{.cargs}
[char \*]{.ret} [Tcl\_UniCharToUtfDString]{.ccmd} [uniStr, uniLength, dsPtr]{.cargs}
[Tcl\_UniChar \*]{.ret} [Tcl\_UtfToUniCharDString]{.ccmd} [src, length, dsPtr]{.cargs}
[int]{.ret} [Tcl\_UniCharLen]{.ccmd} [uniStr]{.cargs}
[int]{.ret} [Tcl\_UniCharNcmp]{.ccmd} [ucs, uct, numChars]{.cargs}
[int]{.ret} [Tcl\_UniCharNcasecmp]{.ccmd} [ucs, uct, numChars]{.cargs}
[int]{.ret} [Tcl\_UniCharCaseMatch]{.ccmd} [uniStr, uniPattern, nocase]{.cargs}
[int]{.ret} [Tcl\_UtfNcmp]{.ccmd} [cs, ct, numChars]{.cargs}
[int]{.ret} [Tcl\_UtfNcasecmp]{.ccmd} [cs, ct, numChars]{.cargs}
[int]{.ret} [Tcl\_UtfCharComplete]{.ccmd} [src, length]{.cargs}
[int]{.ret} [Tcl\_NumUtfChars]{.ccmd} [src, length]{.cargs}
[const char \*]{.ret} [Tcl\_UtfFindFirst]{.ccmd} [src, ch]{.cargs}
[const char \*]{.ret} [Tcl\_UtfFindLast]{.ccmd} [src, ch]{.cargs}
[const char \*]{.ret} [Tcl\_UtfNext]{.ccmd} [src]{.cargs}
[const char \*]{.ret} [Tcl\_UtfPrev]{.ccmd} [src, start]{.cargs}
[Tcl\_UniChar]{.ret} [Tcl\_UniCharAtIndex]{.ccmd} [src, index]{.cargs}
[const char \*]{.ret} [Tcl\_UtfAtIndex]{.ccmd} [src, index]{.cargs}
[int]{.ret} [Tcl\_UtfBackslash]{.ccmd} [src, readPtr, dst]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*buf]{.carg .out type="char"}
: Buffer in which the UTF-8 representation of the Tcl\_UniChar is stored.  At most **TCL\_UTF\_MAX** bytes are stored in the buffer.

[ch]{.carg .in type="int"}
: The Unicode character to be converted or examined.

[\*chPtr]{.carg .out type="Tcl_UniChar"}
: Filled with the Tcl\_UniChar represented by the head of the UTF-8 string.

[\*src]{.carg .in type="const char"}
: Pointer to a UTF-8 string.

[\*cs]{.carg .in type="const char"}
: Pointer to a UTF-8 string.

[\*ct]{.carg .in type="const char"}
: Pointer to a UTF-8 string.

[\*uniStr]{.carg .in type="const Tcl_UniChar"}
: A null-terminated Unicode string.

[\*ucs]{.carg .in type="const Tcl_UniChar"}
: A null-terminated Unicode string.

[\*uct]{.carg .in type="const Tcl_UniChar"}
: A null-terminated Unicode string.

[\*uniPattern]{.carg .in type="const Tcl_UniChar"}
: A null-terminated Unicode string.

[length]{.carg .in type="int"}
: The length of the UTF-8 string in bytes (not UTF-8 characters).  If negative, all bytes up to the first null byte are used.

[uniLength]{.carg .in type="int"}
: The length of the Unicode string in characters.  Must be greater than or equal to 0.

[\*dsPtr]{.carg .in/out type="Tcl_DString"}
: A pointer to a previously initialized [Tcl\_DString][DString].

[numChars]{.carg .in type="unsigned long"}
: The number of characters to compare.

[\*start]{.carg .in type="const char"}
: Pointer to the beginning of a UTF-8 string.

[index]{.carg .in type="int"}
: The index of a character (not byte) in the UTF-8 string.

[\*readPtr]{.carg .out type="int"}
: If non-NULL, filled with the number of bytes in the backslash sequence, including the backslash character.

[\*dst]{.carg .out type="char"}
: Buffer in which the bytes represented by the backslash sequence are stored. At most **TCL\_UTF\_MAX** bytes are stored in the buffer.

[nocase]{.carg .in type="int"}
: Specifies whether the match should be done case-sensitive (0) or case-insensitive (1).

:::

# Description

These routines convert between UTF-8 strings and Tcl\_UniChars.  A Tcl\_UniChar is a Unicode character represented as an unsigned, fixed-size quantity.  A UTF-8 character is a Unicode character represented as a varying-length sequence of up to **TCL\_UTF\_MAX** bytes.  A multibyte UTF-8 sequence consists of a lead byte followed by some number of trail bytes.

**TCL\_UTF\_MAX** is the maximum number of bytes that it takes to represent one Unicode character in the UTF-8 representation.

**Tcl\_UniCharToUtf** stores the Tcl\_UniChar *ch* as a UTF-8 string in starting at *buf*.  The return value is the number of bytes stored in *buf*.

**Tcl\_UtfToUniChar** reads one UTF-8 character starting at *src* and stores it as a Tcl\_UniChar in *\*chPtr*.  The return value is the number of bytes read from *src*.  The caller must ensure that the source buffer is long enough such that this routine does not run off the end and dereference non-existent or random memory; if the source buffer is known to be null-terminated, this will not happen.  If the input is not in proper UTF-8 format, **Tcl\_UtfToUniChar** will store the first byte of *src* in *\*chPtr* as a Tcl\_UniChar between 0x80 and 0xFF and return 1.

**Tcl\_UniCharToUtfDString** converts the given Unicode string to UTF-8, storing the result in a previously initialized [Tcl\_DString][DString]. You must specify *uniLength*, the length of the given Unicode string. The return value is a pointer to the UTF-8 representation of the Unicode string.  Storage for the return value is appended to the end of the [Tcl\_DString][DString].

**Tcl\_UtfToUniCharDString** converts the given UTF-8 string to Unicode, storing the result in the previously initialized [Tcl\_DString][DString]. In the argument *length*, you may either specify the length of the given UTF-8 string in bytes or "-1", in which case **Tcl\_UtfToUniCharDString** uses **strlen** to calculate the length.  The return value is a pointer to the Unicode representation of the UTF-8 string.  Storage for the return value is appended to the end of the [Tcl\_DString][DString].  The Unicode string is terminated with a Unicode null character.

**Tcl\_UniCharLen** corresponds to **strlen** for Unicode characters.  It accepts a null-terminated Unicode string and returns the number of Unicode characters (not bytes) in that string.

**Tcl\_UniCharNcmp** and **Tcl\_UniCharNcasecmp** correspond to **strncmp** and **strncasecmp**, respectively, for Unicode characters. They accept two null-terminated Unicode strings and the number of characters to compare.  Both strings are assumed to be at least *numChars* characters long. **Tcl\_UniCharNcmp**  compares the two strings character-by-character according to the Unicode character ordering.  It returns an integer greater than, equal to, or less than 0 if the first string is greater than, equal to, or less than the second string respectively.  **Tcl\_UniCharNcasecmp** is the Unicode case insensitive version.

**Tcl\_UniCharCaseMatch** is the Unicode equivalent to [Tcl\_StringCaseMatch][StrMatch].  It accepts a null-terminated Unicode string, a Unicode pattern, and a boolean value specifying whether the match should be case sensitive and returns whether the string matches the pattern.

**Tcl\_UtfNcmp** corresponds to **strncmp** for UTF-8 strings. It accepts two null-terminated UTF-8 strings and the number of characters to compare.  (Both strings are assumed to be at least *numChars* characters long.)  **Tcl\_UtfNcmp** compares the two strings character-by-character according to the Unicode character ordering. It returns an integer greater than, equal to, or less than 0 if the first string is greater than, equal to, or less than the second string respectively.

**Tcl\_UtfNcasecmp** corresponds to **strncasecmp** for UTF-8 strings.  It is similar to **Tcl\_UtfNcmp** except comparisons ignore differences in case when comparing upper, lower or title case characters.

**Tcl\_UtfCharComplete** returns 1 if the source UTF-8 string *src* of *length* bytes is long enough to be decoded by **Tcl\_UtfToUniChar**/**Tcl\_UtfNext**, or 0 otherwise.  This function does not guarantee that the UTF-8 string is properly formed.  This routine is used by procedures that are operating on a byte at a time and need to know if a full Tcl\_UniChar has been seen.

**Tcl\_NumUtfChars** corresponds to **strlen** for UTF-8 strings.  It returns the number of Tcl\_UniChars that are represented by the UTF-8 string *src*.  The length of the source string is *length* bytes.  If the length is negative, all bytes up to the first null byte are used.

**Tcl\_UtfFindFirst** corresponds to **strchr** for UTF-8 strings.  It returns a pointer to the first occurrence of the Tcl\_UniChar *ch* in the null-terminated UTF-8 string *src*.  The null terminator is considered part of the UTF-8 string.

**Tcl\_UtfFindLast** corresponds to **strrchr** for UTF-8 strings.  It returns a pointer to the last occurrence of the Tcl\_UniChar *ch* in the null-terminated UTF-8 string *src*.  The null terminator is considered part of the UTF-8 string.

Given *src*, a pointer to some location in a UTF-8 string, **Tcl\_UtfNext** returns a pointer to the next UTF-8 character in the string.  The caller must not ask for the next character after the last character in the string if the string is not terminated by a null character. **Tcl\_UtfCharComplete** can be used in that case to make sure enough bytes are available before calling **Tcl\_UtfNext**.

**Tcl\_UtfPrev** is used to step backward through but not beyond the UTF-8 string that begins at *start*.  If the UTF-8 string is made up entirely of complete and well-formed characters, and *src* points to the lead byte of one of those characters (or to the location one byte past the end of the string), then repeated calls of **Tcl\_UtfPrev** will return pointers to the lead bytes of each character in the string, one character at a time, terminating when it returns *start*.

When the conditions of completeness and well-formedness may not be satisfied, a more precise description of the function of **Tcl\_UtfPrev** is necessary. It always returns a pointer greater than or equal to *start*; that is, always a pointer to a location in the string. It always returns a pointer to a byte that begins a character when scanning for characters beginning from *start*. When *src* is greater than *start*, it always returns a pointer less than *src* and greater than or equal to (*src* - **TCL\_UTF\_MAX**).  The character that begins at the returned pointer is the first one that either includes the byte *src\[-1\]*, or might include it if the right trail bytes are present at *src* and greater. **Tcl\_UtfPrev** never reads the byte *src\[0\]* nor the byte *start\[-1\]* nor the byte *src\[-***TCL\_UTF\_MAX***-1\]*.

**Tcl\_UniCharAtIndex** corresponds to a C string array dereference or the Pascal Ord() function.  It returns the Tcl\_UniChar represented at the specified character (not byte) *index* in the UTF-8 string *src*.  The source string must contain at least *index* characters.  Behavior is undefined if a negative *index* is given.

**Tcl\_UtfAtIndex** returns a pointer to the specified character (not byte) *index* in the UTF-8 string *src*.  The source string must contain at least *index* characters.  This is equivalent to calling **Tcl\_UtfToUniChar** *index* times.  If a negative *index* is given, the return pointer points to the first character in the source string.

**Tcl\_UtfBackslash** is a utility procedure used by several of the Tcl commands.  It parses a backslash sequence and stores the properly formed UTF-8 character represented by the backslash sequence in the output buffer *dst*.  At most **TCL\_UTF\_MAX** bytes are stored in the buffer. **Tcl\_UtfBackslash** modifies *\*readPtr* to contain the number of bytes in the backslash sequence, including the backslash character. The return value is the number of bytes stored in the output buffer.

See the [Tcl] manual entry for information on the valid backslash sequences.  All of the sequences described in the Tcl manual entry are supported by **Tcl\_UtfBackslash**.


[DString]: DString.md
[StrMatch]: StrMatch.md
[Tcl]: ../tcl/Tcl.md
