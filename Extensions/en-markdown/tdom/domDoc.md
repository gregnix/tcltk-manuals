---
CommandName: domDoc
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Links:
 - dom
 - domNode
Keywords:
 - DOM node creation
 - document element
Copyright:
---

# Name

domDoc - Manipulates an instance of a DOM document object

# Synopsis

```
domDocObjCmd method ?arg arg ...?
```

# Description

This command manipulates one particular instance of a document object. *method* indicates a specific method of the document class. These methods should closely conform to the W3C recommendation "Document Object Model (Core) Level 1" (http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html). Look at these documents for a deeper understanding of the functionality.

The valid methods are:

**documentElement** ?*objVar*__?__
: Returns the top most element in the document (the root element).

**getElementsByTagName** *name*
: Returns a list of all elements in the document matching (glob style) *name*.

**getElementsByTagNameNS** *uri* *localname*
:  Returns a list of all elements in the subtree matching (glob style) *localname* and having the given namespace *uri*.

**createElement** *tagName* **?**_objVar_**?**
: Creates (allocates) a new element node with node name *tagName*, append it to the hidden fragment list in the document object and returns the node object.  If *objVar* is given the new node object is stored in this variable.

**createElementNS** *url* *tagName* **?**_objVar_**?**
: Creates (allocates) a new element node within a namespace having *uri* as the URI and node name *tagName*, which could include the namespace prefix, append it to the hidden fragment list in the document object and returns the node object.  If *objVar* is given the new node object is stored in this variable.

**createTextNode** *text* **?**_objVar_**?**
: Creates (allocates) a new text node with node value *text*, appends it to the hidden fragment list in the document object and returns the node object.  If *objVar* is given, the new node object is stored in this variable.

**createComment** *text* **?**_objVar_**?**
: Creates (allocates) a new comment node with value *text*, appends it to the hidden fragment list in the document object and returns the node object.  If *objVar* is given, the new comment node object is stored in this variable.

**createCDATASection** *data* **?**_objVar_**?**
: Creates (allocates) a new CDATA node with node value *data*, appends it to the hidden fragment list in the document object and returns the node object.  If *objVar* is given, the new node object is stored in this variable.

**createProcessingInstruction** *target* *data* **?**_objVar_**?**
: Creates a process instruction, appends it to the hidden fragment list in the document object and returns the node object.  If *objVar* is given, the new node object is stored in this variable.

**delete**
: Explicitly deletes the document, including the associated Tcl object commands (for nodes, fragment/new nodes, the document object itself) and the underlying DOM tree.

**getDefaultOutputMethod**
: Returns the default output method of the document. This is usually a result of a XSLT transformation.

**asXML** **?-indent none/tabs/1..8?** **?-channel channelId?** **?-escapeNonASCII?** **?-doctypeDeclaration \<boolean>?** **-xmlDeclaration \<boolean>?** **-encString \<string>** **?-escapeAllQuot?** **?-indentAttrs?** **?-nogtescape?** **?-noEmptyElementTag?** **?-escapeCR?** **?-escapeTab?**
: 


Returns the DOM tree as an (optional indented) XML string or sends the output directly to the given channelId.

The -indent option requires "no", "none", "tabs" or a natural number betwenn 0 and 8, both included, as value. With the values "no" or "none" no additional white space outside of markup will be added to the serialization. I. Otherwise, it's a "pretty-print" serialization, due to inserting white space between end and the next start tag according to the nesting level. The level indentation wide is given with the number. If the value is "tabs", then indentation is done with tabs, one tab per level.

If the option *-escapeNonASCII* is given, every non 7 bit ASCII character in attribute values or element PCDATA content will be escaped as character reference in decimal representation.

The flag *-doctypeDeclaration* determines whether there will be a DOCTYPE declaration emitted before the first node of the document. The default is not to emit it. The DOCTYPE name will always be the element name of the document element. An external entity declaration of the external subset is only emitted if the document has a system identifier.

The flag *-xmlDeclaration* determines whether there will be an XML Declaration and a newline emitted before anything else. The default is not to emit one. If this flag is given with a true argument then

*-encString* sets the encoding value in the XML Declaration. Otherwise this option is ignored. Please note that this option just enhances the string representation of the generated XML Declaration with an encoding information string, nothing more. It's up to the user to handle encoding in case of writing to a channel or reparsing.

