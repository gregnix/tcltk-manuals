---
CommandName: schema
title: schema
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Keywords:
 - Validation
 - Postvalidation
 - DOM
 - SAX
Copyright:
---

# Name

tdom::schema - Creates a schema validation command

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit}

[tdom::schema]{.cmd} [create]{.optarg} [cmdName]{.arg}
:::

# Description

Every call of this command creates a new validation command. A validation command has methods to define a schema and is able to validate XML data or to post-validate a tDOM DOM tree (and to some degree other kind of hierarchical data) against this schema.

Also, a validation command may be used as argument to the *-validateCmd* option of the *dom parse* and the *expat* commands to enable validation additionally to what they do otherwise.

The methods of created commands are:

**prefixns** *?prefixUriList?*
: This method controls prefix (or abbreviation) to namespace URI mapping. Wherever a namespace argument is expected in the schema command methods the "prefix" could be used instead of the namespace URI. If the list maps the same prefix to different namespace URIs, the first one wins. If there is no such prefix, the namespace argument is used literally as namespace URI. If the method is called without argument, it returns the current prefixUriList. If the method is called with the empty string, any namespace URI arguments are used literally. This is the default.

**defelement** *name* *?namespace?* *<definition script>*
: This method defines the element *name* (optional in the namespace *namespace*) in the schema. The *definition script* is evaluated and defines the content model of the element. If the *namespace* argument is given, any *element* or *ref* references in the definition script not wrapped inside a *namespace* command are resolved in that namespace. If there is already a element definition for the name/namespace combination, the command raises error.

**defelementtype** *typename* *?namespace?* *<definition script>*
: This method defines the element type *typename* (optional in the namespace *namespace*) in the schema. If the element type is used in a definition script with the schema command element, the validation engine expects an element content according to content model *definition script*. Defining (and using) element types seems only sensible if you really have elements with the same name and namespace but different content models. The *definition script* is evaluated and defines the content model of the element it is assgned to. If the *namespace* argument is given, any *element* or *ref* references in the definition script not wrapped inside a *namespace* command are resolved in that namespace. If there is already an elementtype definition for the typename/namespace combination, the command raises error. The document element of any XML to validate cannot be a *defelementtype* defined element.

**defpattern** *name* *?namespace?* *<definition script>*
: This method defines a (maybe complex) content particle with the *name* (optional in the namespace *namespace*) in the schema, to be used in other definition scripts with the definition command *ref*. The *definition script* is evaluated and defines the content model of the content particle. If the *namespace* argument is given, any *element* or *ref* references in the definition script not wrapped inside a *namespace* command are resolved in that namespace. If there is already a pattern definition for the name/namespace combination, the command raises error.

**deftexttype** *name* *<constraint script>*
: This method defines a bundle of text constraints that can be referred to by *name* while defining constraints on text element or attribute values. If there is already a text type definition with this name, the command raises error. A text type may be referred before it is defined in the schema. If a referred text type isn't defined anywhere in the schema then any text will match this type during validation.

**start** *documentElement* *?namespace?*
: This method defines the name and namespace of the root element of a tree to validate. If this method is used, the root element must match for validity. If *start* is not used, any element defined by *defelement* may be the root of a valid document. The *start* method may be used several times with varying arguments during the lifetime of a validation command. If the command is called with just the empty string (and no namespace argument), the validation constraint for the root element is removed and any defined element will be valid as root of a tree to validate.

**define** *<definition script>*
: This method defines several elements or patterns or a whole schema with one call, by evaluating the *definition script*. All schema command methods so far (*prefixns*, *defelement*, *defelementtype*, *defpattern*, *deftexttype* and *start*) are allowed top level in the *definition script*. The *define* method itself isn't allowed recursively.

**event** *(start|end|text)* *?event specific data?*
: This method enables validation of hierarchical data against the content constraints of the validation command.

    **start**  *name ?attributes? ?namespace?*
    : Checks if the current validation state allows the element *name* in the *namespace* to start here. It raises error if not.

    **end**
    : Checks if the current innermost open element may end there in the current state without violation of validation constraints. It raises error if not.

    **text**  *text*
    : Checks if the current validation state allows the given text content. It raises error if not.


**validate** ?*options***?** *<XML string>* *?objVar?*
: Returns true if the *<XML string>* is valid, or false, otherwise. If validation has failed and the optional *objVar* argument is given, the variable with that name is set to a validation error message. If the XML string is valid and the optional *objVar* argument is given, the variable will be untouched.

    The valid options are:

    **-baseurl**  *<baseURI>*
    : If *-baseurl <baseURI>* is specified, the baseURI is used as the base URI of the document. External entities references in the document are resolved relative to this base URI. This base URI is also stored within the DOM tree.

    **-externalentitycommand**  *<script>*
    : If *-externalentitycommand <script>* is specified, the specified Tcl script is called to resolve any external entities of the document. The default is "::tdom::extRefHandler", which is a simple file URL resolver defined by the script part of the package. Setting the option value to the empty string disables resolving of external entities. The actual evaluated command consists of this option followed by three arguments: the base uri, the system identifier of the entity and the public identifier of the entity. The base uri and the public identifier may be the empty list. The script has to return a Tcl list consisting of three elements. The first element of this list signals how the external entity is returned to the processor. Currently the two allowed types are "string" and "channel". The second element of the list has to be the (absolute) base URI of the external entity to be parsed. The third element of the list are data, either the already read data out of the external entity as string in the case of type "string", or the name of a Tcl channel, in the case of type "channel". Note that if the script returns a Tcl channel, it will not be closed by the processor. It must be closed separately if it is no longer needed.

    **-paramentityparsing**  *<always|never|notstandalone>*
    : The *-paramentityparsing* option controls, if the parser tries to resolve the external entities (including the external DTD subset) of the document while building the DOM tree. *-paramentityparsing* requires an argument, which must be either "always", "never", or "notstandalone". The value "always" means that the parser tries to resolves (recursively) all external entities of the XML source. This is the default in case *-paramentityparsing* is omitted. The value "never" means that only the given XML source is parsed and no external entity (including the external subset) will be resolved and parsed. The value "notstandalone" means, that all external entities will be resolved and parsed, with the exception of documents, which explicitly states standalone="yes" in their XML declaration.

    **-useForeignDTD**  *<boolean>*
    : If <boolean> is true and the document does not have an external subset, the parser will call the -externalentitycommand script with empty values for the systemId and publicID arguments. Please note that if the document also doesn't have an internal subset, the -startdoctypedeclcommand and -enddoctypedeclcommand scripts, if set, are not called.


**validatefile** ?*options***?** *filename* *?objVar?*
: Returns true if the content of *filename* is valid, or false, otherwise. The given file is fed as binary stream to expat, therefore, only US-ASCII, ISO-8859-1, UTF-8 or UTF-16 encoded data will work with this method. If validation has failed and the optional *objVar* argument is given, the variable with that name is set to a validation error message. If the XML data is valid and the optional *objVar* argument is given, the variable will be untouched. The allowed options and their meaning are the same as for the *validate* method; see there for a description.

**validatechannel** ?*options***?** *channel* *?objVar?*
: Returns true if the content read from the Tcl channel *channel* is valid, or false, otherwise. Since data read out of a Tcl channel is UTF-8 encoded, any misleading encoding declaration at the beginning of the data will lead to errors. If the validation fails and the optional *objVar* argument is given, the variable with that name is set to a validation error message. If the XML data is valid and the optional *objVar* argument is given, the variable will be untouched. The allowed options and their meaning are the same as for the *validate* method; see there for a description.

**domvalidate** *domNode* *?objVar?*
: Returns true if the first argument is a valid tree, or false, otherwise. If validation has failed and the optional *objVar* argument is given, the variable with that name is set to a validation error message. If the dom tree is valid and the optional *objVar* argument is given, the variable with that name is set to the empty string.

**reportcmd** *?cmd?*
: This method expects the name of a Tcl command to be called in case of validation error. The command will be called with two arguments appended: the schema command which raises the validation error, and a validation error code.

    The possible error codes are:

    - MISSING\_ELEMENT
    - MISSING\_TEXT
    - UNEXPECTED\_ELEMENT
    - UNEXPECTED\_ROOT\_ELEMENT
    - UNEXPECTED\_TEXT
    - UNKNOWN\_ROOT\_ELEMENT
    - UNKNOWN\_ATTRIBUTE
    - MISSING\_ATTRIBUTE
    - INVALID\_ATTRIBUTE\_VALUE
    - DOM\_KEYCONSTRAINT
    - DOM\_XPATH\_BOOLEAN
    - INVALID\_KEYREF
    - INVALID\_VALUE
    - UNKNOWN\_GLOBAL\_ID
    - UNKNOWN\_ID


    For more detailed information see section Recovering.

**delete**
: This method deletes the validation command.

**info** *?args?*
: This method bundles methods to query the state of and details about the schema command.

    **validationstate**
    : This method returns the state of the validation command with respect to validation state. The possible return values and their meanings are:

        READY
        : The validation command is ready to start validation

        VALIDATING
        : The validation command is in the process of validating input.

        FINISHED
        : The validation has finished, no further events are expected.


    **vstate**
    : This method is a shorter alias for validationstate; see there.

    **line**
    : If the schema command is currently validating, this method returns the line part of the parsing position information, and the empty string in all other cases. If the schema command is currently post-validating a DOM tree, there may be no position information stored at some or all nodes. The empty string is returned in these cases.

    **column**
    : If the schema command is currently validating this method returns the column part of the parsing position information, and the empty string in all other cases. If the schema command is currently post-validating a DOM tree, there may be no position information stored at some or all nodes. The empty string is returned in these cases.

    **byteIndex**
    : If the schema command is currently validating this method returns the byte position of the parsing position information, and the empty string in all other cases. If the schema command is currently post-validating a DOM tree, there may be no position information stored at some or all nodes. The empty string is returned in these cases.

    [domNode]
    : If the schema command isn't currently post-validating a DOM tree this method returns the empty string. Otherwise, if the schema command waits for the reportcmd script to finish while recovering from a validation error it returns the node on which the validation engine is currently looking at in case the node is an ELEMENT\_NODE or, if not, its parent node. It is recommended that you do not use this method. Or at least leave the DOM tree alone, use it read-only.

    **nrForwardDefinitions**
    : Returns how many elements, element types and ref patterns are referenced that aren't defined so far (summed together).

    **definedElements**
    : Returns in no particular order the defined elements in the grammar as list. If an element is namespaced, its list entry will be itself a list with two elements, with the name as first and the namespace as second element.

    **definedElementtypes**
    : Returns in no particular order the defined element types in the grammar as list. If an element type is namespaced, its list entry will be itself a list with two elements, with the name as first and the namespace as second element.

    **definedPatterns**
    : Returns in no particular order the defined named pattern in the grammar as list. If a named pattern is namespaced, its list entry will be itself a list with two elements, with the name as first and the namespace as second element.

    **expected**
    : Returns in no particular order all possible next events (since the last successful event match, if there was one) as a list. If an element is namespaced its list entry will be itself a list with two elements, with the name as first and the namespace as second element. If text is a possible next event, the list entry will be a two elements list, with #text as first element and the empty string as second. If an any element constraint is possible the list entry will be a two elements list, with <any> as first element and the empty string as second. If an any element in a certain namespace constraint is possible, the list entry will be a two elements list, with <any> as first element and the namespace as second. If element end is a possible event, the list entry will be a two elements list with <elementend> as first element and the empty string as second element.

    **definition name ?namespace?**
    : Returns the code that defines the given element. The command raises error if there is no definition of that element.

    **typedefinition name ?namespace?**
    : Returns the code that defines the given element type definition. The command raises error if there is no definition of that element.

    **patterndefinition name ?namespace?**
    : Returns the code that defines the given pattern definition. The command raises error if there is no definition of a pattern with that name and, if given, namespace.

    **vaction ?name|namespace|text?**
    : This method returns useful information only if the schema command waits for the reportcmd script to finish while recovering from a validation error. Otherwise it returns NONE.

        If the command is called without the optional argument the possible return values and their meanings are:

        NONE
        : The schema command currently does not recover from a validation event.

        MATCH\_ELEMENT\_START
        : Element start event, which includes looking for missing or unknown attributes.

        MATCH\_ELEMENT\_END
        : Element end event.

        MATCH\_TEXT
        : Validating text between tags.

        MATCH\_ATTRIBUTE\_TEXT
        : Attribute text value constraint check

        MATCH\_GLOBAL
        : Checking global IDs

        MATCH\_DOM\_KEYCONSTRAINT
        : Checking domunique constraint

        MATCH\_DOM\_XPATH\_BOOLEAN
        : Checking domxpathboolean constant


        If called with one of the possible optional arguments, the command returns detail information depending on current action.

        name
        : Returns the name of the element that has to match in case of MATCH\_ELEMENT\_START. Returns the name of the closed element in case of MATCH\_ELEMENT\_END. Returns the name of the attribute in case of MATCH\_ATTRIBUTE\_TEXT. Returns the name of the parent element in case of MATCH\_TEXT.

        namespace
        : Returns the namespace of the element that has to match in case of MATCH\_ELEMENT\_START. Returns the namespace of the closed element in case of MATCH\_ELEMENT\_END. Returns the namespace of the attribute in case of MATCH\_ATTRIBUTE\_TEXT. Returns the namespace of the parent element in case of MATCH\_TEXT.

        text
        : Returns the text to match in case of MATCH\_TEXT. Returns the value of the attribute in case of MATCH\_ATTRIBUTE\_TEXT.


    **stack top|inside|associated**
    : In Tcl scripts evaluated by validation this method provides information about the current validation stack. Called outside this context the method returns the empty string.

        **top**
        : Returns the element whose content is currently checked (the open element tag at this moment).

        **inside**
        : Returns all currently open elements as a list.

        **associated**
        : Returns the data associated with the current top most stack content particle or the empty string if there isn't any.



**reset**
: This method resets the validation command into state READY (while preserving the defined grammar).


# Schema definition scripts

Schema definition scripts are ordinary Tcl scripts evaluated in the namespace tdom::schema. The schema definition commands listed below in this Tcl namespace allow the definition of a wide variety of document structures. Every schema definition command establishes a validation constraint on the content which has to match or must be optional to qualify the content as valid. It is a validation error if there is additional (not matched) content. White-space-only text (in the XML sense of white space) between any different tags is ignored, with the exception of text only elements (for which even white-space-only text will be considered as significant content).

The schema definition commands are:

**element** *name* *?quant?* *(?<definition script>|"type" typename)?*
: If neither the optional argument *definition script* nor the string "type" and a *typename* is given this command refers to the element defined with *defelement* with the name *name* in the current context namespace.

    If the string "type" and a *typename* is given then the content of the element is described by the content model defined with *defelementtype* with the name *typename* in the current context namespace.

    If the *defelement script* argument is given, the validation constraint expects an element with the name *name* in the current namespace with content "locally" defined by the *definition script*. Forward references to so far not defined elements or patterns or other local definitions of the same name inside the *definition script* are allowed. If a forward referenced element is not defined until validation, only an empty element with name *name* and namespace *namespace* and no attributes matches.

**ref** *name* *?quant?*
: This command refers to the content particle defined with *defpattern* with the name *name* in the current context namespace. Forward references to a so far not defined pattern and recursive references are allowed. If a forward referenced pattern is not defined until validation no content whatsoever is expected ("empty match").

**group** *?quant?* *<definition script>*
: This method group a sequence of content particles defined by the *definition script*, which have to match in this sequence order.

**choice** *?quant?* *<definition script>*
: This schema constraint matches if one of the top level content particles defined by the *definition script* matches. If one of this top level content particle is optional this constraint matches the "empty match".

**interleave** *?quant?* *<definition script>*
: This schema constraint matches after every of the required top level content particles defined by the *definition script* have matched (and, optional, some or all other) in any arbitrary order.

**mixed** *?quant?* *<definition script>*
: This schema constraint matches for any text (including the empty one) and every top level content particle defined by the *definition script* with default quantifier \*.

**text** *?<constraint script>|"type" typename?*
: Without the optional constraint script this validation constraint matches every string (including the empty one). With *constraint script* or with a given text type argument a text matching this script or the text type is expected.

**any** ?*options***?** *?<namespace list>?* *?quant?*
: Without arguments the any command matches every element. If the *<namespace list>* argument is given, this matches any element in a namespace out of that list. The empty string means elements with no namespace. If additionally the option *-not* is given then this maches every element with a namespace not in the list. The only other recognized option is *--* which signals the end of any options. Please note that in case of no *namespace* argument is given that means that the quantifier \* and + will eat up any elements until the enclosing element ends. If you really have a namespace that looks like a valid tDOM schema quantifier you will have to spell out always both arguments.

**attribute** *name* *?quant?* *(?<constraint script>|"type" typename?)*
: The attribute command defines an attribute (in no namespace) to the enclosing element. The first definition of *name* inside an element definition wins; later definitions of the same name are silently ignored. After the *name* argument there may be one of the quantifiers ? or !. If there is, it will be used. Otherwise the attribute will be required (must be present in the XML source). If there is one argument more this argument is evaluated as constraint script, defining the value constraints of the attribute. Otherwise, if there are two more arguments and the first of them is the bare-word "type" the following argument is used as a text type name. This command is only allowed at top level in the definition script of a defelement/element script.

**nsattribute** *name* *namespace* *?quant?* *(?<constraint script>|"type" typename?)*
: This command does the same as the command *attribute*, for the attribute *name* in the namespace *namespace*.

**namespace** *URI* *<definition script>*
: Evaluates the *definition script* with context namespace *URI*. Every element, element type or ref command name will be looked up in the namespace *URI*, and local defined elements will be in that namespace. An empty string as *URI* means no namespace.

**tcl** *tclcmd* *?arg arg ...?*
: Evaluates the Tcl script *tclcmd arg arg ...* . This validation command is only allowed in strict sequential context (not in choice, mixed and interleave). If the return code is something else than TCL\_OK, this is an error (which is not caught and reported by reportcmd).

**self**
: Returns the schema command.

**associate** *data*
: This command is only allowed top-level inside definition scripts of the element, elementtype, pattern or interleave content particles. Associates the *data* given as argument with the currently defined content particle and may be requested in scripts evaluated while validating the content of that particle with the schema command method call *info stack associated*.

**domunique** *selector* *fieldlist* *?name?* *?"IGNORE\_EMPTY\_FIELD\_SET"|("EMPTY\_FIELD\_SET\_VALUE" emptyFieldSetValue)?*
: If not postvalidating a DOM tree with *domvalidate* this constraint always matches. If postvalidating this constraint resembles the xsd key/keyref mechanism. The *selector* argument may be any valid XPath expression (without the xsd limits). Several *domunique* commands within one element definition are allowed. They are checked in definition order. The argument name is available in the recovering script per *info vaction name*. If the *fieldlist* does not select something for a node of the result set of the *selector* the key value will be the empty string by default. If the arguments *EMPTY\_FIELD\_SET\_VALUE <value>* are given an empty node set will have the key value *value*. If instead the flag *IGNORE\_EMPTY\_FIELD\_SET* flag is given an empty node set result will not have any key value.

**domxpathboolean** *XPath\_expr* *?name?*
: If not postvalidating a DOM tree with *domvalidate* this constraint always matches. If postvalidating the *XPath\_expr* argument is evaluated (with the node matching the schema parent of the *domxpathboolean* command as context node). The constraint maches if the result of this XPath expression, converted to boolean by XPath rules, is true. Several *domxpathboolean* commands within one element definition are allowed. They are checked in definition order.

    This enables checks depending on more than one element. Consider

    ```
    tdom::schema s
    s define {
        defelement doc {
            element a ! text
            element b ! text
            element c ! text
            domxpathboolean "a * b * c >= 20000" volume
            domxpathboolean "a > b and b > c" sequence
        }
    }
    ```

**jsontype** *JSON structure type*
: If not postvalidating a DOM tree with *domvalidate* this constraint always matches. If postvalidating the constraint matches if the enclosing element has the JSON type given as argument to the structure constraint. The possible JSON structure types are *NONE*, *OBJECT* and *ARRAY*. This constraint is only allowed as direct child of a defelement, defelementtype or local element definition.

**prefixns**         *?prefixUriList?*
: This defines a prefix to namespace URI mapping exactly as a *schemacmd prefixns* would. It is meant as top-level command of a *schemacmd define* script. This command is not allowed nested in another definition script command and will raise error, if you call it there.

**defelement** *name* *?namespace?* *<definition script>*
: This defines an element exactly as a *schemacmd defelement* call would. It is meant as top-level command of a *schemacmd define* script. This command is not allowed nested in another definition script command and will raise error, if you call it there.

**defelementtype** *typename* *?namespace?* *<definition script>*
: This defines an elementtype exactly as a *schemacmd defelementtype* call would. It is meant as top-level command of a *schemacmd define* script. This command is not allowed nested in another definition script command and will raise error, if you call it there.

**defpattern** *name* *?namespace?* *<definition script>*
: This defines a named pattern exactly as a *schemacmd defpattern* call would. It is meant as top-level command of a *schemacmd define* script. This command is not allowed nested in another definition script command and will raise error, if you call it there.

**deftexttype** *name* *<constraint script>*
: This defines a named bundle of text constraints exactly as a *schemacmd deftexttype* call would. It is meant as top-level command of a *schemacmd define* script. This command is not allowed nested in another definition script command and will raise error, if you call it there.

**start** *name* *?namespace?*
: This command works exactly as a *schemacmd start* call would. It is meant as top-level command of a *schemacmd define* script. This command is not allowed nested in another definition script command and will raise error, if you call it there.


# Quantity specifier

Several schema definition commands expect a quantifier as one of their arguments which determines how often the content particle specified by the command is expected. The valid values for a *quant* argument are:

**!**
: The content particle has to occur exactly once in valid documents.

**?**
: The content particle may not occur more than once in valid documents - the particle is optional.

**\***
: The content particle may occur zero or more times in a row in valid documents.

**+**
: The content particle may occur one or more times in a row in valid documents.

**n**
: The content particle must occur n times in a row in valid documents. The quantifier must be an integer greater zero.

**{n m}**
: The content particle must occur at least n and at most m times in a row in valid documents. The quantifier must be a Tcl list with two elements. The first element of this list must be an integer with n >= 0. If the second list element is the character \*, then there is no upper limit. Otherwise the second list element must be an integer with n < m.


If an optional quantifier is not given, it defaults to \* in case of the *mixed* command and to ! for all other commands.

# Text constraint scripts

Text (parsed character data, as XML calls it) sometimes has to be of a certain kind or comply with certain rules to be valid. The text constraint script arguments to text, attribute, nsattribute and deftexttype commands are evaluated in the Tcl namespace *tdom::schema::text* namespace and allow the ensuing text constraint commands to check text for certain properties. The commands are defined in the Tcl namespace *tdom::schema::text*. They raise error in case they are called outside of a text constraint script.

A few of the ensuing text type commands are exposed as general Tcl commands. They are defined in the namespace tdom::type and are called as documented below with the text to check appended to the argument list. They return a logical value. Please note that the commands may not accept starting or ending white space. If a command is available in the tdom::type namespace is recorded in its documentation.

## The tcl text constraint command

The *tcl* text constraint command dispatches the check to an arbitrary Tcl command, thus enable any programmable decision rules.

**tcl** *tclcmd* *?arg arg ...?*
: Evaluates the Tcl script *tclcmd arg arg ...*  and the text to validate appended to the argument list. The return value of the Tcl command is interpreted as a boolean.


## Basic XML types

**name**
: <https://www.w3.org/TR/xml/#NT-Name> This text constraint matches if the text value matches the XML name production . This means that the text value must start with a letter, underscore (\_), or colon (:), and may contain only letters, digits, underscores (\_), colons (:), hyphens (-), and periods (.).

**ncname**
: <https://www.w3.org/TR/xml-names/#NT-NCName> This text constraint matches if the text value matches the XML ncname production . This means that the text value must start with a letter or underscore (\_), and may contain only letters, digits, underscores (\_), hyphens (-), and periods (.) (The only difference to the name constraint is that colons are not permitted.)

**qname**
: <https://www.w3.org/TR/xml-names/#NT-QName> This text constraint matches if the text value matches the XML qname production . This means that the text value is either a ncname or two ncnames joined by a colon (:).

**nmtoken**
: <https://www.w3.org/TR/xml/#NT-Nmtoken> This text constraint matches if the text value matches the XML nmtoken production

**nmtokens**
: <https://www.w3.org/TR/xml/#NT-Nmtokens> This text constraint matches if the text value matches the XML nmtokens production


## Basic type tests

**integer** *?(xsd|tcl)?*
: This text constraint matches if the text value could be parsed as an integer. If the optional argument to the command is *tcl*, everything that returns TCL\_OK if fed into Tcl\_GetInt() matches. If the optional argument to the command is *xsd*, the constraint matches if the value is a valid xsd:integer. Without argument *xsd* is the default.

**negativeInteger** *?(xsd|tcl)?*
: This text constraint matches the same text values as the *integer* text constraint (see there), with the additional constraint, that the value must be < zero.

**nonNegativeInteger** *?(xsd|tcl)?*
: This text constraint matches the same text values as the *integer* text constraint (see there), with the additional constraint, that the value must be >= zero.

**nonPositiveInteger** *?(xsd|tcl)?*
: This text constraint matches the same text values as the *integer* text constraint (see there), with the additional constraint, that the value must be <= zero.

**positiveInteger** *?(xsd|tcl)?*
: This text constraint matches the same text values as the *integer* text constraint (see there), with the additional constraint, that the value must be > zero.

**number** *?(xsd|tcl)?*
: This text constraint matches if the text value could be parsed as a number. If the optional argument to the command is *tcl*, everything that returns TCL\_OK if fed into Tcl\_GetDouble() matches. If the optional argument to the command is *xsd*, the constraint matches if the value is a valid xsd:decimal. Without argument *xsd* is the default.

**boolean** *?(xsd|tcl)?*
: This text constraint matches if the text value could be parsed as a boolean. If the optional argument to the command is *tcl*, everything that returns TCL\_OK if fed into Tcl\_GetBoolean() matches. If the optional argument to the command is *xsd*, the constraint matches if the value is a valid xsd:boolean. Without argument *xsd* is the default.

**date**
: This text constraint matches if the text value is a xsd:date, which is basically like an ISO 8601 date of the form YYYY-MM-DD, with optional time zone part (either the letter Z or plus (+) or minus (-) followed by hh:mm and with maximum allowed positive or negative time zone 14:00). It follows the date rules of the Gregorian calendar for all dates. A preceding minus sign for bce dates is allowed. There is no year 0. The year may have more than 4 digits, but only if needed (no extra leading zeros). This is available as common Tcl command tdom::type::date.

**time**
: This text constraint matches if the text value is a xsd:time, which is basically like an ISO 8601 time of the form hh:mm:ss with optional time zone part. The time zone part follow the rules of the *date* command; see there. All three parts of the time value (hours, minutes, seconds) must be spelled out with 2 digits. Additional fractional seconds (with a point ('.') as separator) are allowed, but not just a dangling point. The time value 24:00:00 (without fractional part) is allowed. This is available as common Tcl command tdom::type::time.

**dateTime**
: This text constraint matches if the text value is a xsd:dateTime, which is basically like an ISO 8601 date time of the form YYYY-MM-DDThh:mm:ss with optional time zone part. The date and time zone parts follows the rules of the *date* and *time* command; see there. The time part (including the signaling 'T' character) is mandatory. This is available as common Tcl command tdom::type::dateTime.

**duration**
: This text constraint matches if the text value is a xsd:duration, which is basically like an ISO 8601 duration of the form PnYnMnDTnHnMnS. All parts other than the starting P and - if one of H, M or S is given - T are optional. In case the following sign letter is S, n may be a decimal (with at least one digit before and after the dot), otherwise it must be a (positive) integer. This is available as common Tcl command tdom::type::duration.

**base64**
: This text constraint matches if text is valid according to RFC 4648. This is available as common Tcl command tdom::type::base64.

**hexBinary**
: This text constraint matches if text is a sequence of binary octets in hexadecimal encoding, where each binary octet is a two-character hexadecimal number. Lowercase and uppercase letters A through F are permitted.

**unsignedByte**
: This text constraint matches if the text value is a xsd:unsignedByte. This is an integer between 0 and 255, both included, optionally preceded by a + sign and leading zeros.

**unsignedShort**
: This text constraint matches if the text value is a xsd:unsignedShort. This is an integer between 0 and 65535, both included, optionally preceded by a + sign and leading zeros.

**unsignedInt**
: This text constraint matches if the text value is a xsd:unsignedInt. This is an integer between 0 and 4294967295, both included, optionally preceded by a + sign and leading zeros.

**unsignedLong**
: This text constraint matches if the text value is a xsd:unsignedLong. This is an integer between 0 and 18446744073709551615, both included, optionally preceded by a + sign and leading zeros.

**byte**
: This text constraint matches if the text value is a xsd:byte. This is an integer between -128 and 127, both included, optionally preceded by a + or a - sign and leading zeros.

**short**
: This text constraint matches if the text value is a xsd:short. This is an integer between -32768 and 32767, both included, optionally preceded by a + or a - sign and leading zeros.

**int**
: This text constraint matches if the text value is a xsd:int. This is an integer between -2147483648 and 2147483647, both included, optionally preceded by a + or a - sign and leading zeros.

**long**
: This text constraint matches if the text value is a xsd:long. This is an integer between -9223372036854775808 and 9223372036854775807, both included, optionally preceded by a + or a - sign and leading zeros.


## Logical constructs

**oneOf** *<constraint script>*
: This text constraint matches if one of the text constraints defined in the argument *constraint script* matches the text. It stops after the first matches and probes the text constraints in the order of definition.

**allOf** *<constraint script>*
: This text constraint matches if all of the text constraints defined in the argument *constraint script* matches the text. It stops after the first match failure and probes the text constraints in the order of definition. Since the schema definition command *text* also expects all text constraints to match the text constraint, *allOf* is useful mostly in connection with the *oneOf* text constraint command.

**not** *<constraint script>*
: This text constraint matches if none of the text constraints defined in the argument *constraint script* matches the text. It stops after the first matching constraint in the *constraint script* and reports validation error. The text constraints in the *constraint script* are probed in the order of definition.

**type** *text type name*
: This text constraint matches if the text type given as argument matches.


## Constraints on processed text value

**whitespace** *(preserve|replace|collapse)* *<constraint script>*
: This text constraint command does white-space (#x20 (space, ' '), #x9 (tab, \\t), #xA (linefeed, \\n), and #xD (carriage return, \\r) normalization to the text value and checks the resulting text with the text constraints of the constraint script argument. The normalization method *preserve* keeps everything as it is; this is another way to say *allOf*. The *replace* normalization method replaces any single white-space character (as above) to a space. The *collapse* normalization method removes all leading and trailing white-space, and all the other sequences of contiguous white-space are replaced by a single space.

**split** *?type ?args??<constraint script>*
: This text constraint command splits the text to test into a list of values and tests all elements of that list for the text constraints in the evaluated *constraint script*.

    The available types are:

    whitespace
    : The text to split is stripped of all white space at start and end and split into a list at any successive white space.

    tcl tclcmd ?arg ...?
    : The text to split is handed to the *tclcmd*, which is evaluated on global level, appended with every given arg and the text to split as last argument. This call must return a valid Tcl list whose elements are tested.


    The default in case no split type argument is given is *whitespace*.

**strip** *<constraint script>*
: This text constraint command tests all text constraints in the evaluated *constraint script* with the text to test stripped of all white space at start and end.


## Various other string properties

**fixed** *value*
: The text constraint only matches if the text value is string equal to the given value.

**enumeration** *list*
: This text constraint matches if the text value is equal to one element (respecting case and any white-space) of the argument *list*, which has to be a valid Tcl list.

**match** *?-nocase?* *glob\_style\_match\_pattern>*
: <https://www.tcl.tk/man/tcl8.6/TclCmd/string.htm#M35> This text constraint matches if the text value matches the glob style pattern given as argument. It follows the rules of the Tcl \[string match\] command, see .

**regexp** *expression*
: <https://www.tcl.tk/man/tcl8.6/TclCmd/re_syntax.htm> This text constraint matches if the text value matches the regular expression given as argument.  describes the regular expression syntax

**length** *length*
: This text constraint matches if the length of the text value (in characters, not bytes) is *length*. The length argument must be a positive integer or zero.

**maxLength** *length*
: This text constraint matches if the length of the text value (in characters, not bytes) is at most *length*. The length argument must be an integer greater zero.

**minLength** *length*
: This text constraint matches if the length of the text value (in characters, not bytes) is at least *length*. The length argument must be an integer greater zero.

**id** *?keySpace?*
: This text constraint command marks the text as a document wide ID (to be referenced by an idref). Every ID value within a document must be unique. It isn't an error if the ID isn't actually referenced within the document. The optional argument *keySpace* does all this for a named key space. The key space "" (the empty sting) is another key space then the *id* command without keySpace argument.

**idref** *?keySpace?*
: This text constraint command expects the text to be a reference to an ID within the document. The referenced ID may appear later in the document than the reference. Several references within the document to one ID are possible. For the optional *keySpace* argument see *id*

**jsontype** *<JSON text type>*
: If not postvalidating a DOM tree with *domvalidate* this constraint always matches. If postvalidating the current TEXT\_NODE to check must have the JSON text type given as argument to the text constraint command. The possible types are *NULL*, *TRUE*, *FALSE*, *STRING* and *NUMBER*.


# Local key constraints

Document wide uniqueness and foreign key constraints are available with the text constraint commands id and idref. Keyspaces allow for sub-tree local uniqueness and foreign key constraints.

**keyspace** *<names list>* *<constraint script>*
: Any number of keyspaces are possible. A keyspace is either active or not. An inside a *constraint script* called keyspace with the same name does nothing.


This text constraint commands work with keyspaces:

**key** *<name>*
: If the keyspace with the name *<name>* is not active the constraint always matches. If the keyspace is active, reports error if there is already a key with the value. Otherwise it stores the value as key in this keyspace and matches.

**keyref** *<name>*
: If the keyspace with the name *<name>* is not active always matches. If the keyspace is active then reports error if there is still no key as the value at the end of the keyspace *<name>*. Otherwise, it matches.


# Recovering

By default the validation engine stops at the first detected validation violation and reports that finding. It does so by return false (and sets, if given, the result variable with an error message) in case the schema command itself is used to validate input. If the schema command is used by a SAX parser or the DOM parser, it does so by throwing error.

If a *reportcmd* is set this command is called on global level appended with the schema command and an error type as arguments in case a validation violation is detected. Then the validation recovers from the error and continues. For some validation errors the recover strategy can be determined with the script result of the reportcmd.

With a *reportcmd* (as long as the *reportcmd* does not throw error while called) the validation engine will never report validation failure to its caller. The validation engine recovers, continues, and reports the next error (if occurring) and so on until the end of the input. The schema command will return true and the SAX parser and DOM builder will process normally until the end of the input, as if there had not been a validation error.

Please note that this happens only for validation errors. It is not possible to recover from well-formedness errors. If the input is not well-formed, the schema command returns false and sets (if given) the result variable with an error message about the well-formedness error.

If the *reportcmd* throws error while called by the validation engine then validation stops and the schema command throws error with the error message of the script.

While validating basically three events can happen: an element start tag has to match, a piece of text has to match or an element end tag has to match. The method *info vaction* called in the recovering script or any script code called from there returns, which event has triggered the error report (MATCH\_ELEMENT\_START, MATCH\_TEXT, MATCH\_ELEMENT\_END, respectively). While the command walks throu the schema looking whether the event matches other, data driven events (as, for example checking, if any keyref within a keyspace exists) may happen.

Several of the validation error codes, appended as second argument to the *reportcmd* calls, may happen at more than one kind of validation event. The *info vaction* method and its subcommands provide information about the current validation event, if called from the report command.

If a structural validation error happens, the default recovering strategy is to ignore any following (or missing) content within the current subtree and to continue with the element end event of the subtree.

Returning "ignore" from the recovering script in case of error type MISSING\_ELEMENT recovers by ignoring the failed constraint and continues to match the event further against the schema.

Returning "vanish" from the recover script in case of the error types MISSING\_ELEMENT and UNEXPECTED\_ELEMENT recovers by ignoring the event.

# Examples

<https://www.w3.org/TR/xmlschema-0/> The XML Schema Part 0: Primer Second Edition () starts with this example schema:

```
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">

  <xsd:annotation>
    <xsd:documentation xml:lang="en">
     Purchase order schema for Example.com.
     Copyright 2000 Example.com. All rights reserved.
    </xsd:documentation>
  </xsd:annotation>

  <xsd:element name="purchaseOrder" type="PurchaseOrderType"/>

  <xsd:element name="comment" type="xsd:string"/>

  <xsd:complexType name="PurchaseOrderType">
    <xsd:sequence>
      <xsd:element name="shipTo" type="USAddress"/>
      <xsd:element name="billTo" type="USAddress"/>
      <xsd:element ref="comment" minOccurs="0"/>
      <xsd:element name="items"  type="Items"/>
    </xsd:sequence>
    <xsd:attribute name="orderDate" type="xsd:date"/>
  </xsd:complexType>

  <xsd:complexType name="USAddress">
    <xsd:sequence>
      <xsd:element name="name"   type="xsd:string"/>
      <xsd:element name="street" type="xsd:string"/>
      <xsd:element name="city"   type="xsd:string"/>
      <xsd:element name="state"  type="xsd:string"/>
      <xsd:element name="zip"    type="xsd:decimal"/>
    </xsd:sequence>
    <xsd:attribute name="country" type="xsd:NMTOKEN"
                   fixed="US"/>
  </xsd:complexType>

  <xsd:complexType name="Items">
    <xsd:sequence>
      <xsd:element name="item" minOccurs="0" maxOccurs="unbounded">
        <xsd:complexType>
          <xsd:sequence>
            <xsd:element name="productName" type="xsd:string"/>
            <xsd:element name="quantity">
              <xsd:simpleType>
                <xsd:restriction base="xsd:positiveInteger">
                  <xsd:maxExclusive value="100"/>
                </xsd:restriction>
              </xsd:simpleType>
            </xsd:element>
            <xsd:element name="USPrice"  type="xsd:decimal"/>
            <xsd:element ref="comment"   minOccurs="0"/>
            <xsd:element name="shipDate" type="xsd:date" minOccurs="0"/>
          </xsd:sequence>
          <xsd:attribute name="partNum" type="SKU" use="required"/>
        </xsd:complexType>
      </xsd:element>
    </xsd:sequence>
  </xsd:complexType>

  <!-- Stock Keeping Unit, a code for identifying products -->
  <xsd:simpleType name="SKU">
    <xsd:restriction base="xsd:string">
      <xsd:pattern value="\d{3}-[A-Z]{2}"/>
    </xsd:restriction>
  </xsd:simpleType>

</xsd:schema>
```

A simple one-to-one translation of that into a tDOM schema definition script would be:

```
tdom::schema schema
schema define {

    # Purchase order schema for Example.com.
    # Copyright 2000 Example.com. All rights reserved.

    defelement purchaseOrder {ref PurchaseOrderType}

    foreach elm {comment name street city state product} {
        defelement $elm text
    }

    defpattern PurchaseOrderType {
        element shipTo ! {ref USAddress}
        element billTo ! {ref USAddress}
        element comment ?
        element items
        attribute orderDate date
    }

    defpattern USAddress {
        element name
        element street
        element city
        element state
        element zip ! {text number}
        attribute country {fixed "US"}
    }

    defelement items {
        element item * {
            element product
            element quantity ! {text positiveInteger}
            element USPrice ! {text number}
            element comment
            element shipDate ? {text date}
            attribute partNum {regexp "^\d{3}-[A-Z]{2}$"}
        }
    }
}
```

<http://relaxng.org/tutorial-20011203.html> The RELAX NG Tutorial () starts with this example:

```
Consider a simple XML representation of an email address book:

<addressBook>
  <card>
    <name>John Smith</name>
    <email>js@example.com</email>
  </card>
  <card>
    <name>Fred Bloggs</name>
    <email>fb@example.net</email>
  </card>
</addressBook>

The DTD would be as follows:

<!DOCTYPE addressBook [
<!ELEMENT addressBook (card*)>
<!ELEMENT card (name, email)>
<!ELEMENT name (#PCDATA)>
<!ELEMENT email (#PCDATA)>
]>

A RELAX NG pattern for this could be written as follows:

<element name="addressBook" xmlns="http://relaxng.org/ns/structure/1.0">
  <zeroOrMore>
    <element name="card">
      <element name="name">
        <text/>
      </element>
      <element name="email">
        <text/>
      </element>
    </element>
  </zeroOrMore>
</element>
```

This schema definition script will do the same:

```
tdom::schema schema
schema define {
    defelement addressBook {
        element card *
    }
    defelement card {
        element name
        element email
    }
    foreach e {name email} {
        defelement $e text
    }
}
```


[domNode]: domNode.md
