---
CommandName: fblocked
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

# NAME

fblocked - Prüft, ob die letzte Eingabeoperation alle verfügbaren Eingabedaten verbraucht hat

# ÜBERSICHT

::: {.synopsis} :::
[fblocked]{.cmd} [channelId]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **fblocked** gibt 1 zurück, wenn die letzte Eingabeoperation auf *channelId* weniger Informationen zurückgab als angefordert, weil alle verfügbaren Eingabedaten erschöpft waren. Wird **gets** aufgerufen, wenn nur drei Zeichen zur Eingabe verfügbar sind und keine Zeilenende-Sequenz vorliegt, gibt **gets** eine leere Zeichenkette zurück, und ein anschließender Aufruf von **fblocked** liefert 1.

*channelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. einen Tcl-Standardkanal (**stdin**, **stdout** oder **stderr**), den Rückgabewert von **open** oder **socket** oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung.

# BEISPIELE

Der Befehl **fblocked** ist besonders nützlich beim Schreiben von Netzwerkservern, da er einen zeilenweisen Programmierstil erlaubt, ohne die Bedienung anderer Verbindungen zu verhindern. Das zeigt sich in diesem einfachen Echo-Dienst:

```
# Wird aufgerufen, wenn ein neuer Client sich mit dem Server verbindet
proc connect {chan host port} {
    set clientName [format <%s:%d> $host $port]
    puts "connection from $clientName"
    fconfigure $chan -blocking 0 -buffering line
    fileevent $chan readable [list echoLine $chan $clientName]
}

# Wird aufgerufen, wenn mindestens ein Byte Eingabedaten verfügbar ist
# oder der Kanal vom Client geschlossen wurde
proc echoLine {chan clientName} {
    gets $chan line
    if {[eof $chan]} {
        puts "finishing connection from $clientName"
        close $chan
    } elseif {![fblocked $chan]} {
        # Hat nicht blockierend auf Zeilenende gewartet
        puts "$clientName - $line"
        puts $chan $line
    }
}

# Server-Socket erstellen und in die Ereignisschleife gehen,
# um eingehende Verbindungen zu erwarten...
socket -server connect 12345
vwait forever
```
