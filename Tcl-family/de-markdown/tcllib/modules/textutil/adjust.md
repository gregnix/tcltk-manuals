---
CommandName: textutil::adjust
ManualSection: n
Version: 0.7.4
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - TeX
 - adjusting
 - formatting
 - hyphenation
 - indenting
 - justification
 - paragraph
 - string
 - undenting
Copyright:
---

# NAME

textutil::adjust – Prozeduren zum Anpassen, Einrücken und Ausrücken von Absätzen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::adjust]{.lit} [0.7.4]{.optlit} 
[::textutil::adjust::adjust]{.cmd} [string]{.arg} [option value]{.optdot} 
[::textutil::adjust::readPatterns]{.cmd} [filename]{.arg} 
[::textutil::adjust::listPredefined]{.cmd} 
[::textutil::adjust::getPredefined]{.cmd} [filename]{.arg} 
[::textutil::adjust::indent]{.cmd} [string]{.arg} [prefix]{.arg} [skip]{.optarg} 
[::textutil::adjust::undent]{.cmd} [string]{.arg} 
:::

# BESCHREIBUNG

Das Paket **textutil::adjust** enthält Befehle zum Einrücken, Ausrücken und Blocksatz des in einer Zeichenkette enthaltenen Textes.

# API

**::textutil::adjust::adjust** *string* ?*option value ...*?
: Gibt eine Kopie von *string* zurück, die entsprechend den angegebenen Optionen geändert wurde. Alle Zeilenumbrüche im ursprünglichen *string* werden als Leerzeichen behandelt, d. h., der Eingabe-*string* wird als ein einziger Textabsatz behandelt. Wenn die resultierende Zeichenkette kürzer ist als **-length**, enthält sie keine Zeilenumbrüche. Andernfalls enthält das Ergebnis so viele Zeilenumbrüche, wie für die gewünschte Ausrichtung erforderlich sind. Zusammen mit **::textutil::adjust::indent** ist es möglich, korrekt umgebrochene Absätze mit beliebigen Einrückungen zu erstellen. Im Hintergrund werden jeder Zeilenumbruch, jedes Tabulatorzeichen oder jede Folge von zwei oder mehr Leerzeichen als ein einziges Leerzeichen behandelt, und einzelne Leerzeichen werden verwendet, um die Wörter einer Zeile voneinander zu trennen. Dies sind die *tatsächlichen* Zeilen des Algorithmus. Jede *tatsächliche* Zeile wird in eine *logische* Zeile platziert, die genau **-length** Zeichen breit ist (auch wenn die *tatsächliche* Zeile kürzer ist). Jedes Wort in einer *echten* Zeile wird durch ein einzelnes Leerzeichen getrennt, außer wenn die Option **-justify** **plain** verwendet wird; in diesem Fall werden Wörter durch ein oder mehrere Leerzeichen getrennt, je nach Bedarf, um die *echte* Zeile auszufüllen. Standardmäßig werden nachgestellte Leerzeichen (einschließlich Tabulatoren, die zunächst durch Leerzeichen ersetzt werden) entfernt. Siehe die Option **-full** weiter unten. Die folgenden Optionen können nach dem Parameter *string* angegeben werden. Sie steuern, wie der Befehl jede *tatsächliche* Zeile in die entsprechende *logische* Zeile platziert.


**-full** *boolean*
: Wenn die Einstellung **0** (false; Standard) gewählt ist, werden alle abschließenden Leerzeichen aus jeder Zeile entfernt, bevor die Zeichenkette zurückgegeben wird. Wenn die Einstellung **1** (true) gewählt ist, bleiben alle abschließenden Leerzeichen am Ende jeder Zeile erhalten.

**-hyphenate** *boolean*
: Bei der Einstellung **0** (falsch; Standard) erfolgt keine Silbentrennung. Bei der Einstellung **1** (wahr) versucht der Befehl, das letzte Wort jeder Zeile gegebenenfalls zu trennen. Wenn **-hyphenate** auf **1** gesetzt ist, *müssen* die Silbentrennungsmuster durch Aufruf des Befehls **::textutil::adjust::readPatterns** Der Befehl geladen worden sein, *bevor* **::textutil::adjust::adjust** aufgerufen wird; andernfalls löst **::textutil::adjust::adjust** einen Fehler aus.

**-justify** **center|left|plain|right**
: Legt die Ausrichtung der zurückgegebenen Zeichenkette auf eine der folgenden Optionen fest: **left** (Standard), **center**, **plain** (blockiert) oder **right**. Die Ausrichtung bedeutet, dass jede Zeile in der zurückgegebenen Zeichenkette (möglicherweise mit Ausnahme der letzten Zeile) entsprechend der angegebenen Ausrichtung ausgerichtet wird. Wenn die Ausrichtung auf **plain** (ausgerichtet) gesetzt ist und die Anzahl der druckbaren Zeichen in der letzten Zeile weniger als 90 % von **-length** beträgt, wird die letzte Zeile **left** ausgerichtet, um den Innenabstand dieser Zeile zu vermeiden, wenn sie zu kurz ist. Die einzelnen Werte haben folgende Bedeutung:


**center**
: Jede *tatsächliche* Zeile wird in der *logischen* Zeile zentriert, indem zwischen der *tatsächlichen* Zeile und der *logischen* Zeile ein Innenabstand mit Leerzeichen eingehalten wird, der bei Bedarf am Anfang und am Ende die *tatsächliche* Zeile auffüllt. Wenn die letzte Zeile weniger als 90 % von **-length** ausmacht, wird sie **left** statt **center** ausgerichtet. (siehe auch die Option **-full**.)

**left**
: Jede *tatsächliche* Zeile wird links von der *logischen* Zeile platziert, ohne vorangestellte Leerzeichen. Wenn **-full** den Wert **1** (wahr) hat, wird die *tatsächliche* Zeile am Ende mit Leerzeichen zum Innenabstand aufgefüllt, sodass sie **-length** Zeichen breit ist.

**plain**
: Jede Zeile ist vollständig ausgerichtet. Das bedeutet, dass die Wörter jeder *tatsächlichen* Zeile in der *logischen* Zeile platziert werden, getrennt durch ein oder mehrere Leerzeichen, je nach Bedarf, um die Zeile vollständig auszufüllen, ohne dass am Anfang oder Ende Leerzeichen stehen.

**right**
: Jede *tatsächliche* Zeile wird rechts neben der *logischen* Zeile platziert, ohne Leerzeichen am Ende, und bei Bedarf mit Innenabstand am Anfang aufgefüllt, damit die *tatsächliche* Zeile eine Breite von **-length** Zeichen hat.


**-length** *integer*
: Legt die *logische* Zeilenlänge auf *integer* fest. *integer* muss eine positive ganze Zahl *> 0* sein. Der Standardwert ist **72**.

**-strictlength** *boolean*
: Wenn die Einstellung **0** (falsch; Standard) gewählt ist, darf eine Zeile die angegebene Länge **-length** überschreiten, wenn ein einzelnes Wort länger als **-length** ist. Wenn die Einstellung **1** (wahr) gewählt ist, werden Wörter, die länger als **-length** sind, so geteilt, dass keine Zeile den festgelegten Wert **-length** überschreitet.


**::textutil::adjust::readPatterns** *filename*
: Liest die Silbentrennungsmuster aus der Datei *Dateiname* ein. Dieser Befehl wird nur benötigt, wenn der Befehl **::textutil::adjust::adjust** zusammen mit **-hyphenate** **1** (wahr) verwendet wird. In diesem Fall *muss* der Aufruf von **::textutil::adjust::readPatterns** *vor* dem Aufruf von **::textutil::adjust::adjust** erfolgen. Das Paket **textutil::adjust** enthält eine Reihe vordefinierter Musterdateien. Verwenden Sie den Befehl **::textutil::adjust::listPredefined**, um deren Namen aufzulisten.

**::textutil::adjust::listPredefined**
: Gibt eine Liste der Namen der von diesem Paket bereitgestellten Silbentrennungsdateien zurück.

**::textutil::adjust::getPredefined** *filename*
: Gibt den vollständigen Pfad und den Dateinamen der Silbentrennungsdatei *filename* zurück. *Hinweis*: *filename* *muss* unbedingt einer der Namen sein, die von **::textutil::adjust::listPredefined** zurückgegeben werden.

**::textutil::adjust::indent** *string* *prefix* ?*skip*?
: Gibt eine modifizierte Kopie von *string* zurück, wobei jeder nicht übersprungenen Zeile das Präfix *prefix* sowie Leerzeichen (mit Ausnahme des Zeilenumbruchs) vorangestellt und am Ende abgeschnitten werden. Standardmäßig werden keine Zeilen übersprungen, sodass allen Zeilen das Präfix vorangestellt wird. Die Option **skip** legt fest, wie viele Zeilen am Anfang der Zeichenkette übersprungen werden sollen; der Standardwert ist **0**, in diesem Fall wird keine Zeile übersprungen und alle Zeilen erhalten das Präfix. Wenn **skip** auf einen Wert *> 0* gesetzt wird, werden entsprechend viele Zeilen am Anfang der Zeichenkette übersprungen, d. h. nicht mit einem Präfix versehen, während alle nachfolgenden Zeilen mit einem Präfix versehen werden. Wird **skip** auf **1** gesetzt, entsteht ein herkömmlicher hängender Einzug. In Verbindung mit **::textutil::adjust::adjust** ist es möglich, korrekt umgebrochene Absätze mit beliebigen Einzügen zu erstellen.

**::textutil::adjust::undent** *string*
: Gibt eine geänderte Kopie von *string* zurück, bei der aus jeder Zeile ein etwaiges gemeinsames Präfix aus Leerzeichen entfernt wurde. Leere Zeilen und Zeilen, die ausschließlich aus Leerzeichen bestehen, werden bei der Berechnung des Präfixes ignoriert, und alle diese Zeilen werden als leere Zeilen zurückgegeben. *Beachten Sie, dass der Name dieses Befehls* **undent** *lautet und nicht unindent.*


# BEISPIELE

Die folgenden Beispiele veranschaulichen einige Befehle des Pakets **::textutil::adjust** in der Praxis.

Die folgenden **proc** und **const** werden in den nachstehenden Beispielen verwendet.

```
proc replace_spc {s {sub ▴}} { regsub -all { } $s $sub }
const LINES "Four\nsiamese cats\nheard barks\nand bolted."
```

Der Befehl **replace_spc** ersetzt jedes Leerzeichen in der übergebenen Zeichenkette durch das Symbol ▴. Die Konstante **LINES** liefert Text, mit dem die Beispiele arbeiten können.

## Begründung

Das folgende Beispiel zeigt alle verfügbaren Ausrichtungsoptionen. Leerzeichen wurden sichtbar gemacht, indem sie mithilfe von **-full** **1** beibehalten und durch das Symbol ▴ ersetzt wurden.

Normalerweise würde **-full** *nicht* verwendet werden, und es gäbe *keine* Leerzeichen am Zeilenende.

```
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify left]
puts "======= left =======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify center]
puts "====== center ======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify plain]
puts "======= plain ======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify right]
puts "======= right ======\n[replace_spc $lines]"
=>
======= left =======
Four▴siamese▴cats▴▴▴
heard▴barks▴and▴▴▴▴▴
bolted.▴▴▴▴▴▴▴▴▴▴▴▴▴

====== center ======
▴▴Four▴siamese▴cats▴
▴▴▴heard▴barks▴and▴▴
▴▴▴▴▴▴▴bolted.▴▴▴▴▴▴

======= plain ======
Four▴siamese▴▴▴▴cats
heard▴▴▴barks▴▴▴▴and
bolted.▴▴▴▴▴▴▴▴▴▴▴▴▴

======= right ======
▴▴▴Four▴siamese▴cats
▴▴▴▴▴heard▴barks▴and
▴▴▴▴▴▴▴▴▴▴▴▴▴bolted.
```

## Einrücken und Ausrücken

In den folgenden Beispielen wurden führende Leerzeichen sichtbar gemacht, indem anstelle von beispielsweise zwei Leerzeichen eine Einrückung von **··** verwendet wurde, und andere Leerzeichen wurden sichtbar gemacht, indem sie durch das Symbol ▴ ersetzt wurden. Es gibt keine nachgestellten Leerzeichen, da **textutil::adjust::indent** diese entfernt.

```
set lines [textutil::adjust::adjust $LINES -length 20 -justify left]
puts "======== left =========\n[replace_spc $lines]"
set indented [textutil::adjust::indent $lines "··"]
puts "======== indent =======\n[replace_spc $indented]"
# undent only unindents spaces
set indented [regsub -all · $indented " "]
set unindented [textutil::adjust::undent $indented]
puts "======== undent =======\n[replace_spc $unindented]"
set hanging [textutil::adjust::indent $lines "··" 1]
puts "==== hanging indent ===\n[replace_spc $hanging]"
=>
======== left =========
Four▴siamese▴cats
heard▴barks▴and
bolted.
======== indent =======
··Four▴siamese▴cats
··heard▴barks▴and
··bolted.
======== undent =======
Four▴siamese▴cats
heard▴barks▴and
bolted.
==== hanging indent ===
Four▴siamese▴cats
··heard▴barks▴and
··bolted.
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
