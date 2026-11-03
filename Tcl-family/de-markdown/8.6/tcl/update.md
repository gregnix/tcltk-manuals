---
CommandName: update
title: update
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - after(n)
 - interp(n)
Keywords:
 - asynchronous I/O
 - event
 - flush
 - handler
 - idle
 - update
Copyright:
 - Copyright (c) 1990-1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

update - Verarbeitet anstehende Ereignisse und Idle-Rückruffunktionen

# Übersicht

::: {.synopsis} :::
[update]{.cmd} [idletasks]{.optlit}
:::

# Beschreibung

Dieser Befehl bringt die Anwendung „auf den neuesten Stand“, indem er wiederholt die Ereignisschleife betritt, bis alle anstehenden Ereignisse (einschließlich Idle-Rückruffunktionen) verarbeitet wurden.

Wird das Schlüsselwort **idletasks** als Argument angegeben, werden keine neuen Ereignisse oder Fehler verarbeitet; es werden nur Idle-Rückruffunktionen aufgerufen. Dadurch werden normalerweise verzögerte Operationen wie Anzeigeaktualisierungen und Fensterlayout-Berechnungen sofort ausgeführt.

Der Befehl **update idletasks** ist in Skripten nützlich, in denen der Zustand der Anwendung geändert wurde und diese Änderungen sofort auf der Anzeige erscheinen sollen, statt erst nach Abschluss des Skripts. Die meisten Anzeigeaktualisierungen erfolgen als Idle-Rückruffunktionen; **update idletasks** lässt sie laufen. Es gibt jedoch Aktualisierungen, die nur als Reaktion auf Ereignisse erfolgen, etwa bei Fenstergrößenänderungen; diese erfolgen nicht bei **update idletasks**.

Der Befehl **update** ohne Optionen ist in Skripten nützlich, die lange Berechnungen ausführen, bei denen die Anwendung dennoch auf Ereignisse wie Benutzerinteraktionen reagieren soll; ruft man gelegentlich **update** auf, wird Benutzereingabe beim nächsten Aufruf von **update** verarbeitet.

# Beispiel

Berechnungen etwa eine Sekunde lang ausführen und dann beenden:

```
set x 1000
set done 0
after 1000 set done 1
while {!$done} {
    # Ein sehr albernes Beispiel!
    set x [expr {log($x) ** 2.8}]

    # Prüfen, ob das Zeitlimit erreicht ist. Das gibt auch
    # Gelegenheit, Netzwerk-Sockets zu bedienen und, wenn das
    # Tk-Paket geladen ist, eine Benutzeroberfläche zu aktualisieren.
    update
}
```
