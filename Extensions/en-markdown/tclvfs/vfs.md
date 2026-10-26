---
CommandName: vfs
ManualSection: n
Version: 1.4
TclPart: Vfs
TclDescription: Tcl-only Virtual File Systems
Keywords:
 - vfs
 - filesystem
 - file
Copyright:
 - Copyright (c) 2001-2003, Vince Darley
---

# Name

::vfs - Commands and Procedures to create virtual filesystems

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} 

[package]{.cmd} [require]{.sub} [vfs]{.lit} [1.4]{.optlit} 

[vfs::filesystem]{.cmd} [info]{.arg} 

[vfs::filesystem]{.cmd} [mount]{.arg} 

[vfs::filesystem]{.cmd} [unmount]{.arg} 

[vfs::accessMode]{.cmd} [mode]{.arg} 

[vfs::matchDirectories]{.cmd} [types]{.arg} 

[vfs::matchFiles]{.cmd} [types]{.arg} 

[vfs::matchCorrectTypes]{.cmd} [types]{.arg} [filelist]{.arg} [inDir]{.optarg} 
:::

# Description

The **::vfs** package provides commands to query, mount and unmount virtual filesystems, and provides as Tcl libraries some facilities for helping the writing of new virtual filesystems in Tcl.  Once a virtual filesystem is in place, the standard Tcl **file**, **glob**, **cd**, **pwd**, **open** commands, including all their C APIs in the Tcl library (e.g. **Tcl_FSOpenFileChannel**, **Tcl_FSMatchInDirectory**,...), can be used within the filesystem (and indeed, properly written extensions such as Tk which may open or read files will also transparently access the virtual filesystem). Because all of Tcl's FS activity passes through a single layer, it can all be intercepted.  This package does just that.  Notice that this is quite different to overloading the **file** command in Tcl.  We are actually providing vfs replacements for C commands like **access**, **stat**.  By implementing just a handful of commands at this low level, we ensure that all commands at higher levels function irrespective of what is going on inside the FS layer.

Tcl's filesystem hooks operate on a per-process basis.  This means every Tcl interpreter in the same process/application sees the same filesystem, including any virtual filesystems.

The **package require vfs** command should be used to access this library.  It automatically registers the vfs hooks into Tcl's filesystem, and these will not be removed until Tcl exits (if desired, control over this could be exposed to Tcl in the future).  However, the vfs package will at that stage not have any new filesystems mounted, so it will have little effect.  Note that **package require vfs** has two effects.  First of all, when it is issued in **any** Tcl interpreter it will ensure the vfs hooks have been registered with Tcl's core just once (and if any of those interpreters are later deleted, the vfs hooks will still remain registered - they remain until Tcl exits).  The second effect is to provide the command **vfs::filesystem** which allows the interpreter to intercept filesystem commands and handle them with Tcl code in that interpreter.

There are three somewhat unsupported subcommands of **vfs::filesystem**, **fullynormalize path**, **posixerror int**, **internalerror ?script?**, which are used to normalize a path (including any final symlink), to register a posix error code with a Tcl error, and to trap/report internal errors in tclvfs implementations respectively.

**vfs::filesystem** *mount* *?-volume?* *path* *command*
: To use a virtual filesystem, it must be 'mounted'.  Mounting involves declaring to the vfs package that any subdirectories of a given *path* in the filesystem should be handled by the given *command* which should be a Tcl command or procedure in the interpreter in which the **vfs::filesystem** is executed.  If the *?-volume?* flag is given, the given mount point is also registered with Tcl as a new volume (like a new drive which will appear in *file volumes*). This is useful (and required for reasonable operation) for mounts like *ftp://*.  For paths mounted inside the native filesystem, it should of course not be given.  The new filesystem mounts will be observed immediately in all interpreters in the current process.  If the interpreter is later deleted, all mounts which are intercepted by it will be automatically removed (and will therefore affect the view of the filesystem seen by all interpreters).

