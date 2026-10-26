---
CommandName: ttk::style
title: ttk::style
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::intro(n)
 - ttk::widget(n)
 - photo(n)
 - ttk_image(n)
Keywords:
 - style
 - theme
 - appearance
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::style - Manipuliert die Style-Datenbank

# Übersicht

::: {.synopsis} :::
[ttk::style]{.cmd} [option]{.arg} [args]{.optarg}
:::

# Hinweise

Siehe auch die Tcl'2004-Konferenzpräsentation unter <https://tktable.sourceforge.net/tile/tile-tcl2004.pdf>

# Definitionen

Jedem Widget wird ein *style* zugewiesen, der die Menge der Elemente bestimmt, aus denen das Widget besteht, und wie sie angeordnet sind, sowie dynamische und Standard-Einstellungen für Elementoptionen. Standardmäßig entspricht der Stilname der Widget-Klasse; dies kann mit der Option **-style** überschrieben werden.

Ein *theme* ist eine Sammlung von Elementen und Styles, die das Gesamterscheinungsbild einer Anwendung steuert. Der Style „.“ ist der Theme-Wurzelstil, auf dem abgeleitete Styles basieren.

# Beschreibung

Der Befehl **ttk::style** akzeptiert folgende Argumente:

[ttk::style]{.cmd} [configure]{.sub} [style]{.arg} [-option ?value option value...]{.optarg} ?
: Legt den Standardwert der angegebenen Option(en) in *style* fest. Existiert *style* nicht, wird er erstellt. Sind nur *style* und *-option* angegeben, wird der Standardwert der Option *-option* von Style *style* abgerufen. Ist nur *style* angegeben, werden die Standardwerte aller Optionen von Style *style* abgerufen.

[ttk::style]{.cmd} [element]{.sub} [args]{.arg}
: siehe unten ...
    [ttk::style]{.cmd} [element]{.sub} [create]{.lit} [elementName]{.arg} [type]{.arg} [args...]{.optarg}
    : Erstellt ein neues Element im aktuellen Theme vom Typ *type*. Der einzige plattformübergreifende eingebaute Elementtyp ist *image* (siehe [ttk\_image][ttk_image](n)); Themes können weitere Elementtypen definieren (siehe **Ttk\_RegisterElementFactory**). Auf geeigneten Windows-Versionen ist eine Elementfabrik registriert, die Windows-Theme-Elemente erzeugt (siehe [ttk\_vsapi][ttk_vsapi](n)).


    [ttk::style]{.cmd} [element]{.sub} [names]{.lit}
    : Gibt die Liste der im aktuellen Theme definierten Elemente zurück.

    [ttk::style]{.cmd} [element]{.sub} [options]{.lit} [element]{.arg}
    : Gibt die Liste der Optionen von *element* zurück.


[ttk::style]{.cmd} [layout]{.sub} [style]{.arg} [layoutSpec]{.optarg}
: Definiert das Widget-Layout für Style *style*. Siehe [Layouts] unten für das Format von *layoutSpec*. Wird *layoutSpec* weggelassen, wird die Layout-Spezifikation für Style *style* zurückgegeben.

[ttk::style]{.cmd} [lookup]{.sub} [style]{.arg} [-option]{.arg} [state ?default]{.optarg}
: Gibt den für *-option* in Style *style* im Zustand *state* festgelegten Wert zurück, unter Verwendung der Standard-Lookup-Regeln für Elementoptionen. *state* ist eine Liste von Zustandsnamen; fehlt sie, entspricht der Standard alle Bits aus („normal“-Zustand). Ist das Argument *default* vorhanden, wird es als Fallback verwendet, falls keine Spezifikation für *-option* gefunden wird. Existiert *style* nicht, wird er erstellt.

[ttk::style]{.cmd} [map]{.sub} [style]{.arg} [-option { statespec value... }]{.optarg}
: Legt dynamische (zustandsabhängige) Werte der angegebenen Option(en) in *style* fest. Jedes Paar *statespec / value* wird der Reihe nach geprüft; der Wert des ersten passenden *statespec* wird verwendet. Existiert *style* nicht, wird er erstellt. Sind nur *style* und *-option* angegeben, werden die dynamischen Werte der Option *-option* von Style *style* abgerufen. Ist nur *style* angegeben, werden die dynamischen Werte aller Optionen von Style *style* abgerufen.

[ttk::style]{.cmd} [theme]{.sub} [args]{.arg}
: siehe unten ...
    [ttk::style]{.cmd} [theme]{.sub} [create]{.lit} [themeName]{.arg} [[-parent]{.lit} [basedon]{.arg}]{.optarg} [[-settings]{.lit} [script...]{.arg}]{.optarg}
    : Erstellt ein neues Theme. Existiert *themeName* bereits, ist das ein Fehler. Ist **-parent** angegeben, erbt das neue Theme Styles, Elemente und Layouts vom Eltern-Theme *basedon*. Ist **-settings** vorhanden, wird *script* im Kontext des neuen Themes gemäß **ttk::style theme settings** ausgewertet.


    [ttk::style]{.cmd} [theme]{.sub} [names]{.lit}
    : Gibt eine Liste aller bekannten Themes zurück.

    [ttk::style]{.cmd} [theme]{.sub} [settings]{.lit} [themeName]{.arg} [script]{.arg}
    : Setzt das aktuelle Theme vorübergehend auf *themeName*, wertet *script* aus und stellt das vorherige Theme wieder her. Typischerweise definiert *script* nur Styles und Elemente, beliebiger Tcl-Code ist jedoch möglich.

    [ttk::style]{.cmd} [theme]{.sub} [styles]{.lit} [themeName]{.optarg}
    : Gibt eine Liste aller Styles in *themeName* zurück. Wird *themeName* weggelassen, wird das aktuelle Theme verwendet.

    [ttk::style]{.cmd} [theme]{.sub} [use]{.lit} [themeName]{.optarg}
    : Ohne Argument ist das Ergebnis der Name des aktuellen Themes. Andernfalls setzt dieser Befehl das aktuelle Theme auf *themeName* und aktualisiert alle Widgets.



# Layouts

Ein *layout* legt eine Liste von Elementen fest, jedes gefolgt von einer oder mehreren Optionen zur Anordnung des Elements. Der Layout-Mechanismus verwendet eine vereinfachte Variante des Geometriemanagers [pack]: Ausgehend von einem anfänglichen Hohlraum (*cavity*) erhält jedes Element ein *parcel* (Zuweisungsbereich). Anschließend wird das vom Element tatsächlich genutzte *parcel* innerhalb des zugewiesenen Bereichs angepasst. Gültige Optionen sind:

[-children]{.lit} [{ sublayout... }]{.arg}
: Legt eine Liste von Elementen fest, die innerhalb des Elements platziert werden.

[-expand]{.lit} [boolean]{.arg}
: Legt fest, ob das zugewiesene *parcel* der gesamte Hohlraum ist. Ist das der Fall, wird eine gleichzeitige Angabe von **-side** ignoriert. Standard ist 0.

[-side]{.lit} [side]{.arg}
: Legt fest, an welcher Seite des Hohlraums das Element platziert wird; einer von **left**, **right**, **top** oder **bottom**. Beispielsweise weist **-side top** das *parcel* entlang der Oberkante des Hohlraums zu, mit Breite und Höhe jeweils der Breite des Hohlraums bzw. der Höhe des Elements. Fehlt die Angabe, ist das zugewiesene *parcel* der gesamte Hohlraum (gleicher Effekt wie **-expand** 1).

[-sticky]{.lit} [\[nswe\]]{.lit}
: Legt Position und Größe des tatsächlichen *parcel* innerhalb des zugewiesenen Bereichs fest. Bei leerer Zeichenkette wird das tatsächliche *parcel* im zugewiesenen Bereich zentriert. Standard ist **nswe**.


Beispiel:

```
ttk::style layout Horizontal.TScrollbar {
    Scrollbar.trough -children {
        Scrollbar.leftarrow -side left
        Scrollbar.rightarrow -side right
        Horizontal.Scrollbar.thumb -side left -sticky ew
    }
}
```

# Wurzel-Stil

Der Theme-Wurzelstil „.“ kann wie jeder andere Style konfiguriert werden und liefert Standardwerte für abgeleitete Styles. Zusätzlich zu den üblichen Optionen sind für „.“ mit **ttk::style** konfigurierbare Styling-Optionen:

**-insertofftime** *amount*
: Legt einen nicht negativen Ganzzahlwert fest: die Anzahl Millisekunden, die der Einfügecursor in jedem Blinkzyklus „aus“ bleiben soll. Ist die Option null, blinkt der Cursor nicht: er ist durchgehend ein. Standard 300 ms, sofern nicht durch eine **RESOURCE\_MANAGER**-Property oder eine **.Xdefaults**-Datei überschrieben.


**-insertontime** *amount*
: Legt einen nicht negativen Ganzzahlwert fest: die Anzahl Millisekunden, die der Einfügecursor in jedem Blinkzyklus „ein“ bleiben soll. Standard 600 ms, sofern nicht durch eine **RESOURCE\_MANAGER**-Property oder eine **.Xdefaults**-Datei überschrieben.


[pack]: pack.md
[ttk_image]: ttk_image.md
[ttk_vsapi]: ttk_vsapi.md
