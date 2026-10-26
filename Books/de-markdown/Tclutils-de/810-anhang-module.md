# Module (Orientierung)

Keine vollständige Liste — Stand und Status:
`docs/guide/module-status.md` und `README.md` im tclutils-Baum.
Hygiene-Zählung mit `tools/check-modules.tcl -require test,doc,man`:
**144** Module im Baum 0.68.0, keines ohne
Test, Doc oder man-Seite; 25 davon nicht direkt im Umbrella.

## Kategorien

| Kategorie | Beispiele |
|---|---|
| Textfilter | tucat, tuhead, tugrep, tusort, tucut, tused (Kapitel [Text und Dateien](040-text-und-dateien.md)); tunl, tufold, tufmt, tuexpand, tucolumn, tutable, tutac, turev, tushuf, tuseq, tutr, tuwc, tupr (Kapitel [Weitere Zeilenfilter](042-zeilenfilter.md)) |
| Zusammenführen / Abläufe | tupaste, tujoin, tucomm, tucsplit, tusplit, tutee, tuxargs, tutsort, tuawk, tufuzzy, tuagrep (Kapitel [Zusammenführen, Aufteilen, Abläufe](043-zusammenfuehren-und-ablaeufe.md)) |
| Daten | tucsv, tujson, tuini, tuxml, tusqlite, tuldif, tubookmark (Kapitel [Datenformate](050-datenformate.md)); tutdbc, tummdb (Kapitel [TDBC und MaxMind](051-tdbc-und-mmdb.md)) |
| Kodierung | tubase64, tubase32, tucrc, tuhash, tuxxhash, tuiconv, tuuuid, tuurl, tudict, tudiff, tupatch (Kapitel [Kodierung, Hash und Vergleich](052-kodierung-hash-vergleich.md)) |
| Binärdaten | tuhexdump, tuod, tustrings, tuhexedit, tucmp, tusize, tustat, tucode (Kapitel [Binärdaten und Dateiinformationen](053-binaerdaten-und-dateiinfo.md)) |
| Notizen | tumd, tuical, turrule, tuvcard, tunotes, tunotesdb, tucal, tuholiday (Kapitel [Notizen und Kalender](054-notizen-und-kalender.md)) |
| Dokumente | tupdftext, tupdf, tuodf (Kapitel [Text aus PDF-Dateien](055-pdf-text.md), [ODF und PDF-Struktur](057-odf-und-pdf-struktur.md)) |
| Diagramme | tudiagram, tuflow und die Arten aus `toSvg` (Kapitel [Diagramme](056-diagramme.md)) |
| Bilder | tucolor, tupng, tupngdraw, tutablepng, tucodepng, tumonthpng, tupngpad, tusvg, tuimage, tuico, tudhash (Kapitel [Bilder ohne Tk](058-bilder-ohne-tk.md)) |
| FS / Archiv | tufile, tufind, tuzip |
| Provider | tuprovider, …::zip, …::dav |
| Anwendung | tulog, tuevent, turegistry, tuvalidate, tulist, tumath, tunumany, tuappinfo, tudeploy, tuexe, tuopen, tuzipfs, tuterm, tupagespec, tulayout (Kapitel [Bausteine für Anwendungen](062-anwendungsbausteine.md)) |
| Netz | tufetch, tudav, tuhttps, tusparql |
| Settings / Test | tusettings, tutestrun |
| Tasks / async | tutask |
| Strings / Datum / Zahlen | tustr, tudate, tunum, tupath (Kapitel [Zeichen, Zahlen, Datum und Pfade](045-zeichen-zahlen-datum.md)) |
| Diagnose | tupkgfinder, tuappinfo |

## Neu in 0.68.0

Korrekturen aus der Prüfung dieses Buchs; jede mit Regressionstest.
Mit „Verhalten“ markierte Zeilen ändern bisherige Ergebnisse.

| Modul | Version | Änderung |
|---|---|---|
| `tuagrep` | 0.2 | `-maxdist` geprüft; `search` ohne leere Schlusszeile; Fehlercodes (Verhalten); zahlähnlicher Text bleibt |
| `tuappinfo` | 0.2 | `-anonymize` verdeckt alle Pfade; unbekannte Optionen sind Fehler |
| `tuarchitecture` | 0.2 | Beschriftung, die auf die Id zurückfällt |
| `tuawk` | 0.2 | Regeln in eigenem Rahmen (8.6 = 9.0); `NR`/`NF` vorab 0; Option ohne Wert ist Fehler |
| `tubase32` | 0.2 | `decode` prüft Länge und Füllbits (`LENGTH`, `BITS`) (Verhalten) |
| `tubookmark` | 0.2 | Maskierung von `"`; jedes `<A>` ein Eintrag |
| `tucal` | 0.2 | `year` zeilenweise wie `cal`; Titel mittig; keine Leerzeichen am Zeilenende (Verhalten) |
| `tuclass` | 0.2 | einzeiliger Klassenblock; Kanten mit Kardinalitäten bleiben |
| `tucmp` | 0.2 | vergleicht Bytes; Zeichen über 255 sind `BYTES` (Verhalten) |
| `tucode` | 0.2 | `signs` mit Optionen; `lookup U+00E4`; Matrix bündig |
| `tucolor` | 0.2 | Tripel dezimal (8.6 = 9.0); `fromHsv` prüft Bereiche (`HSV`) (Verhalten) |
| `tucomm` | 0.2 | `-sort 1` sortiert wie der Vergleich (Verhalten) |
| `tudeploy` | 0.2 | `addModulePaths` ohne abgelehnte Wurzeln; Optionen zuerst geprüft |
| `tudhash` | 0.2 | Breite und Höhe geprüft |
| `tudiagram` | 0.5 | Titel wird gezeichnet; unbekanntes Theme ist `THEME`; zahlähnlicher Text bleibt |
| `tuer` | 0.3 | Anführungszeichen um Beschriftungen entfernt |
| `tuexe` | 0.2 | Option ohne Wert ist Fehler |
| `tuexpand` | 0.2 | `unexpand` wie GNU; `expand` lehnt `-all` ab (Verhalten) |
| `tufile` | 0.2 | `type`, `mime` unverändert |
| `tufind` | 0.2 | `-tails`-Name unverändert |
| `tuflow` | 0.3 | Kopfzeile ohne Groß/Klein; `A & B --> C`; `sankey` erkannt |
| `tufold` | 0.2 | `-words 1` ohne Leerzeichen am Zeilenende |
| `tufuzzy` | 0.2 | Fehlercodes; `-nocase` geprüft |
| `tugantt` | 0.2 | ohne Startdatum `DATE`; Achse ohne doppelte Daten; Höhe automatisch |
| `tugit` | 0.2 | Commit-Id als Beschriftung |
| `tugrep` | 0.1.3 | Dateiname bei `-fileswithmatches` |
| `tuhexdump` | 0.2 | Optionen geprüft; Fehlercodes; `BYTES` |
| `tuhexedit` | 0.2 | `OFFSET`, `RANGE` (kein Schreiben über das Ende), `BYTES`, `ENCODING` (Verhalten) |
| `tuico` | 0.2 | Verzeichnis vorzeichenlos gelesen |
| `tujoin` | 0.1.2 | Optionen über `parseOptions`; Fehlercodes |
| `tujourney` | 0.2 | Bewertungen mit Nachkommastelle; sonst `VALUE` |
| `tulayout` | 0.2 | `ensureBlocks` nimmt Definitionen; Optionen geprüft (`OPTION`) |
| `tuldif` | 0.2 | Base64 über UTF-8; `CHANGETYPE` (Verhalten) |
| `tulog` | 0.2 | Optionen vor dem Anlegen geprüft |
| `tummdb` | 0.2 | IPv6 an `::` richtig aufgefüllt |
| `tumonthpng` | 0.5 | Kopf folgt `-firstweekday`; `-title` bei Quartal und Jahr (Verhalten); zahlähnlicher Text bleibt |
| `tunl` | 0.2 | Start, Schritt, Breite geprüft |
| `tunotesdb` | 0.2 | `fromStore` behält Kinder; Kind vor Elter erlaubt |
| `tunumany` | 0.2 | Option ohne Wert ist Fehler |
| `tunumfmt` | 0.2 | `KiB` usw. als IEC (`2KiB` = 2048) |
| `tuod` | 0.2 | `-format`/`-address` vorab geprüft; `BYTES` |
| `tuopen` | 0.2 | alle Befehle exportiert; URLs unter Windows über `rundll32` |
| `tupacket` | 0.2 | Feldbeschriftung |
| `tupagespec` | 0.2 | Zahlen immer dezimal; zahlähnlicher Text bleibt |
| `tupaste` | 0.2 | Optionen über `parseOptions` |
| `tupatch` | 0.2 | `-reverse`/`-strict` geprüft |
| `tupie` | 0.2 | `1e3` gültig; negative Werte `VALUE` |
| `tupng` | 0.5 | `tRNS` bei Farbtyp 2; CRC geprüft (`CRC`); zahlähnlicher Text bleibt |
| `tupngdraw` | 0.13 | `paste` mischt Alpha richtig |
| `tupngpad` | 0.2 | Optionen geprüft; unbekanntes `-align` ist Fehler (Verhalten) |
| `tuprovider` | 0.2 | `head` gibt Inhalt unverändert |
| `tuprovider::sftp` | 0.2 | Host im sftp-Ziel |
| `turadar` | 0.2 | Legende nur bei benannten Reihen; zahlähnlicher Text bleibt |
| `turrule` | 0.2 | YEARLY mit BYMONTH/BYDAY/BYMONTHDAY; `UNTIL` als ganzer Tag; `UNSUPPORTED` (Verhalten) |
| `tuseq` | 0.2 | Optionen an jeder Stelle; große Zahlen unter 8.6 |
| `tusequence` | 0.2 | `<<->>`; Titel wird gezeichnet; zahlähnlicher Text bleibt |
| `tushuf` | 0.2 | große `-seed` unter 8.6 |
| `tusize` | 0.2 | Links mit eigener Größe; `human` bis YiB (Verhalten) |
| `tusparql` | 0.2 | Endpunkt mit `?`; `Accept` nur einmal; alle Variablen; zahlähnlicher Text bleibt |
| `tusplit` | 0.2 | `splitBytes` mit `BYTES`; fehlender Wert ist Fehler |
| `tustat` | 0.2 | Links mit `lstat` und `target`; `modeOctal` (Verhalten) |
| `tustrings` | 0.2 | `-minlength` geprüft; `-encoding` entfällt; `BYTES` (Verhalten) |
| `tusvg` | 0.3 | Methode `icon` gültig; 149 Symbole |
| `tutable` | 0.2 | `COLUMNS`, `HEADERS`; Mindestbreite 3 |
| `tutablepng` | 0.2 | Zelltext unverändert; `-padding`/`-spacing` geprüft |
| `tutdbc` | 0.2 | Spaltenwerte in `rows` unverändert (`01234`) |
| `tutee` | 0.2 | erst alle Ziele öffnen, bei Fehler aufräumen |
| `tuterm` | 0.2 | `names reset`; `enable` geprüft (Verhalten) |
| `tutimeline` | 0.2 | `12:30` bleibt ganz |
| `tutr` | 0.2 | `RANGE`, `SET2`; letzte Zuordnung gilt; nur verdichten möglich |
| `tutreemap` | 0.2 | Werte ≤ 0 fallen weg |
| `tutsort` | 0.2 | Zyklusmeldung nur mit Zyklusknoten |
| `tuvalidate` | 0.2 | `port` nur Dezimalziffern; `ipv4` ohne führende Nullen |
| `tuwc` | 0.2 | `file`: `bytes` ist die Dateigröße (Verhalten) |
| `tuxxhash` | 0.2 | Text als UTF-8, Option `-encoding` (Verhalten) |
| `tuzipfs` | 0.3 | `rcopy` mit Punktdateien |

Beim Überkopieren eines älteren Baums die alte Datei des Moduls löschen
(z. B. `tuawk-0.1.tm` neben `tuawk-0.2.tm`). Der Umbrella steht auf 0.68.0.

## Neu in 0.67.0

| Modul | Version | Änderung |
|---|---|---|
| `tupdftext` | 0.1 | neu: Text einer PDF je Seite, reines Tcl; im Umbrella; `tupdf.tcl text` |

Sonst blieben die Modulversionen gleich; der Umbrella stand auf 0.67.0.

## Neu in 0.66.0

| Modul | Version | Änderung |
|---|---|---|
| `tutask` | 0.2 | verlangt `common` 0.2; Pool- und Gruppen-Fehler behoben; `-timeout` überall geprüft |

Sonst blieben die Modulversionen gleich; der Umbrella stand auf 0.66.0.
Beim Überkopieren eines älteren Baums `tutask-0.1.tm` löschen.

## Neu in 0.65.0

| Modul | Version | Änderung |
|---|---|---|
| `tutask` | 0.1 | neu: Tasks auf Koroutinen, `await`, `cancel`, Gruppen, Pool, Sandbox; im Umbrella |

Sonst blieben die Modulversionen gleich; der Umbrella stand auf 0.65.0.

## Neu und geändert in 0.64.0

| Modul | Version | Änderung |
|---|---|---|
| `tustr` | 0.2 | `graphemes`, `isPrintable` (Unicode) |
| `tudate` | 0.2 | `zones` |
| `tunum` | 0.4 | `format` rundet halb von null weg, plattformgleich |
| `tupath` | 0.1 | `clean` behält die Wurzel (`C:/` unter Windows) |
| `tusettings` | 0.1 | neu: INI-Settings, `dir`, Recent-Liste |
| `tutestrun` | 0.1 | neu: gemeinsamer Runner, nicht im Umbrella |
| `tupkgfinder` | 0.2 | `candidates`, `shadows` |

Aus 0.63.0 weiter relevant: `tuhttps` 0.1 (neu), `tufetch` 0.4,
`tudav` 0.2, `tupostgrest` 0.2, `tuprovider::ftp` 0.2 (tcllib erst beim
`open`), `common` 0.2 (`ensureOneOf`).

## Zusammenfassung

- 144 Module im Baum 0.68.0, alle mit Test, Doc und man-Seite.
- In 0.68.0 haben 76 Module Korrekturen und eine neue Version bekommen.
- Neu in 0.67.0: `tupdftext` 0.1.
- In 0.66.0 geändert ist nur `tutask` (0.2); neu in 0.65.0 war `tutask` 0.1.

---

*Nächstes Kapitel: [Glossar](820-anhang-glossar.md)*
