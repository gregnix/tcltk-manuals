---
CommandName: photo
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

# NAME

photo - Vollfarbbilder

# ÜBERSICHT

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

# BESCHREIBUNG

Ein Photo ist ein Bild, dessen Pixel jede Farbe anzeigen oder transparent sein können. Ein Foto-Image wird intern in Vollfarbe (32 Bit pro Pixel) gespeichert und bei Bedarf mit Dithering angezeigt. Bilddaten für ein Foto-Image können aus einer Datei oder einer Zeichenkette stammen oder über eine prozedurale C-Schnittstelle geliefert werden. Derzeit werden nur

::: {.info -version="8.6"}
PNG,
:::

GIF und PPM/PGM unterstützt; eine Schnittstelle erlaubt jedoch, weitere Bilddateiformate leicht hinzuzufügen. Ein Foto-Image ist in Bereichen transparent, in denen keine Bilddaten geliefert wurden oder die mit dem Unterbefehl **transparency set** transparent gesetzt wurden.

# ERSTELLUNG VON PHOTOS

Wie alle Images werden Photos mit **image create** erzeugt. Photos unterstützen folgende *Optionen*:

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


# BILD-BEFEHL

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
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann jeden von **image create** **photo** akzeptierten Wert haben.

*imageName* **configure** ?*option*? ?*value option value ...*?
: Fragt Konfigurationsoptionen ab oder ändert sie. Ohne *option* wird eine Liste aller verfügbaren Optionen für *imageName* zurückgegeben (Format siehe **Tk_ConfigureInfo**). Mit *option* ohne *value* eine Liste nur für diese Option (identisch mit dem entsprechenden Teillisten-Eintrag der vollständigen Liste). Bei *option-value*-Paaren werden die Optionen gesetzt; Rückgabe ist ein leerer String. *Option* kann jeden von **image create** **photo** akzeptierten Wert haben.

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
: Name des Bilddateiformat-Handlers. Dieser Unterbefehl sucht den ersten Handler, dessen Name mit einem Anfangs-Substring von *format-name* übereinstimmt und der einen String mit diesen Bilddaten schreiben kann. Ohne Option wird ein Format verwendet: Liste (ein Element pro Zeile) von Listen (ein Element pro Pixel/Spalte) mit Farben im Format „**#**_rrggbb_“ (*rr*, *gg*, *bb* je ein Hex-Paar für Rot, Grün, Blau).

**-from** *x1 y1 x2 y2*
: Rechteckige Region von *imageName*. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke. Alle vier Koordinaten: diagonal gegenüberliegende Ecken, einschließlich x1,y1, ausschließlich x2,y2. Standard: ganzes Bild.

**-grayscale**
: Die Daten enthalten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.


*imageName* **get** *x y*
: Gibt die Farbe des Pixels bei (*x*,*y*) als Liste von drei Ganzzahlen 0–255 für Rot, Grün und Blau zurück.

*imageName* **put** *data* ?*option value(s) ...*?
: Setzt Pixel in *imageName* auf die in *data* angegebenen Daten. Der Befehl sucht einen Handler, der *data* interpretieren kann, und liest das kodierte Bild in *imageName*. Passt *data* zu keinem bekannten Format, wird versucht, es als (von oben nach unten) Liste von Scanlines zu lesen, jede Scanline eine (von links nach rechts) Liste von Pixelfarben (gültige Farben siehe **Tk_GetColor**). Jede Scanline muss gleiche Länge haben. Bei einem einzelnen Farbnamen wird eine rechteckige Region mit dieser Farbe gefüllt. Mögliche Optionen:

**-format** *format-name*
: Format der Bilddaten in *data*. Es werden nur Handler verwendet, deren Name mit *format-name* beginnt.

**-to** *x1 y1* ?*x2 y2*?
: Koordinaten der oberen linken Ecke (*x1*,*y1*) der Zielregion. Standard (0,0). Mit *x2*,*y2* und zu kleinen *data* wird gekachelt. Bei einem einzelnen Farbwert wird die Region bis (*x2*,*y2*) mit dieser Farbe gefüllt.


*imageName* **read** *filename* ?*option value(s) ...*?
: Liest Bilddaten aus *filename* ins Image. Zuerst wird ein passender Handler gesucht, dann wird das Bild in *imageName* gelesen. Mögliche Optionen:

**-format** *format-name*
: Format der Daten in *filename*. Nur Handler, deren Name mit *format-name* beginnt.

**-from** *x1 y1 x2 y2*
: Rechteckige Teilregion der Dateidaten für das Ziel. Nur *x1* und *y1*: von (*x1,y1*) bis zur unteren rechten Ecke in der Datei. Alle vier Koordinaten: diagonal gegenüberliegende Ecken der Region. Standard: ganzes Bild in der Datei.

**-shrink**
: Verkleinert *imageName* bei Bedarf, sodass die gelesene Region in der unteren rechten Ecke liegt. Breite/Höhe bleiben unverändert bei gesetztem **-width**/**-height** ungleich null.

**-to** *x y*
: Obere linke Ecke der Zielregion. Standard (0,0).


*imageName* **redither**
: Das beim Anzeigen von Foto-Images verwendete Dithering propagiert Quantisierungsfehler zu Nachbarpixeln. Werden die Bilddaten für *imageName* stückweise geliefert, kann das geditherte Bild abweichen. Normalerweise fällt das nicht auf; bei Bedarf berechnet dieser Befehl das geditherte Bild in jedem Fenster neu, in dem das Image angezeigt wird.

*imageName* **transparency** *subcommand* ?*arg arg ...*?
: Ermöglicht Abfrage und Änderung der Transparenzinformationen. Verfügbare Unterbefehle:

*imageName* **transparency get** *x y*
: Gibt einen booleschen Wert zurück, ob der Pixel bei (*x*,*y*) transparent ist.

*imageName* **transparency set** *x y boolean*
: Macht den Pixel bei (*x*,*y*) transparent, wenn *boolean* wahr ist, sonst opak.


*imageName* **write** *filename* ?*option value(s) ...*?
: Schreibt Bilddaten von *imageName* in *filename*. Mögliche Optionen:

**-background** *color*
: Mit angegebener Farbe keine Transparenz in den Daten; transparente Pixel werden durch diese Farbe ersetzt.

**-format** *format-name*
: Handler zum Schreiben in die Datei. Ohne Option wird aus der Dateiendung geraten; sonst der erste schreibfähige Handler.

**-from** *x1 y1 x2 y2*
: Rechteckige Region von *imageName* für die Datei. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke. Alle vier Koordinaten: diagonal gegenüberliegende Ecken. Standard: ganzes Bild.

**-grayscale**
: Die Daten enthalten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.



# BILDFORMATE

Der Photo-Image-Code ist so strukturiert, dass Handler für weitere Bilddateiformate leicht ergänzt werden können. Handler werden per **Tk_CreatePhotoImageFormat** registriert. Die Standard-Tk-Distribution enthält Handler für PPM/PGM, PNG und GIF; sie werden bei der Initialisierung automatisch registriert.

Beim Lesen einer Datei oder Verarbeiten von Stringdaten mit **-data** ruft der Code Handler nacheinander auf, bis einer die Daten lesen kann. Meist findet das den richtigen Handler; andernfalls kann mit **-format** ein Formatname vorgegeben werden. Es werden Handler versucht, deren Name mit dem **-format**-String beginnt (Groß-/Kleinschreibung irrelevant). Bei **-format gif** können z. B. GIF87 oder GIF89 aufgerufen werden, JPEG nicht (sofern registriert).

Beim Schreiben in eine Datei muss der **-format**-String mit dem vollständigen Handlernamen beginnen und kann weitere Informationen für den Handler enthalten (z. B. Variante eines unterstützten Formats). Nicht alle Handler unterstützen das Schreiben von Transparenzdaten, auch wenn das Zielformat es theoretisch erlaubt.

## Format-Unteroptionen

::: {.info -version="8.6"}
Manche Bildformate unterstützen Unteroptionen, die beim Laden über zusätzliche Wörter in **-format** angegeben werden. Derzeit unterstützt:
:::

**gif -index** *indexValue*
: Beim Parsen eines mehrteiligen GIF-Images greift Tk normalerweise nur auf das erste Bild zu. Mit **-index** kann das *indexValue*. Bild verwendet werden. *indexValue* muss eine Ganzzahl von 0 bis zur Anzahl der Bildteile im GIF sein.

**png -alpha** *alphaValue*
: Zusätzlicher Alpha-Filter für das Gesamtbild, sodass der Hintergrund der Anzeige durchscheint; oft auch Entsättigung. *alphaValue* muss zwischen 0,0 und 1,0 liegen.


# FARBZUWEISUNG

Wird ein Foto-Image in einem Fenster angezeigt, weist der Photo-Image-Code Farben zu und dithert das Bild bei Bedarf, um eine brauchbare Annäherung mit den verfügbaren Farben darzustellen. Die Farben werden als Farbwürfel zugewiesen: die Anzahl der zugewiesenen Farben ist das Produkt der Anzahl der Rot-, Grün- und Blautöne.

Normalerweise richtet sich die Anzahl nach der Fenstertiefe. In einem 8-Bit-PseudoColor-Fenster werden z. B. sieben Rottöne, sieben Grüntöne und vier Blautöne (198 Farben) versucht. In einem 1-Bit-StaticGray-Fenster Schwarz und Weiß. In einem 24-Bit-DirectColor- oder TrueColor-Fenster 256 Stufen je Kanal — durch die Pixelkombination reichen 256 zugewiesene Farben. Können nicht alle Farben zugewiesen werden, reduziert der Code die Stufen pro Grundfarbe und versucht es erneut.

Mit **-palette** kann der Benutzer die maximale Anzahl Stufen pro Grundfarbe begrenzen oder das Bild in Graustufen erzwingen (eine Zahl statt drei durch Schrägstriche getrennte).

# DANKSAGUNGEN

Der Photo-Image-Typ wurde von Paul Mackerras entworfen und implementiert, auf Basis seines früheren Photo-Widgets und einiger Vorschläge von John Ousterhout.

# BEISPIEL

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

::: {.info -version="8.6"}
Der PNG-Bildlader erlaubt die Anwendung eines zusätzlichen Alpha-Faktors beim Laden — nützlich für Bilder deaktivierter Buttons:
:::

```
image create photo icon -file "icon.png"
image create photo iconDisabled -file "icon.png" \
        -format "png -alpha 0.5"
button .b -image icon -disabledimage iconDisabled
```

