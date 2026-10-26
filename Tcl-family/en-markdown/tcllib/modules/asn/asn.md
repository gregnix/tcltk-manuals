---
CommandName: asn
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: ASN.1 processing
Keywords:
 - asn
 - ber
 - cer
 - der
 - internet
 - protocol
 - x.208
 - x.209
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
 - Copyright (c) 2004-2011 Michael Schlenker <mic42@users.sourceforge.net>
---

# Name

asn - ASN.1 BER encoder/decoder

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [asn]{.lit} [0.8.5]{.optlit} 
[::asn::asnSequence]{.cmd} [evalue]{.optdot} 
[::asn::asnSequenceFromList]{.cmd} [elist]{.arg} 
[::asn::asnSet]{.cmd} [evalue]{.optdot} 
[::asn::asnSetFromList]{.cmd} [elist]{.arg} 
[::asn::asnApplicationConstr]{.cmd} [appNumber]{.arg} [evalue]{.optdot} 
[::asn::asnApplication]{.cmd} [appNumber]{.arg} [data]{.arg} 
[::asn::asnChoice]{.cmd} [appNumber]{.arg} [evalue]{.optdot} 
[::asn::asnChoiceConstr]{.cmd} [appNumber]{.arg} [evalue]{.optdot} 
[::asn::asnInteger]{.cmd} [number]{.arg} 
[::asn::asnEnumeration]{.cmd} [number]{.arg} 
[::asn::asnBoolean]{.cmd} [bool]{.arg} 
[::asn::asnContext]{.cmd} [context]{.arg} [data]{.arg} 
[::asn::asnContextConstr]{.cmd} [context]{.arg} [evalue]{.optdot} 
[::asn::asnObjectIdentifier]{.cmd} [idlist]{.arg} 
[::asn::asnUTCTime]{.cmd} [utcstring]{.arg} 
[::asn::asnNull]{.cmd} 
[::asn::asnBitString]{.cmd} [string]{.arg} 
[::asn::asnOctetString]{.cmd} [string]{.arg} 
[::asn::asnNumericString]{.cmd} [string]{.arg} 
[::asn::asnPrintableString]{.cmd} [string]{.arg} 
[::asn::asnIA5String]{.cmd} [string]{.arg} 
[::asn::asnBMPString]{.cmd} [string]{.arg} 
[::asn::asnUTF8String]{.cmd} [string]{.arg} 
[::asn::asnString]{.cmd} [string]{.arg} 
[::asn::defaultStringType]{.cmd} [type]{.optarg} 
[::asn::asnPeekByte]{.cmd} [dataVar]{.arg} [byteVar]{.arg} 
[::asn::asnGetLength]{.cmd} [dataVar]{.arg} [lengthVar]{.arg} 
[::asn::asnGetResponse]{.cmd} [chan]{.arg} [dataVar]{.arg} 
[::asn::asnGetInteger]{.cmd} [dataVar]{.arg} [intVar]{.arg} 
[::asn::asnGetEnumeration]{.cmd} [dataVar]{.arg} [enumVar]{.arg} 
[::asn::asnGetOctetString]{.cmd} [dataVar]{.arg} [stringVar]{.arg} 
[::asn::asnGetString]{.cmd} [dataVar]{.arg} [stringVar]{.arg} [typeVar]{.optarg} 
[::asn::asnGetNumericString]{.cmd} [dataVar]{.arg} [stringVar]{.arg} 
[::asn::asnGetPrintableString]{.cmd} [dataVar]{.arg} [stringVar]{.arg} 
[::asn::asnGetIA5String]{.cmd} [dataVar]{.arg} [stringVar]{.arg} 
[::asn::asnGetBMPString]{.cmd} [dataVar]{.arg} [stringVar]{.arg} 
[::asn::asnGetUTF8String]{.cmd} [dataVar]{.arg} [stringVar]{.arg} 
[::asn::asnGetUTCTime]{.cmd} [dataVar]{.arg} [utcVar]{.arg} 
[::asn::asnGetBitString]{.cmd} [dataVar]{.arg} [bitsVar]{.arg} 
[::asn::asnGetObjectIdentifier]{.cmd} [dataVar]{.arg} [oidVar]{.arg} 
[::asn::asnGetBoolean]{.cmd} [dataVar]{.arg} [boolVar]{.arg} 
[::asn::asnGetNull]{.cmd} [dataVar]{.arg} 
[::asn::asnGetSequence]{.cmd} [dataVar]{.arg} [sequenceVar]{.arg} 
[::asn::asnGetSet]{.cmd} [dataVar]{.arg} [setVar]{.arg} 
[::asn::asnGetApplication]{.cmd} [dataVar]{.arg} [appNumberVar]{.arg} [contentVar]{.optarg} [encodingTypeVar]{.optarg} 
[::asn::asnGetContext]{.cmd} [dataVar]{.arg} [contextNumberVar]{.arg} [contentVar]{.optarg} [encodingTypeVar]{.optarg} 
[::asn::asnPeekTag]{.cmd} [dataVar]{.arg} [tagVar]{.arg} [tagtypeVar]{.arg} [constrVar]{.arg} 
[::asn::asnTag]{.cmd} [tagnumber]{.arg} [class]{.optarg} [tagstyle]{.optarg} 
[::asn::asnRetag]{.cmd} [dataVar]{.arg} [newTag]{.arg} 
:::

