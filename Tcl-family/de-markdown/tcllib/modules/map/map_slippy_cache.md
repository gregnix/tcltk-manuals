---
CommandName: map::slippy::cache
title: map::slippy::cache
ManualSection: n
Version: 0.5
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - cache
 - filesystem
 - location
 - map
 - slippy
 - tile
 - zoom
Copyright:
---

# Name

map::slippy::cache – Verwaltung eines Kache-Caches im lokalen Dateisystem

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy::cache]{.lit} [0.5]{.optlit}
[::map::slippy::cache]{.cmd} [cacheName]{.arg} [cachedir]{.arg} [provider]{.arg}
[cacheName]{.ins} [valid]{.sub} [tile]{.arg} [msgvar]{.optarg}
[cacheName]{.ins} [exists]{.sub} [tile]{.arg}
[cacheName]{.ins} [get]{.sub} [tile]{.arg} [donecmd]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Klasse zur Verwaltung eines Cache mit Kacheln für „Slippy“-basierte Karten im lokalen Dateisystem bereit.

*ACHTUNG*, *Hinweis*: Version *0.5* hat keine abwärtskompatible Kompatibilität mit Version 0.3 und früheren Versionen. Dies ist darauf zurückzuführen, dass die internen Abläufe dieses Pakets auf die Verwendung der Version 0.8 von **map::slippy** umgestellt wurden.

# API

**::map::slippy::cache** *cacheName* *cachedir* *provider*
: Erstellt den Cache *cacheName* und konfiguriert ihn sowohl mit dem Pfad zu dem Verzeichnis, das die lokal zwischengespeicherten Kacheln enthält (*cachedir*), als auch mit dem Befehlspräfix, über das er angeforderte Kacheln abruft, die dem Cache selbst noch nicht bekannt sind (*provider*).

    Das Ergebnis des Befehls lautet *cacheName*.


## Methoden

*cacheName* **valid** *tile* ?*msgvar*?
: Diese Methode überprüft die Gültigkeit einer angegebenen *tile*-Kennung. Es handelt sich hierbei um eine Komfortfunktion für **::map::slippy tile valid**, die über dieselbe Schnittstelle verfügt.

*cacheName* **exists** *tile*
: Diese Methode testet, ob der Cache die angegebene *tile* enthält oder nicht. Das Ergebnis ist ein boolescher Wert: **true**, wenn die Kachel bekannt ist, und andernfalls **false**. Die Kachel wird durch eine Liste identifiziert, die drei Elemente enthält: Zoomstufe, Zeilennummer und Spaltennummer, in dieser Reihenfolge.

*cacheName* **get** *tile* *donecmd*
: Dies ist die Hauptmethode des Caches, mit der das Bild für die angegebene *tile* aus dem Cache abgerufen wird. Die Kachel-Kennung ist eine Liste mit drei Elementen: der Zoomstufe sowie der Zeilen- und Spaltennummer der Kachel, in dieser Reihenfolge.

    Der Befehl refix *donecmd* wird aufgerufen, wenn der Cache entweder das Bild für die Kachel kennt oder feststellt, dass kein Bild verfügbar sein wird. Er wird entweder mit 2 oder 3 Argumenten aufgerufen, d. h.

    1. Die Zeichenfolge „**set**“, die *tile* und das Bild.

    2. Die Zeichenfolge „**unset**“ und die *tile*.


    Diese beiden Möglichkeiten dienen dazu, entweder das Bild für die *tile* anzugeben oder zu signalisieren, dass für die *tile* kein Bild definiert ist.

    Wenn der Cache keine Informationen über die Kachel besitzt, ruft er den bei seiner Erstellung festgelegten Befehlspräfix *provider* auf und fügt drei Argumente hinzu: die Zeichenfolge **get**, die *tile* sowie eine Rückruffunktion in den Cache. Letzterer wird vom Provider aufgerufen, um entweder das Bild an den Cache zu übertragen oder zu signalisieren, dass für die Kachel kein Bild vorhanden ist.

    Wenn mehrere Anfragen für dieselbe Kachel gestellt werden, wird nur eine einzige Anfrage an den Provider gesendet.


# Literatur

1. <http://wiki.openstreetmap.org/wiki/Main_Page>
