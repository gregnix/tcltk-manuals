# Commands Related to Tile Themes

## For Tablelist Version 7.12

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The tablelist::setTheme Command](#the-tablelist-settheme-command)
- [The tablelist::getCurrentTheme Command](#the-tablelist-getcurrenttheme-command)
- [The tablelist::getThemes Command](#the-tablelist-getthemes-command)
- [The tablelist::setThemeDefaults Command](#the-tablelist-setthemedefaults-command)

[Start page](index.md)

---

## Overview

The commands described in this reference page should only be invoked when using the package Tablelist_tile.  They enable you to set and query the current theme, to retrieve a list of the available themes, and to make sure that your widgets will have a theme-specific appearance.

[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::setTheme` Command

**NAME**
: `tablelist::setTheme` – Set the current theme

**SYNOPSIS**
: 

```
tablelist::setTheme theme
```

**DESCRIPTION**
: This command sets the current theme to `theme`, loading it if necessary.  It is simply an alias for `ttk::setTheme` or `tile::setTheme`, depending on the tile version loaded into the interpreter.  (The `tile::setTheme` command was renamed to `ttk::setTheme` in tile version 0.8.)

: Being just an alias for a tile library procedure, the `tablelist::setTheme` command does exactly the same as the original one: It loads the package implementing the given theme if needed, sets the theme to the specified one, and saves the latter in the variable `ttk::currentTheme` or `tile::currentTheme`, depending on the current tile version.

**KEYWORDS**
: tablelist, theme, tile


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::getCurrentTheme` Command

**NAME**
: `tablelist::getCurrentTheme` – Get the current theme

**SYNOPSIS**
: 

```
tablelist::getCurrentTheme
```

**DESCRIPTION**
: This command returns the name of the current theme by invoking the  `ttk::style theme use`  command.  If an old tile version is being used which doesn't yet support this method then the command returns the value of the variable `ttk::currentTheme` or `tile::currentTheme`, depending on the tile version.  (The namespace containing the variable `currentTheme` was changed in tile version 0.8 from `tile` to `ttk`.)

**KEYWORDS**
: tablelist, theme, tile


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::getThemes` Command

**NAME**
: `tablelist::getThemes` – Get the themes registered in the package database

**SYNOPSIS**
: 

```
tablelist::getThemes
```

**DESCRIPTION**
: This command returns a list of the themes registered in the package database.  It is simply an alias for `ttk::themes` or `tile::availableThemes`, depending on the tile version loaded into the interpreter.  (The `tile::availableThemes` command was renamed to `ttk::themes` in tile version 0.8.)

**KEYWORDS**
: tablelist, theme, tile


[Contents](#contents)     [Start page](index.md)

---

## The `tablelist::setThemeDefaults` Command

**NAME**
: `tablelist::setThemeDefaults` – Set theme-specific default values of some tablelist configuration options

**SYNOPSIS**
: 

```
tablelist::setThemeDefaults
```

**DESCRIPTION**
: This command populates the array `tablelist::themeDefaults` with theme-specific default values of a series of Tablelist configuration options.  The array names are the command-line names of the options, and the corresponding array values are the default values of these configuration options for the currently set tile theme.

: The options whose names and values are written into the array `tablelist::themeDefaults` are: `-arrowcolor`, `-arrowdisabledcolor`, `-arrowstyle`, `-background`, `-disabledforeground`, `-font`, `-foreground`, `-labelborderwidth`, `-labelfont`, `-labelforeground`, `-labelpady`, `-selectbackground`, `-selectborderwidth`, `-selectforeground`, `-stripebackground`, and `-treestyle`.  In addition, the command sets some other array elements to theme-specific default values of the background and foreground colors of the column labels in `normal`, `disabled`, `active`, and `pressed` states.  (Tablelist needs the label colors for handling sort arrows and images with transparent background in the column labels.)

: The `tablelist::setThemeDefaults` command is invoked by Tablelist_tile automatically at application start time and when the `<<ThemeChanged>>` virtual event is sent to the main window.  It is also invoked on macOS 10.14 (Mojave) and later whenever the main window receives a `<<LightAppearance>>` (formerly: `<<LightAqua>>`) or `<<DarkAppearance>>` (formerly: `<<DarkAqua>>`) virtual event, if the current theme is `aqua`.  In these cases, after invoking the `tablelist::setThemeDefaults` command, Tablelist_tile sends the virtual event `<<TablelistThemeDefaultsChanged>>` to the main window and reconfigures all tablelist widgets of the application, using the new default values of those options that were not set explicitly to values different from the corresponding defaults.

: On macOS 10.14 (Mojave) and later, the virtual events `<<LightAppearance>>` and `<<DarkAppearance>>` (or `<<LightAqua>>` and `<<DarkAqua>>`) are sent by Tk 8.6.10 and later to all toplevel widgets whenever the system appearance toggles between Light Mode and Dark Mode or the Accent Color in the General Preferences changes.  Tk versions 8.6.11 and later send these events on macOS 10.15 (Catalina) and later also when changing the Highlight Color in the General Preferences.

: Besides being used by Tablelist_tile, this command can also be invoked in application code, although with current Tablelist_tile versions there is no need for calling it explicitly.

: By using the default option values contained in the array `tablelist::themeDefaults`, you can make sure that classical Tk widgets, e.g., listbox and text, will have a theme-specific appearance, just like the tile widgets.  For example, you can add some common configuration options to the option database as follows:


```
if {[tk windowingsystem] eq "x11"} {
    option add *selectBackground  $tablelist::themeDefaults(-selectbackground)
    option add *selectForeground  $tablelist::themeDefaults(-selectforeground)
}
option add *selectBorderWidth     $tablelist::themeDefaults(-selectborderwidth)
```

: You can also make use of the virtual event `<<TablelistThemeDefaultsChanged>>` to update the appearance of your Tk widgets according to the new values contained in the array `tablelist::themeDefaults`, by binding to the dedicated binding tag `TablelistMain` associated with the main window:


```
bind TablelistMain <<TablelistThemeDefaultsChanged>> ...
```

: The binding tag `TablelistMain` is assigned by Tablelist_tile to the main window and used internally for handling the virtual events `<<ThemeChanged>>`, `<<LightAppearance>>` (or `<<LightAqua>>`), and `<<DarkAppearance>>` (or `<<DarkAqua>>`).  As shown above, applications can make use of it, e.g., to handle the virtual event `<<TablelistThemeDefaultsChanged>>`.

**KEYWORDS**
: tablelist, theme, tile


[Contents](#contents)     [Start page](index.md)
