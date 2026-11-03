---
CommandName: ttk::widget
title: ttk::widget
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::intro(n)
 - ttk::style(n)
Keywords:
 - state
 - configure
 - option
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::widget - Standardoptionen und -befehle, die von den Tk-Themed-Widgets unterstützt werden

# Beschreibung

Diese Handbuchseite beschreibt gemeinsame Widget-Optionen und -befehle.

# Standardoptionen

Die folgenden Optionen werden von allen Tk-Themed-Widgets unterstützt:

**-class** (**undefined**/**undefined**)
: Legt die Fensterklasse fest. Die Klasse wird beim Abfragen der Optionendatenbank für die übrigen Optionen des Fensters, zur Bestimmung der Standard-Bindtags und zur Auswahl des Standard-Layouts und -Stils verwendet. Dies ist eine schreibgeschützte Option: sie darf nur bei der Fenstererzeugung angegeben werden und kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-cursor** (**cursor**/**Cursor**)
: Legt den Mauszeiger fest, der für das Widget verwendet wird. Die zulässigen Werte finden Sie unter [Tk\_GetCursor][GetCursor] und *cursors(n)* im Tk-Referenzhandbuch. Ist die Option auf die leere Zeichenkette gesetzt (Standard), wird der Mauszeiger vom Eltern-Widget geerbt.

**-takefocus** (**takeFocus**/**TakeFocus**)
: Legt fest, ob das Fenster bei der Tastaturnavigation den Fokus annimmt. Zulässig sind **0**, **1**, ein Befehlspräfix (an das der Widget-Pfad angehängt wird und das **0** oder **1** zurückgeben sollte) oder die leere Zeichenkette. Die vollständige Beschreibung finden Sie unter *options(n)* im Tk-Referenzhandbuch.

**-style** (**style**/**Style**)
: Kann verwendet werden, um einen eigenen Widget-Stil festzulegen.


# Optionen für scrollbare Widgets

Die folgenden Optionen werden von Widgets unterstützt, die sich mit einer Scrollbar steuern lassen. Weitere Informationen finden Sie unter *scrollbar(n)*.

**-xscrollcommand** (**xScrollCommand**/**ScrollCommand**)
: Ein Befehlspräfix, über das das Widget mit horizontalen Scrollbars kommuniziert. Wenn sich die Ansicht im Fenster des Widgets ändert, erzeugt das Widget einen Tcl-Befehl, indem es den Scroll-Befehl und zwei Zahlen verkettet. Jede der beiden Zahlen ist ein Bruchteil zwischen 0 und 1, der eine Position im Dokument angibt; 0 bezeichnet den Anfang und 1 das Ende. Der erste Bruchteil gibt die erste Information im Widget an, die im Fenster sichtbar ist, und der zweite Bruchteil die Information unmittelbar nach dem letzten sichtbaren Teil.

    Typischerweise besteht die Option **-xscrollcommand** aus dem Pfadnamen eines [scrollbar]-Widgets, gefolgt von „set“, z. B. „.x.scrollbar set“. Dadurch wird die Scrollbar jedes Mal aktualisiert, wenn sich die Ansicht im Fenster ändert.

    Ist diese Option auf die leere Zeichenkette gesetzt (Standard), wird kein Befehl ausgeführt.

**-yscrollcommand** (**yScrollCommand**/**ScrollCommand**)
: Ein Befehlspräfix, über das das Widget mit vertikalen Scrollbars kommuniziert. Einzelheiten finden Sie oben in der Beschreibung von **-xscrollcommand**.


# Label-Optionen

Die folgenden Optionen werden von Labels, Buttons und anderen button-ähnlichen Widgets unterstützt:

