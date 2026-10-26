---
CommandName: cksum
title: cksum
ManualSection: n
Version: 1.1.5
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - crc32(n)
 - sum(n)
Keywords:
 - checksum
 - cksum
 - crc
 - crc32
 - cyclic redundancy check
 - data integrity
 - security
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# Name

cksum – Berechnung einer mit cksum(1) kompatiblen Prüfsumme

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [cksum]{.lit} [1.1.5]{.optlit}
[::crc::cksum]{.cmd} [-format format]{.optarg} [-chunksize size]{.optarg} \[ [-channel]{.arg} [chan]{.arg} | [-filename]{.arg} [file]{.arg} | [string]{.arg} \]
[::crc::CksumInit]{.cmd}
[::crc::CksumUpdate]{.cmd} [token]{.arg} [data]{.arg}
[::crc::CksumFinal]{.cmd} [token]{.arg}
:::

# Beschreibung

Dieses Paket enthält eine Tcl-Implementierung des cksum(1)-Algorithmus, die auf Informationen basiert, die in der GNU-Implementierung dieses Programms als Teil des Pakets „GNU Textutils 2.0“ bereitgestellt werden.

# Befehle

**::crc::cksum** ?*-format format*? ?*-chunksize size*? \[ *-channel chan* | *-filename file* | *string* \]
: Der Befehl akzeptiert Zeichenfolgendaten, einen Kanal oder einen Dateinamen und gibt einen Prüfsummenwert zurück, der mithilfe des Algorithmus **cksum(1)** berechnet wurde. Das Ergebnis wird entweder gemäß dem angegebenen Bezeichner *format*(n) formatiert oder standardmäßig als vorzeichenlose Ganzzahl (%u) ausgegeben.


# Optionen

-channel *name*
: Gibt eine Prüfsumme für die aus einem Kanal gelesenen Daten zurück. Der Befehl liest so lange Daten aus dem Kanal, bis der Wert **eof** „wahr“ ist. Wenn Sie während dieser Berechnung Ereignisse verarbeiten möchten, lesen Sie bitte den Abschnitt [Programmierschnittstelle].

-filename *name*
: Dies ist eine Komfortoption, die die angegebene Datei öffnet, die Kodierung auf „binär“ setzt und anschließend so vorgeht, als wäre die Option *-channel* verwendet worden. Die Datei wird nach Abschluss des Vorgangs geschlossen.

-format *string*
: Gibt die Prüfsumme unter Verwendung einer alternativen Formatvorlage zurück.


# Programmierschnittstelle

Das Paket „cksum“ implementiert die Prüfsumme mithilfe einer Kontextvariablen, der jederzeit zusätzliche Daten hinzugefügt werden können. Dies ist besonders nützlich in einer ereignisgesteuerten Umgebung, wie beispielsweise einer Tk-Anwendung oder einem Webserver-Paket. Die Daten, für die eine Prüfsumme berechnet werden soll, können während eines **fileevent**-Handlers schrittweise in einzelnen Blöcken verarbeitet werden. Dies kann die Interaktivität einer GUI-Anwendung verbessern und dazu beitragen, einen übermäßigen Speicherverbrauch zu vermeiden.

**::crc::CksumInit**
: Eröffnet einen neuen cksum-Kontext. Gibt eine Token-ID zurück, die für die verbleibenden Funktionen verwendet werden muss. Bei Bedarf kann ein optionaler Startwert festgelegt werden.

**::crc::CksumUpdate** *token* *data*
: Fügt Daten zur durch das Token identifizierten Prüfsumme hinzu. Der Aufruf von *CksumUpdate $token „abcd“* entspricht dem Aufruf von *CksumUpdate $token „ab“*, gefolgt von *CksumUpdate $token „cb“*. Siehe [Beispiele].

**::crc::CksumFinal** *token*
: Gibt den Prüfsummenwert zurück und gibt alle von diesem Token belegten Ressourcen frei. Sobald dieser Befehl abgeschlossen ist, verliert das Token seine Gültigkeit. Das Ergebnis ist ein 32-Bit-Ganzzahlwert.


# Beispiele

```
% crc::cksum "Hello, World!"
2609532967
```

```
% crc::cksum -format 0x%X "Hello, World!"
0x9B8A5027
```

```
% crc::cksum -file cksum.tcl
1828321145
```

```
% set tok [crc::CksumInit]
% crc::CksumUpdate $tok "Hello, "
% crc::CksumUpdate $tok "World!"
% crc::CksumFinal $tok
2609532967
```

# Autoren

Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *crc* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2002, Pat Thoyts
```
