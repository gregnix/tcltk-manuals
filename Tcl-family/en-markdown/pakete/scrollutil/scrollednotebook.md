# The `scrollutil::scrollednotebook` Command  
 and the `closetab` Style Element

## For Scrollutil Version 2.11

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The scrollutil::scrollednotebook Command – Quick Reference](#the-scrollutil-scrollednotebook-command-quick-reference)
- [The scrollutil::scrollednotebook Command – Detailed Reference](#the-scrollutil-scrollednotebook-command-detailed-reference)
- [The closetab Style Element](#the-closetab-style-element)
- [The scrollutil::addclosetab Command](#the-scrollutil-addclosetab-command)
- [The scrollutil::removeclosetab Command](#the-scrollutil-removeclosetab-command)
- [The scrollutil::closetabstate Command](#the-scrollutil-closetabstate-command)

[Start page](index.md)

---

## The `scrollutil::scrollednotebook` Command – Quick Reference

[NAME](#the-scrollutil-scrollednotebook-command-detailed-reference)
: `scrollutil::scrollednotebook` – Create and manipulate scrollednotebook widgets

[SYNOPSIS](#the-scrollutil-scrollednotebook-command-detailed-reference)
: 

```
package require scrollutil_tile
scrollutil::scrollednotebook pathName ?options?
```

[STANDARD OPTIONS](#the-scrollutil-scrollednotebook-command-detailed-reference)
: 

```
-class  -cursor  -style
```

[WIDGET-SPECIFIC OPTIONS](#the-scrollutil-scrollednotebook-command-detailed-reference)
: `-forgetcommand command`

: `-height screenDistance`

: `-leavecommand command`

: `-movabletabs boolean`

: `-padding paddingSpec`

: `-takefocus 0|1|""|command`

: `-width screenDistance`

[WIDGET COMMAND](#the-scrollutil-scrollednotebook-command-detailed-reference)
: `pathName add window ?options?`

: `pathName adjustsize`

: `pathName attrib ?name ?value name value ...??`

: `pathName cget option`

: `pathName closetabstate tabId ?normal|disabled?`

: `pathName configure ?option ?value option value ...??`

: `pathName forget tabId`

: `pathName hasattrib name`

: `pathName hastabattrib tabId name`

: `pathName hide tabId`

: `pathName identify component x y`

: `pathName index tabId`

: `pathName insert pos window ?options?`

: `pathName instate stateSpec ?script?`

: `pathName notebookpath`

: `pathName see tabId`

: `pathName select ?tabId?`

: `pathName state ?stateSpec?`

: `pathName style`

: `pathName tab tabId ?option ?value option value ...??`

: `pathName tabattrib tabId ?name ?value name value ...??`

: `pathName tabs`

: `pathName unsetattrib name`

: `pathName unsettabattrib tabId name`

[KEYWORDS](#the-scrollutil-scrollednotebook-command-detailed-reference)
: scrollednotebook, widget, notebook, scrolled


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::scrollednotebook` Command – Detailed Reference

**NAME**
: `scrollutil::scrollednotebook` – Create and manipulate scrollednotebook widgets

**SYNOPSIS**
: 

```
package require scrollutil_tile
scrollutil::scrollednotebook pathName ?options?
```

: Note that the `scrollutil::scrollednotebook` command is provided by the Scrollutil_tile package, but not by Scrollutil.

**DESCRIPTION**
: The `scrollutil::scrollednotebook` command creates a new window named `pathName` and makes it into a **scrollednotebook** widget.  Additional options, described below, may be specified on the command line or in the option database to configure aspects of the scrollednotebook widget such as its width, height, and style.  The `scrollutil::scrollednotebook` command returns its `pathName` argument.  At the time this command is invoked, there must not exist a window named `pathName`, but `pathName`'s parent must exist.

: A scrollednotebook is a mega-widget that contains a ttk::notebook within a [scrollableframe](scrollableframe.md) and supports an arbitrary number of unsqueezed tabs.  Currently not visible tabs can be brought into view by navigating with the mouse wheel, touchpad, or keyboard, and by scrolling with the aid of the two arrow buttons placed on demand in the top-left and top-right or bottom-left and bottom-right corners (depending on the notebook's [style](#the-scrollutil-scrollednotebook-command-detailed-reference)).  The size of the arrows depends on Tk's scaling factor, while their color is theme-specific and is updated whenever the theme changes.  An individual tab can be made visible programmatically with the aid of the `see` subcommand.  Unlike the ttk::notebook widget, whose `-width` option is quite often overridden by the total width of the tabs, the scrollednotebook widget respects the value of its `-width` option, regardless of the space required by the tabs.

: The API of the scrollednotebook widget is nearly identical to that of ttk::notebook.  Apart from a few additional, scrollednotebook-specific subcommands, the Tcl command associated with a scrollednotebook widget provides the same subcommands as the one associated with a ttk::notebook.

**STANDARD OPTIONS**
: 

```
-class  -cursor  -style
```

: See the **ttk_widget** manual entry for details on the standard options.  The default value of the `-class` option is `Scrollednotebook` and that of `-cursor` an empty string.  The `-style` option, whose value defaults to `TNotebook`, refers to the style of the ttk::notebook widget contained in the scrollednotebook.  The value of the `-tabposition` option of the style specified by this option must be one of `nw` (the default), `n` (the default for the `aqua` theme), `ne`, `sw`, `s`, or `se`.  These values will result in a horizontal tab layout (the scrollednotebook widget doesn't support vertical tab layouts).

**WIDGET-SPECIFIC OPTIONS**
: 

|   |   |
| --- | --- |
| Command-Line Name:  | `-forgetcommand` |
| Database Name: | ` forgetCommand` |
| Database Class: | ` ForgetCommand` |

Specifies a command to be invoked when attempting to remove a tab and unmanage the associated window with the aid of the `forget` subcommand.  If the option's value is a nonempty string then it is concatenated with the path name of the scrollednotebook widget and that of the window to be unmanaged, and the resulting script, which must return a boolean, is evaluated in the global scope.  If the return value of this script is false then the `forget` subcommand is aborted, i.e., the tab is not removed and the associated window is not unmanaged.  The default is an empty string.


|   |   |
| --- | --- |
| Command-Line Name:  | `-height` |
| Database Name: | ` height` |
| Database Class: | ` Height` |

If present and greater than zero, specifies the desired height of the pane area in any of the forms acceptable to `Tk_GetPixels`.  Otherwise, the widget's height is set to the requested height of the ttk::notebook contained in it (which in turn depends on the maximum requested height of all panes and tabs and the extra vertical space resulting from the value of the `-padding` option), immediately after the scrollednotebook gets mapped.  The default is `0`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-leavecommand` |
| Database Name: | ` leaveCommand` |
| Database Class: | ` LeaveCommand` |

Specifies a command to be invoked when attempting to leave the currently selected window by selecting a different one.  If the option's value is a nonempty string then it is concatenated with the path name of the scrollednotebook widget and that of the currently selected window, and the resulting script, which must return a boolean, is evaluated in the global scope.  If the return value of this script is false then the operation of selecting a different window is aborted.  The default is an empty string.


|   |   |
| --- | --- |
| Command-Line Name:  | `-movabletabs` |
| Database Name: | ` movableTabs` |
| Database Class: | ` MovableTabs` |

Specifies a boolean value that determines whether the tabs can be moved with the mouse.  See the [FURTHER BINDINGS](#the-scrollutil-scrollednotebook-command-detailed-reference) section below for details.  The default is `1`.


|   |   |
| --- | --- |
| Command-Line Name:  | `-padding` |
| Database Name: | ` padding` |
| Database Class: | ` Padding` |

Specifies the amount of extra space to add around the outside of the ttk::notebook widget contained in the scrollednotebook.  See the **ttk_notebook** manual entry for details.  The default is an empty string.  Note that if this default value is used then the ttk::notebook widget will be drawn with the external padding specified by the `-padding` option of the widget's style.


|   |   |
| --- | --- |
| Command-Line Name:  | `-takefocus` |
| Database Name: | ` takeFocus` |
| Database Class: | ` TakeFocus` |

This option determines whether the scrollednotebook widget accepts the focus during keyboard traversal.  It is almost identical to the standard option of the same name (see the **options** manual entry for details).  The only difference is that not the scrollednotebook widget itself but the ttk::notebook contained in it will receive the focus during keyboard traversal with the standard keys (`Tab` and `Shift-Tab`).  The default is `"ttk::takefocus"` (just like for ttk::notebook and several other Tk themed widgets).


|   |   |
| --- | --- |
| Command-Line Name:  | `-width` |
| Database Name: | ` width` |
| Database Class: | ` Width` |

If present and greater than zero, specifies the desired width of the ttk::notebook contained in the widget, in any of the forms acceptable to `Tk_GetPixels`.  Otherwise, the widget's width is set to the requested width of the ttk::notebook contained in it (which in turn depends on the maximum requested width of all panes, the total width of the tabs, and the extra horizontal space resulting from the value of the `-padding` option), immediately after the scrollednotebook gets mapped.  The default is `10c`, which should be overridden with a suitable application-specific value.

**TAB OPTIONS**
: See the **ttk_notebook** manual entry.

**TAB IDENTIFIERS**
: See the **ttk_notebook** manual entry.

**WIDGET COMMAND**
: The `scrollutil::scrollednotebook` command creates a new Tcl command whose name is `pathName`.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

: `option` and the `arg`s determine the exact behavior of the command.  The following commands are possible for scrollednotebook widgets:


`pathName add window ?options?`
: See the **ttk_notebook** manual entry.

`pathName adjustsize`
: Sets the scrollednotebook's `-height` option to the maximum requested height of all panes, and its `-width` option to the maximum requested width of all panes, increased by the extra horizontal space resulting from the value of the `-padding` option.

`pathName attrib ?name ?value name value ...??`
: Queries or modifies the attributes of the widget.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for `pathName`.  If `name` is specified with no `value`, then the command returns the value of the one named attribute, or an empty string if no corresponding value exists (you can use the `hasattrib` subcommand to distinguish this case from the one that the value of an *existing* attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given widget attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName cget option`
: Returns the current value of the configuration option given by `option`, which may have any of the values accepted by the `scrollutil::scrollednotebook` command.

`pathName closetabstate tabId ?normal|disabled?`
: Sets or queries the state of the `closetab` element of the tab specified by `tabId`.

: **REMARK:**  Invoking this subcommand is just a shortcut for passing `pathName`, `tabId`, and the optional argument (if present) to the `scrollutil::closetabstate` command.

`pathName configure ?option ?value option value ...??`
: Queries or modifies the configuration options of the widget.  If no `option` is specified, the command returns a list describing all of the available options for `pathName` (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values accepted by the `scrollutil::scrollednotebook` command.

`pathName forget tabId`
: See the **ttk_notebook** manual entry.

`pathName hasattrib name`
: Returns `1` if the attribute `name` exists and `0` otherwise.

`pathName hastabattrib tabId name`
: Returns `1` if the attribute `name` for the tab given by `tabId` exists and `0` otherwise.

`pathName hide tabId`
: See the **ttk_notebook** manual entry.

`pathName identify component x y`
: See the **ttk_notebook** manual entry.

`pathName index tabId`
: See the **ttk_notebook** manual entry.

`pathName insert pos window ?options?`
: See the **ttk_notebook** manual entry.

`pathName instate stateSpec ?script?`
: See the **ttk_widget** manual entry.

`pathName notebookpath`
: Returns the path name of the ttk::notebook widget contained in the scrollednotebook.  One of the extremely rare cases where this subcommand is needed, is related to setting a tooltip for one of the tabs.  If `nb` denotes the ttk::notebook path name returned by this subcommand, you can set a tooltip `message` for one of its tabs by using either the `-tab` option of the `tooltip::tooltip` command from the tooltip package contained in tklib:

```
tooltip::tooltip nb -tab tabId message
```

: or the `-nbktab` option of the `baltip::tip` command from the baltip package by Alex Plotnikov:

```
baltip::tip nb message -nbktab tabWindow ...
```

: The support for the `-tab` option of the `tooltip::tooltip` command was added in version 1.6 of the tooltip package.  The `baltip::tip` command accepts a great variety of additional options, too.  The baltip package can be downloaded from the location

https://chiselapp.com/user/aplsimple/repository/baltip/download/

: **REMARK:**  With the above exception, in the vast majority of cases there is no need to access the ttk::notebook widget contained in the scrollednotebook directly.  Moreover, using the ttk::notebook's options or subcommands instead of those of the scrollednotebook widget will more often than not result in an unpredictable behavior.

`pathName see tabId`
: This subcommand adjusts the view in the scrollednotebook's window so that the tab given by `tabId` becomes visible in it.  Note that when a tab gets selected, this command is automatically invoked for it, in order to make that tab visible.

`pathName select ?tabId?`
: See the **ttk_notebook** manual entry.

`pathName state ?stateSpec?`
: See the **ttk_widget** manual entry.

`pathName style`
: Returns the value of the `-style` configuration option (i.e., the style used by the ttk::notebook widget contained in the scrollednotebook).  For Tk themed widgets this subcommand was introduced in Tk 8.7a4, but the scrollednotebook widget provides it for all supported Tk versions.

`pathName tab tabId ?option ?value option value ...??`
: See the **ttk_notebook** manual entry.

`pathName tabattrib tabId ?name ?value name value ...??`
: Queries or modifies the attributes of the tab given by `tabId`.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for the tab.  If `name` is specified with no `value`, then the command returns the value of the one named tab attribute, or an empty string if no corresponding value exists (you can use the `hastabattrib` subcommand to distinguish this case from the one that the value of an *existing* tab attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given tab attribute(s) to the given value(s); in this case the return value is an empty string.  Each `name` may be an arbitrary string.

`pathName tabs`
: See the **ttk_notebook** manual entry.

`pathName unsetattrib name`
: Unsets the attribute `name`.  Returns an empty string.

`pathName unsettabattrib tabId name`
: Unsets the attribute `name` for the tab given by `tabId`.  Returns an empty string.


**KEYBOARD TRAVERSAL**
: See the **ttk_notebook** manual entry.

**VIRTUAL EVENTS**
: As described in the **ttk_notebook** manual entry, after a new tab of a ttk::notebook is selected (programmatically or interactively), the widget generates a `<<NotebookTabChanged>>` virtual event.  This holds true for scrollednotebook widgets, too.

: The Scrollutil_tile package defines the virtual event `<<Button3>>` as `<Button-3>` for all windowing systems and additionally as `<Control-Button-1>` for Mac OS X/11+.  If this event occurs over a tab of a ttk::notebook or scrollednotebook whose `disabled` widget state flag is not set, and the Tk version is 8.5a2 or later, then the widget generates a `<<MenuItemsRequested>>` virtual event, by invoking   ` event generate`  with the `-data` option set to a list consisting of the path name of an empty pop-up menu and the numerical index of the tab in question.  (The support for this option was introduced in Tk 8.5a2.)  If the application creates a binding for this virtual event, the binding script can access the user data as the value of the `%d` field, with the goal to populate the menu with application-specific entries.  Note that the pop-up menu is posted with a delay of 100 ms, to make sure that it will appear readily populated by the application.

The following example provides a pop-up menu item for closing the tabs of a ttk::notebook or scrollednotebook widget `$nb`:

```
bind $nb <<MenuItemsRequested>> { populateMenu %W %d }

proc populateMenu {nb data} {
    foreach {menu tabIdx} $data {}
    $menu add command -label "Close Tab" -command [list $nb forget $tabIdx]
}
```

: See the next section for the description of the virtual events `<<NotebookTabMoved>>`, `<<NotebookTabClosed>>`, and `<<CloseTabRequested>>`.

**FURTHER BINDINGS**
: The Scrollutil_tile package creates the following additional bindings for the ttk::notebook and scrollednotebook widgets:


  1. **Navigation between the tabs of a scrollednotebook or ttk::notebook widget via the mouse wheel or touchpad:**  A mouse wheel tick or two-finger gesture on the touchpad selects the tab of state `normal` cyclically following/preceding the currently selected one.  (Note that the same effect can also be achieved with the keys `Right`, `Left`, `Control-Tab`, and `Control-Shift-Tab`.)  On the windowing system `aqua`, if the `Option` key is down while the mouse wheel is being rotated then a wheel tick selects the 10'th tab of state `normal` cyclically following/preceding the currently selected one (modulo the number of tabs).  The same holds true on the windowing systems `x11` and `win32` if the Tk version is 8.7a4 or later and the mouse wheel is rotated with the `Alt` key down.
  2. **Scrolling the tab row of a scrollednotebook widget with the aid of the arrow buttons:**  If the tab at the right edge of the scrollednotebook is only partly visible then pressing mouse button 1 over the right arrow adjusts the view in the tab row so that the tab becomes fully visible; otherwise the click brings the next nonhidden tab into view.  Similarly, if the tab at the left edge of the scrollednotebook is only partly visible then pressing mouse button 1 over the left arrow adjusts the view in the tab row so that the tab becomes fully visible; otherwise the click brings the previous nonhidden tab into view.  If the mouse button is held down for at least 300 milliseconds, the actions described above will auto-repeat every 100 milliseconds.
  3. **Moving the tabs of a scrollednotebook or ttk::notebook widget with the mouse**:  If mouse button 1 is pressed over a tab but outside the `closetab` element (if any) and then dragged outside that tab then (in case of a scrollednotebook provided that the value of the widget's `-movabletabs` option is true) the mouse cursor takes on the shape of a left/right arrow, indicating that the tab in question is being moved to another position.  This operation ends when mouse button 1 is released, and can be canceled by pressing the `Escape` key.  In both cases, the mouse cursor is reset to its original value, specified by the `-cursor` configuration option.  After releasing mouse button 1, the source tab is moved to the position previously pointed to by the arrow (provided that the action was not canceled via `Escape`).  If the Tk version is 8.5a2 or later then after moving the tab to its new position, the widget generates a `<<NotebookTabMoved>>` virtual event, by invoking  `event generate`  with the `-data` option set to a list consisting of the path name of the widget contained in the source pane and the numerical index of the target tab position.  (The support for this option was introduced in Tk 8.5a2.)  All the above works also for a ttk::notebook with vertical tab layout, with the only difference that for the duration of the drag, the cursor is set to one having the shape of an up/down arrow.
  4. **Closing a tab of a scrollednotebook widget with the aid of the closetab element**:  If mouse button 1 is pressed over the `closetab` element (if any) of a tab and later released over the same element then, provided that both the value of the tab's `-state` option and the state of its `closetab` element is `normal`, the tab is closed by means of the widget's `forget` subcommand.  Recall that this operation can get canceled by the command specified as the value of the `-forgetcommand` option; if this was not the case and the Tk version is 8.5a2 or later then, after closing the tab, the widget generates a `<<NotebookTabClosed>>` virtual event, by invoking  `event generate`  with the `-data` option set to the path name of the widget contained in that tab's pane.
  5.  **Closing a tab of a ttk::notebook widget with the aid of the closetab element**:  If mouse button 1 is pressed over the `closetab` element (if any) of a tab and later released over the same element then, provided that both the value of the tab's `-state` option and the state of its `closetab` element is `normal`, an action depending on the Tk version is taken:  

    - If the Tk version is 8.5a2 or later then the tab is not (yet) closed.  Instead, the widget generates a `<<CloseTabRequested>>` virtual event, by invoking  `event generate`  with the `-data` option set to the numerical index of the tab in question.  It is the responsibility of the application to create a binding for this virtual event and to close the tab from within the binding script by invoking the widget's `forget` subcommand if appropriate, like in the following example:

      ```
      bind $nb <<CloseTabRequested>> { closeTab %W %d }

      proc closeTab {nb tabIdx} {
          set btn [tk_messageBox -title "Close Tab?" -icon question \
                   -message "Do you really want to close the tab?" -type yesno
          if {$btn eq "yes"} {
              $nb forget $tabIdx

              # Optionally:
              set widget [lindex [$nb tabs] $tabIdx]
              event generate $nb <<NotebookTabClosed>> -data $widget
          }
      }
      ```

    - If the Tk version is earlier than 8.5a2 then the tab is closed immediately by means of the widget's `forget` subcommand.  (Recall that the `-data` option for virtual events was introduced in Tk 8.5a2.)

: If the widget's `disabled` state flag is set then none of the above actions occur: the tabs are completely insensitive.

**KEYWORDS**
: scrollednotebook, widget, notebook, scrolled


[Contents](#contents)     [Start page](index.md)

---

## The `closetab` Style Element

The Scrollutil_tile package automatically creates a new style element named `closetab`, whose shape resembles that of an x character.  The element's size depends on Tk's scaling factor, while its foreground color is theme-specific and is updated whenever the theme changes.

You can add this element to the tabs of a ttk::notebook style (like `TNotebook` or `My.TNotebook`) by using the `scrollutil::addclosetab` command, thus making the tabs of any ttk::notebook or scrollednotebook widget of that style closable by the user.

For the opposite operation the Scrollutil_tile package provides the `scrollutil::removeclosetab` command.

The state (`normal` or `disabled`) of of the `closetab` element of a ttk::notebook or scrollednotebook tab can be set and queried with the aid of the `scrollutil::closetabstate` command.

[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::addclosetab` Command

**NAME**
: `scrollutil::addclosetab` – Add the `closetab` element to the tabs of a ttk::notebook style

**SYNOPSIS**
: 

```
package require scrollutil_tile
scrollutil::addclosetab notebookStyle
```

: Note that the `scrollutil::addclosetab` command is provided by the Scrollutil_tile package, but not by Scrollutil.

**DESCRIPTION**
: Modifies the style `notebookStyle.Tab` corresponding to a given ttk::notebook style (like `TNotebook` or `My.TNotebook`) by adding the `closetab` element to it.  This makes the tabs of any ttk::notebook or scrollednotebook widget whose `-style` option was set to `notebookStyle` closable by the user.  If the `closetab` element was already present in the style `notebookStyle.Tab` then the command returns without performing any action.

**KEYWORDS**
: ttk::notebook style, closetab


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::removeclosetab` Command

**NAME**
: `scrollutil::removeclosetab` – Remove the `closetab` element from the tabs of a ttk::notebook style

**SYNOPSIS**
: 

```
package require scrollutil_tile
scrollutil::removeclosetab notebookStyle
```

: Note that the `scrollutil::removeclosetab` command is provided by the Scrollutil_tile package, but not by Scrollutil.

**DESCRIPTION**
: Modifies the style `notebookStyle.Tab` corresponding to a given ttk::notebook style (like `TNotebook` or `My.TNotebook`) by removing the `closetab` element from it.  If the `closetab` element was not present in the style `notebookStyle.Tab` then the command returns without performing any action.

**KEYWORDS**
: ttk::notebook style, closetab


[Contents](#contents)     [Start page](index.md)

---

## The `scrollutil::closetabstate` Command

**NAME**
: `scrollutil::closetabstate` – Set or query the state of the `closetab` element of a ttk::notebook or scrollednotebook tab

**SYNOPSIS**
: 

```
package require scrollutil_tile
scrollutil::closetabstate notebook tabId ?normal|disabled?
```

: Note that the `scrollutil::closetabstate` command is provided by the Scrollutil_tile package, but not by Scrollutil.

**DESCRIPTION**
: Sets or queries the state of the `closetab` element of the tab specified by `tabId` of the ttk::notebook or scrollednotebook widget `notebook`.  The optional argument specifies the state as `normal` or `disabled`.  Without this argument the command returns the current state of the tab's `closetab` element.

: Provided that the widget's `disabled` state flag is not set and the value of the tab's `-state` option is `normal`, the differences between the two `closetab` states are as follows:

  - In the default `normal` state, the `closetab` element is shown in white color on light red background when hovered, and in white color on dark red background when pressed with mouse button 1.  By releasing mouse button 1 over the same element, the action described under points 4 and 5 of the [FURTHER BINDINGS](#the-scrollutil-scrollednotebook-command-detailed-reference) section above is triggered.
  - In the `disabled` state, the `closetab` element, both when hovered and when pressed, is shown in the same theme-specific foreground color as a disabled text, and pressing and later releasing mouse button 1 over it has no effect.

: Note that the `closetabstate` scrollednotebook widget subcommand is a convenient shortcut for this command.

**KEYWORDS**
: tab, closetab, state


[Contents](#contents)     [Start page](index.md)
