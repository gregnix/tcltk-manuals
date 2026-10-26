---
CommandName: tdbc
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - Tdbc_Init(3)
 - tdbc::connection(n)
 - tdbc::mapSqlState(n)
 - tdbc::resultset(n)
 - tdbc::statement(n)
 - tdbc::tokenize(n)
 - tdbc::mysql(n)
 - tdbc::odbc(n)
 - tdbc::postgres(n)
 - tdbc::sqlite3(n)
Keywords:
 - TDBC
 - SQL
 - database
 - connectivity
 - connection
 - resultset
 - statement
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# Name

tdbc - Tcl Database Connectivity

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit} 
[package]{.cmd} [require]{.sub} [tdbc::driver]{.lit} [version]{.lit} 

[tdbc::driver::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value]{.optdot} 
:::

# Description

Tcl Database Connectivity (TDBC) is a common interface for Tcl programs to access SQL databases. It is implemented by a series of database *drivers*: separate modules, each of which adapts Tcl to the interface of one particular database system.  All of the drivers implement a common series of commands for manipulating the database. These commands are all named dynamically, since they all represent objects in the database system. They include **connections,** which represent connections to a database; **statements,** which represent SQL statements, and **result sets,** which represent the sets of rows that result from executing statements. All of these have manual pages of their own, listed under **SEE ALSO**.

In addition, TDBC itself has a few service procedures that are chiefly of interest to driver writers. **SEE ALSO** also enumerates them.

# Copyright

Copyright (c) 2008 by Kevin B. Kenny.
