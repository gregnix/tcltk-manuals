# Interactive Tablelist Cell Editing Using Tk Core Widgets

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [Interactive Cell Editing Using the entry Widget](#interactive-cell-editing-using-the-entry-widget)
- [Interactive Cell Editing Using the text Widget](#interactive-cell-editing-using-the-text-widget)
- [Interactive Cell Editing Using the spinbox Widget](#interactive-cell-editing-using-the-spinbox-widget)
- [Interactive Cell Editing Using the checkbutton Widget](#interactive-cell-editing-using-the-checkbutton-widget)
- [Interactive Cell Editing Using the menubutton Widget](#interactive-cell-editing-using-the-menubutton-widget)

[Start page](index.md)

---

## Overview

Tablelist supports interactive cell editing with the aid of the Tk core entry, text, spinbox, checkbutton, and menubutton widgets.  These widgets are automatically registered for cell editing, hence the only action needed for using one of them for editing the cells of a given column is as follows:

Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to `entry`, `text`, `spinbox`, `checkbutton`, or `menubutton`, respectively.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)  Since the default value of the `-editwindow` column configuration option is `entry`, it is not necessary to set it explicitly if the editing should take place with the aid of an embedded entry widget.

**REMARK:**  The temporary embedded Tk core widget used for interactive cell editing will appear properly scaled, according to the display's DPI scaling level and Tk's scaling factor given by  `[tk scaling]`.

[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the entry Widget

**DESCRIPTION**
: As mentioned above, the interactive cell editing in a tablelist widget takes place per default with the aid of an embedded entry widget.  Refer to the [INTERACTIVE CELL EDITING](tablelistWidget.md#detailed-reference) section of the reference page describing the `tablelist::tablelist` command for details on the editing process.

**KEYWORDS**
: tablelist, editing, entry


[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the text Widget

**DESCRIPTION**
: The temporary embedded text widget used for interactive cell editing will be created with its `-padx` and `-pady` options set to `2`, its `-wrap` option set to `none`, and its initial height set to the number of lines contained in it.  There is, however, an exception from this rule:  If the `-wrap` option of the cell's column was set to true and Tk version 8.5 or higher is being used, then the text widget's `-wrap` option will be set to `word` and its initial height will equal the number of *display* lines (taking into account the line wraps) contained in it.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to override the initial settings (except the height) according to your needs.

: If the text widget's `-wrap` option was set to `word` or `char` (either by Tablelist or from within the above-mentioned script) and Tk version 8.5 or higher is being used, then, whenever its width changes (e.g., due to interactive column resizing), its height will be set automatically to the number of display lines contained in it.  (The number of display lines is retrieved with the aid of the  `count -displaylines`  text widget subcommand, introduced in Tk 8.5.)

: If the widget callback package Wcb was loaded into the interpreter (via  `package require Wcb`  or  `package require wcb`)  then the text widget's height will be updated automatically whenever text is inserted into or deleted from it, which makes the editing much more user-friendly.  This is achieved by using an appropriately defined after-`insert` and after-`delete` callback for the edit window.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to define further callbacks for the text widget.  (The above-mentioned callback is created via `wcb::cbappend`, *after* returning from that script.)

: The `Tab` key is reserved for navigation between the editable cells, but the user can insert a tabulator character into the text widget by pressing `Control-i`.

: Unlike in the case of the other widgets used for interactive cell editing, the `Return` and `KP_Enter` keys insert a newline character into the text widget.  `Control-j` can also be used for inserting a newline.  `Control-Return` and `Control-KP_Enter` terminate the editing and destroy the edit window.

: `Control-Home` and `Control-End` have their well-known text widget-specific bindings, just like `Meta-<` and `Meta->` if `tk_strictMotif` is false.  Again, this is different from the behavior of the other widgets used for interactive cell editing.  For jumping into the first/last editable cell, the user can press `Alt-Home`/`Alt-End` or `Meta-Home`/`Meta-End` (`Command-Home`/`Command-End` on Mac OS X/11+ Aqua).

**KEYWORDS**
: tablelist, editing, text


[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the spinbox Widget

**DESCRIPTION**
: The temporary embedded spinbox widget used for interactive cell editing will be created with its `-state` option set to `normal`, which makes the widget editable.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to set the state of the spinbox to `readonly` or define validations for it, as well as for setting its (range of) values and its `-wrap` option.

**KEYWORDS**
: tablelist, editing, spinbox


[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the checkbutton Widget

**DESCRIPTION**
: On Windows and Mac OS X/11+ Aqua the temporary embedded checkbutton widget used for interactive cell editing will be created with explicitly set values for its `-borderwidth`, `-font`, `-padx`, `-pady`, and `-variable` options.  In an X11 environment it will be created with explicitly set values for its `-borderwidth`, `-indicatoron`, `-image`, `-selectimage`, `-background`, `-activebackground`, `-selectcolor`, and `-variable` options.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to set any other options, like `-offvalue` and `-onvalue`, according to the *internal* values of the cells.  Since the default values of the `-offvalue` and `-onvalue` checkbutton options are `0` and `1`, you don't need to change these options if the cells have the same internal values `0` and `1`.

**KEYWORDS**
: tablelist, editing, checkbutton


---

## Interactive Cell Editing Using the menubutton Widget

**DESCRIPTION**
: The temporary embedded menubutton widget used for interactive cell editing will be created with explicitly set values for its `-anchor`, `-indicatoron`, `-justify`, `-padx`, `-pady`, `-relief`, and `-textvariable` options.  In addition, a menu with its `-tearoff` option set to `0` and an appropriate script as the value of its `-postcommand` option is created and set as the value of the menubutton's `-menu` option.  In an X11 environment, the menu's appearance is adapted to that of the tablelist widget by setting its `-background`, `-foreground`, `-activebackground`, `-activeforeground`, and `-activeborderwidth` options to appropriate values.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to set any other options of the menubutton and/or its associated menu.  You will, however, need this script in the first place for populating the menu, preferably with radiobutton entries.  For every radiobutton entry added to the menu, the Tablelist implementation will make sure that its value (which can be specified by setting the entry's `-value` or `-label` option) will be displayed in the menubutton as its text when the entry is selected.  (Tablelist achieves this by setting the menu entry's `-variable` option to the value of the menubutton's `-textvariable` option.)  For menu entries of types other than radiobutton (e.g., for command entries) it is the responsibility of the application to make sure that the selected entry's text will be shown in the menubutton (for example, with the aid of the menu entry's `-command` option).

**KEYWORDS**
: tablelist, editing, menubutton


[Contents](#contents)     [Start page](index.md)
