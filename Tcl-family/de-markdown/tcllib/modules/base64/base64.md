---
CommandName: base64
title: base64
ManualSection: n
Version: 2.6.1
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - base64
 - encoding
Copyright:
 - Copyright (c) 2000, Eric Melski
 - Copyright (c) 2001, Miguel Sofer
---

# Name

base64 – Binärdaten in Base64 kodieren/dekodieren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [base64]{.lit} [2.6.1]{.optlit}
[::base64::encode]{.cmd} [[-maxlen]{.lit} [maxlen]{.arg}]{.optarg} [[-wrapchar]{.lit} [wrapchar]{.arg}]{.optarg} [bstring]{.arg}
[::base64::decode]{.cmd} [estring]{.arg}
:::

# Beschreibung

Dieses Paket enthält Befehle zum Kodieren und Dekodieren von Binärzeichenfolgen in die bzw. aus der Standard-Base64-Kodierung, wie in [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648) festgelegt.

*Es wird empfohlen, bei neuem Code die integrierten* [binary](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) *Unterbefehle zur Kodierung und Dekodierung von Base64 (eingeführt in Tcl 8.6) den Befehlen dieses Pakets vorzuziehen.*

## Achtung: Abweichungen im Dekodierungsverhalten

Mit Tcl 8.6 wurde eine integrierte Unterstützung für die Base64-Kodierung und -Dekodierung eingeführt, die über Unterbefehle des Befehls [binary](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) erfolgt:

```
    binary encode base64
    binary decode base64
```

Beachten Sie, dass diese Unterbefehle zwar dieselben Signaturen wie die von diesem Paket bereitgestellten Befehle haben, die Decoder jedoch *nicht verhaltenskompatibel* sind.

Der integrierte Unterbefehl [binary decode base64](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) akzeptiert die Option **-strict**, mit der der Benutzer zwischen dem strengen und dem nicht-strengen Modus wählen kann. Im strengen Modus werden ungültige Zeichen und unvollständige Daten am Ende der Eingabe als Fehler gemeldet. Im nicht-strengen Modus werden sie ignoriert. (Siehe [RFC 2045](https://www.rfc-editor.org/rfc/rfc2045#section-6.8).)

Die in diesem Paket bereitgestellten Implementierungen bieten keine Möglichkeit, die Strenge zu steuern. Stattdessen werden strenge und nicht-strenge Werte gemischt. Unvollständige Daten am Ende der Eingabe werden als Fehler gemeldet, ungültige Zeichen werden jedoch ignoriert.

Standardmäßig führt der Encoder dieses Pakets nach jeweils 76 Zeichen in der Ausgabe einen Zeilenumbruch durch. Der integrierte Unterbefehl [binary encode base64](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) ist standardmäßig so eingestellt, dass kein Zeilenumbruch erfolgt, unterstützt jedoch den Zeilenumbruch mithilfe der Option **-maxlen**.

# API

**::base64::encode** ?**-maxlen** *maxlen*? ?**-wrapchar** *wrapchar*? *bstring*
: Gibt als Ergebnis eine Base64-kodierte Version der Binärzeichenkette *bstring* zurück.

    Die Ergebniszeichenkette enthält nach jeweils *maxlen* Zeichen der Ausgabe das Zeichen *wrapchar*. Der Standardwert für *wrapchar* ist ein Zeilenumbruch, der Standardwert für *maxlen* ist 76. Um einen Zeilenumbruch zu verhindern, setzen Sie *maxlen* auf **0**.

    Der Befehl löst einen Fehler aus, wenn *maxlen* keine ganze Zahl oder negativ ist oder wenn *bstring* weder eine Binärzeichenfolge noch eine Zeichenfolge ist, die ausschließlich aus 7-Bit-ASCII-Zeichen besteht.

**::base64::decode** *estring*
: Gibt eine Binärzeichenkette zurück, die aus *estring* Base64-dekodiert wurde. Ungültige Zeichen oder Leerzeichen (Leerzeichen, Tabulatoren, Zeilenumbrüche) in *estring* werden ignoriert.


# Hinweise zur Umsetzung

Dieses Paket enthält drei verschiedene Implementierungen für die Base64-Kodierung und -Dekodierung und wählt je nach der Umgebung, in der es ausgeführt wird, eine davon aus.

Alle drei Implementierungen verhalten sich gleich. Siehe auch [Achtung: Abweichungen im Dekodierungsverhalten] am Anfang dieses Dokuments.

1. Wenn Tcl 8.6 oder höher erkannt wird, werden die Befehle mithilfe der zu diesem Zeitpunkt verfügbaren integrierten Befehle implementiert.

2. Wenn die Erweiterung [Trf](https://wiki.tcl-lang.org/page/Trf) geladen werden kann, werden die Befehle mithilfe ihrer Befehle umgesetzt.

3. Wenn keine der beiden oben genannten Möglichkeiten in Frage kommt, wird eine reine Tcl-Implementierung verwendet. Diese ist deutlich langsamer.


# Beispiele

Dieses Beispiel zeigt, wie Sie eine Tcl-Zeichenkette in Base64 kodiert und aus Base64 dekodiert, wobei zu berücksichtigen ist, dass die Base64-Befehle mit binären Zeichenketten arbeiten.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
# Legacy (this package)
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc64 [::base64::encode $bytes]
set dec64 [::base64::decode $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$UTF8_LINE eq $line}]"
=>
base64='zpTDtyDigJxVdGYtOOKAnSDimZ7ihKQ=' 1
# Modern (using built-in binary subcommands)
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc64 [binary encode base64 $bytes]
set dec64 [binary decode base64 $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$UTF8_LINE eq $line}]"
=>
base64='zpTDtyDigJxVdGYtOOKAnSDimZ7ihKQ=' 1
```

Wenn die ursprüngliche Zeichenkette aus 7-Bit-ASCII-Zeichen besteht, sind die Konvertierungen in und aus Rohbytes mithilfe des integrierten Befehls [encoding](https://www.tcl-lang.org/man/tcl/TclCmd/encoding.html) nicht erforderlich. Beispiele:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
# Legacy (this package)
set enc64 [::base64::encode $ASCII_LINE]
set dec64 [::base64::decode $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$ASCII_LINE eq $line}]"
=>
base64='ISA3LWJpdCBBU0NJSSB7fl59' 1
# Modern (using built-in binary subcommands)
set enc64 [binary encode base64 $ASCII_LINE]
set dec64 [binary decode base64 $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$ASCII_LINE eq $line}]"
=>
base64='ISA3LWJpdCBBU0NJSSB7fl59' 1
```

Ein Zeilenumbruch kann verhindert werden, sodass keine Leerzeichen eingefügt werden:

```
base64::encode [string repeat xyz 20]
=>
eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6
eHl6eHl6eHl6
base64::encode -maxlen 0 [string repeat xyz 20]
=>
eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6
```

Hinweis: Der integrierte Unterbefehl [binary encode base64](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) standardmäßig einfügt keine Zeilenumbrüche, dies jedoch tut, wenn die Option **-maxlen** verwendet wird.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *base64* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
Copyright (c) 2000, Eric Melski
Copyright (c) 2001, Miguel Sofer
```
