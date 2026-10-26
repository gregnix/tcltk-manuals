---
CommandName: Ttk_CreateTheme
title: Ttk_CreateTheme
ManualSection: 3
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - Ttk_RegisterLayout
 - Ttk_BuildLayout
Copyright:
 - Copyright (c) 2003 Joe English
---

# Name

Ttk\_CreateTheme, Ttk\_GetTheme, Ttk\_GetDefaultTheme, Ttk\_GetCurrentTheme - create and use Tk themes.

# Synopsis

Ttk\_Theme Ttk\_CreateTheme(*interp*, *name*, *parentTheme*); Ttk\_Theme Ttk\_GetTheme(*interp*, *name*); Ttk\_Theme Ttk\_GetDefaultTheme(*interp*); Ttk\_Theme Ttk\_GetCurrentTheme(*interp*);

# Arguments

::: {.arguments} :::

[interp]{.carg .in type="Tcl_Interp *"}
: The Tcl interpreter in which to register/query available themes.

[parentTheme]{.carg .in type="Ttk_Theme"}
: Fallback or parent theme from which the new theme will inherit elements and layouts.

[name]{.carg .in type="const char *"}
: The name of the theme.

:::

# Description
