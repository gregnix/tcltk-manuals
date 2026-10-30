# cufileops und Undo

## install

```tcl
ctrlutils::cufileops::install $f $prov $listwidget $refreshcmd ?-onop script?
```

- `$f` — Identität der Sicht (z. B. Tab-Frame); aller Zustand hängt daran
- `$prov` — Provider
- `$listwidget` — ein `tkufilelist`
- `$refreshcmd` — Skript nach jeder erfolgreichen Änderung (Liste neu lesen)
- `-onop script` — optional; bekommt nach jeder erfolgreichen Operation
  einen Operationssatz (Dict) angehängt. Einziger Abnehmer bisher: cuundo.

Eine unbekannte Option ist ein Fehler mit Errorcode
`{CTRLUTILS CUFILEOPS OPTION <opt>}` und nennt die bekannten. Eine Option
ohne Wert meldet `missing value for option "-onop"` (geprüft, Tcl 8.6.14
und 9.0.4). Bis 0.1 verschluckte `install` einen Tippfehler wie `-onpo`
still — Undo war dann einfach aus.

Das Kapitel gilt für `cufileops` 0.5 und `cuundo` 0.4 aus ctrlutils
0.4. Die Stufen davor:

| ctrlutils | cufileops / cuundo | neu |
|---|---|---|
| 0.3 | 0.3 / 0.2 | Mehrfachauswahl beim Rechtsklick, Dialog 0.3 |
| 0.3 (Nachtrag) | 0.4 / 0.3 | Texte über msgcat |
| 0.4 | 0.5 / 0.4 | `tkufilelist` geladen, `owSetApp`, Redo bleibt erhalten, cuundo-Dialoge mit `-parent`, cuundo-Gründe über msgcat |

Das Verhalten der Operationen selbst ist über alle Stufen gleich.

---

## Menü und Tasten

[cufileops]{.index} baut das Kontextmenü bei jedem Rechtsklick neu, aus
den [caps]{.index} des Providers. Ein Eintrag erscheint nur, wenn die
Operation gelingen kann:

| Eintrag | erscheint, wenn |
|---|---|
| New Folder | `mkdir` |
| Open | Datei, `get` |
| `Open with <App>` | Datei, `get`, Standard-App für die Endung registriert |
| Open with... | Datei, `get` |
| Rename | `move` |
| Copy | Datei: `get`; Verzeichnis: `list` und `get` |
| Cut | wie Copy, zusätzlich `delete` an der Quelle |
| Delete | `delete` |
| Paste | Zwischenablage voll; `put`, bei Verzeichnissen auch `mkdir` |

Trifft nichts davon zu, zeigt das Menü nur den ausgegrauten Eintrag
„(read-only)“. Ein ZIP ist nicht automatisch „(read-only)“: seine caps
sind `get list stat`, auch mit `tuprovider` 0.2 aus tclutils 0.69.0
(geprüft, Tcl 8.6.14 und 9.0.4). Geprüft (Tcl/Tk 8.6.14, Linux, Xvfb):

- ZIP, Datei markiert: `Open`, `Open with...`, Trennlinie, `Copy`.
- ZIP, nichts markiert, Zwischenablage leer: nur „(read-only)“.
- Lokal, Verzeichnis markiert: `New Folder`, `Rename`, `Copy`, `Cut`,
  `Delete`.
- Lokal, Zwischenablage voll, nichts markiert: `New Folder`, `Paste`.

Tasten auf dem Listenkörper: Entf (löschen), F2 (umbenennen), Strg+C,
Strg+X, Strg+V. Strg+X und Entf auf einer Quelle ohne `delete` melden das
per Dialog statt still nichts zu tun:
`Cut is not available here (the source cannot delete).` bzw.
`Delete is not available here (the source cannot delete).` Die übrigen
Tasten tun ohne passende caps nichts.

Alle Dialoge von cufileops bekommen als `-parent` das Toplevel der Liste
und erscheinen über dem eigenen Fenster, nicht mitten auf einem anderen
Monitor. Seit `cuundo` 0.4 gilt das auch für dessen Fehlermeldungen
(Toplevel der Liste aus `-list`; ohne `-list` kein `-parent`). In
`cuundo` 0.3 aus ctrlutils 0.3 kamen sie ohne `-parent`.

---

## Öffnen

- **Open** startet die Standard-App des Systems über `tclutils::tuopen`
  (Rückfall ohne tuopen: `xdg-open` / `open` / `cmd /c start`).
- **Open with...** fragt nach einem Programm. Die Auswahl merkt sich ein
  Register je Dateiendung; vorgeschlagen werden passende installierte
  Programme (Prüfung mit `auto_execok`).
- **`Open with <App>`** erscheint, sobald für die Endung eine Standard-App
  gesetzt ist — ein Klick, kein Dialog.

Das Register ist ein Tcl-Dict in der Datei `openwith.dict`, abgelegt
über `tuopen::configFile` im Konfigurationsverzeichnis der App
`explorer`, solange die App keinen eigenen Namen setzt. Eigene Apps
setzen ihn einmal beim Start, vor dem ersten Menü:

```tcl
::ctrlutils::cufileops::owSetApp meineapp
```

`owSetApp` (seit `cufileops` 0.5, ctrlutils 0.4) nimmt nur Buchstaben,
Ziffern, `.`, `_` und `-`. Sonst ist es ein Fehler
`invalid application name "…": use letters, digits, . _ -` mit dem
Errorcode `{CTRLUTILS CUFILEOPS APPNAME <name>}`. Es verwirft das
zwischengespeicherte Register; der nächste Zugriff liest die Datei der
neuen App. Geprüft (Tcl/Tk 8.6.14 und 9.0.4, Linux, Xvfb):
`owSetApp "mein app"` meldet den Fehler mit
`CTRLUTILS CUFILEOPS APPNAME {mein app}`; nach `owSetApp meineapp` und
`owAddApp .txt vi` liegt das Register unter
`$XDG_CONFIG_HOME/meineapp/openwith.dict`.

Bis ctrlutils 0.3 gab es nur die Variable
`::ctrlutils::cufileops::owApp`. Jede App ohne eigenen Wert teilte sich
das Register von `explorer`. Wer die Variable erst nach dem ersten
Zugriff setzte, las weiter das alte Register. Neue Apps nehmen
`owSetApp`.

Geprüft unter Linux: `$XDG_CONFIG_HOME/<app>/openwith.dict`, ohne
`XDG_CONFIG_HOME` liegt es unter `$HOME/.config/<app>/`. Laut tuopen unter
Windows `%APPDATA%\<app>`, unter macOS
`$HOME/Library/Application Support/<app>` (nicht geprüft). Fehlt tuopen,
landet es als `<app>-openwith.dict` in `$TMPDIR` bzw. `/tmp`.

Nur der lokale Provider öffnet eine vorhandene Datei direkt. Aus ZIP oder
einem entfernten Provider holt cufileops die Bytes per `get` in ein
prozesseigenes Temp-Verzeichnis `cufileops-<pid>-<µs>` unter `TMPDIR`,
`TEMP`, `TMP` oder `/tmp`. Es verschwindet beim `exit` des Prozesses;
Reste toter Prozesse oder älter als ein Tag räumt der nächste Aufruf ab.
Geprüft (Tcl/Tk 8.6.14, Linux, Xvfb): `a.txt` aus einem ZIP
lag beim Öffnen unter `$TMPDIR/cufileops-…/a.txt`, nach `exit` war das
Verzeichnis weg. Doppelklick bleibt Sache der App.

---

## Kopieren, Ausschneiden, Einfügen

Copy/Paste läuft über `get`+`put` im Controller, nicht über das `copy`
des Providers — daher **cross-provider** (z. B. aus ZIP nach lokal),
Verzeichnisse rekursiv. Die Zwischenablage gilt modulweit für alle Tabs
und merkt sich den Quell-Provider. Bei Namensgleichheit wählt Paste
`name (copy).ext`, dann `name (copy 2).ext` usw. und überschreibt nie.
Scheitert ein Verzeichnis halb, löscht Paste das bereits Angelegte
wieder.

Cut markiert zum **Verschieben**: Paste schreibt am Ziel und löscht dann
die Quelle. Deshalb nur, wenn die Quelle `delete` kann — aus einem ZIP
geht Copy, nicht Cut. Ein Cut wird von seinem Paste verbraucht; Einträge,
die sich nicht kopieren ließen, bleiben seit `cufileops` 0.6 als Cut in
der Zwischenablage, sodass Paste sie noch einmal versucht. Bis 0.5 war der
ganze Cut nach einem Teilfehler weg. Ein Cut
in dasselbe Verzeichnis desselben Providers überspringt Paste. Lässt sich
die Quelle nach dem Kopieren nicht löschen, meldet Paste
`Copied, but could not remove the source:` und behält die Kopie.

Geprüft (Tcl/Tk 8.6.14, Linux, Xvfb): `sub/` und `a.txt`
aus einem ZIP in ein lokales Verzeichnis kopiert, samt `sub/c.txt`;
zweimal `a.txt` eingefügt ergibt `a (copy).txt` und `a (copy 2).txt`;
Cut von `b.txt` aus einem lokalen Tab in einen anderen verschiebt die
Datei und leert die Zwischenablage.

---

## Mehrfachauswahl beim Rechtsklick

Seit 0.3 behält ein Rechtsklick auf eine **bereits selektierte** Zeile die
ganze [Mehrfachauswahl]{.index} (Dateimanager-Verhalten). Copy, Cut und
Delete wirken dann auf alle markierten Einträge. Ein Rechtsklick auf eine
nicht selektierte Zeile wählt nur diese.

Technik: Der Rechtsklick lässt tablelist die Zeile selbst wählen
(synthetischer Button-1) und stellt danach die vorherige Auswahl wieder
her, wenn die geklickte Zeile dazugehörte. Dafür braucht es `tkudialog`
0.3 und sinnvoll `tkutablelist` ab 0.4 mit `-exportselection 0` — sonst
nimmt das Menü die PRIMARY-Auswahl und die Markierung verschwindet.

Geprüft (Tcl/Tk 8.6.14, Linux, Xvfb): Auswahl `0 2 3`,
Rechtsklick auf Zeile 2 — Auswahl bleibt `0 2 3`; Rechtsklick auf
Zeile 4 — Auswahl wird `4`.

Bei mehreren Einträgen fragt Delete einmal: `Delete 2 items?`; bei einem
Eintrag `Delete file '<name>'?` bzw. `Delete folder '<name>'?`.

---

## Sprache

Seit `cufileops` 0.4 und `cuundo` 0.3 laufen Menüeinträge, Rückfragen
und Fehlermeldungen über [msgcat]{.index}, sobald es geladen ist. Seit
ctrlutils 0.4 auch die Gründe von cuundo und die Filterzeile von
cufilter. Die Module laden msgcat selbst, wenn vorhanden. Texte mit
Detail nehmen `%s`. Die Übersetzung legt die App im Namensraum `::ctrlutils` ab; msgcat sucht von
`::ctrlutils::cufileops` aus auch dort:

```tcl
package require msgcat
namespace eval ::ctrlutils {
    ::msgcat::mcset {} Rename Umbenennen
    ::msgcat::mcset {} "Could not rename:\n%s" "Umbenennen fehlgeschlagen:\n%s"
    ::msgcat::mcset {} "Delete file '%s'?" "Datei '%s' löschen?"
}
```

Ohne Katalog bleiben die Texte englisch. Die Form mit `{}` (gilt für
jede Sprache) prüft der Test `cufileops-10.2`. Geprüft
(Tcl/Tk 8.6.14, Linux, Xvfb): das Beispiel oben wörtlich, Locale `c` —
Menüeintrag `Umbenennen` und Rückfrage `Datei 'a.txt' löschen?` kommen
deutsch; mit `mclocale de` und `mcset de` ebenso. Die Schlüssel sind
die englischen Texte selbst, etwa `New Folder`, `Open with %s`,
`Open with...`, `(read-only)`, `Delete %s items?`, `Undo failed:\n%s`.
Seit ctrlutils 0.4 kommen dazu `Filter:` und `x` aus cufilter und die
Gründe von cuundo, etwa `no saved content to restore` oder
`cannot undo op %s` (Test `cuundo-11.1`). In ctrlutils 0.3 bleiben
diese englisch.

---

## cuundo

[cuundo]{.index} zeichnet **nur** auf, was cufileops über `-onop`
meldet. Die beiden kennen sich nicht; die Verbindung macht die App:

```tcl
::ctrlutils::cuundo::install $f $prov -list $list
::ctrlutils::cufileops::install $f $prov $list $refresh \
    -onop [list ::ctrlutils::cuundo::record $f]
```

`cuundo::install` gibt `$f` zurück und leert beide Stapel. Ohne `-onop`
bleibt der Undo-Stapel leer. Ein `record` vor `cuundo::install` für
dieses `$f` geht still verloren. Ohne `-list` gibt es keine Tasten;
`-list` bindet Strg+Z (undo) sowie Strg+Y und Strg+Umschalt+Z (redo) auf
den Listenkörper. Auch hier ist eine unbekannte Option ein Fehler
(`{CTRLUTILS CUUNDO OPTION <opt>}`). Nach Undo und Redo frischt cuundo
die Liste auf: mit `-refresh skript`, sonst über `cufileops::refresh $f`,
also den `$refreshcmd` von cufileops für dasselbe `$f`. Scheitert das
Auffrischen, endet Undo oder Redo mit `{CTRLUTILS CUUNDO REFRESH}`; der
Schritt selbst ist dann schon getan. Bis `cuundo` 0.4 rief cuundo die
interne Prozedur `cufileops::_refresh` in `catch` auf, und ein Fehler
blieb unsichtbar.

| Operation | Undo |
|---|---|
| Rename von → nach | zurück verschieben |
| New Folder | löschen |
| Paste | Ziel löschen |
| Delete | aus Schnappschuss wiederherstellen |
| Cut + Paste | Ziel löschen, Quelle wiederherstellen |

Den Schnappschuss nimmt cufileops **vor** dem Löschen (Bytes einer Datei
oder ein ganzer Teilbaum, im Speicher). Rückgängig geht ein Löschen also
nur, wenn der Provider den Inhalt lesen kann. Undo von New Folder und
Paste hält seinerseits einen Schnappschuss fest, damit Redo das
Gelöschte wiederherstellt.

Geprüft (Tcl/Tk 8.6.14, Linux, Xvfb): New Folder → Undo →
Redo; zweites Paste rückgängig; Delete von `b.txt` rückgängig (Inhalt
wieder da); Rename `b.txt` → `b2.txt` rückgängig; Cut von einem Tab in
den anderen rückgängig — alles wie in der Tabelle.

Weitere Aufrufe: `undo`, `redo`, `canUndo` / `canRedo` (für Menüzustände),
`clear`. Neue Aktivität leert den Redo-Stapel.

Fehler zeigt cuundo per `tkudialog::showError` an, falls tkudialog
geladen ist (`Undo failed:` bzw. `Redo failed:` plus Grund). Ein
gescheitertes Undo bleibt auf dem Undo-Stapel. Seit `cuundo` 0.4
(ctrlutils 0.4) bleibt auch ein gescheitertes Redo auf dem Redo-Stapel.
Geprüft (Tcl 8.6.14 und 9.0.4, Linux, Xvfb): Test
`cuundo-1.10` liefert danach `canRedo` 1; `cuundo.test` 13 von 13
bestanden. In `cuundo` 0.3 aus ctrlutils 0.3 ist ein gescheitertes Redo
verloren: es landet auf keinem Stapel mehr (danach `canRedo` 0
und `canUndo` 0).

`cuundo` 0.4 verlangt `tclutils::tuprovider` nicht mehr; es ruft nur das
Provider-Objekt auf, das es bei `install` bekommt.

Apps sollten auch eigene Änderungen (etwa ein Umbenennen aus einer Maske)
als [Operationssatz]{.index} an `cuundo::record` geben — dieselbe
Undo-Spur wie im Menü (Dateiblick: laut Review erledigt, hier nicht
geprüft). Die Sätze, die cufileops erzeugt:

```
op mkdir   path P
op rename  from A to B type file|dir
op paste   path P type file|dir
op delete  path P type file|dir saved SNAP
op movex   srcprov S dstprov D from A to B type file|dir saved SNAP
```

`SNAP` ist `type file bytes …` oder `type dir children {name SNAP …}`.
`movex` entsteht beim Cut; scheitert dort das Löschen der Quelle,
meldet cufileops stattdessen `paste`.

---

## Alles zusammen

Lauffähig unter `wish` (Tablelist auf dem `auto_path`):

```tcl
source /pfad/zu/tclutils/tools/setup.tcl
tcl::tm::path add /pfad/zu/ctrlutils/lib/tm
package require Tk
package require ctrlutils
package require tclutils::tuprovider
package require tkutils::tkufilelist

set prov [::tclutils::tuprovider open local]
set f    [ttk::frame .tab]
::tkutils::tkufilelist::widget $f.l -provider $prov -dir [pwd]
::ctrlutils::cufilter::widget $f.filter $f.l
pack $f.filter -side top -fill x
pack $f.l -side top -fill both -expand 1
pack $f -fill both -expand 1

set refresh [list ::tkutils::tkufilelist::refresh $f.l]
::ctrlutils::cuundo::install $f $prov -list $f.l
::ctrlutils::cufileops::install $f $prov $f.l $refresh \
    -onop [list ::ctrlutils::cuundo::record $f]
::ctrlutils::cumonitor::install $f $prov -interval 2000 \
    -onchange [list apply {{cmd dir} {uplevel #0 $cmd}} $refresh]
::ctrlutils::cumonitor::watch $f [pwd]
```

Geprüft (Tcl/Tk 8.6.14 und 9.0.4, Linux, Xvfb, tclutils 0.69.0): das
Beispiel läuft; die Bindungen am Listenkörper sind danach `Button-3`,
Entf, F2, Strg+C/V/X/Y/Z und Strg+Umschalt+Z.

Der Explorer verdrahtet genauso, mit einem eigenen Refresh-Callback, der
nach jeder Operation auch den Baum auffrischt und `cumonitor::poke`
aufruft.

---

## Zusammenfassung

- caps steuern das Menü; „(read-only)“ nur, wenn gar nichts passt.
- cufileops 0.3 = Mehrfachauswahl beim Rechtsklick + Dialog 0.3;
  0.4 = Texte über msgcat; 0.5 = `tkufilelist` geladen, `owSetApp`;
  0.6 = Cut nach Teilfehler bleibt, `refresh`.
- Eigene Apps setzen `cufileops::owSetApp meineapp`, sonst teilen sie
  das „Open with“-Register mit dem Explorer.
- Undo nur mit `-onop [list ::ctrlutils::cuundo::record $f]`; Tasten
  nur mit `cuundo::install … -list $list`.
- Ein gescheitertes Undo oder Redo bleibt seit ctrlutils 0.4 auf seinem
  Stapel; in 0.3 ging ein gescheitertes Redo verloren.

---

*Nächstes Kapitel: [Explorer und Dateiblick](050-explorer-und-dateiblick.md)*
