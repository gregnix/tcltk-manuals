---
CommandName: autoproxy
ManualSection: n
Version: 1.8.1
TclPart: tcllib
TclDescription: HTTP protocol helper modules
Links:
 - http(n)
Keywords:
 - authentication
 - http
 - proxy
Copyright:
---

# Name

autoproxy - Automatic HTTP proxy usage and authentication

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [http]{.lit} [2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [autoproxy]{.lit} [1.8.1]{.optlit} 
[::autoproxy::init]{.cmd} 
[::autoproxy::cget]{.cmd} [-option]{.arg} 
[::autoproxy::configure]{.cmd} [-option value]{.optarg} 
[::autoproxy::tls_connect]{.cmd} [args]{.arg} 
[::autoproxy::tunnel_connect]{.cmd} [args]{.arg} 
[::autoproxy::tls_socket]{.cmd} [args]{.arg} 
:::

# Description

This package attempts to automate the use of HTTP proxy servers in Tcl HTTP client code. It tries to initialize the web access settings from system standard locations and can be configured to negotiate authentication with the proxy if required.

On Unix the standard for identifying the local HTTP proxy server seems to be to use the environment variable http_proxy or ftp_proxy and no_proxy to list those domains to be excluded from proxying. On Windows we can retrieve the Internet Settings values from the registry to obtain pretty much the same information. With this information we can setup a suitable filter procedure for the Tcl http package and arrange for automatic use of the proxy.

There seem to be a number of ways that the http_proxy environment variable may be set up. Either a plain host:port or more commonly a URL and sometimes the URL may contain authentication parameters or these may be requested from the user or provided via http_proxy_user and http_proxy_pass. This package attempts to deal with all these schemes. It will do it's best to get the required parameters from the environment or registry and if it fails can be reconfigured.

# Tls security considerations

*Note* This section only applies if TLS support is provided by the **TLS** package. It does not apply when **autoproxy** was configured to use some other package which can provide the same (i.e **twapi**), via the **-tls_package** configuration option.

This package uses the **TLS** package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of **TLS**, nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using **TLS** must be patched, and not this package, nor **TLS** itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Commands

**::autoproxy::init**
: Initialize the autoproxy package from system resources. Under unix this means we look for environment variables. Under windows we look for the same environment variables but also look at the registry settings used by Internet Explorer.

**::autoproxy::cget** *-option*
: Retrieve individual package configuration options. See **OPTIONS**.

**::autoproxy::configure** ?-option *value*?
: Configure the autoproxy package. Calling **configure** with no options will return a list of all option names and values. See **OPTIONS**.

**::autoproxy::tls_connect** *args*
: Connect to a secure socket through a proxy. HTTP proxy servers permit the use of the CONNECT HTTP command to open a link through the proxy to the target machine. This function hides the details. For use with the http package see **tls_socket**. The *args* list may contain any of the options supported by the specific TLS package that is in use but must end with the host and port as the last two items.

**::autoproxy::tunnel_connect** *args*
: Connect to a target host throught a proxy. This uses the same CONNECT HTTP command as the **tls_connect** but does not promote the link security once the connection is established. The *args* list may contain any of the options supported by the specific TLS package that is in use but must end with the host and port as the last two items. Note that many proxy servers will permit CONNECT calls to a limited set of ports - typically only port 443 (the secure HTTP port).

**::autoproxy::tls_socket** *args*
: This function is to be used to register a proxy-aware secure socket handler for the https protocol. It may only be used with the Tcl http package and should be registered using the http::register command (see the examples below). The job of actually creating the tunnelled connection is done by the tls_connect command and this may be used when not registering with the http package.


# Options

**-host** hostname
: ...see next...

**-proxy_host** hostname
: Set the proxy hostname. This is normally set up by **init** but may be configured here as well.

**-port** number
: ...see next...

**-proxy_port** number
: Set the proxy port number. This is normally set up by **init**. e.g. **configure** **-port** *3128*

**-no_proxy** list
: You may manipulate the **no_proxy** list that was setup by **init**. The value of this option is a tcl list of strings that are matched against the http request host using the tcl **string match** command. Therefore glob patterns are permitted. For instance, **configure** **-no_proxy** *\*.localdomain*

**-authProc** procedure
: This option may be used to set an application defined procedure to be called when **configure** **-basic** is called with either no or insufficient authentication details. This can be used to present a dialog to the user to request the additional information.

**-basic**
: Following options are for configuring the Basic authentication scheme parameters. See **Basic Authentication**. To unset the proxy authentication information retained from a previous call of this function either "--" or no additional parameters can be supplied. This will remove the existing authentication information.

**-tls_package** packagename
: This option may be used to configure the Tcl package to use for TLS support. Valid package names are **tls** (default) and **twapi**.


# Basic authentication

Basic is the simplest and most commonly use HTTP proxy authentication scheme. It is described in (1 section 11) and also in (2). It offers no privacy whatsoever and its use should be discouraged in favour of more secure alternatives like Digest. To perform Basic authentication the client base64 encodes the username and plaintext password separated by a colon. This encoded text is prefixed with the word "Basic" and a space.

The following options exists for this scheme:

**-username** name
: The username required to authenticate with the configured proxy.

**-password** password
: The password required for the username specified.

**-realm** realm
: This option is not used by this package but may be used in requesting authentication details from the user.

**--**
: The end-of-options indicator may be used alone to unset any authentication details currently enabled.


# Examples

```
package require autoproxy
autoproxy::init
autoproxy::configure -basic -username ME -password SEKRET
set tok [http::geturl http://wiki.tcl.tk/]
http::data $tok
```

```
package require http
package require tls
package require autoproxy
autoproxy::init
http::register https 443 autoproxy::tls_socket
set tok [http::geturl https://www.example.com/]
```

# References

**\[1\]**
: Berners-Lee, T., Fielding R. and Frystyk, H. "Hypertext Transfer Protocol -- HTTP/1.0", RFC 1945, May 1996, (*http://www.rfc-editor.org/rfc/rfc1945.txt*)

**\[2\]**
: Franks, J. et al. "HTTP Authentication: Basic and Digest Access Authentication", RFC 2617, June 1999 (*http://www.rfc-editor.org/rfc/rfc2617.txt*)


# Bugs

At this time only Basic authentication (1) (2) is supported. It is planned to add support for Digest (2) and NTLM in the future.

# Authors

Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *http :: autoproxy* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking
