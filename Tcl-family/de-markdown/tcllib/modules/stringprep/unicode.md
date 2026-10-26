---
CommandName: unicode
title: unicode
ManualSection: n
Version: 1.1.1
TclPart: tcllib
TclDescription: Unicode normalization
Links:
 - stringprep(n)
Keywords:
 - normalization
 - unicode
Copyright:
 - Copyright (c) 2007, Sergei Golovan <sgolovan@nes.ru>
---

# Name

unicode – Implementierung der Unicode-Normalisierung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [unicode]{.lit} [1.1.1]{.lit}
[::unicode::normalizeS]{.cmd} [form]{.arg} [string]{.arg}
[::unicode::fromstring]{.cmd} [string]{.arg}
[::unicode::tostring]{.cmd} [codepointsList]{.arg}
[::unicode::normalize]{.cmd} [form]{.arg} [codepointsList]{.arg}
:::

# Beschreibung

Dies ist eine Tcl-Implementierung der Unicode-Normalisierungsbefehle.

*Hinweis*: Das Paket **stringprep** kann sich als nützlich erweisen, wenn die Normalisierung allein nicht ausreicht (z. B. bei Zeichenfolgenvergleichen).

# API

Das Argument *form* in den unten aufgeführten Befehlen muss eine Zeichenkette sein, die einen der folgenden Werte annimmt: **D** (kanonische Zerlegung), **C** (kanonische Zerlegung, gefolgt von kanonischer Zusammensetzung), **KD** (Kompatibilitätszerlegung) oder **KC** (Kompatibilitätszerlegung, gefolgt von kanonischer Zusammensetzung).

**::unicode::normalizeS** *form* *string*
: Gibt eine möglicherweise geänderte Kopie von *string* zurück, die gemäß der angegebenen *form* normalisiert wurde.

    Dies ist eine Kurzform für: *::unicode::tostring* \[*unicode::normalize $form* \[*::unicode::fromstring $string*\]\].

**::unicode::fromstring** *string*
: Gibt eine Liste von ganzzahligen Unicode-Codepunkten zurück, die die Zeichen in *string* darstellen.

    (Diese ganzzahligen Codepunkte werden in **unicode** für die interne Darstellung von Zeichenfolgen verwendet.)

**::unicode::tostring** *codepointsList*
: Gibt eine Zeichenkette zurück, deren Zeichen den in *codepointsList* enthaltenen Ganzzahlen entsprechen.

    Jede Ganzzahl, die ein gültiger Unicode-Codepunkt ist, wird in der zurückgegebenen Zeichenkette durch das entsprechende Unicode-Zeichen dargestellt. Jede Ganzzahl, die kein gültiger Unicode-Codepunkt ist, wird durch das Unicode-Ersatzzeichen �, U+FFFD, dargestellt, es sei denn, sie ist ausreichend groß; in diesem Fall wird ein Fehler ausgelöst.

**::unicode::normalize** *form* *codepointsList*
: Gibt eine möglicherweise geänderte Kopie der *codepointsList* aus ganzen Zahlen zurück (die alle gültige Unicode-Codepunkte sein müssen), die gemäß der angegebenen Normalisierungsform *form* normalisiert wurde.


# Beispiele

Einige Unicode-Zeichen verfügen in einer Unicode-Kodierung wie beispielsweise UTF-8 über mehr als eine Darstellung. Normalerweise stellt dies *innerhalb* einer Programmiersprache kein Problem dar, da die Sprache für ein bestimmtes Zeichen in der Regel stets dieselbe Darstellung verwendet. Bei Daten, die aus Dateien oder anderen externen Quellen eingelesen werden, könnte jedoch jede der möglichen Darstellungen verwendet werden. In diesen Fällen kann daher eine Normalisierung erforderlich sein.

Hier ist ein Beispiel für das Problem:

```
set a "Å"
set b "\u212B"
set c [encoding convertfrom utf-8 \xC3\x85]
set d [encoding convertfrom utf-8 \xE2\x84\xAB]
set e [encoding convertfrom utf-8 \x41\xCC\x8A]
set s [join [list $a $b $c $d $e] ""]
puts "s=$s a=b→[expr {$a eq $b}] a=c→[expr {$a eq $c}] a=d→[expr {$a eq $d}] a=e→[expr {$a eq $e}] b=c→[expr {$a eq $d}] b=d→[expr {$a eq $d}] b=e→[expr {$a eq $e}] c=d→[expr {$a eq $d}] c=e→[expr {$a eq $e}]"
=>
s=ÅÅÅÅÅ a=b→0 a=c→1 a=d→0 a=e→0 b=c→0 b=d→0 b=e→0 c=d→0 c=e→0
```

Die obige Ausgabe zeigt, dass alle Zeichen zwar dieselben sind, jedoch unterschiedliche UTF-8-Darstellungen aufweisen und daher *nicht* als gleich verglichen werden.

Die Lösung besteht darin, die Daten zu normalisieren. Zum Beispiel:

```
set t [unicode::normalizeS KC $s]
set a [string index $t 0]
set b [string index $t 1]
set c [string index $t 2]
set d [string index $t 3]
set e [string index $t 4]
puts "t=$t a=b→[expr {$a eq $b}] a=c→[expr {$a eq $c}] a=d→[expr {$a eq $d}] a=e→[expr {$a eq $e}] b=c→[expr {$a eq $d}] b=d→[expr {$a eq $d}] b=e→[expr {$a eq $e}] c=d→[expr {$a eq $d}] c=e→[expr {$a eq $e}]"
=>
t=ÅÅÅÅÅ a=b→1 a=c→1 a=d→1 a=e→1 b=c→1 b=d→1 b=e→1 c=d→1 c=e→1
```

Nach der Normalisierung weisen alle Zeichen dieselbe Darstellung auf und werden korrekt als gleichwertig verglichen.

## Ältere Beispiele

```
% ::unicode::fromstring "\u0410\u0411\u0412\u0413"
1040 1041 1042 1043
% ::unicode::tostring {49 50 51 52 53}
12345
%
```

```
% ::unicode::normalize D {7692 775}
68 803 775
% ::unicode::normalizeS KD "\u1d2c"
A
%
```

# Literatur

1. "Unicode Standard Annex #15: Unicode Normalization Forms", (<http://unicode.org/reports/tr15/>)


# Autoren

Sergei Golovan

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *stringprep* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Copyright

```
Copyright (c) 2007, Sergei Golovan <sgolovan@nes.ru>
```
