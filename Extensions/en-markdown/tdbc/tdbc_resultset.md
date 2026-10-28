---
CommandName: tdbc::resultset
title: tdbc::resultset
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - encoding(n)
 - tdbc(n)
 - tdbc::connection(n)
 - tdbc::statement(n)
 - tdbc::tokenize(n)
Keywords:
 - TDBC
 - SQL
 - database
 - connectivity
 - connection
 - resultset
 - statement
 - bound variable
 - stored procedure
 - call
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# Name

tdbc::resultset - TDBC result set object

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit}
[package]{.cmd} [require]{.sub} [tdbc::driver]{.lit} [version]{.lit}

[tdbc::driver::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value...]{.optarg}

[set]{.cmd} [stmt]{.arg} [\[db]{.lit} [prepare]{.lit} [sql-code\]]{.arg}
[set]{.cmd} [resultset]{.arg} [\[$stmt]{.lit} [execute]{.lit} [args...?\]]{.optarg}

[$resultset]{.ins} [columns]{.sub}
[$resultset]{.ins} [rowcount]{.sub}
[$resultset]{.ins} [nextrow]{.sub} [[-as]{.lit} lists|dicts]{.optarg} [--]{.optlit} [varname]{.arg}
[$resultset]{.ins} [nextlist]{.sub} [varname]{.arg}
[$resultset]{.ins} [nextdict]{.sub} [varname]{.arg}
[$resultset]{.ins} [nextresults]{.sub}
[$resultset]{.ins} [allrows]{.sub} [-as lists|dicts]{.optlit} [[-columnsvariable]{.lit} [name]{.arg}]{.optarg} [--]{.optlit}
[$resultset]{.ins} [foreach]{.sub} [-as lists|dicts]{.optlit} [[-columnsvariable]{.lit} [name]{.arg}]{.optarg} [--]{.optlit} [varname]{.arg} [script]{.arg}
[$resultset]{.ins} [close]{.sub}
:::

# Description

Every database driver for TDBC (Tcl DataBase Connectivity) implements a *result set* object that represents a the results returned from executing SQL statement in a database. Instances of this object are created by executing the **execute** object command on a statement object.

The **columns** object command returns a list of the names of the columns in the result set. The columns will appear in the same order as they appeared in the SQL statement that performed the database query. If the SQL statement does not return a set of columns (for instance, if it is an INSERT, UPDATE, or DELETE statement), the **columns** command will return an empty list.

The **rowcount** object command returns the number of rows in the database that were affected by the execution of an INSERT, UPDATE or DELETE statement. For a SELECT statement, the row count is unspecified.

The **nextlist** object command sets the variable given by *varname* in the caller's scope to the next row of the results, expressed as a list of column values. NULL values are replaced by empty strings. The columns of the result row appear in the same order in which they appeared on the SELECT statement. The return of **nextlist** is **1** if the operation succeeded, and **0**  if the end of the result set was reached.

The **nextdict** object command sets the variable given by *varname* in the caller's scope to the next row of the results, expressed as a dictionary. The dictionary's keys are column names, and the values are the values of those columns in the row. If a column's value in the row is NULL, its key is omitted from the dictionary. The keys appear in the dictionary in the same order in which the columns appeared on the SELECT statement. The return of **nextdict** is **1** if the operation succeeded, and **0**  if the end of the result set was reached.

The **nextrow** object command is precisely equivalent to the **nextdict** or **nextlist** object command, depending on whether **-as dicts** (the default) or **-as lists** is specified.

Some databases support the idea of a single statement that returns multiple sets of results. The **nextresults** object command is executed, typically after the **nextlist** of **nextdict** object command has returned **0**, to advance to the next result set. It returns **1** if there is another result set to process, and **0** if the result set just processed was the last. After calling **nextresults** and getting the return value of **1**, the caller may once again call **columns** to get the column descriptions of the next result set, and then return to calling **nextdict** or **nextlist** to process the rows of the next result set.  It is an error to call **columns**, **nextdict**, **nextlist** or **nextrow** after **nextresults** has returned **0**.

The **allrows** object command sets the variable designated by the **-columnsvariable** option (if present) to the result of the **columns** object command. It then executes the **nextrow** object command repeatedly until the end of the result set is reached. If **nextresults** returns a nonzero value, it executes the above two steps (**columns** followed by iterated **nextrow** calls) as long as further results are available. The rows returned by **nextrow** are assembled into a Tcl list and become the return value of the **allrows** command; the last value returned from **columns** is what the application will see in **-columnsvariable**.

The **foreach** object command sets the variable designated by the **-columnsvariable** option (if present) to the result of the **columns** object command. It then executes the **nextrow** object command repeatedly until the end of the result set is reached, storing the successive rows in the variable designated by *varName*. For each row, it executes the given *script*. If the script terminates with an error, the error is reported by the **foreach** command, and iteration stops. If the script performs a **break** operation, the iteration terminates prematurely. If the script performs a **continue** operation, the iteration recommences with the next row. If the script performs a **return**, results are the same as if a script outside the control of **foreach** had returned. Any other unusual return code terminates the iteration and is reported from the **foreach**.

Once **nextrow** returns **0**, the **foreach** object command tries to advance to the next result set using **nextresults**.  If **nextresults** returns **1**, the above steps (**columns** and **nextrow**, with script invocation) are repeated as long as more result sets remain. The *script* will always see the correct description of the columns of the current result set in the variable designated byt **-columnsvariable**. At the end of the call, the variable designated by **-columnsvariable** will have the description of the columns of the last result set.

The **close** object command deletes the result set and frees any associated system resources.

# Copyright

Copyright (c) 2008 by Kevin B. Kenny.
