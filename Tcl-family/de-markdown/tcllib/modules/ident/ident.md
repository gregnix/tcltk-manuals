---
CommandName: ident
title: ident
ManualSection: n
Version: 0.44
TclPart: tcllib
TclDescription: Identification protocol client
Keywords:
 - ident
 - identification
 - rfc 1413
Copyright:
 - Copyright (c) 2004 Reinhard Max <max@tclers.tk>
---

# Name

ident – Ident-Protokoll-Client

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ident]{.lit} [0.44]{.optlit}
[::ident::query]{.cmd} [socket]{.arg} [callback]{.optarg}
:::

# Beschreibung

Das Paket **ident** enthält eine Client-Implementierung des ident-Protokolls, wie es in RFC 1413 (<http://www.rfc-editor.org/rfc/rfc1413.txt>) definiert ist.

**::ident::query** *socket* ?*callback*?
: Dieser Befehl fragt den Ident-Daemon auf der Gegenstelle des angegebenen Sockets ab und gibt das Ergebnis der Abfrage als Dictionary zurück. Wenn Sie das Dictionary als Liste interpretieren, lautet der erste Schlüssel stets **resp-type** und kann einen der Werte **USERID**, **ERROR** und **FATAL** annehmen. Diese *Antworttypen* haben folgende Bedeutungen:

    USERID
    : Dies weist auf eine erfolgreiche Antwort hin. Es werden zwei weitere Schlüssel mit den zugehörigen Werten zurückgegeben: **opsys** und **user-id**.

    ERROR
    : Dies bedeutet, dass der Ident-Server einen Fehler zurückgegeben hat. Ein zweiter Schlüssel namens **error** ist vorhanden; sein Wert enthält das Feld **error-type** aus der Serverantwort.

    FATAL
    : Schwerwiegende Fehler treten auf, wenn auf der Gegenstelle kein Ident-Server lauscht oder wenn der Ident-Server eine Antwort gibt, die nicht dem RFC entspricht. Eine detaillierte Fehlermeldung wird unter dem Schlüssel **error** zurückgegeben.



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ident* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2004 Reinhard Max <max@tclers.tk>
```
