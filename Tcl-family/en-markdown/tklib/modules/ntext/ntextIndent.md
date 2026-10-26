---
CommandName: ntextIndent
title: ntextIndent
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: ntext Indentation for the Text Widget
Links:
 - bindtags
 - ntext
 - re_syntax
 - regexp
 - text
Keywords:
 - bindtags
 - re_syntax
 - regexp
 - text
Copyright:
---

# Name

ntextIndent - ntext Indentation for the Text Widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit}
[::ntext::new\_textCopy]{.cmd} [pathName]{.arg}
[::ntext::new\_textCut]{.cmd} [pathName]{.arg}
[::ntext::new\_textPaste]{.cmd} [pathName]{.arg}
[::ntext::syncIndentColor]{.cmd} [pathName]{.arg}
:::

# Description

The **ntext** package provides a binding tag named *Ntext* for use by text widgets in place of the default *Text* binding tag.

Tk's text widget may be configured to wrap lines of text that are longer than the width of the text area, a feature that is familiar from text editors and word processors.  A complete line of text (delimited by newlines, or by the beginning or end of the document) is called a "logical line".  When a logical line is wrapped onto more than one line of the display area, these fragments of the logical line are called "display lines".

If a logical line begins with whitespace, then wrapped display lines begin further to the left than the first display line, which can make the text layout untidy and difficult to read.  The *Ntext* binding tag provides facilities so that a text widget in *-wrap* *word* mode will automatically indent display lines (other than the first) to match the initial whitespace of the first display line.

This indentation is available to text widgets only in *-wrap* *word* mode.

# Commands

**::ntext::new\_textCopy** *pathName*
: Replacement for ::tk\_textCopy.

**::ntext::new\_textCut** *pathName*
: Replacement for ::tk\_textCut that also maintains *Ntext* indentation.

**::ntext::new\_textPaste** *pathName*
: Replacement for ::tk\_textPaste that also maintains *Ntext* indentation.

**::ntext::syncIndentColor** *pathName*
: Command to apply the current value of the variable **::ntext::indentColor** to existing lines in a text widget.  This command is useful if a text widget has been created, text has been inserted in the widget, *and then* the value of **::ntext::indentColor** is changed.


# Configuration options

The behavior of *Ntext* may be configured application-wide by setting the values of a number of namespace variables:

**::ntext::classicWrap**

- **0** - selects *Ntext* behaviour, i.e. display lines are indented to match the initial whitespace of the first display line of a logical line.

    No other action is required if this option, and the text widget's *-wrap* option, are set before any text is entered in the widget, and if text is entered and edited only by the mouse and keyboard.  If, instead, text is manipulated by the script, or if the text widget's *-wrap* option or the value of **::ntext::classicWrap** are changed while the widget holds text, then calls to *ntext* functions are needed to alter the indentation.  See the section [Indenting display lines] for detailed instructions.

- **1** - (default value) selects classic *Text* behaviour, i.e. no indentation.


**::ntext::indentColor**

- **{}** - if the value is the empty string, then the indent of wrapped display lines has the same color as the widget background.

