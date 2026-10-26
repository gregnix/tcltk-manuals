---
CommandName: canvas::tag
title: canvas::tag
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - append tag
 - canvas
 - insert tag
 - remove tag
 - tags
Copyright:
---

# Name

canvas::tag - Easier management of the tags on canvas items or item groups

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::tag]{.lit} [0.1]{.optlit}
[::canvas::tag]{.cmd} [append]{.lit} [canvas]{.arg} [tagOrId]{.arg} [tag...]{.arg}
[::canvas::tag]{.cmd} [prepend]{.lit} [canvas]{.arg} [tagOrId]{.arg} [tag...]{.arg}
[::canvas::tag]{.cmd} [append]{.lit} [canvas]{.arg} [tagOrId]{.arg} [index]{.arg} [tag...]{.arg}
[::canvas::tag]{.cmd} [remove]{.lit} [canvas]{.arg} [tagOrId]{.arg} [tag...]{.arg}
[::canvas::tag]{.cmd} [match]{.lit} [canvas]{.arg} [tagOrId]{.arg} [pattern]{.arg}
:::

# Description

This package provides utility commands for easier management of the tag lists associated with canvas items or item groups.

The problem with the existing canvas API is that a tag list can only be set as a whole, making adding and removing of tags from such lists relatively complex operations reading the current tag list, modifying it, and then writing the changed list back.

The commands provided by this package hide all this complexity from the user.

# API

**::canvas::tag** **append** *canvas* *tagOrId* *tag*...
: This command adds the tags *tag*... to the tag list for the items identified by the *tagOrId* in the *canvas* widget. The new tags are added at the end of the list.

    The result of the command is the empty string.

**::canvas::tag** **prepend** *canvas* *tagOrId* *tag*...
: This command adds the tags *tag*... to the tag list for the items identified by the *tagOrId* in the *canvas* widget. The new tags are added at the beginning of the list.

    The result of the command is the empty string.

**::canvas::tag** **append** *canvas* *tagOrId* *index* *tag*...
: This command adds the tags *tag*... to the tag list for the items identified by the *tagOrId* in the *canvas* widget. The new tags are inserted before the element at *index*.

    *index* **0** refers to the beginning of the list.

    *index* **end** refers to after the end of the list.

    The result of the command is the empty string.

**::canvas::tag** **remove** *canvas* *tagOrId* *tag*...
: This command removes the named tags *tag*... from the tag list for the items identified by the *tagOrId* in the *canvas* widget.

    The result of the command is the empty string.

**::canvas::tag** **match** *canvas* *tagOrId* *pattern*
: This command finds all tags for the items identified by the *tagOrId* in the *canvas* widget which match the glob *pattern*.

    The result of the command is a list of the matching tags. Which may be empty.


# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *canvas* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
