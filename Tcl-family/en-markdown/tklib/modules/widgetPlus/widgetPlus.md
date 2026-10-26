---
CommandName: widgetPlus
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Enhanced Entry, Spinbox, and Combobox Widgets with Undo/Redo and other useful features
Links:
 - BWidget
 - ComboBox
 - Entry
 - entry
 - persistentSelection
 - spinbox
 - text
 - ttk::combobox
 - ttk::entry
 - ttk::spinbox
Copyright:
---

# Name

widgetPlus - Enhanced Entry, Spinbox, and Combobox Widgets with Undo/Redo and other useful features

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [widgetPlus]{.lit} [1.0]{.optlit} 
[widgetPlus::entryPlus]{.cmd} [create]{.optarg} [pathName]{.arg} 
[widgetPlus::spinboxPlus]{.cmd} [create]{.optarg} [pathName]{.arg} 
[widgetPlus::ttkEntryPlus]{.cmd} [create]{.optarg} [pathName]{.arg} 
[widgetPlus::ttkSpinboxPlus]{.cmd} [create]{.optarg} [pathName]{.arg} 
[widgetPlus::ttkComboboxPlus]{.cmd} [create]{.optarg} [pathName]{.arg} 
[widgetPlus::EnableBWidget]{.cmd} 
[pathName]{.ins} [edit]{.sub} [arg arg]{.optdot} 
[pathName]{.ins} [edit]{.sub} [canredo]{.lit} 
[pathName]{.ins} [edit]{.sub} [canundo]{.lit} 
[pathName]{.ins} [edit]{.sub} [modified]{.lit} [boolean]{.optarg} 
[pathName]{.ins} [edit]{.sub} [redo]{.lit} 
[pathName]{.ins} [edit]{.sub} [reset]{.lit} 
[pathName]{.ins} [edit]{.sub} [separator]{.lit} 
[pathName]{.ins} [edit]{.sub} [undo]{.lit} 
:::

# Description

The **widgetPlus** package adds new features to the widgets **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox**, and **ttk::combobox**.

The new features are Undo and Redo operations, a **<\<Selection>>** event, and for the **Tk** (unthemed) widgets an **-inactiveselectbackground** option, and some minor fixes to bindings.  The new facilities closely follow those of the **text** widget.

The revised **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox**, and **ttk::combobox** widgets are created by the commands **widgetPlus::entryPlus**, **widgetPlus::spinboxPlus**, **widgetPlus::ttkEntryPlus**, **widgetPlus::ttkSpinboxPlus**, and **widgetPlus::ttkComboboxPlus** respectively.

For example, the **widgetPlus::entryPlus** widget is implemented as a *Snit* **snit::widgetadaptor** that wraps a **Tk** **entry** widget.  Its **winfo class** is **Entry**, and it uses a binding tag **EntryPlus** that replaces the **Entry** binding tag.  The other widgets are implemented in a similar way.

The package uses the namespace **::widgetPlus**, which exports (only) the five commands defined below that begin with a lower-case letter (**EnableBWidget** is not exported).  These commands can be imported into the global namespace, and for simplicity, descriptive text in this manual will henceforth omit the namespace qualifier.

```
namespace import ::widgetPlus::*
```

# Widget options

In addition to the usual options of the **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox**, and **ttk::combobox** widgets, the wrappers **entryPlus**, **spinboxPlus**, **ttkEntryPlus**, **ttkSpinboxPlus**, and **ttkComboboxPlus** provide the options below.

```
Command-Line Switch:    -inactiveselectbackground
Database Name:          inactiveSelectBackground
Database Class:         Foreground
```

: Specifies the color to use for the selection when the window does not have the input **focus**. If empty, **{}**, then no selection is shown when the window does not have the **focus**.  The **-inactiveselectbackground** option has no effect on the **Ttk** (themed) widgets **ttkEntryPlus**, **ttkSpinboxPlus**, and **ttkComboboxPlus**.


```
Command-Line Switch:    -maxundo
Database Name:          maxUndo
Database Class:         MaxUndo
```

: Specifies the maximum number of compound undo actions on the *undo stack*. A zero or a negative value imply an unlimited *undo stack*.


```
Command-Line Switch:    -undo
Database Name:          undo
Database Class:         Undo
```

: Specifies a *boolean* that says whether the undo mechanism is active or not.


# Commands

**widgetPlus::entryPlus** ?*create*? *pathName*
: Create an **entryPlus** widget; or convert an existing **entry** widget into an **entryPlus**.

**widgetPlus::spinboxPlus** ?*create*? *pathName*
: Create a **spinboxPlus** widget; or convert an existing **spinbox** widget into a **spinboxPlus**.

**widgetPlus::ttkEntryPlus** ?*create*? *pathName*
: Create a **ttkEntryPlus** widget; or convert an existing **ttk::entry** widget into a **ttkEntryPlus**.

**widgetPlus::ttkSpinboxPlus** ?*create*? *pathName*
: Create a **ttkSpinboxPlus** widget; or convert an existing **ttk::spinbox** widget into a **ttkSpinboxPlus**.

**widgetPlus::ttkComboboxPlus** ?*create*? *pathName*
: Create a **ttkComboboxPlus** widget; or convert an existing **ttk::combobox** widget into a **ttkComboboxPlus**.

**widgetPlus::EnableBWidget**
: Enable **widgetPlus** to modify **BWidget** **Entry** widgets and their compounds (such as the **BWidget** **ComboBox**).  The command creates a bindtag **BwEntryPlus** to replace the default bindtag **BwEntry**.  This operation is not performed when the package is loaded because it requires **BWidget** to be loaded first.  This command is not exported from namespace **::widgetPlus**.


# Widget commands

In addition to the usual commands of the **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox**, and **ttk::combobox** widgets, the wrappers **entryPlus**, **ttkEntryPlus**, **spinboxPlus**, **ttkSpinboxPlus**, and **ttkComboboxPlus** provide:

*pathName* **edit** ?*arg arg ...*?
: This command controls the undo mechanism and the *modified flag*. The exact behavior of the command depends on the option argument that follows the edit argument. The following forms of the command are currently supported:

*pathName* **edit canredo**
: Returns a *boolean* **true** if redo is possible, i.e. when the *redo stack* is not empty. Otherwise returns **false**.

*pathName* **edit canundo**
: Returns a *boolean* **true** if undo is possible, i.e. when the *undo stack* is not empty. Otherwise returns **false**.

*pathName* **edit modified** ?*boolean*?
: If *boolean* is not specified, returns the *modified flag* of the widget. The **insert**, **delete**, **edit undo** and **edit redo** commands, or (by using this command) the user, can set or clear the *modified flag*. If *boolean* is specified, sets the *modified flag* of the widget to *boolean*.

*pathName* **edit redo**
: When the **-undo** option is **true**, reapplies the last undone edits provided no other edits were done since then. Generates an error when the *redo stack* is empty. Does nothing when the **-undo** option is **false**.

*pathName* **edit reset**
: Clears the *undo stack* and *redo stack*.

*pathName* **edit separator**
: Included for completeness, but has no effect. (N.B. An implicit separator is added to the *undo stack* for each call to a widget command (e.g. **insert** or **delete**) that changes the widget contents.  These therefore separate the addition or removal of individual characters by typing, except that *cut* or *paste* operations are discrete.)

*pathName* **edit undo**
: Undoes the last edit action when the **-undo** option is **true**. An edit action is defined as a single **insert** or **delete** command that is recorded on the *undo stack*. Generates an error when the *undo stack* is empty. Does nothing when the **-undo** option is **false**.


# Bindings

## Class bindings

The class binding tag for different widgets has these default values:

**•**
: **entry**           uses **Entry**

**•**
: **spinbox**         uses **Spinbox**

**•**
: **ttk::entry**      uses **TEntry**

**•**
: **ttk::spinbox**    uses **TSpinbox**

**•**
: **ttk::combobox**   uses **TCombobox**

**•**
: **entryPlus**       uses **EntryPlus**

**•**
: **spinboxPlus**     uses **SpinboxPlus**

**•**
: **ttkEntryPlus**    uses **TEntryPlus**

**•**
: **ttkSpinboxPlus**  uses **TSpinboxPlus**

**•**
: **ttkComboboxPlus** uses **TComboboxPlus**


## Undo and redo

The **<\<Undo>>** and **<\<Redo>>** virtual events are mapped to these keyboard events:

**•**
: On X11 systems (Linux®, BSD®, Solaris®, etc):


**•**
: **<\<Undo>>** is mapped to **\<Control-z>**


**•**
: **<\<Redo>>** is mapped to **\<Control-Shift-z>**


**•**
: On Windows® systems:


**•**
: **<\<Undo>>** is mapped to **\<Control-z>**


**•**
: **<\<Redo>>** is mapped to **\<Control-y>**


**•**
: On Aqua® systems (i.e. Apple® macOS® or OS X®):


**•**
: **<\<Undo>>** is mapped to **\<Command-z>**


**•**
: **<\<Redo>>** is mapped to **\<Command-Shift-z>**


## Entryplus

The **EntryPlus** bindings are based on those of the **Entry** bindtag, with these changes:

**•**
: New bindings to **<\<Undo>>** and **<\<Redo>>**.

**•**
: An adjustment to the **<\<Paste>>** binding, so that it behaves the same way on X11 as on other windowing systems (i.e. it deletes the existing selection, if any exists).

**•**
: The removal of the antiquated **\<Insert>** binding.

**•**
: New bindings to **\<FocusIn>** and **\<FocusOut>**, to facilitate the implementation of the **-inactiveselectbackground** option.


## Spinboxplus

The **SpinboxPlus** bindings are based on those of the **Spinbox** bindtag, with the same changes as are made when converting **Entry** to **EntryPlus**.

## Tentryplus

The **TEntryPlus** bindings are based on those of the **TEntry** bindtag, with these changes:

**•**
: New bindings to **<\<Undo>>** and **<\<Redo>>**.


## Tspinboxplus

The **TSpinboxPlus** bindings are based on those of the **TSpinbox** bindtag, with these changes:

**•**
: New bindings to **<\<Undo>>** and **<\<Redo>>**.


## Tcomboboxplus

The **TComboboxPlus** bindings are based on those of the **TCombobox** bindtag, with these changes:

**•**
: New bindings to **<\<Undo>>** and **<\<Redo>>**.


# Virtual event <\<selection>>

Each **widgetPlus** widget generates a virtual event **<\<Selection>>** whenever the value of its selection changes.  This allows other **Tcl** code, for example the package **persistentSelection**, to monitor the selection in these widgets.

# Use with megawidgets

When an **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox**, or **ttk::combobox** is a component of a megawidget, it is often possible to apply **widgetPlus** to that component without modifying the megawidget code.

## Combobox (by bryan oakley)

A **combobox** with path **\$w** includes an **entry** widget **\$w.entry**, which uses the **Entry** binding tag.  Thus **widgetPlus** can be applied to the **combobox** after creation, using the command (see **EXAMPLES**)

```
entryPlus $w.entry -undo 1 -maxundo 0
```

## Combobox (bwidget)

A **BWidget** **ComboBox** with path **\$w** includes an **entry** widget **\$w.e**, which uses the **BwEntry** binding tag in place of the default tag **Entry**.

Package **widgetPlus** provides a replacement bindtag **BwEntryPlus**, but this is not computed when the package is loaded because it requires **BWidget** to be loaded first.  The command **::widgetPlus::EnableBWidget** must be called to provide **BwEntryPlus**, and then the **BWidget** **ComboBox** can be modified (see **EXAMPLES**)

```
::widgetPlus::EnableBWidget
entryPlus $w.e -undo 1 -maxundo 0
```

# To do

**•**
: Undo and Redo do not sync the value of the *modified flag* - they always set the value to *boolean* **true**.

**•**
: Undo and Redo do not sync the position of the insertion cursor.

**•**
: The **<\<Modified>>** event is not generated.

**•**
: Undo/Redo separators, and the **-autoseparators** option, as found in the **text** widget, are not implemented. An implicit separator is added for each call to a widget command (e.g. **insert** or **delete**) that changes the widget contents.  The **edit separator** command has no effect.  Separator functionality would be less useful for widgets such as **entryPlus** than it is for a **text** widget.

**•**
: Add an *overwrite* mode, toggled by **\<Insert>** on non-macOS® systems.


# Bugs

This version of **widgetPlus** is intended to be compatible with all releases of **Tk** 8.5 and 8.6, and with the branches *core-8-5-branch*, *core-8-6-branch*, and *trunk* in the source code repository for **Tk**.  Any incompatibility with any of these versions, for any **Tk** windowing system, should be reported as a bug. Please report such in the category *widgetPlus* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist).

# Examples

To create and map an **entryPlus** widget .ep with an unlimited Undo/Redo stack:

```
package require widgetPlus
widgetPlus::entryPlus .ep -undo 1 -maxundo 0
pack .ep
```

The same but using **namespace import**:

```
package require widgetPlus
namespace import widgetPlus::*
entryPlus .ep -undo 1 -maxundo 0
pack .ep
```

To convert an existing **entry** widget .ee into an **entryPlus** with an unlimited Undo/Redo stack:

```
entry .ee

    .
    .
    .

package require widgetPlus
widgetPlus::entryPlus .ee -undo 1 -maxundo 0
```

The same but using **namespace import**:

```
entry .ee

    .
    .
    .

package require widgetPlus
namespace import widgetPlus::*
entryPlus .ee -undo 1 -maxundo 0
```

Apply **widgetPlus** to a Bryan Oakley **combobox**:

```
package require combobox
combobox::combobox .cb

    .
    .
    .

package require widgetPlus
namespace import widgetPlus::*
entryPlus .cb.entry -undo 1 -maxundo 0
```

Apply **widgetPlus** to a **BWidget** **ComboBox**.  The command **::widgetPlus::EnableBWidget** must be called first.

```
package require BWidget
ComboBox .cb

    .
    .
    .

package require widgetPlus
::widgetPlus::EnableBWidget
namespace import widgetPlus::*

entryPlus .cb.e -undo 1 -maxundo 0
```

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *widgetPlus* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
