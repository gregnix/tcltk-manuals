---
CommandName: textutil
ManualSection: n
Version: 0.10
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - TeX
 - formatting
 - hyphenation
 - indenting
 - paragraph
 - regular expression
 - string
 - trimming
Copyright:
---

# Name

textutil - Procedures to manipulate texts and strings.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil]{.lit} [0.10]{.optlit} 
[::textutil::adjust::adjust]{.cmd} [string]{.arg} [option value]{.optdot} 
[::textutil::adjust::readPatterns]{.cmd} [filename]{.arg} 
[::textutil::adjust::listPredefined]{.cmd} 
[::textutil::adjust::getPredefined]{.cmd} [filename]{.arg} 
[::textutil::adjust::indent]{.cmd} [string]{.arg} [prefix]{.arg} [skip]{.optarg} 
[::textutil::adjust::undent]{.cmd} [string]{.arg} 
[::textutil::repeat::strRepeat]{.cmd} [text]{.arg} [count]{.arg} 
[::textutil::repeat::blank]{.cmd} [count]{.arg} 
[::textutil::split::splitn]{.cmd} [string]{.arg} [size]{.optarg} 
[::textutil::split::splitx]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::string::chop]{.cmd} [string]{.arg} 
[::textutil::string::tail]{.cmd} [string]{.arg} 
[::textutil::string::cap]{.cmd} [string]{.arg} 
[::textutil::string::capEachWord]{.cmd} [string]{.arg} 
[::textutil::string::uncap]{.cmd} [string]{.arg} 
[::textutil::string::longestCommonPrefixList]{.cmd} [list]{.arg} 
[::textutil::string::longestCommonPrefix]{.cmd} [string]{.optdot} 
[::textutil::tabify::tabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::tabify2]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify2]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::trim::trim]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::trim::trimleft]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::trim::trimright]{.cmd} [string]{.arg} [regexp]{.optarg} 
[::textutil::trim::trimPrefix]{.cmd} [string]{.arg} [prefix]{.arg} 
[::textutil::trim::trimEmptyHeading]{.cmd} [string]{.arg} 
:::

# Description

The **textutil** package provides commands that manipulate strings. This package is a bundle providing the commands of the six subpackages listed below, all of which are in the **textutil** namespace.

**textutil::adjust**
: ...see next...

**textutil::repeat**
: ...see next...

**textutil::split**
: ...see next...

**textutil::string**
: ...see next...

**textutil::tabify**
: ...see next...

**textutil::trim**
: The bundle is *deprecated*, and it will be removed in a future Tcllib  release. Instead of using this package, package require specific subpackages as needed. For convenience, all of the **textutil** namespace’s commands shown above are described in the **API** section below, in addition to being documented in the subpackages themselves. *Note* that the following subpackages are also in the **textutil** namespace but are not part of the bundle, so they must be specifically package required as needed.

**textutil::expander**
: ...see next...

**textutil::patch**
: ...see next...

**textutil::wcswidth**
: The **textutil** namespace’s commands shown above are described only in the subpackages themselves.


# Api

**::textutil::adjust::adjust** *string* ?*option value ...*?
: Returns a copy of *string* modified according to the given options. Any newlines in the original *string* are treated as spaces, i.e., the input *string* is handled as a single paragraph of text. If the result string is shorter than the **-length**, it will not contain any newlines. Otherwise, the result will contain newlines as needed to perform the desired justification. Together with **::textutil::adjust::indent** it is possible to create properly wrapped paragraphs with arbitrary indentations. Under the hood, every newline, tab, or sequence of two or more spaces are treated as a single space, and single spaces are used to separate the line’s words. These are the algorithm’s *real* lines. Every *real* line is placed in a *logical* line, which is exactly **-length** characters wide (even if the *real* line is shorter). Every word in a *real* line is separated by a single space, except when the **-justify** **plain** option is used, in which case words are separated by one or more spaces as needed to fill the *real* line. By default, trailing spaces (including tabs which are first replaced by spaces) are trimmed. See the **-full** option below. The following options may be given after the *string* parameter. They control how the command places each *real* line in its corresponding *logical* line.


**-full** *boolean*
: If set to **0** (false; the default), any trailing spaces are deleted from each line before returning the string. If set to **1** (true), any trailing spaces are left at the end each line.

**-hyphenate** *boolean*
: If set to **0** (false; the default), no hyphenation will be done. If set to **1** (true), the command will try to hyphenate the last word of each line when appropriate. If **-hyphenate** is set to **1**, hyphenation patterns *must* have been loaded by calling the **::textutil::adjust::readPatterns** command, *before* the call to **::textutil::adjust::adjust**; otherwise **::textutil::adjust::adjust** will throw an error.

**-justify** **center|left|plain|right**
: Sets the justification applied to the returned string to any one of: **left** (the default), **center**, **plain** (justified), or **right**. The justification means that any line in the returned string (possibly excluding the last line), is justified according to the given justification. If the justification is set to **plain** (justified), and the number of printable characters in the last line is less than 90% of **-length**, then the last line is justified **left**, avoiding the padding of this line when it is too short. The meaning of each value is:


**center**
: Each *real* line is centered in the *logical* line by padding the *real* line with spaces at the beginning and end as needed. If the last line is less than 90% of **-length**, it will be aligned **left** instead of **center**. (See also the **-full** option.)

**left**
: Each *real* line is placed at the left of the *logical* line, with no preceding spaces. If **-full** is **1** (true), the *real* line will be padded with spaces at the end to make it **-length** characters wide.

**plain**
: Each line is fully justified. This means that each *real* line’s words are placed in the *logical* line, separated by one or more spaces, as needed to completely fill the line with no leading or trailing spaces.

**right**
: Each *real* line is placed at the right of the *logical* line, with no trailing spaces, and padded with leading spaces if needed to make the *real* line **-length** characters wide.


**-length** *integer*
: Sets the *logical* line length to be *integer*. The *integer* must be a positive integer *> 0*. The default is **72**.

**-strictlength** *boolean*
: If set to **0** (false; the default), a line can exceed the specified **-length** if a single word is longer than **-length**. If set to **1** (true), words that are longer than **-length** are split so that no line exceeds the specified **-length**.


**::textutil::adjust::readPatterns** *filename*
: Reads hyphenation patterns from the file called *filename*. This command is needed only if command **::textutil::adjust::adjust** is used with **-hyphenate** **1** (true). In this case the call to **::textutil::adjust::readPatterns** *must* be done *before* calling **::textutil::adjust::adjust**. The **textutil::adjust** package comes with a number of predefined pattern files. Use the **::textutil::adjust::listPredefined** command to list their names.

**::textutil::adjust::listPredefined**
: Returns a list of the names of the hyphenation files provided by this package.

**::textutil::adjust::getPredefined** *filename*
: Returns the full path and filename of the *filename* hyphenation file. *Note* that *filename* *must* be one of the names returned by **::textutil::adjust::listPredefined**.

**::textutil::adjust::indent** *string* *prefix* ?*skip*?
: Returns a modified copy of *string* with every non-skipped line prefixed with *prefix* and whitespace (except for the newline), trimmed from the end. By default no lines are skipped, so all are prefixed. The **skip** option specifies how many lines to skip at the start of the string; its default is **0**, in which case none are skipped and all are prefixed. If **skip** is set to a value *> 0*, then that many initial lines in the string are skipped, i.e., not prefixed, while all the subsequent lines are prefixed. Setting **skip** to **1** will create a conventional hanging indent. Together with **::textutil::adjust::adjust** it is possible to create properly wrapped paragraphs with arbitrary indentations.

**::textutil::adjust::undent** *string*
: Returns a modified copy of *string* with any common prefix of whitespace removed from each line. Empty lines and lines containing only whitespace are ignored for the computation of the prefix and all these lines are returned as empty lines. *Note that this command’s name is* **undent** *not unindent.*

**::textutil::repeat::strRepeat** *text* *count*
: Returns a string containing the *text* repeated *count* times. The repetitions are joined with no separators between them. A value of *count* *<= 0* causes the command to return an empty string. *Note*: If the Tcl core this package is loaded in provides the **string repeat** command, then this command will be implemented in its terms, for maximum speed. Otherwise a fast Tcl implementation is used.

**::textutil::repeat::blank** *count*
: Returns a string containing *count* spaces. This is a convenience for calling **::textutil::repeat::strRepeat** with **" "** as its first argument.

**::textutil::split::splitn** *string* ?*size*?
: Returns a list of strings containing consecutive substrings of *string*, each *size* long—except for the last which will be shorter if *string*’s length is not an exact multiple of *size*. The *size* defaults to **1**, i.e., return a list of *string*’s characters; this is the same as calling the built-in [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) command with a second argument of **""**. If *string* is empty, an empty list is returned. If *size* *<= 0*, an error will be thrown.

**::textutil::split::splitx** *string* ?*regexp*?
: Returns a list of strings containing consecutive substrings of *string* split according to the *regexp* regular expression which defaults to *\[\\t \\r\\n\]+* (tabs, spaces, newlines). *Note*: If *regexp* contains capturing parentheses, then the captured groups will be included in the result list as additional elements. If *string* is empty, an empty list is returned. If *regexp* is empty, the *string* is split at every character; this is the same as calling the built-in [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) command with a second argument of **""**.

**::textutil::string::chop** *string*
: Returns a copy of *string* with the last character removed.

**::textutil::string::tail** *string*
: Returns a copy of *string* with the first character removed.

**::textutil::string::cap** *string*
: Returns a copy of *string* with the first character capitalized.

**::textutil::string::capEachWord** *string*
: Returns a copy of *string* with the first character of every word capitalized.

**::textutil::string::uncap** *string*
: Returns a copy of *string* with the first character lowercased.

**::textutil::string::longestCommonPrefixList** *list*
: Returns the longest common prefix of the strings in the given *list*. If no argument is given, the empty string is returned.

**::textutil::string::longestCommonPrefix** ?*string*...?
: Returns the longest common prefix of the string arguments, *string*, …. If a single string is given, it is returned since it is its own longest common prefix. If no argument is given, the empty string is returned.

**::textutil::tabify::tabify** *string* ?*count*?
: Returns a copy of *string* with any substring of *count* space characters replaced by a horizontal tab. The *count* defaults to 8.

**::textutil::tabify::tabify2** *string* ?*count*?
: Returns a copy of *string* with substrings of *count* *or fewer* space characters replaced by a horizontal tab using a text editor like algorithm. The *count* defaults to 8. The algorithm used by this command treats each line in *string* as if it had notional tabstops every *count* columns. (So, if *count* is **8**, at columns **8**, **16**, **24**, ….) Only sequences of *two or more* space characters that occur immediately before a notional tabstop are replaced with a tab.

**::textutil::tabify::untabify** *string* ?*count*?
: Returns a copy of *string* with every horizontal tab replaced by *count* spaces. The *count* defaults to 8.

**::textutil::tabify::untabify2** *string* ?*count*?
: Returns a copy of *string* with horizontal tabs replaced by *count* *or fewer* space characters using a text editor like algorithm. The *count* defaults to 8. This command is the counterpart to **::textutil::tabify::tabify2**. The algorithm used by this command treats each line in *string* as if it had notional tabstops every *count* columns. (So, if *count* is **8**, at columns **8**, **16**, **24**, ….) Instead of blindly replacing each horizontal tab with *count* spaces, each horizontal tab at a notional tabstop is replaced by enough spaces to reach the next notional tabstop. There is one asymmetry though: A tab may be replaced by a single space, but not the other way around.

**::textutil::trim::trim** *string* ?*regexp*?
: Returns a copy of *string* with any leading or trailing substring that matches *regexp* removed from the *string* if does not contain newlines, or from *every line* within the *string* if it contains newlines. The *regexp* defaults to *\[ \\t\]+*. This default will remove leading and trailing spaces and tabs from the *string* if it does not contain newlines, or from *every line* within the *string* if it contains newlines.

**::textutil::trim::trimleft** *string* ?*regexp*?
: Returns a copy of *string* with any leading substring that matches *regexp* removed from the *string* if does not contain newlines, or from *every line* within the *string* if it contains newlines. The *regexp* defaults to *\[ \\t\]+*. This default will remove leading spaces and tabs from the *string* if it does not contain newlines, or from *every line* within the *string* if it contains newlines.

**::textutil::trim::trimright** *string* ?*regexp*?
: Returns a copy of *string* with any trailing substring that matches *regexp* removed from the *string* if does not contain newlines, or from *every line* within the *string* if it contains newlines. The *regexp* defaults to *\[ \\t\]+*. This default will remove trailing spaces and tabs from the *string* if it does not contain newlines, or from *every line* within the *string* if it contains newlines.

**::textutil::trim::trimPrefix** *string* *prefix*
: Returns a copy of *string* with *prefix* removed from the start if it is present; otherwise returns *string* unchanged. Contrast this command with the built-in [string](https://www.tcl-lang.org/man/tcl/TclCmd/string.html) command’s **trim**, **trimleft**, **trimright** subcommands which remove all characters in a given set of characters passed as a string.

**::textutil::trim::trimEmptyHeading** *string*
: Returns a copy of *string* with any leading blank lines (including lines containing only whitespace) removed.


# Examples

## Adjust

The following examples show some of the **::textutil::adjust** package’s commands in action.

The following **proc** and **const** are used by the examples below.

```
proc replace_spc {s {sub ▴}} { regsub -all { } $s $sub }
const LINES "Four\nsiamese cats\nheard barks\nand bolted."
```

The **replace_spc** command replaces every space in the string it is passed with the ▴ symbol. The **LINES** constant provides some text for the examples to work with.

## Justifying

The following example show every justification option in use. Spaces have been made visible by preserving them using **-full** **1** and replacing them with the ▴ symbol.

Normally, **-full** would *not* be used and there would be *no* trailing spaces in each line.

```
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify left]
puts "======= left =======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify center]
puts "====== center ======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify plain]
puts "======= plain ======\n[replace_spc $lines]"
set lines [textutil::adjust::adjust $LINES -length 20 -full 1 -justify right]
puts "======= right ======\n[replace_spc $lines]"
=>
======= left =======
Four▴siamese▴cats▴▴▴
heard▴barks▴and▴▴▴▴▴
bolted.▴▴▴▴▴▴▴▴▴▴▴▴▴

====== center ======
▴▴Four▴siamese▴cats▴
▴▴▴heard▴barks▴and▴▴
▴▴▴▴▴▴▴bolted.▴▴▴▴▴▴

======= plain ======
Four▴siamese▴▴▴▴cats
heard▴▴▴barks▴▴▴▴and
bolted.▴▴▴▴▴▴▴▴▴▴▴▴▴

======= right ======
▴▴▴Four▴siamese▴cats
▴▴▴▴▴heard▴barks▴and
▴▴▴▴▴▴▴▴▴▴▴▴▴bolted.
```

## Indenting and unindenting

In the following example leading spaces have been made visible by using an indent of **··** rather than, say, two spaces, and other spaces have been made visible by replacing them with the ▴ symbol. There are no trailing spaces since **textutil::adjust::indent** trims them.

```
set lines [textutil::adjust::adjust $LINES -length 20 -justify left]
puts "======== left =========\n[replace_spc $lines]"
set indented [textutil::adjust::indent $lines "··"]
puts "======== indent =======\n[replace_spc $indented]"
# undent only unindents spaces
set indented [regsub -all · $indented " "]
set unindented [textutil::adjust::undent $indented]
puts "======== undent =======\n[replace_spc $unindented]"
set hanging [textutil::adjust::indent $lines "··" 1]
puts "==== hanging indent ===\n[replace_spc $hanging]"
=>
======== left =========
Four▴siamese▴cats
heard▴barks▴and
bolted.
======== indent =======
··Four▴siamese▴cats
··heard▴barks▴and
··bolted.
======== undent =======
Four▴siamese▴cats
heard▴barks▴and
bolted.
==== hanging indent ===
Four▴siamese▴cats
··heard▴barks▴and
··bolted.
```

## Repeat

This tiny example shows the **::textutil::repeat** package’s commands in action.

```
puts [::textutil::repeat::strRepeat = 22]
puts =[::textutil::repeat::blank 20]=
=>
======================
=                    =
```

## Split

The following examples show some of the **::textutil::split** package’s commands in action.

To help make the examples’ effects more visible, each element of the returned lists is bracketed using ❬ and ❭. For non-UTF-8 aware editors these can be replaced with **\\u276C** and **\\u276D**.

This first example shows how to split strings by size.

```
const LINE1 "α and ℤ"
set chars [::textutil::split::splitn $LINE1] ;# splits into characters
puts ❬[join $chars "❭ ❬"]❭
set chars [split $LINE1 ""] ;# splits into characters
puts ❬[join $chars "❭ ❬"]❭
set chunks [::textutil::split::splitn $LINE1 3]
puts ❬[join $chunks "❭ ❬"]❭
=>
❬α❭ ❬ ❭ ❬a❭ ❬n❭ ❬d❭ ❬ ❭ ❬ℤ❭
❬α❭ ❬ ❭ ❬a❭ ❬n❭ ❬d❭ ❬ ❭ ❬ℤ❭
❬α a❭ ❬nd ❭ ❬ℤ❭
```

This second example shows how to split strings by regexp.

```
const LINE2 "a, be , cat, done , eagle"
set chunks [::textutil::split::splitx $LINE2] ;# splits on [\t \r\n]+
puts ❬[join $chunks "❭ ❬"]❭
set chunks [::textutil::split::splitx $LINE2 {\s*,\s*}]
puts ❬[join $chunks "❭ ❬"]❭
set chunks [::textutil::split::splitx $LINE2 {\s*(,)\s*}]
puts ❬[join $chunks "❭ ❬"]❭
=>
❬a,❭ ❬be❭ ❬,❭ ❬cat,❭ ❬done❭ ❬,❭ ❬eagle❭
❬a❭ ❬be❭ ❬cat❭ ❬done❭ ❬eagle❭
❬a❭ ❬,❭ ❬be❭ ❬,❭ ❬cat❭ ❬,❭ ❬done❭ ❬,❭ ❬eagle❭
```

## String

The following examples show some of the **::textutil::string** package’s commands in action.

This first example shows all the commands that work on a single string.

```
const LINE "has the σαβ cogs"
puts "“$LINE” const"
set line [::textutil::string::chop $LINE]
puts "“$line” chop"
set line [::textutil::string::tail $line]
puts "“$line” tail"
set line [::textutil::string::cap $line]
puts "“$line” cap"
set line [::textutil::string::capEachWord $line]
puts "“$line” capEachWord"
set line [::textutil::string::uncap $line]
puts "“$line” uncap"
=>
“has the σαβ cogs” const
“has the σαβ cog” chop
“as the σαβ cog” tail
“As the σαβ cog” cap
“As The Σαβ Cog” capEachWord
“as The Σαβ Cog” uncap
```

This example shows the longest common prefix commands in use.

```
const LIST [list handbag handcuff handful handle handy]
puts “[::textutil::string::longestCommonPrefixList $LIST]”
puts “[::textutil::string::longestCommonPrefix king queen knave]”
puts “[::textutil::string::longestCommonPrefix king kin kind kinks]”
=>
“hand”
“”
“kin”
```

This example shows how to use the **::textutil::string::longestCommonPrefixList** command to find the common path from a list of paths.

```
proc longestCommonPath paths {
    const SEP [file separator]
    set path [::textutil::string::longestCommonPrefixList $paths]
    if {[string index $path end] ne $SEP} {
        if {[set j [string last $SEP $path]] > -1} {
            set path [string range $path 0 $j-1]
        }
    }
    if {$path ne $SEP} { set path [string trimright $path $SEP] }
    return $path
}

const PATHS [list /home/sally/music /home/sally/museums /home/sally/musings]
puts [::textutil::string::longestCommonPrefixList $PATHS]
puts [longestCommonPath $PATHS]
puts [longestCommonPath [list /bin / /sbin]]
=>
/home/sally/mus
/home/sally
/
```

## Tabify

The following examples show some of the **::textutil::tabify** package’s commands in action.

The examples make use of a tiny helper command to make spaces and tabs distinct and visible:

```
proc replace_tab_spc s { regsub -all { } [regsub -all \t $s →] ▴ }
```

This example shows the **::textutil::tabify::tabify** command in action.

```
const LINES1 "    if \{\$x\} \{\n        puts 1\n    \}"
puts "=== original ===\n[replace_tab_spc $LINES1]\n"
set tabbed [::textutil::tabify::tabify $LINES1]
puts "=== 8spc→tab ===\n[replace_tab_spc $tabbed]\n"
set tabbed [::textutil::tabify::tabify $LINES1 4]
puts "=== 4spc→tab ===\n[replace_tab_spc $tabbed]\n"
=>
=== original ===
▴▴▴▴if▴{$x}▴{
▴▴▴▴▴▴▴▴puts▴1
▴▴▴▴}

=== 8spc→tab ===
▴▴▴▴if▴{$x}▴{
→puts▴1
▴▴▴▴}

=== 4spc→tab ===
→if▴{$x}▴{
→→puts▴1
→}
```

## Trim

The following examples show some of the **::textutil::trim** package’s commands in action.

The following **proc** is used by some of the examples below.

```
proc replace_ws s { regsub -all { } [regsub -all \t [regsub -all \n $s ⏎] →] ▴ }
```

This example shows the use of **::textutil::trim::trimEmptyHeading** and **::textutil::trim::trim**.

```
const LINES1 "\t\n Alpha\t\n Beta \t\n Gamma \t\n"
puts "== const =============================\n[replace_ws $LINES1]"
set line [::textutil::trim::trimEmptyHeading $LINES1]
puts "== textutil::trim::trimEmptyHeading ==\n[replace_ws $line]"
set line [string trimleft $LINES1]
puts "== string trimleft ===================\n[replace_ws $line]"
set line [::textutil::trim::trim $LINES1]
puts "== textutil::trim::trim ==============\n[replace_ws $line]"
=>
== const =============================
→⏎▴Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== textutil::trim::trimEmptyHeading ==
▴Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== string trimleft ===================
Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== textutil::trim::trim ==============
⏎Alpha⏎Beta⏎Gamma⏎
```

Notice the subtle difference in behavior between **::textutil::trim::trimEmptyHeading** and **string trimleft**.

This example shows the use of the built-in **string trim** in combination with and **::textutil::trim::trim**.

```
const LINES2 [string trim "\t\n Delta\t\n Epsilon \t\n Zeta \t\n"]
puts "== const =============================\n[replace_ws $LINES2]"
set line [::textutil::trim::trim $LINES2]
puts "== textutil::trim::trim ==============\n[replace_ws $line]"
=>
== const =============================
Delta→⏎▴Epsilon▴→⏎▴Zeta
== textutil::trim::trim ==============
Delta⏎Epsilon⏎Zeta
```

This example contrasts the built-in **string trim** with **::textutil::trim::trimPrefix**.

```
const PATH /home/homer
puts "const='$PATH'"
puts "string trim \$PATH /home='[string trim $PATH /home]'"
puts "string trim \$PATH /home='[string trim $PATH ehmo/]'"
puts "::textutil::trim::trimPrefix \$PATH /home='[::textutil::trim::trimPrefix $PATH /home]'"
const LINE mimic
puts "string trim \$LINE mic='[string trim $LINE mic]'"
puts "::textutil::trim::trimPrefix \$LINE mic='[::textutil::trim::trimPrefix $LINE mic]'"
=>
const='/home/homer'
string trim $PATH /home='r'
string trim $PATH /home='r'
::textutil::trim::trimPrefix $PATH /home='/homer'
string trim $LINE mic=''
::textutil::trim::trimPrefix $LINE mic='mimic'
```

For the **PATH** examples, the **string trim** command trims all the individual characters that are in the string "/home", i.e., "/", "h", "o", "m", "e". The order of the characters in the string don’t matter as the "ehmo/" example shows. Compare this with **::textutil::trim::trimPrefix** which trims the literal string "/home".

For the **LINE** examples, the **string trim** command trims all the individual characters that are in the string "mic", i.e., "m", "i", "c". Compare this with **::textutil::trim::trimPrefix** which trims the literal string "mic"; but since the **LINE** doesn’t start with "mic", nothing is trimmed and the string is returned unchanged.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
