---
CommandName: socket
title: socket
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - chan(n)
 - flush(n)
 - open(n)
 - read(n)
Keywords:
 - asynchronous I/O
 - bind
 - channel
 - connection
 - domain name
 - host
 - network address
 - socket
 - tcp
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
 - Copyright (c) 1998-1999 Scriptics Corporation.
---

# Name

socket - Öffnet eine TCP-Netzwerkverbindung

# Übersicht

::: {.synopsis} :::
[socket]{.cmd} [options]{.optarg} [host]{.arg} [port]{.arg}
[socket]{.cmd} [-server]{.lit} [command]{.arg} [options]{.optarg} [port]{.arg}
:::

# Beschreibung

Dieser Befehl öffnet einen Netzwerk-Socket und gibt einen Kanalbezeichner zurück, der in späteren Aufrufen von Befehlen wie [read], [puts] und [flush] verwendet werden kann. Derzeit wird nur das TCP-Netzwerkprotokoll über IPv4 und IPv6 unterstützt; zukünftige Versionen können zusätzliche Protokolle unterstützen. Der Befehl **socket** kann verwendet werden, um je nachdem, ob der Schalter **-server** angegeben ist, entweder die Client- oder die Server-Seite einer Verbindung zu öffnen.

Beachten Sie, dass die Standardkodierung für *alle* Sockets die Systemkodierung ist, wie von [encoding system][encoding] zurückgegeben. Meistens müssen Sie [chan configure][chan] verwenden, um diese auf etwas anderes zu ändern, wie *utf-8* (ideal für die Kommunikation mit anderen Tcl-Prozessen) oder *iso8859-1* (nützlich für viele Netzwerkprotokolle, besonders die älteren).

# Client-Sockets

Ist die Option **-server** nicht angegeben, wird die Client-Seite einer Verbindung geöffnet und der Befehl gibt einen Kanalbezeichner zurück, der sowohl zum Lesen als auch zum Schreiben verwendet werden kann. *Port* und *host* legen einen Port fest, mit dem eine Verbindung hergestellt werden soll; auf diesem Port muss ein Server Verbindungen annehmen. *Port* ist eine ganzzahlige Portnummer (oder ein Dienstname, sofern vom Host-Betriebssystem unterstützt und verstanden) und *host* ist entweder ein Domain-Name wie **www.tcl.tk** oder eine numerische IPv4- oder IPv6-Adresse wie **127.0.0.1** oder **2001:DB8::1**. Verwenden Sie *localhost*, um auf den Host zu verweisen, auf dem der Befehl ausgeführt wird.

Die folgenden Optionen können ebenfalls vor *host* stehen, um zusätzliche Informationen über die Verbindung anzugeben:

**-myaddr** *addr*
: *Addr* gibt den Domain-Namen oder die numerische IP-Adresse der clientseitigen Netzwerkschnittstelle an, die für die Verbindung verwendet werden soll. Diese Option kann nützlich sein, wenn der Client-Rechner mehrere Netzwerkschnittstellen hat. Wird die Option weggelassen, wählt die Systemsoftware die clientseitige Schnittstelle.

**-myport** *port*
: *Port* legt eine ganzzahlige Portnummer (oder einen Dienstnamen, sofern vom Host-Betriebssystem unterstützt und verstanden) für die Client-Seite der Verbindung fest. Wird diese Option weggelassen, wird die Client-Portnummer zufällig von der Systemsoftware gewählt.

**-async**
: Diese Option bewirkt, dass der Client-Socket asynchron verbunden wird. Das heißt, der Socket wird sofort erstellt, ist aber möglicherweise noch nicht mit dem Server verbunden, wenn der Aufruf von **socket** zurückkehrt.

    Wird auf dem Socket ein [gets] oder [flush] ausgeführt, bevor der Verbindungsversuch erfolgreich ist oder fehlschlägt, wartet die Operation im blockierenden Modus des Sockets, bis die Verbindung abgeschlossen ist oder fehlschlägt. Ist der Socket im nicht blockierenden Modus und wird ein [gets] oder [flush] ausgeführt, bevor der Verbindungsversuch erfolgreich ist oder fehlschlägt, kehrt die Operation sofort zurück und [fblocked] auf dem Socket gibt 1 zurück. Synchrone Client-Sockets können (nach erfolgreicher Verbindung) in den asynchronen Betrieb versetzt werden mit:

    ```
    chan configure chan -blocking 0
    ```

    Siehe den Befehl [chan configure][chan] für weitere Einzelheiten.

    Die Tcl-Ereignisschleife sollte laufen, während eine asynchrone Verbindung aufgebaut wird, da im Hintergrund mehrere Verbindungsversuche nötig sein können. Das Ausführen der Ereignisschleife ermöglicht außerdem, ein beschreibbares Kanalereignis auf dem Socket einzurichten, um benachrichtigt zu werden, wenn die asynchrone Verbindung erfolgreich war oder fehlgeschlagen ist. Siehe die Befehle [vwait] und [chan] für weitere Einzelheiten zur Ereignisschleife und zu Kanalereignissen.

    Die [chan configure][chan]-Option **-connecting** kann verwendet werden, um zu prüfen, ob der Verbindungsaufbau noch läuft. Um eine erfolgreiche Verbindung zu verifizieren, kann die Option **-error** geprüft werden, wenn **-connecting** 0 zurückgegeben hat.

    Der Betrieb ohne Ereigniswarteschlange erfordert derzeit Aufrufe von [chan configure][chan], um die interne Zustandsmaschine voranzutreiben.


# Server-Sockets

Ist die Option **-server** angegeben, ist der neue Socket ein Server, der auf dem angegebenen *port* lauscht (entweder eine Ganzzahl oder ein Dienstname, sofern vom Host-Betriebssystem unterstützt und verstanden; ist *port* null, weist das Betriebssystem dem Server-Socket einen freien Port zu, der mit [chan configure][chan] und der Option **-sockname** ermittelt werden kann). Unterstützt der Host sowohl IPv4 als auch IPv6, lauscht der Socket auf beiden Adressfamilien. Tcl nimmt Verbindungen zum angegebenen Port automatisch an. Für jede Verbindung erstellt Tcl einen neuen Kanal, über den mit dem Client kommuniziert werden kann. Tcl ruft dann *command* (korrekt als Befehlspräfixliste, siehe [Beispiele] unten) mit drei zusätzlichen Argumenten auf: den Namen des neuen Kanals, die Adresse des Client-Hosts in Netzwerkadressnotation und die Portnummer des Clients.

Die folgende zusätzliche Option kann ebenfalls vor *port* angegeben werden:

**-myaddr** *addr*
: *Addr* gibt den Domain-Namen oder die numerische IP-Adresse der serverseitigen Netzwerkschnittstelle für die Verbindung an. Diese Option kann nützlich sein, wenn der Server-Rechner mehrere Netzwerkschnittstellen hat. Wird die Option weggelassen, ist der Server-Socket an die Platzhalteradresse gebunden, sodass Verbindungen von jeder Schnittstelle angenommen werden können. Ist *addr* ein Domain-Name, der in mehrere auf dem lokalen Rechner verfügbare IP-Adressen aufgelöst wird, lauscht der Socket auf allen.


Server-Kanäle können nicht zum Lesen oder Schreiben verwendet werden; sie dienen ausschließlich dazu, neue Client-Verbindungen anzunehmen. Die für jede eingehende Client-Verbindung erstellten Kanäle werden zum Lesen und Schreiben geöffnet. Das Schließen des Server-Kanals beendet den Server, sodass keine neuen Verbindungen mehr angenommen werden; bestehende Verbindungen bleiben jedoch unberührt.

Server-Sockets sind auf den Tcl-Ereignismechanismus angewiesen, um zu erfahren, wann neue Verbindungen geöffnet werden. Betritt die Anwendung die Ereignisschleife nicht, etwa durch Aufruf von [vwait] oder der C-Prozedur [Tcl\_DoOneEvent][DoOneEvent], werden keine Verbindungen angenommen.

Wird *port* als null angegeben, weist das Betriebssystem einen unbenutzten Port für den Server-Socket zu. Die tatsächlich zugewiesene Portnummer kann vom erstellten Server-Socket mit [chan configure][chan] und der Option **-sockname** wie unten beschrieben abgefragt werden.

# Konfigurationsoptionen

Der Befehl [chan configure][chan] kann verwendet werden, um mehrere schreibgeschützte Konfigurationsoptionen für Socket-Kanäle abzufragen:

**-error**
: Diese Option liefert den aktuellen Fehlerstatus des angegebenen Sockets. Das ist nützlich, wenn festgestellt werden soll, ob ein asynchroner Verbindungsaufbau erfolgreich war. Bei einem Fehler wird die Fehlermeldung zurückgegeben. Gab es keinen Fehler, wird eine leere Zeichenkette zurückgegeben.

    Beachten Sie, dass der Fehlerstatus durch die Leseoperation zurückgesetzt wird; das entspricht dem zugrunde liegenden Aufruf getsockopt(SO\_ERROR).

**-sockname**
: Bei Client-Sockets (einschließlich der Kanäle, die erstellt werden, wenn sich ein Client mit einem Server-Socket verbindet) gibt diese Option eine Liste aus drei Elementen zurück: Adresse, Hostname und Portnummer des Sockets. Kann der Hostname nicht ermittelt werden, ist das zweite Element identisch mit der Adresse, dem ersten Element der Liste.

    Bei Server-Sockets gibt diese Option eine Liste mit einem Vielfachen von drei Elementen zurück; jede Gruppe hat dieselbe Bedeutung wie oben beschrieben. Die Liste enthält mehr als eine Gruppe, wenn der Server-Socket ohne **-myaddr** erstellt wurde oder das Argument von **-myaddr** ein Domain-Name ist, der in mehrere auf dem aufrufenden Host lokale IP-Adressen aufgelöst wird.

**-peername**
: Diese Option wird von Server-Sockets nicht unterstützt. Bei Client- und angenommenen Sockets gibt sie eine Liste aus drei Elementen zurück: Adresse, Hostname und Port, mit dem der Peer-Socket verbunden ist oder an den er gebunden ist. Kann der Hostname nicht ermittelt werden, ist das zweite Element der Liste identisch mit der Adresse, ihrem ersten Element.

**-connecting**
: Diese Option wird von Server-Sockets nicht unterstützt. Bei Client-Sockets gibt sie 1 zurück, wenn ein asynchroner Verbindungsaufbau noch läuft, sonst 0.


# Beispiele

Hier ist ein sehr einfacher Zeitserver:

```
proc Server {startTime channel clientaddr clientport} {
    puts "Connection from $clientaddr registered"
    set now [clock seconds]
    puts $channel [clock format $now]
    puts $channel "[expr {$now - $startTime}] since start"
    close $channel
}

socket -server [list Server [clock seconds]] 9900
vwait forever
```

Und hier ist der zugehörige Client, der mit dem Server spricht und Informationen ausliest:

```
set server localhost
set sockChan [socket $server 9900]
gets $sockChan line1
gets $sockChan line2
close $sockChan
puts "The time on $server is $line1"
puts "That is [lindex $line2 0]s since the server started"
```

# Geschichte

Unterstützung für IPv6 wurde in Tcl 8.6 hinzugefügt.


[chan]: chan.md
[DoOneEvent]: ../tcl-c/DoOneEvent.md
[encoding]: encoding.md
[fblocked]: fblocked.md
[flush]: flush.md
[gets]: gets.md
[puts]: puts.md
[read]: read.md
[vwait]: vwait.md
