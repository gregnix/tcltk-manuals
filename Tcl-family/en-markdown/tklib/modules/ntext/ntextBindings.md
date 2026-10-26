---
CommandName: ntextBindings
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Alternative Bindings for the Text Widget
Links:
 - bindtags
 - ntext
 - ntextIndent
 - text
Keywords:
 - bindtags
 - text
Copyright:
---

# Name

ntextBindings - Alternative Bindings for the Text Widget

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5-]{.lit} 
[package]{.cmd} [require]{.sub} [ntext]{.lit} [1.0]{.optlit} 
:::

# Description

The **ntext** package provides a binding tag named *Ntext* for use by text widgets in place of the default *Text* binding tag.

The *Text* binding tag provides around one hundred bindings to the text widget (the exact number is platform-dependent).  A few of these behave in a way that is different from most contemporary text-editing applications.  *Ntext* aims to provide more familiar behaviour.

Features of the *Ntext* bindings that differ from the default *Text* bindings:

**•**
: Clicking near the end of a (logical) line moves the cursor to the end of that line *(not the start of the next line)*.  If the widget is in *-wrap* *word* mode, the same rule applies to display lines.

**•**
: Double-clicking or dragging near the end of a (logical) line will highlight/select characters from the end of that line *(not the next line, or the region at the end of the line where there are no characters)*.  If the widget is in *-wrap* *word* mode, the same rule applies to display lines.

**•**
: On windowing systems other than macOS Aqua, the *Home* key implements "Smart Home" (successive keypresses move the cursor to the start of the display line, then to the first non-whitespace character at the start of the logical line, then toggles between the beginning and end of leading whitespace); the *End* key implements "Smart End" (which is similar to "Smart Home").  On macOS Aqua, this functionality is provided by the operations \<Command-Left> and \<Command-Right>.

**•**
: When a selection exists, a "Paste" operation (e.g. \<Control-v>) overwrites the selection (as most editors do), and does so on all platforms.

**•**
: On windowing systems other than macOS Aqua, the *Insert* key toggles between "Insert" and "Overwrite" modes for keyboard input.  *(In contrast, the Text binding tag uses* Insert *as a method to paste the "primary selection", a task that can be accomplished instead by mouse middle-click.)*

**•**
: The *Escape* key clears the selection.

**•**
: On the macOS Aqua windowing system, *Ntext* follows Aqua conventions for keyboard navigation.  Certain bindings related to vertical scrolling can be forced to behave in the same way as for the Windows and X11 windowing systems, by setting **::ntext::classicParagraphs** to **1** (see Section **CONFIGURATION OPTIONS**).

**•**
: On the macOS Aqua windowing system, *Ntext* follows Aqua conventions for placement of the insert mark when keyboard navigation cancels a selection.  This behavior can be switched off by setting **::ntext::classicSelection** to **1** (see Section **CONFIGURATION OPTIONS**).

**•**
: Selecting with \<Shift-Button1> selects from the previous position of the insertion cursor. *(In the Text binding tag, the selection anchor may be the position of the previous mouse click.)*

**•**
: \<Shift-Button1> operations do not alter the selection anchor. *(In the Text binding tag, they do.)*

**•**
: By default, the *Ntext* binding tag does not provide several of the Control-key bindings supplied by the *Text* binding tag.  Modern keyboards offer alternatives, such as cursor keys for navigation; modern applications often use the Control-key bindings for other purposes (e.g. \<Control-p> for "print"). In the last three cases, the behavior of *Text* is often useful, so *Ntext* gives you the option of retaining it, by setting variables defined in the ::ntext namespace to 1 (instead of their default 0).  Explaining these features in more detail:

**•**
: If the mouse is clicked at position A, then the keyboard is used to move the cursor to B, then shift is held down, and the mouse is clicked at C: the *Text* binding tag gives a selection from A to C; the *Ntext* gives a selection from B to C.  If you want *Ntext* to behave like *Text* in this respect, set **::ntext::classicMouseSelect** to 1.

**•**
: The *Text* binding tag allows successive \<Shift-Button-1> events to change both ends of the selection, by moving the selection anchor to the end of the selection furthest from the mouse click.  Instead, the *Ntext* binding tag fixes the anchor, and multiple Shift-Button-1 events can only move the non-anchored end of the selection.  If you want *Ntext* to behave like *Text* in this respect, set **::ntext::classicAnchor** to 1.  In both *Text* and *Ntext*, keyboard navigation with the Shift key held down alters the selection and keeps the selection anchor fixed.

**•**
: The following "extra" *Text* bindings are switched off by default, but can be activated in *Ntext* by setting **::ntext::classicExtras** to 1: \<Control-a>, \<Control-b>, \<Control-d>, \<Control-e>, \<Control-f>, \<Control-h>, \<Control-i>, \<Control-k>, \<Control-n>, \<Control-o>, \<Control-p>, \<Control-t>, \<Control-space>, \<Control-Shift-space>.


# Configuration options

*Ntext* provides alternatives to a number of behaviours of the classic *Text* binding tag.  Where there is an option, the *Ntext* behaviour is switched on by default, except for display-line indentation which is discussed on a separate page at *ntextIndent*.

The behaviour of *Ntext* may be configured application-wide by setting the values of a number of namespace variables:

**::ntext::classicAnchor**

**•**
: **0** - (default value) selects *Ntext* behaviour, i.e. the anchor point is fixed

**•**
: **1** - selects classic *Text* behaviour, i.e. the anchor point is variable **::ntext::classicExtras**

**•**
: **0** - (default value) selects *Ntext* behaviour, i.e. several "extra" *Text* bindings are de-activated

**•**
: **1** - selects classic *Text* behaviour, i.e. the "extra" *Text* bindings are activated **::ntext::classicMouseSelect**

**•**
: **0** - (default value) selects *Ntext* behaviour, i.e. the anchor point for mouse selection operations is moved by keyboard navigation

**•**
: **1** - selects classic *Text* behaviour **::ntext::classicParagraphs**

**•**
: **0** - (default value) on macOS Aqua, certain keyboard bindings are made to behave in the same way as the Mac application TextEdit.  The bindings involve vertical scrolling of the screen and are \<?Shift-?Option-(Up|Down)>.

**•**
: **1** - on macOS Aqua, certain keyboard bindings are made to behave in the same way as for the Windows and X11 windowing systems and the classic *Text*, ignoring the conventions of Aqua.  The bindings involve vertical scrolling of the screen and are \<?Shift-?Option-(Up|Down)>. **::ntext::classicSelection**

**•**
: **0** - (default value on macOS Aqua) selects Mac-like behaviour, i.e. when a navigation keystroke cancels a selection, the insert mark first moves to the end of the selection determined by the navigation direction of the keystroke, and then the keystroke is applied.

**•**
: **1** - (default value except on macOS Aqua) selects PC-like behaviour (the same as classic *Text*), i.e. when a navigation keystroke cancels a selection, the insert mark is not moved before the keystroke is applied. **::ntext::overwrite**

**•**
: **0** - (initial value) text typed at the keyboard is inserted into the widget

**•**
: **1** - text typed at the keyboard overwrites text already in the widget

**•**
: The value is toggled by the *Insert* key. **::ntext::useBlockCursor**

**•**
: **0** - the block cursor will not be used.  When the widget is in *overwrite* mode (see **::ntext::overwrite**), the ordinary cursor will change color instead.

**•**
: **1** - the block cursor will be used when the widget is in *overwrite* mode (see **::ntext::overwrite**).

**•**
: The default value depends on the version of **Tk**.  In versions of **Tk** earlier than **8.5.12**, the sizing of the block cursor had a bug, and **::ntext::useBlockCursor** defaults to **0**.  From **8.5.12** onwards the bug is fixed, and **::ntext::useBlockCursor** defaults to **1**.


# Internals

In order to remain independent of the version of **Tk** (8.5 or 8.6), **ntext** defines its own virtual events.  These new virtual events are used only in the *Ntext* binding tag, and therefore do not interfere with the real or virtual events used in other code.

These events include <\<NtextCut>>, <\<NtextCopy>>, <\<NtextPaste>> which are used in place of <\<Cut>>, <\<Copy>>, <\<Paste>> respectively.

The definition of the virtual event <\<NtextCut>> (etc) is similar to that of <\<Cut>> (etc) in **Tk** 8.6.

# Bugs

This version of **ntext** is intended to be compatible with all releases of **Tk** 8.5, 8.6, and 8.7, and with the branches *core-8-5-branch*, *core-8-6-branch*, and *trunk* in the source code repository for **Tk**.  Any incompatibility with any of these versions, for any **Tk** windowing system, should be reported as a bug. Please report such in the category *ntext* of the [Tklib Trackers](https://core.tcl-lang.org/tklib/reportlist).

# Example

To use *Ntext* but keep classic *Text* 's variable-anchor feature:

```
package require ntext
text .t
set ::ntext::classicAnchor 1
bindtags .t {.t Ntext . all}
```
