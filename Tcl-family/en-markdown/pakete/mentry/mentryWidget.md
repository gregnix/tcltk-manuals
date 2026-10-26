# The `mentry::mentry` Command

## For Mentry Version 4.5

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
: `mentry::mentry` – Create and manipulate multi-entry widgets

[SYNOPSIS](#detailed-reference)
: 

```
mentry::mentry pathName ?options?
```

[STANDARD OPTIONS](#detailed-reference)
: 

```
-borderwidth          -highlightcolor      -relief
-highlightbackground  -highlightthickness
```

[OPTIONS FOR ALL ENTRY AND LABEL COMPONENTS](#detailed-reference)
: 

```
-background  -cursor  -font  -foreground
```

[OPTIONS FOR ALL ENTRY COMPONENTS](#detailed-reference)
: 

```
-exportselection    -insertwidth        -selectforeground
-insertbackground   -invalidcommand     -show
-insertborderwidth  -justify            -state
-insertofftime      -selectbackground   -validate
-insertontime       -selectborderwidth  -validatecommand
```

[WIDGET-SPECIFIC OPTIONS](#detailed-reference)
: `-body {width ?text width text ...?}`

: `-disabledbackground color`

: `-disabledforeground color`

: `-readonlybackground color`

: `-takefocus 0|1|""|command`

: `-textvariable array`

[INDICES](#detailed-reference)
: 

```
number  end
```

[WIDGET COMMAND](#detailed-reference)
: `pathName adjustentry index string1 ?string2?`

: `pathName attrib ?name? ?value name value ...?`

: `pathName cget option`

: `pathName clear first ?last?`

: `pathName configure ?option? ?value option value ...?`

: `pathName entries`

: `pathName entrycount`

: `pathName entrylimit index`

: `pathName entrypath index`

: `pathName getarray array`

: `pathName getlist`

: `pathName getstring`

: `pathName hasattrib name`

: `pathName isempty ?index?`

: `pathName isfull ?index?`

: `pathName labelcount`

: `pathName labelpath index`

: `pathName labels`

: `pathName put startIndex ?string string ...?`

: `pathName setentryextrawidth index amount`

: `pathName setentryfont index font`

: `pathName setentrywidth index width`

: `pathName unsetattrib name`

[KEYWORDS](#detailed-reference)
: mentry, widget, entry, label


[Contents](#contents)     [Start page](index.md)

---

## Detailed Reference

**NAME**
: `mentry::mentry` – Create and manipulate multi-entry widgets

**SYNOPSIS**
: 

```
mentry::mentry pathName ?options?
```

**DESCRIPTION**
: The `mentry::mentry` command creates a new window named `pathName` and of the class `Mentry`, and makes it into a **mentry** widget.  Additional options, described below, may be specified on the command line or in the option database to configure aspects of the mentry such as its colors, font, and components.  The `mentry::mentry` command returns its `pathName` argument.  At the time this command is invoked, there must not exist a window named `pathName`, but `pathName`'s parent must exist.

: The word *mentry* is an abbreviation of *multi-entry*.  A mentry is a mega-widget consisting of any number of entries separated by labels, all embedded in a frame.  Due to appropriately chosen configuration options for the entries and labels, a mentry widget looks like one single entry containing preinserted text pieces that cannot be moved, changed, or deleted by the user.

: In the Mentry package both the entry and label components are direct children of the mentry widget.  In the Mentry_tile package only the labels are direct children, while the entry components are grandchildren of the mentry (for technical reasons, the entry components of a tile-based mentry widget are embedded in frame widgets, which in turn are children of the mentry).

: The initial width of each entry component (specified by the `-body` configuration option) also determines the maximal number of characters that can be inserted into it.  This is achieved with the aid of the `wcb::callback` command, by registering the `wcb::checkEntryLen` before-`insert` callback with the entry component.  In order to keep this callback, additional before-`insert` callbacks (if needed) should only be registered with the `wcb::cbappend` and `wcb::cbprepend` commands.  When reaching this limit in an entry having the input focus, the latter is set automatically to the next enabled entry component, the contents of that widget is selected, and the insertion cursor is set to its end.  This is made sure by defining an appropriate after-`insert` callback, which must be kept to be the last such callback for the entry.  For this reason, additional after-`insert` callbacks (if needed) should only be registered with the `wcb::cbprepend` command.  The same command should be used exclusively to define after-`motion` callbacks (if needed), because `mentry::mentry` registers one that must be the last after-`motion` callback for each entry component.

: Each mentry widget may have any number of **attributes**, which can be used in commands that create or manipulate mentry widgets for particular purposes.  For example, each date mentry created by the `mentry::dateMentry` command has a `type` attribute having the value `"Date"` and a `format` attribute specifying the meanings of its components.  The values of these attributes are queried and used in the bodies of the procedures `mentry::putClockVal` and `mentry::getClockVal`.

**STANDARD OPTIONS**
: 

```
-borderwidth          -highlightcolor      -relief
-highlightbackground  -highlightthickness
```

: See the **options** manual entry for details on the standard Tk widget options.  These options are only supported by the Mentry package, but not by Mentry_tile.

**OPTIONS FOR ALL ENTRY AND LABEL COMPONENTS**
: 

```
-background  -cursor  -font  -foreground
```

: These options (described in the **options** manual entry) specify the values of the options of the same names for all entry and label components of the given multi-entry widget.  These values may be changed for an individual component by using the `configure` subcommand of the Tcl command corresponding to that component.  However, applying this method to change the font of an entry of a tile-based mentry widget might break the latter's appearance (this has tile-related technical reasons).  To avoid this problem, it is recommended to use the `setentryfont` subcommand of the Tcl command associated with the mentry widget for changing the value of the `-font` option of one of its entry components.

: When using the package Mentry_tile, these options have theme-specific default values.  The common abbreviations `-bg` (for `-background`) and `-fg` (for `-foreground`) are supported for both classical and tile-based mentry widgets.

: **REMARK:**  Please take into account that for some themes (like `Arc`, `plastik`, `tileqt`, `vista`, and `xpnative`), the `-background` option will be ignored for the entry components of a tile-based mentry widget.  The same holds true for the `aqua` theme in dark mode and with some Tk versions in the light appearance, too.

**OPTIONS FOR ALL ENTRY COMPONENTS**
: 

```
-exportselection    -insertwidth        -selectforeground
-insertbackground   -invalidcommand     -show
-insertborderwidth  -justify            -state
-insertofftime      -selectbackground   -validate
-insertontime       -selectborderwidth  -validatecommand
```

: These options specify the values of the options of the same names for all entry components of the given multi-entry widget.  These values may be changed for an individual entry component by using the `configure` subcommand of the Tcl command corresponding to that entry.  The options `-insertbackground`, `-insertborderwidth`, `-insertofftime`, `-insertontime`, `-insertwidth`, `-selectbackground`, `-selectborderwidth`, and `-selectforeground` are only supported by the Mentry package, but not by Mentry_tile.  The common abbreviations `-invcmd` (for `-invalidcommand`) and `-vcmd` (for `-validatecommand`) are supported for both classical and tile-based mentry widgets.

**WIDGET-SPECIFIC OPTIONS**
: 

|   |   |
| --- | --- |
| Command-Line Name:  | `-body` |
| Database Name: | ` body` |
| Database Class: | ` Body` |

Specifies the initial widths of the entry components of the given multi-entry widget, as well as the texts to be displayed in the labels separating the entries.  The value of this option is viewed as a list.  Each odd-numbered element is interpreted as the value of the `-width` configuration option of an entry component, while each even-numbered element represents the value of the `-text` configuration option of a label child.  That is, each entry width must be followed by a label text, except for the last one, for which a corresponding label text is optional.  The order of the list elements determines the creation order of the components; these will be packed in a row, without any horizontal padding.  The initial width of each entry also determines the number of characters that can be inserted into it; this maximal length remains unchanged even if the entry's width is set to a new value later on.

The width of an entry component and the text displayed in a label may be changed by using the `configure` subcommand of the Tcl command corresponding to that component.  However, applying this method to change the width of of an entry of a tile-based mentry widget might break the latter's appearance (this has tile-related technical reasons).  To avoid this problem, it is recommended to use the `setentrywidth` subcommand of the Tcl command associated with the mentry widget for changing the value of the `-width` option of one of its entry components.


|   |   |
| --- | --- |
| Command-Line Name:  | `-disabledbackground` |
| Database Name: | ` disabledBackground` |
| Database Class: | ` DisabledBackground` |

This option specifies the background color to use for all entry and label components of the given multi-entry widget when it is disabled.  If the value of this option is an empty string then the normal background color is used.  This option is only supported by the Mentry package, but not by Mentry_tile.


|   |   |
| --- | --- |
| Command-Line Name:  | `-disabledforeground` |
| Database Name: | ` disabledForeground` |
| Database Class: | ` DisabledForeground` |

This option specifies the foreground color to use for all entry and label components of the given multi-entry widget when it is disabled.  If the value of this option is an empty string then the normal foreground color is used.  This option is only supported by the Mentry package, but not by Mentry_tile.


|   |   |
| --- | --- |
| Command-Line Name:  | `-readonlybackground` |
| Database Name: | ` readonlyBackground` |
| Database Class: | ` ReadonlyBackground` |

This option specifies the background color to use for all entry and label components of the given multi-entry widget when it is readonly.  If the value of this option is an empty string then the normal background color is used.  This option is only supported by the Mentry package, but not by Mentry_tile.


|   |   |
| --- | --- |
| Command-Line Name:  | `-takefocus` |
| Database Name: | ` takeFocus` |
| Database Class: | ` TakeFocus` |

This option determines whether the widget accepts the focus during keyboard traversal.  It is almost identical to the standard option of the same name (see the **options** manual entry for details).  The only difference is that not the widget itself but its first enabled entry component will receive the focus during keyboard traversal with the standard keys (`Tab` and `Shift-Tab`).  See the [DEFAULT BINDINGS](#detailed-reference) section below for information on how to move the focus from one entry component to another one using the keyboard.


|   |   |
| --- | --- |
| Command-Line Name:  | `-textvariable` |
| Database Name: | ` textvariable` |
| Database Class: | ` Variable` |

If the value of this option is not an empty string then it must be an array.  In this case, for each entry component of the given multi-entry widget the value of the array element with the index of the entry as element name specifies the value of the `-textvariable` option for that entry.  The entry indices start with `0`.  For example, specifying  `-textvariable arr`  for a multi-entry widget having two entry components is equivalent to specifying  `-textvariable arr(0)`  for the first and  `-textvariable arr(1)`  for the second entry of that widget.

**INDICES**
: Some of the widget commands for mentries take an index as argument.  An index specifies a particular entry or label component of the mentry, in any of the following ways:


|   |   |
| --- | --- |
| `number  ` | Specifies the component as a numerical index, where `0` corresponds to the first entry or label component. |
| `end` | Indicates the last entry or label component of the mentry. |

: The word `end` can be abbreviated as `en` or `e`.  Out-of-range indices are automatically rounded to the nearest legal value.

**WIDGET COMMAND**
: The `mentry::mentry` command creates a new Tcl command whose name is `pathName`.  This command may be used to invoke various operations on the widget.  It has the following general form:

```
pathName option ?arg arg ...?
```

: `option` and the `arg`s determine the exact behavior of the command.  The following commands are possible for mentry widgets:


`pathName adjustentry index string1 ?string2?`
: Increases the width in pixels of the entry component identified by `index` if needed, to make it just large enough for texts of the entry-specific maximal length, consisting of characters contained in the `string1` argument, excepting at most one character, which may be contained in the optional `string2` argument.  Returns an empty string.

: For example, when constructing a mentry widget whose components will accept up to two uppercase hexadecimal digits only, by passing the string `"0123456789ABCDEF"` to this subcommand you can make sure that the entry components will have optimal widths, just large enough to display not only the decimal digits, but also up to two letters in the range `A` - `F` (which need more room than the decimal digits when using a proportionally-spaced font).  It is recommended to invoke this subcommand even if the allowed characters are restricted to the digits `0` - `9` only, because in some fonts not all decimal digits have the same width.

: An example for the case where both string arguments are used is a mentry widget for (signed) real numbers in fixed-point format.  For its first entry component (displaying the integer part of a real number), this subcommand should be invoked with `"0123456789"` as its `string1` argument and `"+-"` as its `string2` argument, being that the entry's first character can be not only a decimal digit but also the sign `"+"` or `"-"`.  (Note that in most proportional fonts, the width of the `"+"` character is larger than that of `"0"`.)

`pathName attrib ?name? ?value name value ...?`
: Queries or modifies the attributes of the widget.  If no `name` is specified, the command returns a list of pairs, each of which contains the name and the value of an attribute for `pathName`.  If `name` is specified with no `value`, then the command returns the value of the one named attribute, or an empty string if no corresponding value exists (you can use the `hasattrib` subcommand to distinguish this case from the one that the value of an *existing* attribute is an empty string).  If one or more `name`-`value` pairs are specified, then the command sets the given widget attribute(s) to the given value(s); in this case the return value is an empty string.  `name` may be an arbitrary string.

`pathName cget option`
: Returns the current value of the configuration option given by `option`, which may have any of the values accepted by the `mentry::mentry` command.

`pathName clear first ?last?`
: Erases the contents of one or more entry components of the widget.  `first` and `last` are indices specifying the first and last entries in the range to clear.  If `last` is not specified then it defaults to `first`, i.e., a single entry is cleared.  The return value is an empty string.

`pathName configure ?option? ?value option value ...?`
: Queries or modifies the configuration options of the widget.  If no `option` is specified, the command returns a list describing all of the available options for `pathName` (see `Tk_ConfigureInfo` for information on the format of this list).  If `option` is specified with no `value`, then the command returns a list describing the one named option (this list will be identical to the corresponding sublist of the value returned if no `option` is specified).  If one or more `option`-`value` pairs are specified, then the command modifies the given widget option(s) to have the given value(s); in this case the return value is an empty string.  `option` may have any of the values accepted by the `mentry::mentry` command.

`pathName entries`
: Returns a list containing the path names of all entry components of the widget.

`pathName entrycount`
: Returns the number of all entry components of the widget.

`pathName entrylimit index`
: Returns the number of characters that can be inserted into the entry component identfied by `index`.

`pathName entrypath index`
: Returns the path name of the entry component identfied by `index`.

`pathName getarray array`
: For each entry component of the widget, the command assigns the string contained in the entry to the element of `array` having the index of the entry as element name.  The entry indices start with `0`.  The return value is an empty string.

`pathName getlist`
: Returns a list containing the strings of all entry components of the widget.

`pathName getstring`
: Returns a string built by concatenating the strings contained in the entry components of the widget with the texts displayed in the labels separating the entries, in the creation order of the components, as given by the `-body` configuration option.  That is, the string of the first entry is followed by the text of the first label, which in turn is followed by the string of the second entry, and so on.

`pathName hasattrib name`
: Returns `1` if the attribute `name` exists and `0` otherwise.

`pathName isempty ?index?`
: If `index` is specified then the command returns the value `1` if the string contained in the entry component identfied by `index` is empty and `0` otherwise.  If this optional argument is not present then the command returns the value `1` if the strings contained in the entry components of the widget are all empty and `0` otherwise.

`pathName isfull ?index?`
: If `index` is specified then the command returns the value `1` if the length of the string contained in the entry component identfied by `index` equals the number of characters that can be inserted into the entry and `0` otherwise.  If this optional argument is not present then the command returns the value `1` if the lengths of the strings contained in the entry components of the widget all equal the numbers of characters that can be inserted into the respective entries (i.e., if all entry components are full) and `0` otherwise.

`pathName labelcount`
: Returns the number of all label children of the widget.

`pathName labelpath index`
: Returns the path name of the label child identfied by `index`.

`pathName labels`
: Returns a list containing the path names of all label children of the widget.

`pathName put startIndex ?string string ...?`
: Replaces the texts of the entry components whose indices are greater than or equal to `startIndex` with the corresponding `string` arguments by using the `delete` and `insert` operations, until either the entries or the `string`s are consumed.  If one of these subcommands gets canceled by some before-callback in any entry component then the command restores the original contents of all affected entries and returns the value `0`, otherwise it returns `1`.  In both cases, the command keeps the position of the insertion cursor in all entry components.

`pathName setentryextrawidth index amount`
: Specifies additonal width to provide for the entry component identified by `index`.  `amount` may have any of the standard forms for screen distances (e.g., a number of pixels).  The return value is an empty string.

: Notice that changing the width of an entry component has no impact on the number of characters that can be inserted into it, which remains set to the corresponding component of the value of the mentry's `-body` option.

`pathName setentryfont index font`
: Sets the font of the entry component identified by `index` to the value given by `font`.  This is done by invoking the `configure` subcommand of the Tcl command corresponding to the entry.  When using the package Mentry_tile, this command also performs some additional steps necessary for updating the appearance of the tile-based mentry widget.  The return value is an empty string.

`pathName setentrywidth index width`
: Sets the width of the entry component identified by `index` to the number of characters given by `width`.  This is done by invoking the `configure` subcommand of the Tcl command corresponding to the entry.  When using the package Mentry_tile, this command also performs some additional steps necessary for updating the appearance of the tile-based mentry widget.  The return value is an empty string.

: Notice that changing the width of an entry component has no impact on the number of characters that can be inserted into it, which remains set to the corresponding component of the value of the mentry's `-body` option.

`pathName unsetattrib name`
: Unsets the attribute `name`.  Returns an empty string.


**DEFAULT BINDINGS**
: The `mentry::mentry` command partially redefines the bindings of the components of the mentry widget it creates:


  1. Clicking mouse button 1 in a label child positions the insertion cursor to the end of the last enabled entry preceding the label, sets the input focus to that entry, and clears any selection in it.
  2. If in a non-empty entry component a character is typed that is contained in the label following that entry (if any), then the focus is moved to the next enabled entry component, the contents of that entry are selected, and the insertion cursor is set to its end.
  3. At the beginning of an entry component that is not the first enabled entry within the widget, the `Left` key clears the selection in that entry, moves the focus to the previous enabled entry component, and sets the insertion cursor to the end of that widget.  Similarly, at the end of an entry component that is not the last enabled entry within the widget, the `Right` key clears the selection in that entry, moves the focus to the next enabled entry component, and sets the insertion cursor to the beginning of that widget.  If `tk_strictMotif` is false then `Control-b` and `Control-f` behave the same as `Left` and `Right`, respectively.
  4. In an entry component that is not the first enabled entry within the widget, `Control-Left` moves the focus to the previous enabled entry component, selects the contents of that widget, and sets the insertion cursor to its end; if there is no enabled entry component to the left of the current one then `Control-Left` moves the insertion cursor to the beginning of the current entry and clears the selection in that widget.  Similarly, in an entry component that is not the last enabled entry within the widget, `Control-Right` moves the focus to the next enabled entry component, selects the contents of that widget, and sets the insertion cursor to its end; if there is no enabled entry component to the right of the current one then `Control-Right` moves the insertion cursor to the end of the current entry and clears the selection in that widget.  If `tk_strictMotif` is false then `Meta-b` and `Meta-f` behave the same as `Control-Left` and `Control-Right`, respectively.
  5. The `Home` key clears the selection in the current entry widget, moves the focus to the first enabled entry component, and sets the insertion cursor to the beginning of that widget.  Similarly, the `End` key clears the selection in the current entry widget, moves the focus to the last enabled entry component, and sets the insertion cursor to the end of that widget.  If `tk_strictMotif` is false then `Control-a` and `Control-e` behave the same as `Home` and `End`, respectively.
  6. `Shift-Home` moves the focus to the first enabled entry component, sets the insertion cursor to the beginning of that widget, and either extends the selection to that position, or clears the selection in the current entry and selects the contents of the new widget, depending upon whether the current entry is the first enabled entry component or not.  Similarly, `Shift-End` moves the focus to the last enabled entry component, sets the insertion cursor to the end of that widget, and either extends the selection to that position, or clears the selection in the current entry and selects the contents of the new widget, depending upon whether the current entry is the last enabled entry component or not.
  7. The `BackSpace` key deletes the selection if there is one in the current entry.  Otherwise, it deletes either the character to the left of the insertion cursor in the current entry, or the last character of the previous enabled entry component.  The latter takes place at the beginning of an entry component that is not the first enabled entry within the widget; in this case, the `BackSpace` key also moves the focus to the previous enabled entry component and sets the insertion cursor to its end.  If `tk_strictMotif` is false then `Control-h` behaves the same as `BackSpace`.
  8. If `tk_strictMotif` is false then `Meta-d` deletes all characters to the right of the insertion cursor within the current entry, while `Meta-BackSpace` and `Meta-Delete` delete either all characters to the left of the insertion cursor in the current entry, or the contents of the previous enabled entry component.  The latter takes place at the beginning of an entry component that is not the first enabled entry within the widget; in this case, `Meta-BackSpace` and `Meta-Delete` also clear the selection in the current entry widget and move the focus to the previous enabled entry component.

**KEYWORDS**
: mentry, widget, entry, label


[Contents](#contents)     [Start page](index.md)
