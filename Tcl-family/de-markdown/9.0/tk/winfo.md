---
CommandName: winfo
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

# NAME

winfo - Gibt fensterbezogene Informationen zurück

# ÜBERSICHT

::: {.synopsis} :::
[winfo]{.cmd} [option]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **winfo** dient dazu, Informationen über von Tk verwaltete Fenster abzurufen. Je nach dem Argument *option* kann er in vielen verschiedenen Formen aufgerufen werden. Die zulässigen Formen sind:

**winfo atom** ?**-displayof** *window*? *name*
: Gibt eine Dezimalzeichenkette zurück, die den ganzzahligen Bezeichner für das Atom mit dem Namen *name* angibt. Existiert kein Atom mit dem Namen *name*, wird ein neues erzeugt. Ist die Option **-displayof** angegeben, wird das Atom auf dem Display von *window* nachgeschlagen; andernfalls auf dem Display des Hauptfensters der Anwendung.

**winfo atomname** ?**-displayof** *window*? *id*
: Gibt den Textnamen für das Atom mit dem ganzzahligen Bezeichner *id* zurück. Ist die Option **-displayof** angegeben, wird der Bezeichner auf dem Display von *window* nachgeschlagen; andernfalls auf dem Display des Hauptfensters der Anwendung. Dieser Befehl ist die Umkehrung von **winfo atom**. Er erzeugt einen Fehler, wenn kein solches Atom existiert.

**winfo cells** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Anzahl der Zellen in der Farbtabelle für *window* angibt.

**winfo children** *window*
: Gibt eine Liste zurück, die die Pfadnamen aller Kinder von *window* enthält. Toplevel-Fenster werden als Kinder ihrer logischen Eltern zurückgegeben. Die Liste ist in Stapelreihenfolge angeordnet, mit dem untersten Fenster zuerst, außer bei Toplevel-Fenstern, die nicht in Stapelreihenfolge zurückgegeben werden. Verwenden Sie den Befehl **wm stackorder**, um die Stapelreihenfolge von Toplevel-Fenstern abzufragen.

**winfo class** *window*
: Gibt den Klassennamen für *window* zurück.

**winfo colormapfull** *window*
: Gibt 1 zurück, wenn die Farbtabelle für *window* als voll bekannt ist, andernfalls 0. Die Farbtabelle eines Fensters gilt als „voll bekannt“, wenn der letzte Versuch, auf diesem Fenster eine neue Farbe zu allozieren, fehlgeschlagen ist und diese Anwendung seit der fehlgeschlagenen Allozierung keine Farben in der Farbtabelle freigegeben hat.

**winfo containing** ?**-displayof** *window*? *rootX rootY*
: Gibt den Pfadnamen des Fensters zurück, das den durch *rootX* und *rootY* gegebenen Punkt enthält. *RootX* und *rootY* sind in Bildschirmeinheiten angegeben (d. h. in jeder für **Tk_GetPixels** zulässigen Form) im Koordinatensystem des Root-Fensters (bei Verwendung eines Virtual-Root-Window-Managers wird das Koordinatensystem des virtuellen Root-Fensters verwendet). Ist die Option **-displayof** angegeben, beziehen sich die Koordinaten auf den Bildschirm, der *window* enthält; andernfalls auf den Bildschirm des Hauptfensters der Anwendung. Enthält kein Fenster in dieser Anwendung den Punkt, wird ein leerer String zurückgegeben. Ein leerer String wird auch zurückgegeben, wenn der Punkt in der Titelleiste oder im Rahmen des höchsten enthaltenden Toplevel in dieser Anwendung liegt. (Beachten Sie, dass bei manchen Window-Managern die Rahmen unsichtbar sein können.) Bei der Auswahl des enthaltenden Fensters haben Kinder höhere Priorität als Eltern, und unter Geschwistern wird das höchste in der Stapelreihenfolge gewählt.

**winfo depth** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Tiefe von *window* angibt (Anzahl der Bits pro Pixel).

**winfo exists** *window*
: Gibt 1 zurück, wenn ein Fenster mit dem Namen *window* existiert, 0 wenn kein solches Fenster existiert.

**winfo fpixels** *window number*
: Gibt einen Gleitkommawert zurück, der die Anzahl der Pixel in *window* angibt, die der durch *number* gegebenen Entfernung entsprechen. *Number* kann in jeder für **Tk_GetScreenMM** zulässigen Form angegeben werden, z. B. „2.0c“ oder „1i“. Der Rückgabewert kann gebrochen sein; für einen ganzzahligen Wert verwenden Sie **winfo pixels**.

**winfo geometry** *window*
: Gibt die Geometrie für *window* in der Form *width*__x__*height*__+__*x*__+__*y* zurück. Alle Abmessungen sind in Pixeln.

**winfo height** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Höhe von *window* in Pixeln angibt. Wenn ein Fenster neu erzeugt wird, beträgt seine Höhe zunächst 1 Pixel; die Höhe wird später vom Geometrie-Manager geändert, um den Anforderungen des Fensters zu genügen. Benötigen Sie die tatsächliche Höhe unmittelbar nach dem Erzeugen eines Widgets, rufen Sie **update** auf, um den Geometrie-Manager zur Anordnung zu zwingen, oder verwenden Sie **winfo reqheight**, um die angeforderte statt der tatsächlichen Höhe des Fensters zu erhalten.

**winfo id** *window*
: Gibt eine hexadezimale Zeichenkette zurück, die einen plattformspezifischen Bezeichner auf niedriger Ebene für *window* angibt. Auf Unix-Plattformen ist dies der X-Fensterbezeichner. Unter Windows ist dies die Windows-HWND. Auf dem Macintosh hat der Wert außerhalb von Tk keine Bedeutung.

**winfo interps** ?**-displayof** *window*?
: Gibt eine Liste zurück, deren Elemente die Namen aller Tcl-Interpreter (z. B. aller Tk-basierten Anwendungen) sind, die derzeit für ein bestimmtes Display registriert sind. Ist die Option **-displayof** angegeben, bezieht sich der Rückgabewert auf das Display von *window*; andernfalls auf das Display des Hauptfensters der Anwendung.

**winfo ismapped** *window*
: Gibt **1** zurück, wenn *window* derzeit gemappt ist, andernfalls **0**.

**winfo manager** *window*
: Gibt den Namen des Geometrie-Managers zurück, der derzeit für *window* verantwortlich ist, oder einen leeren String, wenn *window* von keinem Geometrie-Manager verwaltet wird. Der Name ist in der Regel der Name des Tcl-Befehls für den Geometrie-Manager, z. B. **pack** oder **place**. Ist der Geometrie-Manager ein Widget, z. B. Canvas oder Text, ist der Name der Klassenbefehl des Widgets, z. B. **canvas**.

**winfo name** *window*
: Gibt den Namen von *window* zurück (d. h. seinen Namen innerhalb des Eltern-Widgets, im Gegensatz zum vollständigen Pfadnamen). Der Befehl **winfo name .** gibt den Namen der Anwendung zurück.

**winfo parent** *window*
: Gibt den Pfadnamen des Eltern-Widgets von *window* zurück oder einen leeren String, wenn *window* das Hauptfenster der Anwendung ist.

**winfo pathname** ?**-displayof** *window*? *id*
: Gibt den Pfadnamen des Fensters zurück, dessen X-Bezeichner *id* ist. *Id* muss eine Dezimal-, Hexadezimal- oder Oktalzahl sein und einem Fenster in der aufrufenden Anwendung entsprechen. Ist die Option **-displayof** angegeben, wird der Bezeichner auf dem Display von *window* nachgeschlagen; andernfalls auf dem Display des Hauptfensters der Anwendung.

**winfo pixels** *window number*
: Gibt die Anzahl der Pixel in *window* zurück, die der durch *number* gegebenen Entfernung entsprechen. *Number* kann in jeder für **Tk_GetPixels** zulässigen Form angegeben werden, z. B. „2.0c“ oder „1i“. Das Ergebnis wird auf den nächsten ganzzahligen Wert gerundet; für ein gebrochenes Ergebnis verwenden Sie **winfo fpixels**.

**winfo pointerx** *window*
: Befindet sich der Mauszeiger auf demselben Bildschirm wie *window*, gibt er die x-Koordinate des Zeigers zurück, gemessen in Pixeln im Root-Fenster des Bildschirms. Ist auf dem Bildschirm ein virtuelles Root-Fenster in Verwendung, wird die Position im virtuellen Root gemessen. Befindet sich der Mauszeiger nicht auf demselben Bildschirm wie *window*, wird -1 zurückgegeben.

**winfo pointerxy** *window*
: Befindet sich der Mauszeiger auf demselben Bildschirm wie *window*, gibt er eine Liste mit zwei Elementen zurück: die x- und y-Koordinaten des Zeigers, gemessen in Pixeln im Root-Fenster des Bildschirms. Ist auf dem Bildschirm ein virtuelles Root-Fenster in Verwendung, wird die Position im virtuellen Root berechnet. Befindet sich der Mauszeiger nicht auf demselben Bildschirm wie *window*, sind beide zurückgegebenen Koordinaten -1.

**winfo pointery** *window*
: Befindet sich der Mauszeiger auf demselben Bildschirm wie *window*, gibt er die y-Koordinate des Zeigers zurück, gemessen in Pixeln im Root-Fenster des Bildschirms. Ist auf dem Bildschirm ein virtuelles Root-Fenster in Verwendung, wird die Position im virtuellen Root berechnet. Befindet sich der Mauszeiger nicht auf demselben Bildschirm wie *window*, wird -1 zurückgegeben.

**winfo reqheight** *window*
: Gibt eine Dezimalzeichenkette zurück, die die angeforderte Höhe von *window* in Pixeln angibt. Dies ist der Wert, den der Geometrie-Manager von *window* zur Berechnung der Geometrie verwendet.

**winfo reqwidth** *window*
: Gibt eine Dezimalzeichenkette zurück, die die angeforderte Breite von *window* in Pixeln angibt. Dies ist der Wert, den der Geometrie-Manager von *window* zur Berechnung der Geometrie verwendet.

**winfo rgb** *window color*
: Gibt eine Liste mit drei Dezimalwerten im Bereich 0 bis 65535 zurück, die die Rot-, Grün- und Blau-Intensitäten darstellen, die *color* im durch *window* gegebenen Fenster entsprechen. *Color* kann in jeder für eine Farboption zulässigen Form angegeben werden.

**winfo rootx** *window*
: Gibt eine Dezimalzeichenkette zurück, die die x-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Root-Fenster des Bildschirms angibt.

**winfo rooty** *window*
: Gibt eine Dezimalzeichenkette zurück, die die y-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Root-Fenster des Bildschirms angibt.

**winfo screen** *window*
: Gibt den Namen des mit *window* verknüpften Bildschirms in der Form *displayName*.*screenIndex* zurück.

**winfo screencells** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Anzahl der Zellen in der Standard-Farbtabelle für den Bildschirm von *window* angibt.

**winfo screendepth** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Tiefe des Root-Fensters des Bildschirms von *window* angibt (Anzahl der Bits pro Pixel).

**winfo screenheight** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Höhe des Bildschirms von *window* in Pixeln angibt.

**winfo screenmmheight** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Höhe des Bildschirms von *window* in Millimetern angibt.

**winfo screenmmwidth** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Breite des Bildschirms von *window* in Millimetern angibt.

**winfo screenvisual** *window*
: Gibt eine der folgenden Zeichenketten zurück, um die Standard-Visualklasse für den Bildschirm von *window* anzugeben: **directcolor**, **grayscale**, **pseudocolor**, **staticcolor**, **staticgray** oder **truecolor**.

**winfo screenwidth** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Breite des Bildschirms von *window* in Pixeln angibt.

**winfo server** *window*
: Gibt eine Zeichenkette zurück, die Informationen über den Server für das Display von *window* enthält. Das genaue Format dieser Zeichenkette kann von Plattform zu Plattform variieren. Bei X-Servern hat die Zeichenkette die Form „**X***major***R***minor vendor vendorVersion*“, wobei *major* und *minor* die vom Server bereitgestellten Versions- und Revisionsnummern sind (z. B. **X11R5**), *vendor* der Name des Server-Herstellers ist und *vendorRelease* eine vom Server bereitgestellte ganzzahlige Release-Nummer ist.

**winfo toplevel** *window*
: Gibt den Pfadnamen des Fensters an der Spitze der Hierarchie zurück, das *window* enthält. In Standard-Tk ist dies stets ein **toplevel**-Widget, Erweiterungen können jedoch andere Arten von Hierarchie-Spitzen-Widgets erzeugen.

**winfo viewable** *window*
: Gibt 1 zurück, wenn *window* und alle seine Vorfahren bis zum nächsten Toplevel-Fenster gemappt sind. Gibt 0 zurück, wenn eines dieser Fenster nicht gemappt ist.

**winfo visual** *window*
: Gibt eine der folgenden Zeichenketten zurück, um die Visualklasse für *window* anzugeben: **directcolor**, **grayscale**, **pseudocolor**, **staticcolor**, **staticgray** oder **truecolor**.

**winfo visualid** *window*
: Gibt den X-Bezeichner für das Visual von *window* zurück.

**winfo visualsavailable** *window* ?**includeids**?
: Gibt eine Liste zurück, deren Elemente die für den Bildschirm von *window* verfügbaren Visuals beschreiben. Jedes Element besteht aus einer Visualklasse gefolgt von einer ganzzahligen Tiefe. Die Klasse hat dieselbe Form wie der Rückgabewert von **winfo visual**. Die Tiefe gibt die Anzahl der Bits pro Pixel im Visual an. Wird zusätzlich das Argument **includeids** angegeben, folgt auf die Tiefe der X-Bezeichner für das Visual.

**winfo vrootheight** *window*
: Gibt die Höhe des mit *window* verknüpften virtuellen Root-Fensters zurück, falls eines vorhanden ist; andernfalls die Höhe des Bildschirms von *window*.

**winfo vrootwidth** *window*
: Gibt die Breite des mit *window* verknüpften virtuellen Root-Fensters zurück, falls eines vorhanden ist; andernfalls die Breite des Bildschirms von *window*.

**winfo vrootx** *window*
: Gibt den x-Versatz des mit *window* verknüpften virtuellen Root-Fensters relativ zum Root-Fenster seines Bildschirms zurück. Dies ist normalerweise null oder negativ. Gibt 0 zurück, wenn es kein virtuelles Root-Fenster für *window* gibt.

**winfo vrooty** *window*
: Gibt den y-Versatz des mit *window* verknüpften virtuellen Root-Fensters relativ zum Root-Fenster seines Bildschirms zurück. Dies ist normalerweise null oder negativ. Gibt 0 zurück, wenn es kein virtuelles Root-Fenster für *window* gibt.

**winfo width** *window*
: Gibt eine Dezimalzeichenkette zurück, die die Breite von *window* in Pixeln angibt. Wenn ein Fenster neu erzeugt wird, beträgt seine Breite zunächst 1 Pixel; die Breite wird später vom Geometrie-Manager geändert, um den Anforderungen des Fensters zu genügen. Benötigen Sie die tatsächliche Breite unmittelbar nach dem Erzeugen eines Widgets, rufen Sie **update** auf, um den Geometrie-Manager zur Anordnung zu zwingen, oder verwenden Sie **winfo reqwidth**, um die angeforderte statt der tatsächlichen Breite des Fensters zu erhalten.

**winfo x** *window*
: Gibt eine Dezimalzeichenkette zurück, die die x-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Eltern-Widget von *window* angibt.

**winfo y** *window*
: Gibt eine Dezimalzeichenkette zurück, die die y-Koordinate der oberen linken Ecke des Rahmens von *window* (oder von *window*, wenn es keinen Rahmen hat) im Eltern-Widget von *window* angibt.


# BEISPIELE

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

