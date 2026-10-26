---
CommandName: crc32
ManualSection: n
Version: 1.3.4
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - cksum(n)
 - crc16(n)
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

# NAME

crc32 – Durchführung einer 32-Bit-zyklischen Redundanzprüfung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [crc32]{.lit} [1.3.4]{.optlit} 
[::crc::crc32]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} \[ [-channel]{.arg} [chan]{.arg} | [-filename]{.arg} [file]{.arg} | [message]{.arg} \] 
[::crc::Crc32Init]{.cmd} [seed]{.optarg} 
[::crc::Crc32Update]{.cmd} [token]{.arg} [data]{.arg} 
[::crc::Crc32Final]{.cmd} [token]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine Tcl-Implementierung des CRC-32-Algorithmus, die auf den unter http://www.naaccr.org/standard/crc32/ bereitgestellten Informationen basiertdocument.html. Wenn entweder das Paket **critcl** oder das Paket **Trf** verfügbar ist, kann intern eine kompilierte Version verwendet werden, um die Berechnung der Prüfsumme zu beschleunigen.

# BEFEHLE

**::crc::crc32** ?-format *format*? ?-seed *value*? \[ *-channel chan* | *-filename file* | *message* \]
: Der Befehl akzeptiert entweder Zeichenfolgen, einen Kanal oder einen Dateinamen und gibt einen Prüfsummenwert zurück, der mithilfe des CRC-32-Algorithmus berechnet wurde. Das Ergebnis wird anhand des angegebenen Bezeichners *format*(n) formatiert. Standardmäßig wird der Wert als vorzeichenlose Ganzzahl zurückgegeben (Format %u).


# OPTIONEN

-channel *name*
: Gibt eine Prüfsumme für die aus einem Kanal gelesenen Daten zurück. Der Befehl liest so lange Daten aus dem Kanal, bis der Wert **eof** „wahr“ ist. Wenn Sie während dieser Berechnung Ereignisse verarbeiten möchten, lesen Sie bitte den Abschnitt **PROGRAMMIERSCHNITTSTELLE**.

-filename *name*
: Dies ist eine Komfortoption, die die angegebene Datei öffnet, die Kodierung auf „binär“ setzt und anschließend so vorgeht, als wäre die Option *-channel* verwendet worden. Die Datei wird nach Abschluss des Vorgangs geschlossen.

-format *string*
: Gibt die Prüfsumme unter Verwendung einer alternativen Formatvorlage zurück.

-seed *value*
: Wählt einen alternativen Wert für die CRC-Berechnung aus. Der Standardwert ist 0xffffffff. Dies kann nützlich sein, um den CRC für Datenstrukturen zu berechnen, ohne zuvor die gesamte Struktur in eine Zeichenkette umwandeln zu müssen. Der CRC des vorherigen Elements kann als Wert für die Berechnung des CRC des nächsten Elements verwendet werden. Hinweis: Der CRC32-Algorithmus beinhaltet einen abschließenden XOR-Schritt. Wenn eine inkrementelle Verarbeitung gewünscht ist, muss dieser Schritt rückgängig gemacht werden, bevor die Ausgabe des Algorithmus als Startwert für die weitere Verarbeitung verwendet wird. Eine einfachere Alternative ist die Verwendung der **PROGRAMMIERSCHNITTSTELLE**, die für diesen Betriebsmodus vorgesehen ist.


# PROGRAMMIERSCHNITTSTELLE

Das CRC-32-Paket implementiert die Prüfsumme mithilfe einer Kontextvariablen, der jederzeit zusätzliche Daten hinzugefügt werden können. Dies ist besonders nützlich in einer ereignisgesteuerten Umgebung, wie beispielsweise einer Tk-Anwendung oder einem Webserver-Paket. Die Daten, für die eine Prüfsumme berechnet werden soll, können während eines **fileevent**-Handlers schrittweise in einzelnen Blöcken verarbeitet werden. Dies kann die Interaktivität einer GUI-Anwendung verbessern und dazu beitragen, einen übermäßigen Speicherverbrauch zu vermeiden.

**::crc::Crc32Init** ?*seed*?
: Eröffnet einen neuen CRC32-Kontext. Gibt eine Token-ID zurück, die für die verbleibenden Funktionen verwendet werden muss. Bei Bedarf kann ein optionaler Startwert festgelegt werden.

**::crc::Crc32Update** *token* *data*
: Fügt Daten zur durch das Token identifizierten Prüfsumme hinzu. Der Aufruf von *Crc32Update \$token „abcd“* entspricht dem Aufruf von *Crc32Update \$token „ab“*, gefolgt von *Crc32Update \$token „cb“*. Siehe **BEISPIELE**.

**::crc::Crc32Final** *token*
: Gibt den Prüfsummenwert zurück und gibt alle von diesem Token belegten Ressourcen frei. Sobald dieser Befehl abgeschlossen ist, verliert das Token seine Gültigkeit. Das Ergebnis ist ein 32-Bit-Ganzzahlwert.


# BEISPIELE

```
% crc::crc32 "Hello, World!"
3964322768
```

```
% crc::crc32 -format 0x%X "Hello, World!"
0xEC4AC3D0
```

```
% crc::crc32 -file crc32.tcl
483919716
```

```
% set tok [crc::Crc32Init]
% crc::Crc32Update $tok "Hello, "
% crc::Crc32Update $tok "World!"
% crc::Crc32Final $tok
3964322768
```

# AUTOREN

Pat Thoyts

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *crc* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hashwerte, Prüfsummen und Verschlüsselung

# COPYRIGHT

```
Copyright (c) 2002, Pat Thoyts
```
