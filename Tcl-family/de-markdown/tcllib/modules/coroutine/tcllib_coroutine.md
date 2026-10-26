---
CommandName: coroutine
title: coroutine
ManualSection: n
Version: 1.4
TclPart: tcllib
TclDescription: Coroutine utilities
Keywords:
 - after
 - channel
 - coroutine
 - events
 - exit
 - gets
 - global
 - green threads
 - read
 - threads
 - update
 - vwait
Copyright:
 - Copyright (c) 2010-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

Coroutine – Coroutinen-basierte Ereignis- und E/A-Verarbeitung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [coroutine]{.lit} [1.4]{.lit}
[coroutine::util]{.cmd} [after]{.sub} [delay]{.arg}
[coroutine::util]{.cmd} [await]{.sub} [varname...]{.arg}
[coroutine::util]{.cmd} [create]{.sub} [arg...]{.arg}
[coroutine::util]{.cmd} [exit]{.sub} [status]{.optarg}
[coroutine::util]{.cmd} [gets]{.sub} [chan]{.arg} [varname]{.optarg}
[coroutine::util]{.cmd} [gets\_safety]{.sub} [chan]{.arg} [limit]{.arg} [varname]{.arg}
[coroutine::util]{.cmd} [global]{.sub} [varname...]{.arg}
[coroutine::util]{.cmd} [puts]{.sub} [-nonewline]{.optlit} [channel]{.arg} [string]{.arg}
[coroutine::util]{.cmd} [read]{.sub} [-nonewline]{.lit} [chan]{.arg} [n]{.optarg}
[coroutine::util]{.cmd} [socket]{.sub} [options...]{.optarg} [host]{.arg} [port]{.arg}
[coroutine::util]{.cmd} [update]{.sub} [idletasks]{.optlit}
[coroutine::util]{.cmd} [vwait]{.sub} [varname]{.arg}
:::

# Beschreibung

Das **coroutine**-Paket bietet Coroutinen-fähige Implementierungen verschiedener ereignis- und kanalbezogener Befehle. Es kann in verschiedenen Modi ausgeführt werden:

1. Rufen Sie die Befehle über ihr Ensemble auf – in Code, der ausdrücklich für die Verwendung innerhalb von Coroutinen geschrieben wurde.

2. Importieren Sie die Befehle in einen Namespace, entweder direkt oder über **namespace path**. Dies ermöglicht die Verwendung innerhalb von Code, der an sich nicht coroutinenfähig ist und auf bestimmte Namespaces beschränkt ist.


Eine noch weitergehende Möglichkeit, Code „coroutinenunabhängig“ zu gestalten als in Punkt 2 oben beschrieben, bietet das Paket [coroutine::auto][coro_auto]. Dieses fängt die entsprechenden integrierten Befehle ab und ändert deren Implementierung je nach Ausführungsumgebung, d. h. je nachdem, ob sie innerhalb oder außerhalb einer Coroutine ausgeführt werden.

# API

Alle unten aufgeführten Befehle laufen synchron zur Coroutine ab, die sie aufruft, d. h., diese Coroutine wird so lange blockiert, bis das Ergebnis vorliegt. Die übergeordnete Ereignisschleife wird dadurch jedoch nicht blockiert.

**coroutine::util after** *delay*
: Dieser Befehl verzögert die Coroutine, die ihn aufruft, um *delay* Millisekunden.

**coroutine::util await** *varname*...
: Dieser Befehl ist eine Erweiterung des Befehls **coroutine::util vwait** (siehe unten), der auf einen Schreibvorgang in eine von mehreren benannten Namespace-Variablen wartet.

**coroutine::util create** *arg*...
: Dieser Befehl erstellt eine neue Coroutine mit einem automatisch zugewiesenen Namen und sorgt dafür, dass diese den durch die Argumente angegebenen Code ausführt.

**coroutine::util exit** ?*status*?
: Dieser Befehl beendet die aktuelle Coroutine, wodurch der Wert *status* zurückgegeben wird. Wurde kein Status festgelegt, gibt der Befehl den Standardwert *0* zurück.

**coroutine::util gets** *chan* ?*varname*?
: Dieser Befehl liest eine Zeile aus dem Kanal *chan* und gibt sie entweder als Ergebnis zurück oder schreibt sie – wenn ein *varname* festgelegt wurde – in die angegebene Variable und gibt die Anzahl der gelesenen Zeichen zurück.

**coroutine::util gets\_safety** *chan* *limit* *varname*
: Dieser Befehl liest eine Zeile aus dem Kanal *chan* bis zur Größe *limit* und speichert das Ergebnis in *varname*. Wird *limit* erreicht, bevor die festgelegte erste Zeilenumbruchstelle erreicht ist, wird ein Fehler ausgelöst. Der Befehl gibt die Anzahl der gelesenen Zeichen zurück.

**coroutine::util global** *varname*...
: Dieser Befehl importiert die benannten globalen Variablen der Coroutine in den aktuellen Gültigkeitsbereich. Aus technischer Sicht befinden sich diese Variablen auf Ebene **#1** des Tcl-Stacks. Das heißt, es handelt sich nicht um reguläre globale Variablen im globalen Namespace, und jede Coroutine kann ihren eigenen Satz haben, unabhängig von allen anderen.

**coroutine::util puts** ?**-nonewline**? *channel* *string*
: Dieser Befehl schreibt die Zeichenkette in den angegebenen *Kanal*. Im Gegensatz zur integrierten Funktion **puts** wartet dieser Befehl, bis der *Kanal* beschreibbar ist, bevor er tatsächlich darin schreibt.

**coroutine::util read** **-nonewline** *chan* ?*n*?
: Dieser Befehl liest *n* Zeichen aus dem Kanal *chan* und gibt sie als Ergebnis zurück. Wenn *n* nicht festgelegt wird, liest der Befehl so lange aus dem Kanal, bis das EOF erreicht ist.

**coroutine::util socket** ?*options...*? *host* *port*
: Dieser Befehl stellt eine Verbindung zum angegebenen Host und Port her und gibt zurück, sobald dies geschehen ist. Im Gegensatz zum integrierten Befehl führt er eine nicht-blockierende Verbindung im Hintergrund durch. Daher wird zwar die aufrufende Coroutine blockiert, die gesamte Anwendung wird jedoch nicht blockiert.

**coroutine::util update** ?**idletasks**?
: Dieser Befehl bewirkt, dass die Coroutine, die ihn aufruft, ausstehende Ereignisse oder Leerlauf-Handler ausführt, bevor sie fortfährt.

**coroutine::util vwait** *varname*
: Dieser Befehl bewirkt, dass die Coroutine, die ihn aufruft, auf einen Schreibvorgang in die benannte Namespace-Variable *varname* wartet.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *coroutine* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Coroutine

# Copyright

```
Copyright (c) 2010-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[coro_auto]: coro_auto.md
