---
CommandName: map_overview
title: map_overview
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - map
Copyright:
---

# Name

map\_overview – Einleitung zu den Paketen im Modul „Map“

# Beschreibung

Speicher
: siehe unten ...

    Datei
    : Definitionen einfacher Dateiformate für verschiedene geo/\*-Ressourcen und das Lesen und Schreiben dieser Dateien.

        - [map::area::file][area-file]

        - [map::box::file][box-file]

        - [map::point::file][point-file]

        - [map::track::file][track-file]


    Festplatte
    : Speicher auf der Platte für verschiedene geo/\*-Ressourcen. Es sind einfache Beispiele zum Einstieg und Vorführungen der API. Im ursprünglichen Projekt wurden diese Pakete aus einem Speicher mit **sqlite** herausgelöst. Dieser Speicher ist jedoch zu stark mit jenem Projekt verflochten, um herausgelöst zu werden.

        - [map::area::store::fs][area-store-fs]

        - [map::box::store::fs][box-store-fs]

        - [map::point::store::fs][point-store-fs]

        - [map::track::store::fs][track-store-fs]


    Hauptspeicher
    : Speicher im Hauptspeicher. Die Speicher halten geo/\*-Daten vor und ergänzen abgeleitete Attribute. Die Brücke zwischen den Speichern auf der Platte und den Widgets und Verhalten.

        - [map::area::store::memory][area-store-mem]

        - [map::box::store::memory][box-store-mem]

        - [map::point::store::memory][point-store-mem]

        - [map::track::store::memory][track-store-mem]



Widgets
: Zur Darstellung von Karten, einzelnen Geo-Ressourcen und Tabellen vieler Geo-Ressourcen derselben Art.

    Karte
    : [map::display][display]

    Tabellen von Geo-Ressourcen
    : - [map::area::table-display][area-table-display]

        - [map::box::table-display][box-table-display]

        - [map::point::table-display][point-table-display]

        - [map::track::table-display][track-table-display]


    Anzeige von Geo-Ressourcen
    : - [map::area::display][area-display]

        - [map::box::display][box-display]

        - [map::track::display][track-display]



Verhalten
: Bausteine, die sich an [map::display][display] anbinden lassen und der angezeigten Karte eigenes Verhalten geben. Die beiden Klassen zeigen Overlays für bestimmte Geo-Ressourcen und bearbeiten oder erfassen einzelne Geo-Ressourcen.

    Anzeige
    : - [map::area::map-display][area-map-display]

        - [map::box::map-display][box-map-display]

        - [map::point::map-display][point-map-display]

        - [map::track::map-display][track-map-display]


    Bearbeitung
    : - [map::box::entry][box-entry]

        - [map::mark][mark]

        - [map::track::entry][track-entry]



Unterstützung
: [map::provider::osm][provider-osm]


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Kartenanzeige und Hilfsmittel


[area-display]: area-display.md
[area-file]: area-file.md
[area-map-display]: area-map-display.md
[area-store-fs]: area-store-fs.md
[area-store-mem]: area-store-mem.md
[area-table-display]: area-table-display.md
[box-display]: box-display.md
[box-entry]: box-entry.md
[box-file]: box-file.md
[box-map-display]: box-map-display.md
[box-store-fs]: box-store-fs.md
[box-store-mem]: box-store-mem.md
[box-table-display]: box-table-display.md
[display]: display.md
[mark]: mark.md
[point-file]: point-file.md
[point-map-display]: point-map-display.md
[point-store-fs]: point-store-fs.md
[point-store-mem]: point-store-mem.md
[point-table-display]: point-table-display.md
[provider-osm]: provider-osm.md
[track-display]: track-display.md
[track-entry]: track-entry.md
[track-file]: track-file.md
[track-map-display]: track-map-display.md
[track-store-fs]: track-store-fs.md
[track-store-mem]: track-store-mem.md
[track-table-display]: track-table-display.md
