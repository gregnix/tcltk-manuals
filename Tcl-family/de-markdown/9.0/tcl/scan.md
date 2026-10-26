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

Der Befehl parst Teilstrings aus einer Eingabezeichenkette analog zu ANSI-C **sscanf** und gibt die Anzahl erfolgreicher Konvertierungen zurück, oder -1, wenn das Ende von *string* erreicht wird, bevor eine Konvertierung gelang. *string* ist die Eingabe, *format* legt das Muster fest (**%** wie bei **sscanf**). Jedes *varName* benennt eine Variable; passt ein Teilstring zu einem Spezifizierer, wird er der Variable zugewiesen. Ohne *varName* arbeitet **scan** inline und gibt die Werte als Liste zurück; am Ende ohne Konvertierung: leerer String.

# Details zum Scannen

**scan** durchläuft *string* und *format* gemeinsam. Ist das nächste Zeichen in *format* Leerzeichen oder Tab, entspricht es beliebig viel Leerraum in *string* (auch null). Sonst, wenn es kein **%** ist, muss es mit dem nächsten Zeichen von *string* übereinstimmen. **%** beginnt einen Konvertierungsspezifizierer mit bis zu vier Feldern: XPG3-Position (oder **\*** zum Verwerfen), maximale Teilstringbreite, Größenmodifikator, Konvertierungszeichen (Pflicht). Reihenfolge wie oben.

Bei einem Spezifizierer überspringt **scan** zunächst Leerraum in *string* (außer bei **\[** oder **c**), konvertiert dann die nächsten Zeichen und speichert das Ergebnis in der nächsten Variable.

## Optionale Positionsangabe

**%** gefolgt von Zahl und **$** (z. B. **%2$d**): Variable nicht sequenziell, sondern vom angegebenen *varName* (1 = erstes). Sind Positionsangaben vorhanden, müssen alle positional sein. Jedes *varName* muss genau einem Spezifizierer entsprechen, sonst Fehler; inline darf jede Position höchstens einmal vorkommen, leere Positionen werden mit leeren Strings gefüllt.

## Optionaler Größenmodifikator

Nur bei Tcl-Ganzzahlen relevant; begrenzt den speicherbaren Bereich (bzw. Listenposition inline). Gültig: **h**, **l**, **z**, **t**, **q**, **j**, **ll**, **L**. **h** oder fehlend: 32-Bit-Bereich. **L** oder **ll**: unbegrenzt. **l** (**q**, **j**): Bereich wie **wide()** in [expr]. **z**/**t**: wie **h** oder **l** je nach **pointerSize** in [tcl\_platform][tclvars].

## Pflicht-Konvertierungszeichen

Folgende Konvertierungszeichen werden unterstützt:

**d**
: Dezimalganzzahl; Wert in Variable, gekürzt gemäß Größenmodifikator.

**o**
: Oktalganzzahl; wie oben.

**x** oder **X**
: Hexadezimalganzzahl; wie oben.

**b**
: Binärganzzahl; wie oben.

**u**
: Dezimalganzzahl; nach Kürzung entsprechender vorzeichenloser Wert als Dezimalstring in der Variable.

**i**
: Ganzzahl; Basis per C-Konvention (führende 0 Oktal, **0x** Hex); Kürzung wie oben.

**c**
: Ein Zeichen; Unicode-Wert als Ganzzahl in der Variable. Kein Überspringen von Leerraum; Teilstring kann Leerzeichen sein.

**s**
: Alle Zeichen bis zum nächsten Leerraum; Kopie in die Variable.

**e** oder **f** oder **g** oder **E** oder **G**
: Gleitkommazahl mit optionalem Vorzeichen, Dezimalziffern optional mit Punkt, optionaler Exponent **e**/**E** mit Vorzeichen und Ziffern; intern als Gleitkomma.

**\[***chars***\]**
: Ein oder mehr Zeichen aus *chars*; Treffer in Variable. Steht **\]** zuerst in *chars*, gehört es zu *chars*. Bereich *a***-***b* inklusive. Führendes oder abschließendes **-** in *chars* ist Literal, kein Bereich.

**\[^***chars***\]**
: Zeichen nicht in *chars*; Treffer in Variable. **^** gefolgt von **\]**: **\]** gehört zur Menge. Bereiche und **-** wie oben.

**n**
: Kein Verbrauch aus *string*; bisher gescannte Zeichenanzahl in die Variable.


Gelesen wird jeweils die längste sinnvolle Folge (**%d**: Dezimalziffern, **%o**: Oktal, usw.). Abbruch bei Leerzeichen oder maximaler Breite. **\*** im Spezifizierer: keine Zuweisung, nächstes Scan-Argument wird nicht verbraucht.

# Unterschiede zu ANSI sscanf

Wie **sscanf**, außer:

1. **%p** wird nicht unterstützt.

2. Bei **%c** wird ein Zeichen in einen Dezimalstring umgewandelt und zugewiesen; keine Teilstringbreite.

3. **h** wird ignoriert; **l** und **L** bei reellen Werten ignoriert (intern **double**). **ll** hat kein **sscanf**-Äquivalent.

4. Ende von *string* vor Konvertierungen ohne Variablen: leerer String.


# Beispiele

Unicode-Zeichen in numerischen Wert:

```
set char "x"
set value [scan $char %c]
```

Farbe *#RRGGBB* mit Hex und Feldgrößen:

```
set string "#08D03F"
scan $string "#%2x%2x%2x" r g b
```

Zeit *HH:MM*:

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

Nicht-Leerwort-Sequenzen (**%n** für korrektes Überspringen von Leerraum):

```
set string " a string {with braced words} + leading space "
set words {}
while {[scan $string %s%n word length] == 2} {
    lappend words $word
    set string [string range $string $length end]
}
```

Koordinatenstring mit explizitem Abschlusszeichen:

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

Kürzung durch Größenmodifikatoren:

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
