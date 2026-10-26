---
CommandName: nameserv::auto
title: nameserv::auto
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv(n)
Keywords:
 - automatic
 - client
 - name service
 - reconnect
 - restore
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nameserv::auto – Namensdienst-Funktion, Client-Erweiterung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [nameserv::auto]{.lit} [0.4]{.optlit}
[package]{.cmd} [require]{.sub} [nameserv]{.lit}
:::

# Beschreibung

Zuerst ist das Dokument *Namensdienst-Funktion, Einleitung* zu lesen.

Dieses Paket stellt genau dieselbe API bereit wie das Paket **nameserv**, d. h. den regulären Namensdienst-Client. Es unterscheidet sich von diesem dadurch, dass es Maßnahmen ergreift, um sicherzustellen, dass länger gültige Daten – d. h. gebundene Namen sowie laufende und noch nicht abgeschlossene asynchrone Suchvorgänge – den Verlust der Verbindung zum Namensserver so weit wie möglich überstehen.

Das bedeutet, dass die gebundenen Namen sowie laufende und noch nicht abgeschlossene asynchrone Suchvorgänge clientseitig gespeichert und automatisch wieder an den Server übermittelt werden, wenn die Verbindung nach einem Verbindungsabbruch wiederhergestellt ist. Bei gebundenen Namen gibt es eine wichtige Einschränkung hinsichtlich einer solchen Wiederherstellung: Es ist möglich, dass ein Name dieses Clients während des Verbindungsabbruchs von einem anderen Client gebunden wurde. Solche Namen gehen vollständig verloren, und das Paket kann und wird den Nutzer bestenfalls darüber informieren.

# API

Die für den Benutzer sichtbare API entspricht im Wesentlichen der API von **nameserv** und wird daher an dieser Stelle nicht näher beschrieben. Bitte lesen Sie die Dokumentation zu **nameserv**.

Die Unterschiede werden im Folgenden in den Abschnitten [Optionen] und [Ereignisse] erläutert.

# Optionen

Dieses Paket unterstützt alle Optionen des Pakets **nameserv** sowie eine weitere Option. Mit dieser zusätzlichen Option kann der Benutzer das Zeitintervall festlegen, in dem versucht wird, eine unterbrochene Verbindung wiederherzustellen.

**-delay** *milliseconds*
: Der Wert dieser Option ist eine ganze Zahl größer als 0, die das Intervall in Millisekunden festlegt, das zwischen den Versuchen zur Wiederherstellung einer unterbrochenen Verbindung gewartet werden soll. Der Standardwert lautet **1000**, d. h. eine Sekunde.


# Ereignisse

Dieses Paket generiert alle Ereignisse des Pakets **nameserv** sowie zwei weitere. Beide Ereignisse werden für das Tag *nameserv* generiert.

*lost-name*
: Dieses Ereignis wird ausgelöst, wenn ein gebundener Name tatsächlich verloren gegangen ist, d. h. nach dem vorübergehenden Verlust der Verbindung zum Namensserver nicht wiederhergestellt werden konnte. Es weist darauf hin, dass ein anderer Client die Kontrolle über den Namen übernommen hat, während dieser Client nicht erreichbar war.

    Die Detailinformationen des Ereignisses bestehen aus einem Tcl-Dictionary, das zwei Schlüssel enthält: **name** und **data**. Ihre Werte enthalten alle Informationen über den verlorenen Namen.

*re-connection*
: Dieses Ereignis wird ausgelöst, wenn die Verbindung zum Server wiederhergestellt ist. Die gespeicherten Daten wurden zum Zeitpunkt der Auslösung des Ereignisses wiederhergestellt.

    Das Ereignis enthält keine Detailinformationen.


# Design

Das Paket wird auf Basis des regulären Nameservice-Clients, d. h. des Pakets **nameserv**, implementiert. Es erkennt den Verbindungsverlust, indem es auf *lost-connection*-Ereignisse am Tag *nameserv* überwacht.

Es reagiert auf solche Ereignisse, indem es einen periodischen Timer startet und versucht, die Verbindung zum Server wiederherzustellen, sobald dieser Timer ausgelöst wird. Bei Erfolg wird der Timer abgebrochen, ein *re-connection*-Ereignis generiert, und das Paket gibt die gespeicherten gebundenen Namen und die kontinuierlichen Suchvorgänge erneut ein.

Ein weiterer Abbruch der Verbindung – sei es während oder nach der erneuten Eingabe der gespeicherten Informationen – führt lediglich dazu, dass der Timer neu gestartet wird und weitere Verbindungsversuche unternommen werden.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *nameserv* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
