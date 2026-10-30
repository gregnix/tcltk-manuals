# Verzeichnis beobachten: cumonitor

[cumonitor]{.index} 0.2 pollt `list` des Providers und vergleicht eine
Signatur aus Name, Typ, Größe und mtime. Kein inotify. Polling ist der
Weg, der lokal, im ZIP und auf entfernten Providern gleich funktioniert.
Das Modul braucht kein Tk, aber eine Ereignisschleife.

```tcl
::ctrlutils::cumonitor::install $f $prov -interval 2000 \
    -onchange [list ::app::onDirChanged $f]
::ctrlutils::cumonitor::watch $f $dir    ;# neue Basis, feuert nicht
# nach eigenen Änderungen der App:
::ctrlutils::cumonitor::poke $f
::ctrlutils::cumonitor::stop $f          ;# beim Schließen des Tabs
```

- `-interval` in Millisekunden, Standard 2000.
- `-onchange` bekommt das geänderte Verzeichnis angehängt. Ein Fehler im
  Callback wird verschluckt; das Polling läuft weiter.
- Eine unbekannte Option wirft `{CTRLUTILS CUMONITOR OPTION -name}` und
  nennt die bekannten. Vor 0.2 war das ein Fehler ohne Errorcode.
- Die erste Momentaufnahme ist die Basis; erst eine echte Abweichung
  feuert. `watch` setzt die Basis still neu, Navigieren sieht also nicht
  wie eine Änderung aus.
- `watch` vor `install` ist ein Fehler: `cumonitor: <f> not installed`.
  Ist im Prozess noch gar kein Monitor installiert, melden `watch`,
  `poke` und `stop` stattdessen `can't read "state": no such variable`
  (geprüft, Tcl 8.6.14 und 9.0.4). `stop` ist also erst nach dem ersten
  `install` gefahrlos.
- Ein Verzeichnis, das nicht mehr lesbar ist, zählt als Änderung.
- Ohne `poke` nach eigenen Operationen meldet der Monitor sie zurück.
- `stop` ist wiederholbar und verwirft den Zustand.

Geprüft (Tcl 8.6.14 und 9.0.4, Linux): unter `tclsh` mit `vwait` und
`-interval 200` feuert `-onchange` nach dem Anlegen einer Datei und
bekommt das beobachtete Verzeichnis angehängt.

Der Explorer setzt das Intervall auf 2000 ms und ruft beim Schließen
eines Tabs `stop`. Das steht im Kapitel
[Explorer und Dateiblick](050-explorer-und-dateiblick.md).

---

## Merkliste

- Signatur: Name, Typ, Größe, mtime.
- `watch` feuert nicht. `poke` schluckt die eigenen Änderungen.
- Ein Fehler im Callback stoppt das Polling nicht.
- Ohne Tk laden, mit Ereignisschleife laufen lassen.

---

*Nächstes Kapitel: [Spiegeln: cusync](036-cusync.md)*
