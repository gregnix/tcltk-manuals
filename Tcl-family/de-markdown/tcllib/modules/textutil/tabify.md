---
CommandName: textutil::tabify
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - formatting
 - string
 - tabstops
Copyright:
---

# NAME

textutil::tabify – Prozeduren zum (Ent-)Tabulieren von Zeichenketten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::tabify]{.lit} [0.8]{.optlit} 
[::textutil::tabify::tabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::tabify2]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify2]{.cmd} [string]{.arg} [count]{.optarg} 
:::

# BESCHREIBUNG

Das Paket **textutil::tabify** enthält Befehle zum Ersetzen von Tabulatoren durch Leerzeichen oder von Leerzeichen durch Tabulatoren in Zeichenketten.

# API

**::textutil::tabify::tabify** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, wobei jede Teilzeichenfolge aus *count* Leerzeichen durch ein horizontales Tabulatorzeichen ersetzt wird. Der Standardwert für *count* ist 8.

**::textutil::tabify::tabify2** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, in der Teilzeichenfolgen mit *count* *oder weniger* Leerzeichen durch einen horizontalen Tabulator ersetzt wurden, wobei ein Texteditor-ähnlicher Algorithmus verwendet wird. Der Standardwert für *count* ist 8. Der von diesem Befehl verwendete Algorithmus behandelt jede Zeile in *string* so, als hätte sie fiktive Tabulatorpositionen alle *count* Spalten. (Wenn also *count* **8** ist, dann bei Spalten **8**, **16**, **24**, …) Nur Folgen von *zwei oder mehr* Leerzeichen, die unmittelbar vor einem fiktiven Tabulator-Stopp auftreten, werden durch einen Tabulator ersetzt.

**::textutil::tabify::untabify** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, in der jeder horizontale Tabulator durch *count* Leerzeichen ersetzt wurde. Der Standardwert für *count* ist 8.

**::textutil::tabify::untabify2** *string* ?*count*?
: Gibt eine Kopie von *string* zurück, wobei horizontale Tabulatoren durch *count* *oder weniger* Leerzeichen ersetzt werden – nach einem Prinzip, das dem eines Texteditors ähnelt. Der Standardwert für *count* ist 8. Dieser Befehl ist das Gegenstück zu **::textutil::tabify::tabify2**. Der von diesem Befehl verwendete Algorithmus behandelt jede Zeile in *string* so, als hätte sie fiktive Tabulatorpositionen alle *count* Spalten. (Wenn also *count* **8** ist, werden an den Spalten **8**, **16**, **24**, …) wird anstelle einer blinden Ersetzung jedes horizontalen Tabulatorzeichens durch *count* Leerzeichen jedes horizontale Tabulatorzeichen an einer fiktiven Tabulatorposition durch so viele Leerzeichen ersetzt, dass die nächste fiktive Tabulatorposition erreicht wird. Es gibt jedoch eine Asymmetrie: Ein Tabulatorzeichen kann durch ein einzelnes Leerzeichen ersetzt werden, aber nicht umgekehrt.


# BEISPIELE

Die folgenden Beispiele veranschaulichen einige Befehle des Pakets **::textutil::tabify** in der Praxis.

In den Beispielen wird ein kleiner Hilfsbefehl verwendet, um Leerzeichen und Tabulatoren deutlich voneinander abzugrenzen und sichtbar zu machen:

```
proc replace_tab_spc s { regsub -all { } [regsub -all \t $s →] ▴ }
```

Dieses Beispiel veranschaulicht die Verwendung des Befehls **::textutil::tabify::tabify**.

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

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
