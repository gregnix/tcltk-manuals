# Joining, Splitting, Pipelines

This chapter continues [Text and Files](040-text-und-dateien.md).
It covers the modules that combine several line streams, distribute
text over files, order pipelines and search text approximately. Each
module has a Unix counterpart or follows one loosely. None starts a
program; everything runs in Tcl.

| Group | Modules | Unix counterpart |
|---|---|---|
| Combining line streams | `tupaste`, `tujoin`, `tucomm` | paste, join, comm |
| Splitting | `tucsplit`, `tusplit` | csplit, split |
| Pipeline helpers | `tutee`, `tuxargs`, `tutsort` | tee, xargs, tsort |
| Fields and rules | `tuawk` | awk |
| Approximate search | `tufuzzy`, `tuagrep` | agrep |

Common to the text variants: a text that ends in `\n` does not produce
an empty last line.
Options come in pairs as `-option wert`. Booleans accept anything that
`string is boolean` accepts.

---

## Columns side by side: tupaste

[tupaste]{.index} combines line *n* of each input into one output line,
like Unix `paste`.

```tcl
::tclutils::tupaste::lines lineLists ?-delimiter d?
::tclutils::tupaste::texts textList  ?-delimiter d?
::tclutils::tupaste::files paths     ?-delimiter d?
```

`lines` takes a list of line lists, `texts` a list of texts, `files`
a list of paths. All three return a string, lines separated by `\n`,
without `\n` at the end.

| Option | Default | Effect |
|---|---|---|
| `-delimiter` | `\t` | stands between the columns; may also be several characters or empty |

If an input is shorter, an empty field takes its place. The number of
output lines follows the longest input.

Differences from `paste`: `-delimiter` applies as a whole to every
gap; a list of delimiters used in rotation (`paste -d ',;'`) does not
exist. `paste -s` (one input as one line) is missing as well. An
unknown option and an option without a value report
`TCLUTILS COMMON OPTION -name`.

```tcl
package require tclutils::tupaste
::tclutils::tupaste::texts [list "a\nb\nc\n" "1\n2\n"] -delimiter ";"
                                          ;# -> a;1\nb;2\nc;
::tclutils::tupaste::lines {{a b} {1 2}} -delimiter " | "
                                          ;# -> a | 1\nb | 2
::tclutils::tupaste::files {namen.txt orte.txt} -delimiter ": "
    ;# -> Ada: London\nLinus: Helsinki
```

In the last call `namen.txt` contains the lines `Ada` and `Linus`,
`orte.txt` the lines `London` and `Helsinki`.

---

## Joining on a key: tujoin

[tujoin]{.index} joins two separate text sources on a key field,
modeled on Unix `join`.

```tcl
::tclutils::tujoin::lines leftLines rightLines ?option wert ...?
::tclutils::tujoin::texts leftText  rightText  ?option wert ...?
::tclutils::tujoin::files leftPath  rightPath  ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-delimiter` | `\t` | field separator of the input; several characters form one literal separator |
| `-joiner` | like `-delimiter` | field separator of the output |
| `-leftfield` | 1 | key field on the left, from 1 |
| `-rightfield` | 1 | key field on the right, from 1 |
| `-header` | 0 | first line of both sides is a header line |
| `-outer` | `none` | `none`, `left`, `right`, `full` |
| `-anti` | `none` | `none`, `left`, `right`, `both` |

Each output line consists of the key, the remaining fields on the
left and the remaining fields on the right. The return value is a
string with `\n` between the lines.

- `-outer none` is the inner join: only lines with a partner.
- `-outer left`, `right`, `full` include lines without a partner from
  the named side. The missing side is padded with empty fields, as
  many as the widest line of that side has fields.
- `-anti left`, `right`, `both` return only lines without a partner:
  key and fields of their own side, without padding.
- With `-header 1` the joined header line comes first. With `-anti`
  it is omitted.

Differences from `join`: the inputs need not be sorted; the right
side is read as an index. The output follows the order on the left;
lines without a partner from the right follow afterwards in their
order. Duplicate keys yield every combination, as with `join`. The
default separator is the tab, not whitespace. `-outer` corresponds to
`join -a`, but pads; `-anti` corresponds to `join -v`.

| Error | Message | `-errorcode` |
|---|---|---|
| unknown option | `unknown option "-x"` | `TCLUTILS COMMON OPTION -x` |
| option without value | `missing value for option "-x"` | `TCLUTILS COMMON OPTION -x` |
| field number less than 1 | `-leftfield must be a positive integer` | `TCLUTILS COMMON INTEGER -leftfield` |
| `-header` not a boolean | `-header requires a boolean value` | `TCLUTILS COMMON BOOLEAN -header` |
| unknown value | `unknown -outer: x` | `TCLUTILS COMMON VALUE -outer` |
| `-outer` and `-anti` together | `cannot combine -outer and -anti` | `TCLUTILS TUJOIN COMBINE` |
| empty `-delimiter` | `delimiter must not be empty` | `TCLUTILS COMMON DELIMITER` |

The message for an unknown value lists the allowed values on a second
line, for example `Known: none left right full`; for `-anti` it reads
`unknown -anti: x` with the `-errorcode` `TCLUTILS COMMON VALUE -anti`.

```tcl
package require tclutils::tujoin
set L "1;Ada\n2;Linus\n3;Grace\n"
set R "1;Berlin\n2;Helsinki\n4;Paris\n"
::tclutils::tujoin::texts $L $R -delimiter ";"
    ;# -> 1;Ada;Berlin\n2;Linus;Helsinki
::tclutils::tujoin::texts $L $R -delimiter ";" -outer full
    ;# -> 1;Ada;Berlin\n2;Linus;Helsinki\n3;Grace;\n4;;Paris
::tclutils::tujoin::texts $L $R -delimiter ";" -anti both
                                          ;# -> 3;Grace\n4;Paris
::tclutils::tujoin::texts $L $R -delimiter ";" -joiner ,
    ;# -> 1,Ada,Berlin\n2,Linus,Helsinki
::tclutils::tujoin::texts "id;name\n1;Ada" "ort;id\nBerlin;1" \
    -delimiter ";" -header 1 -rightfield 2
    ;# -> id;name;ort\n1;Ada;Berlin
```

`tujoin` is not built for CSV with quotes; `tucsv` does the parsing,
chapter [Data Formats](050-datenformate.md).

---

## Comparing two sets: tucomm

[tucomm]{.index} compares two sorted line lists like Unix `comm`.

```tcl
::tclutils::tucomm::compareLines aLines bLines ?-sort b? ?-nocase b?
::tclutils::tucomm::text  aText bText ?-sort b? ?-nocase b?
::tclutils::tucomm::files aFile bFile ?-sort b? ?-nocase b?
::tclutils::tucomm::formatColumns comparison ?-separator s?
```

| Option | Default | Effect |
|---|---|---|
| `-sort` | 0 | sort both inputs beforehand, in the order of the comparison |
| `-nocase` | 0 | case-insensitive comparison |
| `-separator` | `\t` | `formatColumns` only: indentation per column |

The return value of the three comparison commands is a dict with the
keys `onlyA` (left only), `onlyB` (right only) and `both`. Under
`both` stands the line from the left input. Duplicate lines count
individually, as with `comm`.

`formatColumns` turns this into text in the style of `comm`: `onlyA`
without indentation, `onlyB` with one separator before it, `both` with
two. Unlike `comm`, the groups follow one another instead of forming
one common sorted sequence.

The comparison is a merge pass with `string compare`, with
`-nocase 1` on the lowercased line. This is the order by character
codes, as with `comm` and `sort` in the C locale. `-sort 1` sorts both
inputs in exactly this order (`lsort` without option, with `-nocase 1`
by the lowercased line). Equal lines thus always end up under `both`,
also with digits (`a9`, `a10`) and mixed case. Unsorted inputs
without `-sort 1` give a wrong result without an error. Sorting
beforehand requires `lsort` without option; `lsort -dictionary`
orders `a9` before `a10` and does not match the merge pass.

Errors: unknown option `TCLUTILS COMMON OPTION -name`, a boolean
that is not one `TCLUTILS COMMON BOOLEAN -sort` or `-nocase`
respectively.

```tcl
package require tclutils::tucomm
set r [::tclutils::tucomm::text "apfel\nbirne\nkiwi\n" \
    "birne\nkiwi\nmango\n"]
dict get $r onlyA                         ;# -> apfel
dict get $r both                          ;# -> birne kiwi
::tclutils::tucomm::formatColumns $r -separator |
    ;# -> apfel\n|mango\n||birne\n||kiwi
::tclutils::tucomm::compareLines [lsort {a10 a9}] {a10}
    ;# -> onlyA a9 onlyB {} both a10
::tclutils::tucomm::compareLines {a9 a10} {a10} -sort 1
    ;# -> onlyA a9 onlyB {} both a10
::tclutils::tucomm::compareLines {a B} {B} -sort 1
    ;# -> onlyA a onlyB {} both B
```

The last two calls show the cases from the paragraph above: `a10`
and `B` occur in both inputs and appear under `both`. A line-by-line
difference with order is the job of `tudiff`, chapter
[Encoding, Hashing and Comparing](052-kodierung-hash-vergleich.md).

---

## Splitting at patterns: tucsplit

[tucsplit]{.index} writes a text into several files and starts a new
file at each line that matches a pattern. The counterpart is Unix
`csplit`.

```tcl
::tclutils::tucsplit::splitText text pattern ?option wert ...?
::tclutils::tucsplit::file      path pattern ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-regexp` | 1 | pattern as regular expression; 0 means `string match` |
| `-keepmatch` | 1 | the matching line starts the new part; 0 drops it |
| `-empty` | 0 | also write empty parts |
| `-prefix` | `xx` | start of the file name |
| `-suffix` | empty | end of the file name, for example `.md` |
| `-digits` | 2 | digits of the sequence number, from 0 |
| `-outdir` | `.` | target directory; created if missing |

The return value is the list of written paths, at least one: a text
without a match and an empty text each yield one file. Without
`-empty 1` there is no empty part before the first match. The parts
end without `\n`, even if the input had one. Existing files of the
same name are overwritten.

Differences from `csplit`: a single pattern applies to all lines;
there is no list of patterns, no line numbers as boundaries and no
repeat count `{*}`. Names and numbering (`xx00`, `xx01`) are as with
`csplit`.

| Error | `-errorcode` |
|---|---|
| `-outdir` is a file | `TCLUTILS TUCSPLIT OUTDIR` |
| unknown option | `TCLUTILS COMMON OPTION -name` |
| `-digits` less than 1 | `TCLUTILS COMMON INTEGER -digits` |
| not a boolean | `TCLUTILS COMMON BOOLEAN -name` |

```tcl
package require tclutils::tucsplit
set dir [file join [pwd] kapitel]
set md "Vorwort\n# Eins\neins\n# Zwei\nzwei\n"
set teile [::tclutils::tucsplit::splitText $md {^# } -outdir $dir]
lmap p $teile {file tail $p}              ;# -> xx00 xx01 xx02
set teile [::tclutils::tucsplit::splitText $md {^# } -outdir $dir \
    -prefix kap -suffix .md -keepmatch 0]
lmap p $teile {file tail $p}
    ;# -> kap00.md kap01.md kap02.md
```

In the first run `xx00` contains the line `Vorwort`, `xx01` the text
`# Eins\neins`, `xx02` the text `# Zwei\nzwei`. In the second run the
headings are missing: `kap01.md` contains only `eins`.

---

## Splitting by size: tusplit

[tusplit]{.index} splits text by line count or data by byte count,
like Unix `split`.

```tcl
::tclutils::tusplit::splitLines text ?option wert ...?
::tclutils::tusplit::splitBytes data ?option wert ...?
::tclutils::tusplit::file  path ?-lines n | -bytes n? ?option wert ...?
::tclutils::tusplit::lines path n ?option wert ...?
::tclutils::tusplit::bytes path n ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-lines` | 1000 | lines per part (`splitLines`, `file`) |
| `-bytes` | 1024 | bytes per part (`splitBytes`); for `file` the option switches to byte mode |
| `-prefix` | `x` | start of the file name |
| `-suffix` | empty | end of the file name |
| `-digits` | 2 | digits of the sequence number, from 0 |
| `-outdir` | `.` | target directory; created if missing |

`file` reads as text in line mode and as binary in byte mode. Without
`-lines` and `-bytes`, line mode with 1000 lines applies. `lines` and
`bytes` are short forms of `file … -lines n` and `file … -bytes n`.
The return value is the list of paths; an empty input yields an empty
file `x00`.

`splitBytes` expects a byte sequence, that is, characters up to
`\xFF`. Convert text with other characters beforehand with
`encoding convertto utf-8`. A character above `\xFF` is an error
`TCLUTILS TUSPLIT BYTES`, the same under Tcl 8.6 and 9.0; the check
runs before any file is created.

Differences from `split`: the number is decimal (`x00`, `x01`, like
`split -d`), not `xaa`, `xab`. Parts from `splitLines` end without
`\n`. Splitting into a fixed number of parts (`split -n`) does not
exist.

| Error | `-errorcode` |
|---|---|
| `-lines` and `-bytes` together for `file` | `TCLUTILS TUSPLIT MODE` |
| `-outdir` is a file | `TCLUTILS TUSPLIT OUTDIR` |
| character above `\xFF` for `splitBytes` | `TCLUTILS TUSPLIT BYTES` |
| count or `-digits` less than 1 | `TCLUTILS COMMON INTEGER -name` |
| unknown option, option without value | `TCLUTILS COMMON OPTION -name` |

```tcl
package require tclutils::tusplit
set dir [file join [pwd] teile]
set teile [::tclutils::tusplit::splitLines "1\n2\n3\n4\n5\n" \
    -lines 2 -outdir $dir]
lmap p $teile {file tail $p}              ;# -> x00 x01 x02
set teile [::tclutils::tusplit::splitBytes abcdefg -bytes 3 \
    -outdir $dir -prefix teil -suffix .bin]
lmap p $teile {file tail $p}
    ;# -> teil00.bin teil01.bin teil02.bin
```

`x00` contains `1\n2`, `x02` only `5`. The three binary parts contain
`abc`, `def` and `g`.

---

## Writing to several targets: tutee

[tutee]{.index} writes the same data into several files and, on
request, to `stdout`, like Unix `tee`.

```tcl
::tclutils::tutee::write data paths ?option wert ...?
::tclutils::tutee::writeFile inputFile paths ?-append b? ?-stdout b?
::tclutils::tutee::copyChannel inChan outChans ?option wert ...?
```

| Option | Default | Commands | Effect |
|---|---|---|---|
| `-append` | 0 | `write`, `writeFile` | append instead of overwrite |
| `-stdout` | 0 | all | additionally to `stdout` |
| `-nonewline` | 0 | `write` | no `\n` at the end |
| `-chunksize` | 8192 | `copyChannel` | characters per read |

- `write` writes `data` with `puts`, that is, with `\n` at the end,
  except with `-nonewline 1`. The return value is `data`.
- `writeFile` reads `inputFile` as text and writes the content
  unchanged, without an additional `\n`. The return value is the
  content. `-nonewline` does not exist here.
- `copyChannel` reads `inChan` to the end and writes each block to
  all channels in `outChans`. The return value is the number of
  characters copied; for channels opened in binary mode these are
  bytes. The caller opens and closes the channels.

`write` opens all targets before it writes, and flushes them only
once all are open. If opening a target fails, the error comes from
`open` (`POSIX ENOENT …`). The channels already opened are then closed
again, existing files keep their content, and files that this call
created are removed again. `writeFile` behaves the same way.

Option errors: `TCLUTILS COMMON BOOLEAN -name`,
`TCLUTILS COMMON INTEGER -chunksize`, `TCLUTILS COMMON OPTION -name`.

```tcl
package require tclutils::tutee
set dir [file join [pwd] tee]
file mkdir $dir
set a [file join $dir a.txt]
set b [file join $dir b.txt]
::tclutils::tutee::write hallo [list $a $b]
                                          ;# -> hallo
::tclutils::tutee::write noch [list $a] -append 1 -nonewline 1
                                          ;# -> noch
set in  [open $a rb]
set out [open [file join $dir kopie.txt] wb]
::tclutils::tutee::copyChannel $in [list $out]
                                          ;# -> 10
close $in; close $out
```

Afterwards `a.txt` contains the text `hallo\nnoch`, `b.txt` the text
`hallo\n`, `kopie.txt` the same as `a.txt`.

---

## Processing lists in batches: tuxargs

[tuxargs]{.index} splits a list into batches and calls a Tcl command
for each batch. The counterpart is Unix `xargs`; instead of a program,
a command prefix runs.

```tcl
::tclutils::tuxargs::batches items ?-n n? ?-skipempty b?
::tclutils::tuxargs::apply   items commandPrefix ?option wert ...?
::tclutils::tuxargs::command items commandPrefix ?option wert ...?
```

| Option | Default | Commands | Effect |
|---|---|---|---|
| `-n` | 100 | all | at most this many elements per batch |
| `-skipempty` | 1 | all | remove empty elements beforehand |
| `-collect` | 1 | `apply`, `command` | collect results; 0 returns empty |

`batches` returns the list of batches. `apply` calls
`{*}$commandPrefix {*}$stapel` per batch and, with `-collect 1`,
returns the list of results, one element per batch. `command` is the
same command under another name. An error in the called command
aborts the run and reaches the caller unchanged.

Differences from `xargs`: the input is a Tcl list, not text split at
whitespace; quotes and spaces in elements are therefore not an issue.
There is no limit by character count and no parallel execution
(`xargs -P`). The default `-n 100` is fixed, not dependent on the
length of the command line.

Errors: `-n` less than 1 is `TCLUTILS COMMON INTEGER -n`; in addition
`TCLUTILS COMMON BOOLEAN -name` and `TCLUTILS COMMON OPTION -name`.

```tcl
package require tclutils::tuxargs
::tclutils::tuxargs::batches {a b c d e} -n 2
                                          ;# -> {a b} {c d} e
::tclutils::tuxargs::batches {a {} b} -n 2
                                          ;# -> {a b}
::tclutils::tuxargs::apply {1 2 3 4 5} ::tcl::mathop::+ -n 2
                                          ;# -> 3 7 5
::tclutils::tuxargs::apply {a b c} {list x} -n 2
                                          ;# -> {x a b} {x c}
::tclutils::tuxargs::apply $pfade {file delete} -n 50 -collect 0
```

The last call deletes the files from `$pfade` in batches of 50.

---

## Ordering dependencies: tutsort

[tutsort]{.index} sorts topologically, like Unix `tsort`: each pair
`u v` means "`u` comes before `v`".

```tcl
::tclutils::tutsort::pairs tokens
::tclutils::tutsort::text  text
::tclutils::tutsort::file  path
```

`pairs` takes a flat list and returns a list. `text` and `file` split
at whitespace, like `tsort`, and return the nodes separated by `\n`.
A pair `u u` registers a node without a constraint. The order is
stable: of the nodes that become free, the one read first comes
first. The output of GNU `tsort` is ordered differently for the same
input, but is equally valid.

| Error | Message | `-errorcode` |
|---|---|---|
| odd number of words | `input contains an odd number of tokens` | `TCLUTILS TUTSORT ODD` |
| cycle | `input contains a cycle involving: …` | `TCLUTILS TUTSORT CYCLE` |

On a cycle `tutsort` aborts; GNU `tsort` prints a warning and still
returns a sequence. The message names only the nodes that lie on a
cycle, in the order of their first occurrence. Nodes that lie only
behind a cycle are not included.

```tcl
package require tclutils::tutsort
::tclutils::tutsort::pairs {hemd jacke hose guertel hose schuhe}
    ;# -> hemd hose jacke guertel schuhe
::tclutils::tutsort::text "a b\nb c\nx x"
                                          ;# -> a\nx\nb\nc
::tclutils::tutsort::pairs {a b b a b c}
    ;# Fehler: input contains a cycle involving: a b
```

---

## Fields and rules: tuawk

[tuawk]{.index} brings the awk model to Tcl: each line is a record,
is split into fields, and a list of rules made of pattern and action
runs over it. It is not an interpreter of the awk language. Patterns
are Tcl expressions, actions are Tcl scripts.

```tcl
::tclutils::tuawk::run  text rules ?-fs s? ?-ofs s? ?-ors s?
::tclutils::tuawk::file path rules ?-fs s? ?-ofs s? ?-ors s?
```

| Option | Default | Effect |
|---|---|---|
| `-fs` | empty | field separator; empty means runs of whitespace |
| `-ofs` | one space | stands between the arguments of `emit` |
| `-ors` | `\n` | stands after each output of `emit` |

The return value is the collected output of all `emit` calls as a
string. `tuawk` writes nothing to `stdout`. `file` reads the file as
text and calls `run`.

### Rules

`rules` is a flat list of pairs `muster aktion`. For each record the
rules run in their order; each matching rule executes its action.

| Pattern | Meaning |
|---|---|
| `BEGIN` | action runs once before the first record |
| `END` | action runs once after the last record |
| empty (`{}`) | always matches |
| `/regex/` | regular expression against the whole line |
| otherwise | Tcl expression for `expr`, for example `{$2 > 3}` or `{$1 eq "x"}` |

An empty action means `emit $0`, that is, output the line.

### Fields and variables

| Name | Content |
|---|---|
| `$0` | the whole line |
| `$1` … | the fields, from 1 |
| `$NF` | number of fields of this line; 0 before the first record |
| `$NR` | number of the line, from 1; 0 before the first record |
| `emit arg …` | output: arguments joined with `-ofs`, followed by `-ors` |

Fields are variables and can be changed in an action (`set 2 …`);
`$0` does not change in the process.

Field separator `-fs`: empty splits at runs of whitespace like awk and
ignores whitespace at the edges. A single character splits with
`split`; two separators in a row yield an empty field. Several
characters count as a regular expression.

All rules of a call run in their own frame, like the body of a
procedure, in a namespace that is deleted after the run. `set name …`
always creates a variable of this frame, never a global variable of
the same name; this holds equally under Tcl 8.6 and 9.0. Variables
from actions persist across all records up to `END`, like global
variables in awk. The actions have the full Tcl command set; rules
from an outside source must therefore be treated like code.

In an action, `break` skips the remaining rules for the current
record, like `next` in awk; `continue` goes to the next rule.

### Differences from awk

- A field beyond `NF` is an error, not an empty string:
  `can't read "3": no such variable`, `-errorcode`
  `TCL LOOKUP VARNAME 3`. If shorter lines are possible, check `$NF`
  first.
- An unset variable is also an error, not 0. Initial values belong
  in `BEGIN`.
- `-fs " "` splits at every single space; only the empty separator
  has the awk meaning "whitespace".
- No `printf`, no `getline`, no custom record separator. For
  formatting, use `format` in the argument of `emit`.

| Error | `-errorcode` |
|---|---|
| unknown option, option without value | `TCLUTILS TUAWK OPTION` |
| odd number of elements in `rules` | `TCLUTILS TUAWK RULES` |
| field beyond `NF` | `TCL LOOKUP VARNAME n` |

Errors in patterns and actions reach the caller unchanged.

### Examples

```tcl
package require tclutils::tuawk
set daten "Ada 3\nLinus 5\nGrace 4\n"
::tclutils::tuawk::run $daten {{$2 > 3} {emit $1}}
                                          ;# -> Linus\nGrace\n
::tclutils::tuawk::run $daten {/^L/ {}}  ;# -> Linus 5\n
::tclutils::tuawk::run $daten {{} {emit $NR $NF $1}} -ofs ";"
    ;# -> 1;2;Ada\n2;2;Linus\n3;2;Grace\n
set regeln {
    BEGIN {set s 0}
    {}    {set s [expr {$s + $2}]}
    END   {emit "Summe: $s"}
}
::tclutils::tuawk::run $daten $regeln    ;# -> Summe: 12\n
```

Grouping with a dict, changing separators and output:

```tcl
set log "INFO start\nERROR disk\nINFO ende\n"
::tclutils::tuawk::run $log {
    BEGIN {set n {}}
    {}    {dict incr n $1}
    END   {dict for {k v} $n {emit $k $v}}
}                                         ;# -> INFO 2\nERROR 1\n
::tclutils::tuawk::run $log {/ERROR/ {emit $NR $2}}
                                          ;# -> 2 disk\n
::tclutils::tuawk::run "Ada;3\nLinus;5" {{} {emit $2 $1}} \
    -fs ";" -ofs ,                        ;# -> 3,Ada\n5,Linus\n
::tclutils::tuawk::run "k=v; x=y" {{} {emit $2}} -fs {;\s*}
                                          ;# -> x=y\n
::tclutils::tuawk::run "a b" {{} {emit [format %-4s| $1]}}
                                          ;# -> a   |\n
```

For a complete awk program, `exec awk` remains.

---

## Approximate comparison: tufuzzy

[tufuzzy]{.index} provides the basics of approximate search. The
measure is the Levenshtein distance: the smallest number of
insertions, deletions and substitutions of single characters.

```tcl
::tclutils::tufuzzy::distance       a b              ?-nocase b?
::tclutils::tufuzzy::searchDistance pattern text     ?-nocase b?
::tclutils::tufuzzy::similarity     a b              ?-nocase b?
::tclutils::tufuzzy::subsequence    pattern text     ?-nocase b?
::tclutils::tufuzzy::bestMatch      pattern candidates ?-nocase b?
```

| Command | Return value |
|---|---|
| `distance` | distance between the two strings, an integer |
| `searchDistance` | smallest distance from `pattern` to any substring of `text` |
| `similarity` | `1.0 - abstand / längere Länge`, between `0.0` and `1.0`; two empty strings yield `1.0` |
| `subsequence` | 1 if the characters of `pattern` occur in `text` in this order, otherwise 0 |
| `bestMatch` | the candidate with the smallest distance; on a tie the first; an empty list yields `""` |

| Option | Default | Effect |
|---|---|---|
| `-nocase` | 0 | both sides with `string tolower` beforehand |

`subsequence` is the search used by fzf-style selection lists: `tcu`
matches `tclutils`, `utc` does not. The computation works on
characters, not bytes; umlauts count as one character.

| Error | Message | `-errorcode` |
|---|---|---|
| unknown option | `unknown option -x` | `TCLUTILS TUFUZZY OPTION` |
| option without value | `missing value for option -x` | `TCLUTILS TUFUZZY OPTION` |
| extra arguments | `unexpected arguments: …` | `TCLUTILS TUFUZZY ARGS` |
| `-nocase` not a boolean | `-nocase requires a boolean value` | `TCLUTILS COMMON BOOLEAN -nocase` |

```tcl
package require tclutils::tufuzzy
::tclutils::tufuzzy::distance kitten sitting     ;# -> 3
::tclutils::tufuzzy::distance Haus haus -nocase 1
                                                 ;# -> 0
::tclutils::tufuzzy::searchDistance gama "gamma line"
                                                 ;# -> 1
::tclutils::tufuzzy::similarity kitten sitting
                                          ;# -> 0.5714285714285714
::tclutils::tufuzzy::subsequence tcu tclutils    ;# -> 1
::tclutils::tufuzzy::bestMatch tujion {tujoin tupaste tucomm}
                                                 ;# -> tujoin
```

---

## Approximate search: tuagrep

[tuagrep]{.index} is a grep with error tolerance, built on
`tufuzzy::searchDistance`. A line matches if the distance of the
pattern to a substring of the line is at most `-maxdist`. The
counterpart is Unix `agrep`.

