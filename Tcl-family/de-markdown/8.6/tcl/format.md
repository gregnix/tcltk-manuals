---
CommandName: format
title: format
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - scan(n)
 - sprintf(3)
 - string(n)
Keywords:
 - conversion specifier
 - format
 - sprintf
 - string
 - substitution
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

format - Zeichenkette im Stil von sprintf formatieren

# Übersicht

::: {.synopsis} :::
[format]{.cmd} [formatString]{.arg} [arg arg]{.optdot}
:::

# Einleitung

Dieser Befehl erzeugt eine formatierte Zeichenkette ähnlich wie die ANSI-C-Prozedur **sprintf**. *formatString* gibt an, wie das Ergebnis formatiert wird; dazu dienen **%**-Konvertierungsspezifizierer wie bei **sprintf**. Die zusätzlichen Argumente, sofern vorhanden, liefern die Werte, die in das Ergebnis eingesetzt werden. Der Rückgabewert von **format** ist die formatierte Zeichenkette.

# Details zum Formatieren

Der Befehl durchläuft *formatString* von links nach rechts. Jedes Zeichen der Formatzeichenkette wird an die Ergebniszeichenkette angehängt, sofern es kein Prozentzeichen ist. Ist das Zeichen ein **%**, wird es nicht in die Ergebniszeichenkette kopiert. Stattdessen werden die Zeichen nach dem **%** als Konvertierungsspezifizierer behandelt. Der Konvertierungsspezifizierer steuert, wie das jeweils nächste *arg* in ein bestimmtes Format umgewandelt wird; das Ergebnis wird anstelle des Konvertierungsspezifizierers an die Ergebniszeichenkette angehängt. Enthält die Formatzeichenkette mehrere Konvertierungsspezifizierer, steuert jeder die Umwandlung eines weiteren *arg*. Dem Befehl **format** müssen genügend *arg*s übergeben werden, um alle Konvertierungsspezifizierer in *formatString* zu bedienen.

Jeder Konvertierungsspezifizierer kann bis zu sechs verschiedene Teile enthalten: eine XPG3-Positionsangabe, eine Menge von Flags, eine Mindestfeldbreite, eine Genauigkeit, einen Größenmodifikator und ein Konvertierungszeichen. Jedes dieser Felder kann weggelassen werden, mit Ausnahme des Konvertierungszeichens. Die vorhandenen Felder müssen in der oben genannten Reihenfolge stehen. Die folgenden Absätze behandeln diese Felder der Reihe nach.

## Optionale Positionsangabe

Folgen auf das **%** eine Dezimalzahl und ein **$**, wie in „**%2$d**“, wird der zu konvertierende Wert nicht dem nächsten Argument der Reihe entnommen. Stattdessen stammt er aus dem Argument, das die Zahl angibt; dabei entspricht 1 dem ersten *arg*. Benötigt der Konvertierungsspezifizierer wegen **\***-Zeichen mehrere Argumente, werden aufeinanderfolgende Argumente verwendet, beginnend mit dem Argument, das die Zahl angibt. Dies folgt den XPG3-Konventionen für Positionsangaben. Enthält *formatString* Positionsangaben, müssen alle Spezifizierer Positionsangaben sein.

## Optionale Flags

Der zweite Teil eines Konvertierungsspezifizierers kann beliebige der folgenden Flag-Zeichen in beliebiger Reihenfolge enthalten:

**-**
: Legt fest, dass das konvertierte Argument in seinem Feld linksbündig ausgerichtet wird (Zahlen werden normalerweise rechtsbündig ausgerichtet und bei Bedarf mit führenden Leerzeichen aufgefüllt).

**+**
: Legt fest, dass eine Zahl immer mit Vorzeichen ausgegeben wird, auch wenn sie positiv ist.

*Leerzeichen*
: Legt fest, dass am Anfang der Zahl ein Leerzeichen eingefügt wird, wenn das erste Zeichen kein Vorzeichen ist.

**0**
: Legt fest, dass die Zahl links mit Nullen statt mit Leerzeichen aufgefüllt wird.

**#**
: Fordert eine alternative Ausgabeform an. Bei **o**-Konvertierungen garantiert es, dass die erste Ziffer immer **0** ist. Bei **x**- oder **X**-Konvertierungen wird **0x** bzw. **0X** am Anfang des Ergebnisses eingefügt, sofern das Ergebnis nicht null ist. Bei **b**-Konvertierungen wird **0b** am Anfang des Ergebnisses eingefügt, sofern das Ergebnis nicht null ist. Bei allen Gleitkommakonvertierungen (**e**, **E**, **f**, **g** und **G**) garantiert es, dass das Ergebnis immer einen Dezimalpunkt enthält. Bei **g**- und **G**-Konvertierungen legt es fest, dass nachgestellte Nullen nicht entfernt werden.


## Optionale Feldbreite

Der dritte Teil eines Konvertierungsspezifizierers ist eine Dezimalzahl, die eine Mindestfeldbreite für diese Konvertierung angibt. Sie dient typischerweise dazu, Spalten in tabellarischen Ausgaben auszurichten. Enthält das konvertierte Argument weniger Zeichen als die Mindestfeldbreite, wird es aufgefüllt, bis es so breit ist wie die Mindestfeldbreite. Normalerweise werden dazu links vom konvertierten Argument zusätzliche Leerzeichen eingefügt; mit den Flags **0** und **-** lässt sich stattdessen links mit Nullen bzw. rechts mit Leerzeichen auffüllen. Ist die Mindestfeldbreite als **\*** statt als Zahl angegeben, bestimmt das nächste Argument des Befehls **format** die Mindestfeldbreite; es muss ein Ganzzahlwert sein.

## Optionale Genauigkeit

Der vierte Teil eines Konvertierungsspezifizierers ist eine Genauigkeit; sie besteht aus einem Punkt, gefolgt von einer Zahl. Die Zahl wird je nach Konvertierung unterschiedlich verwendet. Bei **e**-, **E**- und **f**-Konvertierungen gibt sie die Anzahl der Ziffern rechts vom Dezimalpunkt an. Bei **g**- und **G**-Konvertierungen gibt sie die Gesamtzahl der Ziffern an, einschließlich derer auf beiden Seiten des Dezimalpunkts (nachgestellte Nullen nach dem Dezimalpunkt werden jedoch trotzdem weggelassen, sofern das Flag **#** nicht angegeben ist). Bei Ganzzahlkonvertierungen gibt sie die Mindestzahl der auszugebenden Ziffern an (bei Bedarf werden führende Nullen ergänzt). Bei **s**-Konvertierungen gibt sie die Höchstzahl der auszugebenden Zeichen an; ist die Zeichenkette länger, werden die überzähligen Zeichen am Ende weggelassen. Ist die Genauigkeit als **\*** statt als Zahl angegeben, bestimmt das nächste Argument des Befehls **format** die Genauigkeit; es muss eine numerische Zeichenkette sein.

## Optionaler Größenmodifikator

Der fünfte Teil eines Konvertierungsspezifizierers ist ein Größenmodifikator; er muss **ll**, **h** oder **l** sein. Ist er **ll**, legt er fest, dass ein Ganzzahlwert ohne Kürzung für die Konvertierung in eine formatierte Teilzeichenkette übernommen wird. Ist er **h**, legt er fest, dass ein Ganzzahlwert vor der Konvertierung auf einen 16-Bit-Bereich gekürzt wird. Diese Option ist selten nützlich. Ist er **l**, legt er fest, dass der Ganzzahlwert auf denselben Bereich gekürzt wird, den die Funktion **wide()** des Befehls [expr] liefert (mindestens einen 64-Bit-Bereich). Ist weder **h** noch **l** vorhanden, wird der Ganzzahlwert auf denselben Bereich gekürzt, den die Funktion **int()** des Befehls [expr] liefert (mindestens einen 32-Bit-Bereich, der aber durch den Wert des Elements **wordSize** im Array [tcl\_platform][tclvars] bestimmt wird).

## Pflicht-Konvertierungstyp

Am Ende eines Konvertierungsspezifizierers steht ein Buchstabe, der festlegt, welche Art von Konvertierung durchgeführt wird. Derzeit werden folgende Konvertierungszeichen unterstützt:

**d**
: Wandelt eine Ganzzahl in eine vorzeichenbehaftete dezimale Zeichenkette um.

**u**
: Wandelt eine Ganzzahl in eine vorzeichenlose dezimale Zeichenkette um. Ohne Bezug auf einen Kürzungsbereich ist diese Konvertierung sinnlos; daher ist der Größenmodifikator **ll** zusammen mit dem Konvertierungszeichen **u** nicht erlaubt.

**i**
: Wandelt eine Ganzzahl in eine vorzeichenbehaftete dezimale Zeichenkette um (gleichwertig mit **d**).

**o**
: Wandelt eine Ganzzahl in eine vorzeichenlose oktale Zeichenkette um.

**x** oder **X**
: Wandelt eine Ganzzahl in eine vorzeichenlose hexadezimale Zeichenkette um; dabei werden für **x** die Ziffern „0123456789abcdef“ und für **X** die Ziffern „0123456789ABCDEF“ verwendet.

**b**
: Wandelt eine Ganzzahl in eine vorzeichenlose binäre Zeichenkette um; dabei werden die Ziffern 0 und 1 verwendet.

**c**
: Wandelt eine Ganzzahl in das Unicode-Zeichen um, das sie darstellt.

**s**
: Keine Konvertierung; die Zeichenkette wird nur eingefügt.

**f**
: Wandelt eine Zahl in eine vorzeichenbehaftete dezimale Zeichenkette der Form *xx.yyy* um, wobei die Anzahl der *y* durch die Genauigkeit bestimmt wird (Vorgabe: 6). Ist die Genauigkeit 0, wird kein Dezimalpunkt ausgegeben.

**e** oder **E**
: Wandelt eine Zahl in wissenschaftliche Notation der Form *x.yyy***e±***zz* um, wobei die Anzahl der *y* durch die Genauigkeit bestimmt wird (Vorgabe: 6). Ist die Genauigkeit 0, wird kein Dezimalpunkt ausgegeben. Wird die Form **E** verwendet, wird **E** statt **e** ausgegeben.

**g** oder **G**
: Ist der Exponent kleiner als -4 oder größer als die Genauigkeit oder gleich ihr, wird die Zahl wie bei **%e** bzw. **%E** konvertiert. Andernfalls wird sie wie bei **%f** konvertiert. Nachgestellte Nullen und ein abschließender Dezimalpunkt werden weggelassen.

**%**
: Keine Konvertierung; es wird nur **%** eingefügt.


# Unterschiede zu ANSI sprintf

Das Verhalten des Befehls format entspricht dem der ANSI-C-Prozedur **sprintf**, abgesehen von den folgenden Unterschieden:

1. Tcl garantiert, dass es mit Unicode-Zeichen arbeitet.

2. Die Angaben **%p** und **%n** werden nicht unterstützt.

3. Bei **%c**-Konvertierungen muss das Argument ein Ganzzahlwert sein, der dann in den entsprechenden Zeichenwert umgewandelt wird.

4. Die Größenmodifikatoren werden beim Formatieren von Gleitkommawerten ignoriert. Der Modifikator **ll** hat keine Entsprechung in **sprintf**. Der Spezifizierer **b** hat keine Entsprechung in **sprintf**.


# Beispiele

Den numerischen Wert eines Unicode-Zeichens in das Zeichen selbst umwandeln:

```
set value 120
set char [format %c $value]
```

Die Ausgabe von [time] auf Hundertstelsekunden genau in Sekunden umrechnen:

```
set us [lindex [time $someTclCode] 0]
puts [format "%.2f seconds to execute" [expr {$us / 1e6}]]
```

Eine gepackte literale X11-Farbangabe erzeugen:

```
# Each color-component should be in range (0..255)
set color [format "#%02x%02x%02x" $r $g $b]
```

XPG3-Formatcodes verwenden, um Felder umordnen zu können, ohne die an **format** übergebenen Datenwerte umzuordnen (eine Technik, die oft in lokalisierten Meldungskatalogen verwendet wird; siehe [msgcat]):

```
set fmt1 "Today, %d shares in %s were bought at $%.2f each"
puts [format $fmt1 123 "Global BigCorp" 19.37]

set fmt2 "Bought %2\$s equity ($%3$.2f x %1\$d) today"
puts [format $fmt2 123 "Global BigCorp" 19.37]
```

Eine kleine Tabelle mit Dreierpotenzen ausgeben:

```
# Set up the column widths
set w1 5
set w2 10

# Make a nice header (with separator) for the table first
set sep +-[string repeat - $w1]-+-[string repeat - $w2]-+
puts $sep
puts [format "| %-*s | %-*s |" $w1 "Index" $w2 "Power"]
puts $sep

# Print the contents of the table
set p 1
for {set i 0} {$i<=20} {incr i} {
    puts [format "| %*d | %*ld |" $w1 $i $w2 $p]
    set p [expr {wide($p) * 3}]
}

# Finish off by printing the separator again
puts $sep
```


[expr]: expr.md
[msgcat]: msgcat.md
[tclvars]: tclvars.md
[time]: time.md
