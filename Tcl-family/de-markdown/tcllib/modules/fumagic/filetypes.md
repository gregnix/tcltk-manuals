---
CommandName: fileutil::magic::filetype
title: fileutil::magic::filetype
ManualSection: n
Version: 2.0
TclPart: tcllib
TclDescription: file utilities
Links:
 - file(1)
 - fileutil
 - magic(5)
Keywords:
 - file recognition
 - file type
 - file utilities
 - type
Copyright:
---

# Name

fileutil::magic::filetype – Prozeduren, die die Erkennung von Dateitypen implementieren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [fileutil::magic::filetype]{.lit} [2.0]{.optlit}
[::fileutil::magic::filetype]{.cmd} [filename]{.arg}
:::

# Beschreibung

Dieses Paket enthält einen Befehl zur Erkennung von Dateitypen in reinem Tcl.

Der Kern des Erkenners wurde aus einer „magic(5)“-Datei erzeugt, die die Prüfungen zur Erkennung von Dateien und die zugehörigen Dateitypen enthält.

*Achtung!* Dieser Erkenner ist groß, etwa 752 Kilobyte erzeugter Tcl-Code.

**::fileutil::magic::filetype** *filename*
: Dieser Befehl ähnelt dem Befehl **fileutil::fileType**.

    Er gibt eine Liste zurück, darin eine Liste von Beschreibungen, eine Liste von mimetype-Bestandteilen und eine Liste von Dateiendungen. Er gibt die leere Zeichenkette zurück, wenn der Dateiinhalt nicht erkannt wird.


# Literatur

1. [File(1) sources](ftp://ftp.astron.com/pub/file/) Diese Seite enthält die aktuellen Quellen des Befehls file, einschließlich der magic-Definitionen, die er verwendet. Letztere wurden von uns verwendet, um diesen Erkenner zu erzeugen.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil :: magic* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge
