---
CommandName: grammar::fa::dacceptor
ManualSection: n
Version: 0.1.2
TclPart: tcllib
TclDescription: Finite automaton operations and usage
Keywords:
 - acceptance
 - acceptor
 - automaton
 - finite automaton
 - grammar
 - parsing
 - regular expression
 - regular grammar
 - regular languages
 - state
 - transducer
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

grammar::fa::dacceptor – Erstellen und Verwenden deterministischer Akzeptoren

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [struct::set]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::fa::dacceptor]{.lit} [0.1.2]{.optlit} 
[::grammar::fa::dacceptor]{.cmd} [daName]{.arg} [fa]{.arg} [-any any]{.optarg} 
[daName]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[daName]{.ins} [destroy]{.sub} 
[daName]{.ins} [accept?]{.sub} [symbols]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse für Akzeptoren bereit, die aus deterministischen *endlichen Automaten* (DFA) aufgebaut sind. Akzeptoren sind Objekte, denen eine Folge von Symbolen übergeben werden kann und die angeben, ob der DFA, aus dem sie aufgebaut sind, diese Folge *akzeptieren* würde. Für die eigentliche Erstellung der DFAs, auf denen die Akzeptoren basieren, stehen die Pakete **grammar::fa** und **grammar::fa::op** zur Verfügung.

# API

Das Paket exportiert die hier beschriebene API.

**::grammar::fa::dacceptor** *daName* *fa* ?**-any** *any*?
: Erstellt einen neuen deterministischen Akzeptor mit einem zugehörigen globalen Tcl-Befehl, dessen Name *daName* lautet. Mit diesem Befehl können verschiedene Operationen auf dem Akzeptor aufgerufen werden. Er hat die folgende allgemeine Form:


**daName** *option* ?*arg arg ...*?
: *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Weitere Erläuterungen finden Sie im Abschnitt **AKZEPTORMETHODEN**. Der Akzeptor basiert auf dem deterministischen endlichen Automaten, der im Objekt *fa* gespeichert ist. Er bewahrt eine Kopie der relevanten Daten des FA in seinem eigenen Speicher auf, und zwar in einer Form, die für seine Zwecke leicht zu verwenden ist. Dies bedeutet auch, dass Änderungen, die nach der Erstellung des Akzeptors am *fa* vorgenommen werden, den Akzeptor *nicht* beeinflussen. Wenn *any* festgelegt wurde, wandelt der Akzeptor alle Symbole in der Eingabe, die dem Basis-FA unbekannt sind, in dieses Symbol um, bevor er mit der Verarbeitung fortfährt.


# AKZEPTORMETHODEN

Alle Akzeptoren stellen die folgenden Methoden zu ihrer Handhabung bereit:

*daName* **destroy**
: Löscht den Automaten einschließlich seines Speicherplatzes und des zugehörigen Befehls.

*daName* **accept?** *symbols*
: Nimmt die Liste der *symbols* entgegen und prüft, ob der FA, auf dem der Akzeptor basiert, sie akzeptieren würde. Das Ergebnis ist ein boolescher Wert. **True** wird zurückgegeben, wenn die Symbole akzeptiert werden, andernfalls **False**. Zu beachten ist, dass ungültige Symbole in der Eingabe entweder in das Symbol *any* umgewandelt werden (falls es angegeben ist) oder dazu führen, dass der Akzeptanztest einfach fehlschlägt. Es werden keine Fehler ausgelöst. Die Methode verarbeitet nur genau das Präfix der Eingabe, das ausreicht, um die (Nicht-)Akzeptanz vollständig zu bestimmen.


# BEISPIELE

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *grammar_fa* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Grammatiken und endliche Automaten

# COPYRIGHT

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
