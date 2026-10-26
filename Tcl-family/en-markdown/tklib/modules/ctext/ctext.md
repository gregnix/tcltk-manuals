---
CommandName: ctext
title: ctext
ManualSection: n
Version: 3.3
TclPart: tklib
TclDescription: Ctext a text widget with highlighting support
Links:
 - re_syntax
 - text
Keywords:
 - syntax highlighting
 - text
 - widget
Copyright:
 - Copyright (c) George Peter Staplin <GeorgePS@XMission.com>
---

# Name

ctext - Ctext a text widget with highlighting support

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit}
[package]{.cmd} [require]{.sub} [ctext]{.lit} [3.3]{.optlit}
[ctext]{.cmd} [pathName]{.arg} [options]{.optarg}
[::ctext::addHighlightClass]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [keywordlist]{.arg}
[::ctext::addHighlightClassWithOnlyCharStart]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [char]{.arg}
[::ctext::addHighlightClassForSpecialChars]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [charstring]{.arg}
[::ctext::addHighlightClassForRegexp]{.cmd} [pathName]{.arg} [class]{.arg} [color]{.arg} [pattern]{.arg}
[::ctext::clearHighlightClasses]{.cmd} [pathName]{.arg}
[::ctext::getHighlightClasses]{.cmd} [pathName]{.arg}
[::ctext::deleteHighlightClass]{.cmd} [pathName]{.arg} [class]{.arg}
[::ctext::enableComments]{.cmd} [enable]{.arg}
[::ctext::disableComments]{.cmd} [enable]{.arg}
[pathName]{.ins} [highlight]{.sub} [startIndex]{.arg} [endIndex]{.arg}
[pathName]{.ins} [fastdelete]{.sub} [index1]{.arg} [index2]{.optarg}
[pathName]{.ins} [fastinsert]{.sub}
[pathName]{.ins} [copy]{.sub}
[pathName]{.ins} [cut]{.sub}
[pathName]{.ins} [paste]{.sub}
[pathName]{.ins} [append]{.sub}
[pathName]{.ins} [configure]{.sub} [option]{.arg} [value]{.arg} [...]{.optarg}
:::

# Description

The **ctext** package provides the ctext widget which is an enhanced text widget with support for configurable syntax highlighting and some extra commands.

Ctext overloads the text widget and provides new commands, named **highlight**, **copy**, **paste**,**cut**, **append**, and **edit**.  It also provides several commands that allow you to define classes. Each class corresponds to a tag in the widget.

# Commands

**ctext** *pathName* ?*options*?
: Creates and configures a ctext widget.


# Highlighting

Highlighting is controlled with text widget tags, that are called highlight classes. The *class* is a tag name and can be configured like any text widget tag. Four types of highlight classes are supported. All highlight classes are automatically used by the **highlight** method of the widget.

**::ctext::addHighlightClass** *pathName* *class* *color* *keywordlist*
: Add a highlighting class *class* to the ctext widget *pathName*. The highlighting will be done with the color *color*. All words in the *keywordlist* will be highlighted.

    ```
    	# highlight some tcl keywords
    	::ctext::addHighlightClass .t tclkeywords red [list set info interp uplevel upvar]
    ```

**::ctext::addHighlightClassWithOnlyCharStart** *pathName* *class* *color* *char*
: Add a highlighting class *class* to the ctext widget *pathName*. The highlighting will be done with the color *color*. All words starting with *char* will be highlighted.

    ```
    	::ctext::addHighlightClassWithOnlyCharStart .t vars blue \$
    ```

**::ctext::addHighlightClassForSpecialChars** *pathName* *class* *color* *charstring*
: Add a highlighting class *class* to the ctext widget *pathName*. The highlighting will be done with the color *color*. All chars in *charstring* will be highlighted.

**::ctext::addHighlightClassForRegexp** *pathName* *class* *color* *pattern*
: Add a highlighting class *class* to the ctext widget *pathName*. The highlighting will be done with the color *color*. All text parts matching the regexp *pattern* will be highlighted.

**::ctext::clearHighlightClasses** *pathName*
: Remove all highlight classes from the widget *pathName*.

**::ctext::getHighlightClasses** *pathName*
: List all highlight classes for the widget *pathName*.

**::ctext::deleteHighlightClass** *pathName* *class*
: Delete the highlight class *class* from the widget *pathName*

**::ctext::enableComments** *enable*
: Enable C comment highlighting. The *class* for c-style comments is **\_cComment**. The C comment highlighting is disabled by default.

**::ctext::disableComments** *enable*
: Disable C comment highlighting.


# Widget commands

Each ctext widget created with the above command supports the following commands and options in addition to the standard text widget commands and options.

*pathName* **highlight** *startIndex* *endIndex*
: Highlight the text between *startIndex* and *endIndex*.

*pathName* **fastdelete** *index1* ?*index2*?
: Delete text range without updating the highlighting. Arguments are identical to the *pathName* **delete** command inherited from the standard text widget.

*pathName* **fastinsert**
: Insert text without updating the highlighting. Arguments are identical to the *pathName* **insert** command inherited from the standard text widget.

*pathName* **copy**
: Call **tk\_textCopy** for the ctext instance.

*pathName* **cut**
: Call **tk\_textCut** for the ctext instance.

*pathName* **paste**
: Call **tk\_textPaste** for the ctext instance.

*pathName* **append**
: Append the current selection to the clipboard.

*pathName* **configure** *option* *value* ?...?
: Set the options for the ctext widget. Each option name must be followed the new value.


# Widget options

**-linemap**
: Creates (-linemap 1) or deletes (-linemap 0) a line number list on the left of the widget. The default is to have a linemap displayed.

**-linemapfg**
: Changes the foreground of the linemap. The default is the same color as the main text widget.

**-linemapbg**
: Changes the background of the linemap. The default is the same color as the main text widget.

**-linemap\_select\_fg**
: Changes the selected line foreground.  The default is black.

**-linemap\_select\_bg**
: Changes the selected line background.  The default is yellow.

**-linemap\_mark\_command**
: Calls a procedure or command with the *pathName* of the ctext window, the *type* which is either **marked** or **unmarked**, and finally the line number selected. The proc prototype is:

    ```
    proc linemark_cmd {win type line}.
    ```

    See also ctext\_test\_interactive.tcl

**-highlight**
: Takes a boolean value which defines whether or not to highlight text which is inserted or deleted.  The default is 1.

**-linemap\_markable**
: Takes a boolean value which specifies whether or not lines in the linemap are markable with the mouse.  The default is 1.


# Example

```
	package require Tk
	package require ctext

	proc main {} {
	pack [frame .f] -fill both -expand 1
	pack [scrollbar .f.s -command {.f.t yview}] -side right -fill y

	pack [ctext .f.t -bg black -fg white -insertbackground yellow  -yscrollcommand {.f.s set}] -fill both -expand 1

	ctext::addHighlightClass .f.t widgets purple  [list ctext button label text frame toplevel  scrollbar checkbutton canvas listbox menu menubar menubutton  radiobutton scale entry message tk_chooseDir tk_getSaveFile  tk_getOpenFile tk_chooseColor tk_optionMenu]

	ctext::addHighlightClass .f.t flags orange  [list -text -command -yscrollcommand  -xscrollcommand -background -foreground -fg -bg  -highlightbackground -y -x -highlightcolor -relief -width  -height -wrap -font -fill -side -outline -style -insertwidth  -textvariable -activebackground -activeforeground -insertbackground  -anchor -orient -troughcolor -nonewline -expand -type -message  -title -offset -in -after -yscroll -xscroll -forward -regexp -count  -exact -padx -ipadx -filetypes -all -from -to -label -value -variable  -regexp -backwards -forwards -bd -pady -ipady -state -row -column  -cursor -highlightcolors -linemap -menu -tearoff -displayof -cursor  -underline -tags -tag]

	ctext::addHighlightClass .f.t stackControl red  {proc uplevel namespace while for foreach if else}
	ctext::addHighlightClassWithOnlyCharStart .f.t vars mediumspringgreen "\$"
	ctext::addHighlightClass .f.t variable_funcs gold {set global variable unset}
	ctext::addHighlightClassForSpecialChars .f.t brackets green {[]{}}
	ctext::addHighlightClassForRegexp .f.t paths lightblue {\.[a-zA-Z0-9\_\-]+}
	ctext::addHighlightClassForRegexp .f.t comments khaki {#[^\n\r]*}
	.f.t fastinsert end [info body main]

	pack [frame .f1] -fill x

	.f.t highlight 1.0 end

	pack [button .f1.exit -text Exit -command exit] -side left

	pack [entry .e] -side bottom -fill x
	.e insert end "ctext::deleteHighlightClass .f.t "
	bind .e <Return> {eval [.e get]}
	}
	main
```

Further examples are in the source package for ctext.

# Thanks

Kevin Kenny, Neil Madden, Jeffrey Hobbs, Richard Suchenwirth, Johan Bengtsson, Mac Cody, Günther, Andreas Sievers, and Michael Schlenker.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *ctext* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Copyright

```
Copyright (c) George Peter Staplin <GeorgePS@XMission.com>
```