If the option *-escapeAllQuot* is given, quotation marks will be escaped with &quot; even in text content of elements.

If the option *-indentAttrs* is given, then attributes will each be separated with newlines and indented to the same level as the parent node plus the value given as argument to *-indentAttrs* (0..8).

If the option *-nogtescape* is given then the character '>' won't get escaped in attribute values and text content of elements. The default is to escape this character.

If the option *-noEmptyElementTag* is given then no empty tag syntax will be used. Instead, if an element has empty content it will be serialized with an element start tag and an immediately following element end tag.

If the option *-escapeCR* is given then the character '\\r' will be escaped as character reference in attribute values and text content of elements. The default is to not do this.

If the option *-escapeTab* is given then the character '\\t' will be escaped as character reference in attribute values and text content of elements. The default is to not do this.

**asCanonicalXML** **?-channel channelId?** **?-comments \<boolean>?**
: 


Returns the DOM tree as canonical XML string according to the "Canonical XML Version 1.0 W3C Recommendation 15 March 2001" or sends the output directly to the given channelId.

If the goal is to get a canonical XML serialization of the XML file from which the DOM tree was parsed there are a few prerequisites. The XML data must be parsed with the *-keepEmpties* option. If the XML data includes a DTD which defines attribute defaults or external parsed entity references it is necessary to use the expat parser (not the *-simple* one). For any supported Tcl version lesser then 9.0 if the XML data includes characters outside the BMP a Tcl build with TCL_UTF_MAX defined to 6 (and a tDOM build with this Tcl) is necessary.

If the -channel option is given then the output is send directly to the Tcl channel given as argument. It is the up to the caller to ensure that the channel is correctly fconfigured. If this option is not given then the command returns the serialization as string.

If the option *-comments* is given with a true value then the serialization includes comments according to the rules of the recommendation. If the value is false or this option is omitted then comments are removed from the serialization.

**asHTML** **?-channel channelId?** **?-escapeNonASCII?** **?-htmlEntities?** **?-doctypeDeclaration \<boolean>?** **?-breakLines?** **?-onlyContents?**
: 


Returns the DOM tree serialized according to HTML rules (HTML elements are recognized regardless of case, without end tags for empty HTML elements etc.) as string or sends the output directly to the given channelId.

If the option *-escapeNonASCII* is given, every non 7 bit ASCII character in attribute values or element PCDATA content will be escaped as character reference in decimal representation.

If the option *-htmlEntities* is given, a character or a pair of characters is written using its HTML 5 character entity reference, if it has one. Some HTML 5 character entity references encode the same character or code points. From the possible entity names the shortest is chosen. If there are more than one shortest name and this names differ only in case then the lowercase alternative is chosen. Otherwise frist name in lexical ASCII order is chosen. There is one HTML5 entitiy (ThickSpace), which escapes two characters for which the first and the second character have an entity name by itself. If the two characters are to be serialized then the one two-characters entity ThickSpace will be chosen.

If the option *-breakLines* is given the serialization outputs "\\n>" instead of ">" for the opening tags of elements.

If the option *-onlyContents* is given only all child nodes are serialized. This option is ignored by document nodes.

If the flag *-doctypeDeclaration* is given there will be a DOCTYPE declaration emitted before the first node of the document. The default is, to do not. The DOCTYPE name will always be the element name of the document element without case normalization. An external entity declaration of the external subset is only emitted, if the document has a system identifier. The doctype declaration will be written from the available information, without check, if this is a known (w3c) HTML version information or if the document confirms to the given HTML version. All nodes types other than document nodes ignore this option.

**asText**
: The asText method returns the tree by serializing the string-value of every text node in document order without any escaping. In effect, this is what the xslt output method "text" (XSLT 1.0 recommendation, section 16.3) does.

**asJSON** **?-indent none/0..8?** **?-channel channelId?**
: 


The asJSON method serializes the tree into a valid JSON data string. In general, this may be a lossy serialization. For this serialization all comment, character data sections and processing instruction nodes, all attributes and all XML namespaces are ignored. Only element and text nodes may be reflected in the generated JSON serialization. Appropriate JSON data type information of a node will be respected.

If an element node has the JSON type OBJECT, then every element node child of this element will be serialized as member of that object, with the node name of the child as the member name and the relevant children of that child as the value. Every other child nodes will be ignored.

