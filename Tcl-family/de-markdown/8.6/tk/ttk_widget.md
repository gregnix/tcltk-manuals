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

ttk::widget - Standardoptionen und -befehle der Tk-Themed-Widgets

# Beschreibung

Diese Handbuchseite beschreibt gemeinsame Widget-Optionen und -befehle.

# Standardoptionen

Die folgenden Optionen werden von allen Tk-Themed-Widgets unterstützt:

**-class** (**undefined**/**undefined**)
: Legt die Fensterklasse fest. Die Klasse wird beim Abfragen der Optionendatenbank für die übrigen Optionen des Fensters, zur Bestimmung der Standard-Bindtags und zur Auswahl des Standard-Layouts und -Stils verwendet. Dies ist eine schreibgeschützte Option: sie darf nur bei der Fenstererzeugung angegeben werden und kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-cursor** (**cursor**/**Cursor**)
: Legt den für das Widget zu verwendenden Mauszeiger fest. Siehe [Tk\_GetCursor][GetCursor] und *cursors(n)* im Tk-Referenzhandbuch für die zulässigen Werte. Ist er die leere Zeichenkette (Standard), wird der Zeiger vom Eltern-Widget geerbt.

**-takefocus** (**takeFocus**/**TakeFocus**)
: Legt fest, ob das Fenster den Fokus bei Tastaturtraversierung annimmt. Entweder **0**, **1**, ein Befehlspräfix (dem der Widget-Pfad angehängt wird und der **0** oder **1** zurückgeben soll) oder die leere Zeichenkette. Siehe *options(n)* im Tk-Referenzhandbuch für die vollständige Beschreibung.

**-style** (**style**/**Style**)
: Kann verwendet werden, um einen benutzerdefinierten Widget-Stil anzugeben.


# Optionen für scrollbare Widgets

Die folgenden Optionen werden von Widgets unterstützt, die mit einer Scrollbar gesteuert werden können. Siehe *scrollbar(n)* für Details.

**-xscrollcommand** (**xScrollCommand**/**ScrollCommand**)
: Ein Befehlspräfix zur Kommunikation mit horizontalen Scrollbars. Ändert sich die Ansicht im Widget-Fenster, erzeugt das Widget einen Tcl-Befehl durch Anhängen des Scroll-Befehls und zweier Zahlen. Jede Zahl ist ein Bruchteil zwischen 0 und 1 und gibt eine Position im Dokument an; 0 ist der Anfang, 1 das Ende. Der erste Bruchteil ist die erste im Fenster sichtbare Information, der zweite die Information unmittelbar nach dem letzten sichtbaren Teil.

    Typischerweise besteht **-xscrollcommand** aus dem Pfadnamen einer [scrollbar] gefolgt von „set“, z. B. „.x.scrollbar set“. Die Scrollbar wird dann bei jeder Ansichtsänderung aktualisiert.

    Ist diese Option die leere Zeichenkette (Standard), wird kein Befehl ausgeführt.

**-yscrollcommand** (**yScrollCommand**/**ScrollCommand**)
: Ein Befehlspräfix zur Kommunikation mit vertikalen Scrollbars. Siehe die Beschreibung von **-xscrollcommand** oben.


# Label-Optionen

Die folgenden Optionen werden von Labels, Buttons und anderen button-ähnlichen Widgets unterstützt:

**-compound** (**compound**/**Compound**)
: Legt fest, wie Bild und Text zueinander stehen, wenn sowohl **-text** als auch **-image** gesetzt sind. Ist die Option die leere Zeichenkette (Standard), gelten die Regeln im Abschnitt „Elements“ von *ttk::intro(n)*. Weitere gültige Werte:

    text
    : Nur Text anzeigen.

    image
    : Nur Bild anzeigen.

    center
    : Text zentriert über dem Bild anzeigen.

    top
    : Bild oberhalb des Textes anzeigen.

    bottom
    : Bild unterhalb des Textes anzeigen.

    left
    : Bild links vom Text anzeigen.

    right
    : Bild rechts vom Text anzeigen.

    none
    : Bild anzeigen, falls vorhanden, sonst Text.


**-font** ([font]/**Font**)
: Schriftart für den vom Widget angezeigten Text.

**-foreground** (**textColor**/**TextColor**)
: Vordergrundfarbe des Widgets. Ohne Angabe gilt der Theme-Standard.

**-image** (**image**/**Image**)
: Legt ein anzuzeigendes Bild fest. Liste mit mindestens einem Element; das erste ist der Standard-Bildname. Der Rest ist eine Folge von *statespec / value*-Paaren wie bei **style map**, die verschiedene Bilder für bestimmte Widget-Zustände festlegen. Alle Bilder in der Liste sollten dieselbe Größe haben.

**-padding** (**padding**/**Padding**)
: Legt den inneren Abstand des Widgets fest. Die Liste enthält bis zu vier Längenangaben *left top right bottom*. Bei weniger als vier Elementen gilt: *bottom* = *top*, *right* = *left*, *top* = *left*. Drei Zahlen: links, vertikal, rechts; zwei Zahlen: horizontal und vertikal; eine Zahl: gleicher Abstand ringsum.

**-text** (**text**/**Text**)
: Zeichenkette im Widget (sofern nicht durch **-textvariable** überschrieben, bei Widgets mit dieser Option).

**-textvariable** (**textVariable**/**Variable**)
: Name einer globalen Variable, deren Wert anstelle der **-text**-Resource verwendet wird.

**-underline** (**underline**/**Underline**)
: Wenn gesetzt, Index (0-basiert) des zu unterstreichenden Zeichens in der Textzeichenkette. Das unterstrichene Zeichen dient der Mnemonik-Aktivierung.

**-width** (**width**/**Width**)
: Ist der Wert größer als null, legt er den Platz in Zeichenbreiten für die Textbeschriftung fest. Ist er kleiner als null, eine Mindestbreite. Bei null oder ohne Angabe wird die natürliche Textbreite verwendet.


# Kompatibilitätsoptionen

Diese Option ist nur bei Themed-Widgets mit „entsprechenden“ klassischen Tk-Widgets verfügbar.

**-state** (**state**/**State**)
: Kann auf **normal** oder **disabled** gesetzt werden, um das **disabled**-Zustandsbit zu steuern. Schreiboption: das Setzen ändert den Widget-Zustand; der Widget-Befehl **state** beeinflusst **-state** nicht.


# Befehle

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Bei *option-value*-Paaren werden die Optionen gesetzt; der Befehl gibt dann eine leere Zeichenkette zurück. Ist nur *option* ohne *value* angegeben, gibt er eine Liste zur benannten Option zurück: Optionsname, Datenbankname, Datenbankklasse, Standardwert und aktueller Wert. Ohne *option* eine Liste aller verfügbaren Optionen für *pathName*.

[pathName]{.ins} [identify]{.sub} [element]{.lit} [x]{.arg} [y]{.arg}
: Gibt den Namen des Elements unter dem Punkt *x*, *y* zurück, oder eine leere Zeichenkette, wenn kein Element getroffen wird. *x* und *y* sind Pixelkoordinaten relativ zum Widget. Manche Widgets akzeptieren weitere **identify**-Unterbefehle in ihrer eigenen Dokumentation.

[pathName]{.ins} [instate]{.sub} [statespec]{.arg} [script]{.optarg}
: Prüft den Widget-Zustand. Ohne *script*: 1, wenn der Zustand *statespec* entspricht, sonst 0. Mit *script* äquivalent zu

    ```
    if {[pathName instate stateSpec]} script
    ```

[pathName]{.ins} [state]{.sub} [stateSpec]{.optarg}
: Ändert oder fragt den Widget-Zustand ab. Mit *stateSpec* werden die Flags gesetzt; ein führendes Ausrufezeichen löscht das Flag. Rückgabe: neue Zustandsspezifikation der geänderten Flags:

    ```
    set changes [pathName state spec]
    pathName state $changes
    ```

    stellt den ursprünglichen Zustand wieder her. Ohne *stateSpec*: Liste der aktuell aktiven Zustandsflags.

[pathName]{.ins} [xview]{.sub} [args]{.arg}
: Fragt die horizontale Position des Inhalts im Widget-Fenster ab oder ändert sie. Mögliche Formen:

    [pathName]{.ins} [xview]{.sub}
    : Liste mit zwei Elementen, je ein Bruchteil zwischen 0 und 1; beschreibt den sichtbaren horizontalen Bereich. Z. B. .2 und .6: 20 % links außerhalb, 40 % sichtbar, 40 % rechts außerhalb — dieselben Werte wie an Scrollbars über **-xscrollcommand**.

    [pathName]{.ins} [xview]{.sub} [index]{.arg}
    : Passt die Ansicht so an, dass der Inhalt *index* am linken Fensterrand liegt.

    [pathName]{.ins} [xview]{.sub} [moveto]{.lit} [fraction]{.arg}
    : Passt die Ansicht so an, dass der Inhalt an Position *fraction* am linken Rand erscheint. *fraction* zwischen 0 und 1.

    [pathName]{.ins} [xview]{.sub} [scroll]{.lit} [number]{.arg} [what]{.arg}
    : Verschiebt die Ansicht horizontal gemäß *number* und *what*. *number* muss eine Ganzzahl sein. *what* ist **units** oder **pages**. Bei **units** um *number* durchschnittliche Zeichenbreiten; bei **pages** um *number* Bildschirmseiten. Ist *number* negativ, werden Zeichen weiter links sichtbar; ist es positiv, weiter rechts.


[pathName]{.ins} [yview]{.sub} [args]{.arg}
: Wie **xview**, aber vertikal. Mögliche Formen:

    [pathName]{.ins} [yview]{.sub}
    : Zwei Bruchteile für den vertikal sichtbaren Bereich; dieselben Werte wie über **-yscrollcommand**.

    [pathName]{.ins} [yview]{.sub} [index]{.arg}
    : Inhalt *index* am oberen Fensterrand.

    [pathName]{.ins} [yview]{.sub} [moveto]{.lit} [fraction]{.arg}
    : Element an Position *fraction* am oberen Rand. *fraction* zwischen 0 und 1.

    [pathName]{.ins} [yview]{.sub} [scroll]{.lit} [number]{.arg} [what]{.arg}
    : Verschiebt vertikal. *number* muss eine Ganzzahl sein. *what* ist **units** oder **pages**. Bei **units** um *number* durchschnittliche Zeichenbreiten; bei **pages** um *number* Bildschirmseiten. Ist *number* negativ, werden Elemente weiter oben sichtbar; ist es positiv, weiter unten.



# Widget-Zustände

Der Widget-Zustand ist eine Bitmap-Menge unabhängiger Zustandsflags. Dazu gehören:

**active**
: Mauszeiger über dem Widget; Drücken einer Maustaste löst eine Aktion aus (auch „prelight“ (Gnome), „hot“ (Windows), „hover“).

**disabled**
: Widget ist programmgesteuert deaktiviert (auch „unavailable“, „inactive“).

[focus]
: Widget hat Tastaturfokus.

**pressed**
: Widget wird gedrückt (Motif: „armed“).

**selected**
: „An“, „true“ oder „current“ bei checkbutton und radiobutton.

**background**
: Windows und Mac kennen ein „aktives“ bzw. Vordergrundfenster. **background** ist für Widgets in Hintergrundfenstern gesetzt, in Vordergrundfenstern gelöscht.

**readonly**
: Benutzer darf den Wert nicht ändern.

**alternate**
: Widget-spezifisches alternatives Anzeigeformat, z. B. Tristate bei checkbutton/radiobutton oder Buttons mit **-default active**.

**invalid**
: Widget-Wert ist ungültig (z. B. Scale außerhalb der Grenzen, Entry-Validierung fehlgeschlagen).

**hover**
: Mauszeiger im Widget. Ähnlich **active**; in manchen Themes zusätzliches visuelles Feedback neben dem aktiven Element.

**user1**-**user3**
: Frei für andere Zwecke nutzbar


Eine *Zustandsspezifikation* oder *stateSpec* ist eine Liste von Zustandsnamen, optional mit Ausrufezeichen (!) für „aus“.

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
