---
CommandName: dicttool
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Extensions to the standard
Keywords:
 - dict
Copyright:
 - Copyright (c) 2017 Sean Woods <yoda@etoyoc.com>
---

# NAME

dicttool – Dictionary-Tools

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [dicttool]{.lit} [1.2]{.optlit} 
[ladd]{.cmd} [dictVar]{.arg} [key value]{.optdot} 
[ldelete]{.cmd} [dictVar]{.arg} [key value]{.optdot} 
[dict]{.cmd} [getnull]{.sub} [key]{.arg} 
[dict]{.cmd} [print]{.sub} [aDict]{.arg} 
[dict]{.cmd} [is_dict]{.sub} [value]{.arg} 
[dict]{.cmd} [rmerge]{.sub} [dict1]{.arg} [dict2]{.arg} [dict3]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket erweitert den integrierten Befehl [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html) um mehrere neue Befehle. Darüber hinaus definiert das Paket auch einige praktische Listenbefehle. (Jeder Befehl wird nur dann hinzugefügt, wenn noch kein gleichnamiger Befehl vorhanden ist – für den Fall, dass einer dieser Befehle in den Kern aufgenommen wird.)

# API

**ladd** *dictVar* ?*key value ...*?
: Dieser Befehl fügt jedes Paar von *Schlüssel-Wert*-Elementen zu *dictVar* hinzu, jedoch nur, wenn dieses Element noch nicht vorhanden ist (weder als Schlüssel noch als Wert). Dieser Befehl *muss* mit Paaren von *Schlüssel-Wert*-Elementen aufgerufen werden, damit *dictVar* als **dict** erhalten bleibt.

**ldelete** *dictVar* ?*key value ...*?
: Dieser Befehl löscht jedes Paar von *Schlüssel-Wert*-Elementen aus *dictVar*. Er führt keine Aktion durch, wenn das Paar nicht bereits in *dictVar* vorhanden ist. Dieser Befehl *muss* mit Paaren von *Schlüssel-Wert*-Elementen aufgerufen werden, um *dictVar* als **dict** zu erhalten. Verwenden Sie den Unterbefehl **dict remove** des integrierten Befehls [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html)], um Elemente allein anhand des Schlüssels zu entfernen.

**dict getnull** *key*
: Funktioniert wie **dict get**; wenn der Schlüssel *key* jedoch nicht vorhanden ist, gibt es eine leere Liste zurück, anstatt einen Fehler auszulösen. Eine Alternative zu diesem Befehl ist der integrierte Unterbefehl **dict getwithdefault** des Befehls [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html)] *oder dessen Alias* **dict getdef**. Die Verwendung von **dict getdef** mit einer leeren Liste *{}* als Standardwert entspricht der Verwendung von **dict getnull**.

**dict print** *aDict*
: Gibt eine „übersichtlich formatierte“ Zeichenfolgendarstellung von **dict** *aDict* zurück, wobei jeder verschachtelte Zweig in einer neuen Zeile steht und auf jeder Ebene um zwei Leerzeichen eingerückt ist.

**dict is_dict** *value*
: Gibt **1** (true) zurück, wenn *value* als **dict** interpretiert werden kann; andernfalls **0** (false). Dieser Befehl erzwingt *nicht*, dass eine vorhandene **dict**-Darstellung in eine andere interne Darstellung umgewandelt wird.

**dict rmerge** *dict1* *dict2* ?*dict3 ...*?
: Gibt ein **dict** zurück, das aus der rekursiven Verschmelzung aller **dict**-Argumente entsteht. Anders als der Unterbefehl **dict merge** des eingebauten Befehls [dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html) steigt dieser Befehl in alle Ebenen des **dict** hinab. Beachten Sie, dass **dict**-Schlüssel, die auf einen Doppelpunkt enden, ein Blatt bezeichnen. Sie gelten als literaler Wert und werden nicht weiter hinab verfolgt.


```
set items [dict rmerge {
  option {color {default: green}}
} {
  option {fruit {default: mango}}
} {
  option {color {default: blue} fruit {widget: select values: {mango apple cherry grape}}}
}]
puts [dict print $items]
=>
option {
  color {
    default: blue
  }
  fruit {
    default: mango
    widget: select
    values: {mango apple cherry grape}
  }
}
```

Wenn oben der Unterbefehl „**dict merge**“ des integrierten Befehls „dict](https://www.tcl-lang.org/man/tcl/TclCmd/dict.html)“ verwendet worden wäre, wäre der Schlüssel-Wert-Eintrag „*default*“ des Eintrags „*fruit*“ verloren gegangen.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *dict* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hilfsprogramme

# COPYRIGHT

```
Copyright (c) 2017 Sean Woods <yoda@etoyoc.com>
```
