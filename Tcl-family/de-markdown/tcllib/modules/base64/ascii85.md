---
CommandName: ascii85
title: ascii85
ManualSection: n
Version: 1.1.1
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - ascii85
 - encoding
Copyright:
 - Copyright (c) 2010, Emiliano Gavilán
---

# Name

ascii85 – Binärdaten mit ascii85 kodieren/dekodieren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ascii85]{.lit} [1.1]{.optlit}
[::ascii85::encode]{.cmd} [[-maxlen]{.lit} [maxlen]{.arg}]{.optarg} [[-wrapchar]{.lit} [wrapchar]{.arg}]{.optarg} [bstring]{.arg}
[::ascii85::decode]{.cmd} [estring]{.arg}
:::

# Beschreibung

Dieses Paket enthält Befehle zum Kodieren und Dekodieren von Binärzeichenfolgen in die bzw. aus der ASCII85-Kodierung. (Diese Kodierung ist auch als Base85 bekannt.)

# API

**::ascii85::encode** ?**-maxlen** *maxlen*? ?**-wrapchar** *wrapchar*? *bstring*
: Gibt als Ergebnis eine ASCII85-kodierte Version der Binärzeichenkette *bstring* zurück.

    Die Ergebniszeichenkette enthält nach jeweils *maxlen* Zeichen der Ausgabe das Zeichen *wrapchar*. Der Standardwert für *wrapchar* ist ein Zeilenumbruch, der Standardwert für *maxlen* ist 76. Um einen Zeilenumbruch zu verhindern, setzen Sie *maxlen* auf **0**.

    Der Befehl löst einen Fehler aus, wenn *maxlen* keine ganze Zahl oder negativ ist oder wenn *bstring* weder eine Binärzeichenkette noch eine Zeichenkette ist, die ausschließlich aus 7-Bit-ASCII-Zeichen besteht.

**::ascii85::decode** *estring*
: Gibt eine Binärzeichenkette zurück, die aus *estring* ASCII85-dekodiert wurde. Alle Leerzeichen (Leerzeichen, Tabulatoren, Zeilenumbrüche) in *estring* werden ignoriert.


# Beispiele

Dieses Beispiel zeigt, wie Sie eine Tcl-Zeichenkette in ascii85 kodiert und aus ascii85 dekodiert, wobei berücksichtigt wird, dass die ascii85-Befehle mit binären Zeichenketten arbeiten.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc85 [::ascii85::encode $bytes]
set dec85 [::ascii85::decode $enc85]
set line [encoding convertfrom utf-8 $dec85]
puts "ascii85='$enc85' [expr {$UTF8_LINE eq $line}]"
=>
ascii85='cBQ5U+Q@pA<HMh)39#IZ+QAf\ie4*' 1
```

Wenn die ursprüngliche Zeichenkette aus 7-Bit-ASCII-Zeichen besteht, sind die Konvertierungen in und aus Rohbytes mithilfe des integrierten Befehls **encoding** nicht erforderlich. Beispiel:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set enc85 [::ascii85::encode $ASCII_LINE]
set dec85 [::ascii85::decode $enc85]
set line [encoding convertfrom utf-8 $dec85]
puts "ascii85='$enc85' [expr {$ASCII_LINE eq $line}]"
=>
ascii85='+Wr]q@VKp,5uU-B8K`A/?@;' 1
```

Ein Zeilenumbruch kann verhindert werden, sodass keine Leerzeichen eingefügt werden:

```
ascii85::encode [string repeat xyz 24]
=>
G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G
^4U[H$X^\H?a^]
ascii85::encode -maxlen 0 [string repeat xyz 24]
=>
G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]
```

# Literatur

1. <http://en.wikipedia.org/wiki/Ascii85>

2. „Postscript Language Reference Manual“, 3. Auflage, Seite 131. <http://www.adobe.com/devnet/postscript/pdfs/PLRM.pdf>


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *base64* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
Copyright (c) 2010, Emiliano Gavilán
```
