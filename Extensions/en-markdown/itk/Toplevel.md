---
CommandName: Toplevel
title: Toplevel
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

Toplevel - base class for mega-widgets in a top-level window

# Inheritance

itk::Archetype <- itk::Toplevel

# Standard options

```
background	cursor
```

See the "options" manual entry for details on the standard options.

# Widget-specific options

**-title** (**title**/**Title**)
: Sets the title that the window manager displays in the title bar above the window.  The default title is the null string.


# Description

The **Toplevel** class inherits everything from the [Archetype] class, and adds a Tk toplevel called the "hull" component to represent the body of the mega-widget.  The window class name for the hull is set to the most-specific class name for the mega-widget. The protected variable **itk\_interior** contains the window path name for the "hull" component.  Derived classes specialize this widget by packing other widget components into the hull.

Since the hull for the **Toplevel** class is implemented with a Tk toplevel, mega-widgets in the **Toplevel** class have their own toplevel window.  This class is used to create dialog boxes and other pop-up windows.

# Components

**hull** (**Toplevel**)
: The "hull" component acts as the body for the entire mega-widget. Other components are packed into the hull to further specialize the widget.


# Example

The following example implements a **MessageInfo** mega-widget.  It creates a pop-up message that the user can dismiss by pushing the "Dismiss" button.

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
# EXAMPLE:  Create a notice window:
#
MessageInfo .m -message "File not found:\n/usr/local/bin/foo"
```


[Archetype]: Archetype.md
