---
CommandName: Toplevel
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

Toplevel - Basisklasse für Megawidgets in einem Toplevel-Fenster

# VERERBUNG

itk::Archetype <- itk::Toplevel

# STANDARDOPTIONEN

```
background cursor
```

Einzelheiten zu den Standardoptionen stehen im Handbuchabschnitt „options“.

# WIDGET-SPEZIFISCHE OPTIONEN

```
Name:   title
Class:  Title
Command-Line Switch:    -title
```

: Legt den Titel fest, den der Fenstermanager in der Titelleiste über dem Fenster anzeigt. Der voreingestellte Titel ist die leere Zeichenkette.


# BESCHREIBUNG

Die Klasse **Toplevel** erbt alles von der Klasse **Archetype** und fügt ein Tk-Toplevel namens Komponente „hull“ hinzu, das den Rumpf des Megawidgets darstellt. Der Name der Fensterklasse des Hull wird auf den spezifischsten Klassennamen des Megawidgets gesetzt. Die geschützte Variable **itk_interior** enthält den Fensterpfadnamen der Komponente „hull“. Abgeleitete Klassen spezialisieren dieses Widget, indem sie weitere Widget-Komponenten in den Hull packen.

Da der Hull der Klasse **Toplevel** mit einem Tk-Toplevel umgesetzt ist, haben Megawidgets der Klasse **Toplevel** ein eigenes Toplevel-Fenster. Diese Klasse wird verwendet, um Dialogfenster und andere eingeblendete Fenster zu erzeugen.

# KOMPONENTEN

```
Name:           hull
Class:          Toplevel
```

: Die Komponente „hull“ dient als Rumpf des gesamten Megawidgets. Weitere Komponenten werden in den Hull gepackt, um das Widget weiter zu spezialisieren.


# BEISPIEL

Das folgende Beispiel setzt ein Megawidget **MessageInfo** um. Es erzeugt eine eingeblendete Meldung, die der Benutzer mit der Schaltfläche „Dismiss“ schließen kann.

```
option add *MessageInfo.title "Notice" widgetDefault

itcl::class MessageInfo {
    inherit itk::Toplevel

    constructor {args} {
        itk_component add dismiss {
            button $itk_interior.dismiss -text "Dismiss" \
                -command "destroy $itk_component(hull)"
        }
        pack $itk_component(dismiss) -side bottom -pady 4

        itk_component add separator {
            frame $itk_interior.sep -height 2 -borderwidth 1 -relief sunken
        }
        pack $itk_component(separator) -side bottom -fill x -padx 4

        itk_component add icon {
            label $itk_interior.icon -bitmap info
        }
        pack $itk_component(icon) -side left -padx 8 -pady 8

        itk_component add infoFrame {
            frame $itk_interior.info
        }
        pack $itk_component(infoFrame) -side left -expand yes \
            -fill both -padx 4 -pady 4

        itk_component add message {
            label $itk_interior.mesg -width 20
        } {
            usual
            rename -text -message message Text
        }
        pack $itk_component(message) -expand yes -fill both

        eval itk_initialize $args

        after idle [code $this centerOnScreen]
    }

    protected method centerOnScreen {} {
        update idletasks
        set wd [winfo reqwidth $itk_component(hull)]
        set ht [winfo reqheight $itk_component(hull)]
        set x [expr ([winfo screenwidth $itk_component(hull)]-$wd)/2]
        set y [expr ([winfo screenheight $itk_component(hull)]-$ht)/2]
        wm geometry $itk_component(hull) +$x+$y
    }
}

itk::usual MessageInfo {
    keep -background -cursor -foreground -font
    keep -activebackground -activeforeground -disabledforeground
    keep -highlightcolor -highlightthickness
}

#
# BEISPIEL: Ein Hinweisfenster erzeugen:
#
MessageInfo .m -message "File not found:\n/usr/local/bin/foo"
```
