---
CommandName: transfer::connect
title: transfer::connect
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - active
 - channel
 - connection
 - passive
 - secure
 - ssl
 - tls
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::connect – Einrichtung der Verbindung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::connect]{.lit} [0.3]{.optlit}
[transfer::connect]{.cmd} [objectName]{.arg} [options...]{.optarg}
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [connect]{.sub} [command]{.arg}
:::

# Beschreibung

Dieses Paket stellt Objekte bereit, die über ausreichende Informationen verfügen, um entweder aktiv eine Verbindung zu einem Gegenstück herzustellen oder passiv auf eine Verbindung von diesem Gegenstück zu warten. Das heißt, jedes durch dieses Paket erstellte Objekt befindet sich stets in einem von zwei sich ergänzenden Modi, die als *aktiv* (das Objekt initiiert die Verbindung) und *passiv* (das Objekt empfängt die Verbindung) bezeichnet werden.

Von den beiden Objekten in einem Verbindungspaar muss eines für den *aktiven* Modus konfiguriert werden, das andere muss dann für den *passiven* Modus konfiguriert werden. Dadurch wird festgelegt, welcher der beiden Partner eine Verbindung zu wem herstellt (der *aktive* zum anderen) bzw. wer auf wen wartet (der *passive* auf den anderen). Hinweis: Dies ist völlig unabhängig von der Richtung einer Datenübertragung über die Verbindung, nachdem diese hergestellt wurde. Ein aktives Objekt kann nach dem Aufbau der Verbindung entweder Daten senden oder empfangen. Ebenso kann das passive Objekt dasselbe tun, nachdem das Warten auf seinen Partner beendet ist.

# API

## Paketbefehle

**transfer::connect** *objectName* ?*options*...?
: Dieser Befehl erstellt ein neues Verbindungsobjekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten [Objektbefehl] und [Objektmethoden] ausführlich erläutert. Die unterstützten *options* werden im Abschnitt [Optionen] erläutert.

    Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace. Der vollständig qualifizierte Name des Objektbefehls wird als Ergebnis des Befehls zurückgegeben.


## Objektbefehl

Alle mit dem Befehl **::transfer::connect** erstellten Objekte haben die folgende allgemeine Form:

*objectName* **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt [Objektmethoden].


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt. Bei einem *aktiven* Objekt ist dies unbedenklich, sobald eine Verbindung hergestellt wurde, da die Rückruffunktion zur Fertigstellung synchron abläuft. Bei einem *passiven* Objekt, das derzeit darauf wartet, dass sein Partner die Verbindung herstellt, ist dies jedoch nicht sicher und führt später zu Fehlern, wenn der Verbindungsaufbau abgeschlossen ist und versucht wird, auf die nun fehlenden Datenstrukturen des zerstörten Objekts zuzugreifen.

*objectName* **connect** *command*
: Diese Methode leitet den Verbindungsaufbau gemäß der Konfiguration des Objekts ein. Wenn die Verbindung hergestellt ist, wird die Rückruffunktion *command* mit einem zusätzlichen Argument aufgerufen, nämlich dem Kanal-Handle des Sockets, über den Daten übertragen werden können.

    Das genaue Verhalten der Methode hängt vom konfigurierten Modus ab.

    *active*
    : Der Verbindungsaufbau erfolgt synchron. Das Objekt wartet, bis die Verbindung hergestellt ist. Die Methode gibt als Ergebnis die leere Zeichenkette zurück.

    *passive*
    : Der Verbindungsaufbau erfolgt asynchron. Die Methode gibt sofort zurück, sobald ein lauschenden Socket eingerichtet wurde. Die Verbindung wird im Hintergrund hergestellt. Die Methode gibt die Portnummer des lauschenden Sockets zurück, die vom Aufrufer verwendet werden kann. Eine wichtige Anwendung besteht darin, diese Information an die Gegenstelle weiterzugeben, damit diese weiß, mit welchem Port sie eine Verbindung herstellen muss.

        Dies ist notwendig, da das Objekt möglicherweise für den Port **0** konfiguriert wurde, wodurch das Betriebssystem den tatsächlichen Port auswählen kann, auf dem es auf Verbindungen wartet.

        Der Listening-Port wird sofort geschlossen, wenn die Verbindung durch die Gegenstelle hergestellt wurde, um das Zeitfenster zu minimieren, in dem sich auch Dritte mit dem Port verbinden könnten. Dennoch wird empfohlen, zusätzliche Maßnahmen im Protokoll außerhalb des „connect“- und „transfer“-Objekts zu ergreifen, um sicherzustellen, dass eine Verbindung nicht mit einem nicht identifizierten/nicht autorisierten Partner hergestellt wird. Eine Möglichkeit hierfür ist die Verwendung von SSL/TLS. Informationen dazu finden Sie unter der Option **-socketcmd** und im Abschnitt [Sichere Verbindungen].



## Optionen

Verbindungsobjekte unterstützen die nachfolgend aufgeführten Optionen.

**-mode** *mode*
: Diese Option legt den Modus fest, in dem sich das Objekt befindet. Sie ist optional und ist standardmäßig auf den Modus **active** eingestellt. Die beiden möglichen Modi sind:

    **active**
    : In diesem Modus sind die beiden Optionen **-host** und **-port** relevant und legen den Host sowie den TCP-Port fest, mit dem das Objekt eine Verbindung herstellen muss. Der Host wird entweder durch einen Namen oder eine IP-Adresse angegeben.

    **passive**
    : In diesem Modus ist die Option **-host** ohne Bedeutung und wird ignoriert, falls sie konfiguriert sein sollte. Die einzige Option, die das Objekt benötigt, ist **-port**; diese legt den TCP-Port fest, an dem der lauschenden Socket geöffnet wird, um auf die Verbindung vom Partner zu warten.


**-host** *hostname-or-ipaddr*
: Diese Option legt den Host fest, mit dem im *aktiven* Modus eine Verbindung hergestellt werden soll, entweder anhand des Namens oder der IP-Adresse. Ein für den *passiven* Modus konfiguriertes Objekt ignoriert diese Option.

**-port** *int*
: Im *aktiven* Modus legt diese Option den Port fest, mit dem das Objekt voraussichtlich eine Verbindung herstellen wird. Im *passiven* Modus hingegen handelt es sich um den Port, an dem das Objekt den lauschenden Socket erstellt, um auf eine Verbindung zu warten. Der Standardwert ist **0**, wodurch das Betriebssystem den tatsächlichen Port für den lauschenden Socket selbst auswählen kann.

**-socketcmd** *command*
: Mit dieser Option kann der Benutzer festlegen, welcher Befehl zum Öffnen eines Sockets verwendet werden soll. Standardmäßig wird der integrierte Befehl **::socket** verwendet. Jeder mit diesem Befehl kompatible Befehl ist zulässig.

    Die vorgesehene Hauptanwendung ist die Angabe von **tls::socket**. Das heißt, diese Option ermöglicht die Einrichtung sicherer Übertragungskanäle, ohne dass dieses Paket explizit vom Paket **tls** abhängig gemacht wird.

    Siehe auch den Abschnitt [Sichere Verbindungen].

**-encoding** encodingname
: siehe unten ...

**-eofchar** eofspec
: siehe unten ...

**-translation** transspec
: Diese Optionen entsprechen denen, die vom integrierten Befehl **fconfigure** erkannt werden. Sie legen die Konfiguration fest, die für den Kanal zwischen den beiden Partnern nach dessen Aufbau, jedoch vor dem Aufruf der Rückruffunktion, eingestellt werden soll (siehe Methode **connect**).


# Sichere Verbindungen

Eine Möglichkeit, die von Objekten dieses Pakets hergestellten Verbindungen zu sichern, besteht darin, das Paket **tls** vorzuschreiben und anschließend die Option **-socketcmd** so zu konfigurieren, dass die Verwendung des Befehls **tls::socket** zum Öffnen des Sockets erzwungen wird.

```
    # Load and initialize tls
    package require tls
    tls::init -cafile /path/to/ca/cert -keyfile ...

    # Create a connector with secure socket setup,
    transfer::connect C -socketcmd tls::socket ...
    ...
```

# TLS-Sicherheitshinweise

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *transfer* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Transfermodul

# Copyright

```
Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
