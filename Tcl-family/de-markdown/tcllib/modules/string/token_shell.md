---
CommandName: string::token::shell
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Text and string utilities
Keywords:
 - bash
 - lexing
 - parsing
 - shell
 - string
 - tokenization
Copyright:
---

# NAME

string::token::shell – Analyse der Shell-Befehlszeile

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [string::token::shell]{.lit} [1.3]{.optlit} 
[package]{.cmd} [require]{.sub} [string::token]{.lit} [1]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[::string]{.cmd} [token]{.sub} [shell]{.lit} [-indices]{.optlit} [-partial]{.optlit} [--]{.optarg} [string]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Befehl, der eine Textzeile mithilfe von grundlegenden **sh**-syntax in eine Liste von Wörtern zerlegt.

# API

**::string token shell** ?**-indices**? ?**-partial**? ?--? *string*
: Standardmäßig gibt der Befehl eine Liste von Wörtern aus der Eingabe *string* zurück. Die Wörter werden gemäß der grundlegenden [sh(1p)](https://man7.org/linux/man-pages/man1/sh.1p.html)-Syntax aus *string* aufgeteilt. Es wird ein Fehler ausgelöst, wenn die Eingabe nicht der erwarteten Syntax entspricht. Das Verhalten des Befehls kann durch Angabe einer der beiden Optionen **-indices** und **-partial** geändert werden.


**--**
: Wenn diese Option festgelegt ist, wird die Auswertung an dieser Stelle beendet. Diese Option ist erforderlich, wenn die Eingabe *string* mit einem Bindestrich beginnen kann. Mit anderen Worten: Dies ist so gut wie zwingend erforderlich, wenn *string* eine Benutzereingabe ist.

**-indices**
: Wenn dieser Befehl festgelegt wird, gibt er eine Liste von Listen mit jeweils 4 Elementen zurück. Jede dieser Listen enthält den Typ des Wortes, dessen Start- und Endindex im *string* sowie das Wort selbst (aus dem *string* kopiert). Bei jeder beliebigen Liste mit vier Elementen stimmt die Länge des Wortes, die anhand der Differenz zwischen den Indizes berechnet wird, möglicherweise nicht mit der Länge des Wortes im letzten Element überein. Dies liegt daran, dass die Indizes Trennzeichen, Anführungszeichen innerhalb des Wortes usw. enthalten, während diese im Wort im letzten Element entfernt wurden. Die möglichen Token-Typen sind


**PLAIN**
: Einfaches Wort, nicht in Anführungszeichen gesetzt.

**D:QUOTED**
: Das Wort wurde durch doppelte Anführungszeichen begrenzt.

**S:QUOTED**
: Das Wort wurde durch einfache Anführungszeichen begrenzt.

**D:QUOTED:PART**
: ...siehe nächstes...

**S:QUOTED:PART**
: Wie die vorherigen Typen, jedoch fehlt dem Wort das schließende Anführungszeichen, d. h., es ist unvollständig. Diese Token-Typen können nur auftreten, wenn die Option **-partial** festgelegt wurde, und auch dann nur für das letzte Wort des Ergebnisses. Wenn die Option **-partial** *nicht* angegeben ist, führt ein unvollständiges letztes Wort stattdessen dazu, dass der Befehl einen Fehler ausgibt.


**-partial**
: Wenn diese Option festgelegt ist, akzeptiert der Parser ein unvollständiges Wort in Anführungszeichen (d. h. mit einem öffnenden Anführungszeichen, aber ohne passendes schließendes Anführungszeichen) am Ende der *Zeichenkette*, ohne einen Fehler auszugeben.


Die von diesem Befehl akzeptierte grundlegende Shell-Syntax besteht aus Wörtern ohne Anführungszeichen sowie Wörtern in einfachen und doppelten Anführungszeichen, die durch Leerzeichen voneinander getrennt sind. Leerzeichen am Anfang und am Ende sind ebenfalls zulässig und werden, sofern vorhanden, entfernt.

Shell-Variablen in ihren verschiedenen Formen werden *nicht* erkannt, ebenso wenig wie Sub-Shells.

Hier sind die anerkannten Wortformen:

**single-quoted word**
: Ein in einfache Anführungszeichen gesetztes Wort beginnt mit einem einfachen Anführungszeichen, d. h. **'** (ASCII 39; U+0027), gefolgt von null oder mehr Unicode-Zeichen (mit Ausnahme des einfachen Anführungszeichens) und endet mit einem einfachen Anführungszeichen. Auf das Wort muss entweder das Ende der *Zeichenkette* oder ein Leerzeichen folgen. Ein Wort darf nicht direkt auf ein anderes Wort folgen, ohne dass etwas dazwischen steht.

**double-quoted word**
: Ein in doppelte Anführungszeichen gesetztes Wort beginnt mit einem doppelten Anführungszeichen, d. h. **"** (ASCII 34; U+0022), gefolgt von null oder mehr Unicode-Zeichen (mit Ausnahme des doppelten Anführungszeichens) und endet mit einem doppelten Anführungszeichen. Anders als bei Wörtern in einfachen Anführungszeichen können doppelte Anführungszeichen in Wörtern in doppelten Anführungszeichen eingebettet werden, indem sie mit einem Backslash **\\** (ASCII 92; U+005C) maskiert werden, z. B. **"…\\"…"**. Ebenso kann jeder literale Backslash durch eine Backslash-Escape-Sequenz eingebettet werden, z. B. **"…\\\\…"**.

**unquoted word**
: Nicht in Anführungszeichen gesetzte Wörter werden nicht durch Anführungszeichen begrenzt und dürfen daher keine Leerzeichen oder einfache Anführungszeichen enthalten. Doppelte Anführungszeichen und Backslashes können jedoch in nicht in Anführungszeichen gesetzte Wörter eingefügt werden, indem sie wie bei Wörtern in doppelten Anführungszeichen mit einem Escape-Zeichen versehen werden.

**whitespace**
: Ein Leerzeichen ist jedes Unicode-Leerzeichen, d. h. jedes Zeichen, das [string is space](https://www.tcl-lang.org/man/tcl/TclCmd/string.html)] den Wert **1** (wahr) gibt oder das dem regulären Ausdruck **\\\\s** entspricht. Leerzeichen *können* vor dem ersten Wort und nach dem letzten Wort vorkommen. Leerzeichen *müssen* zwischen benachbarten Wörtern vorkommen.


# BEISPIELE

Ein Beispiel für eine Befehlszeile, die in ihre einzelnen Wörter zerlegt wurde.

```
const CMDLINE "grep --include=*.{tcl,tm,tk} -rl * | grep -v \"The Cloud\""
puts "CMDLINE=«$CMDLINE»"
foreach word [string token shell $CMDLINE] {
    puts "word=«$word»"
}
=>
CMDLINE=«grep --include=*.{tcl,tm,tk} -rl * | grep -v "The Cloud"»
word=«grep»
word=«--include=*.{tcl,tm,tk}»
word=«-rl»
word=«*»
word=«|»
word=«grep»
word=«-v»
word=«The Cloud»
```

Ein Beispiel für dieselbe Befehlszeile wie oben, zerlegt in ihre einzelnen Wörter, mit Tokens und Zeichenfolgen-Indizes.

```
foreach element [string token shell -indices $CMDLINE] {
    lassign $element token i j word
    puts "token=$token i=$i j=$j word=«$word»"
}
=>
token=PLAIN i=0 j=3 word=«grep»
token=PLAIN i=5 j=27 word=«--include=*.{tcl,tm,tk}»
token=PLAIN i=29 j=31 word=«-rl»
token=PLAIN i=33 j=33 word=«*»
token=PLAIN i=35 j=35 word=«|»
token=PLAIN i=37 j=40 word=«grep»
token=PLAIN i=42 j=43 word=«-v»
token=D:QUOTED i=45 j=55 word=«The Cloud»
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
