---
CommandName: tdbc::mapSqlState
title: tdbc::mapSqlState
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - tdbc(n)
 - tdbc::tokenize
 - tdbc::connection(n)
 - tdbc::statement(n)
 - tdbc::resultset(n)
Keywords:
 - TDBC
 - SQL
 - database
 - state
Copyright:
 - Copyright (c) 2009 by Kevin B. Kenny.
---

# Name

tdbc::mapSqlState - Map SQLSTATE to error class

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit}

[tdbc::mapSqlState]{.cmd} [sqlstate]{.arg}
:::

# Description

The **tdbc::mapSqlState** command accepts a string that is expected to be a five-character 'SQL state' as returned from a SQL database when an error occurs. It examines the first two characters of the string, and returns an error class as a human- and machine-readable name (for example, **FEATURE\_NOT\_SUPPORTED**, **DATA\_EXCEPTION** or **INVALID\_CURSOR\_STATE**).

The TDBC specification requires database drivers to return a description of an error in the error code when an error occurs. The description is a string that has at least four elements: "**TDBC** *errorClass* *sqlstate* *driverName* *details...*". The **tdbc::mapSqlState** command gives a convenient way for a TDBC driver to generate the *errorClass* element given the SQL state returned from a database.

# Copyright

Copyright (c) 2009 by Kevin B. Kenny.
