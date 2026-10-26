---
CommandName: textutil::split
title: textutil::split
ManualSection: n
Version: 0.9
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - regular expression
 - split
 - string
Copyright:
---

# Name

textutil::split – Prozeduren zum Aufteilen von Texten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::split]{.lit} [0.9]{.optlit}
[::textutil::split::splitn]{.cmd} [string]{.arg} [size]{.optarg}
[::textutil::split::splitx]{.cmd} [string]{.arg} [regexp]{.optarg}
:::

# Beschreibung

Das Paket **textutil::split** enthält Befehle, mit denen Zeichenfolgen nach Länge oder anhand regulärer Ausdrücke in Teilzeichenfolgen aufgeteilt werden können.

Um an einem bestimmten Zeichen oder einer Zeichenfolge zu trennen, verwenden Sie den integrierten Befehl [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html). Um eine Zeichenfolge in ihre einzelnen Zeichen zu zerlegen, verwenden Sie den integrierten Befehl [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) mit dem zweiten Argument **""**.

# API

**::textutil::split::splitn** *string* ?*size*?
: Gibt eine Liste von Zeichenketten zurück, die aufeinanderfolgende Teilzeichenfolgen von *string* enthalten, die jeweils *size* Zeichen lang sind – mit Ausnahme der letzten, die kürzer ist, wenn die Länge von *string* kein genaues Vielfaches von *size* ist. Der Standardwert für *size* ist **1**, d. h., es wird eine Liste der Zeichen von *string* zurückgegeben; dies entspricht dem Aufruf des integrierten Befehls [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) mit dem zweiten Argument **""**.

    Wenn *string* leer ist, gibt es eine leere Liste zurück. Wenn *size* *<= 0*, wird ein Fehler ausgelöst.

**::textutil::split::splitx** *string* ?*regexp*?
: Gibt eine Liste von Zeichenketten zurück, die aufeinanderfolgende Teilzeichenfolgen von *string* enthalten, die gemäß dem regulären Ausdruck *regexp* aufgeteilt wurden, dessen Standardwert *\[\\t \\r\\n\]+* ist (Tabulatoren, Leerzeichen, Zeilenumbrüche).

    *Hinweis*: Wenn *regexp* erfassende Klammern enthält, werden die erfassten Gruppen als zusätzliche Elemente in die Ergebnisliste aufgenommen.

    Ist *string* leer, gibt es eine leere Liste zurück. Wenn *regexp* leer ist, wird *string* an jedem Zeichen aufgeteilt; dies entspricht dem Aufruf des integrierten Befehls [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) mit dem zweiten Argument **""**.


# Beispiele

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

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung
