---
CommandName: widget_validator
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: widget::validator behaviour
Keywords:
 - invalid
 - state management
 - ttk::combobox
 - ttk::entry
 - validation
 - widget validation
Copyright:
---

# Name

widget_validator - widget::validator behaviour

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [widget::validator]{.lit} [0.1]{.optlit} 
[widget::validator]{.cmd} [attach]{.sub} [w]{.arg} [color]{.arg} [cmdprefix]{.arg} 
[widget::validator]{.cmd} [detach]{.sub} [w]{.arg} 
[widget::validator]{.cmd} [validate]{.sub} [w]{.arg} 
:::

# Description

This package provides a unified validation API for **ttk**'s entry and combobox widgets.

Please note that the validation behaviour defined in this package will not reject invalid edits. It will only highlight the entry containing invalid data and set the proper state flag.

It is the responsibility of the using package or application to decide how and when to actually reject such invalid content.

**widget::validator** **attach** *w* *color* *cmdprefix*
: This method adds a validating behaviour to the widget *w*. Whenever the content of the widget's entry field changes the specified *cmdprefix* is invoked and has to return a boolean value, where **true** means that content is ok, and **false** that the content is invalid. For more information on the command prefix see section **Validation**. In case of the latter the background color of the entry field is changed to *color* to indicate the invalidity. The system does not support nesting of validators on a widget, nor the attachment of multiple validators. To change validating conditions **detach** the current validator first before attaching the new. An error is thrown if the widget has already validating behaviour attached to it. The result of the method is the empty string. To achieve its aims the package overrides various configuration options of the widget the behaviour is attached to. These options are restored to their previous values on **detach**. If other behaviours are attached the validator may be rendered temporarily (partially) non-functional. Similarly, if the validator is detached while a different behaviour is also attached its restoration of configuration settings may render the other non-functional

**widget::validator** **detach** *w*
: This method removes the validating behaviour from the widget *w* and restores it to its original state. An error is thrown if the widget has no validating behaviour attached to it. The result of the method is the empty string.

**widget::validator** **validate** *w*
: Invoking this method forces a validation of the widget *w*, assuming that it has a validator behaviour attached to it. The result of the method is the empty string.


# Validation

The command prefix for used for validation has to have the following signature:

{\*}*cmdprefix* *text*
: The argument is the text to validate. The result of the callback has to be a boolean value where **true** means that *text* is ok, and **false** that *text* is invalid.


# Example

```
package require Tk 8.5
package require widget::validator

set TE {}
set TC {}

ttk::entry    .e -textvariable TE
ttk::combobox .c -textvariable TC -values {fruit vegetable corn}
ttk::combobox .n -values {fruit vegetable corn}
ttk::button   .x -command ::exit -text Exit

pack .e -expand 1 -fill both -side top
pack .c -expand 1 -fill both -side top
pack .n -expand 1 -fill both -side top
pack .x -expand 1 -fill both -side top

widget::validator attach .e lightblue {apply {text {
    expr {$text ne {}}
}}}

widget::validator attach .c yellow {apply {text {
    expr {$text ni {{} hello world}}
}}}

widget::validator attach .n pink {apply {text {
    expr {$text ni {{} blub}}
}}}
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widget::validator* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
