# Fallen

---

- Nur tkutils laden, Provider aus tclutils vergessen.
- ctrlutils 0.3 mit tkudialog 0.2 / altem tablelist-Default.
- `package require ctrlutils` ohne Tk oder ohne Display — es scheitert an
  `cufileops`. Tk-frei nur `cusync`, `cumonitor`, `cuundo` einzeln laden.
- Schreibmenüs trotz read-only caps.
- Explorer-Code nach Dateiblick kopieren statt Controller reuse.
- App-Workarounds für Multi-Select/Dialog neu erfinden — Libs 0.3/0.4.
- Suite gegen `site-tcl` statt Workspace (Banner lesen). Eine
  installierte Kopie gleicher Version verdeckt den Baum, wenn sie im
  Modulpfad vorn steht; nur `tests/all.tcl` schiebt die eigenen Bäume
  nach vorn.
- Neue Version über eine alte `site-tcl`-Kopie kopiert: `cufileops-0.4.tm`
  bleibt neben `cufileops-0.5.tm` liegen, ebenso `cuundo-0.3.tm`,
  `cusync-0.1.tm` und die alten tkutils- und tclutils-Dateien (Liste in
  [Pairing und Setup](020-pairing-und-setup.md)).
- `setup.tcl` gesourct, ctrlutils-`lib/tm` vergessen —
  `can't find package ctrlutils`.
- `cufileops::install` ohne `-onop`: Undo bleibt leer, ohne Meldung.
- cufileops und cuundo mit verschiedenem `$f` installiert: Undo findet
  seine Sätze nicht und frischt die Liste nicht auf.
- `cuundo::install` ohne `-list`: kein Strg+Z.
- `cufilter::widget` aufgerufen, aber nicht gepackt — die Zeile existiert,
  ist aber unsichtbar.
- Nach eigenen Dateioperationen `cumonitor::poke` vergessen: der Monitor
  meldet die eigene Änderung als fremde.
- `cumonitor` unter `tclsh` ohne Ereignisschleife (`vwait`): es pollt nie.
- `cumonitor::stop` oder `poke` aufräumend aufgerufen, bevor im Prozess
  je ein Monitor installiert war: `can't read "state": no such variable`.
- `cusync` für eine Löschsynchronisation halten — es löscht auf dem Ziel
  nie.
- Eigene App ohne `owSetApp`: ihr „Open with“-Register landet im
  Konfigurationsordner `explorer`.
- `::ctrlutils::cufileops::owApp` direkt setzen statt `owSetApp`
  aufrufen: nach dem ersten Zugriff bleibt das alte Register im
  Speicher.
- Utils-Bäume in Buch-PRs patchen.

---

## tical

- tical mit `tcl::tm::path add` einhängen: Tcl findet nur das
  Sammelpaket, dann `can't find package tical::util 1.0`. tical gehört
  in den `auto_path`.
- `month::getData … -count 3` wie einen einzelnen ViewSpec behandeln:
  Ab N > 1 kommt eine Liste von Monaten zurück.
- `render::term::print … -weekStart sun` bei einer Montags-View:
  Fehler `TICAL RENDER WEEKSTART`. Die Option prüft nur; den
  Wochenstart setzt die View (`getData … -weekStart sun`), die Renderer
  folgen ihr.
- Tippfehler in Optionen (`-weekstart`, `-weeknumbers`): seit 1.1 ein
  Fehler `TICAL … OPTION`, vorher still übergangen.
- Ganztägigen Termin mit `dtend` = letzter Tag angeben: `dtend` ist
  exklusiv, `dtstart 20251020 dtend 20251023` sind drei Tage, nicht
  vier. Ein `dtend` gleich `dtstart` macht `normalize` zu einem Tag.
- Mehrtägigen Termin nur in der Startzelle suchen: die View legt ihn in
  jede berührte Zelle, mit `part` `start`, `middle`, `end`.
- `render::term`-Ausgabe von 1.0.1 erwarten: Zellen sind jetzt vier
  Zeichen breit, Feiertag `(3)` statt `+3`, heute `[17]` statt `*17`,
  `*` hinter der Zahl heißt Termin.
- Auf deutsche Fehlertexte prüfen: tical meldet englisch; auf den
  Errorcode `TICAL …` prüfen, nicht auf den Wortlaut.
- `render::canvas::setCallback {w date} {…}` mit Parameterliste und
  Rumpf: Fehler `TICAL RENDER ARGS`; ein Kommandopräfix übergeben.
- Auf `starts_at`/`ends_at` oder `title`/`date`/`startTime` bauen:
  1.1 nimmt und liefert sie noch, 1.2 nicht mehr; `dtstart`, `dtend`,
  `summary` nehmen.
- `tical::io::import` ohne tclutils laden: `can't find package
  tclutils::tuical 0.1`; tclutils in den Modulpfad.
- Auf die Umrechnung von `TZID` bauen, wenn die Datei eigene
  `VTIMEZONE`-Namen hat: eine Zone, die Tcl nicht kennt, bleibt lokale
  Zeit; `tical::event::tzid name` liefert dann `""`.
- Importierte Termine mit `tzid` in `tical::adapter::sqlite` speichern:
  die Tabelle hat keine Spalte dafür, die Zeit gilt danach als lokal.
  Vorher in UTC umrechnen oder die Zone selbst ablegen.
- `tuholiday` und `tical::holidays::de` gleichsetzen: `holidays::de`
  lässt Oster- und Pfingstsonntag weg; `getHolidays -sundays 1` gibt
  dieselbe Liste wie `tuholiday`.

---

## Behoben in ctrlutils 0.4

Diese Fallen gelten für ctrlutils 0.3. In ctrlutils 0.4 sind sie
behoben:

- `tkutils::tkufilelist` nicht geladen, weil `ctrlutils` es mitzubringen
  scheint — in 0.3 tut es das nicht; bis 0.3 nötig: selbst laden. Jetzt
  lädt `cufileops` es selbst.
- „Open with“: in 0.3 teilen sich alle Apps das Register `explorer`, und
  `owApp` nach dem ersten Zugriff zu setzen wirkt nicht. Jetzt
  `owSetApp`.
- Fehlerdialoge von cuundo ohne `-parent`: in 0.3 können sie hinter dem
  App-Fenster aufgehen. Jetzt über dem Toplevel der Liste.
- Gründe von cuundo und die Filterzeile von cufilter: in 0.3 immer
  englisch. Jetzt über msgcat.
- Gescheitertes Redo: in 0.3 ist der Satz weg, ein zweiter Versuch geht
  nicht. Jetzt bleibt er auf dem Redo-Stapel.
- Tippfehler in einer Option von `cusync::apply`: in 0.3 still
  übergangen. Jetzt ein Fehler `unknown option "…"` mit
  `Known: -onfile -ondir`.
- `cusync` mit ZIP-, DAV- oder SFTP-Ziel: in 0.3 kann eine gleichnamige
  lokale Datei die mtime der Quelle bekommen. Jetzt nur noch zwischen
  zwei lokalen Providern.
- Tests ohne Display: in 0.3 scheitert `smoke.test` in `explorer-0-load`.
  Jetzt übersprungen.
- Explorer startet nicht: in 0.3 nennt die Meldung nur den `auto_path`,
  obwohl die Module über den Modulpfad kommen. Jetzt beide.

## Behoben in ctrlutils 0.5

Diese Fallen gelten für ctrlutils 0.4:

- `cusync::compare`: Scheitert das Auflisten einer Seite, gilt sie als
  leer. Beim Ziel heißt das: Jede Datei der Quelle wird kopiert, auch
  über neuere Dateien. Jetzt ein Fehler `{CTRLUTILS CUSYNC LIST …}`.
- Cut mit Teilfehler: Nach dem Paste ist der ganze Cut weg, auch für die
  Einträge, die nicht kopiert wurden. Jetzt bleiben sie in der
  Zwischenablage.
- Undo frischt die Liste über eine interne Prozedur von cufileops auf und
  verschluckt einen Fehler dabei. Jetzt `-refresh` und ein Fehler
  `{CTRLUTILS CUUNDO REFRESH}`.
- `cufilter`: Ein Filter, der sich nicht setzen lässt, verschwindet
  still. Jetzt `invalid`, `<<CufilterError>>` und `lastError`.
- Alte Moduldateien: Der Baum von ctrlutils 0.4 enthielt noch
  `cufileops-0.4.tm`, `cuundo-0.3.tm` und `cusync-0.1.tm`. Wer `lib/tm`
  kopiert, nimmt sie mit; ein `package require -exact … 0.3` lädt sie.

---

## Zusammenfassung

- Die meisten Fallen sind stille Verdrahtungsfehler: falsches `$f`,
  fehlendes `-onop`, fehlendes `poke`, nicht gepackte Filterzeile.
- Bei Versions- und Pfadfragen zuerst das Banner der Suite lesen.
- Bei tical: Ladeweg (`auto_path`), Groß-/Kleinschreibung der Region,
  exklusives `dtend` ganztägiger Termine.

---

*Nächstes Kapitel: [Module](810-anhang-module.md)*
