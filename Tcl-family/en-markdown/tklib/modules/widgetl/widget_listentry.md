---
CommandName: widget_listentry
ManualSection: n
Version: 0.1.2
TclPart: tklib
TclDescription: widget::listentry widget
Keywords:
 - data entry lists
 - data entry ordered list
 - data entry set of strings
 - data entry unordered list
 - list entry panel
 - set entry panel
 - widget
Copyright:
---

# Name

widget_listentry - widget::listentry widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [widget::listentry]{.lit} [0.1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::validator]{.lit} [0.1]{.optlit} 
[package]{.cmd} [require]{.sub} [widget::scrolledwindow]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [tooltip]{.lit} 
[package]{.cmd} [require]{.sub} [img::png]{.lit} 
[package]{.cmd} [require]{.sub} [msgcat]{.lit} 
[widget::listentry]{.cmd} [pathname]{.arg} [options]{.optarg} 
[widgetCmd]{.cmd} [destroy]{.sub} 
[widgetCmd]{.cmd} [configure]{.sub} 
[widgetCmd]{.cmd} [configure]{.sub} [option]{.arg} [value]{.arg} ... 
[widgetCmd]{.cmd} [configure]{.sub} [option]{.arg} 
[widgetCmd]{.cmd} [cget]{.sub} [option]{.arg} 
:::

*{\*}cmdprefix* **get**

*{\*}cmdprefix* **set** *values*

*{\*}cmdprefix* *text* *errvar*

*{\*}cmdprefix* *text*

*{\*}cmdprefix* *cookievar*

# Description

This package provides a megawidget for the interactive entry of ordered and unordered lists. For a simpler and more restricted megawidget please see the package **widget::listsimple**.

# Class api

The widget class supports a single command, for the creation of widgets.

**widget::listentry** *pathname* ?options?
: This command creates and configures new instances of the widget. For details on the available options please see section **Widget Options**. The result of the command is the pathname of the new widget.


# Instance api

All widget instances supported the following methods.

**widgetCmd** **destroy**
: This method destroys the widget. Any further access to the widget will generate errors. The result of the command is the empty string.

**widgetCmd** **configure**
: This method comes in three variants. This variant here returns a list containing the current configuration of the widget, i.e. the values for all options. For details on the available options please see section **Widget Options**.

**widgetCmd** **configure** *option* *value* ...
: This method comes in three variants. This variant here reconfigures the widget, setting the specified options to the given values. *Note* that it is not possible to change the construction-time only options. For details on the available options please see section **Widget General Options**. The result of the command is the empty string.

**widgetCmd** **configure** *option*
: This method comes in three variants. This variant here is an alias for the method **cget** below and identical to it.

**widgetCmd** **cget** *option*
: This method returns the current value of the specified *option*. For details on the available options please see section **Widget Options**.


# Widget options

This section explains all the options available to instances of **widget::listentry**. Please note that a few of the options can be set only at instance construction time. The majority of the options can however be set both during construction- and runtime.

## Widget construction-time only options

**-ordered** boolean
: This options tells the new widget instance whether the list it manages is ordered or not. If it is ordered the widget will show buttons with which the selected entries can be moved around, editing the order. The default is **false**, indicating an unordered list.

**-allow-duplicates** boolean
: This options tells the new widget instance whether we are allowed to add a string to the list multiple times, or not. The default is **false**, indicating that duplicates are not allowed.

**-values** cmdprefix
: This option specifies a callback for the management of a predefined list of strings a user may enter. If specified the widget will use a combobox instead of a plain entry field and fill its list during widget construction using the data delivered by this callback. The callback will be further invoked whenever a new value is entered into the main list, to save the extended list of predefined values. The signature of this callback is


*{\*}cmdprefix* **get**
: In this form the callback is expected to return a list of strings. The strings are loaded into the list of the internal combobox for quick access by the user. It will be invoked once, during widget construction, to load the list of predefined strings a user may enter.

*{\*}cmdprefix* **set** *values*
: In this form the callback is given a list of new strings and expected to save them somewhere for future use. The return value of the callback is ignored. This form is invoked whenever the user entered a new string into the main list. The order of strings in *values* represents the order used to show them in the combobox's list.


**-validate** cmdprefix
: This option specifies a callback which is invoked after every change of the contents of the internal entry field. The signature of this callback is


*{\*}cmdprefix* *text* *errvar*
: where *text* is the string to validate, and *errvar* the name of a variable the callback can store an error message into when it detects invalid data. The widget expects that the callback returns a boolean value, where **true** indicates that *text* is valid.


: The default validation, when no callback was specified, will treat the empty string as invalid, and everything else as valid. *Please note* that the widget will prevent the entry of duplicate values into the main list, regardless of the validity of the input otherwise. This is in keeping with that this widget is meant for the entry of unordered lists, essentially a set of strings.


**-transform** cmdprefix
: This option specifies a callback which is invoked whenever a newly entered element is moved from the entry field to the main list, or the entry field is validated, as part of a check for duplicates, if such are not allowed. The callback is given the text in the entry field and has to return the text which is actually added to, or checked against the list. The use case for this callback is essentially *input normalization*. The most simple case of such would be, for example the use of


```
string tolower
```

**to impose a standard letter**
: case on the data. More complex example can be thought of, like rewriting of multiple syntaxes of input to a canonical form. The signature of this callback is


*{\*}cmdprefix* *text*
: where *text* is the string to transform. The widget expects that the callback returns the transformed string.


The default is to not transform the entered strings.

**-browse** cmdprefix
: If this option is specified the widget will display a "Search" button and invoke the callback provided by the option whenever the user clicks on that button. The signature of the callback is


*{\*}cmdprefix* *cookievar*
: where the cookie variable provides access to context information the callback may wish to preserve between invokations. The initial value stored in the variable is the empty string. After that it is whatever the callback wishes to store. The widget expects that the callback returns a list of strings, which are then added to the list, modulo validity and duplicate checks.


By default there is no browse callback and no button shown.

## Widget general options

**-listvariable** varname
: This option specifies the variable holding the list to be manipulated by the widget. Any changes to the list outside of the widget are automatically imported into the widget. Similarly, all changes made to the list by the widget are automatically exported to this variable.

**-state** normal|disabled
: This option specifies the status of the widget, **normal** (= active), or **disabled**. A disabled widget can not be edited. The default is **normal**.

**-height** integer
: This option specifies the height of the internal listbox, in lines. The default is **20**.

**-skin-add** string
: ...see next...

**-skin-remove** string
: ...see next...

**-skin-up** string
: ...see next...

**-skin-down** string
: ...see next...

**-skin-browse** string
: ...see next...

**-skin-tip-add** string
: ...see next...

**-skin-tip-remove** string
: ...see next...

**-skin-tip-up** string
: ...see next...

**-skin-tip-down** string
: ...see next...

**-skin-tip-browse** string
: ...see next...

**-skin-tip-main** string
: ...see next...

**-skin-tip-entry** string
: ...see next...

**-skin-tip-list** string
: ...see next...

**-skin-tip-empty** string
: ...see next...

**-skin-tip-duplicate** string
: ...see next...

**-skin-tip-add-none** string
: ...see next...

**-skin-tip-remove-none** string
: ...see next...

**-skin-img-add** image
: ...see next...

**-skin-img-remove** image
: ...see next...

**-skin-img-up** string
: ...see next...

**-skin-img-down** string
: ...see next...

**-skin-img-browse** string
: ...see next...

**-skin-invalid-color** color
: These options all modify the appearance of the widget, i.e. its skin. All options taking a string argument influence the various labels shown, with the **-skin-tip-\*** options influencing the tooltips shown on hovering the over various parts in particular. All the strings are run through **msgcat** first, enabling text localization through message catalogs. The default values are keys into the message catalogs which are part of the package itself. The options taking images modify the images shown on the buttons for adding and removing elements of the list. They default to the PNG images distributed with the package itself. The single option taking a color value modifies the color used to highlight invalid data entered into the internal entry field of the widget. This option defaults to **yellow**.


# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widget::listentry* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
