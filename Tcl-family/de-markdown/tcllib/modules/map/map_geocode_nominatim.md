---
CommandName: map::geocode::nominatim
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - geocoding
 - http
 - location
 - map
 - nominatim
 - server
 - url
Copyright:
---

# NAME

map::geocode::nominatim – Auflösung geografischer Namen mit einem Nominatim-Dienst

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [http]{.lit} 
[package]{.cmd} [require]{.sub} [json]{.lit} 
[package]{.cmd} [require]{.sub} [uri]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [map::geocode::nominatim]{.lit} [0.3]{.optlit} 
[::map::geocode::nominatim]{.cmd} [requestor]{.arg} [-baseurl url]{.optarg} [-callback callback]{.optarg} [-error error callback]{.optarg} 
[\$cmdprefix]{.cmd} [result]{.arg} 
[\$cmdprefix]{.cmd} [errorstring]{.arg} 
[requestor]{.ins} [search]{.sub} [query]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse für den Zugriff auf Geokodierungsdienste bereit, die die *Nominatim*-Schnittstelle implementieren (siehe **LITERATUR**)

# API

**::map::geocode::nominatim** *requestor* ?**-baseurl** *url*? ?**-callback** *callback*? ?**-error** *error callback*?
: Erstellt ein Objekt für eine Geokodierungsanfrage (*requestor*), das seine Anfragen an den *Nominatim*-Server sendet. Das Ergebnis des Befehls ist *name*.


## Optionen

**-baseurl** *url*
: Der Wert der Basis-URL des *Nominatim*-Dienstes. Der Standardwert ist der Dienst von *OpenStreetMap* unter *http://nominatim.openstreetmap.org/search*. Eine mögliche kostenlose Alternative finden Sie unter *http://open.mapquestapi.com//nominatim/v1/search*.

**-callback** *cmdprefix*
: Ein Befehlspräfix, das aufgerufen werden soll, sobald Suchergebnisse vorliegen. Die Standardeinstellung, die aktiv ist, wenn bei der Objekterstellung keine Angabe erfolgte, besteht darin, das *result* (siehe unten) auf *stdout* auszugeben. Das Ergebnis des Befehlspräfixes wird ignoriert. Vom Befehlspräfix ausgelöste Fehler werden abgefangen und führen zur Aufrufung der Fehler-Rückruffunktion (siehe Option **-error** weiter unten), wobei die Fehlermeldung als Argument übergeben wird. Die Signatur des Befehlspräfixes lautet:


**\$cmdprefix** *result*
: Das *result* ist eine Liste von Dictionaries, die jeweils einen Eintrag pro Treffer enthält. Jedes Dictionary enthält die folgenden Einträge:


**place_id**
: Die Ortskennung (FIXME: Was ist das?)

**licence**
: Die Datenlizenzangabe

**osm_type**
: Der OSM-Typ des Standorts

**osm_id**
: FIXME

**boundingbox**
: Die Koordinaten des Begrenzungsrahmens (minimale und maximale Breite, minimale und maximale Länge)

**lat**
: Der Breitengrad des Standorts

**lon**
: Der Längengrad des Ortes

**display_name**
: der für Menschen lesbare Name des Standorts

**class**
: FIXME

**type**
: FIXME

**icon**
: FIXME


**-error** *cmdprefix*
: Ein Befehlspräfix, das bei Auftreten von Fehlern aufgerufen wird. In der Regel handelt es sich dabei um HTTP-Fehler. Die Standardeinstellung, die aktiv ist, wenn bei der Objekterstellung keine Angabe erfolgte, besteht darin, den *errorstring* (siehe unten) an *stderr* auszugeben. Das Ergebnis des Befehlspräfixes wird ignoriert. Vom Befehlspräfix ausgelöste Fehler werden an übergeordnete Ebenen weitergeleitet. Die Signatur des Befehlspräfixes lautet:


**\$cmdprefix** *errorstring*
: 


## Methoden

*requestor* **search** *query*
: Diese Methode gibt eine Liste von Dictionaries zurück, wobei jedes Element einem Treffer für die angegebene *query* entspricht.


# LITERATUR

**\[1\]**
: *http://wiki.openstreetmap.org/wiki/Nominatim*

**\[2\]**
: *http://open.mapquestapi.com/nominatim/*
