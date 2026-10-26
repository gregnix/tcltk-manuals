---
CommandName: pullparser
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: 
Keywords:
 - XML
 - pull
 - parsing
Copyright:
---

# Name

tdom::pullparser - Create an XML pull parser command

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit} 

[tdom::pullparser]{.cmd} [cmdName]{.arg} [-ignorewhitecdata]{.optarg} 
:::

# Description

This command creates XML pull parser commands with a simple API, along the lines of a simple StAX parser. After creation, you've to set an input source, to do anything useful with the pull parser. For this see the methods *input*, *inputchannel* and *inputfile*.

The parser has always a *state*. You start parsing the XML data until some next state, do what has to be done and skip again to the next state. XML well-formedness errors along the way will be reported as TCL_ERROR with additional info in the error message.

The pull parsers don't follow external entities and are XML 1.0 only, they know nothing about XML Namespaces. You get the tags and attribute names as in the source. You aren't noticed about comments, processing instructions and external entities; they are silently ignored for you. CDATA Sections are handled as if their content would have been provided without using a CDATA Section.

On the brighter side is that character entity and attribute default declarations in the internal subset are respected (because of using expat as underlying parser). It is probably somewhat faster than a comperable implementation with the SAX interface. It's a nice programming model. It's a slim interface.

If the option *-ignorewhitecdata* is given, the created XML pull parser command will ignore any white space only (' ', \\t, \\n and \\r) text content between START_TAG and START_TAG / END_TAG. The parser won't stop at such input and will create TEXT state events only for not white space only text.

Not all methods are valid in every state. The parser will raise TCL_ERROR if a method is called in a state the method isn't valid for. Valid methods of the created commands are:

**state**
: This method is valid in all parser states. The possible return values and their meanings are:


**•**
: *READY* - The parser is created or reset, but no input is set.

**•**
: *START_DOCUMENT* - Input is set, parser is ready to start parsing.

**•**
: *START_TAG* - Parser has stopped parsing at a start tag.

**•**
: *END_TAG* - Parser has stopped parsing at an end tag

**•**
: *TEXT* - Parser has stopped parsing to report text between tags.

**•**
: *END_DOKUMENT* - Parser has finished parsing without error.

**•**
: *PARSE_ERROR* - Parser stopped parsing at XML error in input.


**input** *data*
: This method is only valid in state *READY*. It prepares the parser to use *data* as XML input to parse and switches the parser into state START_DOCUMENT.

**inputchannel** *channel*
: This method is only valid in state *READY*. It prepares the parser to read the XML input to parse out of *channel* and switches the parser into state START_DOCUMENT.

**inputfile** *filename*
: This method is only valid in state *READY*. It open *filename* and prepares the parser to read the XML input to parse out of that file. The method returns TCL_ERROR, if the file could not be open in read mode. Otherwise it switches the parser into state START_DOCUMENT.

**next**
: This method is valid in state *START_DOCUMENT*, *START_TAG*, *END_TAG* and *TEXT*. It continues parsing of the XML input until the next event, which it will return.

**tag**
: This method is only valid in states *START_TAG* and *END_TAG*. It returns the tag name of the current start or end tag.

**attributes**
: This method is only valid in state *START_TAG*. It returns all attributes of the element in a name value list.

**text**
: This method is only valid in state *TEXT*. It returns the character data of the event. There will be always at most one TEXT event between START_TAG and the next START_TAG or END_TAG event.

**skip**
: This method is only valid in state *START_TAG*. It skips to the corresponding end tag and ignores all events (but not XML parsing errors) on the way and returns the new state END_TAG.

**find-element**  ? tagname | -names tagnames ?
: This method is only valid in states *START_DOCUMENT*, *START_TAG* and *END_TAG*. It skips forward until the next element start tag with tag name *tagname* and returns the new state START_TAG. If a list of tagnames is provided with the *-names* option, any of the *tagnames* match. If there isn't such an element the parser stops at the end of the input and returns END_DOCUMENT.

**reset**
: This method is valid in all parser states. It resets the parser into READY state and returns that.

**delete**
: This method is valid in all parser states. It deletes the parser command. Miscellaneous methods:

**line**
: This method is valid in all parser states except READY and TEXT. It returns the line number of the parsing position. Line counting starts with 1.

**column**
: This method is valid in all parser states except READY and TEXT. It returns the offset, from the beginning of the current line, of the parsing position. Column counting starts with 0.
