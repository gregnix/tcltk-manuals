---
CommandName: Tdbc_Init
title: Tdbc_Init
ManualSection: 3
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - tdbc(n)
 - tdbc::mapSqlState(n)
 - tdbc::tokenize(n)
Keywords:
 - TDBC
 - SQL
 - database
 - tokenize
Copyright:
 - Copyright (c) 2009 by Kevin B. Kenny.
---

# Name

Tdbc\_Init, Tdbc\_MapSqlState, Tdbc\_TokenizeSql - C procedures to facilitate writing TDBC drivers

# Synopsis

::: {.synopsis} :::
**#include <tdbc.h>**

[int]{.ret} [Tdbc\_Init]{.ccmd} [interp]{.cargs}

[Tcl\_Obj \*]{.ret} [Tdbc\_TokenizeSql]{.ccmd} [interp, sqlcode]{.cargs}

[const char \*]{.ret} [Tdbc\_MapSqlState]{.ccmd} [state]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in/out type="Tcl_Interp"}
: Pointer to a Tcl interpreter.

[\*state]{.carg .in type="const char"}
: Pointer to a character string containing a 'SQL state' from a database error.

[\*sqlcode]{.carg .in type="const char"}
: Pointer to a character string containing a SQL statement.

:::

# Description

The TDBC library provides several C procedures that simplify writing a TDBC driver. They include a procedure that tokenizes a SQL statement, locating variables to be substituted, and a procedure that accepts a SQL state and returns an error class for the interpreter error information.

**Tdbc\_Init** must be invoked prior to any other TDBC call.  It accepts a pointer to a Tcl interpreter, and arranges to load the TDBC library. It returns **TCL\_OK** if the Tcl library was loaded successfully, and **TCL\_ERROR** otherwise. If **TCL\_ERROR** is returned, the interpreter's result contains the error message.

**Tdbc\_TokenizeSql** accepts a pointer to a Tcl interpreter, and a pointer to a character string containing one or more SQL statements. It tokenizes the SQL statements, and returns a pointer to a Tcl\_Obj that contains a list of the tokens that make up the statement. Concatenating the tokens together will yield the original SQL code. The returned Tcl\_Obj has a reference count of zero. The caller is responsible for managing the reference count as needed. See [Tokens] below for a description of what may be in the returned list of tokens.

**Tdbc\_MapSqlState** accepts a pointer to a string, usually five characters long, that is the 'SQL state' that resulted from a database error. It returns a character string that is suitable for inclusion as the error class when constructing the error code for an error in a TDBC driver. (By convention, the error code is a list having at least four elements: "**TDBC** *errorClass* *sqlstate* *driverName* *details...*".)

# Tokens

Each token returned from **Tdbc\_TokenizeSql** may be one of the following:

1. A bound variable, which begins with one of the characters '**:**', '**@**', or '**$**'. The remainder of the string is the variable name and will consist of alphanumeric characters and underscores. (The leading character will be be non-numeric.)

2. A semicolon that separates two SQL statements.

3. Something else in a SQL statement. The tokenizer does not attempt to parse SQL; it merely identifies bound variables (distinguishing them from similar strings appearing inside quotes or comments) and statement delimiters.


# Copyright

Copyright (c) 2009 by Kevin B. Kenny.
