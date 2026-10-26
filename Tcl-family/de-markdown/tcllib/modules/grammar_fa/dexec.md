---
CommandName: grammar::fa::dexec
title: grammar::fa::dexec
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Finite automaton operations and usage
Keywords:
 - automaton
 - execution
 - finite automaton
 - grammar
 - parsing
 - regular expression
 - regular grammar
 - regular languages
 - running
 - state
 - transducer
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2007 Bogdan <rftghost@users.sourceforge.net>
---

# Name

grammar::fa::dexec – Ausführung deterministischer endlicher Automaten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [grammar::fa::dexec]{.lit} [0.3]{.optlit}
[::grammar::fa::dexec]{.cmd} [daName]{.arg} [fa]{.arg} [[-any]{.lit} [any]{.arg}]{.optarg} [[-command]{.lit} [cmdprefix]{.arg}]{.optarg}
[daName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[daName]{.ins} [destroy]{.sub}
[daName]{.ins} [put]{.sub} [symbol]{.arg}
[daName]{.ins} [reset]{.sub}
[daName]{.ins} [state]{.sub}
[cmdprefix]{.ins} [error]{.sub} [code]{.arg} [message]{.arg}
[cmdprefix]{.ins} [final]{.sub} [stateid]{.arg}
[cmdprefix]{.ins} [reset]{.sub}
[cmdprefix]{.ins} [state]{.sub} [stateid]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Klasse für Executors bereit, die auf deterministischen *endlichen Automaten* (DFA) basieren. Executors sind Objekte, denen eine Zeichenfolge stückweise übermittelt wird; sie führen Zustandsübergänge durch und melden zurück, sobald sie einen Endzustand erreichen oder einen Fehler in der Eingabe feststellen. Für die eigentliche Erstellung der DFAs, auf denen die Executors basieren, stehen die Pakete **grammar::fa** und **grammar::fa::op** zur Verfügung.

Die Objekte folgen einem Push-Modell. Symbole werden in den Executor übergeben, und wenn etwas Wichtiges geschieht – d. h. ein Fehler auftritt, ein Zustandsübergang stattfindet oder ein Endzustand erreicht wird –, wird dies über die Rückruffunktion gemeldet, die über die Option **-command** festgelegt wurde. Die Umstellung auf ein Pull-Modell, bei dem die Umgebung Nachrichten vom Objekt abruft und das Objekt über eine Rückruffunktion weitere Symbole anfordert, ist eine einfache Angelegenheit.

*Hinweis*: Die von **grammar::fa::dacceptor** bereitgestellten Akzeptorobjekte hätten auf der Grundlage der hier bereitgestellten Executors implementiert werden können, wurden jedoch aus Gründen der Leistungssteigerung nicht so umgesetzt (wir vermeiden dadurch eine Reihe von Aufrufen von Methoden und die dafür erforderliche Zeit).

# API

Das Paket exportiert die hier beschriebene API.

**::grammar::fa::dexec** *daName* *fa* ?**-any** *any*? ?**-command** *cmdprefix*?
: Erstellt einen neuen deterministischen Executor mit einem zugehörigen globalen Tcl-Befehl, dessen Name *daName* lautet. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Executor auszuführen. Er hat die folgende allgemeine Form:

    **daName** *option* ?*arg arg ...*?
    : *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Weitere Erläuterungen finden Sie im Abschnitt [Executor-Methoden].

        Der Executor basiert auf dem deterministischen endlichen Automaten, der im Objekt *fa* gespeichert ist. Er bewahrt eine Kopie der relevanten Daten des FA in seinem eigenen Speicher auf, und zwar in einer Form, die für seine Zwecke leicht zu verwenden ist. Dies bedeutet auch, dass Änderungen, die nach der Erstellung des Executors am *fa* vorgenommen werden, den Executor *nicht* beeinflussen.

        Wenn *any* festgelegt wurde, wandelt der Executor alle Symbole in der Eingabe, die dem Basis-FA unbekannt sind, in dieses Symbol um, bevor er mit dem Prozess fortfährt.



# Executor-Methoden

Alle Executors stellen die folgenden Methoden für deren Bearbeitung bereit:

*daName* **destroy**
: Löscht den Automaten einschließlich seines Speicherplatzes und des zugehörigen Befehls.

*daName* **put** *symbol*
: Übernimmt den aktuellen Zustand des Executors und das *symbol* und führt den entsprechenden Zustandsübergang durch. Meldet über die Rückruffunktion des Befehls sowohl aufgetretene Fehler als auch das Erreichen eines Endzustands des zugrunde liegenden FA.

    Wenn ein Fehler gemeldet wird, führen alle weiteren Aufrufe von **put** keine Aktion aus, bis die Fehlerbedingung durch einen Aufruf der Methode **reset** behoben wurde.

*daName* **reset**
: Setzt den Executor bedingungslos in den Startzustand der zugrunde liegenden FA. Dadurch werden zudem etwaige Fehlerzustände, auf die **put** möglicherweise gestoßen ist, zurückgesetzt.

*daName* **state**
: Gibt den aktuellen Zustand des zugrunde liegenden FA zurück. Dies ermöglicht eine Introspektion, ohne dass Daten aus der Rückruffunktion übergeben werden müssen.


# Rückruffunktion des Executors

Die Rückruffunktion *cmdprefix*, die einem Executor über die Option **-command** übergeben wird, wird vom Objekt auf globaler Ebene unter Verwendung der unten beschriebenen Syntax ausgeführt. Beachten Sie, dass *cmdprefix* nicht einfach der Name eines Befehls ist, sondern ein vollständiges Befehlspräfix. Mit anderen Worten: Es kann zusätzlich zum Befehlswort weitere feste Argumentwörter enthalten.

*cmdprefix* **error** *code* *message*
: Beim Executor ist ein Fehler aufgetreten, und *message* enthält einen für Menschen lesbaren Text, der die Art des Problems erläutert. Der *code* hingegen ist ein festgelegter, maschinenlesbarer Text. Die folgenden Fehlercodes können von Executor-Objekten generiert werden.

    **BADSYM**
    : In der Eingabe wurde ein unbekanntes Symbol gefunden. Dies kann genau dann vorkommen, wenn kein Symbol „**-any**“ festgelegt wurde.

    **BADTRANS**
    : Der zugrunde liegende FA weist für die aktuelle Kombination aus Eingabesymbol und Zustand keinen Übergang auf. Mit anderen Worten: Der Executor war nicht in der Lage, für diese Kombination einen neuen Zustand zu berechnen.


*cmdprefix* **final** *stateid*
: Der Executor ist in den Endzustand *stateid* übergegangen.

*cmdprefix* **reset**
: Der Executor wurde zurückgesetzt.

*cmdprefix* **state** *stateid*
: Der Zustand des FA hat sich aufgrund eines Übergangs geändert. *stateid* ist der neue Zustand.


# Beispiele

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar\_fa* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Grammatiken und endliche Automaten

# Copyright

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2007 Bogdan <rftghost@users.sourceforge.net>
```
