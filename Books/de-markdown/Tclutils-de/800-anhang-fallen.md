# Fallen

---

- `lappend auto_path` statt `tcl::tm::path add` für `.tm`-Bäume.
- Suite ohne Runner starten und dabei `site-tcl` mit gleicher Version
  vor dem Workspace laden.
- `package require tclutils::tutestrun` gegen ein altes Install — Runner
  aus dem Baum `source`-n.
- HTTPS-Politik pro Modul selbst registrieren und nie zurücknehmen —
  `tuhttps` nutzen.
- `tusettings`-Werte mit Zeilenumbruch oder führenden Leerzeichen —
  INI-Grenze, Fehler `TUSETTINGS VALUE`.
- `tusettings::load …` ohne vollen Namensraum aufrufen —
  `invalid command name`; richtig `::tclutils::tusettings::load`.
- `TUFETCH CAFILE` als „keine CA“ lesen — es heißt: `-cafile` nicht
  lesbar. Fehlt jede CA unter tls 1.x: `TUHTTPS NOCA` bzw.
  `TUFETCH NOMETHOD`.
- In einen ZIP-Provider schreiben wollen — caps sind `get list stat`.
- Beträge mit `format %.2f` runden — Ergebnis hängt von der C-Laufzeit
  ab; `tunum::format` nutzen.
- `tuuniq` auf einer unsortierten Liste — es entfernt nur Nachbarn,
  `a b b a` bleibt `a b a`.
- `tucut` für CSV mit Anführungszeichen — das schneidet am Trennzeichen;
  Felder mit Komma gehören zu `tucsv`.
- `tujson::parse` und danach `null` oder `false` prüfen — `null` ist leer,
  `true` ist `1`, `false` ist `0`. Die Art behält `parseTyped`.
- In einen ZIP-Provider schreiben und auf einen `-errorcode` warten —
  die Meldung ist `does not support 'put'`, ohne Code.
- `string length` als sichtbare Zeichenzahl nehmen — `tustr::graphemes`.
  `truncate` und `padLeft` rechnen weiter mit `string length`.
- `tustr::slugify` und den Anker von `tumd` für dasselbe halten — `slugify`
  macht aus „Größe“ `groesse` (ASCII), `tumd` den Anker `größe`.
- Eine eingerückte Markdown-Liste als verschachtelt lesen — `tumd`
  macht daraus eine flache Liste.
- `tunotes::create` den Speicherwert übergeben — die Änderung verlangt
  den Variablennamen. `get` und `search` bekommen den Wert.
- `tunotes::search` als regulären Ausdruck lesen — es ist `string match`,
  ein Stern in der Frage ist ein Musterzeichen.
- Landesspezifische Feiertage bei `tuholiday` erwarten — nur die
  bundesweite Menge `de`, dazu Oster- und Pfingstsonntag (ohne sie:
  `-sundays 0`).
- `tuflow::parse` auf ein `pie` — `{TCLUTILS TUFLOW UNSUPPORTED}`.
  Zeichnen geht über `toSvg`.
- `tudiagram::addEdge` auf unbekannte Ids und einen Fehler erwarten —
  die Kante hängt am Modell. `validate` meldet `NONODE` und wirft nicht.
- `flowchart TD` als Richtung `TD` im Modell lesen — sie wird `TB`.
- `tunum::parse -locale de-strict` und ein Punkt als Dezimalzeichen —
  `956.06` wird `95606.0`.
- `tudate::diff -unit days` über die Sommerzeit als Kalendertage lesen —
  Sekunden durch 86400; 15. März bis 15. April 2024 ergibt 30.
- `02/03/2026` als 3. Februar lesen — `tudate::parse` nimmt `d/m/Y`
  vor `m/d/Y`, das ist der 2. März. `m/d/Y` greift erst, wenn `d/m/Y`
  kein Datum ergibt (`10/29/2026`).
- Eine Zeichenkette mit Umlaut an `tubase64::encode` oder
  `tucrc::crc32` ohne `-encoding utf-8` — `ö` wird das eine Byte `f6`,
  `€` ist `BYTES`. `tuhash` nimmt dagegen UTF-8.
- `tudate::relative` deutsch erwarten — die Texte sind `today`,
  `tomorrow`, `yesterday`.
- `tudict::getOr` wie `dict get` lesen — die Vorgabe steht vor dem
  Pfad: `getOr $d vorgabe schlüssel …`.
