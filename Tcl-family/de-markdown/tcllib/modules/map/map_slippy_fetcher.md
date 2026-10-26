---
CommandName: map::slippy::fetcher
ManualSection: n
Version: 0.7
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - http
 - location
 - map
 - server
 - slippy
 - tile
 - url
 - zoom
Copyright:
---

# NAME

map::slippy::fetcher – Zugriff auf einen Server, der Kacheln für auf Slippy basierende Karten bereitstellt

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy::fetcher]{.lit} [0.7]{.optlit} 
[::map::slippy::fetcher]{.cmd} [fetcherName]{.arg} [levels]{.arg} [url]{.arg} 
[fetcherName]{.ins} [levels]{.sub} 
[fetcherName]{.ins} [tileheight]{.sub} 
[fetcherName]{.ins} [tilewidth]{.sub} 
[fetcherName]{.ins} [get]{.sub} [tile]{.arg} [donecmd]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine Klasse für den Zugriff auf HTTP-Server, die Kacheln für Slippy-basierte Karten bereitstellen.

*ACHTUNG*, *Hinweis*: Die Version *0.7* hat keine abwärtskompatible Kompatibilität mit Version 0.5 und früheren Versionen. Dies ist darauf zurückzuführen, dass die internen Abläufe dieses Pakets auf die Verwendung der Version 0.8 von **map::slippy** umgestellt wurden.

# API

**::map::slippy::fetcher** *fetcherName* *levels* *url*
: Erstellt den Fetcher *fetcherName* und konfiguriert ihn mit der Anzahl der vom Kachelserver unterstützten Zoomstufen *levels* sowie der *url*, unter der er auf Kachelanfragen wartet. Das Ergebnis des Befehls lautet *fetcherName*.


## Methoden

*fetcherName* **levels**
: Diese Methode gibt die Anzahl der Zoomstufen zurück, die vom Fetcher-Objekt und dem von diesem aufgerufenen Kachelserver unterstützt werden.

*fetcherName* **tileheight**
: Diese Methode gibt die Höhe der ausgelieferten Kacheln in Pixeln zurück.

*fetcherName* **tilewidth**
: Diese Methode gibt die Breite der bereitgestellten Kacheln in Pixeln zurück.

*fetcherName* **get** *tile* *donecmd*
: Dies ist die Hauptmethode des Fetchers, die das Bild für die angegebene *tile* abruft. Die Kachel-Kennung ist eine Liste mit drei Elementen: der Zoomstufe sowie den Zeilen- und Spaltennummern der Kachel, in dieser Reihenfolge. Der Befehl „refix *donecmd*“ wird aufgerufen, wenn der Fetcher entweder das Bild für die Kachel kennt oder feststellt, dass kein Bild mehr bereitgestellt wird. Er wird entweder mit 2 oder 3 Argumenten aufgerufen, d. h.


**\[1\]**
: Die Zeichenfolge „**set**“, die *tile* und das Bild.

**\[2\]**
: Die Zeichenfolge „**unset**“ und die *tile*.


: Diese beiden Möglichkeiten dienen dazu, entweder das Bild für die *tile* anzugeben oder zu signalisieren, dass für die *tile* kein Bild definiert ist.


# LITERATUR

**\[1\]**
: *http://wiki.openstreetmap.org/wiki/Main_Page*
