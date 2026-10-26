---
CommandName: page_pluginmgr
title: page_pluginmgr
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - page
 - parser generator
 - text processing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_pluginmgr - page plugin manager

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::pluginmgr]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[::page::pluginmgr::reportvia]{.cmd} [cmd]{.arg}
[::page::pluginmgr::report]{.cmd} [level]{.arg} [text]{.arg} [from ?to]{.optarg}
[::page::pluginmgr::log]{.cmd} [cmd]{.arg}
[::page::pluginmgr::configuration]{.cmd} [name]{.arg}
[::page::pluginmgr::reader]{.cmd} [name]{.arg}
[::page::pluginmgr::rconfigure]{.cmd} [dict]{.arg}
[::page::pluginmgr::rtimeable]{.cmd}
[::page::pluginmgr::rtime]{.cmd}
[::page::pluginmgr::rgettime]{.cmd}
[::page::pluginmgr::rhelp]{.cmd}
[::page::pluginmgr::rlabel]{.cmd}
[::page::pluginmgr::read]{.cmd} [read]{.arg} [eof]{.arg} [complete]{.optarg}
[read]{.ins} [num]{.sub}
[eof]{.ins}
[done]{.ins}
[::page::pluginmgr::writer]{.cmd} [name]{.arg}
[::page::pluginmgr::wconfigure]{.cmd} [dict]{.arg}
[::page::pluginmgr::wtimeable]{.cmd}
[::page::pluginmgr::wtime]{.cmd}
[::page::pluginmgr::wgettime]{.cmd}
[::page::pluginmgr::whelp]{.cmd}
[::page::pluginmgr::wlabel]{.cmd}
[::page::pluginmgr::write]{.cmd} [chan]{.arg} [data]{.arg}
[::page::pluginmgr::transform]{.cmd} [name]{.arg}
[::page::pluginmgr::tconfigure]{.cmd} [id]{.arg} [dict]{.arg}
[::page::pluginmgr::ttimeable]{.cmd} [id]{.arg}
[::page::pluginmgr::ttime]{.cmd} [id]{.arg}
[::page::pluginmgr::tgettime]{.cmd} [id]{.arg}
[::page::pluginmgr::thelp]{.cmd} [id]{.arg}
[::page::pluginmgr::tlabel]{.cmd} [id]{.arg}
[::page::pluginmgr::transform\_do]{.cmd} [id]{.arg} [data]{.arg}
[page\_cdefinition]{.cmd}
[page\_rfeature]{.cmd} [name]{.arg}
[page\_rtime]{.cmd}
[page\_rgettime]{.cmd}
[page\_rlabel]{.cmd}
[page\_rhelp]{.cmd}
[page\_roptions]{.cmd}
[page\_rconfigure]{.cmd} [option]{.arg} [value]{.arg}
[page\_rrun]{.cmd}
[page\_read]{.cmd} [num]{.arg}
[page\_read\_done]{.cmd}
[page\_eof]{.cmd}
[page\_info]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_warning]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_error]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_log\_info]{.cmd} [text]{.arg}
[page\_log\_warning]{.cmd} [text]{.arg}
[page\_log\_error]{.cmd} [text]{.arg}
[page\_wfeature]{.cmd}
[page\_wtime]{.cmd}
[page\_wgettime]{.cmd}
[page\_wlabel]{.cmd}
[page\_whelp]{.cmd}
[page\_woptions]{.cmd}
[page\_wconfigure]{.cmd} [option]{.arg} [value]{.arg}
[page\_wrun]{.cmd} [chan]{.arg} [data]{.arg}
[page\_info]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_warning]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_error]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_log\_info]{.cmd} [text]{.arg}
[page\_log\_warning]{.cmd} [text]{.arg}
[page\_log\_error]{.cmd} [text]{.arg}
[page\_tfeature]{.cmd}
[page\_ttime]{.cmd}
[page\_tgettime]{.cmd}
[page\_tlabel]{.cmd}
[page\_thelp]{.cmd}
[page\_toptions]{.cmd}
[page\_tconfigure]{.cmd} [option]{.arg} [value]{.arg}
[page\_trun]{.cmd} [chan]{.arg} [data]{.arg}
[page\_info]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_warning]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_error]{.cmd} [text]{.arg} [from ?to]{.optarg}
[page\_log\_info]{.cmd} [text]{.arg}
[page\_log\_warning]{.cmd} [text]{.arg}
[page\_log\_error]{.cmd} [text]{.arg}
:::

