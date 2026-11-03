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

Wie alle Images werden Photos mit dem Befehl [image create][image] erzeugt. Photos unterstützen die folgenden *Optionen*:

**-data** *string*
: Legt den Inhalt des Bildes als Zeichenkette fest. Die Zeichenkette sollte Binärdaten oder, bei manchen Formaten, Base64-kodierte Daten enthalten (für PNG- und GIF-Bilder ist das derzeit garantiert). Das Format der Zeichenkette muss eines der Formate sein, für die es einen Bilddateiformat-Handler gibt, der Zeichenkettendaten akzeptiert. Sind sowohl die Option **-data** als auch die Option **-file** angegeben, hat **-file** Vorrang.

**-format** *format-name*
: Legt den Namen des Dateiformats für die Daten fest, die mit der Option **-data** oder **-file** angegeben werden.

**-file** *name*
: *name* gibt den Namen einer Datei an, die gelesen wird, um Daten für das Foto-Image zu liefern. Das Dateiformat muss eines der Formate sein, für die es einen Bilddateiformat-Handler gibt, der Daten lesen kann.

**-gamma** *value*
: Legt fest, dass die Farben, die für die Anzeige dieses Bildes in einem Fenster zugewiesen werden, für ein nichtlineares Display mit dem angegebenen Gamma-Exponenten korrigiert werden. (Die von den meisten CRT-Displays erzeugte Intensität ist in guter Näherung eine Potenzfunktion des Eingabewerts; Gamma ist der Exponent und liegt typischerweise bei etwa 2.) Der angegebene Wert muss größer als null sein. Der Standardwert ist eins (keine Korrektur). Im Allgemeinen machen Werte größer als eins das Bild heller und Werte kleiner als eins dunkler.

**-height** *number*
: Legt die Höhe des Bildes in Pixeln fest. Diese Option ist vor allem dann nützlich, wenn der Benutzer den Inhalt des Bildes Stück für Stück aufbauen möchte. Der Wert null (der Standard) erlaubt es dem Bild, sich vertikal zu vergrößern oder zu verkleinern, sodass es zu den darin gespeicherten Daten passt.

**-palette** *palette-spec*
: Legt die Auflösung des Farbwürfels fest, der für die Anzeige dieses Bildes zugewiesen wird, und damit die Anzahl der Farben, die aus den Farbkarten der Fenster verwendet werden, in denen das Bild angezeigt wird. Die Zeichenkette *palette-spec* kann entweder eine einzelne Dezimalzahl sein, die die Anzahl der zu verwendenden Graustufen angibt, oder drei durch Schrägstriche (/) getrennte Dezimalzahlen, die die Anzahl der zu verwendenden Rot-, Grün- und Blautöne angeben. Wird die erste Form (eine einzelne Zahl) verwendet, wird das Bild monochrom (d. h. in Graustufen) angezeigt.

**-width** *number*
: Legt die Breite des Bildes in Pixeln fest. Diese Option ist vor allem dann nützlich, wenn der Benutzer den Inhalt des Bildes Stück für Stück aufbauen möchte. Der Wert null (der Standard) erlaubt es dem Bild, sich horizontal zu vergrößern oder zu verkleinern, sodass es zu den darin gespeicherten Daten passt.


# Bild-Befehl

Wenn ein Foto-Image erzeugt wird, erzeugt Tk auch einen neuen Befehl, dessen Name mit dem des Images übereinstimmt. Mit diesem Befehl lassen sich verschiedene Operationen auf dem Bild ausführen. Er hat die folgende allgemeine Form:

```
imageName option ?arg arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.

Optionen, die Daten in das Bild schreiben, vergrößern das Bild im Allgemeinen bei Bedarf, damit es die geschriebenen Daten aufnehmen kann. Das gilt nicht, wenn der Benutzer für die Konfigurationsoptionen **-width** und/oder **-height** von null verschiedene Werte angegeben hat; in diesem Fall werden Breite bzw. Höhe des Bildes nicht geändert.

Die folgenden Befehle sind für Foto-Images möglich:

*imageName* **blank**
: Leert das Bild, das heißt, das gesamte Bild erhält keine Daten. Es wird dann transparent angezeigt, und der Hintergrund des Fensters, in dem es angezeigt wird, scheint durch.

*imageName* **cget** *option*
: Gibt den aktuellen Wert der Konfigurationsoption zurück, die durch *option* angegeben ist. *Option* kann jeden der Werte haben, die der Befehl [image create][image] **photo** akzeptiert.

*imageName* **configure** ?*option*? ?*value option value ...*?
: Fragt die Konfigurationsoptionen des Bildes ab oder ändert sie. Ist keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *imageName* beschreibt (Informationen zum Format dieser Liste finden Sie unter [Tk\_ConfigureInfo][ConfigWidg]). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden der Werte haben, die der Befehl [image create][image] **photo** akzeptiert.

*imageName* **copy** *sourceImage* ?*option value(s) ...*?
: Kopiert eine Region aus dem Bild namens *sourceImage* (das ein Foto-Image sein muss) in das Bild namens *imageName*, gegebenenfalls mit Pixel-Zoom und/oder Unterabtastung. Sind keine Optionen angegeben, kopiert dieser Befehl das gesamte *sourceImage* in *imageName*, beginnend bei den Koordinaten (0,0) in *imageName*. Die folgenden Optionen können angegeben werden:

    **-from** *x1 y1 x2 y2*
    : Legt eine rechteckige Teilregion des Quellbildes fest, die kopiert wird. (*x1,y1*) und (*x2,y2*) bezeichnen diagonal gegenüberliegende Ecken des Rechtecks. Sind *x2* und *y2* nicht angegeben, ist der Standardwert die untere rechte Ecke des Quellbildes. Die kopierten Pixel umfassen die linke und die obere Kante des angegebenen Rechtecks, nicht aber die untere und die rechte Kante. Ist die Option **-from** nicht angegeben, wird standardmäßig das gesamte Quellbild kopiert.

    **-to** *x1 y1 x2 y2*
    : Legt eine rechteckige Teilregion des Zielbildes fest, die verändert wird. (*x1,y1*) und (*x2,y2*) bezeichnen diagonal gegenüberliegende Ecken des Rechtecks. Sind *x2* und *y2* nicht angegeben, ist der Standardwert (*x1,y1*) plus die Größe der Quellregion (nach Unterabtastung und Zoom, falls angegeben). Sind *x2* und *y2* angegeben, wird die Quellregion bei Bedarf wiederholt, sodass sie die Zielregion gekachelt ausfüllt.

    **-shrink**
    : Legt fest, dass das Zielbild bei Bedarf verkleinert wird, sodass die Region, in die kopiert wird, in der unteren rechten Ecke des Bildes liegt. Diese Option ändert die Breite bzw. Höhe des Bildes nicht, wenn der Benutzer für die Konfigurationsoption **-width** bzw. **-height** einen von null verschiedenen Wert angegeben hat.

    **-zoom** *x y*
    : Legt fest, dass die Quellregion in X-Richtung um den Faktor *x* und in Y-Richtung um den Faktor *y* vergrößert wird. Ist *y* nicht angegeben, ist der Standardwert gleich *x*. Mit dieser Option wird jedes Pixel des Quellbildes im Zielbild zu einem Block von *x* × *y* Pixeln erweitert, die alle dieselbe Farbe haben. *x* und *y* müssen größer als 0 sein.

    **-subsample** *x y*
    : Legt fest, dass das Quellbild verkleinert wird, indem in X-Richtung nur jedes *x*-te Pixel und in Y-Richtung nur jedes *y*-te Pixel verwendet wird. Negative Werte bewirken, dass das Bild an der Y- bzw. X-Achse gespiegelt wird. Ist *y* nicht angegeben, ist der Standardwert gleich *x*.

    **-compositingrule** *rule*
    : Legt fest, wie transparente Pixel des Quellbildes mit dem Zielbild kombiniert werden. Ist die Kompositionsregel *overlay* gesetzt, bleibt der alte Inhalt des Zielbildes sichtbar, als wäre das Quellbild auf eine transparente Folie gedruckt und über das Zielbild gelegt worden. Ist die Kompositionsregel *set* gesetzt, wird der alte Inhalt des Zielbildes verworfen und das Quellbild unverändert verwendet. Die Standard-Kompositionsregel ist *overlay*.


*imageName* **data** ?*option value(s) ...*?
: Gibt Bilddaten in Form einer Zeichenkette zurück. Die folgenden Optionen können angegeben werden:

    **-background** *color*
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    **-format** *format-name*
    : Legt den Namen des zu verwendenden Bilddateiformat-Handlers fest. Konkret sucht dieser Unterbefehl den ersten Handler, dessen Name mit einer Anfangszeichenkette von *format-name* übereinstimmt und der eine Zeichenkette mit diesen Bilddaten schreiben kann. Ist diese Option nicht angegeben, verwendet dieser Unterbefehl ein Format, das aus einer Liste (ein Element pro Zeile) von Listen (ein Element pro Pixel bzw. Spalte) von Farben im Format „**#***rrggbb*“ besteht (dabei ist *rr* ein Paar Hexadezimalziffern für den Rotkanal, *gg* für Grün und *bb* für Blau).

    **-from** *x1 y1 x2 y2*
    : Legt eine rechteckige Region von *imageName* fest, die zurückgegeben wird. Sind nur *x1* und *y1* angegeben, reicht die Region von *(x1,y1)* bis zur unteren rechten Ecke von *imageName*. Sind alle vier Koordinaten angegeben, bezeichnen sie diagonal gegenüberliegende Ecken der rechteckigen Region, wobei x1,y1 eingeschlossen und x2,y2 ausgeschlossen ist. Ist diese Option nicht angegeben, wird standardmäßig das gesamte Bild verwendet.

    **-grayscale**
    : Ist diese Option angegeben, enthalten die Daten keine Farbinformationen. Alle Pixeldaten werden in Graustufen umgewandelt.


*imageName* **get** *x y*
: Gibt die Farbe des Pixels an den Koordinaten (*x*,*y*) im Bild als Liste von drei Ganzzahlen zwischen 0 und 255 zurück, die den Rot-, Grün- und Blauanteil darstellen.

*imageName* **put** *data* ?*option value(s) ...*?
: Setzt Pixel in *imageName* auf die in *data* angegebenen Daten. Dieser Befehl durchsucht zuerst die Liste der Bilddateiformat-Handler nach einem Handler, der die Daten in *data* interpretieren kann, und liest dann das darin kodierte Bild in *imageName* (das Zielbild) ein. Passt *data* zu keinem bekannten Format, wird versucht, die Daten als (von oben nach unten geordnete) Liste von Scanlines zu interpretieren, wobei jede Scanline eine (von links nach rechts geordnete) Liste von Pixelfarben ist (eine Beschreibung gültiger Farben finden Sie unter [Tk\_GetColor][GetColor]). Alle Scanlines müssen dieselbe Länge haben. Beachten Sie: Ist *data* ein einzelner Farbname, weisen Sie Tk damit an, eine rechteckige Region mit dieser Farbe zu füllen. Die folgenden Optionen können angegeben werden:

    **-format** *format-name*
    : Legt das Format der Bilddaten in *data* fest. Konkret werden bei der Suche nach einem Handler, der die Daten lesen kann, nur Bilddateiformat-Handler berücksichtigt, deren Name mit *format-name* beginnt.

    **-to** *x1 y1* ?*x2 y2*?
    : Legt die Koordinaten der oberen linken Ecke (*x1*,*y1*) der Region von *imageName* fest, in die die Bilddaten kopiert werden. Die Standardposition ist (0,0). Ist *x2*,*y2* angegeben und reicht *data* nicht aus, um das mit dieser Option angegebene Rechteck abzudecken, werden die gelesenen Bilddaten gekachelt, sodass sie das gesamte Zielrechteck abdecken. Beachten Sie: Gibt *data* einen einzelnen Farbwert an, wird eine Region bis zu der durch (*x2*,*y2*) bezeichneten unteren rechten Ecke mit dieser Farbe gefüllt.


*imageName* **read** *filename* ?*option value(s) ...*?
: Liest Bilddaten aus der Datei namens *filename* in das Bild ein. Dieser Befehl durchsucht zuerst die Liste der Bilddateiformat-Handler nach einem Handler, der die Daten in *filename* interpretieren kann, und liest dann das Bild aus *filename* in *imageName* (das Zielbild) ein. Die folgenden Optionen können angegeben werden:

    **-format** *format-name*
    : Legt das Format der Bilddaten in *filename* fest. Konkret werden bei der Suche nach einem Handler, der die Daten lesen kann, nur Bilddateiformat-Handler berücksichtigt, deren Name mit *format-name* beginnt.

    **-from** *x1 y1 x2 y2*
    : Legt eine rechteckige Teilregion der Daten aus der Bilddatei fest, die in das Zielbild kopiert wird. Sind nur *x1* und *y1* angegeben, reicht die Region von (*x1,y1*) bis zur unteren rechten Ecke des Bildes in der Bilddatei. Sind alle vier Koordinaten angegeben, bezeichnen sie diagonal gegenüberliegende Ecken der Region. Ist diese Option nicht angegeben, wird standardmäßig das gesamte Bild in der Bilddatei verwendet.

    **-shrink**
    : Ist diese Option angegeben, wird *imageName* bei Bedarf verkleinert, sodass die Region, in die die Daten aus der Bilddatei gelesen werden, in der unteren rechten Ecke von *imageName* liegt. Diese Option ändert die Breite bzw. Höhe des Bildes nicht, wenn der Benutzer für die Konfigurationsoption **-width** bzw. **-height** einen von null verschiedenen Wert angegeben hat.

    **-to** *x y*
    : Legt die Koordinaten der oberen linken Ecke der Region von *imageName* fest, in die die Daten aus *filename* gelesen werden. Der Standardwert ist (0,0).


*imageName* **redither**
: Der Dithering-Algorithmus, der beim Anzeigen von Foto-Images verwendet wird, gibt Quantisierungsfehler von einem Pixel an seine Nachbarn weiter. Werden die Bilddaten für *imageName* stückweise geliefert, ist das geditherte Bild möglicherweise nicht ganz korrekt. Normalerweise ist der Unterschied nicht wahrnehmbar. Stört er doch, kann mit diesem Befehl das geditherte Bild in jedem Fenster neu berechnet werden, in dem das Bild angezeigt wird.

*imageName* **transparency** *subcommand* ?*arg arg ...*?
: Ermöglicht das Abfragen und Ändern der Transparenzinformationen im Foto-Image. Es stehen mehrere Unterbefehle zur Verfügung:

    *imageName* **transparency get** *x y*
    : Gibt einen booleschen Wert zurück, der angibt, ob das Pixel bei (*x*,*y*) transparent ist.

    *imageName* **transparency set** *x y boolean*
    : Macht das Pixel bei (*x*,*y*) transparent, wenn *boolean* wahr ist, und andernfalls opak.


*imageName* **write** *filename* ?*option value(s) ...*?
: Schreibt Bilddaten aus *imageName* in eine Datei namens *filename*. Die folgenden Optionen können angegeben werden:

    **-background** *color*
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    **-format** *format-name*
    : Legt den Namen des Bilddateiformat-Handlers fest, mit dem die Daten in die Datei geschrieben werden. Konkret sucht dieser Unterbefehl den ersten Handler, dessen Name mit einer Anfangszeichenkette von *format-name* übereinstimmt und der eine Bilddatei schreiben kann. Ist diese Option nicht angegeben, wird das Format aus der Dateiendung erraten. Lässt es sich daraus nicht bestimmen, verwendet dieser Unterbefehl den ersten Handler, der eine Bilddatei schreiben kann.

    **-from** *x1 y1 x2 y2*
    : Legt eine rechteckige Region von *imageName* fest, die in die Bilddatei geschrieben wird. Sind nur *x1* und *y1* angegeben, reicht die Region von *(x1,y1)* bis zur unteren rechten Ecke von *imageName*. Sind alle vier Koordinaten angegeben, bezeichnen sie diagonal gegenüberliegende Ecken der rechteckigen Region. Ist diese Option nicht angegeben, wird standardmäßig das gesamte Bild verwendet.

    **-grayscale**
    : Ist diese Option angegeben, enthalten die Daten keine Farbinformationen. Alle Pixeldaten werden in Graustufen umgewandelt.



# Bildformate

Der Photo-Image-Code ist so aufgebaut, dass sich Handler für weitere Bilddateiformate leicht hinzufügen lassen. Der Photo-Image-Code verwaltet eine Liste dieser Handler. Handler werden der Liste hinzugefügt, indem sie mit einem Aufruf von [Tk\_CreatePhotoImageFormat][CrtPhImgFmt] registriert werden. Die Standard-Tk-Distribution enthält Handler für die Formate PPM/PGM, PNG und GIF, die bei der Initialisierung automatisch registriert werden.

Beim Lesen einer Bilddatei oder beim Verarbeiten von Zeichenkettendaten, die mit der Konfigurationsoption **-data** angegeben wurden, ruft der Photo-Image-Code nacheinander jeden Handler auf, bis einer gefunden ist, der angibt, die Daten in der Datei oder Zeichenkette lesen zu können. Meist wird so der richtige Handler gefunden. Ist das nicht der Fall, kann der Benutzer mit der Option **-format** einen Formatnamen angeben und damit festlegen, welcher Handler verwendet wird. Genauer gesagt versucht der Photo-Image-Code die Handler, deren Name mit der für die Option **-format** angegebenen Zeichenkette beginnt (beim Vergleich wird Groß- und Kleinschreibung nicht unterschieden). Gibt der Benutzer zum Beispiel **-format gif** an, kann ein Handler namens GIF87 oder GIF89 aufgerufen werden, ein Handler namens JPEG dagegen nicht (vorausgesetzt, solche Handler wurden registriert).

Beim Schreiben von Bilddaten in eine Datei wird die Option **-format** etwas anders verarbeitet: Der für die Option **-format** angegebene Zeichenkettenwert muss mit dem vollständigen Namen des gewünschten Handlers beginnen und kann danach weitere Informationen enthalten, die der Handler zum Beispiel nutzen kann, um festzulegen, welche Variante der von ihm unterstützten Formate verwendet wird. Beachten Sie, dass möglicherweise nicht alle Bild-Handler das Schreiben von Transparenzdaten in eine Datei unterstützen, selbst wenn das Zielformat dies tut.

## Format-Unteroptionen

[Einige Bildformate unterstützen Unteroptionen, die beim Laden des Bildes über zusätzliche Wörter in der Option **-format** angegeben werden. Zum Zeitpunkt der Abfassung werden die folgenden unterstützt:]{version="8.6"}

[**gif -index** *indexValue*]{version="8.6"}
: [Beim Parsen eines mehrteiligen GIF-Bildes greift Tk normalerweise nur auf das erste Bild zu. Mit der Unteroption **-index** kann stattdessen das Bild mit dem Index *indexValue* verwendet werden. *indexValue* muss eine Ganzzahl von 0 bis zur Anzahl der Bildteile in den GIF-Daten sein.]{version="8.6"}

[**png -alpha** *alphaValue*]{version="8.6"}
: [Eine zusätzliche Alpha-Filterung für das gesamte Bild, durch die der Hintergrund, auf dem das Bild angezeigt wird, durchscheinen kann. Meist bewirkt sie außerdem eine Entsättigung des Bildes. *alphaValue* muss zwischen 0,0 und 1,0 liegen.]{version="8.6"}


# Farbzuweisung

Wird ein Foto-Image in einem Fenster angezeigt, weist der Photo-Image-Code die Farben zu, mit denen das Bild angezeigt wird, und dithert das Bild bei Bedarf, um mit den verfügbaren Farben eine brauchbare Annäherung an das Bild darzustellen. Die Farben werden als Farbwürfel zugewiesen, das heißt, die Anzahl der zugewiesenen Farben ist das Produkt der Anzahl der Rot-, Grün- und Blautöne.

Normalerweise richtet sich die Anzahl der zugewiesenen Farben nach der Tiefe des Fensters. In einem 8-Bit-PseudoColor-Fenster versucht der Photo-Image-Code zum Beispiel, sieben Rottöne, sieben Grüntöne und vier Blautöne zuzuweisen, insgesamt also 198 Farben. In einem 1-Bit-StaticGray-Fenster (monochrom) weist er zwei Farben zu, Schwarz und Weiß. In einem 24-Bit-DirectColor- oder TrueColor-Fenster weist er je 256 Rot-, Grün- und Blautöne zu. Glücklicherweise müssen dafür wegen der Art, wie Pixelwerte in DirectColor- und TrueColor-Fenstern kombiniert werden können, nur 256 Farben zugewiesen werden. Können nicht alle Farben zugewiesen werden, verringert der Photo-Image-Code die Anzahl der Töne jeder Grundfarbe und versucht es erneut.

Der Benutzer kann mit der Konfigurationsoption **-palette** in gewissem Maß steuern, wie viele Farben ein Foto-Image verwendet. Wird diese Option verwendet, legt sie die maximale Anzahl an Tönen jeder Grundfarbe fest, deren Zuweisung versucht wird. Mit ihr lässt sich auch erzwingen, dass das Bild in Graustufen angezeigt wird, selbst auf einem Farbdisplay, indem eine einzelne Zahl statt drei durch Schrägstriche getrennter Zahlen angegeben wird.

# Danksagungen

Der Photo-Image-Typ wurde von Paul Mackerras entworfen und implementiert, auf der Grundlage seines früheren Photo-Widgets und einiger Vorschläge von John Ousterhout.

# Beispiel

Lädt ein Bild aus einer Datei und kachelt es auf die Größe eines Fensters, was nützlich ist, um einen gekachelten Hintergrund zu erzeugen:

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

[Der PNG-Bildlader erlaubt es, beim Laden einen zusätzlichen Alpha-Faktor anzuwenden. Das ist nützlich, um Bilder zu erzeugen, die sich für deaktivierte Buttons eignen:]{version="8.6"}

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
