# tkdevtools

## The App

[tkdevtools]{.index} (`apps/tkdevtools/tkdevtools.tcl`) is a reference
and probe browser for Tk development: reference tables, cheat sheets and
probes in one app with a navigation tree. Display only — in normal
operation the app writes no files, only the clipboard. The exception is
the screenshot mode.

```bash
wish apps/tkdevtools/tkdevtools.tcl
tclsh apps/tkdevtools/tkdevtools.tcl --shot out.png shadow
```

The screenshot mode renders one tool (keys such as `shadow`, `colors`,
`regexp`) into a PNG file of 900×600 pixels and exits. It needs the
package `img::window` (Img); if it is missing, the app tries
ImageMagick's `import -window root`. Without a key, the first tool
(*Tcl / Tk*) stays selected.

With `tclsh` and the keys `shadow`, `colors` and `regexp`, three PNG
files of 900×600 pixels are created, exit code 0.

Requirements: Tcl/Tk 8.6 or 9.x, at least **tclutils 0.64.0**
(`tucolor`, `tustr` 0.2, `tudate` 0.2, `tupkgfinder` 0.2, `tuappinfo`,
`tupath`, `tunum` 0.4; 0.69.0 recommended), from tkutils `tkutablelist`
0.4 or newer and `tkuunits`, plus Tablelist. The app loads `tablelist_tile`
before `tkutablelist`; the `tkutl*` helpers use the same variant
(chapter [Understanding tkutils](010-tkutils-verstehen.md)). The helpers
`tkutlsort`, `tkutlfind`, `tkutlclip` are used when present. With
`tkutlclip` 0.3 (tkutils 0.49.0) Ctrl+C in the tables copies the selected
rows as TSV; before, Tablelist's own binding overwrote the clipboard. The app
finds the libraries through `apps/_lib/paths.tcl` (the same logic as
`tools/setup.tcl`).

The button *Copy report* in the tool *Tcl / Tk* copies an environment
report (`tuappinfo::buildReport`) to the clipboard.

---

## The Tools

| Group | Tools |
|---|---|
| Runtime | Tcl / Tk, OS / platform, Packages, **Package shadows**, Paths, Display, Environment, Channels, Photo formats, External tools |
| Reference | Colors, Characters, Graphemes, Fonts, Bitmaps, **Font aliases** |
| Conversion / time | Units, Timezones, clock format, **Number format** |
| Platform | **Paths**, **glob**, **Programs**, **Encoding profiles** |
| Tk widgets / style | Widget tree, Clipboard, Cursors, Relief / Anchor, Keysym probe, ttk Themes, Widget explorer |
| Layout | pack, grid |
| Text / patterns | regexp, format / scan, Encodings, Virtual events |

Bold: since 0.46.0. *Paths* exists twice: under *Runtime* the search
paths (`auto_path`, `tcl_pkgPath`, `tcl::tm::path`, encoding folders),
under *Platform* the path probe.

---

## Tools Since 0.46.0

**Package shadows.** Every copy of a package in module paths and
`auto_path` (`tupkgfinder::shadows`). Marked red is a second copy of the
same version that is never loaded — for example an installation next to
the working tree. The row has a light red background, the active copy is
written in green, other versions in gray. Which one wins depends on the
path order.

**Paths (Platform).** `file pathtype`, `split`, `dirname`, `normalize`,
`nativename` and `tupath::clean` for one path, plus the classification
by Windows and Unix rules (`/x` and `C:x` are volume-relative on
Windows).

**glob.** What a pattern matches in a directory, with `-types`. Shows how
many dot files `*` leaves out here; on Windows `*` matches them, and `*`
plus `.*` returns them twice — the bug that `tkufiletree` fixed (chapter
[File Widgets](040-datei-widgets.md)).

**Programs.** `auto_execok` for a name and the PATH entries with
matches; separator and, on Windows, PATHEXT.

**Encoding profiles.** Bytes (hex) read in an encoding with the profiles
`strict`, `replace` and `tcl8` (Tcl 9). `strict` stops at the first
invalid byte, like a channel with the default profile. Tcl 8.6 has no
profiles; the table then shows one row `(8.6)` with the result without
an error.

**Font aliases.** What Tk makes of Helvetica, Times, Courier, Arial and
the `Tk*Font` names (family, size, metrics). Yellow: the name comes back
unchanged (Tk 9 on Windows for Helvetica) and may coincide in a PDF
export with the standard font of the same name. The row then has a
yellow background.

**Number format.** The same values with `format %.Nf` (rounding of the C
runtime; glibc and Windows differ at x.5) and `tunum::format`
(commercial rounding, 0.5 away from zero), plus the stored double value.

---

## Summary

- tkdevtools: reference and probes, writes nothing.
- Since 0.46.0: Package shadows, Paths, glob, Programs, Encoding
  profiles, Font aliases, Number format.
- Needs at least tclutils 0.64.0 (0.69.0 recommended) and Tablelist.
- `--shot` needs Img (`img::window`) or ImageMagick.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 (Img 1.4.16) and 9.0.4 (Img 2.1.1) on
Linux under Xvfb: `--shot` with `shadow`, `colors` and `regexp`.

**Not tested:** display of the encoding profiles under Tcl 9, font
aliases on Windows.
:::

---

*Next chapter: [Limits](090-grenzen.md)*
