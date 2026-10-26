---
CommandName: websocket
title: websocket
ManualSection: n
Version: 1.6
TclPart: tcllib
TclDescription: websocket client and server
Links:
 - http
Keywords:
 - http
 - internet
 - net
 - rfc 6455
Copyright:
---

# Name

websocket - Tcl implementation of the websocket protocol

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [http]{.lit} [2.7]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [sha1]{.lit}
[package]{.cmd} [require]{.sub} [base64]{.lit}
[package]{.cmd} [require]{.sub} [websocket]{.lit} [1.6]{.optlit}
[::websocket::open]{.cmd} [url]{.arg} [handler]{.arg} [options]{.optarg}
[::websocket::send]{.cmd} [sock]{.arg} [type]{.arg} [msg]{.optarg} [final]{.optarg}
[::websocket::server]{.cmd} [sock]{.arg}
[::websocket::live]{.cmd} [sock]{.arg} [path]{.arg} [cb]{.arg} [proto]{.optarg}
[::websocket::test]{.cmd} [srvSock]{.arg} [cliSock]{.arg} [path]{.arg} [hdrs]{.optarg} [qry]{.optarg}
[::websocket::upgrade]{.cmd} [sock]{.arg}
[::websocket::takeover]{.cmd} [sock]{.arg} [handler]{.arg} [server]{.optarg}
[::websocket::conninfo]{.cmd} [sock]{.arg} [what]{.arg}
[::websocket::find]{.cmd} [host]{.optarg} [port]{.optarg}
[::websocket::configure]{.cmd} [sock]{.arg} [args]{.arg}
[::websocket::loglevel]{.cmd} [loglvl]{.optarg}
[::websocket::close]{.cmd} [sock]{.arg} [code]{.optarg} [reason]{.optarg}
:::

# Description

NOTE: THIS DOCUMENTATION IS WORK IN PROGRESS...

The websocket library is a pure Tcl implementation of the WebSocket specification covering the needs of both clients and servers. Websockets provide a way to upgrade a regular HTTP connection into a long-lived and continuous binary or text communication between the client and the server.  The library offers a high-level interface to receive and send data as specified in RFC 6455 (v. 13 of the protocol), relieving callers from all necessary protocol framing and reassembly.  It implements the ping facility specified by the standard, together with levers to control it.  Pings are server-driven and ensure the liveness of the connection across home (NAT) networks. The library has a number of introspection facilities to inquire about the current state of the connection, but also to receive notifications of incoming pings, if necessary.  Finally, the library contains a number of helper procedures to facilitate the upgrading handshaking in existing web servers.

Central to the library is the procedure **websocket::takeover** that will take over a regular socket and treat it as a WebSocket, thus performing all necessary protocol framing, packetisation and reassembly in servers and clients.  The procedure also takes a handler, a command that will be called back each time a (possibly reassembled) packet from the remote end is ready for delivery at the original caller.  While exported by the package, the command **websocket::takeover** is seldom called in applications, since the package provides other commands that are specifically tuned for the needs of clients and servers.

Typically, clients will open a connection to a remote server by providing a WebSocket URL (*ws:* or *wss:* schemes) and the handler described above to the command **websocket::open**. The opening procedure is a wrapper around the latest http::geturl implementations: it arranges to keep the socket created within the http library opened for reuse, but confiscates it from its (internal) map of known sockets for its own use.

Servers will start by registering themselves through the command **::websocket::server** and a number of handlers for paths using the command **::websocket::live**.  Then for each incoming client connection, they should test the incoming request to detect if it is an upgrade request using **::websocket::test** and perform the final handshake to place the socket connection under the control of the websocket library and its central procedure using **::websocket::upgrade**.

Apart from these main commands, the package provides a number of commands for introspection and basic operations on the websockets that it has under its control.  As WebSockets connections are long-lived, most remaining communication with the library will be by way of callbacks, i.e. commands that are triggered whenever important events within the library have occur, but mostly whenever data has been received on a WebSocket.

# Callbacks

A number of commands of the library take a handler handler command as an argument, a command which will be called back upon reception of data, but also upon important events within the library or events resulting from control messages sent by the remote end.  For each callback being performed, the following arguments will be appended:

*sock*
: The identifier of the WebSocket, as returned for example by **::websocket::open**

