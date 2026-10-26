---
CommandName: bench::out::csv
ManualSection: n
Version: 0.1.3
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench
 - bench::out::text
Keywords:
 - benchmark
 - csv
 - formatting
 - performance
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

bench::out::csv – bench::out::csv – Aufbereitung von Benchmark-Ergebnissen als CSV

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [bench::out::csv]{.lit} [0.1.3]{.optlit} 
[::bench::out::csv]{.cmd} [bench_result]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle zur Aufbereitung von Benchmark-Ergebnissen in eine CSV-Tabelle, die in Tabellenkalkulationsprogramme importiert werden kann.

Leser, die sich für die Erstellung oder Verarbeitung solcher Ergebnisse interessieren, sollten stattdessen *bench – Verarbeitung von Benchmark-Suiten* lesen.

Wenn die Bench-Sprache selbst Ihr eigentliches Interesse ist, beginnen Sie bitte mit der *Einleitung in die Bench-Sprache* und fahren Sie anschließend mit der formalen *Spezifikation der Bench-Sprache* fort.

# ÖFFENTLICHE API

**::bench::out::csv** *bench_result*
: Dieser Befehl formatiert das angegebene Benchmark-Ergebnis für die Ausgabe in eine Datei, einen Socket usw. Dieser spezielle Befehl erzeugt CSV-Daten, die in Tabellenkalkulationsprogramme importiert werden können. Weitere Formatierungsoptionen finden Sie in den Paketen **bench** und **bench::out::text**, die Befehle zur Formatierung von Benchmark-Ergebnissen im Rohformat bzw. zur besseren Lesbarkeit für den Menschen bereitstellen.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *bench* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Benchmark-Werkzeuge

# COPYRIGHT

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
