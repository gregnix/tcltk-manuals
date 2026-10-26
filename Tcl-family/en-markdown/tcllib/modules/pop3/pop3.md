---
CommandName: pop3
ManualSection: n
Version: 1.11
TclPart: tcllib
TclDescription: Tcl POP3 Client Library
Keywords:
 - email
 - mail
 - pop
 - pop3
 - rfc 1939
 - secure
 - ssl
 - tls
Copyright:
---

# Name

pop3 - Tcl client for POP3 email protocol

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pop3]{.lit} [1.11]{.optlit} 
[::pop3::open]{.cmd} [-msex 0|1]{.optarg} [-retr-mode retr|list|slow]{.optarg} [-socketcmd cmdprefix]{.optarg} [-stls 0|1]{.optarg} [-tls-callback stls-callback-command]{.optarg} [host]{.arg} [username]{.arg} [password]{.arg} [port]{.optarg} 
[::pop3::config]{.cmd} [chan]{.arg} 
[::pop3::status]{.cmd} [chan]{.arg} 
[::pop3::last]{.cmd} [chan]{.arg} 
[::pop3::retrieve]{.cmd} [chan]{.arg} [startIndex]{.arg} [endIndex]{.optarg} 
[::pop3::delete]{.cmd} [chan]{.arg} [startIndex]{.arg} [endIndex]{.optarg} 
[::pop3::list]{.cmd} [chan]{.arg} [msg]{.optarg} 
[::pop3::top]{.cmd} [chan]{.arg} [msg]{.arg} [n]{.arg} 
[::pop3::uidl]{.cmd} [chan]{.arg} [msg]{.optarg} 
[::pop3::capa]{.cmd} [chan]{.arg} 
[::pop3::close]{.cmd} [chan]{.arg} 
:::

# Description

The **pop3** package provides a simple Tcl-only client library for the POP3 email protocol as specified in [RFC 1939](http://www.rfc-editor.org/rfc/rfc1939.txt). It works by opening the standard POP3 socket on the server, transmitting the username and password, then providing a Tcl API to access the POP3 protocol commands.  All server errors are returned as Tcl errors (thrown) which must be caught with the Tcl **catch** command.

# Tls security considerations

This package uses the **TLS** package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Api

**::pop3::open** ?**-msex** 0|1? ?**-retr-mode** retr|list|slow? ?**-socketcmd** cmdprefix? ?**-stls** 0|1? ?**-tls-callback** stls-callback-command? *host username password* ?*port*?
: Open a socket connection to the server specified by *host*, transmit the *username* and *password* as login information to the server.  The default port number is **110**, which can be overridden using the optional *port* argument.  The return value is a channel used by all of the other ::pop3 functions. The command recognizes three options


**-msex** boolean
: Setting this option tells the package that the server we are talking to is an MS Exchange server (which has some oddities we have to work around). The default is **False**.

**-retr-mode** retr|list|slow
: The retrieval mode determines how exactly messages are read from the server. The allowed values are **retr**, **list** and **slow**. The default is **retr**. See **::pop3::retrieve** for more information.

**-socketcmd** cmdprefix
: This option allows the user to overide the use of the builtin **socket** command with any API-compatible command. The envisioned main use is the securing of the new connection via SSL, through the specification of the command **tls::socket**. This command is specially recognized as well, changing the default port of the connection to **995**.

**-stls** boolean
: Setting this option tells the package to secure the connection using SSL or TLS. It performs STARTTLS as described in IETF RFC 2595, it first opens a normal, unencrypted connection and then negotiates a SSLv3 or TLSv1 connection. If the connection cannot be secured, the connection will be closed and an error will be returned

**-tls-callback** stls-callback-command
: This option allows the user to overide the **tls::callback** used during the **-stls** SSL/TLS handshake. See the TLS manual for details on how to implement this callback.


**::pop3::config** *chan*
: Returns the configuration of the pop3 connection identified by the channel handle *chan* as a serialized array.

**::pop3::status** *chan*
: Query the server for the status of the mail spool.  The status is returned as a list containing two elements, the first is the number of email messages on the server and the second is the size (in octets, 8 bit blocks) of the entire mail spool.

**::pop3::last** *chan*
: Query the server for the last email message read from the spool.  This value includes all messages read from all clients connecting to the login account.  This command may not be supported by the email server, in which case the server may return 0 or an error.

**::pop3::retrieve** *chan startIndex* ?*endIndex*?
: Retrieve a range of messages from the server.  If the *endIndex* is not specified, only one message will be retrieved.  The return value is a list containing each message as a separate element.  See the *startIndex* and *endIndex* descriptions below. The retrieval mode determines how exactly messages are read from the server. The mode **retr** assumes that the RETR command delivers the size of the message as part of the command status and uses this to read the message efficiently. In mode **list** RETR does not deliver the size, but the LIST command does and we use this to retrieve the message size before the actual retrieval, which can then be done efficiently. In the last mode, **slow**, the system is unable to obtain the size of the message to retrieve in any manner and falls back to reading the message from the server line by line. It should also be noted that the system checks upon the configured mode and falls back to the slower modes if the above assumptions are not true.

**::pop3::delete** *chan startIndex* ?*endIndex*?
: Delete a range of messages from the server.  If the *endIndex* is not specified, only one message will be deleted.  Note, the indices are not reordered on the server, so if you delete message 1, then the first message in the queue is message 2 (message index 1 is no longer valid).  See the *startIndex* and *endIndex* descriptions below.


*startIndex*
: The *startIndex* may be an index of a specific message starting with the index 1, or it have any of the following values:


**start**
: This is a logical value for the first message in the spool, equivalent to the value 1.

**next**
: The message immediately following the last message read, see **::pop3::last**.

**end**
: The most recent message in the spool (the end of the spool).  This is useful to retrieve only the most recent message.


*endIndex*
: The *endIndex* is an optional parameter and defaults to the value "-1", which indicates to only retrieve the one message specified by *startIndex*.  If specified, it may be an index of a specific message starting with the index "1", or it may have any of the following values:


**last**
: The message is the last message read by a POP3 client, see **::pop3::last**.

**end**
: The most recent message in the spool (the end of the spool).


**::pop3::list** *chan* ?*msg*?
: Returns the scan listing of the mailbox. If parameter *msg* is given, then the listing only for that message is returned.

**::pop3::top** *chan* *msg* *n*
: Optional POP3 command, not all servers may support this. **::pop3::top** retrieves headers of a message, specified by parameter *msg*, and number of *n* lines from the message body.

**::pop3::uidl** *chan* ?*msg*?
: Optional POP3 command, not all servers may support this. **::pop3::uidl** returns the uid listing of the mailbox. If the parameter *msg* is specified, then the listing only for that message is returned.

**::pop3::capa** *chan*
: Optional POP3 command, not all servers may support this. **::pop3::capa** returns a list of the capabilities of the server. TOP, SASL, UIDL, LOGIN-DELAY and STLS are typical capabilities. See IETF RFC 2449.

**::pop3::close** *chan*
: Gracefully close the connect after sending a POP3 QUIT command down the socket.


# Secure mail transfer

A pop3 connection can be secured with SSL/TLS by requiring the package **TLS** and then using either the option **-socketcmd** or the option **-stls** of the command **pop3::open**. The first method, option **-socketcmd**, will force the use of the **tls::socket** command when opening the connection. This is suitable for POP3 servers which expect SSL connections only. These will generally be listening on port 995.

```
	package require tls
	tls::init -cafile /path/to/ca/cert -keyfile ...

	# Create secured pop3 channel
	pop3::open -socketcmd tls::socket \
		$thehost $theuser $thepassword

	...
```

The second method, option **-stls**, will connect to the standard POP3 port and then perform an STARTTLS handshake. This will only work for POP3 servers which have this capability. The package will confirm that the server supports STARTTLS and the handshake was performed correctly before proceeding with authentication.

```
	package require tls
	tls::init -cafile /path/to/ca/cert -keyfile ...

	# Create secured pop3 channel
	pop3::open -stls 1 \
		$thehost $theuser $thepassword

	...
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *pop3* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking
