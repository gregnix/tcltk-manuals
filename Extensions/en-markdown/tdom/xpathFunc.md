---
CommandName: xpathFunc
title: xpathFunc
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription:
Keywords:
 - XPath
Copyright:
---

# Name

::dom::xpathFunc - Scripted XPath functions

# Synopsis

::: {.synopsis} :::
::dom::xpathFunc::funcName [ctxNode]{.arg} [pos]{.arg} [nodeListType]{.arg} [nodeList]{.arg} [type arg type arg...]{.optarg}
::dom::xpathFunc::namespaceURL::funcName [ctxNode]{.arg} [pos]{.arg} [nodeListType]{.arg} [nodeList]{.arg} [type arg type arg...]{.optarg}
:::

# Description

tDOM's XPath engine supports custom XPath functions implemented by Tcl commands. When it encounters a function call to an unknown function name without a namespace qualifier, the XPath engine looks for a Tcl command of the same name in the **::dom::xpathFunc** namespace. If it encounters an unknown namespace-qualified function call, it looks for a Tcl namespace with a name equal to the function's full namespace URI inside **::dom::xpathFunc**, and a Tcl command named for the local part of the function's name inside that namespace. If it finds such a Tcl command, it is executed with at least the following arguments, to describe the current XPath context:

ctxNode
: The [domNode] object command of the XPath context node.

pos
: The XPath context position, in zero-based form - that is, the return value of the standard XPath **position()** function in the context would be **$pos - 1**.

nodeListType
: The type name for *nodeList*, as for the **selectNodes** method's *typeVar*.

nodeList
: The list of the current worked on XPath step result (as **selectNodes** would return them) in document order. *ctxNode* will be equal to **\[lindex $nodeList $pos\]**.


If the function call includes any arguments, two arguments will be appended to the command's argument list for each one:

type
: The argument's type name, as for **selectNodes**'s *typeVar*.

val
: The argument's value, as **selectNodes** would return it in an XPath expression's result set.


The command is required to return a 1- or 2-element Tcl list to provide the result of the XPath function call. If the result list has two elements, the first is the result's XPath type name, and the second is an appropriately encoded value (note that the *attrnodes* type name is not supported):

bool
: Tcl boolean value acceptable to **Tcl\_GetBooleanFromObj**.

number
: Tcl numeric value acceptable to **Tcl\_GetSizeIntFromObj** or **Tcl\_GetDoubleFromObj**.

string
: Simple string.

nodes
: Tcl list of [domNode] object commands.

attrvalues
: Alias for *string*.


If the result list has only one element, it is treated as a simple string. It is an error for the result to have zero elements, more than two elements, or to be invalid as a Tcl list, and it is an error if the *val* of a two-part result does not match the requirements described above for its *type*.

# Examples

A simple workalike for the XPath 2/3 **fn:matches()** function, not otherwise available in an XPath 1.0 engine such as tDOM's:

```
proc ::dom::xpathFunc::regmatch {
    ctxNode pos nodeListType nodeList
    inputType inputVal patternType patternVal
} {
    set input [::dom::xpathFuncHelper::coerce2string $inputType $inputVal]
    set pattern [::dom::xpathFuncHelper::coerce2string $patternType $patternVal]
    return [list bool [regexp -- $pattern $input]]
}
```

# Helper procs

The **::dom::xpathFuncHelper** namespace contains helper procs for the convenience of scripted XPath functions:

**coerce2number** *type* *val*
: Given a *type* and *val* as provided to scripted XPath functions in their argument lists, convert the *val* to a number in a manner appropriate for its *type*:

    empty
    : Always zero.

    number
    : Unchanged.

    string
    : Unchanged. (Note that no error is raised if *val* is not numeric.)

    attrvalues
    : *value*'s first element.

    nodes
    : The result of the **number()** XPath function called on the first node in the list.

    attrnodes
    : The value of the single attribute assumed to be in *value*. Note that no error is raised if this value is non-numeric.


**coerce2string** *type* *val*
: As for **coerce2number**, but convert *val* to a pure string:

    empty
    : The empty string.

    number
    : Unchanged.

    string
    : Unchanged.

    attrvalues
    : *value*'s first element.

    nodes
    : The result of the **string()** XPath function called on the first node in the list.

    attrnodes
    : The value of the single attribute assumed to be in *value*.



# Limits

Custom XPath function names are limited to 200 characters, including any namespace URI and the **::** Tcl namespace separator between it and the local part. Function calls may have a maximum of 22 arguments (the argument values itself may be large nodesets). If you really need more this limits may be adjusted by build time defines. Tcl commands created with the deprecated **Tcl\_CreateCommand** interface cannot be used as scripted XPath functions.

You **must not** alter any of the DOM trees from which nodes are provided to a scripted XPath function as argument (this is true for the ctxNode argument as well as for the nodes in the nodeList argument). Use them strictly read-only. Ignoring this advice may have any unpredictable results including segmentation faults or security problems.


[domNode]: domNode.md