- *color* - a valid Tk color to use for the indent of wrapped display lines (default value *#d9d9d9*).

    Coloring is implemented with the text widget tag option *-lmargincolor*, which is available from **Tk** 8.6.6 onwards.  *Ntext* indent coloring has no effect in earlier versions of **Tk**.

    The value of **::ntext::indentColor** will often be set at startup.  If the value is changed when text widgets already exist and contain text, those widgets can be updated by calling command **::ntext::syncIndentColor**.


*Advanced Use*

**::ntext::newWrapRegexp**

- the value is a regexp pattern that determines the character of a logical line to which display lines other than the first will be aligned.  The default value, **\[^\[:space:\]\]**, ensures alignment with the first non-whitespace character.


# Indenting display lines

To use *Ntext* 's display line indentation:

1. Set the variable **::ntext::classicWrap** to **0** (default value is **1**).  This enables bindings that will preserve indentation whenever the user modifies the widget contents using the keyboard and mouse.  If the widget already holds text, call **::ntext::wrapIndent** to initialise indentation.

    Further instructions apply if the program changes the widget's contents, wrap configuration, or indent configuration.

2. The program can change the text contents, e.g. by the .text insert command.  Such a change does not trigger a window binding, so the program should explicitly call function **::ntext::wrapIndent** after inserting text.

3. Auto-indentation occurs only if the widget is in *-wrap* *word* mode.  If the program changes to or from *-wrap* *word* when the widget is not empty, it should call **::ntext::wrapIndent** to format the widget's text.

4. If indentation is used, and then switched off by setting **::ntext::classicWrap** to **1**,  call **::ntext::wrapIndent** to remove indentation.


# Functions

**::ntext::wrapIndent** *textWidget* ?index1? ?index2?

- Adjust the indentation of a text widget.  Different cases are discussed below.


**::ntext::wrapIndent** *textWidget*

- Adjust the indentation of all the text in text widget *textWidget*.


**::ntext::wrapIndent** *textWidget* *index1*

- Adjust the indentation of a single logical line of a text widget - the line of *textWidget* that contains the index *index1*.


**::ntext::wrapIndent** *textWidget* *index1* *index2*

- Adjust the indentation of a range of logical lines of a text widget - the lines of *textWidget* that contain indices *index1* to *index2*.


*Usage*

- **::ntext::wrapIndent** should be called only if the script changes the widget's contents or display properties.  If the contents of the widget have been modified by the keyboard or mouse, it is not necessary for the script to call **::ntext::wrapIndent** because the appropriate calls are made automatically by the *Ntext* bindings.

- The script should normally call **::ntext::wrapIndent** if, for example, the script changes one of the following when the widget is not empty: the value of **::ntext::classicWrap**, or the widget's *-wrap* status, or the widget's tab spacing, or the font size, or the widget's contents.

- A call of the form **::ntext::wrapIndent** *textWidget* will always suffice, but if changes are needed only to certain lines, it is more efficient to specify those lines with the optional arguments ?index1?, ?index2?.

- If the widget is in *-word* *wrap* mode, and if **::ntext::classicWrap** is set to **0**, **::ntext::wrapIndent** will apply indentation to the logical lines within the range specified by the function's arguments.

- In other cases, i.e. if the widget is in *-word* *char* or *-word* *none* mode, or if **::ntext::classicWrap** is set to **1**,  **::ntext::wrapIndent** will remove the indentation of the logical lines within the range specified by the function's arguments.


# Bugs

This version of **ntext** is intended to be compatible with all releases of **Tk** 8.5, 8.6, and 8.7, and with the branches *core-8-5-branch*, *core-8-6-branch*, and *trunk* in the source code repository for **Tk**.  Any incompatibility with any of these versions, for any **Tk** windowing system, should be reported as a bug. Please report such in the category *ntext* of the [Tklib Trackers](https://core.tcl-lang.org/tklib/reportlist).

# Examples

To switch on *Ntext* 's indentation and use it in widget .t, using the default indent color *#d9d9d9*:

```
package require ntext
set ::ntext::classicWrap 0
text .t -wrap word
bindtags .t {.t Ntext . all}
```

To switch on *Ntext* 's indentation and use it in widget .t, without colored indents:

```
package require ntext
set ::ntext::classicWrap 0
set ::ntext::indentColor {}
text .t -wrap word
bindtags .t {.t Ntext . all}
```

To switch on *Ntext* 's indentation and use it in widget .t, coloring the indents black:

```
package require ntext
set ::ntext::classicWrap 0
set ::ntext::indentColor black
text .t -wrap word
bindtags .t {.t Ntext . all}
```

To decide later to switch off *Ntext* 's indentation:

```
set ::ntext::classicWrap 1
::ntext::wrapIndent .t
```

To decide later to switch *Ntext* 's indentation back on:

```
set ::ntext::classicWrap 0
::ntext::wrapIndent .t 1.0 end
```

To inject some text into the widget:

```
set foo [.t index end]
.t insert end {This line was added by the script, not the keyboard!}
::ntext::wrapIndent .t $foo end
```

To change the indentation color when a widget .t already holds text:

```
set ::ntext::indentColor black
::ntext::syncIndentColor .t
```

To switch to *-wrap* *char* mode:

```
.t configure -wrap char
::ntext::wrapIndent .t
```
