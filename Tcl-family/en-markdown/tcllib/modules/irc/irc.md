---
CommandName: irc
ManualSection: n
Version: 0.8.0
TclPart: tcllib
TclDescription: Low Level Tcl IRC Interface
Links:
 - rfc 1459
Keywords:
 - chat
 - irc
Copyright:
---

# Name

irc - Create IRC connection and interface.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [irc]{.lit} [0.8.0]{.optlit} 
[::irc::config]{.cmd} [key]{.optarg} [value]{.optarg} 
[::irc::connection]{.cmd} 
[::irc::connections]{.cmd} 
[net]{.ins} [registerevent]{.sub} [event]{.arg} [script]{.arg} 
[net]{.ins} [getevent]{.sub} [event]{.arg} [script]{.arg} 
[net]{.ins} [eventexists]{.sub} [event]{.arg} [script]{.arg} 
[net]{.ins} [connect]{.sub} [hostname]{.arg} [port]{.optarg} 
[net]{.ins} [config]{.sub} [key]{.optarg} [value]{.optarg} 
[net]{.ins} [log]{.sub} [level]{.arg} [message]{.arg} 
[net]{.ins} [logname]{.sub} 
[net]{.ins} [connected]{.sub} 
[net]{.ins} [sockname]{.sub} 
[net]{.ins} [peername]{.sub} 
[net]{.ins} [socket]{.sub} 
[net]{.ins} [user]{.sub} [username]{.arg} [localhostname]{.arg} [localdomainname]{.arg} [userinfo]{.arg} 
[net]{.ins} [nick]{.sub} [nick]{.arg} 
[net]{.ins} [ping]{.sub} [target]{.arg} 
[net]{.ins} [serverping]{.sub} 
[net]{.ins} [join]{.sub} [channel]{.arg} [key]{.optarg} 
[net]{.ins} [part]{.sub} [channel]{.arg} [message]{.optarg} 
[net]{.ins} [quit]{.sub} [message]{.optarg} 
[net]{.ins} [privmsg]{.sub} [target]{.arg} [message]{.arg} 
[net]{.ins} [notice]{.sub} [target]{.arg} [message]{.arg} 
[net]{.ins} [ctcp]{.sub} [target]{.arg} [message]{.arg} 
[net]{.ins} [kick]{.sub} [channel]{.arg} [target]{.arg} [message]{.optarg} 
[net]{.ins} [mode]{.sub} [target]{.arg} [args]{.arg} 
[net]{.ins} [topic]{.sub} [channel]{.arg} [message]{.arg} 
[net]{.ins} [invite]{.sub} [channel]{.arg} [target]{.arg} 
[net]{.ins} [send]{.sub} [text]{.arg} 
[net]{.ins} [destroy]{.sub} 
[who]{.cmd} [address]{.optlit} 
[action]{.cmd} 
[target]{.cmd} 
[additional]{.cmd} 
[header]{.cmd} 
[msg]{.cmd} 
:::

# Description

This package provides low-level commands to deal with the IRC protocol (Internet Relay Chat) for immediate and interactive multi-cast communication.

**::irc::config** ?key? ?value?
: Sets configuration ?key? to ?value?. The configuration keys currently defined are the boolean flags **logger** and **debug**. **logger** makes **irc** use the logger package for printing error. **debug** requires **logger** and prints extra debug output. If no ?key? or ?value? is given the current values are returned.

**::irc::connection**
: The command creates a new object to deal with an IRC connection. Creating this IRC object does not automatically create the network connection.  It returns a new irc namespace command which can be used to interact with the new IRC connection.  NOTE: the old form of the connection command, which took a hostname and port as arguments, is deprecated.  Use **connect** instead to specify this information.

**::irc::connections**
: Returns a list of all the current connections that were created with **connection**


# Per-connection commands

In the following list of available connection methods *net* represents a connection command as returned by **::irc::connection**.

*net* **registerevent** *event* *script*
: Registers a callback handler for the specific event.  Events available are those described in RFC 1459 *http://www.rfc-editor.org/rfc/rfc1459.txt*. In addition, there are several other events defined. **defaultcmd** adds a command that is called if no other callback is present.  **EOF** is called if the connection signals an End of File condition. The events **defaultcmd**, **defaultnumeric**, **defaultevent**, and **EOF** are required. *script* is executed in the connection namespace, which can take advantage of several commands (see **Callback Commands** below) to aid in the parsing of data.

*net* **getevent** *event* *script*
: Returns the current handler for the event if one exists. Otherwise an empty string is returned.

*net* **eventexists** *event* *script*
: Returns a boolean value indicating the existence of the event handler.

*net* **connect** *hostname* ?port?
: This causes the socket to be established.  **::irc::connection** created the namespace and the commands to be used, but did not actually open the socket. This is done here.  NOTE: the older form of \\'connect' did not require the user to specify a hostname and port, which were specified with 'connection'.  That form is deprecated.

*net* **config** ?key? ?value?
: The same as **::irc::config** but sets and gets options for the *net* connection only.

*net* **log** *level* *message*
: If logger is turned on by **config** this will write a log *message* at *level*.

*net* **logname**
: Returns the name of the logger instance if logger is turned on.

*net* **connected**
: Returns a boolean value indicating if this connection is connected to a server.

*net* **sockname**
: Returns a 3 element list consisting of the ip address, the hostname, and the port of the local end of the connection, if currently connected.

*net* **peername**
: Returns a 3 element list consisting of the ip address, the hostname, and the port of the remote end of the connection, if currently connected.

*net* **socket**
: Return the Tcl channel for the socket used by the connection.

*net* **user** *username* *localhostname* *localdomainname* *userinfo*
: Sends USER command to server.  *username* is the username you want to appear.  *localhostname* is the host portion of your hostname, *localdomainname* is your domain name, and *userinfo* is a short description of who you are. The 2nd and 3rd arguments are normally ignored by the IRC server.

*net* **nick** *nick*
: NICK command.  *nick* is the nickname you wish to use for the particular connection.

*net* **ping** *target*
: Send a CTCP PING to *target*.

*net* **serverping**
: PING the server.

*net* **join** *channel* ?*key*?
: *channel* is the IRC channel to join.  IRC channels typically begin with a hashmark ("#") or ampersand ("&").

*net* **part** *channel* ?*message*?
: Makes the client leave *channel*. Some networks may support the optional argument *message*

*net* **quit** ?*message*?
: Instructs the IRC server to close the current connection. The package will use a generic default if no *message* was specified.

*net* **privmsg** *target* *message*
: Sends *message* to *target*, which can be either a channel, or another user, in which case their nick is used.

*net* **notice** *target* *message*
: Sends a **notice** with message *message* to *target*, which can be either a channel, or another user, in which case their nick is used.

*net* **ctcp** *target* *message*
: Sends a CTCP of type *message* to *target*

*net* **kick** *channel* *target* ?*message*?
: Kicks the user *target* from the channel *channel* with a *message*. The latter can be left out.

*net* **mode** *target* *args*
: Sets the mode *args* on the target *target*. *target* may be a channel, a channel user, or yourself.

*net* **topic** *channel* *message*
: Sets the topic on *channel* to *message* specifying an empty string will remove the topic.

*net* **invite** *channel* *target*
: Invites *target* to join the channel *channel*

*net* **send** *text*
: Sends *text* to the IRC server.

*net* **destroy**
: Deletes the connection and its associated namespace and information.


# Callback commands

These commands can be used within callbacks

**who** ?**address**?
: Returns the nick of the user who performed a command.  The optional keyword **address** causes the command to return the user in the format "username@address".

**action**
: Returns the action performed, such as KICK, PRIVMSG, MODE, etc... Normally not useful, as callbacks are bound to a particular event.

**target**
: Returns the target of a particular command, such as the channel or user to whom a PRIVMSG is sent.

**additional**
: Returns a list of any additional arguments after the target.

**header**
: Returns the entire event header (everything up to the :) as a proper list.

**msg**
: Returns the message portion of the command (the part after the :).


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *irc* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking
