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

Der Befehl erzeugt eine formatierte Zeichenkette analog zu ANSI-C **sprintf**. *formatString* legt das Format fest (**%**-Konvertierungen wie bei **sprintf**); weitere Argumente liefern die einzusetzenden Werte. Rückgabe: die formatierte Zeichenkette.

# Details zum Formatieren

**format** durchläuft *formatString* von links nach rechts. Jedes Zeichen wird an die Ergebniszeichenkette angehängt, außer es ist **%**. Dann wird nicht kopiert; die folgenden Zeichen sind ein Konvertierungsspezifizierer. Er steuert die Umwandlung des nächsten *arg* und ersetzt den Spezifizierer im Ergebnis. Mehrere Spezifizierer verarbeiten weitere *arg*s in Reihenfolge; es müssen genug *arg*s für alle Spezifizierer vorhanden sein.

Ein Spezifizierer kann bis zu sechs Teile haben: XPG3-Positionsangabe, Flags, Mindestfeldbreite, Genauigkeit, Größenmodifikator, Konvertierungszeichen. Pflicht ist nur das Konvertierungszeichen; vorhandene Teile in der genannten Reihenfolge. Die folgenden Absätze behandeln diese Felder der Reihe nach.

## Optionale Positionsangabe

Folgt auf **%** eine Dezimalzahl und **$** (z. B. **%2$d**), stammt der Wert nicht vom nächsten sequenziellen Argument, sondern vom angegebenen (1 = erstes *arg*). Benötigt der Spezifizierer mehrere Argumente wegen **\*** in der Angabe, werden ab diesem Argument weitere verwendet (XPG3). Sind Positionsangaben vorhanden, müssen alle Spezifizierer positional sein.

## Optionale Flags

Zweiter Teil des Spezifizierers, beliebige Reihenfolge:

**-**
: Linksbündig im Feld (Zahlen normalerweise rechtsbündig mit führenden Leerzeichen).

**+**
: Vorzeichen immer ausgeben, auch bei positiven Zahlen.

*Leerzeichen*
: Führendes Leerzeichen, wenn das erste Zeichen kein Vorzeichen ist.

**0**
: Links mit Nullen statt Leerzeichen auffüllen.

**#**
: Alternative Ausgabeform. **o**: erste Ziffer immer **0**. **x**/**X**: **0x** bzw. **0X** am Anfang (außer Null). **b**: **0b** am Anfang (außer Null). Gleitkomma (**e**, **E**, **f**, **g**, **G**): Dezimalpunkt immer. **g**/**G**: nachgestellte Nullen nicht entfernen.


## Optionale Feldbreite

Dritter Teil: Dezimalzahl als Mindestfeldbreite (Spaltenausrichtung). Ist das konvertierte Argument kürzer, wird aufgefüllt. Standard: Leerzeichen links; **0** und **-** steuern Nullen links bzw. Leerzeichen rechts. Steht **\*** statt einer Zahl, liefert das nächste *arg* die Breite (Ganzzahl).

## Optionale Genauigkeit

Vierter Teil: Punkt und Zahl. Bedeutung je nach Konvertierung: **e**, **E**, **f**: Stellen rechts vom Dezimalpunkt. **g**, **G**: Gesamtstellenzahl beider Seiten (nachgestellte Nullen nach dem Punkt ohne **#** dennoch weggelassen). Ganzzahl: Mindeststellenzahl (führende Nullen). **s**: maximale Zeichenanzahl; Rest wird abgeschnitten. **\*** als Genauigkeit: nächstes *arg* (numerische Zeichenkette).

## Optionaler Größenmodifikator

Fünfter Teil: Größenmodifikator **ll**, **h** oder **l**. **ll**: Ganzzahl ohne Kürzung. **h**: auf 16-Bit-Bereich kürzen (selten nützlich). **l**: Bereich wie **wide()** in [expr] (mindestens 64 Bit). Fehlen **h** und **l**: Bereich wie **int()** in [expr] (mindestens 32 Bit, bestimmt durch das Element **wordSize** des Arrays [tcl\_platform][tclvars]).

## Pflicht-Konvertierungstyp

Letztes Zeichen: Konvertierungsart:

**d**
: Ganzzahl → vorzeichenbehafteter Dezimalstring.

**u**
: Wandelt eine Ganzzahl in eine vorzeichenlose Dezimalzeichenkette um. Ohne Bezug auf einen Kürzungsbereich ist diese Umwandlung sinnlos; daher ist der Größenmodifikator **ll** zusammen mit dem Umwandlungszeichen **u** nicht erlaubt.

**i**
: wie **d**.

**o**
: Ganzzahl → vorzeichenlose Oktalzeichenkette.

**x** oder **X**
: Ganzzahl → vorzeichenlose Hexzeichenkette („0123456789abcdef“ bzw. „0123456789ABCDEF“).

**b**
: Ganzzahl → vorzeichenlose Binärzeichenkette (0 und 1).

**c**
: Ganzzahl → zugehöriges Unicode-Zeichen.

**s**
: keine Konvertierung; Zeichenkette einfügen.

**f**
: Zahl → Dezimalstring *xx.yyy*; Anzahl *y* durch Genauigkeit (Standard 6). Genauigkeit 0: kein Dezimalpunkt.

**e** oder **E**
: wissenschaftliche Notation *x.yyy***e±***zz*; *y*-Anzahl wie oben (Standard 6). Genauigkeit 0: kein Dezimalpunkt. **E** statt **e**.

**g** oder **G**
: Exponent &lt; -4 oder ≥ Genauigkeit → wie **%e**/**%E**, sonst wie **%f**. Nachgestellte Nullen und Punkt am Ende weggelassen.

**%**
: Literal **%**.


# Unterschiede zu ANSI sprintf

Wie **sprintf**, außer:

1. Tcl arbeitet mit UNICODE-Zeichen.

2. Die Angaben **%p** und **%n** werden nicht unterstützt.

3. Bei **%c** muss das Argument eine Ganzzahl sein (wird zum Zeichen).

4. Größenmodifikatoren bei Gleitkomma werden ignoriert. **ll** hat kein **sprintf**-Pendant. **b** hat kein **sprintf**-Pendant.


# Beispiele

Numerischen Unicode-Wert in ein Zeichen:

```
set value 120
set char [format %c $value]
```

[time]-Ausgabe in Sekunden mit Hundertsteln:

```
set us [lindex [time $someTclCode] 0]
puts [format "%.2f seconds to execute" [expr {$us / 1e6}]]
```

X11-Farbspezifikation:

```
# Each color-component should be in range (0..255)
set color [format "#%02x%02x%02x" $r $g $b]
```

XPG3-Positionscodes für lokalisierte Meldungen ([msgcat]), um Felder umzuordnen, ohne die an **format** übergebenen Werte umzuordnen:

```
set fmt1 "Today, %d shares in %s were bought at $%.2f each"
puts [format $fmt1 123 "Global BigCorp" 19.37]

set fmt2 "Bought %2\$s equity ($%3$.2f x %1\$d) today"
puts [format $fmt2 123 "Global BigCorp" 19.37]
```

Tabelle der Dreierpotenzen:

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
