---
CommandName: practcl
title: practcl
ManualSection: n
Version: 0.16.6
TclPart: tcllib
TclDescription: The The Proper Rational API for C to Tool Command Language Module
Keywords:
 - practcl
Copyright:
 - Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
---

# Name

practcl - The Practcl Module

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit} [1.0]{.lit}
:::

proc **practcl::cat** *fname*

proc **practcl::docstrip** *text*

proc **putb** ?*map*? *text*

proc **Proc** *name* *arglist* *body*

proc **noop** ?*args*?

proc **practcl::debug** ?*args*?

proc **practcl::doexec** ?*args*?

proc **practcl::doexec\_in** *path* ?*args*?

proc **practcl::dotclexec** ?*args*?

proc **practcl::domake** *path* ?*args*?

proc **practcl::domake.tcl** *path* ?*args*?

proc **practcl::fossil** *path* ?*args*?

proc **practcl::fossil\_status** *dir*

proc **practcl::os**

proc **practcl::mkzip** *exename* *barekit* *vfspath*

proc **practcl::sort\_dict** *list*

proc **practcl::local\_os**

proc **practcl::config.tcl** *path*

proc **practcl::read\_configuration** *path*

proc **practcl::tcllib\_require** *pkg* ?*args*?

proc **practcl::platform::tcl\_core\_options** *os*

proc **practcl::platform::tk\_core\_options** *os*

proc **practcl::read\_rc\_file** *filename* ?*localdat* ?

proc **practcl::read\_sh\_subst** *line* *info*

proc **practcl::read\_sh\_file** *filename* ?*localdat* ?

proc **practcl::read\_Config.sh** *filename*

proc **practcl::read\_Makefile** *filename*

proc **practcl::cputs** *varname* ?*args*?

proc **practcl::tcl\_to\_c** *body*

proc **practcl::\_tagblock** *text* ?*style* **tcl**? ?*note* ?

proc **practcl::de\_shell** *data*

proc **practcl::grep** *pattern* ?*files* ?

proc **practcl::file\_lexnormalize** *sp*

proc **practcl::file\_relative** *base* *dst*

proc **practcl::findByPattern** *basedir* *patterns*

proc **practcl::log** *fname* *comment*

proc **practcl::\_pkgindex\_simpleIndex** *path*

proc **practcl::\_pkgindex\_directory** *path*

proc **practcl::\_pkgindex\_path\_subdir** *path*

proc **practcl::pkgindex\_path** ?*args*?

proc **practcl::installDir** *d1* *d2*

proc **practcl::copyDir** *d1* *d2* ?*toplevel* **1**?

proc **practcl::buildModule** *modpath*

proc **practcl::installModule** *modpath* *DEST*

proc **practcl::trigger** ?*args*?

proc **practcl::depends** ?*args*?

proc **practcl::target** *name* *info* ?*action* ?

method **constructor**

method **argspec** *argspec*

method **comment** *block*

method **keyword.Annotation** *resultvar* *commentblock* *type* *name* *body*

method **keyword.Class** *resultvar* *commentblock* *name* *body*

method **keyword.class** *resultvar* *commentblock* *name* *body*

method **keyword.Class\_Method** *resultvar* *commentblock* *name* ?*args*?

method **keyword.method** *resultvar* *commentblock* *name* ?*args*?

method **keyword.proc** *commentblock* *name* *argspec*

method **reset**

method **Main**

method **section.method** *keyword* *method* *minfo*

method **section.annotation** *type* *name* *iinfo*

method **section.class** *class\_name* *class\_info*

method **section.command** *procinfo*

method **manpage** ?**header** *value*? ?**footer** *value*? ?**authors** *list*?

method **scan\_text** *text*

method **scan\_file** *filename*

method **\_MorphPatterns**

method **define** *submethod* ?*args*?

method **graft** ?*args*?

method **initialize**

method **link** *command* ?*args*?

method **morph** *classname*

method **script** *script*

method **select**

method **source** *filename*

classmethod **select** *object*

method **config.sh**

method **BuildDir** *PWD*

method **MakeDir** *srcdir*

method **read\_configuration**

method **build-cflags** *PROJECT* *DEFS* *namevar* *versionvar* *defsvar*

method **critcl** ?*args*?

method **Autoconf**

method **BuildDir** *PWD*

method **ConfigureOpts**

method **MakeDir** *srcdir*

method **make {} autodetect**

method **make {} clean**

method **make {} compile**

method **make {} install** *DEST*

method **build-compile-sources** *PROJECT* *COMPILE* *CPPCOMPILE* *INCLUDES*

method **build-Makefile** *path* *PROJECT*

method **build-library** *outfile* *PROJECT*

method **build-tclsh** *outfile* *PROJECT* ?*path* **auto**?

method **BuildDir** *PWD*

method **make {} autodetect**

method **make {} clean**

method **make {} compile**

method **make {} install** *DEST*

method **MakeDir** *srcdir*

method **NmakeOpts**

method **constructor** *module\_object* *name* *info* ?*action\_body* ?

method **do**

method **check**

method **output**

method **reset**

method **triggers**

method **constructor** *parent* ?*args*?

method **child** *method*

method **go**

method **cstructure** *name* *definition* ?*argdat* ?

method **include** *header*

method **include\_dir** ?*args*?

method **include\_directory** ?*args*?

method **c\_header** *body*

method **c\_code** *body*

method **c\_function** *header* *body* ?*info* ?

method **c\_tcloomethod** *name* *body* ?*arginfo* ?

method **cmethod** *name* *body* ?*arginfo* ?

method **c\_tclproc\_nspace** *nspace*

method **c\_tclcmd** *name* *body* ?*arginfo* ?

method **c\_tclproc\_raw** *name* *body* ?*arginfo* ?

method **tcltype** *name* *argdat*

method **project-compile-products**

method **implement** *path*

method **initialize**

method **linktype**

method **generate-cfile-constant**

method **generate-cfile-header**

method **generate-cfile-tclapi**

method **generate-loader-module**

method **Collate\_Source** *CWD*

method **select**

classmethod **select** *object*

method **code** *section* *body*

method **Collate\_Source** *CWD*

method **project-compile-products**

method **generate-debug** ?*spaces* ?

method **generate-cfile-constant**

method **generate-cfile-public-structure**

method **generate-cfile-header**

method **generate-cfile-global**

method **generate-cfile-private-typedef**

method **generate-cfile-private-structure**

method **generate-cfile-functions**

method **generate-cfile-tclapi**

method **generate-hfile-public-define**

method **generate-hfile-public-macro**

method **generate-hfile-public-typedef**

method **generate-hfile-public-structure**

method **generate-hfile-public-headers**

method **generate-hfile-public-function**

method **generate-hfile-public-includes**

method **generate-hfile-public-verbatim**

method **generate-loader-external**

method **generate-loader-module**

method **generate-stub-function**

method **IncludeAdd** *headervar* ?*args*?

method **generate-tcl-loader**

method **generate-tcl-pre**

method **generate-tcl-post**

method **linktype**

method **Ofile** *filename*

method **project-static-packages**

method **toolset-include-directory**

method **target** *method* ?*args*?

method **project-compile-products**

method **generate-loader-module**

method **project-compile-products**

method **linker-products** *configdict*

method **initialize**

variable **make\_object**

method **\_MorphPatterns**

method **add** ?*args*?

method **install-headers** ?*args*?

method **make {} \_preamble**

method **make {} pkginfo**

method **make {} objects**

method **make {} object** *name*

method **make {} reset**

method **make {} trigger** ?*args*?

method **make {} depends** ?*args*?

method **make {} filename** *name*

method **make {} target** *name* *Info* *body*

method **make {} todo**

method **make {} do**

method **child** *which*

method **generate-c**

method **generate-h**

method **generate-loader**

method **initialize**

method **implement** *path*

method **linktype**

method **\_MorphPatterns**

method **constructor** ?*args*?

method **add\_object** *object*

method **add\_project** *pkg* *info* ?*oodefine* ?

method **add\_tool** *pkg* *info* ?*oodefine* ?

method **build-tclcore**

method **child** *which*

method **linktype**

method **project** *pkg* ?*args*?

method **tclcore**

method **tkcore**

method **tool** *pkg* ?*args*?

method **clean** *PATH*

method **project-compile-products**

method **go**

method **generate-decls** *pkgname* *path*

method **implement** *path*

method **generate-make** *path*

method **linktype**

method **package-ifneeded** ?*args*?

method **shared\_library** ?*filename* ?

method **static\_library** ?*filename* ?

method **build-tclkit\_main** *PROJECT* *PKG\_OBJS*

method **Collate\_Source** *CWD*

method **wrap** *PWD* *exename* *vfspath* ?*args*?

classmethod **Sandbox** *object*

classmethod **select** *object*

classmethod **claim\_option**

classmethod **claim\_object** *object*

classmethod **claim\_path** *path*

method **scm\_info**

method **DistroMixIn**

method **Sandbox**

method **SrcDir**

method **ScmTag**

method **ScmClone**

method **ScmUnpack**

method **ScmUpdate**

method **Unpack**

classmethod **claim\_object** *object*

classmethod **claim\_option**

classmethod **claim\_path** *path*

method **ScmUnpack**

classmethod **claim\_object** *obj*

classmethod **claim\_option**

classmethod **claim\_path** *path*

method **scm\_info**

method **ScmClone**

method **ScmTag**

method **ScmUnpack**

method **ScmUpdate**

classmethod **claim\_object** *obj*

classmethod **claim\_option**

classmethod **claim\_path** *path*

method **ScmTag**

method **ScmUnpack**

method **ScmUpdate**

method **\_MorphPatterns**

method **BuildDir** *PWD*

method **child** *which*

method **compile**

method **go**

method **install** ?*args*?

method **linktype**

method **linker-products** *configdict*

method **linker-external** *configdict*

method **linker-extra** *configdict*

method **env-bootstrap**

