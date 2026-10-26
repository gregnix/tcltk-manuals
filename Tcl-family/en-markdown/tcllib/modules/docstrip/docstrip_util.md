---
CommandName: docstrip_util
title: docstrip_util
ManualSection: n
Version: 1.3.3
TclPart: tcllib
TclDescription: Literate programming tool
Links:
 - docstrip
 - doctools
 - doctools_fmt
Keywords:
 - \.ddt
 - .dtx
 - LaTeX
 - Tcl module
 - catalogue
 - diff
 - docstrip
 - doctools
 - documentation
 - literate programming
 - module
 - package indexing
 - patch
 - source
Copyright:
 - Copyright (c) 2003–2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
---

# Name

docstrip\_util - Docstrip-related utilities

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [docstrip]{.lit} [1.3]{.optlit}
[package]{.cmd} [require]{.sub} [docstrip::util]{.lit} [1.3.3]{.optlit}
[pkgProvide]{.cmd} [name]{.arg} [version]{.arg} [terminals]{.arg}
[pkgIndex]{.cmd} [terminal]{.optdot}
[fileoptions]{.cmd} [option value]{.optdot}
[docstrip::util::index\_from\_catalogue]{.cmd} [dir]{.arg} [pattern]{.arg} [option value]{.optdot}
[docstrip::util::modules\_from\_catalogue]{.cmd} [target]{.arg} [source]{.arg} [option value]{.optdot}
[docstrip::util::classical\_preamble]{.cmd} [metaprefix]{.arg} [message]{.arg} [target]{.arg} [source terminals]{.optdot}
[docstrip::util::classical\_postamble]{.cmd} [metaprefix]{.arg} [message]{.arg} [target]{.arg} [source terminals]{.optdot}
[docstrip::util::packages\_provided]{.cmd} [text]{.arg} [setup-script]{.optarg}
[docstrip::util::ddt2man]{.cmd} [text]{.arg}
[docstrip::util::guards]{.cmd} [subcmd]{.arg} [text]{.arg}
[docstrip::util::patch]{.cmd} [source-var]{.arg} [terminals]{.arg} [fromtext]{.arg} [diff]{.arg} [option value]{.optdot}
[docstrip::util::thefile]{.cmd} [filename]{.arg} [option value]{.optdot}
[docstrip::util::import\_unidiff]{.cmd} [diff-text]{.arg} [warning-var]{.optarg}
:::

# Description

The **docstrip::util** package is meant for collecting various utility procedures that are mainly useful at installation or development time. It is separate from the base package to avoid overhead when the latter is used to **source** code.

# Package indexing commands

Like raw "*.tcl*" files, code lines in docstrip source files can be searched for package declarations and corresponding indices constructed. A complication is however that one cannot tell from the code blocks themselves which will fit together to make a working package; normally that information would be found in an accompanying "*.ins*" file, but parsing one of those is not an easy task. Therefore **docstrip::util** introduces an alternative encoding of such information, in the form of a declarative Tcl script: the *catalogue* (of the contents in a source file).

The special commands which are available inside a catalogue are:

**pkgProvide** *name* *version* *terminals*
: Declares that the code for a package with name *name* and version *version* is made up from those modules in the source file which are selected by the *terminals* list of guard expression terminals. This code should preferably not contain a **package** **provide** command for the package, as one will be provided by the package loading mechanisms.

**pkgIndex** ?*terminal* ...?
: Declares that the code for a package is made up from those modules in the source file which are selected by the listed guard expression *terminal*s. The name and version of this package is determined from **package** **provide** command(s) found in that code (hence there must be such a command in there).

**fileoptions** ?*option* *value* ...?
: Declares the **fconfigure** options that should be in force when reading the source; this can usually be ignored for pure ASCII files, but if the file needs to be interpreted according to some other **-encoding** then this is how to specify it. The command should normally appear first in the catalogue, as it takes effect only for commands following it.


Other Tcl commands are supported too — a catalogue is parsed by being evaluated in a safe interpreter — but they are rarely needed. To allow for future extensions, unknown commands in the catalogue are silently ignored.

To simplify distribution of catalogues together with their source files, the catalogue is stored *in the source file itself* as a module selected by the terminal '**docstrip.tcl::catalogue**'. This supports both the style of collecting all catalogue lines in one place and the style of putting each catalogue line in close proximity of the code that it declares.

Putting catalogue entries next to the code they declare may look as follows

