# Testumgebung

## Einführung

Dieser Anhang nennt die Umgebung, mit der die Angaben des Buchs geprüft
sind, das Verhalten älterer Fassungen und die Punkte, die noch nicht
geprüft sind.

---

## Umgebung

| Was | Stand |
|---|---|
| System | Linux, GUI unter Xvfb ohne Fenstermanager, Bildschirm 1280×1024 |
| Tcl/Tk 8.6 | 8.6.14 mit tDOM 0.9.3, sqlite3 3.45.1, tklib 0.8 (Tablelist 6.20, scrollutil 1.17), Img 1.4.16; ohne tksvg |
| Tcl/Tk 9 | 9.0.4 mit tDOM 0.9.7, sqlite3 3.53.0, Tablelist 7.11, scrollutil 2.10, Img 2.1.1 |
| tkutils | 0.48.0 |
| tclutils | 0.68.0 |
| ctrlutils | 0.4 |
| tical | 1.1, über `TICAL_DIR` oder Geschwisterordner |

Die Ergebnisse der Testsuite stehen in
[Installation](020-installation.md), Abschnitt *Testlauf*. Für den Lauf
liegen tclutils, tkutils und tical als Geschwisterordner nebeneinander;
`TCLUTILS_TM`, `TKUTILS_TM` und `TICAL_DIR` zeigen auf diese Bäume.

Prüfskripte: Jedes Beispiel mit einer Ausgabe `;# -> …` läuft unter
`xvfb-run -a tclsh8.6` und `xvfb-run -a tclsh9.0`, die Module aus
`tcl::tm::path add <tclutils>/lib/tm <tkutils>/lib/tm`.

`tkulauncher-9.4` (Mausrad im Scroll-Modus) war bis `tkulauncher` 0.2
unbeständig: Die Knöpfe bekamen die Mausrad-Bindung erst über ein
späteres Ereignis, nach `reload` gar nicht. Seit 0.3 bindet der Launcher
die Knöpfe beim Anlegen; `tkulauncher-9.5` prüft den Fall nach
`reload`.

---

## Ältere Fassungen

### Testsuite 0.46.0

Tcl/Tk 8.6.14, Linux, Xvfb, tclutils 0.65.0, tkutils 0.46.0 (Commit
`401ebde`), tklib 0.8, tDOM 0.9.3, sqlite3 3.45.1, ohne tksvg: 78
Testdateien, 837 Tests, 811 bestanden, 25 übersprungen, 1 Fehler.

- Der Fehler war `tkulauncher-9.4` (Mausrad im Scroll-Modus). Er ließ
  sich danach nicht reproduzieren, auch nicht im unveränderten Baum (837
  Tests, 0 Fehler unter 8.6.14 und 9.0.4); `tkulauncher.test` allein
  bestand mit 99 von 99 Tests. Die Ursache ist in `tkulauncher` 0.3
  behoben (Abschnitt *Umgebung*).
- Übersprungen waren u. a. alle 13 Tests von `tkumonthcanvas.test` und 7
  SVG-Tests von `tkuwinico.test`.
- In 0.47.0 kamen `tkufiledialog-1.4a` (Doppelklick),
  `tkutltools-2.1`/`-2.2` (beide Ladereihenfolgen mit `tablelist_tile`)
  und `tkuform-3.7` (Optionsfehler) hinzu; die ersten drei schlagen mit
  dem Code von 0.46.0 fehl.

**Ohne Display.** In 0.46.0 brechen `stack.test`, `tkumdview.test`,
`tkupdfinspect.test` und `tkuwinico.test` ohne `DISPLAY` beim Laden ab,
schreiben keine Zusammenfassung, und der Lauf endet mit Exit-Code 1.
Abhilfe: die Suite immer unter Xvfb oder mit Display starten.

**tical.** `tkumonthcanvas.test` aus 0.46.0 sucht ohne `TICAL_DIR` nur
`tical*/tical` und überspringt bei flachem Checkout alle 13 Tests.
Abhilfe: `TICAL_DIR=/pfad/zu/tical` setzen; dann bestehen 13 von 13.

### Zwei Tablelist-Varianten bis 0.46.0

`tkutablelist` lädt zuerst `tablelist_tile` und nur, wenn das fehlt,
`Tablelist`. Die Helfer `tkutl*` laden dagegen `tablelist`. Mit Tablelist
6.20 aus tklib 0.8 scheitert nach `package require tkutils` deshalb
`package require tkutils::tkutltools` (ebenso `tkutlsort` allein) mit

```text
can't set "usingTile": it is not supported to use both Tablelist and Tablelist_tile in the same application
```

Abhilfe: `package require tablelist` (oder `tkutils::tkutltools`) **vor**
dem Umbrella. Dann nimmt `tkutablelist` die nicht-ttk-Variante, und beide
Familien laufen zusammen.

### tkufiledialog 0.1 (tkutils 0.46.0)

Dialog jeweils programmatisch bedient (Tcl/Tk 8.6.14, Linux, Xvfb):

| Bedienung | Ergebnis |
|---|---|
| Name `a.txt` eintippen, Return | voller Pfad zu `a.txt` |
| Escape | `""` |
| `save -initialfile bericht -defaultextension .txt`, *OK* | `…/bericht.txt` |
| `directory`, *OK* ohne Auswahl | der Startordner |
| Doppelklick-Handler auf Datei `a.txt` | `""` |

Der letzte Fall ist ein Fehler im Code von 0.46.0: Der Doppelklick auf
eine Datei trägt den Namen ein und schließt mit *OK*, setzt aber den
Rückgabewert nicht. Abhilfe: Datei markieren und *OK* oder Return
benutzen. In 0.47.0 (`tkufiledialog` 0.2) behoben.

---

## Noch nicht geprüft

| Kapitel | offen |
|---|---|
| alle | Windows und macOS |
| [Dialoge](030-dialoge.md) | Darstellung, Fokus und Platzierung auf einem echten Bildschirm |
| [Datei-Widgets](040-datei-widgets.md) | Navigation eines Dateimanagers mit Windows-Pfaden |
| [Geometrie und Units](060-geometry-und-units.md) | Konfig-Ordner unter Windows und macOS; mehrere Monitore; Zoom-Zustand (Xvfb ohne Fenstermanager kennt keinen) |
| [Aktionen und Layout](070-aktionen-und-layout.md) | Start von `app`-Einträgen unter Windows (nur im Code nachgelesen) |
| [Designer und load](080-designer-und-load.md) | die App Dateiblick (Code nicht in tclutils, tkutils oder ctrlutils) |
| [tkdevtools](085-tkdevtools.md) | Anzeige der Kodierungsprofile unter Tcl 9; Schrift-Aliase unter Windows |

Ein Ergebnis zu einem dieser Punkte gehört in das jeweilige Kapitel und
wird hier gestrichen.
