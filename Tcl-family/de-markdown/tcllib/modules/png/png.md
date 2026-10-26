---
CommandName: png
ManualSection: n
Version: 0.4.1
TclPart: tcllib
TclDescription: Image manipulation
Keywords:
 - comment
 - image
 - png
 - timestamp
Copyright:
 - "Copyright (c) 2004, Code: Aaron Faupell <afaupell@users.sourceforge.net>"
 - "Copyright (c) 2004, Doc: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
---

# NAME

png – Abfrage und Bearbeitung von Metadaten bei PNG-Dateien

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [crc32]{.lit} 
[package]{.cmd} [require]{.sub} [png]{.lit} [0.4.1]{.optlit} 
[::png::validate]{.cmd} [file]{.arg} 
[::png::isPNG]{.cmd} [file]{.arg} 
[::png::imageInfo]{.cmd} [file]{.arg} 
[::png::getTimestamp]{.cmd} [file]{.arg} 
[::png::setTimestamp]{.cmd} [file]{.arg} [time]{.arg} 
[::png::getComments]{.cmd} [file]{.arg} 
[::png::removeComments]{.cmd} [file]{.arg} 
[::png::addComment]{.cmd} [file]{.arg} [keyword]{.arg} [text]{.arg} 
[::png::addComment]{.cmd} [file]{.arg} [keyword]{.arg} [lang]{.arg} [keyword2]{.arg} [text]{.arg} 
[::png::getPixelDimension]{.cmd} [file]{.arg} 
[::png::image]{.cmd} [file]{.arg} 
[::png::write]{.cmd} [file]{.arg} [data]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle zum Abfragen und Bearbeiten von PNG-Bildern. PNG steht für *Portable Network Graphics* und wird unter *http://www.libpng.org/pub/png/spec/1.2* festgelegt.

# BEFEHLE

**::png::validate** *file*
: Gibt einen Wert zurück, der angibt, ob *file* eine gültige PNG-Datei ist. Geprüft werden die PNG-Signatur, die Prüfsumme jedes Chunks, das Vorhandensein eines Daten-Chunks, der erste Chunk auf den Header und der letzte Chunk auf den Abschluss. *Nicht* geprüft werden: die Gültigkeit der Werte in einem Chunk, mehrere Header-Chunks, nicht zusammenhängende Daten-Chunks und ein End-Chunk vor dem tatsächlichen Dateiende. Diese Prozedur kann viel Zeit brauchen. Mögliche Rückgabewerte:


**OK**
: Die Datei ist eine gültige PNG-Datei.

**SIG**
: keine oder beschädigte PNG-Signatur.

**BADLEN**
: beschädigte Chunk-Länge.

**EOF**
: vorzeitiges Dateiende.

**NOHDR**
: fehlender Header-Chunk.

**CKSUM**
: CRC stimmt nicht überein.

**NODATA**
: fehlende Daten-Chunks.

**NOEND**
: fehlender Endmarker.


**::png::isPNG** *file*
: Gibt einen booleschen Wert zurück, der angibt, ob die Datei *file* mit einer PNG-Signatur beginnt. Diese Überprüfung ist wesentlich schneller und weniger ressourcenintensiv als **::png::validate**, da nicht geprüft wird, ob die PNG-Daten gültig sind.

**::png::imageInfo** *file*
: Gibt ein Dictionary mit den Schlüsseln **width**, **height**, **depth**, **color**, **compression**, **filter** und **interlace** zurück. Die Werte sind die zugehörigen Eigenschaften des PNG-Bildes in *file*. Löst einen Fehler aus, wenn *file* kein PNG-Bild ist oder die Prüfsumme des Headers ungültig ist. Zur Deutung der zurückgegebenen Eigenschaften siehe *http://www.libpng.org/pub/png/spec/1.2/PNG-Chunks.html*.

**::png::getTimestamp** *file*
: Gibt die Epochenzeit zurück, wenn in dem in *file* enthaltenen PNG-Bild ein Zeitstempel-Chunk gefunden wird; andernfalls gibt es eine leere Zeichenkette zurück. Die Prüfsumme des Zeitstempel-Chunks wird nicht überprüft. Es wird ein Fehler ausgelöst, wenn *file* kein gültiges PNG-Bild ist.

**::png::setTimestamp** *file* *time*
: Schreibt einen neuen Zeitstempel in *file*, entweder anstelle des bisherigen oder, wenn noch keiner da war, unmittelbar vor den Daten-Chunks. *time* ist die neue Zeit im GMT-Epochenformat. Löst einen Fehler aus, wenn *file* kein gültiges PNG-Bild ist.

**::png::getComments** *file*
: Derzeit werden nur unkomprimierte Kommentare unterstützt. Die Prüfsummen der Kommentar-Chunks werden nicht geprüft. Gibt eine Liste zurück, in der jedes Element ein Kommentar ist. Jeder Kommentar ist selbst eine Liste. Die Liste eines Klartextkommentars besteht aus zwei Elementen: dem für Menschen lesbaren Schlüsselwort und den Textdaten. Ein Unicode-Kommentar (international) besteht aus vier Elementen: dem für Menschen lesbaren Schlüsselwort, der Sprachkennung, dem übersetzten Schlüsselwort und den Unicode-Textdaten. Löst einen Fehler aus, wenn *file* kein gültiges PNG-Bild ist.

**::png::removeComments** *file*
: Entfernt alle Kommentare aus dem PNG-Bild in *file*. Vorsicht: Dafür wird Speicher in Höhe der Dateigröße abzüglich der Kommentare gebraucht, um das Zwischenergebnis zu halten. Löst einen Fehler aus, wenn *file* kein gültiges PNG-Bild ist.

**::png::addComment** *file* *keyword* *text*
: Fügt dem PNG-Bild in *file* unmittelbar vor dem ersten Daten-Chunk einen einfachen *text*-Kommentar hinzu. Löst einen Fehler aus, wenn kein Daten-Chunk gefunden wird. *keyword* muss kürzer als 80 Zeichen sein, damit es der PNG-Spezifikation entspricht.

**::png::addComment** *file* *keyword* *lang* *keyword2* *text*
: Fügt dem PNG-Bild in *file* unmittelbar vor dem ersten Daten-Chunk einen Unicode-Kommentar (international) hinzu. Löst einen Fehler aus, wenn kein Daten-Chunk gefunden wird. *keyword* muss kürzer als 80 Zeichen sein, damit es der PNG-Spezifikation entspricht. *keyword2* ist das übersetzte *keyword*, in der durch die Sprachkennung *lang* bestimmten Sprache.

**::png::getPixelDimension** *file*
: Gibt ein Dictionary mit den Schlüsseln **ppux**, **ppuy** und **unit** zurück, wenn die Angaben vorhanden sind. Andernfalls gibt es die leere Zeichenkette zurück. Die Werte von **ppux** und **ppuy** sind die Pixel pro Einheit in X- bzw. Y-Richtung. Zulässige Werte des Schlüssels **unit** sind **meter** und **unknown**. Im Fall **meter** ergibt sich der dpi-Wert durch Multiplikation mit dem Umrechnungsfaktor **0.0254**.

**::png::image** *file*
: Gibt zu einer PNG-Datei das Bild im Format einer Liste von Scanlines zurück, wie es Tk_GetColor verwendet.

**::png::write** *file* *data*
: Nimmt eine Liste von Scanlines im Format von Tk_GetColor entgegen und schreibt das repräsentierte Bild in *file*.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *png* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dateiformate

# COPYRIGHT

```
Copyright (c) 2004, Code: Aaron Faupell <afaupell@users.sourceforge.net>
Copyright (c) 2004, Doc:  Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
