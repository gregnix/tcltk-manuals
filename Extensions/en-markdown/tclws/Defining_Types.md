## Contents

- [1 Overview](#overview) 
- [2 Loading the Webservices Utility Package](#loading-the-webservices-utility-package) 
- [3 Defining a type](#defining-a-type) 
- [3 Defining a derived type](#defining-a-derived-type) 
- [4 Getting a type definition](#getting-a-type-definition) 
- [5 Generating a template dictionary for a type definition](#generating-a-template-dictionary-for-a-type-definition) 

 

## Overview 

Webservice Type declaration is part of the Webservices Utility package. 

When writing a web service it is often requried to write a complex type definition for an argument containing structured data. 

When calling an operation on a web service it is sometimes convient to define a complex type to return structured data as an XML fragment even though the sevice may state that it is only expecting a string. 

## Loading the Webservices Utility Package 

To load the webservices server package, do: 

```
 package require WS::Utils
```

This command will only load the utilities the first time it is used, so it causes no ill effects to put this in each file using the utilties. 

---

## Defining a type 

**Procedure Name** : *::WS::Utils::ServiceTypeDef* 

**Description** : Define a type for a service. 

**Arguments** : 

```
     mode            - Client or Server
     service         - The name of the service this type definition is for
     type            - The type to be defined/redefined
     definition      - The definition of the type's fields.  This consist of one
                           or more occurance of a field definition.  Each field definition
                           consist of:  fieldName fieldInfo
                           Where field info is: {type typeName comment commentString}
                              typeName can be any simple or defined type.
                              commentString is a quoted string describing the field.
```

**Returns** : Nothing 

**Side-Effects** : None 

**Exception Conditions** : None 

**Pre-requisite Conditions** : None 

---

## Defining a derived type 

**Procedure Name** : *::WS::Utils::ServiceSimpleTypeDef* 

**Description** : Define a derived type for a service. 

**Arguments** : 

```
     mode            - Client or Server
     service         - The name of the service this type definition is for
     type            - The type to be defined/redefined
     definition      - The definition of the type's fields.  This consist of one
                           or more occurance of a field definition.  Each field definition
                           consist of:  fieldName fieldInfo
                           Where: {type typeName comment commentString}
                              baseType typeName - any simple or defined type.
                              comment commentString - a quoted string describing the field.
                              pattern value
                              length value
                              fixed "true"|"false"
                              maxLength value
                              minLength value
                              minInclusive value
                              maxInclusive value
                              enumeration value
```

**Returns** : Nothing 

**Side-Effects** : None 

**Exception Conditions** : None 

**Pre-requisite Conditions** : None 

---

## Getting a type definition 

**Procedure Name** : *::WS::Utils::GetServiceTypeDef* 

**Description** : Query for type definitions. 

**Arguments** : 

```
     mode            - Client or Server
     service         - The name of the service this query is for
     type            - The type to be retrieved (optional)
```

**Returns** : 

```
     If type not provided, a dictionary object describing all of the types
     for the service.
     If type provided, a dictionary object describing the type.
       A definition consist of a dictionary object with the following key/values:
         xns         - The namespace for this type.
         definition  - The definition of the type's fields.  This consist of one
                       or more occurance of a field definition.  Each field definition
                       consist of:  fieldName fieldInfo
                       Where field info is: {type typeName comment commentString}
                         typeName can be any simple or defined type.
                         commentString is a quoted string describing the field.
```

**Side-Effects** : None 

**Exception Conditions** : None 

**Pre-requisite Conditions** : The service must be defined. 

---

## Generating a template dictionary for a type definition 

**Procedure Name** : *::WS::Utils::GenerateTemplateDict* 

**Description** : Generate a template dictionary object for a given type.

**Arguments** : 

```
     mode            - Client or Server
     serviceName     - The service name the type is defined in
     type            - The name of the type
     arraySize       - Number of elements to generate in an array.  Default is 2.
```

**Returns** : 

```
      A dictionary object for a given type.  If any circular references exist, they will have the value of <** Circular Reference **>
```

**Side-Effects** : None 

**Exception Conditions** : None 

**Pre-requisite Conditions** : The type and service must be defined.
