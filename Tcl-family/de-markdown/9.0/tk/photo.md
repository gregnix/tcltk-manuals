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
[imageName]{.ins} [get]{.sub} [x]{.arg} [y]{.arg} [option]{.optarg}
[imageName]{.ins} [put]{.sub} [data]{.arg} [option value(s)]{.optdot}
[imageName]{.ins} [read]{.sub} [filename]{.arg} [option value(s)]{.optdot}
[imageName]{.ins} [redither]{.sub}
[imageName]{.ins} [transparency]{.sub} [subcommand]{.arg} [arg]{.optdot}
[imageName]{.ins} [write]{.sub} [filename]{.arg} [option value(s)]{.optdot}
:::

# Beschreibung

Ein Photo ist ein Bild, dessen Pixel jede Farbe mit variabler Transparenz (Alpha-Kanal) anzeigen können. Ein Foto-Image wird intern in Vollfarbe (32 Bit pro Pixel) gespeichert und bei Bedarf mit Dithering angezeigt. Bilddaten können aus einer Datei oder Zeichenkette stammen oder über eine prozedurale C-Schnittstelle geliefert werden. Derzeit werden nur [PNG,]{version="8.6"} GIF, PPM/PGM, [und (nur lesend) SVG]{version="9.0"} unterstützt; eine Schnittstelle erlaubt, weitere Bilddateiformate leicht hinzuzufügen. Ein Foto-Image ist (halb)transparent, wenn die Bilddaten Transparenzinformationen enthielten. In Bereichen ohne Bilddaten ist es vollständig transparent. Transparenz kann auch mit dem Unterbefehl **transparency set** geändert werden.

# Erstellung von Photos

Wie alle Images werden Photos mit [image create][image] erzeugt. Photos unterstützen folgende *Optionen*:

[-data]{.lit} [string]{.arg}
: Legt den Bildinhalt als Zeichenkette fest. [Die Zeichenkette soll Daten in der Standardform Liste-von-Listen,]{version="9.0"} Binärdaten oder — für manche Formate — Base64-kodierte Daten enthalten (derzeit garantiert für PNG- und GIF-Bilder). Das Format der Zeichenkette muss eines der Formate sein, für die ein Bilddateiformat-Handler Stringdaten akzeptiert. Sind sowohl **-data** als auch **-file** angegeben, hat **-file** Vorrang.

[-format]{.lit} [{format-name ?option value ...?}]{.arg}
: Legt den Namen des Dateiformats für die mit **-data** oder **-file** angegebenen Daten fest und optionale Argumente für den Format-Handler. Der Wert dieser Option muss eine Tcl-Liste sein. Bei einem Wort können die geschweiften Klammern entfallen; statt Klammern können Anführungszeichen zur Quotierung verwendet werden.

[-file]{.lit} [name]{.arg}
: *name* gibt den Namen einer Datei an, aus der Daten für das Foto-Image gelesen werden. Das Dateiformat muss eines der Formate sein, die ein Bilddateiformat-Handler lesen kann.

[-gamma]{.lit} [value]{.arg}
: Legt fest, dass die zur Anzeige dieses Bildes in einem Fenster zugewiesenen Farben für ein nichtlineares Display mit dem angegebenen Gamma-Exponenten korrigiert werden. (Die von den meisten CRT-Displays erzeugte Intensität ist näherungsweise eine Potenzfunktion des Eingabewerts; Gamma ist der Exponent und liegt typischerweise bei etwa 2.) Der angegebene Wert muss größer als null sein. Standard ist eins (keine Korrektur). Im Allgemeinen machen Werte größer als eins das Bild heller, Werte kleiner als eins dunkler.

[-height]{.lit} [number]{.arg}
: Legt die Bildhöhe in Pixeln fest. Die Option ist vor allem nützlich, wenn der Benutzer den Bildinhalt stückweise aufbauen möchte. Null (Standard) erlaubt vertikales Anpassen an die gespeicherten Daten.

[-metadata]{.lit} [metadata]{.arg}
: [Setzt das Metadaten-Dictionary des Images. Weitere Schlüssel können im Metadaten-Dictionary des Images gesetzt werden, wenn Bilddaten wegen der Optionen **-file** oder **-data** verarbeitet werden und der Treiber Metadaten-Schlüssel liefert. Siehe Abschnitt [Metadaten-Dictionary] unten.]{version="9.0"}

