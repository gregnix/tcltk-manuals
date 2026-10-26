---
CommandName: rc4
title: rc4
ManualSection: n
Version: 1.2.0
TclPart: tcllib
TclDescription: RC4 Stream Cipher
Links:
 - aes(n)
 - blowfish(n)
 - des(n)
Keywords:
 - arcfour
 - data integrity
 - encryption
 - rc4
 - security
 - stream cipher
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

rc4 – Implementierung der RC4-Stromverschlüsselung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [rc4]{.lit} [1.2.0]{.optlit}
[::rc4::rc4]{.cmd} [-hex]{.optarg} [-key]{.arg} [keyvalue]{.arg} [-command lst]{.optarg} [-out channel]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [-infile]{.arg} [filename]{.arg} | [string]{.arg} \]
[::rc4::RC4Init]{.cmd} [keydata]{.arg}
[::rc4::RC4]{.cmd} [Key]{.arg} [data]{.arg}
[::rc4::RC4Final]{.cmd} [Key]{.arg}
:::

# Beschreibung

Dieses Paket ist eine Implementierung der von Ron Rivest von RSA Data Security Inc. entwickelten RC4-Stromverschlüsselung in Tcl. Die Verschlüsselung war ein Geschäftsgeheimnis von RSA, wurde jedoch rückentwickelt und 1994 im Internet veröffentlicht. Sie wird in einer Reihe von Netzwerkprotokollen zur Sicherung der Kommunikation eingesetzt. Um markenrechtlichen Beschränkungen zu umgehen, wird diese Verschlüsselung manchmal als ARCFOUR bezeichnet.

# Befehle

**::rc4::rc4** ?*-hex*? *-key keyvalue* ?*-command lst*? ?*-out channel*? \[ *-in channel* | *-infile filename* | *string* \]
: Wendet den RC4-Algorithmus entweder auf die durch das Argument bereitgestellten Daten oder auf die aus dem Kanal *-in* gelesenen Daten an. Wird ein Kanal *-out* angegeben, wird das Ergebnis in diesen Kanal geschrieben. Bei Angabe der Option *-hex* gibt es eine hexadezimal kodierte Version des Ergebnisses zurück, wenn kein *-out*-Kanal verwendet wird.

    Die zu verarbeitenden Daten können entweder als Zeichenfolgenargument für den Befehl rc4, als Dateiname oder als zuvor geöffneter Kanal angegeben werden. Wenn das Argument *-infile* angegeben wird, wird die Datei geöffnet, die Daten werden gelesen und verarbeitet, und die Datei wird geschlossen. Wenn das Argument *-in* angegeben wird, werden Daten aus dem Kanal bis zum Dateiende gelesen. Der Kanal wird nicht geschlossen. Wenn das Argument *-out* angegeben wird, wird das Verarbeitungsergebnis in diesen Kanal geschrieben.

    Wenn *-command* angegeben wird, gibt der Befehl „rc4“ nichts zurück. Stattdessen wird der angegebene Befehl aufgerufen, wobei die Ergebnisdaten von „rc4“ als letzter Parameter angehängt werden. Dies ist besonders nützlich beim Lesen aus Tcl-Kanälen, da auf dem Kanal ein „fileevent“ eingerichtet ist und die Daten in Blöcken verarbeitet werden.

    Es sollte nur eines der Argumente *-infile*, *-in* oder *string* angegeben werden.


# Programmierschnittstelle

**::rc4::RC4Init** *keydata*
: Initialisiert einen neuen RC4-Schlüssel. Bei *keydata* handelt es sich um eine beliebige Menge an Binärdaten, die zur Initialisierung des internen Zustands der Verschlüsselungsfunktion verwendet wird.

**::rc4::RC4** *Key* *data*
: Verschlüsseln oder entschlüsseln Sie die Eingabedaten mit dem Schlüssel, den Sie durch den Aufruf von **RC4Init** erhalten haben.

**::rc4::RC4Final** *Key*
: Diese Funktion sollte aufgerufen werden, um die mit *Key* verbundenen Ressourcen zu bereinigen. Sobald diese Funktion aufgerufen wurde, wird der Schlüssel gelöscht.


# Beispiele

```
% set keydata [binary format H* 0123456789abcdef]
% rc4::rc4 -hex -key $keydata HelloWorld
3cf1ae8b7f1c670b612f
% rc4::rc4 -key $keydata [binary format H* 3cf1ae8b7f1c670b612f]
HelloWorld
```

```
 set Key [rc4::RC4Init "key data"]
 append ciphertext [rc4::RC4 $Key $plaintext]
 append ciphertext [rc4::RC4 $Key $additional_plaintext]
 rc4::RC4Final $Key
```

```
 proc ::Finish {myState data} {
     DoStuffWith $myState $data
 }
 rc4::rc4 -in $socket -command [list ::Finish $ApplicationState]
```

# Autoren

Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *rc4* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
