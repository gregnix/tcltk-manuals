---
CommandName: textutil::wcswidth
ManualSection: n
Version: 35.3
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - character type
 - character width
 - double-wide character
 - prefix
 - regular expression
 - string
Copyright:
---

# NAME

textutil::wcswidth – Prozeduren zur Berechnung der Endbreite von Zeichenketten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::wcswidth]{.lit} [35.3]{.optlit} 
[::textutil::wcswidth]{.cmd} [string]{.arg} 
[::textutil::wcswidth_char]{.cmd} [codepoint]{.arg} 
[::textutil::wcswidth_type]{.cmd} [codepoint]{.arg} 
:::

# BESCHREIBUNG

Das Paket **textutil::wcswidth** enthält Befehle, die Zeichentypen, Zeichenbreiten und Zeichenfolgenbreiten im Zusammenhang mit der Ausgabe auf dem Terminal (der Konsole) anzeigen.

Die Daten dieses Pakets und damit auch die zugrunde liegende Funktionalität basieren auf der Unicode-Datenbankdatei *http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt*.

# API

Die Befehle dieses Pakets berücksichtigen Zeichen doppelter Breite aus den verschiedenen asiatischen und anderen Skripten.

**::textutil::wcswidth** *string*
: Gibt die Anzahl der Zeichenzellen zurück, die für die Ausgabe der angegebenen *Zeichenkette* auf einem Terminal benötigt werden.

**::textutil::wcswidth_char** *codepoint*
: Gibt die Anzahl der Zeichenzellen zurück, die für das angegebene Unicode-Zeichen mit dem *Codepoint* bei der Ausgabe auf einem Terminal benötigt werden. *Wichtig*: Das Unicode-Zeichen mit dem *Codepoint* muss als Ganzzahl festgelegt werden.

**::textutil::wcswidth_type** *codepoint*
: Gibt den Zeichentyp des angegebenen Unicode-Zeichens mit dem *Codepunkt* zurück. Der Wert ist eine Zeichenkette, die eine der folgenden Konstanten enthält: **A**, **F**, **H**, **N**, **Na** oder **W**, wie in *http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt* festgelegt. *Wichtig*: Das Unicode-Zeichen *codepoint* muss als Ganzzahl festgelegt werden.


# BEISPIELE

Dieses Beispiel zeigt alle drei Befehle in der Praxis.

```
const LINE "Δ÷☕M☔ℤ"
puts "string length  = [string length $LINE]"
puts "terminal width = [textutil::wcswidth $LINE]"
foreach char [split $LINE ""] {
    set cp [scan $char %c]
    set pad [string repeat " " [expr {2 - [textutil::wcswidth_char $cp]}]]
    puts [format "%-2s%sU+%04X %s" $char $pad $cp [textutil::wcswidth_type $cp]]
}
=>
string length  = 6
terminal width = 8
Δ  U+0394 A
÷  U+00F7 A
☕ U+2615 W
M  U+004D N
☔ U+2614 W
ℤ  U+2124 N
```

Auf einem Terminal, das eine Monospace-Schriftart verwendet, ist die oben gezeigte Ausgabe *perfekt* ausgerichtet; jegliches „Wackeln“, das auf dieser Seite zu sehen ist, ist ein Artefakt.

Hinweis: Die Ausgabe wäre *nicht* ausgerichtet, wenn **pad** auf **" "** gesetzt wäre, d. h. wenn die Zeichenbreiten nicht berücksichtigt würden, z. B.:

```
string length  = 6
terminal width = 8
Δ  U+0394 A
÷  U+00F7 A
☕  U+2615 W
M  U+004D N
☔  U+2614 W
ℤ  U+2124 N
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
