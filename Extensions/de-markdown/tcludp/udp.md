---
CommandName: udp
ManualSection: n
Version: 1.0.14
TclPart: udp
TclDescription: Tcl UDP extension
Links:
 - socket
Keywords:
 - I/O
 - IP Address
 - TclUDP
 - UDP
 - asynchronous I/O
 - bind
 - channel
 - connection
 - domain
 - host
 - name
 - network
 - network address
 - networking
 - socket
 - udp
Copyright:
 - Copyright (c) 1999-2000 Columbia University; all rights reserved
---

# NAME

udp - UDP-Sockets in Tcl anlegen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit} 
[package]{.cmd} [require]{.sub} [udp]{.lit} [1.0.14]{.lit} 
[udp_open]{.cmd} [localport]{.optarg} [reuse]{.optlit} [ipv6]{.optlit} 
[udp_conf]{.cmd} [channel]{.arg} [host]{.arg} [port]{.arg} 
[udp_conf]{.cmd} [channel]{.arg} [optionName]{.optarg} [value]{.optarg} [optionName value]{.optdot} 
[udp_peek]{.cmd} [channel]{.arg} [buffersize]{.optarg} 
[::udp::build-info]{.cmd} 
[::udp::getaddrinfo]{.cmd} [-hostname]{.sub} [name]{.arg} [optionName value]{.optdot} 
[::udp::getnameinfo]{.cmd} [address]{.arg} [ipv6]{.optlit} 
:::

# BESCHREIBUNG

Dieses Paket ermöglicht UDP aus Tcl. Es stellt einen neuen Kanaltyp bereit und erlaubt paketorientiertes UDP über die stromorientierten Kanäle von Tcl. Das Paket definiert drei Befehle. **udp_conf** gilt als veraltet; an seine Stelle tritt der Tcl-Befehl **fconfigure**.

# BEFEHLE

**udp_open** ?*localport*? ?**reuse**? ?**ipv6**?
: **udp_open** öffnet einen UDP-Socket. Ist *localport* angegeben, wird der Socket an diesen Port gebunden. Sonst wählt das System einen Port. Die Portnummer liefert bei Bedarf **udp_conf**. Die folgenden Schlüsselwörter setzen Optionen des geöffneten Sockets.


**reuse**
: Dieses Schlüsselwort setzt die Socket-Option SO_REUSEADDR. Damit dürfen mehrere Sockets an dieselbe Kombination aus Adresse und Port gebunden werden.

**ipv6**
: Voreingestellt entsteht ein IPv4-Socket. Das Schlüsselwort **ipv6** öffnet einen IPv6-Socket.


**udp_conf** *channel* *host* *port*
: *Veraltet*, zugunsten der Tcl-Befehle **fconfigure** und **chan configure**. **udp_conf** in dieser Form legt das entfernte Ziel der Pakete fest, die auf diesen *channel* geschrieben werden. Der Befehl ist aufzurufen, bevor Daten auf den UDP-Socket geschrieben werden.

**udp_conf** *channel* *?optionName?* *?value?* *?optionName value ...?*
: *Veraltet*, zugunsten der Tcl-Befehle **fconfigure** und **chan configure**. Neben dem entfernten Rechner liefert **udp_conf** Angaben zum UDP-Socket. Alle diese Optionen stehen inzwischen über **fconfigure** und **chan configure** zur Verfügung.


**-myport**
: Gibt die lokale Portnummer des Sockets zurück. Option nur zum Lesen.

**-remote** *?address port?*
: Legt den entfernten Rechnernamen und die Portnummer fest oder gibt sie zurück. Dieselbe Angabe setzt **udp_conf** *channel* *host* *port*.

**-peer**
: Gibt Rechnername und Portnummer des zuletzt auf diesem Socket empfangenen Pakets zurück. Option nur zum Lesen.

**-family**
: Gibt zurück, ob der Socket für IPv4 oder IPv6 eingerichtet ist. Option nur zum Lesen.

**-broadcast** *?boolean?*
: Legt fest oder gibt zurück, ob der Socket auf der Broadcast-Adresse empfangen und senden kann. Auf manchen Systemen braucht der Socket dafür ein Flag. Mit IPv6 ist die Option nicht zulässig; dort ist Multicast zu verwenden.

**-ttl** *?count?*
: Die Lebensdauer ist die Zahl der Router-Sprünge, die das Paket ausführen darf. Bei Multicast-Paketen bestimmt sie die Verteilung. Die Systemvorgabe für Multicast ist 1 und beschränkt das Paket auf das lokale Subnetz. Sollen Pakete Router passieren, ist der TTL-Wert zu erhöhen. 31 bleibt in der Regel innerhalb eines Standorts, 255 lässt das Paket das gesamte Netz durchqueren.

**-mcastadd** groupaddr
: … siehe den folgenden Eintrag …

**-mcastadd** "groupaddr netwif"
: … siehe den folgenden Eintrag …

**-mcastdrop** groupaddr
: … siehe den folgenden Eintrag …

**-mcastdrop** "groupaddr netwif"
: … siehe den folgenden Eintrag …

