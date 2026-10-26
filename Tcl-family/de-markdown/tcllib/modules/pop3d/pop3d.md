---
CommandName: pop3d
ManualSection: n
Version: 1.2.0
TclPart: tcllib
TclDescription: Tcl POP3 Server Package
Keywords:
 - internet
 - network
 - pop3
 - protocol
 - rfc 1939
 - secure
 - ssl
 - tls
Copyright:
 - Copyright (c) 2002-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2005 Reinhard Max <max@suse.de>
---

# NAME

pop3d – Implementierung eines Tcl-POP3-Servers

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pop3d]{.lit} [1.2.0]{.optlit} 
[::pop3d::new]{.cmd} [serverName]{.optarg} 
[serverName]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[serverName]{.ins} [up]{.sub} 
[serverName]{.ins} [down]{.sub} 
[serverName]{.ins} [destroy]{.sub} [mode]{.optarg} 
[serverName]{.ins} [configure]{.sub} 
[serverName]{.ins} [configure]{.sub} [-option]{.arg} 
[serverName]{.ins} [configure]{.sub} [-option]{.arg} [value...]{.arg} 
[serverName]{.ins} [cget]{.sub} [-option]{.arg} 
[serverName]{.ins} [conn]{.sub} list 
[serverName]{.ins} [conn]{.sub} state [id]{.arg} 
[authCmd]{.ins} [exists]{.sub} [name]{.arg} 
[authCmd]{.ins} [lookup]{.sub} [name]{.arg} 
[storageCmd]{.ins} [dele]{.sub} [mbox]{.arg} [msgList]{.arg} 
[storageCmd]{.ins} [lock]{.sub} [mbox]{.arg} 
[storageCmd]{.ins} [unlock]{.sub} [mbox]{.arg} 
[storageCmd]{.ins} [size]{.sub} [mbox]{.arg} [msgId]{.optarg} 
[storageCmd]{.ins} [stat]{.sub} [mbox]{.arg} 
[storageCmd]{.ins} [get]{.sub} [mbox]{.arg} [msgId]{.arg} 
:::

# BESCHREIBUNG

**::pop3d::new** ?*serverName*?
: Dieser Befehl erstellt ein neues Serverobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *serverName* lautet. Mit dem Befehl **serverName** können verschiedene Operationen auf dem Server aufgerufen werden. Er hat die folgende allgemeine Form:

