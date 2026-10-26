---
CommandName: tar
ManualSection: n
Version: 0.15
TclPart: tcllib
TclDescription: Tar file handling
Keywords:
 - archive
 - tape archive
 - tar
Copyright:
---

# Name

tar - Tar file creation, extraction & manipulation

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tar]{.lit} [0.15]{.optlit} 
[::tar::contents]{.cmd} [tarball]{.arg} [-chan]{.optlit} [-gzip]{.optlit} 
[::tar::stat]{.cmd} [tarball]{.arg} [file]{.optarg} [-chan]{.optlit} [-gzip]{.optlit} 
[::tar::untar]{.cmd} [tarball]{.arg} [args]{.arg} 
[::tar::get]{.cmd} [tarball]{.arg} [fileName]{.arg} [-chan]{.optlit} [-gzip]{.optlit} 
[::tar::create]{.cmd} [tarball]{.arg} [files]{.arg} [args]{.arg} 
[::tar::add]{.cmd} [tarball]{.arg} [files]{.arg} [args]{.arg} 
[::tar::remove]{.cmd} [tarball]{.arg} [files]{.arg} 
:::

# Description

*Note*: Starting with version 0.8 the tar reader commands (contents, stats, get, untar) support the GNU LongName extension (header type \\'L') for large paths.

# Beware

For all commands, when using **-chan** ...

**\[1\]**
: It is assumed that the channel was opened for reading, and configured for binary input.

**\[2\]**
: It is assumed that the channel position is at the beginning of a legal tar file.

**\[3\]**
: The commands will *modify* the channel position as they perform their task.

**\[4\]**
: The commands will *not* close the channel.

**\[5\]**
: In other words, the commands leave the channel in a state very likely unsuitable for use by further **tar** commands. Still doing so will very likely results in errors, bad data, etc. pp.

**\[6\]**
: It is the responsibility of the user to seek the channel back to a suitable position.

**\[7\]**
: When using a channel transformation which is not generally seekable, for example **gunzip**, then it is the responsibility of the user to (a) unstack the transformation before seeking the channel back to a suitable position, and (b) for restacking it after. Regarding support for gzip compression:

**\[1\]**
: Errors are thrown when attempting to read from compressed tar archives while compression support (i.e. **::zlib**) is not available.

**\[2\]**
: Errors are thrown when attempting to read an uncompressed tar archive when compression is requested by the user (**-gzip**). No errors are thrown when attempting to read a compressed tar archive when compression was not requested, and is supported. In that case the commands automatically activate the code handling the compression.

**\[3\]**
: Errors are thrown when attempting to edit compressed tar archives. See the commands **tar::add**, and **tar::remove**. This is not supported.

**\[4\]**
: Creation of compressed tar archives however is supported, as this sequentially writes the archive, allowing for streaming compression.


# Commands

**::tar::contents** *tarball* ?**-chan**? ?**-gzip**?
: Returns a list of the files contained in *tarball*. The order is not sorted and depends on the order files were stored in the archive. If the option **-chan** is present *tarball* is interpreted as an open channel. It is assumed that the channel was opened for reading, and configured for binary input. The command will *not* close the channel.

**::tar::stat** *tarball* ?file? ?**-chan**? ?**-gzip**?
: Returns a nested dict containing information on the named ?file? in *tarball*, or all files if none is specified. The top level are pairs of filename and info. The info is a dict with the keys "**mode** **uid** **gid** **size** **mtime** **type** **linkname** **uname** **gname** **devmajor** **devminor**"


```
% ::tar::stat tarball.tar
foo.jpg {mode 0644 uid 1000 gid 0 size 7580 mtime 811903867 type file linkname {} uname user gname wheel devmajor 0 devminor 0}
```

If the option **-chan** is present *tarball* is interpreted as an open channel. It is assumed that the channel was opened for reading, and configured for binary input. The command will *not* close the channel.

**::tar::untar** *tarball* *args*
: Extracts *tarball*. *-file* and *-glob* limit the extraction to files which exactly match or pattern match the given argument. No error is thrown if no files match. Returns a list of filenames extracted and the file size. The size will be null for non regular files. Leading path seperators are stripped so paths will always be relative.


**-dir** dirName
: Directory to extract to. Uses **pwd** if none is specified

**-file** fileName
: Only extract the file with this name. The name is matched against the complete path stored in the archive including directories.

**-glob** pattern
: Only extract files patching this glob style pattern. The pattern is matched against the complete path stored in the archive.

**-nooverwrite**
: Dont overwrite files that already exist

**-nomtime**
: Leave the file modification time as the current time instead of setting it to the value in the archive.

**-noperms**
: In Unix, leave the file permissions as the current umask instead of setting them to the values in the archive.

**-chan**
: If this option is present *tarball* is interpreted as an open channel. It is assumed that the channel was opened for reading, and configured for binary input. The command will *not* close the channel.


```
% foreach {file size} [::tar::untar tarball.tar -glob *.jpg] {
puts "Extracted $file ($size bytes)"
}
```

**::tar::get** *tarball* *fileName* ?**-chan**? ?**-gzip**?
: Returns the contents of *fileName* from the *tarball*.


```
% set readme [::tar::get tarball.tar doc/README] {
% puts $readme
}
```

If the option **-chan** is present *tarball* is interpreted as an open channel.  It is assumed that the channel was opened for reading, and configured for binary input.  The command will *not* close the channel.

An error is thrown when *fileName* is not found in the tar archive.

**::tar::create** *tarball* *files* *args*
: Creates a new tar file containing the *files*. *files* must be specified as a single argument which is a proper list of filenames.


**-dereference**
: Normally **create** will store links as an actual link pointing at a file that may or may not exist in the archive. Specifying this option will cause the actual file point to by the link to be stored instead.

**-chan**
: If this option is present *tarball* is interpreted as an open channel. It is assumed that the channel was opened for writing, and configured for binary output. The command will *not* close the channel.


```
% ::tar::create new.tar [glob -nocomplain file*]
% ::tar::contents new.tar
file1 file2 file3
```

**::tar::add** *tarball* *files* *args*
: Appends *files* to the end of the existing *tarball*. *files* must be specified as a single argument which is a proper list of filenames.


**-dereference**
: Normally **add** will store links as an actual link pointing at a file that may or may not exist in the archive. Specifying this option will cause the actual file point to by the link to be stored instead.

**-prefix** string
: Normally **add** will store files under exactly the name specified as argument. Specifying a ?-prefix? causes the *string* to be prepended to every name.

**-quick**
: The only sure way to find the position in the *tarball* where new files can be added is to read it from start, but if *tarball* was written with a "blocksize" of 1 (as this package does) then one can alternatively find this position by seeking from the end. The ?-quick? option tells **add** to do the latter.


**::tar::remove** *tarball* *files*
: Removes *files* from the *tarball*. No error will result if the file does not exist in the tarball. Directory write permission and free disk space equivalent to at least the size of the tarball will be needed.


```
% ::tar::remove new.tar {file2 file3}
% ::tar::contents new.tar
file3
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *tar* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

File formats
