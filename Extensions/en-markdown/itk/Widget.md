---
CommandName: Widget
title: Widget
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr Tk]"
Keywords:
 - itk
 - Archetype
 - Widget
 - mega-widget
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

Widget - base class for mega-widgets within a frame

# Inheritance

itk::Archetype <- itk::Widget

# Standard options

```
background	cursor
```

See the "options" manual entry for details on the standard options.

# Description

The **Widget** class inherits everything from the [Archetype] class, and adds a Tk frame called the "hull" component to represent the body of the mega-widget.  The window class name for the hull is set to the most-specific class name for the mega-widget. The protected variable **itk\_interior** contains the window path name for the "hull" component.  Derived classes specialize this widget by packing other widget components into the hull.

Since the hull for the **Widget** class is implemented with a Tk frame, mega-widgets in the **Widget** class can be packed into other frames and toplevels.

# Components

**hull** (**Frame**)
: The "hull" component acts as the body for the entire mega-widget. Other components are packed into the hull to further specialize the widget.


# Example

The following example implements a simple **TextDisplay** mega-widget.  It creates a read-only display of text with a text widget and a scrollbar.

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
# EXAMPLE:  Display the /etc/passwd file
#
TextDisplay .file -background red
pack .file

.file display [exec cat /etc/passwd]
```


[Archetype]: Archetype.md
