---
CommandName: shtmlview
ManualSection: n
Version: 1.1.2
TclPart: tklib
TclDescription: Basic HTML and Markdown viewer widget
Links:
 - text
Keywords:
 - html
 - text
 - widget
Copyright:
 - Copyright (c) 2018-2022, Detlef Groth <detlef(at)dgroth(dot)de>
 - Copyright (c) 2009, Robert Heller
 - Copyright (c) 2000, Clif Flynt
 - Copyright (c) 1995-1999, Stephen Uhler
---

# Name

shtmlview - Extended Tcl/Tk text widget with basic support for rendering of HTML and Markdown

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [Markdown]{.lit} [;#]{.lit} [optional]{.lit} [Markdown]{.lit} [support]{.lit} 
[package]{.cmd} [require]{.sub} [img::jpeg]{.lit} [;#]{.lit} [optional]{.lit} [jpeg]{.lit} [image]{.lit} [support]{.lit} 
[package]{.cmd} [require]{.sub} [shtmlview::shtmlview]{.lit} [1.1.2]{.optlit} 
[::shtmlview::converter]{.cmd} [extension]{.arg} [description]{.arg} [cmdprefix]{.arg} 
[::shtmlview::shtmlview]{.cmd} [pathName]{.arg} [options]{.optarg} 
[pathName]{.ins} [back]{.sub} 
[pathName]{.ins} [browse]{.sub} [filename]{.arg} [args]{.optarg} 
[pathName]{.ins} [dosearch]{.sub} [string]{.arg} [direction]{.arg} 
[pathName]{.ins} [edittext]{.sub} [cmd]{.arg} [options]{.optarg} 
[pathName]{.ins} [editView]{.sub} 
[pathName]{.ins} [forward]{.sub} 
[pathName]{.ins} [getFiles]{.sub} 
[pathName]{.ins} [getHistory]{.sub} 
[pathName]{.ins} [getEditWidget]{.sub} 
[pathName]{.ins} [getTextWidget]{.sub} 
[pathName]{.ins} [helptext]{.sub} [cmd]{.arg} [options]{.optarg} 
[pathName]{.ins} [home]{.sub} 
[pathName]{.ins} [open]{.sub} 
[pathName]{.ins} [reload]{.sub} 
[pathName]{.ins} [render]{.sub} [text]{.arg} [ext]{.optarg} 
[pathName]{.ins} [sourceView]{.sub} 
[pathName]{.ins} [url]{.sub} 
:::

# Description

The **shtmlview::shtmlview** package provides a pure Tcl/Tk widget of the same name to render and display basic HTML and Markdown files and string.

Some history: The widget is based on the **htmllib** library developed in the 90ties by Stephen Uhler and Clif Flynt. In 2009 Robert Heller wrapped this library into the excellent mega-widget framework **snit**. The resulting widget was however tied directly into a help system. The author of this document first just isolated the display part and then added some functions such as changing font size and a few buttons in the toolbar. Then a rudimentary display of data tables was added. Even later support for inline images and extended keybindings and Markdown support was added.

The widget is *not* a web browser. It only supports relative links in the local filesystem.  It does *not* support style sheets. It does not support http(s) links nor images. It is thought of as a last fallback to use in cases where no other possibilities exists to display HTML or Markdown markup from a Tk application.

Use cases are as a help viewer and wherever the developer has control about the used html tags.

Comments and feedbacks are welcome.

The **shtmlview::shtmlview** widget overloads the text widget and provides new commands and options. These are explained in the sections **WIDGET COMMANDS** and **WIDGET OPTIONS**.

Note that the file "*shtmlview.tcl*" is not only a package but also a standalone application for the direct viewing of Markdown and HTML files. Invoke it as

```
 tclsh shtmlview.tcl filename.html
```

in a terminal.

The API described in this document is not the whole API offered by the snit object **::shtmlview::shtmlview**. Instead, it is the subset of that API that is expected not to change in future versions.

# Commands

**::shtmlview::converter** *extension* *description* *cmdprefix*
: Registers a conversion command prefix (*cmdprefix*) for files having the *extension*. The *description* is a short summary of the kind of files expected to have that extension. The result of the command is the empty string. Whenever an shtmlview widget encounters a file with the specified *extension* it will invoke the registered command prefix with one argument, the path to the file to convert. The result of the invokation is expected to be the HTML to render and display. See section **EXTENSIONS** for an example.

**::shtmlview::shtmlview** *pathName* ?*options*?
: Creates and configures the shtmlview widget *pathName*. The result of the command is the *pathName*. An error is thrown if a widget for *pathName* already exists. An error is also thrown if the parent for *pathName* does not exist. The recognized options are explained in section **WIDGET OPTIONS**. The methods of the new widget are explained in section **WIDGET COMMANDS**.


# Widget options

Use method **helptext** to configure the internal text widget.

**-browsecmd** cmd
: Each time a HTML or Markdown page is rendered the specified *cmd* command is invoked. The actual URL is appended as first argument to the command.

**-closebutton** boolean
: If **true** (default) a close button is shown in the toolbar. This is useful if the widget is the sole child of a toplevel widget.

**-historycombo** boolean
: If **true**, and the **tile** package is available, then a **ttk::combobox** to show page history is added to the toolbar. Defaults to **false**. Can be only set at widget creation.

**-home** string
: Sets the homepage filename of the widget. If not set, the first page browsed to will be automatically set as the home page.

**-tablesupport** boolean
: If **true** (default) some table support is provided. This will have some undesired results if table tags are misused as markup tool. Simple html tables with **th** and **td** tags should however display well if no internal markup inside of those tags is used.

**-toolbar** boolean
: If **true** (default) a toolbar will be displayed at the top. The toolbar will provide standard buttons for the methods **back**, **forward** and **home**, as well as search facilities. Defaults to **true**.


# Widget commands

Each shtmlview widget created with the above command supports the following commands and options:

*pathName* **back**
: Displays the previous HTML and Markdown page in the browsing history if any.

*pathName* **browse** *filename* ?args?
: Displays the HTML or Markdown text contained in the named file. Any additional arguments, while also file names, are just added to the history stack. They can be walked to using the history keys, **f** and **b**.

*pathName* **dosearch** *string* *direction*
: Search for and highlight the given string starting from the current index in the specified direction. The direction has to be either **forward** (default) or **backwards**.

*pathName* **edittext** *cmd* ?*options*?
: This command exposes the internal text editor widget for configuration. See the following example:


```
    ::shtmlview::shtmlview .help
    .help browse index.md
    .help editView
    .help edittext configure -background salmon
```

*pathName* **editView**
: This command switches the widget from viewing to editing.  In this mode the user is able to edit and change the currently loaded file. To switch to a non-editable source display instead see **sourceView** below.


```
    ::shtmlview::shtmlview .help
    .help browse index.md
    .help editView
```

*pathName* **forward**
: Displays the next HTML or Markdown page in the browsing history if any.

*pathName* **getFiles**
: This command returns a list of all visited files. Duplicates and anchor links are removed from the raw data.

*pathName* **getHistory**
: This command returns a list of the current history of visited files and anchors.

*pathName* **getEditWidget**
: This commands returns the internal pathname of the text editor widget used for editing the current document. This enables the developer to directly access it, if required or desired. This is dangerous. See also **edittext**, above.

*pathName* **getTextWidget**
: This commands returns the internal pathname of the internal viewer text widget. This enables the developer to directly access it, if required or desired. This is dangerous. See also **helptext**, below.

*pathName* **helptext** *cmd* ?*options*?
: This command exposes the internal viewer text widget for configuration. See the following example:


```
    ::shtmlview::shtmlview .help
    .help browse index.html
    .help helptext configure -background yellow
```

*pathName* **home**
: Displays either the page set by option **-home**, or the first page **browse** was called for.

*pathName* **open**
: Uses a standard file open dialog to select a document in any of the supported formats for display, and then renders that file, if any.

*pathName* **reload**
: Reloads and redisplays the currently shown page.

*pathName* **render** *text* ?ext?
: Renders the given *text* in the viewer. If an extension *ext* is specified the string is assumed to be in the associated format, and the associated converter is used. Otherwise the string is considered to be either HTML or Markdown.  To be treated as HTML the *text* has to start with a recognized HTML tag. In any other case it is considered to be Markdown.

*pathName* **sourceView**
: This command switches the widget from viewing the current document itself to viewing the source of that document. To switch to a editable source display see **editView** above.


```
    ::shtmlview::shtmlview .help
    .help browse index.md
    .help sourceView
```

*pathName* **url**
: Returns the currently shown URL.


# Bindings for the widget

The following keys are bound to the widget for navigation and other actions:

**\<cursor>**
: Standard cursor movement in the view

**b**
: Back - display previous page in history

**f**
: Forward - display next page in history

**p**
: Previous - Move cursor to previous search match

**n**
: Next - Move cursor to next search match

**q**
: Remove current page from history. Implies **f**.

**r**
: Start search backward

**s**
: Start search forward

**Ctrl-E**
: Toggle edit mode

**Ctrl-s**
: In edit mode, save page

**Ctrl-r**
: Reload current page

**Ctrl-u**
: Toggle source vs rendered views

**Return**
: Follow link under cursor

**TAB**
: Move cursor to next link on current page


# Example

```
    package require shtmlview::shtmlview
    proc browsed {url} {
        puts "You browsed $url"
    }
    ::shtmlview::shtmlview .help -toolbar true -browsecmd browsed
    .help browse index.html
    pack .help -fill both -expand true -side left
    package require Markdown
    .help browser test.md
```

More examples can be found in the sources of the package.

# Extensions

While the package natively only support HTML documents, and Markdown documents if the supporting **Markdown** package is available, it is possible to extend the range of supported formats by means of a plugin mechanism.

The main entry point to that system is the **shtmlview::converter** command. With it is possible to register a document format and an associated conversion command. The format is identified by its file extension, like, for example "*.md*", "*.man*", etc. The conversion command is expected to convert the content of the file given to it into HTML for display.

The packages **shtmlview::doctools** and **shtmlview::mkdoc** are examples of such plugins. The first provides support for the *doctools* format used by both *Tcllib* and *Tklib* for their manpages, while the second provides support for *mkdoc*-enhanced Tcl source files. In other words, Tcl files with embedded documentation in *mkdoc* syntax.

Enclosed below the bare Tcl code of the **shtmlview::mkdoc** package:

```
    package require shtmlview::shtmlview
    package require mkdoc::mkdoc

    ::shtmlview::converter .tcl {Tcl+mkdoc files}   ::shtmlview::mkdoc
    ::shtmlview::converter .tm  {Tcl+mkdoc modules} ::shtmlview::mkdoc

    proc ::shtmlview::mkdoc {url} {
	close [file tempfile htmltemp .html]

	mkdoc::mkdoc $url $htmltemp -html

	if {[catch {
	    open $htmltemp r
	} result]} {
	    return -code error "Cannot open $url: $result"
	}

	set html [read $result]
	close $result
	file delete $htmltemp

	return $html
    }

    package provide shtmlview::mkdoc 0.1
```

It is of course possible to write plugins which use an external application like **pandoc** to generate the HTML to render, instead of a Tcl package.

And it is of course also possible to register conversion commands directly from the application using this package, instead of going through a separate package.

# Changelog

**2022-02-25 version 0.9.2**
: 


**•**
: Fix for **tk_textCopy** and documentation update


**2022-03-06 version 0.9.3**
: 


**•**
: Support for MouseWheel bindings

**•**
: Fixing hyperlinks to http(s) links

**•**
: Support for file-anchor links like **file.html#anchor**

**•**
: Support for **#** as link to the top

**•**
: Thanks to aplsimple for suggestions and bug reports


**2022-03-26 version 1.0.0**
: 


**•**
: HTML 3.2 tags div, sub, sup, small, big

**•**
: Initial support for Markdown files

**•**
: Initial support for base64 encoded inline image files

**•**
: Support for JPEG images if the **img::jpeg** package is available

**•**
: Support for SVG images if either **critcl** and *librsvg-dev(el)* or terminal application **rsvg-convert** or **cairosvg** are available

**•**
: Back and forward as well for anchors

**•**
: First and last browse entry buttons for history

**•**
: History with full file path to allow directory changes

**•**
: Improved usage line and install option

**•**
: Keyboard bindings for next and previous search

**•**
: Return and tab for links

**•**
: Historycombo option

**•**
: Toolbar fix

**•**
: Browse fix for non-existing files

**•**
: Removed unused css/stylesheet and web forms code

**•**
: Thanks to pepdiz for bug-reports and suggestions


**2022-04-XX version 1.1.0**
: 


**•**
: Keybinding Ctrl-u to source view for HTML and Markdown files

**•**
: Keybinding Ctrl-Shift-e to use a simple text editor for file editing

**•**
: File open dialog now remembers the last directory and the last file extension

**•**
: File close button added with option -closebutton, useful for toplevel windows

**•**
: Some backslash fixes for Markdown links

**•**
: Adding span tag for styling

**•**
: Adding render method to read HTML directly without filename

**•**
: Adding plugin structure for additional file types like Tcllib doctools, or mkdoc

**•**
: Tcl doctools support resides in its own package

**•**
: Tcl mkdoc supports resides in its own package


# Todo

**•**
: Markdown rendering using tcllib package **Markdown** in case an URL ends with "*.md*" (done)

**•**
: Support for SVG images for instance using [svgconvert](https://wiki.tcl-lang.org/page/svgconvert), at least on Linux/Windows

**•**
: More tags, see tag history add 3.2 tags: *http://www.martinrinehart.com/frontend-engineering/engineers/html/html-tag-history.html* (done)

**•**
: Source view using Ctrl-u (done)

**•**
: Edit view using Ctrl-Shift-e

**•**
: Fixing mouse wheel issues


# Thanks

Stephen Uhler, Clif Flynt and Robert Heller, they provided the majority of the code in this widget.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such to the author of this package. Please also report any ideas for enhancements you may have for either package and/or documentation.

# Code copyright

BSD License type:

Sun Microsystems, Inc.  The following terms apply to all files a ssociated with the software unless explicitly disclaimed in individual files.

The authors hereby grant permission to use, copy, modify, distribute, and license this software and its documentation for any purpose, provided that existing copyright notices are retained in all copies and that this notice is included verbatim in any distributions. No written agreement, license, or royalty fee is required for any of the authorized uses.  Modifications to this software may be copyrighted by their authors and need not follow the licensing terms described here, provided that the new terms are clearly indicated on the first page of each file where they apply.

In no event shall the authors or distributors be liable to any party for direct, indirect, special, incidental, or consequential damages arising out of the use of this software, its documentation, or any derivatives thereof, even if the authors have been advised of the possibility of such damage.

The authors and distributors specifically disclaim any warranties, including, but not limited to, the implied warranties of merchantability, fitness for a particular purpose, and non-infringement. This software is provided on an "as is" basis, and the authors and distributors have no obligation to provide maintenance, support, updates, enhancements, or modifications.

RESTRICTED RIGHTS: Use, duplication or disclosure by the government is subject to the restrictions as set forth in subparagraph (c) (1) (ii) of the Rights in Technical Data and Computer Software Clause as DFARS 252.227-7013 and FAR 52.227-19.

# Copyright

```
Copyright (c) 2018-2022, Detlef Groth <detlef(at)dgroth(dot)de>
Copyright (c) 2009, Robert Heller
Copyright (c) 2000, Clif Flynt
Copyright (c) 1995-1999, Stephen Uhler
```