[-palette]{.lit} [palette-spec]{.arg}
: Legt die Auflösung des zuzuweisenden Farbwürfels und damit die Anzahl der aus den Farbtabellen der Anzeigefenster genutzten Farben fest. *palette-spec* kann eine einzelne Dezimalzahl (Anzahl Graustufen) oder drei durch Schrägstriche (/) getrennte Dezimalzahlen (Anzahl Rot-, Grün- und Blautöne) sein. Bei der ersten Form wird das Bild monochrom (Graustufen) angezeigt.

[-width]{.lit} [number]{.arg}
: Legt die Bildbreite in Pixeln fest. Die Option ist vor allem nützlich, wenn der Benutzer den Bildinhalt stückweise aufbauen möchte. Null (Standard) erlaubt horizontales Anpassen an die gespeicherten Daten.


# Bild-Befehl

Beim Erzeugen eines Foto-Images legt Tk auch einen neuen Befehl an, dessen Name mit dem des Images übereinstimmt. Dieser Befehl kann verschiedene Operationen am Bild ausführen. Allgemeine Form:

```
imageName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.

Optionen, die Daten in das Bild schreiben, vergrößern das Bild bei Bedarf, um die geschriebenen Daten aufzunehmen — es sei denn, der Benutzer hat für die Konfigurationsoptionen **-width** und/oder **-height** von null abweichende Werte gesetzt; dann ändern sich Breite und/oder Höhe des Images nicht.

Folgende Befehle sind für Foto-Images möglich:

[imageName]{.ins} [blank]{.sub}
: Leert das Bild; das gesamte Image hat keinen Dateninhalt, wird transparent angezeigt, und der Hintergrund des Anzeigefensters scheint durch. Das Metadaten-Dictionary des Images bleibt unverändert.

[imageName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann jeden von [image create][image] **photo** akzeptierten Wert haben.

[imageName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Fragt Konfigurationsoptionen ab oder ändert sie. Ohne *option* wird eine Liste aller verfügbaren Optionen für *imageName* zurückgegeben (Format siehe [Tk\_ConfigureInfo][ConfigWidg]). Mit *option* ohne *value* eine Liste nur für diese Option (identisch mit dem entsprechenden Teillisten-Eintrag der vollständigen Liste). Bei *option-value*-Paaren werden die Optionen gesetzt; Rückgabe ist ein leerer String. *Option* kann jeden von [image create][image] **photo** akzeptierten Wert haben. [Nur die Option **-metadata** setzen, ohne weitere Option, ruft den Bildformat-Treiber nicht auf, um das Bitmap neu zu erzeugen.]{version="9.0"}

[imageName]{.ins} [copy]{.sub} [sourceImage]{.arg} [option value(s)]{.optdot}
: Kopiert eine Region vom Image *sourceImage* (muss ein Foto-Image sein) nach *imageName*, optional mit Pixel-Zoom und/oder -Unterabtastung. Ohne Optionen wird ganz *sourceImage* ab (0,0) in *imageName* kopiert. Mögliche Optionen:

    [-from]{.lit} [x1]{.arg} [y1]{.arg} [x2]{.arg} [y2]{.arg}
    : Rechteckige Teilregion der Quelle. (*x1,y1*) und (*x2,y2*) sind diagonal gegenüberliegende Ecken. Fehlen *x2* und *y2*, ist die Standardeinstellung die untere rechte Ecke der Quelle. Kopierte Pixel umfassen linke und obere Kante des Rechtecks, nicht untere und rechte. Ohne **-from** wird die ganze Quelle verwendet.

    [-to]{.lit} [x1]{.arg} [y1]{.arg} [x2]{.arg} [y2]{.arg}
    : Rechteckige Teilregion des Ziel-Images. (*x1,y1*) und (*x2,y2*) sind diagonal gegenüberliegende Ecken. Fehlen *x2* und *y2*, Standard ist (*x1,y1*) plus Größe der Quellregion (nach Unterabtastung/Zoom). Sind *x2* und *y2* angegeben, wird die Quellregion bei Bedarf gekachelt, um die Zielregion zu füllen.

    [-shrink]{.lit}
    : Verkleinert das Ziel-Image bei Bedarf, sodass die kopierte Region in der unteren rechten Ecke liegt. Die Option ändert Breite/Höhe nicht, wenn der Benutzer **-width** bzw. **-height** ungleich null gesetzt hat.

    [-zoom]{.lit} [x]{.arg} [y]{.arg}
    : Vergrößert die Quellregion um Faktor *x* in X- und *y* in Y-Richtung. Fehlt *y*, entspricht es *x*. Jedes Quellpixel wird zu einem *x*×*y*-Block gleicher Farbe im Ziel. *x* und *y* müssen größer als 0 sein.

    [-subsample]{.lit} [x]{.arg} [y]{.arg}
    : Verkleinert die Quelle, indem nur jedes *x*. Pixel in X und jedes *y*. Pixel in Y verwendet wird. Negative Werte spiegeln um die Y- bzw. X-Achse. Fehlt *y*, entspricht es *x*.

    [-compositingrule]{.lit} [rule]{.arg}
    : Legt fest, wie transparente Quellpixel mit dem Ziel kombiniert werden. Bei *overlay* bleibt alter Zielinhalt sichtbar, als läge die Quelle auf transparentem Film über dem Ziel. Bei *set* wird alter Zielinhalt verworfen und die Quelle unverändert übernommen. Standard ist *overlay*.


[imageName]{.ins} [data]{.sub} [option value(s)]{.optdot}
: Gibt Bilddaten als Zeichenkette zurück. [Das Format hängt vom Format-Handler ab. Standard ist ein menschenlesbares Format als Liste von Listen von Pixeldaten; andere Formate können mit **-format** gewählt werden. Siehe [Bildformate] unten.]{version="9.0"} Mögliche Optionen:

    [-background]{.lit} [color]{.arg}
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    [-format]{.lit} [{format-name ?option value ...?}]{.arg}
    : Legt den Namen des Bilddateiformat-Handlers fest und optional Argumente dafür. Konkret sucht dieser Unterbefehl den ersten Handler, dessen Name mit einem Anfangs-Substring von *format-name* übereinstimmt und der einen String mit diesen Bilddaten schreiben kann. [Ohne diese Option wird das Standardformat verwendet: eine Liste (ein Element pro Zeile) von Listen (ein Element pro Pixel/Spalte) mit Farben im Format „**#***rrggbb*“ (siehe [Bildformate] unten).]{version="9.0"} Der Wert muss eine Tcl-Liste sein; bei einem Wort können geschweifte Klammern entfallen; Anführungszeichen sind möglich.

    [-from]{.lit} [x1]{.arg} [y1]{.arg} [x2]{.arg} [y2]{.arg}
    : Rechteckige Region von *imageName*, die zurückgegeben wird. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke. Alle vier Koordinaten: diagonal gegenüberliegende Ecken, einschließlich x1,y1, ausschließlich x2,y2. Standard: ganzes Bild.

    [-grayscale]{.lit}
    : Die Daten enthalten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.

    [-metadata]{.lit} [metadata]{.arg}
    : [Der Bildformat-Handler kann Metadaten in den zurückgegebenen Datenstring aufnehmen. Die angegebenen *metadata* werden an den Treiber übergeben. Ohne **-metadata** werden die aktuellen Metadaten des Images verwendet.]{version="9.0"}


[imageName]{.ins} [get]{.sub} [x]{.arg} [y]{.arg} [-withalpha]{.optlit}
: Gibt die Farbe des Pixels bei (*x*,*y*) als Liste von drei Ganzzahlen zwischen 0 und 255 für Rot, Grün und Blau zurück. Mit **-withalpha** enthält die Liste ein viertes Element: den Alpha-Wert des Pixels als Ganzzahl zwischen 0 und 255.

[imageName]{.ins} [put]{.sub} [data]{.arg} [option value(s)]{.optdot}
: Setzt Pixel in *imageName* auf die in *data* angegebenen Daten. [Der Befehl sucht einen Handler, der *data* interpretieren kann, und liest das kodierte Bild in *imageName* (Ziel-Image). Siehe [Bildformate] unten.]{version="9.0"} Mögliche Optionen:

    [-format]{.lit} [{format-name ?option value ..?}]{.arg}
    : Legt das Format der Bilddaten in *data* fest und optional Argumente für den Format-Handler. Es werden nur Handler verwendet, deren Name mit *format-name* beginnt. Der Wert muss eine Tcl-Liste sein; bei einem Wort können geschweifte Klammern entfallen; Anführungszeichen sind möglich.

    [-metadata]{.lit} [metadata]{.arg}
    : [Die angegebenen *metadata* werden an den Bildformat-Treiber beim Interpretieren der Daten übergeben. Die aktuellen Metadaten des Images werden nicht an den Treiber übergeben und durch den Befehl nicht geändert.]{version="9.0"}

    [-to]{.lit} [x1]{.arg} [y1]{.arg} [x2 y2]{.optarg}
    : Koordinaten der oberen linken Ecke (*x1*,*y1*) der Zielregion. Standard (0,0). Mit *x2*,*y2* und zu kleinen *data* wird gekachelt. Ist die mit dieser Option angegebene Region kleiner als *data*, werden überschüssige Daten still verworfen. Gibt *data* einen einzelnen Farbwert an, wird die Region bis (*x2*,*y2*) mit dieser Farbe gefüllt.


[imageName]{.ins} [read]{.sub} [filename]{.arg} [option value(s)]{.optdot}
: Liest Bilddaten aus der Datei *filename* ins Image. Zuerst wird ein passender Handler gesucht, dann wird das Bild in *imageName* gelesen. Mögliche Optionen:

    [-format]{.lit} [{format-name ?option value ..?}]{.arg}
    : Legt das Format der Bilddaten in *filename* fest und optional weitere Argumente für den Format-Handler. Es werden nur Handler verwendet, deren Name mit *format-name* beginnt. Der Wert muss eine Tcl-Liste sein; bei einem Wort können geschweifte Klammern entfallen; Anführungszeichen sind möglich.

    [-from]{.lit} [x1]{.arg} [y1]{.arg} [x2]{.arg} [y2]{.arg}
    : Rechteckige Teilregion der Dateidaten für das Ziel. Nur *x1* und *y1*: von (*x1,y1*) bis zur unteren rechten Ecke in der Datei. Alle vier Koordinaten: diagonal gegenüberliegende Ecken der Region. Standard: ganzes Bild in der Datei.

    [-metadata]{.lit} [metadata]{.arg}
    : [Die angegebenen *metadata* werden an den Bildformat-Treiber beim Interpretieren der Daten übergeben. Die aktuellen Metadaten des Images werden nicht an den Treiber übergeben und durch den Befehl nicht geändert.]{version="9.0"}

    [-shrink]{.lit}
    : Verkleinert *imageName* bei Bedarf, sodass die gelesene Region in der unteren rechten Ecke liegt. Breite/Höhe bleiben unverändert bei gesetztem **-width**/**-height** ungleich null.

    [-to]{.lit} [x]{.arg} [y]{.arg}
    : Koordinaten der oberen linken Ecke der Zielregion. Standard (0,0).


[imageName]{.ins} [redither]{.sub}
: Das beim Anzeigen von Foto-Images verwendete Dithering propagiert Quantisierungsfehler zu Nachbarpixeln. Werden die Bilddaten für *imageName* stückweise geliefert, kann das geditherte Bild abweichen. Normalerweise fällt das nicht auf; bei Bedarf berechnet dieser Befehl das geditherte Bild in jedem Fenster neu, in dem das Image angezeigt wird.

[imageName]{.ins} [transparency]{.sub} [subcommand]{.arg} [arg]{.optdot}
: Ermöglicht Abfrage und Änderung der Transparenzinformationen im Foto-Image. Verfügbare Unterbefehle:

    [imageName]{.ins} [transparency]{.sub} [get]{.lit} [x]{.arg} [y]{.arg} [-alpha]{.optlit}
    : [Gibt wahr zurück, wenn der Pixel bei (*x*,*y*) vollständig transparent ist, sonst falsch. Mit **-alpha** wird stattdessen der Alpha-Wert des Pixels als Ganzzahl zwischen 0 und 255 zurückgegeben.]{version="9.0"}

    [imageName]{.ins} [transparency]{.sub} [set]{.lit} [x]{.arg} [y]{.arg} [newVal]{.arg} [-alpha]{.optlit}
    : [Ändert die Transparenz des Pixels bei (*x*,*y*) auf *newVal*. Ohne weitere Option wird *newVal* als boolescher Wert interpretiert: voll transparent bei wahr, sonst voll opak. Mit **-alpha** wird *newVal* als ganzzahliger Alpha-Wert für den Pixel interpretiert (0 bis 255).]{version="9.0"}


[imageName]{.ins} [write]{.sub} [filename]{.arg} [option value(s)]{.optdot}
: Schreibt Bilddaten von *imageName* in die Datei *filename*. Folgende Optionen können angegeben werden:

    [-background]{.lit} [color]{.arg}
    : Ist die Farbe angegeben, enthalten die Daten keine Transparenzinformationen. In allen transparenten Pixeln wird die Farbe durch die angegebene Farbe ersetzt.

    [-format]{.lit} [{format-name ?option value ...?}]{.arg}
    : Legt den Namen des Bilddateiformat-Handlers fest, der die Daten in die Datei schreibt, und optional Argumente für den Handler. Konkret sucht dieser Unterbefehl den ersten Handler, dessen Name mit einem Anfangs-Substring von *format-name* übereinstimmt und der Bilddateien schreiben kann. Ohne diese Option wird das Format aus der Dateiendung erraten; wenn das nicht möglich ist, wird der erste schreibfähige Handler verwendet. Der Wert muss eine Tcl-Liste sein; bei einem Wort können geschweifte Klammern entfallen, Anführungszeichen sind möglich.

    [-from]{.lit} [x1]{.arg} [y1]{.arg} [x2]{.arg} [y2]{.arg}
    : Rechteckige Region von *imageName*, die in die Bilddatei geschrieben wird. Nur *x1* und *y1*: von *(x1,y1)* bis zur unteren rechten Ecke von *imageName*. Alle vier Koordinaten: diagonal gegenüberliegende Ecken. Standard: ganzes Bild.

    [-grayscale]{.lit}
    : Die Daten enthalten keine Farbinformation; alle Pixel werden in Graustufen umgewandelt.

    [-metadata]{.lit} [metadata]{.arg}
    : [Der Bildformat-Handler kann Metadaten in die geschriebene Datei aufnehmen. Die angegebenen *metadata* werden an den Treiber übergeben. Ohne **-metadata** werden die aktuellen Metadaten des Images verwendet.]{version="9.0"}



# Bildformate

Der Photo-Image-Code ist so strukturiert, dass Handler für weitere Bilddateiformate leicht ergänzt werden können. Der Photo-Image-Code verwaltet eine Liste dieser Handler. Handler werden der Liste durch Registrierung mit einem Aufruf von [Tk\_CreatePhotoImageFormat][CrtPhImgFmt] hinzugefügt. Die Standard-Tk-Distribution enthält Handler für PPM/PGM, PNG, GIF und (nur lesend) SVG, [sowie den Handler **default** zum Kodieren/Dekodieren von Bilddaten in menschenlesbarer Form.]{version="9.0"} Diese Handler werden bei der Initialisierung automatisch registriert.

Beim Lesen einer Bilddatei oder Verarbeiten von Stringdaten, die mit der Konfigurationsoption **-data** angegeben wurden, ruft der Photo-Image-Code Handler nacheinander auf, bis einer die Daten in der Datei oder Zeichenkette lesen kann. Meist findet das den richtigen Handler; andernfalls kann der Benutzer mit **-format** einen Formatnamen vorgeben. Dann werden Handler versucht, deren Name mit dem für **-format** angegebenen String beginnt (Groß-/Kleinschreibung irrelevant). Bei **-format gif** können z. B. Handler namens GIF87 oder GIF89 aufgerufen werden, JPEG nicht (sofern registriert).

Beim Schreiben von Bilddaten in eine Datei ist die Verarbeitung von **-format** etwas anders: Der Stringwert für **-format** muss mit dem vollständigen Namen des gewünschten Handlers beginnen und kann weitere Informationen enthalten, die der Handler nutzen kann, z. B. um eine Variante der vom Handler unterstützten Formate zu wählen. Nicht alle Bildhandler unterstützen das Schreiben von Transparenzdaten in eine Datei, auch wenn das Zielformat es theoretisch erlaubt.

## Standard-Bildhandler

Der Handler **default** kann keine Daten aus Dateien lesen oder in Dateien schreiben. Sein einziger Zweck ist die Kodierung und Dekodierung von Bilddaten in Stringform in klarer, menschenlesbarer Form. Der Unterbefehl *imageName* **data** nutzt diesen Handler, wenn kein anderes Format angegeben ist. Beim Lesen von Bilddaten aus einer Zeichenkette mit *imageName* **put** oder der Option **-data** wird der Standard-Handler wie die anderen Handler behandelt.

Bilddaten im **default**-Stringformat sind eine (von oben nach unten) Liste von Scanlines, wobei jede Scanline eine (von links nach rechts) Liste von Pixeldaten ist. Jede Scanline hat dieselbe Länge. Farbe und optional Alpha-Wert jedes Pixels werden in einer der im Abschnitt [Farbformate] unten beschriebenen Formen angegeben.

## Format-Unteroptionen

[Bildformate können Unteroptionen unterstützen, die über zusätzliche Wörter im Wert von **-format** angegeben werden. Diese Unteroptionen können beeinflussen, wie Bilddaten aus Datei oder String gelesen oder geschrieben werden. Art und Werte dieser Optionen liegen beim Format-Handler. Die eingebauten Handler unterstützen diese Unteroptionen:]{version="8.6"}

[default]{.cmd version="9.0"} [-colorformat]{.sub} [formatType]{.arg}
: [Die Option ist beim Schreiben von Bilddaten in einen String mit *imageName* **data** erlaubt. Legt das Format für die Farbzeichenkette jedes Pixels fest. *formatType* kann sein: **rgb** für Pixeldaten als **#***RRGGBB*, **rgba** als **#***RRGGBBAA* oder [list] als Liste mit vier Elementen. Details siehe [Farbformate] unten. Standard ist **rgb**.]{version="9.0"}

[gif]{.cmd} [-index]{.sub} [indexValue]{.arg}
: Die Option wirkt beim Lesen von Bilddaten aus einer Datei. Beim Parsen eines mehrteiligen GIF-Images greift Tk normalerweise nur auf das erste Bild zu. Mit der Unteroption **-index** kann stattdessen das *indexValue*. Bild verwendet werden. *indexValue* muss eine Ganzzahl von 0 bis zur Anzahl der Bildteile in den GIF-Daten sein.

[png]{.cmd} [-alpha]{.sub} [alphaValue]{.arg}
: Die Option wirkt beim Lesen von Bilddaten aus einer Datei. Legt einen zusätzlichen Alpha-Filter für das Gesamtbild fest, sodass der Hintergrund der Anzeige durchscheinen kann; das hat meist auch eine Entsättigung zur Folge. *alphaValue* muss zwischen 0,0 und 1,0 liegen.

[svg]{.cmd} [-dpi]{.sub} [dpiValue]{.arg} [-scale]{.lit} [scaleValue]{.arg} [-scaletowidth]{.lit} [width]{.arg} [-scaletoheight]{.lit} [height]{.arg}
: *dpiValue* wird bei der Umrechnung zwischen angegebenen Koordinaten und Bildschirmauflösung verwendet. Der Wert muss größer als 0 sein; Standard ist 96.

    *scaleValue* skaliert das resultierende Bild. Der Wert muss größer als 0 sein; Standard ist 1. *width* und *height* sind Breite bzw. Höhe, auf die das Bild angepasst wird. Nur einer der Parameter **-scale**, **-scaletowidth** und **-scaletoheight** darf angegeben werden; das Seitenverhältnis des Originalbilds bleibt erhalten. Das **svg**-Format unterstützt viele SVG-Funktionen, aber nicht den vollen SVG-Standard — z. B. fehlt die Funktion „text“, die beim Lesen der SVG-Daten still ignoriert wird. Unterstützte SVG-Funktionen sind:

    **elements:**
    : g, path, rect, circle, ellipse, line, polyline, polygon, linearGradient, radialGradient, stop, defs, svg, style

    **attributes:**
    : width, height, viewBox, preserveAspectRatio mit none, xMin, xMid, xMax, yMin, yMid, yMax, slice

    **gradient attributes:**
    : gradientUnits mit objectBoundingBox, gradientTransform, cx, cy, r fx, fy x1, y1, x2, y2 spreadMethod mit pad, reflect or repeat, xlink:href

    **poly attributes:**
    : points

    **line attributes:**
    : x1, y1, x2, y2

    **ellipse attributes:**
    : cx, cy, rx, ry

    **circle attributes:**
    : cx, cy, r

    **rectangle attributes:**
    : x, y, width, height, rx, ry

    **path attributes:**
    : d mit m, M, l, L, h, H, v, V, c, C, s, S, q, Q, t, T, a, A, z, Z

    **style attributes:**
    : display mit none, visibility, hidden, visible, fill mit nonzero and evenodd, opacity, fill-opacity, stroke, stroke-width, stroke-dasharray, stroke-dashoffset, stroke-opacity, stroke-linecap mit butt, round and square, stroke-linejoin mit miter, round and  bevel, stroke-miterlimit fill-rule, font-size, transform mit matrix, translate, scale, rotate, skewX and  skewY, stop-color, stop-opacity, offset, id, class


    Derzeit nur Lesen von SVG und Konvertierung in pixelbasierte Photos; Einbetten von Photos in SVG-Vektorgrafik wird (noch) nicht unterstützt.


# Farbformate

Der Standard-Bildhandler kann Farb- und Alpha-Werte eines Pixels in einem der unten aufgeführten Formate darstellen oder parsen. Enthält ein Farbformat keine Transparenzinformation, wird volle Deckkraft angenommen. Verfügbare Farbformate:

- Leerer String — wird als volle Transparenz interpretiert; der Farbwert ist undefiniert.

- Jeder von [Tk\_GetColor][GetColor] akzeptierte Wert, optional gefolgt von einem Alpha-Suffix. Das Alpha-Suffix kann eines von Folgendem sein:

    **@***A*
    : Der Alpha-Wert *A* muss ein Bruchteil im Bereich 0,0 (vollständig transparent) bis 1,0 (vollständig opak) sein.

    **#***X*
    : Der Alpha-Wert *X* ist eine Hexadezimalziffer, die einen ganzzahligen Alpha-Wert im Bereich 0 (vollständig transparent) bis 255 (vollständig opak) angibt. Der Wert wird von 4 Bit auf 8 Bit durch Multiplikation mit 0x11 erweitert.

    **#***XX*
    : Der Alpha-Wert *XX* wird als zwei Hexadezimalziffern übergeben, die einen ganzzahligen Alpha-Wert im Bereich 0 (vollständig transparent) bis 255 (vollständig opak) angeben.


- Eine Tcl-Liste mit drei oder vier Ganzzahlen im Bereich 0 bis 255 für die Kanäle Rot, Grün, Blau und (optional) Alpha.

- Format **#***RGBA*: ein **#** gefolgt von vier Hexadezimalziffern, wobei jede Ziffer den Wert für Rot, Grün, Blau und Alpha angibt. Jede Ziffer wird intern durch Multiplikation mit 0x11 auf 8 Bit erweitert.

- Format **#***RRGGBBAA*: **#** gefolgt von acht Hexadezimalziffern, wobei jedes Paar aufeinanderfolgender Ziffern den Wert für Rot, Grün, Blau und Alpha darstellt.


# Farbzuweisung

Wird ein Foto-Image in einem Fenster angezeigt, weist der Photo-Image-Code Farben zu und dithert das Bild bei Bedarf, um eine brauchbare Annäherung mit den verfügbaren Farben darzustellen. Die Farben werden als Farbwürfel zugewiesen: die Anzahl der zugewiesenen Farben ist das Produkt der Anzahl der Rot-, Grün- und Blautöne.

Normalerweise richtet sich die Anzahl der zugewiesenen Farben nach der Tiefe des Fensters. In einem 8-Bit-PseudoColor-Fenster versucht der Photo-Image-Code z. B., sieben Rottöne, sieben Grüntöne und vier Blautöne zuzuweisen (insgesamt 198 Farben). In einem 1-Bit-StaticGray-Fenster (Monochrom) werden zwei Farben, Schwarz und Weiß, zugewiesen. In einem 24-Bit-DirectColor- oder TrueColor-Fenster werden 256 Stufen je für Rot, Grün und Blau zugewiesen. Dank der Art, wie Pixelwerte in DirectColor- und TrueColor-Fenstern kombiniert werden können, reichen dafür 256 zugewiesene Farben. Können nicht alle Farben zugewiesen werden, reduziert der Photo-Image-Code die Anzahl der Stufen pro Grundfarbe und versucht es erneut.

Der Benutzer kann mit der Konfigurationsoption **-palette** steuern, wie viele Farben ein Foto-Image nutzt. Mit dieser Option wird die maximale Anzahl der Stufen pro Grundfarbe festgelegt, die zugewiesen werden sollen. Sie kann auch erzwingen, dass das Bild in Graustufen angezeigt wird, auch auf einem Farbdisplay, indem eine einzelne Zahl statt drei durch Schrägstriche getrennte Zahlen angegeben wird.

# Metadaten-Dictionary

Jedes Image hat eine Metadaten-Dictionary-Eigenschaft. Dieses Dictionary ist für die Bitmap-Darstellung des Images nicht relevant, kann aber zusätzliche Informationen wie Auflösung oder Kommentare enthalten. Bildformat-Treiber können beim Parsen von Bilddaten Metadaten ausgeben oder Metadaten zum Einbinden in Bilddateien oder -formate nutzen.

## Metadaten-Schlüssel (mehrere Formate)

Jeder Bildformat-Treiber unterstützt eine eigene Menge von Metadaten-Dictionary-Schlüsseln. Vordefinierte Schlüssel sind:

**DPI**
: Horizontale Bildauflösung in DPI als double-Wert. Unterstützt vom Format **png**.

**aspect**
: Seitenverhältnis horizontal geteilt durch vertikal als double-Wert. Unterstützt von den Formaten **gif** und **png**.

**comment**
: Textkommentar zum Bild. Unterstützt von den Formaten **gif** und **png**.


Es ist gültig, beliebige Schlüssel im Metadaten-Dict zu setzen. Ein Format-Treiber ignoriert Schlüssel, die er nicht verarbeitet.

## Metadaten-Schlüssel für animierte GIF-Informationen

Die folgenden Metadaten-Schlüssel werden beim Lesen einer **gif**-Formatdatei gemeldet. Sie werden typischerweise zusammen mit der Option **-index** einer animierten **gif**-Datei verwendet, um die Teilbildsequenz korrekt anzuzeigen. Die Optionen beziehen sich auf das jeweils mit **-index** gewählte Teilbild.

**delay time** *time*
: Aktualisierungsverzögerung in 10-ms-Einheiten. Dieser Schlüssel ist nur vorhanden, wenn die Verzögerung nicht 0 ist.

**disposal method** *method*
: Entsorgungsmethode des vorhergehenden Bildes, falls für das aktuelle Bild angegeben. Mögliche Werte: **do not dispose**, **restore to background color**, **restore to previous**.

**user interaction** *bool*
: Der Schlüssel ist mit dem Wert 1 vorhanden, wenn Benutzerinteraktion vorgesehen ist. Andernfalls fehlt der Schlüssel.

**update region** *X0*, *Y0*, *width*, *height*
: Aktualisierungsregion des aktuellen Teilbilds, wenn das Teilbild nicht dieselbe Größe wie das vollständige Bild hat. Pixel außerhalb dieses Bereichs sind vollständig transparent.


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

[Grüne Box mit einfachem Schatten]{version="9.0"}

```
image create photo foo

# Einfache Verlaufsfüllung mit variierendem Alpha für den Schatten
for {set i 14} {$i > 0} {incr i -1} {
   set i2 [expr {$i + 30}]
   foo put [format black#%x [expr {15-$i}]] -to $i $i $i2 $i2
}

# Solides grünes Rechteck darüberlegen
foo put #F080 -to 0 0 30 30
```


[ConfigWidg]: ../tk-c/ConfigWidg.md
[CrtPhImgFmt]: ../tk-c/CrtPhImgFmt.md
[GetColor]: ../tk-c/GetColor.md
[image]: image.md
[list]: ../tcl/list.md