**-compound** (**compound**/**Compound**)
: Legt fest, wie das Bild relativ zum Text angezeigt wird, wenn sowohl **-text** als auch **-image** vorhanden sind. Ist die Option auf die leere Zeichenkette gesetzt (Standard), bestimmen die Regeln im Abschnitt „Elements“ von *ttk::intro(n)*, welcher Wert tatsächlich verwendet wird. Die übrigen gültigen Werte sind:

    text
    : Zeigt nur den Text an.

    image
    : Zeigt nur das Bild an.

    center
    : Zeigt den Text zentriert über dem Bild an.

    top
    : siehe unten …

    bottom
    : siehe unten …

    left
    : siehe unten …

    right
    : Zeigt das Bild oberhalb, unterhalb, links bzw. rechts vom Text an.

    none
    : Zeigt das Bild an, falls vorhanden, andernfalls den Text.


**-font** ([font]/**Font**)
: Die Schriftart für den Text, den das Widget anzeigt.

**-foreground** (**textColor**/**TextColor**)
: Die Vordergrundfarbe des Widgets. Ist sie nicht angegeben, wird der Standardwert des Themes verwendet.

**-image** (**image**/**Image**)
: Legt ein anzuzeigendes Bild fest. Der Wert ist eine Liste mit einem oder mehreren Elementen. Das erste Element ist der Name des Standardbilds. Der Rest der Liste ist eine Folge von *statespec / value*-Paaren wie bei **style map**, die festlegen, welche anderen Bilder verwendet werden, wenn sich das Widget in einem bestimmten Zustand oder einer Kombination von Zuständen befindet. Alle Bilder in der Liste sollten dieselbe Größe haben.

**-padding** (**padding**/**Padding**)
: Legt den Innenabstand des Widgets fest. Der Innenabstand ist eine Liste mit bis zu vier Längenangaben *left top right bottom*. Werden weniger als vier Elemente angegeben, gilt für *bottom* standardmäßig der Wert von *top*, für *right* der Wert von *left* und für *top* der Wert von *left*. Mit anderen Worten: Eine Liste aus drei Zahlen legt den linken, den vertikalen und den rechten Innenabstand fest; eine Liste aus zwei Zahlen legt den horizontalen und den vertikalen Innenabstand fest; eine einzelne Zahl legt denselben Innenabstand rund um das Widget fest.

**-text** (**text**/**Text**)
: Legt eine Zeichenkette fest, die im Widget angezeigt wird (sofern sie nicht bei Widgets, die diese Option unterstützen, durch **-textvariable** überschrieben wird).

**-textvariable** (**textVariable**/**Variable**)
: Legt den Namen einer globalen Variablen fest, deren Wert anstelle der Ressource **-text** verwendet wird.

**-underline** (**underline**/**Underline**)
: Ist die Option gesetzt, legt sie den ganzzahligen Index (ab 0) eines Zeichens in der Zeichenkette fest, das unterstrichen wird. Das unterstrichene Zeichen dient der Aktivierung per Tastenkürzel (Mnemonik).

**-width** (**width**/**Width**)
: Ist der Wert größer als null, legt er fest, wie viel Platz in Zeichenbreiten für die Textbeschriftung reserviert wird. Ist er kleiner als null, legt er eine Mindestbreite fest. Ist er null oder nicht angegeben, wird die natürliche Breite der Textbeschriftung verwendet.


# Kompatibilitätsoptionen

Diese Option ist nur bei Themed-Widgets verfügbar, die „entsprechende“ klassische Tk-Widgets haben.

**-state** (**state**/**State**)
: Kann auf **normal** oder **disabled** gesetzt werden, um das Zustandsbit **disabled** zu steuern. Dies ist eine Option, die nur geschrieben werden kann: Das Setzen ändert den Widget-Zustand, aber der Widget-Befehl **state** wirkt sich nicht auf die Option **-state** aus.


# Befehle

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der Konfigurationsoption zurück, die mit *option* angegeben ist.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Werden ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Widget-Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. Wird *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die benannte Option beschreibt: Die Elemente der Liste sind der Optionsname, der Datenbankname, die Datenbankklasse, der Standardwert und der aktuelle Wert. Wird keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt.

[pathName]{.ins} [identify]{.sub} [element]{.lit} [x]{.arg} [y]{.arg}
: Gibt den Namen des Elements unter dem Punkt zurück, der durch *x* und *y* gegeben ist, oder eine leere Zeichenkette, wenn der Punkt in keinem Element liegt. *x* und *y* sind Pixelkoordinaten relativ zum Widget. Manche Widgets akzeptieren weitere **identify**-Unterbefehle, die in der Dokumentation dieser Widgets beschrieben sind.

[pathName]{.ins} [instate]{.sub} [statespec]{.arg} [script]{.optarg}
: Prüft den Zustand des Widgets. Ist *script* nicht angegeben, wird 1 zurückgegeben, wenn der Widget-Zustand *statespec* entspricht, andernfalls 0. Ist *script* angegeben, entspricht der Befehl

    ```
    if {[pathName instate stateSpec]} script
    ```

[pathName]{.ins} [state]{.sub} [stateSpec]{.optarg}
: Ändert den Widget-Zustand oder fragt ihn ab. Ist *stateSpec* vorhanden, wird der Widget-Zustand gesetzt: Für jedes Flag in *stateSpec* wird das entsprechende Flag gesetzt, oder es wird gelöscht, wenn ihm ein Ausrufezeichen vorangestellt ist. Der Befehl gibt eine neue Zustandsspezifikation zurück, die angibt, welche Flags geändert wurden:

    ```
    set changes [pathName state spec]
    pathName state $changes
    ```

    stellt den ursprünglichen Zustand von *pathName* wieder her. Ist *stateSpec* nicht angegeben, wird eine Liste der aktuell gesetzten Zustandsflags zurückgegeben.

[pathName]{.ins} [xview]{.sub} [args]{.arg}
: Mit diesem Befehl wird die horizontale Position des Inhalts im Fenster des Widgets abgefragt und geändert. Er kann folgende Formen haben:

    [pathName]{.ins} [xview]{.sub}
    : Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruchteil zwischen 0 und 1; zusammen beschreiben sie den horizontalen Bereich, der im Fenster sichtbar ist. Ist zum Beispiel das erste Element .2 und das zweite .6, liegen 20 % des Widget-Inhalts links außerhalb des sichtbaren Bereichs, die mittleren 40 % sind im Fenster sichtbar, und 40 % des Inhalts liegen rechts außerhalb des sichtbaren Bereichs. Dies sind dieselben Werte, die über die Option **-xscrollcommand** an Scrollbars übergeben werden.

    [pathName]{.ins} [xview]{.sub} [index]{.arg}
    : Passt die Ansicht im Fenster so an, dass der durch *index* angegebene Inhalt am linken Rand des Fensters angezeigt wird.

    [pathName]{.ins} [xview]{.sub} [moveto]{.lit} [fraction]{.arg}
    : Passt die Ansicht im Fenster so an, dass das Zeichen, das um den Bruchteil *fraction* im Inhalt liegt, am linken Rand des Fensters erscheint. *Fraction* muss ein Bruchteil zwischen 0 und 1 sein.

    [pathName]{.ins} [xview]{.sub} [scroll]{.lit} [number]{.arg} [what]{.arg}
    : Dieser Befehl verschiebt die Ansicht im Fenster nach links oder rechts, abhängig von *number* und *what*. *Number* muss eine Ganzzahl sein. *What* muss entweder **units** oder **pages** sein. Ist *what* **units**, wird die Ansicht um *number* Zeichen durchschnittlicher Breite nach links oder rechts verschoben; ist es **pages**, wird die Ansicht um *number* Bildschirmseiten verschoben. Ist *number* negativ, werden Zeichen weiter links sichtbar; ist es positiv, werden Zeichen weiter rechts sichtbar.


[pathName]{.ins} [yview]{.sub} [args]{.arg}
: Mit diesem Befehl wird die vertikale Position des Inhalts im Fenster des Widgets abgefragt und geändert. Er kann folgende Formen haben:

    [pathName]{.ins} [yview]{.sub}
    : Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruchteil zwischen 0 und 1; zusammen beschreiben sie den vertikalen Bereich, der im Fenster sichtbar ist. Ist zum Beispiel das erste Element .2 und das zweite .6, liegen 20 % des Widget-Inhalts oben außerhalb des sichtbaren Bereichs, die mittleren 40 % sind im Fenster sichtbar, und 40 % des Inhalts liegen unten außerhalb des sichtbaren Bereichs. Dies sind dieselben Werte, die über die Option **-yscrollcommand** an Scrollbars übergeben werden.

    [pathName]{.ins} [yview]{.sub} [index]{.arg}
    : Passt die Ansicht im Fenster so an, dass der durch *index* angegebene Inhalt am oberen Rand des Fensters angezeigt wird.

    [pathName]{.ins} [yview]{.sub} [moveto]{.lit} [fraction]{.arg}
    : Passt die Ansicht im Fenster so an, dass das Element, das um den Bruchteil *fraction* im Inhalt liegt, am oberen Rand des Fensters erscheint. *Fraction* muss ein Bruchteil zwischen 0 und 1 sein.

    [pathName]{.ins} [yview]{.sub} [scroll]{.lit} [number]{.arg} [what]{.arg}
    : Dieser Befehl verschiebt die Ansicht im Fenster nach oben oder unten, abhängig von *number* und *what*. *Number* muss eine Ganzzahl sein. *What* muss entweder **units** oder **pages** sein. Ist *what* **units**, wird die Ansicht um *number* Zeichen durchschnittlicher Breite nach oben oder unten verschoben; ist es **pages**, wird die Ansicht um *number* Bildschirmseiten verschoben. Ist *number* negativ, werden Elemente weiter oben sichtbar; ist es positiv, werden Elemente weiter unten sichtbar.



# Widget-Zustände

Der Widget-Zustand ist eine Bitmap aus voneinander unabhängigen Zustandsflags. Zu den Zustandsflags eines Widgets gehören:

**active**
: Der Mauszeiger befindet sich über dem Widget, und das Drücken einer Maustaste löst eine Aktion aus (auch „prelight“ (Gnome), „hot“ (Windows), „hover“ genannt).

**disabled**
: Das Widget ist programmgesteuert deaktiviert (auch „unavailable“, „inactive“ genannt).

[focus]
: Das Widget hat den Tastaturfokus.

**pressed**
: Das Widget wird gerade gedrückt (in Motif „armed“ genannt).

**selected**
: „On“, „true“ oder „current“ bei Elementen wie Checkbuttons und Radiobuttons.

**background**
: Windows und der Mac kennen das Konzept eines „aktiven“ Fensters bzw. Vordergrundfensters. Der Zustand **background** ist bei Widgets in einem Hintergrundfenster gesetzt und bei Widgets im Vordergrundfenster gelöscht.

**readonly**
: Das Widget sollte keine Änderungen durch den Benutzer zulassen.

**alternate**
: Ein Widget-spezifisches alternatives Anzeigeformat. Es wird zum Beispiel bei Checkbuttons und Radiobuttons im Zustand „tristate“ oder „mixed“ verwendet und bei Buttons mit **-default active**.

**invalid**
: Der Wert des Widgets ist ungültig. (Mögliche Anwendungen: Der Wert eines Scale-Widgets liegt außerhalb der Grenzen, der Wert eines Entry-Widgets hat die Validierung nicht bestanden.)

**hover**
: Der Mauszeiger befindet sich innerhalb des Widgets. Dies ähnelt dem Zustand **active**; es wird in manchen Themes für Widgets verwendet, die für das aktive Widget eine eigene visuelle Rückmeldung geben, zusätzlich zum aktiven Element innerhalb des Widgets.

**user1**-**user3**
: Frei für andere Zwecke verwendbar


Eine *Zustandsspezifikation* oder *stateSpec* ist eine Liste von Zustandsnamen, denen optional ein Ausrufezeichen (!) vorangestellt ist, das anzeigt, dass das Bit nicht gesetzt ist.

# Beispiele

```
set b [ttk::button .b]

# Widget deaktivieren:
$b state disabled

# Widget nur aufrufen, wenn gedrückt und nicht deaktiviert:
$b instate {pressed !disabled} { .b invoke }

# Widget wieder aktivieren:
$b state !disabled
```


[focus]: focus.md
[font]: font.md
[GetCursor]: ../tk-c/GetCursor.md
[scrollbar]: scrollbar.md
