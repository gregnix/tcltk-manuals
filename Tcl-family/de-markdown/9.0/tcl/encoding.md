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

Zeichenketten in Tcl sind logisch eine Folge von Unicode-Zeichen. Im Speicher werden sie als Bytefolge in einer von mehreren Kodierungen dargestellt: modifiziertes UTF-8 (1 bis 4 Bytes pro Zeichen) oder eine benutzerdefinierte Kodierung, die als 8-Bit-Binärdaten beginnt.

Betriebssystem-Schnittstellen oder Anwendungen können Zeichenketten in anderen Kodierungen wie Shift-JIS erzeugen. Der Befehl **encoding** überbrückt die Lücke zwischen Unicode und diesen anderen Formaten.

# Beschreibung

Führt je nach *option* eine von mehreren kodierungsbezogenen Operationen aus. Zulässige *option*en sind:

[encoding]{.cmd} [convertfrom]{.sub} [encoding]{.optarg} [data]{.arg}
: siehe unten ...

[encoding]{.cmd version="TIP607, TIP656"} [convertfrom]{.sub} [[-profile]{.lit} [profile]{.arg}]{.optarg} [-failindex var]{.optlit} [encoding]{.arg} [data]{.arg}
: Wandelt *data*, das als Binärstring gemäß *encoding* kodiert sein sollte, in eine Tcl-Zeichenkette um. Fehlt *encoding*, wird die aktuelle Systemkodierung verwendet.


[Die Option **-profile** bestimmt das Verhalten des Befehls bei Konvertierungsfehlern. Details siehe Abschnitt [Profile] unten. Jeder vorzeitige Abbruch der Verarbeitung wegen Fehlern wird durch eine Exception gemeldet, sofern die Option **-failindex** nicht angegeben ist.]{version="TIP607, TIP656"}

Ist **-failindex** angegeben, wird bei vorzeitigem Abbruch statt einer Exception das Konvertierungsergebnis bis zum Fehlerpunkt als Befehlsergebnis zurückgegeben. Zusätzlich wird der Index des auslösenden Quellbytes in **var** gespeichert. Tritt kein Fehler auf, wird das vollständige Konvertierungsergebnis zurückgegeben und **-1** in **var** gespeichert.

[encoding]{.cmd} [convertto]{.sub} [encoding]{.optarg} [data]{.arg}
: siehe unten ...

[encoding]{.cmd} [convertto]{.sub} [[-profile]{.lit} [profile]{.arg}]{.optarg} [-failindex var]{.optlit} [encoding]{.arg} [data]{.arg}
: Wandelt *string* in die angegebene *encoding* um. Das Ergebnis ist ein Tcl-Binärstring mit der Bytefolge der konvertierten Zeichenkette in der angegebenen Kodierung. Fehlt *encoding*, wird die aktuelle Systemkodierung verwendet.


[Die Optionen **-profile** und **-failindex** wirken wie beim Befehl **encoding convertfrom** beschrieben.]{version="TIP607, TIP656"}

[encoding]{.cmd} [dirs]{.sub} [directoryList]{.optarg}
: Tcl kann Kodierungsdatendateien vom Dateisystem laden, die zusätzliche Kodierungen beschreiben. Dieser Befehl setzt den Suchpfad für **\*.enc**-Kodierungsdatendateien auf die Verzeichnisliste *directoryList*. Fehlt *directoryList*, gibt der Befehl die aktuelle Suchpfadliste zurück. *directoryList* muss eine gültige Liste sein, sonst Fehler. Beim Suchen einer Kodierungsdatendatei werden Einträge in *directoryList*, die nicht auf ein lesbares, durchsuchbares Verzeichnis verweisen, ignoriert.

[encoding]{.cmd} [names]{.sub}
: Gibt eine Liste mit den Namen aller derzeit verfügbaren Kodierungen zurück. Die Kodierungen „utf-8“ und „iso8859-1“ sind in der Liste garantiert enthalten.

[encoding]{.cmd} [profiles]{.sub}
: [Gibt eine Liste der Namen von Kodierungsprofilen zurück. Siehe [Profile] unten.]{version="TIP656"}

[encoding]{.cmd} [system]{.sub} [encoding]{.optarg}
: Setzt die Systemkodierung auf *encoding*. Fehlt *encoding*, gibt der Befehl die aktuelle Systemkodierung zurück. Die Systemkodierung wird verwendet, wenn Tcl Zeichenketten an Systemaufrufe übergibt.

[encoding]{.cmd} [user]{.sub}
: [Gibt den Namen der Kodierung gemäß den Benutzereinstellungen zurück. Unter Windows basiert dies auf den Codepage-Einstellungen des Benutzers in der Registry. Auf anderen Plattformen entspricht der Wert dem von **encoding system**.]{version="TIP716"}


# Profile

[Bei Kodierungstransformationen können verschiedene Fehler auftreten, etwa ungültige Sequenzen in den Quelldaten oder Zeichen, die in der Zielkodierung nicht darstellbar sind. Ein *profile* legt die Strategie zum Umgang mit solchen Fehlern fest — auf eine von zwei Arten:]{version="TIP656"}

