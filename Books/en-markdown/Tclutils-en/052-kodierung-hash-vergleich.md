# Encoding, Hashing and Comparing

Base64 and Base32, CRC, the digests and xxHash32, changing the
encoding, UUIDs, query strings, nested dicts, a
line comparison and applying a diff. Everything is in the umbrella. CRC uses `zlib` from
Tcl itself; the digests are pure Tcl and need no tcllib.

---

## Base64: tubase64

`encode` and `decode` go through `binary encode`/`decode base64`.
`encodeFile` reads the file in binary mode, `decodeFile` reads the text.

| Option | Default | Effect |
|---|---|---|
| `-maxlen` | `0` | line break after this many characters; `0` keeps the line whole |

```tcl
package require tclutils::tubase64
::tclutils::tubase64::encode hallo          ;# -> aGFsbG8=
::tclutils::tubase64::decode aGFsbG8=       ;# -> hallo
::tclutils::tubase64::encode hallohallo -maxlen 4
                                          ;# -> aGFs\nbG9o\nYWxs\nbw==
```

`-maxlen -1` throws `{TCLUTILS TUBASE64 MAXLEN}`. A text without valid
Base64, such as `!!!`, comes back as an empty string, without an
error code.

---

## Base32: tubase32

[tubase32]{.index} encodes according to RFC 4648, optionally with the
base32hex alphabet. Tcl itself provides only Base64; the implementation is pure
Tcl. `encodeFile` reads the file in binary mode, `decodeFile` reads the text.

| Command | Effect |
|---|---|
| `encode daten ?-pad b? ?-hex b?` | Base32 text in uppercase |
| `decode text ?-hex b?` | the bytes |
| `encodeFile pfad ?-pad b? ?-hex b?` | the bytes of the file, encoded |
| `decodeFile pfad ?-hex b?` | the text of the file, decoded |

| Option | Default | Effect |
|---|---|---|
| `-pad` | `1` | pads with `=` to a full group of eight characters; `0` omits it |
| `-hex` | `0` | `1` uses the alphabet `0`–`9`, `A`–`V` (base32hex, RFC 4648 §7) |

`decode` skips `=`, space, tab and newline and
accepts lowercase as well as uppercase letters. `decode` checks the end as in RFC 4648
§3.5: the number of characters must be one that `encode` produces (a
multiple of 8 plus 0, 2, 4, 5 or 7), and the bits after the last
full byte must be 0. `decode MY` gives `f`, `decode MZ` is an
error.

```tcl
package require tclutils::tubase32
::tclutils::tubase32::encode foobar        ;# -> MZXW6YTBOI======
::tclutils::tubase32::encode foobar -pad 0 ;# -> MZXW6YTBOI
::tclutils::tubase32::encode foobar -hex 1 ;# -> CPNMUOJ1E8======
::tclutils::tubase32::decode mzxw6ytboi    ;# -> foobar
::tclutils::tubase32::encode [encoding convertto utf-8 Größe]
                                          ;# -> I5ZMHNWDT5SQ====
::tclutils::tubase32::decode MY            ;# -> f
catch {::tclutils::tubase32::decode MZ} m o
dict get $o -errorcode                     ;# -> TCLUTILS TUBASE32 BITS
```

The input of `encode` is bytes. A character above 255 throws
`{TCL VALUE BYTES}` under Tcl 9.0; under Tcl 8.6 only the lower byte
is kept, silently. Text must therefore go through `encoding convertto utf-8` first.

Unlike `tubase64`, `tubase32` does not return an empty string for
invalid text but throws an error. A character outside the
alphabet throws `{TCLUTILS TUBASE32 CHAR}`, for example
`invalid base32 character: "1"`. An impossible length such as `MZX` throws
`{TCLUTILS TUBASE32 LENGTH}`, nonzero bits at the end as with `MZ`
`{TCLUTILS TUBASE32 BITS}`. An invalid boolean word for
`-pad` or `-hex` throws `{TCLUTILS COMMON BOOLEAN -pad}` or `-hex` respectively.

---

## CRC: tucrc

`crc32` and `adler32` pass the bytes on to `zlib`. A second
argument is the start value for a continued checksum. `hex32` turns
it into eight hex characters in uppercase. `crc32File` and
`adler32File` read the file in binary mode.

```tcl
package require tclutils::tucrc
::tclutils::tucrc::crc32 hallo              ;# -> 3111268817
::tclutils::tucrc::hex32 [::tclutils::tucrc::crc32 hallo]
                                          ;# -> B97231D1
::tclutils::tucrc::adler32 hallo            ;# -> 102498833
```

A wrong argument counts as `wrong # args`, without its own
`-errorcode`.

---

## Digests: tuhash

`sha256`, `sha1` and `md5` are separate implementations of FIPS 180-4 and
RFC 1321. The file commands hash the bytes of the file. For text,
`-encoding` applies:

| Value | Effect |
|---|---|
| `utf-8` | default; the text is first converted to UTF-8 |
| `binary` | each character is one byte 0–255 |

```tcl
package require tclutils::tuhash
::tclutils::tuhash::sha256 ""               ;# -> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
::tclutils::tuhash::sha256 abc              ;# -> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
::tclutils::tuhash::md5 ""                  ;# -> d41d8cd98f00b204e9800998ecf8427e
::tclutils::tuhash::sha1 ""                 ;# -> da39a3ee5e6b4b0d3255bfef95601890afd80709
```

Another encoding throws `{TCLUTILS TUHASH ENCODING}`. The same
empty digests are the test vectors of the standards.

---

## xxHash32: tuxxhash

[tuxxhash]{.index} computes XXH32, a fast hash without cryptographic
claims, in pure Tcl. It serves to detect changes and to
pre-sort possible duplicates, not to protect against forgery.
There are no 64-bit or 128-bit variants.

| Command | Effect |
|---|---|
| `xxh32 daten ?seed? ?-encoding e?` | eight hex characters in lowercase |
| `xxh32file pfad ?seed?` | the same for the bytes of the whole file |

`seed` is an integer, default `0`. Only its lower
32 bits count. As with `tuhash`, `-encoding` applies to text; it comes after
`seed`:

| Value | Effect |
|---|---|
| `utf-8` | default; the text is first converted to UTF-8 |
| `binary` | each character is one byte 0–255 |

```tcl
package require tclutils::tuxxhash
::tclutils::tuxxhash::xxh32 ""              ;# -> 02cc5d05
::tclutils::tuxxhash::xxh32 hello           ;# -> fb0077f9
::tclutils::tuxxhash::xxh32 hello 1         ;# -> fcfffba9
::tclutils::tuxxhash::xxh32 Größe           ;# -> 3a44ca22
set b [encoding convertto utf-8 Größe]
::tclutils::tuxxhash::xxh32 $b 0 -encoding binary
                                          ;# -> 3a44ca22
```

`xxh32 Größe` hashes the seven UTF-8 bytes and matches `xxh32file`
of a UTF-8 file with this text. A character above 255 such as
`€` works the same way. `-encoding binary` takes the characters as bytes, for example
for data from `binary format` or from a channel with
`-translation binary`.

A `seed` that is not an integer throws `{TCLUTILS TUXXHASH SEED}`.
Another value for `-encoding` throws `{TCLUTILS TUXXHASH ENCODING}`,
a character above 255 with `-encoding binary`
`{TCLUTILS TUXXHASH BYTES}`, an argument other than `-encoding`
`{TCLUTILS TUXXHASH OPTION}`.
A file that cannot be opened throws
`{TCLUTILS TUXXHASH IO}`. With 32 bits, random collisions occur in large
collections; equal values are only candidates for a
comparison of the bytes or with `sha256`.

---

## Changing the Encoding: tuiconv

[tuiconv]{.index} converts between the encodings Tcl knows, and reads
and writes files with an explicit encoding. The channels are
binary; the conversion is done with `encoding convertfrom` and
`encoding convertto`.

| Command | Effect |
|---|---|
| `encodings` | the names from `encoding names`, sorted |
| `convert bytes von nach` | bytes in `von` to bytes in `nach` |
| `readFile pfad kodierung` | the text of the file |
| `writeFile pfad text kodierung` | writes the file, returns `pfad` |
| `convertFile ein aus von nach` | reads `ein`, writes `aus`, returns `aus` |

A name must appear exactly in `encoding names`, such as `utf-8`,
`iso8859-1` or `cp1252`. Spellings such as `utf8` or `latin1`
throw `{TCLUTILS TUICONV ENCODING name}` with
`unknown encoding "utf8"`. The list is longer under Tcl 9.0 than
under 8.6.

```tcl
package require tclutils::tuiconv
set utf8 [encoding convertto utf-8 Größe]
set cp [::tclutils::tuiconv::convert $utf8 utf-8 cp1252]
binary encode hex $cp                       ;# -> 4772f6df65
set zurueck [::tclutils::tuiconv::convert $cp cp1252 utf-8]
encoding convertfrom utf-8 $zurueck         ;# -> Größe
```

For a character the target encoding does not know, or for
invalid bytes, the versions differ. Tcl 9.0 throws
`{TCL ENCODING ILLEGALSEQUENCE 0}`, for example for `ł` to `cp1252`.
Tcl 8.6 silently inserts `?` or reads the byte as a single character.

---

## UUID: tuuuid

`v4` is random, `v7` carries the Unix time in milliseconds in the
first 48 bits and random data after that (RFC 9562). `generate` takes
`-version` `4` or `7`, default `4`. `nil` is the nil UUID.
`validate` checks the form `8-4-4-4-12`, upper and lower case.
`version` reads the digit at position 14.

```tcl
package require tclutils::tuuuid
::tclutils::tuuuid::nil                     ;# -> 00000000-0000-0000-0000-000000000000
::tclutils::tuuuid::validate [::tclutils::tuuuid::nil]
                                          ;# -> 1
::tclutils::tuuuid::version [::tclutils::tuuuid::nil]
                                          ;# -> 0
::tclutils::tuuuid::version [::tclutils::tuuuid::v4]
                                          ;# -> 4
::tclutils::tuuuid::version [::tclutils::tuuuid::v7]
                                          ;# -> 7
```

`version nein` throws `{TCLUTILS TUUUID INVALID}`. `generate -version 9`
throws `{TCLUTILS TUUUID VERSION}`. The random bytes come from
`/dev/urandom`, otherwise from `rand()`.

---

## Query Strings: tuurl

Letters, digits and `-._~` stay unreserved. Everything else
is percent-encoded with `%` over the UTF-8 bytes.

| Command | `-plus` | Effect |
|---|---|---|
| `encode`, `decode` | `0` | space becomes `%20`; `+` stays `+` |
| `buildQuery`, `parseQuery` | `1` | space becomes `+`, and `+` becomes a space again when reading |

```tcl
package require tclutils::tuurl
::tclutils::tuurl::encode "a b"             ;# -> a%20b
::tclutils::tuurl::encode "a b" -plus 1     ;# -> a+b
::tclutils::tuurl::encode Größe             ;# -> Gr%C3%B6%C3%9Fe
::tclutils::tuurl::decode %C3%BC            ;# -> ü
::tclutils::tuurl::buildQuery {ort {Nord Lager} gang 3}
                                          ;# -> ort=Nord+Lager&gang=3
::tclutils::tuurl::parseQuery {ort=Nord+Lager&gang=3}
                                          ;# -> ort {Nord Lager} gang 3
```

A key without `=` gets the empty value. An invalid
boolean word for `-plus` throws `{TCLUTILS COMMON BOOLEAN -plus}`.

---

## Nested Dicts: tudict

The core already does `dict get $d a b`. [tudict]{.index} adds the path with
a default, the leaf paths, a flat form, deep merging and
inverting.

| Command | Effect |
|---|---|
| `getOr dict vorgabe schlüssel …` | the value, or the default if a key is missing |
| `paths dict` | leaf paths, each path a list of keys |
| `flatten dict ?sep?` | a flat dict, keys joined with `.` |
| `mergeDeep dict …` | from left to right; nested dicts merge, scalars overwrite |
| `invert dict` | swaps key and value; for a duplicate value the last one wins |

The default comes before the path.

```tcl
package require tclutils::tudict
::tclutils::tudict::getOr {ui {theme dark}} - ui theme
                                          ;# -> dark
::tclutils::tudict::getOr {ui {theme dark}} - ui fehlt
                                          ;# -> -
::tclutils::tudict::paths {a {b {c 1}} d 2}
                                          ;# -> {a b c} d
::tclutils::tudict::flatten {a {b {c 1}} d 2}
                                          ;# -> a.b.c 1 d 2
::tclutils::tudict::invert {a 1 b 2}        ;# -> 1 a 2 b
::tclutils::tudict::invert {a 1 b 1}        ;# -> 1 b
```

Without a key, `getOr` throws `{TCLUTILS TUDICT ARG}`. A value that looks like
a dict becomes one: `flatten` of `{name {a b}}` gives
`name.a b`, because `a b` has an even length. `mergeDeep` is shown with an
example in the appendix [Practice](850-praxis-und-fehlerfaelle.md).

---

## Line Comparison: tudiff

`text` returns a list of `equal`, `delete` and `insert`, each
with the line. `unifiedText` builds a unified diff from it,
`contextText` the context form. `files`, `unified` and `context` read
two files. `directory` compares two trees.

| Option | Default | Effect |
|---|---|---|
| `-maxcells` | `2000000` | upper limit for the table, old lines times new lines |
| `-fromlabel`, `-tolabel` | `old`, `new` | header lines of `unifiedText` and `contextText` |

```tcl
package require tclutils::tudiff
::tclutils::tudiff::text "a\nb" "a\nc"      ;# -> {equal a} {delete b} {insert c}
::tclutils::tudiff::unifiedText "a\nb" "a\nc"
                                          ;# -> --- old\n+++ new\n@@ -1,2 +1,2 @@\n a\n-b\n+c
```

`-maxcells 0` throws `{TCLUTILS TUDIFF OPTION MAXCELLS}`. Two texts with
two lines each and `-maxcells 1` throw `{TCLUTILS TUDIFF TOO_LARGE}`,
because 2 × 2 exceeds the limit.

---

## Applying a Diff: tupatch

[tupatch]{.index} is the counterpart of `tudiff`: it applies a unified
diff to a text. That can be the output of `unifiedText`,
but also `diff -u` or `git diff` with several hunks.

| Command | Effect |
|---|---|
| `text quelle patch ?optionen?` | the changed text |
| `fromFile pfad patch ?optionen?` | like `text`, with the source from the file |
| `parse patch` | list of the hunks as dicts |

| Option | Default | Effect |
|---|---|---|
| `-reverse` | `0` | `1` applies the diff in reverse and so undoes it |
| `-strict` | `1` | checks context and deletion lines against the source; `0` follows the diff blindly |

A hunk from `parse` has `oldStart`, `oldLen`, `newStart`,
`newLen` and `body`. `body` is a list of pairs of kind (` `,
`+`, `-`) and line. Header lines such as `---`, `+++`, `diff` and `index`
are dropped, as is `\ No newline at end of file`. An empty line
ends a hunk.

Each hunk applies at the line from its header. `tupatch` does not
search for an offset. The lines are joined with `\n`; a
line break at the end of the source is missing from the result. If the diff
has no hunk, the source comes back unchanged.

```tcl
package require tclutils::tudiff
package require tclutils::tupatch
set alt "alpha\nbeta\ngamma"
set neu "alpha\nBETA\ngamma"
set p [::tclutils::tudiff::unifiedText $alt $neu]
::tclutils::tupatch::text $alt $p           ;# -> alpha\nBETA\ngamma
::tclutils::tupatch::text $neu $p -reverse 1
                                          ;# -> alpha\nbeta\ngamma
llength [::tclutils::tupatch::parse $p]     ;# -> 1
```

If a line does not match, `text` throws `{TCLUTILS TUPATCH CONTEXT}`,
for example with the source `alpha\nbeta\nGAMMA`:
`patch does not apply: expected "gamma" but found "GAMMA" at source
line 3`. A hunk beyond the end of the source, or one that overlaps
an earlier one, throws `{TCLUTILS TUPATCH RANGE}`. An unknown
option throws `{TCLUTILS COMMON OPTION -name}`. `-reverse` and `-strict`
accept any boolean value (`1`, `yes`, `true`, `on` and their
counterparts); `-strict foo` throws `{TCLUTILS COMMON BOOLEAN -strict}`.

---

## In short

- Base64 without line breaks: `-maxlen 0`. Invalid text becomes empty.
- Digests of text are over UTF-8. Files hash the bytes.
- `tuurl`: `-plus` is off for a single value, on for the query.
- `getOr`: first the dict, then the default, then the keys.
- `tudiff` keeps the whole comparison table in memory.
- Base32: `tubase32`, the input is bytes; `-hex 1` for base32hex. Invalid text throws an error.
- `xxh32` hashes text as UTF-8 like `tuhash`; `-encoding binary` for bytes.
- `tuiconv` knows only the names from `encoding names`. Tcl 9.0 throws on characters it cannot represent.
- `tupatch` applies without offset search. `-reverse 1` undoes the diff.

---

*Next chapter: [Binary Data and File Information](053-binaerdaten-und-dateiinfo.md)*