*type*
: A textual type describing the event or message content, can be one of the following

    **text**
    : Complete text message

    **binary**
    : Complete binary message

    **ping**
    : Incoming ping message

    **pong**
    : Response to incoming ping message

    **connect**
    : Notification of successful connection to server

    **disconnect**
    : Disconnection from remote end

    **close**
    : Pending closure of connection

    **timeout**
    : Notification of connection timeout

    **error**
    : Notification of error condition


*msg*
: Will contain the data of the message, whenever this is relevant, i.e. when the *type* is **text**, **binary**, **ping** or **pong** and whenever there is data available.


# API

**::websocket::open** *url* *handler* ?*options*?
: This command is used in clients to open a WebSocket to a remote websocket-enabled HTTP server.  The URL provided as an argument in *url* should start with ws: or wss:, which are the WebSockets counterpart of http: and https:. The *handler* is a command that will be called back on data reception or whenever important events occur during the life of the websocket. **::websocket::open** will return a socket which serves as both the identifier of the websocket and of the physical low-level socket to the server.  This socket can be used in a number of other commands for introspection or for controlling the behaviour of the library. Being essentially a wrapper around the **::http::geturl** command, this command provides mostly the same set of dash-led options than **::http::geturl**.  Documented below are the options that differ from **::http::geturl** and which are specific to the WebSocket library.

    -headers
    : This option is supported, knowing that a number of headers will be automatically added internally in the library in order to be able to handshake the upgrading of the socket from a regular HTTP socket to a WebSocket with the server.

    -validate
    : This option is not supported as it has no real point for WebSockets.

    -handler
    : This option is used internally by the websocket library and cannot be used.

    -command
    : This option is used internally by the websocket library and cannot be used.

    -protocol
    : This option specifies a list of application protocols to handshake with the server.  This protocols might help the server triggering application specific features.  The http::geturl option -protocol is used internally by the websocket library and cannot be used.

    -timeout
    : This option is supported, but will implemented as part of the library to enable a number of finalising cleanups.


**::websocket::send** *sock* *type* ?*msg*? ?*final*?
: This command will send a fragment or a control message to the remote end of the WebSocket identified by *sock*.  The type of the message specified in *type* can either be an integer according to the specification or (preferrably) one of the following case insensitive strings: "text", "binary" or "ping".  The content of the message to send to the remote end is contained in *msg* and message fragmentation is made possible by the setting the argument *final* to non-true, knowing that the type of each fragment has then to be the same. The command returns the number of bytes that were effectively sent, or -1 on errors.  Serious errors, such as when *sock* does not identify a known WebSocket or when the connection is not stable yet will generate errors that must be catched.

**::websocket::server** *sock*
: This command registers the (accept) socket *sock* as the identifier fo an HTTP server that is capable of doing WebSockets. Paths onto which this server will listen for incoming connections should be declared using **::websocket::live**.

**::websocket::live** *sock* *path* *cb* ?*proto*?
: This procedure registers callbacks that will be performed on a WebSocket compliant server registered with **::websocket::server** whenever a client connects to a matching path and protocol. *sock* is the listening socket of the websocket compliant server declared using **::websocket::server**.  *path* is a glob-style path to match in client request, whenever this will occur.  *cb* is the command to callback (see Callbacks).  *proto* is a glob-style protocol name matcher.

**::websocket::test** *srvSock* *cliSock* *path* ?*hdrs*? ?*qry*?
: This procedure will test if the connection from an incoming client on socket *cliSock* and on the path *path* is the opening of a WebSocket stream within a known server *srvSock*.  The incoming request is not upgraded at once, instead a (temporary) context for the incoming connection is created.  This allows server code to perform a number of actions, if necessary, before the WebSocket stream connection goes live.  The text is made by analysing the content of the headers *hdrs* which should contain a dictionary list of the HTTP headers of the incoming client connection. The command will return **1** if this is an incoming WebSocket upgrade request and **0** otherwise.

**::websocket::upgrade** *sock*
: Upgrade the socket *sock* that had been deemed by **::websocket::test** to be a WebSocket connection request to a true WebSocket as recognised by this library. As a result, the necessary connection handshake will be sent to the client, and the command will arrange for relevant callbacks to be made during the life of the WebSocket, notably using the specifications described by **::websocket::live**.

**::websocket::takeover** *sock* *handler* ?*server*?
: Take over the existing opened socket *sock* to implement sending and receiving WebSocket framing on top of the socket.  The procedure arranges for *handler* to be called back whenever messages, control messages or other important internal events are received or occured.  *server* defaults to **0** and can be set to **1** (or a boolean that evaluates to true) to specify that this is a WebSocket within a server.  Apart from specificities in the protocol, servers should ping their clients at regular intervals in order to keep the connection opened at all time.  When *server* is set to true, the library will arrange to send these pings automatically.

**::websocket::conninfo** *sock* *what*
: Provides callers with some introspection facilities in order to get some semi-internal information about an existing websocket connection. Depending on the value of the *what* argument, the procedure returns the following piece of information:

    **peername**
    : Name (preferred) or IP of remote end.

    **sockname**
    : or **name** Name or IP of local end.

    **closed**
    : **1** if the connection is closed, **0** otherwise

    **client**
    : **1** if the connection is a client websocket, **0** otherwise

    **server**
    : **1** if the connection is a server websocket, **0** otherwise

    **type**
    : **server** if the connection is a server websocket, **client** otherwise.

    **handler**
    : The handler command associated to the websocket

    **state**
    : The state of the websocket, which can be one of:

        **CONNECTING**
        : Connection to remote end is in progress.

        **CONNECTED**
        : Connection is connected to remote end.

        **CLOSED**
        : Connection is closed.



**::websocket::find** ?*host*? ?*port*?
: Look among existing websocket connections for the ones that match the hostname and port number filters passed as parameters.  This lookup takes the remote end into account and the *host* argument is matched both against the hostname (whenever available) and the IP address of the remote end.  Both the *host* and *port* arguments are glob-style string matching filters and default to **\***, i.e. will match any host and/or port number.

**::websocket::configure** *sock* *args*
: This command takes a number of dash-led options (and their values) to configure the behaviour of an existing websocket connection.  The recognised options are the following (they can be shortened to the lowest common denominator):

    **-keepalive**
    : is the number of seconds between each keepalive pings being sent along the connection.  A zero or negative number will effectively turn off the feature.  In servers, **-keepalive** defaults to 30 seconds, and in clients, no pings are initiated.

    **-ping**
    : is the text that is used during the automated pings.  This text defaults to the empty string, leading to an empty ping.


**::websocket::loglevel** ?*loglvl*?
: Set or query the log level of the library, which defaults to error. Logging is built on top of the logger module, and the library makes use of the following levels: **debug**, **info**, **notice**, **warn** and **error**.  When called with no argument, this procedure will simply return the current log level.  Otherwise *loglvl* should contain the desired log level.

**::websocket::close** *sock* ?*code*? ?*reason*?
: Gracefully close a websocket that was directly or indirectly passed to **::websocket::takeover**.  The procedure will optionally send the *code* and describing *reason* as part of the closure handshake. Good defaults are provided, so that reasons for a number of known codes will be sent back. Only the first 125 characters of a reason string will be kept and sent as part of the handshake. The known codes are:

    **1000**
    : Normal closure (the default *code* when none provided).

    **1001**
    : Endpoint going away

    **1002**
    : Protocol Error

    **1003**
    : Received incompatible data type

    **1006**
    : Abnormal closure

    **1007**
    : Received data not consistent with type

    **1008**
    : Policy violation

    **1009**
    : Received message too big

    **1010**
    : Missing extension

    **1011**
    : Unexpected condition

    **1015**
    : TLS handshake error



# Examples

The following example script is a client that opens a websocket connection to an echo service, waits 400ms to ensure that the connection is really established and sends a single textual message which should be echoed back by the echo service.  A real example would probably use the **connect** callback to know when connection to the remote server has been establish and would only send data at that time. Finally the script closes the connection.

```
package require websocket
::websocket::loglevel debug
proc handler { sock type msg } {
    switch -glob -nocase -- $type {
	co* {
	    puts "Connected on $sock"
	}
	te* {
	    puts "RECEIVED: $msg"
	}
	cl* -
	dis* {
	}
    }

}
proc test { sock } {
    puts "[::websocket::conninfo $sock type] from [::websocket::conninfo $sock sockname] to [::websocket::conninfo $sock peername]"

    ::websocket::send $sock text "Testing, testing..."
    after 2000 ::websocket::close $sock
}
set sock [::websocket::open ws://ws.ifelse.io/ handler]
after 400 test $sock
vwait forever
```

Example code for a websocket server is provided in the Tcllib directory "examples/websocket".

# TLS security considerations

This package uses the **TLS** package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *websocket* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking
