---
CommandName: scan
title: scan
ManualSection: n
Version: 8.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - format(n)
 - sscanf(3)
Keywords:
 - conversion specifier
 - parse
 - scan
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2000 Scriptics Corporation.
---

# Name

scan - Zeichenkette mit Konvertierungsspezifizierern im sscanf-Stil parsen

# Übersicht

::: {.synopsis} :::
[scan]{.cmd} [string]{.arg} [format]{.arg} [varName varName]{.optdot}
:::

# Einleitung

Dieser Befehl parst Teilzeichenketten aus einer Eingabezeichenkette ähnlich wie die ANSI-C-Prozedur **sscanf** und gibt die Anzahl der durchgeführten Konvertierungen zurück; wird das Ende der Eingabezeichenkette erreicht, bevor eine Konvertierung durchgeführt wurde, gibt er -1 zurück. *string* enthält die zu parsende Eingabe, und *format* gibt an, wie sie geparst wird; dazu dienen **%**-Konvertierungsspezifizierer wie bei **sscanf**. Jedes *varName* gibt den Namen einer Variablen an. Wird aus *string* eine Teilzeichenkette gelesen, die zu einem Konvertierungsspezifizierer passt, wird sie der entsprechenden Variablen zugewiesen. Sind keine *varName*-Variablen angegeben, arbeitet **scan** inline: Er gibt die Daten, die sonst in den Variablen gespeichert würden, als Liste zurück. Im Inline-Fall wird eine leere Zeichenkette zurückgegeben, wenn das Ende der Eingabezeichenkette erreicht wird, bevor eine Konvertierung durchgeführt wurde.

# Details zum Scannen

**scan** arbeitet, indem er *string* und *format* gemeinsam durchläuft. Ist das nächste Zeichen in *format* ein Leerzeichen oder ein Tabulator, passt es zu beliebig vielen Leerraumzeichen in *string* (auch zu keinem). Ist es sonst kein **%**-Zeichen, muss es mit dem nächsten Zeichen von *string* übereinstimmen. Ein **%** in *format* kennzeichnet den Beginn eines Konvertierungsspezifizierers. Ein Konvertierungsspezifizierer enthält nach dem **%** bis zu vier Felder: eine XPG3-Positionsangabe (oder ein **\***, das anzeigt, dass der konvertierte Wert verworfen und keiner Variablen zugewiesen wird), eine Zahl für die maximale Breite der Teilzeichenkette, einen Größenmodifikator und ein Konvertierungszeichen. Alle diese Felder sind optional, mit Ausnahme des Konvertierungszeichens. Die vorhandenen Felder müssen in der oben genannten Reihenfolge stehen.

Findet **scan** einen Konvertierungsspezifizierer in *format*, überspringt er zunächst alle Leerraumzeichen in *string* (außer wenn das Konvertierungszeichen **\[** oder **c** ist). Dann konvertiert er die nächsten Eingabezeichen gemäß dem Konvertierungsspezifizierer und speichert das Ergebnis in der Variablen, die das nächste Argument von **scan** angibt.

## Optionale Positionsangabe

Folgen auf das **%** eine Dezimalzahl und ein **$**, wie in „**%2$d**“, wird die zu verwendende Variable nicht dem nächsten Argument der Reihe entnommen. Stattdessen stammt sie aus dem Argument, das die Zahl angibt; dabei entspricht 1 dem ersten *varName*. Enthält *format* Positionsangaben, müssen alle Spezifizierer Positionsangaben sein. Jedes *varName* in der Argumentliste muss genau einem Konvertierungsspezifizierer entsprechen, sonst wird ein Fehler erzeugt. Im Inline-Fall darf jede Position höchstens einmal angegeben werden, und die leeren Positionen werden mit leeren Zeichenketten gefüllt.

## Optionaler Größenmodifikator

Das Feld für den Größenmodifikator wird nur verwendet, wenn eine Teilzeichenkette in einen der Ganzzahlwerte von Tcl gelesen wird. Es legt fest, welcher Ganzzahlbereich in einer Variablen gespeichert werden kann, im Inline-Fall an einer Position der Ergebnisliste. Syntaktisch gültige Werte für den Größenmodifikator sind **h**, **l**, **z**, **t**, **q**, **j**, **ll** und **L**. Der Größenmodifikator **h** ist gleichwertig mit dem Fehlen eines Größenmodifikators im Konvertierungsspezifizierer. Beide bedeuten, dass der zu speichernde Ganzzahlbereich auf den 32-Bit-Bereich begrenzt ist. Der Größenmodifikator **L** ist gleichwertig mit dem Größenmodifikator **ll**. Beide bedeuten, dass der zu speichernde Ganzzahlbereich unbegrenzt ist. Der Größenmodifikator **l** (oder **q** oder **j**) bedeutet, dass der zu speichernde Ganzzahlbereich auf denselben Bereich begrenzt ist, den die Funktion **wide()** des Befehls [expr] liefert. Die Modifikatoren **z** und **t** legen denselben Ganzzahlbereich fest wie **h** oder **l**, je nach dem Wert des Elements **pointerSize** im Array [tcl\_platform][tclvars].

## Pflicht-Konvertierungszeichen

Folgende Konvertierungszeichen werden unterstützt:

**d**
: Die Eingabe-Teilzeichenkette muss eine dezimale Ganzzahl sein. Sie wird eingelesen, und der Ganzzahlwert wird in der Variablen gespeichert, gekürzt nach den Vorgaben des Größenmodifikators.

**o**
: Die Eingabe-Teilzeichenkette muss eine oktale Ganzzahl sein. Sie wird eingelesen, und der Ganzzahlwert wird in der Variablen gespeichert, gekürzt nach den Vorgaben des Größenmodifikators.

**x** oder **X**
: Die Eingabe-Teilzeichenkette muss eine hexadezimale Ganzzahl sein. Sie wird eingelesen, und der Ganzzahlwert wird in der Variablen gespeichert, gekürzt nach den Vorgaben des Größenmodifikators.

**b**
: Die Eingabe-Teilzeichenkette muss eine binäre Ganzzahl sein. Sie wird eingelesen, und der Ganzzahlwert wird in der Variablen gespeichert, gekürzt nach den Vorgaben des Größenmodifikators.

**u**
: Die Eingabe-Teilzeichenkette muss eine dezimale Ganzzahl sein. Der Ganzzahlwert wird nach den Vorgaben des Größenmodifikators gekürzt; dann wird der entsprechende vorzeichenlose Wert für diesen gekürzten Bereich berechnet und als dezimale Zeichenkette in der Variablen gespeichert.

**i**
: Die Eingabe-Teilzeichenkette muss eine Ganzzahl sein. Die Basis (also dezimal, oktal oder hexadezimal) wird nach der C-Konvention bestimmt (führende 0 für oktal, Präfix 0x für hexadezimal). Der Ganzzahlwert wird in der Variablen gespeichert, gekürzt nach den Vorgaben des Größenmodifikators.

**c**
: Ein einzelnes Zeichen wird eingelesen, und sein Unicode-Wert wird als Ganzzahlwert in der Variablen gespeichert. Führender Leerraum wird in diesem Fall nicht übersprungen; die Eingabe-Teilzeichenkette kann also ein Leerraumzeichen sein.

**s**
: Die Eingabe-Teilzeichenkette besteht aus allen Zeichen bis zum nächsten Leerraumzeichen; diese Zeichen werden in die Variable kopiert.

**e** oder **f** oder **g** oder **E** oder **G**
: Die Eingabe-Teilzeichenkette muss eine Gleitkommazahl sein. Sie besteht aus einem optionalen Vorzeichen, einer Folge von Dezimalziffern, die einen Dezimalpunkt enthalten kann, und einem optionalen Exponenten. Der Exponent besteht aus einem **e** oder **E**, gefolgt von einem optionalen Vorzeichen und einer Folge von Dezimalziffern. Die Zahl wird eingelesen und als Gleitkommawert in der Variablen gespeichert.

**\[***chars***\]**
: Die Eingabe-Teilzeichenkette besteht aus einem oder mehreren Zeichen aus *chars*. Die passende Zeichenkette wird in der Variablen gespeichert. Ist das erste Zeichen zwischen den Klammern ein **\]**, wird es als Teil von *chars* behandelt und nicht als schließende Klammer der Menge. Enthält *chars* eine Folge der Form *a***-***b*, passt jedes Zeichen zwischen *a* und *b* (einschließlich). Ist das erste oder letzte Zeichen zwischen den Klammern ein **-**, wird es als Teil von *chars* behandelt und gibt keinen Bereich an.

**\[^***chars***\]**
: Die Eingabe-Teilzeichenkette besteht aus einem oder mehreren Zeichen, die nicht in *chars* enthalten sind. Die passende Zeichenkette wird in der Variablen gespeichert. Ist das Zeichen unmittelbar nach dem **^** ein **\]**, wird es als Teil der Menge behandelt und nicht als schließende Klammer der Menge. Enthält *chars* eine Folge der Form *a***-***b*, wird jedes Zeichen zwischen *a* und *b* (einschließlich) aus der Menge ausgeschlossen. Ist das erste oder letzte Zeichen zwischen den Klammern ein **-**, wird es als Teil von *chars* behandelt und gibt keinen Bereich an.

**n**
: Aus der Eingabezeichenkette wird nichts verbraucht. Stattdessen wird die Gesamtzahl der bisher aus der Eingabezeichenkette gelesenen Zeichen in der Variablen gespeichert.


Die Anzahl der für eine Konvertierung gelesenen Eingabezeichen ist die größte Anzahl, die für die jeweilige Konvertierung sinnvoll ist (z. B. so viele Dezimalziffern wie möglich bei **%d**, so viele Oktalziffern wie möglich bei **%o** usw.). Die Eingabe-Teilzeichenkette einer Konvertierung endet, sobald ein Leerraumzeichen auftritt oder die maximale Breite der Teilzeichenkette erreicht ist, je nachdem, was zuerst eintritt. Enthält der Konvertierungsspezifizierer ein **\***, wird keiner Variablen etwas zugewiesen, und das nächste Argument von **scan** wird nicht verbraucht.

# Unterschiede zu ANSI sscanf

Das Verhalten des Befehls **scan** entspricht dem der ANSI-C-Prozedur **sscanf**, mit folgenden Unterschieden:

1. Der Konvertierungsspezifizierer **%p** wird nicht unterstützt.

2. Bei **%c**-Konvertierungen wird ein einzelner Zeichenwert in eine dezimale Zeichenkette umgewandelt, die dann dem entsprechenden *varName* zugewiesen wird; für diese Konvertierung kann keine Breite der Teilzeichenkette angegeben werden.

3. Der Modifikator **h** wird immer ignoriert, und die Modifikatoren **l** und **L** werden bei der Konvertierung reeller Werte ignoriert (für die interne Darstellung wird also der Typ **double** verwendet). Der Modifikator **ll** hat keine Entsprechung in **sscanf**.

4. Wird das Ende der Eingabezeichenkette erreicht, bevor eine Konvertierung durchgeführt wurde, und sind keine Variablen angegeben, wird eine leere Zeichenkette zurückgegeben.


# Beispiele

Ein Unicode-Zeichen in seinen numerischen Wert umwandeln:

```
set char "x"
set value [scan $char %c]
```

Eine einfache Farbangabe der Form *#RRGGBB* mit hexadezimalen Konvertierungen und Größen für die Teilzeichenketten parsen:

```
set string "#08D03F"
scan $string "#%2x%2x%2x" r g b
```

Eine Zeitangabe der Form *HH:MM* parsen:

```
set string "08:08"
if {[scan $string "%d:%d" hours minutes] != 2} {
    error "not a valid time string"
}
# We have to understand numeric ranges ourselves...
if {$minutes < 0 || $minutes > 59} {
    error "invalid number of minutes"
}
```

Eine Zeichenkette in Folgen von Nicht-Leerraumzeichen zerlegen (beachten Sie die Verwendung der Konvertierung **%n**, damit das Überspringen von führendem Leerraum korrekt funktioniert):

```
set string " a string {with braced words} + leading space "
set words {}
while {[scan $string %s%n word length] == 2} {
    lappend words $word
    set string [string range $string $length end]
}
```

Eine einfache Koordinatenangabe parsen und prüfen, ob sie vollständig ist, indem ausdrücklich nach dem abschließenden Zeichen gesucht wird:

```
set string "(5.2,-4e-2)"
# Note that the spaces before the literal parts of
# the scan pattern are significant, and that ")" is
# the Unicode character \u0029
if {
    [scan $string " (%f ,%f %c" x y last] != 3
    || $last != 0x0029
} then {
    error "invalid coordinate string"
}
puts "X=$x, Y=$y"
```

Eine interaktive Sitzung, die zeigt, wie Ganzzahlwerte abhängig vom Größenmodifikator gekürzt werden:

```
% scan 20000000000000000000 %d
2147483647
% scan 20000000000000000000 %ld
9223372036854775807
% scan 20000000000000000000 %lld
20000000000000000000
```


[expr]: expr.md
[tclvars]: tclvars.md
