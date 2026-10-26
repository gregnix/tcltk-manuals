---
CommandName: struct::stack
title: struct::stack
ManualSection: n
Version: 1.5.4
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - graph
 - matrix
 - queue
 - tree
Copyright:
---

# Name

struct::stack – Stapelobjekte anlegen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::stack]{.lit} [1.5.4]{.optlit}
[stackName]{.ins} [option]{.sub} [arg arg]{.optdot}
[stackName]{.ins} [clear]{.sub}
[stackName]{.ins} [destroy]{.sub}
[stackName]{.ins} [get]{.sub}
[stackName]{.ins} [getr]{.sub}
[stackName]{.ins} [peek]{.sub} [count]{.optarg}
[stackName]{.ins} [peekr]{.sub} [count]{.optarg}
[stackName]{.ins} [trim]{.sub} [newsize]{.optarg}
[stackName]{.ins} [trim\*]{.sub} [newsize]{.optarg}
[stackName]{.ins} [pop]{.sub} [count]{.optarg}
[stackName]{.ins} [push]{.sub} [item]{.arg} [item...]{.optarg}
[stackName]{.ins} [size]{.sub}
:::

# Beschreibung

Der Namespace **::struct** enthält Befehle zur Verarbeitung endlicher Stapel.

Er exportiert einen einzigen Befehl: **::struct::stack**. Alle hier bereitgestellten Funktionen sind über einen Unterbefehl dieses Befehls aufrufbar.

*Hinweis:* Ab Version 1.3.3 dieses Pakets steht eine auf critcl basierende C-Implementierung zur Verfügung. Diese Implementierung erfordert jedoch Tcl 8.4.

Der Befehl **::struct::stack** erzeugt ein neues Stapelobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *stackName* lautet. Mit diesem Befehl lassen sich verschiedene Operationen auf dem Stapel aufrufen. Er hat die folgende allgemeine Form:

*stackName* **option** ?*arg arg ...*?
: *Option* und die *arg*s legen das genaue Verhalten des Befehls fest. Für Stapelobjekte sind folgende Befehle möglich:

*stackName* **clear**
: Entfernt alle Elemente vom Stapel.

*stackName* **destroy**
: Zerstört den Stapel einschließlich seines Speichers und des zugehörigen Befehls.

*stackName* **get**
: Gibt den gesamten Inhalt des Stapels als Liste zurück, ohne die Elemente vom Stapel zu entfernen.

*stackName* **getr**
: Eine Variante von **get**, die den Inhalt in umgekehrter Reihenfolge zurückgibt.

*stackName* **peek** ?*count*?
: Gibt die obersten *count* Elemente des Stapels zurück, ohne sie vom Stapel zu entfernen. Wird *count* nicht angegeben, beträgt der Standardwert 1. Ist *count* gleich 1, ist das Ergebnis eine einfache Zeichenkette; andernfalls ist es eine Liste.  Falls angegeben, muss *count* größer oder gleich 1 sein. Befinden sich nicht genügend Elemente auf dem Stapel, um die Anforderung zu erfüllen, löst dieser Befehl einen Fehler aus.

*stackName* **peekr** ?*count*?
: Eine Variante von **peek**, die die Elemente in umgekehrter Reihenfolge zurückgibt.

*stackName* **trim** ?*newsize*?
: Verkleinert den Stapel so, dass er höchstens *newsize* Elemente enthält, und gibt eine Liste zurück, die die entfernten Elemente enthält. Nichts geschieht, wenn der Stapel bereits die angegebene Größe hat oder kleiner ist. In diesem Fall ist das Ergebnis eine leere Liste.

*stackName* **trim\*** ?*newsize*?
: Eine Variante von **trim**, die die Verkleinerung durchführt, die entfernten Elemente jedoch nicht zurückgibt.

*stackName* **pop** ?*count*?
: Gibt die obersten *count* Elemente des Stapels zurück und entfernt sie vom Stapel. Wird *count* nicht angegeben, beträgt der Standardwert 1. Ist *count* gleich 1, ist das Ergebnis eine einfache Zeichenkette; andernfalls ist es eine Liste.  Falls angegeben, muss *count* größer oder gleich 1 sein. Befinden sich nicht genügend Elemente auf dem Stapel, um die Anforderung zu erfüllen, löst dieser Befehl einen Fehler aus.

*stackName* **push** *item* ?*item...*?
: Legt das angegebene *item* bzw. die angegebenen Elemente auf den Stapel.  Wird mehr als ein *item* angegeben, werden die Elemente in der Reihenfolge ihrer Auflistung auf den Stapel gelegt.

*stackName* **size**
: Gibt die Anzahl der Elemente auf dem Stapel zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: stack* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen
