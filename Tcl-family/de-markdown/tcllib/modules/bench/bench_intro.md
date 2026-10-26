---
CommandName: bench_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench
 - bench_lang_faq
 - bench_lang_intro
 - bench_lang_spec
Keywords:
 - bench language
 - benchmark
 - performance
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

bench_intro – Einleitung zu „bench“

# BESCHREIBUNG

Der Begriff *bench* (kurz für *benchmark tools*) bezeichnet eine Reihe miteinander verbundener, aber dennoch unterschiedlicher Bestandteile, die zusammenwirken, um die einfache Erstellung und Ausführung von Leistungstestsuiten – auch als Benchmarks bezeichnet – zu ermöglichen. Dazu gehören

**\[1\]**
: Eine auf Tcl basierende Sprache zur Definition von Testfällen. Ein Testfall wird durch einen Tcl-Befehl dargestellt, der die verschiedenen zur Ausführung erforderlichen Bestandteile festlegt, wie z. B. die Vorbereitungs- und Aufräumschritte sowie die zu testenden Befehle usw.

**\[2\]**
: Ein Paket, das die Möglichkeit bietet, in dieser Sprache geschriebene Testfälle auszuführen. Welche der ausführlicheren Dokumente für den Leser dieser Einleitung relevant sind, hängt von seiner Rolle im Benchmarking-Prozess ab.

**\[1\]**
: Ein *Autor* von Benchmarks muss die Bench-Sprache selbst verstehen. Ein Anfänger im Bereich Bench liest zunächst die eher informell verfasste *Einleitung in die Bench-Sprache*. Nachdem er diese verinnerlicht hat, sollte die formale *Spezifikation der Bench-Sprache* verständlich werden. Ein mit Bench erfahrener Autor benötigt dieses letzte Dokument möglicherweise nur gelegentlich, um die Erinnerung aufzufrischen.

**\[2\]**
: Ein *Benutzer* von Benchmark-Suiten, die in der Sprache *bench* geschrieben sind, muss wissen, welche Werkzeuge zur Verfügung stehen. Auf der untersten Ebene befindet sich das Paket **bench**, das die grundlegenden Funktionen zum Lesen und Ausführen von Dateien mit in der Bench-Sprache geschriebenen Benchmarks sowie zur Bearbeitung der Benchmark-Ergebnisse bereitstellt.


# HISTORISCHE HINWEISE

Dieses Modul und dieses Paket basieren auf der Anwendung **tclbench** von Jeff Hobbs zur Leistungsmessung des Tcl-Kerns sowie auf deren Vorgänger "*runbench.tcl*".

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
