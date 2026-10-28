: [NAME](options.md#name)

    : options - Von Widgets unterstützte Standardoptionen

: [BESCHREIBUNG](options.md#beschreibung)

    : [-activebackground, activeBackground, Foreground](options.md) 

    : [-activeborderwidth, activeBorderWidth, BorderWidth](options.md) 

    : [-activeforeground, activeForeground, Background](options.md) 

    : [-anchor, anchor, Anchor](options.md) 

    : [-background oder -bg, background, Background](options.md) 

    : [-bitmap, bitmap, Bitmap](options.md) 

    : [-borderwidth oder -bd, borderWidth, BorderWidth](options.md) 

    : [-cursor, cursor, Cursor](options.md) 

    : [-disabledbackground, disabledBackground, DisabledBackground](options.md) 

    : [-disabledforeground, disabledForeground, DisabledForeground](options.md) 

    : [-exportselection, exportSelection, ExportSelection](options.md) 

    : [-font, font, Font](options.md) 

    : [-foreground oder -fg, foreground, Foreground](options.md) 

    : [-highlightbackground, highlightBackground, HighlightBackground](options.md) 

    : [-highlightcolor, highlightColor, HighlightColor](options.md) 

    : [-highlightthickness, highlightThickness, HighlightThickness](options.md) 

    : [-image, image, Image](options.md) 

    : [-insertbackground, insertBackground, Foreground](options.md) 

    : [-insertborderwidth, insertBorderWidth, BorderWidth](options.md) 

    : [-insertofftime, insertOffTime, OffTime](options.md) 

    : [-insertontime, insertOnTime, OnTime](options.md) 

    : [-insertwidth, insertWidth, InsertWidth](options.md) 

    : [-jump, jump, Jump](options.md) 

    : [-justify, justify, Justify](options.md) 

    : [-orient, orient, Orient](options.md) 

    : [-padx, padX, Pad](options.md) 

    : [-pady, padY, Pad](options.md) 

    : [-relief, relief, Relief](options.md) 

    : [-repeatdelay, repeatDelay, RepeatDelay](options.md) 

    : [-repeatinterval, repeatInterval, RepeatInterval](options.md) 

    : [-selectbackground, selectBackground, Foreground](options.md) 

    : [-selectborderwidth, selectBorderWidth, BorderWidth](options.md) 

    : [-selectforeground, selectForeground, Background](options.md) 

    : [-setgrid, setGrid, SetGrid](options.md) 

    : [-takefocus, takeFocus, TakeFocus](options.md) 

    : [-text, text, Text](options.md) 

    : [-textvariable, textVariable, Variable](options.md) 

    : [-troughcolor, troughColor, Background](options.md) 

    : [-underline, underline, Underline](options.md) 

    : [-wraplength, wrapLength, WrapLength](options.md) 

    : [-xscrollcommand, xScrollCommand, ScrollCommand](options.md) 

    : [-yscrollcommand, yScrollCommand, ScrollCommand](options.md) 

: [SCHLÜSSELWÖRTER](options.md#schl-sselw-rter) 


---

### NAME

options - Von Widgets unterstützte Standardoptionen

### BESCHREIBUNG

Dieser Handbucheintrag beschreibt die gemeinsamen Konfigurationsoptionen, die
Widgets im Tk-Toolkit unterstützen.  Nicht jedes Widget unterstützt
notwendigerweise jede Option (die Handbucheinträge der einzelnen Widgets nennen
die Standardoptionen, die dieses Widget unterstützt), wenn ein Widget aber
eine Option mit einem der unten genannten Namen unterstützt, hat die Option
genau die unten beschriebene Wirkung.

 In den folgenden Beschreibungen bezeichnet \`\`Befehlszeilenname'' den Schalter, der in Klassenbefehlen und Widget-Befehlen **configure** verwendet wird, um diesen Wert zu setzen. Wenn zum Beispiel der Befehlszeilenschalter einer Option **-foreground** ist und ein Widget **.a.b.c** existiert, dann kann der Befehl 

```
.a.b.c  configure  -foreground black
```

verwendet werden, um den Wert

black

für die Option in dem
dem Widget

.a.b.c

.  Befehlszeilenschalter können abgekürzt werden,
solange die Abkürzung eindeutig ist.
\`\`Datenbankname'' bezeichnet den Namen der Option in der Optionsdatenbank (zum Beispiel
in .Xdefaults-Dateien).  \`\`Datenbankklasse'' bezeichnet den Klassenwert der Option
in der Optionsdatenbank.

Datenbankklasse: **Foreground** 
: Legt die Hintergrundfarbe fest, die beim Zeichnen aktiver Elemente verwendet wird. Ein Element (ein Widget oder ein Teil eines Widgets) ist aktiv, wenn der Mauszeiger über dem Element steht und das Drücken einer Maustaste eine Aktion auslöst. Wenn strenge Motif-Konformität verlangt wurde, indem die Variable **tk_strictMotif** gesetzt wurde, wird diese Option gewöhnlich ignoriert; stattdessen wird die normale Hintergrundfarbe verwendet. Bei einigen Elementen auf Windows- und Macintosh-Systemen wird die aktive Farbe nur verwendet, solange die Maustaste 1 über dem Element gedrückt ist.

    Befehlszeilenname: -activeborderwidth Name der Datenbank: activeBorderWidth Datenbankklasse: BorderWidth

    Legt einen nicht negativen Wert fest, der die Breite des 3-D-Rahmens angibt, der um aktive Elemente gezeichnet wird. Die Definition aktiver Elemente steht oben. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert. Diese Option gibt es gewöhnlich nur bei Widgets, die mehr als ein Element gleichzeitig anzeigen (zum Beispiel Menüs, aber keine Schaltflächen).

    Befehlszeilenname: -activeforeground Name der Datenbank: activeForeground Datenbankklasse: Background

    Legt die Vordergrundfarbe fest, die beim Zeichnen aktiver Elemente verwendet wird. Die Definition aktiver Elemente steht oben.

    Befehlszeilenname: -anchor Name der Datenbank: anchor Datenbankklasse: Anchor

    Legt fest, wie die Information in einem Widget (zum Beispiel Text oder eine Bitmap) im Widget angezeigt wird. Muss einer der Werte **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw** oder **center** sein. **nw** bedeutet zum Beispiel, die Information so anzuzeigen, dass ihre obere linke Ecke an der oberen linken Ecke des Widgets liegt.

    Befehlszeilenname: -background oder -bg Name der Datenbank: background Datenbankklasse: Background

    Legt die normale Hintergrundfarbe fest, die beim Anzeigen des Widgets verwendet wird.

    Befehlszeilenname: -bitmap Name der Datenbank: bitmap Datenbankklasse: Bitmap

    Legt eine Bitmap fest, die im Widget angezeigt wird, in jeder Form, die **Tk_GetBitmap** akzeptiert. Die genaue Art der Anzeige kann von anderen Optionen wie **anchor** oder **justify** beeinflusst werden. Wenn diese Option angegeben ist, setzt sie gewöhnlich andere Optionen außer Kraft, die einen Textwert zur Anzeige im Widget festlegen; die Option **bitmap** kann auf eine leere Zeichenkette zurückgesetzt werden, um die Textanzeige wieder einzuschalten. In Widgets, die sowohl **bitmap** als auch **image** unterstützen, setzt **image** gewöhnlich **bitmap** außer Kraft.

    Befehlszeilenname: -borderwidth oder -bd Name der Datenbank: borderWidth Datenbankklasse: BorderWidth

    Legt einen nicht negativen Wert fest, der die Breite des 3-D-Rahmens angibt, der um die Außenseite des Widgets gezeichnet wird (wenn ein solcher Rahmen gezeichnet wird; das bestimmt gewöhnlich die Option **relief**). Der Wert kann auch verwendet werden, wenn 3-D-Effekte im Inneren des Widgets gezeichnet werden. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert.

    Befehlszeilenname: -cursor Name der Datenbank: cursor Datenbankklasse: Cursor

    Legt den Mauszeiger fest, der für das Widget verwendet wird. Der Wert kann jede Form haben, die **Tk_GetCursor** akzeptiert.

    Befehlszeilenname: **-disabledforeground**

    Befehlszeilenname: -disabledbackground Name der Datenbank: disabledBackground Datenbankklasse: DisabledBackground Legt die Hintergrundfarbe fest, die beim Zeichnen eines deaktivierten Elements verwendet wird. Wenn die Option als leere Zeichenkette angegeben ist (was auf monochromen Anzeigen gewöhnlich der Fall ist), werden deaktivierte Elemente mit der normalen Hintergrundfarbe gezeichnet, aber durch ein schraffiertes Füllmuster abgeblendet. Name der Datenbank: disabledForeground Datenbankklasse: DisabledForeground

    Legt die Vordergrundfarbe fest, die beim Zeichnen eines deaktivierten Elements verwendet wird. Wenn die Option als leere Zeichenkette angegeben ist (was auf monochromen Anzeigen gewöhnlich der Fall ist), werden deaktivierte Elemente mit der normalen Vordergrundfarbe gezeichnet, aber durch ein schraffiertes Füllmuster abgeblendet.

    Befehlszeilenname: -exportselection Name der Datenbank: exportSelection Datenbankklasse: ExportSelection

    Legt fest, ob eine Auswahl im Widget auch die X-Auswahl sein soll. Der Wert kann jede Form haben, die **Tcl_GetBoolean** akzeptiert, wie **true**, **false**, **0**, **1**, **yes** oder **no**. Wenn die Auswahl exportiert wird, hebt das Auswählen im Widget die aktuelle X-Auswahl auf, das Auswählen außerhalb des Widgets hebt jede Widget-Auswahl auf, und das Widget beantwortet Anforderungen zum Abfragen der Auswahl, wenn es eine Auswahl hat. Die Vorgabe ist gewöhnlich, dass Widgets Auswahlen exportieren.

    Befehlszeilenname: -font Name der Datenbank: font Datenbankklasse: Font

    Legt die Schriftart fest, die beim Zeichnen von Text im Widget verwendet wird.

    Befehlszeilenname: -foreground oder -fg Name der Datenbank: foreground Datenbankklasse: Foreground

    Legt die normale Vordergrundfarbe fest, die beim Anzeigen des Widgets verwendet wird.

    Befehlszeilenname: -highlightbackground Name der Datenbank: highlightBackground Datenbankklasse: HighlightBackground

    Legt die Farbe fest, die im Bereich der Durchlaufhervorhebung angezeigt wird, wenn das Widget nicht den Eingabefokus hat.

    Befehlszeilenname: -highlightcolor Name der Datenbank: highlightColor Datenbankklasse: HighlightColor

    Legt die Farbe für das Rechteck der Durchlaufhervorhebung fest, das um das Widget gezeichnet wird, wenn es den Eingabefokus hat.

    Befehlszeilenname: -highlightthickness Name der Datenbank: highlightThickness Datenbankklasse: HighlightThickness

    Legt einen nicht negativen Wert fest, der die Breite des Hervorhebungsrechtecks angibt, das um die Außenseite des Widgets gezeichnet wird, wenn es den Eingabefokus hat. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert. Wenn der Wert null ist, wird keine Fokushervorhebung um das Widget gezeichnet.

    Befehlszeilenname: -image Name der Datenbank: image Datenbankklasse: Image

    Legt ein Bild fest, das im Widget angezeigt wird; es muss mit dem Befehl **image create** erzeugt worden sein. Wenn die Option **image** angegeben ist, setzt sie gewöhnlich andere Optionen außer Kraft, die eine Bitmap oder einen Textwert zur Anzeige im Widget festlegen; die Option **image** kann auf eine leere Zeichenkette zurückgesetzt werden, um die Anzeige einer Bitmap oder von Text wieder einzuschalten.

    Befehlszeilenname: -insertbackground Name der Datenbank: insertBackground Datenbankklasse: Foreground

    Legt die Farbe fest, die als Hintergrund in der Fläche der Einfügemarke verwendet wird. Diese Farbe setzt gewöhnlich entweder den normalen Hintergrund des Widgets außer Kraft (oder den Hintergrund der Auswahl, wenn die Einfügemarke in die Auswahl fällt).

    Befehlszeilenname: -insertborderwidth Name der Datenbank: insertBorderWidth Datenbankklasse: BorderWidth

    Legt einen nicht negativen Wert fest, der die Breite des 3-D-Rahmens angibt, der um die Einfügemarke gezeichnet wird. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert.

    Befehlszeilenname: -insertofftime Name der Datenbank: insertOffTime Datenbankklasse: OffTime

    Legt einen nicht negativen ganzzahligen Wert fest, der die Anzahl der Millisekunden angibt, die die Einfügemarke in jedem Blinkzyklus \`\`off'' bleiben soll. Wenn diese Option null ist, blinkt die Einfügemarke nicht: sie ist die ganze Zeit eingeschaltet.

    Befehlszeilenname: -insertontime Name der Datenbank: insertOnTime Datenbankklasse: OnTime

    Legt einen nicht negativen ganzzahligen Wert fest, der die Anzahl der Millisekunden angibt, die die Einfügemarke in jedem Blinkzyklus \`\`on'' bleiben soll.

    Befehlszeilenname: -insertwidth Name der Datenbank: insertWidth Datenbankklasse: InsertWidth

    Legt einen Wert fest, der die Gesamtbreite der Einfügemarke angibt. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert. Wenn für die Einfügemarke ein Rahmen angegeben wurde (mit der Option **insertBorderWidth**), wird der Rahmen innerhalb der Breite gezeichnet, die die Option **insertWidth** angibt.

    Befehlszeilenname: -jump Name der Datenbank: jump Datenbankklasse: Jump

    Bei Widgets mit einem Schieber, der gezogen werden kann, um einen Wert zu verstellen, wie bei Scrollbars, bestimmt diese Option, wann Benachrichtigungen über Änderungen des Wertes erfolgen. Der Wert der Option muss ein boolescher Wert der Form sein, die **Tcl_GetBoolean** akzeptiert. Wenn der Wert false ist, erfolgen Aktualisierungen fortlaufend, während der Schieber gezogen wird. Wenn der Wert true ist, werden Aktualisierungen aufgeschoben, bis die Maustaste losgelassen wird, um das Ziehen zu beenden; dann erfolgt eine einzige Benachrichtigung (der Wert \`\`jumps'', anstatt sich gleichmäßig zu ändern).

    Befehlszeilenname: -justify Name der Datenbank: justify Datenbankklasse: Justify

    Wenn in einem Widget mehrere Textzeilen angezeigt werden, bestimmt diese Option, wie die Zeilen zueinander ausgerichtet werden. Muss einer der Werte **left**, **center** oder **right** sein. **Left** bedeutet, dass die linken Kanten der Zeilen auf einer Linie liegen, **center** bedeutet, dass die Mitten der Zeilen ausgerichtet sind, und **right** bedeutet, dass die rechten Kanten der Zeilen auf einer Linie liegen.

    Befehlszeilenname: -orient Name der Datenbank: orient Datenbankklasse: Orient

    Bei Widgets, die sich mit waagerechter oder senkrechter Ausrichtung anordnen können, wie Scrollbars, legt diese Option fest, welche Ausrichtung verwendet werden soll. Muss entweder **horizontal** oder **vertical** oder eine Abkürzung eines dieser Werte sein.

    Befehlszeilenname: -padx Name der Datenbank: padX Datenbankklasse: Pad

    Legt einen nicht negativen Wert fest, der angibt, wie viel zusätzlicher Platz für das Widget in X-Richtung angefordert wird. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert. Wenn das Widget berechnet, wie groß ein Fenster sein muss, addiert es diesen Betrag zu der Breite, die es gewöhnlich braucht (bestimmt durch die Breite dessen, was im Widget angezeigt wird); wenn der Geometriemanager diese Anforderung erfüllen kann, erhält das Widget zusätzlichen inneren Platz links und/oder rechts von dem, was es innen anzeigt. Die meisten Widgets verwenden diese Option nur für den Abstand um Text: wenn sie eine Bitmap oder ein Bild anzeigen, ignorieren sie Abstandsoptionen gewöhnlich.

    Befehlszeilenname: -pady Name der Datenbank: padY Datenbankklasse: Pad

    Legt einen nicht negativen Wert fest, der angibt, wie viel zusätzlicher Platz für das Widget in Y-Richtung angefordert wird. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert. Wenn das Widget berechnet, wie groß ein Fenster sein muss, addiert es diesen Betrag zu der Höhe, die es gewöhnlich braucht (bestimmt durch die Höhe dessen, was im Widget angezeigt wird); wenn der Geometriemanager diese Anforderung erfüllen kann, erhält das Widget zusätzlichen inneren Platz oberhalb und/oder unterhalb von dem, was es innen anzeigt. Die meisten Widgets verwenden diese Option nur für den Abstand um Text: wenn sie eine Bitmap oder ein Bild anzeigen, ignorieren sie Abstandsoptionen gewöhnlich.

    Befehlszeilenname: -relief Name der Datenbank: relief Datenbankklasse: Relief

    Legt den gewünschten 3-D-Effekt des Widgets fest. Zulässige Werte sind **raised**, **sunken**, **flat**, **ridge**, **solid** und **groove**. Der Wert gibt an, wie das Innere des Widgets gegenüber seiner Außenseite erscheinen soll; **raised** bedeutet zum Beispiel, dass das Innere des Widgets gegenüber der Außenseite des Widgets aus dem Bildschirm hervorzutreten scheint.

    Befehlszeilenname: -repeatdelay Name der Datenbank: repeatDelay Datenbankklasse: RepeatDelay

    Legt die Anzahl der Millisekunden fest, die eine Schaltfläche oder Taste gehalten werden muss, bevor die automatische Wiederholung beginnt. Wird zum Beispiel bei den Auf- und Ab-Pfeilen in Scrollbars verwendet.

    Befehlszeilenname: -repeatinterval Name der Datenbank: repeatInterval Datenbankklasse: RepeatInterval

    Wird zusammen mit **repeatDelay** verwendet: sobald die automatische Wiederholung beginnt, bestimmt diese Option die Anzahl der Millisekunden zwischen den automatischen Wiederholungen.

    Befehlszeilenname: -selectbackground Name der Datenbank: selectBackground Datenbankklasse: Foreground

    Legt die Hintergrundfarbe fest, die beim Anzeigen ausgewählter Einträge verwendet wird.

    Befehlszeilenname: -selectborderwidth Name der Datenbank: selectBorderWidth Datenbankklasse: BorderWidth

    Legt einen nicht negativen Wert fest, der die Breite des 3-D-Rahmens angibt, der um ausgewählte Einträge gezeichnet wird. Der Wert kann jede Form haben, die **Tk_GetPixels** akzeptiert.

    Befehlszeilenname: -selectforeground Name der Datenbank: selectForeground Datenbankklasse: Background

    Legt die Vordergrundfarbe fest, die beim Anzeigen ausgewählter Einträge verwendet wird.

    Befehlszeilenname: -setgrid Name der Datenbank: setGrid Datenbankklasse: SetGrid

    Legt einen booleschen Wert fest, der bestimmt, ob dieses Widget das Größenänderungsraster seines Toplevel-Fensters steuert. Diese Option wird gewöhnlich in Text-Widgets verwendet, bei denen die Information im Widget eine natürliche Größe hat (die Größe eines Zeichens) und es sinnvoll ist, dass die Abmessungen des Fensters ganzzahlige Vielfache dieser Einheiten sind. Diese natürlichen Fenstergrößen bilden ein Raster. Wenn die Option **setGrid** auf true gesetzt ist, verständigt sich das Widget mit dem Fenstermanager, sodass beim interaktiven Ändern der Größe des Toplevel-Fensters, das das Widget enthält, die Abmessungen des Fensters in Rastereinheiten angezeigt werden und die Fenstergröße auf ganzzahlige Anzahlen von Rastereinheiten beschränkt wird. Weitere Einzelheiten stehen im Abschnitt GRIDDED GEOMETRY MANAGEMENT im Handbucheintrag **wm**.

    Befehlszeilenname: -takefocus Name der Datenbank: takeFocus Datenbankklasse: TakeFocus

    Bestimmt, ob das Fenster den Fokus während des Tastaturdurchlaufs annimmt (zum Beispiel Tab und Shift-Tab). Bevor der Fokus auf ein Fenster gesetzt wird, lesen die Durchlaufskripte den Wert der Option **takeFocus**. Ein Wert von **0** bedeutet, dass das Fenster beim Tastaturdurchlauf ganz übersprungen werden soll. **1** bedeutet, dass das Fenster den Eingabefokus erhalten soll, solange es sichtbar ist (es und alle seine Vorfahren sind abgebildet). Ein leerer Wert der Option bedeutet, dass die Durchlaufskripte entscheiden, ob das Fenster den Fokus erhält: der aktuelle Algorithmus überspringt das Fenster, wenn es deaktiviert ist, wenn es keine Tastenbindungen hat oder wenn es nicht sichtbar ist. Wenn der Wert eine andere Form hat, nehmen die Durchlaufskripte den Wert, hängen den Namen des Fensters an (mit einem Leerzeichen als Trenner) und werten die entstehende Zeichenkette als Tcl-Skript aus. Das Skript muss **0**, **1** oder eine leere Zeichenkette zurückgeben: ein Wert **0** oder **1** legt fest, ob das Fenster den Eingabefokus erhält, und eine leere Zeichenkette führt zu der oben beschriebenen Vorgabeentscheidung. Hinweis: diese Deutung der Option legen ausschließlich die Tcl-Skripte fest, die den Durchlauf ausführen: die Widget-Implementierungen ignorieren die Option vollständig, die Bedeutung kann also geändert werden, wenn die Skripte für den Tastaturdurchlauf neu definiert werden.

    Befehlszeilenname: -text Name der Datenbank: text Datenbankklasse: Text

    Legt eine Zeichenkette fest, die im Widget angezeigt wird. Die Art der Anzeige hängt vom jeweiligen Widget ab und kann von anderen Optionen bestimmt werden, wie **anchor** oder **justify**.

    Befehlszeilenname: -textvariable Name der Datenbank: textVariable Datenbankklasse: Variable

    Legt den Namen einer Variablen fest. Der Wert der Variablen ist eine Textzeichenkette, die im Widget angezeigt wird; wenn sich der Wert der Variablen ändert, aktualisiert sich das Widget selbst, um den neuen Wert wiederzugeben. Die Art, wie die Zeichenkette im Widget angezeigt wird, hängt vom jeweiligen Widget ab und kann von anderen Optionen bestimmt werden, wie **anchor** oder **justify**.

    Befehlszeilenname: -troughcolor Name der Datenbank: troughColor Datenbankklasse: Background

    Legt die Farbe für die rechteckigen Muldenflächen in Widgets wie Scrollbars und Scales fest.

    Befehlszeilenname: -underline Name der Datenbank: underline Datenbankklasse: Underline

    Legt den ganzzahligen Index eines Zeichens fest, das im Widget unterstrichen wird. Die Vorgabebindungen verwenden diese Option, um den Tastaturdurchlauf für Menüschaltflächen und Menüeinträge auszuführen. 0 entspricht dem ersten Zeichen des im Widget angezeigten Textes, 1 dem nächsten Zeichen, und so weiter.

    Befehlszeilenname: -wraplength Name der Datenbank: wrapLength Datenbankklasse: WrapLength

    Bei Widgets, die einen Wortumbruch ausführen können, legt diese Option die maximale Zeilenlänge fest. Zeilen, die diese Länge überschreiten würden, werden auf die nächste Zeile umbrochen, sodass keine Zeile länger ist als die angegebene Länge. Der Wert kann in jeder der Standardformen für Bildschirmabstände angegeben werden. Wenn dieser Wert kleiner oder gleich 0 ist, wird nicht umbrochen: Zeilen brechen nur an Zeilenumbruchzeichen im Text.

    Befehlszeilenname: -xscrollcommand Name der Datenbank: xScrollCommand Datenbankklasse: ScrollCommand

    Legt das Präfix für einen Befehl fest, der zur Verständigung mit waagerechten Scrollbars dient. Wenn sich die Ansicht im Fenster des Widgets ändert (oder wenn irgendetwas anderes geschieht, das die Anzeige in einer Scrollbar ändern könnte, wie eine Änderung der Gesamtgröße des Inhalts des Widgets), erzeugt das Widget einen Tcl-Befehl, indem es den Scrollbefehl und zwei Zahlen aneinanderhängt. Jede der Zahlen ist ein Bruch zwischen 0 und 1, der eine Position im Dokument angibt. 0 bezeichnet den Anfang des Dokuments, 1 das Ende, .333 eine Position nach einem Drittel des Dokuments, und so weiter. Der erste Bruch bezeichnet die erste Information im Dokument, die im Fenster sichtbar ist, und der zweite Bruch bezeichnet die Information unmittelbar nach dem letzten sichtbaren Teil. Der Befehl wird dann dem Tcl-Interpreter zur Ausführung übergeben. Gewöhnlich besteht die Option **xScrollCommand** aus dem Pfadnamen eines Scrollbar-Widgets, gefolgt von \`\`set'', zum Beispiel \`\`.x.scrollbar set'': dadurch wird die Scrollbar aktualisiert, sobald sich die Ansicht im Fenster ändert. Wenn diese Option nicht angegeben ist, wird kein Befehl ausgeführt.

    Befehlszeilenname: -yscrollcommand Name der Datenbank: yScrollCommand Datenbankklasse: ScrollCommand Legt das Präfix für einen Befehl fest, der zur Verständigung mit senkrechten Scrollbars dient. Diese Option wird ebenso behandelt wie die Option xScrollCommand, sie wird aber für senkrechte Scrollbars verwendet und von Widgets bereitgestellt, die senkrechtes Scrollen unterstützen. Wie diese Option verwendet wird, steht in der Beschreibung von xScrollCommand.


### SCHLÜSSELWÖRTER

Klasse

,

Name

,

Standardoption

,

Schalter

---

```
Copyright © 1990-1994 The Regents of the University of California.
Copyright © 1994-1996 Sun Microsystems, Inc.
Copyright © 1995-1997 Roger E. Critchlow Jr.
```
