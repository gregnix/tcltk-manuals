---
CommandName: callback
ManualSection: n
Version: 0.3
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - chan(n)
 - fileevent(n)
 - my(n)
 - self(n)
 - socket(n)
 - trace(n)
Keywords:
 - callback
 - object
Copyright:
 - Copyright (c) 2018 Donal K. Fellows
---

# NAME

callback, mymethod - Erzeugt Rückrufe auf Methoden

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit} 

[callback]{.cmd} [methodName]{.arg} [arg]{.optdot} 
[mymethod]{.cmd} [methodName]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **callback**, auch **mymethod** genannt (Kompatibilität mit den ooutil- und snit-Paketen von Tcllib), darf nur im Kontext eines Methodenaufrufs verwendet werden (also im Körper einer Methode, eines Konstruktors oder Destruktors). Er erzeugt ein Skriptfragment, das beim Ausführen die Methode *methodName* auf dem aktuellen Objekt (gemeldet durch **self**) aufruft. Zusätzliche Argumente werden als führende Argumente des Rückrufs übergeben. Das resultierende Skriptfragment ist eine gültige Liste.

Der Aufrufer muss sicherstellen, dass das aktuelle Objekt *methodName* verarbeiten kann; dieser Befehl prüft das nicht. *methodName* kann jede exportierte oder nicht exportierte Methode bezeichnen, aber keine private Methode, da diese nur direkt aus Methoden aufgerufen werden können. Existiert beim Aufruf des Rückrufs keine solche Methode, wird der Standard-**unknown**-Methoden-Handler aufgerufen.

# BEISPIELE

Eine einfache Echo-Server-Klasse. **callback** wird zweimal verwendet: für eingehende Socket-Verbindungen (**Accept**) und für eingehende Bytes auf diesen Verbindungen (**Receive**).

```
oo::class create EchoServer {
    variable server clients
    constructor {port} {
        set server [socket -server [callback Accept] $port]
        set clients {}
    }
    destructor {
        chan close $server
        foreach client [dict keys $clients] {
            chan close $client
        }
    }

    method Accept {channel clientAddress clientPort} {
        dict set clients $channel [dict create \
                address $clientAddress port $clientPort]
        chan event $channel readable [callback Receive $channel]
    }
    method Receive {channel} {
        if {[chan gets $channel line] >= 0} {
            my echo $channel $line
        } else {
            chan close $channel
            dict unset clients $channel
        }
    }

    method echo {channel line} {
        dict with clients $channel {
            chan puts $channel \
                    [format {[%s:%d] %s} $address $port $line]
        }
    }
}
```
