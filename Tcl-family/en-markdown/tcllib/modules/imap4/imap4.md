---
CommandName: imap4
ManualSection: n
Version: 0.5.5
TclPart: tcllib
TclDescription: imap client
Links:
 - ftp
 - http
 - imap
 - mime
 - pop3
 - tls
Keywords:
 - email
 - imap
 - internet
 - mail
 - net
 - rfc3501
 - ssl
 - tls
Copyright:
---

# Name

imap4 - imap client-side tcl implementation of imap protocol

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [imap4]{.lit} [0.5.5]{.optlit} 
[::imap4::open]{.cmd} [hostname]{.arg} [port]{.optarg} 
[::imap4::starttls]{.cmd} [chan]{.arg} 
[::imap4::login]{.cmd} [chan]{.arg} [user]{.arg} [pass]{.arg} 
[::imap4::folders]{.cmd} [chan]{.arg} [-inline]{.optarg} [mboxref]{.optarg} [mboxname]{.optarg} 
[::imap4::select]{.cmd} [chan]{.arg} [mailbox]{.optarg} 
[::imap4::examine]{.cmd} [chan]{.arg} [mailbox]{.optarg} 
[::imap4::fetch]{.cmd} [chan]{.arg} [range]{.arg} [-inline]{.optarg} [attr]{.optdot} 
[::imap4::noop]{.cmd} [chan]{.arg} 
[::imap4::check]{.cmd} [chan]{.arg} 
[::imap4::folderinfo]{.cmd} [chan]{.arg} [info]{.optarg} 
[::imap4::msginfo]{.cmd} [chan]{.arg} [msgid]{.arg} [info]{.optarg} [defval]{.optarg} 
[::imap4::mboxinfo]{.cmd} [chan]{.arg} [info]{.optarg} 
[::imap4::isableto]{.cmd} [chan]{.arg} [capability]{.optarg} 
[::imap4::create]{.cmd} [chan]{.arg} [mailbox]{.arg} 
[::imap4::delete]{.cmd} [chan]{.arg} [mailbox]{.arg} 
[::imap4::rename]{.cmd} [chan]{.arg} [oldname]{.arg} [newname]{.arg} 
[::imap4::subscribe]{.cmd} [chan]{.arg} [mailbox]{.arg} 
[::imap4::unsubscribe]{.cmd} [chan]{.arg} [mailbox]{.arg} 
[::imap4::search]{.cmd} [chan]{.arg} [expr]{.arg} [...]{.optdot} 
[::imap4::close]{.cmd} [chan]{.arg} 
[::imap4::cleanup]{.cmd} [chan]{.arg} 
[::imap4::debugmode]{.cmd} [chan]{.arg} [errormsg]{.optarg} 
[::imap4::store]{.cmd} [chan]{.arg} [range]{.arg} [data]{.arg} [flaglist]{.arg} 
[::imap4::expunge]{.cmd} [chan]{.arg} 
[::imap4::copy]{.cmd} [chan]{.arg} [msgid]{.arg} [mailbox]{.arg} 
[::imap4::logout]{.cmd} [chan]{.arg} 
:::

# Description

The **imap4** library package provides the client side of the *Internet Message Access Protocol* (IMAP) using standard sockets or secure connection via TLS/SSL. The package is fully implemented in Tcl.

This document describes the procedures and explains their usage.

# Procedures

This package defines the following public procedures:

**::imap4::open** *hostname* ?*port*?
: Open a new IMAP connection and initalize the handler, the imap communication channel (handler) is returned. *hostname* - mail server *port* - connection port, defaults to 143 The namespace variable **::imap4::use_ssl** can be used to establish to a secure connection via TSL/SSL if set to true. In this case default connection port defaults to 993. *Note:* For connecting via SSL the Tcl module *tls* must be already loaded otherwise an error is raised.


```
    package require tls              ; # must be loaded for TLS/SSL
    set ::imap4::use_ssl 1           ; # request a secure connection
    set chan [::imap4::open $server] ; # default port is now 993
```

**::imap4::starttls** *chan*
: Use this when tasked with connecting to an unsecure port which must be changed to a secure port prior to user login.  This feature is known as *STARTTLS*.

**::imap4::login** *chan* *user* *pass*
: Login using the IMAP LOGIN command, 0 is returned on successful login. *chan* - imap channel *user* - username *pass* - password

**::imap4::folders** *chan* ?*-inline*? ?*mboxref*? ?*mboxname*?
: Get list of matching folders, 0 is returned on success. Wildcards '\*' as '%' are allowed for *mboxref* and *mboxname*, command **::imap4::folderinfo** can be used to retrieve folder information. *chan* - imap channel *mboxref* - mailbox reference, defaults to "" *mboxname* - mailbox name, defaults to "\*" If **-inline** is specified a compact folderlist is returned instead of the result code. All flags are converted to lowercase and leading special characters are removed.


