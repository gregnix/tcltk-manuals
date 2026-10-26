---
CommandName: Utf
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

Tcl_UniChar, Tcl_UniCharToUtf, Tcl_UtfToUniChar, Tcl_UtfToChar16, Tcl_UtfToWChar, Tcl_UniCharToUtfDString, Tcl_UtfToUniCharDString, Tcl_Char16ToUtfDString, Tcl_UtfToWCharDString, Tcl_UtfToChar16DString, Tcl_WCharToUtfDString, Tcl_WCharLen, Tcl_Char16Len, Tcl_UniCharLen, Tcl_UtfNcmp, Tcl_UtfNcasecmp, Tcl_UtfCharComplete, Tcl_NumUtfChars, Tcl_UtfFindFirst, Tcl_UtfFindLast, Tcl_UtfNext, Tcl_UtfPrev, Tcl_UniCharAtIndex, Tcl_UtfAtIndex, Tcl_UtfBackslash - routines for manipulating TUTF-8 encoded byte sequences

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tcl.h>]{.lit}

typedef ... [Tcl_UniChar]{.cmd};

Tcl_Size
[Tcl_UniCharToUtf]{.cmd}([ch]{.arg}, [buf]{.arg})

Tcl_Size
[Tcl_UtfToUniChar]{.cmd}([src]{.arg}, [chPtr]{.arg})

Tcl_Size
[Tcl_UtfToChar16]{.cmd}([src]{.arg}, [uPtr]{.arg})

Tcl_Size
[Tcl_UtfToWChar]{.cmd}([src]{.arg}, [wPtr]{.arg})

char \*
[Tcl_UniCharToUtfDString]{.cmd}([uniStr]{.arg}, [numUniChars]{.arg}, [dsPtr]{.arg})

char \*
[Tcl_Char16ToUtfDString]{.cmd}([utf16]{.arg}, [numUtf16]{.arg}, [dsPtr]{.arg})

char \*
[Tcl_WCharToUtfDString]{.cmd}([wcharStr]{.arg}, [numWChars]{.arg}, [dsPtr]{.arg})

Tcl_UniChar \*
[Tcl_UtfToUniCharDString]{.cmd}([src]{.arg}, [numBytes]{.arg}, [dsPtr]{.arg})

unsigned short \*
[Tcl_UtfToChar16DString]{.cmd}([src]{.arg}, [numBytes]{.arg}, [dsPtr]{.arg})

wchar_t \*
[Tcl_UtfToWCharDString]{.cmd}([src]{.arg}, [numBytes]{.arg}, [dsPtr]{.arg})

Tcl_Size
[Tcl_Char16Len]{.cmd}([utf16]{.arg})

Tcl_Size
[Tcl_WCharLen]{.cmd}([wcharStr]{.arg})

Tcl_Size
[Tcl_UniCharLen]{.cmd}([uniStr]{.arg})

int
[Tcl_UtfNcmp]{.cmd}([cs]{.arg}, [ct]{.arg}, [length]{.arg})

int
[Tcl_UtfNcasecmp]{.cmd}([cs]{.arg}, [ct]{.arg}, [length]{.arg})

int
[Tcl_UtfCharComplete]{.cmd}([src]{.arg}, [numBytes]{.arg})

Tcl_Size
[Tcl_NumUtfChars]{.cmd}([src]{.arg}, [numBytes]{.arg})

const char \*
[Tcl_UtfFindFirst]{.cmd}([src]{.arg}, [ch]{.arg})

const char \*
[Tcl_UtfFindLast]{.cmd}([src]{.arg}, [ch]{.arg})

const char \*
[Tcl_UtfNext]{.cmd}([src]{.arg})

const char \*
[Tcl_UtfPrev]{.cmd}([src]{.arg}, [start]{.arg})

int
[Tcl_UniCharAtIndex]{.cmd}([src]{.arg}, [index]{.arg})

const char \*
[Tcl_UtfAtIndex]{.cmd}([src]{.arg}, [index]{.arg})

Tcl_Size
[Tcl_UtfBackslash]{.cmd}([src]{.arg}, [readPtr]{.arg}, [dst]{.arg})
:::

# Arguments

char *\*buf* (out)
: Buffer in which the TUTF-8 representation of the Tcl_UniChar is stored.  At most **TCL_UTF_MAX** bytes are stored in the buffer.

int *ch* (in)
: The Unicode character to be converted or examined.

Tcl_UniChar *\*chPtr* (out)
: Filled with the Tcl_UniChar represented by the head of the TUTF-8 byte sequence.

unsigned short *\*uPtr* (out)
: Filled with the utf-16 represented by the head of the TUTF-8 byte sequence.

wchar_t *\*wPtr* (out)
: Filled with the wchar_t represented by the head of the TUTF-8 byte sequence.

const char *\*src* (in)
: Pointer to a TUTF-8 byte sequence.

const char *\*cs* (in)
: Pointer to a TUTF-8 byte sequence.

const char *\*ct* (in)
: Pointer to a TUTF-8 byte sequence.

const Tcl_UniChar *\*uniStr* (in)
: A sequence of **Tcl_UniChar** units with null-termination optional depending on function.

const Tcl_UniChar *\*ucs* (in)
: A null-terminated sequence of **Tcl_UniChar**.

const Tcl_UniChar *\*uct* (in)
: A null-terminated sequence of **Tcl_UniChar**.

const Tcl_UniChar *\*uniPattern* (in)
: A null-terminated sequence of **Tcl_UniChar**.

const unsigned short *\*utf16* (in)
: A sequence of UTF-16 units with null-termination optional depending on function.

const wchar_t *\*wcharStr* (in)
: A sequence of **wchar_t** units with null-termination optional depending on function.

Tcl_Size *numBytes* (in)
: The length of the TUTF-8 input in bytes.  If negative, the length includes all bytes until the first null byte.

Tcl_Size *numUtf16* (in)
: The length of the input in UTF-16 units. If negative, the length includes all bytes until the first null.

Tcl_Size *numUniChars* (in)
: The length of the input in Tcl_UniChar units. If negative, the length includes all bytes until the first null.

Tcl_Size *numWChars* (in)
: The length of the input in wchar_t units. If negative, the length includes all bytes until the first null.

Tcl_DString *\*dsPtr* (in/out)
: A pointer to a previously initialized **Tcl_DString**.

const char *\*start* (in)
: Pointer to the beginning of a TUTF-8 byte sequence.

Tcl_Size *index* (in)
: The index of a character (not byte) in the TUTF-8 byte sequence.

int *\*readPtr* (out)
: If non-NULL, filled with the number of bytes in the backslash sequence, including the backslash character.

char *\*dst* (out)
: Buffer in which the bytes represented by the backslash sequence are stored. At most **TCL_UTF_MAX** bytes are stored in the buffer.

int *nocase* (in)
: Specifies whether the match should be done case-sensitive (0) or case-insensitive (1).


# Description

N.B. The use of the term *TUTF-8* in this documentation refers to the modified UTF-8 encoding used internally by Tcl. This differs from the UTF-8 encoding defined in the Unicode standard with respect to the encoding of the NUL character U+0000 which Tcl encodes internally as the byte sequence 0xC0 0x80 and not a single 0x00 byte as per the standard. The term *TUTF-8 byte sequence* refers to a byte sequence representing one or more Unicode code points encoded in TUTF-8. The term *character* refers to a Unicode code point and is used interchangeably with it.

The routines described here convert between TUTF-8 encoded byte sequences and other representation forms.

The **Tcl_UniChar** type is an C integer type wide enough to hold a single Unicode code point value. A TUTF-8 byte sequence encoding a single code point may have a maximum length of 4 bytes, defined as the C preprocessor symbol **TCL_UTF_MAX**. This is also the maximum number of bytes that **Tcl_UtfToUniChar** can consume in a single call.

**Tcl_UniCharToUtf** encodes the character *ch* as a TUTF-8 byte sequence, storing it starting at *buf*.  The return value is the number of bytes stored in *buf*. The character *ch* can be or'ed with the value TCL_COMBINE to enable special behavior, compatible with Tcl 8.x. Then, if ch is a high surrogate (range U+D800 - U+DBFF), the return value will be 1 and a single byte in the range 0xF0 - 0xF4 will be stored. If *ch* is a low surrogate (range U+DC00 - U+DFFF), an attempt is made to combine the result with the earlier produced bytes, resulting in a 4-byte TUTF-8 byte sequence.

**Tcl_UtfToUniChar** reads a TUTF-8 byte sequence starting at *src* and encoding a single code point, and stores it as a Tcl_UniChar in *\*chPtr*.  The return value is the number of bytes read from *src*.  The caller must ensure that the source buffer is long enough such that this routine does not run off the end and dereference non-existent or random memory; if the source buffer is known to be null-terminated, this will not happen.  If the input starts with a byte in the range 0x80 - 0x9F, **Tcl_UtfToUniChar** assumes the cp1252 encoding, stores the corresponding Tcl_UniChar in *\*chPtr* and returns 1. If the input is otherwise not in proper TUTF-8 format, **Tcl_UtfToUniChar** will store the first byte of *src* in *\*chPtr* as a Tcl_UniChar between 0x00A0 and 0x00FF and return 1.

**Tcl_UniCharToUtfDString** converts the input in the form of a sequence of **Tcl_UniChar** code points to TUTF-8, appending the result to the previously initialized output **Tcl_DString**. The return value is a pointer to the TUTF-8 encoded representation of the **appended** string.

**Tcl_UtfToUniCharDString** converts the input in the form of a TUTF-8 byte sequence to a **Tcl_UniChar** sequence appending the result in the previously initialized **Tcl_DString**. The return value is a pointer to the appended result which is also terminated with a **Tcl_UniChar** NUL character.

**Tcl_WCharToUtfDString** and **Tcl_UtfToWCharDString** are similar to **Tcl_UniCharToUtfDString** and **Tcl_UtfToUniCharDString** except they operate on sequences of **wchar_t** instead of **Tcl_UniChar**.

**Tcl_Char16ToUtfDString** and **Tcl_UtfToChar16DString** are similar to **Tcl_UniCharToUtfDString** and **Tcl_UtfToUniCharDString** except they operate on sequences of **UTF-16** units instead of **Tcl_UniChar**.

**Tcl_Char16Len** corresponds to **strlen** for UTF-16 characters.  It accepts a null-terminated UTF-16 sequence and returns the number of UTF-16 units until the null.

**Tcl_WCharLen** corresponds to **strlen** for **wchar_t** characters.  It accepts a null-terminated **wchar_t** sequence and returns the number of **wchar_t** units until the null.

**Tcl_UniCharLen** corresponds to **strlen** for Tcl_UniChar characters.  It accepts a null-terminated Tcl_UniChar string and returns the number of Tcl_UniChar's (not bytes) in that string.

**Tcl_UtfNcmp** corresponds to **strncmp** and accepts two null-terminated TUTF-8 encoded strings each of which should represent a sequence of at least *length* code points. **Tcl_UtfNcmp** compares the code points represented by each of the encoded strings in order. It returns an integer greater than, equal to, or less than 0 if the first string is greater than, equal to, or less than the second string respectively.

**Tcl_UtfNcasecmp** corresponds to **strncasecmp** for TUTF-8 encoded strings.  It is similar to **Tcl_UtfNcmp** except comparisons ignore differences in case when comparing upper, lower or title case characters.

