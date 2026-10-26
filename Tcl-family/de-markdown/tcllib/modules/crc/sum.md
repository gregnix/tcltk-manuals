---
CommandName: sum
ManualSection: n
Version: 1.1.3
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - cksum(n)
 - crc32(n)
 - sum(1)
Keywords:
 - checksum
 - cksum
 - crc
 - crc32
 - cyclic redundancy check
 - data integrity
 - security
 - sum
Copyright:
 - Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# NAME

sum – Berechnung einer „sum(1)“-kompatiblen Prüfsumme

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [sum]{.lit} [1.1.3]{.optlit} 
[::crc::sum]{.cmd} [-bsd | -sysv]{.optarg} [-format fmt]{.optarg} [-chunksize size]{.optarg} \[ [-filename]{.arg} [file]{.arg} | [-channel]{.arg} [chan]{.arg} | [string]{.arg} \] 
:::

# BESCHREIBUNG

Dieses Paket enthält eine ausschließlich in Tcl geschriebene Implementierung des Befehls „sum(1)“, der aus den Eingabedaten einen 16-Bit-Prüfsummenwert berechnet. Standardmäßig wird der BSD-Summenalgorithmus verwendet, es steht jedoch auch der SysV-Algorithmus zur Verfügung.

# BEFEHLE

**::crc::sum** ?*-bsd* | *-sysv*? ?*-format fmt*? ?*-chunksize size*? \[ *-filename file* | *-channel chan* | *string* \]
: Der Befehl akzeptiert Zeichenfolgen, einen Dateinamen oder einen Kanal als Eingabe und gibt einen Prüfsummenwert zurück, der mithilfe des Algorithmus **sum(1)** berechnet wurde. Das Ergebnis wird entweder gemäß dem angegebenen Bezeichner *format*(n) oder standardmäßig als vorzeichenlose Ganzzahl (%u) formatiert.


# OPTIONEN

**-sysv**
: Der SysV-Algorithmus ist relativ einfach aufgebaut. Die Byte-Werte werden addiert, und ein eventueller Überlauf wird verworfen. Die niedrigsten 16 Bits werden als Prüfsumme zurückgegeben. Eingaben mit identischem Inhalt, aber unterschiedlicher Reihenfolge führen zum gleichen Ergebnis.

**-bsd**
: Dieser Algorithmus ähnelt der SysV-Version, beinhaltet jedoch einen Schritt zur Bitrotation, wodurch eine Abhängigkeit von der Reihenfolge der Werte entsteht.

-filename *name*
: Gibt eine Prüfsumme für den Dateiinhalt anstelle der Parameterdaten zurück.

-channel *chan*
: Gibt eine Prüfsumme für den Inhalt des angegebenen Kanals zurück. Der Kanal muss zum Lesen geöffnet sein und sollte für die binäre Übersetzung konfiguriert sein. Der Kanal wird nach Abschluss des Vorgangs nicht geschlossen.

-chunksize *size*
: Legt die Blockgröße fest, die beim Lesen von Daten aus Dateien oder Kanälen verwendet wird. Der Standardwert beträgt 4096.

-format *string*
: Gibt die Prüfsumme unter Verwendung einer alternativen Formatvorlage zurück.


# BEISPIELE

```
% crc::sum "Hello, World!"
37287
```

```
% crc::sum -format 0x%X "Hello, World!"
0x91A7
```

```
% crc::sum -file sum.tcl
13392
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
Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
```
