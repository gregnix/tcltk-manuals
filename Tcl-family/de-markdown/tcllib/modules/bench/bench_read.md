---
CommandName: bench::in
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench
 - bench::out::csv
 - bench::out::text
 - bench_intro
Keywords:
 - benchmark
 - csv
 - formatting
 - human readable
 - parsing
 - performance
 - reading
 - testing
 - text
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

bench::in – bench::in – Lesen von Benchmark-Ergebnissen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [csv]{.lit} 
[package]{.cmd} [require]{.sub} [bench::in]{.lit} [0.2]{.optlit} 
[::bench::in::read]{.cmd} [file]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Befehl zum Einlesen von Benchmark-Ergebnissen aus Dateien, Sockets usw.

Leser, die sich für die Erstellung, die Verarbeitung oder das Schreiben solcher Ergebnisse interessieren, sollten stattdessen den Artikel *bench – Verarbeitung von Benchmark-Suiten* lesen.

Wenn die Bench-Sprache selbst Ihr eigentliches Interesse ist, beginnen Sie bitte mit der *Einleitung in die Bench-Sprache* und fahren Sie anschließend mit der formalen *Spezifikation der Bench-Sprache* fort.

# ÖFFENTLICHE API

**::bench::in::read** *file*
: Dieser Befehl liest ein Benchmark-Ergebnis aus der angegebenen *file* ein und gibt es als Ergebnis zurück. Der Befehl erkennt die drei Formate, die von den folgenden Befehlen erstellt werden:


**bench::out::raw**
: Bereitgestellt durch das Paket **bench**.

**bench::out::csv**
: Bereitgestellt durch das Paket **bench::out::csv**.

**bench::out::text**
: Bereitgestellt durch das Paket **bench::out::text**.


und erkennt automatisch, welches Format in der Eingabedatei verwendet wird.

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
