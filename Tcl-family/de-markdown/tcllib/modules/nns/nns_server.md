---
CommandName: nameserv::server
title: nameserv::server
ManualSection: n
Version: 0.3.3
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::client(n)
 - nameserv::common(n)
Keywords:
 - name service
 - server
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nameserv::server – Namensdienst-Funktion, Server

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [nameserv::server]{.lit} [0.3.3]{.optlit}
[package]{.cmd} [require]{.sub} [comm]{.lit}
[package]{.cmd} [require]{.sub} [interp]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[::nameserv::server::start]{.cmd}
[::nameserv::server::stop]{.cmd}
[::nameserv::server::active?]{.cmd}
[::nameserv::server::cget]{.cmd} [-option]{.lit}
[::nameserv::server::configure]{.cmd}
[::nameserv::server::configure]{.cmd} [-option]{.lit}
[::nameserv::server::configure]{.cmd} [-option]{.lit} [value...]{.arg}
:::

# Beschreibung

Bitte lesen Sie zunächst *Namensdienst-Funktion, Einleitung*.

Dieses Paket enthält eine Implementierung der serverseitigen Komponente der Namensdienstfunktion, die vom Client abgefragt wird, der im Paket **nameserv** bereitgestellt wird. Alle vom Server benötigten Informationen werden im Arbeitsspeicher gehalten. Es gibt keinen persistenten Zustand.

Dieser Dienst wurde auf der Grundlage des Pakets **comm** entwickelt und ist für dieses bestimmt. Er hat nichts mit dem Domain Name System des Internets zu tun. Wenn Sie nach einem Paket suchen, das sich damit befasst, sehen Sie sich bitte die Tcllib-Pakete **dns** und **resolv** an.

Dieser Server unterstützt die Protokollfunktion *Core* sowie seit Version 0.3 auch die Funktion *Search/Continuous*.

# API

Das Paket exportiert fünf Befehle, wie im Folgenden angegeben:

**::nameserv::server::start**
: Dieser Befehl startet den Server und sorgt dafür, dass er auf dem konfigurierten Port auf eingehende Verbindungen wartet. Von nun an können Clients eine Verbindung herstellen und Anfragen senden. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Hinweis: Eingehende Anfragen werden nur dann bearbeitet, wenn die Anwendung, zu der der Server gehört, nach Ausführung dieses Befehls tatsächlich in eine Ereignisschleife wechselt.

**::nameserv::server::stop**
: Durch die Ausführung dieses Befehls wird der Server angehalten und alle darin gespeicherten Daten werden freigegeben. Bestehende Verbindungen werden beendet, und es werden keine neuen Verbindungen mehr angenommen. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::nameserv::server::active?**
: Dieser Befehl gibt einen booleschen Wert zurück, der den Status des Servers angibt. Das Ergebnis lautet **true**, wenn der Server aktiv ist, d. h. gestartet wurde, und andernfalls **false**.

**::nameserv::server::cget** **-option**
: Dieser Befehl gibt den aktuell konfigurierten Wert für das angegebene **-option** zurück. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt [Optionen].

**::nameserv::server::configure**
: In dieser Form gibt der Befehl ein Dictionary mit allen unterstützten Optionen und deren aktuellen Werten zurück. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt [Optionen].

**::nameserv::server::configure** **-option**
: In dieser Form ist der Befehl ein Alias für „**::nameserv::server::cget** **-option**“. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt [Optionen].

**::nameserv::server::configure** **-option** *value*...
: In dieser Form dient der Befehl dazu, eine oder mehrere der unterstützten Optionen zu konfigurieren. Es muss mindestens eine Option angegeben werden, und auf jede Option folgt ihr neuer Wert. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt [Optionen].

    Diese Form kann nur verwendet werden, wenn der Server nicht aktiv ist, d. h. noch nicht gestartet wurde oder bereits gestoppt wurde. Solange der Server aktiv ist, kann er nicht neu konfiguriert werden.


# Optionen

Die vom Server unterstützten Optionen dienen der Festlegung des TCP-Ports, auf dem der Server auf Verbindungen wartet, sowie der Einstellung, ob nicht-lokale Verbindungen akzeptiert werden sollen oder nicht. Es handelt sich um folgende Optionen:

**-localonly** *bool*
: Diese Option legt fest, ob nur lokale Verbindungen (-localonly 1) oder auch Remote-Verbindungen (-localonly 0) akzeptiert werden sollen. Standardmäßig werden nur lokale Verbindungen akzeptiert.

**-port** *number*
: Diese Option legt den Port fest, auf dem der Namensdienst nach seinem Start auf eingehende Verbindungen wartet. Es muss sich um eine positive ganze Zahl (> 0) handeln, die nicht größer als 65536 (unsigned short) ist. Der anfängliche Standardwert ist die Zahl, die vom Befehl **::nameserv::server::common::port** zurückgegeben wird, wie sie vom Paket **::nameserv::server::common** bereitgestellt wird.


# Geschichte

0.3
: Der Server wurde um die Möglichkeit erweitert, asynchrone und kontinuierliche Suchvorgänge durchzuführen.

0.2
: Der Name des Schalters „-local“ wurde in „-localonly“ geändert.

0.1
: Erste Implementierung des Servers.


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
