---
CommandName: websocket
ManualSection: n
Version: 1.6
TclPart: tcllib
TclDescription: websocket client and server
Links:
 - http
Keywords:
 - http
 - internet
 - net
 - rfc 6455
Copyright:
---

# NAME

websocket – Tcl-Implementierung des WebSocket-Protokolls

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [http]{.lit} [2.7]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [sha1]{.lit} 
[package]{.cmd} [require]{.sub} [base64]{.lit} 
[package]{.cmd} [require]{.sub} [websocket]{.lit} [1.6]{.optlit} 
[::websocket::open]{.cmd} [url]{.arg} [handler]{.arg} [options]{.optarg} 
[::websocket::send]{.cmd} [sock]{.arg} [type]{.arg} [msg]{.optarg} [final]{.optarg} 
[::websocket::server]{.cmd} [sock]{.arg} 
[::websocket::live]{.cmd} [sock]{.arg} [path]{.arg} [cb]{.arg} [proto]{.optarg} 
[::websocket::test]{.cmd} [srvSock]{.arg} [cliSock]{.arg} [path]{.arg} [hdrs]{.optarg} [qry]{.optarg} 
[::websocket::upgrade]{.cmd} [sock]{.arg} 
[::websocket::takeover]{.cmd} [sock]{.arg} [handler]{.arg} [server]{.optarg} 
[::websocket::conninfo]{.cmd} [sock]{.arg} [what]{.arg} 
[::websocket::find]{.cmd} [host]{.optarg} [port]{.optarg} 
[::websocket::configure]{.cmd} [sock]{.arg} [args]{.arg} 
[::websocket::loglevel]{.cmd} [loglvl]{.optarg} 
[::websocket::close]{.cmd} [sock]{.arg} [code]{.optarg} [reason]{.optarg} 
:::

# BESCHREIBUNG

HINWEIS: DIESE DOKUMENTATION BEFINDET SICH NOCH IN DER ENTWICKLUNG...

Die WebSocket-Bibliothek ist eine reine Tcl-Implementierung der WebSocket-Spezifikation, die sowohl die Anforderungen von Clients als auch von Servern abdeckt. WebSockets bieten eine Möglichkeit, eine normale HTTP-Verbindung zu einer langlebigen und kontinuierlichen binären oder textbasierten Kommunikation zwischen Client und Server auszubauen.  Die Bibliothek bietet eine hochrangige Schnittstelle zum Empfangen und Senden von Daten gemäß RFC 6455 (Version 13 des Protokolls) und entlastet die Aufrufer von allen notwendigen Aufgaben der Protokollaufteilung und -wiederzusammensetzung. Sie implementiert die im Standard festgelegte Ping-Funktion sowie die entsprechenden Steuerungsmöglichkeiten.  Pings werden vom Server initiiert und gewährleisten die Aufrechterhaltung der Verbindung über Heimnetzwerke (NAT) hinweg. Die Bibliothek verfügt über eine Reihe von Introspektionsfunktionen, um den aktuellen Status der Verbindung abzufragen, aber bei Bedarf auch Benachrichtigungen über eingehende Pings zu empfangen.  Schließlich enthält die Bibliothek eine Reihe von Hilfsprozeduren, um die Aktualisierung des Handshakes in bestehenden Webservern zu erleichtern.

Im Mittelpunkt der Bibliothek steht die Prozedur **websocket::takeover**, die einen regulären Socket übernimmt und ihn als WebSocket behandelt, wodurch alle erforderlichen Protokoll-Framing-, Paketierungs- und Wiederzusammensetzungsvorgänge auf Servern und Clients durchgeführt werden.  Die Prozedur nimmt zudem einen Handler entgegen – einen Befehl, der jedes Mal aufgerufen wird, wenn ein (möglicherweise wieder zusammengesetztes) Paket von der Gegenstelle zur Zustellung an den ursprünglichen Aufrufer bereitsteht.  Obwohl der Befehl **websocket::takeover** vom Paket exportiert wird, wird er in Anwendungen nur selten aufgerufen, da das Paket andere Befehle bereitstellt, die speziell auf die Anforderungen von Clients und Servern zugeschnitten sind.

In der Regel stellen Clients eine Verbindung zu einem Remote-Server her, indem sie dem Befehl **websocket::open** eine WebSocket-URL (mit den Schemata *ws:* oder *wss:*) sowie den oben beschriebenen Handler übergeben. Die Prozedur zum Öffnen der Verbindung ist eine Hülle um die neuesten Implementierungen von http::geturl: Es sorgt dafür, dass der innerhalb der HTTP-Bibliothek erstellte Socket zur Wiederverwendung offen bleibt, entfernt ihn jedoch aus der (internen) Zuordnung bekannter Sockets, um ihn für eigene Zwecke zu nutzen.

Die Server registrieren sich zunächst mithilfe des Befehls **::websocket::server** und richten mithilfe des Befehls **::websocket::live** eine Reihe von Handlern für Pfade ein.  Anschließend sollten sie bei jeder eingehenden Client-Verbindung die eingehende Anfrage mit dem Befehl **::websocket::test** prüfen, um festzustellen, ob es sich um eine Upgrade-Anfrage handelt, und mit dem Befehl **::websocket::upgrade** den abschließenden Handshake durchführen, um die Socket-Verbindung unter die Kontrolle der WebSocket-Bibliothek und ihrer zentralen Prozedur zu stellen.

Neben diesen Hauptbefehlen bietet das Paket eine Reihe von Befehlen zur Introspektion und für grundlegende Operationen an den WebSockets, die es verwaltet.  Da WebSocket-Verbindungen von langer Dauer sind, erfolgt der Großteil der weiteren Kommunikation mit der Bibliothek über Rückruffunktionen, d. h. Befehle, die immer dann ausgelöst werden, wenn wichtige Ereignisse innerhalb der Bibliothek eintreten, vor allem jedoch, wenn Daten über einen WebSocket empfangen wurden.

# CALLBACKS

Eine Reihe von Befehlen der Bibliothek nimmt den Befehl „handler“ als Argument entgegen; dabei handelt es sich um einen Befehl, der bei Empfang von Daten, aber auch bei wichtigen Ereignissen innerhalb der Bibliothek oder bei Ereignissen, die durch vom Gegenüber gesendete Steuermeldungen ausgelöst werden, aufgerufen wird. Bei jeder ausgeführten Rückruffunktion werden die folgenden Argumente angehängt:

*sock*
: Die Kennung des WebSockets, wie sie beispielsweise von **::websocket::open** gegeben wird

*type*
: Ein Textfeld, das den Inhalt des Ereignisses oder der Meldung beschreibt, kann einen der folgenden Werte annehmen


**text**
: Vollständiger SMS-Text

**binary**
: Vollständige Binärnachricht

**ping**
: Eingehende Ping-Nachricht

**pong**
: Antwort auf eine eingehende Ping-Nachricht

**connect**
: Benachrichtigung über eine erfolgreiche Verbindung zum Server

**disconnect**
: Trennung von der Gegenstelle

**close**
: Verbindung wird geschlossen

**timeout**
: Meldung über ein Zeitlimit bei der Verbindung

**error**
: Meldung eines Fehlerzustands


*msg*
: Enthält die Daten der Nachricht, sofern dies relevant ist, d. h. wenn der *type* **text**, **binary**, **ping** oder **pong** lautet und sofern Daten vorhanden sind.


# API

**::websocket::open** *url* *handler* ?*options*?
: Dieser Befehl wird in Clients verwendet, um eine WebSocket-Verbindung zu einem entfernten, WebSocket-fähigen HTTP-Server herzustellen. Die als Argument in *url* angegebene URL sollte mit „ws:“ oder „wss:“ beginnen, da dies die WebSocket-Entsprechungen von „http:“ und „https:“ sind. Der *handler* ist ein Befehl, der bei Datenempfang oder bei wichtigen Ereignissen während der Lebensdauer des WebSockets aufgerufen wird. **::websocket::open** gibt einen Socket zurück, der sowohl als Kennung des WebSockets als auch des physischen Low-Level-Sockets zum Server dient.  Dieser Socket kann in einer Reihe weiterer Befehle zur Introspektion oder zur Steuerung des Verhaltens der Bibliothek verwendet werden. Da es sich im Wesentlichen um einen Wrapper um den Befehl **::http::geturl** handelt, bietet dieser Befehl größtenteils denselben Satz von durch Bindestriche getrennten Optionen wie **::http::geturl**.  Im Folgenden sind die Optionen dokumentiert, die sich von **::http::geturl** unterscheiden und spezifisch für die WebSocket-Bibliothek sind.


