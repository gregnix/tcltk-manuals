---
CommandName: base32::hex
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Base32 encoding
Links:
 - binary
 - encoding
Keywords:
 - base32
 - hex
 - rfc4648
Copyright:
---

# NAME

base32::hex – Base32-Kodierung mit erweiterter Hexadezimaldarstellung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [base32::core]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [base32::hex]{.lit} [0.2]{.optlit} 
[::base32::hex::encode]{.cmd} [bstring]{.arg} 
[::base32::hex::decode]{.cmd} [estring]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle zum Kodieren und Dekodieren von Binärzeichenfolgen in die bzw. aus der erweiterten Hex-Base32-Kodierung, wie in [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648)] festgelegt.

(Beachten Sie, dass der in Tcl integrierte Befehl [binary](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html)] eine einfache Kodierung und Dekodierung von Bytes in und aus Hexadezimalziffernpaaren ermöglicht.)

# API

**::base32::hex::encode** *bstring*
: Gibt als Ergebnis eine erweiterte, in der Hexadezimalbasis 32 kodierte Version der Binärzeichenfolge *bstring* zurück. Das Ergebnis wird möglicherweise am Ende mit den Zeichen **=** durch Padding aufgefüllt, um sicherzustellen, dass die Länge des Ergebnisses ein Vielfaches von acht ist. Der Encoder löst einen Fehler aus, wenn *bstring* weder eine Binärzeichenfolge noch eine Zeichenfolge ist, die ausschließlich aus 7-Bit-ASCII-Zeichen besteht.

**::base32::hex::decode** *estring*
: Gibt eine binäre Zeichenkette zurück, die aus dem *estring* in der erweiterten Hex-Base32-Kodierung dekodiert wurde. Hinweis: Der Encoder erzeugt zwar ausschließlich Großbuchstaben, dieser Decoder unterscheidet jedoch nicht zwischen Groß- und Kleinschreibung, d. h., er ist toleranter. Der Decoder kann bei ungültiger Eingabe einen Fehler auslösen. Beispielsweise wenn:


**•**
: Die Eingabe enthält Zeichen, die für erweiterte, in der Base-32-Kodierung kodierte Daten nicht zulässig sind;

**•**
: Die Länge der Eingabe ist kein Vielfaches von acht;

**•**
: Der Innenabstand erscheint in der Mitte und nicht am Ende der Eingabe;

**•**
: Die Länge des Innenabstands beträgt nicht genau ein, drei, vier oder sechs Zeichen.


Es ist auch möglich, dass eine ungültige Eingabe *keinen* Fehler auslöst – beispielsweise reiner Text, der keine der oben aufgeführten Eigenschaften aufweist.

# CODETABELLE

Die Codetabelle zur Umwandlung von 5-Bit-Sequenzen ist nachstehend aufgeführt, wobei links die numerische Kennung der Bitsequenzen und rechts das zur Kodierung verwendete Zeichen angegeben ist. Das wesentliche Merkmal der erweiterten Hexadezimal-Zuordnung besteht darin, dass die ersten 16 Codes den Ziffern und Hexadezimalzeichen zugeordnet sind.

```
	0 0    9 9        18 I   27 R
	1 1   10 A        19 J   28 S
	2 2   11 B        20 K   29 T
	3 3   12 C        21 L   30 U
	4 4   13 D        22 M   31 V
	5 5   14 E        23 N
	6 6   15 F        24 O
	7 7        16 G   25 P
	8 8        17 H   26 Q
```

# BEISPIELE

Dieses Beispiel veranschaulicht, wie eine Tcl-Zeichenkette in das erweiterte Hex-Base32-Format kodiert und wieder daraus dekodiert wird, wobei zu berücksichtigen ist, dass die Befehle für das erweiterte Hex-Base32-Format mit binären Zeichenketten arbeiten.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc32 [::base32::hex::encode $bytes]
set dec32 [::base32::hex::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32::hex='$enc32' [expr {$UTF8_LINE eq $line}]"
=>
base32::hex='PQAC7DP0SA09OLBKCOMJHOK0JKGE56CUSA2A8===' 1
```

Wenn es sich bei der ursprünglichen Zeichenkette um 7-Bit-ASCII handelt, sind die Konvertierungen in und aus Rohbytes mithilfe des Befehls **encoding** nicht erforderlich. Beispiel:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set enc32 [::base32::hex::encode $ASCII_LINE]
set dec32 [::base32::hex::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32::hex='$enc32' [expr {$ASCII_LINE eq $line}]"
=>
base32::hex='44G3EBB2D5Q20GAJ8D4KI83RFPF7Q===' 1
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *base32* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung

# COPYRIGHT

```
Public domain
```
