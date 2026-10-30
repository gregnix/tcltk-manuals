# Glossar

---

[Pairing]{.index}
:   Abgestimmte Versionsnummern der drei Libs; derzeit tclutils 0.69.0,
    tkutils 0.49.0, ctrlutils 0.5.

[Provider]{.index}
:   Einheitliche Speicher-API (tclutils); Schemata `local`, `zip`,
    `dav`, `ftp`, `sftp`.

[Controller]{.index}
:   ctrlutils-Modul: verdrahtet Verhalten auf vorhandenen Widgets.
    Ausnahmen: `cufilter` baut eine eigene Filterzeile, `cusync` braucht
    kein Tk.

[caps]{.index}
:   Provider-Fähigkeiten; steuern Menüs. Beispiel ZIP: `get list stat`.

[Operationssatz]{.index}
:   Dict, das cufileops nach jeder erfolgreichen Operation an `-onop`
    gibt (`op mkdir|rename|paste|delete|movex` plus Pfade); cuundo
    zeichnet es auf.

[Schnappschuss]{.index}
:   Inhalt, den cufileops vor dem Löschen festhält (Bytes oder Teilbaum),
    damit cuundo ihn wiederherstellen kann.

[Polling]{.index}
:   Regelmäßiges `list` über den Provider (cumonitor); funktioniert lokal,
    im ZIP und entfernt gleich.

[Sync-Plan]{.index}
:   Ergebnis von `cusync::plan`: Kopieraktionen für eine Richtung, nie
    Löschungen.

[msgcat]{.index}
:   Tcl-Paket für Übersetzungen; in ctrlutils 0.4 holen cufileops,
    cuundo und cufilter ihre Texte daraus, Katalog im Namensraum
    `::ctrlutils`.

[Testgrenze]{.index}
:   Zeitlimit je Testdatei in Sekunden (`CTRLUTILS_TESTGRENZE` usw.,
    Standard 120).

[site-tcl]{.index}
:   Verzeichnis im Standard-Modulpfad einer Tcl-Installation
    (`lib/tcl8/site-tcl`, `lib/tcl9/site-tcl`).

[Explorer]{.index}
:   Referenz-App in ctrlutils.

[Dateiblick]{.index}
:   Endbenutzer-App auf dem Stack.

[tical]{.index}
:   Kalender- und iCalendar-Engine (1.1) in eigenem Repo; Kern ohne Tk,
    Renderer für Text, Tk-Canvas und PDF; geladen über `auto_path`.

[tical::event]{.index}
:   Terminformat von tical (`summary`, `dtstart`, `dtend`, `allday` …)
    mit `normalize` und `validate`; gilt für Views, Modell, iCalendar und
    SQLite.

[ViewSpec]{.index}
:   Dict einer tical-View (`month-grid`, `week-grid`, `day-grid`) mit
    einem Raster aus Zellen; Eingabe jedes Renderers.

[Feiertags-Plugin]{.index}
:   Befehl, der für ein Jahr ein Dict `Datum → Name` liefert, unter einer
    Region bei `tical::holidays` registriert (`DE`).

---

## Zusammenfassung

- Die Begriffe oben tragen das Buch: Pairing, Provider, caps,
  Operationssatz, Testgrenze, ViewSpec.

---

*Nächstes Kapitel: [Fehlermeldungen](830-anhang-fehlermeldungen.md)*
