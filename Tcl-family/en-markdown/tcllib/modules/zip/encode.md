---
CommandName: zipfile::encode
ManualSection: n
Version: 0.5.2
TclPart: tcllib
TclDescription: Zip archive handling
Keywords:
 - compression
 - zip
Copyright:
 - Copyright (c) 2008-2009 Andreas Kupries
---

# Name

zipfile::encode - Generation of zip archives

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [Trf]{.lit} 
[package]{.cmd} [require]{.sub} [crc32]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [zlibtcl]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[package]{.cmd} [require]{.sub} [zipfile::encode]{.lit} [0.5.2]{.optlit} 
[::zipfile::encode]{.cmd} [objectName]{.arg} 
[\<encoder>]{.cmd} [comment:]{.sub} [text]{.arg} 
[\<encoder>]{.cmd} [file:]{.sub} [dst]{.arg} [owned]{.arg} [src]{.arg} [noCompress]{.optarg} 
[\<encoder>]{.cmd} [write]{.sub} [archive]{.arg} 
:::

# Description

Note: packages Trf and zlibtcl are not required for Tcl version 8.6 or above. This package provides a class for the generation of zip archives.

# Class api

**::zipfile::encode** *objectName*
: The class command constructs encoder instances, i.e. objects. The result of the command is the fully-qualified name of the instance command. The argument *objectName* is required. If *objectName* is set to **%AUTO%** the class will generate and use an automatic name in the current namespace. If the value of *objectName* is not fully qualified, the instance command will be created relative to the current namespace.


# Instance api

**\<encoder>** **comment:** *text*
: This method specifies the text of the global comment for the archive. The result of the method is the empty string. In case of multiple calls to this method for the same encoder the data from the last call prevails over all previous texts.

**\<encoder>** **file:** *dst* *owned* *src* ?*noCompress*?
: This method adds a new file to the archive. The contents of the file are found in the filesystem at *src*, and will be stored in the archive under path *dst*. If the file is declared as *owned* by the archive the original file will be deleted when the archive is constructed and written. If *noCompress* is set to **true** the file will not be compressed on writing. Otherwise (the default) the file is compressed if it is advantageous. The result of the method is an empty string.

**\<encoder>** **write** *archive*
: This method takes the global comment and all added files, encodes them as a zip archive and stores the result at path *archive* in the filesystem. All added files which were owned by the archive are deleted at this point. On the issue of ordering, the files are added to the archive in the same order as they were specified via **file:**. *Note* that this behaviour is new for version 0.4 and higher. Before 0.4 no specific order was documented. It was lexicographically sorted. The change was made to support **zip**-based file formats which require a specific order of files in the archive, for example "*.epub*".


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *zipfile* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

File

# Copyright

```
Copyright (c) 2008-2009 Andreas Kupries
```