# Description

The **asn** package provides *partial* de- and encoder commands for BER encoded ASN.1 data. It can also be used for decoding DER, which is a restricted subset of BER.

ASN.1 is a standard *Abstract Syntax Notation*, and BER are its *Basic Encoding Rules*.

See *http://asn1.elibel.tm.fr/en/standards/index.htm* for more information about the standard.

Also see *http://luca.ntop.org/Teaching/Appunti/asn1.html* for *A Layman's Guide to a Subset of ASN.1, BER, and DER*, an RSA Laboratories Technical Note by Burton S. Kaliski Jr. (Revised November 1, 1993). A text version of this note is part of the module sources and should be read by any implementor.

# Api

## Encoder

**::asn::asnSequence** ?*evalue ...*?
: Takes zero or more encoded values, packs them into an ASN sequence and returns its encoded binary form.

**::asn::asnSequenceFromList** *elist*
: Takes a list of encoded values, packs them into an ASN sequence and returns its encoded binary form.

**::asn::asnSet** ?*evalue ...*?
: Takes zero or more encoded values, packs them into an ASN set and returns its encoded binary form.

**::asn::asnSetFromList** *elist*
: Takes a list of encoded values, packs them into an ASN set and returns its encoded binary form.

**::asn::asnApplicationConstr** *appNumber* ?*evalue ...*?
: Takes zero or more encoded values, packs them into an ASN application construct and returns its encoded binary form.

**::asn::asnApplication** *appNumber* *data*
: Takes a single encoded value *data*, packs it into an ASN application construct and returns its encoded binary form.

**::asn::asnChoice** *appNumber* ?*evalue ...*?
: Takes zero or more encoded values, packs them into an ASN choice construct and returns its encoded binary form.

**::asn::asnChoiceConstr** *appNumber* ?*evalue ...*?
: Takes zero or more encoded values, packs them into an ASN choice construct and returns its encoded binary form.

**::asn::asnInteger** *number*
: Returns the encoded form of the specified integer *number*.

**::asn::asnEnumeration** *number*
: Returns the encoded form of the specified enumeration id *number*.

**::asn::asnBoolean** *bool*
: Returns the encoded form of the specified boolean value *bool*.

**::asn::asnContext** *context* *data*
: Takes an encoded value and packs it into a constructed value with application tag, the *context* number.

**::asn::asnContextConstr** *context* ?*evalue ...*?
: Takes zero or more encoded values and packs them into a constructed value with application tag, the *context* number.

**::asn::asnObjectIdentifier** *idlist*
: Takes a list of at least two integers describing an object identifier (OID) value, and returns the encoded value.

**::asn::asnUTCTime** *utcstring*
: Returns the encoded form of the specified UTC time string.

**::asn::asnNull**
: Returns the NULL encoding.

**::asn::asnBitString** *string*
: Returns the encoded form of the specified *string*.

**::asn::asnOctetString** *string*
: Returns the encoded form of the specified *string*.

**::asn::asnNumericString** *string*
: Returns the *string* encoded as an ASN.1 NumericString. Raises an error if the *string* contains characters other than decimal digits and spaces.

**::asn::asnPrintableString** *string*
: Returns the *string* encoding as ASN.1 PrintableString. Raises an error if the *string* contains characters which are not allowed by the Printable String datatype. The allowed characters are A-Z, a-z, 0-9, space, apostrophe, colon, parentheses, plus, minus, comma, period, forward slash, question mark, and the equals sign.

**::asn::asnIA5String** *string*
: Returns the *string* encoded as ASN.1 IA5String. Raises an error if the *string* contains any characters outside of the US-ASCII range.

**::asn::asnBMPString** *string*
: Returns the *string* encoded as ASN.1 Basic Multilingual Plane string (Which is essentialy big-endian UCS2).

**::asn::asnUTF8String** *string*
: Returns the *string* encoded as UTF8 String. Note that some legacy applications such as Windows CryptoAPI may not work correctly with UTF8 strings. It may be safest to use BMPStrings.

**::asn::asnString** *string*
: Returns an encoded form of *string*, choosing the most restricted ASN.1 string type possible. If the string contains non-ASCII characters, then there is more than one string type which can be used. See **::asn::defaultStringType**.

**::asn::defaultStringType** ?*type*?
: Selects the string type to use for the encoding of non-ASCII strings. Returns current default when called without argument. If the argument *type* is supplied, it should be either **UTF8** or **BMP** to choose UTF8String or BMPString respectively.


## Decoder

General notes:

**\[1\]**
: Nearly all getter (decoder) commands take two arguments. These arguments are variable names, *except* for **::asn::asnGetResponse**. The *dataVar* variable contains the encoded ASN values to decode. When a value getter (decoder) is called, the value is stored in the second variable, and the remaining input is stored back in the first *dataVar* variable.

**\[2\]**
: When getting (decoding), the *dataVar* variable is modified first, before the decoded value is stored in the second variable. This means that if both arguments refer to the same variable, it will always contain the decoded value after the call, and not the remainder of the input.


**::asn::asnPeekByte** *dataVar* *byteVar*
: Return a copy of the first byte of the data, without modifing *dataVar*. This can be used to check for implicit tags.

**::asn::asnGetLength** *dataVar* *lengthVar*
: Decode the length information for a block of BER data. The tag has already to be removed from the data.

**::asn::asnGetResponse** *chan* *dataVar*
: Reads an encoded ASN *sequence* from the channel *chan* and stores it into the variable called *dataVar*.

**::asn::asnGetInteger** *dataVar* *intVar*
: Decodes the integer value encoded at the start of the data stored in the variable called *dataVar*. The integer is stored in the variable called *intVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded integer an error is thrown.

**::asn::asnGetEnumeration** *dataVar* *enumVar*
: Decodes the enumeration ID value encoded at the start of the data stored in the variable called *dataVar*. The enumeration ID is stored in the variable called *enumVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded enumeration ID an error is thrown.

**::asn::asnGetOctetString** *dataVar* *stringVar*
: Decodes the string value encoded at the start of the data stored in the variable called *dataVar*. The string is stored in the variable called *stringVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded string an error is thrown.

**::asn::asnGetString** *dataVar* *stringVar* ?*typeVar*?
: Decodes the user-readable string value encoded at the start of the data stored in the variable called *dataVar*. The string is stored in the variable called *stringVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded string an error is thrown. This is a convenience function which is able to automatically distinguish all supported ASN.1 string types and convert the input value appropriately. See **::asn::asnGetPrintableString**, **::asnGetIA5String**, etc., below for the type-specific conversion commands. If the optional third argument *typeVar* is supplied, then the incoming string’s type is stored in the variable it names. The function throws the error "Invalid command name asnGetSome**UnsupportedString**" if the unsupported string type **Unsupported** is encountered. You can create the appropriate function "asn::asnGetSome**UnsupportedString**" in your application if neccessary.

**::asn::asnGetNumericString** *dataVar* *stringVar*
: Decodes the numeric string value encoded at the start of the data stored in the variable called *dataVar*. The numeric string is stored in the variable called *stringVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded numeric string an error is thrown.

