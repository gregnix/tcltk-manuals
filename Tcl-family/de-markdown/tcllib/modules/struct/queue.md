---
CommandName: struct::queue
title: struct::queue
ManualSection: n
Version: 1.4.6
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - graph
 - list
 - matrix
 - pool
 - prioqueue
 - record
 - set
 - skiplist
 - stack
 - tree
Copyright:
---

# Name

struct::queue – Warteschlangenobjekte anlegen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::queue]{.lit} [1.4.6]{.optlit}
[queueName]{.ins} [option]{.sub} [arg arg]{.optdot}
[queueName]{.ins} [clear]{.sub}
[queueName]{.ins} [destroy]{.sub}
[queueName]{.ins} [get]{.sub} [count]{.optarg}
[queueName]{.ins} [peek]{.sub} [count]{.optarg}
[queueName]{.ins} [put]{.sub} [item]{.arg} [item]{.optdot}
[queueName]{.ins} [unget]{.sub} [item]{.arg}
[queueName]{.ins} [size]{.sub}
:::

# Beschreibung

Der Namespace **::struct** enthält Befehle zur Verarbeitung endlicher Warteschlangen.

Er exportiert einen einzigen Befehl: **::struct::queue**. Alle hier bereitgestellten Funktionen sind über einen Unterbefehl dieses Befehls aufrufbar.

*Hinweis:* Ab Version 1.4.1 dieses Pakets steht eine auf critcl basierende C-Implementierung zur Verfügung. Diese Implementierung erfordert jedoch Tcl 8.4.

Der Befehl **::struct::queue** erzeugt ein neues Warteschlangenobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *queueName* lautet. Mit diesem Befehl lassen sich verschiedene Operationen auf der Warteschlange aufrufen. Er hat die folgende allgemeine Form:

*queueName* **option** ?*arg arg ...*?
: *Option* und die *arg*s legen das genaue Verhalten des Befehls fest. Für Warteschlangenobjekte sind folgende Befehle möglich:

*queueName* **clear**
: Entfernt alle Elemente aus der Warteschlange.

*queueName* **destroy**
: Zerstört die Warteschlange einschließlich ihres Speichers und des zugehörigen Befehls.

*queueName* **get** ?*count*?
: Gibt die ersten *count* Elemente der Warteschlange zurück und entfernt sie aus der Warteschlange.  Wird *count* nicht angegeben, beträgt der Standardwert 1.  Ist *count* gleich 1, ist das Ergebnis eine einfache Zeichenkette; andernfalls ist es eine Liste.  Falls angegeben, muss es größer oder gleich 1 sein. Befinden sich nicht genügend Elemente in der Warteschlange, um die Anforderung zu erfüllen, löst dieser Befehl einen Fehler aus.

*queueName* **peek** ?*count*?
: Gibt die ersten *count* Elemente der Warteschlange zurück, ohne sie aus der Warteschlange zu entfernen. Wird *count* nicht angegeben, beträgt der Standardwert 1. Ist *count* gleich 1, ist das Ergebnis eine einfache Zeichenkette; andernfalls ist es eine Liste.  Falls angegeben, muss es größer oder gleich 1 sein. Befinden sich nicht genügend Elemente in der Warteschlange, um die Anforderung zu erfüllen, löst dieser Befehl einen Fehler aus.

*queueName* **put** *item* ?*item ...*?
: Fügt das angegebene *item* oder die angegebenen Elemente in die Warteschlange ein. Wird mehr als ein *item* angegeben, werden die Elemente in der Reihenfolge hinzugefügt, in der sie aufgeführt sind.

*queueName* **unget** *item*
: Fügt das *item* am Anfang der Warteschlange ein, d. h. vor alle anderen Elemente, die sich bereits in der Warteschlange befinden. Damit bildet dieser Vorgang das Gegenstück zur Methode **get**.

*queueName* **size**
: Gibt die Anzahl der Elemente in der Warteschlange zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: queue* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen
