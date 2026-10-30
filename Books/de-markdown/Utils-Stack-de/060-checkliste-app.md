# Checkliste App

---

1. Pairing **0.69.0 / 0.49.0 / 0.4** laden;
   im Banner der Suite prüfen, welche Dateien wirklich geladen werden.
2. `setup.tcl` (oder `TCLUTILS_TM` / `TKUTILS_TM`), dazu
   `tcl::tm::path add …/ctrlutils/lib/tm` — oder alles in `site-tcl`,
   alte Moduldateien vorher löschen.
3. `package require Tk` vor `ctrlutils`. Bis ctrlutils 0.3
   `tkutils::tkufilelist` selbst laden; ab 0.4 lädt `cufileops` es.
4. Provider wählen; caps prüfen, bevor Menüs hart verdrahtet werden.
5. Widgets: `tkufilelist` / Tree / Path; Dialoge **0.3**; tablelist **0.4**.
6. `cuundo::install $f $prov -list $list`, dann `cufileops::install …
   -onop [list ::ctrlutils::cuundo::record $f]` — beide mit demselben
   `$f`; optional `cufilter::widget` (selbst packen) und `cumonitor`.
7. Refresh-Callback nach Mutation, darin `cumonitor::poke`; beim
   Tab-Ende `cumonitor::stop` und Provider `destroy`.
8. Eigene Dateiänderungen der App als Operationssatz an
   `cuundo::record` geben.
9. Sprache: Übersetzungen für cufileops, cuundo und cufilter per
   `::msgcat::mcset` im Namensraum `::ctrlutils`, für tkudialog in
   `::tkutils`.
10. Eigenen App-Namen für das „Open with“-Register setzen, beim Start:
    `::ctrlutils::cufileops::owSetApp meineapp` (ab ctrlutils 0.4).
11. Settings/Geometrie: `tusettings` / `tkugeometry`.
12. Tests: `tclsh tests/all.tcl` über tutestrun; Banner prüfen, Grenze
    über `*_TESTGRENZE`; Tk-Tests mit Display (`xvfb-run -a`).
13. Kalender: tical 1.1.1 über `auto_path` laden (nicht `tcl::tm::path`),
    Feiertage mit `-holidays DE`, Termine mit `-events` im Format von
    `tical::event`; als Widget
    `tkutils::tkutical` oder `tkutils::tkumonthcanvas` einzeln laden.
14. Explorer nicht anfassen; eigene App im eigenen Baum.

---

## Zusammenfassung

- Stack laden → Provider → View → Controller → Lebenszyklus.
- Details: Bücher *tclutils* und *tkutils*.

---

*Nächstes Kapitel: [Kalender: tical](070-tical.md)*
