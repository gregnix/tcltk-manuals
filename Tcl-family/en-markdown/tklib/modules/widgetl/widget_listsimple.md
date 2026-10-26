---
CommandName: widget_listsimple
title: widget_listsimple
ManualSection: n
Version: 0.1.2
TclPart: tklib
TclDescription: widget::listsimple widget
Keywords:
 - data entry lists
 - data entry set of strings
 - data entry unordered list
 - list entry panel
 - set entry panel
 - widget
Copyright:
---

# Name

widget\_listsimple - widget::listsimple widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [widget::listsimple]{.lit} [0.1.2]{.optlit}
[package]{.cmd} [require]{.sub} [widget::validator]{.lit} [0.1]{.optlit}
[package]{.cmd} [require]{.sub} [widget::scrolledwindow]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [tooltip]{.lit}
[package]{.cmd} [require]{.sub} [img::png]{.lit}
[package]{.cmd} [require]{.sub} [msgcat]{.lit}
[widget::listsimple]{.cmd} [pathname]{.arg} [options]{.optarg}
[widgetCmd]{.cmd} [destroy]{.lit}
[widgetCmd]{.cmd} [configure]{.lit}
[widgetCmd]{.cmd} [configure]{.lit} [option]{.arg} [value]{.arg} ...
[widgetCmd]{.cmd} [configure]{.lit} [option]{.arg}
[widgetCmd]{.cmd} [cget]{.lit} [option]{.arg}
[{\*}cmdprefix]{.ins} [get]{.sub}
[{\*}cmdprefix]{.ins} [set]{.sub} [values]{.arg}
[{\*}cmdprefix]{.ins} [text]{.sub} [errvar]{.arg}
:::

# Description

This package provides a megawidget for the interactive entry of unordered lists. For a megawidget allowing the entry of ordered lists, and more, please see the package [widget::listentry][widget_listentry].

# Class API

The widget class supports a single command, for the creation of widgets.

**widget::listsimple** *pathname* ?options?
: This command creates and configures new instances of the widget.

    For details on the available options please see section [Widget options].

    The result of the command is the pathname of the new widget.


# Instance API

All widget instances supported the following methods.

**widgetCmd** **destroy**
: This method destroys the widget. Any further access to the widget will generate errors.

    The result of the command is the empty string.

**widgetCmd** **configure**
: This method comes in three variants. This variant here returns a list containing the current configuration of the widget, i.e. the values for all options.

    For details on the available options please see section [Widget options].

**widgetCmd** **configure** *option* *value* ...
: This method comes in three variants. This variant here reconfigures the widget, setting the specified options to the given values.

    *Note* that it is not possible to change the construction-time only options.

    For details on the available options please see section [Widget General options].

    The result of the command is the empty string.

**widgetCmd** **configure** *option*
: This method comes in three variants. This variant here is an alias for the method **cget** below and identical to it.

**widgetCmd** **cget** *option*
: This method returns the current value of the specified *option*.

    For details on the available options please see section [Widget options].


# Widget options

This section explains all the options available to instances of **widget::listsimple**. Please note that a few of the options can be set only at instance construction time. The majority of the options can however be set both during construction- and runtime.

## Widget construction-time only options

**-values** cmdprefix
: This option specifies a callback for the management of a predefined list of strings a user may enter.

    If specified the widget will use a combobox instead of a plain entry field and fill its list during widget construction using the data delivered by this callback. The callback will be further invoked whenever a new value is entered into the main list, to save the extended list of predefined values.

    The signature of this callback is

    *{\*}cmdprefix* **get**
    : In this form the callback is expected to return a list of strings. The strings are loaded into the list of the internal combobox for quick access by the user.

        It will be invoked once, during widget construction, to load the list of predefined strings a user may enter.

    *{\*}cmdprefix* **set** *values*
    : In this form the callback is given a list of new strings and expected to save them somewhere for future use.

        The return value of the callback is ignored.

        This form is invoked whenever the user entered a new string into the main list. The order of strings in *values* represents the order used to show them in the combobox's list.


**-validate** cmdprefix
: This option specifies a callback which is invoked after every change of the contents of the internal entry field. The signature of this callback is

    *{\*}cmdprefix* *text* *errvar*
    : where *text* is the string to validate, and *errvar* the name of a variable the callback can store an error message into when it detects invalid data.

        The system expects that the callback returns a boolean value, where **true** indicates that *text* is valid.


    The default validation, when no callback was specified, will treat the empty string as invalid, and everything else as valid.

    *Please note* that the widget will prevent the entry of duplicate values into the main list, regardless of the validity of the input otherwise. This is in keeping with that this widget is meant for the entry of unordered lists, essentially a set of strings.


## Widget General options

**-listvariable** varname
: This option specifies the variable holding the list to be manipulated by the widget. Any changes to the list outside of the widget are automatically imported into the widget. Similarly, all changes made to the list by the widget are automatically exported to this variable.

**-skin-add** string
: see below ...

**-skin-remove** string
: see below ...

**-skin-tip-add** string
: see below ...

**-skin-tip-remove** string
: see below ...

**-skin-tip-main** string
: see below ...

**-skin-tip-entry** string
: see below ...

**-skin-tip-list** string
: see below ...

**-skin-tip-empty** string
: see below ...

**-skin-tip-duplicate** string
: see below ...

**-skin-tip-add-none** string
: see below ...

**-skin-tip-remove-none** string
: see below ...

**-skin-img-add** image
: see below ...

**-skin-img-remove** image
: see below ...

**-skin-invalid-color** color
: These options all modify the appearance of the widget, i.e. its skin.

    All options taking a string argument influence the various labels shown, with the **-skin-tip-\*** options influencing the tooltips shown on hovering the over various parts in particular.

    All the strings are run through **msgcat** first, enabling text localization through message catalogs. The default values are keys into the message catalogs which are part of the package itself.

    The options taking images modify the images shown on the buttons for adding and removing elements of the list. They default to the PNG images distributed with the package itself.

    The single option taking a color value modifies the color used to highlight invalid data entered into the internal entry field of the widget. This option defaults to **yellow**.


# Example

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widget::listsimple* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.


[widget_listentry]: widget_listentry.md