**vfs::filesystem** *unmount* *path*
: This unmounts the virtual filesystem which was mounted at *path* (hence removing it from Tcl's filesystem), or throws an error if no filesystem was mounted there.

**vfs::filesystem** *info* *?path?*
: If no arguments are given, this returns a list of all filesystems mounted (in all interpreters).  If a path argument is given, then the *command* to be used for that path is returned, or an error is thrown if no vfs is mounted for that path.  There is currently no facility for examining in which interpreter each command will be evaluated.

**vfs::filesystem** *fullynormalize* *path*
: Performs a full expansion of *path*, (as per 'file normalize'), but including following any links in the last element of path.


# Implementing a tcl only vfs

The vfs package will intercept every filesystem operation which falls within a given mount point, and pass the operation on to the mount point's *command* in the interpreter which registered it. In general this occurs by the C equivalent of an evaluation like this: *eval \$command \[list \$subcmd \$root \$relative \$actualpath\] \$args*.

Here *subcmd* may be any of the following: *access*, *createdirectory*, *deletefile*, *fileattributes*, *matchindirectory*, *open*, *removedirectory*, *stat*, *utime*. If *command* takes appropriate action for each of these cases, a complete, perfect virtual filesystem will be achieved, indistinguishable to Tcl from the native filesystem.  (CAVEATS: right now I don't expose to Tcl all the permission-related flags of 'glob').

The remaining arguments specify a file path on which to operate (all commands operate on one of these), and any additional arguments which may be required to carry out the action.  The file path is specified by three arguments: *root* is the part of the path which lies outside this filesystem's mount point, *relative* is the part of the path which lies inside this filesytem, and *actualpath* is the original (unnormalized) name of the path which was used in the current command wherever it originated (in Tcl or C).  For example, if *C:/foo/bar/mount.zip/xxx/yyy* is a path in your filesystem, where *mount.zip* is a zip archive which has been mounted (on top of itself) and contains *xxx/yyy*, and the current working directory is inside *xxx*, and we evaluate a command like *file exists yyy*, then *root*\\*R will be C:/foo/bar/mount.zip*, *relative* will be *xxx/yyy*, and *actualpath* will be *yyy*. The file separator between the *root* and *relative* is omitted.

Note that most filesystem operations will only require the *relative* argument to work correctly, but the other arguments are actually required for correct operation of some subcommands.

Almost all of these commands should either return correctly (i.e. with a TCL_OK result at the C level) or they should use vfs::filesystem posixerror to signal the appropriate posix error code.  If a Tcl error is thrown, that should be considered a bug, but it will be interpreted as an unknown posix error in the filesystem call.  The exceptions to these rules are those filesystem commands which are able to specify a Tcl error message directly: open (when an interpreter is given), matchindirectory and fileattributes (for a set or get operation only).  These three commands are allowed to throw any Tcl error message which will be passed along to the caller, or they may throw a posix error which will be handled appropriately.

The actual commands are as follows (where *r-r-a* represents the standard argument triplet of *root*, *relative* and *actualpath*):

*command* *access* *r-r-a* *mode*
: Return TCL_OK or throw a posix error depending on whether the given access mode (which is an integer) is compatible with the file.

*command* *createdirectory* *r-r-a*
: Create a directory with the given name.  The command can assume that all sub-directories in the path exist and are valid, and that the actual desired path does not yet exist (Tcl takes care of all of that for us).

*command* *deletefile* *r-r-a*
: Delete the given file.

*command* *fileattributes* *r-r-a* *?index?* *?value?*
: If neither index nor value is given, then return a list of all acceptable attribute names.  If *index* is given, but no value, then retrieve the value of the *index*'th attribute (counting in order over the list returned when no argument is given) for the given file.  If a value is also given then set the *index*'th attribute of the given file to that value.

*command* *matchindirectory* *r-r-a* *pattern* *types*
: Return the list of files or directories in the given path (which is always the name of an existing directory), which match the *pattern* and are compatible with the *types* given.  It is very important that the command correctly handle *types* requests for directories only (and files only), because to handle any kind of recursive globbing, Tcl will actually generate requests for directory-only matches from the filesystem.  See **vfs::matchDirectories** below for help.

*command* *open* *r-r-a* *mode* *permissions*
: For this command, *mode* is any of "r", "w", "a", "w+", "a+". If the open involves creating a file, then *permissions* dictates what modes to create it with.  If the open operation was not successful, an error should be thrown.  If the open operation is successful, the command should return a list of either one or two items.  The first item (which is obligatory) is the name of the channel which has been created.  The second item, if given, is a Tcl-callback to be used when the channel is closed, so that the vfs can clean up as appropriate.  This callback will be evaluated by Tcl just before the channel is closed.  The channel will still exist, and all available data will have been flushed into it.  The callback can, for example, seek to the beginning of the channel, read its contents and store that contents elsewhere (e.g. compressed or on a remote ftp site, etc).  The return code or any errors returned by the callback are ignored (if the callback wishes to signal an error, it must do so asycnhronously, with bgerror, for example), unless the 'internalerror' script has been specified, when they are passed to that script for further action.

*command* *removedirectory* *r-r-a* *recursive*
: Delete the given directory.  *recursive* is either 0 or 1. If it is 1 then even if the directory is non-empty, an attempt should be made to recursively delete it and its contents.  If it is 0 and the directory is non-empty, a posix error (EEXIST) should be thrown.

*command* *stat* *r-r-a*
: Return a list of even length containing field-name and value pairs for the contents of a stat structure.  The order is not important. The option names are dev (long), ino (long), mode (int), nlink (long), uid (long), gid (long), size (long), atime (long), mtime (long), ctime (long), type (string which is either "directory" or "file"), where the type of each argument is given in brackets.  The procedure should therefore return with something like *return \[list dev 0 type file mtime 1234 ...\]*.

*command* *utime* *r-r-a* *actime* *mtime*
: Set the access and modification times of the given file (these are read with 'stat').


# Vfs helpers

The vfslib provides a number of Tcl procedures which can help with writing command procedures to handle the above possibilities.  These are:

**vfs::accessMode** *mode*
: converts an integer *access* mode to a somewhat more preferable string, any of F X W XW R RX RW.

**vfs::matchDirectories** *types*
: Does *types* want directories included?

**vfs::matchFiles** *types*
: Does *types* want files included?

**vfs::matchCorrectTypes** *types* *filelist* *?inDir?*
: Returns that subset of the *filelist* (which are either absolute paths or names of files in *inDir*) which are compatible with the *types* given.


# Vfs debugging

Use something like this to debug problems in your implementation: vfs::filesystem internalerror report ; proc report {} { puts stderr \$::errorInfo }

# Limitations

There are very few limitations to the vfs code.  One subtlety that you may encounter is if you mount a case-sensitive virtual filesystem into a case-insensitive system (e.g. the standard Windows or MacOS fs) and your code relies on case-insensitivity, then it will not run properly in the virtual filesystem.  Of course if your code relies on case-insensitivity, it wouldn't run under Tcl on Unix either, so the best solution is to fix your code!

We may add *link* and *lstat* commands in the future to allow virtual filesystems to support reading and writing links - this is supported by the C API, but has simply not been exposed to Tcl in this extension, yet.

The Tcl 'Tcl_FSMatchInDirectory' function takes a variety of type information in a Tcl_GlobTypeData structure.  We currently only expose the 'type' field from that structure (so the 'permissions' and MacOS type/creator fields are ignored).
