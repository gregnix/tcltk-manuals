# Characters, Numbers, Dates and Paths

Four modules for what the Tcl core provides only awkwardly or not at
all: visible characters ([tustr]{.index}), amounts ([tunum]{.index}),
calendar dates ([tudate]{.index}) and paths without a file system
([tupath]{.index}). All four are in the umbrella, none needs Tk.

---

## tustr

`tustr` extends `string`. What the core can do (`string reverse`,
`string map`, `string repeat`) stays with the core.

| Command | Effect |
|---|---|
| `isEmpty s` | 1 for an empty string |
| `truncate s n ?ende?` | shortens to `n` characters; the default for `ende` is `...`, its characters count |
| `padLeft`, `padRight`, `center` | pad to a width; the default pad character is the space |
| `startsWith`, `endsWith` | 1 if the edge matches |
| `removePrefix`, `removeSuffix` | cut off the edge, otherwise unchanged |
| `splitTrim s ?sep?` | splits, removes spaces, drops empty pieces; the default for `sep` is the space |
| `toCamel`, `toSnake` | `my-cool_var` becomes `myCoolVar`, `myCoolVar` becomes `my_cool_var`; letters of every script count |
| `slugify s` | ASCII lowercase: umlauts spelled out, otherwise everything except `a`–`z` and digits becomes `-` |
| `capitalize s` | first letter uppercase |
| `count s teil` | non-overlapping matches |
| `graphemes s` | list of the visible characters |
| `isPrintable zeichen` | 1 if exactly one printable character is given |

`truncate`, `padLeft`, `padRight` and `center` calculate with
`string length`, not with `graphemes`. A negative width or length
results in `{TCLUTILS TUSTR ARG}`.

```tcl
package require tclutils::tustr
::tclutils::tustr::truncate HalloWelt 6          ;# -> Hal...
::tclutils::tustr::toCamel my-cool_var           ;# -> myCoolVar
::tclutils::tustr::toSnake myCoolVar             ;# -> my_cool_var
::tclutils::tustr::splitTrim { a , , b } ,       ;# -> a b
::tclutils::tustr::count ababa ba                ;# -> 2
::tclutils::tustr::slugify "Hallo, Welt!"        ;# -> hallo-welt
::tclutils::tustr::slugify "Größe"               ;# -> groesse
::tclutils::tustr::toCamel "Jörg Müller"         ;# -> jörgMüller
```

`slugify` returns ASCII for file names and URLs. It spells Latin letters
in ASCII first: `ä` becomes `ae`, `ö` `oe`, `ü` `ue`, `ß` `ss`, accents
are dropped (`é` becomes `e`, `ł` becomes `l`). What has no ASCII form,
such as `日本`, is dropped. `toCamel` and `toSnake` keep letters of every
script (since 0.3; up to 0.2 `Größe` became `gr-e` and
`toCamel "Jörg Müller"` became `jRgMLler`).

### Visible Characters

`graphemes` splits a string into visible characters, a simplified
UAX #29. Base characters with combining accents, emoji ZWJ sequences,
flag pairs and CR LF stay together. Hangul syllables and Indic
conjuncts are not covered. `[join [graphemes $s] ""]` gives `$s` again.

`isPrintable` checks exactly one character against Unicode, not only
ASCII: 0 for C0/C1 control characters and DEL, 1 for U+00A0. An empty
string or more than one character throws `{TCLUTILS TUSTR ARG}` with
`isPrintable expects exactly one character`. Surrogate pairs that Tcl 8.6
delivers from a channel count as one character in both commands.

```tcl
llength [::tclutils::tustr::graphemes "e\u0301x"]   ;# -> 2
string length "e\u0301x"                           ;# -> 3
::tclutils::tustr::isPrintable \u00e4               ;# -> 1
::tclutils::tustr::isPrintable \x07                 ;# -> 0
```

---

## tupath

`tupath` wraps `file`. `clean` and `relative` do not query the file
system; `normalize` and `readlink` do.

| Command | Effect |
|---|---|
| `normalize pfad` | absolute, resolves `.`, `..` and symbolic links (`file normalize`) |
| `clean pfad` | `.`, `..` and `//` only lexically; an empty path becomes `.` |
| `isAbsolute pfad` | 1 or 0 |
| `components pfad` | `file split` |
| `join teile…` | `file join` |
| `relative basis ziel` | way from the base to the target, both absolute or both relative |
| `commonPath liste` | longest common directory, otherwise `""` |
| `readlink pfad` | target of a symbolic link |

```tcl
package require tclutils::tupath
::tclutils::tupath::clean a/./b/../c             ;# -> a/c
::tclutils::tupath::clean /a/../../b             ;# -> /b
::tclutils::tupath::clean ""                     ;# -> .
::tclutils::tupath::commonPath {/a/b/c /a/b/d}   ;# -> /a/b
::tclutils::tupath::relative /a/b /a/b/c/d       ;# -> c/d
::tclutils::tupath::relative /a/b /a/b           ;# -> .
```

Since tclutils 0.64.0 an absolute path keeps its root: `..` stops
there. On Windows, according to the code, this also applies to `C:/`, `/`
(drive-relative) and `//server/share`. The module version stayed 0.1.

`relative` with one relative and one absolute path throws
`{TCLUTILS TUPATH RELATIVE}`. `commonPath` without a path throws
`{TCLUTILS TUPATH ARGS}`. `readlink` on a regular file throws
`{TCLUTILS TUPATH NOTLINK}`. If the paths share no first component,
`commonPath` returns `""`.

---

## tudate

`tudate` calculates in the local time zone, on top of `clock`.

| Command | Effect |
|---|---|
| `parse text ?-format fmt?` | seconds since the epoch; without `-format` a list of formats, then a free-form attempt |
| `iso sekunden ?-time 0?` | `yyyy-mm-dd`, with `-time 1` additionally `THH:MM:SS` |
| `add sekunden zahl einheit` | calendar addition; unit `second`, `minute`, `hour`, `day`, `week`, `month`, `year`, also in the plural |
| `diff a b ?-unit days?` | `a` minus `b`, as an integer; units `seconds`, `minutes`, `hours`, `days`, `weeks` |
| `relative sekunden ?-base sek?` | English day phrase; without `-base` the base is now |
| `today` | today's date as ISO text |
| `zones` | sorted names for `clock format -timezone` |

```tcl
package require tclutils::tudate
set t [::tclutils::tudate::parse 15.03.2024]
::tclutils::tudate::iso $t                              ;# -> 2024-03-15
::tclutils::tudate::iso [::tclutils::tudate::add $t 1 month]
                                                        ;# -> 2024-04-15
::tclutils::tudate::relative $t -base $t                ;# -> today
::tclutils::tudate::relative [::tclutils::tudate::add $t 3 day] -base $t
                                                        ;# -> in 3 days
expr {"Europe/Berlin" in [::tclutils::tudate::zones]}   ;# -> 1
```

Without `-format`, `parse` tries in turn the ISO date and ISO date-time
(also without seconds and as `YYYYMMDD`), `d.m.Y` (also with a time),
`d/m/Y`, `Y/m/d`, `m/d/Y`, `H:M:S`, `H:M` and English month names
(`29 Oct 2025`, `Oct 29 2025`). `02/03/2026` is 2 March; `m/d/Y` only
applies when `d/m/Y` gives no date, so `10/29/2026` is 29 October. A
string of digits and separators only never goes to the free-form
attempt.

`parse` rejects a day or month that does not exist, with and without
`-format`, on Tcl 8.6 as on 9.0: `2026-02-29`, `31.04.2026`,
`29/02/2026` and `Feb 30 2026` give `{TCLUTILS TUDATE PARSE}`.
`clock scan` alone turns these into 1 March, 1 May and 2 May 2028 on
8.6; `parse` formats every match back and drops it when the numbers
differ. Up to tclutils 0.68.0 these days slipped through on 8.6.

```tcl
::tclutils::tudate::iso [::tclutils::tudate::parse 10/29/2026]
                                                        ;# -> 2026-10-29
catch {::tclutils::tudate::parse 2026-02-29} m o
dict get $o -errorcode                                  ;# -> TCLUTILS TUDATE PARSE
```

`relative` answers in English: `today`, `tomorrow`, `yesterday`,
`in N days`, `N days ago`. An unreadable date results in
`{TCLUTILS TUDATE PARSE}`, an unknown unit in
`{TCLUTILS TUDATE UNIT}`.

`diff -unit days` divides the seconds by 86400 and truncates. It
does not count calendar days. From March 15, 2024 to April 15, 2024 it
returns 30, not 31: in the local zone (CEST, `TZ` not set) one hour
is missing because of daylight saving time. `add` itself goes through
`clock add` and lands on April 15.

`zones` reads the first source that has entries: Tcl's tzdata, otherwise
`/usr/share/zoneinfo`. It checks names from the system directory with
`clock`, because Tcl 8.6 without its own tzdata rejects names like `Etc/GMT+1`.
`UTC` is always included. The list does not mix the two sources.

---

## tunum

`tunum` reads amounts as they appear in tables and writes them in
German format. `tunumfmt` is a different module: it reads sizes like `1.5K`,
`2Mi` and `2KiB`.

| Command | Effect |
|---|---|
| `parse text ?-default {}? ?-locale auto?` | Tcl double, or `-default` if nothing is recognized |
| `sum werte ?-default 0?` | sum, unreadable entries are dropped; always locale `auto` |
| `isNumber text` | 1 if `parse` with `auto` finds a value |
| `format zahl ?-locale de? ?-decimals 2?` | period as thousands separator, decimal comma |

Locale `auto` (default of `parse`): a comma followed by digits at the end is
the decimal comma, periods are thousands separators. Otherwise the period
is decimal and the commas are thousands separators. `€`, `$`, `£`, `¥` and
spaces are dropped.

Locale `de-strict`: the period is always a thousands separator and is
dropped, the comma is decimal, currency symbols stay. `956.06` thus becomes
`95606.0`. For the period as decimal separator, use `auto`.

```tcl
package require tclutils::tunum
::tclutils::tunum::parse "1.234,56"                 ;# -> 1234.56
::tclutils::tunum::parse "1,234.56"                 ;# -> 1234.56
::tclutils::tunum::parse "12 \u20AC"                ;# -> 12.0
::tclutils::tunum::parse "abc"                      ;# -> (leer)
::tclutils::tunum::sum {1,50 2,00 abc 4,20}         ;# -> 7.7
::tclutils::tunum::parse 956.06 -locale de-strict   ;# -> 95606.0
::tclutils::tunum::format 1234.5                    ;# -> 1.234,50
::tclutils::tunum::format 1234.5 -decimals 0        ;# -> 1.235
::tclutils::tunum::format 2.675                     ;# -> 2,68
::tclutils::tunum::format -2.5 -decimals 0          ;# -> -3
format %.2f 2.675                                   ;# -> 2.67
```

Since module 0.4, `format` rounds half away from zero on the decimal digits,
the same on every platform. Up to tclutils 0.63.0 this went through
`format %.*f`, and there the C runtime decided. The different
behavior of the Windows runtime before 0.4 is described in the CHANGELOG.
The caller appends a currency:
`"[::tclutils::tunum::format $n] EUR"`.

The procedure is named `format` and lives in the namespace `tclutils::tunum`.
The call stays `::tclutils::tunum::format`; that way it does not hide Tcl's
`format`. `-decimals` below 0 results in `{TCLUTILS TUNUM DECIMALS}`,
a locale other than `de` results in `{TCLUTILS TUNUM LOCALE}`.
`parse -locale` knows `auto` and `de-strict`.

---

## In short

- Visible length: `tustr::graphemes`, not `string length`.
- `slugify` returns ASCII and spells umlauts out: `Größe` becomes `groesse`.
- `tupath::clean` and `relative` read no file; `..` stops at the root.
- `tudate::diff -unit days` divides seconds; `relative` answers in English.
- Amounts: `tunum::format`. `de-strict` treats every period as a thousands separator.
- Nationwide public holidays: chapter [Notes and Calendars](054-notizen-und-kalender.md).

---

*Next chapter: [Data Formats](050-datenformate.md)*
