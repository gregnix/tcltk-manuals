---
CommandName: crc16
title: crc16
ManualSection: n
Version: 1.1.5
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - cksum(n)
 - crc32(n)
 - sum(n)
Keywords:
 - checksum
 - cksum
 - crc
 - crc16
 - crc32
 - cyclic redundancy check
 - data integrity
 - security
Copyright:
 - Copyright (c) 2002, 2017, Pat Thoyts
---

# Name

crc16 – Durchführung einer 16-Bit-zyklischen Redundanzprüfung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [crc16]{.lit} [1.1.5]{.optlit}
[::crc::crc16]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::crc16]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::crc-ccitt]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::crc-ccitt]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::xmodem]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::xmodem]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::kermit]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::kermit]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::modbus]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::modbus]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::mcrf4xx]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::mcrf4xx]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::genibus]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::genibus]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::crc-x25]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::crc-x25]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::crc-sdlc]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::crc-sdlc]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::crc-usb]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::crc-usb]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::buypass]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::buypass]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::umts]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::umts]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::gsm]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::gsm]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::unknown2]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::unknown2]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::maxim]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::maxim]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::unknown3]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::unknown3]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::unknown4]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::unknown4]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
[::crc::cms]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} [--]{.lit} [message]{.arg}
[::crc::cms]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} [[-implementation]{.lit} [procname]{.arg}]{.optarg} -filename [file]{.arg}
:::

# Beschreibung

Dieses Paket bietet eine rein auf Tcl basierende Implementierung der CRC-Algorithmen, die auf den unter http://www.microconsultants.com/tips/crc/crc.txt bereitgestellten Informationen basiert. Es stehen zahlreiche Permutationen zur Berechnung von CRC-Prüfsummen zur Verfügung, und dieses Paket kann alle davon verarbeiten. Für die gängigsten Fälle sind Standardwerte voreingestellt.

# Befehle

**::crc::crc16** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::crc16** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::crc-ccitt** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::crc-ccitt** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::xmodem** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::xmodem** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::kermit** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::kermit** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::modbus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::modbus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::mcrf4xx** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::mcrf4xx** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::genibus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::genibus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::crc-x25** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::crc-x25** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::crc-sdlc** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::crc-sdlc** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::crc-usb** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::crc-usb** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::buypass** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::buypass** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::umts** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::umts** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::gsm** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::gsm** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::unknown2** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::unknown2** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::maxim** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::maxim** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::unknown3** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::unknown3** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::unknown4** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::unknown4** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: siehe unten ...

**::crc::cms** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: siehe unten ...

**::crc::cms** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: Der Befehl akzeptiert entweder Zeichenfolgendaten oder einen Dateinamen und gibt einen mithilfe des CRC-Algorithmus berechneten Prüfsummenwert zurück. Der verwendete Befehl legt das CRC-Polynom, den Startwert und die Bitreihenfolge für die gewünschte Standard-Prüfsummenberechnung fest. Das Ergebnis wird anhand des angegebenen Spezifikators *format*(n) formatiert oder standardmäßig als vorzeichenlose Ganzzahl (%u) ausgegeben.

    Für den CRC-Algorithmus werden eine Reihe gängiger Polynome verwendet, von denen die am häufigsten verwendeten in diesem Paket enthalten sind. Der Einfachheit halber verfügt jedes dieser Polynome über einen Befehlsalias im crc-Namespace.

    Es ist möglich, die CRC-32-Prüfsumme mithilfe dieses crc16-Pakets zu implementieren, da die Implementierung ausreichend generisch ist, um auf 32-Bit-Prüfsummen erweitert zu werden. Dies wurde beispielsweise bereits umgesetzt – allerdings ist dies nicht die schnellste Methode zur Implementierung dieses Algorithmus in Tcl, weshalb ein separates Paket namens **crc32** zur Verfügung steht.


# Optionen

-filename *name*
: Gibt eine Prüfsumme für den Dateiinhalt anstelle der Parameterdaten zurück.

-format *string*
: Gibt die Prüfsumme unter Verwendung einer alternativen Formatvorlage zurück.

-seed *value*
: Wählt einen alternativen Wert für die CRC-Berechnung aus. Der Standardwert ist 0 für die CRC16-Berechnung und 0xFFFF für die CCITT-Version. Dies kann nützlich sein, um den CRC für Datenstrukturen zu berechnen, ohne zuvor die gesamte Struktur in eine Zeichenkette umwandeln zu müssen. Der CRC des vorherigen Elements kann als Startwert für die Berechnung des CRC des nächsten Elements verwendet werden. Er dient außerdem dazu, eine Prüfsumme aus Fragmenten einer großen Nachricht (oder Datei) zu bilden.

-implementation *procname*
: Dieser Hook wird bereitgestellt, damit Benutzer ihre eigene Implementierung bereitstellen können (beispielsweise eine in C kompilierte Erweiterung). Die angegebene Prozedur wird mit zwei Parametern aufgerufen. Der erste Parameter sind die Daten, für die eine Prüfsumme berechnet werden soll, und der zweite ist der Startwert. Als Ergebnis wird eine Ganzzahl erwartet.

    Das Paket stellt einige Implementierungen von Standard-CRC-Polynomen für XMODEM, CCITT und die übliche CRC-16-Prüfsumme bereit. Der Einfachheit halber wurden zusätzliche Befehle bereitgestellt, die diese Implementierungen nutzen.

--
: Beendet die Optionsverarbeitung. Beachten Sie, dass die Verwendung des Optionsbeendigungsflags bei der Verarbeitung von Daten aus Parametern wichtig ist. Wenn die Binärdaten einer der oben genannten Optionen ähneln, werden die Daten als Option interpretiert, sofern dieses Kennzeichen nicht enthalten ist. Verwenden Sie stets das Optionsbeendigungsflag *--* vor der Angabe des Argumentes.


# Beispiele

```
% crc::crc16 -- "Hello, World!"
64077
```

```
% crc::crc-ccitt -- "Hello, World!"
26586
```

```
% crc::crc16 -format 0x%X -- "Hello, World!"
0xFA4D
```

```
% crc::crc16 -file crc16.tcl
51675
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
Copyright (c) 2002, 2017, Pat Thoyts
```
