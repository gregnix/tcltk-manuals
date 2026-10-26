---
CommandName: dom
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Keywords:
 - XML
 - DOM
 - document
 - node
 - parsing
Copyright:
---

# Name

dom - Create an in-memory DOM tree from XML

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit} 

[dom]{.cmd} [method]{.arg} [arg arg]{.optdot} 
:::

# Description

This command provides the creation of DOM trees in memory. In the usual case a string containing an XML document is parsed and converted into a DOM tree. Other possible parse input may be HTML or JSON. The *method* indicates a specific subcommand.

The valid methods are:

**dom** **parse** ?*options*__? ?__*data*__? ?objvar?__
: Parses the *data* and builds up a DOM tree from that in memory providing a Tcl object command to this DOM document object. Example:


```
dom parse $xml doc
$doc documentElement root
```

This parses the XML data in the variable xml, creates the DOM tree in memory, make a reference to the document object, visible in Tcl as a document object command  and assigns this new object command to the variable doc. If the variable doc gets gets out of scope, the DOM tree and the associated Tcl command object (document and all node objects) are freed automatically.

Instead of using the *objvar* argument you may just use the returned object command:

```
set document [dom parse $xml]
set root     [$document documentElement]
```

This creates a persitent DOM tree which is not freed automatically. To free the DOM tree and the related Tcl object commands (document + nodes + fragment nodes) the document object command has to be explicitly deleted by:

```
$document delete
```

or

```
rename $document ""
```

By default no white space only text nodes are inserted into the tree with respecting *xml:space="preserve"* attributes (and reverting to default inside such a subtree with *xml:space="default"*).

The valid options are:

**-simple**
: If *-simple* is specified, a simple but fast parser is used (conforms not fully to XML recommendation). That should double parsing and DOM generation speed. The encoding of the data is not transformed inside the parser. The simple parser does not respect any encoding information in the XML declaration. It skips over the internal DTD subset and ignores any information in it. Therefore, it doesn't include defaulted attribute values into the tree, even if the according attribute declaration is in the internal subset. It also doesn't expand internal or external entity references other than the predefined entities and character references

**-html**
: If *-html* is specified, a fast HTML parser is used, which tries to even parse badly formed HTML into a DOM tree. If the HTML document given to parse does not have a single root element (as it was legal up to HTML 4.01) and the -forest option is not used then a html node will be inserted as document element, with the HTML input data top level elements as children.

**-html5**
: This option is only available if tDOM was build with --enable-html5. Use the *featureinfo* method if you need to know if this feature is build in. If *-html5* is specified, the gumbo lib html5 parser (https://github.com/google/gumbo-parser) is used to build the DOM tree. This is, as far as it goes, XML namespace-aware (which means for example that all HTML elements are in the html5 namespace). Since this probably isn't wanted by a lot of users and adds only burden for no good in a lot of use cases *-html5* can be combined with *-ignorexmlns*, in which case all nodes and attributes in the DOM tree are not in an XML namespace. All tag and attribute names in the DOM tree will be lower case, even for foreign elements not in the xhtml, svg or mathml namespace. The DOM tree may include nodes, that the parser inserted because they are implied by the context (as \<head>, \<tbody>, etc.). Input longer than 4 GByte byte length is not supported by the underlying gumbo parser.

**-json**
: If *-json* is specified, the *data* is expected to be a valid JSON string (according to RFC 7159). The command returns an ordinary DOM document with nesting token inside the JSON data translated into tree hierarchy. If a JSON array value is itself an object or array then container element nodes named (in a default build) arraycontainer or objectcontainer, respectively, are inserted into the tree. The JSON serialization of this document (with the domDoc method *asJSON*) is the same JSON information as the *data*, preserving JSON datatypes, allowing non-unique member names of objects while preserving their order and the full range of JSON string values. JSON datatype handling is done with an additional property "sticking" at the doc and tree nodes. This property isn't contained in an XML serialization of the document. If you need to store the JSON data represented by a document, store the JSON serialization and parse it back from there. Apart from this JSON type information the returned doc command or handle is an ordinary DOM doc, which may be investigated or modified with the full range of the doc and node methods. Please note that the element node names and the text node values within the tree may be outside of what the appropriate XML productions allow.

**-jsonroot \<document element name>**
: If given makes the given element name the document element of the resulting doc. The parsed content of the JSON string will be the children of this document element node.

**-jsonmaxnesting**  *integer*
: This option only has effect if used together with the *-json* option. The current implementation uses a recursive descent JSON parser. In order to avoid using excess stack space, any JSON input that has more than a certain levels of nesting is considered invalid. The default maximum nesting is 2000. The option -jsonmaxnesting allows the user to adjust that.

**--**
: The option *--* marks the end of options. To give this option isn't strictly necessary even in the case of JSON parsing, for which valid data may start with a "-". If parsing json and if the second to last or last argument start with a "-" and isn't a known option name it will be treated as JSON data.

**-keepEmpties**
: If *-keepEmpties* is specified then text nodes which contain only whitespaces will be part of the resulting DOM tree. In default case (*-keepEmpties* not given) those empty text nodes are removed at parsing time.

**-keepCDATA**
: If *-keepCDATA* is specified then CDATA sections aren't added to the tree as text nodes (and, if necessary, combined with sibling text nodes into one text node) as without this option but are added as CDATA_SECTION_NODEs to the tree. Please note that the resulting tree isn't prepared for XPath selects or to be the source or the stylesheet of an XSLT transformation. If not combined with *-keepEmpties* only not whitespace only CDATA sections will be added to the resulting DOM tree.

**-channel**  *\<channel-ID>*
: If *-channel \<channel-ID>* is specified, the input to be parsed is read from the specified channel. The encoding setting of the channel (via fconfigure -encoding) is respected, ie the data read from the channel are converted to UTF-8 according to the encoding settings before the data is parsed.

**-baseurl**  *\<baseURI>*
: If *-baseurl \<baseURI>* is specified, the baseURI is used as the base URI of the document. External entities references in the document are resolved relative to this base URI. This base URI is also stored within the DOM tree.

**-feedbackAfter**  *<#bytes>*
: If *-feedbackAfter <#bytes>* is specified, the Tcl command given by *-feedbackcmd* is evaluated at the first element start within the document (or an external entity) after the start of the document or external entity or the last such call after #bytes. For backward compatibility if no -feedbackcmd is given but there is a Tcl proc named ::dom::domParseFeedback this proc is used as -feedbackcmd. If there isn't such a proc and -feedbackAfter is used it is an error to not also use -feedbackcmd. If the called script raises error, then parsing will be aborted, the *dom parse* call returns error, with the script error msg as error msg. If the called script *return -code break*, the parsing will abort and the *dom parse* call will return the empty string.

**-feedbackcmd**  *\<script>*
: If *-feedbackcmd \<script>* is specified, the script *script* is evaluated at the first element start within the document (or an external entity) after the start of the document or external entity or the last such call after #bytes value given by the *-feedbackAfter* option. If *-feedbackAfter* isn't given, using this option doesn't has any effect. If the called script raises error, then parsing will be aborted, the *dom parse* call returns error, with the script error msg as error msg. If the called script *return -code break*, the parsing will abort and the *dom parse* call will return the empty string.

**-externalentitycommand**  *\<script>*
: If *-externalentitycommand \<script>* is specified, the specified Tcl script is called to resolve any external entities of the document. The actual evaluated command consists of this option followed by three arguments: the base uri, the system identifier of the entity and the public identifier of the entity. The base uri and the public identifier may be the empty list. The script has to return a Tcl list consisting of three elements. The first element of this list signals how the external entity is returned to the processor. Currently the two allowed types are "string" and "channel". The second element of the list has to be the (absolute) base URI of the external entity to be parsed.  The third element of the list are data, either the already read data out of the external entity as string in the case of type "string", or the name of a Tcl channel, in the case of type "channel". Note that if the script returns a Tcl channel, it will not be closed by the processor.  It must be closed separately if it is no longer needed.

**-useForeignDTD**  *\<boolean>*
: If \<boolean> is true and the document does not have an external subset, the parser will call the -externalentitycommand script with empty values for the systemId and publicID arguments. Please note that if the document also doesn't have an internal subset, the -startdoctypedeclcommand and -enddoctypedeclcommand scripts, if set, are not called.

**-paramentityparsing**  *\<always|never|notstandalone>*
: The *-paramentityparsing* option controls, if the parser tries to resolve the external entities (including the external DTD subset) of the document while building the DOM tree. *-paramentityparsing* requires an argument, which must be either "always", "never", or "notstandalone". The value "always" means that the parser tries to resolves (recursively) all external entities of the XML source. This is the default in case *-paramentityparsing* is omitted. The value "never" means that only the given XML source is parsed and no external entity (including the external subset) will be resolved and parsed. The value "notstandalone" means, that all external entities will be resolved and parsed, with the exception of documents, which explicitly states standalone="yes" in their XML declaration.

**-forest**
: If this option is given, there is no need for a single root; any sequence of well-formed, balanced subtrees will be parsed into a DOM tree. This works for the expat DOM builder, the simple xml parser enabled with *-simple* and the simple HTML parser enabled -with *-html*. If used together with *-json* or *-html5* this option is ignored.

**-ignorexmlns**
: It is recommended, that you only use this option with the *-html5* option. If this option is given, no node within the created DOM tree will be internally marked as placed into an XML Namespace, even if there is a default namespace in scope for un-prefixed elements or even if the element has a defined namespace prefix. One consequence is that XPath node expressions on such a DOM tree doesn't work as may be expected. Prefixed element nodes can't be selected naively and element nodes without prefix will be seen by XPath expressions as if they are not in any namespace (no matter if they are in fact should be in a default namespace). If you need to inject prefixed node names into an XPath expression use the '%' syntax described in the documentation of the of the


**domNode**
:  command method **selectNodes**.


**-billionLaughsAttackProtectionMaximumAmplification**  *\<float>*
: \<URL: https://en.wikipedia.org/wiki/Billion_laughs_attack> ["https://en.wikipedia.org/wiki/Billion_laughs_attack"]("https://en.wikipedia.org/wiki/Billion_laughs_attack") This option together with *-billionLaughsAttackProtectionActivationThreshold* gives control over the parser limits that protects against billion laugh attacks (). This option expects a float >= 1.0 as argument. You should never need to use this option, because the default value (100.0) should work for any real data. If you ever need to increase this value for non-attack payload, please report.

**-billionLaughsAttackProtectionActivationThreshold**  *\<long>*
: \<URL: https://en.wikipedia.org/wiki/Billion_laughs_attack> ["https://en.wikipedia.org/wiki/Billion_laughs_attack"]("https://en.wikipedia.org/wiki/Billion_laughs_attack") This option together with *-billionLaughsAttackProtectionMaximumAmplification* gives control over the parser limits that protects against billion laugh attacks (). This option expects a positiv integer as argument. You should never need to use this option, because the default value (8388608) should work for any real data. If you ever need to increase this value for non-attack payload, please report.

**-setReparseDeferralEnabled**  *\<boolean>*
: Expat protects itself against quadratic parsing time due to long tokens in malicious crafted documents. This protection may have the side effect that a parsing event is not triggered directly after the end of the respective token but only after the parser has processed some more bytes of the input. This option allows disabling this behavior.

**-allocTrackerActivationThreshold**  *\<float>*
: This option together with *-allocTrackerMaximumAmplification* gives control for the parser limits to protect against the use of disproportional amounts of dynamic memory due to malicious crafted documents. This option expects a positive integer as argument. You should never need to use this option, because the default value (100.0) should work for any real data. If you ever need to increase this value for non-attack payload, please report.

**-allocTrackerMaximumAmplification**  *\<long>*
: This option together with *-allocTrackerActivationThreshold* gives control for the parser limits to protect against the use of disproportional amounts of dynamic memory due to malicious crafted documents. This option expects a positive integer as argument. You should never need to use this option, because the default value (67108864, that is 64 MiB) should work for any real data. If you ever need to increase this value for non-attack payload, please report.


**dom** **createDocument** *docElemName* **?**_objVar_**?**
: Creates a new DOM document object with one element node with node name *docElemName*. The *objVar* controls the memory handling as explained above.

**dom** **createDocumentNS** *uri* *docElemName* **?**_objVar_**?**
: Creates a new DOM document object with one element node with node name *docElemName*. *Uri* gives the namespace of the document element to create. The *objVar* controls the memory handling as explained above.

**dom** **createDocumentNode** ?*-jsonType jsonType*__? ?__*objVar*__?__
: Creates a new 'empty' DOM document object without any element node. *objVar* controls the memory handling as explained above. If the option -jsonType is given the created document node will be of the given JSON type.

**dom** **createFromTypedList** *typedList* **?**_objVar_**?**
: 


Creates a new DOM document from the argument *typedList*. The *objVar* argument controls the memory handling as explained above.

The *typedList* argument must be a Tcl list and must follow the format of the output of the document command method *asTypedList*, see there.

**dom** **createNodeCmd**           *?-returnNodeCmd?* *?-tagName name?* *?-jsonType jsonType?* *?-namespace URI?* *?-noNamespacedAttributes?* *?-notempty?* *(element|comment|text|cdata|pi)Node* *commandName*
: This method creates Tcl commands, which in turn create tDOM nodes. Tcl commands created by this command are only available inside a script given to the domNode methods *appendFromScript* or *insertBeforeFromScript*. If a command created with *createNodeCmd* is invoked in any other context, it will return error. The created command *commandName* replaces any existing command or procedure with that name. If the *commandName* includes any Tcl namespace qualifiers, it is created in the specified namespace. The *-tagName* option is only allowed for the elementNode type. The *-jsonType* option is only allowed for elementNode and textNode types.


If such command is invoked inside a script given as argument to the domNode method *appendFromScript* or *insertBeforeFromScript* it creates a new node and appends this node at the end of the child list of the invoking element node. If the option *-returnNodeCmd* was given, the command returns the created node as Tcl command. If this option was omitted, the command returns nothing. Each command creates always the same type of node. Which type of node is created by the command is determined by the first argument to the *createNodeCmd*. The syntax of the created command depends on the type of the node it creates.

If the command type to create is *elementNode*, the created command will create an element node, if called. Though, if the *-notempty* flag was used in creating the node command the element node will only be created if it is not empty. Without the *-tagName* option the tag name of the created node is *commandName* without Tcl namespace qualifiers. If the *-tagName* option was given then the created elements will have the value of this option as tag name. If the *-jsonType* option was given then the created node elements will have the given JSON type. If the *-namespace* option is given the created element node will be XML namespaced and in the namespace given by the option. The element name will be literal as given either by the command name or the *-tagname* option, if that was given. An appropriate XML namespace declaration will be automatically added, to bind the prefix (if the element name has one) or the default namespace (if the element name hasn't a prefix) to the namespace if such a binding isn't in scope.

The syntax of the created command is:

```
elementNodeCmd ?attributeName attributeValue ...? ?script?
elementNodeCmd ?-attributeName attributeValue ...? ?script?
elementNodeCmd ?name_value_list? ?script?
```

The command syntax allows three different ways to specify the attributes of the resulting element. These could be specified with *attributeName attributeValue* argument pairs, in an "option style" way with *-attriubteName attributeValue* argument pairs (the '-' character is only syntactical sugar and will be stripped off) or as a Tcl list with elements interpreted as attribute name and the corresponding attribute value. The attribute name elements in the list may have a leading '-' character, which will be stripped off. If the *elementNodeCmd* is called with only one argument this will be interpreted as content script.

If an *attributeName* is prefixed then by default the prefix will be first looked up in the *selectNodesNamespaces* prefix URI list and, if not found, looked up in the XML namespace scope of the node. If the prefix does not resolve error is raisen. If the prefix resolve then the attribute is created in this namespace (adding XML namespace declarations, if necessary). If *elementNodeCmd* was created with the flag *-noNamespacedAttributes* then no prefix lookup is done and the attribute is created with the name as given and in no XML namespace. It is recommended to not create XML namespace declarations with this.

Every *elementNodeCmd* accepts an optional Tcl script as last argument. This script is evaluated as recursive *appendFromScript* script with the node created by the *elementNodeCmd* as parent of all nodes created by the script.

If the first argument of the method is *textNode*, the command will create a text node. If the *-jsonType* option was given then the created text node will have that JSON type. The syntax of the created command is:

```
textNodeCmd ?-disableOutputEscaping? ?data?
```

If the json type of the created text node is NULL, TRUE or FALSE then the *data* argument is optional, otherwise it this argument must be given.

If the json type of the created text node is the virtual type BOOLEAN then if the text value is a boolean as recognized by Tcl_GetBooleanFromObj() the json value will be the according JSON boolean value. If the text node value is not a boolean value understood by Tcl the value will be written as json string.

If the optional flag *-disableOutputEscaping* is given, the escaping of the ampersand character (&) and the left angle bracket (<) inside the data is disabled. You should use this flag carefully.

If the first argument of the method is *commentNode* or *cdataNode* the command will create an comment node or CDATA section node. The syntax of the created command is:

```
nodeCmd data
```

If the first argument of the method is *piNode*, the command will create a processing instruction node. The syntax of the created command is:

```
piNodeCmd target data
```

Beside the with **dom** **createNodeCmd** calls created node commands there are two more commands which automatically insert nodes into the tree inside an **appendFromScript** script.

```
tdom::fsnewNode ?-jsonType <jsonType>? ?-namespace <namespace>? ?-noNamespacedAttributes? -notempty tagName ?attributes? ?script?
```

If called inside a fromScript context this command creates a new node *tagName* in the XML namespace *namespace* if the *-namespace* option was given and with the JSON type *jsonType* if the *-jsonType* option was given and appends this node at the end of the child list of the invoking element node. The other flags will also work as if given at the creation of an element creating command; see there. The *attributes* and *script* arguments will also be processed as if given to an element creating node command. If called outside a fromScript context this command will raise error.

```
tdom::fsinsertNode node
```

If called inside a fromScript context this command instead of creating a new node appends the as argument given node at the end of the child list of the invoking element node. The node is unlinked from its previous place. If called outside a fromScript context this command will raise error.

**dom** **fromScriptContext** ?*objVar*__?__
: If called inside a fromScript context this method returns the node on which the script context appends nodes to the child list. Otherwise it returns error.


If you create nodeCmds with the -notempty the returned node may have vanished outside the evaluation context if it is still empty at the end of the evaluation.

**dom** **setStoreLineColumn** *?boolean*__?__
: If switched on, the DOM nodes will contain line and column position information for the original XML document after parsing. The default is not to store line and column position information.

**dom** **setNameCheck** *?boolean*__?__
: If NameCheck is true, every method which expects an XML Name, a full qualified name or a processing instructing target will check, if the given string is valid according to its production rule. For commands created with the *createNodeCmd* method to be used in the context of *appendFromScript* the status of the flag at creation time decides. If NameCheck is true at creation time, the command will check its arguments, otherwise not. The *setNameCheck* set this flag. It returns the current NameCheck flag state. The default state for NameCheck is true.

**dom** **setTextCheck** *?boolean*__?__
: If TextCheck is true, every command which expects XML Chars, a comment, a CDATA section value or a processing instructing value will check, if the given string is valid according to its production rule. For commands created with the *createNodeCmd* method to be used in the context of *appendFromScript* the status of the flag at creation time decides. If TextCheck is true at creation time, the command will check its arguments, otherwise not.The *setTextCheck* method sets this flag. It returns the current TextCheck flag state. The default state for TextCheck is true.

**dom** **setObjectCommands** ?*(automatic|token|command)*__?__
: Controls if documents and nodes are created as Tcl commands or as token to be used with the domNode and domDoc commands. If the mode is 'automatic', then methods used at Tcl commands will create Tcl commands and methods used at doc or node tokes will create tokens. If the mode is 'command' then always Tcl commands will be created. If the mode is 'token', then always token will be created. The method returns the current mode. This method is an experimental interface.

**dom** **isName** *name*
: Returns 1 if *name* is a valid XML Name according to production 5 of the XML 1.0 recommendation. This means that *name* is a valid XML element or attribute name. Otherwise it returns 0.

**dom** **isPIName** *name*
: Returns 1 if *name* is a valid XML processing instruction target according to production 17 of the XML 1.0 recommendation. Otherwise it returns 0.

**dom** **isNCName** *name*
: Returns 1 if *name* is a valid NCName according to production 4 of the of the Namespaces in XML recommendation. Otherwise it returns 0.

**dom** **isQName** *name*
: Returns 1 if *name* is a valid QName according to production 6 of the of the Namespaces in XML recommendation. Otherwise it returns 0.

**dom** **isCharData** *string*
: Returns 1 if every character in *string* is a valid XML Char according to production 2 of the XML 1.0 recommendation. Otherwise it returns 0.

**dom** **isHTML5CustomName** *string*
: Returns 1 if *string* is a HTML5 valid custom element name (according to https://html.spec.whatwg.org/#valid-custom-element-name at 26 June 2024, it's a living standard). Otherwise it returns 0.

**dom** **clearString** ?*-replace*__?__ *string*
: Returns the string given as argument cleared out from any characters not allowed as XML parsed character data. If the *-replace* option is given then instead of removing such characters are replaced with \\uFFFD.

**dom** **isBMPCharData** *string*
: Returns 1 if every character in *string* is a valid XML Char with a Unicode code point within the Basic Multilingual Plane (that means, that every character within the string is at most 3 bytes long). Otherwise it returns 0.

**dom** **isComment** *string*
: Returns 1 if *string* is a valid comment according to production 15 of the XML 1.0 recommendation. Otherwise it returns 0.

**dom** **isCDATA** *string*
: Returns 1 if *string* is valid according to production 20 of the XML 1.0 recommendation. Otherwise it returns 0.

**dom** **isPIValue** *string*
: Returns 1 if *string* is valid according to production 16 of the XML 1.0 recommendation. Otherwise it returns 0.

**dom** **jsonEscape** *string*
: Returns the given *string* argument escaped in a way that if the returned string is used literary in a JSON document it is read by any confirming JSON parser as the original string.

**dom** **featureinfo** *feature*
: This method provides information about the used build options and the expat version. The valid values for the *feature* argument are:


**expatversion**
: Returns the version of the underlyling expat version as string, something like "exapt_2.1.0". This is what the expat API function XML_ExpatVersion() returns.

**expatmajorversion**
: Returns the major version of the at build time used expat version as integer.

**expatminorversion**
: Returns the minor version of the at build time used expat version as integer.

**expatmicroversion**
: Returns the micro version of the at build time used expat version as integer.

**dtd**
: Returns as boolean if build with *--enable-dtd*.

**ns**
: Returns as boolean if build with *--enable-ns*.

**unknown**
: Returns as boolean if build with *--enable-unknown*.

**tdomalloc**
: Returns as boolean if build with *--enable-tdomalloc*.

**lessns**
: Returns as boolean if build with *--enable-lessns*.

**TCL_UTF_MAX**
: Returns the TCL_UTF_MAX value of the Tcl core, tDOM was build with as integer

**html5**
: Returns as boolean, if build with *--enable-html5*.

**versionhash**
: Returns the fossil repository version hash.

**pullparser**
: Returns as boolean if the pullparser command is build in.

**schema**
: Returns as boolean if the tDOM schema features are build in.

**largedata**
: Returns as boolean if the expat library configuration allows pcdata content of an XML element greater than 2 GByte. Could be true only if build with Tcl 9 for a 64-bit architecture and then depends if the build-in expat version is used with default configuration or if the used system expat library is capable enough for this (typically not).
