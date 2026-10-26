---
CommandName: rest
title: rest
ManualSection: n
Version: 1.7
TclPart: tcllib
TclDescription: A framework for RESTful web services
Copyright:
---

# Name

rest - define REST web APIs and call them inline or asychronously

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [rest]{.lit} [1.7]{.optlit}
[::rest::simple]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg}
[::rest::get]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg}
[::rest::post]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg}
[::rest::patch]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg}
[::rest::head]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg}
[::rest::put]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg}
[::rest::delete]{.cmd} [url]{.arg} [query]{.arg} [config]{.optarg} [body]{.optarg}
[::rest::save]{.cmd} [name]{.arg} [file]{.arg}
[::rest::describe]{.cmd} [name]{.arg}
[::rest::parameters]{.cmd} [url]{.arg} [key]{.optarg}
[::rest::parse\_opts]{.cmd} [static]{.arg} [required]{.arg} [optional]{.arg} [words]{.arg}
[::rest::substitute]{.cmd} [string]{.arg} [var]{.arg}
[::rest::create\_interface]{.cmd} [name]{.arg}
:::

# Description

There are two types of usage this package supports: *simple calls*, and complete *interfaces*. In an *interface* you specify a set of rules and then the package builds the commands which correspond to the REST methods. These commands can have many options such as input and output transformations and data type specific formatting. This results in a cleaner and simpler script. On the other hand, while a *simple call* is easier and quicker to implement it is also less featureful. It takes the url and a few options about the command and returns the result directly. Any formatting or checking is up to rest of the script.

# Simple usage

In simple usage you make calls using the http method procedures and then check or process the returned data yourself

**::rest::simple** *url* *query* ?*config*? ?*body*?
: see below ...

**::rest::get** *url* *query* ?*config*? ?*body*?
: see below ...

**::rest::post** *url* *query* ?*config*? ?*body*?
: see below ...

**::rest::patch** *url* *query* ?*config*? ?*body*?
: see below ...

**::rest::head** *url* *query* ?*config*? ?*body*?
: see below ...

**::rest::put** *url* *query* ?*config*? ?*body*?
: see below ...

**::rest::delete** *url* *query* ?*config*? ?*body*?
: These commands are all equivalent except for the http method used. If you use **simple** then the method should be specified as an option in the *config* dictionary. If that is not done it defaults to **get**. If a *body* is needed then the *config* dictionary must be present, however it is allowed to be empty.

    The *config* dictionary supports the following keys

    - **auth**
    - **content-type**
    - **cookie**
    - **error-body**
    - **format**
    - **headers**
    - **method**
    - **timeout**


    Two quick examples:

    Example 1, Yahoo Boss:

    ```
        set appid APPID
        set search tcl
        set res [rest::get http://boss.yahooapis.com/ysearch/web/v1/$search [list appid $appid]]
        set res [rest::format_json $res]
    ```

    Example 2, Twitter:

    ```
        set url   http://twitter.com/statuses/update.json
        set query [list status $text]
        set res [rest::simple $url $query {
            method post
            auth   {basic user password}
            format json
        }]
    ```


# Interface usage

An interface to a REST API consists of a series of definitions of REST calls contained in an array. The name of that array becomes a namespace containing the defined commands. Each key of the array specifies the name of the call, with the associated configuration a dictionary, i.e. key/value pairs. The acceptable keys, i.e. legal configuration options are described below. After creating the definitions in the array simply calling **rest::create\_interface** with the array as argument will then create the desired commands.

Example, Yahoo Weather:

```
    package require rest

    set yweather(forecast) {
       url      http://weather.yahooapis.com/forecastrss
       req_args { p: }
       opt_args { u: }
    }
    rest::create_interface yweather
    puts [yweather::forecast -p 94089]
```

**::rest::save** *name* *file*
: This command saves a copy of the dynamically created procedures for all the API calls specified in the array variable *name* to the *file*, for later loading.

    The result of the command is the empty string

**::rest::describe** *name*
: This command prints a description of all API calls specified in the array variable *name* to the channel **stdout**.

    The result of the command is the empty string.

**::rest::parameters** *url* ?*key*?
: This command parses an *url* query string into a dictionary and returns said dictionary as its result.

    If *key* is specified the command will not return the entire dictionary, but only the value of that *key*.

**::rest::parse\_opts** *static* *required* *optional* *words*
: This command implements a custom parserfor command options.

    dict *static*
    : A dictionary of options and their values that are always present in the output.

    list *required*
    : A list of options that must be supplied by *words*

    list *optional*
    : A list of options that may appear in the *words*, but are not required. The elements must be in one of three forms:

        name
        : The option may be present or not, no default.

        name:
        : When present the option requires an argument.

        name:value
        : When not present use **value** as default.


    list *words*
    : The words to parse into options and values.


    The result of the command is a list containing two elements. The first element is a dictionary containing the parsed options and their values.  The second element is a list of the remaining words.

**::rest::substitute** *string* *var*
: This command takes a *string*, substitutes values for any option identifiers found inside and returns the modified string as its results.

    The values to substitute are found in the variable *var*, which is expected to contain a dictionary mapping from the option identifiers to replace to their values. *Note* that option identifiers which have no key in *var* are replaced with the empty string.

    The option identifiers in *string* have to follow the syntax **%...%** where **...** may contain any combination of lower-case alphanumeric characters, plus underscore, colon and dash.

**::rest::create\_interface** *name*
: This command creates procedures for all the API calls specified in the array variable *name*.

    The name of that array becomes a namespace containing the defined commands. Each key of the array specifies the name of the call, with the associated configuration a dictionary, i.e. key/value pairs. The legal keys and their meanings are:

    **url**
    : The value of this *required* option must be the target of the http request.

    **description**
    : The value of this option must be a short string describing the call. Default to the empty string, if not specified. Used only by **::rest::describe**.

    **body**
    : The value of this option indicates if arguments are required for the call's request body or not. The acceptable values are listed below. Defaults to **optional** if not specified.

        **none**
        : The call has no request body, none must be supplied.

        **optional**
        : A request body can be supplied, but is not required.

        **required**
        : A request body must be supplied.

        **argument**
        : This value must be followed by the name of an option, treating the entire string as a list. The request body will be used as the value of that option.

        **mime\_multipart**
        : A request body must be supplied and will be interpreted as each argument representing one part of a mime/multipart document. Arguments must be lists containing 2 elements, a list of header keys and values, and the mime part body, in this order.

        **mime\_multipart/<value>**
        : Same as mime\_multipart, but the **Content-Type** header is set to **multipart/<value>**.


    **method**
    : The value of this option must be the name of the HTTP method to call on the url. Defaults to GET, if not specified. The acceptable values are **GET**, **POST**, and **PUT**, regardless of letter-case.

    **copy**
    : When present the value of this option specifies the name of a previously defined call. The definition of that call is copied to the current call, except for the options specified by the current call itself.

    **unset**
    : When present the value of this option contains a list of options in the current call. These options are removed from the definition. Use this after **copy**ing an existing definition to remove options, instead of overriding their value.

    **headers**
    : Specification of additional header fields. The value of this option must be a dictionary, interpreted to contain the new header fields and their values. The default is to not add any additional headers.

    **content-type**
    : The value of this option specifies the content type for the request data.

    **req\_args**
    : The value of this option is a list naming the required arguments of the call.  Names ending in a colon will require a value.

    **opt\_args**
    : The value of this option a list naming the arguments that may be present for a call but are not required.

    **static\_args**
    : The value of this option a list naming the arguments that are always the same.  No sense in troubling the user with these.  A leading dash (**-**) is allowed but not required to maintain consistency with the command line.

    **auth**
    : The value of this option specifies how to authenticate the calls. No authentication is done if the option is not specified.

        **basic**
        : The user may configure the *basic authentication* by overriding the procedure **basic\_auth** in the namespace of interface. This procedure takes two arguments, the username and password, in this order.

        **bearer**
        : The user may configure a bearer token as authentication. The value is the token passed to the HTTP authorization header.

        **sign**
        : The value must actually be a list with the second element the name of a procedure which will be called to perform request signing.


    **callback**
    : If this option is present then the method will be created as an *async* call. Such calls will return immediately with the value of the associated http token instead of the call's result. The event loop must be active to use this option.

        The value of this option is treated as a command prefix which is invoked when the HTTP call is complete. The prefix will receive at least two additional arguments, the name of the calling procedure and the status of the result (one of **OK** or **ERROR**), in this order.

        In case of **OK** a third argument is added, the data associated with the result.

        If and only if the **ERROR** is a redirection, the location redirected to will be added as argument. Further, if the configuration key **error-body** is set to **true** the data associated with the result will be added as argument as well.

        The http request header will be available in that procedure via **upvar token token**.

    **cookie**
    : The value of this option is a list of cookies to be passed in the http header. This is a shortcut to the **headers** option.

    **input\_transform**
    : The value of this option is a command prefix or script to perform a transformation on the query before invoking the call. A script transform is wrapped into an automatically generated internal procedure.

        If not specified no transformation is done.

        The command (prefix) must accept a single argument, the query (a dictionary) to transform, and must return the modified query (again as dictionary) as its result. The request body is accessible in the transform command via **upvar body body**.

    **format**
    : see below ...

    **result**
    : The value of this option specifies the format of the returned data. Defaults to **auto** if not specified. The acceptable values are:

        **auto**
        : Auto detect between **xml** and **json**.

        **discard**
        : see below ...

        **json**
        : see below ...

        **raw**
        : see below ...

        **rss**
        : This is formatted as a special case of **xml**.


        - **tdom**
        - **xml**


    **pre\_transform**
    : The value of this option is a command prefix or script to perform a transformation on the result of a call (*before* the application of the output transform as per **format**). A script transform is wrapped into an automatically generated internal procedure.

        If not specified no transformation is done.

        The command (prefix) must accept a single argument, the result to transform, and must return the modified result as its result.

        The http request header is accessible in the transform command via **upvar token token**

    **post\_transform**
    : The value of this option is a command prefix or script to perform a transformation on the result of a call (*after* the application of the output transform as per **format**). A script transform is wrapped into an automatically generated internal procedure.

        If not specified no transformation is done.

        The command (prefix) must accept a single argument, the result to transform, and must return the modified result as its result.

        The http request header is accessible in the transform command via **upvar token token**

    **check\_result**
    : The value of this option must be list of two expressions, either of which may be empty.

        The first expression is checks the OK condition, it must return **true** when the result is satisfactory, and **false** otherwise.

        The second expression is the ERROR condition, it must return **false** unless there is an error, then it has to return **true**.

    **error\_body**
    : The value of this option determines whether to return the response when encountering an HTTP error, or not. The default is to not return the response body on error.

        See **callback** above for more information.

    **timeout**
    : The value of this option determines whether to set a timeout on the HTTP call. By default, no timeout is set.

        Timeout value is accepted in milliseconds.



# Examples

Yahoo Geo:

```
set ygeo(parse) {
    url http://wherein.yahooapis.com/v1/document
    method post
    body { arg documentContent }
}
ygeo::parse "san jose ca"
# "san jose ca" will be interpreted as if it were specified as the -documentContent option
```

Google Docs:

```
set gdocs(upload) {
    url http://docs.google.com/feeds/default/private/full
    body mime_multipart
}
gdocs::upload [list {Content-Type application/atom+xml} $xml] [list {Content-Type image/jpeg} $filedata]
```

Delicious:

```
set delicious(updated) {
    url https://api.del.icio.us/v1/posts/update
    auth basic
}

rest::create_interface flickr

flickr::basic_auth username password
```

Flickr:

```
set flickr(auth.getToken) {
   url http://api.flickr.com/services/rest/
   req_args { api_key: secret: }
   auth { sign do_signature }
}

rest::create_interface flickr

proc ::flickr::do_signature {query} {
    # perform some operations on the query here
    return $query
}
```

# Included

The package provides functional but incomplete implementations for the following services:

- **del.icio.us**
- **facebook**
- **flickr**
- **twitter**
- **google calendar**
- **yahoo boss**
- **yahoo weather**


Please either read the package's implementation, or use **rest::describe** after loading it for their details.

Do not forget developers' documentation on the respective sites either.

# Tls

The **rest** package can be used with *https*-secured services, by requiring the [Tls] package and then registering it with the **http** package it is sitting on top of. Example

```
    package require tls
    http::register https 443 ::tls::socket
```

# Tls security considerations

This package uses the [Tls] package to handle the security for **https** urls and other socket connections.

Policy decisions like the set of protocols to support and what ciphers to use are not the responsibility of [Tls], nor of this package itself however. Such decisions are the responsibility of whichever application is using the package, and are likely influenced by the set of servers the application will talk to as well.

For example, in light of the recent [POODLE attack](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) discovered by Google many servers will disable support for the SSLv3 protocol. To handle this change the applications using [Tls] must be patched, and not this package, nor [Tls] itself. Such a patch may be as simple as generally activating **tls1** support, as shown in the example below.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *rest* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.
