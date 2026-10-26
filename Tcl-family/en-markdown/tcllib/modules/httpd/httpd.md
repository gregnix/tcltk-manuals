---
CommandName: httpd
ManualSection: n
Version: 4.3.6
TclPart: tcllib
TclDescription: Tcl Web Server
Keywords:
 - TclOO
 - WWW
 - http
 - httpd
 - httpserver
 - services
Copyright:
 - Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
---

# Name

httpd - A TclOO and coroutine based web server

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uuid]{.lit} 
[package]{.cmd} [require]{.sub} [clay]{.lit} 
[package]{.cmd} [require]{.sub} [coroutine]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::filetype]{.lit} 
[package]{.cmd} [require]{.sub} [websocket]{.lit} 
[package]{.cmd} [require]{.sub} [mime]{.lit} 
[package]{.cmd} [require]{.sub} [cron]{.lit} 
[package]{.cmd} [require]{.sub} [uri]{.lit} 
[package]{.cmd} [require]{.sub} [Markdown]{.lit} 
:::

method **ChannelCopy** *in* *out* ?*args*?

method **html_header** ?*title* ? ?*args*?

method **html_footer** ?*args*?

method **http_code_string** *code*

method **HttpHeaders** *sock* ?*debug* ?

method **HttpHeaders_Default**

method **HttpServerHeaders**

method **MimeParse** *mimetext*

method **Url_Decode** *data*

method **Url_PathCheck** *urlsuffix*

method **wait** *mode* *sock*

variable **ChannelRegister**

variable **reply**

variable **request**

delegate **\<server>**

method **constructor** *ServerObj* ?*args*?

method **destructor** ?*dictargs*?

method **ChannelRegister** ?*args*?

method **close**

method **Log_Dispatched**

method **dispatch** *newsock* *datastate*

method **Dispatch**

method **html_header** *title* ?*args*?

method **html_footer** ?*args*?

method **error** *code* ?*msg* ? ?*errorInfo* ?

method **content**

method **EncodeStatus** *status*

method **log** *type* ?*info* ?

method **CoroName**

method **DoOutput**

method **FormData**

method **PostData** *length*

method **Session_Load**

method **puts** *line*

method **RequestFind** *field*

method **request** *subcommand* ?*args*?

method **reply** *subcommand* ?*args*?

method **reset**

method **timeOutCheck**

method **timestamp**

variable **template**

variable **url_patterns**

method **constructor** *args* ?*port* **auto**? ?*myaddr* **127.0.0.1**? ?*string* **auto**? ?*name* **auto**? ?*doc_root* ? ?*reverse_dns* **0**? ?*configuration_file* ? ?*protocol* **HTTP/1.1**?

method **destructor** ?*dictargs*?

method **connect** *sock* *ip* *port*

method **ServerHeaders** *ip* *http_request* *mimetxt*

method **Connect** *uuid* *sock* *ip*

method **counter** *which*

method **CheckTimeout**

method **debug** ?*args*?

method **dispatch** *data*

method **Dispatch_Default** *reply*

method **Dispatch_Local** *data*

method **Headers_Local** *varname*

method **Headers_Process** *varname*

method **HostName** *ipaddr*

method **log** ?*args*?

method **plugin** *slot* ?*class* ?

method **port_listening**

method **PrefixNormalize** *prefix*

method **source** *filename*

method **start**

method **stop**

method **SubObject {} db**

method **SubObject {} default**

method **template** *page*

method **TemplateSearch** *page*

method **Thread_start**

method **Uuid_Generate**

method **Validate_Connection** *sock* *ip*

method **reset**

method **content**

method **Dispatch**

method **content**

method **FileName**

method **DirectoryListing** *local_file*

method **content**

method **Dispatch**

variable **exename**

method **CgiExec** *execname* *script* *arglist*

method **Cgi_Executable** *script*

method **proxy_channel**

method **proxy_path**

method **ProxyRequest** *chana* *chanb*

method **ProxyReply** *chana* *chanb* ?*args*?

method **Dispatch**

method **FileName**

method **proxy_channel**

method **ProxyRequest** *chana* *chanb*

method **ProxyReply** *chana* *chanb* ?*args*?

method **DirectoryListing** *local_file*

method **EncodeStatus** *status*

method **scgi_info**

method **proxy_channel**

method **ProxyRequest** *chana* *chanb*

method **ProxyReply** *chana* *chanb* ?*args*?

method **debug** ?*args*?

method **Connect** *uuid* *sock* *ip*

method **Dispatch_Dict** *data*

method **uri {} add** *vhosts* *patterns* *info*

method **uri {} direct** *vhosts* *patterns* *info* *body*

method **output**

method **DoOutput**

method **close**

method **local_memchan** *command* ?*args*?

method **Connect_Local** *uuid* *sock* ?*args*?

# Description

This module implements a web server suitable for embedding in an application. The server is object oriented, and contains all fundamentals needed for a full service website.

# Minimal example

Starting a web service requires starting a class of type **httpd::server**, and providing that server with one or more URIs to service, and **httpd::reply** derived classes to generate them.

```
package require httpd

oo::class create ::reply.hello {
  method content {} {
    my puts "<HTML><HEAD><TITLE>IRM Dispatch Server</TITLE></HEAD><BODY>"
    my puts "<h1>Hello World!</h1>"
    my puts </BODY></HTML>
  }
}
::httpd::server create HTTPD port 8015 myaddr 127.0.0.1 doc_root [file home]/htdocs
HTTPD plugin dispatch ::httpd::plugin.dict_dispatch
HTTPD uri add * /hello [list mixin reply.hello]
vwait forever
```

The bare module has facilities to host files from a file system. Files that end in a **.tml** will be substituted in the style of Tclhttpd:

```
<!-- hello.tml -->
[my html_header {Hello World!}]
Your Server is running.
<p>
The time is now [clock format [clock seconds]]
[my html_footer]
```

A complete httpd server example in the Tcllib’s /examples directory. This also shows how to dispatch URIs to other processes via SCGI and HTTP proxies.

```
cd ~/tcl/sandbox/tcllib
tclsh examples/httpd.tcl
```

# Classes

## Class  httpd::mime

A metaclass for MIME handling behavior across a live socket

**Methods**

method **ChannelCopy** *in* *out* ?*args*?
: ...see next...

method **html_header** ?*title* ? ?*args*?
: Returns a block of HTML

method **html_footer** ?*args*?
: ...see next...

method **http_code_string** *code*
: ...see next...

method **HttpHeaders** *sock* ?*debug* ?
: ...see next...

method **HttpHeaders_Default**
: ...see next...

method **HttpServerHeaders**
: ...see next...

method **MimeParse** *mimetext*
: Converts a block of mime encoded text to a key/value list. If an exception is encountered, the method will generate its own call to the **error** method, and immediately invoke the **output** method to produce an error code and close the connection.

method **Url_Decode** *data*
: De-httpizes a string.

method **Url_PathCheck** *urlsuffix*
: ...see next...

method **wait** *mode* *sock*
: 


## Class  httpd::reply

*ancestors*: **httpd::mime**

A class which shephards a request through the process of generating a reply. The socket associated with the reply is available at all times as the *chan* variable. The process of generating a reply begins with an **httpd::server** generating a **http::class** object, mixing in a set of behaviors and then invoking the reply object's **dispatch** method. In normal operations the **dispatch** method:

**\[1\]**
: Invokes the **reset** method for the object to populate default headers.

**\[2\]**
: Invokes the **HttpHeaders** method to stream the MIME headers out of the socket

**\[3\]**
: Invokes the **request parse** method to convert the stream of MIME headers into a dict that can be read via the **request** method.

**\[4\]**
: Stores the raw stream of MIME headers in the *rawrequest* variable of the object.

**\[5\]**
: Invokes the **content** method for the object, generating an call to the **error** method if an exception is raised.

**\[6\]**
: Invokes the **output** method for the object Developers have the option of streaming output to a buffer via the **puts** method of the reply, or simply populating the *reply_body* variable of the object. The information returned by the **content** method is not interpreted in any way. If an exception is thrown (via the **error** command in Tcl, for example) the caller will auto-generate a 500 {Internal Error} message. A typical implementation of **content** look like:


```
 clay::define ::test::content.file {
 	superclass ::httpd::content.file
 	# Return a file
 	# Note: this is using the content.file mixin which looks for the reply_file variable
 	# and will auto-compute the Content-Type
 	method content {} {
 	  my reset
     set doc_root [my request get DOCUMENT_ROOT]
     my variable reply_file
     set reply_file [file join $doc_root index.html]
 	}
 }
 clay::define ::test::content.time {
   # return the current system time
 	method content {} {
 		my variable reply_body
     my reply set Content-Type text/plain
 		set reply_body [clock seconds]
 	}
 }
 clay::define ::test::content.echo {
 	method content {} {
 		my variable reply_body
     my reply set Content-Type [my request get CONTENT_TYPE]
 		set reply_body [my PostData [my request get CONTENT_LENGTH]]
 	}
 }
 clay::define ::test::content.form_handler {
 	method content {} {
 	  set form [my FormData]
 	  my reply set Content-Type {text/html; charset=UTF-8}
     my puts [my html_header {My Dynamic Page}]
     my puts "<BODY>"
     my puts "You Sent<p>"
     my puts "<TABLE>"
     foreach {f v} $form {
       my puts "<TR><TH>$f</TH><TD><verbatim>$v</verbatim></TD>"
     }
     my puts "</TABLE><p>"
     my puts "Send some info:<p>"
     my puts "<FORM action=/[my request get REQUEST_PATH] method POST>"
     my puts "<TABLE>"
     foreach field {name rank serial_number} {
       set line "<TR><TH>$field</TH><TD><input name=\"$field\" "
       if {[dict exists $form $field]} {
         append line " value=\"[dict get $form $field]\"""
       }
       append line " /></TD></TR>"
       my puts $line
     }
     my puts "</TABLE>"
     my puts [my html footer]
 	}
 }
```

**Variable**

variable **ChannelRegister**
: ...see next...

variable **reply**
: A dictionary which will converted into the MIME headers of the reply

variable **request**
: A dictionary containing the SCGI transformed HTTP headers for the request **Delegate**

delegate **\<server>**
: The server object which spawned this reply **Methods**

method **constructor** *ServerObj* ?*args*?
: ...see next...

method **destructor** ?*dictargs*?
: clean up on exit

method **ChannelRegister** ?*args*?
: Registers a channel to be closed by the close method

method **close**
: Close channels opened by this object

method **Log_Dispatched**
: Record a dispatch event

method **dispatch** *newsock* *datastate*
: Accept the handoff from the server object of the socket *newsock* and feed it the state *datastate*. Fields the *datastate* are looking for in particular are: \* **mixin** - A key/value list of slots and classes to be mixed into the object prior to invoking **Dispatch**. \* **http** - A key/value list of values to populate the object's *request* ensemble All other fields are passed along to the **clay** structure of the object.

method **Dispatch**
: ...see next...

method **html_header** *title* ?*args*?
: ...see next...

method **html_footer** ?*args*?
: ...see next...

method **error** *code* ?*msg* ? ?*errorInfo* ?
: ...see next...

method **content**
: REPLACE ME: This method is the "meat" of your application. It writes to the result buffer via the "puts" method and can tweak the headers via "clay put header_reply"

method **EncodeStatus** *status*
: Formulate a standard HTTP status header from he string provided.

method **log** *type* ?*info* ?
: ...see next...

method **CoroName**
: ...see next...

method **DoOutput**
: Generates the the HTTP reply, streams that reply back across *chan*, and destroys the object.

method **FormData**
: For GET requests, converts the QUERY_DATA header into a key/value list. For POST requests, reads the Post data and converts that information to a key/value list for application/x-www-form-urlencoded posts. For multipart posts, it composites all of the MIME headers of the post to a singular key/value list, and provides MIME\_\* information as computed by the **mime** package, including the MIME_TOKEN, which can be fed back into the mime package to read out the contents.

method **PostData** *length*
: Stream *length* bytes from the *chan* socket, but only of the request is a POST or PUSH. Returns an empty string otherwise.

method **Session_Load**
: Manage session data

method **puts** *line*
: Appends the value of *string* to the end of *reply_body*, as well as a trailing newline character.

method **RequestFind** *field*
: ...see next...

method **request** *subcommand* ?*args*?
: ...see next...

method **reply** *subcommand* ?*args*?
: ...see next...

method **reset**
: Clear the contents of the *reply_body* variable, and reset all headers in the **reply** structure back to the defaults for this object.

method **timeOutCheck**
: Called from the **http::server** object which spawned this reply. Checks to see if too much time has elapsed while waiting for data or generating a reply, and issues a timeout error to the request if it has, as well as destroy the object and close the *chan* socket.

method **timestamp**
: Return the current system time in the format:


```
%a, %d %b %Y %T %Z
```

## Class  httpd::server

*ancestors*: **httpd::mime**

**Variable**

variable **template**
: ...see next...

variable **url_patterns**
: **Methods**

method **constructor** *args* ?*port* **auto**? ?*myaddr* **127.0.0.1**? ?*string* **auto**? ?*name* **auto**? ?*doc_root* ? ?*reverse_dns* **0**? ?*configuration_file* ? ?*protocol* **HTTP/1.1**?
: ...see next...

method **destructor** ?*dictargs*?
: ...see next...

method **connect** *sock* *ip* *port*
: Reply to an open socket. This method builds a coroutine to manage the remainder of the connection. The coroutine's operations are driven by the **Connect** method.

method **ServerHeaders** *ip* *http_request* *mimetxt*
: ...see next...

method **Connect** *uuid* *sock* *ip*
: This method reads HTTP headers, and then consults the **dispatch** method to determine if the request is valid, and/or what kind of reply to generate. Under normal cases, an object of class **::http::reply** is created, and that class's **dispatch** method. This action passes control of the socket to the reply object. The reply object manages the rest of the transaction, including closing the socket.

method **counter** *which*
: Increment an internal counter.

method **CheckTimeout**
: Check open connections for a time out event.

method **debug** ?*args*?
: ...see next...

method **dispatch** *data*
: Given a key/value list of information, return a data structure describing how the server should reply.

method **Dispatch_Default** *reply*
: Method dispatch method of last resort before returning a 404 NOT FOUND error. The default behavior is to look for a file in *DOCUMENT_ROOT* which matches the query.

method **Dispatch_Local** *data*
: Method dispatch method invoked prior to invoking methods implemented by plugins. If this method returns a non-empty dictionary, that structure will be passed to the reply. The default is an empty implementation.

method **Headers_Local** *varname*
: Introspect and possibly modify a data structure destined for a reply. This method is invoked before invoking Header methods implemented by plugins. The default implementation is empty.

method **Headers_Process** *varname*
: Introspect and possibly modify a data structure destined for a reply. This method is built dynamically by the **plugin** method.

method **HostName** *ipaddr*
: Convert an ip address to a host name. If the server/ reverse_dns flag is false, this method simply returns the IP address back. Internally, this method uses the *dns* module from tcllib.

method **log** ?*args*?
: Log an event. The input for args is free form. This method is intended to be replaced by the user, and is a noop for a stock http::server object.

method **plugin** *slot* ?*class* ?
: Incorporate behaviors from a plugin. This method dynamically rebuilds the **Dispatch** and **Headers** method. For every plugin, the server looks for the following entries in *clay plugin/*: *load* - A script to invoke in the server's namespace during the **plugin** method invokation. *dispatch* - A script to stitch into the server's **Dispatch** method. *headers* - A script to stitch into the server's **Headers** method. *thread* - A script to stitch into the server's **Thread_start** method.

method **port_listening**
: Return the actual port that httpd is listening on.

method **PrefixNormalize** *prefix*
: For the stock version, trim trailing /'s and \*'s from a prefix. This method can be replaced by the end user to perform any other transformations needed for the application.

method **source** *filename*
: ...see next...

method **start**
: Open the socket listener.

method **stop**
: Shut off the socket listener, and destroy any pending replies.

method **SubObject {} db**
: ...see next...

method **SubObject {} default**
: ...see next...

method **template** *page*
: Return a template for the string *page*

method **TemplateSearch** *page*
: Perform a search for the template that best matches *page*. This can include local file searches, in-memory structures, or even database lookups. The stock implementation simply looks for files with a .tml or .html extension in the ?doc_root? directory.

method **Thread_start**
: Built by the **plugin** method. Called by the **start** method. Intended to allow plugins to spawn worker threads.

method **Uuid_Generate**
: Generate a GUUID. Used to ensure every request has a unique ID. The default implementation is:


```
   return [::clay::uuid generate]
```

method **Validate_Connection** *sock* *ip*
: Given a socket and an ip address, return true if this connection should be terminated, or false if it should be allowed to continue. The stock implementation always returns 0. This is intended for applications to be able to implement black lists and/or provide security based on IP address.


## Class  httpd::server::dispatch

*ancestors*: **httpd::server**

Provide a backward compadible alias

## Class  httpd::content.redirect

**Methods**

method **reset**
: ...see next...

method **content**
: 


## Class  httpd::content.cache

**Methods**

method **Dispatch**
: 


## Class  httpd::content.template

**Methods**

method **content**
: 


## Class  httpd::content.file

Class to deliver Static content When utilized, this class is fed a local filename by the dispatcher

**Methods**

method **FileName**
: ...see next...

method **DirectoryListing** *local_file*
: ...see next...

method **content**
: ...see next...

method **Dispatch**
: 


## Class  httpd::content.exec

**Variable**

variable **exename**
: **Methods**

method **CgiExec** *execname* *script* *arglist*
: ...see next...

method **Cgi_Executable** *script*
: 


## Class  httpd::content.proxy

*ancestors*: **httpd::content.exec**

Return data from an proxy process

**Methods**

method **proxy_channel**
: ...see next...

method **proxy_path**
: ...see next...

method **ProxyRequest** *chana* *chanb*
: ...see next...

method **ProxyReply** *chana* *chanb* ?*args*?
: ...see next...

method **Dispatch**
: 


## Class  httpd::content.cgi

*ancestors*: **httpd::content.proxy**

**Methods**

method **FileName**
: ...see next...

method **proxy_channel**
: ...see next...

method **ProxyRequest** *chana* *chanb*
: ...see next...

method **ProxyReply** *chana* *chanb* ?*args*?
: ...see next...

method **DirectoryListing** *local_file*
: For most CGI applications a directory list is vorboten


## Class  httpd::protocol.scgi

Return data from an SCGI process

**Methods**

method **EncodeStatus** *status*
: 


## Class  httpd::content.scgi

*ancestors*: **httpd::content.proxy**

**Methods**

method **scgi_info**
: ...see next...

method **proxy_channel**
: ...see next...

method **ProxyRequest** *chana* *chanb*
: ...see next...

method **ProxyReply** *chana* *chanb* ?*args*?
: 


## Class  httpd::server.scgi

*ancestors*: **httpd::server**

Act as an  SCGI Server

**Methods**

method **debug** ?*args*?
: ...see next...

method **Connect** *uuid* *sock* *ip*
: 


## Class  httpd::content.websocket

Upgrade a connection to a websocket

## Class  httpd::plugin

httpd plugin template

## Class  httpd::plugin.dict_dispatch

A rudimentary plugin that dispatches URLs from a dict data structure

**Methods**

method **Dispatch_Dict** *data*
: Implementation of the dispatcher

method **uri {} add** *vhosts* *patterns* *info*
: ...see next...

method **uri {} direct** *vhosts* *patterns* *info* *body*
: 


## Class  httpd::reply.memchan

*ancestors*: **httpd::reply**

**Methods**

method **output**
: ...see next...

method **DoOutput**
: ...see next...

method **close**
: 


## Class  httpd::plugin.local_memchan

**Methods**

method **local_memchan** *command* ?*args*?
: ...see next...

method **Connect_Local** *uuid* *sock* ?*args*?
: A modified connection method that passes simple GET request to an object and pulls data directly from the reply_body data variable in the object Needed because memchan is bidirectional, and we can't seem to communicate that the server is one side of the link and the reply is another


# Authors

Sean Woods

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *network* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Networking

# Copyright

```
Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
```
