---
CommandName: itkvars
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr\\ Tk]"
Keywords:
 - itcl
 - itk
 - variables
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---


# Name

itkvars - variables used by \[incr\\ Tk\]

# Description

The following global variables are created and managed automatically by the **\[incr**\\ **Tk\]** library.  Except where noted below, these variables should normally be treated as read-only by application-specific code and by users.

**itk::library**
: When an interpreter is created, **\[incr**\\ **Tk\]** initializes this variable to hold the name of a directory containing the system library of **\[incr**\\ **Tk\]** scripts.  The initial value of **itk::library** is set from the ITK_LIBRARY environment variable if it exists, or from a compiled-in value otherwise. When **\[incr**\\ **Tk\]** is added to an interpreter, it executes the script "\\ffCinit.itk" in this directory.  This script, in turn, looks for other script files with the name "\\ffCinit.*xxx*". Mega-widget libraries will be automatically initialized if they install a script named "\\ffCinit.*xxx*" in this directory, where "*xxx*" is the name of the mega-widget library. For example, the **\[incr**\\ **Widgets\]** library installs the script "\\ffCinit.iwidgets" in this directory. This script establishes the "iwidgets" namespace, and sets up autoloading for all **\[incr**\\ **Widgets\]** commands.
