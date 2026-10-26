---
CommandName: uuencode
title: uuencode
ManualSection: n
Version: 1.1.6
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - encoding
 - uuencode
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# Name

uuencode – Binäre Daten im UU-Format kodieren/dekodieren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [uuencode]{.lit} [1.1.6]{.optlit}
[::uuencode::encode]{.cmd} [bstring]{.arg}
[::uuencode::decode]{.cmd} [estring]{.arg}
[::uuencode::uuencode]{.cmd} [[-name]{.lit} [string]{.arg}]{.optarg} [[-mode]{.lit} [octal]{.arg}]{.optarg} ([-file]{.lit} [filename]{.arg} | [--]{.optlit} [bstring]{.arg})
[::uuencode::uudecode]{.cmd} ([-file]{.lit} [filename]{.arg} | [--]{.optlit} [estring]{.arg})
:::

# Beschreibung

Dieses Paket enthält eine reine Tcl-Implementierung der Befehle **uuencode(1p)** <https://www.man7.org/linux/man-pages/man1/uuencode.1p.html> und **uudecode(1p)** <https://www.man7.org/linux/man-pages/man1/uudecode.1p.html>. Bei dieser Kodierung werden Binärdaten in druckbare 7-Bit-ASCII-Zeichen gepackt.

# API

**::uuencode::encode** *bstring*
: Gibt als Ergebnis eine uuencode-kodierte Version der Binärzeichenkette *bstring* zurück.

    Alle übergebenen Bytes werden kodiert, auch wenn sie die maximale Zeilenlänge von uuencode überschreiten. Wenn die Anzahl der Eingabebytes kein Vielfaches von 3 ist, wird die Zeichenkette mit zusätzlichen **\\x00**-NUL-Bytes aufgefüllt.

    Der Befehl löst einen Fehler aus, wenn *bstring* weder eine Binärzeichenkette noch eine Zeichenkette ist, die ausschließlich aus 7-Bit-ASCII-Zeichen besteht.

**::uuencode::decode** *estring*
: Gibt eine Binärzeichenkette zurück, die aus dem *estring* mit uuencode-Decodierung entschlüsselt wurde, einschließlich etwaiger Padding-NUL-Bytes **\\x00** am Ende.

**::uuencode::uuencode** ?**-name** *string*? ?**-mode** *octal*? (**-file** *filename* |  ?**--**? *bstring*)
: Gibt als Ergebnis eine umgeschlossene, uuencodierte Version der Daten im durch **-file** *Dateinamen* oder durch die Binärzeichenfolge *bstring* festgelegten Dateinamen zurück.

    Jedes umgeschlossene, uuencodierte Ergebnis besteht aus einem Header, einem Hauptteil und einem Footer. Der Header ist eine Zeile, die mit **begin** beginnt, gefolgt von einem vorgeschlagenen Dateimodus und einem vorgeschlagenen Dateinamen. Der Hauptteil besteht aus Zeilen mit uuencodierten Daten, denen jeweils ein Zeichen für die Zeilenlänge vorangestellt ist. Der Footer ist **end** in einer eigenen Zeile. Siehe **uuencode(1)** <https://www.man7.org/linux/man-pages/man1/uuencode.1p.html>.

**::uuencode::uudecode** (**-file** *filename* |  ?**--**? *estring*)
: Gibt eine Liste aus Listen mit jeweils drei Elementen zurück, bestehend aus Dateiname, Dateimodus und uuencode-dekodierten Bytes, und zwar aus der durch **-file** angegebenen Datei *filename* oder aus dem *estring*.


## Optionen

**-file** *filename*
: Bewirkt, dass die Befehle **uuencode** oder **uudecode** ihre Daten aus der angegebenen Datei lesen, anstatt einen binären Zeichenfolgenparameter zu verwenden.

**-name** *string*
: Die uuencodierte Daten-Kopfzeile enthält den vorgeschlagenen Dateinamen, der beim Entpacken der Daten verwendet werden soll. Verwenden Sie diese Option, um den Standardwert „data.dat“ zu ändern.

**-mode** *octal*
: Die uuencodierte Datenkopfzeile enthält ein empfohlenes Bitmuster für die Zugriffsrechte, das als Oktalzahl ausgedrückt wird. Um die Standardeinstellung 0644 zu ändern, können Sie diese Option festlegen. Beispielsweise wäre 0755 für eine ausführbare Datei geeignet. Siehe **chmod(1)** <https://www.man7.org/linux/man-pages/man1/chmod.1.html>.


# Beispiele

In den Beispielen wird der Unterbefehl **string trimright** verwendet, um etwaige **\\x00**-NUL-Bytes zu entfernen, die möglicherweise während der Kodierung hinzugefügt wurden. *Hinweis: Wenn die ursprünglichen Binärzeichenfolgen möglicherweise mit* **\\x00**-NUL-Bytes *enden, ist ein ausgefeilterer Ansatz erforderlich.*

Dieses Beispiel zeigt, wie Sie eine Tcl-Zeichenkette mit „uuencode“ und „uudecode“ verarbeitet, wobei zu berücksichtigen ist, dass die „uuencode“-Befehle mit binären Zeichenketten arbeiten.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set encuu [::uuencode::encode $bytes]
set decuu [string trimright [::uuencode::decode $encuu] \x00]
set line [encoding convertfrom utf-8 $decuu]
puts "uuencode='$encuu' [expr {$UTF8_LINE eq $line}]"
=>
uuencode='SI3#MR#B@)Q5=&8M..*`G2#BF9[BA*0`' 1
```

Wenn die ursprüngliche Zeichenkette aus 7-Bit-ASCII-Zeichen besteht, sind die Konvertierungen in und aus Rohbytes mithilfe des integrierten Befehls **encoding** nicht erforderlich. Beispiel:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set encuu [::uuencode::encode $ASCII_LINE]
set decuu [string trimright [::uuencode::decode $encuu] \x00]
set line [encoding convertfrom utf-8 $decuu]
puts "uuencode='$encuu' [expr {$ASCII_LINE eq $line}]"
=>
uuencode='(2`W+6)I="!!4T-)22![?EY]' 1
```

Dieses Beispiel zeigt, wie Sie eine uuencodierte Byte-Zeichenkette erstellt und in eine Datei schreibt.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set encuu [::uuencode::uuencode -name test.uu $bytes]
writeFile test.uu binary $encuu
puts $encuu
=>
begin 644 test.uu
7SI3#MR#B@)Q5=&8M..*`G2#BF9[BA*0`
`
end
```

Dieses Beispiel zeigt, wie Sie eine Datei liest, die eine oder mehrere uuencodierte Dateien enthält.

```
foreach lst [::uuencode::uudecode -file test.uu] {
    lassign $lst name mode decuu
    set decuu [string trimright $decuu \x00]
    set line [encoding convertfrom utf-8 $decuu]
    puts "name=$name mode=$mode line='$line'"
}
=>
name=test.uu mode=644 line='Δ÷ “Utf-8” ♞ℤ'
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *base64* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
Copyright (c) 2002, Pat Thoyts
```
