---
CommandName: textutil
ManualSection: n
Version: 0.10
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - TeX
 - formatting
 - hyphenation
 - indenting
 - paragraph
 - regular expression
 - string
 - trimming
Copyright:
---

# NAME

textutil – Prozeduren zur Bearbeitung von Texten und Zeichenketten.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil]{.lit} [0.10]{.optlit} 
[::textutil::adjust::adjust]{.cmd} [string]{.arg} [option value]{.optdot} 
[::textutil::adjust::readPatterns]{.cmd} [filename]{.arg} 
[::textutil::adjust::listPredefined]{.cmd} 
[::textutil::adjust::getPredefined]{.cmd} [filename]{.arg} 
[::textutil::adjust::indent]{.cmd} [string]{.arg} [prefix]{.arg} [skip]{.optarg} 
[::textutil::adjust::undent]{.cmd} [string]{.arg} 
[::textutil::repeat::strRepeat]{.cmd} [text]{.arg} [count]{.arg} 
[::textutil::repeat::blank]{.cmd} [count]{.arg} 
[::textutil::split::splitn]{.cmd} [string]{.arg} [size]{.optarg} 
[::textutil::split::splitx]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::string::chop]{.cmd} [string]{.arg} 
[::textutil::string::tail]{.cmd} [string]{.arg} 
[::textutil::string::cap]{.cmd} [string]{.arg} 
[::textutil::string::capEachWord]{.cmd} [string]{.arg} 
[::textutil::string::uncap]{.cmd} [string]{.arg} 
[::textutil::string::longestCommonPrefixList]{.cmd} [list]{.arg} 
[::textutil::string::longestCommonPrefix]{.cmd} [string]{.optdot} 
[::textutil::tabify::tabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::tabify2]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify2]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::trim::trim]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::trim::trimleft]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::trim::trimright]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::trim::trimPrefix]{.cmd} [string]{.arg} [prefix]{.arg} 
[::textutil::trim::trimEmptyHeading]{.cmd} [string]{.arg} 
:::

# BESCHREIBUNG

Das **textutil**-Paket enthält Befehle zur Bearbeitung von Zeichenketten. Dieses Paket ist ein Bündel, das die Befehle der sechs unten aufgeführten Unterpakete enthält, die sich alle im **textutil**-Namespace befinden.

**textutil::adjust**
: ...siehe nächstes...

**textutil::repeat**
: ...siehe nächstes...

**textutil::split**
: ...siehe nächstes...

**textutil::string**
: ...siehe nächstes...

**textutil::tabify**
: ...siehe nächstes...

**textutil::trim**
: Das Bundle ist *veraltet* und wird in einer zukünftigen Tcllib-Version entfernt. Anstatt dieses Pakets zu verwenden, sollten Sie je nach Bedarf bestimmte Unterpakete mit „package require“ einbinden. Der Einfachheit halber werden alle oben aufgeführten Befehle des **textutil**-Namespaces im folgenden Abschnitt **API** beschrieben, zusätzlich zu ihrer Dokumentation in den Unterpaketen selbst. *Hinweis*: Die folgenden Unterpakete gehören ebenfalls zum **textutil**-Namespace, sind jedoch nicht Teil des Bundles; sie müssen daher bei Bedarf explizit über package require angefordert werden.

**textutil::expander**
: ...siehe nächstes...

**textutil::patch**
: ...siehe nächstes...

**textutil::wcswidth**
: Die oben aufgeführten Befehle des Namespaces **textutil** werden ausschließlich in den jeweiligen Unterpaketen beschrieben.


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

**::textutil::repeat::strRepeat** *text* *count*
: Gibt eine Zeichenkette zurück, die den *text* *count*-mal wiederholt enthält. Die Wiederholungen werden ohne Trennzeichen miteinander verbunden. Ist der Wert von *count* *<= 0*, gibt der Befehl eine leere Zeichenkette zurück. Hinweis: Wenn der Tcl-Kern, in den dieses Paket geladen wird, den Befehl **string repeat** bereitstellt, wird dieser Befehl aus Gründen der maximalen Geschwindigkeit in dessen Begriffen implementiert. Andernfalls wird eine schnelle Tcl-Implementierung verwendet.

**::textutil::repeat::blank** *count*
: Gibt eine Zeichenkette zurück, die *count* Leerzeichen enthält. Dies dient als Erleichterung für den Aufruf von **::textutil::repeat::strRepeat** mit **" "** als erstem Argument.

