---
CommandName: textutil::repeat
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - blanks
 - repetition
 - string
Copyright:
---

# NAME

textutil::repeat – Prozeduren zum Wiederholen von Zeichenfolgen.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::repeat]{.lit} [0.8]{.optlit} 
[::textutil::repeat::strRepeat]{.cmd} [text]{.arg} [count]{.arg} 
[::textutil::repeat::blank]{.cmd} [count]{.arg} 
:::

# BESCHREIBUNG

Das Paket **textutil::repeat** enthält Befehle zum Erzeugen von Zeichenfolgen, indem eine Zeichenfolge mehrfach wiederholt wird.

# API

**::textutil::repeat::strRepeat** *text* *count*
: Gibt eine Zeichenkette zurück, die den *text* *count*-mal wiederholt enthält. Die Wiederholungen werden ohne Trennzeichen miteinander verbunden. Ist der Wert von *count* *<= 0*, gibt der Befehl eine leere Zeichenkette zurück. Hinweis: Wenn der Tcl-Kern, in den dieses Paket geladen wird, den Befehl **string repeat** bereitstellt, wird dieser Befehl aus Gründen der maximalen Geschwindigkeit in dessen Begriffen implementiert. Andernfalls wird eine schnelle Tcl-Implementierung verwendet.

**::textutil::repeat::blank** *count*
: Gibt eine Zeichenkette zurück, die *count* Leerzeichen enthält. Dies dient als Erleichterung für den Aufruf von **::textutil::repeat::strRepeat** mit **" "** als erstem Argument.


# BEISPIELE

Dieses kurze Beispiel veranschaulicht die Befehle des Pakets **::textutil::repeat** in der Praxis.

```
puts [::textutil::repeat::strRepeat = 22]
puts =[::textutil::repeat::blank 20]=
=>
======================
=                    =
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
