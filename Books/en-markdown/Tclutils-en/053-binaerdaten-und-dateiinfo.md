# Binary Data and File Information

The modules in this chapter display bytes, search and change them in a
file, compare two files, and read size and metadata. `tucode` adds the
character tables for ASCII and Latin-1. All modules are pure Tcl.

| Group | Modules |
|---|---|
| Viewing | `tuhexdump`, `tuod`, `tustrings` |
| Changing | `tuhexedit` |
| Comparing | `tucmp` |
| Size and metadata | `tusize`, `tustat` |
| Character tables | `tucode` |

Commands that take data as an argument expect bytes: a Tcl string in
which every character has a value from 0 to 255. `read` on a channel
with `-translation binary` returns such a string, and the `file`
variants of the modules read their file the same way. A text with
characters above 255, such as `€`, is not a byte string. `tuhexdump`,
`tuod`, `tustrings`, `tucmp` and `tuhexedit::writeBytes` check this up
front and throw `{TCLUTILS <MODUL> BYTES}` under both Tcl 8.6 and 9,
for example `{TCLUTILS TUOD BYTES}`. Convert text to bytes first with
`encoding convertto utf-8`.

```tcl
package require tclutils::tuod
::tclutils::tuod::bytes [encoding convertto utf-8 €]
                                          ;# -> 226 130 172
catch {::tclutils::tuod::bytes €} msg opts ;# -> 1
dict get $opts -errorcode         ;# -> TCLUTILS TUOD BYTES
```

Checksums, hashes, Base64 and line comparison are covered in the chapter
[Encoding, Hashing and Comparing](052-kodierung-hash-vergleich.md),
file type detection with `tufile` in the chapter
[Text and Files](040-text-und-dateien.md).

---

## Hexdump: tuhexdump

[tuhexdump]{.index} prints bytes as lines with an address, hex values and
an ASCII column, in the form of `hexdump -C`.

```tcl
::tclutils::tuhexdump::data bytes ?option wert ...?
::tclutils::tuhexdump::file pfad  ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-width` | `16` | bytes per line, integer of at least 1 |
| `-offset` | `0` | first byte; the address counts from here |
| `-length` | `-1` | number of bytes; negative means up to the end |

The return value is a string with lines separated by `\n`, without a
trailing `\n`. Each line has the address with eight hex digits, the
bytes in lowercase, and between `|` the characters 32 to 126; every
other byte appears there as `.`. The last line is padded with spaces
to the full width. Empty data yields an empty string.

Differences from `hexdump -C` and `xxd`: no gap after the eighth byte,
no folding of identical lines into `*`, no final line with the end
address.

```tcl
package require tclutils::tuhexdump
set daten "Hallo, Welt!\n\x00\x01\xff"
puts [::tclutils::tuhexdump::data $daten -width 8]
```

```text
00000000  48 61 6c 6c 6f 2c 20 57  |Hallo, W|
00000008  65 6c 74 21 0a 00 01 ff  |elt!....|
```

```tcl
::tclutils::tuhexdump::data "Hallo, Welt!" -offset 7 -length 4 -width 4
                              ;# -> 00000007  57 65 6c 74  |Welt|
```

At the default width a line is 77 characters long.

| Error | `-errorcode` |
|---|---|
| `-width` not an integer of at least 1 | `{TCLUTILS COMMON INTEGER -width}` |
| `-offset` negative or not an integer | `{TCLUTILS TUHEXDUMP OFFSET}` |
| `-length` not an integer | `{TCLUTILS TUHEXDUMP LENGTH}` |
| characters above 255 in the data | `{TCLUTILS TUHEXDUMP BYTES}` |
| unknown option, option without value | `{TCLUTILS COMMON OPTION -name}` |

---

## Octal, Decimal, Characters: tuod

[tuod]{.index} prints bytes one by one as octal, hex or decimal numbers or
as characters. `bytes` returns the byte values as an unsigned list;
`binary scan` with `c` alone would give the value `-1` for `\xff`.

```tcl
::tclutils::tuod::bytes bytes ?option wert ...?
::tclutils::tuod::data  bytes ?option wert ...?
::tclutils::tuod::file  pfad  ?option wert ...?
```

| Option | Default | Effect |
|---|---|---|
| `-format` | `octal` | `octal` (`%03o`), `hex` (`%02x`), `decimal` (`%03d`), `char` |
| `-width` | `16` | bytes per line, at least 1 |
| `-offset` | `0` | first byte |
| `-length` | `-1` | number of bytes; negative means up to the end |
| `-address` | `hex` | `hex` (8 digits), `octal` (7), `decimal` (8), `none` |

`-format char` shows the characters 32 to 126 and `.` otherwise. Two
spaces separate the address from the values, one space separates the
values. `bytes` evaluates only `-offset` and `-length` and accepts the
other options without effect.

Differences from `od`: Unix `od` without options shows two-byte words
in octal and the address in octal. `tuod` shows each byte on its own
and the address in hex; `-address octal` gives the address as `od`
does. Instead of `\n` and `\0` as in `od -c`, `.` appears. Identical
lines are not folded into `*`, and there is no final line with the end
address.

```tcl
package require tclutils::tuod
::tclutils::tuod::bytes "A\x00\xff"       ;# -> 65 0 255
::tclutils::tuod::data ABC                ;# -> 00000000  101 102 103
::tclutils::tuod::data "Hallo\n" -format hex -address none
                                          ;# -> 48 61 6c 6c 6f 0a
::tclutils::tuod::data abcdef -format char -offset 2 -length 3
                                          ;# -> 00000002  c d e
set daten "Hallo\n\x00\xff"
puts [::tclutils::tuod::data $daten -format char \
    -address octal -width 4]
```

```text
0000000  H a l l
0000004  o . . .
```

| Error | `-errorcode` |
|---|---|
| unknown `-format` | `{TCLUTILS TUOD FORMAT wert}` |
| unknown `-address` | `{TCLUTILS TUOD ADDRESS wert}` |
| `-width` not an integer of at least 1 | `{TCLUTILS TUOD WIDTH}` |
| `-offset` negative or not an integer | `{TCLUTILS TUOD OFFSET}` |
| `-length` not an integer | `{TCLUTILS TUOD LENGTH}` |
| characters above 255 in the data | `{TCLUTILS TUOD BYTES}` |
| unknown option, option without value | `{TCLUTILS COMMON OPTION -name}` |

`data` and `file` check `-format` and `-address` before the first byte,
so a wrong value is caught even with empty data.

---

## Readable Strings: tustrings

[tustrings]{.index} searches binary data for runs of printable ASCII
characters, like Unix `strings`.

```tcl
::tclutils::tustrings::extract bytes ?-minlength n?
::tclutils::tustrings::file    pfad  ?-minlength n?
```

| Option | Default | Effect |
|---|---|---|
| `-minlength` | `4` | shorter runs are discarded; integer of at least 1 |

Bytes 32 to 126 are printable. Every other byte ends a run, including
tab and end of line. The return value is a Tcl list of the runs in
order of occurrence, without positions.

Differences from `strings`: GNU `strings` counts the tab as part of the
string, `tustrings` splits there. There is no position output like
`strings -t`. Umlauts are not printable ASCII characters, in Latin-1
either, and also split.

```tcl
package require tclutils::tustrings
set bin "\x00\x01%PDF-1.7\x00ab\x00Hallo Welt\n\xffKey\tWert"
::tclutils::tustrings::extract $bin  ;# -> %PDF-1.7 {Hallo Welt} Wert
::tclutils::tustrings::extract $bin -minlength 2
                          ;# -> %PDF-1.7 ab {Hallo Welt} Key Wert
::tclutils::tustrings::extract "Größe 12"  ;# -> {e 12}
```

There is no `-encoding` option; the printable bytes are always 32 to
126.

| Error | `-errorcode` |
|---|---|
| `-minlength` not an integer of at least 1 | `{TCLUTILS COMMON INTEGER -minlength}` |
| characters above 255 in the data | `{TCLUTILS TUSTRINGS BYTES}` |
| unknown option, option without value | `{TCLUTILS COMMON OPTION -name}` |

---

## Reading, Searching, Patching: tuhexedit

[tuhexedit]{.index} reads bytes at a position, searches for byte and text
patterns, and overwrites bytes in the file. It is a library, not an
editor with a user interface. Unix has no single tool for this;
overwriting at a fixed position corresponds to `dd ... conv=notrunc`.

