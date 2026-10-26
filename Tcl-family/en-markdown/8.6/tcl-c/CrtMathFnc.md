---
CommandName: Tcl_CreateMathFunc
ManualSection: 3
Version: 8.4
TclPart: Tcl
TclDescription: Tcl Library Procedures
Links:
 - expr(n)
 - info(n)
 - Tcl_CreateObjCommand(3)
 - Tcl_Free(3)
 - Tcl_NewListObj(3)
Keywords:
 - expression
 - mathematical function
Copyright:
 - Copyright (c) 1989-1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tcl_CreateMathFunc, Tcl_GetMathFuncInfo, Tcl_ListMathFuncs - Define, query and enumerate math functions for expressions

# Notice of eventual deprecation

The **Tcl_CreateMathFunc** and **Tcl_GetMathFuncInfo** functions are rendered somewhat obsolete by the ability to create functions for expressions by placing commands in the **tcl::mathfunc** namespace, as described in the **mathfunc** manual page; the API described on this page is not expected to be maintained indefinitely.

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tcl.h>]{.lit}

void
[Tcl_CreateMathFunc]{.cmd}([interp]{.arg}, [name]{.arg}, [numArgs]{.arg}, [argTypes]{.arg}, [proc]{.arg}, [clientData]{.arg})

int
[Tcl_GetMathFuncInfo]{.cmd}([interp]{.arg}, [name]{.arg}, [numArgsPtr]{.arg}, [argTypesPtr]{.arg}, [procPtr]{.arg},
[clientDataPtr]{.arg})

Tcl_Obj \*
[Tcl_ListMathFuncs]{.cmd}([interp]{.arg}, [pattern]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in)
: Interpreter in which new function will be defined.

const char *\*name* (in)
: Name for new function.

int *numArgs* (in)
: Number of arguments to new function;  also gives size of *argTypes* array.

Tcl_ValueType *\*argTypes* (in)
: Points to an array giving the permissible types for each argument to function.

Tcl_MathProc *\*proc* (in)
: Procedure that implements the function.

ClientData *clientData* (in)
: Arbitrary one-word value to pass to *proc* when it is invoked.

int *\*numArgsPtr* (out)
: Points to a variable that will be set to contain the number of arguments to the function.

Tcl_ValueType *\*\*argTypesPtr* (out)
: Points to a variable that will be set to contain a pointer to an array giving the permissible types for each argument to the function which will need to be freed up using *Tcl_Free*.

Tcl_MathProc *\*\*procPtr* (out)
: Points to a variable that will be set to contain a pointer to the implementation code for the function (or NULL if the function is implemented directly in bytecode).

ClientData *\*clientDataPtr* (out)
: Points to a variable that will be set to contain the clientData argument passed to *Tcl_CreateMathFunc* when the function was created if the function is not implemented directly in bytecode.

const char *\*pattern* (in)
: Pattern to match against function names so as to filter them (by passing to *Tcl_StringMatch*), or NULL to not apply any filter.


# Description

Tcl allows a number of mathematical functions to be used in expressions, such as **sin**, **cos**, and **hypot**. These functions are represented by commands in the namespace, **tcl::mathfunc**.  The **Tcl_CreateMathFunc** function is an obsolete way for applications to add additional functions to those already provided by Tcl or to replace existing functions. It should not be used by new applications, which should create math functions using **Tcl_CreateObjCommand** to create a command in the **tcl::mathfunc** namespace.

In the **Tcl_CreateMathFunc** interface, *Name* is the name of the function as it will appear in expressions. If *name* does not already exist in the **::tcl::mathfunc** namespace, then a new command is created in that namespace. If *name* does exist, then the existing function is replaced. *NumArgs* and *argTypes* describe the arguments to the function. Each entry in the *argTypes* array must be one of **TCL_INT**, **TCL_DOUBLE**, **TCL_WIDE_INT**, or **TCL_EITHER** to indicate whether the corresponding argument must be an integer, a double-precision floating value, a wide (64-bit) integer, or any, respectively.

Whenever the function is invoked in an expression Tcl will invoke *proc*.  *Proc* should have arguments and result that match the type **Tcl_MathProc**:

```
typedef int Tcl_MathProc(
        ClientData clientData,
        Tcl_Interp *interp,
        Tcl_Value *args,
        Tcl_Value *resultPtr);
```

When *proc* is invoked the *clientData* and *interp* arguments will be the same as those passed to **Tcl_CreateMathFunc**. *Args* will point to an array of *numArgs* Tcl_Value structures, which describe the actual arguments to the function:

```
typedef struct Tcl_Value {
    Tcl_ValueType type;
    long intValue;
    double doubleValue;
    Tcl_WideInt wideValue;
} Tcl_Value;
```

The *type* field indicates the type of the argument and is one of **TCL_INT**, **TCL_DOUBLE** or **TCL_WIDE_INT**. It will match the *argTypes* value specified for the function unless the *argTypes* value was **TCL_EITHER**. Tcl converts the argument supplied in the expression to the type requested in *argTypes*, if that is necessary. Depending on the value of the *type* field, the *intValue*, *doubleValue* or *wideValue* field will contain the actual value of the argument.

*Proc* should compute its result and store it either as an integer in *resultPtr->intValue* or as a floating value in *resultPtr->doubleValue*. It should set also *resultPtr->type* to one of **TCL_INT**, **TCL_DOUBLE** or **TCL_WIDE_INT** to indicate which value was set. Under normal circumstances *proc* should return **TCL_OK**. If an error occurs while executing the function, *proc* should return **TCL_ERROR** and leave an error message in the interpreter's result.

**Tcl_GetMathFuncInfo** retrieves the values associated with function *name* that were passed to a preceding **Tcl_CreateMathFunc** call.  Normally, the return code is **TCL_OK** but if the named function does not exist, **TCL_ERROR** is returned and an error message is placed in the interpreter's result.

If an error did not occur, the array reference placed in the variable pointed to by *argTypesPtr* is newly allocated, and should be released by passing it to **Tcl_Free**.  Some functions (the standard set implemented in the core, and those defined by placing commands in the **tcl::mathfunc** namespace) do not have argument type information; attempting to retrieve values for them causes a NULL to be stored in the variable pointed to by *procPtr* and the variable pointed to by *clientDataPtr* will not be modified.  The variable pointed to by *numArgsPointer* will contain -1, and no argument types will be stored in the variable pointed to by *argTypesPointer*.

**Tcl_ListMathFuncs** returns a Tcl value containing a list of all the math functions defined in the interpreter whose name matches *pattern*.  The returned value has a reference count of zero.