**-headers**
: Diese Option wird unterstützt, wobei zu beachten ist, dass in der Bibliothek intern eine Reihe von Headern automatisch hinzugefügt wird, um mit dem Server den Handshake für die Umwandlung des Sockets von einem regulären HTTP-Socket in einen WebSocket durchführen zu können.

**-validate**
: Diese Option wird nicht unterstützt, da sie für WebSockets keinen wirklichen Sinn ergibt.

**-handler**
: Diese Option wird intern von der WebSocket-Bibliothek verwendet und kann nicht genutzt werden.

**-command**
: Diese Option wird intern von der WebSocket-Bibliothek verwendet und kann nicht genutzt werden.

**-protocol**
: Diese Option legt eine Liste von Anwendungsprotokollen fest, über die ein Handshake mit dem Server hergestellt werden soll. Diese Protokolle können dem Server dabei helfen, anwendungsspezifische Funktionen auszulösen. Die Option http::geturl -protocol wird intern von der WebSocket-Bibliothek verwendet und kann nicht genutzt werden.

**-timeout**
: Diese Option wird unterstützt, wird jedoch als Teil der Bibliothek implementiert, um eine Reihe abschließender Bereinigungen zu ermöglichen.


**::websocket::send** *sock* *type* ?*msg*? ?*final*?
: Dieser Befehl sendet ein Fragment oder eine Steuermeldung an die Gegenstelle des durch *sock* identifizierten WebSockets.  Der in *type* angegebene Nachrichtentyp kann entweder eine Ganzzahl gemäß der Spezifikation oder (vorzugsweise) eine der folgenden Zeichenfolgen sein, bei denen Groß- und Kleinschreibung keine Rolle spielt: „text“, „binary“ oder „ping“.  Der Inhalt der an die Gegenstelle zu sendenden Nachricht ist in *msg* enthalten, und die Fragmentierung der Nachricht wird durch die Einstellung des Arguments *final* auf einen Wert ungleich „true“ ermöglicht, wobei zu beachten ist, dass der Typ jedes Fragments dann identisch sein muss. Der Befehl gibt die Anzahl der tatsächlich gesendeten Bytes zurück oder -1 im Fehlerfall. Schwerwiegende Fehler, beispielsweise wenn *sock* keinen bekannten WebSocket identifiziert oder wenn die Verbindung noch nicht stabil ist, führen zu Fehlern, die abgefangen werden müssen.

**::websocket::server** *sock*
: Dieser Befehl registriert den (Accept-)Socket *sock* als Kennung für einen HTTP-Server, der WebSockets unterstützt. Die Pfade, auf denen dieser Server auf eingehende Verbindungen wartet, sollten mithilfe von **::websocket::live** deklariert werden.

**::websocket::live** *sock* *path* *cb* ?*proto*?
: Diese Prozedur registriert Rückruffunktionen, die auf einem mit **::websocket::server** registrierten, WebSocket-kompatiblen Server ausgeführt werden, sobald ein Client eine Verbindung zu einem übereinstimmenden Pfad und Protokoll herstellt. *sock* ist der lauschenden Socket des WebSocket-kompatiblen Servers, der mit **::websocket::server** deklariert wurde.  *path* ist ein Pfad im Glob-Stil, der mit der Client-Anfrage abgeglichen werden soll, wann immer diese eingeht.  *cb* ist der Befehl für die Rückruffunktion (siehe „Callbacks“).  *proto* ist ein Protokollnamens-Matcher im Glob-Stil.

**::websocket::test** *srvSock* *cliSock* *path* ?*hdrs*? ?*qry*?
: Diese Prozedur prüft, ob es sich bei der Verbindung eines ankommenden Clients über den Socket *cliSock* und den Pfad *path* um die Eröffnung eines WebSocket-Streams auf einem bekannten Server *srvSock* handelt. Die eingehende Anfrage wird nicht sofort verarbeitet, sondern es wird zunächst ein (temporärer) Kontext für die eingehende Verbindung erstellt.  Dies ermöglicht es dem Servercode, bei Bedarf eine Reihe von Aktionen durchzuführen, bevor die WebSocket-Stream-Verbindung aktiv wird. Die Analyse erfolgt durch Auswertung des Inhalts der Header *hdrs*, die eine Dictionary-Liste der HTTP-Header der eingehenden Client-Verbindung enthalten sollten. Der Befehl gibt **1** zurück, wenn es sich um eine eingehende WebSocket-Upgrade-Anfrage handelt, andernfalls **0**.

**::websocket::upgrade** *sock*
: Rüstet den Socket *sock*, der von **::websocket::test** als WebSocket-Verbindungsanfrage eingestuft wurde, auf einen echten WebSocket auf, wie er von dieser Bibliothek erkannt wird. Infolgedessen wird der erforderliche Handshake für die Verbindung an den Client gesendet, und der Befehl sorgt dafür, dass während der Laufzeit des WebSockets entsprechende Rückruffunktionen ausgeführt werden, insbesondere unter Verwendung der in **::websocket::live** beschriebenen Spezifikationen.

**::websocket::takeover** *sock* *handler* ?*server*?
: Übernimmt den bereits geöffneten Socket *sock*, um das Senden und Empfangen von WebSocket-Frames auf Basis dieses Sockets zu implementieren. Die Prozedur sorgt dafür, dass *handler* zurückgerufen wird, sobald Nachrichten, Steuermeldungen oder andere wichtige interne Ereignisse empfangen werden oder eintreten.  *server* ist standardmäßig auf **0** gesetzt und kann auf **1** (oder einen booleschen Wert, der zu „true“ ausgewertet wird) gesetzt werden, um festzulegen, dass es sich um einen WebSocket innerhalb eines Servers handelt.  Abgesehen von protokollspezifischen Besonderheiten sollten Server ihre Clients in regelmäßigen Abständen anpingen, um die Verbindung stets offen zu halten. Wenn *server* auf „true“ gesetzt ist, sorgt die Bibliothek dafür, dass diese Pings automatisch gesendet werden.

**::websocket::conninfo** *sock* *what*
: Bietet Aufrufern einige Funktionen zur Selbstauswertung, um bestimmte halbinterne Informationen über eine bestehende WebSocket-Verbindung abzurufen. Je nach Wert des Arguments *what* gibt die Prozedur die folgenden Informationen zurück:


**peername**
: Name (bevorzugt) oder IP-Adresse der Gegenstelle.

**sockname**
: oder **name** Name oder IP-Adresse des lokalen Endgeräts.

**closed**
: **1**, wenn die Verbindung geschlossen ist, andernfalls **0**

**client**
: **1**, wenn es sich um eine Client-WebSocket-Verbindung handelt, andernfalls **0**

**server**
: **1**, wenn es sich um eine Server-WebSocket-Verbindung handelt, andernfalls **0**

**type**
: **server**, wenn es sich bei der Verbindung um einen Server-WebSocket handelt, andernfalls **client**.

**handler**
: Der dem WebSocket zugeordnete Handler-Befehl

**state**
: Der Status des WebSockets, der einer der folgenden sein kann:


**CONNECTING**
: Die Verbindung zur Gegenstelle wird gerade hergestellt.

**CONNECTED**
: Die Verbindung zum Gegenüber ist hergestellt.

**CLOSED**
: Die Verbindung wurde geschlossen.


**::websocket::find** ?*host*? ?*port*?
: Durchsucht die bestehenden WebSocket-Verbindungen nach solchen, die den als Parameter übergebenen Filtern für Hostnamen und Portnummern entsprechen. Bei dieser Suche wird die Gegenstelle berücksichtigt, und das Argument *host* wird sowohl mit dem Hostnamen (sofern verfügbar) als auch mit der IP-Adresse der Gegenstelle abgeglichen.  Sowohl das Argument *host* als auch das Argument *port* sind Filter für den String-Abgleich im Glob-Stil und sind standardmäßig auf **\*** gesetzt, d. h., sie finden Übereinstimmungen mit jedem Host und/oder jeder Portnummer.

