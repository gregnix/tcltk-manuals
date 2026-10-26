---
CommandName: map_overview
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - map
Copyright:
---

# NAME

map_overview – Einleitung zu den Paketen im Modul „Map“

# BESCHREIBUNG

**Speicher**
: 


**Datei**
: Definitionen einfacher Dateiformate für verschiedene geo/\*-Ressourcen und das Lesen und Schreiben dieser Dateien.


**•**
: **map::area::file**

**•**
: **map::box::file**

**•**
: **map::point::file**

**•**
: **map::track::file**


**Festplatte**
: Speicher auf der Platte für verschiedene geo/\*-Ressourcen. Es sind einfache Beispiele zum Einstieg und Vorführungen der API. Im ursprünglichen Projekt wurden diese Pakete aus einem Speicher mit **sqlite** herausgelöst. Dieser Speicher ist jedoch zu stark mit jenem Projekt verflochten, um herausgelöst zu werden.


**•**
: **map::area::store::fs**

**•**
: **map::box::store::fs**

**•**
: **map::point::store::fs**

**•**
: **map::track::store::fs**


**Hauptspeicher**
: Speicher im Hauptspeicher. Die Speicher halten geo/\*-Daten vor und ergänzen abgeleitete Attribute. Die Brücke zwischen den Speichern auf der Platte und den Widgets und Verhalten.


**•**
: **map::area::store::memory**

**•**
: **map::box::store::memory**

**•**
: **map::point::store::memory**

**•**
: **map::track::store::memory**


**Widgets**
: Zur Darstellung von Karten, einzelnen Geo-Ressourcen und Tabellen vieler Geo-Ressourcen derselben Art.


**Karte**
: **map::display**

**Tabellen von Geo-Ressourcen**
: 


**•**
: **map::area::table-display**

**•**
: **map::box::table-display**

**•**
: **map::point::table-display**

**•**
: **map::track::table-display**


**Anzeige von Geo-Ressourcen**
: 


**•**
: **map::area::display**

**•**
: **map::box::display**

**•**
: **map::track::display**


**Verhalten**
: Bausteine, die sich an **map::display** anbinden lassen und der angezeigten Karte eigenes Verhalten geben. Die beiden Klassen zeigen Overlays für bestimmte Geo-Ressourcen und bearbeiten oder erfassen einzelne Geo-Ressourcen.


**Anzeige**
: 


**•**
: **map::area::map-display**

**•**
: **map::box::map-display**

**•**
: **map::point::map-display**

**•**
: **map::track::map-display**


**Bearbeitung**
: 


**•**
: **map::box::entry**

**•**
: **map::mark**

**•**
: **map::track::entry**


**Unterstützung**
: **map::provider::osm**


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Kartenanzeige und Hilfsmittel
