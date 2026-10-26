---
CommandName: doctools::cvs
title: doctools::cvs
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - http://wiki.tcl.tk/log2changelog
 - uri
Keywords:
 - changelog
 - cvs
 - cvs log
 - emacs
 - log
Copyright:
 - Copyright (c) 2003-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::cvs – Verarbeitung von Text im Format „cvs log“

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil]{.lit}
[package]{.cmd} [require]{.sub} [doctools::cvs]{.lit} [1.1]{.optlit}
[::doctools::cvs::scanLog]{.cmd} [text]{.arg} [evar]{.arg} [cvar]{.arg} [fvar]{.arg}
[::doctools::cvs::toChangeLog]{.cmd} [evar]{.arg} [cvar]{.arg} [fvar]{.arg}
:::

# Beschreibung

Dieses Paket enthält Tcl-Befehle zur Verarbeitung und Neuformatierung von Text in dem durch den Befehl **cvs log** erzeugten Format.

Die Befehle **::doctools::cvs::scanLog** und **::doctools::cvs::toChangeLog** stammen aus Code, der auf der Seite [Tcl'ers Wiki](http://wiki.tcl.tk) zu finden ist. Siehe die Literatur am Ende der Seite.

# API

**::doctools::cvs::scanLog** *text* *evar* *cvar* *fvar*
: Der Befehl nimmt den *text* entgegen und wertet ihn unter der Annahme aus, dass er ein von **cvs log** generiertes CVS-Protokoll enthält. Die daraus resultierenden Informationen werden in den Variablen gespeichert, deren Namen über *evar*, *cvar* und *fvar* festgelegt wurden.

    Bereits vorhandene Informationen in den referenzierten Variablen bleiben erhalten, sodass der Aufrufer Daten aus mehreren Protokollen in einer Datenbank zusammenführen kann.

    varname *evar* (in)
    : Muss sich auf eine skalare Variable beziehen. Nach dem Aufruf enthält diese Variable eine Liste aller Einträge, die in der Protokolldatei gefunden wurden. Ein Eintrag wird durch die Kombination aus Datum und Autor identifiziert und kann sich auf mehrere physische Einträge verteilen, wobei jeder Eintrag einer berührten Datei entspricht.

        Zu beachten ist, dass die Einträge in derselben Reihenfolge aufgelistet werden, in der sie im *text* gefunden wurden. Diese Reihenfolge ist nicht zwangsläufig nach Datum oder Autor sortiert.

        Jedes Element der Liste ist eine Liste, die zwei Elemente enthält: das Datum des Eintrags und dessen Autor, in dieser Reihenfolge. Das Datum ist im Format **year**/**month**/**day** formatiert.

    varname *cvar* (in)
    : Muss sich auf eine Array-Variable beziehen. Die Schlüssel sind Zeichenfolgen, die das Datum und den Autor der Protokolleinträge in dieser Reihenfolge enthalten und durch ein Komma getrennt sind.

        Die Werte sind Listen mit Kommentaren zu dem jeweiligen Eintrag.

    varname *fvar* (in)
    : Muss sich auf eine Array-Variable beziehen. Die Schlüssel sind Zeichenfolgen, die in dieser Reihenfolge das Datum, den Autor eines Protokolleintrags und einen Kommentar zu diesem Eintrag enthalten und durch Kommas getrennt sind.

        Die Werte sind Listen der Dateien, die der Eintrag berührt.


**::doctools::cvs::toChangeLog** *evar* *cvar* *fvar*
: Die drei Argumente für diesen Befehl entsprechen den letzten drei Argumenten des Befehls **::doctools::cvs::scanLog**. Dieser Befehl erwartet jedoch, dass diese mit Informationen zu einem oder mehreren Protokollen gefüllt sind. Er nimmt diese Informationen auf und wandelt sie in einen Text im Format eines ChangeLog um, wie er von **emacs** akzeptiert und generiert wird. Der erstellte Text wird als Ergebnis des Befehls zurückgegeben.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2003-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
