---
CommandName: tiff
ManualSection: n
Version: 0.2.3
TclPart: tcllib
TclDescription: TIFF image manipulation
Keywords:
 - image
 - tif
 - tiff
Copyright:
 - Copyright (c) 2005-2006, Aaron Faupell <afaupell@users.sourceforge.net>
---

# NAME

tiff – Lesen und Schreiben von TIFF-Dateien sowie Abfragen und Bearbeitung von Metadaten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tiff]{.lit} [0.2.3]{.optlit} 
[::tiff::isTIFF]{.cmd} [file]{.arg} 
[::tiff::byteOrder]{.cmd} [file]{.arg} 
[::tiff::numImages]{.cmd} [file]{.arg} 
[::tiff::dimensions]{.cmd} [file]{.arg} [image]{.optarg} 
[::tiff::imageInfo]{.cmd} [file]{.arg} [image]{.optarg} 
[::tiff::entries]{.cmd} [file]{.arg} [image]{.optarg} 
[::tiff::getEntry]{.cmd} [file]{.arg} [entry]{.arg} [image]{.optarg} 
[::tiff::addEntry]{.cmd} [file]{.arg} [entry]{.arg} [image]{.optarg} 
[::tiff::deleteEntry]{.cmd} [file]{.arg} [entry]{.arg} [image]{.optarg} 
[::tiff::getImage]{.cmd} [file]{.arg} [image]{.optarg} 
[::tiff::writeImage]{.cmd} [image]{.arg} [file]{.arg} [entry]{.optarg} 
[::tiff::nametotag]{.cmd} [names]{.arg} 
[::tiff::tagtoname]{.cmd} [tags]{.arg} 
[::tiff::debug]{.cmd} [file]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle zum Abfragen, Ändern, Lesen und Schreiben von TIFF-Bildern. TIFF steht für *Tagged Image File Format* und ist ein Standard für die verlustfreie Speicherung von fotografischen Bildern und zugehörigen Metadaten. Die Spezifikation finden Sie unter *http://partners.adobe.com/public/developer/tiff/index.html*.

In einer einzelnen TIFF-Datei können mehrere Bilder gespeichert sein. Die Argumente ?*image*? der Funktionen in diesem Paket dienen dem Zugriff auf andere Bilder als das erste. Die Daten in einem TIFF-Bild werden als eine Reihe von Tags mit numerischem Wert gespeichert, dargestellt entweder im vierstelligen Hexadezimalformat oder als Zeichenkettenname. Eine Übersicht definierter Tags und ihrer Bedeutung steht unter *http://www.awaresystems.be/imaging/tiff/tifftags.html*

# BEFEHLE

**::tiff::isTIFF** *file*
: Gibt einen booleschen Wert zurück, der angibt, ob *file* ein TIFF-Bild ist.

**::tiff::byteOrder** *file*
: Gibt entweder **big** oder **little** zurück. Löst einen Fehler aus, wenn *file* kein TIFF-Bild ist.

**::tiff::numImages** *file*
: Gibt die Anzahl der Bilder in *file* zurück. Löst einen Fehler aus, wenn *file* kein TIFF-Bild ist.

**::tiff::dimensions** *file* ?*image*?
: Gibt die Abmessungen des Bildes mit der Nummer ?*image*? in *file* als Liste der horizontalen und vertikalen Pixelanzahl zurück. Löst einen Fehler aus, wenn *file* kein TIFF-Bild ist.

**::tiff::imageInfo** *file* ?*image*?
: Gibt ein Dictionary mit den Schlüsseln **ImageWidth**, **ImageLength**, **BitsPerSample**, **Compression**, **PhotometricInterpretation**, **ImageDescription**, **Orientation**, **XResolution**, **YResolution**, **ResolutionUnit**, **DateTime**, **Artist** und **HostComputer** zurück. Die Werte sind die zugehörigen Eigenschaften des TIFF-Bildes ?*image*? in *file*. Die Werte können leer sein, wenn das zugehörige Tag in der Datei fehlt.


```
    puts [::tiff::imageInfo photo.tif]

    ImageWidth 686 ImageLength 1024 BitsPerSample {8 8 8} Compression 1
    PhotometricInterpretation 2 ImageDescription {} Orientation 1
    XResolution 170.667 YResolution 170.667 ResolutionUnit 2 DateTime {2005:12:28 19:44:45}
    Artist {} HostComputer {}
```

: An diesen Tags ist nichts Besonderes. Die Prozedur ruft lediglich **getEntry** mit gängigen Einträgen auf. Löst einen Fehler aus, wenn *file* kein TIFF-Bild ist.


**::tiff::entries** *file* ?*image*?
: Gibt eine Liste aller Einträge in *file* und ?*image*? im Hexadezimalformat zurück. Löst einen Fehler aus, wenn *file* kein TIFF-Bild ist.

**::tiff::getEntry** *file* *entry* ?*image*?
: Gibt den Wert von *entry* aus dem Bild ?*image*? in der TIFF-Datei *file* zurück. *entry* kann eine Liste mehrerer Einträge sein. Fehlt ein Eintrag, wird eine leere Zeichenkette zurückgegeben.


```
    set data [::tiff::getEntry photo.tif {0131 0132}]
    puts "file was written at [lindex $data 0] with software [lindex $data 1]"
```

: Es wird ein Fehler ausgelöst, wenn *file* kein TIFF-Bild ist.


**::tiff::addEntry** *file* *entry* ?*image*?
: Fügt die angegebenen Einträge dem durch ?*image*? benannten Bild hinzu (Vorgabe 0) oder optional **all**. *entry* muss eine Liste sein, deren Elemente jeweils eine Liste aus Tag, Typ und Wert sind. Ist ein Tag schon vorhanden, wird es überschrieben.


```
    ::tiff::addEntry photo.tif {{010e 2 "an example photo"} {013b 2 "Aaron F"}}
```

: Die Datentypen sind wie folgt definiert.


**1**
: BYTE (8-Bit-Ganzzahl ohne Vorzeichen)

**2**
: ASCII

**3**
: SHORT (16-Bit-Ganzzahl ohne Vorzeichen)

**4**
: LONG (32-Bit-Ganzzahl ohne Vorzeichen)

**5**
: RATIONAL

**6**
: SBYTE (vorzeichenbehaftetes 8-Bit-Byte)

**7**
: UNDEFINED (nicht interpretierte Binärdaten)

**8**
: SSHORT (vorzeichenbehaftete 16-Bit-Ganzzahl)

**9**
: SLONG (vorzeichenbehaftete 32-Bit-Ganzzahl)

**10**
: SRATIONAL

**11**
: FLOAT (32-Bit-Gleitkommazahl)

**12**
: DOUBLE (64-Bit-Gleitkommazahl)


: Es wird ein Fehler ausgelöst, wenn *file* kein TIFF-Bild ist.


**::tiff::deleteEntry** *file* *entry* ?*image*?
: Löscht die angegebenen Einträge aus dem durch ?*image*? benannten Bild (Vorgabe 0) oder optional aus **all**. Löst einen Fehler aus, wenn *file* kein TIFF-Bild ist.

**::tiff::getImage** *file* ?*image*?
: Gibt den Namen eines Tk-Bildes zurück, das das Bild am Index ?*image*? aus *file* enthält. Löst einen Fehler aus, wenn *file* kein TIFF-Bild ist oder das Bild ein nicht unterstütztes Format hat. Unterstützt werden unkomprimiertes 24-Bit-RGB und unkomprimierte 8-Bit-Palette.

**::tiff::writeImage** *image* *file* ?*entry*?
: Schreibt den Inhalt des Tk-Bildes *image* in eine TIFF-Datei *file*. Die Dateien werden unkomprimiert mit 24 Bit und Big-Endian-Byte-Reihenfolge geschrieben. Zusätzliche Einträge für das Bild können angegeben werden, im selben Format wie bei **tiff::addEntry**.

**::tiff::nametotag** *names*
: Gibt eine Liste zurück, in der *names* von der Zeichenkette ins vierstellige Format übersetzt sind. Vierstellige Namen in der Eingabe werden unverändert durchgereicht. Zeichenketten ohne definierten Tag-Namen lösen einen Fehler aus.

**::tiff::tagtoname** *tags*
: Gibt eine Liste zurück, in der *tags* vom vierstelligen Format in Zeichenketten übersetzt sind. Hat ein Tag keinen definierten Namen, wird es unverändert durchgereicht.

**::tiff::debug** *file*
: Gibt alle uns bekannten Informationen zur angegebenen Datei in einem übersichtlichen Format aus.


# VARIABLEN

Für die Zuordnung von vierstelligen Tag-Namen zu Zeichenfolgen-Namen wird das Array ::tiff::tiff_tags verwendet. Für die umgekehrte Zuordnung wird das Array ::tiff::tiff_sgat verwendet.

# EINSCHRÄNKUNGEN

**\[1\]**
: EXIF-IFD kann nicht geschrieben werden

**\[2\]**
: Lesen ist auf unkomprimiertes 8-Bit-RGB und unkomprimierte 8-Bit-Palettenbilder beschränkt

**\[3\]**
: Schreiben ist auf unkomprimiertes 8-Bit-RGB beschränkt


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *tiff* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dateiformate

# COPYRIGHT

```
Copyright (c) 2005-2006, Aaron Faupell <afaupell@users.sourceforge.net>
```
