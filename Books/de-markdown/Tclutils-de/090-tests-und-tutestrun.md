# Tests und tutestrun

## Suite

```bash
tclsh8.6 tests/all.tcl
tclsh8.6 tests/all.tcl -match 'tusettings-*'
```

Jede `*.test`-Datei läuft in eigenem Prozess; tcltest-Optionen wie
`-match` reicht der Runner durch. Das Banner zeigt, wohin `tclutils`
aufgelöst wird. Zeitgrenze pro Datei: Umgebung `TCLUTILS_TESTGRENZE`
(Default 120 s). Am Ende listet der Runner „Files with problems“ oder
meldet `All test files passed`; Exit-Code 1 bei Problemen. Findet
`all.tcl` den Runner nicht, bricht es mit Exit-Code 2 und
`all.tcl: tclutils::tutestrun not found (set TCLUTILS_TM)` ab.

Ergebnis für tclutils 0.69.0 unter Linux (Xvfb), macOS und Windows:

| Lauf | Dateien | Tests | bestanden | übersprungen | fehlgeschlagen |
|---|---|---|---|---|---|
| Tcl 8.6.14 mit tls 1.7.22, Thread 2.8.9, tDOM 0.9.3 | 156 | 2642 | 2617 | 25 | 0 |
| Tcl 9.0.4 (aus den Quellen gebaut) mit tls 2.0 (OpenSSL 3.0.13), Thread 3.0.6, tDOM 0.9.7 | 156 | 2642 | 2625 | 17 | 0 |
| macOS (Darwin 27, arm64), Tcl/Tk 9.0.4 (Aqua), Stand vor den Schreibfehler-Tests | 154 | 2582 | 2567 | 15 | 0 |
| Windows, Tcl 8.6.17 (Systemkodierung cp1252), Stand vor den Schreibfehler-Tests | 154 | 2582 | 2545 | 37 | 0 |
| Windows, Tcl 9.0.4, Stand vor den Schreibfehler-Tests | 154 | 2582 | 2549 | 33 | 0 |

Kein Test schlägt fehl. Übersprungene Tests hängen
an fehlenden Paketen oder an der Plattform (Constraints wie `tdbc`,
`haveTk`, `net`, `windows`).

---

## tutestrun

[tutestrun]{.index} **0.2** ist der gemeinsame Runner für tclutils,
tkutils und ctrlutils. **Nicht** im Umbrella — `tests/all.tcl` sourct die
`.tm` aus dem Baum unter Test (eigenes `lib/tm`, `$env(TCLUTILS_TM)` oder
der Geschwister-Checkout), sonst gewinnt ein altes Install.

```tcl
exit [::tclutils::tutestrun::run $here {tclutils} \
    -limitvar TCLUTILS_TESTGRENZE -argv $argv]
```

Was `run` tut:

1. **Eigene Bäume zuerst.** Nur die eigenen Bäume (`lib/tm` des Repos und
   die Geschwister-Checkouts der genannten Libs) werden aus
   `TCL8_6_TM_PATH` / `TCL9_0_TM_PATH` entfernt und im Runner vorn
   eingesetzt. Fremde Einträge bleiben stehen. Grund: steht der Baum
   schon hinter einem `site-tcl` mit derselben Versionsnummer, bewirkt
   `tcl::tm::path add` nichts, und getestet würde die installierte Kopie.
2. **Banner.** Wohin jede Lib aufgelöst wird — gesucht, ohne etwas zu
   laden —, andere Versionen daneben als `(also: <version>)`, gesetzte
   Variablen (`TCL8_6_TM_PATH`, `TCL9_0_TM_PATH`, `TCLLIBPATH`,
   `<LIB>_TM`) als `note: … is set: …`.
3. **Grenze pro Datei.** `-limit` Sekunden (Default 120) oder der Wert
   der Umgebungsvariable aus `-limitvar`, wenn er eine positive Ganzzahl
   ist; eine hängende Datei wird beendet (Unix: `kill -TERM`, dann
   `-KILL`; Windows: `taskkill /T /F`).
4. **Ungültige Bytes.** Tcl 9 liest Kanäle strikt: ein Byte, das in der
   Systemkodierung ungültig ist, ließ den Lauf bis zur Grenze stehen.
   tutestrun ersetzt solche Bytes (`-profile replace`); Tcl 8.6 braucht
   das nicht.
5. **Testdateien in UTF-8.** Jede Datei startet als
   `tclsh -encoding utf-8 datei.test`. Tcl 8.6 läse sie sonst in der
   Systemkodierung, unter Windows cp1252, und jeder erwartete Wert mit
   Umlaut würde falsch; mit tutestrun 0.1 schlugen so 19 Tests fehl.
6. **Zusammenfassung.** Fehlgeschlagene Tests, fehlende tcltest-Summe,
   Exit ungleich 0 oder Hänger landen unter „Files with problems“.
   tcltest beendet eine Datei auch bei Fehlern mit 0 — die Summenzeile
   zählt.

Optionen von `run`: `-argv`, `-limit`, `-limitvar`. Unbekannte Optionen:
`{TCLUTILS TUTESTRUN OPTION <opt>}`. Eine direkt
gestartete Testdatei ohne Runner ist dem `site-tcl`-Problem weiter
ausgesetzt.

