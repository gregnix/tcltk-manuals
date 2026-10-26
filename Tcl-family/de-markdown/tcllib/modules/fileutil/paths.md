---
CommandName: fileutil::paths
title: fileutil::paths
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription:
Copyright:
---

# Name

fileutil::paths – Suchpfad-Pools verwalten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [fileutil::paths]{.lit} [1.1]{.optlit}
[::fileutil::paths]{.cmd} [poolName]{.arg}
[poolName]{.cmd} [method]{.lit} [arg arg]{.optdot}
[poolName]{.ins} [add]{.sub} [path]{.arg}
[poolName]{.ins} [clear]{.sub}
[poolName]{.ins} [paths]{.sub}
[poolName]{.ins} [remove]{.sub} [path]{.arg}
:::

# Beschreibung

Stellt eine snit-Klasse bereit, deren Instanzen einen Pool von (Such-)Pfaden verwalten.

# API

Der Hauptbefehl dient zur Erstellung von Suchpfad-Pools:

**::fileutil::paths** *poolName*
: Erstellt einen neuen, leeren Pool von Suchpfaden mit einem zugehörigen globalen Tcl-Befehl, dessen Name *poolName* lautet. Dieser kann verwendet werden, um verschiedene Operationen auf den Pool anzuwenden. Er hat die folgende allgemeine Form:

    **poolName** **method** ?*arg arg ...*?
    : **method** und *arg*umente bestimmen das genaue Verhalten des Befehls.


    Wenn *poolName* als **%AUTO%** festgelegt wird, wird vom Paket selbst ein eindeutiger Name generiert. Das Ergebnis des Befehls ist der vollqualifizierte Name des Instanzbefehls.


Für Pool-Objekte sind folgende Befehle möglich:

*poolName* **add** *path*
: Fügt den *Pfad* zum Pool hinzu. Es geschieht nichts, wenn der *Pfad* dem Pool bereits bekannt ist. Das Ergebnis des Befehls ist die leere Zeichenkette.

*poolName* **clear**
: Leert den gesamten Pool. Mit anderen Worten: Entfernt alle Pfade daraus. Das Ergebnis des Befehls ist die leere Zeichenkette.

*poolName* **paths**
: Gibt die Liste aller dem Pool bekannten Pfade in der Reihenfolge zurück, in der sie hinzugefügt wurden.

*poolName* **remove** *path*
: Entfernt den *Pfad* aus dem Pool, wenn dieser dem Pool bekannt ist. Unbekannte Pfade werden ohne Fehlermeldung ignoriert. Das Ergebnis des Befehls ist die leere Zeichenkette.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.
