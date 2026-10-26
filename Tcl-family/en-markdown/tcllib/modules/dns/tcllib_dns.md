---
CommandName: dns
title: dns
ManualSection: n
Version: 1.6.1
TclPart: tcllib
TclDescription: Domain Name Service
Links:
 - resolver(5)
Keywords:
 - DNS
 - domain name service
 - resolver
 - rfc 1034
 - rfc 1035
 - rfc 1886
 - rfc 7858
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# Name

dns - Tcl Domain Name Service Client

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [dns]{.lit} [1.6.1]{.optlit}
[::dns::resolve]{.cmd} [query]{.arg} [options]{.optarg}
[::dns::configure]{.cmd} [options]{.optarg}
[::dns::name]{.cmd} [token]{.arg}
[::dns::address]{.cmd} [token]{.arg}
[::dns::cname]{.cmd} [token]{.arg}
[::dns::result]{.cmd} [token]{.arg}
[::dns::status]{.cmd} [token]{.arg}
[::dns::error]{.cmd} [token]{.arg}
[::dns::reset]{.cmd} [token]{.arg}
[::dns::wait]{.cmd} [token]{.arg}
[::dns::cleanup]{.cmd} [token]{.arg}
[::dns::nameservers]{.cmd}
:::

# Description

The dns package provides a Tcl only Domain Name Service client. You should refer to (1) and (2) for information about the DNS protocol or read resolver(3) to find out how the C library resolves domain names. The intention of this package is to insulate Tcl scripts from problems with using the system library resolver for slow name servers. It may or may not be of practical use. Internet name resolution is a complex business and DNS is only one part of the resolver. You may find you are supposed to be using hosts files, NIS or WINS to name a few other systems. This package is not a substitute for the C library resolver - it does however implement name resolution over DNS. The package also extends the package **uri** to support DNS URIs (4) of the form *dns:what.host.com* or *dns://my.nameserver/what.host.com*. The **dns::resolve** command can handle DNS URIs or simple domain names as a query.

*Note:* The package defaults to using DNS over TCP connections. If you wish to use UDP you will need to have the **tcludp** package installed and have a version that correctly handles binary data (> 1.0.4). This is available at <http://tcludp.sourceforge.net/>. If the **udp** package is present then UDP will be used by default.

*Note:* The package supports DNS over TLS (RFC 7858) for enhanced privacy of DNS queries. Using this feature requires the TLS package.

# Commands

**::dns::resolve** *query* ?*options*?
: Resolve a domain name using the *DNS* protocol. *query* is the domain name to be lookup up. This should be either a fully qualified domain name or a DNS URI.

    **-nameserver** *hostname* or **-server** *hostname*
    : Specify an alternative name server for this request.

    **-protocol** *tcp|udp*
    : Specify the network protocol to use for this request. Can be one of *tcp* or *udp*.

    **-port** *portnum*
    : Specify an alternative port.

    **-search** *domainlist*
    : see below ...

    **-timeout** *milliseconds*
    : Override the default timeout.

    **-type** *TYPE*
    : Specify the type of DNS record you are interested in. Valid values are A, NS, MD, MF, CNAME, SOA, MB, MG, MR, NULL, WKS, PTR, HINFO, MINFO, MX, TXT, SPF, SRV, AAAA, AXFR, MAILB, MAILA and \*. See RFC1035 for details about the return values. See <http://spf.pobox.com/> about SPF. See (3) about AAAA records and RFC2782 for details of SRV records.

    **-class** *CLASS*
    : Specify the class of domain name. This is usually IN but may be one of IN for internet domain names, CS, CH, HS or \* for any class.

    **-recurse** *boolean*
    : Set to *false* if you do not want the name server to recursively act upon your request. Normally set to *true*.

    **-command** *procname*
    : Set a procedure to be called upon request completion. The procedure will be passed the token as its only argument.

    **-usetls** *boolean*
    : Set the *true* to use DNS over TLS. This will force the use of TCP and change the default port to 853. Certificate validation is required so a source of trusted certificate authority certificates must be provided using *-cafile* or *-cadir*.

    **-cafile** *filepath*
    : Specify a file containing a collection of trusted certificate authority certficates. See the **update-ca-certificates** command manual page for details or the **-CAfile** option help from **openssl**.

    **-cadir** *dirpath*
    : Specify a directory containing trusted certificate authority certificates. This must be provided if **-cafile** is not specified for certificate validation to work when **-usetls** is enabled. See the **openssl** documentation for the required structure of this directory.


**::dns::configure** ?*options*?
: The **::dns::configure** command is used to setup the dns package. The server to query, the protocol and domain search path are all set via this command. If no arguments are provided then a list of all the current settings is returned.  If only one argument then it must the the name of an option and the value for that option is returned.

    **-nameserver** *hostname*
    : Set the default name server to be used by all queries. The default is *localhost*.

    **-protocol** *tcp|udp*
    : Set the default network protocol to be used. Default is *tcp*.

    **-port** *portnum*
    : Set the default port to use on the name server. The default is 53.

    **-search** *domainlist*
    : Set the domain search list. This is currently not used.

    **-timeout** *milliseconds*
    : Set the default timeout value for DNS lookups. Default is 30 seconds.

    **-loglevel** *level*
    : Set the log level used for emitting diagnostic messages from this package. The default is *warn*. See the **log** package for details of the available levels.

    **-cafile** *filepath*
    : Set the default file path to be used for the **-cafile** option to **dns::resolve**.

    **-cadir** *dirpath*
    : Set the default directory path to be used for the **-cadir** option to **dns::resolve**.


**::dns::name** *token*
: Returns a list of all domain names returned as an answer to your query.

**::dns::address** *token*
: Returns a list of the address records that match your query.

**::dns::cname** *token*
: Returns a list of canonical names (usually just one) matching your query.

**::dns::result** *token*
: Returns a list of all the decoded answer records provided for your query. This permits you to extract the result for more unusual query types.

**::dns::status** *token*
: Returns the status flag. For a successfully completed query this will be *ok*. May be *error* or *timeout* or *eof*. See also **::dns::error**

**::dns::error** *token*
: Returns the error message provided for requests whose status is *error*. If there is no error message then an empty string is returned.

**::dns::reset** *token*
: Reset or cancel a DNS query.

**::dns::wait** *token*
: Wait for a DNS query to complete and return the status upon completion.

**::dns::cleanup** *token*
: Remove all state variables associated with the request.

**::dns::nameservers**
: Attempts to return a list of the nameservers currently configured for the users system. On a unix machine this parses the /etc/resolv.conf file for nameservers (if it exists) and on Windows systems we examine certain parts of the registry. If no nameserver can be found then the loopback address (127.0.0.1) is used as a default.


# Examples

```
% set tok [dns::resolve www.tcl.tk]
::dns::1
% dns::status $tok
ok
% dns::address $tok
199.175.6.239
% dns::name $tok
www.tcl.tk
% dns::cleanup $tok
```

Using DNS URIs as queries:

```
% set tok [dns::resolve "dns:tcl.tk;type=MX"]
% set tok [dns::resolve "dns://l.root-servers.net/www.tcl.tk"]
```

Reverse address lookup:

```
% set tok [dns::resolve 127.0.0.1]
::dns::1
% dns::name $tok
localhost
% dns::cleanup $tok
```

Using DNS over TLS (RFC 7858):

```
% set tok [dns::resolve www.tcl.tk -nameserver dns-tls.bitwiseshift.net  -usetls 1 -cafile /etc/ssl/certs/ca-certificates.crt]
::dns::12
% dns::wait $tok
ok
% dns::address $tok
104.25.119.118 104.25.120.118
```

# References

1. Mockapetris, P., "Domain Names - Concepts and Facilities", RFC 1034, November 1987. (<http://www.ietf.org/rfc/rfc1034.txt>)

2. Mockapetris, P., "Domain Names - Implementation and Specification", RFC 1035, November 1087. (<http://www.ietf.org/rfc/rfc1035.txt>)

3. Thompson, S. and Huitema, C., "DNS Extensions to support IP version 6", RFC 1886, December 1995. (<http://www.ietf.org/rfc/rfc1886.txt>)

4. Josefsson, S., "Domain Name System Uniform Resource Identifiers", Internet-Draft, October 2003, (<http://www.ietf.org/internet-drafts/draft-josefsson-dns-url-09.txt>)

5. Gulbrandsen, A., Vixie, P. and Esibov, L., "A DNS RR for specifying the location of services (DNS SRV)", RFC 2782, February 2000, (<http://www.ietf.org/rfc/rfc2782.txt>)

6. Ohta, M. "Incremental Zone Transfer in DNS", RFC 1995, August 1996, (<http://www.ietf.org/rfc/rfc1995.txt>)

7. Hu, Z., etc al. "Specification for DNS over Transport Layer Security (TLS)", RFC 7858, May 2016, (<http://www.ietf.org/rfc/rfc7858.txt>)


# Authors

Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *dns* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2002, Pat Thoyts
```
