# Fehlermeldungen

Wortlaut aus dem Code. Die mit „geprüft“ markierten Zeilen sind mit
Tcl/Tk 8.6.14 unter Linux (Xvfb) ausgelöst; die Zeilen zu den Optionen
von cufileops, cuundo, cumonitor und cusync, zu `owSetApp`, zum
Explorer-Start und zu tical auch mit Tcl/Tk 9.0.4. Wortlaut gilt für
ctrlutils 0.5 und tical 1.1.1; wo ein älteres ctrlutils anders ist, steht
es dabei.

| Symptom | Prüfen |
|---|---|
| `can't find package ctrlutils` / `ctrlutils::…` (geprüft) | `tcl::tm::path add …/ctrlutils/lib/tm`; `setup.tcl` kennt ctrlutils nicht |
| `can't find package tkutils::tkudialog 0.3` (geprüft) | tkutils ≥ 0.46 (Dialog 0.3) |
| `no display name and no $DISPLAY environment variable` beim Laden von `ctrlutils` (geprüft) | Sammelpaket braucht Tk; ohne Display nur Tk-freie Controller laden |
| `invalid command name "::tkutils::tkufilelist::widget"` (geprüft) | ctrlutils 0.3: `package require tkutils::tkufilelist` fehlt; ab ctrlutils 0.4 lädt `cufileops` es selbst |
| Dialog ohne Default-Button | tkudialog ≥ 0.3 |
| Multi-Select weg nach Rechtsklick | cufileops ≥ 0.3 + tablelist 0.4 |
| `can't find package tclutils::tuprovider` | tclutils laden |
| Suite testet falschen Baum | Banner / `TCL*_TM_PATH`; Suite über `tests/all.tcl` starten |
| `unknown option "-onpo"` / `Known: -onop` (geprüft) | Tippfehler; Errorcode `CTRLUTILS CUFILEOPS OPTION -onpo` |
| `missing value for option "-onop"` (geprüft) | Option ohne Wert; Errorcode `CTRLUTILS CUFILEOPS OPTION` |
| `unknown option "…"` / `Known: -list, -refresh` (geprüft) | `cuundo::install`; Errorcode `CTRLUTILS CUUNDO OPTION …`; bis ctrlutils 0.4 nur `Known: -list` |
| `list not refreshed: …` (geprüft) | Undo oder Redo ist getan, das Auffrischen der Liste nicht; Errorcode `CTRLUTILS CUUNDO REFRESH`; Skript von `-refresh` oder von `cufileops::install` prüfen |
| `unknown option "…"` / `Known: -interval -onchange` (geprüft) | `cumonitor::install`; Errorcode `CTRLUTILS CUMONITOR OPTION …` |
| `cumonitor: <f> not installed` (geprüft) | `watch` vor `cumonitor::install` |
| `can't read "state": no such variable` (geprüft) | `cumonitor::watch`, `poke` oder `stop`, bevor im Prozess ein Monitor installiert war |
| `unknown option "-x"` / `Known: -onfile -ondir` (geprüft) | `cusync::apply`; Errorcode `CTRLUTILS CUSYNC OPTION -x`; in ctrlutils 0.3 still übergangen |
| `missing value for option "-onfile"` (geprüft) | `cusync::apply`, Option ohne Wert; Errorcode `CTRLUTILS CUSYNC OPTION` |
| `cannot list "…" (R): …` (geprüft) | `cusync::compare`: ein Verzeichnis lässt sich nicht auflisten; Errorcode `CTRLUTILS CUSYNC LIST R dir` (`L` für links); bis ctrlutils 0.4 galt die Seite als leer |
| `invalid application name "mein app": use letters, digits, . _ -` (geprüft) | `cufileops::owSetApp`; nur Buchstaben, Ziffern, `.` `_` `-`; Errorcode `CTRLUTILS CUFILEOPS APPNAME {mein app}` |
| „Open with“ zeigt die Programme einer anderen App | kein `cufileops::owSetApp` gesetzt (Register `explorer`) oder in ctrlutils 0.3 `owApp` erst nach dem ersten Zugriff gesetzt |
| Undo tut nichts | cufileops ohne `-onop [list ::ctrlutils::cuundo::record $f]` oder anderes `$f` |
| Strg+Z ohne Wirkung | `cuundo::install` ohne `-list` |
| `Undo failed:` + `no saved content to restore` (geprüft) | Delete ohne Schnappschuss (Provider konnte nicht lesen) |
| `Redo failed:` (geprüft) | Ziel blockiert; der Satz bleibt auf dem Redo-Stapel (in ctrlutils 0.3 ist er danach verloren) |
| `Cut is not available here (the source cannot delete).` (geprüft) | Quelle ohne `delete`, z. B. ZIP; Copy nehmen |
| `Delete is not available here (the source cannot delete).` (geprüft) | Quelle ohne `delete` |
| `Copied, but could not remove the source:` | Cut: Kopie steht, Quelle blieb |
| Filterzeile fehlt | `cufilter::widget` erzeugt, aber nicht gepackt |
| Monitor meldet eigene Änderungen | nach der Operation `cumonitor::poke` |
| Menü zeigt nur „(read-only)“ (geprüft) | keine passende Operation, z. B. ZIP ohne markierte Datei und mit leerer Zwischenablage |
| Explorer: „Explorer cannot start“, `Missing package:`, `Searched module path (tcl::tm::path):`, `Searched auto_path:` (geprüft) | Modulpfad für alle drei Libs; Tablelist. In ctrlutils 0.3 ohne die Zeilen zum Modulpfad |
| Explorer: `Sync needs the ctrlutils::cusync module.` | Modul `cusync` fehlt |
| Explorer: `Find in list needs the tkutils::tkutlfind module.` | Modul `tkutlfind` fehlt |
| `all.tcl: tclutils::tutestrun not found (set TCLUTILS_TM)` (geprüft, Exit 2) | tclutils ≥ 0.64 als Geschwister oder `TCLUTILS_TM` setzen |
| `<datei> (hang after 120s)` | `CTRLUTILS_TESTGRENZE` erhöhen |
| `smoke.test (1 failed)`, `couldn't connect to display` (geprüft) | ctrlutils 0.3: Suite mit Display starten (`xvfb-run -a`); ab ctrlutils 0.4 übersprungen |
| `can't find package tical::util 1.0` (geprüft) | tical über `tcl::tm::path` eingehängt; tical-Ordner in den `auto_path` |
| `can't find package tical::view::month` o. ä. | tical fehlt im `auto_path`; für tkutils `TICAL_DIR` setzen oder tical als Geschwister-Checkout |
| Kalender zeigt keine Feiertage | unbekannte Region bei `-holidays` (keine Fehlermeldung) |
| `view::month::getData: -year and -month are required` (geprüft) | Monat ohne `-month`; `-count` ersetzt es nicht; Errorcode `TICAL VIEW ARGS` |
| `view::month::getData: -count must be an integer >= 1, got "0"` (geprüft) | `-count` kleiner 1 oder keine Zahl; Errorcode `TICAL VIEW COUNT` |
| `view::month::getData: unknown option "-weekstart", must be -count, -events, …` (geprüft) | Tippfehler in einer Option der View (bis 1.0.1 still übergangen); Errorcode `TICAL VIEW OPTION` |
| `render::term::print: unknown option "-colour", must be -color, -weekNumbers or -weekStart` (geprüft) | Option, die `render::term` nicht kennt; Errorcode `TICAL RENDER OPTION` |
| `render::term::print: -weekStart mon contradicts the view (starts on sun): week start comes from the view; use getData ... -weekStart mon` (geprüft) | `-weekStart` passt nicht zur View; den Wochenstart in `getData` setzen; Errorcode `TICAL RENDER WEEKSTART` |
| `render::pdf::create: bad paper "b5": must be a3, a4, a5 or letter` (geprüft) | Papierformat, das `render::pdf` nicht kennt; Errorcode `TICAL RENDER OPTION` |
| `event missing required field: dtstart` (geprüft) | Termin ohne Beginn bei `getData … -events`, `normalize`, `model` oder `exportEvents`; Errorcode `TICAL EVENT FIELD` |
| `dtend "20251014T090000" is before dtstart "20251014T100000"` (geprüft) | Ende vor Beginn; Errorcode `TICAL EVENT RANGE` |
| `render::term::print: expected type month-grid, week-grid or day-grid, got "year-grid"` (geprüft) | ViewSpec, den `render::term` nicht kennt (bis 1.1 auch Woche und Tag); Errorcode `TICAL RENDER TYPE` |
| `setCallback: "w date" is not a widget path; pass one command prefix (setCallback CMD) or a canvas and one (setCallback .c CMD)` (geprüft) | `setCallback` mit Parameterliste und Rumpf; ein Kommandopräfix übergeben; Errorcode `TICAL RENDER ARGS` |
| `dtstart format invalid: "2025-10-14" (expected YYYYMMDD, YYYYMMDDTHHMMSS or YYYYMMDDTHHMMSSZ)` (geprüft) | `io::ical::validate` mit ISO-Datum; `validate` prüft die Form, in der geschrieben wird; Errorcode `TICAL ICAL FORMAT` |
| `FREQ must be DAILY\|WEEKLY\|MONTHLY\|YEARLY, got "HOURLY"` (geprüft) | `rrule` mit anderer Frequenz; Errorcode `TICAL ICAL RRULE` |
| `appointment not found: appt-9` (geprüft) | `tical::model::get…` mit unbekannter Kennung; Errorcode `TICAL MODEL NOTFOUND` |
| `event not found: nix` (geprüft, nur 9.0.4) | `adapter::sqlite::read`/`update`/`delete` mit unbekannter `uid`; Errorcode `TICAL SQLITE NOTFOUND` |
| `can't find package tdbc::sqlite3` | `tical::adapter::sqlite` ohne TDBC-SQLite; die Suite überspringt `adapter-sqlite.test` |
| `can't find package tclutils::tuical 0.1` (geprüft) | `tical::io::import` ohne tclutils; `tcl::tm::path add …/tclutils/lib/tm`; die Suite überspringt `io-import.test` |
| `VEVENT "X": RRULE FREQ=MONTHLY;BYSETPOS=-1: unsupported rule part: BYSETPOS` (geprüft) | `io::import::expand` mit einem RRULE-Teil, den `turrule` nicht kennt; Errorcode `TICAL IMPORT RRULE` |

Fehlercodes der Einzelmodule: jeweilige Lib-Docs und Bücher
*tclutils* und *tkutils*.

---

## Zusammenfassung

- Ladefehler: Modulpfad, Tk/Display, `tkufilelist` selbst laden.
- Optionsfehler nennen die bekannten Optionen und tragen einen Errorcode
  `CTRLUTILS <MODUL> OPTION …`.
- Testfehler: Banner, Display, `*_TESTGRENZE`.
- tical: `auto_path` statt Modulpfad; der Import braucht tclutils im
  Modulpfad.
