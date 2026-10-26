---
CommandName: fileutil
title: fileutil
ManualSection: n
Version: 1.16.4
TclPart: tcllib
TclDescription: file utilities
Keywords:
 - cat
 - file utilities
 - grep
 - temp file
 - test
 - touch
 - type
Copyright:
---

# Name

fileutil - Procedures implementing some file utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit} [1.16.4]{.optlit}
[::fileutil::lexnormalize]{.cmd} [path]{.arg}
[::fileutil::fullnormalize]{.cmd} [path]{.arg}
[::fileutil::test]{.cmd} [path]{.arg} [codes]{.arg} [msgvar]{.optarg} [label]{.optarg}
[::fileutil::cat]{.cmd} ([options]{.optarg} [file]{.arg})...
[::fileutil::writeFile]{.cmd} [options]{.optarg} [file]{.arg} [data]{.arg}
[::fileutil::appendToFile]{.cmd} [options]{.optarg} [file]{.arg} [data]{.arg}
[::fileutil::insertIntoFile]{.cmd} [options]{.optarg} [file]{.arg} [at]{.arg} [data]{.arg}
[::fileutil::removeFromFile]{.cmd} [options]{.optarg} [file]{.arg} [at]{.arg} [n]{.arg}
[::fileutil::replaceInFile]{.cmd} [options]{.optarg} [file]{.arg} [at]{.arg} [n]{.arg} [data]{.arg}
[::fileutil::updateInPlace]{.cmd} [options]{.optarg} [file]{.arg} [cmd]{.arg}
[::fileutil::fileType]{.cmd} [filename]{.arg}
[::fileutil::find]{.cmd} [basedir ?filtercmd]{.optarg}
[::fileutil::findByPattern]{.cmd} [basedir]{.arg} [-regexp|-glob]{.optlit} [--]{.optlit} [patterns]{.arg}
[::fileutil::foreachLine]{.cmd} [var]{.arg} [filename]{.arg} [cmd]{.arg}
[::fileutil::grep]{.cmd} [pattern]{.arg} [files]{.optarg}
[::fileutil::install]{.cmd} [[-m]{.lit} [mode]{.arg}]{.optarg} [source]{.arg} [destination]{.arg}
[::fileutil::stripN]{.cmd} [path]{.arg} [n]{.arg}
[::fileutil::stripPwd]{.cmd} [path]{.arg}
[::fileutil::stripPath]{.cmd} [prefix]{.arg} [path]{.arg}
[::fileutil::jail]{.cmd} [jail]{.arg} [path]{.arg}
[::fileutil::touch]{.cmd} [-a]{.optlit} [-c]{.optlit} [-m]{.optlit} [[-r]{.lit} [ref\_file]{.arg}]{.optarg} [[-t]{.lit} [time]{.arg}]{.optarg} [filename]{.arg} [...]{.optarg}
[::fileutil::tempdir]{.cmd}
[::fileutil::tempdir]{.cmd} [path]{.arg}
[::fileutil::tempdirReset]{.cmd}
[::fileutil::tempfile]{.cmd} [prefix]{.optarg}
[::fileutil::maketempdir]{.cmd} [[-prefix]{.lit} [str]{.arg}]{.optarg} [[-suffix]{.lit} [str]{.arg}]{.optarg} [[-dir]{.lit} [str]{.arg}]{.optarg}
[::fileutil::relative]{.cmd} [base]{.arg} [dst]{.arg}
[::fileutil::relativeUrl]{.cmd} [base]{.arg} [dst]{.arg}
:::

# Description

This package provides implementations of standard unix utilities.

**::fileutil::lexnormalize** *path*
: This command performs purely lexical normalization on the *path* and returns the changed path as its result. Symbolic links in the path are *not* resolved.

    Examples:

    ```
        fileutil::lexnormalize /foo/./bar
        => /foo/bar

        fileutil::lexnormalize /foo/../bar
        => /bar
    ```

**::fileutil::fullnormalize** *path*
: This command resolves all symbolic links in the *path* and returns the changed path as its result. In contrast to the builtin **file normalize** this command resolves a symbolic link in the last element of the path as well.

**::fileutil::test** *path* *codes* ?*msgvar*? ?*label*?
: A command for the testing of several properties of a *path*. The properties to test for are specified in *codes*, either as a list of keywords describing the properties, or as a string where each letter is a shorthand for a property to test. The recognized keywords, shorthands, and associated properties are shown in the list below. The tests are executed in the order given to the command.

    The result of the command is a boolean value. It will be true if and only if the *path* passes all the specified tests. In the case of the *path* not passing one or more test the first failing test will leave a message in the variable referenced by *msgvar*, if such is specified. The message will be prefixed with *label*, if it is specified. *Note* that the variabled referenced by *msgvar* is not touched at all if all the tests pass.

    *r*ead
    : **file readable**

    *w*rite
    : **file writable**

    *e*xists
    : **file exists**

    e*x*ec
    : **file executable**

    *f*ile
    : **file isfile**

    *d*ir
    : **file isdirectory**


