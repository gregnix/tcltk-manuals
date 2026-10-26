---
CommandName: struct::map
title: struct::map
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription:
Copyright:
---

# Name

struct::map – Schlüssel-Wert-Zuordnungen verwalten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [struct::map]{.lit} [1]{.optlit}
[::struct::map]{.cmd} [mapName]{.arg}
[mapName]{.cmd} [method]{.lit} [arg arg]{.optdot}
[mapName]{.ins} [get]{.sub}
[mapName]{.ins} [names]{.sub}
[mapName]{.ins} [set]{.sub} [name]{.arg} [value]{.optarg}
[mapName]{.ins} [unset]{.sub} [pattern...]{.optarg}
:::

# Beschreibung

Stellt eine snit-Klasse bereit, deren Instanzen eine Schlüssel-Wert-Map verwalten. Mit anderen Worten: eine Objekthülle um Tcl-Arrays.

# API

Der Hauptbefehl erzeugt Maps:

**::struct::map** *mapName*
: Erzeugt eine neue, leere Map mit einem zugehörigen globalen Tcl-Befehl, dessen Name *mapName* lautet. Mit ihm lassen sich verschiedene Operationen auf der Map aufrufen. Er hat die folgende allgemeine Form:

    **mapName** **method** ?*arg arg ...*?
    : **method** und *arg*umente bestimmen das genaue Verhalten des Befehls.


    Wird als *mapName* **%AUTO%** angegeben, erzeugt das Paket selbst einen eindeutigen Namen. Das Ergebnis des Befehls ist der vollqualifizierte Name des Instanzbefehls.


Für Map-Objekte sind folgende Befehle möglich:

*mapName* **get**
: Gibt die gesamte Map als Tcl-Dictionary zurück.

*mapName* **names**
: Gibt die Liste aller der Map bekannten Schlüssel in beliebiger Reihenfolge zurück.

*mapName* **set** *name* ?*value*?
: Setzt den Schlüssel *name* auf den angegebenen *value*, sofern ein Wert angegeben ist. Gibt den Wert für den Schlüssel zurück. Löst einen Fehler aus, wenn der Schlüssel unbekannt ist.

*mapName* **unset** ?*pattern*...?
: Entfernt alle Schlüssel aus der Map, die auf mindestens eines der glob-Muster *pattern* passen. Wird kein Muster angegeben, werden alle Schlüssel entfernt. Mit anderen Worten: Das Standardmuster lautet **\***. Das Ergebnis des Befehls ist die leere Zeichenkette.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: list* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.
