# The `scrollutil::plainnotebook` Command

## For Scrollutil Version 2.11

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Quick Reference](#quick-reference)
- [Detailed Reference](#detailed-reference)

[Start page](index.md)

---

## Quick Reference

[NAME](#detailed-reference)
: `scrollutil::plainnotebook` – Create and manipulate plainnotebook widgets

[SYNOPSIS](#detailed-reference)
: 

```
package require scrollutil_tile
scrollutil::plainnotebook pathName ?options?
```

[STANDARD OPTIONS](#detailed-reference)
: 

```
-class  -cursor  -style
```

[WIDGET-SPECIFIC OPTIONS](#detailed-reference)
: `-caller pageIndex`

: `-closabletabs boolean`

: `-forgetcommand command`

: `-height screenDistance`

: `-leavecommand command`

: `-movabletabs boolean`

: `-side left|right`

: `-takefocus 0|1|""|command`

: `-title text`

: `-width screenDistance`

[WIDGET COMMAND](#detailed-reference)
: `pathName add window ?options?`

: `pathName addbutton pageIndex text ?image?`

: `pathName addlabel text ?image?`

: `pathName addseparator`

: `pathName adjustsize`

: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName closablestate tabId ?boolean?`

: `pathName configure ?option ?value option value ...??`

: `pathName forget tabId`

: `pathName hasattrib name`

: `pathName hastabattrib tabId name`

: `pathName hide tabId`

: `pathName index tabId`

: `pathName insert pos window ?options?`

: `pathName insertbutton pos pageIndex text ?image?`

: `pathName insertlabel pos text ?image?`

: `pathName insertseparator pos`

: `pathName instate stateSpec ?script?`

: `pathName see tabId`

: `pathName select ?tabId?`

: `pathName state ?stateSpec?`

: `pathName style`

: `pathName tab tabId ?option ?value option value ...??`

: `pathName tabattrib tabId ?name ?value name value ...??`

: `pathName tabpath tabId`

: `pathName tabs`

: `pathName titlepath`

: `pathName unsetattrib name`

: `pathName unsettabattrib tabId name`

[KEYWORDS](#detailed-reference)
: plainnotebook, widget, notebook, closebtn


[Contents](#contents)     [Start page](index.md)

---

## Detailed Reference

**NAME**
: `scrollutil::plainnotebook` – Create and manipulate plainnotebook widgets

**SYNOPSIS**
: 

```
package require scrollutil_tile
scrollutil::plainnotebook pathName ?options?
```

: Note that the `scrollutil::plainnotebook` command is provided by the Scrollutil_tile package, but not by Scrollutil.

**DESCRIPTION**
: The `scrollutil::plainnotebook` command creates a new window named `pathName` and makes it into a **plainnotebook** widget.  Additional options, described below, may be specified on the command line or in the option database to configure aspects of the plainnotebook widget such as its width, height, and side.  The `scrollutil::plainnotebook` command returns its `pathName` argument.  At the time this command is invoked, there must not exist a window named `pathName`, but `pathName`'s parent must exist.

: A plainnotebook is a mega-widget that extends a ttk::notebook having an arbitrary number of pages with invisible tabs by a ttk::frame to its left or right containing, among others, a [scrollableframe](scrollableframe.md) whose content frame is the parent of a series of widgets that play the role of vertically laid-out notebook tabs.  Currently not visible "tabs" can be brought into view by navigating with the mouse wheel, touchpad, or keyboard, and by scrolling with the vertical scrollbar of the [scrollarea](scrollarea.md) containing the scrollableframe.  An individual "tab" can be made visible programmatically with the aid of the `see` subcommand.  Unlike a ttk::notebook widget with vertically aligned tabs, which in most themes has a suboptimal look and whose `-height` option is quite often overridden by the total height of the tabs, the plainnotebook widget respects the value of its `-height` option, regardless of the space required by the "tabs".

: In the rest of this document, the widgets that play the role of vertically laid-out notebook tabs, will be called **tabs** themselves.

: The upper part of the frame to the left or right of the ttk::notebook component contains a toolbutton and a ttk::label widget, called **ascend button** and **title label**, respectively.  Their visibility is controlled by the `-caller` and `-title` widget options.  The ascend button displays an image whose shape resembles that of a < character.

: The API of the plainnotebook widget is quite similar to that of ttk::notebook.  Apart from a few additional, plainnotebook-specific subcommands and the missing `identify` subcommand, the Tcl command associated with a plainnotebook widget provides the same subcommands as the one associated with a ttk::notebook.  Note that the API doesn't provide any command for retrieving the path name of the ttk::notebook widget contained in a plainnotebook, because there is no need to access that widget directly.  Moreover, using its options or subcommands instead of those of the plainnotebook widget will more often than not result in an unpredictable behavior.

: Notice also that only the tabs created with the `add` and `insert` subcommands are selectable.  The ones created with the plainnotebook-specific subcommands `addbutton` and `insertbutton` are designed for descending to another plainnotebook widget, while the ones created via `addlabel`, `addseparator`, `insertlabel`, and `insertseparator` can be used as titles and delimiters of tab groups.

**STANDARD OPTIONS**
: 

```
-class  -cursor  -style
```

: See the **ttk_widget** manual entry for details on the standard options.  The default value of the `-class` option is `Plainnotebook` and that of `-cursor` an empty string.  The `-style` option, whose value defaults to `Plain.TNotebook`, refers to the style of the ttk::notebook widget contained in the plainnotebook.  The "plain" look of this ttk::notebook widget is achieved by setting the layout of the style `Plain.TNotebook.Tab` to `null` and the `-mintabwidth`, `-tabmargins`, and `-padding` options of the style `Plain.TNotebook` to `0`.

**WIDGET-SPECIFIC OPTIONS**
: 

|   |   |
| --- | --- |
| Command-Line Name:  | `-caller` |
| Database Name: | ` caller` |
| Database Class: | ` Caller` |

The value of this option must be an integer.  If it is nonnegative then the widget's parent must be a [pagesman](pagesman.md) widget.  In this case the value is viewed as the numerical index of an already existing page of the parent pagesman widget, and the plainnotebook's ascend button will select that page, which is assumed to be the "caller" of the current plainnotebook widget, meaning that the current plainnotebook was previously selected from within that page.  For example, if the option's value is `0` then pressing and later releasing the left mouse button over the ascend button will ascend back to the pagesman page of index `0`, which is assumed to be the page from which the user previously descended to the current one.  The default is `-1`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-closabletabs` |
| Database Name: | ` closableTabs` |
| Database Class: | ` ClosableTabs` |

Specifies a boolean value that determines whether the tabs created with the `add` and `insert` subcommands (only) will contain the `closebtn` element.  This style element is automatically created by the Scrollutil_tile package and is quite similar to the `closetab` element.  See the [FURTHER BINDINGS](#detailed-reference) section below for details on closing the tabs with the aid of the `closebtn` element.  The default is `0`.  This option can be overridden for individual tabs with the aid of the `closablestate` subcommand.


|   |   |
| --- | --- |
| Command-Line Name:  | `-forgetcommand` |
| Database Name: | ` forgetCommand` |
| Database Class: | ` ForgetCommand` |

Specifies a command to be invoked when attempting to remove a tab and unmanage the associated window with the aid of the `forget` subcommand.  If the option's value is a nonempty string then it is concatenated with the path name of the plainnotebook widget and that of the window to be unmanaged, and the resulting script, which must return a boolean, is evaluated in the global scope.  If the return value of this script is false then the `forget` subcommand is aborted, i.e., the tab is not removed and the associated window is not unmanaged.  The default is an empty string.


|   |   |
| --- | --- |
| Command-Line Name:  | `-height` |
| Database Name: | ` height` |
| Database Class: | ` Height` |

If present and greater than zero, specifies the desired height of the pane area in any of the forms acceptable to `Tk_GetPixels`.  Otherwise, the maximum requested height of all panes is used.  The default is `0`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-leavecommand` |
| Database Name: | ` leaveCommand` |
| Database Class: | ` LeaveCommand` |

Specifies a command to be invoked when attempting to leave the currently selected window by selecting a different one.  If the option's value is a nonempty string then it is concatenated with the path name of the plainnotebook widget and that of the currently selected window, and the resulting script, which must return a boolean, is evaluated in the global scope.  If the return value of this script is false then the operation of selecting a different window is aborted.  The default is an empty string.


|   |   |
| --- | --- |
| Command-Line Name:  | `-movabletabs` |
| Database Name: | ` movableTabs` |
| Database Class: | ` MovableTabs` |

Specifies a boolean value that determines whether the tabs can be moved with the mouse.  See the [FURTHER BINDINGS](#detailed-reference) section below for details.  The default is `1`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-side` |
| Database Name: | ` side` |
| Database Class: | ` Side` |

Specifies on which side (`left` or `right`) of the widget to show the ttk::frame containing the tabs, the ascend button, and the title label.  The default is `left`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-takefocus` |
| Database Name: | ` takeFocus` |
| Database Class: | ` TakeFocus` |

This option determines whether the plainnotebook widget accepts the focus during keyboard traversal.  It is almost identical to the standard option of the same name (see the **options** manual entry for details).  The only difference is that not the plainnotebook widget itself but the content frame of the scrollableframe contained in it will receive the focus during keyboard traversal with the standard keys (`Tab` and `Shift-Tab`).  The default is `"ttk::takefocus"` (just like for ttk::notebook and several other Tk themed widgets).


|   |   |
| --- | --- |
| Command-Line Name:  | `-title` |
| Database Name: | ` title` |
| Database Class: | ` Title` |

Specifies the text to be displayed in the plainnotebook's title label, which is a ttk::label widget of the style `PnbTitle.TLabel`.  The font used for this style is derived from `TkDefaultFont` by increasing the latter's size by a factor of 1.2.  To set a different font, use the `ttk::style` command or retrieve the path name of this widget with the `titlepath` subcommand and then invoke  `... configure -font ...`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-width` |
| Database Name: | ` width` |
| Database Class: | ` Width` |

If present and greater than zero, specifies the desired width of the pane area in any of the forms acceptable to `Tk_GetPixels`.  Otherwise, the maximum requested width of all panes is used.  The default is `0`.

**TAB OPTIONS**
: See the **ttk_notebook** manual entry.

**TAB IDENTIFIERS**
: See the **ttk_notebook** manual entry.  Note that in positional specifications of the form `"@x,y`", the coordinates are expected to be relative to the plainnotebook window.

**WIDGET COMMAND**
: The `scrollutil::plainnotebook` command creates a new Tcl command whose name is `pathName`.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

: `option` and the `arg`s determine the exact behavior of the command.  The following commands are possible for plainnotebook widgets:


`pathName add window ?options?`
: See the **ttk_notebook** manual entry.  As mentioned there, if `window` is currently managed by the notebook but hidden, the subcommand restores it to its previous position.  This holds equally true for the non-selectable (dummy) windows associated with the tabs created with the `addbutton`, `addlabel`, `addseparator`, `insertbutton`, `insertlabel`, and `insertseparator` subcommands.  If `window` is not yet managed by the notebook then the corresponding tab will be a ttk::radiobutton widget of a toolbutton style (`Page.Toolbutton` or `ClosablePage.Toolbutton`, depending on the value of the `-closabletabs` option).  The return value is the path name of the widget used for the tab corresponding to `window` (a ttk::radiobutton or ttk::button, both using a toolbutton style, or a ttk::label, or a ttk::separator).

`pathName addbutton pageIndex text ?image?`
: Adds a new tab implemented as a ttk::button widget of a toolbutton style (`Desc.Toolbutton`) that displays, besides the specified `text` and optional `image`, the `descend` element, whose shape resembles that of a > character.  This style element is automatically created by the Scrollutil_tile package.  Its size depends on Tk's scaling factor, while its foreground color is theme-specific and is updated whenever the theme changes.  The return value is the path name of the above-mentioned ttk::button widget.

: For this subcommand to work, the widget's parent must be a [pagesman](pagesman.md) widget.  `pageIndex`, which must be a nonnegative integer, specifies the numerical index of a page within the pagesman widget that will be selected when invoking the toolbutton.  It is not expected that at the time this subcommand is invoked, the page identified by `pageIndex` already exists; it may be created and added to the pagesman widget later.

: This subcommand, together with the `-caller` option, makes it easy to to write applications in which the user can descend from a plainnotebook to another one within a common pagesman parent with a single mouse click and switch back in the same way to the original one.  For example, if the two plainnotebook widgets have the page indices `0` and `1` then all you need is to pass the page index `1` to the first plainnotebook's `addbutton` subcommand and set the `-caller` option of the second one to the page index `0`.

`pathName addlabel text ?image?`
: Adds a new tab implemented as a ttk::label widget of the style `PnbLabel.TLabel` that displays the specified `text` and optional `image`, and is typically used as a title of a group of tabs.  The font used for this style is derived from `TkDefaultFont` by increasing the latter's size by a factor of 1.2 and can be changed with the `ttk::style` command.  The return value is the path name of the above-mentioned ttk::label widget; you can use it, e.g., to override the style's font for this particular label via  `... configure -font ...`.

`pathName addseparator`
: Adds a new tab implemented as a horizontal ttk::separator widget, which is typically used as a delimiter of a group of tabs.  The return value is the path name of the above-mentioned ttk::separator widget.

`pathName adjustsize`
: Sets the plainnotebook's `-height` option to the maximum requested height of all panes and its `-width` option to the maximum requested width of all panes.

: **REMARK:**  If the plainnotebook's `-height` and `-width` options have their default value `0` then in many cases there is no need for invocations of this subcommand, since the widget will automatically attempt to adapt its size to the maximum requested size of its panes.

`pathName attrib ?name ?value name value ...??`
: Queries or modifies the attributes of the widget.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for `pathName`.  If `name` is specified with no `value`, then the command returns the value of the one named attribute, or an empty string if no corresponding value exists (you can use the `hasattrib` subcommand to distinguish this case from the one that the value of an *existing* attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given widget attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName cget option`
: Returns the current value of the configuration option given by `option`, which may have any of the values accepted by the `scrollutil::plainnotebook` command.

`pathName closablestate tabId ?boolean?`
: Sets or queries the presence of the `closebtn` element in the tab specified by `tabId`.  The optional argument is only supported for tabs created via `add` or `insert`.  This subcommand overrides the `-closabletabs` option for the specified tab.

`pathName configure ?option ?value option value ...??`
: Queries or modifies the configuration options of the widget.  If no `option` is specified, the command returns a list describing all of the available options for `pathName` (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values accepted by the `scrollutil::plainnotebook` command.

`pathName forget tabId`
: See the **ttk_notebook** manual entry.

`pathName hasattrib name`
: Returns `1` if the attribute `name` exists and `0` otherwise.

`pathName hastabattrib tabId name`
: Returns `1` if the attribute `name` for the tab given by `tabId` exists and `0` otherwise.

`pathName hide tabId`
: See the **ttk_notebook** manual entry.

`pathName index tabId`
: See the **ttk_notebook** manual entry.

`pathName insert pos window ?options?`
: See the **ttk_notebook** manual entry.  As mentioned there, if `window` is already managed by the notebook, the subcommand moves it to the specified position.  This holds equally true for the non-selectable (dummy) windows associated with the tabs created with the `addbutton`, `addlabel`, `addseparator`, `insertbutton`, `insertlabel`, and `insertseparator` subcommands.  If `window` is not yet managed by the notebook then the corresponding tab will be a ttk::radiobutton widget of a toolbutton style (`Page.Toolbutton` or `ClosablePage.Toolbutton`, depending on the value of the `-closabletabs` option).  The return value is the path name of the widget used for the tab corresponding to `window` (a ttk::radiobutton or ttk::button, both using a toolbutton style, or a ttk::label, or a ttk::separator).

`pathName insertbutton pos pageIndex text ?image?`
: Inserts a new tab implemented as a ttk::button widget of a toolbutton style (`Desc.Toolbutton`) that displays, besides the specified `text` and optional `image`, the `descend` element, at the specified position.  The details are quite similar to the ones regarding the `addbutton` subcommand.

`pathName insertlabel pos text ?image?`
: Inserts a new tab implemented as a ttk::label widget of the style `PnbLabel.TLabel` that displays the specified `text` and optional `image`, at the specified position.  The details are quite similar to the ones regarding the `addlabel` subcommand.

`pathName insertseparator pos`
: Inserts a new tab implemented as a horizontal ttk::separator widget, at the specified position.  The details are quite similar to the ones regarding the `addseparator` subcommand.

`pathName instate stateSpec ?script?`
: See the **ttk_widget** manual entry.

`pathName see tabId`
: This subcommand adjusts the view in the plainnotebook's window so that the tab given by `tabId` becomes visible in it.  Note that when a tab gets selected, this command is automatically invoked for it, in order to make that tab visible.

`pathName select ?tabId?`
: See the **ttk_notebook** manual entry.

`pathName state ?stateSpec?`
: See the **ttk_widget** manual entry.

`pathName style`
: Returns the value of the `-style` configuration option (i.e., the style used by the ttk::notebook widget contained in the plainnotebook).  For Tk themed widgets this subcommand was introduced in Tk 8.7a4, but the plainnotebook widget provides it for all supported Tk versions.

`pathName tab tabId ?option ?value option value ...??`
: See the **ttk_notebook** manual entry.

`pathName tabattrib tabId ?name ?value name value ...??`
: Queries or modifies the attributes of the tab given by `tabId`.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for the tab.  If `name` is specified with no `value`, then the command returns the value of the one named tab attribute, or an empty string if no corresponding value exists (you can use the `hastabattrib` subcommand to distinguish this case from the one that the value of an *existing* tab attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given tab attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName tabpath tabId`
: Returns the path name of the widget used for the specified tab.  This widget can be a ttk::radiobutton or ttk::button, both using a toolbutton style, or a ttk::label, or a ttk::separator.

`pathName tabs`
: See the **ttk_notebook** manual entry.

`pathName titlepath`
: Returns the path name of the plainnotebook's title label, which is a ttk::label widget of the style `PnbTitle.TLabel`.

`pathName unsetattrib name`
: Unsets the attribute `name`.  Returns an empty string.

`pathName unsettabattrib tabId name`
: Unsets the attribute `name` for the tab given by `tabId`.  Returns an empty string.


**KEYBOARD TRAVERSAL**
: See the **ttk_notebook** manual entry.

**VIRTUAL EVENTS**
: As described in the **ttk_notebook** manual entry, after a new tab of a ttk::notebook is selected (programmatically or interactively), the widget generates a `<<NotebookTabChanged>>` virtual event.  This holds true for plainnotebook widgets, too.

: The Scrollutil_tile package defines the virtual event `<<Button3>>` as `<Button-3>` for all windowing systems and additionally as `<Control-Button-1>` for Mac OS X/11+.  If this event occurs over a tab of a plainnotebook whose `disabled` widget state flag is not set, and the Tk version is 8.5a2 or later, then the widget generates a `<<MenuItemsRequested>>` virtual event, by invoking   ` event generate`  with the `-data` option set to a list consisting of the path name of an empty pop-up menu and the numerical index of the tab in question.  (The support for this option was introduced in Tk 8.5a2.)  If the application creates a binding for this virtual event, the binding script can access the user data as the value of the `%d` field, with the goal to populate the menu with application-specific entries.  Note that the pop-up menu is posted with a delay of 100 ms, to make sure that it will appear readily populated by the application.

The following example provides a pop-up menu item for closing the tabs of a plainnotebook widget `$nb`:

```
bind $nb <<MenuItemsRequested>> { populateMenu %W %d }

proc populateMenu {nb data} {
    foreach {menu tabIdx} $data {}
    $menu add command -label "Close Tab" -command [list $nb forget $tabIdx]
}
```

: See the next section for the description of the virtual events `<<NotebookTabMoved>>` and `<<NotebookTabClosed>>`.

**FURTHER BINDINGS**
: The Scrollutil_tile package creates the following additional bindings for the plainnotebook widgets:


  1. **Navigation between the selectable tabs of a plainnotebook widget via the mouse wheel or touchpad:**  Recall that the selectable tabs are the ones created with the `add` and `insert` subcommands.  A mouse wheel tick or a two-finger gesture on the touchpad selects the selectable tab of state `normal` cyclically following/preceding the currently selected one.  (Note that the same effect can also be achieved with the keys `Down`, `Up`, `Control-Tab`, and `Control-Shift-Tab`.)  On the windowing system `aqua`, if the `Option` key is down while the mouse wheel is being rotated then a wheel tick selects the 10'th selectable tab of state `normal` cyclically following/preceding the currently selected one (modulo the number of selectable tabs).  The same holds true on the windowing systems `x11` and `win32` if the Tk version is 8.7a4 or later and the mouse wheel is rotated with the `Alt` key down.
  2. **Moving the tabs of a plainnotebook widget with the mouse**:  If mouse button 1 is pressed over a tab but outside the `closebtn` element (if any) and then dragged outside that tab then, provided that the value of the widget's `-movabletabs` option is true, the mouse cursor takes on the shape of an up/down arrow, indicating that the tab in question is being moved to another position.  This operation ends when mouse button 1 is released, and can be canceled by pressing the `Escape` key.  In both cases, the mouse cursor is reset to its original value, specified by the `-cursor` configuration option.  After releasing mouse button 1, the source tab is moved to the position previously pointed to by the arrow (provided that the action was not canceled via `Escape`).  If the Tk version is 8.5a2 or later then after moving the tab to its new position, the widget generates a `<<NotebookTabMoved>>` virtual event, by invoking  `event generate`  with the `-data` option set to a list consisting of the path name of the widget contained in the source pane and the numerical index of the target tab position.  (The support for this option was introduced in Tk 8.5a2.)
  3. **Closing a tab of a plainnotebook widget with the aid of the closebtn element**:  If mouse button 1 is pressed over the `closebtn` element (if any) of a tab and later released over the same element then, provided that the value of the tab's `-state` option is `normal`, the tab is closed by means of the widget's `forget` subcommand.  Recall that this operation can get canceled by the command specified as the value of the `-forgetcommand` option; if this was not the case and the Tk version is 8.5a2 or later then, after closing the tab, the widget generates a `<<NotebookTabClosed>>` virtual event, by invoking  `event generate`  with the `-data` option set to the path name of the widget contained in that tab's pane.

: If the widget's `disabled` state flag is set then none of the above actions occur: the tabs are completely insensitive.

**KEYWORDS**
: plainnotebook, widget, notebook, closebtn


[Contents](#contents)     [Start page](index.md)
