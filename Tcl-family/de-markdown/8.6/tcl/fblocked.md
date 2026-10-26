---
CommandName: fblocked
title: fblocked
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - gets(n)
 - open(n)
 - read(n)
 - socket(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - nonblocking
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

fblocked - Prüft, ob die letzte Eingabeoperation alle verfügbaren Eingabedaten verbraucht hat

# Übersicht

::: {.synopsis} :::
[fblocked]{.cmd} [channelId]{.arg}
:::

# Beschreibung

Der Befehl **fblocked** gibt 1 zurück, wenn die letzte Eingabeoperation auf *channelId* weniger Informationen zurückgab als angefordert, weil alle verfügbaren Eingabedaten erschöpft waren. Wird [gets] aufgerufen, wenn nur drei Zeichen zur Eingabe verfügbar sind und keine Zeilenende-Sequenz vorliegt, gibt [gets] eine leere Zeichenkette zurück, und ein anschließender Aufruf von **fblocked** liefert 1.

*channelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. einen Tcl-Standardkanal (**stdin**, **stdout** oder **stderr**), den Rückgabewert von [open] oder [socket] oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung.

# Beispiele

Der Befehl **fblocked** ist besonders nützlich beim Schreiben von Netzwerkservern, da er einen zeilenweisen Programmierstil erlaubt, ohne die Bedienung anderer Verbindungen zu verhindern. Das zeigt sich in diesem einfachen Echo-Dienst:

```
# This is called whenever a new client connects to the server
proc connect {chan host port} {
    set clientName [format <%s:%d> $host $port]
    puts "connection from $clientName"
    fconfigure $chan -blocking 0 -buffering line
    fileevent $chan readable [list echoLine $chan $clientName]
}

# This is called whenever either at least one byte of input
# data is available, or the channel was closed by the client.
proc echoLine {chan clientName} {
    gets $chan line
    if {[eof $chan]} {
        puts "finishing connection from $clientName"
        close $chan
    } elseif {![fblocked $chan]} {
        # Didn't block waiting for end-of-line
        puts "$clientName - $line"
        puts $chan $line
    }
}

# Create the server socket and enter the event-loop to wait
# for incoming connections...
socket -server connect 12345
vwait forever
```


[gets]: gets.md
[open]: open.md
[socket]: socket.md
