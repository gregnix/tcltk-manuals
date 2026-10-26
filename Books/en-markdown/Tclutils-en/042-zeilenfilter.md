# More Line Filters

This chapter continues [Text and Files](040-text-und-dateien.md).
The modules here number, wrap, align, reverse, count and generate
lines. Each has a Unix counterpart from coreutils or util-linux; the
differences are listed with each module. No module starts a program.

All options go through the same parser. An unknown option throws
`{TCLUTILS COMMON OPTION -name}` and lists the known options in the
message. An integer below 1 where a positive one is required throws
`{TCLUTILS COMMON INTEGER -name}`, a value that is not a boolean
`{TCLUTILS COMMON BOOLEAN -name}`. These three codes are not repeated
for every module below.

`file` reads the file with the system encoding and converts `\r\n` to
`\n`. Whether a trailing `\n` is kept depends on the module:

| Trailing `\n` | Modules |
|---|---|
| kept | `tunl`, `tutac`, `turev`, `tuexpand`, `tutr` |
| dropped | `tufold`, `tufmt`, `tucolumn`, `tushuf`, `tupr` |

---

## Numbering lines: tunl

[tunl]{.index} numbers lines like Unix `nl`.

```tcl
::tclutils::tunl::text text ?option wert ...?
::tclutils::tunl::file pfad ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-style` | `nonempty` | `all` every line, `nonempty` only lines with content, `none` none |
| `-start` | 1 | first number |
| `-increment` | 1 | step |
| `-width` | 6 | digits of the number, right-aligned |
| `-separator` | `\t` | between number and line |

A line without a number starts with `-width` spaces and the
separator. Unix `nl` writes only spaces for an empty line, without a
tab. A trailing `\n` is kept and does not produce a line of its own.
An empty text yields `""`.

`-start` and `-increment` are integers, also negative and of any
size. `-width` is an integer of at least 1.

| Error | `-errorcode` |
|---|---|
| `-style` other than `all`, `nonempty`, `none` | `{TCLUTILS TUNL STYLE}` |
| `-start` not an integer | `{TCLUTILS TUNL START}` |
| `-increment` not an integer | `{TCLUTILS TUNL INCREMENT}` |
| `-width` not an integer of at least 1 | `{TCLUTILS TUNL WIDTH}` |

```tcl
package require tclutils::tunl
::tclutils::tunl::text "a\n\nb" -width 2 -separator " "
                                          ;# -> " 1 a\n   \n 2 b"
::tclutils::tunl::text "a\n\nb" -style all -width 2 -separator " "
                                          ;# -> " 1 a\n 2 \n 3 b"
::tclutils::tunl::text "a\nb" -start 10 -increment 5 \
    -width 2 -separator ": "              ;# -> 10: a\n15: b
```

`tucat -number 1` from [Text and Files](040-text-und-dateien.md), by
contrast, always numbers with six digits and a tab.

---

## Wrapping: tufold and tufmt

[tufold]{.index} wraps each line on its own, like Unix `fold`.
[tufmt]{.index} joins paragraphs and wraps them anew, like Unix
`fmt`.

```tcl
::tclutils::tufold::foldLine zeile ?-width n? ?-words 0|1?
::tclutils::tufold::text     text  ?-width n? ?-words 0|1?
::tclutils::tufold::file     pfad  ?-width n? ?-words 0|1?
::tclutils::tufmt::reflow     text ?-width n?
::tclutils::tufmt::reflowFile pfad ?-width n?
```

| Option | Default | Effect |
|---|---|---|
| `tufold -width` | 80 | at most this many characters per line |
| `tufold -words` | 0 | 1 breaks at the last space before the limit |
| `tufmt -width` | 75 | target width of the paragraphs |

`foldLine` returns a list of the partial lines, `text` and `file` a
string. The width counts characters, not screen columns: a tab is one
character. Without `-words`, `tufold` cuts hard after `-width`
characters; a space at the cut stays at the end of the line. With
`-words 1`, `tufold` breaks at the last space up to column `-width`
plus one. All spaces at the break are dropped, both at the end of the
line and at the start of the next line. Unix `fold -s` keeps them:
from `"ab   cd"` with width 3 it makes `"ab "`, `"  "` and `"cd"`,
whereas `tufold` makes `ab` and `cd`. A word longer than `-width` is
cut hard even with `-words 1`. Empty lines stay empty.

