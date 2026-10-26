---
CommandName: persistentSelection
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Enhanced PRIMARY selection
Links:
 - bindtags
 - ntext
 - text
 - widgetPlus
Copyright:
---

# Name

persistentSelection - Enhanced PRIMARY selection

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [persistentSelection]{.lit} [1.0]{.optlit} 
[persistentSelection::fixText]{.cmd} 
[persistentSelection::getClassicPrimarySel]{.cmd} [displayOf]{.optarg} [withOthers]{.optarg} 
[persistentSelection::getPrimarySel]{.cmd} [displayOf]{.optarg} 
[persistentSelection::report]{.cmd} [type]{.arg} [pathName]{.arg} 
:::

# Description

Consider a **Tk** widget that sets its **-exportselection** option to boolean **true**, thereby exporting its selection.  When the selection in the widget is canceled, by default **Tk** also cancels the **PRIMARY** selection.  In this situation, an attempt to read the **PRIMARY** selection, e.g. by a **<\<PasteSelection>>** event, will fail.

The **persistentSelection** package offers more convenient behavior.  It will sustain as the **PRIMARY** selection the last non-empty value set by any **Tk** widget that it monitors, as long as the **PRIMARY** selection is not claimed by another process, or by a widget that it does not monitor.

The **persistentSelection** package works by binding to the **<\<Selection>>** event on the widgets of interest, and using this binding to monitor any change of the selection in the widget.  Its commands are confined to the namespace **::persistentSelection**.

# Commands

**persistentSelection::fixText**
: Call this command once to resolve problems with **text** widgets that use the default **Text** bindtag (rather than **Ntext**).  See **Text widgets** for an explanation. The command adjusts some **Text** bindings to generate **<\<Selection>>** events; and it re-orders calls to the **text** widget **tag** command in the private command **::tk::TextSelectTo**, so that this command cooperates better with **persistentSelection**. These adjustments are needed only to older versions of **Tk**.  The command **persistentSelection::fixText** has no effect on sufficiently recent releases.  It can safely be called for any version of **Tk**.

**persistentSelection::getClassicPrimarySel** ?*displayOf*? ?*withOthers*?
: 


**•**
: *displayOf* - a **Tk** window path on the display to be interrogated (optional, default {**.**})

**•**
: *withOthers* - whether to return the **PRIMARY** selection if it is owned by another process or interpreter (optional, boolean, default **false**)


: A command to return the classic (non-persistent) form of the **PRIMARY** selection.  If the selection does not exist, or is sustained only by **persistentSelection**, the command returns the empty string.


**persistentSelection::getPrimarySel** ?*displayOf*?
: 


**•**
: *displayOf* - a **Tk** window on the display to be interrogated (optional, default {**.**})


: A command to return the value of the **PRIMARY** selection.  If the selection does not exist, the command returns the empty string.  The usual **Tk** commands are perfectly valid, but they raise an error if the selection does not exist.


**persistentSelection::report** *type* *pathName*
: 


**•**
: *type* - (value **text** or **entry**) classification of the widget whose selection has changed

**•**
: *pathName* - the **Tk** window path of the widget whose selection has changed


: To make package **persistentSelection** monitor a widget, this command must be bound to the **<\<Selection>>** event on that widget.  The command records changes in the widget's selection, and uses the information to sustain a non-empty **PRIMARY** selection on each display.


# Usage

## Script requirements

For each widget that will be monitored by **persistentSelection**, the command **persistentSelection::report** must be bound to event **<\<Selection>>** in one of the widget's binding tags.

For example, the developer may wish to use **persistentSelection** with every **text** and **entryPlus** widget in an application: this can be achieved by adding the **<\<Selection>>** binding to the **Text** and **EntryPlus** bindtags.  See **EXAMPLES**.

If **persistentSelection** is not required for all widgets of a particular class, the binding can be added to per-widget bindtags.  See **EXAMPLES**.

## Widget requirements

To be capable of being monitored by **persistentSelection**, a widget must satisfy three conditions:

**•**
: It must have an **-exportselection** option that allows it to export its selection to the **PRIMARY** selection.

**•**
: It must generate a **<\<Selection>>** event whenever its selection changes.

**•**
: its bindings to other events should be suitable - specifically, in versions of **Tk** older than **8.6.6**, a GUI event that extends or reduces the selection from one non-empty value to another should not use an intermediate state that has an empty selection, because this confuses **persistentStore**. The **Tk** and **Ttk** widgets that can export their selection are **text**, **entry**, **listbox**, **spinbox**, **ttk::entry**, **ttk::spinbox**, and **ttk::combobox**.


## Text widgets

In versions of **Tk** older than **8.6.9**, the **text** widget does not generate **<\<Selection>>** events in a few "corner cases" in which its selection changes.  These omissions can be corrected by changes to the **Text** bindings, in order to satisfy the second condition of **Widget requirements**.

In addition, versions of **Tk** older than **8.6.6** process selection events slightly differently from newer versions, and in combination with the **Text** bindings this confuses **persistentStore**.  If an upgrade to the current version of **Tcl/Tk** is not feasible, this problem can be resolved by making a slight modification to the widget bindings, in order to satisfy the third condition of **Widget requirements**.

Either the script should call the command **persistentSelection::fixText** to adjust the **Text** bindings and the commands that they call; or the widget can use the **Ntext** binding tag (for **ntext** version 1.0 or above) instead of the default **Text** bindtag.

In either case, the argument *type* supplied to command **persistentSelection::report** should have the value **text**.

## Entry, spinbox, ttk::entry, ttk::spinbox, and ttk::combobox widgets

The **entry**, **spinbox**, **ttk::entry**, **ttk::spinbox**, and **ttk::combobox** widgets do not generate a **<\<Selection>>** event when their selection changes, and therefore require modification.

The package **widgetPlus** provides **snit** wrappers **widgetPlus::entryPlus**, **widgetPlus::spinboxPlus**, **widgetPlus::ttkEntryPlus**, **widgetPlus::ttkSpinboxPlus**, and **widgetPlus::ttkComboboxPlus** respectively.  Each **widgetPlus** widget generates the required **<\<Selection>>** events.

In all these cases, the argument *type* supplied to command **persistentSelection::report** should have the value **entry**.  This argument determines how **persistentSelection** will inspect the widget's selection, and the commands that do so are the same for all these widgets.

## Listbox widgets

A similar wrapper has not been created for the **listbox** widget, which has the complication of permitting multiple selections.

# To do

**•**
: Test on a system with multiple displays.


# Bugs

This version of **persistentSelection** is intended to be compatible with all releases of **Tk** 8.5- and 8.6, and with the branches *core-8-5-branch*, *core-8-6-branch*, *revised_text*, and *trunk* in the source code repository for **Tk**.  Any incompatibility with any of these versions, for any **Tk** windowing system, should be reported as a bug. Please report such in the category *persistentSelection* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist).

# Examples

Each example uses **persistentSelection** to retain the last non-empty value of the selection in certain widgets.  Each example also includes the creation of sample widgets.

Monitor all **entryPlus** widgets.

```
package require widgetPlus
widgetPlus::entryPlus .ep
pack .ep

package require persistentSelection
bind EntryPlus <<Selection>> {::persistentSelection::report entry %W}
```

Monitor all **text** widgets that use the default **Text** bindings.

```
text .t
pack .t

package require persistentSelection
::persistentSelection::fixText
bind Text <<Selection>> {::persistentSelection::report text %W}
```

Monitor all **text** widgets that use the default **Text** bindings, and all **entryPlus** widgets.

```
text .t
pack .t

package require widgetPlus
widgetPlus::entryPlus .ep
pack .ep

package require persistentSelection
::persistentSelection::fixText
bind Text <<Selection>> {::persistentSelection::report text %W}
bind EntryPlus <<Selection>> {::persistentSelection::report entry %W}
```

Monitor all **text** widgets that use **Ntext** bindings.

```
text .t
pack .t

package require ntext
bindtags .t {.t Ntext . all}

package require persistentSelection
bind Ntext <<Selection>> {::persistentSelection::report text %W}
```

Monitor a single **entryPlus** widget **.ep**

```
package require widgetPlus
widgetPlus::entryPlus .ep
pack .ep

package require persistentSelection
bind .ep <<Selection>> {::persistentSelection::report entry %W}
```

Monitor a single **text** widget **.t**

```
text .t
pack .t

package require persistentSelection
bind .t <<Selection>> {::persistentSelection::report text %W}
```