method **env-exec**

method **env-install**

method **env-load**

method **env-present**

method **sources**

method **update**

method **unpack**

method **env-bootstrap**

method **env-present**

method **linktype**

method **env-bootstrap**

method **env-install**

method **env-present**

method **install** *DEST*

method **kettle** *path* ?*args*?

method **install** *DEST*

method **install** *DEST*

method **env-bootstrap**

method **env-install**

method **env-present**

method **install** *DEST*

method **install-module** *DEST* ?*args*?

method **env-bootstrap**

method **env-install**

method **install** *DEST*

method **install-module** *DEST* ?*args*?

method **clean**

method **env-install**

method **project-compile-products**

method **ComputeInstall**

method **go**

method **linker-products** *configdict*

method **project-static-packages**

method **BuildDir** *PWD*

method **compile**

method **Configure**

method **install** *DEST*

method **install** *DEST*

method **install** *DEST*

method **env-bootstrap**

method **env-present**

method **env-install**

method **go**

method **linktype**

# Description

The Practcl module is a tool for integrating large modules for C API Tcl code that requires custom Tcl types and TclOO objects.

The concept with Practcl is that is a single file package that can assist any tcl based project with distribution, compilation, linking, VFS preparation, executable assembly, and installation. Practcl also allows one project to invoke the build system from another project, allowing complex projects such as a statically linked basekit to be assembled with relative ease.

Practcl ships as a single file, and aside from a Tcl 8.6 interpreter, has no external dependencies.

Making a practcl project

# Commands

proc **practcl::cat** *fname*
: Concatenate a file

proc **practcl::docstrip** *text*
: Strip the global comments from tcl code. Used to prevent the documentation markup comments from clogging up files intended for distribution in machine readable format.

proc **putb** ?*map*? *text*
: Append a line of text to a variable. Optionally apply a string mapping.

proc **Proc** *name* *arglist* *body*
: Generate a proc if no command already exists by that name

proc **noop** ?*args*?
: A command to do nothing. A handy way of negating an instruction without having to comment it completely out. It's also a handy attachment point for an object to be named later

proc **practcl::debug** ?*args*?
: see below ...

proc **practcl::doexec** ?*args*?
: Drop in a static copy of Tcl

proc **practcl::doexec\_in** *path* ?*args*?
: see below ...

proc **practcl::dotclexec** ?*args*?
: see below ...

proc **practcl::domake** *path* ?*args*?
: see below ...

proc **practcl::domake.tcl** *path* ?*args*?
: see below ...

proc **practcl::fossil** *path* ?*args*?
: see below ...

proc **practcl::fossil\_status** *dir*
: see below ...

proc **practcl::os**
: see below ...

proc **practcl::mkzip** *exename* *barekit* *vfspath*
: Build a zipfile. On tcl8.6 this invokes the native Zip implementation on older interpreters this invokes zip via exec

proc **practcl::sort\_dict** *list*
: Dictionary sort a key/value list. Needed because pre tcl8.6 does not have *lsort -stride 2*

proc **practcl::local\_os**
: Returns a dictionary describing the local operating system. Fields return include:

    - download - Filesystem path where fossil repositories and source tarballs are downloaded for the current user

    - EXEEXT - The extension to give to executables. (i.e. .exe on windows)

    - fossil\_mirror - A URI for a local network web server who acts as a fossil repository mirror

    - local\_install - Filesystem path where packages for local consumption by the current user are installed

    - prefix - The prefix as given to the Tcl core/TEA for installation to local\_install in ./configure

    - sandbox - The file location where this project unpacks external projects

    - TEACUP\_PROFILE - The ActiveState/Teacup canonical name for this platform (i.e. win32-ix86 macosx10.5-i386-x86\_84)

    - TEACUP\_OS - The local operating system (windows, macosx, openbsd, etc). Gives the same answer as tcl.m4, except that macosx is given as macosx instead of Darwin.

    - TEA\_PLATFORM - The platform returned by uname -s-uname -r (on Unix), or "windows" on Windows

    - TEACUP\_ARCH - The processor architecture for the local os (i.e. ix86, x86\_64)

    - TEACUP\_ARCH - The processor architecture for the local os (i.e. ix86, x86\_64)

    - teapot - Filesystem path where teapot package files are downloaded for the current user

    - userhome - File path to store localized preferences, cache download files, etc for the current user


    This command uses a combination of local checks with Exec, any tclConfig.sh file that is resident, autoconf data where already computed, and data gleaned from a file named practcl.rc in userhome. The location for userhome varies by platform and operating system:

    - Windows: ::env(LOCALAPPDATA)/Tcl

    - Macos: ~/Library/Application Support/Tcl

    - Other: ~/tcl


proc **practcl::config.tcl** *path*
: A transparent call to ::practcl::read\_configuration to preserve backward compadibility with older copies of Practcl

proc **practcl::read\_configuration** *path*
: Detect local platform. This command looks for data gleaned by autoconf or autosetup in the path specified, or perform its own logic tests if neither has been run. A file named config.site present in the location indicates that this project is cross compiling, and the data stored in that file is used for the compiler and linker.

    This command looks for information from the following files, in the following order:

    - config.tcl - A file generated by autoconf/configure in newer editions of TEA, encoded as a Tcl script.

    - config.site - A file containing cross compiler information, encoded as a SH script

    - ::env(VisualStudioVersion) - On Windows, and environmental value that indicates MS Visual Studio is installed


    This command returns a dictionary containing all of the data cleaned from the sources above. In the absence of any guidance this command returns the same output as ::practcl::local\_os. In this mode, if the environmental variable VisualStudioVersion exists, this command will provide a template of fields that are appropriate for compiling on Windows under Microsoft Visual Studio. The USEMSVC flag in the dictionary is a boolean flag to indicate if this is indeed the case.

proc **practcl::tcllib\_require** *pkg* ?*args*?
: Try to load  a package, and failing that retrieve tcllib

proc **practcl::platform::tcl\_core\_options** *os*
: Return the string to pass to ./configure to compile the Tcl core for the given OS.

    - windows: --with-tzdata --with-encoding utf-8

    - macosx: --enable-corefoundation=yes  --enable-framework=no --with-tzdata --with-encoding utf-8

    - other: --with-tzdata --with-encoding utf-8


proc **practcl::platform::tk\_core\_options** *os*
: see below ...

proc **practcl::read\_rc\_file** *filename* ?*localdat* ?
: Read a stylized key/value list stored in a file

proc **practcl::read\_sh\_subst** *line* *info*
: Converts a XXX.sh file into a series of Tcl variables

proc **practcl::read\_sh\_file** *filename* ?*localdat* ?
: see below ...

proc **practcl::read\_Config.sh** *filename*
: A simpler form of read\_sh\_file tailored to pulling data from (tcl|tk)Config.sh

proc **practcl::read\_Makefile** *filename*
: A simpler form of read\_sh\_file tailored to pulling data from a Makefile

proc **practcl::cputs** *varname* ?*args*?
: Append arguments to a buffer The command works like puts in that each call will also insert a line feed. Unlike puts, blank links in the interstitial are suppressed

proc **practcl::tcl\_to\_c** *body*
: see below ...

proc **practcl::\_tagblock** *text* ?*style* **tcl**? ?*note* ?
: see below ...

proc **practcl::de\_shell** *data*
: see below ...

proc **practcl::grep** *pattern* ?*files* ?
: Search for the pattern *pattern* amongst $files

proc **practcl::file\_lexnormalize** *sp*
: see below ...

proc **practcl::file\_relative** *base* *dst*
: Calculate a relative path between base and dst

    Example:

    ```
      ::practcl::file_relative ~/build/tcl/unix ~/build/tcl/library
      > ../library
    ```

proc **practcl::findByPattern** *basedir* *patterns*
: see below ...

proc **practcl::log** *fname* *comment*
: Record an event in the practcl log

proc **practcl::\_pkgindex\_simpleIndex** *path*
: see below ...

proc **practcl::\_pkgindex\_directory** *path*
: Return true if the pkgindex file contains any statement other than "package ifneeded" and/or if any package ifneeded loads a DLL

proc **practcl::\_pkgindex\_path\_subdir** *path*
: Helper function for ::practcl::pkgindex\_path

proc **practcl::pkgindex\_path** ?*args*?
: Index all paths given as though they will end up in the same virtual file system

proc **practcl::installDir** *d1* *d2*
: Delete the contents of *d2*, and then recusively Ccopy the contents of *d1* to *d2*.

proc **practcl::copyDir** *d1* *d2* ?*toplevel* **1**?
: Recursively copy the contents of *d1* to *d2*

proc **practcl::buildModule** *modpath*
: see below ...

proc **practcl::installModule** *modpath* *DEST*
: Install a module from MODPATH to the directory specified. *dpath* is assumed to be the fully qualified path where module is to be placed. Any existing files will be deleted at that path. If the path is symlink the process will return with no error and no action. If the module has contents in the build/ directory that are newer than the .tcl files in the module source directory, and a build/build.tcl file exists, the build/build.tcl file is run. If the source directory includes a file named index.tcl, the directory is assumed to be in the tao style of modules, and the entire directory (and all subdirectories) are copied verbatim. If no index.tcl file is present, all .tcl files are copied from the module source directory, and a pkgIndex.tcl file is generated if non yet exists. I a folder named htdocs exists in the source directory, that directory is copied verbatim to the destination.

proc **practcl::trigger** ?*args*?
: Trigger build targets, and recompute dependencies

    Internals:

    ```
      ::practcl::LOCAL make trigger {*}$args
      foreach {name obj} [::practcl::LOCAL make objects] {
        set ::make($name) [$obj do]
      }
    ```

proc **practcl::depends** ?*args*?
: Calculate if a dependency for any of the arguments needs to be fulfilled or rebuilt.

    Internals:

    ```
      ::practcl::LOCAL make depends {*}$args
    ```

proc **practcl::target** *name* *info* ?*action* ?
: Declare a build product. This proc is just a shorthand for *::practcl::LOCAL make task $name $info $action*

    Registering a build product with this command will create an entry in the global  array, and populate a value in the global  array.

    Internals:

    ```
      set obj [::practcl::LOCAL make task $name $info $action]
      set ::make($name) 0
      set filename [$obj define get filename]
      if {$filename ne {}} {
        set ::target($name) $filename
      }
    ```


# Classes

## Class  practcl::doctool

```
{ set authors {
   {John Doe} {jdoe@illustrious.edu}
   {Tom RichardHarry} {tomdickharry@illustrius.edu}
 }
 # Create the object
 ::practcl::doctool create AutoDoc
 set fout [open [file join $moddir module.tcl] w]
 foreach file [glob [file join $srcdir *.tcl]] {
   set content [::practcl::cat [file join $srcdir $file]]
    # Scan the file
    AutoDoc scan_text $content
    # Strip the comments from the distribution
    puts $fout [::practcl::docstrip $content]
 }
 # Write out the manual page
 set manout [open [file join $moddir module.man] w]
 dict set args header [string map $modmap [::practcl::cat [file join $srcdir manual.txt]]]
 dict set args footer [string map $modmap [::practcl::cat [file join $srcdir footer.txt]]]
 dict set args authors $authors
 puts $manout [AutoDoc manpage {*}$args]
 close $manout


}
```

Tool for build scripts to dynamically generate manual files from comments in source code files

**Methods**

method **constructor**
: see below ...

method **argspec** *argspec*
: Process an argument list into an informational dict. This method also understands non-positional arguments expressed in the notation of Tip 471 <https://core.tcl-lang.org/tips/doc/trunk/tip/479.md>.

    The output will be a dictionary of all of the fields and whether the fields are **positional**, **mandatory**, and whether they have a **default** value.

    Example:

    ```
       my argspec {a b {c 10}}

       > a {positional 1 mandatory 1} b {positional 1 mandatory 1} c {positional 1 mandatory 0 default 10}
    ```

method **comment** *block*
: Convert a block of comments into an informational dictionary. If lines in the comment start with a single word ending in a colon, all subsequent lines are appended to a dictionary field of that name. If no fields are given, all of the text is appended to the **description** field.

    Example:

    ```
     my comment {Does something cool}
     > description {Does something cool}

     my comment {
     title : Something really cool
     author : Sean Woods
     author : John Doe
     description :
     This does something really cool!
     }
     > description {This does something really cool!}
       title {Something really cool}
       author {Sean Woods
       John Doe}
    ```

method **keyword.Annotation** *resultvar* *commentblock* *type* *name* *body*
: see below ...

method **keyword.Class** *resultvar* *commentblock* *name* *body*
: Process an oo::objdefine call that modifies the class object itself

method **keyword.class** *resultvar* *commentblock* *name* *body*
: Process an oo::define, clay::define, etc statement.

method **keyword.Class\_Method** *resultvar* *commentblock* *name* ?*args*?
: Process a statement for a clay style class method

method **keyword.method** *resultvar* *commentblock* *name* ?*args*?
: Process a statement for a tcloo style object method

method **keyword.proc** *commentblock* *name* *argspec*
: Process a proc statement

method **reset**
: Reset the state of the object and its embedded coroutine

method **Main**
: Main body of the embedded coroutine for the object

method **section.method** *keyword* *method* *minfo*
: Generate the manual page text for a method or proc

method **section.annotation** *type* *name* *iinfo*
: see below ...

method **section.class** *class\_name* *class\_info*
: Generate the manual page text for a class

method **section.command** *procinfo*
: Generate the manual page text for the commands section

method **manpage** ?**header** *value*? ?**footer** *value*? ?**authors** *list*?
: Generate the manual page. Returns the completed text suitable for saving in .man file. The header argument is a block of doctools text to go in before the machine generated section. footer is a block of doctools text to go in after the machine generated section. authors is a list of individual authors and emails in the form of AUTHOR EMAIL ?AUTHOR EMAIL?...

method **scan\_text** *text*
: Scan a block of text

method **scan\_file** *filename*
: Scan a file of text


## Class  practcl::metaclass

The metaclass for all practcl objects

**Methods**

- method **\_MorphPatterns**
- method **define** *submethod* ?*args*?
- method **graft** ?*args*?
- method **initialize**
- method **link** *command* ?*args*?
- method **morph** *classname*
- method **script** *script*
- method **select**
- method **source** *filename*


## Class  practcl::toolset

Ancestor-less class intended to be a mixin which defines a family of build related behaviors that are modified when targetting either gcc or msvc

**Class Methods**

classmethod **select** *object*
: Perform the selection for the toolset mixin


**Methods**

method **config.sh**
: find or fake a key/value list describing this project

method **BuildDir** *PWD*
: Compute the location where the product will be built

method **MakeDir** *srcdir*
: Return where the Makefile is located relative to *srcdir*. For this implementation the MakeDir is always srcdir.

method **read\_configuration**
: Read information about the build process for this package. For this implementation, data is sought in the following locations in the following order: config.tcl (generated by practcl.) PKGConfig.sh. The Makefile

    If the Makefile needs to be consulted, but does not exist, the Configure method is invoked

method **build-cflags** *PROJECT* *DEFS* *namevar* *versionvar* *defsvar*
: method DEFS This method populates 4 variables: name - The name of the package version - The version of the package defs - C flags passed to the compiler includedir - A list of paths to feed to the compiler for finding headers

method **critcl** ?*args*?
: Invoke critcl in an external process


## Class  practcl::toolset.gcc

*ancestors*: **practcl::toolset**

**Methods**

method **Autoconf**
: see below ...

method **BuildDir** *PWD*
: see below ...

method **ConfigureOpts**
: see below ...

method **MakeDir** *srcdir*
: Detect what directory contains the Makefile template

method **make {} autodetect**
: see below ...

method **make {} clean**
: see below ...

method **make {} compile**
: see below ...

method **make {} install** *DEST*
: see below ...

method **build-compile-sources** *PROJECT* *COMPILE* *CPPCOMPILE* *INCLUDES*
: see below ...

method **build-Makefile** *path* *PROJECT*
: see below ...

method **build-library** *outfile* *PROJECT*
: Produce a static or dynamic library

method **build-tclsh** *outfile* *PROJECT* ?*path* **auto**?
: Produce a static executable


## Class  practcl::toolset.msvc

*ancestors*: **practcl::toolset**

**Methods**

method **BuildDir** *PWD*
: MSVC always builds in the source directory

method **make {} autodetect**
: Do nothing

method **make {} clean**
: see below ...

method **make {} compile**
: see below ...

method **make {} install** *DEST*
: see below ...

method **MakeDir** *srcdir*
: Detect what directory contains the Makefile template


- method **NmakeOpts**


## Class  practcl::make\_obj

*ancestors*: **practcl::metaclass**

A build deliverable object. Normally an object file, header, or tcl script which must be compiled or generated in some way

**Methods**

- method **constructor** *module\_object* *name* *info* ?*action\_body* ?
- method **do**
- method **check**
- method **output**
- method **reset**
- method **triggers**


## Class  practcl::object

*ancestors*: **practcl::metaclass**

A generic Practcl object

**Methods**

- method **constructor** *parent* ?*args*?
- method **child** *method*
- method **go**


## Class  practcl::dynamic

Dynamic blocks do not generate their own .c files, instead the contribute to the amalgamation of the main library file

**Methods**

method **cstructure** *name* *definition* ?*argdat* ?
: Parser functions

method **include** *header*
: see below ...

method **include\_dir** ?*args*?
: see below ...

method **include\_directory** ?*args*?
: see below ...

method **c\_header** *body*
: see below ...

method **c\_code** *body*
: see below ...

method **c\_function** *header* *body* ?*info* ?
: see below ...

method **c\_tcloomethod** *name* *body* ?*arginfo* ?
: see below ...

method **cmethod** *name* *body* ?*arginfo* ?
: Alias to classic name

method **c\_tclproc\_nspace** *nspace*
: see below ...

method **c\_tclcmd** *name* *body* ?*arginfo* ?
: see below ...

method **c\_tclproc\_raw** *name* *body* ?*arginfo* ?
: Alias to classic name

method **tcltype** *name* *argdat*
: see below ...

method **project-compile-products**
: Module interactions

method **implement** *path*
: see below ...

method **initialize**
: Practcl internals

method **linktype**
: see below ...

method **generate-cfile-constant**
: see below ...

method **generate-cfile-header**
: see below ...

method **generate-cfile-tclapi**
: Generate code that provides implements Tcl API calls

method **generate-loader-module**
: Generate code that runs when the package/module is initialized into the interpreter

method **Collate\_Source** *CWD*
: see below ...

method **select**
: Once an object marks itself as some flavor of dynamic, stop trying to morph it into something else


## Class  practcl::product

A deliverable for the build system

**Class Methods**

- classmethod **select** *object*


**Methods**

method **code** *section* *body*
: see below ...

method **Collate\_Source** *CWD*
: see below ...

method **project-compile-products**
: see below ...

method **generate-debug** ?*spaces* ?
: see below ...

method **generate-cfile-constant**
: see below ...

method **generate-cfile-public-structure**
: Populate const static data structures

method **generate-cfile-header**
: see below ...

method **generate-cfile-global**
: see below ...

method **generate-cfile-private-typedef**
: see below ...

method **generate-cfile-private-structure**
: see below ...

method **generate-cfile-functions**
: Generate code that provides subroutines called by Tcl API methods

method **generate-cfile-tclapi**
: Generate code that provides implements Tcl API calls

method **generate-hfile-public-define**
: see below ...

method **generate-hfile-public-macro**
: see below ...

method **generate-hfile-public-typedef**
: see below ...

method **generate-hfile-public-structure**
: see below ...

method **generate-hfile-public-headers**
: see below ...

method **generate-hfile-public-function**
: see below ...

method **generate-hfile-public-includes**
: see below ...

method **generate-hfile-public-verbatim**
: see below ...

method **generate-loader-external**
: see below ...

method **generate-loader-module**
: see below ...

method **generate-stub-function**
: see below ...

method **IncludeAdd** *headervar* ?*args*?
: see below ...

method **generate-tcl-loader**
: see below ...

method **generate-tcl-pre**
: This methods generates any Tcl script file which is required to pre-initialize the C library

method **generate-tcl-post**
: see below ...

method **linktype**
: see below ...

method **Ofile** *filename*
: see below ...

method **project-static-packages**
: Methods called by the master project

method **toolset-include-directory**
: Methods called by the toolset


- method **target** *method* ?*args*?


## Class  practcl::product.cheader

*ancestors*: **practcl::product**

A product which generated from a C header file. Which is to say, nothing.

**Methods**

- method **project-compile-products**
- method **generate-loader-module**


## Class  practcl::product.csource

*ancestors*: **practcl::product**

A product which generated from a C source file. Normally an object (.o) file.

**Methods**

- method **project-compile-products**


## Class  practcl::product.clibrary

*ancestors*: **practcl::product**

A product which is generated from a compiled C library. Usually a .a or a .dylib file, but in complex cases may actually just be a conduit for one project to integrate the source code of another

**Methods**

- method **linker-products** *configdict*


## Class  practcl::product.dynamic

*ancestors*: **practcl::dynamic** **practcl::product**

A product which is generated from C code that itself is generated by practcl or some other means. This C file may or may not produce its own .o file, depending on whether it is eligible to become part of an amalgamation

**Methods**

- method **initialize**


## Class  practcl::product.critcl

*ancestors*: **practcl::dynamic** **practcl::product**

A binary product produced by critcl. Note: The implementation is not written yet, this class does nothing.

## Class  practcl::module

*ancestors*: **practcl::object** **practcl::product.dynamic**

In the end, all C code must be loaded into a module This will either be a dynamically loaded library implementing a tcl extension, or a compiled in segment of a custom shell/app

**Variable**

- variable **make\_object**


**Methods**

method **\_MorphPatterns**
: see below ...

method **add** ?*args*?
: see below ...

method **install-headers** ?*args*?
: see below ...

method **make {} \_preamble**
: see below ...

method **make {} pkginfo**
: see below ...

method **make {} objects**
: Return a dictionary of all handles and associated objects

method **make {} object** *name*
: Return the object associated with handle *name*

method **make {} reset**
: Reset all deputy objects

method **make {} trigger** ?*args*?
: Exercise the triggers method for all handles listed

method **make {} depends** ?*args*?
: Exercise the check method for all handles listed

method **make {} filename** *name*
: Return the file name of the build product for the listed handle

method **make {} target** *name* *Info* *body*
: see below ...

method **make {} todo**
: Return a list of handles for object which return true for the do method

method **make {} do**
: For each target exercise the action specified in the *action* definition if the *do* method returns true

method **child** *which*
: see below ...

method **generate-c**
: This methods generates the contents of an amalgamated .c file which implements the loader for a batch of tools

method **generate-h**
: This methods generates the contents of an amalgamated .h file which describes the public API of this module


- method **generate-loader**
- method **initialize**
- method **implement** *path*
- method **linktype**


## Class  practcl::project

*ancestors*: **practcl::module**

A toplevel project that is a collection of other projects

**Methods**

method **\_MorphPatterns**
: see below ...

method **constructor** ?*args*?
: see below ...

method **add\_object** *object*
: see below ...

method **add\_project** *pkg* *info* ?*oodefine* ?
: see below ...

method **add\_tool** *pkg* *info* ?*oodefine* ?
: see below ...

method **build-tclcore**
: Compile the Tcl core. If the define *tk* is true, compile the Tk core as well

method **child** *which*
: see below ...

method **linktype**
: see below ...

method **project** *pkg* ?*args*?
: Exercise the methods of a sub-object


- method **tclcore**
- method **tkcore**
- method **tool** *pkg* ?*args*?


## Class  practcl::library

*ancestors*: **practcl::project**

A toplevel project that produces a library

**Methods**

method **clean** *PATH*
: see below ...

method **project-compile-products**
: see below ...

method **go**
: see below ...

method **generate-decls** *pkgname* *path*
: see below ...

method **implement** *path*
: see below ...

method **generate-make** *path*
: Backward compadible call

method **linktype**
: see below ...

method **package-ifneeded** ?*args*?
: Create a "package ifneeded" Args are a list of aliases for which this package will answer to


- method **shared\_library** ?*filename* ?
- method **static\_library** ?*filename* ?


## Class  practcl::tclkit

*ancestors*: **practcl::library**

A toplevel project that produces a self-contained executable

**Methods**

method **build-tclkit\_main** *PROJECT* *PKG\_OBJS*
: see below ...

method **Collate\_Source** *CWD*
: see below ...

method **wrap** *PWD* *exename* *vfspath* ?*args*?
: Wrap an executable


## Class  practcl::distribution

Standalone class to manage code distribution This class is intended to be mixed into another class (Thus the lack of ancestors)

**Class Methods**

- classmethod **Sandbox** *object*
- classmethod **select** *object*
- classmethod **claim\_option**
- classmethod **claim\_object** *object*
- classmethod **claim\_path** *path*


**Methods**

- method **scm\_info**
- method **DistroMixIn**
- method **Sandbox**
- method **SrcDir**
- method **ScmTag**
- method **ScmClone**
- method **ScmUnpack**
- method **ScmUpdate**
- method **Unpack**


## Class  practcl::distribution.snapshot

*ancestors*: **practcl::distribution**

A file distribution from zip, tarball, or other non-scm archive format

**Class Methods**

- classmethod **claim\_object** *object*
- classmethod **claim\_option**
- classmethod **claim\_path** *path*


**Methods**

- method **ScmUnpack**


## Class  practcl::distribution.fossil

*ancestors*: **practcl::distribution**

A file distribution based on fossil

**Class Methods**

classmethod **claim\_object** *obj*
: Check for markers in the metadata

classmethod **claim\_option**
: see below ...

classmethod **claim\_path** *path*
: Check for markers in the source root


**Methods**

method **scm\_info**
: see below ...

method **ScmClone**
: Clone the source


- method **ScmTag**
- method **ScmUnpack**
- method **ScmUpdate**


## Class  practcl::distribution.git

*ancestors*: **practcl::distribution**

A file distribution based on git

**Class Methods**

- classmethod **claim\_object** *obj*
- classmethod **claim\_option**
- classmethod **claim\_path** *path*


**Methods**

- method **ScmTag**
- method **ScmUnpack**
- method **ScmUpdate**


## Class  practcl::subproject

*ancestors*: **practcl::module**

A subordinate project

**Methods**

method **\_MorphPatterns**
: see below ...

method **BuildDir** *PWD*
: see below ...

method **child** *which*
: see below ...

method **compile**
: see below ...

method **go**
: see below ...

method **install** ?*args*?
: Install project into the local build system

method **linktype**
: see below ...

method **linker-products** *configdict*
: see below ...

method **linker-external** *configdict*
: see below ...

method **linker-extra** *configdict*
: see below ...

method **env-bootstrap**
: Methods for packages/tools that can be downloaded possibly built and used internally by this Practcl process Load the facility into the interpreter

method **env-exec**
: Return a file path that exec can call

method **env-install**
: Install the tool into the local environment

method **env-load**
: Do whatever is necessary to get the tool into the local environment

method **env-present**
: Check if tool is available for load/already loaded


- method **sources**
- method **update**
- method **unpack**


## Class  practcl::subproject.source

*ancestors*: **practcl::subproject** **practcl::library**

A project which the kit compiles and integrates the source for itself

**Methods**

- method **env-bootstrap**
- method **env-present**
- method **linktype**


## Class  practcl::subproject.teapot

*ancestors*: **practcl::subproject**

a copy from the teapot

**Methods**

- method **env-bootstrap**
- method **env-install**
- method **env-present**
- method **install** *DEST*


## Class  practcl::subproject.kettle

*ancestors*: **practcl::subproject**

**Methods**

- method **kettle** *path* ?*args*?
- method **install** *DEST*


## Class  practcl::subproject.critcl

*ancestors*: **practcl::subproject**

**Methods**

- method **install** *DEST*


## Class  practcl::subproject.sak

*ancestors*: **practcl::subproject**

**Methods**

- method **env-bootstrap**
- method **env-install**
- method **env-present**
- method **install** *DEST*
- method **install-module** *DEST* ?*args*?


## Class  practcl::subproject.practcl

*ancestors*: **practcl::subproject**

**Methods**

- method **env-bootstrap**
- method **env-install**
- method **install** *DEST*
- method **install-module** *DEST* ?*args*?


## Class  practcl::subproject.binary

*ancestors*: **practcl::subproject**

A subordinate binary package

**Methods**

- method **clean**
- method **env-install**
- method **project-compile-products**
- method **ComputeInstall**
- method **go**
- method **linker-products** *configdict*
- method **project-static-packages**
- method **BuildDir** *PWD*
- method **compile**
- method **Configure**
- method **install** *DEST*


## Class  practcl::subproject.TEA

*ancestors*: **practcl::subproject.binary**

A subordinate TEA based binary package

## Class  practcl::subproject.library

*ancestors*: **practcl::subproject.binary** **practcl::library**

A subordinate C library built by this project

**Methods**

- method **install** *DEST*


## Class  practcl::subproject.external

*ancestors*: **practcl::subproject.binary**

A subordinate external C library

**Methods**

- method **install** *DEST*


## Class  practcl::subproject.core

*ancestors*: **practcl::subproject.binary**

**Methods**

- method **env-bootstrap**
- method **env-present**
- method **env-install**
- method **go**
- method **linktype**


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *practcl* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

TclOO

# Copyright

```
Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
```