# Description

This package provides the plugin manager central to the **page** application. It manages the various reader, writer, configuration, and transformation plugins which actually process the text (read, transform, and write).

All plugins are loaded into slave interpreters specially prepared for them. While implemented using packages they need this special environment and are not usable in a plain interpreter, like tclsh. Because of that they are only described in general terms in section [Predefined plugins], and not documented as regular packages. It is expected that they follow the APIs specified in the sections

1. [Config plugin API]

2. [Reader plugin API]

3. [Writer plugin API]

4. **TRANSFORM PLUGIN API**


as per their type.

# API

**::page::pluginmgr::reportvia** *cmd*
: This command defines the callback command used by **::page::pluginmgr::report** (see below) to report input errors and warnings. The default is to write such reports to the standard error channel.

**::page::pluginmgr::report** *level* *text* ?*from* ?*to*??
: This command is used to report input errors and warnings. By default such reports are written to the standard error. This can be changed by setting a user-specific callback command with **::page::pluginmgr::reportvia** (see above).

    The arguments *level* and *text* specify both the importance of the message, and the message itself. For the former see the package **logger** for the allowed values.

    The optional argument *from* and *to* can be used by the caller to indicate the location (or range) in the input where the reported problem occured. Each is a list containing two elements, the line and the column in the input, in this order.

**::page::pluginmgr::log** *cmd*
: This command defines a log callback command to be used by loaded plugins for the reporting of internal errors, warnings, and general information. Specifying the empty string as callback disables logging.

    Note: The *cmd* has to be created by the **logger** package, or follow the same API as such.

    The command returns the empty string as its result.

**::page::pluginmgr::configuration** *name*
: This command loads the named configuration plugin, retrieves the options encoded in it, and then immediately unloads it again.

    If the *name* is the path to a file, then this files will be tried to be loaded as a plugin first, and, if that fails, opened and its contents read as a list of options and their arguments, separated by spaces, tabs and newlines, possibly quotes with single and double quotes.

    See section [Config plugin API] for the API expected of configuration plugins.

    The result of the command is the list of options retrieved.

**::page::pluginmgr::reader** *name*
: This command loads the named reader plugin and initializes it. The result of the command is a list of options the plugin understands.

    Only a single reader plugin can be loaded. Loading another reader plugin causes the previously loaded reader plugin to be de-initialized and unloaded.

    See section [Reader plugin API] for the API expected of reader plugins.

**::page::pluginmgr::rconfigure** *dict*
: This commands configures the loaded reader plugin. The options and their values are provided as a Tcl dictionary. The result of the command is the empty string.

**::page::pluginmgr::rtimeable**
: This commands checks if the loaded reader plugin is able to collect timing statistics. The result of the command is a boolean flag. The result is **true** if the plugin can be timed, and **false** otherwise.

**::page::pluginmgr::rtime**
: This command activates the collection of timing statistics in the loaded reader plugin.

**::page::pluginmgr::rgettime**
: This command retrieves the collected timing statistics of the loaded reader plugin after it was executed.

**::page::pluginmgr::rhelp**
: This command retrieves the help string of the loaded reader plugin. This is expected to be in *doctools* format.

**::page::pluginmgr::rlabel**
: This command retrieves the human-readable name of the loaded reader plugin.

**::page::pluginmgr::read** *read* *eof* ?*complete*?
: This command invokes the loaded reader plugin to process the input, and returns the results of the plugin as its own result. The input is accessible through the callback commands *read*, and *eof*. The optional *done* can be used to intrecept when the plugin has completed its processing. All arguments are command prefixes.

    The plugin will invoke the various callbacks in the following situations:

    *read* *num*
    : is invoked whenever input to process is needed, with the number of characters/bytes it asks for. The result is expected to be the input the plugin is in need of.

    *eof*
    : is invoked by the plugin to check if the input has reached the of the stream. The result is expected to be a boolean flag, **true** when the input has hit EOF, and **false** otherwise.

    *done*
    : is invoked when the plugin has completed the processing of the input.


