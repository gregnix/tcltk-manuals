# Module (Orientierung)

Keine vollständige Liste — Stand und Status:
`docs/guide/module-status.md` und `README.md` im tclutils-Baum.
Hygiene-Zählung mit `tools/check-modules.tcl -require test,doc,man`:
**146** Module im Baum 0.69.0, keines ohne
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
| Settings / Test | tusettings, tutestrun, tulint |
| Tasks / async | tutask |
| Strings / Datum / Zahlen | tustr, tudate, tunum, tupath (Kapitel [Zeichen, Zahlen, Datum und Pfade](045-zeichen-zahlen-datum.md)) |
| Diagnose | tupkgfinder, tuappinfo, tusysinfo, tuedid |

## Neu in 0.69.0

| Modul | Version | Änderung |
|---|---|---|
| `tucsv` | 0.2 | `-profile excel-de` oder `rfc4180`, `text -bom 1`, `-encoding` für `file` und `writeFile` (Vorgabe UTF-8); `writeFile` behält die Zeilenenden von `-newline` |
| `tusqlite` | 0.2 | `rows` und `value` mit Parameter-Dict, Variablen des Aufrufers erreichen die Abfrage nicht mehr (Verhalten); neu `update`, `delete` |
| `tusysinfo` | 0.1 | neu: Betriebssystem, CPU, Speicher, Modell, Festplatten, Monitore; im Umbrella; `bin/tusysinfo.tcl` |
| `tuedid` | 0.1 | neu: EDID-Block eines Monitors lesen; im Umbrella |
| `tuholiday` | 0.2 | `-sundays 0` für die neun bundesweiten Tage; Vorgabe 1 wie bisher |
| `tuzip` | 0.2 | Namen in UTF-8 mit UTF-8-Flag (Verhalten); Lesen mit `-encoding auto` |
| `tudiff` | 0.2 | `-eol ignore\|strict`, `-encoding` für Dateien; `text` übergeht CR auch in Zeichenketten (Verhalten) |
| `tubookmark` | 0.3 | Reihenfolge bleibt, Schlüssel `folders`, `HREF` in einfachen Anführungszeichen (Verhalten); `<DD>`-Beschreibung und Lesezeichenleiste bleiben erhalten |
| `tuical`, `tuvcard` | 0.2 | `toIcs` und `toVcf` schließen auch die letzte Zeile mit CR/LF ab (Verhalten) |
| `tuini` | 0.2 | `setValue`, `addSection`, `toIni` lehnen ab, was INI nicht fassen kann, etwa einen Zeilenumbruch im Wert (Verhalten) |
| `tupatch` | 0.3 | das letzte `\n` bleibt; `\ No newline at end of file` wie bei `diff -u` (Verhalten) |
| `tusplit` | 0.3 | Zeilenteile behalten ihre Zeilenenden; `file -lines` teilt Bytes (Verhalten) |
| `tutee` | 0.3 | `writeFile` kopiert Bytes, gibt die Bytezahl zurück (Verhalten) |
| `tumd` | 0.2 | Anker wie bei GitHub, mit Umlauten und `-1`, `-2` (Verhalten) |
| `tuiconv` | 0.2 | streng unter 8.6 und 9.0, `-replace 1` (Verhalten) |
| `tucat` | 0.2 | keine Nummer nach dem letzten `\n`, `files` zählt durch (Verhalten) |
| `tuldif` | 0.3 | Binärattribute behalten ihre Bytes, `-binary` (Verhalten) |
| `tucsplit` | 0.2 | Teile behalten ihre Zeilenenden, `-encoding` (Verhalten) |
| `tuhead`, `tutail` | 0.2 | Zeilenenden wie `head`/`tail`, `text` = `file`, `COUNT` (Verhalten) |
| `tugrep` | 0.2 | keine leere Zeile hinter dem letzten `\n` (Verhalten) |
| `tustr` | 0.3 | `slugify` schreibt Umlaute um, `toCamel`/`toSnake` mit Unicode (Verhalten) |
| `tuer` | 0.4 | Entitätsnamen mit Umlauten; `SYNTAX` (Verhalten) |
| `tugantt` | 0.3 | unbekannte Einheit `DURATION`; Ids mit Umlauten; `writeSvg`/`writePng` über temporäre Datei (Verhalten) |
| `tuxychart` | 0.2 | `COUNT`, wenn Werte und Kategorien nicht passen; Schreiben über temporäre Datei (Verhalten) |
| `tusankey` | 0.2 | schlechte Zeilen `VALUE` statt still weg; Schreiben über temporäre Datei (Verhalten) |
| `tudate` | 0.3 | Tage und Monate, die es nicht gibt, sind `PARSE`, auch unter 8.6; `m/d/Y` nach `d/m/Y`; mehr Formate (Verhalten) |
| `tunumany` | 0.3 | Dezimalkomma vor der Einheit, `1,5K` ist 1500 (Verhalten) |
| `tubase64`, `tucrc` | 0.2 | `-encoding binary\|utf-8`; ein Zeichen über 255 ist `BYTES` (Verhalten) |
| `tudav` | 0.3 | Basic-Anmeldung in UTF-8; `.` und `..` in einer `href` aufgelöst (Verhalten) |
| `tuflow` | 0.4 | Knoten-Ids mit Umlauten (Verhalten) |
| `tuc4` | 0.2 | Ids mit Umlauten (Verhalten) |
| `tugit` | 0.3 | doppelte Commit-Id ist `DUPID` (Verhalten) |
| `turadar` | 0.3 | genau ein Wert je Achse, sonst `COUNT` oder `AXIS`; Schreiben über temporäre Datei (Verhalten) |
| `tusort`, `tuuniq`, `tucut`, `tujoin`, `tucolumn`, `tufmt` | 0.2 | abschließendes `\n` wie in der Eingabe (Verhalten) |
| `tupaste`, `tushuf`, `tufold` | 0.3 | abschließendes `\n` wie in der Eingabe (Verhalten) |
| `tutestrun` | 0.2 | Testdateien mit `-encoding utf-8` (Verhalten) |
| `tuarchitecture` | 0.3 | Ids mit Umlauten (Verhalten) |
| `tustate`, `tublock` | 0.2 | Ids mit Umlauten (Verhalten) |
| `tunotes` | 0.2 | Datei immer UTF-8; ältere Dateien in der Systemkodierung werden noch gelesen (Verhalten) |
| `tumindmap` | 0.2 | Ids mit Umlauten vor einer Form (Verhalten) |
| `tulint` | 0.1 | neu: Prüfregeln für Tcl-Quelltexte, nicht im Umbrella |
| `common` | 0.3 | neu `replaceFile`: Schreiben über temporäre Datei |
| `tused`, `tusettings` | 0.2 | Schreiben über `replaceFile`; scheitert es, bleibt die alte Datei und kein Kanal offen (Verhalten) |
| `tuprovider` | 0.3 | lokales `put` über `replaceFile` (Verhalten) |
| `tutreemap` | 0.3 | `:::Klasse` mit Umlauten ganz entfernt; Schreiben über temporäre Datei (Verhalten) |
| `tuclass` | 0.3 | `;` in Anführungszeichen trennt keine Mitglieder (Verhalten) |
| `tuimage` | 0.2 | `;base64` in einem Parameter in Anführungszeichen schaltet Base64 nicht ein (Verhalten) |
| `tupacket`, `tujourney`, `tutimeline`, `tupie`, `tusequence` | 0.3 | `writeSvg`/`writePng` über `replaceFile` (Verhalten) |
| `tukanban`, `tuquadrant` | 0.2 | `writeSvg`/`writePng` über `replaceFile` (Verhalten) |
| `tudiagram` | 0.6 | `writePng` über `replaceFile` (Verhalten) |
| `tusvg` | 0.4 | `write` über `replaceFile` (Verhalten) |
| `tupngdraw` | 0.14 | `write` über `replaceFile` (Verhalten) |
| `tupng` | 0.6 | `write*` über `replaceFile` (Verhalten) |
| `tuappinfo` | 0.3 | Tk-Zeile mit Patchlevel; `writeLog` UTF-8 über `replaceFile` (Verhalten) |

Beim Überkopieren eines älteren Baums `tucsv-0.1.tm`, `tusqlite-0.1.tm`,
`tuholiday-0.1.tm`, `tuzip-0.1.tm`, `tudiff-0.1.tm`, `tubookmark-0.2.tm`,
`tuical-0.1.tm`, `tuvcard-0.1.tm`, `tuini-0.1.tm`, `tupatch-0.2.tm`,
`tusplit-0.2.tm`, `tutee-0.2.tm`, `tumd-0.1.tm`, `tuiconv-0.1.tm`,
`tucat-0.1.tm`, `tuldif-0.2.tm`, `tucsplit-0.1.tm`,
`tuhead-0.1.tm`, `tutail-0.1.tm`, `tugrep-0.1.3.tm`, `tustr-0.2.tm`,
`tuer-0.3.tm`, `tugantt-0.2.tm`, `tuxychart-0.1.tm`, `tusankey-0.1.tm`,
`tudate-0.2.tm`, `tunumany-0.2.tm`, `tubase64-0.1.tm`, `tucrc-0.1.tm`,
`tudav-0.2.tm`, `tuflow-0.3.tm`, `tuc4-0.1.tm`, `tugit-0.2.tm`,
`turadar-0.2.tm`, `tusort-0.1.tm`, `tuuniq-0.1.tm`, `tucut-0.1.tm`,
`tupaste-0.2.tm`, `tujoin-0.1.2.tm`, `tushuf-0.2.tm`, `tucolumn-0.1.tm`,
`tufold-0.2.tm`, `tufmt-0.1.tm`, `tutestrun-0.1.tm`,
`tuarchitecture-0.2.tm`, `tustate-0.1.tm`, `tublock-0.1.tm`,
`tunotes-0.1.tm`, `tumindmap-0.1.tm`, `common-0.2.tm`, `tused-0.1.3.tm`,
`tusettings-0.1.tm`, `tuimage-0.1.tm`, `tuprovider-0.2.tm`, `tutreemap-0.2.tm`,
`tuclass-0.2.tm`, `tupacket-0.2.tm`, `tujourney-0.2.tm`, `tukanban-0.1.tm`,
`tutimeline-0.2.tm`, `tupie-0.2.tm`, `tuquadrant-0.1.tm`, `tusequence-0.2.tm`,
`tudiagram-0.5.tm`, `tusvg-0.3.tm`, `tupngdraw-0.13.tm`, `tupng-0.5.tm`,
`tuappinfo-0.2.tm` und `tclutils-0.68.0.tm` löschen. Der Umbrella steht auf 0.69.0.

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
(z. B. `tuawk-0.1.tm` neben `tuawk-0.2.tm`). Der Umbrella stand auf 0.68.0.

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

- 146 Module im Baum 0.69.0, alle mit Test, Doc und man-Seite.
- Neu in 0.69.0: `tucsv`, `tusqlite`, `tuholiday`, `tuzip`, `tudiff`, `tuical`, `tuvcard`, `tuini`, `tumd`, `tuiconv`, `tucat`, `tucsplit`, `tuhead`, `tutail`, `tugrep`, `tuxychart`, `tusankey` 0.2, `tupatch`, `tusplit`, `tutee`, `tuldif`, `tustr`, `tugantt` 0.3, `tuer` 0.4, `tubookmark` 0.3, `tudate`, `tunumany`, `tubase64`, `tucrc`, `tudav`, `tuflow`, `tuc4`, `tugit`, `turadar` und neun Zeilenfilter, neu `tusysinfo` und `tuedid` 0.1.
- In 0.68.0 haben 76 Module Korrekturen und eine neue Version bekommen.
- Neu in 0.67.0: `tupdftext` 0.1.
- In 0.66.0 geändert ist nur `tutask` (0.2); neu in 0.65.0 war `tutask` 0.1.

---

*Nächstes Kapitel: [Glossar](820-anhang-glossar.md)*
