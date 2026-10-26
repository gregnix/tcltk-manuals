---
CommandName: inifile
ManualSection: n
Version: 0.3.3
TclPart: tcllib
TclDescription: Parsing of Windows INI files
Copyright:
---

# Name

inifile - Parsing of Windows INI files

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [inifile]{.lit} [0.3.3]{.optlit} 
[::ini::open]{.cmd} [file]{.arg} [-encoding encoding]{.optarg} [access]{.optarg} 
[::ini::close]{.cmd} [ini]{.arg} 
[::ini::commit]{.cmd} [ini]{.arg} 
[::ini::revert]{.cmd} [ini]{.arg} 
[::ini::filename]{.cmd} [ini]{.arg} 
[::ini::sections]{.cmd} [ini]{.arg} 
[::ini::keys]{.cmd} [ini]{.arg} [section]{.arg} 
[::ini::get]{.cmd} [ini]{.arg} [section]{.arg} 
[::ini::exists]{.cmd} [ini]{.arg} [section]{.arg} [key]{.optarg} 
[::ini::value]{.cmd} [ini]{.arg} [section]{.arg} [key]{.arg} [default]{.optarg} 
[::ini::set]{.cmd} [ini]{.arg} [section]{.arg} [key]{.arg} [value]{.arg} 
[::ini::delete]{.cmd} [ini]{.arg} [section]{.arg} [key]{.optarg} 
[::ini::comment]{.cmd} [ini]{.arg} [section]{.arg} [key]{.optarg} [text]{.optarg} 
[::ini::commentchar]{.cmd} [char]{.optarg} 
:::

# Description

This package provides an interface for easy manipulation of Windows INI files.

**::ini::open** *file* ?**-encoding** *encoding*? ?*access*?
: Opens an INI file and returns a handle that is used by other commands. *access* is the same as the first form (non POSIX) of the **open** command, with the exception that mode **a** is not supported. The default mode is **r+**. The default *encoding* is the system encoding.

**::ini::close** *ini*
: Close the specified handle. If any changes were made and not written by **commit** they are lost.

**::ini::commit** *ini*
: Writes the file and all changes to disk. The sections are written in arbitrary order. The keys in a section are written in alphabetical order. If the ini was opened in read only mode an error will be thrown.

**::ini::revert** *ini*
: Rolls all changes made to the inifile object back to the last committed state.

**::ini::filename** *ini*
: Returns the name of the file the *ini* object is associated with.

**::ini::sections** *ini*
: Returns a list of all the names of the existing sections in the file handle specified.

**::ini::keys** *ini* *section*
: Returns a list of all they key names in the section and file specified.

**::ini::get** *ini* *section*
: Returns a list of key value pairs that exist in the section and file specified.

**::ini::exists** *ini* *section* ?*key*?
: Returns a boolean value indicating the existance of the specified section as a whole or the specified key within that section.

**::ini::value** *ini* *section* *key* ?*default*?
: Returns the value of the named key and section. If specified, the default value will be returned if the key does not exist. If the key does not exist and no default is specified an error will be thrown.

**::ini::set** *ini* *section* *key* *value*
: Sets the value of the key in the specified section. If the section does not exist then a new one is created.

**::ini::delete** *ini* *section* ?*key*?
: Removes the key or the entire section and all its keys. A section is not automatically deleted when it has no remaining keys.

**::ini::comment** *ini* *section* ?*key*? ?*text*?
: Reads and modifies comments for sections and keys. To write a section comment use an empty string for the *key*. To remove all comments use an empty string for *text*. *text* may consist of a list of lines or one single line. Any embedded newlines in *text* are properly handled.  Comments may be written to nonexistant sections or keys and will not return an error. Reading a comment from a nonexistant section or key will return an empty string.

**::ini::commentchar** ?char?
: Reads and sets the comment character. Lines that begin with this character are treated as comments. When comments are written out each line is preceded by this character. The default is **;**.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *inifile* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
