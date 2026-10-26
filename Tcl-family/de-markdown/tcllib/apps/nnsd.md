---
CommandName: nnsd
title: nnsd
ManualSection: n
Version: 1.0.1
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::common(n)
 - nameserv::server(n)
Keywords:
 - application
 - name service
 - server
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nnsd – Name Service Facility, Serveranwendung für die Befehlszeile

# Übersicht

::: {.synopsis} :::
[nnsd]{.cmd} [[-localonly]{.lit} [flag]{.arg}]{.optarg} [[-port]{.lit} [port]{.arg}]{.optarg}
:::

# Beschreibung

Bitte lesen Sie zunächst *Namensdienst-Funktion, Einleitung*.

Die in diesem Dokument beschriebene Anwendung „[nns]“ ist ein einfacher Befehlszeilenserver für die Nano-Namensdienstfunktion, die von den Tcllib-Paketen „**nameserv**“ und „**nameserv::server**“ bereitgestellt wird. Darüber hinaus dienen die Quellcodes der Anwendung auch als Beispiele für die Verwendung des Serverpakets **nameserv::server**.

Diese Namensdienstfunktion hat nichts mit dem *Domain Name System* des Internets zu tun, das auch als *DNS* bekannt ist. Wenn Sie nach einem Paket suchen, das sich damit befasst, sehen Sie sich bitte eines der Pakete **dns** oder **resolv** an, die beide ebenfalls in Tcllib zu finden sind.

## Anwendungsfälle

**nnsd** wurde unter Berücksichtigung des folgenden Hauptanwendungsfalls entwickelt.

1. Einen Nano-Namensdienst auf einem beliebigen Host ausführen.


## Befehlszeile

**nnsd** ?**-localonly** *flag*? ?**-port** *port*?
: Der Befehl konfiguriert einen Server gemäß den angegebenen Optionen und startet ihn. Der Befehl beendet sich nicht von selbst, da er die Namensdienst-Datenbank vollständig im Arbeitsspeicher hält. Der Benutzer muss ihn explizit beenden, entweder durch Senden eines Signals oder über die Job-Steuerungsfunktionen der verwendeten Shell.

    Die Optionen zur Konfiguration des Namensdienstes werden im Abschnitt [Optionen] erläutert.


## Optionen

In diesem Abschnitt werden alle Optionen beschrieben, die dem Benutzer der Anwendung zur Verfügung stehen

**-localonly** bool
: Wenn diese Option nicht festgelegt wird, gilt standardmäßig die Einstellung **true**, d. h., es werden nur lokale Verbindungen akzeptiert. Der Server akzeptiert Fernverbindungen, d. h. Verbindungen von anderen Hosts, genau dann, wenn diese Option auf **false** konfiguriert ist.

**-port** number
: Wenn diese Option nicht angegeben wird, wird standardmäßig „**38573**“ verwendet. Sie legt den TCP-Port fest, auf dem der Server auf Anfragen warten soll.


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


[nns]: nns.md