**::websocket::configure** *sock* *args*
: Dieser Befehl akzeptiert eine Reihe von durch Bindestriche eingeleiteten Optionen (sowie deren Werte), um das Verhalten einer bestehenden WebSocket-Verbindung zu konfigurieren. Die folgenden Optionen werden erkannt (sie können auf den kleinsten gemeinsamen Nenner verkürzt werden):


**-keepalive**
: Dies ist die Anzahl der Sekunden zwischen den einzelnen Keepalive-Pings, die über die Verbindung gesendet werden. Eine Null oder eine negative Zahl deaktiviert diese Funktion effektiv. Auf Servern ist der Standardwert für **-keepalive** auf 30 Sekunden festgelegt, während auf Clients keine Pings initiiert werden.

**-ping**
: Dies ist der Text, der bei den automatisierten Pings verwendet wird. Standardmäßig ist dieser Text eine leere Zeichenkette, was zu einem leeren Ping führt.


**::websocket::loglevel** ?*loglvl*?
: Legt die Protokollierungsstufe der Bibliothek fest oder rufen Sie diese ab; die Standardstufe ist error. Die Protokollierung basiert auf dem Logger-Modul, und die Bibliothek verwendet die folgenden Stufen: **debug**, **info**, **notice**, **warn** und **error**.  Wird diese Prozedur ohne Argument aufgerufen, gibt sie lediglich die aktuelle Protokollierungsstufe zurück.  Andernfalls sollte *loglvl* die gewünschte Protokollierungsstufe enthalten.

**::websocket::close** *sock* ?*code*? ?*reason*?
: Schließt eine WebSocket-Verbindung, die direkt oder indirekt an **::websocket::takeover** übergeben wurde, ordnungsgemäß. Die Prozedur sendet optional den *code* und den beschreibenden *reason* als Teil des Schließungs-Handshakes. Es stehen geeignete Standardwerte zur Verfügung, sodass für eine Reihe bekannter Codes entsprechende Gründe zurückgesendet werden. Es werden nur die ersten 125 Zeichen einer Begründungszeichenfolge beibehalten und als Teil des Handshakes gesendet. Die bekannten Codes lauten:


**1000**
: Normalerweise geschlossen (der Standard-*code*, wenn kein Code angegeben wurde).

**1001**
: Endpunkt wird abgeschafft

**1002**
: Protokollfehler

**1003**
: Inkompatibler Datentyp empfangen

**1006**
: Fehlverschluss

**1007**
: Die empfangenen Daten stimmen nicht mit dem Typ überein

**1008**
: Verstoß gegen die Richtlinien

**1009**
: Die empfangene Nachricht ist zu groß

**1010**
: Fehlende Erweiterung

**1011**
: Unerwarteter Zustand

**1015**
: TLS-Handshake-Fehler


# BEISPIELE

Das folgende Skript stellt einen Client dar, der eine WebSocket-Verbindung zu einem Echo-Dienst herstellt, 400 ms wartet, um sicherzustellen, dass die Verbindung tatsächlich hergestellt wurde, und eine einzelne Textnachricht sendet, die vom Echo-Dienst zurückgesendet werden soll.  In einem realen Beispiel würde wahrscheinlich die Rückruffunktion „**connect**“ verwendet werden, um festzustellen, wann die Verbindung zum Remote-Server hergestellt wurde, und erst zu diesem Zeitpunkt würden Daten gesendet werden. Abschließend schließt das Skript die Verbindung.

```
package require websocket
::websocket::loglevel debug
proc handler { sock type msg } {
    switch -glob -nocase -- $type {
	co* {
	    puts "Connected on $sock"
	}
	te* {
	    puts "RECEIVED: $msg"
	}
	cl* -
	dis* {
	}
    }

}
proc test { sock } {
    puts "[::websocket::conninfo $sock type] from [::websocket::conninfo $sock sockname] to [::websocket::conninfo $sock peername]"

    ::websocket::send $sock text "Testing, testing..."
    after 2000 ::websocket::close $sock
}
set sock [::websocket::open ws://ws.ifelse.io/ handler]
after 400 test $sock
vwait forever
```

Beispiele für Code für einen WebSocket-Server finden Sie im Tcllib-Verzeichnis „examples/websocket“.

# TLS-SICHERHEITSHINWEISE

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *websocket* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk
