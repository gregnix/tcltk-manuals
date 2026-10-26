---
CommandName: mime
title: mime
ManualSection: n
Version: 1.7.2
TclPart: tcllib
TclDescription: Mime
Links:
 - ftp
 - http
 - pop3
 - smtp
Keywords:
 - email
 - internet
 - mail
 - mime
 - net
 - rfc 2045
 - rfc 2046
 - rfc 2049
 - rfc 821
 - rfc 822
 - smtp
Copyright:
 - Copyright (c) 1999-2000 Marshall T. Rose
---

# Name

mime - Manipulation of MIME body parts

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [mime]{.lit} [1.7.2]{.optlit}
[::mime::initialize]{.cmd} [[-canonical]{.lit} [type/subtype]{.arg} ?-param {key value}...]{.optarg} [[-encoding]{.lit} [value]{.arg}]{.optarg} [[-header]{.lit} {key value}...]{.optarg} ([-file]{.lit} [name]{.arg} | [-string]{.lit} [value]{.arg} | [-parts]{.lit} [{token1 ... tokenN}]{.arg})
[::mime::finalize]{.cmd} [token]{.arg} [[-subordinates]{.lit} all | dynamic | none]{.optarg}
[::mime::getproperty]{.cmd} [token]{.arg} [property | -names]{.optarg}
[::mime::getheader]{.cmd} [token]{.arg} [key | -names]{.optarg}
[::mime::setheader]{.cmd} [token]{.arg} [key]{.arg} [value]{.arg} [[-mode]{.lit} write | append | delete]{.optarg}
[::mime::getbody]{.cmd} [token]{.arg} [-decode]{.optlit} [[-command]{.lit} [callback]{.arg} [[-blocksize]{.lit} [octets]{.arg}]{.optarg}]{.optarg}
[::mime::copymessage]{.cmd} [token]{.arg} [channel]{.arg}
[::mime::buildmessage]{.cmd} [token]{.arg}
[::mime::parseaddress]{.cmd} [string]{.arg}
[::mime::parsedatetime]{.cmd} ([string]{.arg} | [-now]{.lit}) [property]{.arg}
[::mime::mapencoding]{.cmd} [encoding\_name]{.arg}
[::mime::reversemapencoding]{.cmd} [charset\_type]{.arg}
:::

# Description

The **mime** library package provides the commands to create and manipulate MIME body parts.

**::mime::initialize** ?**-canonical** *type/subtype* ?**-param** {*key value*}...? ?**-encoding** *value*? ?**-header** {*key value*}...?? (**-file** *name* | **-string** *value* | **-parts** {*token1* ... *tokenN*})
: Creates a MIME part and returns a token representing it.

    - If the **-canonical** option is present, then the body is in canonical (raw) form and is found by consulting either the **-file**, **-string**, or **-parts** option.

        In addition, both the **-param** and **-header** options may occur zero or more times to specify **Content-Type** parameters (e.g., **charset**) and header keyword/values (e.g., **Content-Disposition**), respectively.

        Also, **-encoding**, if present, specifies the **Content-Transfer-Encoding** when copying the body.

    - If the **-canonical** option is not present, then the MIME part contained in either the **-file** or the **-string** option is parsed, dynamically generating subordinates as appropriate.


**::mime::finalize** *token* ?**-subordinates** **all** | **dynamic** | **none**?
: Destroys the MIME part represented by *token*. It returns an empty string.

    If the **-subordinates** option is present, it specifies which subordinates should also be destroyed. The default value is **dynamic**, destroying all subordinates which were created by **::mime::initialize** together with the containing body part.

**::mime::getproperty** *token* ?*property* | **-names**?
: Returns a string or a list of strings containing the properties of a MIME part. If the command is invoked with the name of a specific property, then the corresponding value is returned; instead, if **-names** is specified, a list of all properties is returned; otherwise, a serialized array of properties and values is returned.

    The possible properties are:

    **content**
    : The type/subtype describing the content

    **encoding**
    : The "Content-Transfer-Encoding"

    **params**
    : A list of "Content-Type" parameters

    **parts**
    : A list of tokens for the part's subordinates.  This property is present only if the MIME part has subordinates.

    **size**
    : The approximate size of the content (unencoded)


**::mime::getheader** *token* ?*key* | **-names**?
: Returns the header of a MIME part as a dictionary with possibly-redundant keys.

    If *key* is provided, then a list of values of matching names, without regard to case, is returned.

    If **-names** is provided, a list of all keys is returned.

**::mime::setheader** *token* *key value* ?**-mode** **write** | **append** | **delete**?
: If **append** is provided, creates a new header named *key* with the value of *value* is added. If **write** is provided, deletes any existing headers whose names match *key* and then creates a new header named *key* with the value of *value*. If **delete** is provided any existing header having a name that matches *key* is deleted. Returns a list of strings containing the previous value associated with the key.

    The value for **-mode** is one of:

    **write**
    : The *key*/*value* is either created or overwritten (the default).

    **append**
    : A new *value* is appended for the *key* (creating it as necessary).

    **delete**
    : All values associated with the key are removed (the *value* parameter is ignored).


**::mime::getbody** *token* ?**-decode**? ?**-command** *callback* ?**-blocksize** *octets*??
: Returns a string containing the body of the leaf MIME part represented by *token* in canonical form.

    If the **-command** option is present, then it is repeatedly invoked with a fragment of the body as this:

    ```
      uplevel #0 $callback [list "data" $fragment]
    ```

    (The **-blocksize** option, if present, specifies the maximum size of each fragment passed to the callback.)

    When the end of the body is reached, the callback is invoked as:

    ```
        uplevel #0 $callback "end"
    ```

    Alternatively, if an error occurs, the callback is invoked as:

    ```
        uplevel #0 $callback [list "error" reason]
    ```

    Regardless, the return value of the final invocation of the callback is propagated upwards by **::mime::getbody**.

    If the **-command** option is absent, then the return value of **::mime::getbody** is a string containing the MIME part's entire body.

    If the option **-decode** is absent the return value computed above is returned as is. This means that it will be in the charset specified for the token and not the usual utf-8. If the option **-decode** is present however the command will use the charset information associated with the token to convert the string from its encoding into utf-8 before returning it.

**::mime::copymessage** *token* *channel*
: Copies the MIME represented by *token* part to the specified *channel*. The command operates synchronously, and uses fileevent to allow asynchronous operations to proceed independently. It returns an empty string.

**::mime::buildmessage** *token*
: Returns the MIME part represented by *token* as a string.  It is similar to **::mime::copymessage**, only it returns the data as a return string instead of writing to a channel.

**::mime::parseaddress** *string*
: Takes a string containing one or more 822-style address specifications and returns a list of serialized arrays, one element for each address specified in the argument. If the string contains more than one address they will be separated by commas.

    Each serialized array contains the properties below. Note that one or more of these properties may be empty.

    **address**
    : local@domain

    **comment**
    : 822-style comment

    **domain**
    : the domain part (rhs)

    **error**
    : non-empty on a parse error

    **group**
    : this address begins a group

    **friendly**
    : user-friendly rendering

    **local**
    : the local part (lhs)

    **memberP**
    : this address belongs to a group

    **phrase**
    : the phrase part

    **proper**
    : 822-style address specification

    **route**
    : 822-style route specification (obsolete)


**::mime::parsedatetime** (*string* | **-now**) *property*
: Takes a string containing an 822-style date-time specification and returns the specified property as a serialized array.

    The list of properties and their ranges are:

    **hour**
    : 0 .. 23

    **lmonth**
    : January, February, ..., December

    **lweekday**
    : Sunday, Monday, ... Saturday

    **mday**
    : 1 .. 31

    **min**
    : 0 .. 59

    **mon**
    : 1 .. 12

    **month**
    : Jan, Feb, ..., Dec

    **proper**
    : 822-style date-time specification

    **rclock**
    : elapsed seconds between then and now

    **sec**
    : 0 .. 59

    **wday**
    : 0 .. 6 (Sun .. Mon)

    **weekday**
    : Sun, Mon, ..., Sat

    **yday**
    : 1 .. 366

    **year**
    : 1900 ...

    **zone**
    : -720 .. 720 (minutes east of GMT)


**::mime::mapencoding** *encoding\_name*
: Maps tcl encodings onto the proper names for their MIME charset type.  This is only done for encodings whose charset types were known.  The remaining encodings return "" for now.

**::mime::reversemapencoding** *charset\_type*
: Maps MIME charset types onto tcl encoding names.  Those that are unknown return "".


# Known bugs

Tcllib Bug #447037
: This problem affects only people which are using Tcl and Mime on a 64-bit system. The currently recommended fix for this problem is to upgrade to Tcl version 8.4. This version has extended 64 bit support and the bug does not appear anymore.

    The problem could have been generally solved by requiring the use of Tcl 8.4 for this package. We decided against this solution as it would force a large number of unaffected users to upgrade their Tcl interpreter for no reason.

    See *Ticket 447037* \[/tktview?name=447037\] for additional information.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *mime* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing

# Copyright

```
Copyright (c) 1999-2000 Marshall T. Rose
```
