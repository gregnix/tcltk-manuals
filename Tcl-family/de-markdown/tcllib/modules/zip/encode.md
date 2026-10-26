---
CommandName: zipfile::encode
title: zipfile::encode
ManualSection: n
Version: 0.5.2
TclPart: tcllib
TclDescription: Zip archive handling
Keywords:
 - compression
 - zip
Copyright:
 - Copyright (c) 2008-2009 Andreas Kupries
---

# Name

zipfile::encode – Erstellung von ZIP-Archiven

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [Trf]{.lit}
[package]{.cmd} [require]{.sub} [crc32]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [zlibtcl]{.lit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[package]{.cmd} [require]{.sub} [zipfile::encode]{.lit} [0.5.2]{.optlit}
[::zipfile::encode]{.cmd} [objectName]{.arg}
[<encoder>]{.lit} [comment:]{.lit} [text]{.arg}
[<encoder>]{.lit} [file:]{.lit} [dst]{.arg} [owned]{.arg} [src]{.arg} [noCompress]{.optarg}
[<encoder>]{.lit} [write]{.lit} [archive]{.arg}
:::

# Beschreibung

Hinweis: Die Pakete „Trf“ und „zlibtcl“ sind für Tcl Version 8.6 oder höher nicht erforderlich. Dieses Paket stellt eine Klasse zur Erstellung von ZIP-Archiven bereit.

# API für Klassen

**::zipfile::encode** *objectName*
: Der Befehl „class“ erstellt Encoder-Instanzen, d. h. Objekte. Das Ergebnis des Befehls ist der vollqualifizierte Name des Instanzbefehls.

    Das Argument *objectName* ist erforderlich. Wenn *objectName* auf **%AUTO%** gesetzt ist, generiert die Klasse einen automatischen Namen im aktuellen Namespace und verwendet diesen. Ist der Wert von *objectName* nicht vollständig qualifiziert, wird der Befehl für die Instanz relativ zum aktuellen Namespace erstellt.


# Instanz-API

**<encoder>** **comment:** *text*
: Diese Methode legt den Text des globalen Kommentars für das Archiv fest. Das Ergebnis der Methode ist die leere Zeichenkette. Werden mehrere Aufrufe dieser Methode für denselben Encoder durchgeführt, haben die Daten des letzten Aufrufs Vorrang vor allen vorherigen Texten.

**<encoder>** **file:** *dst* *owned* *src* ?*noCompress*?
: Diese Methode fügt dem Archiv eine neue Datei hinzu. Der Inhalt der Datei befindet sich im Dateisystem unter *src* und wird im Archiv unter dem Pfad *dst* gespeichert. Wenn die Datei als *Eigentum* des Archivs deklariert ist, wird die Originaldatei beim Erstellen und Schreiben des Archivs gelöscht. Wenn *noCompress* auf **true** gesetzt ist, wird die Datei beim Schreiben nicht komprimiert. Andernfalls (Standardeinstellung) wird die Datei komprimiert, sofern dies vorteilhaft ist. Das Ergebnis der Methode ist eine leere Zeichenkette.

**<encoder>** **write** *archive*
: Diese Methode nimmt den globalen Kommentar und alle hinzugefügten Dateien, kodiert sie als Zip-Archiv und speichert das Ergebnis unter dem Pfad *archive* im Dateisystem. Alle hinzugefügten Dateien, die dem Archiv gehören, werden an dieser Stelle gelöscht. Zur Reihenfolge: Die Dateien werden dem Archiv in derselben Reihenfolge hinzugefügt, in der sie über **file:** angegeben wurden. *Hinweis:* Dieses Verhalten gilt ab Version 0.4. Vor 0.4 war keine bestimmte Reihenfolge dokumentiert. Sortiert wurde lexikografisch. Die Änderung unterstützt **zip**-basierte Dateiformate, die eine bestimmte Dateireihenfolge im Archiv verlangen, zum Beispiel "*.epub*".


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *zipfile* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dateien

# Copyright

```
Copyright (c) 2008-2009 Andreas Kupries
```
