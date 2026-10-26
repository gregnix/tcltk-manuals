---
CommandName: Widget
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr\\ Tk]"
Keywords:
 - itk
 - Archetype
 - Widget
 - mega-widget
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---


# NAME

Widget - Basisklasse für Megawidgets innerhalb eines Frames

# VERERBUNG

itk::Archetype <- itk::Widget

# STANDARDOPTIONEN

```
background cursor
```

Einzelheiten zu den Standardoptionen stehen im Handbuchabschnitt „options“.

# BESCHREIBUNG

Die Klasse **Widget** erbt alles von der Klasse **Archetype** und fügt einen Tk-Frame namens Komponente „hull“ hinzu, der den Rumpf des Megawidgets darstellt. Der Name der Fensterklasse des Hull wird auf den spezifischsten Klassennamen des Megawidgets gesetzt. Die geschützte Variable **itk_interior** enthält den Fensterpfadnamen der Komponente „hull“. Abgeleitete Klassen spezialisieren dieses Widget, indem sie weitere Widget-Komponenten in den Hull packen.

Da der Hull der Klasse **Widget** mit einem Tk-Frame umgesetzt ist, lassen sich Megawidgets der Klasse **Widget** in andere Frames und Toplevel-Fenster packen.

# KOMPONENTEN

```
Name:           hull
Class:          Frame
```

: Die Komponente „hull“ dient als Rumpf des gesamten Megawidgets. Weitere Komponenten werden in den Hull gepackt, um das Widget weiter zu spezialisieren.


# BEISPIEL

Das folgende Beispiel setzt ein einfaches Megawidget **TextDisplay** um. Es erzeugt eine nur lesbare Anzeige von Text mit einem Text-Widget und einem Rollbalken.

```
option add *TextDisplay.wrap none widgetDefault
option add *TextDisplay.textBackground ivory widgetDefault
option add *TextDisplay.width 40 widgetDefault
option add *TextDisplay.height 10 widgetDefault

itcl::class TextDisplay {
    inherit itk::Widget

    constructor {args} {
        itk_component add text {
            text $itk_interior.info -state disabled \
                -yscrollcommand [code $itk_interior.sbar set]
        } {
            usual
            keep -tabs -wrap -width -height
            rename -background -textbackground textBackground Background
        }
        pack $itk_component(text) -side left -expand yes -fill both

        itk_component add scrollbar {
            scrollbar $itk_interior.sbar \
                -command [code $itk_interior.info yview]
        }
        pack $itk_component(scrollbar) -side right -fill y

        eval itk_initialize $args
    }

    public method display {info}
    public method append {info}
}

itcl::body TextDisplay::display {info} {
    $itk_component(text) configure -state normal
    $itk_component(text) delete 1.0 end
    $itk_component(text) insert 1.0 $info
    $itk_component(text) configure -state disabled
}

itcl::body TextDisplay::append {info} {
    $itk_component(text) configure -state normal
    $itk_component(text) insert end $info
    $itk_component(text) configure -state disabled
}

itk::usual TextDisplay {
    keep -background -cursor -foreground -font
    keep -activebackground -activerelief
    keep -highlightcolor -highlightthickness
    keep -insertbackground -insertborderwidth -insertwidth
    keep -insertontime -insertofftime
    keep -selectbackground -selectborderwidth -selectforeground
    keep -textbackground -troughcolor
}

#
# BEISPIEL: Die Datei /etc/passwd anzeigen
#
TextDisplay .file -background red
pack .file

.file display [exec cat /etc/passwd]
```
