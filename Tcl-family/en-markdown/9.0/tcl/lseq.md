---
CommandName: lseq
title: lseq
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - foreach(n)
 - list(n)
 - lappend(n)
 - lassign(n)
 - lindex(n)
 - linsert(n)
 - llength(n)
 - lmap(n)
 - lpop(n)
 - lrange(n)
 - lremove(n)
 - lreplace(n)
 - lreverse(n)
 - lsearch(n)
 - lset(n)
 - lsort(n)
Keywords:
 - element
 - index
 - list
Copyright:
 - Copyright (c) 2022 Eric Taylor. All rights reserved.
---

# Name

lseq - Build a numeric sequence returned as a list

# Synopsis

::: {.synopsis} :::
[lseq]{.cmd} [start]{.arg} [(..|to)]{.optarg} [end]{.arg} [?by]{.optarg} [step?]{.arg}
[lseq]{.cmd} [start]{.arg} [count]{.lit} [count]{.arg} [?by]{.optarg} [step?]{.arg}
[lseq]{.cmd} [count]{.arg} [[by]{.lit} [step]{.arg}]{.optarg}
:::

# Description

The **lseq** command creates a sequence of numeric values, which may be either wide integers or doubles, using the given parameters *start*, *end*, and *step*. The *operation* argument "**..**" or "**to**" defines the range. The "**count**" option is used to define a count of the number of elements in the list. A short form use of the command, with a single count value, will create a range from 0 to *count*-1.

The **lseq** command can produce both increasing and decreasing sequences. When both *start* and *end* are provided without a *step* value, then if *start* <= *end*, the sequence will be increasing and if *start* > *end* it will be decreasing. If a *step* value is included, it's sign should agree with the direction of the sequence (descending → negative and ascending → positive), otherwise the list will have a length of 0.  For example:

```
# increasing:
% lseq 1 to 5
→ 1 2 3 4 5

# decreasing:
% lseq 5 to 1
→ 5 4 3 2 1

# doubles:
% lseq 0 0.5 by 0.1
→ 0.0 0.1 0.2 0.3 0.4 0.5

# decreasing, step with wrong sign:
% lseq 6 to 1 by 2
→ {}

# step of 0,
% lseq 3 to 9 by 0
→ 3
```

*Start* defines the initial value and *end* defines the limit, not necessarily the last value. **lseq** produces a list with *count* elements, always, even if the step value is 0. and if *count* is not supplied, it is computed as:

```
count = int( ( (end - start) / step ) + 1 )
```

# Examples

```
lseq 3
→ 0 1 2

lseq 3 0
→ 3 2 1 0

lseq 10 .. 1 by -2
→ 10 8 6 4 2

set l [lseq 0 -5]
→ 0 -1 -2 -3 -4 -5

lseq 1 count 5 by 0
→ 1 1 1 1 1

foreach i [lseq [llength $l]] {
    puts l($i)=[lindex $l $i]
}
→ l(0)=0
→ l(1)=-1
→ l(2)=-2
→ l(3)=-3
→ l(4)=-4
→ l(5)=-5

foreach i [lseq {[llength $l]-1} 0] {
    puts l($i)=[lindex $l $i]
}
→ l(5)=-5
→ l(4)=-4
→ l(3)=-3
→ l(2)=-2
→ l(1)=-1
→ l(0)=0

set i 17
→ 17

if {$i in [lseq 0 50]} { # equivalent to: (0 <= $i && $i <= 50)
    puts "Ok"
} else {
    puts "outside :("
} → Ok

set sqrs [lmap i [lseq 1 10] { expr {$i*$i} }]
→ 1 4 9 16 25 36 49 64 81 100
```