**::fileutil::cat** (?*options*? *file*)...
: A tcl implementation of the UNIX **cat** command.  Returns the contents of the specified file(s). The arguments are files to read, with interspersed options configuring the process. If there are problems reading any of the files, an error will occur, and no data will be returned.

    The options accepted are **-encoding**, **-translation**, **-eofchar**, and **--**. With the exception of the last all options take a single value as argument, as specified by the tcl builtin command **fconfigure**. The **--** has to be used to terminate option processing before a file if that file's name begins with a dash.

    Each file can have its own set of options coming before it, and for anything not specified directly the defaults are inherited from the options of the previous file. The first file inherits the system default for unspecified options.

**::fileutil::writeFile** ?*options*? *file* *data*
: The command replaces the current contents of the specified *file* with *data*, with the process configured by the options. The command accepts the same options as **::fileutil::cat**. The specification of a non-existent file is legal and causes the command to create the file (and all required but missing directories).

**::fileutil::appendToFile** ?*options*? *file* *data*
: This command is like **::fileutil::writeFile**, except that the previous contents of *file* are not replaced, but appended to. The command accepts the same options as **::fileutil::cat**

**::fileutil::insertIntoFile** ?*options*? *file* *at* *data*
: This comment is similar to **::fileutil::appendToFile**, except that the new data is not appended at the end, but inserted at a specified location within the file. In further contrast this command has to be given the path to an existing file. It will not create a missing file, but throw an error instead.

    The specified location *at* has to be an integer number in the range **0** ... \[file size *file*\]. **0** will cause insertion of the new data before the first character of the existing content, whereas \[file size *file*\] causes insertion after the last character of the existing content, i.e. appending.

    The command accepts the same options as **::fileutil::cat**.

**::fileutil::removeFromFile** ?*options*? *file* *at* *n*
: This command is the complement to **::fileutil::insertIntoFile**, removing *n* characters from the *file*, starting at location *at*. The specified location *at* has to be an integer number in the range **0** ... \[file size *file*\] - *n*. **0** will cause the removal of the new data to start with the first character of the existing content, whereas \[file size *file*\] - *n* causes the removal of the tail of the existing content, i.e. the truncation of the file.

    The command accepts the same options as **::fileutil::cat**.

**::fileutil::replaceInFile** ?*options*? *file* *at* *n* *data*
: This command is a combination of **::fileutil::removeFromFile** and **::fileutil::insertIntoFile**. It first removes the part of the contents specified by the arguments *at* and *n*, and then inserts *data* at the given location, effectively replacing the removed by content with *data*. All constraints imposed on *at* and *n* by **::fileutil::removeFromFile** and **::fileutil::insertIntoFile** are obeyed.

    The command accepts the same options as **::fileutil::cat**.

**::fileutil::updateInPlace** ?*options*? *file* *cmd*
: This command can be seen as the generic core functionality of **::fileutil::replaceInFile**. It first reads the contents of the specified *file*, then runs the command prefix *cmd* with that data appended to it, and at last writes the result of that invokation back as the new contents of the file.

    If the executed command throws an error the *file* is not changed.

    The command accepts the same options as **::fileutil::cat**.

**::fileutil::fileType** *filename*
: An implementation of the UNIX **file** command, which uses various heuristics to guess the type of a file.  Returns a list specifying as much type information as can be determined about the file, from most general (eg, "binary" or "text") to most specific (eg, "gif").  For example, the return value for a GIF file would be "binary graphic gif".  The command will detect the following types of files: directory, empty, binary, text, script (with interpreter), executable elf, executable dos, executable ne, executable pe, graphic gif, graphic jpeg, graphic png, graphic tiff, graphic bitmap, html, xml (with doctype if available), message pgp, binary pdf, text ps, text eps, binary gravity\_wave\_data\_frame, compressed bzip, compressed gzip, compressed zip, compressed tar, audio wave, audio mpeg, and link. It further detects doctools, doctoc, and docidx documentation files, and tklib diagrams.

**::fileutil::find** ?*basedir* ?*filtercmd*??
: An implementation of the unix command **find**. Adapted from the Tcler's Wiki. Takes at most two arguments, the path to the directory to start searching from and a command to use to evaluate interest in each file. The path defaults to "*.*", i.e. the current directory. The command defaults to the empty string, which means that all files are of interest. The command takes care *not* to lose itself in infinite loops upon encountering circular link structures. The result of the command is a list containing the paths to the interesting files.

    The *filtercmd*, if specified, is interpreted as a command prefix and one argument is added to it, the name of the file or directory find is currently looking at. Note that this name is *not* fully qualified. It has to be joined it with the result of **pwd** to get an absolute filename.

    The result of *filtercmd* is a boolean value that indicates if the current file should be included in the list of interesting files.

    Example:

    ```
        # find .tcl files
        package require fileutil
        proc is_tcl {name} {return [string match *.tcl $name]}
        set tcl_files [fileutil::find . is_tcl]
    ```

**::fileutil::findByPattern** *basedir* ?**-regexp**|**-glob**? ?**--**? *patterns*
: This command is based upon the **TclX** command **recursive\_glob**, except that it doesn't allow recursion over more than one directory at a time. It uses **::fileutil::find** internally and is thus able to and does follow symbolic links, something the **TclX** command does not do. First argument is the directory to start the search in, second argument is a list of *patterns*. The command returns a list of all files reachable through *basedir* whose names match at least one of the patterns. The options before the pattern-list determine the style of matching, either regexp or glob. glob-style matching is the default if no options are given. Usage of the option **--** stops option processing. This allows the use of a leading '-' in the patterns.

**::fileutil::foreachLine** *var filename cmd*
: The command reads the file *filename* and executes the script *cmd* for every line in the file. During the execution of the script the variable *var* is set to the contents of the current line. The return value of this command is the result of the last invocation of the script *cmd* or the empty string if the file was empty.

**::fileutil::grep** *pattern* ?*files*?
: Implementation of **grep**. Adapted from the Tcler's Wiki. The first argument defines the *pattern* to search for. This is followed by a list of *files* to search through. The list is optional and **stdin** will be used if it is missing. The result of the procedures is a list containing the matches. Each match is a single element of the list and contains filename, number and contents of the matching line, separated by a colons.

**::fileutil::install** ?**-m** *mode*? *source* *destination*
: The **install** command is similar in functionality to the **install** command found on many unix systems, or the shell script distributed with many source distributions (unix/install-sh in the Tcl sources, for example).  It copies *source*, which can be either a file or directory to *destination*, which should be a directory, unless *source* is also a single file.  The ?-m? option lets the user specify a unix-style mode (either octal or symbolic - see **file attributes**.

**::fileutil::stripN** *path* *n*
: Removes the first *n* elements from the specified *path* and returns the modified path. If *n* is greater than the number of components in *path* an empty string is returned. The number of components in a given path may be determined by performing **llength** on the list returned by **file split**.

**::fileutil::stripPwd** *path*
: If, and only if the *path* is inside of the directory returned by \[**pwd**\] (or the current working directory itself) it is made relative to that directory. In other words, the current working directory is stripped from the *path*.  The possibly modified path is returned as the result of the command. If the current working directory itself was specified for *path* the result is the string "**.**".

**::fileutil::stripPath** *prefix* *path*
: If, and only of the *path* is inside of the directory "*prefix*" (or the prefix directory itself) it is made relative to that directory. In other words, the prefix directory is stripped from the *path*. The possibly modified path is returned as the result of the command. If the prefix directory itself was specified for *path* the result is the string "**.**".

**::fileutil::jail** *jail* *path*
: This command ensures that the *path* is not escaping the directory *jail*. It always returns an absolute path derived from *path* which is within *jail*.

    If *path* is an absolute path and already within *jail* it is returned unmodified.

    An absolute path outside of *jail* is stripped of its root element and then put into the *jail* by prefixing it with it. The same happens if *path* is relative, except that nothing is stripped of it. Before adding the *jail* prefix the *path* is lexically normalized to prevent the caller from using **..** segments in *path* to escape the jail.

**::fileutil::touch** ?**-a**? ?**-c**? ?**-m**? ?**-r** *ref\_file*? ?**-t** *time*? *filename* ?*...*?
: Implementation of **touch**. Alter the atime and mtime of the specified files. If **-c**, do not create files if they do not already exist. If **-r**, use the atime and mtime from *ref\_file*. If **-t**, use the integer clock value *time*. It is illegal to specify both **-r** and **-t**. If **-a**, only change the atime. If **-m**, only change the mtime.

    *This command is not available for Tcl versions less than 8.3.*

**::fileutil::tempdir**
: The command returns the path of a directory where the caller can place temporary files, such as "*/tmp*" on Unix systems. The algorithm we use to find the correct directory is as follows:

    1. The directory set by an invokation of **::fileutil::tempdir** with an argument. If this is present it is tried exclusively and none of the following item are tried.

    2. The directory named in the TMPDIR environment variable.

    3. The directory named in the TEMP environment variable.

    4. The directory named in the TMP environment variable.

    5. A platform specific location:

        Windows
        : "*C:\\TEMP*", "*C:\\TMP*", "*\\TEMP*", and "*\\TMP*" are tried in that order.

        (classic) Macintosh
        : The TRASH\_FOLDER environment variable is used.  This is most likely not correct.

        Unix
        : The directories "*/tmp*", "*/var/tmp*", and "*/usr/tmp*" are tried in that order.



    The algorithm utilized is mainly that used in the Python standard library. The exception is the first item, the ability to have the search overridden by a user-specified directory.

**::fileutil::tempdir** *path*
: In this mode the command sets the *path* as the first and only directory to try as a temp. directory. See the previous item for the use of the set directory. The command returns the empty string.

**::fileutil::tempdirReset**
: Invoking this command clears the information set by the last call of \[**::fileutil::tempdir** *path*\]. See the last item too.

**::fileutil::tempfile** ?*prefix*?
: The command generates a temporary file name suitable for writing to, and the associated file.  The file name will be unique, and the file will be writable and contained in the appropriate system specific temp directory. The name of the file will be returned as the result of the command.

    The code was taken from <http://wiki.tcl.tk/772>, attributed to Igor Volobouev and anon.

**::fileutil::maketempdir** ?**-prefix** *str*? ?**-suffix** *str*? ?**-dir** *str*?
: The command generates a temporary directory suitable for writing to. The directory name will be unique, and the directory will be writable and contained in the appropriate system specific temp directory. The name of the directory will be returned as the result of the command.

    The three options can used to tweak the behaviour of the command:

    **-prefix** str
    : The initial, fixed part of the directory name. Defaults to **tmp** if not specified.

    **-suffix** str
    : The fixed tail of the directory. Defaults to the empty string if not specified.

    **-dir** str
    : The directory to place the new directory into. Defaults to the result of **fileutil::tempdir** if not specified.


    The initial code for this was supplied by [Miguel Martinez Lopez](mailto:aplicacionamedida@gmail.com).

**::fileutil::relative** *base* *dst*
: This command takes two directory paths, both either absolute or relative and computes the path of *dst* relative to *base*. This relative path is returned as the result of the command. As implied in the previous sentence, the command is not able to compute this relationship between the arguments if one of the paths is absolute and the other relative.

    *Note:* The processing done by this command is purely lexical. Symbolic links are *not* taken into account.

**::fileutil::relativeUrl** *base* *dst*
: This command takes two file paths, both either absolute or relative and computes the path of *dst* relative to *base*, as seen from inside of the *base*. This is the algorithm how a browser resolves a relative link found in the currently shown file.

    The computed relative path is returned as the result of the command. As implied in the previous sentence, the command is not able to compute this relationship between the arguments if one of the paths is absolute and the other relative.

    *Note:* The processing done by this command is purely lexical. Symbolic links are *not* taken into account.


# Warnings and incompatibilities

**1.14.9**
: In this version **fileutil::find**'s broken system for handling symlinks was replaced with one working correctly and properly enumerating all the legal non-cyclic paths under a base directory.

    While correct this means that certain pathological directory hierarchies with cross-linked sym-links will now take about O(n\*\*2) time to enumerate whereas the original broken code managed O(n) due to its brokenness.

    A concrete example and extreme case is the "*/sys*" hierarchy under Linux where some hundred devices exist under both "*/sys/devices*" and "*/sys/class*" with the two sub-hierarchies linking to the other, generating millions of legal paths to enumerate. The structure, reduced to three devices, roughly looks like

    ```
    	/sys/class/tty/tty0 --> ../../dev/tty0
    	/sys/class/tty/tty1 --> ../../dev/tty1
    	/sys/class/tty/tty2 --> ../../dev/tty1

    	/sys/dev/tty0/bus
    	/sys/dev/tty0/subsystem --> ../../class/tty
    	/sys/dev/tty1/bus
    	/sys/dev/tty1/subsystem --> ../../class/tty
    	/sys/dev/tty2/bus
    	/sys/dev/tty2/subsystem --> ../../class/tty
    ```

    The command **fileutil::find** currently has no way to escape this. When having to handle such a pathological hierarchy It is recommended to switch to package **fileutil::traverse** and the same-named command it provides, and then use the **-prefilter** option to prevent the traverser from following symbolic links, like so:

    ```
        package require fileutil::traverse

        proc NoLinks {fileName} {
            if {[string equal [file type $fileName] link]} {
                return 0
            }
            return 1
        }

        fileutil::traverse T /sys/devices -prefilter NoLinks
        T foreach p {
            puts $p
        }
        T destroy
    ```


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *fileutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Programming tools
