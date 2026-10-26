---
CommandName: tclhttpd
ManualSection: 1
Version: unknown
TclPart: TclPro
TclDescription: TclPro Applications
Keywords:
 - Web Server
 - HTTP
 - TclHttpd
Copyright:
 - Copyright (c) 1998-2000 by Ajuba Solutions
 - All rights reserved.
---

# Name

tclhttpd - Tcl Web Server

# Synopsis

::: {.synopsis} :::
[tclsh]{.cmd} [httpd.tcl]{.sub} [options]{.optarg} 
:::

# Options

**-help**
: Displays usage information, then exit without doing anything.

**-config** *filename*
: Name of the configuration file (e.g. tclpro/bin/tclhttpd.rc).

**-main** *filename*
: Name of the per-thread main script (e.g. tclpro/bin/httpdthread.tcl).

**-docRoot** *directory*
: The root directory of your web pages (e.g., tclpro/tclhttpd/htdocs).

**-port** *value*
: HTTP listening port.  Defaults to 8015.

**-host** *value*
: The hostname for the HTTP listening socket.

**-ipaddr** *value*
: Interface the server should bind to.

**-webmaster** *email*
: Email contact for webmaster.

**-uid** *userid*
: User name or ID for server process user ID.

**-gid** *groupid*
: Group name or ID for server process group ID.

**-threads** *num*
: Run with *num* worker threads. Requires a thread safe Tcl shell.

**-library** *directory*
: Directory to add to the auto_path.

**-verbose**
: Causes extra print statements during startup.


# Description

TclHttpd is a simple, extensible, embeddable Web Server. The best source of documentation is in HTML distributed with the server.

To start the server, simply run the httpd.tcl script with *tclsh* or *wish*. For example, this starts the server on the standard Web server port, 80. tclsh \<installdir>/bin/httpd.tcl -port 80 Note that you must start the server as root if you use port numbers less than 1024 on UNIX systems.  If you want the server process to run under a different user than root, which is strongly recommended, then use the **-uid** and **-gid** options.  This way the server can start as root, open the socket, and then switch to a less privileged account.

# Configuration and customization

The main script depends on a per-thread Tcl script, httpdthread.tcl, and a configuration file, tclhttpd.rc. These have configuration settings and the start up code for the web server.

The configuration file can be used to set the port, user ID, and other values described in the Options list above. You can configure additional features such as log file location, and more, by editting the configuration file. There is an explanation about each option, so you can make a copy of the configuration file and try out new settings.

```
tclsh httpd.tcl -config myserver.rc
```

If you plan to extend Tcl Httpd with your own code, you may need to add initialization code to bin/httpd.tcl and bin/httpdthread.tcl.  This code is typically a "package require" for your module and one or two calls to initialize it. For example, this code the httpdthread.tcl enables a /debug URL implementation that lets you examine the state of the server.

```
package require httpd::debug
Debug_Url /debug Debug
```

The web server should have access to any Tcl package installed along with your Tcl installation.  Consult the on-line HTML documentation for a more indepth discussion of programming the server.

# Web page templates

TclHttpd supports a flexible template system that embeds Tcl code into your HTML pages.  The Web Server processes the Tcl, which typically generates bits and pieces of your HTML page, and delivers the result to the client transparently.  You can cache the results of processing your templates, or you can have pages that are processed dynamically on each access.

Any page that ends in ".tml" is treated like an HTML+Tcl template page. The Web Server uses the Tcl **subst** command to replace commands within brackets, \[ and \], and variable references, like \$Phone, with their value.  Backslash processing is also done. The main thing you need to watch out for is putting literal dollar amounts in your templates.  You'll need to protect your \$ with a backslash:

```
The price is \$10.00.
```

The ".tml" files in the sample htdocs directory structure should give you examples to work from.

Try to limit the Tcl code in your pages to simple procedure calls, and put the procedure definitions in per-directory files named ".tml".  The name of this file is confusing: each directory can contain a file named "dot-t-m-l" (.tml) that should contain Tcl code. These files are automatically loaded before any templates in that directory (or subdirectories) is processed.

For example, first create a new directory of the htdocs directory that comes with TclHttpd.

```
mkdir htdocs/mystuff
```

Next, put the following into htdocs/mystuff/.tml

```
package require htmlutils

# A procedure to format the date the way you like it
proc MyDate {{seconds {}}} {
    if {[string length $seconds] == 0} {
	set seconds [clock seconds]
    }
    return [clock format $seconds -format "%B %m, %Y"]
}
# Some page settings
set bgcolor pink
```

Now, any page in the htdocs/mystuff directory can use the **MyDate** procedure in a template. Finally, put the following into htodcs/mystuff/index.tml

```
<title>My Stuff</title>
<body text=black bgcolor=$bgcolor>
<h2>My Stuff</h2>
[MyDate]
<br>
Page content here.
<p>
Send email to [Mailto [Doc_Webmaster]].
```

The **bgcolor** variable is set in the .tml file and used in the BODY tag. The **Mailto** is part of the **htmlutils** package that was required by the .tml file. The **Doc_Webmaster** procedure is built into TclHttpd. The MyDate procedure was added by you, and is shared by any page in or below the htdocs/mystuff directory.
