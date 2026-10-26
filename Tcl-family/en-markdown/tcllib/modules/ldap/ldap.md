---
CommandName: ldap
ManualSection: n
Version: 1.10.2
TclPart: tcllib
TclDescription: LDAP client
Keywords:
 - directory access
 - internet
 - ldap
 - ldap client
 - protocol
 - rfc 2251
 - rfc 4511
 - x.500
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
 - Copyright (c) 2006 Michael Schlenker <mic42@users.sourceforge.net>
---

# Name

ldap - LDAP client

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [ldap]{.lit} [1.10.2]{.optlit} 
[::ldap::connect]{.cmd} [host]{.arg} [port]{.optarg} 
[::ldap::tlsoptions]{.cmd} [reset]{.sub} 
[::ldap::tlsoptions]{.cmd} [opt1 val1]{.optarg} [opt2 val2]{.optarg} ... 
[::ldap::secure_connect]{.cmd} [host]{.arg} [port]{.optarg} 
[::ldap::secure_connect]{.cmd} [host]{.arg} [port]{.optarg} [verify_cert]{.optarg} [sni_servername]{.optarg} 
[::ldap::disconnect]{.cmd} [handle]{.arg} 
[::ldap::starttls]{.cmd} [handle]{.arg} 
[::ldap::starttls]{.cmd} [handle]{.arg} [cafile]{.optarg} [certfile]{.optarg} [keyfile]{.optarg} [verify_cert]{.optarg} [sni_servername]{.optarg} 
[::ldap::bind]{.cmd} [handle]{.arg} [name]{.optarg} [password]{.optarg} 
[::ldap::bindSASL]{.cmd} [handle]{.arg} [name]{.optarg} [password]{.optarg} 
[::ldap::unbind]{.cmd} [handle]{.arg} 
[::ldap::search]{.cmd} [handle]{.arg} [baseObject]{.arg} [filterString]{.arg} [attributes]{.arg} [options]{.arg} 
[::ldap::searchInit]{.cmd} [handle]{.arg} [baseObject]{.arg} [filterString]{.arg} [attributes]{.arg} [options]{.arg} 
[::ldap::searchNext]{.cmd} [handle]{.arg} 
[::ldap::searchEnd]{.cmd} [handle]{.arg} 
[::ldap::modify]{.cmd} [handle]{.arg} [dn]{.arg} [attrValToReplace]{.arg} [attrToDelete]{.optarg} [attrValToAdd]{.optarg} 
[::ldap::modifyMulti]{.cmd} [handle]{.arg} [dn]{.arg} [attrValToReplace]{.arg} [attrValToDelete]{.optarg} [attrValToAdd]{.optarg} 
[::ldap::add]{.cmd} [handle]{.arg} [dn]{.arg} [attrValueTuples]{.arg} 
[::ldap::addMulti]{.cmd} [handle]{.arg} [dn]{.arg} [attrValueTuples]{.arg} 
[::ldap::delete]{.cmd} [handle]{.arg} [dn]{.arg} 
[::ldap::modifyDN]{.cmd} [handle]{.arg} [dn]{.arg} [newrdn]{.arg} [deleteOld]{.optarg} [newSuperior]{.optarg} 
[::ldap::info]{.cmd} [ip]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [bound]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [bounduser]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [connections]{.sub} 
[::ldap::info]{.cmd} [tls]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [tlsstatus]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [saslmechanisms]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [control]{.sub} [handle]{.arg} 
[::ldap::info]{.cmd} [extensions]{.sub} [extensions]{.arg} 
[::ldap::info]{.cmd} [whoami]{.sub} [handle]{.arg} 
:::

# Description

The **ldap** package provides a Tcl-only client library for the LDAPv3 protocol as specified in RFC 4511 (*http://www.rfc-editor.org/rfc/rfc4511.txt*). It works by opening the standard (or secure) LDAP socket on the server, and then providing a Tcl API to access the LDAP protocol commands.  All server errors are returned as Tcl errors (thrown) which must be caught with the Tcl **catch** command.

# Tls security considerations

This package uses the **TLS** package to handle the security for **LDAPS** connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    ldap::tlsoptions -tls1 1 -ssl2 0 -ssl3 0 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Commands

**::ldap::connect** *host* ?*port*?
: Opens a LDAPv3 connection to the specified *host*, at the given *port*, and returns a token for the connection. This token is the *handle* argument for all other commands. If no *port* is specified it will default to **389**. The command blocks until the connection has been established, or establishment definitely failed.

**::ldap::tlsoptions** **reset**
: This command resets TLS options to default values. It returns the set of options. Using this command is incompatible with the obsolete form of **::ldap::secure_connect** and **::ldap_starttls**.

**::ldap::tlsoptions** ?*opt1* *val1*? ?*opt2* *val2*? ...
: This commands adds one or more options to some value, and may be used more than one time in order to add options in several steps.  A complete description of options may be found in the **tls** package documentation. Valid options and values are:


**-cadir** directory
: Provide the directory containing the CA certificates. No default.

**-cafile** file
: Provide the CA file. No default.

**-cipher** string
: Provide the cipher suites to use. No default.

**-dhparams** file
: Provide a Diffie-Hellman parameters file. No default.

**-request** boolean
: Request a certificate from peer during SSL handshake. Default: true.

**-require** boolean
: Require a valid certificate from peer during SSL handshake. If this is set to true then -request must also be set to true. Default: false

**-servername** host
: Only available if the OpenSSL library the TLS package is linked against supports the TLS hostname extension for 'Server Name Indication' (SNI). Use to name the logical host we are talking to and expecting a certificate for. No default.

**-ssl2** bool
: Enable use of SSL v2. Default: false

**-ssl3** bool
: Enable use of SSL v3. Default: false

**-tls1** bool
: Enable use of TLS v1 Default: true

**-tls1.1** bool
: Enable use of TLS v1.1 Default: true

**-tls1.2** bool
: Enable use of TLS v1.2 Default: true


This command returns the current set of TLS options and values. In particular, one may use this command without any arguments to get the current set of options.

Using this command is incompatible with the obsolete form of **::ldap::secure_connect** and **::ldap_starttls** (see below).

**::ldap::secure_connect** *host* ?*port*?
: Like **::ldap::connect**, except that the created connection is secured by SSL. The port defaults to **636**.  This command depends on the availability of the package **TLS**, which is a SSL binding for Tcl. If **TLS** is not available, then this command will fail. TLS options are specified with **::ldap::tlsoptions**. The command blocks until the connection has been established, or establishment definitely failed.

**::ldap::secure_connect** *host* ?*port*? ?*verify_cert*? ?*sni_servername*?
: Note: this form of the command is deprecated, since TLS options had to be specified with a combination of parameters to this command (*verify_cert* and *sni_servername*) and arguments to **::tls::init** (from package **tls**) for example to setup defaults for trusted certificates. Prefer the above form (without the *verify_cert* and *sni_servername* parameters) and set TLS options with **::ldap::tlsoptions**. If *verify_cert* is set to 1, the default, this checks the server certificate against the known hosts. If *sni_servername* is set, the given hostname is used as the hostname for Server Name Indication in the TLS handshake. Use **::tls::init** to setup defaults for trusted certificates. TLS supports different protocol levels. In common use are the versions 1.0, 1.1 and 1.2. By default all those versions are offered. If you need to modify the acceptable protocols, you can change the ::ldap::tlsProtocols list (deprecated).

**::ldap::disconnect** *handle*
: Closes the ldap connection refered to by the token *handle*. Returns the empty string as its result.

**::ldap::starttls** *handle*
: Start TLS negotiation on the connection denoted by *handle*, with TLS parameters set with **::ldap::tlsoptions**.

**::ldap::starttls** *handle* ?*cafile*? ?*certfile*? ?*keyfile*? ?*verify_cert*? ?*sni_servername*?
: Note: this form of the command is deprecated, since TLS options had to be specified with a combination of parameters to this command (*cafile*, *certfile*, *keyfile*, *verify_cert* and *sni_servername*) and arguments to **::tls::init** (from package **tls**). Prefer the above form (without specific TLS arguments) and set TLS options with **::ldap::tlsoptions**. Start TLS negotiation on the connection denoted by *handle*. You need to set at least the *cafile* argument to a file with trusted certificates, if *verify_cert* is 1, which is the default. The *sni_servername* can be used to signal a different hostname during the TLS handshake. The announced protocols are determined in the same way as **::ldap::secure_connect**. You can specify a TLS client certificate with the *certfile* and *keyfile* options.

**::ldap::bind** *handle* ?*name*? ?*password*?
: This command authenticates the ldap connection refered to by the token in *handle*, with a user name and associated password. It blocks until a response from the ldap server arrives. Its result is the empty string. Both *name* and *passwd* default to the empty string if they are not specified. By leaving out *name* and *passwd* you can make an anonymous bind to the ldap server. You can issue **::ldap::bind** again to bind with different credentials.

**::ldap::bindSASL** *handle* ?*name*? ?*password*?
: This command uses SASL authentication mechanisms to do a multistage bind. Its otherwise identical to the standard **::ldap::bind**. This feature is currently experimental and subject to change. See the documentation for the **SASL** and the "*SASL.txt*" in the tcllib CVS repository for details how to setup and use SASL with openldap.

**::ldap::unbind** *handle*
: This command asks the ldap server to release the last bind done for the connection refered to by the token in *handle*. The *handle* is invalid after the unbind, as the server closes the connection. So this is effectivly just a more polite disconnect operation.

**::ldap::search** *handle* *baseObject* *filterString* *attributes* *options*
: This command performs a LDAP search below the *baseObject* tree using a complex LDAP search expression *filterString* and returns the specified *attributes* of all matching objects (DNs). If the list of *attributes* was empty all attributes are returned. The command blocks until it has received all results. The valid *options* are identical to the options listed for **::ldap::searchInit**. An example of a search expression is


```
    set filterString "|(cn=Linus*)(sn=Torvalds*)"
```

The return value of the command is a list of nested dictionaries. The first level keys are object identifiers (DNs), second levels keys are attribute names. In other words, it is in the form

```
    {dn1 {attr1 {val11 val12 ...} attr2 {val21...} ...}} {dn2 {a1 {v11 ...} ...}} ...
```

**::ldap::searchInit** *handle* *baseObject* *filterString* *attributes* *options*
: This command initiates a LDAP search below the *baseObject* tree using a complex LDAP search expression *filterString*. The search gets the specified *attributes* of all matching objects (DNs). The command itself just starts the search, to retrieve the actual results, use **::ldap::searchNext**. A search can be terminated at any time by **::ldap::searchEnd**. This informs the server that no further results should be sent by sending and ABANDON message and cleans up the internal state of the search. Only one **::ldap::search** can be active at a given time, this includes the introspection commands **::ldap::info saslmechanisms**, **ldap::info control** and **ldap::info extensions**, which invoke a search internally. Error responses from the server due to wrong arguments or similar things are returned with the first **::ldap::searchNext** call and should be checked and dealed with there. If the list of requested *attributes* is empty all attributes will be returned. The parameter *options* specifies the options to be used in the search, and has the following format:


```
    {-option1 value1 -option2 value2 ... }
```

Following options are available:

**-scope** base one sub
: Control the scope of the search to be one of **base**, **one**, or **sub**,  to  specify  a  base object,  one-level or  subtree  search.   The  default is **sub**.

**-derefaliases** never search find always
: Control how aliases dereferencing is done.  Should be one of **never**, **always**, **search**,  or  **find**  to specify that aliases are never dereferenced, always dereferenced, dereferenced when searching, or dereferenced only when locating the base object for the search. The default is to never dereference aliases.

**-sizelimit** num
: Determines the maximum number of entries to return in a search. If specified as 0 no limit is enforced. The server may enforce a configuration dependent sizelimit, which may be lower than the one given by this option. The default is 0, no limit.

**-timelimit** seconds
: Asks the server to use a timelimit of *seconds* for the search. Zero means no limit. The default is 0, no limit.

**-attrsonly** boolean
: If set to 1 only the attribute names but not the values will be present in the search result. The default is to retrieve attribute names and values.

**-referencevar** varname
: If set the search result reference LDAPURIs, if any, are returned in the given variable. The caller can than decide to follow those references and query other LDAP servers for further results.


**::ldap::searchNext** *handle*
: This command returns the next entry from a LDAP search initiated by **::ldap::searchInit**. It returns only after a new result is received or when no further results are available, but takes care to keep the event loop alive. The returned entry is a list with two elements: the first is the DN of the entry, the second is the list of attributes and values, under the format:


```
    dn {attr1 {val11 val12 ...} attr2 {val21...} ...}
```

The **::ldap::searchNext** command returns an empty list at the end of the search.

**::ldap::searchEnd** *handle*
: This command terminates a LDAP search initiated by **::ldap::searchInit**. It also cleans up the internal state so a new search can be initiated. If the client has not yet received all results, the client sends an ABANDON message to inform the server that no further results for the previous search should to be sent.

**::ldap::modify** *handle* *dn* *attrValToReplace* ?*attrToDelete*? ?*attrValToAdd*?
: This command modifies the object *dn* on the ldap server we are connected to via *handle*. It replaces attributes with new values, deletes attributes, and adds new attributes with new values. All arguments are dictionaries mapping attribute names to values. The optional arguments default to the empty dictionary, which means that no attributes will be deleted nor added.


dictionary *attrValToReplace* (in)
: No attributes will be changed if this argument is empty. The dictionary contains the new attributes and their values. They *replace all* attributes known to the object.

dictionary *attrToDelete* (in)
: No attributes will be deleted if this argument is empty. The dictionary values are restrictions on the deletion. An attribute listed here will be deleted if and only if its current value at the server matches the value specified in the dictionary, or if the value in the dictionary is the empty string.

dictionary *attrValToAdd* (in)
: No attributes will be added if this argument is empty. The dictionary values are the values for the new attributes.


The command blocks until all modifications have completed. Its result is the empty string.

**::ldap::modifyMulti** *handle* *dn* *attrValToReplace* ?*attrValToDelete*? ?*attrValToAdd*?
: This command modifies the object *dn* on the ldap server we are connected to via *handle*. It replaces attributes with new values, deletes attributes, and adds new attributes with new values. All arguments are lists with the format:


```
    attr1 {val11 val12 ...} attr2 {val21...} ...
```

where each value list may be empty for deleting all attributes. The optional arguments default to empty lists of attributes to delete and to add.

list *attrValToReplace* (in)
: No attributes will be changed if this argument is empty. The dictionary contains the new attributes and their values. They *replace all* attributes known to the object.

list *attrValToDelete* (in)
: No attributes will be deleted if this argument is empty. If no value is specified, the whole set of values for an attribute will be deleted.

list *attrValToAdd* (in)
: No attributes will be added if this argument is empty.


The command blocks until all modifications have completed. Its result is the empty string.

**::ldap::add** *handle* *dn* *attrValueTuples*
: This command creates a new object using the specified *dn*. The attributes of the new object are set to the values in the list *attrValueTuples*. Multiple valuated attributes may be specified using multiple tuples. The command blocks until the operation has completed. Its result is the empty string.

**::ldap::addMulti** *handle* *dn* *attrValueTuples*
: This command is the preferred one to create a new object using the specified *dn*. The attributes of the new object are set to the values in the dictionary *attrValueTuples* (which is keyed by the attribute names). Each tuple is a list containing multiple values. The command blocks until the operation has completed. Its result is the empty string.

**::ldap::delete** *handle* *dn*
: This command removes the object specified by *dn*, and all its attributes from the server. The command blocks until the operation has completed. Its result is the empty string.

**::ldap::modifyDN** *handle* *dn* *newrdn* ?*deleteOld*? ?*newSuperior*?
: This command moves or copies the object specified by *dn* to a new location in the tree of object. This location is specified by *newrdn*, a *relative* designation, or by *newrdn* and *newSuperior*, a *absolute* designation. The optional argument *deleteOld* defaults to **true**, i.e. a move operation. If *deleteOld* is not set, then the operation will create a copy of *dn* in the new location. The optional argument *newSuperior* defaults an empty string, meaning that the object must not be relocated in another branch of the tree. If this argument is given, the argument *deleteOld* must be specified also. The command blocks until the operation has completed. Its result is the empty string.

**::ldap::info** **ip** *handle*
: This command returns the IP address of the remote LDAP server the handle is connected to.

**::ldap::info** **bound** *handle*
: This command returns 1 if a handle has successfully completed a **::ldap::bind**. If no bind was done or it failed, a 0 is returned.

**::ldap::info** **bounduser** *handle*
: This command returns the username used in the bind operation if a handle has successfully completed a **::ldap::bind**. If no bound was done or it failed, an empty string is returned.

**::ldap::info** **connections**
: This command returns all currently existing ldap connection handles.

**::ldap::info** **tls** *handle*
: This command returns 1 if the ldap connection *handle* used TLS/SSL for connection via **ldap::secure_connect** or completed **ldap::starttls**, 0 otherwise.

**::ldap::info** **tlsstatus** *handle*
: This command returns the current security status of an TLS secured channel. The result is a list of key-value pairs describing the connected peer (see the **TLS** package documentation for the returned values). If the connection is not secured with TLS, an empty list is returned.

**::ldap::info** **saslmechanisms** *handle*
: Return the supported SASL mechanisms advertised by the server. Only valid in a bound state (anonymous or other).

**::ldap::info** **control** *handle*
: Return the supported controls advertised by the server as a list of OIDs. Only valid in a bound state. This is currently experimental and subject to change.

**::ldap::info** **extensions** *extensions*
: Returns the supported LDAP extensions as list of OIDs. Only valid in a bound state. This is currently experimental and subject to change.

**::ldap::info** **whoami** *handle*
: Returns authzId for the current connection. This implements the RFC 4532 protocol extension.


# Examples

A small example, extracted from the test application coming with this code.

```
    package require ldap

    # Connect, bind, add a new object, modify it in various ways

    set handle [ldap::connect localhost 9009]

    set dn "cn=Manager, o=University of Michigan, c=US"
    set pw secret

    ldap::bind $handle $dn $pw

    set dn "cn=Test User,ou=People,o=University of Michigan,c=US"

    ldap::add $handle $dn {
	objectClass     OpenLDAPperson
	cn              {Test User}
	mail            test.user@google.com
	uid             testuid
	sn              User
	telephoneNumber +31415926535
	telephoneNumber +27182818285
    }

    set dn "cn=Another User,ou=People,o=University of Michigan,c=US"

    ldap::addMulti $handle $dn {
	objectClass     {OpenLDAPperson}
	cn              {{Anotther User}}
	mail            {test.user@google.com}
	uid             {testuid}
	sn              {User}
	telephoneNumber {+31415926535 +27182818285}
    }

    # Replace all attributes
    ldap::modify $handle $dn [list drink icetea uid JOLO]

    # Add some more
    ldap::modify $handle $dn {} {} [list drink water  drink orangeJuice pager "+1 313 555 7671"]

    # Delete
    ldap::modify $handle $dn {} [list drink water  pager ""]

    # Move
    ldap::modifyDN $handle $dn "cn=Tester"

    # Kill the test object, and shut the connection down.
    set dn "cn=Tester,ou=People,o=University of Michigan,c=US"
    ldap::delete $handle $dn

    ldap::unbind     $handle
    ldap::disconnect $handle
```

And another example, a simple query, and processing the results.

```
    package require ldap
    set handle [ldap::connect ldap.acme.com 389]
    ldap::bind $handle
    set results [ldap::search $handle "o=acme,dc=com" "(uid=jdoe)" {}]
    foreach result $results {
	foreach {object attributes} $result break

	# The processing here is similar to what 'parray' does.
	# I.e. finding the longest attribute name and then
	# generating properly aligned output listing all attributes
	# and their values.

	set width 0
	set sortedAttribs {}
	foreach {type values} $attributes {
	    if {[string length $type] > $width} {
		set width [string length $type]
	    }
	    lappend sortedAttribs [list $type $values]
	}

	puts "object='$object'"

	foreach sortedAttrib  $sortedAttribs {
	    foreach {type values} $sortedAttrib break
	    foreach value $values {
		regsub -all "\[\x01-\x1f\]" $value ? value
		puts [format "  %-${width}s %s" $type $value]
	    }
	}
	puts ""
    }
    ldap::unbind $handle
    ldap::disconnect $handle
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *ldap* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
Copyright (c) 2006 Michael Schlenker <mic42@users.sourceforge.net>
```
