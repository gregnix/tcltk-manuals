# Using Web Service Options

## Contents

- [Overview](#overview) 
- [Loading the Webservices Utilities Package](#loading-the-webservices-utilities-package) 
- [ Access Routine](#access-routine) 
-  Options  

  - [ genOutAttr - generate attributes on outbound tags](#genoutattr-generate-attributes-on-outbound-tags) 
  - [ includeDirectory - disk directory to use for XSD includes when they can not be accessed via the Web.](#includedirectory-disk-directory-to-use-for-xsd-includes-when-they-can-not-be-accessed-via-the-web) 
  - [ nsOnChangeOnly - only put namespace prefix when namespaces change](#nsonchangeonly-only-put-namespace-prefix-when-namespaces-change) 
  - [parseInAttr - parse attributes on inbound tags](#parseinattr-parse-attributes-on-inbound-tags) 
  - [ queryTimeout - set http(s) fetch timeout.](#querytimeout-set-http-s-query-timeout) 
  - [ StrictMode - WSDL processing mode](#strictmode-wsdl-processing-mode) 
  - [ UseNS - put namespaces on field tags](#usens-put-namespaces-on-field-tags) 
  - [ useTypeNs - use type's namespace prefix as prefix of elements](#usetypens-use-type-s-namespace-prefix-as-prefix-of-elements) 
  - [ suppressNS - do not put a particular namespace prefix](#suppressns-do-not-put-a-given-namespace-prefix) 

 

## Overview

The Webservices Client and Server packages make use of the following options: 

- [UseNS](#usens-put-namespaces-on-field-tags), when set the following options become relevant:  
- [StrictMode](#strictmode-wsdl-processing-mode) 
- [parseInAttr](#parseinattr-parse-attributes-on-inbound-tags) 
- [genOutAttr](#genoutattr-generate-attributes-on-outbound-tags) 
- [includeDirectory](#includedirectory-disk-directory-to-use-for-xsd-includes-when-they-can-not-be-accessed-via-the-web) 

  - [useTypeNs](#usetypens-use-type-s-namespace-prefix-as-prefix-of-elements) 
  - [nsOnChangeOnly](#nsonchangeonly-only-put-namespace-prefix-when-namespaces-change) 
  - [suppressNS](#suppressns-do-not-put-a-given-namespace-prefix) 

The attributes can be retrieved and set using [::WS::Utils::SetOption](#access-routine).

If called by the client side, the following options are overwritten and restored on any call: 

- genOutAttr
- nsOnChangeOnly
- parseInAttr
- suppressNS
- UseNS
- useTypeNs
- valueAttrCompatiblityMode

---

## Loading the Webservices Utilities Package 

To load the webservices server package, do: 

```
 package require WS::Utils
```

This command will only load the utilities the first time it is used, so it causes no ill effects to put this in each file using the utilties. 

---

## Access Routine 

**Procedure Name : ::WS::Utils::SetOption** 

**Description :**  Retrieve or set an option 

**Arguments :** 

```
    option - name of the option
    value - value of the option (optional)
```

**Returns : The value of the option** 

**Side-Effects : None** 

**Exception Conditions :None** 

**Pre-requisite Conditions : None** 

---

## genOutAttr - generate attributes on outbound tags 

 The *genOutAttr* option, if set to a "true" value, will convert all dictionary keys of the entry for a given field tag to attribute value pairs of the tag in the outbound XML. For attributes in the "http://www.w3.org/2001/XMLSchema-instance" url, the key will be the attribute name prepended with two colons (e.g. **::type**) and the value will be the value of the attribute. For attributes other than those in the "http://www.w3.org/2001/XMLSchema-instance" url, the key will be the attribute name and the value will be the value of the attribute. The value of the tag will have a key determined by the [valueAttrCompatiblityMode](#valueattrcompatiblitymode-specify-dictionary-key-for-value-when-attributes-are-in-use). 

 The default value, "0", is for this option to be turned off. 

---

## includeDirectory - disk directory to use for XSD includes when they can not be accessed via the Web. 

 The *includeDirectory* option, if set, instructs TclWs to look in the specified directory for any XSD includes that can not be found via the web. 

 The default value, "{}", is for this option to be turned off. 

---

## nsOnChangeOnly - only put namespace prefix when namespaces change 

 The *nsOnChangeOnly* option, if set to a "true" value, will only place namespace prefixes when the namespaces change. 

 This option is only relevant, if the option [UseNS](#usens-put-namespaces-on-field-tags) is set. 

 The default value, "0", is for this option to be turned off. 

---

## parseInAttr - parse attributes on inbound tags 

 The *parseInAttr* option, if set to a "true" value, will convert all attributes of inbound field tags to dictionary entries for that tag. For attributes in the "http://www.w3.org/2001/XMLSchema-instance" url, the key will be the attribute name prepended with two colons (e.g. **::type**) and the value will be the value of the attribute. For attributes other than those in the "http://www.w3.org/2001/XMLSchema-instance" url, the key will be the attribute name and the value will be the value of the attribute. The value of the tag will have a key determined by the [valueAttrCompatiblityMode](#valueattrcompatiblitymode-specify-dictionary-key-for-value-when-attributes-are-in-use). 

 The default value, "0", is for this option to be turned off. 

---

## queryTimeout - set http(s) query timeout

 Timeout to any network query in ms. The [client side package](Calling_a_Web_Service.md#configuring-a-service) has an option with the same functionality, which is used, when there is a call option context. 

Default value: 60000 (1 minuite).

---

## StrictMode - WSDL processing mode 

 The *StrictMode* option determines what happens when an error is detected in parsing a WSDL. The legal values are: 

- **debug**
- **warning**
- **error**

 If the *StrictMode* is set to **debug** or **warning**, a message is logged using the ::log package at that level and the error is then ignored. 

 If the *StrictMode* is set to any value other than **debug** or **warning**, a message is logged using the ::log package at the **error** level and exception is generated. 

 The default value is **error**. 

 A major use of this is to ignore namespace imports in a WDSL that do not actually import any definitions. 

---

## UseNS - put namespaces on field tags 

 The *UseNS* option, if set to a "true" value, will put a namespace alias on all field tags. 

 The default value, "1", is for this option to be turned on. 

---

## useTypeNs - use type's namespace prefix as prefix of elements 

 The *useTypeNs* option, if set to a "true" value, will use the prefix of the type's namespace instead of the prefix of the element's namespace. 

 This option is only relevant, if the option [UseNS](#usens-put-namespaces-on-field-tags) is set. 

 The default value, "0", is for this option to be turned off. 

---

## suppressNS - do not put a given namespace prefix. 

 The *suppressNS* option, if set, will cause the given namespace to never be used as a prefix (i.e. tags that would normally have had the given prefix will not have any prefix). 

 This option is only relevant, if the option [UseNS](#usens-put-namespaces-on-field-tags) is set. 

 The default value, "{}", is for this option to be turned off. 

---

## valueAttrCompatiblityMode - specify dictionary key for value when attributes are in use

 This option is only meaningful when the *parseInAttr* or *genOutAttr* option is set to a "true" value. When set to a "true" value, the value of the tag will have a key of the null string (i.e. **{}**). When set to a "false" value, the value of the tag will have a key of **::value**. 

 The default value, "0", is for this option to be turned off. 

---