```
{{Arc08 noselect} {Arc08/Private {noinferiors unmarked}} {INBOX noinferiors}}
```

**::imap4::select** *chan* ?*mailbox*?
: Select a mailbox, 0 is returned on success. *chan* - imap channel *mailbox* - Path of the mailbox,  defaults to *INBOX* Prior to examine/select an open mailbox must be closed - see: **::imap4::close**.

**::imap4::examine** *chan* ?*mailbox*?
: "Examines" a mailbox, read-only equivalent of **::imap4::select**. *chan* - imap channel *mailbox* - mailbox name or path to mailbox, defaults to *INBOX* Prior to examine/select an open mailbox must be closed - see: **::imap4::close**.

**::imap4::fetch** *chan* *range* ?*-inline*? ?*attr ...*?
: Fetch attributes from messages. The attributes are fetched and stored in the internal state which can be retrieved with command **::imap4::msginfo**, 0 is returned on success. If **-inline** is specified, alle records are returned as list in order as defined in the *attr* argument. *chan* - imap channel *range* - message index in format *FROM*:*TO* *attr* - imap attributes to fetch *Note:* If *FROM* is omitted, the 1st message is assumed, if *TO* is ommitted the last message is assumed. All message index ranges are 1-based.

**::imap4::noop** *chan*
: Send NOOP command to server. May get information as untagged data. *chan* - imap channel

**::imap4::check** *chan*
: Send CHECK command to server. Flush to disk. *chan* - imap channel

**::imap4::folderinfo** *chan* ?*info*?
: Get information on the recently selected folderlist. If the *info* argument is omitted or a null string, the full list of information available for the mailbox is returned. If the required information name is suffixed with a ? character, the command returns true if the information is available, or false if it is not. *chan* - imap channel *info* - folderlist options to retrieve Currently supported options: *delim* - hierarchy delimiter only, *match* - ref and mbox search patterns (see **::imap4::folders**), *names* - list of folder names only, *flags* - list of folder names with flags in format *{ {name {flags}} ... }* (see also compact format in function **::imap4::folders**).


```
{{Arc08 {{\NoSelect}}} {Arc08/Private {{\NoInferiors} {\UnMarked}}} {INBOX {\NoInferiors}}}
```

**::imap4::msginfo** *chan* *msgid* ?*info*? ?*defval*?
: Get information (from previously collected using fetch) from a given *msgid*. If the 'info' argument is omitted or a null string, the list of available information options for the given message is returned. If the required information name is suffixed with a ? character, the command returns true if the information is available, or false if it is not. *chan* - imap channel *msgid* - message number *info* - imap keyword to retrieve *defval* - default value, returned if info is empty *Note:* All message index ranges are 1-based.

**::imap4::mboxinfo** *chan* ?*info*?
: Get information on the currently selected mailbox. If the *info* argument is omitted or a null string, the list of available information options for the mailbox is returned. If the required information name is suffixed with a ? character, the command returns true if the information is available, or false if it is not. *chan* - imap channel *opt* - mailbox option to retrieve Currently supported options: *EXISTS* (noof msgs), *RECENT* (noof 'recent' flagged msgs), *FLAGS* In conjunction with OK: *PERMFLAGS*, *UIDNEXT*, *UIDVAL*, *UNSEEN* Div. states: *CURRENT*, *FOUND*, *PERM*.


```
    ::imap4::select $chan INBOX
    puts "[::imap4::mboxinfo $chan exists] mails in INBOX"
```

**::imap4::isableto** *chan* ?*capability*?
: Test for capability. It returns 1 if requested capability is supported, 0 otherwise. If *capability* is omitted all capability imap codes are retured as list. *chan* - imap channel *info* - imap keyword to retrieve *Note:* Use the capability command to ask the server if not already done by the user.

**::imap4::create** *chan* *mailbox*
: Create a new mailbox. *chan* - imap channel *mailbox* - mailbox name

**::imap4::delete** *chan* *mailbox*
: Delete a new mailbox. *chan* - imap channel *mailbox* - mailbox name

**::imap4::rename** *chan* *oldname* *newname*
: Rename a new mailbox. *chan* - imap channel *mailbox* - old mailbox name *mailbox* - new mailbox name

**::imap4::subscribe** *chan* *mailbox*
: Subscribe a new mailbox. *chan* - imap channel *mailbox* - mailbox name

**::imap4::unsubscribe** *chan* *mailbox*
: Unsubscribe a new mailbox. *chan* - imap channel *mailbox* - mailbox name

**::imap4::search** *chan* *expr* ?*...*?
: Search for mails matching search criterions, 0 is returned on success. *chan* - imap channel *expr* - imap search expression *Notes:* Currently the following search expressions are handled: *Mail header flags:* all mail header entries (ending with a colon ":"), like "From:", "Bcc:", ... *Imap message search flags:* ANSWERED, DELETED, DRAFT, FLAGGED, RECENT, SEEN, NEW, OLD, UNANSWERED, UNDELETED, UNDRAFT, UNFLAGGED, UNSEEN, ALL *Imap header search flags:* BODY, CC, FROM, SUBJECT, TEXT, KEYWORD, BCC *Imap conditional search flags:* SMALLER, LARGER, ON, SENTBEFORE, SENTON, SENTSINCE, SINCE, BEFORE (not implemented), UID (not implemented) *Logical search conditions:* OR, NOT


```
::imap4::search $chan larger 4000 seen
puts "Found messages: [::imap4::mboxinfo $chan found]"
Found messages: 1 3 6 7 8 9 13 14 15 19 20
```

**::imap4::close** *chan*
: Close the mailbox. Permanently removes \\Deleted messages and return to the AUTH state. *chan* - imap channel

**::imap4::cleanup** *chan*
: Destroy an IMAP connection and free the used space. Close the mailbox. Permanently removes \\Deleted messages and return to the AUTH state. *chan* - imap channel

**::imap4::debugmode** *chan* ?*errormsg*?
: Switch client into command line debug mode. This is a developers mode only that pass the control to the programmer. Every line entered is sent verbatim to the server (after the addition of the request identifier). The ::imap4::debug variable is automatically set to '1' on enter. It's possible to execute Tcl commands starting the line with a slash. *chan* - imap channel *errormsg* - optional error message to display

**::imap4::store** *chan* *range* *data* *flaglist*
: Alters data associated with a message in the selected mailbox. *chan* - imap channel *range* - message index in format *FROM*:*TO* *flaglist* - Flags the *data* operates on. *data* - The currently defined *data* items that can be stored are shown below. *Note* that all of these data types may also be suffixed with ".SILENT" to suppress the untagged FETCH response.


**FLAGS**
: Replace the flags for the message (other than \\Recent) with the *flaglist*.

**+FLAGS**
: Add the flags in *flaglist* to the existing flags for the message.

**-FLAGS**
: Remove the flags in *flaglist* to the existing flags for the message.


: For example:


```
	::imap4::store $chan $start_msgid:$end_msgid +FLAGS "Deleted"
```

**::imap4::expunge** *chan*
: Permanently removes all messages that have the \\Deleted flag set from the currently selected mailbox, without the need to close the connection. *chan* - imap channel

**::imap4::copy** *chan* *msgid* *mailbox*
: Copies the specified message (identified by its message number) to the named mailbox, i.e. imap folder. *chan* - imap channel *msgid* - message number *mailbox* - mailbox name

**::imap4::logout** *chan*
: Informs the server that the client is done with the connection and closes the network connection. Permanently removes \\Deleted messages. A new connection will need to be established to login once more. *chan* - imap channel


# Examples

```
    set user myusername
    set pass xtremescrt
    set server imap.test.tld
    set FOLDER INBOX
    # Connect to server
    set imap [::imap4::open $server]
    ::imap4::login $imap $user $pass
    ::imap4::select $imap $FOLDER
    # Output all the information about that mailbox
    foreach info [::imap4::mboxinfo $imap] {
        puts "$info -> [::imap4::mboxinfo $imap $info]"
    }
    # fetch 3 records inline
    set fields {from: to: subject: size}
    foreach rec [::imap4::fetch $imap :3 -inline {*}$fields] {
        puts -nonewline "#[incr idx])"
        for {set j 0} {$j<[llength $fields]} {incr j} {
            puts "\t[lindex $fields $j] [lindex $rec $j]"
        }
    }

    # Show all the information available about the message ID 1
    puts "Available info about message 1: [::imap4::msginfo $imap 1]"

    # Use the capability stuff
    puts "Capabilities: [::imap4::isableto $imap]"
    puts "Is able to imap4rev1? [::imap4::isableto $imap imap4rev1]"

    # Cleanup
    ::imap4::cleanup $imap
```

# Tls security considerations

This package uses the **TLS** package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# References

Mark R. Crispin, "INTERNET MESSAGE ACCESS PROTOCOL - VERSION 4rev1", RFC 3501, March 2003, *http://www.rfc-editor.org/rfc/rfc3501.txt*

OpenSSL, *http://www.openssl.org/*

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *imap4* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar. Only a small part of rfc3501 implemented.

# Category

Networking
