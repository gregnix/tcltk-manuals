---
CommandName: picoirc
title: picoirc
ManualSection: n
Version: 0.14.1
TclPart: tcllib
TclDescription: Simple embeddable IRC interface
Links:
 - rfc 1459
Keywords:
 - chat
 - irc
Copyright:
---

# Name

picoirc - Small and simple embeddable IRC client.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [picoirc]{.lit} [0.14.1]{.optlit}
[::picoirc::connect]{.cmd} [callback]{.arg} [nick]{.arg} [password]{.optarg} [url]{.arg}
[::picoirc::post]{.cmd} [context]{.arg} [channel]{.arg} [message]{.arg}
:::

# Description

This package provides a general purpose minimal IRC client suitable for embedding in other applications. All communication with the parent application is done via an application provided callback procedure. Each connection has its own state so you can hook up multiple servers in a single application instance.

To initiate an IRC connection you must call **picoirc::connect** with a callback procedure, a nick-name to use on IRC and the IRC URL that describes the connection. This will return a variable name that is the irc connection context. See [Callback] for details.

This package is a fairly simple IRC client. If you need something with more capability investigate the **irc** package.

# Commands

**::picoirc::connect** *callback* *nick* ?*password*? *url*
: Creates a new irc connection to the server specified by *url* and login using the *nick* as the username and optionally *password*.  If the *url* starts with *ircs://* then a TLS connection is created. The *callback* must be as specified in [Callback].  Returns a package-specific variable that is used when calling other commands in this package.

    *Note:* For connecting via TLS the Tcl module *tls* must be already loaded, otherwise an error is raised.

    ```
    # must be loaded for TLS
    package require tls
    # default arguments
    tls::init -autoservername true -command workaround \
        -require 1 -cadir /etc/ssl/certs -tls1 0 -tls1.1 0
    # avoid annoying bgerror, errors are already catched internally
    proc workaround {state args} {
        if {$state == "verify"} {
            return [lindex $args 3]
        }
    }
    ```

**::picoirc::post** *context* *channel* *message*
: This should be called to process user input and send it to the server. If *message* is multiline then each line will be processed and sent individually. A number of commands are recognised when prefixed with a forward-slash (/). Such commands are converted to IRC command sequences and then sent. If *channel* is empty then all raw output to the server is handled. The default action is to write the *message* to the irc socket. However, before this happens the callback is called with "debug write". This permits the application author to inspect the raw IRC data and if desired to return a break error code to halt further processing. In this way the application can override the default send via the callback procedure.


# Callback

The callback must look like:

```
proc Callback {context state args} {
}
```

where context is the irc context variable name (in case you need to pass it back to a picoirc procedure). state is one of a number of states as described below.

**init**
: called just before the socket is created

**connect**
: called once we have connected, before we join any channels

**close**
: called when the socket gets closed, before the context is deleted. If an error occurs before we get connected the only argument will be the socket error message.

**userlist** *channel* *nicklist*
: called to notify the application of an updated userlist. This is generated when the output of the NAMES irc command is seen. The package collects the entire output which can span a number of output lines from the server and calls this callback when they have all been received.

**userinfo** *nick* *info*
: called as a response of WHOIS command. *nick* is the user the command was targeted for. *info* is the dictionary containing detailed information about that user: name, host, channels and userinfo. userinfo typically contains name and version of user's IRC client.

**chat** *target* *nick* *message* *type*
: called when a message arrives. *target* is the identity that the message was targetted for. This can be the logged in nick or a channel name. *nick* is the name of the sender of the message. *message* is the message text. *type* is set to "ACTION" if the message was sent as a CTCP ACTION. *type* is set to "NOTICE" if the message was sent as a NOTICE command, in that case *target* is empty if it matches current user nick or it's "\*", in later case empty *target* means that notice comes from server.

**mode** *nick* *target* *flags*
: called when mode of user or channel changes. *nick* is the name of the user who requested a change, can be empty if it's the server. *target* is the identity that has its mode changed. *flags* are the changes in mode.

**system** *channel* *message*
: called when a system message is received

**topic** *channel* *topic*
: called when the channel topic string is seen. *topic* is the text of the channel topic.

**traffic** *action* *channel* *nick* ?*newnick*?
: called when users join, leave or change names. *action* is either entered, left or nickchange and *nick* is the user doing the action. *newnick* is the new name if *action* is nickchange.

    *NOTE*: *channel* is often empty for these messages as nick activities are global for the irc server. You will have to manage the nick for all connected channels yourself.

**version**
: This is called to request a version string to use to override the internal version. If implemented, you should return as colon delimited string as

    Appname:Appversion:LibraryVersion

    For example, the default is

    PicoIRC:\[package provide picoirc\]:Tcl \[info patchlevel\]

**debug** *type* *raw*
: called when data is either being read or written to the network socket. *type* is set to **read** when reading data and **write** if the data is to be written. *raw* is the unprocessed IRC protocol data.

    In both cases the application can return a break error code to interrupt further processing of the raw data. If this is a **read** operation then the package will not handle this line. If the operation is **write** then the package will not send the data. This callback is intended for debugging protocol issues but could be used to redirect all input and output if desired.


# Category

Networking