```tcl
::tclutils::tuagrep::search text     pattern ?option wert ...?
::tclutils::tuagrep::match  line     pattern ?option wert ...?
::tclutils::tuagrep::file   filename pattern ?option wert ...?
::tclutils::tuagrep::files  fileList pattern ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-maxdist` | 1 | largest allowed distance, an integer from 0; 0 means exact substring |
| `-nocase` | 0 | case-insensitive |
| `-invert` | 0 | the lines without a match |
| `-linenumbers` | 0 | each line as `{nummer text}`, number from 1 |
| `-count` | 0 | only the count |
| `-filenames` | 0 | `file` only: matches as `{datei treffer}` |
| `-fileswithmatches` | 0 | `file`, `files` only: only the paths with a match |

| Command | Return value |
|---|---|
| `search` | list of matches, with `-count 1` the count |
| `match` | 1 or 0 for one line; honors `-maxdist`, `-nocase`, `-invert` |
| `file` | like `search`; with `-fileswithmatches 1` the path or `""` |
| `files` | matches of all files, always with file name; with `-count 1` a dict `pfad anzahl`; with `-fileswithmatches 1` the list of paths |

The options are the same as those of `tugrep` from
[Text and Files](040-text-und-dateien.md). `tuagrep` has no `-max`,
no `-word` and no `-wholeline`, and the pattern is always literal: no
regular expressions. `agrep`, by contrast, allows patterns with error
tolerance and weights for insertion, deletion and substitution;
`-maxdist` corresponds to `agrep -k` or `-1` to `-9`.

`search` splits the text at `\n` into the same lines that `file`
reads: a `\n` at the end closes the last line and does not start an
empty one; an empty text has no line. An empty pattern matches every
line. A text has no file name; `search` and `match` accept
`-filenames` and `-fileswithmatches` but ignore them.
`files` always adds the file name.

| Error | Message | `-errorcode` |
|---|---|---|
| unknown option | `unknown option -x` | `TCLUTILS TUAGREP OPTION` |
| option without value | `missing value for option -x` | `TCLUTILS TUAGREP OPTION` |
| extra arguments | `unexpected arguments: …` | `TCLUTILS TUAGREP ARGS` |
| `-maxdist` not an integer from 0 | `-maxdist must be a non-negative integer` | `TCLUTILS TUAGREP MAXDIST` |
| switch not a boolean | `-invert requires a boolean value` | `TCLUTILS COMMON BOOLEAN -name` |

A file that cannot be opened is reported by `open` with
`POSIX ENOENT …`.

```tcl
package require tclutils::tuagrep
set text "gamma line\nbeta line\ndelta"
::tclutils::tuagrep::search $text gama   ;# -> {gamma line}
::tclutils::tuagrep::search $text gama -maxdist 0
                                          ;# ->
::tclutils::tuagrep::search $text gama -linenumbers 1
                                          ;# -> {1 {gamma line}}
::tclutils::tuagrep::search $text gama -invert 1
                                          ;# -> {beta line} delta
::tclutils::tuagrep::match Hauptstrasse strase
                                          ;# -> 1
::tclutils::tuagrep::search "eins\nzwei\n" xyz -invert 1
                                          ;# -> eins zwei
::tclutils::tuagrep::search $text gama -maxdist x
    ;# Fehler: -maxdist must be a non-negative integer
```

With files; `a.txt` contains `gamma line` and `beta`, `b.txt` contains
`nichts` and `gamma`, `c.txt` contains `leer`:

```tcl
::tclutils::tuagrep::files {a.txt b.txt c.txt} gama
    ;# -> {a.txt {gamma line}} {b.txt gamma}
::tclutils::tuagrep::files {a.txt b.txt c.txt} gama -count 1
                                          ;# -> a.txt 1 b.txt 1 c.txt 0
::tclutils::tuagrep::files {a.txt b.txt c.txt} gama \
    -fileswithmatches 1                   ;# -> a.txt b.txt
```

---

*Next chapter: [Characters, Numbers, Dates and Paths](045-zeichen-zahlen-datum.md)*
