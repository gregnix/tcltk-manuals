# Setup and Fonts

## Introduction

pdf4tcllib needs two things: the package pdf4tcl and a
TrueType font. Without TrueType it carries on with Helvetica, but then
all characters outside Latin-1 are missing, and the PDF cannot be
archived as PDF/A. This chapter sets up both and shows
how to check what `fonts::init` has found.

---

## Loading the Module

pdf4tcllib is a Tcl module: a file `pdf4tcllib-0.6.7.tm` in the folder
`lib/`, next to it the add-on packages (`pdf4tcltoc-0.1.tm` etc.). Tcl finds
them through the module path:

```tcl
tcl::tm::path add /pfad/zu/pdf4tcllib/lib
package require pdf4tcllib
```

Or, without changing the script, through the environment, depending on the Tcl version:

```bash
export TCL8_6_TM_PATH=/pfad/zu/pdf4tcllib/lib
export TCL9_0_TM_PATH=/pfad/zu/pdf4tcllib/lib
```

pdf4tcl itself is a classic package with `pkgIndex.tcl`; its folder
belongs in `auto_path` or in `TCLLIBPATH`. `package require pdf4tcllib`
does not load pdf4tcl along with it. Both lines therefore appear at the
start of every example:

```tcl
package require pdf4tcl
package require pdf4tcllib
```

To ship pdf4tcllib with an application, copy the `.tm` files in use
into a module folder of the application's own and add it with
`tcl::tm::path add`. Nothing more is needed; apart from pdf4tcl,
pdf4tcllib has no dependencies. Only the namespace `image` needs Tk.

---

## Scripts in UTF-8

The examples contain umlauts in the source code. Tcl 9 reads scripts as
UTF-8. Tcl 8.6 reads them in the system encoding, and without a
locale set (`LANG` empty, for instance in a cron job or container) that is
ISO 8859-1. Then "gegenüber" turns into "gegenÃ¼ber" in the PDF, without
an error message.

The remedy, one of three:

- set the locale (`LANG=de_DE.UTF-8` or `C.UTF-8`),
- load the script with `source -encoding utf-8 skript.tcl`,
- write characters outside ASCII as a `\u` sequence (`gegen\u00fcber`).

The encoding can be checked with `encoding system`.

---

## fonts::init

```tcl
pdf4tcllib::fonts::init ?-fontdir dir? ?-family name? \
    ?-cid 0|1? ?-force 0|1?
```

`fonts::init` searches for a TrueType family, registers its faces with
pdf4tcl and remembers the names. It takes effect once per process; every
further call returns immediately.

| Option | Default | Effect |
|---|---|---|
| `-family` | `DejaVuSansCondensed` | name of the family as it appears in the file names |
| `-fontdir` | – | folder searched before all others |
| `-cid` | `0` | `1`: full font instead of 256 characters (section [256 Characters or CID](#256-characters-or-cid)) |
| `-force` | `0` | `1`: search again, even if already loaded |

### Which Files It Looks For

A family counts as found when **both** files are in one
folder:

```
<familie>.ttf
<familie>-Bold.ttf
```

From the same folder `fonts::init` also takes, if present:

- `<familie>-Oblique.ttf` and `<familie>-BoldOblique.ttf` for italic,
- `<familie>Mono.ttf`, otherwise `DejaVuSansMono.ttf`, otherwise
  `LiberationMono-Regular.ttf` for the monospaced font.

The names follow the DejaVu scheme. Liberation uses
`LiberationSans-Regular.ttf` and `LiberationSans-Italic.ttf`; that does
not match, not even with `-family LiberationSans`.

### Where It Looks

In this order; the first folder with both files wins:

1. the folder from `-fontdir`,
2. `fonts/` next to `lib/` and `lib/fonts/`, i.e. with the module itself,
3. on Linux `/usr/share/fonts/truetype/dejavu`,
   `/usr/share/fonts/dejavu-sans-fonts` (Fedora), `/usr/share/fonts/TTF`
   (Arch), `/usr/share/fonts/truetype`, `$HOME/.fonts`,
   `$HOME/.local/share/fonts`,
4. on Windows `%SystemRoot%\Fonts` and
   `%LOCALAPPDATA%\Microsoft\Windows\Fonts`,
5. on macOS `/Library/Fonts`, `/System/Library/Fonts`,
   `$HOME/Library/Fonts`.

It does not search subfolders.

### Where the Font Comes From

| System | What to do |
|---|---|
| Debian, Ubuntu | `apt install fonts-dejavu-core fonts-dejavu-extra fonts-dejavu-mono` |
| Fedora | `dnf install dejavu-sans-fonts dejavu-sans-mono-fonts` |
| Windows, macOS | DejaVu is not included: put the `.ttf` files in `fonts/` next to `lib/` or pass `-fontdir` |

On Debian the faces are split across three packages. `fonts-dejavu-core`
contains `DejaVuSans.ttf` and `DejaVuSans-Bold.ttf`, but not the
narrow family `DejaVuSansCondensed` that `fonts::init` looks for without `-family`.
That one is in `fonts-dejavu-extra`, together with all
oblique faces. If only the core package is installed,
`-family DejaVuSans` helps.

For an application meant to run on other people's machines, the
folder `fonts/` next to `lib/` is the safe way: the font travels along, and
the PDF looks the same everywhere.

---

## Checking What Is Loaded

```tcl
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init
set kursiv [pdf4tcllib::fonts::hasTtfItalic]
puts "TrueType:  [pdf4tcllib::fonts::hasTtf]  kursiv: $kursiv"
puts "CID-Modus: [pdf4tcllib::fonts::isCidMode]"
foreach p {fontSans fontSansBold fontSansItalic fontSansBoldItalic
           fontMono} {
    puts [format "%-20s %s" $p [pdf4tcllib::fonts::$p]]
}
```

Output:

```text
pdf4tcllib::fonts: TTF italic faces loaded
pdf4tcllib::fonts: TTF faces loaded from /usr/share/fonts/truetype/dejavu
TrueType:  1  kursiv: 1
CID-Modus: 0
fontSans             Pdf4tclSans
fontSansBold         Pdf4tclSansBold
fontSansItalic       Pdf4tclSansItalic
fontSansBoldItalic   Pdf4tclSansBoldItalic
fontMono             Pdf4tclMono
```

If `fonts::init` finds nothing, it reports on stderr where it looked, and
falls back to the standard fonts:

```text
pdf4tcllib::fonts: No TTF fonts found, falling back to Helvetica
pdf4tcllib::fonts: searched in:
pdf4tcllib::fonts:   [---] .../pdf4tcllib/lib/../fonts
pdf4tcllib::fonts:   [---] .../pdf4tcllib/lib/fonts
pdf4tcllib::fonts:   [exists] /usr/share/fonts/truetype/dejavu
...
TrueType: 0  Sans: Helvetica
```

`[exists]` only means that the folder exists, not that the family
is in it. The program keeps running. Code that relies on TrueType
therefore checks `fonts::hasTtf` and aborts itself:

```tcl
pdf4tcllib::fonts::init
if {![pdf4tcllib::fonts::hasTtf]} {
    error "keine TrueType-Schrift gefunden, siehe stderr"
}
```

---

## Font Names Always Through the Accessor Procedures

pdf4tcl knows the loaded font under a name that
`fonts::init` assigns: `Pdf4tclSans` with TrueType, `Helvetica` without.
The code queries it instead of hard-coding it:

| Procedure | with TrueType | without |
|---|---|---|
| `fonts::fontSans` | `Pdf4tclSans` | `Helvetica` |
| `fonts::fontSansBold` | `Pdf4tclSansBold` | `Helvetica-Bold` |
| `fonts::fontSansItalic` | `Pdf4tclSansItalic` | `Helvetica-Oblique` |
| `fonts::fontSansBoldItalic` | `Pdf4tclSansBoldItalic` | `Helvetica-BoldOblique` |
| `fonts::fontMono` | `Pdf4tclMono` | `Courier` |

This way the same code runs with and without TrueType. The italic faces
fall back to Helvetica-Oblique individually if the oblique files
are missing (`fonts::hasTtfItalic` is then 0).

`fonts::setFont` takes a style as a word:

```tcl
pdf4tcllib::fonts::setFont $pdf 14 Sans Bold       ;# fontSansBold
pdf4tcllib::fonts::setFont $pdf 14 Sans Italic     ;# fontSansItalic
pdf4tcllib::fonts::setFont $pdf 14 Sans BoldItalic ;# ...BoldItalic
```

After `fonts::init` the family does not matter here: `Bold`, `Italic` and
`BoldItalic` always lead to the loaded faces. Without a style,
`fonts::setFont` sets the family unchanged, so `fonts::setFont $pdf 14
Helvetica` really sets Helvetica. For normal text, therefore, use
`$pdf setFont 14 [pdf4tcllib::fonts::fontSans]`.

With TrueType all faces are embedded:

```text
$ pdffonts 020-schriften.pdf     (Spalten gekürzt)
name                             type       emb
AAAAAA+_Pdf4tcl_Base_Italic      TrueType   yes
AAAAAA+_Pdf4tcl_Base_BoldItalic  TrueType   yes
AAAAAA+_Pdf4tcl_Base_Mono        TrueType   yes
AAAAAA+_Pdf4tcl_Base_Regular     TrueType   yes
AAAAAA+_Pdf4tcl_Base_Bold        TrueType   yes
```

---

## 256 Characters or CID

`fonts::init` registers the font in one of two modes:

| | without `-cid` | `-cid 1` |
|---|---|---|
| Characters | 256: ASCII, Latin-1 and 32 more characters | all that the font has |
| including | umlauts, €, –, —, …, •, arrows ←↑→↓, box-drawing lines, ✓ ✗ ☐ ☑, ≤ ≥ | in addition Greek, mathematics, Cyrillic, typographic quotation marks |
| PDF with one line of text | 22 KB | 49–52 KB, depending on the text |
| Characters outside | become “?” | become “?” if the font does not have them |

The sizes come from the example in the next chapter; the
difference is the font, which is embedded more completely in CID
mode.

For German texts `-cid 1` is the better choice. The 256 characters
cover umlauts and ß, but not the German
quotation marks „ and “: they are missing from the selection. What that means for
`safeText` is shown in the chapter
[Safe Unicode Output](030-unicode-sicher-ausgeben.md).

### Choosing the Mode on the First Call

The mode applies to the whole process, and it is fixed on the **first**
`fonts::init`. A later `fonts::init -cid 1` no longer changes the
font, not even with `-force 1`: the font is already registered with
pdf4tcl under its name and is not registered
again. `fonts::isCidMode` nevertheless reports 1 afterwards. In one test
"αβγ" thus came out as "???" in the PDF. The pdf4tcllib counter
stayed 0, nothing appeared on stderr; only `$pdf getSubstCount` counted the three characters.

That is why `fonts::init` with all its options belongs in one place at the
start of the program, before some library calls it with other options.

---

## Summary

- `package require pdf4tcl` and `package require pdf4tcllib`, then
  `pdf4tcllib::fonts::init` once, with `-cid 1` for German texts.
- The font must be present as `<familie>.ttf` and `<familie>-Bold.ttf` in one
  of the search folders; on Debian install `fonts-dejavu-extra`
  or pass `-family DejaVuSans`.
- Check `fonts::hasTtf` when TrueType is mandatory.
- Font names only through `fonts::fontSans` and the other
  accessor procedures.
- Tcl 8.6 needs a UTF-8 locale for umlauts in the script.

---

*Next chapter: [Safe Unicode Output](030-unicode-sicher-ausgeben.md)*
