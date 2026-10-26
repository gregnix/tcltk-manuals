---
CommandName: Tk_ParseArgv
title: Tk_ParseArgv
ManualSection: 3
Version: unknown
TclPart: Tk
TclDescription: Tk Library Procedures
Keywords:
 - arguments
 - command line
 - options
Copyright:
 - Copyright (c) 1990-1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

Tk\_ParseArgv - process command-line options

# Synopsis

::: {.synopsis} :::
**#include <tk.h>**
[int]{.ret} [Tk\_ParseArgv]{.ccmd} [interp, tkwin, argcPtr, argv, argTable, flags]{.cargs}
:::

# Arguments

::: {.arguments} :::

[\*interp]{.carg .in type="Tcl_Interp"}
: Interpreter to use for returning error messages.

[tkwin]{.carg .in type="Tk_Window"}
: Window to use when arguments specify Tk options.  If NULL, then no Tk options will be processed.

[argcPtr]{.carg .in/out type="int"}
: Pointer to number of arguments in argv;  gets modified to hold number of unprocessed arguments that remain after the call.

[\*\*argv]{.carg .in/out type="const char"}
: Command line arguments passed to main program.  Modified to hold unprocessed arguments that remain after the call.

[\*argTable]{.carg .in type="Tk_ArgvInfo"}
: Array of argument descriptors, terminated by element with type **TK\_ARGV\_END**.

[flags]{.carg .in type="int"}
: If non-zero, then it specifies one or more flags that control the parsing of arguments.  Different flags may be OR'ed together. The flags currently defined are **TK\_ARGV\_DONT\_SKIP\_FIRST\_ARG**, **TK\_ARGV\_NO\_ABBREV**, **TK\_ARGV\_NO\_LEFTOVERS**, and **TK\_ARGV\_NO\_DEFAULTS**.

:::

# Description

**Tk\_ParseArgv** processes an array of command-line arguments according to a table describing the kinds of arguments that are expected. Each of the arguments in *argv* is processed in turn:  if it matches one of the entries in *argTable*, the argument is processed according to that entry and discarded.  The arguments that do not match anything in *argTable* are copied down to the beginning of *argv* (retaining their original order) and returned to the caller.  At the end of the call **Tk\_ParseArgv** sets *\*argcPtr* to hold the number of arguments that are left in *argv*, and *argv\[\*argcPtr\]* will hold the value NULL.  Normally, **Tk\_ParseArgv** assumes that *argv\[0\]* is a command name, so it is treated like an argument that does not match *argTable* and returned to the caller;  however, if the **TK\_ARGV\_DONT\_SKIP\_FIRST\_ARG** bit is set in *flags* then *argv\[0\]* will be processed just like the other elements of *argv*.

**Tk\_ParseArgv** normally returns the value [TCL\_OK][catch].  If an error occurs while parsing the arguments, then [TCL\_ERROR][catch] is returned and **Tk\_ParseArgv** will leave an error message in the result of interpreter *interp* in the standard Tcl fashion.  In the event of an error return, *\*argvPtr* will not have been modified, but *argv* could have been partially modified.  The possible causes of errors are explained below.

The *argTable* array specifies the kinds of arguments that are expected;  each of its entries has the following structure:

```
typedef struct {
    const char *key;
    int type;
    char *src;
    char *dst;
    const char *help;
} Tk_ArgvInfo;
```

The *key* field is a string such as "-display" or "-bg" that is compared with the values in *argv*.  *Type* indicates how to process an argument that matches *key* (more on this below).  *Src* and *dst* are additional values used in processing the argument.  Their exact usage depends on *type*, but typically *src* indicates a value and *dst* indicates where to store the value.  The **char \*** declarations for *src* and *dst* are placeholders:  the actual types may be different.  Lastly, *help* is a string giving a brief description of this option;  this string is printed when users ask for help about command-line options.

When processing an argument in *argv*, **Tk\_ParseArgv** compares the argument to each of the *key*'s in *argTable*. **Tk\_ParseArgv** selects the first specifier whose *key* matches the argument exactly, if such a specifier exists.  Otherwise **Tk\_ParseArgv** selects a specifier for which the argument is a unique abbreviation.  If the argument is a unique abbreviation for more than one specifier, then an error is returned.  If there is no matching entry in *argTable*, then the argument is skipped and returned to the caller.

Once a matching argument specifier is found, **Tk\_ParseArgv** processes the argument according to the *type* field of the specifier.  The argument that matched *key* is called "the matching argument" in the descriptions below.  As part of the processing, **Tk\_ParseArgv** may also use the next argument in *argv* after the matching argument, which is called "the following argument". The legal values for *type*, and the processing that they cause, are as follows:

