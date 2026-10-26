---
CommandName: uuid
title: uuid
ManualSection: n
Version: 1.0.9
TclPart: tcllib
TclDescription: uuid
Keywords:
 - GUID
 - UUID
Copyright:
 - Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

uuid – Erzeugung und Vergleich von UUIDs

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [uuid]{.lit} [1.0.9]{.optlit}
[::uuid::uuid]{.cmd} [generate]{.sub}
[::uuid::uuid]{.cmd} [equal]{.sub} [id1]{.arg} [id2]{.arg}
:::

# Beschreibung

Dieses Paket stellt einen Generator für universell eindeutige Identifikatoren (UUID) bereit, die auch als global eindeutige Identifikatoren (GUID) bezeichnet werden. Diese Implementierung folgt dem Spezifikationsentwurf aus (1), obwohl es sich dabei eigentlich um einen abgelaufenen Entwurf handelt.

# Befehle

**::uuid::uuid generate**
: Erzeugt eine UUID vom Typ 4, indem eine bestimmte Anzahl von Bits verschiedener Daten, darunter die Uhrzeit und der Hostname, mit einem MD5-Hash-Algorithmus verarbeitet wird. Gibt die Zeichenfolgenrepräsentation der neuen UUID zurück.

**::uuid::uuid equal** *id1* *id2*
: Vergleicht zwei UUIDs und gibt „true“ zurück, wenn beide Argumente dieselbe UUID sind.


# Beispiele

```
% uuid::uuid generate
b12dc22c-5c36-41d2-57da-e29d0ef5839c
```

# Literatur

1. Paul J. Leach, „UUIDs und GUIDs“, Februar 1998. (<http://www.opengroup.org/dce/info/draft-leach-uuids-guids-01.txt>)


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *uuid* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
```
