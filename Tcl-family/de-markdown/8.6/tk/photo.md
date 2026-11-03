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

Ein Photo ist ein Bild, dessen Pixel jede Farbe anzeigen oder transparent sein können. Ein Foto-Image wird intern in Vollfarbe (32 Bit pro Pixel) gespeichert und bei Bedarf mit Dithering angezeigt. Bilddaten für ein Foto-Image können aus einer Datei oder einer Zeichenkette stammen oder über eine prozedurale Schnittstelle aus C-Code geliefert werden. Derzeit werden nur die Formate [PNG,]{version="8.6"} GIF und PPM/PGM unterstützt; es gibt jedoch eine Schnittstelle, über die sich weitere Bilddateiformate leicht hinzufügen lassen. Ein Foto-Image ist in Bereichen transparent, für die keine Bilddaten geliefert wurden oder die mit dem Unterbefehl **transparency set** transparent gesetzt wurden.

# Erstellung von Photos

Wie alle Images werden Photos mit [image create][image] erzeugt. Photos unterstützen folgende *Optionen*:

**-data** *string*
: Legt den Inhalt des Bildes als Zeichenkette fest. Die Zeichenkette sollte Binärdaten oder, bei manchen Formaten, Base64-kodierte Daten enthalten (für PNG- und GIF-Bilder ist das derzeit garantiert). Das Format der Zeichenkette muss eines der Formate sein, für die es einen Bilddateiformat-Handler gibt, der Zeichenkettendaten akzeptiert. Sind sowohl die Option **-data** als auch die Option **-file** angegeben, hat **-file** Vorrang.

**-format** *format-name*
: Legt den Namen des Dateiformats für die Daten fest, die mit der Option **-data** oder **-file** angegeben werden.

**-file** *name*
: *name* gibt den Namen einer Datei an, aus der Daten für das Foto-Image gelesen werden. Das Dateiformat muss eines der Formate sein, die ein Bilddateiformat-Handler lesen kann.

**-gamma** *value*
: Legt fest, dass die zur Anzeige dieses Bildes in einem Fenster zugewiesenen Farben für ein nichtlineares Display mit dem angegebenen Gamma-Exponenten korrigiert werden. (Die von den meisten CRT-Displays erzeugte Intensität ist näherungsweise eine Potenzfunktion des Eingabewerts; Gamma ist der Exponent und liegt typischerweise bei etwa 2.) Der angegebene Wert muss größer als null sein. Standard ist eins (keine Korrektur). Im Allgemeinen machen Werte größer als eins das Bild heller, Werte kleiner als eins dunkler.

**-height** *number*
: Legt die Bildhöhe in Pixeln fest. Die Option ist vor allem nützlich, wenn der Benutzer den Bildinhalt stückweise aufbauen möchte. Null (Standard) erlaubt vertikales Anpassen an die gespeicherten Daten.

**-palette** *palette-spec*
: Legt die Auflösung des zuzuweisenden Farbwürfels und damit die Anzahl der aus den Farbkarten der Anzeigefenster genutzten Farben fest. *palette-spec* kann eine einzelne Dezimalzahl (Anzahl Graustufen) oder drei durch Schrägstriche (/) getrennte Dezimalzahlen (Anzahl Rot-, Grün- und Blautöne) sein. Bei der ersten Form wird das Bild monochrom (Graustufen) angezeigt.

**-width** *number*
: Legt die Bildbreite in Pixeln fest. Die Option ist vor allem nützlich, wenn der Benutzer den Bildinhalt stückweise aufbauen möchte. Null (Standard) erlaubt horizontales Anpassen an die gespeicherten Daten.


# Bild-Befehl

Beim Erzeugen eines Foto-Images legt Tk auch einen neuen Befehl an, dessen Name mit dem des Images übereinstimmt. Dieser Befehl kann verschiedene Operationen am Bild ausführen. Allgemeine Form:

```
imageName option ?arg arg ...?
```

*Option* und die Argumente *arg* bestimmen das genaue Verhalten des Befehls.

Optionen, die Daten in das Bild schreiben, vergrößern das Bild bei Bedarf, um die geschriebenen Daten aufzunehmen — es sei denn, der Benutzer hat für die Konfigurationsoptionen **-width** und/oder **-height** von null abweichende Werte gesetzt; dann ändern sich Breite und/oder Höhe des Images nicht.

Folgende Befehle sind für Foto-Images möglich:

*imageName* **blank**
: Leert das Bild, das heißt, das gesamte Bild erhält keine Daten. Es wird dann transparent angezeigt, und der Hintergrund des Fensters, in dem es angezeigt wird, scheint durch.

*imageName* **cget** *option*
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann jeden von [image create][image] **photo** akzeptierten Wert haben.

*imageName* **configure** ?*option*? ?*value option value ...*?
: Fragt die Konfigurationsoptionen des Bildes ab oder ändert sie. Ist keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *imageName* beschreibt (Informationen zum Format dieser Liste finden Sie unter [Tk\_ConfigureInfo][ConfigWidg]). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden der Werte haben, die der Befehl [image create][image] **photo** akzeptiert.

*imageName* **copy** *sourceImage* ?*option value(s) ...*?
: Kopiert eine Region vom Image *sourceImage* (muss ein Foto-Image sein) nach *imageName*, optional mit Pixel-Zoom und/oder -Unterabtastung. Ohne Optionen wird ganz *sourceImage* ab (0,0) in *imageName* kopiert. Mögliche Optionen:

    **-from** *x1 y1 x2 y2*
    : Rechteckige Teilregion der Quelle. (*x1,y1*) und (*x2,y2*) sind diagonal gegenüberliegende Ecken. Fehlen *x2* und *y2*, ist die Standardeinstellung die untere rechte Ecke der Quelle. Kopierte Pixel umfassen linke und obere Kante des Rechtecks, nicht untere und rechte. Ohne **-from** wird die ganze Quelle verwendet.

    **-to** *x1 y1 x2 y2*
    : Rechteckige Teilregion des Ziel-Images. (*x1,y1*) und (*x2,y2*) sind diagonal gegenüberliegende Ecken. Fehlen *x2* und *y2*, ist der Standard (*x1,y1*) plus Größe der Quellregion (nach Unterabtastung/Zoom). Sind *x2* und *y2* angegeben, wird die Quellregion bei Bedarf gekachelt, um die Zielregion zu füllen.

    **-shrink**
    : Verkleinert das Ziel-Image bei Bedarf, sodass die kopierte Region in der unteren rechten Ecke liegt. Die Option ändert Breite/Höhe nicht, wenn der Benutzer **-width** bzw. **-height** ungleich null gesetzt hat.

    **-zoom** *x y*
    : Vergrößert die Quellregion um Faktor *x* in X- und *y* in Y-Richtung. Fehlt *y*, entspricht es *x*. Jedes Quellpixel wird zu einem *x*×*y*-Block gleicher Farbe im Ziel. *x* und *y* müssen größer als 0 sein.

    **-subsample** *x y*
    : Verkleinert die Quelle, indem nur jedes *x*. Pixel in X und jedes *y*. Pixel in Y verwendet wird. Negative Werte spiegeln um die Y- bzw. X-Achse. Fehlt *y*, entspricht es *x*.

    **-compositingrule** *rule*
    : Legt fest, wie transparente Quellpixel mit dem Ziel kombiniert werden. Bei *overlay* bleibt alter Zielinhalt sichtbar, als läge die Quelle auf transparentem Film über dem Ziel. Bei *set* wird alter Zielinhalt verworfen und die Quelle unverändert übernommen. Standard ist *overlay*.


*imageName* **data** ?*option value(s) ...*?
: Gibt Bilddaten in Form einer Zeichenkette zurück. Die folgenden Optionen können angegeben werden:

    **-background** *color*
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    **-format** *format-name*
    : Legt den Namen des zu verwendenden Bilddateiformat-Handlers fest. Konkret sucht dieser Unterbefehl den ersten Handler, dessen Name mit einer Anfangszeichenkette von *format-name* übereinstimmt und der eine Zeichenkette mit diesen Bilddaten schreiben kann. Ist diese Option nicht angegeben, verwendet dieser Unterbefehl ein Format, das aus einer Liste (ein Element pro Zeile) von Listen (ein Element pro Pixel bzw. Spalte) von Farben im Format „**#***rrggbb*“ besteht (dabei ist *rr* ein Paar Hexadezimalziffern für den Rotkanal, *gg* für Grün und *bb* für Blau).

    **-from** *x1 y1 x2 y2*
    : Rechteckige Region von *imageName*, die zurückgegeben wird. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke. Alle vier Koordinaten: diagonal gegenüberliegende Ecken, einschließlich x1,y1, ausschließlich x2,y2. Standard: ganzes Bild.

    **-grayscale**
    : Ist diese Option angegeben, enthalten die Daten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.


*imageName* **get** *x y*
: Gibt die Farbe des Pixels an den Koordinaten (*x*,*y*) im Bild als Liste von drei Ganzzahlen zwischen 0 und 255 zurück, die den Rot-, Grün- und Blauanteil darstellen.

*imageName* **put** *data* ?*option value(s) ...*?
: Setzt Pixel in *imageName* auf die in *data* angegebenen Daten. Dieser Befehl durchsucht zuerst die Liste der Bilddateiformat-Handler nach einem Handler, der die Daten in *data* interpretieren kann, und liest dann das darin kodierte Bild in *imageName* (das Zielbild) ein. Passt *data* zu keinem bekannten Format, wird versucht, die Daten als (von oben nach unten geordnete) Liste von Scanlines zu interpretieren, wobei jede Scanline eine (von links nach rechts geordnete) Liste von Pixelfarben ist (eine Beschreibung gültiger Farben finden Sie unter [Tk\_GetColor][GetColor]). Alle Scanlines müssen dieselbe Länge haben. Beachten Sie: Ist *data* ein einzelner Farbname, weisen Sie Tk damit an, eine rechteckige Region mit dieser Farbe zu füllen. Die folgenden Optionen können angegeben werden:

    **-format** *format-name*
    : Legt das Format der Bilddaten in *data* fest. Konkret werden bei der Suche nach einem Handler, der die Daten lesen kann, nur Bilddateiformat-Handler berücksichtigt, deren Name mit *format-name* beginnt.

    **-to** *x1 y1* ?*x2 y2*?
    : Legt die Koordinaten der oberen linken Ecke (*x1*,*y1*) der Region von *imageName* fest, in die die Bilddaten kopiert werden. Die Standardposition ist (0,0). Ist *x2*,*y2* angegeben und reicht *data* nicht aus, um das mit dieser Option angegebene Rechteck abzudecken, werden die gelesenen Bilddaten gekachelt, sodass sie das gesamte Zielrechteck abdecken. Beachten Sie: Gibt *data* einen einzelnen Farbwert an, wird eine Region bis zu der durch (*x2*,*y2*) bezeichneten unteren rechten Ecke mit dieser Farbe gefüllt.


*imageName* **read** *filename* ?*option value(s) ...*?
: Liest Bilddaten aus der Datei *filename* ins Image. Zuerst wird ein passender Handler gesucht, dann wird das Bild in *imageName* gelesen. Mögliche Optionen:

    **-format** *format-name*
    : Legt das Format der Bilddaten in *filename* fest. Konkret werden bei der Suche nach einem Handler, der die Daten lesen kann, nur Bilddateiformat-Handler berücksichtigt, deren Name mit *format-name* beginnt.

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
    : Gibt einen booleschen Wert zurück, der angibt, ob das Pixel bei (*x*,*y*) transparent ist.

    *imageName* **transparency set** *x y boolean*
    : Macht das Pixel bei (*x*,*y*) transparent, wenn *boolean* wahr ist, und andernfalls opak.


*imageName* **write** *filename* ?*option value(s) ...*?
: Schreibt Bilddaten von *imageName* in die Datei *filename*. Folgende Optionen können angegeben werden:

    **-background** *color*
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    **-format** *format-name*
    : Legt den Namen des Bilddateiformat-Handlers fest, mit dem die Daten in die Datei geschrieben werden. Konkret sucht dieser Unterbefehl den ersten Handler, dessen Name mit einer Anfangszeichenkette von *format-name* übereinstimmt und der eine Bilddatei schreiben kann. Ist diese Option nicht angegeben, wird das Format aus der Dateiendung erraten. Lässt es sich daraus nicht bestimmen, verwendet dieser Unterbefehl den ersten Handler, der eine Bilddatei schreiben kann.

    **-from** *x1 y1 x2 y2*
    : Rechteckige Region von *imageName*, die in die Bilddatei geschrieben wird. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke von *imageName*. Alle vier Koordinaten: diagonal gegenüberliegende Ecken. Standard: ganzes Bild.

    **-grayscale**
    : Ist diese Option angegeben, enthalten die Daten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.



# Bildformate

Der Photo-Image-Code ist so aufgebaut, dass sich Handler für weitere Bilddateiformate leicht hinzufügen lassen. Der Photo-Image-Code verwaltet eine Liste dieser Handler. Handler werden der Liste hinzugefügt, indem sie mit einem Aufruf von [Tk\_CreatePhotoImageFormat][CrtPhImgFmt] registriert werden. Die Standard-Tk-Distribution enthält Handler für die Formate PPM/PGM, PNG und GIF, die bei der Initialisierung automatisch registriert werden.

Beim Lesen einer Bilddatei oder beim Verarbeiten von Zeichenkettendaten, die mit der Konfigurationsoption **-data** angegeben wurden, ruft der Photo-Image-Code nacheinander jeden Handler auf, bis einer gefunden ist, der angibt, die Daten in der Datei oder Zeichenkette lesen zu können. Meist wird so der richtige Handler gefunden. Ist das nicht der Fall, kann der Benutzer mit der Option **-format** einen Formatnamen angeben und damit festlegen, welcher Handler verwendet wird. Genauer gesagt versucht der Photo-Image-Code die Handler, deren Name mit der für die Option **-format** angegebenen Zeichenkette beginnt (beim Vergleich wird Groß- und Kleinschreibung nicht unterschieden). Gibt der Benutzer zum Beispiel **-format gif** an, kann ein Handler namens GIF87 oder GIF89 aufgerufen werden, ein Handler namens JPEG dagegen nicht (vorausgesetzt, solche Handler wurden registriert).

Beim Schreiben von Bilddaten in eine Datei ist die Verarbeitung von **-format** etwas anders: Der Zeichenkettenwert für **-format** muss mit dem vollständigen Namen des gewünschten Handlers beginnen und kann weitere Informationen enthalten, die der Handler nutzen kann, z. B. um eine Variante der vom Handler unterstützten Formate zu wählen. Nicht alle Bildhandler unterstützen das Schreiben von Transparenzdaten in eine Datei, auch wenn das Zielformat es theoretisch erlaubt.

## Format-Unteroptionen

[Einige Bildformate unterstützen Unteroptionen, die beim Laden des Bildes über zusätzliche Wörter in der Option **-format** angegeben werden. Zum Zeitpunkt der Abfassung werden die folgenden unterstützt:]{version="8.6"}

[**gif -index** *indexValue*]{version="8.6"}
: [Beim Parsen eines mehrteiligen GIF-Bildes greift Tk normalerweise nur auf das erste Bild zu. Mit der Unteroption **-index** kann stattdessen das Bild mit dem Index *indexValue* verwendet werden. *indexValue* muss eine Ganzzahl von 0 bis zur Anzahl der Bildteile in den GIF-Daten sein.]{version="8.6"}

[**png -alpha** *alphaValue*]{version="8.6"}
: [Eine zusätzliche Alpha-Filterung für das gesamte Bild, durch die der Hintergrund, auf dem das Bild angezeigt wird, durchscheinen kann. Meist bewirkt sie außerdem eine Entsättigung des Bildes. *alphaValue* muss zwischen 0,0 und 1,0 liegen.]{version="8.6"}


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
