---
CommandName: nameserv
ManualSection: n
Version: 0.4.3
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::common(n)
 - nameserv::server(n)
Keywords:
 - client
 - name service
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

nameserv - Name service facility, Client

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [nameserv]{.lit} [0.4.3]{.optlit} 
[package]{.cmd} [require]{.sub} [comm]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[::nameserv::bind]{.cmd} [name]{.arg} [data]{.arg} 
[::nameserv::release]{.cmd} 
[::nameserv::search]{.cmd} [-async|-continuous]{.optlit} [pattern]{.optarg} 
[::nameserv::protocol]{.cmd} 
[::nameserv::server_protocol]{.cmd} 
[::nameserv::server_features]{.cmd} 
[::nameserv::cget]{.cmd} [-option]{.sub} 
[::nameserv::configure]{.cmd} 
[::nameserv::configure]{.cmd} [-option]{.sub} 
[::nameserv::configure]{.cmd} [-option]{.sub} [value...]{.arg} 
[\$result]{.cmd} [destroy]{.sub} 
[\$result]{.cmd} [filled]{.sub} 
[\$result]{.cmd} [get]{.sub} [name]{.arg} 
[\$result]{.cmd} [names]{.sub} 
[\$result]{.cmd} [size]{.sub} 
[\$result]{.cmd} [getall]{.sub} [pattern]{.optarg} 
:::

# Description

Please read *Name service facility, introduction* first.

This package provides a client for the name service facility implemented by the package **nameserv::server**.

This service is built in top of and for the package **comm**. It has nothing to do with the Internet's Domain Name System. If the reader is looking for a package dealing with that please see Tcllib's packages **dns** and **resolv**.

# Api

The package exports eight commands, as specified below:

**::nameserv::bind** *name* *data*
: The caller of this command registers the given *name* as its name in the configured name service, and additionally associates a piece of *data* with it. The service does nothing with this information beyond storing it and delivering it as part of search results. The meaning is entirely up to the applications using the name service. A generally useful choice would for example be an identifier for a communication endpoint managed by the package **comm**. Anybody retrieving the name becomes immediately able to talk to this endpoint, i.e. the registering application. Of further importance is that a caller can register itself under more than one name, and each name can have its own piece of *data*. Note that the name service, and thwerefore this command, will throw an error if the chosen name is already registered.

**::nameserv::release**
: Invoking this command releases all names (and their data) registered by all previous calls to **::nameserv::bind** of this client. Note that the name service will run this command implicitly when it loses the connection to this client.

**::nameserv::search** ?**-async**|**-continuous**? ?*pattern*?
: This command searches the name service for all registered names matching the specified glob-*pattern*. If not specified the pattern defaults to **\***, matching everything. The result of the command is a dictionary mapping the matching names to the data associated with them at *bind*-time. If either option **-async** or **-continuous** were specified the result of this command changes and becomes the Tcl command of an object holding the actual result. These two options are supported if and only if the service the client is connected to supports the protocol feature *Search/Continuous*. For **-async** the result object is asynchronously filled with the entries matching the pattern at the time of the search and then not modified any more. The option **-continuous** extends this behaviour by additionally continuously monitoring the service for the addition and removal of entries which match the pattern, and updating the object's contents appropriately. *Note* that the caller is responsible for configuring the object with a callback for proper notification when the current result (or further changes) arrive. For more information about this object see section **ASYNCHRONOUS AND CONTINUOUS SEARCHES**.

**::nameserv::protocol**
: This command returns the highest version of the name service protocol supported by the package.

**::nameserv::server_protocol**
: This command returns the highest version of the name service protocol supported by the name service the client is currently connected to.

**::nameserv::server_features**
: This command returns a list containing the names of the features of the name service protocol which are supported by the name service the client is currently connected to.

**::nameserv::cget** **-option**
: This command returns the currently configured value for the specified **-option**. The list of supported options and their meaning can be found in section **OPTIONS**.

**::nameserv::configure**
: In this form the command returns a dictionary of all supported options, and their current values. The list of supported options and their meaning can be found in section **OPTIONS**.

**::nameserv::configure** **-option**
: In this form the command is an alias for "**::nameserv::cget** **-option**". The list of supported options and their meaning can be found in section **OPTIONS**.

**::nameserv::configure** **-option** *value*...
: In this form the command is used to configure one or more of the supported options. At least one option has to be specified, and each option is followed by its new value. The list of supported options and their meaning can be found in section **OPTIONS**. This form can be used only as long as the client has not contacted the name service yet. After contact has been made reconfiguration is not possible anymore. This means that this form of the command is for the initalization of the client before it use. The command forcing a contact with the name service are


**bind**
: ...see next...

**release**
: ...see next...

**search**
: ...see next...

**server_protocol**
: ...see next...

**server_features**
: 


# Connection handling

The client automatically connects to the service when one of the commands below is run for the first time, or whenever one of the commands is run after the connection was lost, when it was lost.

**bind**
: ...see next...

**release**
: ...see next...

**search**
: ...see next...

**server_protocol**
: ...see next...

**server_features**
: Since version 0.2 of the client it will generate an event when the connection is lost, allowing higher layers to perform additional actions. This is done via the support package **uevent**. This and all other name service related packages hereby reserve the uevent-tag *nameserv*. All their events will be posted to that tag.


# Events

This package generates only one event, *lost-connection*. The detail information provided to that event is a Tcl dictionary. The only key contained in the dictionnary is **reason**, and its value will be a string describing why the connection was lost. This string is supplied by the underlying communication package, i.e. **comm**.

# Options

The options supported by the client are for the specification of which name service to contact, i.e. of the location of the name service. They are:

**-host** *name*|*ipaddress*
: This option specifies the host name service to contact is running on, either by *name*, or by *ipaddress*. The initial default is **localhost**, i.e. it is expected to contact a name service running on the same host as the application using this package.

**-port** *number*
: This option specifies the port the name service to contact is listening on. It has to be a positive integer number (> 0) not greater than 65536 (unsigned short). The initial default is the number returned by the command **::nameserv::common::port**, as provided by the package **::nameserv::common**.


# Asynchronous and continuous searches

Asynchronous and continuous searches are invoked by using either option **-async** or **-continuous** as argument to the command **::nameserv::search**.

*Note* that these two options are supported if and only if the service the client is connected to supports the protocol feature *Search/Continuous*. The service provided by the package **::nameserv::server** does this since version 0.3.

For such searches the result of the search command is the Tcl command of an object holding the actual result. The API provided by these objects is:

**Options:**
: 


**-command** *command_prefix*
: This option has to be set if a user of the result object wishes to get asynchronous notifications when the search result or changes to it arrive. *Note* that while it is possible to poll for the arrival of the initial search result via the method **filled**, and for subsequent changes by comparing the output of method **getall** against a saved copy, this is not the recommended behaviour. Setting the **-command** callback and processing the notifications as they arrive is much more efficient. The *command_prefix* is called with two arguments, the type of change, and the data of the change. The type is either **add** or **remove**, indicating new data, or deleted data, respectively. The data of the change is always a dictionary listing the added/removed names and their associated data. The first change reported for a search is always the set of matching entries at the time of the search.


**Methods:**
: 


**\$result** **destroy**
: Destroys the object and cancels any continuous monitoring of the service the object may have had active.

**\$result** **filled**
: The result is a boolean value indicating whether the search result has already arrived (**True**), or not (**False**).

**\$result** **get** *name*
: Returns the data associated with the given *name* at *bind*-time.

**\$result** **names**
: Returns a list containing all names known to the object at the time of the invokation.

**\$result** **size**
: Returns an integer value specifying the size of the result at the time of the invokation.

**\$result** **getall** ?*pattern*?
: Returns a dictionary containing the search result at the time of the invokation, mapping the matching names to the data associated with them at *bind*-time.


# History

**0.3.1**
: Fixed SF Bug 1954771.

**0.3**
: Extended the client with the ability to perform asynchronous and continuous searches.

**0.2**
: Extended the client with the ability to generate events when it loses its connection to the name service. Based on package **uevent**.

**0.1**
: Initial implementation of the client.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *nameserv* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
