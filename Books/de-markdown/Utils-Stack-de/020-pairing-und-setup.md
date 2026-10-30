# Pairing und Setup

## Empfohlenes Pairing

| Lib | Version | braucht |
|---|---|---|
| tclutils | 0.69.0 | — |
| tkutils | 0.49.0 | tclutils 0.64 oder neuer (`tusettings`, `tustr::graphemes`, `tudate::zones`, `tutestrun`); 0.69.0 für den CSV-Export von `tkutablelist` und für `tkusysinfo` |
| ctrlutils | 0.4 | tkutils mit `tkudialog` 0.3 und `tkufilelist` 0.2 |
| tical | 1.1 | nichts aus dem Stack; optional Tk, `pdf4tcl`, `tdbc::sqlite3`, für den Import tclutils (`tuical`, `turrule`) |

Die CHANGELOGs von tclutils 0.69.0 und tkutils 0.49.0 nennen das Trio
„tclutils 0.69.0 + tkutils 0.49.0 + ctrlutils 0.5“. Der Umbrella von
tkutils 0.49.0 braucht weiter nur tclutils 0.64.0 oder neuer; der
CSV-Export von `tkutablelist` 0.5 und das Widget `tkusysinfo` brauchen
0.69.0. ctrlutils 0.5 braucht nichts Neues aus tclutils oder tkutils. Die Suiten unten sind mit
genau diesem Trio gelaufen.

tical ist kein Teil des Trios. tclutils und ctrlutils laden es nie,
tkutils nur in den beiden optionalen Widgets `tkutical` und
`tkumonthcanvas`, die nicht im Sammelpaket stehen (Kapitel
[Kalender: tical](070-tical.md)).

Im Sammelpaket `ctrlutils` 0.5 stecken `cufileops` **0.6**, `cuundo`
**0.5**, `cusync` **0.3** und `cufilter` **0.2**; `cumonitor` 0.2 ist
unverändert. `cufileops` verlangt `tkutils::tkudialog 0.3` und
`tkutils::tkufilelist 0.2`; ein älteres tkutils mit Dialog 0.2 reicht
nicht. Was neu ist, steht in den Kapiteln
[ctrlutils](030-ctrlutils.md) und
[cufileops und Undo](040-cufileops-und-undo.md).

Zur Zählung: Im CHANGELOG von ctrlutils stehen `cufileops` 0.4 und
`cuundo` 0.3 (Texte über msgcat, Eintrag) unter „## 0.3“.
Sie kamen, als das Sammelpaket schon 0.3 hieß, und bekamen keine eigene
Nummer. Sie gehören zu ctrlutils 0.3, wie ausgeliefert. Ab 0.4 steigt
mit jedem Modul auch die Nummer des Sammelpakets.

Die beiden anderen Bibliotheken bringen für den Stack wenig Neues:

- tkutils 0.49.0: `tkutablelist` 0.5 (Zeilen-IDs, Sortieren über
  `tablelist::sortByColumn`, CSV-Export nur sichtbarer Zeilen und
  Spalten in UTF-8), die Tablelist-Helfer `tkutlclip` 0.3 (Strg+C greift
  jetzt), `tkutlfind` 0.3 (Treffer bleiben nach dem Sortieren richtig),
  `tkutlsort` 0.3, `tkutlstate` 0.4, `tkutltree` 0.3, neu `tkutlfilter`,
  `tkutlgroup`, `tkutldrag` und `tkusysinfo`. Der Explorer von ctrlutils
  nutzt `tkutablelist` und `tkutlfind`; beide laufen ohne Änderung an
  ctrlutils, die Suche in der Liste profitiert vom neuen `tkutlfind`.
- tclutils 0.69.0: `tucsv` 0.2 (Excel-Profile, BOM, Kodierung),
  `tusqlite` 0.2 (Parameter-Dict, `update`, `delete`), neu `tusysinfo`
  und `tuedid`. ctrlutils benutzt keines davon.
- tkutils 0.48.0: `tkulauncher` 0.3 (mit `-scroll 1` bekommen auch nach
  `reload` neue Knöpfe die Mausrad-Bindung) und `tkuload` 0.3
  (exportiert `widgetByName`, `setValue`, `getValue`, `fill`,
  `collect`). ctrlutils benutzt beide nicht.