**-mcastgroups**
: Sockets von **tcludp** unterstützen Multicast mit IPv4 und IPv6. Damit Multicast-Pakete ankommen, muss die Anwendung dem Betriebssystem mitteilen, dass sie einer bestimmten Multicast-Gruppe beitritt. Bei IPv4 sind das Adressen von 224.0.0.0 bis 239.255.255.255. Steht nur *groupaddr*, wählt das System die Netzschnittstelle. *netwif* tritt einer Multicast-Gruppe auf einer bestimmten Schnittstelle bei. Das ist auf einem System mit mehreren Netzschnittstellen sinnvoll. Unter Windows ist der Index der Netzschnittstelle anzugeben. Auf anderen Plattformen kann der Name der Schnittstelle stehen, zum Beispiel 'eth0'. Die aktuellen Multicast-Gruppen eines Kanals zeigt *-mcastgroups*.

**-mcastif**
: Gibt zurück, welche Schnittstelle ausgehende Multicast-Pakete verwendet. Nur UNIX.

**-mcastloop** *?boolean?*
: Bei Multicast-UDP kann das System Pakete empfangen, die es selbst gesendet hat, oder sie verwerfen. Das ist die Multicast-Schleife und lässt sich mit dieser Option steuern. Voreingestellt ist der Wert true, und die Anwendung empfängt ihre eigenen Sendungen.


**udp_peek** *channel* ?*buffersize*?
: Sieht ein Paket an, ohne es aus dem Puffer zu nehmen. Die Option *buffersize* legt die größte Puffergröße fest. Der Wert liegt zwischen 0 und 16. Unter Windows gibt es diese Funktion nicht.

**::udp::build-info**
: Gibt Informationen zur Bauumgebung zurück.

**::udp::getaddrinfo** **-hostname** *name* *?optionName value ...?*
: Gibt eine Liste mit Angaben zu der IP-Adresse zurück, die zu den Parametern passt. Gültige Optionen:


**-hostname** *name*
: Legt fest, welche IP-Adresse nachgeschlagen wird. Zulässig sind Adresse oder Name. Pflichtoption.

**-port** *number*
: Legt fest, welche Portnummer nachgeschlagen wird.

**-service** *name*
: Legt fest, welcher bekannte Dienst (also http, https und so weiter) beim Nachschlagen den Port bestimmt.

**-ipv4**
: Gibt nur IPv4-Adressen zurück.

**-ipv6**
: Gibt nur IPv6-Adressen zurück.

**-server**
: Gibt nur Dienste zurück, für die der Rechnername ein Server ist.

**-tcp**
: Gibt nur TCP-Dienste zurück.

**-udp**
: Gibt nur UDP-Dienste zurück.


**::udp::getnameinfo** *address* **?ipv6?**
: **::udp::getnameinfo** gibt die Namen zur IP-Adresse *address* zurück. Mit *ipv6* ist die Adresse eine IPv6-Adresse.


# BEISPIELE

```
# Send data to a remote UDP socket
proc udp_puts {host port} {
    set s [udp_open]
    fconfigure $s -remote [list $host $port]
    puts $s "Hello, World"
    close $f
}
```

```
# A simple UDP server
package require udp

proc udpEventHandler {sock} {
    set pkt [read $sock]
    set peer [fconfigure $sock -peer]
    puts "$peer: [string length $pkt] {$pkt}"
    return
}

proc udp_listen {port} {
    set srv [udp_open $port]
    fconfigure $srv -buffering none -translation binary
    fileevent $srv readable [list ::udpEventHandler $srv]
    puts "Listening on udp port: [fconfigure $srv -myport]"
    return $srv
}

set sock [udp_listen 53530]
vwait forever
close $sock
```

```
# A multicast demo.
proc udpEvent {chan} {
    set data [read $chan]
    set peer [fconfigure $chan -peer]
    puts "$peer [string length $data] '$data'"
    if {[string match "QUIT*" $data]} {
        close $chan
        set ::forever 1
    }
    return
}

set group 224.5.1.21
set port  7771
set s [udp_open $port]
fconfigure $s -buffering none -blocking 0
fconfigure $s -mcastadd $group -remote [list $group $port]
fileevent $s readable [list udpEvent $s]
puts -nonewline $s "hello, world"
set ::forever 0
vwait ::forever
exit
```

# GESCHICHTE

Ein Teil des Codes dieser Erweiterung stammt aus dem Paket tcludp von Michael Miller (http://www.neosoft.com/tcl/ftparchive/sorted/comm/tcludp-1.0/). Gegenüber Michaels UDP-Erweiterung bietet diese Erweiterung Windows und das Lesen und Schreiben des Sockets mit 'gets/puts'. Dazu kommen weitere Einstellungen.

Erweiterungen für Binärdaten und die Einrichtung des Pakets für die Tcl Extension Architecture stammen von Pat Thoyts.

Die Unterstützung für IPv6 und den Beitritt zu einer Multicast-Gruppe auf einer bestimmten Netzschnittstelle hat Huub Eikens ergänzt.

# COPYRIGHT

```
Copyright (c) 1999-2000 Columbia University; all rights reserved
```