**serverName** *option* ?*arg arg ...*?
: *Option* und die *arg*s legen das genaue Verhalten des Befehls fest. Ein POP3-Server kann auf jedem Port gestartet werden, für den der Aufrufer vom Betriebssystem die Berechtigung hat. Der Standardport ist 110, der Port aus dem in RFC 1939 (*http://www.rfc-editor.org/rfc/rfc1939.txt*) festgelegten Standard. Nach dem Erzeugen, Konfigurieren und Starten lauscht das Server-Objekt auf diesem Port, nimmt Verbindungen an und verarbeitet sie gemäß dem POP3-Protokoll. *Hinweis:* Der von diesem Modul bereitgestellte Server verarbeitet von sich aus nur das Basisprotokoll. Für die höheren Ebenen der Benutzerauthentifizierung und die Verarbeitung der eigentlichen Postfachinhalte werden Rückruffunktionen aufgerufen. Für Server-Objekte sind diese Befehle möglich:

*serverName* **up**
: Nach diesem Aufruf wartet der Server auf Verbindungen an seinem konfigurierten Port.

*serverName* **down**
: Nach diesem Aufruf wird der Server keine Verbindungen mehr annehmen. Bestehende Verbindungen sind davon nicht betroffen.

*serverName* **destroy** ?*mode*?
: Zerstört das Server-Objekt. Derzeit offene Verbindungen werden je nach gewähltem Modus behandelt. Die vorgesehenen Werte für *mode* sind:


**kill**
: Zerstört den Server sofort und schließt alle derzeit offenen Verbindungen zwangsweise. Das ist der Standardmodus.

**defer**
: Nimmt keine neuen Verbindungen mehr an und zerstört den Server erst, wenn die letzte der derzeit offenen Verbindungen geschlossen wurde.


*serverName* **configure**
: Gibt eine Liste zurück, die alle Optionen und deren aktuelle Werte in einem Format enthält, das für die Verwendung durch den Befehl **array set** geeignet ist. Die Optionen selbst werden im Abschnitt **OPTIONEN** beschrieben.

*serverName* **configure** *-option*
: Gibt den aktuellen Wert der angegebenen Option zurück. Dies ist ein Alias für die Methode **cget**. Die Optionen selbst werden im Abschnitt **OPTIONEN** beschrieben.

*serverName* **configure** *-option value*...
: Setzt die angegebene Option auf den angegebenen Wert. Die Optionen selbst werden im Abschnitt **OPTIONEN** beschrieben.

*serverName* **cget** *-option*
: Gibt den aktuellen Wert der angegebenen Option zurück. Die Optionen selbst werden im Abschnitt **OPTIONEN** beschrieben.

*serverName* **conn** list
: Gibt eine Liste mit den Kennungen aller derzeit offenen Verbindungen zurück.

*serverName* **conn** state *id*
: Gibt eine für \[**array set**\] geeignete Liste zurück, die den Status der Verbindung enthält, auf die *id* verweist.


# OPTIONEN

Für POP3-Serverobjekte stehen die folgenden Optionen zur Verfügung.

**-port** *port*
: Legt den *port* fest, auf dem nach neuen Verbindungen gelauscht wird. Voreinstellung ist 110. Diese Option ist etwas Besonderes. Ist *port* auf „0“ gesetzt, wählt der Server, genauer das Betriebssystem, selbst einen freien Port. Eine Abfrage von **-port** gibt die Kennung dieses gewählten Ports zurück. Eine Änderung des Ports bei laufendem Server ändert weder den zurückgegebenen Wert noch den Port, auf dem der Server lauscht. Erst nach einem Neustart über einen Aufruf von **down** und anschließend **up** wirkt der neue Port. Erst dann ändert sich auch der Wert, den eine Abfrage von **-port** zurückgibt.

**-auth** *command*
: Definiert ein *command*-Präfix, das aufgerufen wird, wenn ein Benutzer authentifiziert werden muss. Ist kein solcher Befehl festgelegt, lehnt der Server alle Benutzer ab. Die Schnittstelle, die das Befehlspräfix bereitstellen muss, steht im Abschnitt **AUTHENTIFIZIERUNG**.

**-storage** *command*
: Definiert ein *command*-Präfix, das aufgerufen wird, wenn Postfachinhalte verarbeitet werden müssen. Ist kein solcher Befehl festgelegt, behauptet der Server, alle Postfächer seien leer. Die Schnittstelle, die das Befehlspräfix bereitstellen muss, steht im Abschnitt **POSTFÄCHER**.

**-socket** *command*
: Definiert ein *command*-Präfix, das zum Öffnen des Listening-Sockets aufgerufen wird. Damit kann der POP3-Server auf einem SSL-Socket lauschen, wie ihn das Paket **tls** bereitstellt; siehe den Befehl **tls::socket**.


# AUTHENTIFIZIERUNG

Hier wird die Schnittstelle beschrieben, die die Authentifizierungs-Rückruffunktion bereitstellen muss, damit POP3-Server nach der Schnittstelle dieses Moduls sie nutzen können.

*authCmd* **exists** *name*
: Dieser Methode wird ein Benutzer*name* übergeben. Sie muss einen booleschen Wert zurückgeben, der angibt, ob der angegebene Benutzer existiert.

*authCmd* **lookup** *name*
: Dieser Methode wird ein Benutzer*name* übergeben. Sie muss eine Liste mit zwei Elementen zurückgeben, in dieser Reihenfolge das Passwort dieses Benutzers und eine Speicherreferenz. Die Speicherreferenz wird unverändert an die Speicher-Rückruffunktion übergeben; siehe die Abschnitte **OPTIONEN** und **POSTFÄCHER**, dort die Option, die sie festlegt, bzw. die bereitzustellende Schnittstelle.


# POSTFÄCHER

Hier wird die Schnittstelle beschrieben, die die Speicher-Rückruffunktion bereitstellen muss, damit POP3-Server nach der Schnittstelle dieses Moduls sie nutzen können. Das Argument *mbox* ist die Speicherreferenz, wie sie die Methode **lookup** des Authentifizierungsbefehls zurückgibt; siehe den Abschnitt **AUTHENTIFIZIERUNG**.

*storageCmd* **dele** *mbox* *msgList*
: Löscht die Nachrichten, deren numerische IDs in der *msgList* enthalten sind, aus dem über *mbox* festgelegten Postfach.

*storageCmd* **lock** *mbox*
: Diese Methode sperrt das angegebene Postfach für die Nutzung durch eine einzelne Verbindung zum Server. Das ist nötig, damit mehrere offene Verbindungen zum selben Postfach kein Chaos anrichten. Die ergänzende Methode ist **unlock**. Der Befehl gibt true zurück, wenn die Sperre gesetzt werden konnte, andernfalls false.

*storageCmd* **unlock** *mbox*
: Dies ist die ergänzende Methode zu **lock**; sie hebt die Sperre für das angegebene Postfach auf.

*storageCmd* **size** *mbox* ?*msgId*?
: Ermittelt die Größe der über die ID in *msgId* angegebenen Nachricht in Byte und gibt diesen Wert zurück. Wurde keine Nachrichten-ID angegeben, gibt der Befehl die Größe des gesamten Maildrops zurück.

*storageCmd* **stat** *mbox*
: Ermittelt die Anzahl der Nachrichten in dem angegebenen Postfach und gibt diese Zahl zurück.

*storageCmd* **get** *mbox* *msgId*
: Gibt ein Handle für die angegebene Nachricht zurück. Dieses Handle ist ein MIME-Token, das der in der Dokumentation des Pakets **mime** beschriebenen Schnittstelle entspricht. Der POP3-Server nutzt die Funktionalität des MIME-Tokens, um die E-Mail an den Anforderer am anderen Ende einer POP3-Verbindung zu senden.


# SICHERE MAIL-ÜBERTRAGUNG

Die Option **-socket** (siehe **OPTIONEN**) ermöglicht es den Benutzern des Pakets, die Art und Weise zu überschreiben, wie der Server seinen Listening-Socket öffnet. Die vorgesehene Hauptanwendung ist die Angabe des Befehls **tls::socket** (siehe Paket **tls**) zur Sicherung der Kommunikation.

```
	package require tls
	tls::init \
		...

	pop3d::new S -socket tls::socket
	...
```

# LITERATUR

**\[1\]**
: [RFC 1939](http://www.rfc-editor.org/rfc/rfc1939.txt)

**\[2\]**
: [RFC 2449](http://www.rfc-editor.org/rfc/rfc2449.txt)


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pop3d* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2002-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2005 Reinhard Max  <max@suse.de>
```