```tcl
::tclutils::tuhexedit::readBytes  pfad offset länge
::tclutils::tuhexedit::writeBytes pfad offset bytes ?sicherung?
::tclutils::tuhexedit::patch      pfad offset hex ?-backup 1?
::tclutils::tuhexedit::backup     pfad ?zielname?
::tclutils::tuhexedit::findHex    pfad hex
::tclutils::tuhexedit::findString pfad text ?kodierung?
::tclutils::tuhexedit::dump       pfad ?option wert ...?
```

| Command | Return value |
|---|---|
| `readBytes` | the bytes; fewer at the end of the file, empty past the end |
| `writeBytes`, `patch` | the path, as passed |
| `backup` | the name of the copy; default `pfad.bak` |
| `findHex`, `findString` | list of offsets from 0, overlapping matches included |
| `dump` | hexdump like `tuhexdump::file`, with its options |

An offset is an integer from 0 or hex with `0x`, such as `0x100`;
`0x` without a valid hex digit is an error.
Hex patterns for `findHex` and `patch` may contain spaces, `:`, `-`,
`,` and `0x` before each byte; `{50 4B 03 04}`, `504b0304` and
`0x50,0x4B,0x03,0x04` are the same pattern. `findString` converts the
text to bytes with the encoding before searching, default `utf-8`. An
`ä` in a Latin-1 file is therefore found only by
`findString pfad ä iso8859-1`. A character the encoding cannot represent is an
error.

`writeBytes` and `patch` first create a copy `pfad.bak` and overwrite
an existing copy. `writeBytes` with `0` as the fourth argument and
`patch` with `-backup 0` skip the copy. The file is overwritten in
place; nothing is inserted or removed, and the file length stays the
same. If the bytes from the offset reach past the end of the file, the
command throws an error before it creates the copy; file and copy then
stay unchanged. `findHex`, `findString` and `patch` read the whole
file, `readBytes` only the requested part.

```tcl
package require tclutils::tuhexedit
set fh [open probe.bin wb]
puts -nonewline $fh ABCDEFGH
close $fh
::tclutils::tuhexedit::readBytes probe.bin 2 3    ;# -> CDE
::tclutils::tuhexedit::findString probe.bin CD    ;# -> 2
::tclutils::tuhexedit::findHex probe.bin {47 48}  ;# -> 6
::tclutils::tuhexedit::patch probe.bin 0x2 {58 59}
                                          ;# -> probe.bin
::tclutils::tuhexedit::readBytes probe.bin 0 8    ;# -> ABXYEFGH
::tclutils::tuhexedit::readBytes probe.bin.bak 0 8
                                          ;# -> ABCDEFGH
::tclutils::tuhexedit::dump probe.bin -width 8
              ;# -> 00000000  41 42 58 59 45 46 47 48  |ABXYEFGH|
catch {::tclutils::tuhexedit::patch probe.bin 7 {58 59}} msg opts
                                          ;# -> 1
dict get $opts -errorcode     ;# -> TCLUTILS TUHEXEDIT RANGE
```

| Error | `-errorcode` |
|---|---|
| offset negative, not a number, or `0x` without a hex digit | `{TCLUTILS TUHEXEDIT OFFSET}` |
| length negative or not a number | `{TCLUTILS TUHEXEDIT LENGTH}` |
| writing past the end of the file | `{TCLUTILS TUHEXEDIT RANGE}` |
| `writeBytes` with characters above 255 | `{TCLUTILS TUHEXEDIT BYTES}` |
| character not in the encoding (`findString`) | `{TCLUTILS TUHEXEDIT ENCODING}` |
| empty search pattern | `{TCLUTILS TUHEXEDIT NEEDLE}` |
| hex with an odd number of digits | `{TCLUTILS TUBIN HEX ODD}` |
| hex with other characters | `{TCLUTILS TUBIN HEX BADCHAR}` |
| unknown option to `patch` | `{TCLUTILS COMMON OPTION -name}` |
| unknown encoding | `{TCL LOOKUP ENCODING name}` |
| file missing | `{POSIX ENOENT ...}` |

`writeBytes` does not create a new file; a missing file throws
`{POSIX ENOENT ...}`. All checks run before writing, so a rejected
call changes nothing.

---

## Comparing Byte by Byte: tucmp

[tucmp]{.index} compares two byte strings or two files and reports the
first difference, like Unix `cmp`.

```tcl
::tclutils::tucmp::data            bytes1 bytes2
::tclutils::tucmp::files           pfad1 pfad2
::tclutils::tucmp::equal           pfad1 pfad2
::tclutils::tucmp::firstDifference pfad1 pfad2
```

`data` and `files` return a dict:

| Key | Content |
|---|---|
| `equal` | `1` for identical data, `0` otherwise |
| `offset` | first differing position from 0; `-1` for identical data |
| `byte1`, `byte2` | byte value 0–255 at `offset`; empty where the data has ended |
| `size1`, `size2` | number of bytes of both data |

`equal` returns only `equal`, `firstDifference` only `offset`. If one
side is the beginning of the other, `offset` is set to the length of
the shorter side and its byte is empty.

Differences from `cmp`: the offset counts from 0, `cmp` counts byte and
line from 1. There is no line number, and the result is a dict instead
of an exit status. `files` reads both files completely into memory.

```tcl
package require tclutils::tucmp
dict get [::tclutils::tucmp::data abc abc] equal    ;# -> 1
dict get [::tclutils::tucmp::data abc abc] offset   ;# -> -1
::tclutils::tucmp::data abc abx
::tclutils::tucmp::data abc abcd
```

```text
equal 0 offset 2 byte1 99 byte2 120 size1 3 size2 3
equal 0 offset 3 byte1 {} byte2 100 size1 3 size2 4
```

`data` compares bytes. A character above 255 is an error, even if both
strings are equal; convert text first with
`encoding convertto`.

```tcl
set cmp [::tclutils::tucmp::data [encoding convertto utf-8 a€] \
    [encoding convertto utf-8 aä]]
dict get $cmp byte1                       ;# -> 226
dict get $cmp size1                       ;# -> 4
```

| Error | `-errorcode` |
|---|---|
| characters above 255 in `data` | `{TCLUTILS TUCMP BYTES}` |
| file missing | `{POSIX ENOENT ...}` |

---

## Sizes: tusize

[tusize]{.index} adds up file sizes below a directory and writes byte
counts in readable form, a small `du`.

```tcl
::tclutils::tusize::bytes   pfad
::tclutils::tusize::entries verzeichnis
::tclutils::tusize::human   n ?-si 0|1?
```

| Command | Return value |
|---|---|
| `bytes` | size of the file, or the sum of all files below it |
| `entries` | list `{bytes pfad}` per direct entry, sorted by path |
| `human` | number with unit |

| Option `human` | Default | Effect |
|---|---|---|
| `-si` | `0` | `0`: base 1024, `B KiB MiB GiB TiB PiB EiB ZiB YiB`; `1`: base 1000, `B kB MB GB TB PB EB ZB YB` |

`bytes` includes dot files. It counts the file size, not the space used
on disk, and the directories themselves do not count. Below the base,
`human` prints the integer with `B`, otherwise the value with one
decimal place. It does not go beyond `YiB` (`YB`); larger values stay
in that unit.

The unit always names its base: `KiB` is 1024, `kB` is 1000. 1500 and
1536 bytes are both `1.5 KiB` because only one decimal is shown.
`tunumfmt::toHuman` instead writes the bare `K` for 1000 like `numfmt`
(`1.5K`); for bytes use `-to iec` there (`1.5Ki`).

`bytes` does not descend into a symbolic link and does not follow it.
It counts the link itself with `file lstat`; under Unix its size is the
length of the target path. This applies to links to files, links to
directories and links without a target. A circular link therefore does
not lead to a loop.

Differences from `du`: without options `du` counts used blocks and the
directories themselves. `tusize::bytes` is closer to `du -sb`, without
the directory entries.

```tcl
package require tclutils::tusize
file mkdir projekt/sub
foreach {pfad n} {projekt/a.txt 100 projekt/sub/b.bin 3000} {
    set fh [open $pfad wb]
    puts -nonewline $fh [string repeat x $n]
    close $fh
}
::tclutils::tusize::bytes projekt        ;# -> 3100
::tclutils::tusize::entries projekt
                          ;# -> {100 projekt/a.txt} {3000 projekt/sub}
::tclutils::tusize::human 500            ;# -> 500 B
::tclutils::tusize::human 1536           ;# -> 1.5 KiB
::tclutils::tusize::human 1500 -si 1     ;# -> 1.5 kB
::tclutils::tusize::human 5368709120     ;# -> 5.0 GiB
::tclutils::tusize::human [expr {2**70}] ;# -> 1.0 ZiB
```

On a real tree the sum depends on the content; the result of `entries`
then has the same form, a list of pairs of number and
path.

| Error | `-errorcode` |
|---|---|
| path missing (`bytes`) | `{TCLUTILS TUSIZE NOTFOUND}` |
| not a directory or missing (`entries`) | `{TCLUTILS TUSIZE NOTDIR}` |
| `n` not an integer (`human`) | `{TCLUTILS TUSIZE VALUE}` |
| `-si` not a boolean | `{TCLUTILS COMMON BOOLEAN -si}` |
| unknown option | `{TCLUTILS COMMON OPTION -name}` |

---

## Metadata: tustat

[tustat]{.index} returns the values of `file stat` as a dict and formats a
selection of them as text, similar to Unix `stat`.

```tcl
::tclutils::tustat::file   pfad
::tclutils::tustat::files  pfade
::tclutils::tustat::render dict ?-timeformat format?
```

`file` returns a dict with the keys from `file stat` (`atime`,
`blksize`, `blocks`, `ctime`, `dev`, `gid`, `ino`, `mode`, `mtime`,
`nlink`, `size`, `uid`) plus `path` (as passed), `normalized`
(result of `file normalize`), `type` (result of `file type`:
`file`, `directory`, `link` and so on) and `modeOctal` (`mode` in the
familiar octal form, such as `100644`). For a link, `target` is added,
the result of `file readlink`. `files` returns a list of such dicts in
the order of the paths.

| Option `render` | Default | Effect |
|---|---|---|
| `-timeformat` | `%Y-%m-%d %H:%M:%S` | format for `clock format`, local time |

`render` prints the fields `path`, `type`, `size`, `mtime`, `mode`,
`ino`, `dev`, `uid` and `gid` in this order, one per line, with the
name padded to ten characters followed by the value. If a field is
missing from the dict, its line is missing. `render` prints no other
fields.

`file` does not follow a link, like Unix `stat` without `-L`: size,
permissions and times come from `file lstat` and belong to the link
itself. A link without a target is therefore not an error. `mode` is a
decimal number with file type and permissions; `render` prints it as
such.

```tcl
package require tclutils::tustat
set d [::tclutils::tustat::file projekt/a.txt]
dict get $d size                          ;# -> 100
dict get $d type                          ;# -> file
dict get $d path                          ;# -> projekt/a.txt
llength [::tclutils::tustat::files {projekt/a.txt projekt}]
                                          ;# -> 2
file link -symbolic projekt/l.txt a.txt
set l [::tclutils::tustat::file projekt/l.txt]
dict get $l type                          ;# -> link
dict get $l target                        ;# -> a.txt
puts [::tclutils::tustat::render $d]
```

The output of `render` has this form; time, permissions and numbers
depend on the file and the machine:

```text
path       projekt/a.txt
type       file
size       100
mtime      JJJJ-MM-TT hh:mm:ss
mode       Dezimalzahl
ino        Dezimalzahl
dev        Dezimalzahl
uid        Dezimalzahl
gid        Dezimalzahl
```

`file` and `files` have no error codes of their own; a missing path
throws `{POSIX ENOENT ...}` from `file type`.
An unknown option to `render` throws
`{TCLUTILS COMMON OPTION -name}`.

---

## Character Tables: tucode

[tucode]{.index} prints tables of the characters 0 to 255, ASCII and
Latin-1, plus selected character groups, and looks up single
characters. The Unix counterparts are the manual pages `ascii(7)` and
`iso_8859-1(7)`.

```tcl
::tclutils::tucode::lookup     wert
::tclutils::tucode::lookupChar zeichen
::tclutils::tucode::table      von bis ?option wert ...?
::tclutils::tucode::render     von bis ?option wert ...?
::tclutils::tucode::ascii      ?option wert ...?
::tclutils::tucode::latin1     ?option wert ...?
::tclutils::tucode::ansi       ?option wert ...?
::tclutils::tucode::signs      ?gruppe ...? ?option wert ...?
::tclutils::tucode::groups
```

`lookup` takes a decimal number, hex with `0x`, a code point with `U+`
(`U+00E4`, also lowercase `u+e4`) or a Latin-1 character. With several
characters the first one counts. An empty value, a character above 255
and a code point above `U+00FF` are errors. `lookupChar` is the same
command. The return value is a dict:

| Key | Content |
|---|---|
| `code` | value 0–255 |
| `hex`, `oct` | two uppercase hex digits, three octal digits |
| `glyph` | display: `^@` to `^_` and `^?` for control characters, `SP` for the space, `.` for 128–159 and the soft hyphen |
| `name` | short name: `NUL`, `DEL`, `nbsp`, `ssharp`, `auml`; for 32–126 the character itself |
| `char` | the character |

`table` and `render` are the same command for the range `von` to
`bis`, both from 0 to 255. `ascii` is `0 127`, `latin1` is
`128 255`, `ansi` is `latin1`. The entries run column by column from
top to bottom.

| Option | Default | Effect |
|---|---|---|
| `-columns` | `4` | columns side by side |
| `-showName` | `1` | short name per entry |
| `-compact` | `0` | `1`: matrix with 16 characters per line, display only |

In the full table each name is padded to the length of the longest
name in the range, so the columns line up. With four columns it is 73
characters wide for ASCII and 85 for Latin-1.

`signs` prints groups with a title, a rule and one entry per line;
without a group, all of them. `groups` returns the names sorted. The
groups `controls`, `whitespace`, `quotes`, `dashes`, `german`,
`currency`, `math` and `latin1hi` contain Latin-1 characters; `arrows`,
`boxdraw` and `boxdraw2` contain Unicode characters above 255 and show
them as `U+XXXX`. `signs` accepts the options before or after the
groups; the effective one there is `-showName`.

```tcl
package require tclutils::tucode
::tclutils::tucode::lookup 0xDF
```

```text
code 223 hex DF oct 337 glyph ß name ssharp char ß
```

```tcl
dict get [::tclutils::tucode::lookup 65] name       ;# -> A
dict get [::tclutils::tucode::lookup ä] code        ;# -> 228
dict get [::tclutils::tucode::lookup U+00E4] name   ;# -> auml
dict get [::tclutils::tucode::lookup 0] glyph       ;# -> ^@
dict get [::tclutils::tucode::lookup 160] name      ;# -> nbsp
puts [::tclutils::tucode::table 0 7 -columns 2]
puts [::tclutils::tucode::table 64 95 -compact 1]
puts [::tclutils::tucode::signs currency]
puts [::tclutils::tucode::signs dashes -showName 0]
```

```text
Dec Hex  Chr  Name
----------------------------------------
  0 00  ^@   NUL |   4 04  ^D   EOT
  1 01  ^A   SOH |   5 05  ^E   ENQ
  2 02  ^B   STX |   6 06  ^F   ACK
  3 03  ^C   ETX |   7 07  ^G   BEL

    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
40  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O
50  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _

Currency symbols
----------------------------------------
 36 24  $    $
162 A2  ¢    cent
163 A3  £    pound
164 A4  ¤    curren
165 A5  ¥    yen
Dashes and hyphen
----------------------------------------
 45 2D  -
173 AD  .
```

In the compact form each cell is three characters wide; the digits of
the header line stand above their columns.

| Error | `-errorcode` |
|---|---|
| value outside 0–255, `von` > `bis`, not an integer | `{TCLUTILS TUCODE RANGE}` |
| empty value, character above 255 (`lookup €`), `U+` above `U+00FF` | `{TCLUTILS TUCODE LOOKUP}` |
| unknown group | `{TCLUTILS TUCODE GROUP}` |
| `-columns` not an integer of at least 1 | `{TCLUTILS COMMON INTEGER -columns}` |
| `-showName`, `-compact` not a boolean | `{TCLUTILS COMMON BOOLEAN -name}` |
| unknown option, option without value | `{TCLUTILS COMMON OPTION -name}` |

---

## In short

- Data commands expect bytes 0–255. Convert text first with
  `encoding convertto utf-8`; otherwise
  `{TCLUTILS <MODUL> BYTES}` follows.
- `tuhexdump` and `tuod` do not fold identical lines.
- `tustrings` splits at the tab.
- `patch` and `writeBytes` create a `.bak` copy unless given
  `-backup 0` or `0`, insert nothing, and do not write past the end of
  the file.
- `tucmp` counts the offset from 0, not from 1 like `cmp`.
- `tusize` counts file sizes, not blocks; links with their own
  size.
- `tustat::file` does not follow links; `target` names the target.

---

*Next chapter: [Notes and Calendars](054-notizen-und-kalender.md)*
