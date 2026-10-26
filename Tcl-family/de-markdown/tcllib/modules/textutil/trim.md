---
CommandName: textutil::trim
title: textutil::trim
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - prefix
 - regular expression
 - string
 - trimming
Copyright:
---

# Name

textutil::trim – Prozeduren zum Kürzen von Zeichenketten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::trim]{.lit} [0.8]{.optlit}
[::textutil::trim::trim]{.cmd} [string]{.arg} [regexp]{.optarg}
[::textutil::trim::trimleft]{.cmd} [string]{.arg} [regexp]{.optarg}
[::textutil::trim::trimright]{.cmd} [string]{.arg} [regexp]{.optarg}
[::textutil::trim::trimPrefix]{.cmd} [string]{.arg} [prefix]{.arg}
[::textutil::trim::trimEmptyHeading]{.cmd} [string]{.arg}
:::

# Beschreibung

Das Paket **textutil::trim** enthält Befehle, mit denen Zeichenfolgen auf verschiedene Weise gekürzt werden können, unter anderem mithilfe beliebiger regulärer Ausdrücke.

Um Zeichenfolgen von bestimmten Zeichengruppen (z. B. Leerzeichen) zu entfernen, verwenden Sie die integrierten Unterbefehle **trim**, **trimleft** und **trimright** des Befehls [string](https://www.tcl-lang.org/man/tcl/TclCmd/string.html).

# API

**::textutil::trim::trim** *string* ?*regexp*?
: Gibt eine Kopie von *string* zurück, wobei alle am Anfang oder Ende stehenden Teilzeichenfolgen, die mit *regexp* übereinstimmen, aus *string* entfernt werden, sofern dieser keine Zeilenumbrüche enthält, bzw. aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält. Der Standardwert für *regexp* ist *\[ \\t\]+*. Dieser Standardwert entfernt führende und abschließende Leerzeichen und Tabulatoren aus *string*, wenn dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, wenn dieser Zeilenumbrüche enthält.

**::textutil::trim::trimleft** *string* ?*regexp*?
: Gibt eine Kopie von *string* zurück, wobei alle führenden Teilzeichenfolgen, die mit *regexp* übereinstimmen, aus *string* entfernt werden, sofern dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält. Der Standardwert für *regexp* ist *\[ \\t\]+*. Dieser Standardwert entfernt führende Leerzeichen und Tabulatoren aus *string*, wenn dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, wenn dieser Zeilenumbrüche enthält.

**::textutil::trim::trimright** *string* ?*regexp*?
: Gibt eine Kopie von *string* zurück, wobei alle am Ende stehenden Teilzeichenfolgen, die mit *regexp* übereinstimmen, aus *string* entfernt werden, sofern dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält. Der Standardwert für *regexp* ist *\[ \\t\]+*. Dieser Standardwert entfernt abschließende Leerzeichen und Tabulatoren aus *string*, sofern dieser keine Zeilenumbrüche enthält, oder aus *jeder Zeile* innerhalb von *string*, sofern dieser Zeilenumbrüche enthält.

**::textutil::trim::trimPrefix** *string* *prefix*
: Gibt eine Kopie von *string* zurück, wobei *prefix* am Anfang entfernt wird, sofern es vorhanden ist; andernfalls wird *string* unverändert zurückgegeben.

    Vergleichen Sie diesen Befehl mit den Unterbefehlen **trim**, **trimleft** und **trimright** des integrierten Befehls [string](https://www.tcl-lang.org/man/tcl/TclCmd/string.html), die alle Zeichen aus einer als Zeichenkette übergebenen Zeichenmenge entfernen.

**::textutil::trim::trimEmptyHeading** *string*
: Gibt eine Kopie von *string* zurück, aus der alle führenden Leerzeilen (einschließlich Zeilen, die ausschließlich Leerzeichen enthalten) entfernt wurden.


# Beispiele

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

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung
