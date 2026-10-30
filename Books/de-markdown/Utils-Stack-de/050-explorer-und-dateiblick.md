# Explorer und Dateiblick

## Zwei Rollen

| App | Ort | Rolle |
|---|---|---|
| Explorer | `ctrlutils/apps/explorer/` | Referenz / Demo für Controller |
| Dateiblick | `dateiblick/` | Endbenutzer-App |

Namen und Bäume getrennt lassen. Explorer in Reviews und Regeln
**unangetastet**.

Der Explorer ist die einzige App in den drei Repos, die ctrlutils
benutzt. Die Apps unter `tkutils/apps/` (Editoren, Launcher,
tkdevtools …) bauen nur auf tclutils und tkutils; die unter
`tclutils/apps/` (`find-tclconfig`, `build-app`) sind Tk-frei.

---

## Explorer (Kurz)

```bash
wish ctrlutils/apps/explorer/explorer.tcl ?verzeichnis?
wish ctrlutils/apps/explorer/explorer.tcl -zip archiv.zip
wish ctrlutils/apps/explorer/explorer.tcl -remote URL ?provider-optionen?
wish ctrlutils/apps/explorer/explorer.tcl --check
```

- Ohne Argument startet der Explorer im aktuellen Verzeichnis.
- `-remote` nimmt `sftp://`, `ftp://`, `dav://`, `davs://` oder
  `http(s)://` und lädt den passenden Provider erst bei Bedarf.
- `--check` (oder `-check`) zeigt, welche optionalen Vorschauen geladen
  sind (Bildformate über `img::*`, SVG über `tcllunasvg`, PDF über
  `pdfiumtcl`, SQLite) — auf der Konsole und in einem Fenster. Nach dem
  Schließen des Fensters endet er mit Exit 0 nur, wenn alle da sind.
  Geprüft (Tcl/Tk 8.6.14, Linux, Xvfb): hier fehlen
  `img::jpeg`, `img::tiff`, `img::bmp`, `img::ico`, `tcllunasvg` und
  `pdfiumtcl`; SQLite ist `OK`.

Die drei Bibliotheken müssen auf dem Modulpfad liegen (Setup oder
`site-tcl`, siehe [Pairing und Setup](020-pairing-und-setup.md)). Der
Explorer sourct `setup.tcl` nicht selbst. Dazu braucht er Tablelist
(mit Scrollutil) aus tklib. Fehlt ein Pflichtpaket, zeigt er ein
Meldungsfenster „Explorer cannot start“ statt eines leeren Fensters und
endet mit Exit 1. Die Meldung nennt das Paket, die Fehlermeldung von
`package require`, den durchsuchten Modulpfad und den `auto_path`:

```
Missing package:
  tkutils::tkufiletree

can't find package tkutils::tkufiletree

Searched module path (tcl::tm::path):
/usr/lib/tcltk/tcl8/site-tcl
...

Searched auto_path:
...
```

Geprüft (Tcl/Tk 8.6.14 und 9.0.4, Linux, Xvfb) ohne
Modulpfad zu den drei Bibliotheken. Die Pflichtmodule sind `.tm`-Module
und werden über den Modulpfad gefunden, nicht über `auto_path`. Bis
ctrlutils 0.3 nannte die Meldung nur den `auto_path`.

Je Tab: `tkufiletree`, `tkufilelist` mit `cufilter`-Zeile darüber,
`tkupreview`; dazu `cuundo::install … -list`, `cufileops::install … -onop
[list ::ctrlutils::cuundo::record $f]` und `cumonitor` mit 2000 ms.

Jeder Tab hält seinen **eigenen** Provider. Ein Tab kann ein ZIP zeigen,
ein anderer die lokale Platte; cufileops kopiert zwischen ihnen, weil
seine Zwischenablage den Quell-Provider kennt. Der Knopf „+“ und Strg+T
öffnen einen neuen lokalen Tab im Home-Verzeichnis. Beim Schließen eines
Tabs stoppt der Explorer dessen `cumonitor` und zerstört den Provider,
wenn kein anderer Tab ihn noch benutzt. Geprüft (Tcl/Tk
8.6.14, Linux, Xvfb): Start mit `-zip` ergibt einen Tab mit Provider
`::tclutils::tuprovider::Zip`, ein neuer Tab bekommt ein eigenes
Provider-Objekt.

`cusync` ist optional geladen: fehlt es, startet der Explorer trotzdem;
erst „File > Sync folders...“ meldet
`Sync needs the ctrlutils::cusync module.` und rät, das Modul neben die
übrigen ctrlutils-Module zu legen. Ebenso optional ist
`tkutils::tkutlfind` für die Suche in der Liste; fehlt es, sagt die
Meldung, das Modul zu den übrigen tkutils-Modulen zu legen. Bis
ctrlutils 0.4 nannten beide Meldungen einen Dateinamen
(`cusync-0.2.tm`, `tkutlfind-0.2.tm`); die Datei heißt seit tkutils
0.49.0 aber `tkutlfind-0.3.tm`. Das Menü „Edit“ bietet Undo,
Redo und dieselben Dateioperationen wie das Kontextmenü. Fehler beim
Start und Hintergrundfehler zeigt `tkudialog` mit kopierbaren Details.
Die Oberflächentexte des Explorers selbst sind englisch und laufen nicht
über msgcat.

Als Einzelprogramm lässt sich der Explorer mit `build-app` aus tclutils
bauen (Tcl-9-Zipkit mit allen drei `lib/tm`-Bäumen plus Tablelist und
Scrollutil). Das beschreibt `tclutils/apps/build-app/doc/`; hier nicht
geprüft.

---

## Dateiblick (Kurz)

Dateiblick liegt nicht in den drei Repos. Die folgenden Punkte stammen
aus dem Review-Stand und sind für diesen Stand **nicht
geprüft**:

- Handverdrahtete GUI (kein `tkuload::slot` / `.tkd`)
- Requires u. a. `tkudialog` 0.3, `cufileops` 0.3
- Suite gegen Geschwister-Utils grün (Stand Reviews: 45/45)
- Workarounds für Multi-Select und Dialog-Defaults entfernt — Libs tragen das

Architektur-Notiz: `00review/dateiblick-review.md` (im Dateiblick-Baum).

`package require ctrlutils::cufileops 0.3` lädt auch 0.5 (gleiche
Hauptversion). Wer Dateiblick auf Deutsch zeigen will, legt die
Übersetzungen im Namensraum `::ctrlutils` ab (siehe
[cufileops und Undo](040-cufileops-und-undo.md)) und für die Dialoge in
`::tkutils`. Das Register für „Open with“ teilt sich Dateiblick mit dem
Explorer, bis es `::ctrlutils::cufileops::owSetApp dateiblick` aufruft
(ab ctrlutils 0.4).

---

## Zusammenfassung

- Explorer = Referenz, Dateiblick = Produkt.
- Beide auf demselben Stack; nicht vermischen.
- Im Explorer hat jeder Tab seinen eigenen Provider.

---

*Nächstes Kapitel: [Checkliste App](060-checkliste-app.md)*