**TK\_ARGV\_END**
: Marks the end of the table.  The last entry in *argTable* must have this type;  all of its other fields are ignored and it will never match any arguments.

**TK\_ARGV\_CONSTANT**
: *Src* is treated as an integer and *dst* is treated as a pointer to an integer.  *Src* is stored at *\*dst*. The matching argument is discarded.

**TK\_ARGV\_INT**
: The following argument must contain an integer string in the format accepted by **strtol** (e.g. "0" and "0x" prefixes may be used to specify octal or hexadecimal numbers, respectively).  *Dst* is treated as a pointer to an integer;  the following argument is converted to an integer value and stored at *\*dst*.  *Src* is ignored.  The matching and following arguments are discarded from *argv*.

**TK\_ARGV\_FLOAT**
: The following argument must contain a floating-point number in the format accepted by **strtol**. *Dst* is treated as the address of a double-precision floating point value;  the following argument is converted to a double-precision value and stored at *\*dst*.  The matching and following arguments are discarded from *argv*.

**TK\_ARGV\_STRING**
: In this form, *dst* is treated as a pointer to a (char \*); **Tk\_ParseArgv** stores at *\*dst* a pointer to the following argument, and discards the matching and following arguments from *argv*.  *Src* is ignored.

**TK\_ARGV\_UID**
: This form is similar to **TK\_ARGV\_STRING**, except that the argument is turned into a [Tk\_Uid][GetUid] by calling [Tk\_GetUid][GetUid]. *Dst* is treated as a pointer to a [Tk\_Uid][GetUid]; **Tk\_ParseArgv** stores at *\*dst* the [Tk\_Uid][GetUid] corresponding to the following argument, and discards the matching and following arguments from *argv*.  *Src* is ignored.

**TK\_ARGV\_CONST\_OPTION**
: This form causes a Tk option to be set (as if the [option] command had been invoked).  The *src* field is treated as a pointer to a string giving the value of an option, and *dst* is treated as a pointer to the name of the option.  The matching argument is discarded.  If *tkwin* is NULL, then argument specifiers of this type are ignored (as if they did not exist).

**TK\_ARGV\_OPTION\_VALUE**
: This form is similar to **TK\_ARGV\_CONST\_OPTION**, except that the value of the option is taken from the following argument instead of from *src*.  *Dst* is used as the name of the option. *Src* is ignored.  The matching and following arguments are discarded.  If *tkwin* is NULL, then argument specifiers of this type are ignored (as if they did not exist).

**TK\_ARGV\_OPTION\_NAME\_VALUE**
: In this case the following argument is taken as the name of a Tk option and the argument after that is taken as the value for that option.  Both *src* and *dst* are ignored.  All three arguments are discarded from *argv*.  If *tkwin* is NULL, then argument specifiers of this type are ignored (as if they did not exist).

**TK\_ARGV\_HELP**
: When this kind of option is encountered, **Tk\_ParseArgv** uses the *help* fields of *argTable* to format a message describing all the valid arguments.  The message is placed in interpreter *interp*'s result and **Tk\_ParseArgv** returns [TCL\_ERROR][catch].  When this happens, the caller normally prints the help message and aborts.  If the *key* field of a **TK\_ARGV\_HELP** specifier is NULL, then the specifier will never match any arguments;  in this case the specifier simply provides extra documentation, which will be included when some other **TK\_ARGV\_HELP** entry causes help information to be returned.

**TK\_ARGV\_REST**
: This option is used by programs or commands that allow the last several of their options to be the name and/or options for some other program.  If a **TK\_ARGV\_REST** argument is found, then **Tk\_ParseArgv** does not process any of the remaining arguments;  it returns them all at the beginning of *argv* (along with any other unprocessed arguments). In addition, **Tk\_ParseArgv** treats *dst* as the address of an integer value, and stores at *\*dst* the index of the first of the **TK\_ARGV\_REST** options in the returned *argv*.  This allows the program to distinguish the **TK\_ARGV\_REST** options from other unprocessed options that preceded the **TK\_ARGV\_REST**.

**TK\_ARGV\_FUNC**
: For this kind of argument, *src* is treated as the address of a procedure, which is invoked to process the following argument. The procedure should have the following structure:

    ```
    int
    func(dst, key, nextArg)
        char *dst;
        char *key;
        char *nextArg;
    {
    }
    ```

    The *dst* and *key* parameters will contain the corresponding fields from the *argTable* entry, and *nextArg* will point to the following argument from *argv* (or NULL if there are not any more arguments left in *argv*). If *func* uses *nextArg* (so that **Tk\_ParseArgv** should discard it), then it should return 1.  Otherwise it should return 0 and **TkParseArgv** will process the following argument in the normal fashion.  In either event the matching argument is discarded.

