---
CommandName: winfo
title: winfo
ManualSection: n
Version: 4.3
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - atom
 - children
 - class
 - geometry
 - height
 - identifier
 - information
 - interpreters
 - mapped
 - parent
 - path name
 - screen
 - virtual root
 - width
 - window
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

winfo - Gibt fensterbezogene Informationen zurück

# Übersicht

::: {.synopsis} :::
[winfo]{.cmd} [option]{.arg} [arg]{.optdot}
:::

# Beschreibung

Der Befehl **winfo** dient dazu, Informationen über von Tk verwaltete Fenster abzurufen. Je nach dem Argument *option* kann er in vielen verschiedenen Formen aufgerufen werden. Die zulässigen Formen sind:

[winfo]{.cmd} [atom]{.sub} [[-displayof]{.lit} [window]{.arg}]{.optarg} [name]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die den ganzzahligen Bezeichner für das Atom mit dem Namen *name* angibt. Existiert kein Atom mit dem Namen *name*, wird ein neues erzeugt. Ist die Option **-displayof** angegeben, wird das Atom auf dem Display von *window* nachgeschlagen; andernfalls auf dem Display des Hauptfensters der Anwendung.

[winfo]{.cmd} [atomname]{.sub} [[-displayof]{.lit} [window]{.arg}]{.optarg} [id]{.arg}
: Gibt den Textnamen für das Atom mit dem ganzzahligen Bezeichner *id* zurück. Ist die Option **-displayof** angegeben, wird der Bezeichner auf dem Display von *window* nachgeschlagen; andernfalls auf dem Display des Hauptfensters der Anwendung. Dieser Befehl ist die Umkehrung von **winfo atom**. Er erzeugt einen Fehler, wenn kein solches Atom existiert.

[winfo]{.cmd} [cells]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Anzahl der Zellen in der Farbtabelle für *window* angibt.

[winfo]{.cmd} [children]{.sub} [window]{.arg}
: Gibt eine Liste zurück, die die Pfadnamen aller Kinder von *window* enthält. Toplevel-Fenster werden als Kinder ihrer logischen Eltern zurückgegeben. Die Liste ist in Stapelreihenfolge angeordnet, mit dem untersten Fenster zuerst, außer bei Toplevel-Fenstern, die nicht in Stapelreihenfolge zurückgegeben werden. Verwenden Sie den Befehl [wm stackorder][wm], um die Stapelreihenfolge von Toplevel-Fenstern abzufragen.

[winfo]{.cmd} [class]{.sub} [window]{.arg}
: Gibt den Klassennamen für *window* zurück.

[winfo]{.cmd} [colormapfull]{.sub} [window]{.arg}
: Gibt 1 zurück, wenn die Farbtabelle für *window* als voll bekannt ist, andernfalls 0. Die Farbtabelle eines Fensters gilt als „voll bekannt“, wenn der letzte Versuch, auf diesem Fenster eine neue Farbe zu allozieren, fehlgeschlagen ist und diese Anwendung seit der fehlgeschlagenen Allozierung keine Farben in der Farbtabelle freigegeben hat.

[winfo]{.cmd} [containing]{.sub} [[-displayof]{.lit} [window]{.arg}]{.optarg} [rootX]{.arg} [rootY]{.arg}
: Gibt den Pfadnamen des Fensters zurück, das den durch *rootX* und *rootY* gegebenen Punkt enthält. *RootX* und *rootY* sind in Bildschirmeinheiten angegeben (d. h. in jeder für [Tk\_GetPixels][GetPixels] zulässigen Form) im Koordinatensystem des Root-Fensters (bei Verwendung eines Virtual-Root-Window-Managers wird das Koordinatensystem des virtuellen Root-Fensters verwendet). Ist die Option **-displayof** angegeben, beziehen sich die Koordinaten auf den Bildschirm, der *window* enthält; andernfalls auf den Bildschirm des Hauptfensters der Anwendung. Enthält kein Fenster in dieser Anwendung den Punkt, wird ein leerer String zurückgegeben. Ein leerer String wird auch zurückgegeben, wenn der Punkt in der Titelleiste oder im Rahmen des höchsten enthaltenden Toplevel in dieser Anwendung liegt. (Beachten Sie, dass bei manchen Window-Managern die Rahmen unsichtbar sein können.) Bei der Auswahl des enthaltenden Fensters haben Kinder höhere Priorität als Eltern, und unter Geschwistern wird das höchste in der Stapelreihenfolge gewählt.

[winfo]{.cmd} [depth]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Tiefe von *window* angibt (Anzahl der Bits pro Pixel).

