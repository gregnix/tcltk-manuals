---
CommandName: bench
title: bench
ManualSection: n
Version: 0.6
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench_intro
 - bench_lang_intro
 - bench_lang_spec
 - bench_read
 - bench_wcsv
 - bench_wtext
Keywords:
 - benchmark
 - merging
 - normalization
 - performance
 - testing
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

bench – Verarbeitung von Benchmark-Suiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [bench]{.lit} [0.6]{.optlit}
[::bench::locate]{.cmd} [pattern]{.arg} [paths]{.arg}
[::bench::run]{.cmd} [option value...]{.optarg} [interp\_list]{.arg} [file...]{.arg}
[::bench::versions]{.cmd} [interp\_list]{.arg}
[::bench::del]{.cmd} [bench\_result]{.arg} [column]{.arg}
[::bench::edit]{.cmd} [bench\_result]{.arg} [column]{.arg} [newvalue]{.arg}
[::bench::merge]{.cmd} [bench\_result...]{.arg}
[::bench::norm]{.cmd} [bench\_result]{.arg} [column]{.arg}
[::bench::out::raw]{.cmd} [bench\_result]{.arg}
:::

# Beschreibung

Dieses Paket enthält Befehle zur Ausführung von Benchmarks, die in der Bench-Sprache geschrieben sind, sowie zur Verarbeitung der bei dieser Ausführung erzeugten Ergebnisse.

Ein Leser, der sich für die Bench-Sprache selbst interessiert, beginnt mit der *Einleitung in die Bench-Sprache* und geht von dort zur formalen *Spezifikation der Bench-Sprache* weiter.

# Öffentliche API

## Durchführung des Benchmark-Tests

**::bench::locate** *pattern* *paths*
: Dieser Befehl ermittelt Tcl-Interpreter und gibt eine Liste mit deren Pfaden zurück. Er durchsucht die vom Aufrufer angegebene Liste der *paths* unter Verwendung des Glob-*pattern*.

    Der Befehl löst symbolische Links auf, um die tatsächlichen ausführbaren Dateien zu finden, die dem Muster entsprechen. Nur Interpreter, die als ausführbar markiert sind und auf der aktuellen Plattform tatsächlich ausführbar sind, werden in das Ergebnis aufgenommen.

**::bench::run** ?*option value*...? *interp\_list* *file*...
: Dieser Befehl führt die in der Dateimenge deklarierten Benchmarks einmal je über die *interp\_list* angegebenen Tcl-Interpreter und gemäß der durch die Optionen festgelegten Konfiguration aus und gibt anschließend die kumulierten Zeitmessungsergebnisse zurück. Das Format dieses Ergebnisses wird im Abschnitt [Ergebnisformat] beschrieben.

    Es wird davon ausgegangen, dass der Inhalt der Dateien in der Bench-Sprache verfasst ist.

    Die verfügbaren Optionen sind

    **-errors** *flag*
    : Das Argument ist ein boolescher Wert. Wenn dieser Wert gesetzt ist, werden Fehler in Benchmarks an den Befehl weitergeleitet, wodurch die Ausführung des Benchmarks abgebrochen wird. Andernfalls werden sie über einen speziellen Ergebniscode im Zeitmessungsergebnis erfasst. Standardmäßig erfolgt eine Weiterleitung und ein Abbruch.

    **-threads** *n*
    : Das Argument ist ein nicht-negativer Wert für die Anzahl der Threads, die bei der Ausführung der Benchmarks verwendet werden sollen. Der Standardwert ist **0**, was bedeutet, dass keine Threads verwendet werden.

    **-match** *pattern*
    : Das Argument ist ein Glob-Muster. Es werden nur Benchmarks ausgeführt, deren Beschreibung mit dem Muster übereinstimmt. Der Standardwert ist die leere Zeichenkette, wodurch alle Benchmarks ausgeführt werden.

    **-rmatch** *pattern*
    : Das Argument ist ein Muster für einen regulären Ausdruck. Es werden nur Benchmarks ausgeführt, deren Beschreibung mit dem Muster übereinstimmt. Der Standardwert ist die leere Zeichenfolge, wodurch alle Benchmarks ausgeführt werden.

    **-iters** *n*
    : Das Argument ist eine positive ganze Zahl, die die maximale Anzahl an Iterationen für einen beliebigen Benchmark angibt. Der Standardwert lautet **1000**. Einzelne Benchmarks können diesen Wert überschreiben.

    **-pkgdir** *path*
    : Das Argument ist ein Pfad zu einem vorhandenen, lesbaren Verzeichnis. Es können mehrere Pfade angegeben werden; verwenden Sie dazu die Option einfach mehrmals, wobei Sie jedes Mal einen der zu verwendenden Pfade angeben.

        Wenn keine Pfade angegeben wurden, verhält sich das System wie bisher. Wenn ein oder mehrere Pfade festgelegt werden, beispielsweise **N**, wird jeder der festgelegten Interpreter **N**-mal mit einem der festgelegten Pfade aufgerufen. Der ausgewählte Pfad wird in die Variable **auto\_path** des Interpreters übernommen, wodurch diese bestimmte Versionen eines Pakets finden können.

        Auf diese Weise ermöglicht die Verwendung von **-pkgdir** dem Benutzer, mehrere verschiedene Versionen eines Pakets im Vergleich zu einem oder mehreren Interpretern zu testen.

        *Hinweis:* Eine leere Zeichenkette ist als Pfad zulässig und bewirkt, dass das System die angegebenen Interpreter mit einem unveränderten **auto\_path** ausführt – sofern das betreffende Paket dort ebenfalls verfügbar ist.


**::bench::versions** *interp\_list*
: Dieser Befehl nimmt eine Liste von Tcl-Interpretern entgegen, die durch ihren Pfad identifiziert werden, und gibt ein Dictionary zurück, das die Interpreter ihren Versionen zuordnet. Interpreter, die nicht tatsächlich ausführbar sind oder bei der Abfrage einen Fehler zurückgeben, werden nicht in das Ergebnis aufgenommen. Das bedeutet, dass das Ergebnis möglicherweise weniger Interpreter enthält als in der Eingabeliste vorhanden sind.

    Der Befehl verwendet den integrierten Befehl **info patchlevel**, um die Version jedes Interpreters zu ermitteln.


## Ergebnismanipulation

**::bench::del** *bench\_result* *column*
: Dieser Befehl entfernt eine Spalte, d. h. alle Benchmark-Ergebnisse für einen bestimmten Tcl-Interpreter, aus dem angegebenen Benchmark-Ergebnis und gibt das geänderte Ergebnis zurück.

    Die Benchmark-Ergebnisse liegen in dem in Abschnitt [Ergebnisformat] beschriebenen Format vor.

    Die Spalten werden durch eine ganzzahlige Nummer identifiziert.

**::bench::edit** *bench\_result* *column* *newvalue*
: Dieser Befehl benennt eine Spalte im angegebenen Benchmark-Ergebnis um und gibt das geänderte Ergebnis zurück. Das bedeutet, dass der Pfad zum Tcl-Interpreter in der angegebenen Spalte in eine beliebige Zeichenfolge geändert wird.

    Die Benchmark-Ergebnisse liegen in dem im Abschnitt [Ergebnisformat] beschriebenen Format vor.

    Die Spalte wird durch eine ganzzahlige Nummer gekennzeichnet.

**::bench::merge** *bench\_result*...
: Dieser Befehl nimmt ein oder mehrere Benchmark-Ergebnisse entgegen, fasst diese zu einem einzigen großen Ergebnis zusammen und gibt dieses als Ergebnis zurück.

    Alle Benchmark-Ergebnisse liegen in dem im Abschnitt [Ergebnisformat] beschriebenen Format vor.

**::bench::norm** *bench\_result* *column*
: Dieser Befehl normalisiert die Zeitmessungsergebnisse anhand des angegebenen Benchmark-Ergebnisses und gibt das modifizierte Ergebnis zurück. Das bedeutet, dass die Zellwerte keine Zeitangaben mehr sind, sondern Faktoren, die angeben, um wie viel schneller oder langsamer die Ausführung im Vergleich zur Basislinie war.

    Die Basislinie, anhand derer der Befehl die Normalisierung vornimmt, sind die Zeitmessungsergebnisse in der ausgewählten Spalte. Das bedeutet, dass nach der Normalisierung die Werte in dieser Spalte alle den Wert **1** annehmen, da diese Benchmarks weder schneller noch langsamer als die Basislinie sind.

    Ein Faktor kleiner als **1** weist auf einen Benchmark hin, der schneller als die Basislinie war, während ein Faktor größer als **1** auf eine langsamere Ausführung hinweist.

    Die Benchmark-Ergebnisse liegen in dem im Abschnitt [Ergebnisformat] beschriebenen Format vor.

    Die Spalten werden durch eine ganze Zahl gekennzeichnet.

**::bench::out::raw** *bench\_result*
: Dieser Befehl formatiert das angegebene Benchmark-Ergebnis für die Ausgabe in eine Datei, einen Socket usw. Dieser spezielle Befehl führt keinerlei Formatierung durch, sondern leitet die Eingabe unverändert weiter.

    Weitere Formatierungsstile finden Sie in den Paketen **bench::out::text** und **bench::out::csv**, die Befehle zur Formatierung von Benchmark-Ergebnissen für die menschliche Lesbarkeit bzw. als CSV-Daten zum Import in Tabellenkalkulationsprogramme bereitstellen.

    Um Benchmark-Ergebnisse aus Dateien, Sockets usw. einzulesen, nutzen Sie bitte das Paket **bench::in** und die darin enthaltenen Befehle.


## Ergebnisformat

Nach der Ausführung einer Reihe von Benchmarks gibt dieses Paket als Rohergebnis ein Tcl-Dictionary zurück, das alle relevanten Informationen enthält. Das Dictionary ist eine kompakte Darstellung – d. h. eine Serialisierung – einer zweidimensionalen Tabelle, deren Spalten Tcl-Interpreter und deren Zeilen Benchmarks enthalten. Die Zellen der Tabelle enthalten die Zeitmessungsergebnisse. Die Tcl-Interpreter (Spalten) werden anhand ihrer Pfade identifiziert. Die Benchmarks (Zeilen) werden anhand ihrer Beschreibung identifiziert.

Die möglichen Schlüssel sind allesamt gültige Tcl-Listen mit zwei oder drei Elementen und weisen eine der folgenden Formen auf:

{interp \*}
: Die Schlüssel, die diesem Glob-Muster entsprechen, enthalten Informationen zu allen Tcl-Interpretern, die zur Ausführung der Benchmarks verwendet wurden. Das zweite Element des Schlüssels ist der Pfad zum Interpreter.

    Der zugehörige Wert ist die Version des Tcl-Interpreters.

{desc \*}
: Die Schlüssel, die diesem Glob-Muster entsprechen, erfassen die Informationen zu allen Benchmarks, die in der ausgeführten Benchmark-Suite gefunden wurden. Das zweite Element des Schlüssels ist die Beschreibung des Benchmarks, die eindeutig sein muss.

    Der zugehörige Wert ist irrelevant und wird auf die leere Zeichenkette gesetzt.

{usec \* \*}
: Die Schlüssel, die diesem Glob-Muster entsprechen, erfassen die Leistungsdaten, d. h. die Zeitmessungsergebnisse. Das zweite Element des Schlüssels ist die Beschreibung des Benchmarks, das dritte Element der Pfad des Tcl-Interpreters, mit dem dieser ausgeführt wurde.

    Der zugehörige Wert ist entweder einer von mehreren speziellen Ergebniscodes oder die Zeit, die für die Ausführung des Benchmarks benötigt wurde, in Mikrosekunden. Die möglichen speziellen Ergebniscodes sind

    ERR
    : Der Benchmark konnte nicht ausgeführt werden; es trat ein Tcl-Fehler auf.

    BAD\_RES
    : Der Benchmark konnte zwar ausgeführt werden, das Ergebnis aus seinem Rumpf entsprach jedoch nicht den angegebenen Erwartungen.



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *bench* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Benchmark-Werkzeuge

# Copyright

```
Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