If an element node has the JSON type ARRAY, then the text and element node children of that element node are serialized as the consecutive values of the array. Element node children of an ARRAY element will be container nodes for nested ARRAY or OBJECT values.

Text nodes with the JSON types TRUE, FALSE or NULL will be serialized to the corresponding JSON token without looking at the value of the text node. A text node without JSON type will always be serialized as a JSON string token. A text node with JSON type NUMBER will be serialized as JSON number token if the text node value is in fact a valid JSON number and as a JSON string if not.

If an element node doesn't has a JSON type then the serialization of its children is determined by the following rules:

Only text and element node child are relevant. If the element node to serialize is the member of a JSON object and there is no relevant child node the value of that member will be an empty JSON string. If the only relevant child node of this element node is a text node then the JSON value of that text node will be the value of the object member. If the element has more than one relevant child nodes and the first one is a text node then the relevant children will be serialized as JSON array. If the only relevant child node is an element node or the first relevant child is an element node and the node name of that only or first relevant child isn't equal to the array container node name all element node children will be serialized as the members of a JSON object (while ignoring any intermixed text nodes). If the only or first relevant child is an element node and the node name of this child is equal to the array container element name then all relevant children will be serialized as the values of a JSON array.

If the element to serialize is a value of a JSON array and the node name of this element isn't equal to the array container node name that element will be seen as a container node for a JSON object and all element node children will be serialized as the members of that array while ignoring any text node children. If the element to serialize is a value of a JSON array and the node name of this element is equal to the array container node name, all relevant children will be serialized as JSON array.

If the *-channel* option is given the serialization isn't returned as string but send directly to the channel, given as argument to the option.

If the *-indent* option is given and the argument given to this option isn't "none" then the returned JSON string is "pretty-printed". The numeric argument to this option defines the number of spaces for any indentation level. The default is to not emit any additional white space.

**asTclValue** **?typevariable?**
: 


In case the DOM tree includes JSON type information this method returns the JSON data as nested Tcl data structure.

The returned value may be a Tcl dict, a Tcl list or a string. If the optional argument *typevariable* is given then the variable with that name is set to the value *dict*, *list* or *string* respectively to signal the type of the result.

A JSON object is returned as Tcl dict, a JSON array is returned as list and JSON strings and numbers as well as the symbolic JSON values null, true and false are returned as string (with the strings null, true and false for the respectively JSON symbol). The value of a member of a JSON object may be also a Tcl dict, or a Tcl list or a string and the elements of a JSON array list may be a Tcl dict or a Tcl list or a string.

**asTypedList**
: 


In case the DOM tree includes JSON type information this method returns the JSON data as a nested Tcl list.

The first element of every of this lists describes the type of the value. The types are: OBJECT, ARRAY, STRING, NUMBER, TRUE, FALSE or NULL.

If the type is NUMBER or STRING, then the second (and last) element is the value. If the type is NULL, TRUE or FALSE the list does not have any other elements.

If the type is OBJECT the second value will be a Tcl list of property name and value pairs, which means the second element could be used as dict. The value will be a Tcl list build by the rules of the *asTypedList* method.

If the type is ARRAY the second value will be a Tcl list of the JSON array values, each one build by the rules of the *asTypedList* method.

**publicId** *?publicId?*
: Returns the public identifier of the doctype declaration of the document, if there is one, otherwise the empty string. If there is a value given to the method, the public identifier of the document is set to this value.

**systemId** *?systemId?*
: Returns the system identifier of the doctype declaration of the document, if there is one, otherwise the empty string. If there is a value given to the method, the system identifier of the document is set to this value.

**internalSubset** *?internalSubset?*
: Returns the internal subset of the doctype declaration of the document, if there is one, otherwise the empty string. If there is a value given to the method, the internal subset of the document is set to this value. Note that none of the parsing methods preserve the internal subset of a document; a freshly parsed document will always have an empty internal subset. Also note that the method doesn't do any syntactical check on a given internal subset.

**cdataSectionElements** *(?URI:?localname|\*) ?\<boolean>?*
: This method allows one to control for which element nodes the text node children will be serialized as CDATA sections (this affects only serialization with the asXML method, no text node is altered in any way by this method). IF the method is called with an element name as first argument and a boolean with value true as second argument, every text node child of every element node in the document with the same name as the first argument will be serialized as CDATA section. If the second argument is a boolean with value false, all text nodes of all elements with the same name as the first argument will be serialized as usual. Namespaced element names have to be given in the form namespace_URI:localname, not in the otherwise usual prefix:localname form. With two arguments called, the method returns the used boolean value. If the method is called with only an element name, it will return a boolean value, indicating that the text node children of all elements with that name in the document will be serialized as CDATA section elements (return value 1) or not (return value 0). If the method is called with only one argument and that argument is an asterisk ('\*'), then the method returns an unordered list of all element names of the document, for which the text node children will be serialized as CDATA section nodes.

**selectNodesNamespaces** **?prefixUriList?**
: This method gives control to a document global prefix to namespace URI mapping, which will be used for selectNodes method calls (on document as well as on all nodes, which belongs to the document) if it is not overwritten by using the -namespaces option of the selectNodes method. Any namespace prefix within an xpath expression will be first resolved against this list. If the list binds the same prefix to different namespaces, then the first binding will win. If a prefix could not resolved against the document global prefix / namespaces list, then the namespace definitions in scope of the context node will be used to resolve the prefix, as usual. If the optional argument *prefixUriList* is given, then the global prefix / namespace list is set to this list and returns it. Without the optional argument the method returns the current list. The default is the empty list.

**xslt** **?-parameters parameterList?** **?-ignoreUndeclaredParameters?** **?-maxApplyDepth int?** **?-xsltmessagecmd script?** *stylesheet* *?outputVar?*
: Applies an XSLT transformation on the whole document of the node object using the XSLT *stylesheet* (given as domDoc). Returns a document object containing the result document of the transformation and stores that document object in the optional *outputVar*, if that was given.


The optional *-parameters* option sets top level \<xsl:param> to string values. The *parameterList* has to be a tcl list consisting of parameter name and value pairs.

If the option *-ignoreUndeclaredParameters* is given, then parameter names in the *parameterList* given to the *-parameters* options that are not declared as top-level parameters in the stylesheet are silently ignored. Without this option, an error is raised if the user tries to set a top-level parameter that is not declared in the stylesheet.

The option *-maxApplyDepth* expects a positiv integer as argument. By default, the XSLT engine allows XSLT templates to nest up to 3000 levels (and raises error if they nest deeper). This limit can be set by the *-maxApplyDepth* option.

The *-xsltmessagecmd* option sets a callback for xslt:message elements in the stylesheet. The actual command consists of the script, given as argument to the option, appended with the XML Fragment from instantiating the xsl:message element content as string (as if the XPath string() function would have been applied to the XML Fragment) and a flag, which indicates, if the xsl:message has an attribute "terminate" with the value "yes". If the called script returns anything else then TCL_OK then the XSLT transformation will be aborted, returning error. If the called script returns -code break, the error message is empty, otherwise the result code is reported. In case of terminated transformation, the outputVar, if given, is set to the empty string.

**toXSLTcmd** ?*objVar*__?__
: If the DOM tree represents a valid XSLT stylesheet, this method transforms the DOM tree into an XSLT command, otherwise it returns error. The created xsltCmd is returned and stored in the *objVar*, if a var name was given. A successful transformation of the DOM tree to an xsltCmd removes the domDoc cmd and all nodeCmds of the document.


The syntax of the created xsltCmd is:

```
xsltCmd method ?arg ...?
```

The valid methods are:

**transform** **?-parameters parameterList?** **?-ignoreUndeclaredParameters?** **?-maxApplyDepth int?**  **?-xsltmessagecmd script?** *domDoc* *?outputVar?*
: Applies XSLT transformation on the document *domDoc*. Returns a document object containing the result document of that transformation and stores it in the optional *outputVar*.


The optional *-parameters* option sets top level \<xsl:param> to string values. The *parameterList* has to be a tcl list consisting of parameter name and value pairs.

If the option *-ignoreUndeclaredParameters* is given, then parameter names in the *parameterList* given to the *-parameters* options that are not declared as top-level parameters in the stylesheet are silently ignored. Without this option, an error is raised if the user tries to set a top-level parameter, which is not declared in the stylesheet.

The option *-maxApplyDepth* expects a positiv integer as argument. By default, the XSLT engine allows XSLT templates to nest up to 3000 levels (and raises error if they nest deeper). This limit can be set by the *-maxApplyDepth* option.

The *-xsltmessagecmd* option sets a callback for xslt:message elements in the stylesheet. The actual command consists of the script, given as argument to the option, appended with the XML Fragment from instantiating the xsl:message element content as string (as if the XPath string() function would have been applied to the XML Fragment) and a flag, which indicates, if the xsl:message has an attribute "terminate" with the value "yes".

**delete**
: Deletes the xsltCmd and cleans up all used recourses If the first argument to an xsltCmd is a domDoc or starts with a "-", then the command is processed in the same way as *\<xsltCmd> transform*.


**normalize** *?-forXPath?*
: Puts all text nodes in the document into a "normal" form where only structure (e.g., elements, comments, processing instructions and CDATA sections) separates text nodes, i.e., there are neither adjacent text nodes nor empty text nodes. If the option *-forXPath* is given, all CDATA sections in the nodes are converted to text nodes, as a first step before the normalization.

**nodeType**
: Returns the node type of the document node. This is always DOCUMENT_NODE.

**getElementById** *id*
: Returns the node having a id attribute with value *id* or the empty string, if no node has an id attribute with that value.

**firstChild** **?objVar?**
: Returns the first top level node of the document.

**lastChild** **?objVar?**
: Returns the last top level node of the document.

**appendChild** *newChild*
: Append *newChild* to the end of the list of top level nodes of the document.

**removeChild** *child*
: Removes *child* from the list of top level nodes of the document. *child* will be part of the document fragment list after this operation. It is not physically deleted.

**hasChildNodes**
: Returns 1 if the document has any nodes in the tree. Otherwise 0 is returned.

**childNodes**
: Returns a list of the top level nodes of the document.

**ownerDocument** **?domObjVar?**
: Returns the document itself.

**insertBefore** *newChild*  *refChild*
: Insert *newChild* before the *refChild* into the list of top level nodes of the document. If *refChild* is the empty string, inserts *newChild* at the end of the top level nodes.

**replaceChild** *newChild*  *oldChild*
: Replaces *oldChild* with *newChild* in the list of children of that node. The *oldChild* node will be part of the document fragment list after this operation.

**appendFromList** *list*
: Parses *list* , creates an according DOM subtree and appends this subtree at the end of the current list of top level nodes of the document.

**appendXML** *XMLstring*
: Parses *XMLstring*, creates an according DOM subtree and appends this subtree at the end of the current list of top level nodes of the document.

**selectNodes** **?-namespaces prefixUriList?** **?-cache \<boolean>?** **?-list?** *xpathQuery* **?typeVar?**
: 


Returns the result of applying the XPath query *xpathQuery* to the document. The context node of the query is the root node in the sense of the XPath recommendation (not the document element). The result can be a string/value, a list of strings, a list of nodes or a list of attribute name / value pairs. If *typeVar* is given the result type name is stored into that variable (empty, bool, number, string, nodes, attrnodes or mixed).

See the documentation of the of the

**domNode**
:  command method **selectNodes** for a detailed description of the arguments.


**baseURI** *?URI?*
: Returns the present baseURI of the document. If the optional argument URI is given, sets the base URI of the document to the given URI.

**appendFromScript** *tclScript*
: Appends the nodes created by the *tclScript* by Tcl functions, which have been built using *dom createNodeCmd*, at the end of the current list of top level nodes of the document.

**insertBeforeFromScript** *tclScript* *refChild*
: Inserts the nodes created in the *tclScript* by Tcl functions, which have been built using *dom createNodeCmd*, before the *refChild* into to the list of top level nodes of the document. If *refChild* is the empty string, the new nodes will be appended.

**deleteXPathCache** *?xpathQuery?*
: If called without the optional argument, all cached XPath expressions of the document are freed. If called with the optional argument *xpathQuery*, this single XPath query will be removed from the cache, if it is there. The method always returns an empty string. Otherwise, if an unknown method name is given, the command with the same name as the given method within the namespace **::dom::domDoc** is tried to be executed. This allows quick method additions on Tcl level. Newly created nodes are appended to a hidden fragment list. If they are not moved into the tree they are automatically deleted as soon as the whole document gets deleted.
