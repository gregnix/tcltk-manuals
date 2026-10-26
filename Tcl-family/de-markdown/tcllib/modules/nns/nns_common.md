---
CommandName: nameserv::common
title: nameserv::common
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::client(n)
 - nameserv::server(n)
Keywords:
 - client
 - name service
 - server
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nameserv::common – Namensdienst-Funktion, gemeinsame Definitionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [nameserv::common]{.lit} [0.2]{.optlit}
[::nameserv::common::port]{.cmd}
:::

# Beschreibung

Bitte lesen Sie zunächst *Namensdienst-Funktion, Einleitung*.

Dieses Paket ist intern und für Benutzer nicht von Interesse. Es stellt die Befehle der Namensdienstfunktion bereit, die sowohl vom Client als auch vom Server genutzt werden und durch die Pakete **nameserv::server** und **nameserv** (der Client) implementiert werden.

Dieser Dienst wurde auf der Grundlage des Pakets **comm** entwickelt und ist für dieses bestimmt. Er hat nichts mit dem Domain Name System des Internets zu tun. Wenn Sie nach einem Paket suchen, das sich damit befasst, sehen Sie sich bitte die Tcllib-Pakete **dns** und **resolv** an.

# API

Das Paket exportiert einen einzigen Befehl, wie im Folgenden festgelegt:

**::nameserv::common::port**
: Das vom Befehl zurückgegebene Ergebnis ist die Kennung des Standard-TCP/IP-Ports, auf dem ein Namensdienstserver auf eingehende Verbindungen wartet und zu dem ein Namensdienst-Client eine Verbindung herzustellen versucht.


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
