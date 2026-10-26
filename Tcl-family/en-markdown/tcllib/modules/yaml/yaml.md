---
CommandName: yaml
title: yaml
ManualSection: n
Version: 0.4.2
TclPart: tcllib
TclDescription: YAML processing
Links:
 - base64
 - huddle
 - json
Keywords:
 - data exchange
 - huddle
 - parsing
 - text processing
 - yaml
Copyright:
 - Copyright (c) 2008 KATO Kanryu <kanryu6@users.sourceforge.net>
---

# Name

yaml - YAML Format Encoder/Decoder

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [yaml]{.lit} [0.4.2]{.optlit}
[::yaml::yaml2dict]{.cmd} [options]{.optarg} [txt]{.arg}
[::yaml::yaml2huddle]{.cmd} [options]{.optarg} [txt]{.arg}
[::yaml::setOption]{.cmd} [options]{.optarg}
[::yaml::dict2yaml]{.cmd} [dict]{.arg} [indent]{.optarg} [wordwrap]{.optarg}
[::yaml::list2yaml]{.cmd} [list]{.arg} [indent]{.optarg} [wordwrap]{.optarg}
[::yaml::huddle2yaml]{.cmd} [huddle]{.arg} [indent]{.optarg} [wordwrap]{.optarg}
:::

# Description

The **yaml** package provides a simple Tcl-only library for parsing the YAML <http://www.yaml.org/> data exchange format as specified in <http://www.yaml.org/spec/1.1/>.

The **yaml** package returns data as a Tcl **dict**.  Either the **dict** package or Tcl 8.5 is required for use.

# Commands

**::yaml::yaml2dict** ?*options*? *txt*
: see below ...

**::yaml::yaml2huddle** ?*options*? *txt*
: Parse yaml formatted text *txt* into a Tcl dict/huddle and return the value.

    **-file**
    : *txt* is a filename of YAML-stream.

    **-stream**
    : *txt* is just a YAML-stream.

    **-types** *list*
    : The *list* is a type list for the yaml-scalar types.(e.g. !!str !!timestamp !!integer !!true ...)

        ```
         -types {timestamp integer null true false}
        ```

        In this case, if a string matched "timestamp", converted to the TCL internal timestamp.(e.g. "2001-12-15T02:59:43.1Z" => 1008385183)

    **-m:true** *param*
    : The *param* is two elements of list for the value of true, and considered strings.

        ```
         -m:true {1 {true on + yes y}}
        ```

        In this case, the string "yes" found in YAML Stream, automatically converted 1.

    **-m:false** *param*
    : The *param* is two elements of list for the value of false, and considered strings.

        ```
         -m:false {0 {false off - no n}}
        ```

    **-m:null** *param*
    : The *param* is two elements of list for the value of null, and considered strings.

        ```
         -m:null {"" {null nil "" ~}}
        ```

    **-validate**
    : Experiment,old: Output stream contains YAML's-tag, each node.

        ```
        % puts [::yaml::load -validate {[aaa, bbb]}]
        =>
        !!seq {{!!str aaa} {!!str bbb}}
        ```


**::yaml::setOption** ?*options*?
: Change implicit options for the library. Now, the params are the same as **::yaml::yaml2dict**. Arguments of**::yaml::yaml2dict** is more priority than this setting.

**::yaml::dict2yaml** *dict* ?*indent*? ?*wordwrap*?
: see below ...

**::yaml::list2yaml** *list* ?*indent*? ?*wordwrap*?
: see below ...

**::yaml::huddle2yaml** *huddle* ?*indent*? ?*wordwrap*?
: Convert a dict/list/huddle object into YAML stream.

    indent
    : spaces indent of each block node. currently default is 2.

    wordwrap
    : word wrap for YAML stream. currently default is 40.



# Examples

An example of a yaml stream converted to Tcl.  A yaml stream is returned as a single item with multiple elements.

```
{
--- !<tag:clarkevans.com,2002:invoice>
invoice: 34843
date   : 2001-01-23
bill-to: &id001
    given  : Chris
    family : Dumars
    address:
        lines: |
            458 Walkman Dr.
            Suite #292
        city    : Royal Oak
        state   : MI
        postal  : 48046
ship-to: *id001
product:
    - sku         : BL394D
      quantity    : 4
      description : Basketball
      price       : 450.00
    - sku         : BL4438H
      quantity    : 1
      description : Super Hoop
      price       : 2392.00
tax  : 251.42
total: 4443.52
comments:
    Late afternoon is best.
    Backup contact is Nancy
    Billsmer @ 338-4338.
}
=>
invoice 34843 date 2001-01-23 bill-to {given Chris family Dumars address {lines {458 Walkman Dr.
Suite #292
} city {Royal Oak} state MI postal 48046}} ship-to {given Chris family Dumars address {lines {458 Walkman Dr.
Suite #292
} city {Royal Oak} state MI postal 48046}} product {{sku BL394D quantity 4 description Basketball price 450.00} {sku BL4438H quantity 1 description {Super Hoop} price 2392.00}} tax 251.42 total 4443.52 comments {Late afternoon is best. Backup contact is Nancy Billsmer @ 338-4338.}
```

An example of a yaml object converted to Tcl.  A yaml object is returned as a multi-element list (a dict).

```
{
---
- [name        , hr, avg  ]
- [Mark McGwire, 65, 0.278]
- [Sammy Sosa  , 63, 0.288]
-
  Mark McGwire: {hr: 65, avg: 0.278}
  Sammy Sosa: { hr: 63, avg: 0.288}
}
=>
{name hr avg} {{Mark McGwire} 65 0.278} {{Sammy Sosa} 63 0.288} {{Mark McGwire} {hr 65 avg 0.278} {Sammy Sosa} {hr 63 avg 0.288}}
```

# Limitations

tag parser not implemented. currentry, tags are merely ignored.

Only Anchor => Aliases ordering. back alias-referring is not supported.

Too many braces, or too few braces.

Not enough character set of line feeds. Please use only "\\n" as line breaks.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *yaml* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Copyright

```
Copyright (c) 2008 KATO Kanryu <kanryu6@users.sourceforge.net>
```
