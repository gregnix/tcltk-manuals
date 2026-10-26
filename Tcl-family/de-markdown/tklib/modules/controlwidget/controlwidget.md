---
CommandName: controlwidget
title: controlwidget
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: controlwidget
Keywords:
 - controlling
 - displaying
 - numerical values
 - scale widget
Copyright:
 - Copyright (c) 2010 Ron Fox <rfox@...>
 - Copyright (c) 2010 Gerhard Reithofer <...@...>
 - Copyright (c) 2010 Marco Maggi <...@...>
 - Copyright (c) 2010 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

controlwidget – Sammlung von Widgets zur Anzeige und Steuerung numerischer Werte

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.optlit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [2.0]{.optlit}
[package]{.cmd} [require]{.sub} [controlwidget]{.lit} [0.1]{.optlit}
[::controlwidget::meter]{.cmd} [w]{.arg} [args]{.arg}
[::controlwidget::slider]{.cmd} [w]{.arg} [args]{.arg}
[::controlwidget::equalizerBar]{.cmd} [w]{.arg} [args]{.arg}
[::controlwidget::thermometer]{.cmd} [w]{.arg} [args]{.arg}
[::controlwidget::voltmeter]{.cmd} [w]{.arg} [args]{.arg}
[::controlwidget::tachometer]{.cmd} [w]{.arg} [args]{.arg}
[::controlwidget::rdial]{.cmd} [w]{.arg} [args]{.arg}
[$widget]{.cmd} [get]{.lit}
[$widget]{.cmd} [set]{.lit} [value]{.arg}
[::controlwidget::led]{.cmd} [w]{.arg} [args]{.arg}
[::controlwidget::radioMatrix]{.cmd} [w]{.arg} [args]{.arg}
[$led]{.cmd} [on]{.lit}
[$led]{.cmd} [off]{.lit}
[$led]{.cmd} [setstate]{.lit} [state]{.arg}
[$matrix]{.cmd} [get]{.lit}
[$matrix]{.cmd} [set]{.lit} [index]{.arg}
:::

# Beschreibung

Das „controlwidget“-Paket hat den Fokus auf die Darstellung und interaktive Steuerung numerischer Werte. Es ahmt verschiedene Messgeräte und Bedienelemente nach, wie sie in Laborumgebungen, aber auch im Alltag zu finden sind: Spannungsmesser, Equalizer und Drehzahlmesser, um nur einige zu nennen. Das sind Alternativen zum Widget *scale*.

*Hinweis:* Das Paket ist bislang nicht umfassend geprüft. Andere Größen als die Vorgaben können die Darstellung unerwartet ändern. Auch die Optionen für Farben der einzelnen Teile, Schriften und Ähnliches sind nicht alle geprüft und können weitere Fehlerquellen sein.

Ein letzter Hinweis: Einige Teile wurden in keiner der Optionen berücksichtigt, insbesondere die Farben von Teilen, bei denen hellere und dunklere Farbtöne miteinander harmonieren müssen.

# Arten von Widgets

Das Paket unterscheidet zwischen verschiedenen Arten von Widgets:

- Vertikale Anzeigen: Der Wert der Variable wird in eine vertikale Position umgewandelt, ähnlich wie bei den farbigen Balken einer Stereoanlage.

- Winkelanzeigen: Der Wert der Variable steht in Zusammenhang mit dem Winkel einer Nadel, ähnlich wie bei Drehzahlmessern.

- Interaktive Widgets: Die meisten Widgets ändern den Wert der Variablen, wenn die Maustaste auf der Nadel liegt und die Nadel nach oben und unten oder nach links und rechts geschoben wird.

- Nicht-interaktive Widgets: Einige Widgets, wie beispielsweise das Thermometer-Widget, lassen eine solche Interaktion nicht zu.

- Logische Widgets oder Auswahl-Widgets: Einige Widgets zeigen die Werte als on/off (oder true/false) oder als eine aus einer Menge diskreter Möglichkeiten.


Allen gemeinsam ist, dass sie sich an eine Variable binden lassen und dass eine Änderung der Variable die Anzeige ändert. Außerdem haben alle Widgets die Methoden **set** und **get**, um mit dem angezeigten Wert zu arbeiten, ob er in einer globalen Variablen liegt oder nicht.

Erscheinungsbild und Verhalten folgen einer oder mehreren Optionen, die sich beim Erzeugen und oft auch später setzen lassen. Alle Widgets bauen auf dem Paket *snit* auf, die Methoden **configure** und **cget** setzen und lesen diese Optionen.

# Befehle

Derzeit enthält das Paket folgende Widgets vom Typ *vertikaler Messbalken*:

**::controlwidget::meter** *w* *args*
: Erzeugt eine vertikale Anzeige, die aus einer Achse und einem beweglichen Pfeil besteht.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern:

        **variable** name
        : Name der Variable, die dem Zähler zugeordnet werden soll

        **background** color
        : Hintergrundfarbe für das Widget

        **height** pixels
        : Höhe des Widgets

        **width** pixels
        : Breite des Widgets

        **arrowthickness** pixels
        : Dicke des angezeigten Pfeils in Pixeln

        **arrowcolor** color
        : Farbe des angezeigten Pfeils

        **readonly** boolean
        : Ob der Pfeil interaktiv verschoben werden kann oder nicht



**::controlwidget::slider** *w* *args*
: Erzeugt ein Widget mit einem oder mehreren senkrechten Schiebereglern und einer Achse. Die Griffe lassen sich mit der Maus verschieben.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern:

        **variable** name
        : Name der (Listen-)Variablen, die dem Widget zugeordnet werden soll

        **number** integer
        : Anzahl der Schieberegler im Widget

        **background** color
        : Hintergrundfarbe für das Widget

        **height** pixels
        : Höhe des Widgets

        **width** pixels
        : Breite des Widgets

        **sliderthickness** pixels
        : Dicke der Schiebereglergriffe

        **sliderwidth** color
        : Breite der Schiebereglergriffe

        **troughwidth** color
        : Breite der Führungen, in denen die Gleitstücke gelagert sind



**::controlwidget::equalizerBar** *w* *args*
: Erzeugt ein Widget, das einen oder mehrere vertikale Balken enthält, die denen ähneln, wie man sie bei grafischen HiFi-Equalizern findet. Hinweis: Es handelt sich um ein schreibgeschütztes Widget.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern:

        **variable** name
        : Name der (Listen-)Variablen, die dem Widget zugeordnet werden soll

        **number** integer
        : Anzahl der Balken im Widget

        **background** color
        : Hintergrundfarbe für das Widget

        **height** pixels
        : Höhe des Widgets

        **width** pixels
        : Breite des Widgets

        **barwidth** pixels
        : Breite der Stäbe

        **segments** integer
        : Anzahl der Segmente, in die die Balken unterteilt sind

        **safecolor** color
        : Farbe für Werte unterhalb der Warnschwelle

        **warningcolor** color
        : Farbe für Werte, die über dem Wert für den Fehler liegen

        **warninglevel** double
        : Schwellenwert; legt fest, ab welchem Wert sich die Farbe ändert



**::controlwidget::thermometer** *w* *args*
: Erzeugt ein Thermometer-Widget (schreibgeschützt)

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern:

        **variable** name
        : Name der (Listen-)Variablen, die dem Widget zugeordnet werden soll

        **background** color
        : Hintergrundfarbe für das Widget

        **height** pixels
        : Höhe des Widgets

        **width** pixels
        : Breite des Widgets

        **linethickness** pixels
        : Dicke der Linie, die die „Temperatur“ darstellt

        **linecolor** color
        : Farbe der Linie




Diese Widgets verwenden alle eine vertikale Achse und verfügen über die folgenden gemeinsamen Optionen zur Konfiguration der Achse:

**axisformat** string
: Formatzeichenfolge zur Formatierung der Zahlen entlang der Achse

**axisfont** string
: Name der Schriftart, die für die Zahlen verwendet werden soll

**axiscolor** color
: Farbe der Achse (einschließlich der Zahlen)

**from** color
: Niedrigerer Wert für die Achse

**to** color
: Oberer Wert für die Achse

**majorticks** integer
: Anzahl der zu zeichnenden Hauptmarkierungen (jede ist beschriftet)

**minorticks** integer
: Anzahl der kleinen Skalenmarkierungen, die zwischen zwei großen Skalenmarkierungen eingezeichnet werden sollen

**log** boolean
: Logarithmische Achse (true) oder lineare Achse (false).


Das Paket enthält das folgende Widget für Winkelanzeigen:

**::controlwidget::voltmeter** *w* *args*
: Erzeugt ein Widget, das einem Voltmeter ähnelt.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern:

        **variable** name
        : Name der Variable, die dem Zähler zugeordnet werden soll

        **value** value
        : Wert für den Zähler (sofern er keiner Variable zugeordnet ist)

        **min** value
        : Der Mindestwert für die Werte in der Anzeige

        **max** value
        : Der Höchstwert für die Werte in der Anzeige

        **labels** list
        : Die Bezeichnungen, die entlang der Skala angezeigt werden sollen. (Diese werden lediglich als Text betrachtet und stehen daher an sich in keinem Zusammenhang mit dem Minimal- und Maximalwert.)

        **title** string
        : Text, der unterhalb des Zifferblatts angezeigt werden soll

        **width** pixels
        : Die Breite des Widgets

        **height** pixels
        : Die Höhe des Widgets

        **borderwidth** pixels
        : Die Breite des Rahmens, der das gesamte Widget umgibt

        **relief** string
        : Das Relief des Rahmens, der das gesamte Widget umgibt

        **highlightthickness** pixels
        : Die Breite des Rahmens, der anzeigt, dass das Widget den Tastaturfokus hat

        **labelfont** fontname
        : Schriftart der Beschriftungen auf der Skala

        **titlefont** fontname
        : Schriftart des Titels unterhalb des Zifferblatts

        **dialcolor** color
        : Farbe des Zifferblatts, auf dem sich der Zeiger befindet

        **needlecolor** color
        : Farbe der Nadel

        **scalecolor** color
        : Farbe der Skala (Bogen und Teilstriche)

        **labelcolor** color
        : Farbe der Beschriftungen auf der Skala

        **titlecolor** color
        : Farbe der Überschrift unterhalb des Zifferblatts



**::controlwidget::tachometer** *w* *args*
: Erzeugt ein Widget, das einem Drehzahlmesser ähnelt.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern. Zusätzlich zu den für das Voltmeter-Widget angegebenen:

        **variable** name
        : Name der Variable, die dem Zähler zugeordnet werden soll

        **value** value
        : Wert für den Zähler (sofern er keiner Variable zugeordnet ist)

        **dangerlevel** value
        : Wert, ab dem die Werte in einer anderen Farbe angezeigt werden

        **dangercolor** color
        : Farbe für die Werte oberhalb der „Gefahrenstufe“

        **dangerwidth** pixels
        : Breite des farbigen Streifens, der die „Gefahrenstufe“ anzeigt

        **pincolor** color
        : Farbe für die Nadel und die Stecknadel



**::controlwidget::rdial** *w* *args*
: Erzeugt einen Drehregler. Der Regler lässt sich ziehen, um den Wert zu ändern. Mit gedrückter Taste Shift ändert sich der Wert langsam, mit gedrückter Taste Control schnell. Ebenso lässt sich der Regler mit dem Mausrad steuern. Shift und Control wirken dabei wie beim Mauszeiger. *Hinweis:* Shift und Control wirken unter Windows derzeit nicht.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern:

        **variable** name
        : Name der Variablen, die dem Drehregler zugeordnet werden soll

        **value** value
        : Wert für das Dial-Element (sofern es keiner Variable zugeordnet ist)

        **orient** string
        : Ob eine waagerechte Scheibe („horizontal“) oder eine senkrechte („vertical“) gebraucht wird.

        **step** value
        : Erster Schritt zum Erhöhen oder Verringern des Wertes

        **bindwheel** value
        : Schrittweite für den Wert über das Mausrad.

        **slow** value
        : Faktor auf der Schrittweite, mit dem der Wert langsam steigt oder fällt.

        **fast** value
        : Faktor auf der Schrittweite, mit dem der Wert schnell steigt oder fällt.

        **scale** value
        : Skalenwert, der auf den tatsächlichen Wert angewandt wird.

        **callback** command
        : Befehl, der beim Ändern des Wertes aufgerufen wird.

        **width** pixels
        : Die Breite des Widgets

        **height** pixels
        : Die Höhe des Widgets

        **background** color
        : Die Hintergrundfarbe des Widgets (Farbe der Scheibe/des Zifferblatts)

        **foreground** color
        : Die Vordergrundfarbe des Widgets (die Markierungslinien)




Alle diese Widgets verfügen über die folgenden Methoden:

**$widget** get
: Gibt den aktuellen Wert oder die aktuellen Werte zurück, die das Widget anzeigt.

**$widget** set *value*
: Setzt den oder die im Widget angezeigten Werte. Ist das Widget einer Variablen zugeordnet, wird diese Variable ebenfalls gesetzt.

    value *double/list*
    : Neuer Wert oder neue Werte für das Widget.



Es stehen zwei weitere Widgets zur Verfügung, die zur Anzeige logischer Werte dienen:

**::controlwidget::led** *w* *args*
: Erzeugt ein Widget, das wie eine LED aussieht.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern. Zusätzlich zu den für das Voltmeter-Widget angegebenen:

        **variable** name
        : Name der Variablen, die der LED zugeordnet werden soll

        **size** pixels
        : Durchmesser des LED-Widgets

        **on** color
        : Farbe, die für den „Ein“-Zustand verwendet werden soll

        **off** color
        : Farbe, die für den „Aus“-Zustand verwendet werden soll



**::controlwidget::radioMatrix** *w* *args*
: Erzeugt eine Matrix aus Radiobuttons, die sich wie ein einziges Widget verhält.

    widget *w* (in)
    : Name des zu erstellenden Widgets.

    arguments *args* (in)
    : Liste der Schlüssel-Wert-Paare, die das Erscheinungsbild und das Verhalten des Widgets steuern. Zusätzlich zu den für das Voltmeter-Widget angegebenen:

        **variable** name
        : Name der Variable, die der Matrix zugeordnet werden soll

        **orient** string
        : Anordnung der Radiobuttons (zuerst horizontal oder vertical)

        **rows** integer
        : Anzahl der Zeilen in der Matrix

        **columns** integer
        : Anzahl der Spalten in der Matrix

        **command** list
        : Befehl der Radiobuttons. Wird aufgerufen, wenn der aktive Radiobutton wechselt.




Das LED-Widget verfügt über die folgenden öffentlichen Methoden:

**$led** on
: Setzt den Zustand auf „on“.

**$led** off
: Setzt den Zustand auf „off“.

**$led** setstate *state*
: Setzt den Zustand nach dem Wert von „state“.

    state *boolean* (in)
    : Neuer Zustand für das LED-Widget



Das „radioMatrix“-Widget verfügt über zwei öffentliche Methoden:

**$matrix** get
: Gibt den Index des gerade gewählten Radiobuttons zurück.

**$matrix** set *index*
: Wählt den Radiobutton mit dem Index *index*.

    index *integer*
    : Index des zu setzenden Radiobuttons.



# Danksagungen

Der Code für die meisten dieser Widgets erschien zunächst im Wiki. In vielen Fällen hat Arjen Markus den Code lediglich ein wenig überarbeitet und einige davon auf *snit* umgestellt. Der ursprüngliche Code wurde von den folgenden Personen entwickelt:

- Senkrechtes Messgerät, LED-Anzeige, Radiobutton-Matrix: Ron Fox

- Drehregler: Gerhard Reithofer

- Spannungsmesser und Drehzahlmesser: Marco Maggi

- Code zum Bewegen der Nadel: ?


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *controlwidget* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 2010 Ron Fox <rfox@...>
Copyright (c) 2010 Gerhard Reithofer <...@...>
Copyright (c) 2010 Marco Maggi <...@...>
Copyright (c) 2010 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
