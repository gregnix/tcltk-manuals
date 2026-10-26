---
CommandName: nnslog
title: nnslog
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv(n)
 - nameserv::common(n)
Keywords:
 - application
 - client
 - name service
Copyright:
 - Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nnslog – Name Service Facility, Client-Anwendung zur Protokollierung über die Befehlszeile

# Übersicht

::: {.synopsis} :::
[nnslog]{.cmd} [[-host]{.lit} [host]{.arg}]{.optarg} [[-port]{.lit} [port]{.arg}]{.optarg}
:::

# Beschreibung

Bitte lesen Sie zunächst *Namensdienst-Funktion, Einleitung*.

Die in diesem Dokument beschriebene Anwendung, **nnslog**, ist ein einfacher Befehlszeilen-Client für die Nano-Namensdienstfunktion, die von den Tcllib-Paketen **nameserv** und **nameserv::server** bereitgestellt wird.

Im Wesentlichen wird damit „[nns] search -continuous \*“ umgesetzt, allerdings mit einer anderen Ausgabeformatierung. Anstatt den aktuellen Inhalt des Servers fortlaufend im Terminal anzuzeigen, protokolliert es lediglich alle empfangenen Hinzufügungs- und Entfernungsereignisse in der Datei „**stdout**“.

Diese Namensdienstfunktion hat nichts mit dem *Domain Name System* des Internets zu tun, das auch als *DNS* bekannt ist. Wenn Sie nach einem Paket suchen, das sich damit befasst, sehen Sie sich bitte eines der Pakete **dns** oder **resolv** an, die beide ebenfalls in Tcllib zu finden sind.

## Anwendungsfälle

**nnslog** wurde unter Berücksichtigung des folgenden Hauptanwendungsfalls entwickelt.

1. Überwachung des Namensdienstes auf alle Änderungen und Protokollierung dieser Änderungen in einem Textterminal.


## Befehlszeile

**nnslog** ?**-host** *host*? ?**-port** *port*?
: Der Befehl stellt eine Verbindung zum angegebenen Namensdienst her, richtet eine Suche nach allen Änderungen ein und gibt anschließend alle empfangenen Ereignisse auf der Standardausgabe aus, wobei jedes Ereignis in einer eigenen Zeile steht. Der Befehl wird erst beendet, wenn er vom Benutzer explizit beendet wird. Er übersteht insbesondere den Verlust der Verbindung zum Namensdienst und nimmt die Suche sowie die Protokollierung wieder auf, sobald die Verbindung wiederhergestellt ist.

    Die Optionen zur Angabe des Namensdienstes werden später im Abschnitt [Optionen] erläutert.


## Optionen

In diesem Abschnitt werden alle Optionen beschrieben, die dem Benutzer der Anwendung zur Verfügung stehen

**-host** name|ipaddress
: Wenn diese Option nicht angegeben wird, wird standardmäßig „**localhost**“ verwendet. Sie legt den Namen oder die IP-Adresse des Hosts fest, auf dem der anzusprechende Namensdienst ausgeführt wird.

**-port** number
: Wenn diese Option nicht angegeben wird, wird standardmäßig „**38573**“ verwendet. Sie legt den TCP-Port fest, auf dem der anzufragende Namensdienst auf Anfragen wartet.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *nameserv* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[nns]: nns.md
