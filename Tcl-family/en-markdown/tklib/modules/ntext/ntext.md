---
CommandName: ntext
title: ntext
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Alternative Bindings for the Text Widget
Links:
 - bindtags
 - ntextBindings
 - ntextIndent
 - ntextWordBreak
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

ntext - Alternative Bindings for the Text Widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit}
[::ntext::new\_textCopy]{.cmd} [pathName]{.arg}
[::ntext::new\_textCut]{.cmd} [pathName]{.arg}
[::ntext::new\_textPaste]{.cmd} [pathName]{.arg}
[::ntext::syncIndentColor]{.cmd} [pathName]{.arg}
[::ntext::syncTabColor]{.cmd} [pathName]{.arg}
:::

# Description

The purpose of the **ntext** package is to make the text widget behave more like other text-editing applications. It makes the text widget more useful for implementing a text editor, and makes it behave in a way that will be more familiar to most users.

The package provides a binding tag named *Ntext* for use by text widgets in place of the default *Text* binding tag.

Package **ntext** 's functions and variables are contained entirely in the **::ntext** namespace; its other code is contained in the binding tag *Ntext*.  **ntext** has no exports to the global or other namespaces, and no new widget commands.  It uses modified copies of the **Tk** code, leaving the original code, and the *Text* binding tag, unchanged.

The differences between the *Ntext* binding tag and the default *Text* binding tag are in three categories:

- Some *Text* bindings behave differently from most text-editing applications.  *Ntext* gives these bindings more familiar behaviour.  For details see *ntextBindings*.

- When a logical line with leading whitespace is word-wrapped onto more than one display line, the wrapped display lines begin further to the left than the first display line, which can make the text layout untidy and difficult to read.  *Ntext* can indent the wrapped lines to match the leading whitespace of the first display line (this facility is switched off by default).  For details see *ntextIndent*.

- When the user navigates or selects text, **Tcl/Tk** sometimes needs to detect word boundaries.  *Ntext* provides improved rules for word boundary detection.  For details see *ntextWordBreak*.


The remainder of this page describes the basic use and configuration of all three aspects of *Ntext*.  For more detailed information on the different facilities of *Ntext*, see the pages *ntextBindings*, *ntextIndent*, and *ntextWordBreak*.

See Section [Example] for how to apply the *Ntext* binding tag in place of the *Text* binding tag.

# Commands

**::ntext::new\_textCopy** *pathName*
: Replacement for ::tk\_textCopy.

**::ntext::new\_textCut** *pathName*
: Replacement for ::tk\_textCut that also maintains *Ntext* indentation (see *ntextIndent*).

**::ntext::new\_textPaste** *pathName*
: Replacement for ::tk\_textPaste that also maintains *Ntext* indentation (see *ntextIndent*).

**::ntext::syncIndentColor** *pathName*
: Command to apply the current value of the variable **::ntext::indentColor** to existing lines in a text widget.  This command is useful if a text widget has been created, text has been inserted in the widget, *and then* the value of **::ntext::indentColor** is changed (see *ntextIndent*).

**::ntext::syncTabColor** *pathName*
: Command to apply the current values of the variables **::ntext::tabColor** and **::ntext::tabSelColor** to tab spaces in a text widget.  This command is useful if a text widget has been created, text has been inserted in the widget, *and then* the value of **::ntext::tabColor** or **::ntext::tabSelColor** is changed.


# Configuration options

*Ntext* provides alternatives to a number of behaviours of the classic *Text* binding tag.  Where there is an option, the *Ntext* behaviour (except for display-line indentation) is switched on by default.

The behaviour of *Ntext* may be configured application-wide by setting the values of a number of namespace variables:

**::ntext::classicAnchor**

- **0** - (default value) selects *Ntext* behaviour, i.e. the anchor point is fixed

- **1** - selects classic *Text* behaviour, i.e. the anchor point is variable

- For more information see *ntextBindings*


**::ntext::classicExtras**

- **0** - (default value) selects *Ntext* behaviour, i.e. several traditional *Text* bindings are de-activated

- **1** - selects classic *Text* behaviour, i.e. all *Text* bindings are activated

- For more information see *ntextBindings*


**::ntext::classicMouseSelect**

- **0** - (default value) selects *Ntext* behaviour, i.e. the anchor point for mouse selection operations is moved by keyboard navigation

- **1** - selects classic *Text* behaviour

- For more information see *ntextBindings*


**::ntext::classicParagraphs**

- **0** - (default value) on macOS Aqua, certain keyboard bindings are made to behave in the same way as the Mac application TextEdit.  The bindings involve vertical scrolling of the screen and are <?Shift-?Option-(Up|Down)>.

- **1** - on macOS Aqua, certain keyboard bindings are made to behave in the same way as classic *Text*, ignoring the conventions of Aqua.  The bindings involve vertical scrolling of the screen and are <?Shift-?Option-(Up|Down)>.

- For more information see *ntextBindings*


**::ntext::classicSelection**

- **0** - (default value on macOS Aqua) selects Mac-like behaviour, i.e. when a navigation keystroke cancels a selection, the insert mark first moves to the end of the selection determined by the navigation direction of the keystroke, and then the keystroke is applied.

- **1** - (default value except on macOS Aqua) selects PC-like behaviour (the same as classic *Text*), i.e. when a navigation keystroke cancels a selection, the insert mark is not moved before the keystroke is applied.

- For more information see *ntextBindings*


**::ntext::classicWordBreak**

- **0** - (default value) selects *Ntext* behaviour, i.e. platform-independent, two classes of word characters and one class of non-word characters.

- **1** - selects classic *Text* behaviour, i.e. platform-dependent, one class of word characters and one class of non-word characters

- After changing this value, the matching patterns should be recalculated.  See *ntextWordBreak* for details and advanced configuration options.


**::ntext::classicWrap**

- **0** - selects *Ntext* behaviour, i.e. display lines of text widgets in *-wrap* *word* mode are indented to match the initial whitespace of the first display line of a logical line.  If the widget already holds text when this value is set, a function call may be necessary.  See *ntextIndent* for detailed instructions on the use of *Ntext* 's indentation.

- **1** - (default value) selects classic *Text* behaviour, i.e. no indentation

- For more information see *ntextIndent*


**::ntext::indentColor**

- **{}** - if the value is the empty string, then the indent of wrapped display lines has the same color as the widget background.

- *color* - a valid **Tk** color to use for the indent of wrapped display lines (default value *#d9d9d9*).

    Coloring is implemented with the text widget tag option *-lmargincolor*, which is available from **Tk** 8.6.6 onwards.  *Ntext* indent coloring has no effect in earlier versions of **Tk**.

    The value of **::ntext::indentColor** will often be set at startup.  If the value is changed when text widgets already exist and contain text, those widgets can be updated by calling command **::ntext::syncIndentColor**.

- For more information see *ntextIndent*


**::ntext::overwrite**

- **0** - (initial value) text typed at the keyboard is inserted into the widget

- **1** - text typed at the keyboard overwrites text already in the widget

- The value is toggled by the *Insert* key (except on macOS Aqua where there is no such key).

- For more information see *ntextBindings*


**::ntext::tabColor**

- **{}** - if the value is the empty string, then the tab spaces have the same color as the widget background.

- *color* - a valid **Tk** color to use for tab spaces (default value *#ffffaa*).

    The value of **::ntext::tabColor** will often be set at startup. If the value is changed when text widgets already exist and contain text, those widgets can be updated by calling command **::ntext::syncTabColor**.


**::ntext::tabSelColor**

- **{}** - if the value is the empty string, then the color of tab spaces in the selection defaults to the same color as unselected tabs (see **::ntext::tabColor**), and *not* to the widget *-selectbackground* color.

- *color* - a valid **Tk** color to use for tab spaces in the selection (default value *#418bd4*).

    The value of **::ntext::tabSelColor** will often be set at startup. If the value is changed when text widgets already exist and contain text, those widgets can be updated by calling command **::ntext::syncTabColor**.


**::ntext::useBlockCursor**

- **0** - the block cursor will not be used.  When the widget is in *overwrite* mode (see **::ntext::overwrite**), the ordinary cursor will change color instead.

- **1** - the block cursor will be used when the widget is in *overwrite* mode (see **::ntext::overwrite**).

- The default value depends on the version of **Tk**.  In versions of **Tk** earlier than **8.5.12**, the sizing of the block cursor had a bug, and **::ntext::useBlockCursor** defaults to **0**.  From **8.5.12** onwards the bug is fixed, and **::ntext::useBlockCursor** defaults to **1**.

- For more information see *ntextBindings*


# Bugs

This version of **ntext** is intended to be compatible with all releases of **Tk** 8.5, 8.6, and 8.7, and with the branches *core-8-5-branch*, *core-8-6-branch*, and *trunk* in the source code repository for **Tk**.  Any incompatibility with any of these versions, for any **Tk** windowing system, should be reported as a bug. Please report such in the category *ntext* of the [Tklib Trackers](https://core.tcl-lang.org/tklib/reportlist).

# Example

To create a text widget .t and use the *Ntext* bindings:

```
package require ntext
text .t
bindtags .t {.t Ntext . all}
```

See **bindtags** for more information.
