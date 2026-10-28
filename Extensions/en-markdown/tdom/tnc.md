---
CommandName: tnc
title: tnc
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Keywords:
 - Validation
 - DTD
Copyright:
---

# Name

tnc - tnc is an expat parser object extension, that validates the XML stream against the document DTD while parsing.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdom]{.lit}
[package]{.cmd} [require]{.sub} [tnc]{.lit}

set parser \[expat\]

tnc $parser enable
:::

# Description

*tnc* adds the C handler set "tnc" to a tcl expat parser obj. This handler set is a simple DTD validator. If the validator detects a validation error, it sets the interp result, signals error and stops parsing. There isn't any validation error recovering. As a consequence, only valid documents are completely parsed.

This handler set has only three methods:

**tnc** *parserObj* **enable**
: Adds the tnc C handler set to a Tcl expat parser object.

**tnc** *parserObj* **remove**
: Removes the tnc validatore from the parser *parserObj* and frees all information, stored by it.

**tnc** *parserObj* **getValidateCmd** **?validateCmdName?**
: Returns a new created validation command, if one is available from the parser command, otherwise it signals error. The name of the validation command is the *validateCmdName*, if this optional argument was given, or a random chosen name. A validation command is available in a parser command, if the parser with tnc enabled was previously used, to parse an XML document with a valid doctype declaration, a valid external subset, if one was given by the doctype declaration, and a valid internal subset. The further document doesn't need to be valid, to make the validation command available. The validation command can only get received one time from the parser command. The created validation command has this syntax:

    ```
    validationCmd method ?args?
    ```

    The valid methods are:

    **validateDocument** *domDocument* *?varName?*
    : Checks, if the given domDocument is valid against the DTD information represented by the validation command. Returns 1, if the document ist valid, 0 otherwise. If the *varName* argument is given, then the variable it names is set to the detected reason for the validation error or to the empty string in case of a valid document.

    **validateTree** *elementNode* *?varName?*
    : Checks, if the given subtree with *domNode* as root element is a possible valid subtree of a document conforming to the DTD information represented by the validation command. IDREF could not checked, while validating only a subtree, but it is checked, that every known ID attribute in the subtree is unique. Returns 1, if the subtree is OK, 0 otherwise. If the *varName* argument is given, then the variable it names is set to the detected reason for the validation error or to the empty string in case of a valid subtree.

    **validateAttributes** *elementNode* *?varName?*
    : Checks, if there is an element declaration for the name of the *elementNode* in the DTD represented by the validation command and, if yes, if the attributes of the *elementNode* are conform to the ATTLIST declarations for that element in the DTD. Returns 1, if the attributes and there value types are OK, 0 otherwise. If the *varName* argument is given, then the variable it names is set to the detected reason for the validation error or to the empty string in case the element has all its required attributes, only declared attributes and the values of the attributes matches there type.

    **delete**
    : Deletes the validation command and frees the memory used by it. Returns the empty string.



# Bugs

The validation error reports could be much more informative and user-friendly.

The validator doesn't detect ambiguous content models (see XML recomendation Section 3.2.1 and Appendix E). Most Java validators also doesn't, but handle such content models right anyhow. Tnc does not; if your DTD has such ambiguous content models, tnc can not used to validate documents against such (not completely XML spec compliant) DTDs.

It isn't possible to validate XML documents with standalone="yes" in the XML Declaration

Violations of the validity constraints Proper Group/PE Nesting and Proper Conditional Section/PE Nesting are not detected. They could only happen inside a invalid DTD, not in the content of a document.