**::asn::asnGetPrintableString** *dataVar* *stringVar*
: Decodes the printable string value encoded at the start of the data stored in the variable called *dataVar*. The printable string is stored in the variable called *stringVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded printable string an error is thrown.

**::asn::asnGetIA5String** *dataVar* *stringVar*
: Decodes the IA5 (US-ASCII) string value encoded at the start of the data stored in the variable called *dataVar*. The IA5 string is stored in the variable called *stringVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded IA5 string an error is thrown.

**::asn::asnGetBMPString** *dataVar* *stringVar*
: Decodes the BMP (two-byte unicode—UCS2) string value encoded at the start of the data stored in the variable called *dataVar*. The BMP string is converted into a proper Tcl string which is then stored in the variable called *stringVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded BMP string an error is thrown.

**::asn::asnGetUTF8String** *dataVar* *stringVar*
: Decodes the UTF8 string value encoded at the start of the data stored in the variable called *dataVar*. The UTF8 string is converted into a proper Tcl string which is then stored in the variable called *stringVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded UTF8 string an error is thrown.

**::asn::asnGetUTCTime** *dataVar* *utcVar*
: Decodes the UTC time value encoded at the start of the data stored in the variable called *dataVar*. The UTC time value is stored in the variable called *utcVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. The value stored in *utcVar* is a string; to get an actual time value, use the  **clock scan** command. If the value at the start is not an encoded UTC time value an error is thrown.

**::asn::asnGetBitString** *dataVar* *bitsVar*
: Decodes the bit string value encoded at the start of the data stored in the variable called *dataVar*. The bit string is stored in the variable called *bitsVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. The value stored in *bitsVar* is a string that contains only **"0"** and **"1"** characters. If the value at the start is not an encoded bit string an error is thrown.

**::asn::asnGetObjectIdentifier** *dataVar* *oidVar*
: Decodes the object identifier (OID) value encoded at the start of the data stored in the variable called *dataVar*. The OID is stored in the variable called *oidVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. The value stored in *oidVar* is a list of integers. If the value at the start is not an encoded OID an error is thrown.

**::asn::asnGetBoolean** *dataVar* *boolVar*
: Decodes the Boolean value encoded at the start of the data stored in the variable called *dataVar*. The Boolean is stored in the variable called *boolVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. The value stored in *boolVar* is either **0** or **1**. If the value at the start is not an encoded Boolean an error is thrown.

**::asn::asnGetNull** *dataVar*
: Decodes the NULL value encoded at the start of the data stored in the variable called *dataVar* and removes the decoded bytes from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded NULL value an error is thrown.

**::asn::asnGetSequence** *dataVar* *sequenceVar*
: Decodes the ASN sequence value encoded at the start of the data stored in the variable called *dataVar*. The ASN sequence is stored in the variable called *sequenceVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded ASN sequence an error is thrown. The value in *sequenceVar* is encoded binary and must be further decoded according to the definition of the sequence, using the other decoder “asnGet…” commands.

**::asn::asnGetSet** *dataVar* *setVar*
: Decodes the ASN set value encoded at the start of the data stored in the variable called *dataVar*. The ASN set is stored in the variable called *setVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded ASN set an error is thrown. The value in *setVar* is encoded binary and must be further decoded according to the definition of the sequence, using the other decoder “asnGet…” commands.

**::asn::asnGetApplication** *dataVar* *appNumberVar* ?*contentVar*? ?*encodingTypeVar*?
: Decodes the ASN application construct value encoded at the start of the data stored in the variable called *dataVar*. The ASN application construct’s ID is stored in the variable called *appNumberVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded ASN application construct an error is thrown. If a *contentVar* is specified, then the command places all data associated with the ASN application construct into the named variable, in the binary form which can be processed using the this package’s decoder commands. If a *encodingTypeVar* is specified, then that variable is set to **1** if the encoding is constructed and **0** if it is primitive. Without the optional arguments, it is the responsibility of the caller to decode the remainder of the ASN application construct based on the ID retrieved by this command, using the package’s decoder commands.

**::asn::asnGetContext** *dataVar* *contextNumberVar* ?*contentVar*? ?*encodingTypeVar*?
: Decodes the ASN context tag construct encoded at the start of the data stored in the variable called *dataVar*. The ASN context tag construct’s ID is stored in the variable called *contextNumberVar*, and the decoded bytes are removed from the start of the data in *dataVar*, ready for the next value to be decoded. If the value at the start is not an encoded ASN context tag construct an error is thrown. If a *contentVar* is specified, then the command places all data associated with the ASN context tag construct into the named variable, in the binary form which can be processed using the this package’s decoder commands. If a *encodingTypeVar* is specified, then that variable is set to **1** if the encoding is constructed and **0** if it is primitive. Without the optional arguments, it is the responsibility of the caller to decode the remainder of the ASN context tag construct based on the ID retrieved by this command, using the package’s decoder commands.


## Handling tags

When working with ASN.1 you often need to decode tagged values which use a tag that’s different from a type’s universal tag. In these cases, to decode the value, you must replace the tag with the type’s universal tag. To decode a tagged value use **::asn::asnRetag** to change the tag to an appropriate type so that you can use one of the decoders for primitive values. To assist with this the package provides three helper functions:

**::asn::asnPeekTag** *dataVar* *tagVar* *tagtypeVar* *constrVar*
: The **::asn::asnPeekTag** command can be used to take a peek at the data and decode the tag value, without removing it from the data. The *tagVar* is set to the tag number. The *tagtypeVar* is set to the tag’s class, which is one of **UNIVERSAL**, **CONTEXT**, **APPLICATION**, or **PRIVATE**. The *constrVar* is set to 1 if the tag is for a constructed value, or to 0 for a primitive. The command returns the tag’s length.

**::asn::asnTag** *tagnumber* ?*class*? ?*tagstyle*?
: The **::asn::asnTag** command is used to create a tag value. The *tagnumber* specifies the tag’s number. If given, the tag’s *class* must be one of **UNIVERSAL**, **CONTEXT**, **APPLICATION**, or **PRIVATE**; or just the first letter as an abbreviation (**U**, **C**, **A**, or **P**.) The default class is **UNIVERSAL**. If given, the *tagstyle* must be either **C** or **1** for a constructed encoding, or **P** or **0** for a primitive encoding. The default is **P**. (The use of **1** and **0** makes it easy to use this command with the values returned by **::asn::asnPeekTag**.)

**::asn::asnRetag** *dataVar* *newTag*
: Replaces the tag at the start of the data in *dataVar* with *newTag*. The new tag can be created using the **::asn::asnTag** command.


# Examples

Examples that show this package in use can be found in the implementation of the **ldap** package.

When encoding text it is best to *avoid* **::asn::asnUTF8String** since in rare cases it may not work correctly. For pure 7-bit ASCII it is easiest to encode using **::asn::asnIA5String**. Outside the 7-bit ASCII range convert Tcl strings into UCS2 (i.e., utf-16le) and encode with **::asn::asnBMPString**. For decoding any string use **::asn::asnGetString**; however, for each UCS2 string, remember to convert it back to a Tcl string.

```
# Encode
set eflag [::asn::asnBoolean 1]
set etotal [::asn::asnInteger 734]
set line [encoding convertto utf-16le "€2 ÷ 3 → €⅔ ✔"]
set eline [::asn::asnBMPString $line]
set enote [::asn::asnIA5String "7-bit ASCII ~^"]
set encoded [::asn::asnSequence $eflag $etotal $eline $enote]
# Decode
::asn::asnGetSequence encoded sequence
::asn::asnGetBoolean sequence flag
::asn::asnGetInteger sequence total
::asn::asnGetString sequence bmp_line
set line [encoding convertfrom utf-16le $bmp_line]
::asn::asnGetString sequence note
puts "flag=$flag total=$total line='$line' note='$note'"
=>
flag=1 total=734 line='€2 ÷ 3 → €⅔ ✔' note='7-bit ASCII ~^'
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *asn* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
Copyright (c) 2004-2011 Michael Schlenker <mic42@users.sourceforge.net>
```
