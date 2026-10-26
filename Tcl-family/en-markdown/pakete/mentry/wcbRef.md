# Wcb Command Reference

## For Wcb Version 4.2

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The wcb::callback Command](#the-wcb-callback-command)
- [The wcb::cbappend Command](#the-wcb-cbappend-command)
- [The wcb::cbprepend Command](#the-wcb-cbprepend-command)
- [The wcb::cancel Command](#the-wcb-cancel-command)
- [The wcb::canceled Command](#the-wcb-canceled-command)
- [The wcb::extend Command](#the-wcb-extend-command)
- [The wcb::replace Command](#the-wcb-replace-command)
- [The wcb::pathname Command](#the-wcb-pathname-command)
- [The wcb::changeEntryText Command](#the-wcb-changeentrytext-command)
- [The wcb::postInsertEntryLen Command](#the-wcb-postinsertentrylen-command)
- [The wcb::postInsertEntryText Command](#the-wcb-postinsertentrytext-command)
- [The wcb::postDeleteEntryText Command](#the-wcb-postdeleteentrytext-command)
- [Before-insert Callbacks for entry, spinbox, and combobox Widgets](#before-insert-callbacks-for-entry-spinbox-and-combobox-widgets)
- [Before-insert Callbacks for text and ctext Widgets](#before-insert-callbacks-for-text-and-ctext-widgets)

[Start page](index.md)

---

## The `wcb::callback` Command

**NAME**
: `wcb::callback` – Retrieve, set, and remove widget callbacks

**SYNOPSIS**
: 

```
wcb::callback widgetName before|after option ?callback callback ...?
```

**DESCRIPTION**
: Retrieves, sets, or removes the callbacks for the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, Ttk combobox, listbox, tablelist, Ttk treeview, text, or ctext widget `widgetName`, the argument `before` or `after`, and the command corresponding to `option`.  The values of the `option` argument can be:


  - `insert`, `delete`, or `motion`, for a Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, Ttk combobox, text, or ctext widget;
  - `replace`, for a text or ctext widget;
  - `activate`, for a listbox, tablelist, or Ttk treeview widget;
  - `selset` or `selclear`, for a listbox, tablelist, Ttk treeview, text, or ctext widget;
  - `seladd` or `seltoggle`, for a Ttk treeview widget;
  - `cellselset` or `cellselclear`, for a tablelist or Ttk treeview widget;
  - `cellseladd` or `cellseltoggle`, for a Ttk treeview widget;
  - `activatecell`, for a tablelist widget.

: If no arguments after the `option` parameter are specified, then the procedure just returns the current before- or after-callback list, respectively, for the given widget operation.

: Otherwise:


  - If at least one of the arguments following the `option` parameter is a nonempty string, then:
  - If all arguments following the `option` parameter are empty, then the procedure unregisters all the corresponding before- or after-callbacks for the given widget and returns an empty string.

    - if called for the first time for this widget with at least one nonempty argument following the `option` parameter, then the procedure renames the Tcl command `::widgetName` to `::_widgetName` and builds a new procedure `::widgetName`, in which the execution of the widget operations associated with the above values of `option` is preceded by invocations of the corresponding before-callbacks and followed by calls to the corresponding after-callbacks, in the global scope;
    - it sets the callback list to the one built from these arguments and returns the new list.

: When a callback is invoked for the widget `widgetName`, the name of the **proxy command** `::_widgetName` and the command arguments are automatically appended to it as parameters.  Use the `wcb::pathname` command to retrieve the original widget path name.

: The following table shows the widget subcommands corresponding to the above values of `option`, together with the arguments of these subcommands:


| Widget | `option` | Subcommand | Arguments |
| --- | --- | --- | --- |
| Tk entry, ttk::entry,    BWidget Entry,    Tk spinbox, ttk::spinbox,    or ttk::combobox | `insert` | `insert` | `index string` |
| `delete` | `delete` | `from ?to?` |
| `motion` | `icursor` | `index` |
| listbox | `activate` | `activate` | `index` |
| `selset` | `selection set` | `first ?last?` |
| `selclear` | `selection clear` | `first ?last?` |
| tablelist::tablelist | `activate` | `activate` | `index` |
| `selset` | `selection set` | `first ?last?`   (`indexList`   or  `firstIndex lastIndex`) |
| `selclear` | `selection clear` | `first ?last?`   (`indexList`   or  `firstIndex lastIndex`) |
| `activatecell` | `activatecell` | `cellIndex` |
| `cellselset` | `cellselection set` | `first ?last?`   (`cellIndexList`   or  `firstCell lastCell`) |
| `cellselclear` | `cellselection clear` | `first ?last?`   (`cellIndexList`   or  `firstCell lastCell`) |
| ttk::treeview | `activate` | `focus` | `item` |
| `selset` | `selection set` | `itemList` |
| `seladd` | `selection add` | `itemList` |
| `selclear` | `selection remove` | `itemList` |
| `seltoggle` | `selection toggle` | `itemList` |
| `cellselset` | `cellselection set` | `first ?last?`   (`cellList`   or  `firstCell lastCell`) |
| `cellseladd` | `cellselection add` | `first ?last?`   (`cellList`   or  `firstCell lastCell`) |
| `cellselclear` | `cellselection remove` | `first ?last?`   (`cellList`   or  `firstCell lastCell`) |
| `cellseltoggle` | `cellselection toggle` | `first ?last?`   (`cellList`   or  `firstCell lastCell`) |
| text or ctext | `insert` | `insert` | `index string ?tagList string tagList ...?` |
| `delete` | `delete` | `from ?to?` |
| `replace` | `replace` | `from to string ?tagList string tagList ...?` |
| `motion` | `mark set insert` | `index` |
| `selset` | `tag add sel` | `from ?to from to ...?` |
| `selclear` | `tag remove sel` | `from ?to from to ...?` |

: **REMARKS:**


  1. You may abbreviate the words `before`, `after`, `insert`, `delete`, `replace`, `motion`, and `activate` (the latter not for tablelist widgets) to a minimum of one character.  Similarly, the first four characters of the words `selset`, `selclear`, `seladd`, and `seltoggle`, the first eight characters of `cellselset`, `cellselclear`, `cellseladd`, and `cellseltoggle`, and the first nine characters of `activatecell` are sufficient for Wcb to recognize these options.
  2. After a successful invocation of this command with at least one nonempty callback following the `option` argument, you can use either the new procedure `widgetName` or the proxy command `::_widgetName` to perform any valid operation on the widget `widgetName`.  Use the proxy command `::_widgetName` if you want to prevent the callbacks from being invoked when executing the respective widget subcommand.
  3. When destroying a widget `widgetName` for which `wcb::callback` has replaced the corresponding Tcl command with a new procedure, the proxy command `::_widgetName` is deleted automatically by the Tcl interpreter (this is not true in the case of a BWidget Entry, tablelist, or ctext widget).  The new widget procedure `widgetName` would persist, but Wcb arranges for it to be deleted from within a cleanup script bound to the `<Destroy>` event.  This cleanup script is associated with a binding tag called `WcbCleanup`, which is appended to the list of binding tags of the widget the first time when registering some callbacks for it.  (In the case of a BWidget Entry, tablelist, or ctext widget, this script also deletes the proxy command `::_widgetName`.)
  4. The cleanup script mentioned above also unregisters all callbacks defined for `widgetName`, thus ensuring that a widget with the same path created later will not inherit them from the widget just deleted (this can be important in some applications).  For this reason, you should be careful not to remove `WcbCleanup` from the list of binding tags of the given widget!

**KEYWORDS**
: callback, widget, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, listbox, tablelist, Ttk treeview, text, ctext


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::cbappend` Command

**NAME**
: `wcb::cbappend` – Append to a callback list

**SYNOPSIS**
: 

```
wcb::cbappend widgetName before|after option ?callback callback ...?
```

**DESCRIPTION**
: This command is almost identical to `wcb::callback`.  The only difference is that `wcb::cbappend` *appends* the arguments specified after the `option` parameter to the current callback list (if present), while `wcb::callback` *replaces* the old callbacks with these arguments.

**KEYWORDS**
: callback, append, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::cbprepend` Command

**NAME**
: `wcb::cbprepend` – Prepend to a callback list

**SYNOPSIS**
: 

```
wcb::cbprepend widgetName before|after option ?callback callback ...?
```

**DESCRIPTION**
: This command is almost identical to `wcb::callback`.  The only difference is that `wcb::cbprepend` *prepends* the arguments specified after the `option` parameter to the current callback list (if present), while `wcb::callback` *replaces* the old callbacks with these arguments.

**KEYWORDS**
: callback, prepend, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::cancel` Command

**NAME**
: `wcb::cancel` – Cancel a widget command

**SYNOPSIS**
: 

```
wcb::cancel ?script?
```

**DESCRIPTION**
: This procedure is designed to be invoked from a before-callback for a widget command.  It cancels the execution of that command and of the remaining callbacks, and evaluates the `script` argument in the global scope.  If this argument is not specified, it defaults to the `bell` command.

: The return value is the one obtained from `script` if this argument is specified and nonempty.  Otherwise, the command returns an empty string.

**KEYWORDS**
: cancel, command, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::canceled` Command

**NAME**
: `wcb::canceled` – Query the canceled status of a widget command

**SYNOPSIS**
: 

```
wcb::canceled widgetName option
```

**DESCRIPTION**
: Returns the value `1` if the most recent invocation of the widget operation corresponding to `widgetName` and `option` has been aborted by some before-callback by invoking `wcb::cancel`; otherwise, the return value is `0`.  The arguments must fulfil the same restrictions as in the case of the `wcb::callback` command.

**KEYWORDS**
: cancel, command, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::extend` Command

**NAME**
: `wcb::extend` – Extend the argument list of a widget command

**SYNOPSIS**
: 

```
wcb::extend ?arg arg ...?
```

**DESCRIPTION**
: This procedure is designed to be invoked from a before-callback for a widget command.  It appends the values given in the optional `arg` parameters to the argument list of that command.  The new argument list will be passed to the remaining callbacks for that command, too.

: This procedure simply passes its parameters to the `lappend` command, called for the argument list of the respective widget operation.

**KEYWORDS**
: extend, argument, command, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::replace` Command

**NAME**
: `wcb::replace` – Replace arguments of a widget command with new ones

**SYNOPSIS**
: 

```
wcb::replace first last ?arg arg ...?
```

**DESCRIPTION**
: This procedure is designed to be invoked from a before-callback for a widget command.  It replaces the arguments having the indices `first` through `last` of that command with the optional `arg` parameters.  The new argument list will be passed to the remaining callbacks for that command, too.  The arguments are numbered from `0` (see the table in the description of the `wcb::callback` command).

: This procedure simply passes its parameters to the `lreplace` command, called for the argument list of the respective widget operation.

**KEYWORDS**
: replace, argument, command, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::pathname` Command

**NAME**
: `wcb::pathname` – Query the path name of the widget corresponding to a Tcl command name

**SYNOPSIS**
: 

```
wcb::pathname proxyCmd
```

**DESCRIPTION**
: This procedure returns the path name of the widget corresponding to the Tcl command name `proxyCmd` passed to a callback.

: When a before- or after-callback for a widget is invoked, the name of the proxy command associated with that widget is automatically appended to it as parameter.  This procedure can be used within a callback to retrieve the path name of the widget from the command name passed to the callback as argument.  It simply returns the string range obtained from `proxyCmd` by removing the `"::_"` prefix.

**KEYWORDS**
: path name, command, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::changeEntryText` Command

**NAME**
: `wcb::changeEntryText` – Change the text of a Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget

**SYNOPSIS**
: 

```
wcb::changeEntryText widgetName string
```

**DESCRIPTION**
: Replaces the text of the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `widgetName` with `string`, by using the `delete` and `insert` operations.  If the first subcommand is canceled by some before-`delete` callback then the procedure returns without inserting the new text; if the second operation is canceled by some before-`insert` callback then the command restores the original contents of the widget.

: The procedure keeps the position of the insertion cursor.  The return value is `1` on success and `0` on failure, i.e., if one of the attempted operations was canceled by some before-callback.

**KEYWORDS**
: Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::postInsertEntryLen` Command

**NAME**
: `wcb::postInsertEntryLen` – Query the would-be length of the text in a Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget after text insertion

**SYNOPSIS**
: 

```
wcb::postInsertEntryLen widgetName string
```

**DESCRIPTION**
: Returns the length of the text that would be contained in the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `widgetName` after inserting `string`.

**KEYWORDS**
: insert, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::postInsertEntryText` Command

**NAME**
: `wcb::postInsertEntryText` – Query the would-be text of a Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget after text insertion

**SYNOPSIS**
: 

```
wcb::postInsertEntryText widgetName index string
```

**DESCRIPTION**
: Returns the text that would be contained in the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `widgetName` after inserting `string` before the character indicated by `index`.

**KEYWORDS**
: insert, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Contents](#contents)     [Start page](index.md)

---

## The `wcb::postDeleteEntryText` Command

**NAME**
: `wcb::postDeleteEntryText` – Query the would-be text of a Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget after text deletion

**SYNOPSIS**
: 

```
wcb::postDeleteEntryText widgetName from ?to?
```

**DESCRIPTION**
: Returns the text that would be contained in the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `widgetName` after deleting the characters starting with the one indicated by the index `from` and stopping just before `to`.  If `to` is not specified then the return value is the text that would be contained in the widget after deleting the single character given by `from`.

: **REMARK:**  This command has a variable number (2 or 3) of arguments, because the `delete` subcommand of the Tcl command associated with `widgetName` expects either one or two indices as arguments.  For this reason, the correct way to invoke this command from within a before-`delete` callback is as shown in the following example:


```
proc myBeforeDeleteCallback {w args} {
    #
    # Get the text that would be contained in the widget after
    # deleting the characters specified by $args, which stands
    # for the one or two arguments passed to delete; pass these
    # arguments to wcb::postDeleteEntryText by expanding $args
    #
    set newText [eval [list wcb::postDeleteEntryText $w] $args]
    if {!some_condition_on_$newText} {
        wcb::cancel
    }
}
```

: The following alternative, more elegant solution requires Tcl/Tk 8.5 or later:


```
proc myBeforeDeleteCallback {w args} {
    # . . .
    set newText [wcb::postDeleteEntryText $w {*}$args]
    . . .
}
```

**KEYWORDS**
: delete, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Contents](#contents)     [Start page](index.md)

---

## Before-`insert` Callbacks for entry, spinbox, and combobox Widgets

**NAME**
: `wcb::checkStrFor*`, `wcb::convStrTo*`, `wcb::checkEntryFor*`, `wcb::checkEntryLen` – Before-`insert` callbacks for Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, and Ttk combobox widgets

**SYNOPSIS**
: 

```
wcb::checkStrForRegExp  exp w idx str

wcb::checkStrForAlpha       w idx str
wcb::checkStrForNum         w idx str
wcb::checkStrForAlnum       w idx str

wcb::convStrToUpper         w idx str
wcb::convStrToLower         w idx str

wcb::checkEntryForInt       w idx str
wcb::checkEntryForUInt  max w idx str
wcb::checkEntryForReal      w idx str
wcb::checkEntryForFixed cnt w idx str

wcb::checkEntryLen      len w idx str
```

**DESCRIPTION**
: The `wcb::checkStrForRegExp` callback checks whether the string `str` to be inserted into the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `w` is matched by the regular expression `exp`; if not, it cancels the `insert` operation.

: The three other `wcb::checkStrFor*` callbacks check whether the string `str` to be inserted into the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `w` is alphabetic, numeric, or alphanumeric, respectively; if not, they cancel the `insert` operation.  These procedures just invoke the callback `wcb::checkStrForRegExp`, passing to it the Unicode-based patterns `{^[[:alpha:]]*$}`, `{^[[:digit:]]*$}`, and `{^[[:alnum:]]*$}`.

: The `wcb::convStrTo*` callbacks replace the string `str` to be inserted into the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `w` with its uppercase or lowercase equivalent, respectively.

: The `wcb::checkEntryFor*` callbacks check whether the text contained in the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `w` after inserting the string `str` before the character indicated by the index `idx` would represent (the starting part of) an integer number, unsigned integer no greater than `max`, real number, or real number in fixed-point format with at most `cnt` digits after the decimal point, respectively; if not, they cancel the `insert` operation.  `max` and `cnt` should be nonnegative numbers or `*`;  `max = *`  means: no upper bound for the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox value, while  `cnt = *`  stands for an unlimited number of digits after the decimal point.

: The `wcb::checkEntryLen` callback checks whether the length of the text contained in the Tk or Ttk entry, BWidget Entry, Tk or Ttk spinbox, or Ttk combobox widget `w` after inserting the string `str` would be greater than `len`; if yes, it cancels the `insert` operation.

: These callback procedures are implemented in the file `wcbEntry.tcl`, contained in the `scripts` directory.  They return an empty string.

**KEYWORDS**
: callback, insert, Tk entry, Ttk entry, BWidget Entry, Tk spinbox, Ttk spinbox, Ttk combobox, widget


[Contents](#contents)     [Start page](index.md)

---

## Before-`insert` Callbacks for text and ctext Widgets

**NAME**
: `wcb::checkStrsFor*`, `wcb::convStrsTo*` – Before-`insert` callbacks for text and ctext widgets

**SYNOPSIS**
: 

```
wcb::checkStrsForRegExp exp w idx args

wcb::checkStrsForAlpha      w idx args
wcb::checkStrsForNum        w idx args
wcb::checkStrsForAlnum      w idx args

wcb::convStrsToUpper        w idx args
wcb::convStrsToLower        w idx args
```

**DESCRIPTION**
: The `wcb::checkStrsForRegExp` callback checks whether the strings to be inserted into the text or ctext widget `w`, contained in the list `args` of the form  `string ?tagList string tagList ...?`,  are matched by the regular expression `exp`; if not, it cancels the `insert` operation.

: The three other `wcb::checkStrsFor*` callbacks check whether the strings to be inserted into the text or ctext widget `w`, contained in the list `args` of the form  `string ?tagList string tagList ...?`,  are alphabetic, numeric, or alphanumeric, respectively; if not, they cancel the `insert` operation.  These procedures just invoke the callback `wcb::checkStrsForRegExp`, passing to it the Unicode-based patterns `{^[[:alpha:]\n]*$}`, `{^[[:digit:]\n]*$}`, and `{^[[:alnum:]\n]*$}`.

: The `wcb::convStrsTo*` callbacks replace the strings to be inserted into the text or ctext widget `w`, contained in the list `args` of the form  `string ?tagList string tagList ...?`,  with their uppercase or lowercase equivalents, respectively.

: These callback procedures are implemented in the file `wcbText.tcl`, contained in the `scripts` directory.  They return an empty string.

**KEYWORDS**
: callback, insert, text, ctext, widget


[Contents](#contents)     [Start page](index.md)
