---
CommandName: string::token
title: string::token
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

string::token – Iterative Lexem-Analyse auf Basis regulärer Ausdrücke

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [string::token]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[::string]{.cmd} [token]{.sub} [text]{.lit} [lex]{.arg} [string]{.arg}
[::string]{.cmd} [token]{.sub} [file]{.lit} [lex]{.arg} [path]{.arg}
[::string]{.cmd} [token]{.sub} [chomp]{.lit} [lex]{.arg} [startVar]{.arg} [string]{.arg} [resultVar]{.arg}
:::

# Beschreibung

Dieses Paket enthält Befehle für die auf regulären Ausdrücken basierende Lexem-Analyse (Tokenisierung) von Zeichenketten.

# API

**::string token text** *lex* *string*
: Dieser Befehl nimmt ein Dictionary *lex* entgegen, das reguläre Ausdrücke („regexps“) auf Bezeichnungen abbilden muss, und zerlegt die Zeichenkette *string* gemäß diesem Dictionary in Token.

    Der Befehl testet jeden regulären Ausdruck im *lex*-Dictionary der Reihe nach. Da Tcl-**dict**s in Einfügungsreihenfolge sortiert sind, wird empfohlen, die regulären Ausdrücke vom spezifischsten zum allgemeinsten zu legen.

    Der Befehl gibt eine Liste von Tokens zurück. Jedes Token ist eine Liste mit drei Elementen, die die Bezeichnung (aus dem *lex*-**dict**) sowie den Start- und Endindex der Übereinstimmung in der *string* enthält.

    Der Befehl löst einen Fehler aus, wenn er nicht in der Lage ist, die gesamte Zeichenkette zu tokenisieren.

    Bei zeilenorientierten Lexern lassen sich durch zeilenweises Lexing eine feinere Fehlerbehandlung und die Verarbeitung großer Dateien erreichen.

**::string token file** *lex* *path*
: Dieser Befehl ist eine praktische Hülle um **::string token text**, die das Tokenisieren ganzer Dateien vereinfacht.

    Hinweis: Dieser Befehl lädt die gesamte Datei in den Arbeitsspeicher, bevor er mit der Verarbeitung beginnt.

**::string token chomp** *lex* *startVar* *string* *resultVar*
: Dieser Befehl steht zur Verfügung, damit Benutzer eigene Lexer schreiben können. Beispielsweise, um je nach internem Zustand im Verlauf des Lexings unterschiedliche Lexing-Dictionaries anzuwenden.

    (Die Befehle **::string token text** und **::string token file** nutzen diesen Befehl im Hintergrund.)

    Dieser Befehl benötigt ein Dictionary *lex*, das reguläre Ausdrücke auf Bezeichnungen abbilden muss, eine Variable *startVar*, die die Indexposition enthält, an der die Lexem-Analyse in der Eingabe *string* beginnen soll, sowie eine Ergebnisvariable *resultVar*, an die jedes erfolgreich analysierte Lexem angehängt wird.

    Der Befehl gibt einen Statuscode zurück, der den Zustand des Lexers angibt. Diese sind

    **0**
    : Es wurde kein Token gefunden.

    **1**
    : Token gefunden.

    **2**
    : Das Ende der Zeichenkette ist erreicht.


    Wenn ein Token erkannt wurde (Status **1**), aktualisiert der Befehl den Index in *startVar* auf das Zeichen, das unmittelbar *auf* das lexikalisch analysierte Token folgt. Außerdem wird an *resultVar* das lexikalisch analysierte Token angehängt, das selbst eine Liste mit drei Elementen ist, die die Bezeichnung (aus dem *lex*-**dict**) sowie den Start- und End-Index der Übereinstimmung in der *Zeichenkette* enthält.

    Wenn ein Token nicht erkannt wurde (Status **0** oder **2**), werden weder *startVar* noch *resultVar* aktualisiert.

    Wie bereits erwähnt, testet der Befehl jeden regulären Ausdruck im *lex*-Dictionary der Reihe nach. Da Tcl-**dict**s in der Reihenfolge ihrer Einfügung sortiert sind, wird empfohlen, die regulären Ausdrücke vom spezifischsten zum allgemeinsten anzugeben.

    Beachten Sie außerdem, dass allen Regex-Mustern implizit das Constraint-Escape-Zeichen **\\A** vorangestellt wird, um sicherzustellen, dass eine Übereinstimmung genau an dem in *startVar* angegebenen Index beginnt.


# Beispiele

Dieses Beispiel zeigt, wie Sie mit dem Befehl **string token text** ein einfaches zeilenorientiertes *.ini*-Dateiformat lexikalisch analysiert. (Informationen zur umfassenden Bearbeitung von *.ini*-Dateien finden Sie unter [inifile](https://core.tcl-lang.org/tcllib/doc/trunk/embedded/md/tcllib/files/modules/inifile/ini.md).)

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

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung
