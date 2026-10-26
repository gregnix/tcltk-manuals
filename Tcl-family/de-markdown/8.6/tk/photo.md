---
CommandName: photo
title: photo
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - image(n)
Keywords:
 - photo
 - image
 - color
Copyright:
 - Copyright (c) 1994 The Australian National University
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

photo - Vollfarbbilder

# Übersicht

::: {.synopsis} :::
[image]{.cmd} [create]{.sub} [photo]{.lit} [name]{.optarg} [options]{.optarg}

[imageName]{.ins} [blank]{.sub}
[imageName]{.ins} [cget]{.sub} [option]{.arg}
[imageName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
[imageName]{.ins} [copy]{.sub} [sourceImage]{.arg} [option value(s)]{.optdot}
[imageName]{.ins} [data]{.sub} [option value(s)]{.optdot}
[imageName]{.ins} [get]{.sub} [x]{.arg} [y]{.arg}
[imageName]{.ins} [put]{.sub} [data]{.arg} [option value(s)]{.optdot}
[imageName]{.ins} [read]{.sub} [filename]{.arg} [option value(s)]{.optdot}
[imageName]{.ins} [redither]{.sub}
[imageName]{.ins} [transparency]{.sub} [subcommand]{.arg} [arg arg]{.optdot}
[imageName]{.ins} [write]{.sub} [filename]{.arg} [option value(s)]{.optdot}
:::

# Beschreibung

Ein Photo ist ein Bild, dessen Pixel jede Farbe anzeigen oder transparent sein können. Ein Foto-Image wird intern in Vollfarbe (32 Bit pro Pixel) gespeichert und bei Bedarf mit Dithering angezeigt. Bilddaten für ein Foto-Image können aus einer Datei oder einer Zeichenkette stammen oder über eine prozedurale C-Schnittstelle geliefert werden. Derzeit werden nur [PNG,]{version="8.6"} GIF und PPM/PGM unterstützt; eine Schnittstelle erlaubt jedoch, weitere Bilddateiformate leicht hinzuzufügen. Ein Foto-Image ist in Bereichen transparent, in denen keine Bilddaten geliefert wurden oder die mit dem Unterbefehl **transparency set** transparent gesetzt wurden.

# Erstellung von Photos

Wie alle Images werden Photos mit [image create][image] erzeugt. Photos unterstützen folgende *Optionen*:

**-data** *string*
: Legt den Bildinhalt als Zeichenkette fest. Die Zeichenkette soll Binärdaten oder — für manche Formate — Base64-kodierte Daten enthalten (derzeit garantiert für PNG- und GIF-Bilder). Das Format der Zeichenkette muss eines der Formate sein, für die ein Bilddateiformat-Handler Stringdaten akzeptiert. Sind sowohl **-data** als auch **-file** angegeben, hat **-file** Vorrang.

**-format** *format-name*
: Gibt den Namen des Dateiformats für die mit **-data** oder **-file** angegebenen Daten an.

**-file** *name*
: *name* gibt den Namen einer Datei an, aus der Daten für das Foto-Image gelesen werden. Das Dateiformat muss eines der Formate sein, die ein Bilddateiformat-Handler lesen kann.

**-gamma** *value*
: Legt fest, dass die zur Anzeige dieses Bildes in einem Fenster zugewiesenen Farben für ein nichtlineares Display mit dem angegebenen Gamma-Exponenten korrigiert werden. (Die von den meisten CRT-Displays erzeugte Intensität ist näherungsweise eine Potenzfunktion des Eingabewerts; Gamma ist der Exponent und liegt typischerweise bei etwa 2.) Der angegebene Wert muss größer als null sein. Standard ist eins (keine Korrektur). Im Allgemeinen machen Werte größer als eins das Bild heller, Werte kleiner als eins dunkler.

**-height** *number*
: Legt die Bildhöhe in Pixeln fest. Die Option ist vor allem nützlich, wenn der Benutzer den Bildinhalt stückweise aufbauen möchte. Null (Standard) erlaubt vertikales Anpassen an die gespeicherten Daten.

**-palette** *palette-spec*
: Legt die Auflösung des zuzuweisenden Farbwürfels und damit die Anzahl der aus den Farbtabellen der Anzeigefenster genutzten Farben fest. *palette-spec* kann eine einzelne Dezimalzahl (Anzahl Graustufen) oder drei durch Schrägstriche (/) getrennte Dezimalzahlen (Anzahl Rot-, Grün- und Blautöne) sein. Bei der ersten Form wird das Bild monochrom (Graustufen) angezeigt.

**-width** *number*
: Legt die Bildbreite in Pixeln fest. Die Option ist vor allem nützlich, wenn der Benutzer den Bildinhalt stückweise aufbauen möchte. Null (Standard) erlaubt horizontales Anpassen an die gespeicherten Daten.


# Bild-Befehl

Beim Erzeugen eines Foto-Images legt Tk auch einen neuen Befehl an, dessen Name mit dem des Images übereinstimmt. Dieser Befehl kann verschiedene Operationen am Bild ausführen. Allgemeine Form:

```
imageName option ?arg arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.

Optionen, die Daten in das Bild schreiben, vergrößern das Bild bei Bedarf, um die geschriebenen Daten aufzunehmen — es sei denn, der Benutzer hat für die Konfigurationsoptionen **-width** und/oder **-height** von null abweichende Werte gesetzt; dann ändern sich Breite und/oder Höhe des Images nicht.

Folgende Befehle sind für Foto-Images möglich:

*imageName* **blank**
: Leert das Bild; das gesamte Image hat keine Daten, wird transparent angezeigt, und der Hintergrund des Anzeigefensters scheint durch.

*imageName* **cget** *option*
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann jeden von [image create][image] **photo** akzeptierten Wert haben.

*imageName* **configure** ?*option*? ?*value option value ...*?
: Fragt Konfigurationsoptionen ab oder ändert sie. Ohne *option* wird eine Liste aller verfügbaren Optionen für *imageName* zurückgegeben (Format siehe [Tk\_ConfigureInfo][ConfigWidg]). Mit *option* ohne *value* eine Liste nur für diese Option (identisch mit dem entsprechenden Teillisten-Eintrag der vollständigen Liste). Bei *option-value*-Paaren werden die Optionen gesetzt; Rückgabe ist ein leerer String. *Option* kann jeden von [image create][image] **photo** akzeptierten Wert haben.

*imageName* **copy** *sourceImage* ?*option value(s) ...*?
: Kopiert eine Region vom Image *sourceImage* (muss ein Foto-Image sein) nach *imageName*, optional mit Pixel-Zoom und/oder -Unterabtastung. Ohne Optionen wird ganz *sourceImage* ab (0,0) in *imageName* kopiert. Mögliche Optionen:

    **-from** *x1 y1 x2 y2*
    : Rechteckige Teilregion der Quelle. (*x1,y1*) und (*x2,y2*) sind diagonal gegenüberliegende Ecken. Fehlen *x2* und *y2*, ist die Standardeinstellung die untere rechte Ecke der Quelle. Kopierte Pixel umfassen linke und obere Kante des Rechtecks, nicht untere und rechte. Ohne **-from** wird die ganze Quelle verwendet.

    **-to** *x1 y1 x2 y2*
    : Rechteckige Teilregion des Ziel-Images. (*x1,y1*) und (*x2,y2*) sind diagonal gegenüberliegende Ecken. Fehlen *x2* und *y2*, Standard ist (*x1,y1*) plus Größe der Quellregion (nach Unterabtastung/Zoom). Sind *x2* und *y2* angegeben, wird die Quellregion bei Bedarf gekachelt, um die Zielregion zu füllen.

    **-shrink**
    : Verkleinert das Ziel-Image bei Bedarf, sodass die kopierte Region in der unteren rechten Ecke liegt. Die Option ändert Breite/Höhe nicht, wenn der Benutzer **-width** bzw. **-height** ungleich null gesetzt hat.

    **-zoom** *x y*
    : Vergrößert die Quellregion um Faktor *x* in X- und *y* in Y-Richtung. Fehlt *y*, entspricht es *x*. Jedes Quellpixel wird zu einem *x*×*y*-Block gleicher Farbe im Ziel. *x* und *y* müssen größer als 0 sein.

    **-subsample** *x y*
    : Verkleinert die Quelle, indem nur jedes *x*. Pixel in X und jedes *y*. Pixel in Y verwendet wird. Negative Werte spiegeln um die Y- bzw. X-Achse. Fehlt *y*, entspricht es *x*.

    **-compositingrule** *rule*
    : Legt fest, wie transparente Quellpixel mit dem Ziel kombiniert werden. Bei *overlay* bleibt alter Zielinhalt sichtbar, als läge die Quelle auf transparentem Film über dem Ziel. Bei *set* wird alter Zielinhalt verworfen und die Quelle unverändert übernommen. Standard ist *overlay*.


*imageName* **data** ?*option value(s) ...*?
: Gibt Bilddaten als Zeichenkette zurück. Mögliche Optionen:

    **-background** *color*
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    **-format** *format-name*
    : Name des Bilddateiformat-Handlers. Dieser Unterbefehl sucht den ersten Handler, dessen Name mit einem Anfangs-Substring von *format-name* übereinstimmt und der einen String mit diesen Bilddaten schreiben kann. Ohne Option wird ein Format verwendet: Liste (ein Element pro Zeile) von Listen (ein Element pro Pixel/Spalte) mit Farben im Format „**#***rrggbb*“ (*rr*, *gg*, *bb* je ein Hex-Paar für Rot, Grün, Blau).

    **-from** *x1 y1 x2 y2*
    : Rechteckige Region von *imageName*, die zurückgegeben wird. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke. Alle vier Koordinaten: diagonal gegenüberliegende Ecken, einschließlich x1,y1, ausschließlich x2,y2. Standard: ganzes Bild.

    **-grayscale**
    : Die Daten enthalten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.


*imageName* **get** *x y*
: Gibt die Farbe des Pixels bei (*x*,*y*) als Liste von drei Ganzzahlen 0–255 für Rot, Grün und Blau zurück.

*imageName* **put** *data* ?*option value(s) ...*?
: Setzt Pixel in *imageName* auf die in *data* angegebenen Daten. Der Befehl sucht einen Handler, der *data* interpretieren kann, und liest das kodierte Bild in *imageName*. Passt *data* zu keinem bekannten Format, wird versucht, es als (von oben nach unten) Liste von Scanlines zu lesen, jede Scanline eine (von links nach rechts) Liste von Pixelfarben (gültige Farben siehe [Tk\_GetColor][GetColor]). Jede Scanline muss gleiche Länge haben. Bei einem einzelnen Farbnamen wird eine rechteckige Region mit dieser Farbe gefüllt. Mögliche Optionen:

    **-format** *format-name*
    : Format der Bilddaten in *data*. Es werden nur Handler verwendet, deren Name mit *format-name* beginnt.

    **-to** *x1 y1* ?*x2 y2*?
    : Koordinaten der oberen linken Ecke (*x1*,*y1*) der Zielregion. Standard (0,0). Mit *x2*,*y2* und zu kleinen *data* wird gekachelt. Bei einem einzelnen Farbwert wird die Region bis (*x2*,*y2*) mit dieser Farbe gefüllt.


*imageName* **read** *filename* ?*option value(s) ...*?
: Liest Bilddaten aus der Datei *filename* ins Image. Zuerst wird ein passender Handler gesucht, dann wird das Bild in *imageName* gelesen. Mögliche Optionen:

    **-format** *format-name*
    : Format der Daten in *filename*. Nur Handler, deren Name mit *format-name* beginnt.

    **-from** *x1 y1 x2 y2*
    : Rechteckige Teilregion der Dateidaten für das Ziel. Nur *x1* und *y1*: von (*x1,y1*) bis zur unteren rechten Ecke in der Datei. Alle vier Koordinaten: diagonal gegenüberliegende Ecken der Region. Standard: ganzes Bild in der Datei.

    **-shrink**
    : Verkleinert *imageName* bei Bedarf, sodass die gelesene Region in der unteren rechten Ecke liegt. Breite/Höhe bleiben unverändert bei gesetztem **-width**/**-height** ungleich null.

    **-to** *x y*
    : Koordinaten der oberen linken Ecke der Zielregion. Standard (0,0).


*imageName* **redither**
: Das beim Anzeigen von Foto-Images verwendete Dithering propagiert Quantisierungsfehler zu Nachbarpixeln. Werden die Bilddaten für *imageName* stückweise geliefert, kann das geditherte Bild abweichen. Normalerweise fällt das nicht auf; bei Bedarf berechnet dieser Befehl das geditherte Bild in jedem Fenster neu, in dem das Image angezeigt wird.

*imageName* **transparency** *subcommand* ?*arg arg ...*?
: Ermöglicht Abfrage und Änderung der Transparenzinformationen im Foto-Image. Verfügbare Unterbefehle:

    *imageName* **transparency get** *x y*
    : Gibt einen booleschen Wert zurück, ob der Pixel bei (*x*,*y*) transparent ist.

    *imageName* **transparency set** *x y boolean*
    : Macht den Pixel bei (*x*,*y*) transparent, wenn *boolean* wahr ist, sonst opak.


*imageName* **write** *filename* ?*option value(s) ...*?
: Schreibt Bilddaten von *imageName* in die Datei *filename*. Folgende Optionen können angegeben werden:

    **-background** *color*
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    **-format** *format-name*
    : Legt den Namen des Bilddateiformat-Handlers fest, der die Daten in die Datei schreibt. Konkret sucht dieser Unterbefehl den ersten Handler, dessen Name mit einem Anfangs-Substring von *format-name* übereinstimmt und der Bilddateien schreiben kann. Ohne diese Option wird das Format aus der Dateiendung erraten; wenn das nicht möglich ist, wird der erste schreibfähige Handler verwendet.

    **-from** *x1 y1 x2 y2*
    : Rechteckige Region von *imageName*, die in die Bilddatei geschrieben wird. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke von *imageName*. Alle vier Koordinaten: diagonal gegenüberliegende Ecken. Standard: ganzes Bild.

    **-grayscale**
    : Die Daten enthalten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.



# Bildformate

Der Photo-Image-Code ist so strukturiert, dass Handler für weitere Bilddateiformate leicht ergänzt werden können. Der Photo-Image-Code verwaltet eine Liste dieser Handler. Handler werden der Liste durch Registrierung mit einem Aufruf von [Tk\_CreatePhotoImageFormat][CrtPhImgFmt] hinzugefügt. Die Standard-Tk-Distribution enthält Handler für PPM/PGM, PNG und GIF; sie werden bei der Initialisierung automatisch registriert.

Beim Lesen einer Bilddatei oder Verarbeiten von Stringdaten, die mit der Konfigurationsoption **-data** angegeben wurden, ruft der Photo-Image-Code Handler nacheinander auf, bis einer die Daten in der Datei oder Zeichenkette lesen kann. Meist findet das den richtigen Handler; andernfalls kann der Benutzer mit **-format** einen Formatnamen vorgeben. Tatsächlich werden Handler versucht, deren Name mit dem für **-format** angegebenen String beginnt (Groß-/Kleinschreibung irrelevant). Bei **-format gif** können z. B. Handler namens GIF87 oder GIF89 aufgerufen werden, JPEG nicht (sofern registriert).

Beim Schreiben von Bilddaten in eine Datei ist die Verarbeitung von **-format** etwas anders: Der Stringwert für **-format** muss mit dem vollständigen Namen des gewünschten Handlers beginnen und kann weitere Informationen enthalten, die der Handler nutzen kann, z. B. um eine Variante der vom Handler unterstützten Formate zu wählen. Nicht alle Bildhandler unterstützen das Schreiben von Transparenzdaten in eine Datei, auch wenn das Zielformat es theoretisch erlaubt.

## Format-Unteroptionen

[Manche Bildformate unterstützen Unteroptionen, die beim Laden über zusätzliche Wörter in **-format** angegeben werden. Derzeit unterstützt:]{version="8.6"}

[**gif -index** *indexValue*]{version="8.6"}
: [Beim Parsen eines mehrteiligen GIF-Images greift Tk normalerweise nur auf das erste Bild zu. Mit der Unteroption **-index** kann stattdessen das *indexValue*. Bild verwendet werden. *indexValue* muss eine Ganzzahl von 0 bis zur Anzahl der Bildteile in den GIF-Daten sein.]{version="8.6"}

[**png -alpha** *alphaValue*]{version="8.6"}
: [Zusätzlicher Alpha-Filter für das Gesamtbild, sodass der Hintergrund der Anzeige durchscheint; oft auch Entsättigung. *alphaValue* muss zwischen 0,0 und 1,0 liegen.]{version="8.6"}


# Farbzuweisung

Wird ein Foto-Image in einem Fenster angezeigt, weist der Photo-Image-Code Farben zu und dithert das Bild bei Bedarf, um eine brauchbare Annäherung mit den verfügbaren Farben darzustellen. Die Farben werden als Farbwürfel zugewiesen: die Anzahl der zugewiesenen Farben ist das Produkt der Anzahl der Rot-, Grün- und Blautöne.

Normalerweise richtet sich die Anzahl der zugewiesenen Farben nach der Tiefe des Fensters. In einem 8-Bit-PseudoColor-Fenster versucht der Photo-Image-Code z. B., sieben Rottöne, sieben Grüntöne und vier Blautöne zuzuweisen (insgesamt 198 Farben). In einem 1-Bit-StaticGray-Fenster (Monochrom) werden zwei Farben, Schwarz und Weiß, zugewiesen. In einem 24-Bit-DirectColor- oder TrueColor-Fenster werden 256 Stufen je für Rot, Grün und Blau zugewiesen. Dank der Art, wie Pixelwerte in DirectColor- und TrueColor-Fenstern kombiniert werden können, reichen dafür 256 zugewiesene Farben. Können nicht alle Farben zugewiesen werden, reduziert der Photo-Image-Code die Anzahl der Stufen pro Grundfarbe und versucht es erneut.

Der Benutzer kann mit der Konfigurationsoption **-palette** steuern, wie viele Farben ein Foto-Image nutzt. Mit dieser Option wird die maximale Anzahl der Stufen pro Grundfarbe festgelegt, die zugewiesen werden sollen. Sie kann auch erzwingen, dass das Bild in Graustufen angezeigt wird, auch auf einem Farbdisplay, indem eine einzelne Zahl statt drei durch Schrägstriche getrennte Zahlen angegeben wird.

# Danksagungen

Der Photo-Image-Typ wurde von Paul Mackerras entworfen und implementiert, auf Basis seines früheren Photo-Widgets und einiger Vorschläge von John Ousterhout.

# Beispiel

Bild aus einer Datei laden und auf Fenstergröße kacheln — nützlich für einen gekachelten Hintergrund:

```
# Diese Zeilen sollten einmal aufgerufen werden
image create photo untiled -file "theFile.ppm"
image create photo tiled

# Diese Zeilen sollten aufgerufen werden, wenn sich .someWidget in der Größe ändert;
# eine <Configure>-Bindung ist hier hilfreich
set width  [winfo width .someWidget]
set height [winfo height .someWidget]
tiled copy untiled -to 0 0 $width $height -shrink
```

[Der PNG-Bildlader erlaubt die Anwendung eines zusätzlichen Alpha-Faktors beim Laden — nützlich für Bilder deaktivierter Buttons:]{version="8.6"}

```
image create photo icon -file "icon.png"
image create photo iconDisabled -file "icon.png" \
        -format "png -alpha 0.5"
button .b -image icon -disabledimage iconDisabled
```


[ConfigWidg]: ../tk-c/ConfigWidg.md
[CrtPhImgFmt]: ../tk-c/CrtPhImgFmt.md
[GetColor]: ../tk-c/GetColor.md
[image]: image.md
