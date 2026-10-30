# Grenzen

---

- Kein Tk — Widgets und Dialoge gehören nach tkutils.
- Kein vollständiges GNU-coreutils; nur die abgebildeten Filter.
- SFTP und TDBC: eigenes `package require`, ggf. externe Pakete.
- `tuflow` lädt `tudiagram` sofort. Die übrigen Diagramm-Module erst
  beim ersten Abruf der betreffenden Art. `parse` liest Flowcharts;
  `pie` und die weiteren Arten zeichnet `toSvg`. `validate` wirft nicht.
  Siehe [Diagramme](056-diagramme.md).
- `tustr::graphemes` ist vereinfachtes UAX #29 (keine Hangul-Silben,
  keine indischen Konjunkte). `slugify` liefert ASCII; Schriften ohne lateinische Buchstaben fallen weg.
- `tupdf` zählt Seiten an `/Type /Page`. `zugferd` sucht Marker, es prüft
  die Rechnung nicht. `object` wirft `NOTFOUND`, wenn die Nummer nach
  dem Aufblasen fehlt. Siehe [ODF und PDF-Struktur](057-odf-und-pdf-struktur.md).
- `tuodf` liest Absätze aus `text:p`. Tabellen übergeht es. `text`
  verbindet mit `\n`, ein leerer Schlussabsatz lässt den Text damit enden.
- `tupdftext` liest keine Verschlüsselung und keinen Text aus Bildern,
  hält Spalten nicht auseinander und setzt am Zeilenende getrennte Wörter
  nicht zusammen.
- `tuuniq` entfernt nur benachbarte Doppelte. `tucut` ist kein CSV.
- `tujson::parse` macht `true` zu `1` und `null` zu leer.
- `tuhash` ist reines Tcl. Text wird vor dem Digest nach UTF-8 gewandelt.
- `tumd` kennt keine verschachtelten Listen, Tabellen und Setext-Überschriften.
  Der Anker behält Buchstaben jeder Schrift, Ziffern, `_` und `-`.
- `tuical` und `tuvcard` lassen Eigenschaftswerte roh. `toIcs` und `toVcf`
  schreiben CR/LF.
- `tuholiday` kennt nur `-region de` und keine landesspezifischen Tage.
- `tudict::getOr` stellt die Vorgabe vor den Pfad. `flatten` nimmt eine
  gerade Liste als Dict.
- `tudiff` baut die Vergleichstabelle im Speicher, Grenze `-maxcells`.
- `tusqlite` lädt `sqlite3` nicht. Eine als NULL geschriebene Zelle kommt
  aus `rows` leer zurück.
- `tutdbc` lädt keinen TDBC-Treiber und steht nicht im Umbrella.
  SQL-NULL bleibt eine Spalte mit leerem Wert. Siehe
  [TDBC und MaxMind](051-tdbc-und-mmdb.md).
- `tummdb` hält die Datei im Speicher. `open` und `close` sind nicht
  exportiert. Eine Adresse ohne Satz ergibt die leere Zeichenkette.
- `tudate::diff -unit days` teilt Sekunden durch 86400. `relative`
  antwortet englisch.
- `tupath::relative` verlangt zwei absolute oder zwei relative Pfade.
- Ein ZIP-Provider kennt kein `put`. Die Meldung hat keinen `-errorcode`.
- `tufetch` ohne Server liefert `URL` und `CAFILE`. `socketCmd` öffnet
  keinen Socket. Unter tls 2 hängt es kein CA-Bundle an.
- `tutask`: Die Sandbox läuft im aufrufenden Thread, parallel ist nur der
  Pool (Paket `Thread`). `pipe` beendet unter Unix beim Abbruch nur die
  direkten Prozesse, keine Enkel. `-commands` allein stoppt keine leere
  Schleife. Siehe [Tasks mit tutask](085-tutask.md).
- Modul-Docs und man sind die API-Wahrheit; dieses Buch ist der Pfad.

Stack, Dateiblick, Explorer: Buch *Utils-Stack*.

---

## Windows-Hinweise

Die Tabelle gibt Code und CHANGELOG wieder, nicht eigene Tests unter
Windows.

| Thema | Verhalten unter Windows |
|---|---|
| `tunum::format` | rundet wie unter Linux (seit 0.4), nicht nach C-Laufzeit |
| `tupath::clean` | `..` endet an der Laufwerkswurzel `C:/` |
| `tusettings::dir` | `%APPDATA%`, `%LOCALAPPDATA%`, `%TEMP%` |
| Recent-Liste | gleiche Datei ohne Groß/Klein-Unterschied erkannt |
| HTTPS mit tls 1.x | kein System-CA-Speicher: `SSL_CERT_FILE` oder `-cafile` |
| `tufetch` ohne CA-Bundle | weicht auf curl/wget aus, sonst `NOMETHOD` |
| Testsuite | läuft laut CHANGELOG; CA-Tests ohne Bundle übersprungen |
| `tutask::pipe` | Abbruch per `taskkill /T /F`, auch Kindprozesse |

---

## Zusammenfassung

- Engines ja, GUI und App-Glue nein.
- Optionale Backends explizit laden.
- Unter Windows: CA-Bundle für tls 1.x bereitstellen.
- `tutask` hat dokumentierte Grenzen bei Prozessen und Sandbox-Limits.

---

*Nächstes Kapitel: [Fallen](800-anhang-fallen.md)*