- tclutils 0.68.0: Korrekturen in 76 Modulen, jedes mit neuer Nummer
  (Liste im CHANGELOG). Für den Stack zählen `tuprovider` 0.2 (`head`
  des lokalen Providers liefert den Inhalt), `tuprovider::sftp` 0.2
  und `tuopen` 0.2 (unter Windows gehen URLs über `rundll32`, alle
  Befehle exportiert). tkutils und ctrlutils verlangen diese Module ohne
  Versionsnummer und laden 0.2 ohne Änderung. Die Fassung verlangt von
  ihnen nichts Neues.
- tclutils 0.67.0: `tupdftext` 0.1, der Text einer PDF-Datei. tkutils
  und ctrlutils benutzen es nicht.
- tclutils 0.66.0: `tutask` 0.2 (Korrekturen an `group`, `pool` und
  `-timeout`; verlangt `tclutils::common` 0.2). tkutils und ctrlutils
  benutzen `tutask` nicht.
- tkutils 0.47.0: `tkufiledialog` 0.2 (Doppelklick auf eine Datei
  lieferte `""`). Die `tkutl*`-Helfer laden jetzt `tablelist_tile` wie
  `tkutablelist`; vorher scheiterte `tkutils` zusammen mit `tkutltools`
  an `can't set "usingTile"` (laut CHANGELOG). Optionsfehler in zehn
  Modulen folgen `tkuopts` (`unknown option "…"` plus Zeile `Known:`).

---

## Einmal Setup

Die Datei `tools/setup.tcl` ist in tclutils und tkutils **identisch**. Wer
eine davon sourct, macht **beide** Bibliotheken auffindbar — ctrlutils
aber nicht. Den [Modulpfad]{.index} für ctrlutils selbst ergänzen:

```tcl
source /pfad/zu/tclutils/tools/setup.tcl     ;# oder .../tkutils/tools/setup.tcl
tcl::tm::path add /pfad/zu/ctrlutils/lib/tm

package require Tk
package require tclutils
package require tkutils
package require ctrlutils
```

Ohne die zweite Zeile endet `package require ctrlutils` mit
`can't find package ctrlutils`. Einzelne Controller lassen sich auch
allein laden (`package require ctrlutils::cufilter`). Das Sammelpaket
`ctrlutils` braucht Tk und ein Display; ohne Tk nur die Tk-freien
Controller einzeln laden (siehe [Stack verstehen](010-stack-verstehen.md)).

`ctrlutils` 0.3 lädt `tkutils::tkufilelist` nicht mit, obwohl
`cufileops` dessen Prozeduren aufruft. Bis ctrlutils 0.3 nötig: die Liste
selbst mit `package require tkutils::tkufilelist` laden — sonst endet der
erste Aufruf mit `invalid command name "::tkutils::tkufilelist::widget"`.

Seit ctrlutils 0.4 lädt `cufileops` `tkutils::tkufilelist 0.2` selbst.
Geprüft (Tcl 8.6.14 und 9.0.4, Linux, Xvfb): Nach
`package require Tk` und `package require ctrlutils` ist
`tkutils::tkufilelist` 0.2 geladen; mit ctrlutils 0.3 ist es das nicht.

Geprüft (Tcl/Tk 8.6.14 und 9.0.4, Linux, Xvfb): Setup wie oben lädt
tclutils 0.69.0, tkutils 0.49.0 und ctrlutils 0.5 mit `cufileops` 0.6,
`cuundo` 0.5, `cufilter` 0.2, `cumonitor` 0.2, `cusync` 0.3, dazu
`tkufilelist` 0.2, `tkutablelist` 0.5, `tuprovider` 0.2 und `tuopen`
0.2.

`setup.tcl` sucht je Bibliothek in dieser Reihenfolge und nimmt nur
Verzeichnisse, die existieren:

| Rang | Ort |
|---|---|
| 1 | `TCLUTILS_TM` / `TKUTILS_TM` (Override, gewinnt) |
| 2 | `<repo>/lib/tm` des Pakets, aus dem `setup.tcl` stammt |
| 3 | `<tcl-install>/<pkg>/lib/tm` neben der Tcl-Bibliothek |
| 4 | `/usr/local/share/tcltk/<pkg>/lib/tm` |
| 5 | `$XDG_DATA_HOME` bzw. `$HOME/.local/share/tcltk/<pkg>/lib/tm` |
| 6 | Geschwisterordner `<pkg>/lib/tm` |
| 7 | Geschwisterordner `<pkg>-*/lib/tm` (höchste Version) |

Fehlt ein Paket wirklich, meldet das erst `package require` — so gewollt.

Unter Windows liegen die beiden Treffer, die gemeint sind, in
`TCLUTILS_TM` und in `lib/tm` neben der gesourcten Datei. Der Kandidat
`/usr/local/share/tcltk/...` wird auf dem aktuellen Laufwerk gesucht.
Der Benutzerpfad gilt nur, wenn `HOME` oder `XDG_DATA_HOME` gesetzt
ist. `USERPROFILE` liest das Skript nicht.

---

## In eine Tcl-Installation legen

Statt `setup.tcl` lassen sich alle drei Bäume in das
[site-tcl]{.index}-Verzeichnis einer Tcl-Installation kopieren:
`<tcl>/lib/tcl8/site-tcl` für Tcl 8.6, `<tcl>/lib/tcl9/site-tcl` für
Tcl 9. Allgemein liegt es neben der Tcl-Bibliothek:
`[file dirname [info library]]/tcl8/site-tcl`. Debian nimmt dafür
mehrere Orte, darunter `/usr/share/tcltk/tcl8/site-tcl` und
`/usr/lib/tcltk/tcl8/site-tcl` (laut `tcl::tm::path list` unter Tcl
8.6.14). Dieses Verzeichnis steht schon im Standard-Modulpfad, danach
genügt `package require`.

Kopiert wird jeweils der **Inhalt** von `lib/tm` mit Unterordnern:

```
site-tcl/
    tclutils-0.69.0.tm
    tclutils/            tu*-Module, Unterordner tuprovider/
    tkutils-0.49.0.tm
    tkutils/
    ctrlutils-0.5.tm
    ctrlutils/           cufileops-0.6, cufilter-0.2, cumonitor-0.2,
                         cusync-0.3, cuundo-0.5
```

Geprüft (Tcl/Tk 8.6.14 und 9.0.4, Linux, Xvfb): genau diese Ablage in
einem Testverzeichnis, über `TCL8_6_TM_PATH` bzw. `TCL9_0_TM_PATH`
eingehängt, lädt alle drei Sammelpakete. Ein echtes
`lib/tcl9/site-tcl` ist nicht geprüft.

tical gehört nicht in diese Ablage: Seine Pakete stehen in einem
`pkgIndex.tcl` und werden über `auto_path` gefunden. Der ganze Ordner
`tical/` gehört deshalb in ein Verzeichnis, das im `auto_path` steht
(bei Tcl 9 unter `/opt/tcl9` etwa `/opt/tcl9/lib`, unter Debian etwa
`/usr/local/share/tcltk`), oder sein Elternverzeichnis kommt in
`TCLLIBPATH`. Geprüft (Tcl 8.6.14 und 9.0.4, Linux): mit dem
Elternverzeichnis in `TCLLIBPATH` lädt `package require tical` die
Version 1.1. Mehr im Kapitel [Kalender: tical](070-tical.md).

Keines der drei Repos bringt ein Installationsskript mit. Wer eins
schreibt: Zielverzeichnis aus der Tcl-Version ableiten, die drei
`lib/tm`-Bäume rekursiv kopieren, alte Dateien derselben Module vorher
entfernen. Das ist nötig, weil Modulnamen die Version tragen: Beim
bloßen Drüberkopieren bleibt die alte Datei neben der neuen liegen.
Beim Wechsel auf dieses Pairing sind das:

| Lib | alte Dateien löschen |
|---|---|
| ctrlutils 0.5 | `ctrlutils-0.4.tm`; in `ctrlutils/`: `cufileops-0.5.tm`, `cuundo-0.4.tm`, `cusync-0.2.tm`, `cufilter-0.1.tm`, dazu `cufileops-0.4.tm`, `cuundo-0.3.tm`, `cusync-0.1.tm` (sie lagen noch im Baum von 0.4); von 0.3 aus statt `ctrlutils-0.4.tm` die Datei `ctrlutils-0.3.tm`, von noch älteren Ständen auch `cufileops-0.3.tm`, `cuundo-0.2.tm` |
| tkutils 0.49.0 | `tkutils-0.48.0.tm`; in `tkutils/`: `tkutablelist-0.4.tm`, `tkutlclip-0.2.tm`, `tkutlfind-0.2.tm`, `tkutlsort-0.2.tm`, `tkutlstate-0.3.tm`, `tkutltools-0.2.tm`, `tkutltree-0.2.tm`, `tkuical-0.2.tm`, `tkuvcard-0.2.tm`, `tkuldif-0.2.tm`, `tkuini-0.2.tm`, `tkutical-0.3.tm`, `tkunotes-0.2.tm`, `tkueditor-0.2.tm`, `tkubase64-0.1.tm`, `tkutlfooter-0.3.tm`, `tkulauncher-0.3.tm`, `tkuhexedit-0.1.tm` (von 0.47.0 aus statt `tkutils-0.48.0.tm` die Datei `tkutils-0.47.0.tm`, dazu `tkulauncher-0.2.tm`, `tkuload-0.2.tm`; von 0.46.0 aus statt `tkutils-0.47.0.tm` die Datei `tkutils-0.46.0.tm`, dazu `tkufiledialog-0.1.tm`, `tkutlclip-0.1.tm`, `tkutlfind-0.1.tm`, `tkutlsort-0.1.tm`, `tkutltools-0.1.tm`, `tkutltree-0.1.tm`, `tkutlfmt-0.2.tm`, `tkutlfooter-0.2.tm`, `tkutlstate-0.2.tm`) |
| tclutils 0.69.0 | `tclutils-0.68.0.tm`, in `tclutils/` `tucsv-0.1.tm`, `tusqlite-0.1.tm`, `tuholiday-0.1.tm`, `tuzip-0.1.tm`, `tudiff-0.1.tm`, `tubookmark-0.2.tm`, `tuical-0.1.tm`, `tuvcard-0.1.tm`, `tuini-0.1.tm`, `tupatch-0.2.tm`, `tusplit-0.2.tm`, `tutee-0.2.tm`, `tumd-0.1.tm`, `tuiconv-0.1.tm`, `tucat-0.1.tm`, `tuldif-0.2.tm`, `tucsplit-0.1.tm`, `tuhead-0.1.tm`, `tutail-0.1.tm`, `tugrep-0.1.3.tm`, `tustr-0.2.tm`, `tuer-0.3.tm`, `tugantt-0.2.tm`, `tuxychart-0.1.tm`, `tusankey-0.1.tm`, `tudate-0.2.tm`, `tunumany-0.2.tm`, `tubase64-0.1.tm`, `tucrc-0.1.tm`, `tudav-0.2.tm`, `tuflow-0.3.tm`, `tuc4-0.1.tm`, `tugit-0.2.tm`, `turadar-0.2.tm`, `tusort-0.1.tm`, `tuuniq-0.1.tm`, `tucut-0.1.tm`, `tupaste-0.2.tm`, `tujoin-0.1.2.tm`, `tushuf-0.2.tm`, `tucolumn-0.1.tm`, `tufold-0.2.tm`, `tufmt-0.1.tm`, `tutestrun-0.1.tm`, `tuarchitecture-0.2.tm`, `tustate-0.1.tm`, `tublock-0.1.tm`, `tunotes-0.1.tm`, `tumindmap-0.1.tm`, `common-0.2.tm`, `tused-0.1.3.tm`, `tusettings-0.1.tm`, `tuimage-0.1.tm`, `tuprovider-0.2.tm`, `tutreemap-0.2.tm`, `tuclass-0.2.tm`, `tupacket-0.2.tm`, `tujourney-0.2.tm`, `tukanban-0.1.tm`, `tutimeline-0.2.tm`, `tupie-0.2.tm`, `tuquadrant-0.1.tm`, `tusequence-0.2.tm`, `tudiagram-0.5.tm`, `tusvg-0.3.tm`, `tupngdraw-0.13.tm`, `tupng-0.5.tm`, `tuappinfo-0.2.tm`, `tuodf-0.1.tm`; von 0.67.0 aus statt `tclutils-0.68.0.tm` die Datei `tclutils-0.67.0.tm`, dazu die alten Dateien der 76 Module mit neuer Nummer in 0.68.0 (Liste im CHANGELOG), darunter `tuprovider-0.1.tm`, `tuopen-0.1.tm`, `tuprovider/sftp-0.1.tm`; von älteren Ständen auch `tclutils-0.66.0.tm`, `tclutils-0.65.0.tm` und `tutask-0.1.tm` |

Danach gilt: Eine installierte Kopie kann einen Arbeitsbaum verdecken —
siehe den Test-Abschnitt unten.

---

## Tests

Jede Bibliothek bringt `tests/all.tcl` mit. Für ctrlutils:

```bash
cd ctrlutils
tclsh tests/all.tcl
tclsh tests/all.tcl -match 'cufileops-*'
```

Optionen wie `-match` gehen an jede Testdatei. Mit `-match 'cufileops-*'`
laufen alle acht Dateien, aber nur in `cufileops.test` passt ein Test;
die übrigen melden alles als übersprungen.

Der Runner ist [tutestrun]{.index} aus tclutils (seit 0.64). `all.tcl`
holt ihn aus dem eigenen `lib/tm`, aus `$TCLUTILS_TM` oder aus dem
Geschwister-Checkout `tclutils*/lib/tm` — nie aus einer installierten
Kopie. Findet es ihn nicht: `all.tcl: tclutils::tutestrun not found (set
TCLUTILS_TM)`, Exit 2 (geprüft mit einer Kopie von `tests` und `lib`
ohne Geschwister-Checkouts).

Jede `.test`-Datei läuft in einem eigenen Prozess. Vor dem Lauf druckt
der Runner ein Banner, aus welcher Datei ctrlutils, tkutils und tclutils
geladen werden, zum Beispiel:

```
Modules resolve to:
  ctrlutils  0.5      .../ctrlutils/lib/tm/ctrlutils-0.5.tm
  tkutils    0.49.0   .../tkutils/lib/tm/tkutils-0.49.0.tm
  tclutils   0.69.0   .../tclutils/lib/tm/tclutils-0.69.0.tm
```

Liegt eine zweite Version daneben, steht dahinter `(also: <version>)`,
etwa `(also: 0.4)`, solange `ctrlutils-0.4.tm` neben `ctrlutils-0.5.tm`
liegt. Alte Dateien der einzelnen Module sieht der Runner nicht; ein
Baum von ctrlutils 0.4 enthielt noch `cufileops-0.4.tm`, `cuundo-0.3.tm`
und `cusync-0.1.tm`, ohne dass der Banner es zeigte.
Gesetzte Variablen wie `TCL8_6_TM_PATH` oder `TCLUTILS_TM` meldet je eine
Zeile `note: <VAR> is set: …`.

Eigene Bäume stehen vorn: der Runner nimmt sie aus `TCL8_6_TM_PATH` /
`TCL9_0_TM_PATH` heraus und setzt sie im Testprozess an die Spitze. Eine
direkt gestartete Testdatei ohne Runner hat diesen Schutz nicht.

Zeitgrenze je Datei: [CTRLUTILS_TESTGRENZE]{.index} in Sekunden, Standard
120. tclutils und tkutils folgen demselben Schema mit
`TCLUTILS_TESTGRENZE` und `TKUTILS_TESTGRENZE`. Am Ende steht
`All test files passed` oder eine Liste `Files with problems:` mit dem
Grund je Datei: `N failed`, `no summary`, `exit code / error`,
`hang after Ns`, `could not start`. Dann ist der Exit-Code 1.

Geprüft mit ctrlutils 0.5, tkutils 0.49.0 und tclutils 0.69.0 (Linux,
Xvfb), unter Tcl/Tk 8.6.14 und 9.0.4 gleich:

- 8 Testdateien, **91** Tests, alle grün (`cufileops` 27, `cufilter` 7,
  `cumonitor` 6, `cusync` 14, `cuundo` 15, `headers` 1, `smoke` 20,
  `versions` 1).
- Neu gegenüber ctrlutils 0.4 (82 Tests): `cusync-4.1` bis `4.3`
  (Auflisten scheitert), `cufileops-13.1` (Cut nach Teilfehler),
  `cufileops-13.2` (`refresh`), `cuundo-12.1`, `12.2` (`-refresh`),
  `cufilter-10.1`, `10.2` (Fehler im Filter).
- Neu in ctrlutils 0.4 gegenüber 0.3 (76 Tests): `cuundo-1.10` (Redo),
  `cusync-3.6` (Optionen), `cusync-3.7` (mtime), `cuundo-11.1`
  (Dialog-Parent, msgcat), `cufileops-12.1` (`owSetApp`),
  `cufilter-9.1` (msgcat).
- `CTRLUTILS_TESTGRENZE=1` meldet `cumonitor.test (hang after 1s)`
  (geprüft mit ctrlutils 0.3).
- `cumonitor.test` arbeitet im System-Temp; ein abgebrochener Lauf lässt
  kein `cumon/` mehr im Baum.

Ohne Display werden die Tests von `cufileops` und `cufilter`
übersprungen. In ctrlutils 0.3 scheitert dann `smoke.test` in
`explorer-0-load` (`couldn't connect to display`), Exit 1. Seit 0.4
überspringt `smoke.test` diesen Test: 20 übersprungen, 0 Fehler. Für die Tk-Tests also ein Display nehmen (unter Linux ohne
Bildschirm: `xvfb-run -a tclsh tests/all.tcl`).

Die Suiten der beiden anderen Bibliotheken (Linux, Xvfb), jeweils 0
Fehler:

| Suite | Tests | Tcl 8.6.14 | Tcl 9.0.4 |
|---|---|---|---|
| tclutils 0.69.0 | 2639 | 2614 bestanden, 25 übersprungen | 2622 bestanden, 17 übersprungen |
| tkutils 0.49.0 | 947 | 935 bestanden, 12 übersprungen | 944 bestanden, 3 übersprungen |

Die tkutils-Suite lief mit tical als Geschwister-Checkout; ohne tical
überspringen `tkutical.test` und `tkumonthcanvas.test` ihre Tests. Die
Suite von tical selbst steht im Kapitel [Kalender: tical](070-tical.md).

Unter macOS (Darwin 27, arm64, Tcl/Tk 9.0.4 mit Aqua) liefen die drei
Suiten vor den Schreibfehler-Tests ohne Fehler:

| Suite | Tests | bestanden | übersprungen |
|---|---|---|---|
| tclutils 0.69.0 | 2582 | 2567 | 15 |
| tkutils 0.49.0 | 938 | 896 | 42 |
| ctrlutils 0.4 | 82 | 82 | 0 |

Unter Windows liefen die drei Suiten im selben Stand ebenfalls ohne
Fehler, Tcl 8.6.17 mit der Systemkodierung cp1252 und Tcl 9.0.4:

| Suite | Tests | Tcl 8.6.17 | Tcl 9.0.4 |
|---|---|---|---|
| tclutils 0.69.0 | 2582 | 2545 bestanden, 37 übersprungen | 2549 bestanden, 33 übersprungen |
| tkutils 0.49.0 | 938 | 927 bestanden, 11 übersprungen | 935 bestanden, 3 übersprungen |
| ctrlutils 0.4 | 82 | 82 bestanden | 82 bestanden |

Die Übersprünge unter Windows kommen von der Plattform (`unix`) und von
fehlenden Paketen (Zipfs, SFTP, HTTPS).

---

## Zusammenfassung

- Pairing 0.69.0 / 0.49.0 / 0.5; im Sammelpaket ctrlutils 0.5 stecken
  `cufileops` 0.6, `cuundo` 0.5, `cusync` 0.3 und `cufilter` 0.2. tical 1.1.1 optional
  daneben.
- `setup.tcl` kennt tclutils und tkutils; ctrlutils per
  `tcl::tm::path add …/ctrlutils/lib/tm`; `tkufilelist` bis ctrlutils 0.3
  selbst laden, ab 0.4 lädt `cufileops` es.
- Alternativ alle drei `lib/tm`-Bäume nach `site-tcl` kopieren, alte
  Moduldateien vorher entfernen.
- `tclsh tests/all.tcl`; Banner lesen, Grenze über `*_TESTGRENZE`.

---

*Nächstes Kapitel: [ctrlutils](030-ctrlutils.md)*
