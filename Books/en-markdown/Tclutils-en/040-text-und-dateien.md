# Text and Files

The text filters mirror Unix tools as a Tcl API. A string or a list
goes in, a string or a list comes out. The filters themselves start no
program. The mapping to the Unix names is in
`docs/guide/coreutils-mapping.md`. This chapter describes the commands
used to build a pipeline from filters, file type and ZIP. It does not
list every filter module from the mapping.

Common pattern, where the module has it: `text` works on a string,
`file` on a path, `files` on a list of paths.

---

## Head and Tail

| Command | Effect |
|---|---|
| `tucat::text`, `file`, `files` | text unchanged, or with line numbers |
| `tuhead::text`, `file` | the first `n` lines; default 10 |
| `tutail::text`, `file` | the last `n` lines; default 10 |

With `-number 1`, `tucat` numbers every line, including an empty one,
as six digits, tab, text (`format %6d`). `-nonblank 1` numbers only
lines with content. As with `cat -n`, the rest after the last `\n` is
not a line and gets no number, and `files` numbers the files one after
another in one run. A file without a final `\n` runs into the next one.
An unknown option throws `{TCLUTILS COMMON OPTION -name}` (since 0.2; up
to 0.1 the empty last line got a number, every file started at 1, and
unknown options were silently ignored).

```tcl
package require tclutils::tucat
package require tclutils::tuhead
package require tclutils::tutail
set text "alpha\nbeta\nbeta\nalpha"
::tclutils::tuhead::text $text 2          ;# -> alpha\nbeta\n
::tclutils::tutail::text $text 1          ;# -> alpha
::tclutils::tucat::text "alpha\nbeta" -number 1
                                          ;# -> "     1\talpha\n     2\tbeta"
```

As with `head -n` and `tail -n`, the result keeps the line ends: every
line ends with `\n`, except the last line of the input when it has none.
`text` and `file` return the same; `file` reads UTF-8, other encodings
with `-encoding`. Up to 0.1 `tutail::text "eins\nJörg\n" 1` was empty, and
`file` dropped every line end. So print with `puts -nonewline`. `tuhead`
and `tutail` do not follow files. A negative count throws
`{TCLUTILS TUHEAD COUNT}` or `{TCLUTILS TUTAIL COUNT}`.

---

## Searching: tugrep

```tcl
::tclutils::tugrep::search text muster ?option wert ...?
::tclutils::tugrep::match  zeile muster ?option wert ...?
::tclutils::tugrep::file   pfad muster ?option wert ...?
::tclutils::tugrep::files  pfade muster ?option wert ...?
```

The pattern is a regular expression. `-fixed 1` searches for the
string literally.

| Option | Default | Effect |
|---|---|---|
| `-nocase` | 0 | ignore case |
| `-linenumbers` | 0 | each line as `{nummer text}`, number from 1 |
| `-invert` | 0 | the lines without a match |
| `-fixed` | 0 | no regex |
| `-word` | 0 | whole word, like grep `-w` |
| `-wholeline` | 0 | the whole line, like grep `-x` |
| `-max` | 0 | stop after N matches; 0 means no limit |
| `-count` | 0 | only the count |
| `-fileswithmatches` | 0 | only the paths with a match |
| `-filenames` | 0 | matches prefixed with the file name |

```tcl
package require tclutils::tugrep
set text "alpha\nbeta\nERROR eins\nerror zwei\nERRORCODE"
::tclutils::tugrep::search $text ERROR
                                          ;# -> {ERROR eins} ERRORCODE
::tclutils::tugrep::search $text error -nocase 1 -linenumbers 1
                                          ;# -> {3 {ERROR eins}} {4 {error zwei}} {5 ERRORCODE}
::tclutils::tugrep::search "ERROR\nERRORCODE" ERROR -word 1
                                          ;# -> ERROR
::tclutils::tugrep::search "a\na\na" a -max 1
                                          ;# -> a
::tclutils::tugrep::search $text error -nocase 1 -count 1
                                          ;# -> 3
```

`-word` matches `ERROR` and not `ERRORCODE`. `-max` counts lines, not
matches within a line. The rest after a final `\n` is not a line: `.*` matches two lines in
`"eins\nJörg\n"` (since 0.2; up to 0.1.3 three, and `file` dropped empty
lines at the end of the file).

---

## Sorting and Duplicates

`tusort` sorts lines or a list. `tuuniq` removes only adjacent
duplicates, like Unix `uniq`. To remove all duplicates, sort
first.

| Option `tusort` | Effect |
|---|---|
| `-numeric`, `-integer`, `-real` | numeric comparison |
| `-dictionary` | like `lsort -dictionary` |
| `-nocase` | ignore case |
| `-reverse` | descending |
| `-unique` | drop duplicates while sorting |

`tuuniq` knows `-nocase`. `adjacentCount` returns `{anzahl wert}` per
group of neighbors. `count` counts over the whole list.

```tcl
package require tclutils::tusort
package require tclutils::tuuniq
::tclutils::tusort::text "10\n2\n10" -numeric 1 -unique 1
                                          ;# -> 2\n10
::tclutils::tuuniq::uniqList {a b b a}    ;# -> a b a
::tclutils::tuuniq::uniqList [::tclutils::tusort::sortList {a b b a}]
                                          ;# -> a b
::tclutils::tuuniq::adjacentCount {a a b} ;# -> {2 a} {1 b}
```

---

## Fields and Replacing

`tucut` cuts fields from a line. This is not CSV: quotes and commas
inside a field belong to `tucsv`, chapter
[Data Formats](050-datenformate.md). Field numbers count from 1. Ranges
are written `2-4`. `-chars` cuts characters, also from 1, also
open-ended as `4-` or `-3`.

```tcl
package require tclutils::tucut
::tclutils::tucut::field "a;b;c" ";" 2         ;# -> b
::tclutils::tucut::fields "a;b;c;d" ";" {1 3}  ;# -> a;c
::tclutils::tucut::fields "a;b;c;d" ";" 2-3    ;# -> b;c
```

`text` and `file` take `-delimiter`, `-fields` and `-chars`.
As with `tusort::text` and `tuuniq::text`, the result ends with `\n`
exactly when the input does; up to tclutils 0.68.0 it was dropped.

`tused` replaces and deletes line by line. Without `-all`, the first
match in the line applies. `-fixed 1` searches literally, otherwise as
a regex. `-nocase 1` ignores case. `delete` drops the matching
lines. `process` takes a list of rules (`s`, `d`).

```tcl
package require tclutils::tused
::tclutils::tused::replace "foo foo" foo bar         ;# -> bar foo
::tclutils::tused::replace "foo foo" foo bar -all 1  ;# -> bar bar
::tclutils::tused::delete "# c\nzeile" {^#}          ;# -> zeile
```

Addresses as in sed (`3`, `$`, `/regex/`, range, negation with `!`,
step `erste~schritt`) attach to the rule in `process` and `script`.
The forms are listed in `docs/tused.md`.

---

## File Type and Searching the Tree

`tufile` reads only the head of the file and compares it with a
signature table. No libmagic, no masks.

| Command | Result |
|---|---|
| `detect pfad` | dict of the most specific match, or empty |
| `type pfad` | short name (`pdf`, `png`, `zip`) or `""` |
| `mime pfad` | MIME type or `""` |
| `describe pfad` | a sentence, or `data` |
| `checkExtension pfad` | dict with `status`: `ok`, `mismatch`, `noext`, `unknown`, `unknownext` |

```tcl
package require tclutils::tufile
::tclutils::tufile::type /pfad/seite.pdf    ;# -> pdf
::tclutils::tufile::mime /pfad/seite.pdf    ;# -> application/pdf
```

For a page from pdf4tcl the type is `pdf`. According to `docs/tufile.md`,
DOCX, XLSX and PPTX share only the ZIP signature and come back as `zip`;
the module recognizes ODT, ODS and ODP by the `mimetype` entry at
byte 30.

`tufind` walks the tree in Tcl.

| Command | What comes back |
|---|---|
| `files wurzel muster ?optionen?` | files |
| `directories wurzel muster` | directories |
| `all wurzel muster` | both |
| `walk wurzel muster script` | calls the script for each match |

| Option | Default | Effect |
|---|---|---|
| `-recursive` | 1 | into subdirectories |
| `-maxdepth` | −1 | −1 means no limit |
| `-mindepth` | 0 | shallower entries are dropped |
| `-hidden` | 0 | include dot files |
| `-tails` | 0 | only the file name, not the full path |
| `-type` | | `file`, `dir`, `any` |
| `-size` | | `N`, `+N`, `-N`, plus `k`, `m`, `g` |
| `-mtime` | | age in days: `+N` older, `-N` newer |

```tcl
package require tclutils::tufind
::tclutils::tufind::files $dir *.pdf -tails 1 -maxdepth 1
```

With `-tails 1` and `-maxdepth 1` these are the names directly in
`$dir`, no paths from subdirectories.

---

## ZIP

`tuzip` reads and writes ZIP with stored and with deflate entries.
That is enough for normal archives and for ODF, which is a ZIP. It
opens binary files in binary mode.

| Command | Effect |
|---|---|
| `names archiv` | the member names |
| `entries archiv` | a dict per member |
| `readMember archiv name` | the content |
| `extract archiv name zieldatei` | writes a file |
| `create archiv dateien ?-base dir? ?-compress 1?` | new archive |
| `createMembers archiv member` | from memory; per dict `name`, `content`, `method` |

```tcl
package require tclutils::tuzip
::tclutils::tuzip::create $archiv [list $datei] -base $dir -compress 1
::tclutils::tuzip::names $archiv                 ;# -> notiz.txt
::tclutils::tuzip::readMember $archiv notiz.txt  ;# -> hallo zip
```

`-base` strips the directory from the name. The order in
`createMembers` is kept; this way an ODF puts `mimetype` as the first,
stored entry.

Since 0.2 `tuzip` writes names as UTF-8; a name with an umlaut gets the
UTF-8 flag, and `unzip`, Python and Windows read it correctly. Up to
0.1 names were Latin-1 without the flag, other programs read `Jörg` as
`J÷rg`. Reading uses `-encoding auto`: with the flag or valid UTF-8,
UTF-8, else CP437, as the ZIP format specifies. For archives from tuzip
0.1 with umlauts, pass `-encoding iso8859-1`. The provider over the same file is described in the
chapter [Providers](060-provider.md).

Paths without a file system, visible characters and amounts:
[Characters, Numbers, Dates and Paths](045-zeichen-zahlen-datum.md).

Some modules have a program under `bin/`. The list is in
`docs/guide/cli.md`. This book does not describe them one by one.

---

## In short

- `text`, `file`, `files`: string in, string or list out.
- `tuuniq` removes only neighbors. Run `tusort` first to remove all duplicates.
- `tucut` is not CSV.
- `tugrep -word` matches the word, not the start of a longer word.
- `tuzip` reads the content; the provider decides whether writing is allowed.

---

*Next chapter: [More Line Filters](042-zeilenfilter.md)*