**TK\_ARGV\_GENFUNC**
: This form provides a more general procedural escape.  It treats *src* as the address of a procedure, and passes that procedure all of the remaining arguments.  The procedure should have the following form:

    ```
    int
    genfunc(dst, interp, key, argc, argv)
        char *dst;
        Tcl_Interp *interp;
        char *key;
        int argc;
        char **argv;
    {
    }
    ```

    The *dst* and *key* parameters will contain the corresponding fields from the *argTable* entry.  *Interp* will be the same as the *interp* argument to **Tcl\_ParseArgv**. *Argc* and *argv* refer to all of the options after the matching one.  *Genfunc* should behave in a fashion similar to **Tk\_ParseArgv**:  parse as many of the remaining arguments as it can, then return any that are left by compacting them to the beginning of *argv* (starting at *argv*\[0\]).  *Genfunc* should return a count of how many arguments are left in *argv*; **Tk\_ParseArgv** will process them.  If *genfunc* encounters an error then it should leave an error message in interpreter *interp*'s result, in the usual Tcl fashion, and return -1;  when this happens **Tk\_ParseArgv** will abort its processing and return [TCL\_ERROR][catch].


## Flags

**TK\_ARGV\_DONT\_SKIP\_FIRST\_ARG**
: **Tk\_ParseArgv** normally treats *argv\[0\]* as a program or command name, and returns it to the caller just as if it had not matched *argTable*.  If this flag is given, then *argv\[0\]* is not given special treatment.

**TK\_ARGV\_NO\_ABBREV**
: Normally, **Tk\_ParseArgv** accepts unique abbreviations for *key* values in *argTable*.  If this flag is given then only exact matches will be acceptable.

**TK\_ARGV\_NO\_LEFTOVERS**
: Normally, **Tk\_ParseArgv** returns unrecognized arguments to the caller.  If this bit is set in *flags* then **Tk\_ParseArgv** will return an error if it encounters any argument that does not match *argTable*.  The only exception to this rule is *argv\[0\]*, which will be returned to the caller with no errors as long as **TK\_ARGV\_DONT\_SKIP\_FIRST\_ARG** is not specified.

**TK\_ARGV\_NO\_DEFAULTS**
: Normally, **Tk\_ParseArgv** searches an internal table of standard argument specifiers in addition to *argTable*.  If this bit is set in *flags*, then **Tk\_ParseArgv** will use only *argTable* and not its default table.


# Example

Here is an example definition of an *argTable* and some sample command lines that use the options.  Note the effect on *argc* and *argv*;  arguments processed by **Tk\_ParseArgv** are eliminated from *argv*, and *argc* is updated to reflect reduced number of arguments.

```
/*
 * Define and set default values for globals.
 */
int debugFlag = 0;
int numReps = 100;
char defaultFileName[] = "out";
char *fileName = defaultFileName;
Boolean exec = FALSE;

/*
 * Define option descriptions.
 */
Tk_ArgvInfo argTable[] = {
    {"-X", TK_ARGV_CONSTANT, (char *) 1, (char *) &debugFlag,
        "Turn on debugging printfs"},
    {"-N", TK_ARGV_INT, NULL, (char *) &numReps,
        "Number of repetitions"},
    {"-of", TK_ARGV_STRING, NULL, (char *) &fileName,
        "Name of file for output"},
    {"x", TK_ARGV_REST, NULL, (char *) &exec,
        "File to exec, followed by any arguments (must be last argument)."},
    {NULL, TK_ARGV_END, NULL, NULL,
        NULL}
};

main(argc, argv)
    int argc;
    char *argv[];
{
    ...

    if (Tk_ParseArgv(interp, tkwin, &argc, argv, argTable, 0) != TCL_OK) {
        fprintf(stderr, "%s\n", Tcl_GetString(Tcl_GetObjResult(interp)));
        exit(1);
    }

    /*
     * Remainder of the program.
     */
}
```

Note that default values can be assigned to variables named in *argTable*:  the variables will only be overwritten if the particular arguments are present in *argv*. Here are some example command lines and their effects.

```
prog -N 200 infile        # just sets the numReps variable to 200
prog -of out200 infile    # sets fileName to reference "out200"
prog -XN 10 infile        # sets the debug flag, also sets numReps
```

In all of the above examples, *argc* will be set by **Tk\_ParseArgv** to 2, *argv*\[0\] will be "prog", *argv*\[1\] will be "infile", and *argv*\[2\] will be NULL.


[catch]: ../tcl/catch.md
[GetUid]: GetUid.md
[option]: ../tk/option.md
