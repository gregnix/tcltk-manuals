---
CommandName: jpeg
ManualSection: n
Version: 0.7
TclPart: tcllib
TclDescription: JPEG image manipulation
Keywords:
 - comment
 - exif
 - image
 - jfif
 - jpeg
 - thumbnail
Copyright:
 - "Copyright (c) 2004-2005, Code: Aaron Faupell <afaupell@users.sourceforge.net>"
 - "Copyright (c) 2007, Code: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
 - "Copyright (c) 2004-2009, Doc: Andreas Kupries <andreas_kupries@users.sourceforge.net>"
 - "Copyright (c) 2011, Code: Pat Thoyts <patthoyts@users.sourceforge.net>"
---

# NAME

jpeg – Abfrage und Bearbeitung von Metadaten bei JPEG-Dateien

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [jpeg]{.lit} [0.7]{.optlit} 
[::jpeg::isJPEG]{.cmd} [file]{.arg} 
[::jpeg::imageInfo]{.cmd} [file]{.arg} 
[::jpeg::dimensions]{.cmd} [file]{.arg} 
[::jpeg::getThumbnail]{.cmd} [file]{.arg} 
[::jpeg::getExif]{.cmd} [file]{.arg} [section]{.optarg} 
[::jpeg::getExifFromChannel]{.cmd} [channel]{.arg} [section]{.optarg} 
[::jpeg::formatExif]{.cmd} [keys]{.arg} 
[::jpeg::exifKeys]{.cmd} 
[::jpeg::removeExif]{.cmd} [file]{.arg} 
[::jpeg::stripJPEG]{.cmd} [file]{.arg} 
[::jpeg::getComments]{.cmd} [file]{.arg} 
[::jpeg::addComment]{.cmd} [file]{.arg} [text...]{.arg} 
[::jpeg::removeComments]{.cmd} [file]{.arg} 
[::jpeg::replaceComment]{.cmd} [file]{.arg} [text]{.arg} 
[::jpeg::debug]{.cmd} [file]{.arg} 
[::jpeg::markers]{.cmd} [channel]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle zum Abfragen und Bearbeiten von JPEG-Bildern. JPEG steht für *Joint Photography Experts Group* und ist ein Standard für die verlustbehaftete Komprimierung fotografischer Bilder. Die Spezifikation finden Sie unter *LINK_HERE*.

# BEFEHLE

**::jpeg::isJPEG** *file*
: Gibt einen booleschen Wert zurück, der angibt, ob *file* ein JPEG-Bild ist.

**::jpeg::imageInfo** *file*
: Gibt ein Dictionary mit den Schlüsseln **version**, **units**, **xdensity**, **ydensity**, **xthumb** und **ythumb** zurück. Die Werte sind die zugehörigen Eigenschaften des JPEG-Bildes in *file*. Löst einen Fehler aus, wenn *file* kein JPEG-Bild ist.

**::jpeg::dimensions** *file*
: Gibt die Abmessungen der JPEG-Datei *file* als Liste der horizontalen und vertikalen Pixelanzahl zurück. Löst einen Fehler aus, wenn *file* kein JPEG-Bild ist.

**::jpeg::getThumbnail** *file*
: Diese Prozedur gibt die binären Daten des Vorschaubildes zurück, wenn in *file* ein JPEG-Vorschaubild enthalten ist, andernfalls die leere Zeichenkette. Hinweis: Vorschaubilder können auch in anderen Formaten als JPEG eingebettet sein, auch wenn das unüblich ist. Der Befehl findet Vorschaubilder, die im JFXX- oder im EXIF-Segment der JPEG-Daten kodiert sind. Sind beide vorhanden, hat das EXIF-Vorschaubild Vorrang. Löst einen Fehler aus, wenn *file* kein JPEG-Bild ist.


```
    set fh [open thumbnail.jpg w+]
    fconfigure $fh -translation binary -encoding binary
    puts -nonewline $fh [::jpeg::getThumbnail photo.jpg]
    close $fh
```

**::jpeg::getExif** *file* ?*section*?
: *section* muss entweder **main** oder **thumbnail** lauten. Der Standardwert ist **main**. Gibt ein Dictionary zurück, das die EXIF-Informationen für den angegebenen Abschnitt enthält. Beispiel:


```
    set exif {
	Make     Canon
	Model    {Canon DIGITAL IXUS}
	DateTime {2001:06:09 15:17:32}
    }
```

: Es wird ein Fehler ausgelöst, wenn *file* kein JPEG-Bild ist.


**::jpeg::getExifFromChannel** *channel* ?*section*?
: Dieser Befehl entspricht **::jpeg::getExif**, verwendet aber einen bereits geöffneten Kanal. *channel* sollte ein positionierbarer Kanal sein (seek), und *section* ist wie bei **::jpeg::getExif** beschrieben. *Hinweis*: Der JPEG-Parser erwartet, dass der Anfang des Kanals der Anfang der Bilddaten ist. Liegt das Bild in einem Container-Dateiformat, kann es nötig sein, die JPEG-Daten in einen temporären Container zu lesen: eine temporäre Datei oder einen Speicherkanal. *Achtung*: Den Kanal nach der Verwendung zu schließen, ist Sache des Aufrufenden.

**::jpeg::formatExif** *keys*
: Nimmt eine Liste von Schlüssel-Wert-Paaren entgegen, wie **getExif** sie zurückgibt, und bringt viele der Werte in eine besser lesbare Form. Es reicht ein einziges Schlüssel-Wert-Paar; die gesamten EXIF-Daten sind nicht nötig.


```
    foreach {key val} [::jpeg::formatExif [::jpeg::getExif photo.jpg]] {
        puts "$key: $val"
    }
```

```
    array set exif [::jpeg::getExif photo.jpg]
    puts "max f-stop: [::jpeg::formatExif [list MaxAperture $exif(MaxAperture)]]
```

**::jpeg::exifKeys**
: Gibt eine Liste der EXIF-Schlüssel zurück, die derzeit verstanden werden. In den Daten von **getExif** können Schlüssel vorkommen, die nicht verstanden werden. Diese erscheinen im vierstelligen Hexadezimalformat.

**::jpeg::removeExif** *file*
: Entfernt das Exif-Datensegment aus der angegebenen Datei und ersetzt es durch ein Standard-JFIF-Segment. Es wird ein Fehler ausgelöst, wenn *file* kein JPEG-Bild ist.

**::jpeg::stripJPEG** *file*
: Entfernt alle Metadaten aus der JPEG-Datei, sodass nur das Bild übrig bleibt. Dazu gehören Kommentare, EXIF-Segmente, JFXX-Segmente und anwendungsspezifische Segmente. Es wird ein Fehler ausgelöst, wenn *file* kein JPEG-Bild ist.

**::jpeg::getComments** *file*
: Gibt eine Liste aller JPEG-Kommentare in *file* zurück. Löst einen Fehler aus, wenn *file* kein gültiges JPEG-Bild ist.

**::jpeg::addComment** *file* *text*...
: Fügt dem JPEG-Bild in *file* einen oder mehrere einfache *text*-Kommentare hinzu. Löst einen Fehler aus, wenn *file* kein gültiges JPEG-Bild ist.

**::jpeg::removeComments** *file*
: Entfernt alle Kommentare aus der angegebenen Datei. Es wird ein Fehler ausgelöst, wenn *file* kein gültiges JPEG-Bild ist.

**::jpeg::replaceComment** *file* *text*
: Ersetzt den ersten Kommentar in der Datei durch den neuen *text*. Das ist nur eine Kurzform für **::jpeg::removeComments** und **::jpeg::addComment**. Löst einen Fehler aus, wenn *file* kein gültiges JPEG-Bild ist.

**::jpeg::debug** *file*
: Gibt alle uns bekannten Informationen zur angegebenen Datei in einem übersichtlichen Format aus.

**::jpeg::markers** *channel*
: Dies ist ein interner Hilfsbefehl, dokumentiert für fortgeschrittene Nutzer des Pakets. Das Argument *channel* ist ein geöffnetes Dateihandle am Anfang des ersten Markers (üblicherweise 2 Byte). Der Befehl gibt eine Liste mit einem Element je JFIF-Marker in der Datei zurück. Jedes Element ist eine Liste aus dem Namen des Markers, seinem Offset in der Datei und seiner Länge. Der Offset zeigt auf den Anfang der Daten des Abschnitts, nicht auf den Marker selbst. Die Länge ist die Länge der Daten vom angegebenen Offset bis zum Anfang des nächsten Markers.


# EINSCHRÄNKUNGEN

Kann nur mit Dateien arbeiten; EXIF-Daten lassen sich nicht schreiben; GPS-EXIF-Daten werden nicht geparst; Makernote-Daten sind noch nicht implementiert

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *jpeg* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dateiformate

# COPYRIGHT

```
Copyright (c) 2004-2005, Code: Aaron Faupell <afaupell@users.sourceforge.net>
Copyright (c) 2007, Code:  Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2004-2009, Doc:  Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2011, Code: Pat Thoyts <patthoyts@users.sourceforge.net>
```
