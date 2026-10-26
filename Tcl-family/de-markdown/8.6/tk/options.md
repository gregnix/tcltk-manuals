---
CommandName: options
ManualSection: n
Version: 4.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - colors
 - cursors
 - font
Keywords:
 - class
 - name
 - standard option
 - switch
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

options - Von Widgets unterstützte Standardoptionen

# BESCHREIBUNG

Dieser Handbuch-Eintrag beschreibt die gemeinsamen Konfigurationsoptionen, die von Widgets im Tk-Toolkit unterstützt werden. Nicht jedes Widget unterstützt notwendigerweise jede Option (siehe die Handbuch-Einträge für einzelne Widgets für eine Liste der von diesem Widget unterstützten Standardoptionen), aber wenn ein Widget eine Option mit einem der unten aufgeführten Namen unterstützt, hat die Option genau die unten beschriebene Wirkung.

In den folgenden Beschreibungen bezeichnet „Befehlszeilen-Name" den Schalter, der in Klassenbefehlen und **configure**-Widget-Befehlen verwendet wird, um diesen Wert festzulegen. Wenn beispielsweise der Befehlszeilen-Schalter einer Option **-foreground** ist und ein Widget **.a.b.c** existiert, dann kann der Befehl

```
\&.a.b.c\0\0configure\0\0\-foreground black
```

verwendet werden, um den Wert **black** für die Option im Widget **.a.b.c** festzulegen. Befehlszeilen-Schalter dürfen abgekürzt werden, solange die Abkürzung eindeutig ist. „Datenbank-Name" bezieht sich auf den Namen der Option in der Optionsdatenbank (z. B. in .Xdefaults-Dateien). „Datenbank-Klasse" bezieht sich auf den Klassenwert der Option in der Optionsdatenbank.

**-activebackground** (activeBackground/Foreground)
: Legt die Hintergrundfarbe fest, die beim Zeichnen aktiver Elemente verwendet werden soll. Ein Element (ein Widget oder ein Teil eines Widgets) ist aktiv, wenn der Mauszeiger über dem Element positioniert ist und das Drücken einer Maustaste eine Aktion auslöst. Wenn strikte Motif-Kompatibilität durch Setzen der Variable **tk_strictMotif** angefordert wurde, wird diese Option normalerweise ignoriert; stattdessen wird die normale Hintergrundfarbe verwendet. Bei einigen Elementen unter Windows- und Macintosh-Systemen wird die aktive Farbe nur verwendet, während Maustaste 1 über dem Element gedrückt gehalten wird.

**-activeborderwidth** (activeBorderWidth/BorderWidth)
: Legt einen nicht-negativen Wert fest, der die Breite des 3D-Rahmens angibt, der um aktive Elemente gezeichnet wird. Siehe oben für die Definition aktiver Elemente. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben. Diese Option ist typischerweise nur in Widgets verfügbar, die mehr als ein Element gleichzeitig anzeigen (z. B. Menüs, aber nicht Buttons).

**-activeforeground** (activeForeground/Background)
: Legt die Vordergrundfarbe fest, die beim Zeichnen aktiver Elemente verwendet werden soll. Siehe oben für die Definition aktiver Elemente.

**-anchor** (anchor/Anchor)
: Legt fest, wie die Informationen in einem Widget (z. B. Text oder ein Bitmap) im Widget angezeigt werden sollen. Muss einer der Werte **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw** oder **center** sein. Beispielsweise bedeutet **nw**, dass die Informationen so angezeigt werden, dass ihre obere linke Ecke an der oberen linken Ecke des Widgets liegt.

**-background**, **-bg** (background/Background)
: Legt die normale Hintergrundfarbe fest, die beim Anzeigen des Widgets verwendet werden soll.

**-bitmap** (bitmap/Bitmap)
: Legt ein Bitmap fest, das im Widget angezeigt werden soll, in einer der von **Tk_GetBitmap** akzeptierten Formen. Die genaue Art, wie das Bitmap angezeigt wird, kann von anderen Optionen wie **-anchor** oder **-justify** beeinflusst werden. Typischerweise überschreibt diese Option, wenn sie angegeben ist, andere Optionen, die einen Textwert zur Anzeige im Widget festlegen, aber dies wird durch die Option **-compound** gesteuert; die Option **-bitmap** kann auf eine leere Zeichenkette zurückgesetzt werden, um eine Textanzeige wieder zu aktivieren. In Widgets, die sowohl **-bitmap** als auch **-image** unterstützen, überschreibt **-image** normalerweise **-bitmap**.

**-borderwidth**, **-bd** (borderWidth/BorderWidth)
: Legt einen nicht-negativen Wert fest, der die Breite des 3D-Rahmens angibt, der um die Außenseite des Widgets gezeichnet wird (wenn ein solcher Rahmen gezeichnet wird; die Option **-relief** bestimmt dies typischerweise). Der Wert kann auch beim Zeichnen von 3D-Effekten im Inneren des Widgets verwendet werden. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben.

**-cursor** (cursor/Cursor)
: Legt den Mauszeiger fest, der für das Widget verwendet werden soll. Der Wert kann eine der von **Tk_GetCursor** akzeptierten Formen haben. Wenn eine leere Zeichenkette angegeben ist, bedeutet dies, dass das Widget die Cursor-Spezifikation an sein übergeordnetes Widget delegieren soll.

**-compound** (compound/Compound)
: Legt fest, ob das Widget Text und Bitmaps/Bilder gleichzeitig anzeigen soll und, falls ja, wo das Bitmap/Bild relativ zum Text platziert werden soll. Muss einer der Werte **none**, **bottom**, **top**, **left**, **right** oder **center** sein. Beispielsweise gibt der (Standard-)Wert **none** an, dass das Bitmap oder Bild (falls definiert) anstelle des Textes angezeigt werden soll, der Wert **left** gibt an, dass das Bitmap oder Bild links vom Text angezeigt werden soll, und der Wert **center** gibt an, dass das Bitmap oder Bild über dem Text angezeigt werden soll.

**-disabledforeground** (disabledForeground/DisabledForeground)
: Legt die Vordergrundfarbe fest, die beim Zeichnen eines deaktivierten Elements verwendet werden soll. Wenn die Option als leere Zeichenkette angegeben ist (was typischerweise bei monochromen Displays der Fall ist), werden deaktivierte Elemente mit der normalen Vordergrundfarbe gezeichnet, aber sie werden abgedunkelt, indem sie mit einem gestrichelten Füllmuster gezeichnet werden.

**-exportselection** (exportSelection/ExportSelection)
: Legt fest, ob eine Auswahl im Widget auch die X-Auswahl sein soll. Der Wert kann eine der von **Tcl_GetBoolean** akzeptierten Formen haben, wie **true**, **false**, **0**, **1**, **yes** oder **no**. Wenn die Auswahl exportiert wird, hebt die Auswahl im Widget die aktuelle X-Auswahl auf, die Auswahl außerhalb des Widgets hebt jede Widget-Auswahl auf, und das Widget reagiert auf Anfragen zur Auswahlübermittlung, wenn es eine Auswahl hat. Standardmäßig exportieren Widgets normalerweise Auswahlen.

**-font** (font/Font)
: Legt die Schriftart fest, die beim Zeichnen von Text im Widget verwendet werden soll. Der Wert kann eine der im Handbuch-Eintrag **font** unter **FONT DESCRIPTION** beschriebenen Formen haben.

**-foreground**, **-fg** (foreground/Foreground)
: Legt die normale Vordergrundfarbe fest, die beim Anzeigen des Widgets verwendet werden soll.

**-highlightbackground** (highlightBackground/HighlightBackground)
: Legt die Farbe fest, die in der Traversierungs-Hervorhebungsregion angezeigt wird, wenn das Widget nicht den Eingabefokus hat.

**-highlightcolor** (highlightColor/HighlightColor)
: Legt die Farbe fest, die für das Traversierungs-Hervorhebungsrechteck verwendet wird, das um das Widget gezeichnet wird, wenn es den Eingabefokus hat.

**-highlightthickness** (highlightThickness/HighlightThickness)
: Legt einen nicht-negativen Wert fest, der die Breite des Hervorhebungsrechtecks angibt, das um die Außenseite des Widgets gezeichnet wird, wenn es den Eingabefokus hat. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben. Wenn der Wert null ist, wird keine Fokus-Hervorhebung um das Widget gezeichnet.

**-image** (image/Image)
: Legt ein Bild fest, das im Widget angezeigt werden soll, das mit dem Befehl **image create** erstellt worden sein muss. Typischerweise überschreibt die Option **-image**, wenn sie angegeben ist, andere Optionen, die ein Bitmap oder einen Textwert zur Anzeige im Widget festlegen, obwohl dies durch die Option **-compound** gesteuert wird; die Option **-image** kann auf eine leere Zeichenkette zurückgesetzt werden, um eine Bitmap- oder Textanzeige wieder zu aktivieren.

**-insertbackground** (insertBackground/Foreground)
: Legt die Farbe fest, die als Hintergrund im Bereich verwendet wird, der vom Einfügecursor abgedeckt wird. Diese Farbe überschreibt normalerweise entweder den normalen Hintergrund des Widgets (oder den Auswahlhintergrund, wenn der Einfügecursor zufällig in der Auswahl liegt).

**-insertborderwidth** (insertBorderWidth/BorderWidth)
: Legt einen nicht-negativen Wert fest, der die Breite des 3D-Rahmens angibt, der um den Einfügecursor gezeichnet wird. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben.

**-insertofftime** (insertOffTime/OffTime)
: Legt einen nicht-negativen Ganzzahlwert fest, der angibt, wie viele Millisekunden der Einfügecursor in jedem Blinkzyklus „aus" bleiben soll. Wenn diese Option null ist, blinkt der Cursor nicht: er ist die ganze Zeit an.

**-insertontime** (insertOnTime/OnTime)
: Legt einen nicht-negativen Ganzzahlwert fest, der angibt, wie viele Millisekunden der Einfügecursor in jedem Blinkzyklus „an" bleiben soll.

**-insertwidth** (insertWidth/InsertWidth)
: Legt einen nicht-negativen Wert fest, der die Gesamtbreite des Einfügecursors angibt. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben. Wenn ein Rahmen für den Einfügecursor angegeben wurde (mit der Option **-insertborderwidth**), wird der Rahmen innerhalb der von der Option **-insertwidth** angegebenen Breite gezeichnet.

**-jump** (jump/Jump)
: Bei Widgets mit einem Schieberegler, der zum Anpassen eines Werts gezogen werden kann, wie Scrollleisten, bestimmt diese Option, wann Benachrichtigungen über Änderungen des Werts erfolgen. Der Wert der Option muss ein boolescher Wert in der von **Tcl_GetBoolean** akzeptierten Form sein. Wenn der Wert false ist, werden Aktualisierungen kontinuierlich vorgenommen, während der Schieberegler gezogen wird. Wenn der Wert true ist, werden Aktualisierungen verzögert, bis die Maustaste losgelassen wird, um das Ziehen zu beenden; zu diesem Zeitpunkt erfolgt eine einzelne Benachrichtigung (der Wert „springt" anstatt sich stetig zu ändern).

**-justify** (justify/Justify)
: Wenn mehrere Textzeilen in einem Widget angezeigt werden, bestimmt diese Option, wie die Zeilen zueinander ausgerichtet werden. Muss einer von **left**, **center** oder **right** sein. **Left** bedeutet, dass die linken Kanten der Zeilen alle auf einer Linie liegen, **center** bedeutet, dass die Mittelpunkte der Zeilen ausgerichtet sind, und **right** bedeutet, dass die rechten Kanten der Zeilen auf einer Linie liegen.

**-orient** (orient/Orient)
: Bei Widgets, die sich horizontal oder vertikal ausrichten können, wie Scrollleisten, legt diese Option fest, welche Ausrichtung verwendet werden soll. Muss entweder **horizontal** oder **vertical** oder eine Abkürzung davon sein.

**-padx** (padX/Pad)
: Legt einen nicht-negativen Wert fest, der angibt, wie viel zusätzlicher Platz für das Widget in X-Richtung angefordert werden soll. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben. Bei der Berechnung, wie groß ein Fenster benötigt wird, addiert das Widget diesen Betrag zur Breite, die es normalerweise benötigen würde (bestimmt durch die Breite der im Widget angezeigten Elemente); wenn der Geometrie-Manager diese Anforderung erfüllen kann, erhält das Widget zusätzlichen internen Platz links und/oder rechts von dem, was es innen anzeigt. Die meisten Widgets verwenden diese Option nur zum Polstern von Text: wenn sie ein Bitmap oder Bild anzeigen, ignorieren sie Polsterungsoptionen normalerweise.

**-pady** (padY/Pad)
: Legt einen nicht-negativen Wert fest, der angibt, wie viel zusätzlicher Platz für das Widget in Y-Richtung angefordert werden soll. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben. Bei der Berechnung, wie groß ein Fenster benötigt wird, addiert das Widget diesen Betrag zur Höhe, die es normalerweise benötigen würde (bestimmt durch die Höhe der im Widget angezeigten Elemente); wenn der Geometrie-Manager diese Anforderung erfüllen kann, erhält das Widget zusätzlichen internen Platz oberhalb und/oder unterhalb von dem, was es innen anzeigt. Die meisten Widgets verwenden diese Option nur zum Polstern von Text: wenn sie ein Bitmap oder Bild anzeigen, ignorieren sie Polsterungsoptionen normalerweise.

**-relief** (relief/Relief)
: Legt den gewünschten 3D-Effekt für das Widget fest. Zulässige Werte sind **raised**, **sunken**, **flat**, **ridge**, **solid** und **groove**. Der Wert gibt an, wie das Innere des Widgets relativ zu seinem Äußeren erscheinen soll; beispielsweise bedeutet **raised**, dass das Innere des Widgets relativ zum Äußeren des Widgets aus dem Bildschirm hervorstehen soll.

**-repeatdelay** (repeatDelay/RepeatDelay)
: Legt die Anzahl der Millisekunden fest, die eine Taste oder ein Schlüssel gedrückt gehalten werden muss, bevor die automatische Wiederholung beginnt. Wird beispielsweise bei den Auf- und Ab-Pfeilen in Scrollleisten verwendet.

**-repeatinterval** (repeatInterval/RepeatInterval)
: Wird zusammen mit **-repeatdelay** verwendet: Sobald die automatische Wiederholung beginnt, bestimmt diese Option die Anzahl der Millisekunden zwischen automatischen Wiederholungen.

**-selectbackground** (selectBackground/Foreground)
: Legt die Hintergrundfarbe fest, die beim Anzeigen ausgewählter Elemente verwendet werden soll.

**-selectborderwidth** (selectBorderWidth/BorderWidth)
: Legt einen nicht-negativen Wert fest, der die Breite des 3D-Rahmens angibt, der um ausgewählte Elemente gezeichnet wird. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben.

**-selectforeground** (selectForeground/Background)
: Legt die Vordergrundfarbe fest, die beim Anzeigen ausgewählter Elemente verwendet werden soll.

**-setgrid** (setGrid/SetGrid)
: Legt einen booleschen Wert fest, der bestimmt, ob dieses Widget das Größenänderungsraster für sein Toplevel-Fenster steuert. Diese Option wird typischerweise in Text-Widgets verwendet, bei denen die Informationen im Widget eine natürliche Größe haben (die Größe eines Zeichens) und es sinnvoll ist, dass die Fensterabmessungen ganzzahlige Vielfache dieser Einheiten sind. Diese natürlichen Fenstergrößen bilden ein Raster. Wenn die Option **-setgrid** auf true gesetzt ist, kommuniziert das Widget mit dem Fenstermanager, sodass beim interaktiven Größenändern des Toplevel-Fensters, das das Widget enthält, die Abmessungen des Fensters dem Benutzer in Rastereinheiten angezeigt werden und die Fenstergröße auf ganzzahlige Vielfache von Rastereinheiten beschränkt wird. Siehe den Abschnitt **GRIDDED GEOMETRY MANAGEMENT** im Handbuch-Eintrag **wm** für weitere Details.

**-takefocus** (takeFocus/TakeFocus)
: Bestimmt, ob das Fenster während der Tastatur-Traversierung (z. B. Tab und Shift-Tab) den Fokus annimmt. Bevor der Fokus auf ein Fenster gesetzt wird, konsultieren die Traversierungs-Skripte den Wert der Option **-takefocus**. Ein Wert von **0** bedeutet, dass das Fenster während der Tastatur-Traversierung vollständig übersprungen werden soll. **1** bedeutet, dass das Fenster den Eingabefokus erhalten soll, solange es sichtbar ist (es und alle seine Vorfahren sind gemappt). Ein leerer Wert für die Option bedeutet, dass die Traversierungs-Skripte die Entscheidung treffen, ob auf das Fenster fokussiert werden soll oder nicht: Der aktuelle Algorithmus überspringt das Fenster, wenn es deaktiviert ist, wenn es keine Tastenbelegungen hat oder wenn es nicht sichtbar ist. Wenn der Wert eine andere Form hat, nehmen die Traversierungs-Skripte den Wert, hängen den Namen des Fensters an (mit einem Trennleerzeichen) und werten die resultierende Zeichenkette als Tcl-Skript aus. Das Skript muss **0**, **1** oder eine leere Zeichenkette zurückgeben: Ein **0**- oder **1**-Wert gibt an, ob das Fenster den Eingabefokus erhalten wird, und eine leere Zeichenkette führt zur oben beschriebenen Standardentscheidung. Hinweis: Diese Interpretation der Option wird vollständig durch die Tcl-Skripte definiert, die die Traversierung implementieren: Die Widget-Implementierungen ignorieren die Option vollständig, sodass Sie ihre Bedeutung ändern können, wenn Sie die Tastatur-Traversierungs-Skripte neu definieren.

**-text** (text/Text)
: Legt eine Zeichenkette fest, die im Widget angezeigt werden soll. Die Art, wie die Zeichenkette angezeigt wird, hängt vom jeweiligen Widget ab und kann durch andere Optionen wie **-anchor** oder **-justify** bestimmt werden.

**-textvariable** (textVariable/Variable)
: Legt den Namen einer globalen Variable fest. Der Wert der Variable ist eine Textzeichenkette, die im Widget angezeigt werden soll; wenn sich der Variablenwert ändert, aktualisiert sich das Widget automatisch, um den neuen Wert widerzuspiegeln. Die Art, wie die Zeichenkette im Widget angezeigt wird, hängt vom jeweiligen Widget ab und kann durch andere Optionen wie **-anchor** oder **-justify** bestimmt werden.

**-troughcolor** (troughColor/Background)
: Legt die Farbe fest, die für die rechteckigen Trog-Bereiche in Widgets wie Scrollleisten und Skalen verwendet wird. Diese Option wird für Scrollleisten unter Windows ignoriert (das native Widget erkennt diese Option nicht).

**-underline** (underline/Underline)
: Legt den ganzzahligen Index eines Zeichens fest, das im Widget unterstrichen werden soll. Diese Option wird von den Standard-Bindings verwendet, um die Tastatur-Traversierung für Menü-Buttons und Menüeinträge zu implementieren. 0 entspricht dem ersten Zeichen des im Widget angezeigten Textes, 1 dem nächsten Zeichen und so weiter.

**-wraplength** (wrapLength/WrapLength)
: Bei Widgets, die Zeilenumbrüche durchführen können, legt diese Option die maximale Zeilenlänge fest. Zeilen, die diese Länge überschreiten würden, werden auf die nächste Zeile umgebrochen, sodass keine Zeile länger als die angegebene Länge ist. Der Wert kann in einer der Standardformen für Bildschirmabstände angegeben werden. Wenn dieser Wert kleiner oder gleich 0 ist, erfolgt kein Umbruch: Zeilen werden nur an Zeilenumbruchzeichen im Text getrennt.

**-xscrollcommand** (xScrollCommand/ScrollCommand)
: Legt das Präfix für einen Befehl fest, der zur Kommunikation mit horizontalen Scrollleisten verwendet wird. Wenn sich die Ansicht im Fenster des Widgets ändert (oder immer wenn etwas anderes auftritt, das die Anzeige in einer Scrollleiste ändern könnte, wie eine Änderung der Gesamtgröße des Widget-Inhalts), erzeugt das Widget einen Tcl-Befehl durch Verkettung des Scroll-Befehls und zweier Zahlen. Jede der Zahlen ist ein Bruchteil zwischen 0 und 1, der eine Position im Dokument angibt. 0 gibt den Anfang des Dokuments an, 1 das Ende, .333 eine Position ein Drittel durch das Dokument und so weiter. Der erste Bruchteil gibt die ersten Informationen im Dokument an, die im Fenster sichtbar sind, und der zweite Bruchteil gibt die Informationen unmittelbar nach dem letzten sichtbaren Teil an. Der Befehl wird dann an den Tcl-Interpreter zur Ausführung übergeben. Typischerweise besteht die Option **-xscrollcommand** aus dem Pfadnamen eines Scrollleisten-Widgets gefolgt von „set", z. B. „.x.scrollbar set": Dies bewirkt, dass die Scrollleiste aktualisiert wird, wann immer sich die Ansicht im Fenster ändert. Wenn diese Option nicht angegeben ist, wird kein Befehl ausgeführt.

**-yscrollcommand** (yScrollCommand/ScrollCommand)
: Legt das Präfix für einen Befehl fest, der zur Kommunikation mit vertikalen Scrollleisten verwendet wird. Diese Option wird auf die gleiche Weise behandelt wie die Option **-xscrollcommand**, außer dass sie für vertikale Scrollleisten verwendet wird und von Widgets bereitgestellt wird, die vertikales Scrollen unterstützen. Siehe die Beschreibung von **-xscrollcommand** für Details zur Verwendung dieser Option.

