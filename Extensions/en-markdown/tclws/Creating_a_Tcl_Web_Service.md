# Creating a Tcl Web Service

## Contents

- [1 Loading the Webservices Server Package](#loading-the-webservices-server-package) 
- [2 Defining a Service](#defining-a-service) 
- [3 Defining an Operation (aka a Service Procedure)](#defining-an-operation-aka-a-service-procedure) 
- [4 Declaring Complex Types](#declaring-complex-types) 

## Loading the Webservices Server Package 

To load the webservices server package, do: 

```
 package require WS::Server
```

This command will only load the server the first time it is used, so it causes no ill effects to put this in each file declaring a service or service procedure. 

### Using as part of TclHttpd

 The Web Services package, WS::Server, is not a standalone application, but rather is designed to be a "module" of TclHttpd. The following command is normally placed in httpdthread.tcl: 

### Embedding in a Standalone Application

 To embed a Web Service into an application, the application needs to be event driven and you also need to use the **WS::Embeded** package. You also must define the service with the *-mode=embedded* option. 

 See also [Embedding a Web Service into an application](Embedded_Web_Service.md). 

### Using with Apache Rivet

 [Apache Rivet](http://tcl.apache.org/rivet/) is a module (mod_rivet) that can be loaded by Apache httpd server to allow web pages to run embedded Tcl commands in a way similar to PHP. To create a Web Service in Rivet, use the example EchoRivetService.rvt as a starting point by simply copying it into any directory served by your Apache instance. You should be able to immediately access that new location at the following URLs: 

```
               /path/to/EchoRivetService.rvt/doc
                     Displays an HTML page describing the service
               /path/to/EchoRivetService.rvt/wsdl
                     Returns a WSDL describing the service
               /path/to/EchoRivetService.rvt/op
                     Invoke an operation
```

 If you would prefer to expose the published URLs of your service differently, you can use the standard Apache mod_rewrite or mod_alias modules to transparently map any other URL to those locations. 

---

## Defining a Service 

 The code that defines a service is normally placed in one or more files in the custom directory. 

**Procedure Name : ::WS::Server::Service** 

**Description** : Declare a Web Service, the following URLs will exist 

```
               /service/<ServiceName>
                     Displays an HTML page describing the service
               /service/<ServiceName>/wsdl
                     Returns a WSDL describing the service
               /service/<ServiceName>/op
                     Invoke an operation
```

**Arguments** : this procedure uses position independent arguments, they are: 

```
             -hostcompatibility32 bool - Activate version 3.2.0 compatibility
                               mode for -host parameter.
                               Defaults to true.
             -host           - The host specification within XML namespaces
                               of the transmitted XML files.
                               This should be unique.
                               Defaults to localhost.
                               If 3.2 compatibility is activated, the default
                               value is changed to ip:port in embedded mode.
             -hostlocation   - The host name, which is promoted within the
                               generated WSDL file. Defaults to localhost.
                               If 3.2 compatibility is activated, the
                               default value is equal to the -host parameter.
             -hostlocationserver bool - If true, the host location is set by
                               the current server settings.
                               In case of httpd server, this value is imported.
                               For other servers or if this fails, the value
                               is the current ip:port.
                               The default value is true.
                               In case of 3.2 compatibility, the default
                               value is true for tclhttpd, false otherwise.
             -hostProtocol   - Define the host protocol (http, https) for the
                               WSDL location URL. The special value "server"
                               (default) follows the TCP/IP server specification.
                               This is implemented for Embedded server and tclhttpd.
                               Remark that the protocol for XML namespaces
                               is always "http".
             -description    - The HTML description for this service
             -htmlhead       - The title string of the service description
             -author         - The author property in the service description
             -xmlnamespace   - Extra XML namespaces used by the service
             -service        - The service name (this will also be used for
                                 the Tcl namespace of the procedures that implement
                                 the operations.
             -premonitor     - This is a command prefix to be called before
                                 an operation is called.  The following arguments are
                                 added to the command prefix:
                                    PRE serviceName operationName operArgList
             -postmonitor    - This is a command prefix to be called after
                                 an operation is called.  The following arguments are
                                 added to the command prefix:
                                    POST serviceName operationName OK|ERROR results
             -inheaders      - List of input header types.
             -outheaders     - List of output header types.
             -intransform    - Inbound (request) transform procedure (2.0.3 and later).
                                The signature of the command must be:
                                     cmd \
                                         mode (REQUEST) \
                                         xml \
                                         notUsed_1 \
                                         notUsed_2
             -outtransform   - Outbound (reply) transform procedure (2.0.3 and later).
                                The signature of the command must be:
                                     cmd \
                                         mode (REPLY) \
                                         xml \
                                         operation \
                                         resultDict
             -checkheader    - Command prefix to check headers.
                                   If the call is not to be allowed, this command
                                   should raise an error.
                                   The signature of the command must be:
                                     cmd \
                                         service \
                                         operation \
                                         caller_ipaddr \
                                         http_header_list \
                                         soap_header_list
            -mode           - Mode that service is running in.  Must be one of:
                                   tclhttpd  -- running inside of tclhttpd or an
                                                environment that supplies a
                                                compatible Url_PrefixInstall
                                                and Httpd_ReturnData commands
                                   embedded  -- using the ::WS::Embedded package
                                   aolserver -- using the ::WS::AolServer package
                                   wub       -- using the ::WS::Wub package
                                   wibble    -- running inside wibble
                                   rivet     -- running inside Apache Rivet (mod_rivet)
            -ports          - List of ports for embedded mode. Default: 80
                                    NOTE -- a call should be to
                                            ::WS::Embedded::Listen for each port
                                            in this list prior to calling ::WS::Embeded::Start
            -prefix         - Path prefix used for the namespace and endpoint
                              Defaults to "/service/" plus the service name
            -traceEnabled   - Boolean to enable/disable trace being passed back in exception
                              Defaults to "Y"
            -docFormat      - Format of the documentation for operations ("text" or "html").
                              Defaults to "text"
            -stylesheet     - The CSS stylesheet URL used in the HTML documentation

            -errorCallback  - Callback to be invoked in the event of an error being produced
            -verifyUserArgs - Boolean to enable/disable validating user supplied arguments
                              Defaults to "N"
            -enforceRequired - Throw an error if a required field is not included in the
                               response.
                               Defaults to "N"
```

**Returns** : Nothing 

**Side-Effects** : None 

**Exception Conditions** : 

```
     MISSREQARG -- Missing required arguments
```

**Pre-requisite Conditions** : None 

---

## Defining an Operation (aka a Service Procedure) 

**Procedure Name : ::WS::Server::ServiceProc** 

**Description** : Register an operation for a service and declare the procedure to handle the operations. 

**Arguments** : 

```
     ServiceName     -- Name of the service this operation is for
     NameInfo        -- List of two elements:
                             1) OperationName -- the name of the operation
                             2) ReturnType    -- the type of the procedure return,
                                                 this can be a simple or complex type
     Arglist         -- List of argument definitions,
                         each list element must be of the form:
                             1) ArgumentName -- the name of the argument
                             2) ArgumentTypeInfo -- -- A list of:
                                    {type typeName comment commentString}
                                         typeName can be any simple or defined type.
                                         commentString is a quoted string describing the field
     Documentation   -- HTML describing what this operation does
     Body            -- The tcl code to be called when the operation is invoked. This
                            code should return a dictionary with <OperationName>Result as a
                            key and the operation's result as the value.
```

Available simple types are:

- anyType, string, boolean, decimal, float, double, duration, dateTime, time, date, gYearMonth, gYear, gMonthDay, gDay, gMonth, hexBinary, base64Binary, anyURI, QName, NOTATION, normalizedString, token, language, NMTOKEN, NMTOKENS, Name, NCName, ID, IDREF, IDREFS, ENTITY, ENTITIES, integer, nonPositiveInteger, negativeInteger, long, int, short, byte, nonNegativeInteger, unsignedLong, unsignedInt, unsignedShort, unsignedByte, positiveInteger

The

typeName

may contain the following suffixes:

- *()* : type is an array
- *?* : type is an optional parameter

**Returns** : Nothing 

*Side-Effects* : 

```
   A procedure named "<ServiceName>::<OperationName>" defined
   A type name with the name <OperationName>Result is defined.
```

*Exception Conditions* : None 

*Pre-requisite Conditions* : ::WS::Server::Server must have been called for the ServiceName 

---

## Declaring Complex Types 

See: [Creating a Web Service Type from Tcl](Creating_a_Web_Service_Type.md)
