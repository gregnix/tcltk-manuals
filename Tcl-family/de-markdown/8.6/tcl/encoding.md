---
CommandName: encoding
title: encoding
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - Tcl_GetEncoding(3)
 - fconfigure(n)
Keywords:
 - encoding
 - unicode
Copyright:
 - Copyright (c) 1998 Scriptics Corporation.
---

# Name

encoding - Verwaltet Kodierungen

# Übersicht

::: {.synopsis} :::
[encoding]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Einleitung

Zeichenketten in Tcl sind logisch eine Folge von 16-Bit-Unicode-Zeichen. Im Speicher werden sie als Bytefolge in einer von mehreren Kodierungen dargestellt: modifiziertes UTF-8 (1 bis 3 Bytes pro Zeichen), 16-Bit-„Unicode“ (2 Bytes pro Zeichen, Endianness abhängig von der Host-Architektur) und binär (ein Byte pro Zeichen, aber nur eingeschränkter Zeichenbereich). Tcl garantiert nicht, dieselbe Kodierung für dieselbe Zeichenkette zu verwenden.

Betriebssystem-Schnittstellen oder Anwendungen können Zeichenketten in anderen Kodierungen wie Shift-JIS erzeugen. Der Befehl **encoding** überbrückt die Lücke zwischen Unicode und diesen anderen Formaten.

# Beschreibung

Führt je nach *option* eine von mehreren kodierungsbezogenen Operationen aus. Zulässige *option*en sind:

[encoding]{.cmd} [convertfrom]{.sub} [encoding]{.optarg} [data]{.arg}
: Wandelt *data* von der angegebenen *encoding* nach Unicode um. Die Zeichen in *data* werden als Binärdaten behandelt, wobei die unteren 8 Bits jedes Zeichens als ein Byte gelten. Die resultierende Bytefolge wird als Zeichenkette in der angegebenen *encoding* interpretiert. Fehlt *encoding*, wird die aktuelle Systemkodierung verwendet.

[encoding]{.cmd} [convertto]{.sub} [encoding]{.optarg} [string]{.arg}
: Wandelt *string* von Unicode in die angegebene *encoding* um. Das Ergebnis ist eine Bytefolge der konvertierten Zeichenkette. Jedes Byte wird in den unteren 8 Bits eines Unicode-Zeichens gespeichert (für Tcl zunächst eine Binärzeichenkette). Fehlt *encoding*, wird die aktuelle Systemkodierung verwendet.

[encoding]{.cmd} [dirs]{.sub} [directoryList]{.optarg}
: Tcl kann Kodierungsdatendateien vom Dateisystem laden, die zusätzliche Kodierungen beschreiben. Dieser Befehl setzt den Suchpfad für **\*.enc**-Kodierungsdatendateien auf die Verzeichnisliste *directoryList*. Fehlt *directoryList*, gibt der Befehl die aktuelle Suchpfadliste zurück. *directoryList* muss eine gültige Liste sein, sonst Fehler. Beim Suchen einer Kodierungsdatendatei werden Einträge in *directoryList*, die nicht auf ein lesbares, durchsuchbares Verzeichnis verweisen, ignoriert.

[encoding]{.cmd} [names]{.sub}
: Gibt eine Liste mit den Namen aller derzeit verfügbaren Kodierungen zurück. Die Kodierungen „utf-8“ und „iso8859-1“ sind in der Liste garantiert enthalten.

[encoding]{.cmd} [system]{.sub} [encoding]{.optarg}
: Setzt die Systemkodierung auf *encoding*. Fehlt *encoding*, gibt der Befehl die aktuelle Systemkodierung zurück. Die Systemkodierung wird verwendet, wenn Tcl Zeichenketten an Systemaufrufe übergibt.


# Beispiele

Das folgende Beispiel wandelt eine Bytefolge in japanischer euc-jp-Kodierung in eine Tcl-Zeichenkette um:

```
set s [encoding convertfrom euc-jp "\xA4\xCF"]
```

Das Ergebnis ist der Unicode-Codepunkt: „\u306F“, der Hiragana-Buchstabe HA.
