---
CommandName: string::token
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Text and string utilities
Keywords:
 - lexing
 - regex
 - string
 - tokenization
Copyright:
---

# Name

string::token - Regex based iterative lexing

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [string::token]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[::string]{.cmd} [token]{.sub} [text]{.lit} [lex]{.arg} [string]{.arg} 
[::string]{.cmd} [token]{.sub} [file]{.lit} [lex]{.arg} [path]{.arg} 
[::string]{.cmd} [token]{.sub} [chomp]{.lit} [lex]{.arg} [startVar]{.arg} [string]{.arg} [resultVar]{.arg} 
:::

# Description

This package provides commands for regular expression based lexing (tokenizing) of strings.

# Api

**::string token text** *lex* *string*
: This command takes a dictionary, *lex*, which must map regular expressions (“regexps”) to labels, and tokenizes the *string* according to the dictionary. The command tests each regexp in the *lex* dictionary in order. Since Tcl **dict**s are insertion-ordered, it is recommended that the regexps are specified from most specific to most general. The command returns a list of tokens. Each token is a 3-element list containing the label (from the *lex* **dict**), and the start and end indexes of the match in the *string*. The command will throw an error if it is not able to tokenize the entire string. For line-oriented lexers, finer-grained error handling and handling huge files can be achieved by lexing line-by-line.

**::string token file** *lex* *path*
: This command is a convenience wrapper around **::string token text** that makes it easy to tokenize entire files. *Note* that this command loads the whole file into memory before starting to process it.

**::string token chomp** *lex* *startVar* *string* *resultVar*
: This command is exposed to enable users to write their own lexers. For example, to apply different lexing dictionaries depending on internal state as the lex progresses. (The **::string token text** and **::string token file** commands make use of this command behind the scenes.) This command takes a dictionary, *lex*, which must map regexps to labels, a variable *startVar* which contains the index position where the lexing should begin in the input *string*, and a result variable *resultVar* to which each successfuly lexed token will be appended. The command returns a status code indicating the state of the lex These are


**0**
: No token found.

**1**
: Token found.

**2**
: End of string reached.


If a token was recognized (status **1**) the command will update the index in *startVar* to the character immediately *following* the lexed token. It will also append to the *resultVar* the lexed token which itself is a 3-element list containing the label (from the *lex* **dict**), and the start and end indexes of the match in the *string*.

If a token was not recognized (status **0** or **2**), neither *startVar* nor *resultVar* will be updated.

As noted earlier, the command tests each regexp in the *lex* dictionary in order. Since Tcl **dict**s are insertion-ordered, it is recommended that the regexps are specified from most specific to most general.

Further note that all regex patterns are implicitly prefixed with the constraint escape **\\A** to ensure that a match starts exactly at the character index found in *startVar*.

# Examples

This example shows how to use the **string token text** command to lex a simple line-oriented *.ini* file format. (For full-featured *.ini* file handling, see [inifile](https://core.tcl-lang.org/tcllib/doc/trunk/embedded/md/tcllib/files/modules/inifile/ini.md).)

```
const INI_EG "; example.ini
Filename = test.db

invalid
\[Database\]
# remote data
Port: 143
IP: 192.0.2.62

junk
"

proc main {} {
    set groups [lex_ini $::INI_EG]
    puts General:
    dict for {key value} [dict get $groups General] { puts "\t$key: $value" }
    puts Database:
    dict for {key value} [dict get $groups Database] { puts "\t$key: $value" }
}

proc lex_ini ini_text {
    const INI_LEX [dict create {[#;].*$} COMMENT {\[[^]]+\]} GROUP {\w+\s*[:=].+$} ENTRY]
    set group General
    set linenum 0
    foreach line [split $ini_text \n] {
        incr linenum
        if {[string trim $line] eq ""} { continue }
        try {
            set token [string token text $INI_LEX $line]
            if {[llength $token]} { set token [lindex $token 0] }
            lassign $token label i j
            switch $label {
                COMMENT { continue }
                GROUP {
                    set group [string range $line $i+1 $j-1]
                    dict set groups $group {}
                }
                ENTRY {
                    set entry [string range $line $i $j]
                    set k [lindex [regexp -inline -indices {[=:]} $entry] 0 0]
                    set key [string trim [string range $entry 0 $k-1]]
                    set value [string trim [string range $entry $k+1 end]]
                    dict set groups $group $key $value
                }
            }
        } on error err {
            puts "Error: line $linenum: $err"
        }
    }
    return $groups
}

main
=>
Error: line 4: Unexpected character 'i' at offset 0
Error: line 10: Unexpected character 'j' at offset 0
General:
	Filename: test.db
Database:
	Port: 143
	IP: 192.0.2.62
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
