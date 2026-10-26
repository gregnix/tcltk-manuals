---
CommandName: ntp_time
ManualSection: n
Version: 1.2.2
TclPart: tcllib
TclDescription: Network Time Facilities
Links:
 - ntp
Keywords:
 - NTP
 - SNTP
 - rfc 2030
 - rfc 868
 - time
Copyright:
 - Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

ntp_time - Tcl Time Service Client

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [time]{.lit} [1.2.2]{.optlit} 
[::time::gettime]{.cmd} [options]{.optarg} [timeserver]{.arg} [port]{.optarg} 
[::time::getsntp]{.cmd} [options]{.optarg} [timeserver]{.arg} [port]{.optarg} 
[::time::configure]{.cmd} [options]{.optarg} 
[::time::cget]{.cmd} [name]{.arg} 
[::time::unixtime]{.cmd} [token]{.arg} 
[::time::status]{.cmd} [token]{.arg} 
[::time::error]{.cmd} [token]{.arg} 
[::time::reset]{.cmd} [token]{.arg} [reason]{.optarg} 
[::time::wait]{.cmd} [token]{.arg} 
[::time::cleanup]{.cmd} [token]{.arg} 
:::

# Description

This package implements a client for the RFC 868 TIME protocol (*http://www.rfc-editor.org/rfc/rfc868.txt*) and also a minimal client for the RFC 2030 Simple Network Time Protocol (*http://www.rfc-editor.org/rfc/rfc2030.txt*). RFC 868 returns the time in seconds since 1 January 1900 to either tcp or udp clients. RFC 2030 also gives this time but also provides a fractional part which is not used in this client.

# Commands

**::time::gettime** ?*options*? *timeserver* ?*port*?
: Get the time from *timeserver*. You may specify any of the options listed for the **configure** command here. This command returns a token which must then be used with the remaining commands in this package. Once you have finished, you should use **cleanup** to release all resources. The default port is **37**.

**::time::getsntp** ?*options*? *timeserver* ?*port*?
: Get the time from an SNTP server. This accepts exactly the same arguments as **::time::gettime** except that the default port is **123**. The result is a token as per **::time::gettime** and should be handled in the same way. Note that it is unlikely that any SNTP server will reply using tcp so you will require the **tcludp** or the **ceptcl** package. If a suitable package can be loaded then the udp protocol will be used by default.

**::time::configure** ?*options*?
: Called with no arguments this command returns all the current configuration options and values. Otherwise it should be called with pairs of option name and value.


**-protocol** *number*
: Set the default network protocol. This defaults to udp if the tcludp package is available. Otherwise it will use tcp.

**-port** *number*
: Set the default port to use. RFC 868 uses port **37**, RFC 2030 uses port **123**.

**-timeout** *number*
: Set the default timeout value in milliseconds. The default is 10 seconds.

**-command** *number*
: Set a command procedure to be run when a reply is received. The procedure is called with the time token appended to the argument list.

**-loglevel** *number*
: Set the logging level. The default is 'warning'.


**::time::cget** *name*
: Get the current value for the named configuration option.

**::time::unixtime** *token*
: Format the returned time for the unix epoch. RFC 868 time defines time 0 as 1 Jan 1900, while unix time defines time 0 as 1 Jan 1970. This command converts the reply to unix time.

**::time::status** *token*
: Returns the status flag. For a successfully completed query this will be *ok*. May be *error* or *timeout* or *eof*. See also **::time::error**

**::time::error** *token*
: Returns the error message provided for requests whose status is *error*. If there is no error message then an empty string is returned.

**::time::reset** *token* *?reason?*
: Reset or cancel the query optionally specfying the reason to record for the **error** command.

**::time::wait** *token*
: Wait for a query to complete and return the status upon completion.

**::time::cleanup** *token*
: Remove all state variables associated with the request.


```
% set tok [::time::gettime ntp2a.mcc.ac.uk]
% set t [::time::unixtime $tok]
% ::time::cleanup $tok
```

```
% set tok [::time::getsntp pool.ntp.org]
% set t [::time::unixtime $tok]
% ::time::cleanup $tok
```

```
proc on_time {token} {
   if {[time::status $token] eq "ok"} {
      puts [clock format [time::unixtime $token]]
   } else {
      puts [time::error $token]
   }
   time::cleanup $token
}
time::getsntp -command on_time pool.ntp.org
```

# Authors

Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *ntp* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
```
