# Encoding and locale

## Introduction

On Linux, the locale determines the encoding, not the
operating system. At startup Tcl reads `LC_ALL`, `LC_CTYPE` and `LANG`
and sets [`encoding system`]{.index} from them. If the locale is `C` or
missing, that is not UTF-8. Three things depend on this: how `open`
reads a file, how `puts` writes to the terminal, and under Tcl
8.6 also how `source` reads a script.

The long version of the topic, with Windows and TIP 656, is in the book
*Encoding*.

---

## encoding system follows the locale

`serie-linux` (howto 08) shows on Debian forky with Tcl 8.6.18:

```text
LANG=C         encoding system = iso8859-1
LANG=C.UTF-8   encoding system = utf-8
```

The container check confirms this and adds further values. Each
run with `env -i`, that is, without any other variable. Evaluated: `encoding
system`, the length of a UTF-8 literal `"Grüße"` in the script, and the
length of the same five characters, read from a UTF-8 file with `open`
without `fconfigure`.

| Environment | 8.6.14 system | 8.6.14 literal | 9.0.4 system | 9.0.4 literal | `open`, both |
|----------|---------------|----------------|--------------|---------------|---------------|
| no locale | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=C` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=POSIX` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=C.UTF-8` | utf-8 | 5 | utf-8 | 5 | 5 |
| `LANG=de_DE.UTF-8` | utf-8 | 5 | utf-8 | 5 | 5 |
| `LANG=en_US.ISO-8859-1` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=de_DE` | iso8859-1 | 7 | **utf-8** | 5 | 7 and 5 respectively |
| `LANG=C.UTF-8 LC_ALL=C` | iso8859-1 | 7 | iso8859-1 | 5 | 7 |
| `LANG=C LC_CTYPE=C.UTF-8` | utf-8 | 5 | utf-8 | 5 | 5 |

What follows from this:

- The order is `LC_ALL`, then `LC_CTYPE`, then `LANG`. An
  `LC_ALL=C` beats any `LANG`.
- The locale does not have to be installed. The container has only `C`,
  `C.utf8` and `POSIX` (`locale -a`), yet
  `LANG=de_DE.UTF-8` leads to `utf-8`. Tcl reads the name.
- A locale without a character set (`de_DE`) is handled differently by 8.6.14 and 9.0.4:
  8.6 takes iso8859-1, 9.0 takes utf-8.
- `open` follows `encoding system` in both versions.
- Tcl 9 always reads scripts as UTF-8. Tcl 8.6 reads them in
  `encoding system`.

---

## Files: always with an encoding

Because the default depends on the locale, a program opens every
text file with an explicit encoding. This applies under 8.6 and 9:

```tcl
set ch [open $pfad r]
fconfigure $ch -encoding utf-8
set text [read $ch]
close $ch
```

`open` itself has no option for the encoding, not even under Tcl 9.
The `fconfigure` line stays.

Tcl 9 aborts when reading invalid bytes instead of silently
reinterpreting them (TIP 656, profile `strict` as the default for channels).
Container check with a Latin-1 file `Gr\xfc\xdfe`, read with
`-encoding utf-8`:

```text
8.6.14   Grüße
9.0.4    error reading "file5": invalid or incomplete multibyte or wide character
```

Tcl 8.6 interprets invalid UTF-8 bytes as Latin-1. Here that happens to
look right and hides the fact that the file is not UTF-8 at all.
Under Tcl 9 the same error becomes visible. On Linux this mainly
affects old files and output of other programs. The profiles
(`-profile replace`, `-profile tcl8`) are described in the book *Encoding*.

---

## Scripts: the guard under Tcl 8.6

A UTF-8 script with umlauts in the source only runs correctly under Tcl 8.6
if the locale is UTF-8. Under `LANG=C`,
`Rückgängig` becomes the string `RÃ¼ckgÃ¤ngig` (`serie-linux`, howto 08).
This affects programs that start from cron, from a systemd unit or from
a container without a locale.

A remedy without startup parameters is a guard at the start of the file. The file
itself is UTF-8. If Tcl reads it as iso8859-1, `"ü"` is two characters
long. Then the guard reads the file again, this time as UTF-8:

```tcl
if {[string length "ü"] != 1} {
    source -encoding utf-8 [file normalize [info script]]
    return
}
```

`beispiele/utf8-wache.tcl` shows this. Container check, under
`LANG=C` and `LANG=C.UTF-8`, with 8.6.14 and 9.0.4: in all four runs
`"Rückgängig"` has length 10. Under `LANG=C` the terminal still shows the
umlauts wrongly, because `stdout` writes in iso8859-1. The
string in the program is correct.

The guard belongs in the startup script. For further files there is
`source -encoding utf-8` directly, for packages the entry in
`pkgIndex.tcl`:

```tcl
package ifneeded meinpaket 1.0 \
    [list source -encoding utf-8 [file join $dir meinpaket.tcl]]
```

Alternatively, the start command passes the encoding explicitly:
`tclsh8.6 -encoding utf-8 app.tcl`. That only works if you control the call
yourself, that is, not via a shebang line with `env`
(see [Which Tcl?](030-welches-tcl.md)).

---

## Terminal and exec

`stdout`, `stderr` and `stdin` are set to `encoding system` at startup
(container: `fconfigure stdout -encoding` returns `utf-8` under
`C.UTF-8`). The same applies to channels to child processes: `exec` and
`open "|…"` decode the child's output in `encoding system`.
`exec printf %s "Grüße"` returns `Grüße` under `LANG=C.UTF-8`.
A child that always writes UTF-8 is read, under an
unknown locale, via a channel with a fixed encoding:

```tcl
set ch [open |[list git log -1 --format=%an] r]
fconfigure $ch -encoding utf-8
set autor [string trim [read $ch]]
close $ch
```

See [exec, xdg-open, processes](070-exec-und-prozesse.md).

---

## msgcat and language

`msgcat::mclocale` also reads the locale variables, in the
order `LC_ALL`, `LC_MESSAGES`, `LANG` (source of
`msgcat.tcl` in Tcl 9.0.4). In the container with `LANG=C.UTF-8` the
result is `c`. A program with German messages in `de.msg` therefore needs
a German locale or an explicit call
`msgcat::mclocale de`. `LANGUAGE`, on Linux the language list for
gettext, is not evaluated by `msgcat`.

---

## Summary

- `encoding system` follows `LC_ALL`, `LC_CTYPE`, `LANG`. `C` and
  a missing locale result in iso8859-1.
- `open` follows `encoding system`. Always open files with `fconfigure
  -encoding utf-8`.
- Tcl 9 reads scripts as UTF-8, Tcl 8.6 in `encoding system`. For
  8.6, the guard at the start of the startup script.
- `de_DE` without a character set: 8.6 iso8859-1, 9.0 utf-8.
- Read output of child processes via a channel with a fixed encoding.

---

*Next chapter: [exec, xdg-open, processes](070-exec-und-prozesse.md)*
