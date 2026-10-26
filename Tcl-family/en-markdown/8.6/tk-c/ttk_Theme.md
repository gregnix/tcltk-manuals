---
CommandName: Ttk_CreateTheme
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

Ttk_CreateTheme, Ttk_GetTheme, Ttk_GetDefaultTheme, Ttk_GetCurrentTheme - create and use Tk themes.

# Synopsis

```
Ttk_Theme Ttk_CreateTheme(interp, name, parentTheme);
Ttk_Theme Ttk_GetTheme(interp, name);
Ttk_Theme Ttk_GetDefaultTheme(interp);
Ttk_Theme Ttk_GetCurrentTheme(interp);
```

# Arguments

Tcl_Interp \* *interp* (in)
: The Tcl interpreter in which to register/query available themes.

Ttk_Theme *parentTheme* (in)
: Fallback or parent theme from which the new theme will inherit elements and layouts.

const char \* *name* (in)
: The name of the theme.


# Description