`tufmt` separates paragraphs at empty lines; several empty lines
become one. Within a paragraph all line breaks and repeated spaces are
dropped, then the module fills the lines word by word up to the width.
The indentation of the first paragraph line applies to all lines of
the paragraph and counts toward the width; a tab in the indentation
counts as one character. A word longer than the width stands alone
and uncut on its line. The module removes `\r` beforehand.

```tcl
package require tclutils::tufold
package require tclutils::tufmt
::tclutils::tufold::text "abcdefghij" -width 4
                                          ;# -> abcd\nefgh\nij
::tclutils::tufold::foldLine "eins zwei drei vier" -width 9 -words 1
                                          ;# -> {eins zwei} {drei vier}
::tclutils::tufold::foldLine "ab   cd" -width 3 -words 1
                                          ;# -> ab cd
::tclutils::tufmt::reflow "a  b\nc d e" -width 3
                                          ;# -> a b\nc d\ne
::tclutils::tufmt::reflow "  a b c d\n\n\nx" -width 5
                                          ;# -> "  a b\n  c d\n\nx"
```

---

## Tabs: tuexpand

[tuexpand]{.index} converts tabs to spaces and back, like Unix
`expand` and `unexpand`.

```tcl
::tclutils::tuexpand::expand   text ?-tabs n?
::tclutils::tuexpand::unexpand text ?-tabs n? ?-all 0|1?
::tclutils::tuexpand::file     pfad ?-mode m? ?-tabs n? ?-all 0|1?
```

| Option | Default | Effect |
|---|---|---|
| `-tabs` | 8 | distance between tab stops |
| `-all` | 0 | `unexpand`: 0 only leading spaces, 1 all runs |
| `-mode` | `expand` | `file` only: which direction |

`expand` fills each tab up to the next tab stop. A trailing `\n` is
kept.

Without `-all`, `unexpand` converts only the whitespace at the start
of the line, spaces as well as tabs; the rest of the line stays as it
is, including tabs inside it. `-all 1` converts every run of
whitespace. In a run of at least two characters, and in every run at
the start of the line, each tab stop reached becomes a tab; what is
left after the last tab stop remains spaces. A single space inside the
line remains a space, even directly before a tab stop. Spaces directly
before a tab are absorbed into it. Unix `unexpand` behaves the same
way (`-a` for `-all 1`).

`file` throws `{TCLUTILS TUEXPAND MODE}` for an unknown `-mode` and
`{TCLUTILS TUEXPAND OPTION}` for a missing value. `expand` and
`unexpand` do not know `-mode`. `-all` applies only to `unexpand`;
`expand` and `file -mode expand` throw `{TCLUTILS COMMON OPTION -all}`
for it.

```tcl
package require tclutils::tuexpand
::tclutils::tuexpand::expand "ab\tc" -tabs 4  ;# -> ab  c
::tclutils::tuexpand::unexpand "        x  y" ;# -> \tx  y
::tclutils::tuexpand::unexpand "ab  cd      e" -tabs 4 -all 1
                                          ;# -> ab\tcd\t\te
::tclutils::tuexpand::unexpand "a\tb"     ;# -> a\tb
::tclutils::tuexpand::unexpand "abcdefg          x" -all 1
                                          ;# -> abcdefg\t\t x
```

---

## Columns: tucolumn

[tucolumn]{.index} aligns columns, like `column` from util-linux.
There are two modes: `table` for lines with fields (`column -t`),
`fill` for a word list that is distributed over several columns.

```tcl
::tclutils::tucolumn::table text  ?option wert ...?
::tclutils::tucolumn::text  text  ?option wert ...?
::tclutils::tucolumn::fill  liste ?-width n? ?-gap n?
::tclutils::tucolumn::file  pfad  ?-mode table|fill? ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-separator` | `""` | field separator of the input; empty means runs of whitespace |
| `-output` | two spaces | separator of the output |
| `-right` | 0 | 1 right-aligns all cells |
| `-width` | 80 | `fill`: target width of the line |
| `-gap` | 2 | `fill`: spaces between columns, at least 1 |
| `-mode` | `table` | `file` only |

`text` is the same as `table`. The column width is the longest cell
of the column, in characters. `table` does not pad the last column of
each line, so no whitespace appears at the end of a line. Lines may
have different numbers of fields. A separator of several characters
counts as a whole. Empty lines remain as empty lines; `column -t`
drops them without `-e`.

`fill` fills column by column: first the first column from top to
bottom, then the next. If not even one column fits into `-width`,
there is one column. `file -mode fill` splits the file into words at
whitespace. An empty list yields `""`.

`file` throws `{TCLUTILS TUCOLUMN MODE}` for an unknown `-mode` and
`{TCLUTILS TUCOLUMN OPTION}` for a missing value.

```tcl
package require tclutils::tucolumn
::tclutils::tucolumn::table "Name Alter\nBob 7"
                                          ;# -> Name  Alter\nBob   7
::tclutils::tucolumn::table "Name;Alter\nBob;7" -separator ";" \
    -output " | "                         ;# -> Name | Alter\nBob  | 7
::tclutils::tucolumn::fill {a b c d e} -width 7
                                          ;# -> "a  c  e\nb  d"
```

---

## Tables: tutable

[tutable]{.index} renders a table of header and rows as text, either
as a Markdown table or with an ASCII frame. There is no Unix
counterpart; `tucolumn` is there for aligning finished lines of
text.

```tcl
::tclutils::tutable::render koepfe zeilen ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-style` | `markdown` | `markdown` (pipe table) or `box` (`+`, `-`, `\|`) |
| `-align` | empty | per column `l`, `r` or `c`; missing entries count as `l` |

The return value is a string without a trailing `\n`. `koepfe`
determines the number of columns: missing cells of a row stay empty.
The width counts characters. The separator line in Markdown carries
the alignment (`:--`, `--:`, `:-:`); `l` also gets the colon on the
left. In Markdown each column is at least three characters wide, as
wide as `:--`; cells and separator line are aligned. In the frame a
column is as wide as its longest cell.

| Error | `-errorcode` |
|---|---|
| `-style` other than `markdown` and `box` | `{TCLUTILS TUTABLE OPT}` |
| alignment other than `l`, `r` and `c` | `{TCLUTILS TUTABLE OPT}` |
| row with more cells than `koepfe` | `{TCLUTILS TUTABLE COLUMNS}` |
| `koepfe` empty | `{TCLUTILS TUTABLE HEADERS}` |

```tcl
package require tclutils::tutable
puts [::tclutils::tutable::render {Name Alter} {{Alice 30} {Bob 7}}]
puts [::tclutils::tutable::render {Artikel Menge} \
    {{Äpfel 12} {Birnen 3}} -align {l r} -style box]
```

```text
| Name  | Alter |
| :---- | :---- |
| Alice | 30    |
| Bob   | 7     |
+---------+-------+
| Artikel | Menge |
+---------+-------+
| Äpfel   |    12 |
| Birnen  |     3 |
+---------+-------+
```

---

## Reversing and shuffling: tutac, turev, tushuf

[tutac]{.index} reverses the order of the lines (Unix `tac`),
[turev]{.index} the characters in each line (Unix `rev`),
[tushuf]{.index} shuffles the lines (Unix `shuf`).

| Command | Effect |
|---|---|
| `tutac::text text`, `file pfad` | lines in reverse; trailing `\n` is kept |
| `tutac::lines liste` | the list in reverse, like `lreverse` |
| `turev::line zeile` | the characters in reverse, like `string reverse` |
| `turev::text text`, `file pfad` | each line on its own; trailing `\n` is kept |
| `tushuf::lines liste ?opt?` | shuffled list |
| `tushuf::text text ?opt?`, `file pfad ?opt?` | shuffled lines, without trailing `\n` |

`tutac` treats the last line without `\n` like any other:
`"a\nb"` becomes `"b\na"`. Unix `tac` returns `ba` and a `\n` here.
`turev` reverses by code points; it splits composed characters made of
base and accent.

| Option `tushuf` | Default | Effect |
|---|---|---|
| `-seed` | from the clock | integer; same value, same order |
| `-count` | −1 | at most this many lines; negative means all, 0 none |

`tushuf` uses its own random number generator, not `rand()`. With the
same `-seed` the order is the same on every platform and under Tcl
8.6 and 9.0. The value may be of any size, also beyond 32 bits under
Tcl 8.6; the generator uses its lower 31 bits. A `-seed` that is not
an integer throws `{TCLUTILS TUSHUF SEED}`, such a `-count`
`{TCLUTILS TUSHUF COUNT}`.

```tcl
package require tclutils::tutac
package require tclutils::turev
package require tclutils::tushuf
::tclutils::tutac::text "a\nb\nc\n"       ;# -> c\nb\na\n
::tclutils::turev::text "abc\nxyz"        ;# -> cba\nzyx
::tclutils::tushuf::lines {a b c d e} -seed 7
                                          ;# -> b e d a c
::tclutils::tushuf::lines {a b c d e} -seed 7 -count 2
                                          ;# -> b e
```

---

## Number sequences: tuseq

[tuseq]{.index} generates number sequences like Unix `seq`.

```tcl
::tclutils::tuseq::range ?erste? ?schritt? letzte ?option wert ...?
::tclutils::tuseq::text  ?erste? ?schritt? letzte ?option wert ...?
```

One value means `letzte` (from 1, step 1), two mean `erste letzte`,
three `erste schritt letzte`. Options may stand before, between or
after the values: an argument that starts with `-` and is not a
number introduces an option. Negative numbers count as values. `range`
returns a list, `text` a string.

| Option | Default | Effect |
|---|---|---|
| `-format` | empty | `format` pattern per number, like `seq -f` |
| `-equalwidth` | 0 | padded with zeros to equal width, like `seq -w` |
| `-separator` | `\n` | `text` only: separator, like `seq -s` |

If all three values are integers, the module computes with integers,
of any size, also beyond 32 bits under Tcl 8.6. Otherwise it computes
in floating point and prints the numbers with `%g`; `1.0` thus
becomes `1`.
A step in the wrong direction yields an empty list. A `-format` for
integers (`%d`) fails on floating-point values with
`{TCL VALUE INTEGER}`. `-equalwidth` puts the minus sign before the
zeros. `-separator` applies only to `text`; `range` throws
`{TCLUTILS COMMON OPTION -separator}` for it.

| Error | `-errorcode` |
|---|---|
| zero or more than three values | `{TCLUTILS TUSEQ ARGS}` |
| value is not a number | `{TCLUTILS TUSEQ VALUE}` |
| step 0 | `{TCLUTILS TUSEQ INCREMENT}` |
| option without value | `{TCLUTILS TUSEQ OPTION}` |

```tcl
package require tclutils::tuseq
::tclutils::tuseq::range 5                ;# -> 1 2 3 4 5
::tclutils::tuseq::range 5 -1 1           ;# -> 5 4 3 2 1
::tclutils::tuseq::range 1 0.5 2          ;# -> 1 1.5 2
::tclutils::tuseq::range 8 11 -equalwidth 1
                                          ;# -> 08 09 10 11
::tclutils::tuseq::range -2 1 -equalwidth 1
                                          ;# -> -2 -1 00 01
::tclutils::tuseq::range 1 3 -format %03d ;# -> 001 002 003
::tclutils::tuseq::text -separator , 3    ;# -> 1,2,3
::tclutils::tuseq::text 3 -separator ,    ;# -> 1,2,3
::tclutils::tuseq::text 1 2 7 -separator ,
                                          ;# -> 1,3,5,7
::tclutils::tuseq::range 5000000000 5000000001
                                          ;# -> 5000000000 5000000001
```

---

## Replacing characters: tutr

[tutr]{.index} replaces, deletes and squeezes characters, like Unix
`tr`.

```tcl
::tclutils::tutr::translate text menge1 menge2
::tclutils::tutr::delete    text menge1
::tclutils::tutr::squeeze   text menge1
::tclutils::tutr::file      pfad menge1 menge2 ?option wert ...?
```

A set consists of single characters and ranges `a-z`. A `-` at the
start or end stands for itself. A descending range such as `c-a`
throws `{TCLUTILS TUTR RANGE}`. `translate` replaces the n-th
character of `menge1` with the n-th of `menge2`; if `menge2` is
shorter, its last character applies to the rest. If a character
appears in `menge1` more than once, its last mapping applies. All
replacements happen in one pass, so `ab` to `ba` swaps. An empty
`menge2` throws `{TCLUTILS TUTR SET2}`, unless `menge1` is empty too.
`delete` removes the characters of the set. `squeeze` reduces
consecutive identical characters of the set to one.

| Option `file` | Default | Effect |
|---|---|---|
| `-delete` | 0 | 1 deletes `menge1` instead of replacing |
| `-squeeze` | 0 | 1 then squeezes the characters from `menge2` |

`file` requires `menge2` even with `-delete 1`; it is then needed only
for `-squeeze` and may otherwise be `""`. With an empty `menge2`,
`-squeeze 1` and without `-delete`, `file` squeezes only the
characters from `menge1`, like `tr -s menge1`. Without `-delete` and
`-squeeze`, an empty `menge2` throws `{TCLUTILS TUTR SET2}`.

Differences from Unix `tr`: no classes such as `[:alpha:]` and no
escapes of its own; Tcl itself writes `\n` or `\t` into the string.

```tcl
package require tclutils::tutr
::tclutils::tutr::translate "hallo welt" a-z A-Z  ;# -> HALLO WELT
::tclutils::tutr::translate "abcde" a-e xy        ;# -> xyyyy
::tclutils::tutr::delete "a1b2c3" 0-9             ;# -> abc
::tclutils::tutr::squeeze "aaabccc  d" "ac "      ;# -> abc d
::tclutils::tutr::translate "abcabc" aa xy         ;# -> ybcybc
```

---

## Counting: tuwc

[tuwc]{.index} counts lines, words, characters and bytes, like Unix
`wc`.

```tcl
::tclutils::tuwc::text daten
::tclutils::tuwc::file pfad
```

The return value is a dict with `lines`, `words`, `chars`, `bytes`;
`file` adds `file` with the path.

| Key | Meaning |
|---|---|
| `lines` | number of `\n`, plus one if the text does not end in `\n` |
| `words` | runs without whitespace |
| `chars` | characters (code points) |
| `bytes` | `text`: length in UTF-8; `file`: size of the file in bytes |

`lines` differs from `wc -l`: a last line without `\n` is counted.
An empty text has 0 lines, `"\n"` one. `file` reads with the system
encoding and turns `\r\n` into `\n`; `lines`, `words` and `chars`
count this text. For `file`, `bytes` is the file size, as with
`wc -c`.

```tcl
package require tclutils::tuwc
set d [::tclutils::tuwc::text "eins zwei\ndrei"]
dict get $d lines                         ;# -> 2
dict get $d words                         ;# -> 3
set d [::tclutils::tuwc::text "Grüße"]
dict get $d chars                         ;# -> 5
dict get $d bytes                         ;# -> 7
```

---

## Pages: tupr

[tupr]{.index} splits text into pages with a header, like Unix `pr`
without multi-column output.

```tcl
::tclutils::tupr::text text ?option wert ...?
::tclutils::tupr::file pfad ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-length` | 66 | lines per page, including header and footer |
| `-header` | `""`; for `file` the file name | title in the header |
| `-width` | 72 | width of the header line |
| `-number` | 0 | 1 numbers the text lines (`%5d`, tab) |
| `-date` | now, `%Y-%m-%d %H:%M` | any string for the header |

Each page has five header lines: two empty, the info line, two empty.
The info line has date and title on the left, separated by three
spaces, and `Page n` right-aligned; if it is too long, at least one
space stands before `Page`. Then follow `-length` minus 10 text lines,
padded with empty lines to the full page length, and five empty footer
lines. The pages follow each other without a form feed; the result
ends without `\n`. `-width` applies only to the header; the module
does not shorten long text lines. `-number 1` counts across all
pages. An empty text yields `""`.

A `-length` of 10 or less throws `{TCLUTILS TUPR LENGTH}`.

```tcl
package require tclutils::tupr
set seiten [::tclutils::tupr::text "a\nb\nc" -length 12 \
    -header Liste -date Montag -width 24]
set z [split $seiten \n]
llength $z                      ;# -> 24
lindex $z 2                     ;# -> Montag   Liste    Page 1
lrange $z 5 6                   ;# -> a b
lindex $z 14                    ;# -> Montag   Liste    Page 2
```

---

*Next chapter: [Joining, Splitting, Pipelines](043-zusammenfuehren-und-ablaeufe.md)*
