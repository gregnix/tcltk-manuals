---
CommandName: json
ManualSection: n
Version: 1.3.6
TclPart: tcllib
TclDescription: JSON
Keywords:
 - data exchange
 - exchange format
 - javascript
 - json
Copyright:
 - Copyright (c) 2006 ActiveState Software Inc.
 - Copyright (c) 2009 Thomas Maeder, Glue Software Engineering AG
---

# Name

json - JSON parser

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [json]{.lit} [1.3.6]{.optlit} 
[::json::json2dict]{.cmd} [json_txt]{.arg} 
[::json::many-json2dict]{.cmd} [json_txt]{.arg} [max]{.optarg} 
:::

# Description

The **json** package provides a simple Tcl-only library for parsing the [JSON](http://www.json.org/) data exchange format as specified in [RFC 4627](http://www.ietf.org/rfc/rfc4627.txt). There is some ambiguity in parsing JSON because JSON has type information that is not maintained by this module's conversion. Furthermore, JSON **null** values are converted to the string literal "null" (see [ticket](https://core.tcl-lang.org/tcllib/tktview/2aa0cebb88)). The **json** package returns data either as a Tcl **dict** or a **list** which itself may contain nested **dict**s or **list**s. (Either the **dict** package or Tcl 8.5 or later is required for use.)

For an alternative Tcl-only type-preserving implementation, see the [typed-json](https://wiki.tcl-lang.org/page/typed-json) module.

# Commands

**::json::json2dict** *json_txt*
: Returns a **dict** or **list** (which itself may contain nested **dict**s and/or **list**s) which is the result of parsing the JSON formatted text passed in *json_txt*. If *json_txt* contains more than one JSON entity only the first one is returned.

**::json::many-json2dict** *json_txt* ?*max*?
: Returns a **list** (which itself will contain nested **dict**s and/or **list**s) which is the result of parsing all the JSON entities (or if *max* is specified, the first *max* entities), in the JSON formatted text passed in *json_txt*. If *max* is specified it must be a positive integer **> 0** or the command will throw and error. If the JSON formatted text contains nested lists and dicts then so will the returned dict. In such cases accessing a data value may require a *mixture* of using dict get and lindex. (See the second example.)


# Examples

An example of a JSON array converted to Tcl.  A JSON array is returned as a single item with multiple elements.

```
[
    {
       "precision": "zip",
       "Latitude":  37.7668,
       "Longitude": -122.3959,
       "Address":   "",
       "City":      "SAN FRANCISCO",
       "State":     "CA",
       "Zip":       "94107",
       "Country":   "US"
    },
    {
       "precision": "zip",
       "Latitude":  37.371991,
       "Longitude": -122.026020,
       "Address":   "",
       "City":      "SUNNYVALE",
       "State":     "CA",
       "Zip":       "94085",
       "Country":   "US"
    }
]
=>
{Country US Latitude 37.7668 precision zip State CA City {SAN FRANCISCO} Address {} Zip 94107 Longitude -122.3959} {Country US Latitude 37.371991 precision zip State CA City SUNNYVALE Address {} Zip 94085 Longitude -122.026020}
```

An example of a JSON dict which contains an entry whose value is a list of dicts.

```
{
  "items": [
     {
      "snippet": {
        "title": "In The Shade",
        "channelTitle": "Flox - Topic"
      },
      "statistics": {
        "viewCount": "274"
      }
    }
  ]
}
=>
items {{snippet {title {In The Shade} channelTitle {Flox - Topic}} statistics {viewCount 274}}}
```

Assuming that the JSON formatted text is in variable **jdata**, it can be converted to a **dict** and elements extracted.

```
set d [json::json2dict $jdata]
set title [dict get [lindex [dict get $d items] 0] snippet title]
=>
In The Shade
```

An example of a JSON object converted to Tcl.  A JSON object is returned as a multi-element list (a dict).

```
{
    "Image": {
        "Width":  800,
        "Height": 600,
        "Title":  "View from 15th Floor",
        "Thumbnail": {
            "Url":    "http://www.example.com/image/481989943",
            "Height": 125,
            "Width":  "100"
        },
        "IDs": [116, 943, 234, 38793]
    }
}
=>
Image {IDs {116 943 234 38793} Thumbnail {Width 100 Height 125 Url http://www.example.com/image/481989943} Width 800 Height 600 Title {View from 15th Floor}}
```

# Related

To write json, instead of parsing it, see package **json::write**.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *json* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

CGI programming

# Copyright

```
Copyright (c) 2006 ActiveState Software Inc.
Copyright (c) 2009 Thomas Maeder, Glue Software Engineering AG
```
