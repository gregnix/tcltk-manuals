# Stack verstehen

## Einführung

Der Utils-Stack besteht aus drei Bibliotheken: [tclutils]{.index}
(Logik), [tkutils]{.index} (Widgets) und [ctrlutils]{.index}
(Controller). Dieses Handbuch beschreibt, wie die drei zusammenpassen:
Paarung der Versionen, Setup, Tests, die Controller-Module von ctrlutils
und den Unterschied zwischen Explorer und Dateiblick. Ein eigenes Kapitel
gilt der Kalender-Engine [tical]{.index}, einer vierten, optionalen
Bibliothek, auf der zwei Kalender-Widgets von tkutils aufbauen. Die API
der einzelnen Module beschreiben die Bücher *tclutils* und *tkutils*.

Es gilt für die Paarung tclutils **0.69.0**, tkutils **0.49.0** und
ctrlutils **0.5**, dazu tical **1.1**. Beispiele und Testsuiten sind mit
Tcl/Tk 8.6.14 und 9.0.4 unter Linux (Xvfb) geprüft, die Testsuiten auch
unter macOS und Windows. Die Beispiele sind dort nicht geprüft.

---

## Drei Repos, eine Schichtungsregel

```
tclutils   (tu*)   Logik, kein Tk        = Model
tkutils    (tku*)  Widgets               = View
ctrlutils  (cu*)   Verhalten verdrahten  = Controller

tical      (tical::*)  Kalender-Engine, eigenes Repo, optional
```

Ein tkutils-Modul **ist** ein Widget (`tkufilelist $path …`). Ein
ctrlutils-Modul **verdrahtet** Verhalten auf vorhandenen Widgets
(`cufileops::install …`) — ohne eigenen Widget-Pfad. Zwei Abweichungen:
`cufilter::widget` baut eine eigene kleine Filterzeile, und `cusync`
braucht gar kein Tk (Vergleich und Spiegeln über Provider).

Paketnamen folgen den Präfixen: Sammelpakete `tclutils`, `tkutils`,
`ctrlutils`; Einzelmodule `tclutils::tu…`, `tkutils::tku…`,
`ctrlutils::cu…`. tical gehört nicht zur Schichtung: Es hat einen eigenen
Kern ohne Tk, eigene Renderer und wird über `auto_path` gefunden, nicht
über den Modulpfad (Kapitel [Kalender: tical](070-tical.md)).

---

## Warum getrennt

- CI und Server laden nur tclutils.
- Widgets ohne App-Politik wiederverwenden.
- Controller gegen die Provider-API, nicht gegen eine feste App.

Tk-frei laden lassen sich `ctrlutils::cusync`, `ctrlutils::cumonitor`
und `ctrlutils::cuundo`. Das Sammelpaket `ctrlutils` dagegen braucht Tk,
denn `cufileops` zieht Kontextmenü und Dialoge aus tkutils nach.
Geprüft (Tcl/Tk 8.6.14 und 9.0.4, Linux): ohne Display endet
`package require ctrlutils` mit
`no display name and no $DISPLAY environment variable`.

Paarung dieses Buchs: **0.69.0 / 0.49.0 / 0.4**, dazu tical **1.1**.

---

## Aufbau

Kapitel 2 behandelt Paarung, Setup und Tests. Danach folgen die fünf
Controller: Überblick, Filter, Verzeichnis beobachten, Spiegeln,
`cufileops` und `cuundo`. Kapitel 8 stellt Explorer und Dateiblick
gegenüber, Kapitel 9 ist die Checkliste für eigene Anwendungen.
Kapitel 10 beschreibt tical: Views, Termine, Renderer, Feiertage,
iCalendar-Export und -Import und das Verhältnis zu den Kalendermodulen
von tclutils und tkutils. Die
Anhänge enthalten Fallen (A), die Modulliste (B), das Glossar (C) und
Fehlermeldungen (D).

---

## Merkliste

- Model / View / Controller als drei Paketbäume.
- Apps sind Glue darüber (Explorer, Dateiblick).
- Ohne Tk nur einzelne Controller laden, nicht das Sammelpaket.
- tical ist optional und liegt neben dem Stack, nicht darin.

---

*Nächstes Kapitel: [Pairing und Setup](020-pairing-und-setup.md)*
