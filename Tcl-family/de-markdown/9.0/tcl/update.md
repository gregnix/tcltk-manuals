---
CommandName: update
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

# NAME

update - Verarbeitet anstehende Events und Idle-Callbacks

# ÜBERSICHT

::: {.synopsis} :::
[update]{.cmd} [idletasks]{.optlit} 
:::

# BESCHREIBUNG

Dieser Befehl bringt die Anwendung „auf den neuesten Stand“, indem er wiederholt die Event-Schleife betritt, bis alle anstehenden Events (einschließlich Idle-Callbacks) verarbeitet wurden.

Wird das Schlüsselwort **idletasks** als Argument angegeben, werden keine neuen Events oder Fehler verarbeitet; es werden nur Idle-Callbacks aufgerufen. Dadurch werden normalerweise verzögerte Operationen wie Anzeigeaktualisierungen und Fensterlayout-Berechnungen sofort ausgeführt.

Der Befehl **update idletasks** ist in Skripten nützlich, in denen der Zustand der Anwendung geändert wurde und diese Änderungen sofort auf der Anzeige erscheinen sollen, statt erst nach Abschluss des Skripts. Die meisten Anzeigeaktualisierungen erfolgen als Idle-Callbacks; **update idletasks** lässt sie laufen. Es gibt jedoch Aktualisierungen, die nur als Reaktion auf Events erfolgen, etwa bei Fenstergrößenänderungen; diese erfolgen nicht bei **update idletasks**.

Der Befehl **update** ohne Optionen ist in Skripten nützlich, die lange Berechnungen ausführen, bei denen die Anwendung dennoch auf Events wie Benutzerinteraktionen reagieren soll; ruft man gelegentlich **update** auf, wird Benutzereingabe beim nächsten Aufruf von **update** verarbeitet.

# BEISPIEL

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
