# Interactive Tablelist Cell Editing Using Tile Widgets

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [Interactive Cell Editing Using the ttk::entry Widget](#interactive-cell-editing-using-the-ttk-entry-widget)
- [Interactive Cell Editing Using the ttk::spinbox Widget](#interactive-cell-editing-using-the-ttk-spinbox-widget)
- [Interactive Cell Editing Using the ttk::combobox Widget](#interactive-cell-editing-using-the-ttk-combobox-widget)
- [Interactive Cell Editing Using the ttk::checkbutton Widget](#interactive-cell-editing-using-the-ttk-checkbutton-widget)
- [Interactive Cell Editing Using the ttk::menubutton Widget](#interactive-cell-editing-using-the-ttk-menubutton-widget)
- [Interactive Cell Editing Using the ttk::toggleswitch Widget](#interactive-cell-editing-using-the-ttk-toggleswitch-widget)

[Start page](index.md)

---

## Overview

The tile theme engine is a compiled library extension for Tcl/Tk versions 8.4 or higher.  Beginning with Tk 8.5a6, tile is integrated into the Tk core.  For earlier Tk versions it can be downloaded from the address

https://sourceforge.net/projects/tktable//files/tile

Tablelist supports interactive cell editing with the aid of the ttk::entry, ttk::spinbox, ttk::combobox, ttk::checkbutton, ttk::menubutton, and ttk::toggleswitch widgets, accessed as `ttk::entry`, `ttk::spinbox`, `ttk::combobox`, `ttk::checkbutton`, `ttk::menubutton`, and `ttk::toggleswitch`, respectively.  The fully-qualified names `::ttk::entry`, `::ttk::spinbox`, `::ttk::combobox`, `::ttk::checkbutton`, `::ttk::menubutton`, and `::ttk::toggleswitch` are also supported.  The version of the tile package must be 0.6 or higher (the ttk::spinbox widget requires even tile 0.8.3 or later, or, alternatively, Tk 8.5.9 or later).  The ttk::toggleswitch widget was introduced in Tk 9.1a1.  These widgets are automatically registered for cell editing, hence the only action needed for using one of them for editing the cells of a given column is as follows:

Use the tablelist widget's `columnconfigure` subcommand to set the given column's `-editable` option to true and its `-editwindow` option to `ttk::entry`, `ttk::spinbox`, `ttk::combobox`, `ttk::checkbutton`, `ttk::menubutton`, or `ttk::toggleswitch` (or to the corresponding fully-qualified name), respectively.  (These options are supported at cell level, too, with the aid of the `cellconfigure` subcommand.)

**REMARK 1:**  When using one of the built-in themes, the temporary embedded tile widget used for interactive cell editing will appear properly scaled, according to the display's DPI scaling level and Tk's scaling factor given by  `[tk scaling]`.  The only exception is the tile checkbutton widget, which will be scaled as expected for the themes `aqua`, `clam`, `classic`, `default`, `vista`, and `xpnative`, but, for technical reasons, cannot be scaled if the theme is `alt` or `winnative` and the Tk version is earlier than 9.

**REMARK 2:**  One known limitation of earlier tile versions was that the  `(ttk::)style theme use`  command could only be used to set the current theme, but not to retrieve it.  For this reason, if Tablelist cannot get the current theme with the aid of  `ttk::style theme use`  then it makes use of the variable `ttk::currentTheme` or `tile::currentTheme` (depending on the tile version), which is set by the `ttk::setTheme` or `tile::setTheme` command.  From this it follows that if the tile version being used doesn't support the  `ttk::style theme use`  command without an argument then the tile widgets used for interactive cell editing will only be managed as expected if the platform-specific default theme is either left unchanged or replaced with another theme by invoking the library procedure `ttk::setTheme` or `tile::setTheme`, depending on the current tile version.  (See also the `tablelist::setTheme` command.)

[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the ttk::entry Widget

**DESCRIPTION**
: The temporary embedded ttk::entry widget used for interactive cell editing will be created with an explicitly set value for its `-style` option.  Apart from its theme-specific appearance, it behaves just like its Tk core counterpart.

: If an application uses the ttk::entry widget for interactive cell editing and also the Wcb package (even if not for that widget), then the version of Wcb must be 3.1 or higher (because earlier Wcb releases didn't support any tile widgets).

**KEYWORDS**
: tablelist, editing, ttk::entry


[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the ttk::spinbox Widget

**DESCRIPTION**
: The temporary embedded ttk::spinbox widget used for interactive cell editing will be created with an explicitly set value for its `-style` option and with its `-state` option set to `normal`, which makes the widget editable.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to set the state of the spinbox to `readonly` or define validations for it, as well as for setting its (range of) values and its `-wrap` option.  Apart from its theme-specific appearance, it behaves just like its Tk core counterpart.

: If an application uses the ttk::spinbox widget for interactive cell editing and also the Wcb package (even if not for that widget), then the version of Wcb must be 3.2 or higher (because the support for the new tile spinbox widget was added to Wcb in its version 3.2).

**KEYWORDS**
: tablelist, editing, ttk::spinbox


[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the ttk::combobox Widget

**DESCRIPTION**
: The temporary embedded ttk::combobox widget used for interactive cell editing will be created with an explicitly set value for its `-style` option and with its `-state` option set to `normal`, which makes the widget editable.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to set the state of the combobox to `readonly` or define validations for it, as well as for populating its listbox component (with the aid of the combobox widget's `-values` option).

: If an application uses the ttk::combobox widget for interactive cell editing and also the Wcb package (even if not for that widget), then the version of Wcb must be 3.1 or higher (because earlier Wcb releases didn't support any tile widgets).

**KEYWORDS**
: tablelist, editing, ttk::combobox


[Contents](#contents)     [Start page](index.md)

---

## Interactive Cell Editing Using the ttk::checkbutton Widget.

**DESCRIPTION**
: The temporary embedded ttk::checkbutton widget used for interactive cell editing will be created with explicitly set values for its `-style` and `-variable` options.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to set any other configuration options, like `-offvalue` and `-onvalue`, according to the *internal* values of the cells.  Since the default values of the `-offvalue` and `-onvalue` ttk::checkbutton options are `0` and `1`, you don't need to change these options if the cells have the same internal values `0` and `1`.

**KEYWORDS**
: tablelist, editing, ttk::checkbutton


---

## Interactive Cell Editing Using the ttk::menubutton Widget.

**DESCRIPTION**
: The temporary embedded ttk::menubutton widget used for interactive cell editing will be created with explicitly set values for its `-style` and `-textvariable` options.  In addition, a menu with its `-tearoff` option set to `0` and an appropriate script as the value of its `-postcommand` option is created and set as the value of the menubutton's `-menu` option.  In an X11 environment, the menu's appearance is adapted to that of the tablelist widget by setting its `-background`, `-foreground`, `-activebackground`, `-activeforeground`, and `-activeborderwidth` options to appropriate values.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to set any other options of the menubutton and/or its associated menu.  You will, however, need this script in the first place for populating the menu, preferably with radiobutton entries.  For every radiobutton entry added to the menu, the Tablelist implementation will make sure that its value (which can be specified by setting the entry's `-value` or `-label` option) will be displayed in the menubutton as its text when the entry is selected.  (Tablelist achieves this by setting the menu entry's `-variable` option to the value of the menubutton's `-textvariable` option.)  For menu entries of types other than radiobutton (e.g., for command entries) it is the responsibility of the application to make sure that the selected entry's text will be shown in the menubutton (for example, with the aid of the menu entry's `-command` option).

**KEYWORDS**
: tablelist, editing, ttk::menubutton


---

## Interactive Cell Editing Using the ttk::toggleswitch Widget.

**DESCRIPTION**
: The temporary embedded ttk::toggleswitch widget used for interactive cell editing will be created with its `-size` option set to `1`.  You can use the script corresponding to the `-editstartcommand` tablelist configuration option to override the initial settings according to your needs.

**KEYWORDS**
: tablelist, editing, ttk::toggleswitch


---

[Contents](#contents)     [Start page](index.md)
