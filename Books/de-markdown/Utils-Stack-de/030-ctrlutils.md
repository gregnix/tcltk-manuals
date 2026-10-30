# ctrlutils

## Fünf Controller

| Modul | Rolle | Tk |
|---|---|---|
| `cufileops` 0.5 | Kontextmenü und Tasten an der Dateiliste: neu, öffnen, öffnen mit, umbenennen, kopieren, ausschneiden, einfügen, löschen | ja |
| `cuundo` 0.4 | Undo/Redo für die Operationen von cufileops | lädt ohne Tk; Tasten nur mit `-list` |
| `cufilter` 0.1 | eigene Filterzeile über der Liste | ja |
| `cumonitor` 0.2 | Verzeichnis per Polling überwachen, Callback bei Änderung | nein (nur `after`) |
| `cusync` 0.2 | zwei Bäume vergleichen und einseitig spiegeln | nein |

```tcl
package require ctrlutils
# oder einzeln: package require ctrlutils::cufileops 0.6
```

`package require ctrlutils` lädt alle fünf und braucht dafür Tk. Seit
ctrlutils 0.4 lädt `cufileops` auch `tkutils::tkufilelist` 0.2; bis 0.3
musste die App das selbst tun. Docs:
`ctrlutils/docs/<modul>.md`, Manpages: `ctrlutils/man/mann/<modul>.n`.
Suite: **91** Tests in 8 Dateien (geprüft, Tcl/Tk 8.6.14
und 9.0.4, Linux, Xvfb).

Neu in ctrlutils 0.5, kurz:

- `cusync`: Ein Verzeichnis, das sich nicht auflisten lässt, ist ein
  Fehler `{CTRLUTILS CUSYNC LIST side dir}`. Bis 0.4 galt die Seite als
  leer, und der Spiegel kopierte jede Datei der Quelle darüber.
- `cufileops`: Einträge eines Cut, die sich nicht kopieren ließen,
  bleiben in der Zwischenablage. Neu `refresh $f`.
- `cuundo`: Option `-refresh`; ein scheiterndes Auffrischen ist ein
  Fehler statt still verschluckt.
- `cufilter`: Ein Filter, der sich nicht setzen lässt, markiert die Zeile
  und bleibt über `lastError` lesbar.

Neu in ctrlutils 0.4, kurz:

- `cuundo`: Ein gescheitertes Redo bleibt auf dem Redo-Stapel. Die
  Fehlerdialoge bekommen `-parent`, die Gründe laufen über msgcat.
  `tclutils::tuprovider` lädt es nicht mehr selbst.
- `cufileops`: lädt `tkufilelist` 0.2; neu `owSetApp` für den
  App-Namen des „Open with“-Registers.
- `cufilter`: „Filter:“ und „x“ laufen über msgcat.
- `cusync`: prüft die Optionen von `apply`; die mtime überträgt es nur
  zwischen zwei lokalen Providern.
- Explorer: Die Startmeldung bei fehlendem Modul nennt auch den
  Modulpfad.

Jeder [Controller]{.index} hängt nur an der Provider-Schnittstelle von
tclutils und an tkutils-Widgets — nie an einer bestimmten App. Zustand
liegt je Sicht unter einem Schlüssel `$f` (z. B. dem Tab-Frame); mehrere
Sichten bleiben so getrennt. Undo und Liste finden sich über dasselbe
`$f`: cufileops und cuundo für eine Sicht mit demselben Schlüssel
installieren.

---

## Abhängigkeit zur View

`cufileops` 0.5 braucht `tkucontextmenu`, `tkudialog` 0.3 und
`tkufilelist` 0.2; `tuopen` (Öffnen mit der Standard-App) und `msgcat`
sind optional. Es spielt mit `tkutablelist` ab 0.4 (Standard
`-exportselection 0`), damit die Mehrfachauswahl beim Rechtsklick nicht
verloren geht. `cufileops` 0.4 aus ctrlutils 0.3 rief `tkufilelist` auf,
ohne es zu laden. Details:
[cufileops und Undo](040-cufileops-und-undo.md).

---

## Weiter

Die drei kleineren Module haben eigene Kapitel:
[Filter](032-cufilter.md),
[Verzeichnis beobachten](034-cumonitor.md),
[Spiegeln](036-cusync.md). Dateioperationen und Undo stehen im Kapitel
[cufileops und Undo](040-cufileops-und-undo.md).

---

## Zusammenfassung

- Fünf Module. cufileops, cuundo und cumonitor hängen an vorhandenen
  Pfaden. cufilter baut eine eigene Zeile. cusync rechnet ohne Tk.
- Das Sammelpaket braucht Tk. cusync, cumonitor und cuundo laden auch
  ohne.
- ctrlutils 0.4 lädt `tkufilelist`, behält ein gescheitertes Redo,
  prüft die Optionen von `cusync` und nimmt einen eigenen App-Namen
  für „Open with“.
- ctrlutils 0.5 macht einen Fehler beim Auflisten in `cusync` laut und
  behält nach einem Teilfehler den Rest eines Cut.

---

*Nächstes Kapitel: [Filter](032-cufilter.md)*
