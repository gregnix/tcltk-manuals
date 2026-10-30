# Module (Stack-Sicht)

| Schicht | Buch / Ort | Umfang |
|---|---|---|
| tclutils | Buch *tclutils*, `tclutils/docs/` | 146 Moduldateien |
| tkutils | Buch *tkutils*, `tkutils/docs/` | 79 Module |
| ctrlutils | dieses Buch, `ctrlutils/docs/` | 5 Module |
| tical | dieses Buch, Kapitel 10, `tical/doc/`, `tical/schemas/` | 19 Pakete |

Gezählt als `.tm`-Dateien unter `lib/tm/<lib>/` ohne das Sammelpaket.
tclutils 0.69.0 hat 142 flache Module und vier Provider in
`tuprovider/` (`dav`, `ftp`, `sftp`, `zip`). 0.69.0 bringt `tusysinfo`
und `tuedid` neu und `tucsv`, `tusqlite` als 0.2. 0.68.0 brachte kein neues
Modul, aber neue Nummern für 76 vorhandene, darunter `tuprovider` 0.2,
`tuprovider::sftp` 0.2 und `tuopen` 0.2. `tupdftext` kam mit 0.67.0
dazu, `tutask` mit 0.65.0 (seit 0.66.0 als 0.2). In tkutils 0.49.0
neu: `tkutlfilter`, `tkutlgroup`, `tkutldrag`, `tkusysinfo`; neu
nummeriert `tkutablelist` 0.5, `tkutlstate` 0.4, `tkutlclip`,
`tkutlfind`, `tkutlsort`, `tkutltree`, `tkutltools` 0.3. In 0.48.0
neu nummeriert: `tkulauncher`, `tkuload` 0.3; in 0.47.0 `tkufiledialog`
0.2, `tkutlclip`, `tkutlfind`, `tkutlsort`, `tkutltools`, `tkutltree`
0.2, `tkutlfmt`, `tkutlfooter`, `tkutlstate` 0.3.

Bei tkutils liegt `tkutablelist` nur noch als 0.5 bei; die Dateien für
0.3 und 0.4 sind entfernt.

ctrlutils vollständig:

| Modul | Version | braucht Tk | Kernaufrufe |
|---|---|---|---|
| cufileops | 0.6 | ja | `install … ?-onop?`, `newFolder`, `openFile`, `openWith`, `openWithDefault`, `rename`, `copy`, `cut`, `paste`, `delete`, `refresh` |
| cuundo | 0.5 | nur `-list` | `install … ?-list? ?-refresh?`, `record`, `undo`, `redo`, `canUndo`, `canRedo`, `clear` |
| cufilter | 0.2 | ja | `widget $path $list`, `clear`, `lastError` |
| cumonitor | 0.2 | nein | `install … ?-interval? ?-onchange?`, `watch`, `poke`, `stop` |
| cusync | 0.3 | nein | `compare`, `plan`, `apply`, `applyOne` |

Dateien: `lib/tm/ctrlutils-0.5.tm`, in `lib/tm/ctrlutils/`
`cufileops-0.6.tm`, `cufilter-0.2.tm`, `cumonitor-0.2.tm`,
`cusync-0.3.tm`, `cuundo-0.5.tm`.

Dazu für das „Open with“-Register in cufileops: `owSetApp` (App-Name,
seit 0.5), `owApps`, `owDefault`, `owAddApp`, `owRemoveApp`,
`owSetDefault` (Schlüssel: Endung in Kleinbuchstaben mit Punkt, z. B.
`.txt`).

Sammelpaket: `ctrlutils` 0.5 lädt alle fünf.

Versionsgeschichte: ctrlutils 0.3 enthielt zuerst `cufileops` 0.3 und
`cuundo` 0.2, nach einem Nachtrag `cufileops` 0.4 und `cuundo` 0.3, dazu
`cusync` 0.1. Ab 0.4 steigt das Sammelpaket mit jedem Modul.

---

## tical 1.1.1

Alle Pakete stehen in `tical/pkgIndex.tcl`. Was sich in 1.1.1 geändert
hat, trägt 1.1.1 (`tical::holidays::de` 1.0.1; `tical::config`,
`tical::locale` und `tical::holidays` 1.0.2); `tical::term` bleibt 1.0.

| Paket | Datei | braucht | im Sammelpaket |
|---|---|---|---|
| `tical` | `tical-1.1.1.tm` | — | (Sammelpaket) |
| `tical::core` | `core/tical-core-1.1.1.tm` | — | ja |
| `tical::util` | `core/tical-util-1.1.1.tm` | — | ja |
| `tical::config` | `core/tical-config-1.0.2.tm` | — | ja |
| `tical::locale` | `core/tical-locale-1.0.2.tm` | — | ja |
| `tical::term` | `core/tical-term-1.0.tm` | — | ja |
| `tical::holidays` | `core/tical-holidays-1.0.2.tm` | — | ja |
| `tical::holidays::de` | `holidays/tical-holidays-de-1.0.1.tm` | — | ja |
| `tical::event` | `core/tical-event-1.1.1.tm` | — | ja |
| `tical::view::month` | `views/tical-view-month-1.1.1.tm` | — | ja |
| `tical::view::week` | `views/tical-view-week-1.1.1.tm` | — | ja |
| `tical::view::day` | `views/tical-view-day-1.1.1.tm` | — | ja |
| `tical::render::term` | `render/tical-render-term-1.1.1.tm` | — | ja |
| `tical::render::canvas` | `render/tical-render-canvas-1.1.1.tm` | Tk | nein |
| `tical::render::pdf` | `render/tical-render-pdf-1.1.1.tm` | `pdf4tcl` | nein |
| `tical::model` | `model/tical-model-1.1.1.tm` | — | ja |
| `tical::io::ical` | `io/tical-io-ical-1.1.1.tm` | — | ja |
| `tical::io::import` | `io/tical-io-import-1.1.1.tm` | tclutils (`tuical`, `turrule`) | nein |
| `tical::adapter::sqlite` | `adapter/tical-adapter-sqlite-1.1.1.tm` | `tdbc::sqlite3` | nein |

Auf tical bauen in tkutils 0.49.0 `tkutils::tkutical` 0.4 und
`tkutils::tkumonthcanvas` 0.5; beide fehlen im Sammelpaket `tkutils`.

---

## Zusammenfassung

- tclutils 146 Moduldateien, tkutils 79, ctrlutils 5 Module, tical 19
  Pakete.
- ctrlutils 0.5 enthält cufileops 0.6, cuundo 0.5, cusync 0.3 und
  cufilter 0.2.
- Das Sammelpaket `tical` lädt alles außer Canvas, PDF, SQLite und
  Import.

---

*Nächstes Kapitel: [Glossar](820-anhang-glossar.md)*
