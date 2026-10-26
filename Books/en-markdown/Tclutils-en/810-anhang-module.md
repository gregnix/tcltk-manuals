# Modules (Orientation)

Not a complete list — for state and status see
`docs/guide/module-status.md` and `README.md` in the tclutils tree.
Hygiene count with `tools/check-modules.tcl -require test,doc,man`:
**144** modules in the 0.68.0 tree, none without a
test, doc or man page; 25 of them not directly in the umbrella.

## Categories

| Category | Examples |
|---|---|
| Text filters | tucat, tuhead, tugrep, tusort, tucut, tused (chapter [Text and Files](040-text-und-dateien.md)); tunl, tufold, tufmt, tuexpand, tucolumn, tutable, tutac, turev, tushuf, tuseq, tutr, tuwc, tupr (chapter [More Line Filters](042-zeilenfilter.md)) |
| Joining / pipelines | tupaste, tujoin, tucomm, tucsplit, tusplit, tutee, tuxargs, tutsort, tuawk, tufuzzy, tuagrep (chapter [Joining, Splitting, Pipelines](043-zusammenfuehren-und-ablaeufe.md)) |
| Data | tucsv, tujson, tuini, tuxml, tusqlite, tuldif, tubookmark (chapter [Data Formats](050-datenformate.md)); tutdbc, tummdb (chapter [TDBC and MaxMind](051-tdbc-und-mmdb.md)) |
| Encoding | tubase64, tubase32, tucrc, tuhash, tuxxhash, tuiconv, tuuuid, tuurl, tudict, tudiff, tupatch (chapter [Encoding, Hashing and Comparing](052-kodierung-hash-vergleich.md)) |
| Binary data | tuhexdump, tuod, tustrings, tuhexedit, tucmp, tusize, tustat, tucode (chapter [Binary Data and File Information](053-binaerdaten-und-dateiinfo.md)) |
| Notes | tumd, tuical, turrule, tuvcard, tunotes, tunotesdb, tucal, tuholiday (chapter [Notes and Calendars](054-notizen-und-kalender.md)) |
| Documents | tupdftext, tupdf, tuodf (chapters [Text from PDF Files](055-pdf-text.md), [ODF and PDF Structure](057-odf-und-pdf-struktur.md)) |
| Diagrams | tudiagram, tuflow and the kinds from `toSvg` (chapter [Diagrams](056-diagramme.md)) |
| Images | tucolor, tupng, tupngdraw, tutablepng, tucodepng, tumonthpng, tupngpad, tusvg, tuimage, tuico, tudhash (chapter [Images without Tk](058-bilder-ohne-tk.md)) |
| FS / archive | tufile, tufind, tuzip |
| Provider | tuprovider, …::zip, …::dav |
| Application | tulog, tuevent, turegistry, tuvalidate, tulist, tumath, tunumany, tuappinfo, tudeploy, tuexe, tuopen, tuzipfs, tuterm, tupagespec, tulayout (chapter [Building Blocks for Applications](062-anwendungsbausteine.md)) |
| Network | tufetch, tudav, tuhttps, tusparql |
| Settings / test | tusettings, tutestrun |
| Tasks / async | tutask |
| Strings / dates / numbers | tustr, tudate, tunum, tupath (chapter [Characters, Numbers, Dates and Paths](045-zeichen-zahlen-datum.md)) |
| Diagnostics | tupkgfinder, tuappinfo |

## New in 0.68.0

Corrections from the review of this book; each with a regression test.
Rows marked "behavior" change previous results.

