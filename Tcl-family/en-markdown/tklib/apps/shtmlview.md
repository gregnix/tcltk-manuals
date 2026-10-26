---
CommandName: shtmlview
title: shtmlview
ManualSection: n
Version: 1.1.0
TclPart: tklib
TclDescription: Basic HTML and Markdown viewer
Keywords:
 - doctools
 - html
 - markdown
 - mkdoc
 - viewer
Copyright:
 - Copyright (c)
---

# Name

shtmlview - Basic HTML and Markdown viewer application

# Synopsis

::: {.synopsis} :::
[shtmlview]{.cmd}
[shtmlview]{.cmd} [--help]{.lit}
[shtmlview]{.cmd} [--version]{.lit}
[shtmlview]{.cmd} [--render]{.lit} [text]{.arg}
[shtmlview]{.cmd} [--render]{.lit} [-]{.lit}
[shtmlview]{.cmd} [filename]{.arg}
:::

# Description

The application described by this document, **shtmlview**, is a simple viewer for HTML files. Further supported are documents written in *Markdown*, *doctools*, or *mkdoc* format, if various supporting packages are available. See section [Beyond HTML].

## Command line

**shtmlview**
: see below ...

**shtmlview** **--help**
: Prints usage information to standard error.

**shtmlview** **--version**
: Prints the application version to standard output.

**shtmlview** **--render** *text*
: Displays the provided text in a viewer window. Treats the text as Markdown except if it starts with a recognized HTML tag. In that case it assumes and renders as HTML.

**shtmlview** **--render** **-**
: As before, except it reads the text to render from standard input.

**shtmlview** *filename*
: Reads and renders the named file in a viewer widget.


# Beyond HTML

Documents in any other format than HTML require the presence of various supporting packages to enable the application to display them.

Markdown
: - **Markdown**


doctools
: - **shtmlview::doctools**

    - **dtplite**


mkdoc
: - **shtmlview::mkdoc**

    - **mkdoc::mkdoc**



# Bugs, ideas, feedback

This document, and the application it describes, will undoubtedly contain bugs and other problems. Please report such in the category *shtmlview* of the [Tklib Trackers](https://core.tcl-lang.org/tklib/ticket). Please also report any ideas for enhancements you may have for either application and/or documentation.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *shtmlview* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.

# Category

Document display

# Copyright

```
Copyright (c)
```
