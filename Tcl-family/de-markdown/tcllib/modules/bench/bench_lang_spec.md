---
CommandName: bench_lang_spec
title: bench_lang_spec
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - bench_intro
 - bench_lang_intro
Keywords:
 - bench language
 - benchmark
 - performance
 - specification
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bench\_lang\_spec – Spezifikation der Bench-Sprache

# Übersicht

::: {.synopsis} :::
[bench\_rm]{.cmd} [path...]{.arg}
[bench\_tmpfile]{.cmd}
[bench]{.cmd} [options...]{.arg}
:::

# Beschreibung

Dieses Dokument legt sowohl die Namen als auch die Syntax aller Befehle fest, die zusammen die „Bench-Sprache“, Version 1, bilden. Da dieses Dokument als Nachschlagewerk gedacht ist, sind die Befehle in alphabetischer Reihenfolge aufgeführt, und die Beschreibungen sind relativ kurz gehalten. Anfängern wird empfohlen, zunächst die eher informell verfasste *Einleitung in die Bench-Sprache* zu lesen.

# Befehle

**bench\_rm** *path*...
: Dieser Befehl löscht die als Argumente festgelegten Dateien ohne Rückmeldung und gibt anschließend die leere Zeichenkette als Ergebnis zurück. Der Befehl gilt als *vertrauenswürdig*; es wird nicht überprüft, ob sich die festgelegten Dateien außerhalb des eingeschränkten Bereichs befinden, in dem die Benchmarks ausgeführt werden.

**bench\_tmpfile**
: Dieser Befehl gibt den Pfad zu einer benchspezifischen, eindeutigen temporären Datei zurück. Die Eindeutigkeit bedeutet, dass mehrere Aufrufe unterschiedliche Pfade zurückgeben. Der Pfad kann zwar aus früheren Ausführungen stammen, der Befehl selbst erstellt jedoch *keine* Dateien.

    Der Speicherort der temporären Dateien ist plattformabhängig:

    Unix und unbestimmte Plattform
    : "*/tmp*"

    Windows
    : **$TEMP**

    Alles andere
    : Das aktuelle Arbeitsverzeichnis.


**bench** *options*...
: Dieser Befehl deklariert einen einzelnen Benchmark. Sein Ergebnis ist die leere Zeichenkette. Alle Bestandteile des Benchmarks werden über Optionen und deren Werte deklariert. Die Optionen können in beliebiger Reihenfolge angegeben werden. Folgende Optionen werden akzeptiert:

    **-body** script
    : Das Argument dieser Option definiert den Rumpf des Benchmarks, d. h. das Tcl-Skript, dessen Leistung gemessen werden soll. Diese Option und **-desc** sind die beiden obligatorischen Bestandteile jedes Benchmarks.

    **-desc** msg
    : Das Argument dieser Option gibt den Namen des Benchmarks an. Dieser muss eindeutig sein, da sonst die Zeitmessdaten verschiedener Benchmarks miteinander vermischt werden.

        *Achtung!* Diese Anforderung wird bei der Ausführung der Benchmarks nicht überprüft, und das System erzeugt stillschweigend fehlerhafte Daten. Diese Option und **-body** sind die beiden erforderlichen Bestandteile jedes Benchmarks.

    **-ipost** script
    : Das Argument dieser Option deklariert ein Skript, das unmittelbar *nach* jeder Iteration des Rumpfes ausgeführt wird. Seine Aufgabe besteht darin, die vom Rumpf oder vom **-ipre**-Rumpf erstellten Ressourcen freizugeben, die nicht in die nächste Iteration übernommen werden sollen.

    **-ipre** script
    : Das Argument dieser Option deklariert ein Skript, das unmittelbar *vor* jeder Iteration des Rumpfes ausgeführt wird. Seine Aufgabe besteht darin, den vom Rumpf erwarteten Systemzustand herzustellen, damit die richtige Messung erfolgt.

    **-iterations** num
    : Das Argument dieser Option legt fest, wie oft der **-body** des Benchmarks maximal ausgeführt werden soll. Während der Ausführung werden dieser Wert und die globale maximale Anzahl an Iterationen verglichen, wobei der kleinere der beiden Werte verwendet wird.

        Diese Option sollte nur für Benchmarks verwendet werden, bei denen zu erwarten ist oder bekannt ist, dass ein Durchlauf viel Zeit in Anspruch nimmt. Das heißt, die Anzahl der Durchläufe sollte reduziert werden, um die Gesamtzeit für die Ausführung des gesamten Benchmarks in überschaubaren Grenzen zu halten.

    **-post** script
    : Das Argument dieser Option deklariert ein Skript, das *nach* der Ausführung aller Iterationen des Rumpfes ausgeführt wird. Seine Aufgabe besteht darin, die vom Rumpf oder vom **-pre**-Rumpf erstellten Ressourcen freizugeben.

    **-pre** script
    : Das Argument dieser Option deklariert ein Skript, das *vor* der Ausführung einer der Iterationen des Rumpfes ausgeführt wird. Seine Aufgabe besteht darin, alle Ressourcen bereitzustellen, die der Rumpf benötigt, um fehlerfrei ausgeführt zu werden.



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *bench* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Benchmark-Werkzeuge

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