---

## Herkunft prüfen: tupkgfinder 0.2

Die Paketdatenbank kennt pro Version nur ein `ifneeded`. Liegt dieselbe
Version zweimal auf den Pfaden, sieht man die zweite Kopie dort nicht.
[tupkgfinder]{.index} 0.2 sucht deshalb selbst:

- `candidates` — jede Kopie eines Pakets auf Modulpfaden und
  `auto_path`, als Dict `{package version kind path}`.
- `shadows` — pro Paket mit mehr als einer Kopie: welche aktiv ist, und
  für jede Kopie ein `status` (`active`, `same version`, `other
  version`). `duplicate` ist 1, wenn eine Version doppelt liegt.

```tcl
package require tclutils::tupkgfinder
foreach d [::tclutils::tupkgfinder::candidates -pattern tclutils::tunum] {
    puts "[dict get $d version] [dict get $d kind] [dict get $d path]"
}
foreach d [::tclutils::tupkgfinder::shadows -pattern tclutils::*] {
    if {[dict get $d duplicate]} { puts "doppelt: [dict get $d package]" }
}
```

Geladen wird dabei nichts. Die Ausgabe ist
`0.4 tm …/lib/tm/tclutils/tunum-0.4.tm`; `shadows` fand keine
doppelte Kopie, und `tclutils::tunum` war danach nicht geladen.
`shadows` lässt für Pakete mit nicht registrierten Kopien ein
unerfüllbares `package require` laufen; dabei liest Tcl die
`pkgIndex.tcl`-Dateien, lädt aber nichts.

`kind` ist `tm` (Pfad der `.tm`-Datei) oder `pkgIndex` (Pfad der
`pkgIndex.tcl`; nur wörtliche `package ifneeded NAME VERSION`-Zeilen
werden erkannt). Falsche Optionen werfen `{TCLUTILS TUPKGFINDER OPTION}`,
etwa `unknown option "-x" (-pattern, -tmpaths, -autopath)`.

---

## Prüfregeln: tulint

[tulint]{.index} prüft Tcl-Quelltexte und liefert die Befunde als Daten:
eine Liste von Dicts mit `file`, `line`, `rule`, `severity` und
`message`. Das Modul gibt nichts aus und beendet nichts; die
Kommandozeile ist `bin/tulint.tcl`. Die Regelnamen sind die Kennungen aus
dem Buch *Tcl/Tk Qualität*:

| Regel | Stufe | Findet |
|---|---|---|
| `ENC-1` | warning | Nicht-ASCII-Zeichen in einer `*.test`-Datei |
| `ENC-2` | error | `source` ohne `-encoding` in `pkgIndex.tcl` |
| `ENC-3` | warning | Nicht-ASCII-Zeichen außerhalb von Kommentaren in einem `*.tcl`-Skript |
| `TST-3` | error | derselbe Testname zweimal in einer Datei |
| `DAT-2` | info | `open` mit `w`, `wb`, `w+` oder `TRUNC` außerhalb von Testdateien |

```tcl
package require tclutils::tulint
set f [::tclutils::tulint::checkText \
    "test a {} -result {}\ntest a {} -result {}\n" -file x.test]
::tclutils::tulint::format $f
;# -> x.test:2: error TST-3: test name "a" already used in line 1
::tclutils::tulint::summary $f        ;# -> error 1 warning 0 info 0
```

`TST-3` liest ganze Befehle (`info complete`), nicht Zeilen, und steigt
in geklammerte Rümpfe ab. Zwei Zweige desselben `if` oder `switch` gelten
als Alternativen. `check pfade ?-rules namen? ?-exclude muster?` läuft
über Verzeichnisse. Eigene Regeln kommen mit
`register name stufe beschreibung cmd` dazu; `cmd` bekommt Dateiname und
Text und liefert Paare `{zeile meldung}`. Ein Kommentar
`# tulint: ignore REGEL` gilt für die nächste Zeile, `;# tulint: ignore
REGEL` am Zeilenende für diese Zeile.

`bin/tulint.tcl` endet mit 1, sobald ein Befund der Stufe `error` dabei
ist. `--severity` filtert nur die Ausgabe, nicht den Exit-Code. Eine
unbekannte Option oder Regel ist ein Fehler `{TCLUTILS TULINT OPTION}`
bzw. `RULE`.

---

## Windows

Laut CHANGELOG läuft die Suite seit 0.64.0 auch unter Windows: keine
`/dev/null`- oder Unix-Wurzeln in Fixtures; Tests, die ein CA-Bundle
brauchen, werden ohne eines übersprungen (Constraint `caOK`). In 0.65.0
kamen die Windows-Tests `tutask` 2.8w/4.4w für `pipe` hinzu.

---

## Zusammenfassung

- `tests/all.tcl` → tutestrun: eigene Bäume zuerst, Banner, Limit.
- Runner aus dem Baum sourcen, nicht blind require.
- Doppelte Kopien findet `tupkgfinder::shadows`.
- Fehlerklassen aus dem Qualitätsbuch prüft `tulint`.

---

*Nächstes Kapitel: [Grenzen](100-grenzen.md)*