- `tudict::flatten` auf einem Wert wie `a b` — gerade Länge gilt als
  Dict, `{name {a b}}` wird `name.a b`.
- `tuhash` auf Dateibytes mit der Textvorgabe — `sha256` kodiert UTF-8;
  die Bytes der Datei hasht `sha256File`.
- Ungültiges Base64 als Fehler erwarten — `decode` von `!!!` ist leer,
  ohne `-errorcode`.
- SQL-NULL aus `tusqlite::rows` am Sentinel erkennen — die Zelle kommt
  leer zurück. NULL setzt `insert` mit `null`.
- In `tusqlite::rows` einen Platzhalter `:x` aus einer Variablen `x`
  erwarten — seit 0.2 kommt der Wert nur aus dem Parameter-Dict; ohne
  Eintrag ist er NULL.
- Bei TDBC `allrows -as dicts` eine fehlende Spalte als leer lesen —
  NULL-Spalten fallen aus dem Dict. `tutdbc::rows` setzt sie leer wieder
  ein. `0` bleibt `0`.
- `tummdb::close` auf einem unbekannten Handle als Fehler erwarten —
  der Aufruf gibt die leere Zeichenkette zurück. `metadata` wirft
  `HANDLE`.
- `tupdftext` auf einem Scan — `{TCLUTILS TUPDFTEXT NOTEXT}`, nicht ein
  stiller Leerstring. `-notext empty` liefert die leere Seite.
- `tupdf::object` auf eine Nummer, die nach dem Aufblasen fehlt —
  `{TCLUTILS TUPDF NOTFOUND}`. Die Meldung nennt einen Objektstrom.
- `tuodf::text` nach einem leeren Schlussabsatz ohne Zeilenumbruch
  erwarten — die Absätze hängen an `\n`, der Text endet damit.
- Eine zweite Kopie derselben Version im Modulpfad übersehen —
  `tupkgfinder::shadows`.
- `$t wait` außerhalb eines Tasks in einem Tk-Handler aufrufen —
  verschachteltes `vwait`; im Handler nur `spawn`.
- `await` außerhalb einer Koroutine — `TUTASK NOTASK`; in `spawn` oder
  `run` einpacken.
- Sandbox nur mit `-commands` begrenzen — `while 1 {}` läuft weiter;
  `-time` mit setzen.
- Unter Unix erwarten, dass `tutask::pipe` beim Abbruch auch Enkelprozesse
  beendet — nur die direkten Prozesse der Pipeline.
- Einen Task-Fehler nie abholen — beim `destroy` kommt er über `bgerror`.
- tkutils-Code in tclutils erwarten.

---

## Behoben in 0.66.0

Diese Fallen gelten bis 0.65.0. In 0.66.0 sind sie behoben:

- `$g wait -mode first` außerhalb eines Tasks und die Gruppe sofort
  zerstören — in 0.65.0 später `bgerror` „invalid command name …::my“;
  bis 0.65.0 nötig: `after idle [list $g destroy]`.
- `pool` scheitert im Konstruktor (`NOTHREAD`, `-size 0`) — in 0.65.0
  zusätzlich `bgerror` `can't read "jobs": no such variable`.
- `-init` des Pools scheitert — in 0.65.0 bleibt der Job in der
  Warteschlange (`queued 1 jobs 1`).
- Älteres `tclutils::common` als 0.2 auf dem Pfad — `tutask` 0.1 lädt
  trotzdem, `group` und `pool` scheitern erst beim Aufruf. `tutask` 0.2
  verlangt `common` 0.2.
- `run -timeout`, `$t wait -timeout` oder `$g wait -timeout` außerhalb
  eines Tasks mit `abc` oder `-5` — bis 0.65.0 still angenommen, es gab
  keinen Timeout. Ab 0.66.0 `TUTASK OPTION` wie bei `await`.

---

## Zusammenfassung

- Die meisten Fallen betreffen Modulpfade, HTTPS-Politik und Rundung.
- Neu in 0.65.0: Fallen rund um `tutask` (Tk-Handler, Gruppen, Sandbox,
  Prozesse). Vier davon und die stille Annahme falscher `-timeout`-Werte
  sind in 0.66.0 behoben.

---

*Nächstes Kapitel: [Module](810-anhang-module.md)*