**::page::pluginmgr::writer** *name*
: This command loads the named writer plugin and initializes it. The result of the command is a list of options the plugin understands.

    Only a single reader plugin can be loaded. Loading another reader plugin causes the previously loaded reader plugin to be de-initialized and unloaded.

    See section [Writer plugin API] for the API expected of writer plugins.

**::page::pluginmgr::wconfigure** *dict*
: This commands configures the loaded writer plugin. The options and their values are provided as a Tcl dictionary. The result of the command is the empty string.

**::page::pluginmgr::wtimeable**
: This commands checks if the loaded writer plugin is able to measure execution times. The result of the command is a boolean flag. The result is **true** if the plugin can be timed, and **false** otherwise.

**::page::pluginmgr::wtime**
: This command activates the collection of timing statistics in the loaded writer plugin.

**::page::pluginmgr::wgettime**
: This command retrieves the collected timing statistics of the loaded writer plugin after it was executed.

**::page::pluginmgr::whelp**
: This command retrieves the help string of the loaded writer plugin. This is expected to be in *doctools* format.

**::page::pluginmgr::wlabel**
: This command retrieves the human-readable name of the loaded writer plugin.

**::page::pluginmgr::write** *chan* *data*
: The loaded writer plugin is invoked to generate the output. It is given the *data* to generate the outpout from, and the Tcl handle *chan* of the channel to write the generated output to. The command returns th empty string as its result.

**::page::pluginmgr::transform** *name*
: This command loads the named transformation plugin and initializes it. The result of the command is a 2-element list containing the plugin id and a list of options the plugin understands, in this order.

    Multiple transformations plugins can be loaded and are identified by handles.

    See section **TRANSFORM PLUGIN API** for the API expected of transformation plugins.

**::page::pluginmgr::tconfigure** *id* *dict*
: This commands configures the identified transformation plugin. The options and their values are provided as a Tcl dictionary. The result of the command is the empty string.

**::page::pluginmgr::ttimeable** *id*
: This commands checks if the identified transformation plugin is able to collect timing statistics. The result of the command is a boolean flag. The result is **true** if the plugin can be timed, and **false** otherwise.

**::page::pluginmgr::ttime** *id*
: This command activates the collection of timing statistics in the identified transformation plugin.

**::page::pluginmgr::tgettime** *id*
: This command retrieves the collected timing statistics of the identified transformation plugin after it was executed.

**::page::pluginmgr::thelp** *id*
: This command retrieves the help string of the identified transformation plugin. This is expected to be in *doctools* format.

**::page::pluginmgr::tlabel** *id*
: This command retrieves the human-readable name of the identified transformation plugin.

**::page::pluginmgr::transform\_do** *id* *data*
: The identified transformation plugin is invoked to process the specified *data*. The result of the plugin is returned as the result of the command.


# Config plugin API

Configuration plugins are expected to provide a single command, described below.

**page\_cdefinition**
: This command of a configuration plugin is called by the plugin manager to execute it. Its result has to be a list of options and values to process.


Configuration plugins do not expect the environment to provide any special commands.

It is expected that a configuration plugin **FOO** is implemented by the package **page::config::FOO**.

Configuration plugins are loaded, executed, and unloaded in one step, they are not kept in memory. The command for doing this is **::page::pluginmgr::configuration**.

# Reader plugin API

Reader plugins are expected to provide the following commands, described below.

**page\_rfeature** *name*
: This command takes a feature *name* and returns a boolean flag indicating whether the feature is supported by the plugin, or not. The result has to be **true** if the feature is supported, and **false** otherwise.

    See section [Features] for the possible features the plugin manager will ask for.

**page\_rtime**
: This command is invoked to activate the collection of timing statistics.

**page\_rgettime**
: This command is invoked to retrieve the collected timing statistics.

**page\_rlabel**
: This command is invoked to retrieve a human-readable label for the plugin.

**page\_rhelp**
: This command is invoked to retrieve a help text for plugin. The text is expected to be in *doctools* format.

**page\_roptions**
: This command is invoked to retrieve the options understood by the plugin.

**page\_rconfigure** *option* *value*
: This command is invoked to reconfigure the plugin, specifically the given *option* is set to the new *value*.

**page\_rrun**
: This command is invoked to process the input stream per the current plugin configuration.  The result of the command is the result of the processing.


Reader plugins expect the environment to provide the following special commands.

**page\_read** *num*
: This command is invoked to read *num* characters/bytes from the input. Its result has to be read characters/bytes.

**page\_read\_done**
: This command is invoked to signal that the plugin has completed the processing of the input.

**page\_eof**
: This command is invoked to check if the input stream has reached its end. Its result has to be a boolean flag, **true** when the input has reached the end, **false** otherwise.

**page\_info** *text* ?*from* ?*to*??
: Invoked to report some information to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_warning** *text* ?*from* ?*to*??
: Invoked to report a warning to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_error** *text* ?*from* ?*to*??
: Invoked to report an error to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_log\_info** *text*
: Invoked to report some internal information.

**page\_log\_warning** *text*
: Invoked to report an internal warning.

**page\_log\_error** *text*
: Invoked to report an internal error.


It is expected that a reader plugin **FOO** is implemented by the package **page::reader::FOO**.

Reader plugins are loaded by the command **::page::pluginmgr::reader**. At most one reader plugin can be kept in memory.

# Writer plugin API

Writer plugins are expected to provide the following commands, described below.

**page\_wfeature**
: This command takes a feature *name* and returns a boolean flag indicating whether the feature is supported by the plugin, or not. The result has to be **true** if the feature is supported, and **false** otherwise.

    See section [Features] for the possible features the plugin manager will ask for.

**page\_wtime**
: This command is invoked to activate the collection of timing statistics.

**page\_wgettime**
: This command is invoked to retrieve the collected timing statistics.

**page\_wlabel**
: This command is invoked to retrieve a human-readable label for the plugin.

**page\_whelp**
: This command is invoked to retrieve a help text for plugin. The text is expected to be in *doctools* format.

**page\_woptions**
: This command is invoked to retrieve the options understood by the plugin.

**page\_wconfigure** *option* *value*
: This command is invoked to reconfigure the plugin, specifically the given *option* is set to the new *value*.

**page\_wrun** *chan* *data*
: This command is invoked to process the specified *data* and write it to the output stream *chan*. The latter is a Tcl channel handle opened for writing. The result of the command is the empty string.


Writer plugins expect the environment to provide the following special commands.

**page\_info** *text* ?*from* ?*to*??
: Invoked to report some information to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_warning** *text* ?*from* ?*to*??
: Invoked to report a warning to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_error** *text* ?*from* ?*to*??
: Invoked to report an error to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_log\_info** *text*
: Invoked to report some internal information.

**page\_log\_warning** *text*
: Invoked to report an internal warning.

**page\_log\_error** *text*
: Invoked to report an internal error.


It is expected that a writer plugin **FOO** is implemented by the package **page::writer::FOO**.

Writer plugins are loaded by the command **::page::pluginmgr::writer**. At most one writer plugin can be kept in memory.

# Transform plugin API" page::transform::\*

Transformation plugins are expected to provide the following commands, described below.

**page\_tfeature**
: This command takes a feature *name* and returns a boolean flag indicating whether the feature is supported by the plugin, or not. The result has to be **true** if the feature is supported, and **false** otherwise.

    See section [Features] for the possible features the plugin manager will ask for.

**page\_ttime**
: This command is invoked to activate the collection of timing statistics.

**page\_tgettime**
: This command is invoked to retrieve the collected timing statistics.

**page\_tlabel**
: This command is invoked to retrieve a human-readable label for the plugin.

**page\_thelp**
: This command is invoked to retrieve a help text for plugin. The text is expected to be in *doctools* format.

**page\_toptions**
: This command is invoked to retrieve the options understood by the plugin.

**page\_tconfigure** *option* *value*
: This command is invoked to reconfigure the plugin, specifically the given *option* is set to the new *value*.

**page\_trun** *chan* *data*
: This command is invoked to process the specified *data* and write it to the output stream *chan*. The latter is a Tcl channel handle opened for writing. The result of the command is the empty string.


Transformation plugins expect the environment to provide the following special commands.

**page\_info** *text* ?*from* ?*to*??
: Invoked to report some information to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_warning** *text* ?*from* ?*to*??
: Invoked to report a warning to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_error** *text* ?*from* ?*to*??
: Invoked to report an error to the user. May indicate a location or range in the input. Each piece of location data, if provided, is a 2-element list containing line and column numbers.

**page\_log\_info** *text*
: Invoked to report some internal information.

**page\_log\_warning** *text*
: Invoked to report an internal warning.

**page\_log\_error** *text*
: Invoked to report an internal error.


It is expected that a transformation plugin **FOO** is implemented by the package **page::transform::FOO**.

Transformation plugins are loaded by the command **::page::pluginmgr::transform**. More than one transformation plugin can be kept in memory.

# Predefined plugins

The following predefined plugins are known, i.e. provided by the page module.

Configuration
: see below ...

    peg
    : Returns a set of options to configure the **page** application for the processing of a PEG grammar and the generation of ME code. See the packages **grammar\_peg**, **grammar\_me** and relations for more details.


Reader
: see below ...

    hb
    : Expects a so-called *half-baked PEG container* as input and returns the equivalent abstract syntax tree. See the writer plugin *hb* for the plugin generating this type of input.

    lemon
    : Expects a grammar specification as understood by Richar Hipp's LEMON parser generator and returns an abstract syntax tree for it.

    peg
    : Expects a grammar specification in the form of a parsing expression grammar (PEG) and returns an abstract syntax tree for it.

    ser
    : Expect the serialized form of a parsing expression grammar as generated by the package **grammar::peg** as input, converts it into an equivalent abstract syntax tree and returns that.

    treeser
    : Expects the serialized form of a tree as generated by the package **struct::tree** as input and returns it, after validation.


Writer
: see below ...

    hb
    : Expects an abstract syntax tree for a parsing expression grammar as input and writes it out in the form of a so-called *half-baked PEG container*.

    identity
    : Takes any input and writes it as is.

    mecpu
    : Expects symbolic assembler code for the MatchEngine CPU (See the package **grammar::me::cpu** and relatives) and writes it out as Tcl code for a parser.

    me
    : Expects an abstract syntax tree for a parsing expression grammar as input and writes it out as Tcl code for the MatchEngine (See the package **grammar::me** and relatives) which parses input in that grammar.

    null
    : Takes any input and writes nothing. The logical equivalent of /dev/null.

    peg
    : Expects an abstract syntax tree for a parsing expression grammar as input and writes it out in the form of a canonical PEG which can be read by the reader plugin *peg*.

    ser
    : Expects an abstract syntax tree for a parsing expression grammar as input and writes it out as a serialized PEG container which can be read by the reader plugin *ser*.

    tpc
    : Expects an abstract syntax tree for a parsing expression grammar as input and writes it out as Tcl code initializing a PEG container as provided by the package **grammar::peg**.

    tree
    : Takes any serialized tree (per package **struct::tree**) as input and writes it out in a generic indented format.


Transformation
: see below ...

    mecpu
    : Takes an abstract syntax tree for a parsing expression grammer as input, generates symbolic assembler code for the MatchEngine CPU, and returns that as its result (See the package **grammar::me::cpu** and relatives).

    reachable
    : Takes an abstract syntax tree for a parsing expression grammer as input, performs a reachability analysis, and returns the modified and annotated tree.

    realizable
    : Takes an abstract syntax tree for a parsing expression grammer as input, performs an analysis of realizability, and returns the modified and annotated tree.



# Features

The plugin manager currently checks the plugins for only one feature, **timeable**. A plugin supporting this feature is assumed to be able to collect timing statistics on request.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *page* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Page Parser Generator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
