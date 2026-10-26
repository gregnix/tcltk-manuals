# Commands Related to Tile Themes

## For Mentry Version 4.5

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [Overview](#overview)
- [The mentry::setTheme Command](#the-mentry-settheme-command)
- [The mentry::getCurrentTheme Command](#the-mentry-getcurrenttheme-command)
- [The mentry::getThemes Command](#the-mentry-getthemes-command)
- [The mentry::setThemeDefaults Command](#the-mentry-setthemedefaults-command)

[Start page](index.md)

---

## Overview

The commands described in this reference page should only be invoked when using the package Mentry_tile.  They enable you to set and query the current theme, to retrieve a list of the available themes, and to make sure that your widgets will have a theme-specific appearance.

[Contents](#contents)     [Start page](index.md)

---

## The `mentry::setTheme` Command

**NAME**
: `mentry::setTheme` – Set the current theme

**SYNOPSIS**
: 

```
mentry::setTheme theme
```

**DESCRIPTION**
: This command sets the current theme to `theme`, loading it if necessary.  It is simply an alias for `ttk::setTheme` or `tile::setTheme`, depending on the tile version loaded into the interpreter.  (The `tile::setTheme` command was renamed to `ttk::setTheme` in tile version 0.8.)

: Being just an alias for a tile library procedure, the `mentry::setTheme` command does exactly the same as the original one: It loads the package implementing the given theme if needed, sets the theme to the specified one, and saves the latter in the variable `ttk::currentTheme` or `tile::currentTheme`, depending on the current tile version.

**KEYWORDS**
: mentry, theme, tile


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::getCurrentTheme` Command

**NAME**
: `mentry::getCurrentTheme` – Get the current theme

**SYNOPSIS**
: 

```
mentry::getCurrentTheme
```

**DESCRIPTION**
: This command returns the name of the current theme by invoking the  `ttk::style theme use`  command.  If an old tile version is being used which doesn't yet support this method then the command returns the value of the variable `ttk::currentTheme` or `tile::currentTheme`, depending on the tile version.  (The namespace containing the variable `currentTheme` was changed in tile version 0.8 from `tile` to `ttk`.)

**KEYWORDS**
: mentry, theme, tile


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::getThemes` Command

**NAME**
: `mentry::getThemes` – Get the themes registered in the package database

**SYNOPSIS**
: 

```
mentry::getThemes
```

**DESCRIPTION**
: This command returns a list of the themes registered in the package database.  It is simply an alias for `ttk::themes` or `tile::availableThemes`, depending on the tile version loaded into the interpreter.  (The `tile::availableThemes` command was renamed to `ttk::themes` in tile version 0.8.)

**KEYWORDS**
: mentry, theme, tile


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::setThemeDefaults` Command

**NAME**
: `mentry::setThemeDefaults` – Set theme-specific default values of some mentry configuration options

**SYNOPSIS**
: 

```
mentry::setThemeDefaults
```

**DESCRIPTION**
: This command populates the array `mentry::themeDefaults` with theme-specific default values of a series of Mentry configuration options.  The array names are the command-line names of the options, and the corresponding array values are the default values of these configuration options for the currently set tile theme.

: The options whose names and values are written into the array `mentry::themeDefaults` are: `-background`, `-foreground`, and `-font`.  In addition, the command sets some other array elements to theme-specific default values, needed for internal purposes, like updating the background and foreground colors of the label components of a mentry widget in `disabled` or `readonly` state; the corresponding array names are: `-disabledbackground`, `-disabledforeground`, and `-readonlybackground`.  Finally, the array values associated with the names `-selectbackground`, `-selectforeground`, and `-selectborderwidth` are not used by Mentry_tile, but might prove useful for other purposes, as described below.

: The `mentry::setThemeDefaults` command is invoked by Mentry_tile automatically at application start time and when the `<<ThemeChanged>>` virtual event is sent to the main window.  It is also invoked on macOS 10.14 (Mojave) and later whenever the main window receives a `<<LightAppearance>>` (formerly: `<<LightAqua>>`) or `<<DarkAppearance>>` (formerly: `<<DarkAqua>>`) virtual event, if the current theme is `aqua`.  In these cases, after invoking the `mentry::setThemeDefaults` command, Mentry_tile sends the virtual event `<<MentryThemeDefaultsChanged>>` to the main window and reconfigures all mentry widgets of the application, using the new default values of those options that were not set explicitly to values different from the corresponding defaults.

: On macOS 10.14 (Mojave) and later, the virtual events `<<LightAppearance>>` and `<<DarkAppearance>>` (or `<<LightAqua>>` and `<<DarkAqua>>`) are sent by Tk 8.6.10 and later to all toplevel widgets whenever the system appearance toggles between Light Mode and Dark Mode or the Accent Color in the General Preferences changes.  Tk versions 8.6.11 and later send these events on macOS 10.15 (Catalina) and later also when changing the Highlight Color in the General Preferences.

: Besides being used by Mentry_tile, this command can also be invoked in application code, although with current Mentry_tile versions there is no need for calling it explicitly.

: By using the default values contained in the array `mentry::themeDefaults`, you can make sure that classical Tk widgets, e.g., text, will have a theme-specific appearance, just like the tile widgets.  For example, you can add some common configuration options to the option database as follows:


```
if {[tk windowingsystem] eq "x11"} {
    option add *Text.background   $mentry::themeDefaults(-background)
    option add *Text.foreground   $mentry::themeDefaults(-foreground)
    option add *selectBackground  $mentry::themeDefaults(-selectbackground)
    option add *selectForeground  $mentry::themeDefaults(-selectforeground)
}
option add *selectBorderWidth     $mentry::themeDefaults(-selectborderwidth)
option add *Font                  $mentry::themeDefaults(-font)
```

: You can also make use of the virtual event `<<MentryThemeDefaultsChanged>>` to update the appearance of your Tk widgets according to the new values contained in the array `mentry::themeDefaults`, by binding to the dedicated binding tag `MentryMain` associated with the main window:


```
bind MentryMain <<MentryThemeDefaultsChanged>> ...
```

: The binding tag `MentryMain` is assigned by Mentry_tile to the main window and used internally for handling the virtual events `<<ThemeChanged>>`, `<<LightAppearance>>` (or `<<LightAqua>>`), and `<<DarkAppearance>>` (or `<<DarkAqua>>`).  As shown above, applications can make use of it, e.g., to handle the virtual event `<<MentryThemeDefaultsChanged>>`.

**KEYWORDS**
: mentry, theme, tile


[Contents](#contents)     [Start page](index.md)
