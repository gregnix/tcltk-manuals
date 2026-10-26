---
CommandName: bee
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: BitTorrent
Keywords:
 - BitTorrent
 - bee
 - bittorrent
 - serialization
 - torrent
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bee - BitTorrent Serialization Format Encoder/Decoder

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [bee]{.lit} [0.3]{.optlit} 
[::bee::encodeString]{.cmd} [string]{.arg} 
[::bee::encodeNumber]{.cmd} [integer]{.arg} 
[::bee::encodeListArgs]{.cmd} [beevalue]{.optdot} 
[::bee::encodeList]{.cmd} [listofbees]{.arg} 
[::bee::encodeDictArgs]{.cmd} [key beevalue]{.optdot} 
[::bee::encodeDict]{.cmd} [dictofbees]{.arg} 
[::bee::decode]{.cmd} [beestring]{.arg} [endVar]{.optarg} [start]{.optarg} 
[::bee::decodeIndices]{.cmd} [beestring]{.arg} [endVar]{.optarg} [start]{.optarg} 
[::bee::decodeChannel]{.cmd} [chan]{.arg} [-command]{.lit} [on_decode]{.arg} [-exact]{.optlit} [-prefix data]{.optarg} 
[on_decode]{.cmd} [value]{.sub} [handle]{.arg} [value]{.arg} 
[on_decode]{.cmd} [error]{.sub} [handle]{.arg} [message]{.arg} 
[on_decode]{.cmd} [eof]{.sub} [handle]{.arg} 
[::bee::decodeCancel]{.cmd} [handle]{.arg} 
[::bee::decodePush]{.cmd} [handle]{.arg} [string]{.arg} 
:::

# Description

This package provides encoding and decoding commands for data in Bencode (spoken as “bee-encode”), the BitTorrent protocol’s serialization format used for data and messages.

# Api

## Encoder

This package provides an encoder command for each value type (string and integer), and two commands per collection type (list and dict), one taking a complete Tcl collection to encode, the other taking the same data given as arguments.

**::bee::encodeString** *string*
: Returns the bee-encoding of the *string*.

**::bee::encodeNumber** *integer*
: Returns the bee-encoding of the *integer* number. This command will throw an error if *integer* is not an integer.

**::bee::encodeListArgs** ?*beevalue ...*?
: Returns a bee-encoded list of the given zero or more bee-encoded *beevalue*s.

**::bee::encodeList** *listofbees*
: Returns a bee-encoded list of the given Tcl list, *listofbees*, of bee-encoded values.

**::bee::encodeDictArgs** ?*key beevalue ...*?
: Returns a bee-encoded dict of the given zero or more pairs of Tcl string keys and bee-encoded *beevalue*s. This command will bee-encode each string key itself.

**::bee::encodeDict** *dictofbees*
: Returns a bee-encoded dict of the given Tcl dict, *dictofbees*, whose keys must be Tcl strings and whose values must be bee-encoded values. This command will bee-encode each string key itself.


## Decoder

This package provides decoding commands for bee-encoded strings and for bee-encoded data received over a channel.

The commands for decoding a bee-encoded string expect the string to contain one or more complete bee-encoded values (which may themselves contain nested bee-encoded lists and dicts).

The command for the incremental decoding of bee-values arriving on a channel is asynchronous and provides the completed decoded values via a callback.

**::bee::decode** *beestring* ?*endVar*? ?*start*?
: Returns a bee-decoded value from the *beestring*, starting from index position *start* if given—or from its default of **0**, and sets *endVar* if given. If the bee-encoded value is a string or integer, the equivalent Tcl string or integer is returned. If the bee-encoded value is a collection (a bee-list or a bee-dict), then a corresponding Tcl list or Tcl dict is returned. And in either of these cases, all contained values (including nested bee-lists and bee-dicts) are all bee-decoded, so that the result is a Tcl list or dict with all the nested values fully bee-decoded into Tcl lists, dicts, strings, or integers, as appropriate. If the option *endVar* is given, it is the name of a variable used to store the index position of the first character in the *beestring* that *follows* the value that’s just been decoded, i.e., the start position of the next value to decode. This is useful if the *beestring* contains two or more bee-encoded values concatenated together (as opposed to a single bee-encoded list of bee-encoded values). See the last example in the **Examples**. The optional *start* is the index position from which the next bee-encoded value will be read and decoded.

**::bee::decodeIndices** *beestring* ?*endVar*? ?*start*?
: Returns a list based on the bee-decoded value from the *beestring*, starting from index position *start* if given—or from its default of **0**, and sets *endVar* if given. The meaning and use of *endVar* and *start* are exactly the same as for **::bee::decode**. The returned list’s elements depend on the type of the bee-decoded value. In all cases though, the first element is a type name (one of **string** **integer** **list** **dict**), and the second and third elements are the start and end index positions in the *beestring* for the bee-encoded value. For bee-lists and bee-dicts there is a fourth element which provides details of their contained bee-values. Formally the result lists for the various types of bee-values are:


**string**
: A list containing three elements:


**•**
: A constant string indicating the value’s type, for strings it is **string**.

**•**
: The index position (*>= 0*) of the first character of the bee-value in the given *beestring*.

**•**
: The index position (*>= 0*) of the last character of the bee-value in the given *beestring*.


*Every result list, for every bee-value, begins with these three elements.*

**integer**
: A list containing the constant string **integer** and—just the same as for strings—the start and end index positions of the bee-value in the *beestring*.

**list**
: A list containing the constant string **list** and—just the same as for strings—the start and end index positions of the bee-value in the *beestring*. In addition the list has a fourth element, which itself contains the index data as described here for all the elements of the bee-list.

**dictionary**
: A list containing the constant string **dict** and—just the same as for strings—the start and end index positions of the bee-value in the *beestring*. In addition the dict has a fourth element. This element is a dictionary mapping from each of the bee-dict’s string keys to a 2-element list of 2-element lists. The list’s first element’s list contains the index positions for the key, and the second element’s list contains the index positions for the value the key maps to. This structure is the only one which contains not only index positions, but actual values from the *beestring*. While each key’s index positions are unique, i.e., usable as a key, they are not easy to navigate when trying to find a particular element. Using actual keys makes navigation much easier, which is why they’re provided.


**::bee::decodeChannel** *chan* **-command** *on_decode* ?**-exact**? ?**-prefix** *data*?
: This command creates a decoder for a series of bee-values arriving on the channel *chan* and returns a decoder handle. Each decoding event is reported to the required *on_decode* callback command. The returned handle can be used to push data into the decoder or to cancel the decoder. Attempting to create another bee decoder on the *chan* channel while an existing bee decoder is still active will throw an error.


**-command**
: The *on_decode* command specified by the *required* option **-command** is used to report decoded values, errors, and channel EOF. The callback is executed at the interpreter’s global level, with two or three arguments. The possible callback signatures are:


**on_decode** **value** *handle* *value*
: The decoder received and successfully decoded a bee-value. The format of the equivalent Tcl *value* is the same as returned by **::bee::decode**. The channel is still open and the decoder handle is valid. This means that the callback is able to push data into the decoder or to cancel the decoder.

**on_decode** **error** *handle* *message*
: The decoder encountered an error, which is not EOF. For example, an invalid bee-value. The *message* provides details about the error. The decoder handle is in the same state as for EOF, i.e., invalid, and cannot be used. However, the channel remains open.

**on_decode** **eof** *handle*
: The decoder has reached EOF on the *chan* channel. No further calls to the callback will be made after this. The channel has already been closed at the time of the call, and the *handle* is invalid and cannot be used.


**-exact**
: By default the decoder assumes that all the channel’s data consists of bee-values, and reads as much as possible per event, without regard for boundaries between bee-values. This means that if the the channel contains non-bee data after a series of bee-values, the beginning of any non-bee data may be lost, because it has already been read by the decoder, but not processed. In such cases use the **-exact** option. When this is specified, the decoder will not read any characters beyond the currently processed bee-value, so that any non-bee data is left in the channel for further processing after the decoder is closed.

**-prefix**
: If this option is specified its value is assumed to be the beginning of a bee-value and is used to initialize the decoder’s internal buffer. This feature is required if the creator of the decoder read data from the channel to determine if it should create the decoder or not. Without the option this initial data would be lost to the decoding.


**::bee::decodeCancel** *handle*
: This command cancels the decoder set up by **::bee::decodeChannel** and represented by the handle *handle*.

**::bee::decodePush** *handle* *string*
: This command appends the *string* to the decoder’s internal buffer. It is the runtime equivalent of the **::bee::decodeChannel** command’s **-prefix** option. Use this command to push data back into the decoder when the **on_decode value** callback used data from the channel to determine if it should decode another bee-value or not.


# Format definition

Data in the Bencode serialization format is constructed from two basic forms, and two collection forms. The basic forms are strings and integerss, and the collections are lists and dictionaries.

String *S*
: A string *S* of length *L* is encoded by the string "*L*__:__*S*", where the length is in textual form. For example, the string **"Bencode format"** would be encoded as **"14:Bencode format"**.

Integer *N*
: An integer *N* is encoded by the string "**i**_N_**e**". For example, the integer **-482** would be encoded as **"i-482e"**.

List *v1* ... *vn*
: A list of the values *v1* to *vn* is encoded by the string "**l**_BV1_...*BVn*__e__" where "BV**i**" is the bee-encoding of the value "v**i**".

Dict *k1* -> *v1* ...
: A dictionary mapping the string key *k*__i__ to the value *v*__i__, for **i** in **1** ... **n** is encoded by the string "**d**_BK_**i**_BV_**i**...**e**" for i in **1** ... **n**, where "BK**i**" is the bee-encoding of the key string "k**i**".  and "BV**i**" is the bee-encoding of the value "v**i**". *Note*: The bee-encoding does not preserve the order of the keys in the input, but stores in key-sorted order. Note that the type of each encoded item can be determined immediately from the first character of its encoding:

**i**
: Integer.

**l**
: List.

**d**
: Dictionary.

**\[0-9\]**
: String. By prefixing integers with **i** the format ensures that they are different from strings, which all begin with a digit.


# Examples

This example shows how to bee-encode and bee-decode individual strings and integers.

```
const LABEL "Δ÷ “Utf-8” ♞ℤ"
set labelbeeEnc [::bee::encodeString $LABEL]
set labelbeeDec [::bee::decode $labelbeeEnc]
puts "labelbeeEnc='$labelbeeEnc' eq LABEL → [expr {$labelbeeDec eq $LABEL}]"
set xbeeEnc [::bee::encodeNumber 834]
set ybeeEnc [::bee::encodeNumber -172]
set ybeeDec [::bee::decode $ybeeEnc]
puts "ybeeEnc='$ybeeEnc' == -172 → [expr {$ybeeDec == -172}]"
=>
labelbeeEnc='13:Δ÷ “Utf-8” ♞ℤ' eq LABEL → 1
ybeeEnc='i-172e' == -172 → 1
```

This example shows how to bee-encode collections of bee-encoded values.

```
set pointbeeEnc [::bee::encodeList [list $xbeeEnc $ybeeEnc]]
set placebeeEnc [::bee::encodeDictArgs label $labelbeeEnc point $pointbeeEnc]
puts "pointbeeEnc='$pointbeeEnc'"
puts "placebeeEnc='$placebeeEnc'"
=>
pointbeeEnc='li834ei-172ee'
placebeeEnc='d5:label13:Δ÷ “Utf-8” ♞ℤ5:pointli834ei-172eee'
```

This example shows how to bee-decode collections of bee-encoded values.

```
set placebeeDec [::bee::decode $placebeeEnc]
set label [dict get $placebeeDec label]
puts "label='$label' eq LABEL → [expr {$label eq $LABEL}]"
lassign [dict get $placebeeDec point] x y
puts "x=$x == 834 → [expr {$x == 834}] • y=$y == -172 → [expr {$y == -172}]"
=>
label='Δ÷ “Utf-8” ♞ℤ' eq LABEL → 1
x=834 == 834 → 1 • y=-172 == -172 → 1
```

This example shows how to bee-decode using the **::bee::decodeIndices** command.

```
set labelbeeDecInd [::bee::decodeIndices $labelbeeEnc]
lassign $labelbeeDecInd type i j
set label [::bee::decode [string range $labelbeeEnc $i $j]]
puts "labelbeeDecInd type=$type i=$i j=$j label='$label'"
=>
labelbeeDecInd type=string i=0 j=15 label='Δ÷ “Utf-8” ♞ℤ'
```

This example shows how to bee-encode and then bee-decode a sequence of *separate* bee-encoded values.

```
set stream [::bee::encodeString "€⅔•"][::bee::encodeNumber -91][::bee::encodeString "α-ω"][::bee::encodeNumber 68]
for {set i 0} {$i < [string length $stream]} {} {
    lappend items [::bee::decode $stream i $i]
}
puts "stream='$stream' items={$items} size=[llength $items]"
=>
stream='3:€⅔•i-91e3:α-ωi68e' items={€⅔• -91 α-ω 68} size=4
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *bee* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
