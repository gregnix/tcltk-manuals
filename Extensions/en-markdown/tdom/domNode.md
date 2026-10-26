---
CommandName: domNode
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Links:
 - dom
 - domDoc
Keywords:
 - XML
 - DOM
 - document
 - node
 - parsing
Copyright:
---

# Name

domNode - Manipulates an instance of a DOM node object

# Synopsis

```
 $nodeObject method  arg arg ...
```

# Description

This command manipulates one particular instance of a DOM node object. *method* indicates a specific method of the node class. These methods should closely conform to the W3C recommendation "Document Object Model (Core) Level 1" (http://www.w3.org/TR/REC-DOM-Level-1/level-one-core.html) as well to parts of the W3C draft "XML Pointer Language (XPointer)" (http://www.w3.org/TR/1998/WD-xptr-19980303). Please note, that the XPointer methods are deprecated. Use DOM methods or XPath expressions instead of them.

The selectNodes method implements the "XML Path Language (XPath) Version 1.0" W3C recommendation 16 November 1999 (http://www.w3.org/TR/1999/REC-xpath-19991116). Look at these documents for a deeper understanding of the functionality.

The valid methods are:

**nodeType**
: Returns the node type of that node object. This can be: ELEMENT_NODE, TEXT_NODE, CDATA_SECTION_NODE, COMMENT_NODE or PROCESSING_INSTRUCTION_NODE.

**nodeName**
: Returns the node name of that node object. This is the element (tag) name for element nodes (type ELEMENT_NODE), the processing-instruction target for processing-instructions, "#text" for text node, "#comment" for comment nodes or "#cdata" for cdata section nodes.

**nodeValue** *?newValue?*
: Returns the value of that node object. This is the text or the data for element nodes of type TEXT_NODE, COMMENT_NODE, PROCESSING_INSTRUCTION_NODE or CDATA_SECTION_NODE). Otherwise it is empty. If the node is a TEXT_NODE, COMMENT_NODE or PROCESSING_INSTRUCTION_NODE and the optional argument *newValue* is given, the node is set to that value.

**hasChildNodes**
: Returns 1 if the node has children. Otherwise 0 is returned.

**parentNode** **?objVar?**
: Returns the parent node.

**childNodes**
: Returns a list of direct children node objects.

**childNodesLive**
: Returns a "live" nodeList object of the child nodes of the node in the sense of the DOM recommendation. This nodeList object is "live" in the sense that, for instance, changes to the children of the node object that it was created from are immediately reflected in the nodes returned by the NodeList accessors; it is not a static snapshot of the content of the node. The two accessors known by the nodeList object are "item \<index>", which returns the indexth item in the collection, and "length", which returns the number of nodes in the list.

**firstChild** **?objVar?**
: Returns the first child as a node object.

**lastChild** **?objVar?**
: Returns the last child as a node object.

**nextSibling**  **?objVar?**
: Returns the next sibling relative to the current node as a node object.

**previousSibling** **?objVar?**
: Returns the next sibling relative to the current node as a node object.

**getElementsByTagName** *name*
: Returns a list of all elements in the subtree matching (glob style) *name*.

**getElementsByTagNameNS** *uri* *localname*
: Returns a list of all elements in the subtree matching (glob style) *localname* and having the given namespace *uri*.

**getElementById** *id*
: Returns the node having an id attribute with value *id* or the empty string if no node has an id attribute with that value.

**hasAttribute** *attributeName*
: Returns 1 if the object node contains an attribute with name *attributeName* . Otherwise 0 is returned.

**getAttribute** *attributeName  ?defaultValue?*
: Returns the value of the attribute *attributeName*. If the attribute is not available *defaultValue* is returned.

**setAttribute** *attributeName newValue  ?attributeName newValue ...?*
: Sets the value for one or more attributes. Every *attributeName* is set to the corresponding *newValue*. If there isn't an attribute for one or more of the *attributeName*, this will create that attribute. It is not recommended to set attributes that look like XML namespace declarations.

**removeAttribute** *attributeName*
: Removes the attribute *attributeName*.

**hasAttributeNS** *uri* *localName*
: Returns 1 if the object node contains an attribute with the local name *localName* within the namespace *uri*.  Otherwise 0 is returned.

**getAttributeNS** *uri* *localName ?defaultValue?*
: Returns the value of the attribute with the local name *localName* within the namespace URI *uri*. If the node dosn't have that attribute the *defaultValue* is returned.

**setAttributeNS** *uri qualifiedName newValue ?uri qualifiedName newValue ...?*
: 


Sets the value for one or more full qualified attributes. Every attribute *qualifiedName* with the namespace URI *uri* will be set to *newValue*. This will create a new attribute, if it wasn't available before. If you want to set an attribute within a namespace you must specify the attribute name with prefix, even if you want to set an already existing attribute to a new value. While searching, if the attribute already exists, only the given *uri* and the localname of the *qualifiedName* is used.

```
$node setAttributeNS "http://some.uri.com/wow" prefix:attr1 attrValue
```

If the uri is the empty string and the attribute name has no prefix, this method has the same effect as the method **setAttribute**.

```
$node setAttributeNS "" attri "some Value"
```

With the exceptions of the special prefixes "xmlns" and "xml" you always must provide a non empty *uri* if your *qualifiedName* has a prefix. It is not recommended to set XML namespace declarations. The effects are complicated and not always obvious up to resulting a not well-formed serializations after further processing.

**removeAttributeNS** *uri* *localName*
: Removes the attribute with the local name *localName* within the namespace *uri*.

**attributes** **?attributeNamePattern?**
: Returns information about the attributes matching the *attributeNamePattern*. If *attributeNamePattern* isn't given, information about all attributes are returned. The return value is a Tcl list, the elements just the attribute name in case of non namespaced attributes and three element sublists for namespaced attributes. In case of an "ordinary" namespaced attribute, the sublist elements are {\<localname> \<prefix> \<namespace_uri>}. In the special case of an XML namespace declaration it is {\<the prefix defined> \<localname> ""}.

**attributeNames** **?attributeNamePattern?**
: Returns a flat list of all attributes names (as found in the XML source) matching the *attributeNamePattern*. If *attributeNamePattern* isn't given, all attribute names are returned as a Tcl list.

**appendChild** *newChild*
: Appends *newChild* to the end of the child list of the node.

**insertBefore** *newChild*  *refChild*
: Inserts *newChild* before the *refChild* into the list of children of node. If *refChild* is the empty string, insert *newChild* at the end of the child nodes list of that node.

**replaceChild** *newChild*  *oldChild*
: Replaces *oldChild* with *newChild* in the list of children of that node. The *oldChild* node will be part of the document fragment list after this operation.

**removeChild** *child*
: Removes *child* from the list of children of that node. *child* will be part of the document fragment list after this operation.

**delete**
: Deletes the given node and its complete child tree and frees the complete internal memory. The affected nodes are not accessible through the document fragment list.

**cloneNode** **?-deep?**
: Clones this node and adds the new create node into the document fragment list. If the *-deep* option is specified, all descendant nodes are also cloned.

**ownerDocument** **?domObjVar?**
: Returns the document object of the document this node belongs to.

**find** *attrName* *attrVal* **?objVar?**
: Finds the node with the attribute name *attrName*, and attribute value *attrVal* in the subtree starting the current node.

**child** *number|all* **type** **attrName attrValue**
: (XPointer) child

**descendant** *number|all* **type** **attrName attrValue**
: (XPointer) descendant

**ancestor** *number|all* **type** **attrName attrValue**
: (XPointer) ancestor

**fsibling** *number|all* **type** **attrName attrValue**
: (XPointer) fsibling

**psibling** *number|all* **type** **attrName attrValue**
: (XPointer) psibling

**root**  **objVar**
: (XPointer) root

**text**
: Returns all text node children of that current node combined, i.e. appended into one string.

**target**
: For a processing instruction node the target part is returned. Otherwise an error is generated.

**data**
: For a processing instruction node the data part is returned. For a text node, comment node or cdata section node the value is returned. Otherwise an error is generated.

**prefix**
: Returns the namespace prefix.

**namespaceURI**
: Returns the namespace URI.

**localName**
: Returns the localName from the tag name of the given node.

**selectNodes** **?-namespaces prefixUriList?** **?-cache \<boolean>?** **?-list?** *xpathQuery* **?typeVar?**
: 


Returns the result of applying the XPath query *xpathQuery* to the subtree. This result can be a string/value, a list of strings, a list of nodes or a list of attribute name / value pairs. If *typeVar* argument is given the result type name is stored into that variable (empty, bool, number, string, nodes, attrnodes or mixed).

The argument *xpathQuery* has to be a valid XPath 1.0 expression. However there are a few exceptions to that rule. Tcl variable references (in the usual tcl syntax: \$varname) may appear in the XPath statement at any position where it is legal according to the rules of the XPath syntax to put an XPath variable. Ignoring the syntax rules of XPath the Tcl variable name may be any legal Tcl var name: local variables, global variables, array entries and so on. The value will always be seen as string literal by the xpath engine. Cast the value explicitly with the according xpath functions (number(), boolean()) to another data type, if needed.

Similar to the way described above to inject literals in a secure way into the XPath expression using tcl variable references there is a syntax to inject element names from tcl variables. At every place where the XPath syntax allows a node test there could be a Tcl variable reference (in any form), just the leading \$ replaced with %. This allows one to select nodes with 'strange' (invalid, according to the appropriate XML production rule) node names which may be needed in case of working with JSON data.

The option *-namespaces* expects a Tcl list with prefix / namespace pairs as argument. If this option is not given, then any namespace prefix within the xpath expression will be first resolved against the list of prefix / namespace pairs set with the selectNodesNamespaces method for the document, the node belongs to. If this fails, then the namespace definitions in scope of the context node will be used to resolve the prefix. If this option is given, any namespace prefix within the xpath expression will be first resolved against that given list (and ignoring the document global prefix / namespace list). If the list binds the same prefix to different namespaces, then the first binding will win.  If this fails, then the namespace definitions in scope of the context node will be used to resolve the prefix, as usual.

If the *-cache* option is used with a true value, then the *xpathQuery* will be looked up in a document specific cache. If the query is found, then the stored pre-compiled query will be used. If the query isn't found, it will be compiled and stored in the cache, for use in further calls. Please note that the *xpathQuery* given as string is used as key for the cache. This means, that equal XPath expressions, which differ only in white space are treated as different cache entries. Special care is needed, if the XPath expression includes namespace prefixes or references to Tcl variables. Both namespace prefixes and Tcl variable references will be resolved according to the XML prefix namespace mappings and Tcl variable values at expression compilation time. If the same XPath expression is used later on in a context with other XML prefix namespace mappings or values of the used Tcl variables, make sure to first remove the compiled expression from the cache with the help of the **deleteXPathCache** method, to force a recompilation. Without using the *-cache* option such consideration is never needed.

If the *-list* option is given then the *xpathQuery* argument is expected to be a Tcl list of XPath queries. Every XPath query in this list other than the last one must return a node set result. Using the context and namespace resolution rules as without the *-list* option the first query out of the list is run. Every node out of the result set of this query is used as context node for the next XPath query out of the list and so on. It returns the result sets of the last query in the query list concatenated together.

Examples:

```
set paragraphNodes [$node selectNodes {chapter[3]//para[@type='warning' or @type='error'} ]
foreach paragraph $paragraphNodes {
    lappend  values [$paragraph selectNodes attribute::type]
}

set doc [dom parse {<doc xmlns="http://www.defaultnamespace.org"><child/></doc>}]
set root [$doc documentElement]
set childNodes [$root selectNodes -namespaces {default http://www.defaultnamespace.org} default:child]
```

**getLine**
: Returns the line number of that node in the originally parsed XML. The counting starts with 1

**getColumn**
: Returns the column number of that node in the originally parsed XML. The counting starts with 0

**getByteIndex**
: Returns the byte position of that node in the originally parsed XML. The counting starts with 0.

**asList**
: Returns the DOM substree starting from the current node as a nested Tcl list.

**asXML** **?-indent none/tabs/1..8?** **?-channel channelId?** **?-escapeNonASCII?** **?-doctypeDeclaration \<boolean>?** **-xmlDeclaration \<boolean>?** **-encString \<string>** **?-escapeAllQuot?** **?-indentAttrs?** **?-nogtescape?** **?-noEmptyElementTag?** **?-escapeCR?** **?-escapeTab?**
: 


Returns the DOM substree starting from the current node as the root node of the result as an (optional indented) XML string or sends the output directly to the given channelId.

See the documentation of the

**domDoc**
:  command method **asXML** for a detailed description of the arguments.


**asCanonicalXML** **?-channel channelId?** **?-comment?**
: 


Returns the DOM tree as canonical XML string according to the "Canonical XML Version 1.0 W3C Recommendation 15 March 2001" or sends the output directly to the given channelId.

See the documentation of the

**domDoc**
:  command method **asCanonicalXML** for a detailed description of the arguments.


**asHTML** **?-channel channelId?** **b?-escapeNonASCII?** **?-htmlEntities?** **?-doctypeDeclaration \<boolean>?** **?-breakLines?** **?-onlyContents?**
: 


Returns the DOM substree starting from the current node as the root node of the result serialized according to HTML rules (HTML elements are recognized regardless of case, without end tags for empty HTML elements etc.), as string or sends the output directly to the given channelId.

See the documentation of the

**domDoc**
:  method **asHTML** for a detailed description of the arguments.


**asText**
: For ELEMENT_NODEs, the asText method outputs the string-value of every text node descendant of node in document order without any escaping. For every other node type, this method outputs the XPath string value of that node.

**asJSON** **?-indent none/0..8?** **?-channel channelId?**
: 


The asJSON method serializes the subtree starting with the node the method was called on into a valid JSON data string.

See the documentation of the

**domDoc**
:  method **asJSON** for a detailed description of the method


**asTclValue** **?typevariable?**
: 


In case the subtree starting with the node the method was called on includes JSON type information this method returns the JSON data as nested Tcl data structure.

See the documentation of the

**domDoc**
:  method **asTclValue** for a detailed description of the method


**appendFromList** *list*
: Parses *list* , creates an according DOM subtree and appends this subtree to the current node.

**appendFromScript** *tclScript*
: Appends the nodes created in the *tclScript* by Tcl functions, which have been built using *dom createNodeCmd*, to the given node.

**insertBeforeFromScript** *tclScript* *refChild*
: Inserts the nodes created in the *tclScript* by Tcl functions, which have been built using *dom createNodeCmd*, before the *refChild* into the list of children of node. If *refChild* is the empty string, the new nodes will be appended.

**appendXML** *XMLstring*
: Parses *XMLstring*, creates an according DOM subtree and appends this subtree to the current node.

**simpleTranslate** *outputVar* *specifications*
: Translates the subtree starting at the object node according to the specifications in *specifications* and outputs the result in the variable *outputVar* . The translation is very similar to Cost Simple mode.

**toXPath** *?-legacy?*
: Returns an XPath, which exactly addresses the given node in its document. This XPath is only valid as there are no changes to DOM tree made later one. With the -legacy option, other XPath expressions are returned, which doesn't work in all cases.

**getBaseURI**
: Returns the baseURI of the node. This method is deprecated in favor of the *baseURI* method.

**baseURI** *?URI?*
: Returns the present baseURI of the node. If the optional argument URI is given, it sets the base URI of the node and of all of its child nodes out of the same entity as node to the given URI.

**disableOutputEscaping** *?boolean?*
: This method works only for text nodes; for every other node it returns error. Without the optional argument it returns, if disabling output escaping is on. The return value 0 means, the characters of the text node will be escaped, to generate valid XML, if serialized. This is the default for every parsed or created text node (with the exception of that text nodes in a result tree of an XSLT transformation, for which disabling output escaping was requested explicitly in the stylesheet). The return value 1 means, that output escaping is disabled for this text node. If such a text node is serialized (with asXML or asHTML), it is literally written, without escaping of the special XML characters. If the optional boolean value *boolean* is given, the flag is set accordingly. You should not set this flag to 1 until you really know what you do.

**precedes** *refnode*
: Compares the relative order of the node and *refnode*. Both nodes must be part of the same documents and not out of the fragment list of the document. Returns true if node is in document order (in the sense of the XPath 1.0 recommendation) before *refnode*, and false otherwise.

**normalize** *?-forXPath?*
: Puts all Text nodes in the full depth of the sub-tree underneath this Node into a "normal" form where only structure (e.g., elements, comments, processing instructions and CDATA sections) separates Text nodes, i.e., there are neither adjacent Text nodes nor empty Text nodes. If the option *-forXPath* is given, all CDATA sections in the nodes are converted to text nodes, as a first step before the normalization.

**xslt** **?-parameters parameterList?** **?-ignoreUndeclaredParameters?** **?-maxApplyDepth int?** **?-xsltmessagecmd script?** *stylesheet* *?outputVar?*
: Applies an XSLT transformation on the document using the XSLT *stylesheet* (given as domDoc). Returns a document object containing the result document of that transformation and stores it in the optional *outputVar*.


The optional *-parameters* option sets top level \<xsl:param> to string values. The *parameterList* has to be a Tcl list consisting of parameter name and value pairs.

If the option *-ignoreUndeclaredParameters* is given, then parameter names in the *parameterList* given to the *-parameters* options that are not declared as top-level parameters in the stylesheet are silently ignored. Without this option, an error is raised if the user tries to set a top-level parameter which is not declared in the stylesheet.

The option *-maxApplyDepth* expects a positive integer as argument. By default, the XSLT engine allows XSLT templates to nest up to 3000 levels (and raises error if they nest deeper). This limit can be set by the *-maxApplyDepth* option.

The *-xsltmessagecmd* option sets a callback for xslt:message elements in the stylesheet. The actual command consists of the script, given as argument to the option, appended with the XML Fragment from instantiating the xsl:message element content as string (as if the XPath string() function would have been applied to the XML Fragment) and a flag, which indicates whether the xsl:message has an attribute "terminate" with the value "yes". If the called script returns anything else then TCL_OK then the XSLT transformation will be aborted, returning error. If the called script returns -code break the error message is empty, otherwise the result code is reported. In case of terminated transformation the outputVar, if given, is set to the empty string.

*@attrName*
: Returns the value of the attribute *attrName*.  Short cut for *getAttribute*.

**jsonType** *?(OBJECT|ARRAY|NONE)|(STRING|NUMBER|TRUE|FALSE|NULL|NONE)?*
: Only element and text nodes may have a JSON type and only this types of nodes support the *jsonType* method; the other node types return error if called with this method. Returns the jsonType of the node. If the optional argument is given, the JSON type of the node is set to the given type and returned. Valid type arguments for element nodes are OBJECT, ARRAY and NONE. Valid type arguments for text nodes are STRING, NUMBER, TRUE, FALSE, NULL and NONE. Otherwise, if an unknown method name is given, the command with the same name as the given method within the namespace **::dom::domNode** is tried to be executed. This allows quick method additions on Tcl level.
