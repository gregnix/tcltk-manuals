---
CommandName: Tk_CreateBindingTable
title: Tk_CreateBindingTable
ManualSection: 3
Version: 4.0
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - binding
 - event
 - object
 - script
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_CreateBindingTable, Tk\_DeleteBindingTable, Tk\_CreateBinding, Tk\_DeleteBinding, Tk\_GetBinding, Tk\_GetAllBindings, Tk\_DeleteAllBindings, Tk\_BindEvent - invoke scripts in response to X events

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
Tk\_BindingTable Tk\_CreateBindingTable(interp)
[Tk\_DeleteBindingTable(bindingTable)]{.cmd}
unsigned long Tk\_CreateBinding(interp, bindingTable, object, eventString, script, append)
int Tk\_DeleteBinding(interp, bindingTable, object, eventString)
const char \* Tk\_GetBinding(interp, bindingTable, object, eventString)
Tk\_GetAllBindings(interp, bindingTable, object)
Tk\_DeleteAllBindings(bindingTable, object)
Tk\_BindEvent(bindingTable, eventPtr, tkwin, numObjects, objectPtr)
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use when invoking bindings in binding table.  Also used for returning results and errors from binding procedures.

[bindingTable]{.carg .in type="Tk_BindingTable"}
: Token for binding table;  must have been returned by some previous call to **Tk\_CreateBindingTable**.

[object]{.carg .in type="ClientData"}
: Identifies object with which binding is associated.

[\*eventString]{.carg .in type="const char"}
: String describing event sequence.

[\*script]{.carg .in type="const char"}
: Tcl script to invoke when binding triggers.

[append]{.carg .in type="int"}
: Non-zero means append *script* to existing script for binding, if any; zero means replace existing script with new one.

[\*eventPtr]{.carg .in type="XEvent"}
: X event to match against bindings in *bindingTable*.

[tkwin]{.carg .in type="Tk_Window"}
: Identifier for any window on the display where the event occurred. Used to find display-related information such as key maps.

[numObjects]{.carg .in type="int"}
: Number of object identifiers pointed to by *objectPtr*.

[\*objectPtr]{.carg .in type="ClientData"}
: Points to an array of object identifiers:  bindings will be considered for each of these objects in order from first to last.

:::

# Description

These procedures provide a general-purpose mechanism for creating and invoking bindings. Bindings are organized in terms of *binding tables*. A binding table consists of a collection of bindings plus a history of recent events. Within a binding table, bindings are associated with *objects*. The meaning of an object is defined by clients of the binding package. For example, Tk keeps uses one binding table to hold all of the bindings created by the [bind] command. For this table, objects are pointers to strings such as window names, class names, or other binding tags such as **all**. Tk also keeps a separate binding table for each canvas widget, which manages bindings created by the canvas's **bind** widget command;  within this table, an object is either a pointer to the internal structure for a canvas item or a [Tk\_Uid][GetUid] identifying a tag.

The procedure **Tk\_CreateBindingTable** creates a new binding table and associates *interp* with it (when bindings in the table are invoked, the scripts will be evaluated in *interp*). **Tk\_CreateBindingTable** returns a token for the table, which must be used in calls to other procedures such as **Tk\_CreateBinding** or **Tk\_BindEvent**.

**Tk\_DeleteBindingTable** frees all of the state associated with a binding table. Once it returns the caller should not use the *bindingTable* token again.

**Tk\_CreateBinding** adds a new binding to an existing table. The *object* argument identifies the object with which the binding is to be associated, and it may be any one-word value. Typically it is a pointer to a string or data structure. The *eventString* argument identifies the event or sequence of events for the binding;  see the documentation for the [bind] command for a description of its format. *script* is the Tcl script to be evaluated when the binding triggers. *append* indicates what to do if there already exists a binding for *object* and *eventString*:  if *append* is zero then *script* replaces the old script;  if *append* is non-zero then the new script is appended to the old one. **Tk\_CreateBinding** returns an X event mask for all the events associated with the bindings. This information may be useful to invoke **XSelectInput** to select relevant events, or to disallow the use of certain events in bindings. If an error occurred while creating the binding (e.g., *eventString* refers to a non-existent event), then 0 is returned and an error message is left as the result of interpreter *interp*.

**Tk\_DeleteBinding** removes from *bindingTable* the binding given by *object* and *eventString*, if such a binding exists. **Tk\_DeleteBinding** always returns [TCL\_OK][catch]. In some cases it may reset the interpreter result to the default empty value.

**Tk\_GetBinding** returns a pointer to the script associated with *eventString* and *object* in *bindingTable*. If no such binding exists then NULL is returned and an error message is left as the result of interpreter *interp*.

**Tk\_GetAllBindings** returns in *interp*'s result a list of all the event strings for which there are bindings in *bindingTable* associated with *object*. If there are no bindings for *object*, the result will be an empty string.

**Tk\_DeleteAllBindings** deletes all of the bindings in *bindingTable* that are associated with *object*.

**Tk\_BindEvent** is called to process an event. It makes a copy of the event in an internal history list associated with the binding table, then it checks for bindings that match the event. **Tk\_BindEvent** processes each of the objects pointed to by *objectPtr* in turn. For each object, it finds all the bindings that match the current event history, selects the most specific binding using the priority mechanism described in the documentation for [bind], and invokes the script for that binding. If there are no matching bindings for a particular object, then the object is skipped. **Tk\_BindEvent** continues through all of the objects, handling exceptions such as errors, [break], and [continue] as described in the documentation for [bind].


[bind]: ../tk/bind.md
[break]: ../tcl/break.md
[catch]: ../tcl/catch.md
[continue]: ../tcl/continue.md
[GetUid]: GetUid.md
