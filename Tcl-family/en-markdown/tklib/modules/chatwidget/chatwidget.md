---
CommandName: chatwidget
ManualSection: n
Version: 1.1.4
TclPart: tklib
TclDescription: Composite widget for chat applications
Links:
 - text(n)
Keywords:
 - chat
 - chatwidget
 - composite widget
 - irc
 - mega-widget
 - widget
Copyright:
---

# Name

chatwidget - Provides a multi-paned view suitable for display of chat room or irc channel information

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [chatwidget]{.lit} [1.1.4]{.optlit} 
[::chatwidget::chatwidget]{.cmd} [path]{.arg} [options]{.optarg} 
[\$widget]{.cmd} topic [command]{.arg} [args]{.arg} 
[\$widget]{.cmd} name [nick]{.arg} [args]{.arg} 
[\$widget]{.cmd} message [text]{.arg} [args]{.arg} 
[\$widget]{.cmd} hook [command]{.arg} [args]{.arg} 
[\$widget]{.cmd} names [args]{.arg} 
[\$widget]{.cmd} entry [args]{.arg} 
[\$widget]{.cmd} chat [args]{.arg} 
:::

# Description

This is a composite widget designed to simplify the construction of chat applications. The widget contains display areas for chat messages, user names and topic and an entry area. It automatically handles colourization of messages per nick and manages nick completion. A system of hooks permit the application author to adjust display features. The main chat display area may be split for use displaying history or for searching.

The widget is made up of a number of text widget and panedwindow widgets so that the size of each part of the display may be adjusted by the user. All the text widgets may be accessed via widget passthrough commands if fine adjustment is required. The topic and names sections can also be hidden if desired.

# Commands

**::chatwidget::chatwidget** *path* ?*options*?
: Create a new chatwidget using the Tk window id *path*. Any options provided are currently passed directly to the main chat text widget.


# Widget commands

**\$widget** topic *command* *args*
: The chat widget can display a topic string, for instance the topic or name given to a multi-user chatroom or irc channel.


**show**
: Enable display of the topic.

**hide**
: Disable display of the topic

**set** *topic*
: Set the topic text to *topic*.


**\$widget** name *nick* *args*
: Control the names and tags associated with names.


**list ?**_-full_?
: Returns a list of all the user names from the names view. If ?-full? is given then the list returned is a list of lists where each sublist is made up of the nick followed by any options that have been set on this nick entry. This may be used to examine any application specific options that may be applied to a nick when using the **add** command.

**add** *nick* ?*options*?
: ...see next...

**delete** *nick*
: 


**\$widget** message *text* *args*
: Add messages to the display. options are -nick, -time, -type, -mark -tags

**\$widget** hook *command* *args*
: Manage hooks. add (message, post names_group, names_nick, chatstate), remove, run

**\$widget** names *args*
: Passthrough to the name display text widget. See the **text** widget manual for all available commands. The chatwidget provides two additional commands **show** and **hide** which are used to control the display of this element in the widget.

**\$widget** entry *args*
: Passthrough to the entry text widget. See the **text** widget manual for all available commands.

**\$widget** chat *args*
: Passthrough to the chat text widget. See the **text** widget manual for all available commands.


# Example

```
chatwidget::chatwidget .chat
proc speak {w msg} {$w message $msg -nick user}
.chat hook add post [list speak .chat]
pack .chat -side top -fill both -expand 1
.chat topic show
.chat topic set "Chat widget demo"
.chat name add "admin" -group admin
.chat name add "user" -group users -color tomato
.chat message "Chatwidget ready" -type system
.chat message "Hello, user" -nick admin
.chat message "Hello, admin" -nick user
```

A more extensive example is available by examining the code for the picoirc program in the tclapps repository which ties the tcllib **picoirc** package to this **chatwidget** package to create a simple irc client.

# Bugs, ideas, feedback

This document, and the package it describes, will undoubtedly contain bugs and other problems. Please report such in the category *chatwidget* of the [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Please also report any ideas for enhancements you may have for either package and/or documentation.
