---
CommandName: canvas::sqmap
ManualSection: n
Version: 0.3.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - cell
 - grid
 - image
 - map
 - square map
 - tile
Copyright:
---

# NAME

canvas::sqmap – Canvas mit Kartenhintergrund aus quadratischen Kacheln

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [uevent::onidle]{.lit} 
[package]{.cmd} [require]{.sub} [cache::async]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::sqmap]{.lit} [0.3.1]{.optlit} 
[::canvas::sqmap]{.cmd} [pathName]{.arg} [options]{.optarg} 
[canvasName]{.ins} [image]{.sub} [set]{.lit} [cell]{.arg} [image]{.arg} 
[canvasName]{.ins} [image]{.sub} [unset]{.lit} [cell]{.arg} 
[canvasName]{.ins} [flush]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket stellt ein erweitertes Canvas-Widget für die Darstellung von Karten bereit, das auf einer Reihe quadratischer Bildkacheln basiert. Die Kacheln bilden den Hintergrund des Canvases, wobei alle anderen Canvas-Elemente stets vor ihnen angezeigt werden. Die Anzahl der angezeigten Kacheln, die Kachelgröße sowie die Quelle der anzuzeigenden Bilder sind konfigurierbar.

# API

**::canvas::sqmap** *pathName* ?options?
: Erstellt den Canvas *pathName* und konfiguriert ihn. Das neue Widget unterstützt alle Optionen und Methoden eines regulären Canvas sowie die im Folgenden beschriebenen Optionen und Methoden. Das Ergebnis des Befehls ist *pathName*.


## Optionen

**-grid-cell-width**
: Der Wert für diese Option ist eine nicht-negative ganze Zahl. Er legt die Breite der Zellen fest, aus denen sich der Hintergrund zusammensetzt.

**-grid-cell-height**
: Der Wert für diese Option ist eine nicht-negative ganze Zahl. Er legt die Höhe der Zellen fest, aus denen sich der Hintergrund zusammensetzt.

**-grid-cell-command**
: Der Wert für diese Option ist ein Befehlspräfix. Er wird immer dann aufgerufen, wenn der Canvas das Bild für eine bestimmte Zelle des Hintergrunds benötigt, und zwar mit zwei zusätzlichen Argumenten: der ID der Zelle und einem Befehlspräfix, das aufgerufen werden soll, sobald das Bild bereitsteht oder feststeht, dass es nicht vorhanden ist. Die ID der Zelle ist eine Liste mit zwei Elementen, die die Zeilen- und Spaltennummer der Zelle in dieser Reihenfolge enthält. Das resultierende Befehlspräfix (im folgenden Beispiel „\$result“ genannt) muss entweder mit zwei oder drei Argumenten aufgerufen werden, d. h.


```
    $result set   $cellid $image ; # image is known and ready
    $result unset $cellid        ; # image does not exist
```

: Diese Option kann undefiniert bleiben, d. h., der Canvas kann auch ohne sie funktionieren. In diesem Fall werden in den Rasterzellen nur jene Bilder angezeigt, die explizit mit der Methode **image set** festgelegt wurden; siehe den nächsten Abschnitt. Alle anderen Rasterzellen bleiben einfach leer.


**-viewport-command**
: Diese Option legt ein Befehlspräfix fest, das wenn der Ansichtsbereich des canvases geändert wird, aufgerufen wird, damit Benutzer jederzeit den Überblick darüber behalten können, an welcher Stelle im Bildlaufbereich sie sich gerade befinden. Dies kann beispielsweise dazu verwendet werden, abgeleitete Anzeigen zu steuern oder Elemente im Blickfeld zu halten, indem sie entsprechend der Bewegung des Ansichtsbereichs verschoben werden.

**-image-on-load**
: Der Wert für diese Option ist ein Bild. Wird dieses Bild angegeben, wird es in einer Zelle angezeigt, während das eigentliche Bild für diese Zelle über die durch **-grid-cell-command** festgelegte Rückruffunktion geladen wird.

**-image-on-unset**
: Der Wert für diese Option ist ein Bild. Wenn angegeben, wird das Bild in einer Zelle angezeigt, für die die durch **-grid-cell-command** angegebene Rückruffunktion gemeldet hat, dass kein tatsächliches Bild zur Anzeige vorhanden ist.


## Methoden

*canvasName* **image set** *cell* *image*
: Durch den Aufruf dieser Methode wird das *image* in die angegebene *cell* des Hintergrunds eingefügt. Die Zelle wird als Liste mit zwei Elementen angegeben, die in dieser Reihenfolge die Zeilen- und Spaltennummer enthält. Hinweis: Ein Bild kann mehreren Zellen des Canvases zugeordnet und in diesen angezeigt werden.

*canvasName* **image unset** *cell*
: Durch den Aufruf dieser Methode wird die angegebene *cell* des Hintergrunds als leer deklariert; ein in dieser Zelle angezeigtes Bild wird dabei verworfen. Die Zelle wird als Liste mit zwei Elementen angegeben, die in dieser Reihenfolge die Zeilen- und Spaltennummer enthält.

*canvasName* **flush**
: Durch den Aufruf dieser Methode wird das Canvas dazu gezwungen, die Bilder für alle Zellen vollständig neu zu laden. Verwenden Sie diese Methode nicht, wenn der Canvas ohne **-grid-cell-command** betrieben wird, da das Canvas in diesem Fall einfach alle Bilder vergisst, ohne sie neu laden zu können.


# BESITZ DER BILDER

Beachten Sie, dass das Canvas *keinen* Besitzanspruch auf die Bilder erhebt, die es im Hintergrund anzeigt. Mit anderen Worten: Wenn wir sagen, dass der Canvas ein Bild „vergisst“, bedeutet dies lediglich, dass die Zuordnung zwischen einer Rasterzelle und dem angezeigten Bild aufgehoben wird. Das Bild wird *nicht* gelöscht. Die Verwaltung des Lebenszyklus der vom Canvas angezeigten Bilder liegt in der Verantwortung des Canvas-Nutzers.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
