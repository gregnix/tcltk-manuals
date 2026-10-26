---
CommandName: bench_lang_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Benchmarking/Performance tools
Links:
 - bench_intro
 - bench_lang_spec
Keywords:
 - bench language
 - benchmark
 - examples
 - performance
 - testing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

bench_lang_intro – Einleitung in die Bench-Sprache

# BESCHREIBUNG

Dieses Dokument bietet anhand zahlreicher Beispiele eine informelle Einleitung in Version 1 der Bench-Sprache. Nach der Lektüre dieses Dokuments sollte ein Benchmark-Entwickler in der Lage sein, die formale *Spezifikation der Bench-Sprache* zu verstehen.

## Grundlagen

Im weitesten Sinne ist die *Bench-Sprache* im Wesentlichen Tcl, ergänzt um eine Reihe von Befehlen zur Unterstützung der Deklaration von Benchmarks. Ein in dieser Sprache verfasstes Dokument ist ein Tcl-Skript und weist dieselbe Syntax auf.

## Einfache Benchmarks

Einer der einfachsten Benchmarks, die in bench geschrieben werden können, ist

```
bench -desc LABEL -body {
    set a b
}
```

Dieser Code deklariert einen Benchmark namens **LABEL**, der die Zeit misst, die benötigt wird, um einer Variable einen Wert zuzuweisen. Der Tcl-Code, der diese Zuweisung durchführt, ist der **-body** des Benchmarks.

## Vor- und Nachbearbeitung

Unser nächstes Beispiel veranschaulicht, wie *Initialisierungs-* und *Aufräum-*Code deklariert wird, d. h. Code, der Informationen für die Verwendung des **-body** berechnet und der diese Ressourcen nach Abschluss der Messung wieder freigibt. Es handelt sich dabei um den **-pre**- bzw. den **-post**-Rumpf.

In unserem Beispiel, das direkt aus der Benchmark-Suite des Tcllib-Pakets **aes** stammt, erstellt der konkrete Initialisierungscode das Schlüsselschema, das vom Verschlüsselungsbefehl verwendet wird, dessen Geschwindigkeit gemessen wird, und der Aufräumcode gibt alle Ressourcen frei, die an dieses Schlüsselschema gebunden sind.

```
bench -desc "AES-${len} ECB encryption core" -pre {
    set key [aes::Init ecb $k $i]
} -body {
    aes::Encrypt $key $p
} -post {
    aes::Final $key
}
```

## Fortgeschrittene Vor- und Nachbearbeitung

Unser letztes Beispiel befasst sich erneut mit Initialisierungs- und Aufräumcode. Um den Unterschied zu der im letzten Abschnitt behandelten regulären Initialisierung und dem Aufräumvorgang zu erkennen, ist es notwendig, etwas mehr darüber zu wissen, wie bench die Geschwindigkeit des **-body** tatsächlich misst.

Anstatt den **-body** nur einmal auszuführen, führt das System den **-body** tatsächlich mehrere hundert Mal aus und gibt anschließend den Durchschnitt der ermittelten Ausführungszeiten zurück. Dies geschieht, um Umwelteinflüsse wie die Systemauslastung so weit wie möglich aus dem Ergebnis zu eliminieren, wobei sich Ausreißer im Durchschnitt gegenseitig aufheben.

Der Nachteil dieser Vorgehensweise besteht darin, dass wir bei der Messung von Operationen, die nicht idempotent sind, höchstwahrscheinlich nicht die Zeit für die gewünschte Operation messen, sondern die Zeit für den Zustand bzw. die Zustände, in denen sich das System nach der ersten Iteration befindet – eine Mischung aus Faktoren, die für uns nicht von Interesse sind.

Sollten wir beispielsweise die Zeit messen wollen, die benötigt wird, um ein Element in eine Menge aufzunehmen, wobei sich das Element noch nicht in der Menge befindet und die Menge bestimmte Eigenschaften aufweist – wie beispielsweise, dass es sich um ein gemeinsam genutztes Tcl_Obj handelt –, dann wird in der ersten Iteration die dafür benötigte Zeit gemessen. *Allerdings* messen alle nachfolgenden Iterationen die Zeit für die Aufnahme eines Elements, das sich bereits in der Menge befindet, und das Tcl_Obj, das die Menge enthält, wird ebenfalls nicht mehr gemeinsam genutzt. Letztendlich werden die für die mehreren hundert Iterationen in diesem Zustand gemessenen Zeiten die Zeit aus der ersten Iteration bei weitem überwiegen – der einzigen, die tatsächlich das gemessen hat, was wir wollten.

Die erweiterten Initialisierungs- und Bereinigungscodes, nämlich der **-ipre**- bzw. der **-ipost**-Rumpf, dienen genau der Lösung dieses Problems. Während die regulären Initialisierungs- und Bereinigungscodes vor und nach der gesamten Iterationsreihe ausgeführt werden, werden die erweiterten Codes vor und nach jeder einzelnen Iteration des Rumpfes ausgeführt, ohne selbst gemessen zu werden. Dadurch können sie das System genau in den Zustand versetzen, den der Rumpf messen möchte.

Unser Beispiel, das direkt aus der Benchmark-Suite des Tcllib-Pakets **struct::set** stammt, entspricht genau dem Beispiel, das oben verwendet wurde, um die Notwendigkeit der erweiterten Initialisierung und Bereinigung zu veranschaulichen. Der konkrete Initialisierungscode erstellt eine Variable, die auf eine Menge mit bestimmten Eigenschaften verweist (die Menge verfügt über eine Zeichenfolgendarstellung, die gemeinsam genutzt wird), was sich auf die Geschwindigkeit des Befehls **include** auswirkt, und der Bereinigungscode gibt die durch diese Initialisierung erstellten temporären Variablen frei.

```
bench -desc "set include, missing <SC> x$times $n" -ipre {
    set A $sx($times,$n)
    set B $A
} -body {
    struct::set include A x
} -ipost {
    unset A B
}
```

# WEITERFÜHRENDE LITERATUR

Nachdem der Leser – von dem angenommen wird, dass er ein *Entwickler* von Benchmarks ist – dieses Dokument verinnerlicht hat, sollte er ausreichend gerüstet sein, um die formale *Spezifikation der Bench-Sprache* zu verstehen. Diese dient zudem als detaillierte Spezifikation und Spickzettel für alle verfügbaren Befehle und deren Syntax.

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