**::textutil::split::splitn** *string* ?*size*?
: Gibt eine Liste von Zeichenketten zurück, die aufeinanderfolgende Teilzeichenfolgen von *string* enthalten, die jeweils *size* Zeichen lang sind – mit Ausnahme der letzten, die kürzer ist, wenn die Länge von *string* kein genaues Vielfaches von *size* ist. Der Standardwert für *size* ist **1**, d. h., es wird eine Liste der Zeichen von *string* zurückgegeben; dies entspricht dem Aufruf des integrierten Befehls [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) mit dem zweiten Argument **""**. Wenn *string* leer ist, gibt es eine leere Liste zurück. Wenn *size* *<= 0*, wird ein Fehler ausgelöst.

**::textutil::split::splitx** *string* ?*regexp*?
: Gibt eine Liste von Zeichenketten zurück, die aufeinanderfolgende Teilzeichenfolgen von *string* enthalten, die gemäß dem regulären Ausdruck *regexp* aufgeteilt wurden, dessen Standardwert *\[\\t \\r\\n\]+* ist (Tabulatoren, Leerzeichen, Zeilenumbrüche). *Hinweis*: Wenn *regexp* erfassende Klammern enthält, werden die erfassten Gruppen als zusätzliche Elemente in die Ergebnisliste aufgenommen. Ist *string* leer, gibt es eine leere Liste zurück. Wenn *regexp* leer ist, wird *string* an jedem Zeichen aufgeteilt; dies entspricht dem Aufruf des integrierten Befehls [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) mit dem zweiten Argument **""**.

**::textutil::string::chop** *string*
: Gibt eine Kopie von *string* zurück, bei der das letzte Zeichen entfernt wurde.

**::textutil::string::tail** *string*
: Gibt eine Kopie von *string* zurück, bei der das erste Zeichen entfernt wurde.

**::textutil::string::cap** *string*
: Gibt eine Kopie von *string* zurück, bei der das erste Zeichen großgeschrieben ist.

**::textutil::string::capEachWord** *string*
: Gibt eine Kopie von *string* zurück, bei der das erste Zeichen jedes Wortes großgeschrieben ist.

**::textutil::string::uncap** *string*
: Gibt eine Kopie von *string* zurück, wobei das erste Zeichen in Kleinbuchstaben umgewandelt wird.

**::textutil::string::longestCommonPrefixList** *list*
: Gibt das längste gemeinsame Präfix der Zeichenketten in der angegebenen *Liste* zurück. Wird kein Argument angegeben, gibt es die leere Zeichenkette zurück.

**::textutil::string::longestCommonPrefix** ?*string*...?
: Gibt das längste gemeinsame Präfix der Zeichenfolgenargumente *string*, … zurück. Wird eine einzelne Zeichenfolge angegeben, wird diese zurückgegeben, da sie ihr eigenes längstes gemeinsames Präfix ist. Wird kein Argument angegeben, wird die leere Zeichenfolge zurückgegeben.

**::textutil::tabify::tabify** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, wobei jede Teilzeichenfolge aus *count* Leerzeichen durch ein horizontales Tabulatorzeichen ersetzt wird. Der Standardwert für *count* ist 8.

**::textutil::tabify::tabify2** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, in der Teilzeichenfolgen mit *count* *oder weniger* Leerzeichen durch einen horizontalen Tabulator ersetzt wurden, wobei ein Texteditor-ähnlicher Algorithmus verwendet wird. Der Standardwert für *count* ist 8. Der von diesem Befehl verwendete Algorithmus behandelt jede Zeile in *string* so, als hätte sie fiktive Tabulatorpositionen alle *count* Spalten. (Wenn also *count* **8** ist, dann bei Spalten **8**, **16**, **24**, …) Nur Folgen von *zwei oder mehr* Leerzeichen, die unmittelbar vor einem fiktiven Tabulator-Stopp auftreten, werden durch einen Tabulator ersetzt.

**::textutil::tabify::untabify** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, in der jeder horizontale Tabulator durch *count* Leerzeichen ersetzt wurde. Der Standardwert für *count* ist 8.

**::textutil::tabify::untabify2** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, wobei horizontale Tabulatoren durch *count* *oder weniger* Leerzeichen ersetzt werden – nach einem Prinzip, das dem eines Texteditors ähnelt. Der Standardwert für *count* ist 8. Dieser Befehl ist das Gegenstück zu **::textutil::tabify::tabify2**. Der von diesem Befehl verwendete Algorithmus behandelt jede Zeile in *string* so, als hätte sie fiktive Tabulatorpositionen alle *count* Spalten. (Wenn also *count* **8** ist, werden an den Spalten **8**, **16**, **24**, …) wird anstelle einer blinden Ersetzung jedes horizontalen Tabulatorzeichens durch *count* Leerzeichen jedes horizontale Tabulatorzeichen an einer fiktiven Tabulatorposition durch so viele Leerzeichen ersetzt, dass die nächste fiktive Tabulatorposition erreicht wird. Es gibt jedoch eine Asymmetrie: Ein Tabulatorzeichen kann durch ein einzelnes Leerzeichen ersetzt werden, aber nicht umgekehrt.

**::textutil::trim::trim** *string* ?*regexp*?
: Gibt eine Kopie von *string* zurück, wobei alle am Anfang oder Ende stehenden Teilzeichenfolgen, die mit *regexp* übereinstimmen, aus *string* entfernt werden, sofern dieser keine Zeilenumbrüche enthält, bzw. aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält. Der Standardwert für *regexp* ist *\[ \\t\]+*. Dieser Standardwert entfernt führende und abschließende Leerzeichen und Tabulatoren aus *string*, wenn dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, wenn dieser Zeilenumbrüche enthält.

**::textutil::trim::trimleft** *string* ?*regexp*?
: Gibt eine Kopie von *string* zurück, wobei alle führenden Teilzeichenfolgen, die mit *regexp* übereinstimmen, aus *string* entfernt werden, sofern dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält. Der Standardwert für *regexp* ist *\[ \\t\]+*. Dieser Standardwert entfernt führende Leerzeichen und Tabulatoren aus *string*, wenn dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, wenn dieser Zeilenumbrüche enthält.

**::textutil::trim::trimright** *string* ?*regexp*?
: Gibt eine Kopie von *string* zurück, wobei alle am Ende stehenden Teilzeichenfolgen, die mit *regexp* übereinstimmen, aus *string* entfernt werden, sofern dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält. Der Standardwert für *regexp* ist *\[ \\t\]+*. Dieser Standardwert entfernt abschließende Leerzeichen und Tabulatoren aus *string*, sofern dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält.

**::textutil::trim::trimPrefix** *string* *prefix*
: Gibt eine Kopie von *string* zurück, wobei *prefix* am Anfang entfernt wird, sofern es vorhanden ist; andernfalls wird *string* unverändert zurückgegeben. Vergleichen Sie diesen Befehl mit den Unterbefehlen **trim**, **trimleft** und **trimright** des integrierten Befehls [string](https://www.tcl-lang.org/man/tcl/TclCmd/string.html)], die alle Zeichen aus einer als Zeichenkette übergebenen Zeichenmenge entfernen.

**::textutil::trim::trimEmptyHeading** *string*
: Gibt eine Kopie von *string* zurück, aus der alle führenden Leerzeilen (einschließlich Zeilen, die ausschließlich Leerzeichen enthalten) entfernt wurden.


# BEISPIELE

## Anpassen

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

## Wiederholen

Dieses kurze Beispiel veranschaulicht die Befehle des Pakets **::textutil::repeat** in der Praxis.

```
puts [::textutil::repeat::strRepeat = 22]
puts =[::textutil::repeat::blank 20]=
=>
======================
=                    =
```

## Split

Die folgenden Beispiele veranschaulichen einige Befehle des Pakets **::textutil::split** in der Praxis.

Um die Auswirkungen der Beispiele besser sichtbar zu machen, wird jedes Element der zurückgegebenen Listen mit ❬ und ❭ in Klammern gesetzt. Bei Editoren, die UTF-8 nicht unterstützen, können diese durch **\\u276C** und **\\u276D** ersetzt werden.

Dieses erste Beispiel zeigt, wie Sie Zeichenfolgen nach ihrer Länge aufteilt.

```
const LINE1 "α and ℤ"
set chars [::textutil::split::splitn $LINE1] ;# splits into characters
puts ❬[join $chars "❭ ❬"]❭
set chars [split $LINE1 ""] ;# splits into characters
puts ❬[join $chars "❭ ❬"]❭
set chunks [::textutil::split::splitn $LINE1 3]
puts ❬[join $chunks "❭ ❬"]❭
=>
❬α❭ ❬ ❭ ❬a❭ ❬n❭ ❬d❭ ❬ ❭ ❬ℤ❭
❬α❭ ❬ ❭ ❬a❭ ❬n❭ ❬d❭ ❬ ❭ ❬ℤ❭
❬α a❭ ❬nd ❭ ❬ℤ❭
```

Dieses zweite Beispiel zeigt, wie Sie Zeichenfolgen mithilfe regulärer Ausdrücke aufteilt.

```
const LINE2 "a, be , cat, done , eagle"
set chunks [::textutil::split::splitx $LINE2] ;# splits on [\t \r\n]+
puts ❬[join $chunks "❭ ❬"]❭
set chunks [::textutil::split::splitx $LINE2 {\s*,\s*}]
puts ❬[join $chunks "❭ ❬"]❭
set chunks [::textutil::split::splitx $LINE2 {\s*(,)\s*}]
puts ❬[join $chunks "❭ ❬"]❭
=>
❬a,❭ ❬be❭ ❬,❭ ❬cat,❭ ❬done❭ ❬,❭ ❬eagle❭
❬a❭ ❬be❭ ❬cat❭ ❬done❭ ❬eagle❭
❬a❭ ❬,❭ ❬be❭ ❬,❭ ❬cat❭ ❬,❭ ❬done❭ ❬,❭ ❬eagle❭
```

## Zeichenkette

Die folgenden Beispiele veranschaulichen einige Befehle des Pakets **::textutil::string** in der Praxis.

Dieses erste Beispiel zeigt alle Befehle, die auf eine einzelne Zeichenkette angewendet werden können.

```
const LINE "has the σαβ cogs"
puts "“$LINE” const"
set line [::textutil::string::chop $LINE]
puts "“$line” chop"
set line [::textutil::string::tail $line]
puts "“$line” tail"
set line [::textutil::string::cap $line]
puts "“$line” cap"
set line [::textutil::string::capEachWord $line]
puts "“$line” capEachWord"
set line [::textutil::string::uncap $line]
puts "“$line” uncap"
=>
“has the σαβ cogs” const
“has the σαβ cog” chop
“as the σαβ cog” tail
“As the σαβ cog” cap
“As The Σαβ Cog” capEachWord
“as The Σαβ Cog” uncap
```

Dieses Beispiel zeigt die Befehle für das längste gemeinsame Präfix, die derzeit verwendet werden.

```
const LIST [list handbag handcuff handful handle handy]
puts “[::textutil::string::longestCommonPrefixList $LIST]”
puts “[::textutil::string::longestCommonPrefix king queen knave]”
puts “[::textutil::string::longestCommonPrefix king kin kind kinks]”
=>
“hand”
“”
“kin”
```

Dieses Beispiel zeigt, wie Sie mit dem Befehl **::textutil::string::longestCommonPrefixList** den gemeinsamen Pfad aus einer Liste von Pfaden ermittelt.

```
proc longestCommonPath paths {
    const SEP [file separator]
    set path [::textutil::string::longestCommonPrefixList $paths]
    if {[string index $path end] ne $SEP} {
        if {[set j [string last $SEP $path]] > -1} {
            set path [string range $path 0 $j-1]
        }
    }
    if {$path ne $SEP} { set path [string trimright $path $SEP] }
    return $path
}

const PATHS [list /home/sally/music /home/sally/museums /home/sally/musings]
puts [::textutil::string::longestCommonPrefixList $PATHS]
puts [longestCommonPath $PATHS]
puts [longestCommonPath [list /bin / /sbin]]
=>
/home/sally/mus
/home/sally
/
```

## Tabify

Die folgenden Beispiele veranschaulichen einige Befehle des Pakets **::textutil::tabify** in der Praxis.

In den Beispielen wird ein kleiner Hilfsbefehl verwendet, um Leerzeichen und Tabulatoren deutlich voneinander abzugrenzen und sichtbar zu machen:

```
proc replace_tab_spc s { regsub -all { } [regsub -all \t $s →] ▴ }
```

Dieses Beispiel veranschaulicht die Verwendung des Befehls **::textutil::tabify::tabify**.

```
const LINES1 "    if \{\$x\} \{\n        puts 1\n    \}"
puts "=== original ===\n[replace_tab_spc $LINES1]\n"
set tabbed [::textutil::tabify::tabify $LINES1]
puts "=== 8spc→tab ===\n[replace_tab_spc $tabbed]\n"
set tabbed [::textutil::tabify::tabify $LINES1 4]
puts "=== 4spc→tab ===\n[replace_tab_spc $tabbed]\n"
=>
=== original ===
▴▴▴▴if▴{$x}▴{
▴▴▴▴▴▴▴▴puts▴1
▴▴▴▴}

=== 8spc→tab ===
▴▴▴▴if▴{$x}▴{
→puts▴1
▴▴▴▴}

=== 4spc→tab ===
→if▴{$x}▴{
→→puts▴1
→}
```

## Trim

Die folgenden Beispiele veranschaulichen einige Befehle des Pakets **::textutil::trim** in der Praxis.

Die folgende **proc** wird in einigen der nachfolgenden Beispiele verwendet.

```
proc replace_ws s { regsub -all { } [regsub -all \t [regsub -all \n $s ⏎] →] ▴ }
```

Diese Beispiele veranschaulichen die Verwendung von **::textutil::trim::trimEmptyHeading** und **::textutil::trim::trim**.

```
const LINES1 "\t\n Alpha\t\n Beta \t\n Gamma \t\n"
puts "== const =============================\n[replace_ws $LINES1]"
set line [::textutil::trim::trimEmptyHeading $LINES1]
puts "== textutil::trim::trimEmptyHeading ==\n[replace_ws $line]"
set line [string trimleft $LINES1]
puts "== string trimleft ===================\n[replace_ws $line]"
set line [::textutil::trim::trim $LINES1]
puts "== textutil::trim::trim ==============\n[replace_ws $line]"
=>
== const =============================
→⏎▴Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== textutil::trim::trimEmptyHeading ==
▴Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== string trimleft ===================
Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== textutil::trim::trim ==============
⏎Alpha⏎Beta⏎Gamma⏎
```

Beachten Sie den subtilen Unterschied im Verhalten zwischen **::textutil::trim::trimEmptyHeading** und **string trimleft**.

Dieses Beispiel veranschaulicht die Verwendung der integrierten Funktion **string trim** in Kombination mit **::textutil::trim::trim**.

```
const LINES2 [string trim "\t\n Delta\t\n Epsilon \t\n Zeta \t\n"]
puts "== const =============================\n[replace_ws $LINES2]"
set line [::textutil::trim::trim $LINES2]
puts "== textutil::trim::trim ==============\n[replace_ws $line]"
=>
== const =============================
Delta→⏎▴Epsilon▴→⏎▴Zeta
== textutil::trim::trim ==============
Delta⏎Epsilon⏎Zeta
```

In diesen Beispielen wird die integrierte Funktion **string trim** mit **::textutil::trim::trimPrefix** verglichen.

```
const PATH /home/homer
puts "const='$PATH'"
puts "string trim \$PATH /home='[string trim $PATH /home]'"
puts "string trim \$PATH /home='[string trim $PATH ehmo/]'"
puts "::textutil::trim::trimPrefix \$PATH /home='[::textutil::trim::trimPrefix $PATH /home]'"
const LINE mimic
puts "string trim \$LINE mic='[string trim $LINE mic]'"
puts "::textutil::trim::trimPrefix \$LINE mic='[::textutil::trim::trimPrefix $LINE mic]'"
=>
const='/home/homer'
string trim $PATH /home='r'
string trim $PATH /home='r'
::textutil::trim::trimPrefix $PATH /home='/homer'
string trim $LINE mic=''
::textutil::trim::trimPrefix $LINE mic='mimic'
```

Bei den **PATH**-Beispielen entfernt der Befehl **string trim** alle einzelnen Zeichen, die in der Zeichenkette „/home“ enthalten sind, d. h. „/“, „h“, „o“, „m“, „e“. Die Reihenfolge der Zeichen in der Zeichenkette spielt keine Rolle, wie das Beispiel „ehmo/“ zeigt. Vergleichen Sie dies mit **::textutil::trim::trimPrefix**, das die Zeichenkette „/home“ wörtlich trimmt.

Bei den **LINE**-Beispielen entfernt der Befehl **string trim** alle einzelnen Zeichen, die in der Zeichenkette „mic“ enthalten sind, d. h. „m“, „i“ und „c“. Vergleichen Sie dies mit **::textutil::trim::trimPrefix**, das die Literalzeichenfolge „mic“ trimmt; da die **LINE** jedoch nicht mit „mic“ beginnt, wird nichts getrimmt und die Zeichenfolge wird unverändert gegeben.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