| Module | Version | Change |
|---|---|---|
| `tuagrep` | 0.2 | `-maxdist` checked; `search` without empty final line; error codes (behavior); number-like text kept |
| `tuappinfo` | 0.2 | `-anonymize` hides all paths; unknown options are errors |
| `tuarchitecture` | 0.2 | label falling back to the id |
| `tuawk` | 0.2 | rules in their own frame (8.6 = 9.0); `NR`/`NF` initially 0; option without value is an error |
| `tubase32` | 0.2 | `decode` checks length and padding bits (`LENGTH`, `BITS`) (behavior) |
| `tubookmark` | 0.2 | escaping of `"`; each `<A>` one entry |
| `tucal` | 0.2 | `year` row by row like `cal`; title centered; no spaces at end of line (behavior) |
| `tuclass` | 0.2 | single-line class block; edges with cardinalities stay |
| `tucmp` | 0.2 | compares bytes; characters above 255 are `BYTES` (behavior) |
| `tucode` | 0.2 | `signs` with options; `lookup U+00E4`; matrix aligned |
| `tucolor` | 0.2 | triples decimal (8.6 = 9.0); `fromHsv` checks ranges (`HSV`) (behavior) |
| `tucomm` | 0.2 | `-sort 1` sorts like the comparison (behavior) |
| `tudeploy` | 0.2 | `addModulePaths` without rejected roots; options checked first |
| `tudhash` | 0.2 | width and height checked |
| `tudiagram` | 0.5 | title is drawn; unknown theme is `THEME`; number-like text kept |
| `tuer` | 0.3 | quotes around labels removed |
| `tuexe` | 0.2 | option without value is an error |
| `tuexpand` | 0.2 | `unexpand` like GNU; `expand` rejects `-all` (behavior) |
| `tufile` | 0.2 | `type`, `mime` unchanged |
| `tufind` | 0.2 | `-tails` name unchanged |
| `tuflow` | 0.3 | header line case-insensitive; `A & B --> C`; `sankey` recognized |
| `tufold` | 0.2 | `-words 1` without spaces at end of line |
| `tufuzzy` | 0.2 | error codes; `-nocase` checked |
| `tugantt` | 0.2 | without start date `DATE`; axis without duplicate dates; height automatic |
| `tugit` | 0.2 | commit id as label |
| `tugrep` | 0.1.3 | file name with `-fileswithmatches` |
| `tuhexdump` | 0.2 | options checked; error codes; `BYTES` |
| `tuhexedit` | 0.2 | `OFFSET`, `RANGE` (no writing past the end), `BYTES`, `ENCODING` (behavior) |
| `tuico` | 0.2 | directory read unsigned |
| `tujoin` | 0.1.2 | options through `parseOptions`; error codes |
| `tujourney` | 0.2 | ratings with decimal places; otherwise `VALUE` |
| `tulayout` | 0.2 | `ensureBlocks` accepts definitions; options checked (`OPTION`) |
| `tuldif` | 0.2 | Base64 over UTF-8; `CHANGETYPE` (behavior) |
| `tulog` | 0.2 | options checked before creation |
| `tummdb` | 0.2 | IPv6 expanded correctly at `::` |
| `tumonthpng` | 0.5 | header follows `-firstweekday`; `-title` for quarter and year (behavior); number-like text kept |
| `tunl` | 0.2 | start, step, width checked |
| `tunotesdb` | 0.2 | `fromStore` keeps children; child before parent allowed |
| `tunumany` | 0.2 | option without value is an error |
| `tunumfmt` | 0.2 | `KiB` etc. as IEC (`2KiB` = 2048) |
| `tuod` | 0.2 | `-format`/`-address` checked in advance; `BYTES` |
| `tuopen` | 0.2 | all commands exported; URLs under Windows through `rundll32` |
| `tupacket` | 0.2 | field label |
| `tupagespec` | 0.2 | numbers always decimal; number-like text kept |
| `tupaste` | 0.2 | options through `parseOptions` |
| `tupatch` | 0.2 | `-reverse`/`-strict` checked |
| `tupie` | 0.2 | `1e3` valid; negative values `VALUE` |
| `tupng` | 0.5 | `tRNS` with color type 2; CRC checked (`CRC`); number-like text kept |
| `tupngdraw` | 0.13 | `paste` blends alpha correctly |
| `tupngpad` | 0.2 | options checked; unknown `-align` is an error (behavior) |
| `tuprovider` | 0.2 | `head` returns content unchanged |
| `tuprovider::sftp` | 0.2 | host in the sftp target |
| `turadar` | 0.2 | legend only for named series; number-like text kept |
| `turrule` | 0.2 | YEARLY with BYMONTH/BYDAY/BYMONTHDAY; `UNTIL` as a whole day; `UNSUPPORTED` (behavior) |
| `tuseq` | 0.2 | options in any position; large numbers under 8.6 |
| `tusequence` | 0.2 | `<<->>`; title is drawn; number-like text kept |
| `tushuf` | 0.2 | large `-seed` under 8.6 |
| `tusize` | 0.2 | links with their own size; `human` up to YiB (behavior) |
| `tusparql` | 0.2 | endpoint with `?`; `Accept` only once; all variables; number-like text kept |
| `tusplit` | 0.2 | `splitBytes` with `BYTES`; missing value is an error |
| `tustat` | 0.2 | links with `lstat` and `target`; `modeOctal` (behavior) |
| `tustrings` | 0.2 | `-minlength` checked; `-encoding` dropped; `BYTES` (behavior) |
| `tusvg` | 0.3 | method `icon` valid; 149 symbols |
| `tutable` | 0.2 | `COLUMNS`, `HEADERS`; minimum width 3 |
| `tutablepng` | 0.2 | cell text unchanged; `-padding`/`-spacing` checked |
| `tutdbc` | 0.2 | column values in `rows` unchanged (`01234`) |
| `tutee` | 0.2 | open all targets first, clean up on error |
| `tuterm` | 0.2 | `names reset`; `enable` checked (behavior) |
| `tutimeline` | 0.2 | `12:30` stays whole |
| `tutr` | 0.2 | `RANGE`, `SET2`; last mapping wins; squeeze-only possible |
| `tutreemap` | 0.2 | values ≤ 0 are dropped |
| `tutsort` | 0.2 | cycle message only with cycle nodes |
| `tuvalidate` | 0.2 | `port` decimal digits only; `ipv4` without leading zeros |
| `tuwc` | 0.2 | `file`: `bytes` is the file size (behavior) |
| `tuxxhash` | 0.2 | text as UTF-8, option `-encoding` (behavior) |
| `tuzipfs` | 0.3 | `rcopy` with dot files |

When copying over an older tree, delete the module's old file
(e.g. `tuawk-0.1.tm` next to `tuawk-0.2.tm`). The umbrella is at 0.68.0.

## New in 0.67.0

| Module | Version | Change |
|---|---|---|
| `tupdftext` | 0.1 | new: text of a PDF per page, pure Tcl; in the umbrella; `tupdf.tcl text` |

Otherwise the module versions stayed the same; the umbrella was at 0.67.0.

## New in 0.66.0

| Module | Version | Change |
|---|---|---|
| `tutask` | 0.2 | requires `common` 0.2; pool and group errors fixed; `-timeout` checked everywhere |

Otherwise the module versions stayed the same; the umbrella was at 0.66.0.
When copying over an older tree, delete `tutask-0.1.tm`.

## New in 0.65.0

| Module | Version | Change |
|---|---|---|
| `tutask` | 0.1 | new: tasks on coroutines, `await`, `cancel`, groups, pool, sandbox; in the umbrella |

Otherwise the module versions stayed the same; the umbrella was at 0.65.0.

## New and Changed in 0.64.0

| Module | Version | Change |
|---|---|---|
| `tustr` | 0.2 | `graphemes`, `isPrintable` (Unicode) |
| `tudate` | 0.2 | `zones` |
| `tunum` | 0.4 | `format` rounds half away from zero, the same on every platform |
| `tupath` | 0.1 | `clean` keeps the root (`C:/` under Windows) |
| `tusettings` | 0.1 | new: INI settings, `dir`, recent list |
| `tutestrun` | 0.1 | new: shared runner, not in the umbrella |
| `tupkgfinder` | 0.2 | `candidates`, `shadows` |

Still relevant from 0.63.0: `tuhttps` 0.1 (new), `tufetch` 0.4,
`tudav` 0.2, `tupostgrest` 0.2, `tuprovider::ftp` 0.2 (tcllib only on
`open`), `common` 0.2 (`ensureOneOf`).

## Summary

- 144 modules in the 0.68.0 tree, all with a test, doc and man page.
- In 0.68.0, 76 modules got fixes and a new version.
- New in 0.67.0: `tupdftext` 0.1.
- In 0.66.0 only `tutask` changed (0.2); new in 0.65.0 was `tutask` 0.1.

---

*Next chapter: [Glossary](820-anhang-glossar.md)*