**Tcl_UtfCharComplete** returns 1 if the source TUTF-8 byte sequence *src* of *numBytes* bytes is long enough to be decoded by **Tcl_UtfToUniChar**/**Tcl_UtfNext**, or 0 otherwise.  This function does not guarantee that the TUTF-8 byte sequence is properly formed.  This routine is used by procedures that are operating on a byte at a time and need to know if a full Unicode character has been seen.

**Tcl_NumUtfChars** corresponds to **strlen** for TUTF-8 byte sequences. It returns the number of Tcl_UniChars that are represented by the TUTF-8 byte sequence *src*. The length of the source string is *length* bytes. If the length is negative, all bytes up to the first null byte are used.

**Tcl_UtfFindFirst** corresponds to **strchr** for TUTF-8 byte sequences. It returns a pointer to the first occurrence of the Unicode character *ch* in the null-terminated TUTF-8 byte sequence *src*. The null terminator is considered part of the byte sequence.

**Tcl_UtfFindLast** corresponds to **strrchr** for TUTF-8 byte sequences. It returns a pointer to the last occurrence of the Unicode character *ch* in the null-terminated TUTF-8 byte sequence *src*. The null terminator is considered part of the byte sequence.

Given *src*, a pointer to some location in a TUTF-8 byte sequence, **Tcl_UtfNext** returns a pointer to the start of the TUTF-8 byte sequence corresponding to the next character The caller must not ask for the next character after the last character in the string if the string is not terminated by a null character. **Tcl_UtfCharComplete** can be used in that case to make sure enough bytes are available before calling **Tcl_UtfNext**.

**Tcl_UtfPrev** is used to step backward through but not beyond the TUTF-8 byte sequence that begins at *start*. If the byte sequence is made up entirely of complete and well-formed characters, and *src* points to the lead byte of one of those characters (or to the location one byte past the end of the string), then repeated calls of **Tcl_UtfPrev** will return pointers to the lead bytes of each character in the string, one character at a time, terminating when it returns *start*.

When the conditions of completeness and well-formedness may not be satisfied, a more precise description of the function of **Tcl_UtfPrev** is necessary. It always returns a pointer greater than or equal to *start*; that is, always a pointer to a location in the string. It always returns a pointer to a byte that begins a character when scanning for characters beginning from *start*. When *src* is greater than *start*, it always returns a pointer less than *src* and greater than or equal to (*src* - 4).  The character that begins at the returned pointer is the first one that either includes the byte *src\[-1\]*, or might include it if the right trail bytes are present at *src* and greater. **Tcl_UtfPrev** never reads the byte *src\[0\]* nor the byte *start\[-1\]* nor the byte *src\[-5\]*.

**Tcl_UniCharAtIndex** corresponds to a C string array dereference or the Pascal Ord() function.  It returns the Unicode code point represented at the specified character (not byte) *index* in the TUTF-8 byte sequence *src*.  The source string must contain at least *index* characters.  If *index* is negative it returns -1.

**Tcl_UtfAtIndex** returns a pointer to the specified character (not byte) *index* in the TUTF-8 byte sequence *src*.  The source must contain at least *index* characters.  This is equivalent to calling **Tcl_UtfToUniChar** *index* times.  If *index* is negative, the return pointer points to the first character in the source.

**Tcl_UtfBackslash** is a utility procedure used by several of the Tcl commands.  It parses a backslash sequence and stores the properly formed TUTF-8 encoding of the character represented by the backslash sequence in the output buffer *dst*.  At most **TCL_UTF_MAX** bytes are stored in the buffer. **Tcl_UtfBackslash** modifies *\*readPtr* to contain the number of bytes in the backslash sequence, including the backslash character. The return value is the number of bytes stored in the output buffer. See the **Tcl** manual entry for information on the valid backslash sequences.  All of the sequences described in the Tcl manual entry are supported by **Tcl_UtfBackslash**.
