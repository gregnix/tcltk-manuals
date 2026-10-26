---
CommandName: yencode
ManualSection: n
Version: 1.1.4
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - encoding
 - yEnc
 - ydecode
 - yencode
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# NAME

yencode – Binäre Daten im Y-Format kodieren/dekodieren

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [yencode]{.lit} [1.1.4]{.optlit} 
[::yencode::encode]{.cmd} [bstring]{.arg} 
[::yencode::decode]{.cmd} [estring]{.arg} 
[::yencode::yencode]{.cmd} [-name string]{.optarg} [-line integer]{.optarg} [-crc32 boolean]{.optarg} (-file [filename]{.arg} | [--]{.optlit} [bstring)]{.arg} 
[::yencode::ydecode]{.cmd} (-file [filename]{.arg} | [--]{.optlit} [estring)]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine rein auf Tcl basierende Implementierung der yEncode-Dateikodierung, die für Usenet-Nachrichten verwendet wird. Diese Kodierung packt Binärdaten in ein Format, das eine 8-Bit-kompatible Übertragungsschicht erfordert, dabei jedoch Sonderzeichen der *NNTP*-Posting-Protokolle escapt. Einzelheiten zur Kodierung finden Sie unter *http://www.yenc.org*.

# API

**::yencode::encode** *bstring*
: Gibt als Ergebnis eine yEncoded-Version der Binärzeichenfolge *bstring* zurück. Der Befehl löst einen Fehler aus, wenn *bstring* weder eine Binärzeichenfolge noch eine Zeichenfolge ist, die ausschließlich aus 7-Bit-ASCII-Zeichen besteht.

**::yencode::decode** *estring*
: Gibt eine Binärzeichenfolge zurück, die aus dem *estring* mittels yEncode-Dekodierung dekodiert wurde.

**::yencode::yencode** ?**-name** *string*? ?**-line** *integer*? ?**-crc32** *boolean*? (**-file** *filename* | ?**--**? *bstring*)
: Gibt als Ergebnis eine „wrapped“ yEncoded-Version der Daten im durch **-file** *Dateinamen* oder durch die Binärzeichenfolge *bstring* festgelegten Dateinamen zurück. Jedes „wrapped“ yEncoded-Ergebnis besteht aus einem Header, einem Body und einem Trailer. Der Header ist eine Zeile, die mit **=ybegin** beginnt, gefolgt von einer Zeilenlänge in der Form **line=**_length_, der Größe der Originaldaten (in Byte) in der Form **size=**_size_ sowie dem Name der Originaldatei in der Form **name=**_filename_, alles durch Leerzeichen getrennt. Der Hauptteil besteht aus den yEncoded-Daten. Der Trailer ist eine Zeile, die mit **=yend** beginnt, gefolgt von der Größe der Originaldaten in der Form **size=**_size_ und optional (aber empfohlen) einem CRC32-Prüfsummenwert in der Form **crc32=**_checksum_, alles durch Leerzeichen getrennt.

**::yencode::ydecode** (**-file** *filename* | ?**--**? *estring*)
: Gibt eine Liste aus Listen mit jeweils drei Elementen zurück, bestehend aus Dateiname, Dateigröße und yEncode-dekodierten Bytes, entweder aus der durch **-file** angegebenen Datei *filename* oder aus dem *estring*.


## Optionen

**-file** *filename*
: Bewirkt, dass die Befehle **yencode** oder **ydecode** ihre Daten aus der angegebenen Datei lesen, anstatt einen binären Zeichenfolgenparameter zu verwenden.

**-name** *string*
: Die yEncoded-Daten-Kopfzeile enthält den ursprünglichen Dateinamen, der beim Entpacken der Daten verwendet werden soll. Verwenden Sie diese Option, um den Standardwert „default.bin“ zu ändern.

**-line** *integer*
: Die yEncoded-Kopfzeile legt die für die Kodierung verwendete Zeilenlänge fest, deren Standardwert 128 beträgt. Verwenden Sie diese Option, um eine andere Zeilenlänge festzulegen. Hinweis: NNTP legt eine Begrenzung der Zeilenlänge auf 1000 Zeichen fest und einige Systeme haben bei mehr als 255 Zeichen pro Zeile Probleme.

**-crc32** *boolean*
: Wenn die Kodierung dieses Pakets durchgeführt wird, fügt es gemäß der yEncode-Spezifikation einen CRC-Wert (Cyclic Redundancy Check) in den Trailer ein. Dies lässt sich verhindern, indem Sie diese Option verwendet und für *boolean* einen falschen Wert übergibt, z. B. **0**.


# BEISPIELE

*Die yEncode-Daten werden in den Beispielen nicht gezeigt, weil es nur Rohbytes sind.*

Dieses Beispiel zeigt, wie Sie eine Tcl-Zeichenkette mit „yEncode“ kodiert und wieder dekodiert, wobei zu berücksichtigen ist, dass die „yEncode“-Befehle mit binären Zeichenketten arbeiten.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set ency [::yencode::encode $bytes]
set decy [::yencode::decode $ency]
set line [encoding convertfrom utf-8 $decy]
puts "[expr {$UTF8_LINE eq $line}]"
=>
1
```

Wenn die ursprüngliche Zeichenkette aus 7-Bit-ASCII-Zeichen besteht, sind die Konvertierungen in und aus Rohbytes mithilfe des integrierten Befehls **encoding** nicht erforderlich. Beispiel:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set ency [::yencode::encode $ASCII_LINE]
set decy [::yencode::decode $ency]
set line [encoding convertfrom utf-8 $decy]
puts "[expr {$ASCII_LINE eq $line}]"
=>
1
```

Dieses Beispiel zeigt, wie Sie eine yEncoded-Byte-Zeichenkette erstellt und in eine Datei schreibt.

```
set bytes [encoding convertto utf-8 $UTF8_LINE]
set ency [::yencode::yencode -name test.y $bytes]
writeFile test.y binary $ency
puts $ency
=>
=ybegin line=128 size=23 name=test.y
    … raw binary data elided …
=yend size=23 crc32=fc01071
```

Dieses Beispiel zeigt, wie Sie eine Datei liest, die eine oder mehrere yEncoded-Dateien enthält.

```
foreach lst [::yencode::ydecode $ency] {
    lassign $lst name size decy
    set line [encoding convertfrom utf-8 $decy]
    puts "name=$name size=$size line='$line'"
}
=>
name=test.y size=23 line='Δ÷ “Utf-8” ♞ℤ'
```

# LITERATUR

**\[1\]**
: *http://www.yenc.org/yenc-draft.1.3.txt*


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *base64* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung

# COPYRIGHT

```
Copyright (c) 2002, Pat Thoyts
```
