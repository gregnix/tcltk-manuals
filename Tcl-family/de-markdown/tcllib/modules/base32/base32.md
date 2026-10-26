---
CommandName: base32
title: base32
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Base32 encoding
Links:
 - encoding
Keywords:
 - base32
 - rfc3548
 - rfc4648
Copyright:
---

# Name

base32 – Standard-Kodierung nach base32

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [base32::core]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [base32]{.lit} [0.2]{.optlit}
[::base32::encode]{.cmd} [bstring]{.arg}
[::base32::decode]{.cmd} [estring]{.arg}
:::

# Beschreibung

Dieses Paket stellt Befehle zur Kodierung und Dekodierung von Binärzeichenfolgen in die bzw. aus der Standard-Base32-Kodierung bereit, wie in [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648) *(sowie in der älteren* [RFC 3548](https://datatracker.ietf.org/doc/html/rfc3548))* festgelegt.*

# API

**::base32::encode** *bstring*
: Gibt als Ergebnis eine Base32-kodierte Version der Binärzeichenfolge *bstring* zurück.

    Das Ergebnis wird möglicherweise am Ende mit den Zeichen „**=**“ durch Innenabstand aufgefüllt, um sicherzustellen, dass die Länge des Ergebnisses ein Vielfaches von acht ist.

    Der Encoder löst einen Fehler aus, wenn *bstring* weder eine Binärzeichenfolge noch eine Zeichenfolge ist, die ausschließlich aus 7-Bit-ASCII-Zeichen besteht.

**::base32::decode** *estring*
: Gibt eine Binärzeichenkette zurück, die aus dem *estring* mittels Base32-Dekodierung gewonnen wurde.

    Beachten Sie, dass der Encoder zwar ausschließlich Großbuchstaben erzeugt, dieser Dekoder jedoch nicht zwischen Groß- und Kleinschreibung unterscheidet, d. h., er ist toleranter.

    Der Dekoder kann bei ungültiger Eingabe einen Fehler auslösen. Beispielsweise wenn:

    - Die Eingabe enthält Zeichen, die für Base32-kodierte Daten nicht zulässig sind;

    - Die Länge der Eingabe ist kein Vielfaches von acht;

    - Der Innenabstand erscheint in der Mitte und nicht am Ende der Eingabe;

    - Die Länge des Innenabstands beträgt nicht genau ein, drei, vier oder sechs Zeichen.



Es ist auch möglich, dass eine ungültige Eingabe *keinen* Fehler auslöst – beispielsweise reiner Text, der keine der oben aufgeführten Eigenschaften aufweist.

# Codetabelle

Die zur Konvertierung von 5-Bit-Sequenzen verwendete Codetabelle ist nachstehend aufgeführt, wobei links die numerische Kennung der Bitsequenzen und rechts das zur Kodierung verwendete Zeichen angegeben ist. Hinweis: Die Zeichen „0“ und „1“ werden bei der Kodierung *nicht* verwendet, um Verwechslungen mit „O“, „o“ und „l“ (L) zu vermeiden.

```
	0 A    9 J   18 S   27 3
	1 B   10 K   19 T   28 4
	2 C   11 L   20 U   29 5
	3 D   12 M   21 V   30 6
	4 E   13 N   22 W   31 7
	5 F   14 O   23 X
	6 G   15 P   24 Y
	7 H   16 Q   25 Z
	8 I   17 R   26 2
```

# Beispiele

Dieses Beispiel veranschaulicht, wie eine Tcl-Zeichenkette in Base32 kodiert und aus Base32 dekodiert wird, wobei berücksichtigt wird, dass die Base32-Befehle mit binären Zeichenketten arbeiten.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc32 [::base32::encode $bytes]
set dec32 [::base32::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32='$enc32' [expr {$UTF8_LINE eq $line}]"
=>
base32='Z2KMHNZA4KAJYVLUMYWTRYUATUQOFGM64KCKI===' 1
```

Wenn die ursprüngliche Zeichenkette aus 7-Bit-ASCII-Zeichen besteht, sind die Konvertierungen in und aus Rohbytes mithilfe des integrierten Befehls [encoding](https://www.tcl-lang.org/man/tcl/TclCmd/encoding.html) nicht erforderlich. Beispiele:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set enc32 [::base32::encode $ASCII_LINE]
set dec32 [::base32::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32='$enc32' [expr {$ASCII_LINE eq $line}]"
=>
base32='EEQDOLLCNF2CAQKTINEUSID3PZPH2===' 1
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *base32* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
Public domain
```
