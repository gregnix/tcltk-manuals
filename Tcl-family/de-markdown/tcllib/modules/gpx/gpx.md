---
CommandName: gpx
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: GPS eXchange Format (GPX)
Keywords:
 - gps
 - gpx
Copyright:
 - Copyright (c) 2010, Keith Vetter <kvetter@gmail.com>
---

# NAME

gpx – Extrahiert Wegpunkte, Tracks und Routen aus GPX-Dateien

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [gpx]{.lit} [1.1]{.optlit} 
[::gpx::Create]{.cmd} [gpxFilename]{.arg} [rawXML]{.optarg} 
[::gpx::Cleanup]{.cmd} [token]{.arg} 
[::gpx::GetGPXMetadata]{.cmd} [token]{.arg} 
[::gpx::GetWaypointCount]{.cmd} [token]{.arg} 
[::gpx::GetAllWaypoints]{.cmd} [token]{.arg} 
[::gpx::GetTrackCount]{.cmd} [token]{.arg} 
[::gpx::GetTrackMetadata]{.cmd} [token]{.arg} [whichTrack]{.arg} 
[::gpx::GetTrackPoints]{.cmd} [token]{.arg} [whichTrack]{.arg} 
[::gpx::GetRouteCount]{.cmd} [token]{.arg} 
[::gpx::GetRouteMetadata]{.cmd} [token]{.arg} [whichRoute]{.arg} 
[::gpx::GetRoutePoints]{.cmd} [token]{.arg} [whichRoute]{.arg} 
:::

# BESCHREIBUNG

Dieses Modul parst eine GPX-Datei (GPS eXchange) und extrahiert daraus Wegpunkte, Tracks, Routen und Metadaten. Unterstützt werden die GPX-Versionen 1.0 und 1.1.

# BEFEHLE

**::gpx::Create** *gpxFilename* ?*rawXML*?
: Der Befehl **::gpx::Create** ist der erste Befehl, der zur Verarbeitung von GPX-Daten aufgerufen wird. Er entnimmt die GPX-Daten dem Parameter *rawXML*, sofern vorhanden, sonst dem Inhalt von *gpxFilename*, und parst sie mit *tdom*. Er gibt einen Token-Wert zurück, den alle anderen Befehle verwenden.

**::gpx::Cleanup** *token*
: Diese Prozedur räumt die mit *token* verbundenen Ressourcen auf. Es wird *dringend* empfohlen, diese Funktion aufzurufen, nachdem Sie die Arbeit mit einer bestimmten GPX-Datei abgeschlossen haben. Andernfalls wird der Speicher nicht freigegeben, und wenn Ihre App die Funktion **::gpx::Create** oft genug aufruft, könnte das Speicherleck zu Leistungseinbußen führen … oder Schlimmerem.

**::gpx::GetGPXMetadata** *token*
: Diese Prozedur gibt ein Dictionary mit den Metadaten zurück, die zu den durch *token* identifizierten GPX-Daten gehören. Das Format des Metadaten-Dictionaries wird im Folgenden beschrieben, wobei die Schlüssel *version* und *creator* stets vorhanden sind.

**::gpx::GetWaypointCount** *token*
: Diese Prozedur gibt die Anzahl der Wegpunkte zurück, die in den durch *token* identifizierten GPX-Daten definiert sind.

**::gpx::GetAllWaypoints** *token*
: Diese Prozedur gibt eine Liste der Wegpunkte zurück, die in den durch *token* identifizierten GPX-Daten definiert sind. Das Format der einzelnen Wegpunkteinträge wird im Folgenden beschrieben.

**::gpx::GetTrackCount** *token*
: Diese Prozedur gibt die Anzahl der in den durch *token* identifizierten GPX-Daten definierten Tracks zurück.

**::gpx::GetTrackMetadata** *token* *whichTrack*
: Diese Prozedur gibt ein Dictionary mit den Metadaten zurück, die der Track-Nummer *whichTrack* (ab 1) in den durch *token* identifizierten GPX-Daten zugeordnet sind. Das Format des Metadaten-Dictionaries wird im Folgenden beschrieben.

**::gpx::GetTrackPoints** *token* *whichTrack*
: Die Prozedur gibt eine Liste der Trackpunkte zurück, aus denen der Track mit der Nummer *whichTrack* (ab 1) in den durch *token* identifizierten GPX-Daten besteht. Das Format des Metadaten-Dictionaries wird im Folgenden beschrieben.

**::gpx::GetRouteCount** *token*
: Diese Prozedur gibt die Anzahl der Routen zurück, die in den durch *token* identifizierten GPX-Daten definiert sind.

**::gpx::GetRouteMetadata** *token* *whichRoute*
: Diese Prozedur gibt ein Dictionary mit den Metadaten zurück, die der Routennummer *whichRoute* (ab 1) in den durch *token* identifizierten GPX-Daten zugeordnet sind. Das Format des Metadaten-Dictionaries wird im Folgenden beschrieben.

**::gpx::GetRoutePoints** *token* *whichRoute*
: Die Prozedur gibt eine Liste der Routenpunkte zurück, aus denen die Route mit der Nummer *whichRoute* (ab 1) in den durch *token* identifizierten GPX-Daten besteht. Das Format des Metadaten-Dictionaries wird im Folgenden beschrieben.


# DATENSTRUKTUREN

**metadata dictionary**
: Die Metadaten des GPX-Dokuments, eines Tracks, einer Route, eines Wegpunkts, eines Trackpunkts oder eines Routenpunkts werden in einem Dictionary zurückgegeben. Die Schlüssel dieses Dictionarys sind die jeweils vorhandenen optionalen GPX-Elemente. Der Wert jedes Schlüssels hängt vom GPX-Schema des jeweiligen Elements ab. So ist der Wert eines version-Schlüssels eine Zeichenkette, der eines link-Schlüssels ein untergeordnetes Dictionary mit den Schlüsseln *href* sowie optional *text* und *type*.

**point item**
: Jeder Eintrag in einer Liste von Track- oder Routenpunkten besteht aus einer Liste mit drei Elementen: *latitude*, *longitude* und *metadata dictionary*. *latitude* und *longitude* sind Dezimalzahlen. Das Format des *metadata dictionary* ist oben beschrieben. Bei Punkten in einem Track sind in der Regel immer die Metadatenschlüssel ele (Höhe) und time (Zeit) vorhanden.


# BEISPIEL

```
% set token [::gpx::Create myGpxFile.gpx]
% set version [dict get [::gpx::GetGPXMetadata $token] version]
% set trackCnt [::gpx::GetTrackCount $token]
% set firstPoint [lindex [::gpx::GetTrackPoints $token 1] 0]
% lassign $firstPoint lat lon ptMetadata
% puts "first point in the first track is at $lat, $lon"
% if {[dict exists $ptMetadata ele]} {
     puts "at elevation [dict get $ptMetadata ele] meters"
  }
% ::gpx::Cleanup $token
```

# LITERATUR

**\[1\]**
: GPX: the GPS Exchange Format (*http://www.topografix.com/gpx.asp*)

**\[2\]**
: GPX 1.1 Schema Documentation (*http://www.topografix.com/GPX/1/1/*)

**\[3\]**
: GPX 1.0 Developer's Manual (*http://www.topografix.com/gpx_manual.asp*)


# AUTOREN

Keith Vetter

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *gpx* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dateiformate

# COPYRIGHT

```
Copyright (c) 2010, Keith Vetter <kvetter@gmail.com>
```
