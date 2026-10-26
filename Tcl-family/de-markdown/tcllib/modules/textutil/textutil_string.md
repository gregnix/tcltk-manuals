---
CommandName: textutil::string
ManualSection: n
Version: 0.9
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - capitalize
 - chop
 - common prefix
 - formatting
 - prefix
 - string
 - uncapitalize
Copyright:
---

# NAME

textutil::string – Prozeduren zur Bearbeitung von Texten und Zeichenfolgen.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::string]{.lit} [0.9]{.optlit} 
[::textutil::string::chop]{.cmd} [string]{.arg} 
[::textutil::string::tail]{.cmd} [string]{.arg} 
[::textutil::string::cap]{.cmd} [string]{.arg} 
[::textutil::string::capEachWord]{.cmd} [string]{.arg} 
[::textutil::string::uncap]{.cmd} [string]{.arg} 
[::textutil::string::longestCommonPrefixList]{.cmd} [list]{.arg} 
[::textutil::string::longestCommonPrefix]{.cmd} [string]{.optdot} 
:::

# BESCHREIBUNG

Das Paket **textutil::string** bietet verschiedene Befehle zur Zeichenfolgenbearbeitung.

Wie Sie aus einer Liste von Pfaden einen gemeinsamen Pfad ermittelt, erfahren Sie im letzten der **BEISPIELE**.

# API

**::textutil::string::chop** *string*
: Gibt eine Kopie von *string* zurück, bei der das letzte Zeichen entfernt wurde.

**::textutil::string::tail** *string*
: Gibt eine Kopie von *string* zurück, bei der das erste Zeichen entfernt wurde.

**::textutil::string::cap** *string*
: Gibt eine Kopie von *string* zurück, bei der das erste Zeichen großgeschrieben ist.

**::textutil::string::capEachWord** *string*
: Gibt eine Kopie von *string* zurück, bei der das erste Zeichen jedes Wortes großgeschrieben ist.

**::textutil::string::uncap** *string*
: Gibt eine Kopie von *string* zurück, wobei das erste Zeichen in Kleinbuchstaben umgewandelt wird.

**::textutil::string::longestCommonPrefixList** *list*
: Gibt das längste gemeinsame Präfix der Zeichenketten in der angegebenen *Liste* zurück. Wird kein Argument angegeben, gibt es die leere Zeichenkette zurück.

**::textutil::string::longestCommonPrefix** ?*string*...?
: Gibt das längste gemeinsame Präfix der Zeichenfolgenargumente *string*, … zurück. Wird eine einzelne Zeichenfolge angegeben, wird diese zurückgegeben, da sie ihr eigenes längstes gemeinsames Präfix ist. Wird kein Argument angegeben, wird die leere Zeichenfolge zurückgegeben.


# BEISPIELE

Die folgenden Beispiele veranschaulichen einige Befehle des Pakets **::textutil::string** in der Praxis.

Dieses erste Beispiel zeigt alle Befehle, die auf eine einzelne Zeichenkette angewendet werden können.

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

Dieses Beispiel zeigt die Befehle für das längste gemeinsame Präfix, die derzeit verwendet werden.

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

Dieses Beispiel zeigt, wie Sie mit dem Befehl **::textutil::string::longestCommonPrefixList** den gemeinsamen Pfad aus einer Liste von Pfaden ermittelt.

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

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
