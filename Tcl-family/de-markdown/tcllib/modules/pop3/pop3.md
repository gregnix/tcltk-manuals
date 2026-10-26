---
CommandName: pop3
title: pop3
ManualSection: n
Version: 1.11
TclPart: tcllib
TclDescription: Tcl POP3 Client Library
Keywords:
 - email
 - mail
 - pop
 - pop3
 - rfc 1939
 - secure
 - ssl
 - tls
Copyright:
---

# Name

pop3 – Tcl-Client für das POP3-E-Mail-Protokoll

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pop3]{.lit} [1.11]{.optlit}
[::pop3::open]{.cmd} [[-msex]{.lit} 0|1]{.optarg} [[-retr-mode]{.lit} retr|list|slow]{.optarg} [[-socketcmd]{.lit} cmdprefix]{.optarg} [[-stls]{.lit} 0|1]{.optarg} [[-tls-callback]{.lit} stls-callback-command]{.optarg} [host]{.arg} [username]{.arg} [password]{.arg} [port]{.optarg}
[::pop3::config]{.cmd} [chan]{.arg}
[::pop3::status]{.cmd} [chan]{.arg}
[::pop3::last]{.cmd} [chan]{.arg}
[::pop3::retrieve]{.cmd} [chan]{.arg} [startIndex]{.arg} [endIndex]{.optarg}
[::pop3::delete]{.cmd} [chan]{.arg} [startIndex]{.arg} [endIndex]{.optarg}
[::pop3::list]{.cmd} [chan]{.arg} [msg]{.optarg}
[::pop3::top]{.cmd} [chan]{.arg} [msg]{.arg} [n]{.arg}
[::pop3::uidl]{.cmd} [chan]{.arg} [msg]{.optarg}
[::pop3::capa]{.cmd} [chan]{.arg}
[::pop3::close]{.cmd} [chan]{.arg}
:::

# Beschreibung

Das Paket **pop3** stellt eine einfache, ausschließlich auf Tcl basierende Client-Bibliothek für das POP3-E-Mail-Protokoll bereit, wie es in [RFC 1939](http://www.rfc-editor.org/rfc/rfc1939.txt) festgelegt ist. Es öffnet den üblichen POP3-Socket auf dem Server, übermittelt Benutzername und Passwort und stellt dann eine Tcl-API für die POP3-Protokollbefehle bereit. Alle Serverfehler werden als Tcl-Fehler zurückgegeben (ausgelöst) und müssen mit dem Tcl-Befehl **catch** abgefangen werden.

# TLS-Sicherheitshinweise

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# API

**::pop3::open** ?**-msex** 0|1? ?**-retr-mode** retr|list|slow? ?**-socketcmd** cmdprefix? ?**-stls** 0|1? ?**-tls-callback** stls-callback-command? *host username password* ?*port*?
: Öffnet eine Socket-Verbindung zu dem durch *host* angegebenen Server und übermittelt *username* und *password* als Anmeldedaten an den Server. Die vorgegebene Portnummer ist **110** und lässt sich mit dem optionalen Argument *port* ändern. Der Rückgabewert ist ein Kanal, den alle anderen ::pop3-Funktionen verwenden.

    Der Befehl erkennt fünf Optionen

    **-msex** boolean
    : Diese Option teilt dem Paket mit, dass der Server ein MS-Exchange-Server ist (mit einigen Eigenheiten, die zu umgehen sind). Die Vorgabe ist **False**.

    **-retr-mode** retr|list|slow
    : Der Abrufmodus legt fest, wie genau Nachrichten vom Server gelesen werden. Die zulässigen Werte sind **retr**, **list** und **slow**. Die Standardeinstellung ist **retr**. Weitere Informationen finden Sie unter **::pop3::retrieve**.

    **-socketcmd** cmdprefix
    : Diese Option ermöglicht es dem Benutzer, die Verwendung des integrierten Befehls **socket** durch einen beliebigen API-kompatiblen Befehl zu überschreiben. Der vorgesehene Hauptzweck besteht darin, die neue Verbindung über SSL zu sichern, indem der Befehl **tls::socket** angegeben wird. Dieser Befehl wird ebenfalls speziell erkannt und ändert den Standardport der Verbindung auf **995**.

    **-stls** boolean
    : Diese Option weist das Paket an, die Verbindung mit SSL oder TLS zu sichern. Sie führt STARTTLS aus, wie in IETF RFC 2595 beschrieben: zuerst eine normale, unverschlüsselte Verbindung, dann die Aushandlung einer SSLv3- oder TLSv1-Verbindung. Lässt sich die Verbindung nicht sichern, wird sie geschlossen und ein Fehler zurückgegeben.

    **-tls-callback** stls-callback-command
    : Mit dieser Option lässt sich der **tls::callback** überschreiben, der beim SSL/TLS-Handshake von **-stls** verwendet wird. Zur Umsetzung dieser Rückruffunktion siehe das TLS-Handbuch.


**::pop3::config** *chan*
: Gibt die Konfiguration der POP3-Verbindung, die durch das Kanal-Handle *chan* identifiziert wird, als serialisiertes Array zurück.

**::pop3::status** *chan*
: Fragt den Server nach dem Status des Mail-Spools. Der Status kommt als Liste mit zwei Elementen zurück. Das erste ist die Anzahl der E-Mail-Nachrichten auf dem Server, das zweite die Größe (in Oktetten, Blöcken zu 8 Bit) des gesamten Mail-Spools.

**::pop3::last** *chan*
: Fragt den Server nach der zuletzt aus dem Spool gelesenen E-Mail. Der Wert umfasst alle Nachrichten, die irgendein Client des Anmeldekontos gelesen hat. Der E-Mail-Server muss den Befehl nicht unterstützen; dann gibt er möglicherweise 0 oder einen Fehler zurück.

**::pop3::retrieve** *chan startIndex* ?*endIndex*?
: Ruft einen Bereich von Nachrichten vom Server ab. Ist *endIndex* nicht angegeben, wird nur eine Nachricht abgerufen. Der Rückgabewert ist eine Liste, die jede Nachricht als eigenes Element enthält. Zu *startIndex* und *endIndex* siehe unten.

    Der Abrufmodus legt fest, wie die Nachrichten vom Server gelesen werden. Der Modus **retr** nimmt an, dass der Befehl RETR die Größe der Nachricht als Teil des Befehlsstatus liefert, und nutzt das, um die Nachricht effizient zu lesen. Im Modus **list** liefert RETR die Größe nicht, der Befehl LIST aber schon; damit wird die Nachrichtengröße vor dem eigentlichen Abruf geholt, der dann effizient erfolgen kann. Im letzten Modus, **slow**, lässt sich die Größe der Nachricht auf keine Weise ermitteln, und die Nachricht wird Zeile für Zeile vom Server gelesen.

    Das System prüft den konfigurierten Modus und fällt auf die langsameren Modi zurück, wenn die genannten Annahmen nicht zutreffen.

**::pop3::delete** *chan startIndex* ?*endIndex*?
: Löscht einen Bereich von Nachrichten auf dem Server. Ist *endIndex* nicht angegeben, wird nur eine Nachricht gelöscht. Die Indizes werden auf dem Server nicht neu geordnet. Wird Nachricht 1 gelöscht, ist die erste Nachricht in der Warteschlange Nachricht 2 (der Nachrichtenindex 1 ist nicht mehr gültig). Zu *startIndex* und *endIndex* siehe unten.

    *startIndex*
    : Der *startIndex* kann entweder ein Index einer bestimmten Nachricht sein, beginnend mit dem Index 1, oder einen der folgenden Werte annehmen:

        **start**
        : Dies ist ein logischer Wert für die erste Nachricht im Spool, der dem Wert 1 entspricht.

        **next**
        : Die Nachricht unmittelbar nach der zuletzt gelesenen Nachricht, siehe **::pop3::last**.

        **end**
        : Die neueste Nachricht im Spool (das Ende des Spools). Damit lässt sich nur die neueste Nachricht abrufen.


    *endIndex*
    : Der Parameter *endIndex* ist optional und hat standardmäßig den Wert „-1“, was bedeutet, dass nur die durch *startIndex* angegebene Nachricht abgerufen wird. Sofern er angegeben wird, kann es sich um den Index einer bestimmten Nachricht handeln, beginnend mit dem Index „1“, oder er kann einen der folgenden Werte annehmen:

        **last**
        : Bei dieser Nachricht handelt es sich um die zuletzt von einem POP3-Client gelesene Nachricht; siehe **::pop3::last**.

        **end**
        : Die neueste Nachricht im Spool (das Ende des Spools).



**::pop3::list** *chan* ?*msg*?
: Gibt die Scan-Auflistung des Postfachs zurück. Wenn der Parameter *msg* angegeben ist, wird nur die Auflistung für diese Nachricht zurückgegeben.

**::pop3::top** *chan* *msg* *n*
: Optionaler POP3-Befehl, den nicht alle Server unterstützen. **::pop3::top** holt die Kopfzeilen der durch *msg* angegebenen Nachricht und *n* Zeilen aus dem Nachrichtentext.

**::pop3::uidl** *chan* ?*msg*?
: Optionaler POP3-Befehl, den nicht alle Server unterstützen. **::pop3::uidl** gibt das UID-Listing des Postfachs zurück. Ist *msg* angegeben, kommt nur das Listing dieser Nachricht zurück.

**::pop3::capa** *chan*
: Optionaler POP3-Befehl, den nicht alle Server unterstützen. **::pop3::capa** gibt eine Liste der Fähigkeiten des Servers zurück. TOP, SASL, UIDL, LOGIN-DELAY und STLS sind typische Fähigkeiten. Siehe IETF RFC 2449.

**::pop3::close** *chan*
: Schließt die Verbindung geordnet, nachdem ein POP3-Befehl QUIT über den Socket gesendet wurde.


# Sichere Mail-Übertragung

Eine POP3-Verbindung lässt sich mit SSL/TLS sichern, indem das Paket **TLS** vorausgesetzt wird und dann entweder die Option **-socketcmd** oder die Option **-stls** des Befehls **pop3::open** zum Einsatz kommt. Die erste Methode, die Option **-socketcmd**, erzwingt beim Öffnen der Verbindung den Befehl **tls::socket**. Das passt zu POP3-Servern, die nur SSL-Verbindungen erwarten. Sie lauschen in der Regel auf Port 995.

```
	package require tls
	tls::init -cafile /path/to/ca/cert -keyfile ...

	# Create secured pop3 channel
	pop3::open -socketcmd tls::socket \
		$thehost $theuser $thepassword

	...
```

Die zweite Methode, die Option **-stls**, verbindet sich mit dem üblichen POP3-Port und führt dann einen STARTTLS-Handshake aus. Das funktioniert nur bei POP3-Servern mit dieser Fähigkeit. Das Paket bestätigt, dass der Server STARTTLS unterstützt und der Handshake korrekt ausgeführt wurde, bevor die Authentifizierung folgt.

```
	package require tls
	tls::init -cafile /path/to/ca/cert -keyfile ...

	# Create secured pop3 channel
	pop3::open -stls 1 \
		$thehost $theuser $thepassword

	...
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pop3* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk
