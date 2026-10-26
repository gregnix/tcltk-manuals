---
CommandName: Tdbc_Init
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

Tdbc_Init, Tdbc_MapSqlState, Tdbc_TokenizeSql - C procedures to facilitate writing TDBC drivers

# Synopsis

::: {.synopsis} :::
[#include]{.cmd} [\<tdbc.h>]{.lit}

int
[Tdbc_Init]{.cmd}([interp]{.arg})

Tcl_Obj \*
[Tdbc_TokenizeSql]{.cmd}([interp]{.arg}, [sqlcode]{.arg})

const char \*
[Tdbc_MapSqlState]{.cmd}([state]{.arg})
:::

# Arguments

Tcl_Interp *\*interp* (in/out)
: Pointer to a Tcl interpreter.

const char *\*state* (in)
: Pointer to a character string containing a 'SQL state' from a database error.

const char *\*sqlcode* (in)
: Pointer to a character string containing a SQL statement.


# Description

The TDBC library provides several C procedures that simplify writing a TDBC driver. They include a procedure that tokenizes a SQL statement, locating variables to be substituted, and a procedure that accepts a SQL state and returns an error class for the interpreter error information.

**Tdbc_Init** must be invoked prior to any other TDBC call.  It accepts a pointer to a Tcl interpreter, and arranges to load the TDBC library. It returns **TCL_OK** if the Tcl library was loaded successfully, and **TCL_ERROR** otherwise. If **TCL_ERROR** is returned, the interpreter's result contains the error message.

**Tdbc_TokenizeSql** accepts a pointer to a Tcl interpreter, and a pointer to a character string containing one or more SQL statements. It tokenizes the SQL statements, and returns a pointer to a Tcl_Obj that contains a list of the tokens that make up the statement. Concatenating the tokens together will yield the original SQL code. The returned Tcl_Obj has a reference count of zero. The caller is responsible for managing the reference count as needed. See **TOKENS** below for a description of what may be in the returned list of tokens.

**Tdbc_MapSqlState** accepts a pointer to a string, usually five characters long, that is the 'SQL state' that resulted from a database error. It returns a character string that is suitable for inclusion as the error class when constructing the error code for an error in a TDBC driver. (By convention, the error code is a list having at least four elements: "**TDBC** *errorClass* *sqlstate* *driverName* *details...*".)

# Tokens

Each token returned from **Tdbc_TokenizeSql** may be one of the following:

**\[1\]**
: A bound variable, which begins with one of the characters '**:**', '**@**', or '**\$**'. The remainder of the string is the variable name and will consist of alphanumeric characters and underscores. (The leading character will be be non-numeric.)

**\[2\]**
: A semicolon that separates two SQL statements.

**\[3\]**
: Something else in a SQL statement. The tokenizer does not attempt to parse SQL; it merely identifies bound variables (distinguishing them from similar strings appearing inside quotes or comments) and statement delimiters.


# Copyright

Copyright (c) 2009 by Kevin B. Kenny.
