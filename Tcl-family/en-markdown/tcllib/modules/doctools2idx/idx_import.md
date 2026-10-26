---
CommandName: doctools::idx::import
ManualSection: n
Version: 0.2.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - conversion
 - docidx
 - documentation
 - import
 - index
 - json
 - keyword index
 - manpage
 - markup
 - parsing
 - plugin
 - reference
 - url
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx::import - Importing keyword indices

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx::import]{.lit} [0.2.2]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::map]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [pluginmgr]{.lit} 
[::doctools::idx::import]{.cmd} [objectName]{.arg} 
[objectName]{.cmd} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [import]{.sub} [text]{.lit} [text]{.arg} [format]{.optarg} 
[objectName]{.ins} [import]{.sub} [file]{.lit} [path]{.arg} [format]{.optarg} 
[objectName]{.ins} [import]{.sub} [object]{.lit} [text]{.lit} [object]{.arg} [text]{.arg} [format]{.optarg} 
[objectName]{.ins} [import]{.sub} [object]{.lit} [file]{.lit} [object]{.arg} [path]{.arg} [format]{.optarg} 
[objectName]{.ins} [config]{.sub} [names]{.lit} 
[objectName]{.ins} [config]{.sub} [get]{.lit} 
[objectName]{.ins} [config]{.sub} [set]{.lit} [name]{.arg} [value]{.optarg} 
[objectName]{.ins} [config]{.sub} [unset]{.lit} [pattern...]{.arg} 
[objectName]{.ins} [includes]{.sub} 
[objectName]{.ins} [include]{.sub} [add]{.lit} [path]{.arg} 
[objectName]{.ins} [include]{.sub} [remove]{.lit} [path]{.arg} 
[objectName]{.ins} [include]{.sub} [clear]{.lit} 
[IncludeFile]{.cmd} [currentfile]{.arg} [path]{.arg} 
[import]{.cmd} [text]{.arg} [configuration]{.arg} 
:::

# Description

This package provides a class to manage the plugins for the import of keyword indices from other formats, i.e. their conversion from, for example *docidx*, *json*, etc.

This is one of the three public pillars the management of keyword indices resides on. The other two pillars are

**\[1\]**
: *Exporting keyword indices*, and

**\[2\]**
: *Holding keyword indices* For information about the **Concepts** of keyword indices, and their parts, see the same-named section. For information about the data structure which is the major output of the manager objects provided by this package see the section **Keyword index serialization format**. The plugin system of our class is based on the package **pluginmgr**, and configured to look for plugins using

**\[1\]**
: the environment variable **DOCTOOLS_IDX_IMPORT_PLUGINS**,

**\[2\]**
: the environment variable **DOCTOOLS_IDX_PLUGINS**,

**\[3\]**
: the environment variable **DOCTOOLS_PLUGINS**,

**\[4\]**
: the path "*~/.doctools/idx/import/plugin*"

**\[5\]**
: the path "*~/.doctools/idx/plugin*"

**\[6\]**
: the path "*~/.doctools/plugin*"

**\[7\]**
: the path "*~/.doctools/idx/import/plugins*"

**\[8\]**
: the path "*~/.doctools/idx/plugins*"

**\[9\]**
: the path "*~/.doctools/plugins*"

**\[10\]**
: the registry entry "HKEY_CURRENT_USER\\SOFTWARE\\DOCTOOLS\\IDX\\IMPORT\\PLUGINS"

**\[11\]**
: the registry entry "HKEY_CURRENT_USER\\SOFTWARE\\DOCTOOLS\\IDX\\PLUGINS"

**\[12\]**
: the registry entry "HKEY_CURRENT_USER\\SOFTWARE\\DOCTOOLS\\PLUGINS" The last three are used only when the package is run on a machine using Windows(tm) operating system. The whole system is delivered with two predefined import plugins, namely


**docidx**
: See *docidx import plugin* for details.

**json**
: See *json import plugin* for details. Readers wishing to write their own import plugin for some format, i.e. *plugin writer*s reading and understanding the section containing the **Import plugin API v2 reference** is an absolute necessity, as it specifies the interaction between this package and its plugins in detail.


# Concepts

**\[1\]**
: A *keyword index* consists of a (possibly empty) set of *keywords*.

**\[2\]**
: Each keyword in the set is identified by its name.

**\[3\]**
: Each keyword has a (possibly empty) set of *references*.

**\[4\]**
: A reference can be associated with more than one keyword.

**\[5\]**
: A reference not associated with at least one keyword is not possible however.

**\[6\]**
: Each reference is identified by its target, specified as either an url or symbolic filename, depending on the type of reference (**url**, or **manpage**).

**\[7\]**
: The type of a reference (url, or manpage) depends only on the reference itself, and not the keywords it is associated with.

**\[8\]**
: In addition to a type each reference has a descriptive label as well. This label depends only on the reference itself, and not the keywords it is associated with. A few notes

**\[1\]**
: Manpage references are intended to be used for references to the documents the index is made for. Their target is a symbolic file name identifying the document, and export plugins may replace symbolic with actual file names, if specified.

**\[2\]**
: Url references are intended on the othre hand are inteded to be used for links to anything else, like websites. Their target is an url.

**\[3\]**
: While url and manpage references share a namespace for their identifiers, this should be no problem, given that manpage identifiers are symbolic filenames and as such they should never look like urls, the identifiers for url references.


# Api

## Package commands

**::doctools::idx::import** *objectName*
: This command creates a new import manager object with an associated Tcl command whose name is *objectName*. This *object* command is explained in full detail in the sections **Object command** and **Object methods**. The object command will be created under the current namespace if the *objectName* is not fully qualified, and in the specified namespace otherwise.


## Object command

All objects created by the **::doctools::idx::import** command have the following general form:

**objectName** **method** ?*arg arg ...*?
: The method **method** and its *arg*'uments determine the exact behavior of the command. See section **Object methods** for the detailed specifications.


## Object methods

*objectName* **destroy**
: This method destroys the object it is invoked for.

*objectName* **import text** *text* ?*format*?
: This method takes the *text* and converts it from the specified *format* to the canonical serialization of a keyword index using the import plugin for the format. An error is thrown if no plugin could be found for the format. The serialization generated by the conversion process is returned as the result of this method. If no format is specified the method defaults to **docidx**. The specification of what a *canonical* serialization is can be found in the section **Keyword index serialization format**. The plugin has to conform to the interface specified in section **Import plugin API v2 reference**.

*objectName* **import file** *path* ?*format*?
: This method is a convenient wrapper around the **import text** method described by the previous item. It reads the contents of the specified file into memory, feeds the result into **import text** and returns the resulting serialization as its own result.

*objectName* **import object text** *object* *text* ?*format*?
: This method is a convenient wrapper around the **import text** method described by the previous item. It expects that *object* is an object command supporting a **deserialize** method expecting the canonical serialization of a keyword index. It imports the text using **import text** and then feeds the resulting serialization into the *object* via **deserialize**. This method returns the empty string as it result.

*objectName* **import object file** *object* *path* ?*format*?
: This method behaves like **import object text**, except that it reads the text to convert from the specified file instead of being given it as argument.

*objectName* **config names**
: This method returns a list containing the names of all configuration variables currently known to the object.

*objectName* **config get**
: This method returns a dictionary containing the names and values of all configuration variables currently known to the object.

*objectName* **config set** *name* ?*value*?
: This method sets the configuration variable *name* to the specified *value* and returns the new value of the variable. If no value is specified it simply returns the current value, without changing it. Note that while the user can set the predefined configuration variables **user** and **format** doing so will have no effect, these values will be internally overridden when invoking an import plugin.

*objectName* **config unset** *pattern*...
: This method unsets all configuration variables matching the specified glob *pattern*s. If no pattern is specified it will unset all currently defined configuration variables.

*objectName* **includes**
: This method returns a list containing the currently specified paths to use to search for include files when processing input. The order of paths in the list corresponds to the order in which they are used, from first to last, and also corresponds to the order in which they were added to the object.

*objectName* **include add** *path*
: This methods adds the specified *path* to the list of paths to use to search for include files when processing input. The path is added to the end of the list, causing it to be searched after all previously added paths. The result of the command is the empty string. The method does nothing if the path is already known.

*objectName* **include remove** *path*
: This methods removes the specified *path* from the list of paths to use to search for include files when processing input. The result of the command is the empty string. The method does nothing if the path is not known.

*objectName* **include clear**
: This method clears the list of paths to use to search for include files when processing input. The result of the command is the empty string.


# Import plugin api v2 reference

Plugins are what this package uses to manage the support for any input format beyond the **Keyword index serialization format**. Here we specify the API the objects created by this package use to interact with their plugins.

A plugin for this package has to follow the rules listed below:

**\[1\]**
: A plugin is a package.

**\[2\]**
: The name of a plugin package has the form doctools::idx::import::**FOO**, where **FOO** is the name of the format the plugin will generate output for. This name is also the argument to provide to the various **import** methods of import manager objects to get a string encoding a keyword index in that format.

**\[3\]**
: The plugin can expect that the package **doctools::idx::export::plugin** is present, as indicator that it was invoked from a genuine plugin manager.

**\[4\]**
: The plugin can expect that a command named **IncludeFile** is present, with the signature


**IncludeFile** *currentfile* *path*
: This command has to be invoked by the plugin when it has to process an included file, if the format has the concept of such. An example of such a format would be *docidx*. The plugin has to supply the following arguments


string *currentfile*
: The path of the file it is currently processing. This may be the empty string if no such is known.

string *path*
: The path of the include file as specified in the include directive being processed.


: The result of the command will be a 5-element list containing


**\[1\]**
: A boolean flag indicating the success (**True**) or failure (**False**) of the operation.

**\[2\]**
: In case of success the contents of the included file, and the empty string otherwise.

**\[3\]**
: The resolved, i.e. absolute path of the included file, if possible, or the unchanged *path* argument. This is for display in an error message, or as the *currentfile* argument of another call to **IncludeFile** should this file contain more files.

**\[4\]**
: In case of success an empty string, and for failure a code indicating the reason for it, one of


**notfound**
: The specified file could not be found.

**notread**
: The specified file was found, but not be read into memory.


**\[5\]**
: An empty string in case of success of a **notfound** failure, and an additional error message describing the reason for a **notread** error in more detail.


**\[5\]**
: A plugin has to provide one command, with the signature shown below.


**import** *text* *configuration*
: Whenever an import manager of **doctools::idx** has to parse input for an index it will invoke this command.


string *text*
: This argument will contain the text encoding the index per the format the plugin is for.

dictionary *configuration*
: This argument will contain the current configuration to apply to the parsing, as a dictionary mapping from variable names to values. The following configuration variables have a predefined meaning all plugins have to obey, although they can ignore this information at their discretion. Any other other configuration variables recognized by a plugin will be described in the manpage for that plugin.


**user**
: This variable is expected to contain the name of the user owning the process invoking the plugin.

**format**
: This variable is expected to contain the name of the format whose plugin is invoked.


**\[6\]**
: A single usage cycle of a plugin consists of the invokations of the command **import**. This call has to leave the plugin in a state where another usage cycle can be run without problems.


# Keyword index serialization format

Here we specify the format used by the doctools v2 packages to serialize keyword indices as immutable values for transport, comparison, etc.

We distinguish between *regular* and *canonical* serializations. While a keyword index may have more than one regular serialization only exactly one of them will be *canonical*.

**regular serialization**
: 


**\[1\]**
: An index serialization is a nested Tcl dictionary.

**\[2\]**
: This dictionary holds a single key, **doctools::idx**, and its value. This value holds the contents of the index.

**\[3\]**
: The contents of the index are a Tcl dictionary holding the title of the index, a label, and the keywords and references. The relevant keys and their values are


**title**
: The value is a string containing the title of the index.

**label**
: The value is a string containing a label for the index.

**keywords**
: The value is a Tcl dictionary, using the keywords known to the index as keys. The associated values are lists containing the identifiers of the references associated with that particular keyword. Any reference identifier used in these lists has to exist as a key in the **references** dictionary, see the next item for its definition.

**references**
: The value is a Tcl dictionary, using the identifiers for the references known to the index as keys. The associated values are 2-element lists containing the type and label of the reference, in this order. Any key here has to be associated with at least one keyword, i.e. occur in at least one of the reference lists which are the values in the **keywords** dictionary, see previous item for its definition.


**\[4\]**
: The *type* of a reference can be one of two values,


**manpage**
: The identifier of the reference is interpreted as symbolic file name, referring to one of the documents the index was made for.

**url**
: The identifier of the reference is interpreted as an url, referring to some external location, like a website, etc.


**canonical serialization**
: The canonical serialization of a keyword index has the format as specified in the previous item, and then additionally satisfies the constraints below, which make it unique among all the possible serializations of the keyword index.


**\[1\]**
: The keys found in all the nested Tcl dictionaries are sorted in ascending dictionary order, as generated by Tcl's builtin command **lsort -increasing -dict**.

**\[2\]**
: The references listed for each keyword of the index, if any, are listed in ascending dictionary order of their *labels*, as generated by Tcl's builtin command **lsort -increasing -dict**.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *doctools* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Documentation tools

# Copyright

```
Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