[winfo]{.cmd} [exists]{.sub} [window]{.arg}
: Gibt 1 zurück, wenn ein Fenster mit dem Namen *window* existiert, 0 wenn kein solches Fenster existiert.

[winfo]{.cmd} [fpixels]{.sub} [window]{.arg} [number]{.arg}
: Gibt einen Gleitkommawert zurück, der die Anzahl der Pixel in *window* angibt, die der durch *number* gegebenen Entfernung entsprechen. *Number* kann in jeder für [Tk\_GetScreenMM][GetPixels] zulässigen Form angegeben werden, z. B. „2.0c“ oder „1i“. Der Rückgabewert kann gebrochen sein; für einen ganzzahligen Wert verwenden Sie **winfo pixels**.

[winfo]{.cmd} [geometry]{.sub} [window]{.arg}
: Gibt die Geometrie für *window* in der Form *width***x***height***+***x***+***y* zurück. Alle Abmessungen sind in Pixeln.

[winfo]{.cmd} [height]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Höhe von *window* in Pixeln angibt. Wenn ein Fenster neu erzeugt wird, beträgt seine Höhe zunächst 1 Pixel; die Höhe wird später vom Geometrie-Manager geändert, um den Anforderungen des Fensters zu genügen. Benötigen Sie die tatsächliche Höhe unmittelbar nach dem Erzeugen eines Widgets, rufen Sie [update] auf, um den Geometrie-Manager zur Anordnung zu zwingen, oder verwenden Sie **winfo reqheight**, um die angeforderte statt der tatsächlichen Höhe des Fensters zu erhalten.

[winfo]{.cmd} [id]{.sub} [window]{.arg}
: Gibt eine hexadezimale Zeichenkette zurück, die einen plattformspezifischen Bezeichner auf niedriger Ebene für *window* angibt. Auf Unix-Plattformen ist dies der X-Fensterbezeichner. Unter Windows ist dies die Windows-HWND. Auf dem Macintosh hat der Wert außerhalb von Tk keine Bedeutung.

[winfo]{.cmd} [interps]{.sub} [[-displayof]{.lit} [window]{.arg}]{.optarg}
: Gibt eine Liste zurück, deren Elemente die Namen aller Tcl-Interpreter (z. B. aller Tk-basierten Anwendungen) sind, die derzeit für ein bestimmtes Display registriert sind. Ist die Option **-displayof** angegeben, bezieht sich der Rückgabewert auf das Display von *window*; andernfalls auf das Display des Hauptfensters der Anwendung.

[winfo]{.cmd} [ismapped]{.sub} [window]{.arg}
: Gibt **1** zurück, wenn *window* derzeit gemappt ist, andernfalls **0**.

[winfo]{.cmd} [manager]{.sub} [window]{.arg}
: Gibt den Namen des Geometrie-Managers zurück, der derzeit für *window* verantwortlich ist, oder einen leeren String, wenn *window* von keinem Geometrie-Manager verwaltet wird. Der Name ist in der Regel der Name des Tcl-Befehls für den Geometrie-Manager, z. B. [pack] oder [place]. Ist der Geometrie-Manager ein Widget, z. B. Canvas oder Text, ist der Name der Klassenbefehl des Widgets, z. B. [canvas].

[winfo]{.cmd} [name]{.sub} [window]{.arg}
: Gibt den Namen von *window* zurück (d. h. seinen Namen innerhalb des Eltern-Widgets, im Gegensatz zum vollständigen Pfadnamen). Der Befehl **winfo name .** gibt den Namen der Anwendung zurück.

[winfo]{.cmd} [parent]{.sub} [window]{.arg}
: Gibt den Pfadnamen des Eltern-Widgets von *window* zurück oder einen leeren String, wenn *window* das Hauptfenster der Anwendung ist.

[winfo]{.cmd} [pathname]{.sub} [[-displayof]{.lit} [window]{.arg}]{.optarg} [id]{.arg}
: Gibt den Pfadnamen des Fensters zurück, dessen X-Bezeichner *id* ist. *Id* muss eine Dezimal-, Hexadezimal- oder Oktalzahl sein und einem Fenster in der aufrufenden Anwendung entsprechen. Ist die Option **-displayof** angegeben, wird der Bezeichner auf dem Display von *window* nachgeschlagen; andernfalls auf dem Display des Hauptfensters der Anwendung.

[winfo]{.cmd} [pixels]{.sub} [window]{.arg} [number]{.arg}
: Gibt die Anzahl der Pixel in *window* zurück, die der durch *number* gegebenen Entfernung entsprechen. *Number* kann in jeder für [Tk\_GetPixels][GetPixels] zulässigen Form angegeben werden, z. B. „2.0c“ oder „1i“. Das Ergebnis wird auf den nächsten ganzzahligen Wert gerundet; für ein gebrochenes Ergebnis verwenden Sie **winfo fpixels**.

[winfo]{.cmd} [pointerx]{.sub} [window]{.arg}
: Befindet sich der Mauszeiger auf demselben Bildschirm wie *window*, gibt er die x-Koordinate des Zeigers zurück, gemessen in Pixeln im Root-Fenster des Bildschirms. Ist auf dem Bildschirm ein virtuelles Root-Fenster in Verwendung, wird die Position im virtuellen Root gemessen. Befindet sich der Mauszeiger nicht auf demselben Bildschirm wie *window*, wird -1 zurückgegeben.

[winfo]{.cmd} [pointerxy]{.sub} [window]{.arg}
: Befindet sich der Mauszeiger auf demselben Bildschirm wie *window*, gibt er eine Liste mit zwei Elementen zurück: die x- und y-Koordinaten des Zeigers, gemessen in Pixeln im Root-Fenster des Bildschirms. Ist auf dem Bildschirm ein virtuelles Root-Fenster in Verwendung, wird die Position im virtuellen Root berechnet. Befindet sich der Mauszeiger nicht auf demselben Bildschirm wie *window*, sind beide zurückgegebenen Koordinaten -1.

[winfo]{.cmd} [pointery]{.sub} [window]{.arg}
: Befindet sich der Mauszeiger auf demselben Bildschirm wie *window*, gibt er die y-Koordinate des Zeigers zurück, gemessen in Pixeln im Root-Fenster des Bildschirms. Ist auf dem Bildschirm ein virtuelles Root-Fenster in Verwendung, wird die Position im virtuellen Root berechnet. Befindet sich der Mauszeiger nicht auf demselben Bildschirm wie *window*, wird -1 zurückgegeben.

[winfo]{.cmd} [reqheight]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die angeforderte Höhe von *window* in Pixeln angibt. Dies ist der Wert, den der Geometrie-Manager von *window* zur Berechnung der Geometrie verwendet.

[winfo]{.cmd} [reqwidth]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die angeforderte Breite von *window* in Pixeln angibt. Dies ist der Wert, den der Geometrie-Manager von *window* zur Berechnung der Geometrie verwendet.

[winfo]{.cmd} [rgb]{.sub} [window]{.arg} [color]{.arg}
: Gibt eine Liste mit drei Dezimalwerten im Bereich 0 bis 65535 zurück, die die Rot-, Grün- und Blau-Intensitäten darstellen, die *color* im durch *window* gegebenen Fenster entsprechen. *Color* kann in jeder für eine Farboption zulässigen Form angegeben werden.

[winfo]{.cmd} [rootx]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die x-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Root-Fenster des Bildschirms angibt.

[winfo]{.cmd} [rooty]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die y-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Root-Fenster des Bildschirms angibt.

[winfo]{.cmd} [screen]{.sub} [window]{.arg}
: Gibt den Namen des mit *window* verknüpften Bildschirms in der Form *displayName*.*screenIndex* zurück.

[winfo]{.cmd} [screencells]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Anzahl der Zellen in der Standard-Farbtabelle für den Bildschirm von *window* angibt.

[winfo]{.cmd} [screendepth]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Tiefe des Root-Fensters des Bildschirms von *window* angibt (Anzahl der Bits pro Pixel).

[winfo]{.cmd} [screenheight]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Höhe des Bildschirms von *window* in Pixeln angibt.

[winfo]{.cmd} [screenmmheight]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Höhe des Bildschirms von *window* in Millimetern angibt.

[winfo]{.cmd} [screenmmwidth]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Breite des Bildschirms von *window* in Millimetern angibt.

[winfo]{.cmd} [screenvisual]{.sub} [window]{.arg}
: Gibt eine der folgenden Zeichenketten zurück, um die Standard-Visualklasse für den Bildschirm von *window* anzugeben: **directcolor**, **grayscale**, **pseudocolor**, **staticcolor**, **staticgray** oder **truecolor**.

[winfo]{.cmd} [screenwidth]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Breite des Bildschirms von *window* in Pixeln angibt.

[winfo]{.cmd} [server]{.sub} [window]{.arg}
: Gibt eine Zeichenkette zurück, die Informationen über den Server für das Display von *window* enthält. Das genaue Format dieser Zeichenkette kann von Plattform zu Plattform variieren. Bei X-Servern hat die Zeichenkette die Form „**X***major***R***minor vendor vendorVersion*“, wobei *major* und *minor* die vom Server bereitgestellten Versions- und Revisionsnummern sind (z. B. **X11R5**), *vendor* der Name des Server-Herstellers ist und *vendorRelease* eine vom Server bereitgestellte ganzzahlige Release-Nummer ist.

[winfo]{.cmd} [toplevel]{.sub} [window]{.arg}
: Gibt den Pfadnamen des Fensters an der Spitze der Hierarchie zurück, das *window* enthält. In Standard-Tk ist dies stets ein [toplevel]-Widget, Erweiterungen können jedoch andere Arten von Hierarchie-Spitzen-Widgets erzeugen.

[winfo]{.cmd} [viewable]{.sub} [window]{.arg}
: Gibt 1 zurück, wenn *window* und alle seine Vorfahren bis zum nächsten Toplevel-Fenster gemappt sind. Gibt 0 zurück, wenn eines dieser Fenster nicht gemappt ist.

[winfo]{.cmd} [visual]{.sub} [window]{.arg}
: Gibt eine der folgenden Zeichenketten zurück, um die Visualklasse für *window* anzugeben: **directcolor**, **grayscale**, **pseudocolor**, **staticcolor**, **staticgray** oder **truecolor**.

[winfo]{.cmd} [visualid]{.sub} [window]{.arg}
: Gibt den X-Bezeichner für das Visual von *window* zurück.

[winfo]{.cmd} [visualsavailable]{.sub} [window]{.arg} [includeids]{.optlit}
: Gibt eine Liste zurück, deren Elemente die für den Bildschirm von *window* verfügbaren Visuals beschreiben. Jedes Element besteht aus einer Visualklasse gefolgt von einer ganzzahligen Tiefe. Die Klasse hat dieselbe Form wie der Rückgabewert von **winfo visual**. Die Tiefe gibt die Anzahl der Bits pro Pixel im Visual an. Wird zusätzlich das Argument **includeids** angegeben, folgt auf die Tiefe der X-Bezeichner für das Visual.

[winfo]{.cmd} [vrootheight]{.sub} [window]{.arg}
: Gibt die Höhe des mit *window* verknüpften virtuellen Root-Fensters zurück, falls eines vorhanden ist; andernfalls die Höhe des Bildschirms von *window*.

[winfo]{.cmd} [vrootwidth]{.sub} [window]{.arg}
: Gibt die Breite des mit *window* verknüpften virtuellen Root-Fensters zurück, falls eines vorhanden ist; andernfalls die Breite des Bildschirms von *window*.

[winfo]{.cmd} [vrootx]{.sub} [window]{.arg}
: Gibt den x-Versatz des mit *window* verknüpften virtuellen Root-Fensters relativ zum Root-Fenster seines Bildschirms zurück. Dies ist normalerweise null oder negativ. Gibt 0 zurück, wenn es kein virtuelles Root-Fenster für *window* gibt.

[winfo]{.cmd} [vrooty]{.sub} [window]{.arg}
: Gibt den y-Versatz des mit *window* verknüpften virtuellen Root-Fensters relativ zum Root-Fenster seines Bildschirms zurück. Dies ist normalerweise null oder negativ. Gibt 0 zurück, wenn es kein virtuelles Root-Fenster für *window* gibt.

[winfo]{.cmd} [width]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die Breite von *window* in Pixeln angibt. Wenn ein Fenster neu erzeugt wird, beträgt seine Breite zunächst 1 Pixel; die Breite wird später vom Geometrie-Manager geändert, um den Anforderungen des Fensters zu genügen. Benötigen Sie die tatsächliche Breite unmittelbar nach dem Erzeugen eines Widgets, rufen Sie [update] auf, um den Geometrie-Manager zur Anordnung zu zwingen, oder verwenden Sie **winfo reqwidth**, um die angeforderte statt der tatsächlichen Breite des Fensters zu erhalten.

[winfo]{.cmd} [x]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die x-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Eltern-Widget von *window* angibt.

[winfo]{.cmd} [y]{.sub} [window]{.arg}
: Gibt eine Dezimalzeichenkette zurück, die die y-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Eltern-Widget von *window* angibt.


# Beispiele

Ausgabe der Position des Mauszeigers und des Fensters, über dem er sich befindet:

```
lassign [winfo pointerxy .] x y
puts -nonewline "Mouse pointer at ($x,$y) which is "
set win [winfo containing $x $y]
if {$win eq ""} {
    puts "over no window"
} else {
    puts "over $win"
}
```


[canvas]: canvas.md
[GetPixels]: ../tk-c/GetPixels.md
[pack]: pack.md
[place]: place.md
[toplevel]: toplevel.md
[update]: ../tcl/update.md
[wm]: wm.md
