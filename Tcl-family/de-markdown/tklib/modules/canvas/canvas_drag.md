---
CommandName: canvas::drag
title: canvas::drag
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - dragging
Copyright:
---

# Name

canvas::drag – Verwalten des Ziehens von Canvas-Elementen oder Elementgruppen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::drag]{.lit} [0.1]{.optlit}
[::canvas::drag]{.cmd} [on]{.lit} [canvas]{.arg} [tagOrId]{.arg} [cmd]{.arg} [option...]{.arg}
[::canvas::drag]{.cmd} [off]{.lit} [canvas]{.arg} [tagOrId]{.arg}
[::canvas::drag]{.cmd} [item]{.lit} [canvas]{.arg} [tagOrId]{.arg} [option...]{.arg}
[::canvas::drag]{.cmd} [group]{.lit} [canvas]{.arg} [tagOrId]{.arg} [cmd]{.arg} [option...]{.arg}
[{\*}cmd]{.cmd} [start]{.lit} [canvas]{.arg} [item]{.arg}
[{\*}cmd]{.cmd} [move]{.lit} [canvas]{.arg} [clientdata]{.arg} [dx]{.arg} [dy]{.arg}
[{\*}cmd]{.cmd} [done]{.lit} [canvas]{.arg} [clientdata]{.arg}
:::

# Beschreibung

Dieses Paket enthält Hilfsbefehle zum Einrichten und Entfernen des Ziehens von Elementen oder Elementgruppen auf einem Canvas, wobei alle komplexen Zusammenhänge hinsichtlich der Bindungen vor dem Benutzer verborgen bleiben.

# API

**::canvas::drag** **on** *canvas* *tagOrId* *cmd* *option*...
: Dieser Befehl initialisiert das Ziehen von Elementen im *canvas*-Widget, wobei die als Ziehgriffe verwendeten Elemente durch *tagOrId* identifiziert werden. Das Befehlspräfix *cmd*, das beim Start und während der Bewegung des Ziehvorgangs aufgerufen wird, ist für die Initialisierung und die eigentliche Ausführung des Ziehvorgangs zuständig.

    Die Signatur des Befehlspräfixes wird später im Abschnitt [Callback beim Ziehen] beschrieben.

    Ebenso werden die zulässigen Optionen und ihre Werte im Abschnitt [Optionen] beschrieben.

    Das Ergebnis des Befehls ist die leere Zeichenkette.

**::canvas::drag** **off** *canvas* *tagOrId*
: Dieser Befehl hebt alle Drag-Operationen auf, die für die Elemente des Canvas *canvas* festgelegt wurden, die durch *tagOrId* identifiziert werden.

    Das Ergebnis des Befehls ist die leere Zeichenkette.

**::canvas::drag** **item** *canvas* *tagOrId* *option*...
: Hierbei handelt es sich um einen Komfort-Befehl, der die Methode **on** (siehe oben) umschließt, um einzelne Elemente des *canvas*-Widgets, die durch *tagOrId* identifiziert werden, zu verschieben.

    Dazu wird eine interne Standard-Rückruffunktion verwendet.

    Das Ergebnis des Befehls ist die leere Zeichenkette.

**::canvas::drag** **group** *canvas* *tagOrId* *cmd* *option*...
: Dies ist ein Komfort-Befehl, der die Methode **on** (siehe oben) umschließt, um einzelne Elemente des *canvas*-Widgets, die durch *tagOrId* identifiziert werden, zu verschieben.

    Hierfür wird eine interne Standard-Rückruffunktion verwendet. Die angegebene Rückruffunktion *cmd* hat dieselbe Signatur wie der [Callback beim Ziehen], mit der Ausnahme, dass

    1. Die Methode **move** wird nicht aufgerufen.

    2. Das Ergebnis der Methode **start** *muss* ein Canvas-Tag sein, das auf die gesamte Gruppe der zu verschiebenden Elemente verweist. Mit anderen Worten: Es muss die Umwandlung vom Ziehgriff (Element-ID) in die verschobene Gruppe (Tag) vornehmen.


    Das Ergebnis des Befehls ist die leere Zeichenkette.


## Callback beim Ziehen

Die Drag-Rückruffunktion ist ein Befehlspräfix, das auf die folgenden zwei Arten aufgerufen wird:

**{\*}cmd** **start** *canvas* *item*
: Diese Form wird aufgerufen, wenn das Ziehen mithilfe des durch die *item*-ID des Canvas-Elements identifizierten Ziehgriffs initiiert wurde. Die Rückruffunktion muss nun alle für die jeweilige Art des Ziehvorgangs erforderlichen Schritte ausführen.

    Das Ergebnis des Befehls kann beliebig sein. Es wird vom System als Client-Information gespeichert und unverändert an die Bewegungs-Rückruffunktion zur weiteren Verwendung übergeben. Auf diese Weise kann die Drag-Rückruffunktion den benutzerdefinierten Zustand vom Start bis zur Bewegung beibehalten.

**{\*}cmd** **move** *canvas* *clientdata* *dx* *dy*
: Diese Form wird aufgerufen, wenn die Maus während eines Ziehvorgangs bewegt wird. Sie wird mit den Client-Daten aus der Start-Rückruffunktion (oder der vorherigen Bewegungs-Rückruffunktion) sowie den Entfernungen aufgerufen, die die Maus in horizontaler und vertikaler Richtung zurückgelegt hat.

    Das Ergebnis des Befehls kann beliebig sein. Es wird vom System als Client-Information gespeichert und unverändert an die nächste Rückruffunktion zur weiteren Verwendung übergeben. Auf diese Weise kann die Drag-Rückruffunktion einen benutzerdefinierten Zustand von Bewegung zu Bewegung beibehalten.

**{\*}cmd** **done** *canvas* *clientdata*
: Diese Form wird aufgerufen, wenn der Ziehvorgang beendet ist. Sie wird mit den Client-Daten aus der Rückruffunktion für die letzte Bewegung (oder der Start-Rückruffunktion, falls keine Bewegung stattgefunden hat) aufgerufen.

    Das Ergebnis des Befehls wird ignoriert.


## Optionen

Die Befehle zum Erstellen von Drag-Operationen (**on**, **item** und **group**) akzeptieren alle die folgenden Optionen zur Konfiguration des neuen Drag.

**-event** *spec*
: Der Wert dieser Option legt fest, welche Maustaste zum Auslösen des Ziehvorgangs verwendet wird, sowie gegebenenfalls die Zusatztaste. Beispiele für Angaben:

    Um einen Ziehvorgang durch Drücken der Maustaste 3 auf einem Ziehgriff auszulösen, verwenden Sie:

    ```
     -event 3
    ```

    Dies ist auch die Standardeinstellung, wenn die Option nicht angegeben wird.

    Um einen Ziehvorgang durch Drücken der Maustaste 2 auf einem Ziehgriff bei gedrückter Strg-Taste zu starten, verwenden Sie:

    ```
     -event Control-2
    ```


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
