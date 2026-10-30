# Umbrella and Modules

## What the umbrella loads

```tcl
package require tclutils    ;# -> 0.69.0
```

The file is `lib/tm/tclutils-0.69.0.tm`. It requires 121 modules with
`package require tclutils::…`, among them `common` 0.2, `tutask` 0.2,
`tusettings` 0.1, `tupdftext` 0.1, `tufetch` 0.4, `tuhttps` 0.1 and
`tuflow` 0.4. `tuflow` requires `tudiagram` when it loads. Afterwards
122 packages `tclutils::*` are loaded.

24 module files in the tree stay outside until someone requires them individually:

| Group | Packages |
|---|---|
| only with their own `package require` | `tutestrun`, `tutdbc`, `tuprovider::sftp` |
| diagram, `tuflow` loads them on the first call of the respective kind | `tustate`, `turequirement`, `tuer`, `tuclass`, `tumindmap`, `tuc4`, `tublock`, `tugit`, `tuarchitecture`, `tupie`, `tuxychart`, `tuquadrant`, `tujourney`, `tutimeline`, `tusankey`, `tugantt`, `tusequence`, `turadar`, `tutreemap`, `tupacket`, `tukanban` |

`tudiagram` is not in the list of the 121, but is present after the umbrella,
because `tuflow` loads it immediately. The other diagram modules are not.
25 files are not in the umbrella's require list.

```tcl
::tcl::tm::path add /pfad/zu/tclutils-0.69.0/lib/tm
package require tclutils                       ;# -> 0.69.0
package present tclutils::tutask               ;# -> 0.2
package present tclutils::tusettings           ;# -> 0.1
package present tclutils::tupdftext            ;# -> 0.1
catch {package present tclutils::tutestrun}    ;# -> 1
```

`catch` returns 1 because `tutestrun` is not loaded. The package
exists in the tree. `package require tclutils::tutestrun` loads it without the
umbrella.

In 0.69.0 came `tucsv` 0.2 (Excel profiles, BOM, encoding) and
`tusqlite` 0.2 (parameter dict, `update`, `delete`), chapter
[Data Formats](050-datenformate.md). In 0.68.0, 76 modules received fixes and a new version;
the list is in [Appendix B](810-anhang-module.md). New in 0.67.0 is
`tupdftext` 0.1, chapter
[Text from PDF Files](055-pdf-text.md). In 0.66.0 `tutask` became 0.2,
chapter [Tasks with tutask](085-tutask.md). In 0.65.0 `tutask` 0.1 was added
to the umbrella. From 0.64.0 remain `tusettings` 0.1, `tunum` 0.4 and
`tupkgfinder` 0.2; `tustr` and `tudate` are at 0.3 since 0.69.0.

FTP is in the umbrella (`tuprovider::ftp` 0.2) and requires tcllib `ftp`
only on `open`. SFTP is not. TDBC is not.

---

## File, docs, test

| Part | Example |
|---|---|
| Package | `tclutils::tujson` |
| File | `lib/tm/tclutils/tujson-0.1.tm` |
| Commands | namespace `::tclutils::tujson` |
| Docs | `docs/tujson.md` |
| Test | `tests/tujson.test` |
| man | `man/mann/tujson.n` |

The version in the file name is that of the module, not that of the umbrella.
`tujson-0.1.tm` stays 0.1 while the umbrella is at 0.69.0.

```bash
tclsh tools/check-modules.tcl -require test,doc,man
```

148 modules, none without test, doc or man page.

---

## common

`tclutils::common` 0.2 is the shared helper, not a module for the
application. The option errors of the other modules go through it.

| Command | Effect |
|---|---|
| `parseOptions defaults args` | an unknown option becomes `{TCLUTILS COMMON OPTION name}` |
| `ensureBoolean wert option` | a non-boolean becomes `{TCLUTILS COMMON BOOLEAN …}` |
| `ensurePositiveInteger wert was` | `{TCLUTILS COMMON INTEGER …}` |
| `ensureOneOf wert liste was` | a value not in the list becomes `{TCLUTILS COMMON VALUE …}` |
| `readFile`, `writeFile` | text; the channel is closed even on error |
| `readBinaryFile` | bytes, channel `iso8859-1`, so that Tcl 9 works without the old encoding `binary` |

```tcl
::tclutils::tudate::iso 0 -nope 1
```

This throws `{TCLUTILS COMMON OPTION -nope}` and names the known
options, here `-time`.

---

## Error codes

A module's own error has the form
`{TCLUTILS <MODUL> <GRUND> …}`. `try`/`trap` compares from the front. Catching
`{TCLUTILS TUFETCH}` gets every error from `tufetch`. The
list of codes this book has tried is in the appendix
[Error Messages](830-anhang-fehlermeldungen.md).

---

## In short

- `package require tclutils` loads 122 packages, not the 146 files in the tree.
- `tutestrun`, `tutdbc` and `tuprovider::sftp` stay outside.
- `tuflow` loads the diagram kinds other than `tudiagram` only when called.
  Commands: chapter [Diagrams](056-diagramme.md).
- Unknown options arrive as `{TCLUTILS COMMON OPTION …}`.

---

*Next chapter: [Text and Files](040-text-und-dateien.md)*