- [Weitere Verarbeitung der Quelldaten beenden. Das Profil bestimmt nicht, wie dieser vorzeitige Abbruch dem Aufrufer mitgeteilt wird. Standardmäßig erfolgt dies durch eine Exception. Ist die Option **-failindex** angegeben, werden Fehler über diesen Mechanismus gemeldet.]{version="TIP656"}

- [Weitere Verarbeitung der Quelldaten mit einer Fallback-Strategie fortsetzen, z. B. Ersetzen oder Verwerfen der fehlerhaften Bytes profilabhängig.]{version="TIP656"}


Folgende Profile sind derzeit implementiert; Standard ist **strict**, wenn **-profile** nicht angegeben ist.

[**strict**]{version="TIP656"}
: [Das Profil **strict** stoppt die Verarbeitung stets bei einem Konvertierungsfehler. Der Fehler wird per Exception oder über **-failindex** gemeldet. **strict** entspricht dem Unicode-Standard.]{version="TIP656"}

[**tcl8**]{version="TIP656"}
: [Das Profil **tcl8** folgt stets der ersten Strategie oben und entspricht dem Verhalten von Kodierungstransformationen in Tcl 8.6. Beim Konvertieren von einer externen Kodierung **außer utf-8** in Tcl-Zeichenketten mit **encoding convertfrom** werden ungültige Bytes ihren numerisch äquivalenten Codepunkten zugeordnet. Das Byte 0x80, in ASCII ungültig, wird z. B. auf Codepunkt U+0080 abgebildet. Beim Konvertieren von **utf-8** werden ungültige Bytes, die in CP1252 definiert sind, ihren Unicode-Äquivalenten zugeordnet, andere fallen auf numerische Äquivalente zurück. Byte 0x80 ist in CP1252 definiert und wird daher U+20AC zugeordnet; Byte 0x81 ist in CP1252 nicht definiert und wird U+0081 zugeordnet. Als Sonderfall wird die Sequenz 0xC0 0x80 auf U+0000 abgebildet.]{version="TIP656"}

    [Beim Konvertieren von Tcl-Zeichenketten in ein externes Format mit **encoding convertto** werden nicht darstellbare Zeichen durch ein kodierungsabhängiges Zeichen ersetzt, meist **?**.]{version="TIP656"}

[**replace**]{version="TIP656"}
: [Wie **tcl8** setzt **replace** bei Konvertierungsfehlern die Verarbeitung fort, verwendet aber eine Unicode-konforme Ersetzungsmethode für ungültige Quelldaten.]{version="TIP656"}

    [Bei **encoding convertfrom** werden ungültige Bytes durch den Codepunkt U+FFFD REPLACEMENT CHARACTER ersetzt.]{version="TIP656"}

    [Bei **encoding convertto** werden nicht darstellbare Codepunkte in ein kodierungsspezifisches Ersatzzeichen umgewandelt: U+FFFD REPLACEMENT CHARACTER für UTF-Ziele, sonst meist `?`.]{version="TIP656"}


# Beispiele

Diese Beispiele verwenden die unten stehende Hilfsprozedur, die die Unicode-Codepunkte einer Tcl-Zeichenkette ausgibt.

```
proc codepoints s {join [lmap c [split $s {}] {
    string cat U+ [format %.6X [scan $c %c]]}]
}
```

Beispiel 1: Bytefolge in japanischer euc-jp-Kodierung in eine Tcl-Zeichenkette umwandeln:

```
% codepoints [encoding convertfrom euc-jp "\xA4\xCF"]
U+00306F
```

Das Ergebnis ist der Unicode-Codepunkt „\\u306F“, der Hiragana-Buchstabe HA.

Beispiel 2: Fehlerbehandlung anhand von Profilen:

Der Buchstabe **A** ist das Unicode-Zeichen U+0041, das Byte „\\x80“ ist in ASCII-Kodierung ungültig.

```
% codepoints [encoding convertfrom -profile tcl8 ascii A\x80]
U+000041 U+000080
% codepoints [encoding convertfrom -profile replace ascii A\x80]
U+000041 U+00FFFD
% codepoints [encoding convertfrom -profile strict ascii A\x80]
unexpected byte sequence starting at index 1: '\x80'
```

Beispiel 3: Teilweise Daten und Fehlerposition:

```
% codepoints [encoding convertfrom -profile strict -failindex idx ascii AB\x80]
U+000041 U+000042
% set idx
2
```

Beispiel 4: Zeichen kodieren, das in ISO8859-1 nicht darstellbar ist:

```
% encoding convertto iso8859-1 A\u0141
A?
% encoding convertto -profile strict iso8859-1 A\u0141
unexpected character at index 1: 'U+000141'
% encoding convertto -profile strict -failindex idx iso8859-1 A\u0141
A
% set idx
1
```
