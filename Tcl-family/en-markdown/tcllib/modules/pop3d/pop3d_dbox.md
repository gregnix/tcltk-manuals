---
CommandName: pop3d::dbox
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Tcl POP3 Server Package
Keywords:
 - internet
 - network
 - pop3
 - protocol
 - rfc 822
Copyright:
 - Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pop3d::dbox - Simple mailbox database for pop3d

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pop3d::dbox]{.lit} [1.0.3]{.optlit} 
[::pop3d::dbox::new]{.cmd} [dbName]{.optarg} 
[dbName]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[dbName]{.ins} [destroy]{.sub} 
[dbName]{.ins} [base]{.sub} [base]{.arg} 
[dbName]{.ins} [add]{.sub} [mbox]{.arg} 
[dbName]{.ins} [remove]{.sub} [mbox]{.arg} 
[dbName]{.ins} [move]{.sub} [old]{.arg} [new]{.arg} 
[dbName]{.ins} [list]{.sub} 
[dbName]{.ins} [exists]{.sub} [mbox]{.arg} 
[dbName]{.ins} [locked]{.sub} [mbox]{.arg} 
[dbName]{.ins} [lock]{.sub} [mbox]{.arg} 
[dbName]{.ins} [unlock]{.sub} [mbox]{.arg} 
[dbName]{.ins} [stat]{.sub} [mbox]{.arg} 
[dbName]{.ins} [size]{.sub} [mbox]{.arg} [msgId]{.optarg} 
[dbName]{.ins} [dele]{.sub} [mbox]{.arg} [msgList]{.arg} 
[storageCmd]{.ins} [get]{.sub} [mbox]{.arg} [msgId]{.arg} 
:::

# Description

The package **pop3d::dbox** provides simple/basic mailbox management facilities. Each mailbox object manages a single base directory whose subdirectories represent the managed mailboxes. Mails in a mailbox are represented by files in a mailbox directory, where each of these files contains a single mail, both headers and body, in RFC 822 (*http://www.rfc-editor.org/rfc/rfc822.txt*) conformant format.

Any mailbox object following the interface described below can be used in conjunction with the pop3 server core provided by the package **pop3d**. It is especially possible to directly use the objects created by this package in the storage callback of pop3 servers following the same interface as servers created by the package **pop3d**.

**::pop3d::dbox::new** ?*dbName*?
: This command creates a new database object with an associated global Tcl command whose name is *dbName*. The command **dbName** may be used to invoke various operations on the database.  It has the following general form:

**dbName** *option* ?*arg arg ...*?
: *Option* and the *arg*s determine the exact behavior of the command. The following commands are possible for database objects:

*dbName* **destroy**
: Destroys the mailbox database and all transient data. The directory associated with the object is not destroyed.

*dbName* **base** *base*
: Defines the base directory containing the mailboxes to manage. If this method is not called none of the following methods will work.

*dbName* **add** *mbox*
: Adds a mailbox of name *mbox* to the database. The name must be a valid path component.

*dbName* **remove** *mbox*
: Removes the mailbox specified through *mbox*, and the mails contained therein, from the database. This method will fail if the specified mailbox is locked.

*dbName* **move** *old new*
: Changes the name of the mailbox *old* to *new*.

*dbName* **list**
: Returns a list containing the names of all mailboxes in the directory associated with the database.

*dbName* **exists** *mbox*
: Returns true if the mailbox with name *mbox* exists in the database, or false if not.

*dbName* **locked** *mbox*
: Checks if the mailbox specified through *mbox* is currently locked.

*dbName* **lock** *mbox*
: This method locks the specified mailbox for use by a single connection to the server. This is necessary to prevent havoc if several connections to the same mailbox are open. The complementary method is **unlock**. The command will return true if the lock could be set successfully or false if not.

*dbName* **unlock** *mbox*
: This is the complementary method to **lock**, it revokes the lock on the specified mailbox.

*dbName* **stat** *mbox*
: Determines the number of messages in the specified mailbox and returns this number. This method fails if the mailbox *mbox* is not locked.

*dbName* **size** *mbox* ?*msgId*?
: Determines the size of the message specified through its id in *msgId*, in bytes, and returns this number. The command will return the size of the whole maildrop if no message id was specified. If specified the *msgId* has to be in the range "1 ... \[*dbName* **stat**\]" or this call will fail. If **stat** was not called before this call, **size** will assume that there are zero messages in the mailbox.

*dbName* **dele** *mbox msgList*
: Deletes the messages whose numeric ids are contained in the *msgList* from the mailbox specified via *mbox*. The *msgList* must not be empty or this call will fail. The numeric ids in *msgList* have to be in the range "1 ... \[*dbName* **stat**\]" or this call will fail. If **stat** was not called before this call, **dele** will assume that there are zero messages in the mailbox.

*storageCmd* **get** *mbox* *msgId*
: Returns a handle for the specified message. This handle is a mime token following the interface described in the documentation of package **mime**. The token is *read-only*. In other words, the caller is allowed to do anything with the token except to modify it. The *msgId* has to be in the range "1 ... \[*dbName* **stat**\]" or this call will fail. If **stat** was not called before this call, **get** will assume that there are zero messages in the mailbox.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *pop3d* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