```
%    First there's the catalogue entry
%    \begin{tcl}
%<docstrip.tcl::catalogue>pkgProvide foo::bar 1.0 {foobar load}
%    \end{tcl}
%    second a metacomment used to include a copyright message
%    \begin{macrocode}
%<*foobar>
%% This file is placed in the public domain.
%    \end{macrocode}
%    third the package implementation
%    \begin{tcl}
namespace eval foo::bar {
   # ... some clever piece of Tcl code elided ...
%    \end{tcl}
%    which at some point may have variant code to make use of a
%    |load|able extension
%    \begin{tcl}
%<*load>
   load [file rootname [info script]][info sharedlibextension]
%</load>
%<*!load>
   # ... even more clever scripted counterpart of the extension
   # also elided ...
%</!load>
}
%</foobar>
%    \end{tcl}
%    and that's it!
```

The corresponding set-up with **pkgIndex** would be

```
%    First there's the catalogue entry
%    \begin{tcl}
%<docstrip.tcl::catalogue>pkgIndex foobar load
%    \end{tcl}
%    second a metacomment used to include a copyright message
%    \begin{tcl}
%<*foobar>
%% This file is placed in the public domain.
%    \end{tcl}
%    third the package implementation
%    \begin{tcl}
package provide foo::bar 1.0
namespace eval foo::bar {
   # ... some clever piece of Tcl code elided ...
%    \end{tcl}
%    which at some point may have variant code to make use of a
%    |load|able extension
%    \begin{tcl}
%<*load>
   load [file rootname [info script]][info sharedlibextension]
%</load>
%<*!load>
   # ... even more clever scripted counterpart of the extension
   # also elided ...
%</!load>
}
%</foobar>
%    \end{tcl}
%    and that's it!
```

**docstrip::util::index\_from\_catalogue** *dir* *pattern* ?*option* *value* ...?
: This command is a sibling of the standard **pkg\_mkIndex** command, in that it adds package entries to "*pkgIndex.tcl*" files. The difference is that it indexes **docstrip**-style source files rather than raw "*.tcl*" or loadable library files. Only packages listed in the catalogue of a file are considered.

    The *dir* argument is the directory in which to look for files (and whose "*pkgIndex.tcl*" file should be amended). The *pattern* argument is a **glob** pattern of files to look into; a typical value would be **\*.dtx** or **\*.{dtx,ddt}**. Remaining arguments are option-value pairs, where the supported options are:

    **-recursein** *dirpattern*
    : If this option is given, then the **index\_from\_catalogue** operation will be repeated in each subdirectory whose name matches the *dirpattern*. **-recursein** **\*** will cause the entire subtree rooted at *dir* to be indexed.

    **-sourceconf** *dictionary*
    : Specify **fileoptions** to use when reading the catalogues of files (and also for reading the packages if the catalogue does not contain a **fileoptions** command). Defaults to being empty. Primarily useful if your system encoding is very different from that of the source file (e.g., one is a two-byte encoding and the other is a one-byte encoding). **ascii** and **utf-8** are not very different in that sense.

    **-options** *terminals*
    : The *terminals* is a list of terminals in addition to **docstrip.tcl::catalogue** that should be held as true when extracting the catalogue. Defaults to being empty. This makes it possible to make use of "variant sections" in the catalogue itself, e.g. gaurd some entries with an extra "experimental" and thus prevent them from appearing in the index unless that is generated with "experimental" among the **-options**.

    **-report** *boolean*
    : If the *boolean* is true then the return value will be a textual, probably multiline, report on what was done. Defaults to false, in which case there is no particular return value.

    **-reportcmd** *commandPrefix*
    : Every item in the report is handed as an extra argument to the command prefix. Since **index\_from\_catalogue** would typically be used at a rather high level in installation scripts and the like, the *commandPrefix* defaults to "**puts** **stdout**". Use **list** to effectively disable this feature. The return values from the prefix are ignored.


    The **package ifneeded** scripts that are generated contain one **package require docstrip** command and one [docstrip::sourcefrom][docstrip] command. If the catalogue entry was of the **pkgProvide** kind then the **package ifneeded** script also contains the **package provide** command.

    Note that **index\_from\_catalogue** never removes anything from an existing "*pkgIndex.tcl*" file. Hence you may need to delete it (or have **pkg\_mkIndex** recreate it from scratch) before running **index\_from\_catalogue** to update some piece of information, such as a package version number.

**docstrip::util::modules\_from\_catalogue** *target* *source* ?*option* *value* ...?
: This command is an alternative to **index\_from\_catalogue** which creates Tcl Module ("*.tm*") files rather than "*pkgIndex.tcl*" entries. Since this action is more similar to what **docstrip** classically does, it has features for putting pre- and postambles on the generated files.

    The *source* argument is the name of the source file to generate "*.tm*" files from. The *target* argument is the directory which should count as a module path, i.e., this is what the relative paths derived from package names are joined to. The supported options are:

    **-preamble** *message*
    : A message to put in the preamble (initial block of comments) of generated files. Defaults to a space. May be several lines, which are then separated by newlines. Traditionally used for copyright notices or the like, but metacomment lines provide an alternative to that.

    **-postamble** *message*
    : Like **-preamble**, but the message is put at the end of the file instead of the beginning. Defaults to being empty.

    **-sourceconf** *dictionary*
    : Specify **fileoptions** to use when reading the catalogue of the *source* (and also for reading the packages if the catalogue does not contain a **fileoptions** command). Defaults to being empty. Primarily useful if your system encoding is very different from that of the source file (e.g., one is a two-byte encoding and the other is a one-byte encoding). **ascii** and **utf-8** are not very different in that sense.

    **-options** *terminals*
    : The *terminals* is a list of terminals in addition to **docstrip.tcl::catalogue** that should be held as true when extracting the catalogue. Defaults to being empty. This makes it possible to make use of "variant sections" in the catalogue itself, e.g. gaurd some entries with an extra "experimental" guard and thus prevent them from contributing packages unless those are generated with "experimental" among the **-options**.

    **-formatpreamble** *commandPrefix*
    : Command prefix used to actually format the preamble. Takes four additional arguments *message*, *targetFilename*, *sourceFilename*, and *terminalList* and returns a fully formatted preamble. Defaults to using **classical\_preamble** with a *metaprefix* of '##'.

    **-formatpostamble** *commandPrefix*
    : Command prefix used to actually format the postamble. Takes four additional arguments *message*, *targetFilename*, *sourceFilename*, and *terminalList* and returns a fully formatted postamble. Defaults to using **classical\_postamble** with a *metaprefix* of '##'.

    **-report** *boolean*
    : If the *boolean* is true (which is the default) then the return value will be a textual, probably multiline, report on what was done. If it is false then there is no particular return value.

    **-reportcmd** *commandPrefix*
    : Every item in the report is handed as an extra argument to this command prefix. Defaults to **list**, which effectively disables this feature. The return values from the prefix are ignored. Use for example "**puts** **stdout**" to get report items written immediately to the terminal.


    An existing file of the same name as one to be created will be overwritten.

**docstrip::util::classical\_preamble** *metaprefix* *message* *target* ?*source* *terminals* ...?
: This command returns a preamble in the classical **docstrip** style

    ```
    ##
    ## This is `TARGET',
    ## generated by the docstrip::util package.
    ##
    ## The original source files were:
    ##
    ## SOURCE (with options: `foo,bar')
    ##
    ## Some message line 1
    ## line2
    ## line3
    ```

    if called as

    ```
    docstrip::util::classical_preamble {##}\
      "\nSome message line 1\nline2\nline3" TARGET SOURCE {foo bar}
    ```

    The command supports preambles for files generated from multiple sources, even though **modules\_from\_catalogue** at present does not need that.

**docstrip::util::classical\_postamble** *metaprefix* *message* *target* ?*source* *terminals* ...?
: This command returns a postamble in the classical **docstrip** style

    ```
    ## Some message line 1
    ## line2
    ## line3
    ##
    ## End of file `TARGET'.
    ```

    if called as

    ```
    docstrip::util::classical_postamble {##}\
      "Some message line 1\nline2\nline3" TARGET SOURCE {foo bar}
    ```

    In other words, the *source* and *terminals* arguments are ignored, but supported for symmetry with **classical\_preamble**.

**docstrip::util::packages\_provided** *text* ?*setup-script*?
: This command returns a list where every even index element is the name of a package **provide**d by *text* when that is evaluated as a Tcl script, and the following odd index element is the corresponding version. It is used to do package indexing of extracted pieces of code, in the manner of **pkg\_mkIndex**.

    One difference to **pkg\_mkIndex** is that the *text* gets evaluated in a safe interpreter. **package require** commands are silently ignored, as are unknown commands (which includes **source** and **load**). Other errors cause processing of the *text* to stop, in which case only those package declarations that had been encountered before the error will be included in the return value.

    The *setup-script* argument can be used to customise the evaluation environment, if the code in *text* has some very special needs. The *setup-script* is evaluated in the local context of the **packages\_provided** procedure just before the *text* is processed. At that time, the name of the slave command for the safe interpreter that will do this processing is kept in the local variable **c**. To for example copy the contents of the **::env** array to the safe interpreter, one might use a *setup-script* of

    ```
      $c eval [list array set env [array get ::env]]
    ```


# Source processing commands

Unlike the previous group of commands, which would use [docstrip::extract][docstrip] to extract some code lines and then process those further, the following commands operate on text consisting of all types of lines.

**docstrip::util::ddt2man** *text*
: The **ddt2man** command reformats *text* from the general **docstrip** format to **doctools** "*.man*" format (Tcl Markup Language for Manpages). The different line types are treated as follows:

    comment and metacomment lines
    : The '%' and '%%' prefixes are removed, the rest of the text is kept as it is.

    empty lines
    : These are kept as they are. (Effectively this means that they will count as comment lines after a comment line and as code lines after a code line.)

    code lines
    : **example\_begin** and **example\_end** commands are placed at the beginning and end of every block of consecutive code lines. Brackets in a code line are converted to **lb** and **rb** commands.

    verbatim guards
    : These are processed as usual, so they do not show up in the result but every line in a verbatim block is treated as a code line.

    other guards
    : These are treated as code lines, except that the actual guard is **emph**asised.


    At the time of writing, no project has employed **doctools** markup in master source files, so experience of what works well is not available. A source file could however look as follows

    ```
    % [manpage_begin gcd n 1.0]
    % [keywords divisor]
    % [keywords math]
    % [moddesc {Greatest Common Divisor}]
    % [require gcd [opt 1.0]]
    % [description]
    %
    % [list_begin definitions]
    % [call [cmd gcd] [arg a] [arg b]]
    %   The [cmd gcd] procedure takes two arguments [arg a] and [arg b] which
    %   must be integers and returns their greatest common divisor.
    proc gcd {a b} {
    %   The first step is to take the absolute values of the arguments.
    %   This relieves us of having to worry about how signs will be treated
    %   by the remainder operation.
       set a [expr {abs($a)}]
       set b [expr {abs($b)}]
    %   The next line does all of Euclid's algorithm! We can make do
    %   without a temporary variable, since $a is substituted before the
    %   [lb]set a $b[rb] and thus continues to hold a reference to the
    %   "old" value of [var a].
       while {$b>0} { set b [expr { $a % [set a $b] }] }
    %   In Tcl 8.3 we might want to use [cmd set] instead of [cmd return]
    %   to get the slight advantage of byte-compilation.
    %<tcl83>  set a
    %<!tcl83>   return $a
    }
    % [list_end]
    %
    % [manpage_end]
    ```

    If the above text is fed through **docstrip::util::ddt2man** then the result will be a syntactically correct **doctools** manpage, even though its purpose is a bit different.

    It is suggested that master source code files with **doctools** markup are given the suffix "*.ddt*", hence the "ddt" in **ddt2man**.

**docstrip::util::guards** *subcmd* *text*
: The **guards** command returns information (mostly of a statistical nature) about the ordinary docstrip guards that occur in the *text*. The *subcmd* selects what is returned.

    **counts**
    : List the guard expression terminals with counts. The format of the return value is a dictionary which maps the terminal name to the number of occurencies of it in the file.

    **exprcount**
    : List the guard expressions with counts. The format of the return value is a dictionary which maps the expression to the number of occurencies of it in the file.

    **exprerr**
    : List the syntactically incorrect guard expressions (e.g. parentheses do not match, or a terminal is missing). The return value is a list, with the elements in no particular order.

    **expressions**
    : List the guard expressions. The return value is a list, with the elements in no particular order.

    **exprmods**
    : List the guard expressions with modifiers. The format of the return value is a dictionary where each index is a guard expression and each entry is a string with one character for every guard line that has this expression. The characters in the entry specify what modifier was used in that line: +, -, \*, /, or (for guard without modifier:) space. This is the most primitive form of the information gathered by **guards**.

    **names**
    : List the guard expression terminals. The return value is a list, with the elements in no particular order.

    **rotten**
    : List the malformed guard lines (this does not include lines where only the expression is malformed, though). The format of the return value is a dictionary which maps line numbers to their contents.


**docstrip::util::patch** *source-var* *terminals* *fromtext* *diff* ?*option* *value* ...?
: This command tries to apply a **diff** file (for example a contributed patch) that was computed for a generated file to the **docstrip** source. This can be useful if someone has edited a generated file, thus mistaking it for being the source. This command makes no presumptions which are specific for the case that the generated file is a Tcl script.

    **patch** requires that the source file to patch is kept as a list of lines in a variable, and the name of that variable in the calling context is what goes into the *source-var* argument. The *terminals* is the list of terminals used to extract the file that has been patched. The *diff* is the actual diff to apply (in a format as explained below) and the *fromtext* is the contents of the file which served as "from" when the diff was computed. Options can be used to further control the process.

    The process works by "lifting" the hunks in the *diff* from generated to source file, and then applying them to the elements of the *source-var*. In order to do this lifting, it is necessary to determine how lines in the *fromtext* correspond to elements of the *source-var*, and that is where the *terminals* come in; the source is first **extract**ed under the given *terminals*, and the result of that is then matched against the *fromtext*. This produces a map which translates line numbers stated in the *diff* to element numbers in *source-var*, which is what is needed to lift the hunks.

    The reason that both the *terminals* and the *fromtext* must be given is twofold. First, it is very difficult to keep track of how many lines of preamble are supplied some other way than by copying lines from source files. Second, a generated file might contain material from several source files. Both make it impossible to predict what line number an extracted file would have in the generated file, so instead the algorithm for computing the line number map looks for a block of lines in the *fromtext* which matches what can be extracted from the source. This matching is affected by the following options:

    **-matching** *mode*
    : How equal must two lines be in order to match? The supported *mode*s are:

        **exact**
        : Lines must be equal as strings. This is the default.

        **anyspace**
        : All sequences of whitespace characters are converted to single spaces before comparing.

        **nonspace**
        : Only non-whitespace characters are considered when comparing.

        **none**
        : Any two lines are considered to be equal.


    **-metaprefix** *string*
    : The **-metaprefix** value to use when extracting. Defaults to "%%", but for Tcl code it is more likely that "#" or "##" had been used for the generated file.

    **-trimlines** *boolean*
    : The **-trimlines** value to use when extracting. Defaults to true.


    The return value is in the form of a unified diff, containing only those hunks which were not applied or were only partially applied; a comment in the header of each hunk specifies which case is at hand. It is normally necessary to manually review both the return value from **patch** and the patched text itself, as this command cannot adjust comment lines to match new content.

    An example use would look like

    ```
    set sourceL [split [docstrip::util::thefile from.dtx] \n]
    set terminals {foo bar baz}
    set fromtext [docstrip::util::thefile from.tcl]
    set difftext [exec diff --unified from.tcl to.tcl]
    set leftover [docstrip::util::patch sourceL $terminals $fromtext\
      [docstrip::util::import_unidiff $difftext] -metaprefix {#}]
    set F [open to.dtx w]; puts $F [join $sourceL \n]; close $F
    return $leftover
    ```

    Here, "*from.dtx*" was used as source for "*from.tcl*", which someone modified into "*to.tcl*". We're trying to construct a "*to.dtx*" which can be used as source for "*to.tcl*".

**docstrip::util::thefile** *filename* ?*option* *value* ...?
: The **thefile** command opens the file *filename*, reads it to end, closes it, and returns the contents (dropping a final newline if there is one). The option-value pairs are passed on to **fconfigure** to configure the open file channel before anything is read from it.

**docstrip::util::import\_unidiff** *diff-text* ?*warning-var*?
: This command parses a unified (**diff** flags **-U** and **--unified**) format diff into the list-of-hunks format expected by **docstrip::util::patch**. The *diff-text* argument is the text to parse and the *warning-var* is, if specified, the name in the calling context of a variable to which any warnings about parsing problems will be **append**ed.

    The return value is a list of *hunks*. Each hunk is a list of five elements "*start1* *end1* *start2* *end2* *lines*". *start1* and *end1* are line numbers in the "from" file of the first and last respectively lines of the hunk. *start2* and *end2* are the corresponding line numbers in the "to" file. Line numbers start at 1. The *lines* is a list with two elements for each line in the hunk; the first specifies the type of a line and the second is the actual line contents. The type is **-** for lines only in the "from" file, **+** for lines that are only in the "to" file, and **0** for lines that are in both.


# Category

Documentation tools

# Copyright

```
Copyright (c) 2003–2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
```


[docstrip]: docstrip.md
