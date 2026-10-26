---
CommandName: struct::prioqueue
title: struct::prioqueue
ManualSection: n
Version: 1.5
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - ordered list
 - prioqueue
 - priority queue
Copyright:
 - Copyright (c) 2003 Michael Schlenker <mic42@users.sourceforge.net>
---

# Name

struct::prioqueue – Prioqueue-Objekte anlegen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::prioqueue]{.lit} [1.5]{.optlit}
[::struct::prioqueue]{.cmd} [-ascii|-dictionary|-integer|-real]{.optlit} [prioqueueName]{.optarg}
[prioqueueName]{.ins} [option]{.sub} [arg arg]{.optdot}
[prioqueueName]{.ins} [clear]{.sub}
[prioqueueName]{.ins} [remove]{.sub} [item]{.arg}
[prioqueueName]{.ins} [destroy]{.sub}
[prioqueueName]{.ins} [get]{.sub} [count]{.optarg}
[prioqueueName]{.ins} [peek]{.sub} [count]{.optarg}
[prioqueueName]{.ins} [peekpriority]{.sub} [count]{.optarg}
[prioqueueName]{.ins} [put]{.sub} [item]{.arg} [prio]{.arg} [item prio]{.optdot}
[prioqueueName]{.ins} [size]{.sub}
:::

# Beschreibung

Dieses Paket implementiert eine einfache Prioritätswarteschlange unter Verwendung verschachtelter Tcl-Listen.

Der Befehl **::struct::prioqueue** erstellt eine neue Prioritätswarteschlange mit dem Standard-Prioritätsschlüsseltyp *-integer*. Das bedeutet, dass Schlüssel, die dem Unterbefehl **put** übergeben werden, diesen Typ aufweisen müssen.

Dadurch wird auch die Prioritätsreihenfolge festgelegt. Bei den Schlüsseltypen *-ascii* und *-dictionary* werden die Daten in aufsteigender Reihenfolge sortiert (wie bei **lsort** *-increasing*), während bei *-integer* und *-real* die Daten in absteigender Reihenfolge sortiert werden (wie bei **lsort** *-decreasing*).

Die Namen der Prioqueues unterliegen keinen Einschränkungen, können jedoch als Optionen interpretiert werden, wenn kein Prioritätstyp angegeben wird.

**::struct::prioqueue** ?**-ascii|-dictionary|-integer|-real**? ?*prioqueueName*?
: Der Befehl **::struct::prioqueue** erzeugt ein neues Prioqueue-Objekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *prioqueueName* lautet. Mit diesem Befehl lassen sich verschiedene Operationen auf der Prioqueue aufrufen. Er hat die folgende allgemeine Form:

*prioqueueName* **option** ?*arg arg ...*?
: **option** und die *arg*s legen das genaue Verhalten des Befehls fest. Für Prioqueue-Objekte sind folgende Befehle möglich:

*prioqueueName* **clear**
: Entfernt alle Elemente aus der Prioqueue.

*prioqueueName* **remove** *item*
: Entfernt das angegebene Element aus dieser Prioritätswarteschlange.

*prioqueueName* **destroy**
: Zerstört die Prioqueue einschließlich ihres Speichers und des zugehörigen Befehls.

*prioqueueName* **get** ?*count*?
: Gibt die ersten *count* Elemente der Prioritätswarteschlange zurück (jedoch nicht deren Prioritäten) und entfernt sie aus der Prioritätswarteschlange. Wird *count* nicht angegeben, beträgt der Standardwert 1. Ist *count* gleich 1, ist das Ergebnis eine einfache Zeichenkette; andernfalls ist es eine Liste.  Falls angegeben, muss es größer oder gleich 1 sein.  Befinden sich keine oder zu wenige Elemente in der Prioritätswarteschlange, löst dieser Befehl einen Fehler aus.

*prioqueueName* **peek** ?*count*?
: Gibt die ersten *count* Elemente der Prioritätswarteschlange zurück (jedoch nicht deren Prioritäten), ohne sie aus der Prioritätswarteschlange zu entfernen. Wird *count* nicht angegeben, beträgt der Standardwert 1. Ist *count* gleich 1, ist das Ergebnis eine einfache Zeichenkette; andernfalls ist es eine Liste. Falls angegeben, muss *count* größer oder gleich 1 sein. Befinden sich keine oder zu wenige Elemente in der Warteschlange, löst dieser Befehl einen Fehler aus.

*prioqueueName* **peekpriority** ?*count*?
: Gibt die Prioritätsschlüssel der ersten *count* Elemente zurück, ohne die Elemente aus der Prioritätswarteschlange zu entfernen. Wird *count* nicht angegeben, beträgt der Standardwert 1.  Ist *count* gleich 1, ist das Ergebnis eine einfache Zeichenkette; andernfalls ist es eine Liste.  Falls angegeben, muss *count* größer oder gleich 1 sein.  Befinden sich keine oder zu wenige Elemente in der Warteschlange, löst dieser Befehl einen Fehler aus.

*prioqueueName* **put** *item prio* ?*item prio ...*?
: Fügt das angegebene *item* oder die angegebenen Elemente in die Prioqueue ein. *prio* muss ein gültiger Prioritätsschlüssel für diesen Prioqueue-Typ sein; andernfalls wird ein Fehler ausgelöst und es wird kein Element hinzugefügt. Elemente werden nach ihrem Prioritätsrang eingefügt. Elemente gleicher Priorität bleiben in der Reihenfolge, in der sie hinzugefügt wurden.

*prioqueueName* **size**
: Gibt die Anzahl der Elemente in der Prioritätswarteschlange zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: prioqueue* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2003 Michael Schlenker <mic42@users.sourceforge.net>
```
