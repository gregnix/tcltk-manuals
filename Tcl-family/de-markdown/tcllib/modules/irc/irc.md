---
CommandName: irc
title: irc
ManualSection: n
Version: 0.8.0
TclPart: tcllib
TclDescription: Low Level Tcl IRC Interface
Links:
 - rfc 1459
Keywords:
 - chat
 - irc
Copyright:
---

# Name

irc – IRC-Verbindung und -Schnittstelle erstellen.

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [irc]{.lit} [0.8.0]{.optlit}
[::irc::config]{.cmd} [key]{.optarg} [value]{.optarg}
[::irc::connection]{.cmd}
[::irc::connections]{.cmd}
[net]{.ins} [registerevent]{.sub} [event]{.arg} [script]{.arg}
[net]{.ins} [getevent]{.sub} [event]{.arg} [script]{.arg}
[net]{.ins} [eventexists]{.sub} [event]{.arg} [script]{.arg}
[net]{.ins} [connect]{.sub} [hostname]{.arg} [port]{.optarg}
[net]{.ins} [config]{.sub} [key]{.optarg} [value]{.optarg}
[net]{.ins} [log]{.sub} [level]{.arg} [message]{.arg}
[net]{.ins} [logname]{.sub}
[net]{.ins} [connected]{.sub}
[net]{.ins} [sockname]{.sub}
[net]{.ins} [peername]{.sub}
[net]{.ins} [socket]{.sub}
[net]{.ins} [user]{.sub} [username]{.arg} [localhostname]{.arg} [localdomainname]{.arg} [userinfo]{.arg}
[net]{.ins} [nick]{.sub} [nick]{.arg}
[net]{.ins} [ping]{.sub} [target]{.arg}
[net]{.ins} [serverping]{.sub}
[net]{.ins} [join]{.sub} [channel]{.arg} [key]{.optarg}
[net]{.ins} [part]{.sub} [channel]{.arg} [message]{.optarg}
[net]{.ins} [quit]{.sub} [message]{.optarg}
[net]{.ins} [privmsg]{.sub} [target]{.arg} [message]{.arg}
[net]{.ins} [notice]{.sub} [target]{.arg} [message]{.arg}
[net]{.ins} [ctcp]{.sub} [target]{.arg} [message]{.arg}
[net]{.ins} [kick]{.sub} [channel]{.arg} [target]{.arg} [message]{.optarg}
[net]{.ins} [mode]{.sub} [target]{.arg} [args]{.arg}
[net]{.ins} [topic]{.sub} [channel]{.arg} [message]{.arg}
[net]{.ins} [invite]{.sub} [channel]{.arg} [target]{.arg}
[net]{.ins} [send]{.sub} [text]{.arg}
[net]{.ins} [destroy]{.sub}
[who]{.cmd} [address]{.optlit}
[action]{.cmd}
[target]{.cmd}
[additional]{.cmd}
[header]{.cmd}
[msg]{.cmd}
:::

# Beschreibung

Dieses Paket stellt Low-Level-Befehle zur Verfügung, die das IRC-Protokoll (Internet Relay Chat) für die unmittelbare und interaktive Mehrbenutzer-Kommunikation nutzen.

**::irc::config** ?key? ?value?
: Setzt die Konfiguration ?key? auf ?value?. Die derzeit definierten Konfigurationsschlüssel sind die booleschen Flags **logger** und **debug**. **logger** bewirkt, dass **irc** das Logger-Paket zur Ausgabe von Fehlern verwendet. **debug** setzt **logger** voraus und gibt zusätzliche Debug-Ausgaben aus. Wenn weder ?key? noch ?value? angegeben wird, werden die aktuellen Werte zurückgegeben.

**::irc::connection**
: Der Befehl erstellt ein neues Objekt zur Verwaltung einer IRC-Verbindung. Durch das Erstellen dieses IRC-Objekts wird die Netzwerkverbindung nicht automatisch hergestellt. Er gibt einen neuen Befehl im IRC-Namespace zurück, mit dem sich die neue IRC-Verbindung steuern lässt. Hinweis: Die alte Form des Befehls connection, bei der Hostname und Port als Argumente übergeben wurden, ist veraltet. Stattdessen legt **connect** diese Angaben fest.

**::irc::connections**
: Gibt eine Liste aller aktuellen Verbindungen zurück, die mit **connection** erstellt wurden


# Befehle pro Verbindung

In der folgenden Liste der verfügbaren Verbindungsmethoden steht *net* für einen Verbindungsbefehl, wie er von **::irc::connection** zurückgegeben wird.

*net* **registerevent** *event* *script*
: Registriert einen Rückruf-Handler für das jeweilige Ereignis. Verfügbar sind die in RFC 1459 <http://www.rfc-editor.org/rfc/rfc1459.txt> beschriebenen Ereignisse. Darüber hinaus sind mehrere weitere Ereignisse definiert. **defaultcmd** fügt einen Befehl hinzu, der aufgerufen wird, wenn keine andere Rückruffunktion vorhanden ist. **EOF** wird aufgerufen, wenn die Verbindung ein Dateiende signalisiert. Die Ereignisse **defaultcmd**, **defaultnumeric**, **defaultevent** und **EOF** sind erforderlich. *script* wird im Namespace der Verbindung ausgeführt und kann dabei verschiedene Befehle nutzen (siehe [Callback-Befehle] weiter unten), die beim Parsen der Daten helfen.

*net* **getevent** *event* *script*
: Gibt den aktuellen Ereignisbehandler zurück, sofern einer vorhanden ist. Andernfalls wird eine leere Zeichenkette zurückgegeben.

*net* **eventexists** *event* *script*
: Gibt einen booleschen Wert zurück, der angibt, ob der Ereignisbehandler vorhanden ist.

*net* **connect** *hostname* ?port?
: Dadurch wird die Socket-Verbindung hergestellt. **::irc::connection** hat den Namespace und die zu verwendenden Befehle erstellt, jedoch den Socket noch nicht tatsächlich geöffnet. Dies geschieht hier. Hinweis: Bei der älteren Form von \\'connect' mussten kein Hostname und kein Port angegeben werden; diese wurden mit 'connection' festgelegt. Diese Form ist veraltet.

*net* **config** ?key? ?value?
: Entspricht **::irc::config**, legt Optionen jedoch nur für die Verbindung *net* fest und ruft sie nur von dort ab.

*net* **log** *level* *message*
: Wenn die Protokollierung durch **config** eingeschaltet ist, wird eine Protokoll-*message* auf der Stufe *level* geschrieben.

*net* **logname**
: Gibt den Namen der Logger-Instanz zurück, wenn die Protokollierung aktiviert ist.

*net* **connected**
: Gibt einen booleschen Wert zurück, der angibt, ob diese Verbindung zu einem Server besteht.

*net* **sockname**
: Gibt eine Liste mit drei Elementen zurück, bestehend aus der IP-Adresse, dem Hostnamen und dem Port der lokalen Seite der Verbindung, wenn derzeit eine Verbindung besteht.

*net* **peername**
: Gibt eine Liste mit drei Elementen zurück, bestehend aus der IP-Adresse, dem Hostnamen und dem Port der Gegenstelle, wenn derzeit eine Verbindung besteht.

*net* **socket**
: Gibt den Tcl-Kanal für den von der Verbindung verwendeten Socket zurück.

*net* **user** *username* *localhostname* *localdomainname* *userinfo*
: Sendet den Befehl USER an den Server. *username* ist der Benutzername, der angezeigt werden soll. *localhostname* ist der Host-Teil des Hostnamens, *localdomainname* der Domainname und *userinfo* eine kurze Beschreibung der Person. Das zweite und dritte Argument werden vom IRC-Server normalerweise ignoriert.

*net* **nick** *nick*
: Der Befehl NICK. *nick* ist der Nickname, der für diese Verbindung verwendet werden soll.

*net* **ping** *target*
: Sendet einen CTCP-PING an *target*.

*net* **serverping**
: Sendet einen PING an den Server.

*net* **join** *channel* ?*key*?
: *channel* ist der IRC-Kanal, dem beigetreten wird. IRC-Kanäle beginnen in der Regel mit einem Rautezeichen ("#") oder einem Und-Zeichen ("&").

*net* **part** *channel* ?*message*?
: Bewirkt, dass der Client den *channel* verlässt. Einige Netzwerke unterstützen möglicherweise das optionale Argument *message*

*net* **quit** ?*message*?
: Weist den IRC-Server an, die aktuelle Verbindung zu schließen. Das Paket verwendet einen generischen Vorgabewert, wenn keine *message* angegeben wurde.

*net* **privmsg** *target* *message*
: Sendet *message* an *target*, wobei es sich entweder um einen Kanal oder um einen anderen Benutzer handeln kann; im letzteren Fall wird dessen Nickname verwendet.

*net* **notice** *target* *message*
: Sendet ein **notice** mit der *message* an *target*, wobei es sich entweder um einen Kanal oder um einen anderen Benutzer handeln kann; im letzteren Fall wird dessen Nickname verwendet.

*net* **ctcp** *target* *message*
: Sendet eine CTCP-Nachricht vom Typ *message* an *target*

*net* **kick** *channel* *target* ?*message*?
: Entfernt den Benutzer *target* mit einer *message* aus dem Kanal *channel*. Letztere kann weggelassen werden.

*net* **mode** *target* *args*
: Legt den Modus *args* für das Ziel *target* fest. *target* kann ein Kanal, ein Kanalbenutzer oder der eigene Benutzer sein.

*net* **topic** *channel* *message*
: Legt das Thema auf *channel* auf *message* fest; durch die Angabe einer leeren Zeichenfolge wird das Thema entfernt.

*net* **invite** *channel* *target*
: Lädt *target* ein, dem Kanal *channel* beizutreten

*net* **send** *text*
: Sendet *text* an den IRC-Server.

*net* **destroy**
: Löscht die Verbindung sowie den zugehörigen Namespace und die zugehörigen Informationen.


# Callback-Befehle

Diese Befehle können innerhalb von Rückruffunktionen verwendet werden

**who** ?**address**?
: Gibt den Nickname des Benutzers zurück, der einen Befehl ausgeführt hat. Das optionale Schlüsselwort **address** bewirkt, dass der Befehl den Benutzer im Format "username@address" zurückgibt.

**action**
: Gibt die ausgeführte Aktion zurück, z. B. KICK, PRIVMSG, MODE usw. Dies ist in der Regel nicht sinnvoll, da Rückruffunktionen an ein bestimmtes Ereignis gebunden sind.

**target**
: Gibt das Ziel eines bestimmten Befehls zurück, beispielsweise den Kanal oder den Benutzer, an den eine PRIVMSG gesendet wird.

**additional**
: Gibt eine Liste aller zusätzlichen Argumente nach dem Ziel zurück.

**header**
: Gibt den gesamten Ereignis-Header (alles bis zum :) als reguläre Liste zurück.

**msg**
: Gibt den Meldungsteil des Befehls zurück (den Teil nach dem :).


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *irc* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk
