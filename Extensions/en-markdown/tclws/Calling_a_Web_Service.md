# Calling a Web Service from Tcl

---

## Contents

- [1 Overview](#overview) 
- [2 Loading the Webservices Client Package](#loading-the-webservices-client-package) 
- [3 Quering a remote Web Services Server for its WSDL and parsing it](#quering-a-remote-web-services-server-for-its-wsdl-and-parsing-it) 
- [4 Parsing a saved WSDL](#parsing-a-saved-wsdl) 
- [5 Loading a pre-parsed WSDL](#loading-a-pre-parsed-wsdl) 
- [6 Defining a REST based service by hand](#defining-a-rest-based-service-by-hand) 
- [7 Defining Transforms](#defining-transforms) 
- [8 Synchronous Call returning a dictionary object](#synchronous-call-returning-a-dictionary-object) 
- [9 Asynchronous Call with separate success and error callbacks](#asynchronous-call-with-separate-success-and-error-callbacks) 
- [10 Creation of stub Tcl procedures to make synchronous calls](#creation-of-stub-tcl-procedures-to-make-synchronous-calls) 
- [11 Synchronous Call returning the raw XML](#synchronous-call-returning-the-raw-xml) 
- [12 Configuring Services](#configuring-a-service) 
- [13 Dealing With Casting Abstract Types to Concrete Types](#dealing-with-casting-abstract-types-to-concrete-types) 

 

## Overview 

The Webservices Client package provides a several ways to define what operations a remote Web Services Server provides and how to call those operations. It also includes several ways to call an operation. 

The following ways are provided to define remote operations: 

- Loading a pre-parsed WSDL 
- Quering a remote Web Services Server for its WSDL and parsing it 
- Parsing a saved WSDL 

- Defining a REST based service by hand 

The parsed format is much more compact than the XML of a WSDL. 

The following ways are provided to directly call an operation of a Web Service Server: 

- Synchronous Call returning a dictionary object 
- Synchronous Call returning the raw XML 
- Asynchronous Call with separate success and error callbacks 
- Creation of stub Tcl procedures to make synchronous calls 

This package makes use of the **log** package from **TclLib**. In particular the following levels are used: 

- error/warning -- errors encountered when parsing a WSDL. Actual level depends on options that are set in the **::WS::Utils** package. 
- info -- HTTP calls, including the XML, made to invoke operations and the replies received. *Introduced in 2.2.8.* 
- debug -- detailed internal information. This should only be used if you want to code dive into the TclWs package internals. 

## Loading the Webservices Client Package 

To load the webservices server package, do: 

```
 package require WS::Client
```

This command will only load the utilities the first time it is used, so it causes no ill effects to put this in each file using the utilties. 

---

## Quering a remote Web Services Server for its WSDL and parsing it 

**Procedure Name : ::WS::Client::GetAndParseWsdl** 

**Description : Fetch the WSDL file from the given URL, aprse it and create the service.** 

**Arguments :** 

```
     url     - The url of the WSDL
     headers - Extra headers to add to the HTTP request. This
               is a key value list argument. It must be a list with
               an even number of elements that alternate between
               keys and values. The keys become header field names.
               Newlines are stripped from the values so the header
               cannot be corrupted.
               This is an optional argument and defaults to {}.
     serviceAlias - Alias (unique) name for service.
                    This is an optional argument and defaults to the name of the
                    service in serviceInfo.
     serviceNumber - Number of service within the WSDL to assign the
                     serviceAlias to. Only recognized with a serviceAlias.
                     First service (default) is addressed by value "1".
```

The following example WSDL snipped defines two services:

```
  >definitions ...<
    >service name="service1"<
      ...
    >/service<
    >service name="service1"<
      ...
    >/service<
  >/definitions<
```

Using an empty or no *serviceAlias* would result in the creation of the services "service1" and "service2".

Using *serviceAlias*="SE" and *serviceNumber*=2 would result in the creation of the service "SE" containing the "service2" of the WSDL.

**Returns : The parsed service definition** 

**Side-Effects : None** 

**Exception Conditions : None** 

**Pre-requisite Conditions : None** 

---

## Parsing a saved WSDL 

**Procedure Name : ::WS::Client::ParseWsdl** 

**Description : Parse a WSDL and create the service. Create also the stubs if specified.** 

**Arguments :** 

```
     wsdlXML - XML of the WSDL
```

**Optional Arguments:** 

```
     -createStubs 0|1 - create stub routines for the service
     -headers         - Extra headers to add to the HTTP request. This
                        is a key value list argument. It must be a list with
                        an even number of elements that alternate between
                        keys and values. The keys become header field names.
                        Newlines are stripped from the values so the header
                        cannot be corrupted.
                        This is an optional argument and defaults to {}.
     -serviceAlias    - Alias (unique) name for service.
                        This is an optional argument and defaults to the name of the
                        service in serviceInfo.
     serviceNumber - Number of service within the WSDL to assign the
                     serviceAlias to. Only recognized with a serviceAlias.
                     First service (default) is addressed by value "1".
```

The arguments are position independent.

For an example use of *serviceAlias* and *serviceNumber*, see [the chapter above](#quering-a-remote-web-services-server-for-its-wsdl-and-parsing-it).

**Returns : The parsed service definition** 

**Side-Effects : None** 

**Exception Conditions :None** 

**Pre-requisite Conditions : None** 

---

## Loading a pre-parsed WSDL 

**Procedure Name : ::WS::Client::LoadParsedWsdl** 

**Description : Load a saved service definition in** 

**Arguments :** 

```
     serviceInfo - parsed service definition, as returned from
                   ::WS::Client::ParseWsdl or ::WS::Client::GetAndParseWsdl
     headers     - Extra headers to add to the HTTP request. This
                     is a key value list argument. It must be a list with
                     an even number of elements that alternate between
                     keys and values. The keys become header field names.
                     Newlines are stripped from the values so the header
                     cannot be corrupted.
                     This is an optional argument and defaults to {}.
     serviceAlias - Alias (unique) name for service.
                     This is an optional argument and defaults to the name of the
                     service in serviceInfo.
```

**Returns : The name of the service loaded** 

**Side-Effects : None** 

**Exception Conditions : None** 

**Pre-requisite Conditions : None** 

---

## Defining a REST based service by hand 

### Service Definition

**Procedure Name : ::WS::Client::CreateService** 

**Description : Define a REST service** 

**Arguments :** 

```
     serviceName - Service name to add namespace to
     type        - The type of service, currently only REST is supported.
     url          - URL of namespace.
     args         - Optional arguments:
                            This is an optional argument and defaults to the name of the
                                -header httpHeaderList.
```

**Returns : The local alias (tns)** 

**Side-Effects : None** 

**Exception Conditions : None** 

**Pre-requisite Conditions : None** 

### Method Definition

**Procedure Name : ::WS::Client::DefineRestMethod** 

**Description : Define a method on a REST service** 

**Arguments :** 

```
     serviceName - Service name to add namespace to
     methodName  - The name of the method to add.
     returnType  - The type, if any returned by the procedure.  Format is:
                           xmlTag typeInfo.
     inputArgs   - List of input argument definitions where each argument
                           definition is of the format: name typeInfo.

    where, typeInfo is of the format {type typeName comment commentString}
```

**Returns : The current service definition**  

**Side-Effects : None** 

**Exception Conditions : None** 

**Pre-requisite Conditions : None** 

---

## Defining Transforms 

**Procedure Name : ::WS::Client::SetServiceTransforms** 

**Description : Define a service's transforms** 

```
               Transform signature is:
                   cmd serviceName operationName transformType xml {url {}} {argList {}}
               where transformType is REQUEST or REPLY
               and url and argList will only be present for transformType == REQUEST
```

**Arguments :** 

```
     serviceName  - The name of the Webservice
     inTransform  - Input transform cmd, defaults to {}.
     The inTransform is the proc which allows to transform the SOAP output message, which will be input in the server.
     outTransform - Output transformcmd, defaults to {}.
     The outTransform is the proc which allows to transform the SOAP input message, which is the answer of the server.
```

**Returns : None**

**Side-Effects : None** 

**Exception Conditions : None** 

**Pre-requisite Conditions : Service must have been defined.** 

---

## Synchronous Call returning a dictionary object 

**Procedure Name : ::WS::Client::DoCall** 

**Description : Call an operation of a web service** 

**Arguments :** 

```
     serviceName     - The name of the Webservice
     operationName   - The name of the Operation to call
     argList         - The arguements to the operation as a dictionary object
                       This is for both the Soap Header and Body messages.
     headers         - Extra headers to add to the HTTP request. This
                       is a key value list argument. It must be a list with
                       an even number of elements that alternate between
                       keys and values. The keys become header field names.
                       Newlines are stripped from the values so the header
                       cannot be corrupted.
                       This is an optional argument and defaults to {}.
```

**Returns :** 

```
     The return value of the operation as a dictionary object.
       This includes both the return result and any return headers.
```

**Side-Effects : None** 

**Exception Conditions :** 

```
     WSCLIENT HTTPERROR      - if an HTTP error occured
     others                  - as raised by called Operation
```

**Pre-requisite Conditions : Service must have been defined.** 

---

## Asynchronous Call with separate success and error callbacks 

**Procedure Name : ::WS::Client::DoAsyncCall** 

**Description : Call an operation of a web service asynchronously** 

**Arguments :** 

```
     serviceName     - The name of the Webservice
     operationName   - The name of the Operation to call
     argList         - The arguements to the operation as a dictionary object
                       This is for both the Soap Header and Body messages.
     succesCmd       - A command prefix to be called if the operations
                       does not raise an error.  The results, as a dictionary
                       object are concatinated to the prefix. This includes
                       both the return result and any return headers.  Leave
                       empty to not call any function.

     errorCmd        - A command prefix to be called if the operations
                       raises an error.  The error code, stack trace and
                       error message are concatinated to the prefix.  Leave
                       empty to not call any function.
     headers         - Extra headers to add to the HTTP request. This
                       is a key value list argument. It must be a list with
                       an even number of elements that alternate between
                       keys and values. The keys become header field names.
                       Newlines are stripped from the values so the header
                       cannot be corrupted.
                       This is an optional argument and defaults to {}.
```

**Returns : Nothing.** 

**Side-Effects : None** 

**Exception Conditions :** 

```
     WSCLIENT HTTPERROR      - if an HTTP error occured
     others                  - as raised by called Operation
```

**Pre-requisite Conditions : Service must have been defined.** 

---

## Creation of stub Tcl procedures to make synchronous calls 

**Procedure Name : ::WS::Client::CreateStubs** 

**Description : Create stubs routines to make calls to Webservice Operations.** 

```
             All routines will be create in a namespace that is the same
             as the service name.  The procedure name will be the same
             as the operation name.
```

```
             NOTE -- Webservice arguments are position independent, thus
                     the proc arguments will be defined in alphabetical order.
```

**Arguments :** 

```
     serviceName     - The service to create stubs for
```

**Returns : A string describing the created procedures.** 

**Side-Effects : Existing namespace is deleted.** 

**Exception Conditions : None** 

**Pre-requisite Conditions : Service must have been defined.** 

---

## Synchronous Call returning the raw XML 

**Procedure Name : ::WS::Client::DoRawCall** 

**Description : Call an operation of a web service** 

**Arguments :** 

```
     serviceName     - The name of the Webservice
     operationName   - The name of the Operation to call
     argList         - The arguements to the operation as a dictionary object
                       This is for both the Soap Header and Body messages.
     headers         - Extra headers to add to the HTTP request. This
                       is a key value list argument. It must be a list with
                       an even number of elements that alternate between
                       keys and values. The keys become header field names.
                       Newlines are stripped from the values so the header
                       cannot be corrupted.
                       This is an optional argument and defaults to {}.
```

**Returns :** 

```
     The XML of the operation.
```

**Side-Effects : None** 

**Exception Conditions :** 

```
     WSCLIENT HTTPERROR      - if an HTTP error occured
```

**Pre-requisite Conditions : Service must have been defined.** 

---

## Generating a Template Dictionary

**Procedure Name : ::WS::Utils::GenerateTemplateDict** 

**Description : Generate a template dictionary object for a given type.** 

**Arguments :** 

```
     mode            - The mode, Client or Server
     serviceName     - The name of the Webservice
     type            - The name of the type
     arraySize       - Number of elements to generate in an array.  Default is 2
```

**Returns :** 

```
A dictionary object for a given type.  If any circular references exist, they will have the value of <** Circular Reference **>
Side-Effects : None 
Exception Conditions  : None 
Pre-requisite Conditions : Service must have been defined. 
```

---

## Configuring a Service 

There are two procedures to configure a service:

- ::WS::Client::SetOption
- ::WS::Client::Config

The first procedure contains the default options of the package. The default options are used on service creation and are then copied to the service.

The second procedure contains the options of each service. They are copied on service creation from the default options.

Most option items may be accessed by both functions. Some options are only used on service creation phase, which do not exist as service option. Other options do not exist as default option, as they are initialized from the WSDL file.

In the following, first the two access routines are described. Then, a list of options for both functions are given, with remarks, if they are only valid for one of the two procedures.

**Procedure Name : ::WS::Client::SetOption** 

**Description : Get or set the default options of the package** 

**Arguments :** 

```
     -globalonly   - Return a list of global-only options and their values.
                     Global-only options are not copied to the service.
     -defaultonly  - Return a list of default-only options and their values.
                     default-only options are copied to the service.
     --            - End of options
     item          - The option item to get or configure.
                     Return a list of all item/value pairs if ommitted. 
     value         - The value to set the option item to.
                     Return current value if omitted.
```

**Procedure Name : ::WS::Client::Config** 

**Description : Get or set the options local to a service definition** 

**Arguments :** 

```
     serviceName - The name of the Webservice.
                   Return a list of default items/values paires if not given.
     item        - The option item to get or configure.
                   Return a list of all item/value pairs, if not given. 
     value       - The value to set the option item to.
                   Return current value if omitted.
```

**Option List:** 

- 

  ```
  allowOperOverloading
  ```

  An overloaded operation is an operation with the same name but different may exist with different input parameter sets.

  This option throws an error, if a WSDL is parsed with an overloaded operation.

  Default: 1

- 

  ```
  contentType
  ```

  The http content type of the http request sent to call the web service.  
   Default: "text/xml;charset=utf-8"

- 

  ```
  errorOnRedefine
  ```

  Throw an error, if a service is created (CreateService etc) for an already existing service.

  Default value: 0

  This item may not be used with *::WS::Client::Config*.

- 

  ```
  genOutAttr
  ```

  generate attributes on outbound tags, see [here](Using_Options.md#genoutattr-generate-attributes-on-outbound-tags) for details

- 

  ```
  inlineElementNS
  ```

  Namespace prefixes for types may be defined within the WSDL root element.

  This item may not be used with *::WS::Client::Config*.

  Activate this option, to also search namespace prefixes in the type definition. As those are seen as global prefixes, there might be a double-used prefix which will cause a processing error, if different URI's are assigned.

  The error would be caused by a WSDL as follows

  ```
  	<wsdl:definitions targetNamespace="http://www.webserviceX.NET/"
          xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/
  		xmlns:q1="myURI1"
  		...>
  	    ...
  	    <xs:element xmlns:q1="myURI2" type="q1:MessageQ1"/>
  ```

- 

  ```
  location
  ```

  The URL of the service. This is initialized on the value in the WSDL file, when the WSDL file is parsed. The value may be overwritten setting this option.

  This item may not be used with *::WS::Client::SetOption*.

- 

  ```
  noTargetNs
  ```

  The target namespace URI is normally included twice in the envelope of the webservice call:  

  ```
  <SOAP-ENV:Envelope
  	...
  	xmlns="http://targeturi.org/"
  	xmlns:tns1="http://targeturi.org/"
  	...>
  ```

  Setting this option to 1 suppresses the line with "xmlns=".   
  This option was set to call a service published by SAP.   
  Default value: 0

- 

  ```
  nsOnChangeOnly
  ```

  only put namespace prefix when namespaces change

- 

  ```
  parseInAttr
  ```

  parse attributes on inbound tags, see [here](Using_Options.md#parseinattr-parse-attributes-on-inbound-tags) for details

- 

  ```
  queryTimeout
  ```

  Timeout to any network query in ms. Default value: 60000 (1 minuite). The [utility package](Using_Options.md#querytimeout-set-http-s-query-timeout) has an option with the same functionality, which is used, when there is no call option context.

- 

  ```
  skipHeaderLevel
  ```

  boolean indicating the first level of the XML in a request header *shall be* skipped. Derived from options. Default is 0 (do not skip). *(Introduced in 2.2.8)*

- 

  ```
  skipLevelOnReply
  ```

  boolean indicating the first level of the XML in a reply *may be* skipped. Derived from options. Default is 0 (do not skip). *(Introduced in 2.2.8)*

- 

  ```
  skipLevelWhenActionPresent
  ```

  boolean indicating if the first level of the XML is to be skipped. Derived from options. Default is 0 (do not skip).

- 

  ```
  suppressNS (default: empty string)
  ```

  do not put a particular namespace prefix

- 

  ```
  suppressTargetNS
  ```

  Do not add the Target Namespace URI prefix "tns1" to all parameters in the webservice call XML.

  As an example, the XML is modified from (option not set): 

  ```
  <SOAP-ENV:Envelope ...
      xmlns:tns1="http://targeturi.org/"
      ... >
    <SOAP-ENV:Body>
      <tns1:CalledMethod>
        <tns1:Parameter1>Value;/tns1:Parameter1>
      </tns1:CalledMethod>
    </SOAP-ENV:Body>
  </SOAP-ENV:Envelope>
  ```

  to (option set)

  ```
  <SOAP-ENV:Envelope ...
      xmlns:tns1="http://targeturi.org/"
      ... >
  <SOAP-ENV:Envelope ...
    <SOAP-ENV:Body>
      <tns1:CalledMethod>
        <Parameter1>Value;/Parameter1>
      </tns1:CalledMethod>
    </SOAP-ENV:Body>
  </SOAP-ENV:Envelope>
  ```

  Derived from options.   
  Internally, this option sets the option "suppressNS" to "tns1".   
  This option was set to call a service published by SAP.   
  This option made a call to a certain MS Web Service fail with the error message: "Input parameter 'Parameter1' can not be NULL or Empty.".   
  Default is 0 (do not suppress).

- 

  ```
  targetNamespace (default: empty string)
  ```

  the target namespace of the service, derived from the WSDL.

  This item may not be used with *::WS::Client::SetOption*.

- 

  ```
  UseNS (default: empty string)
  ```

  See [here](Using_Options.md#usens-put-namespaces-on-field-tags)

- 

  ```
  useTypeNS (default: empty string)
  ```

  use type's namespace prefix as prefix of elements

- 

  ```
  valueAttrCompatiblityMode (default: 1)
  ```

  If this and genOutAttr/parseInAttr are set, then values are specified in the dictionary as {}. Otherwise if genOutAttr/parseInAttr is set this is not set, then the values are specified in the dictionary as ::value.


```
     value         - Optional, the new value.
```

**Returns :** 

```
     The value of the item.
Side-Effects : None 
Exception Conditions  : None 
Pre-requisite Conditions : Service must have been defined. 
```

## Dealing With Casting Abstract Types to Concrete Types 

 If you turn on *parseInAttr* and *genOutAttr*, the system will semi-automatically deal with casting of elements declared as a being of a type that is an abstract type to/from the concrete type actually to be used in a message. On an element that is decleared to be a type which is an abstract type, the value of the **::type** key in the dictionary will specify the concrete type to be actually used (or for a reply message the concrete type that was actually used). 

 **NOTE:** While in the WSDL the concreate type must be an extention of the abstract type, the package does not enforce this restriction, so caution must be taken.
