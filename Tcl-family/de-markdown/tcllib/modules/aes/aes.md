---
CommandName: aes
title: aes
ManualSection: n
Version: 1.2.2
TclPart: tcllib
TclDescription: Advanced Encryption Standard (AES)
Links:
 - blowfish(n)
 - des(n)
 - md5(n)
 - sha1(n)
Keywords:
 - aes
 - block cipher
 - data integrity
 - encryption
 - security
Copyright:
 - Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
 - Copyright (c) 2012-2014, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

aes – Implementierung der AES-Blockverschlüsselung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [aes]{.lit} [1.2.2]{.optlit}
[::aes::aes]{.cmd} [-mode \[ecb|cbc\]]{.optarg} [-dir \[encrypt|decrypt\]]{.optarg} [-key]{.arg} [keydata]{.arg} [-iv vector]{.optarg} [-hex]{.optarg} [-out channel]{.optarg} [-chunksize size]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [--]{.optlit} [data]{.arg} \]
[::aes::Init]{.cmd} [mode]{.arg} [keydata]{.arg} [iv]{.arg}
[::aes::Encrypt]{.cmd} [Key]{.arg} [data]{.arg}
[::aes::Decrypt]{.cmd} [Key]{.arg} [data]{.arg}
[::aes::Reset]{.cmd} [Key]{.arg} [iv]{.arg}
[::aes::Final]{.cmd} [Key]{.arg}
:::

# Beschreibung

Dies ist eine Tcl-Implementierung des Advanced Encryption Standard (AES), wie er vom US-amerikanischen National Institute of Standards and Technology veröffentlicht wurde \[1\]. AES ist eine 128-Bit-Blockverschlüsselung mit einer variablen Schlüsselgröße von 128, 192 oder 256 Bit. Diese Implementierung unterstützt die Modi CBC und ECB.

# Befehle

**::aes::aes** ?*-mode \[ecb|cbc\]*? ?*-dir \[encrypt|decrypt\]*? *-key keydata* ?*-iv vector*? ?*-hex*? ?*-out channel*? ?*-chunksize size*? \[ *-in channel* | ?**--**? *data* \]
: Wendet den Algorithmus **aes** entweder auf die durch das Argument bereitgestellten Daten oder auf die aus dem Kanal *-in* gelesenen Daten an. Wenn ein *-out*-Kanal angegeben wird, wird das Ergebnis in diesen Kanal geschrieben.

    Die Option *-key* muss angegeben werden. Dieser Parameter akzeptiert eine binäre Zeichenkette mit einer Länge von entweder 16, 24 oder 32 Byte und dient zur Generierung des Schlüsselschemas.

    Die Optionen *-mode* und *-dir* sind optional und sind standardmäßig auf den CBC-Modus bzw. auf encrypt gesetzt. Der Initialisierungsvektor *-iv* erwartet ein binäres Argument mit einer Länge von 16 Byte, das standardmäßig aus lauter Nullen besteht. Weitere Informationen zu den verfügbaren Modi und deren Verwendung finden Sie unter [Betriebsarten].

    Da AES eine 128-Bit-Blockverschlüsselung ist, müssen die Daten in Einheiten bereitgestellt werden, die ein Vielfaches von 16 Byte sind.


# Programmierschnittstelle

Der interne Zustand wird in einer undurchsichtigen Struktur verwaltet, die von der Funktion **Init** zurückgegeben wird. Im CBC-Modus wird ein bestimmter, von der Eingabe abhängiger Zustand verwaltet, der durch den Aufruf der Funktion **Reset** mit einem neuen Wert für den Initialisierungsvektor zurückgesetzt werden kann. Im ECB-Modus wird der Zustand durch die Eingabe nicht beeinflusst.

**::aes::Init** *mode* *keydata* *iv*
: Erstellt ein neues AES-Schlüsselschema unter Verwendung der angegebenen Schlüsseldaten und des vorgegebenen Initialisierungsvektors. Der Initialisierungsvektor ist für den CBC-Modus von Bedeutung; im ECB-Modus wird er nicht verwendet. Weitere Informationen zu den Verschlüsselungsmodi finden Sie unter [Betriebsarten].

**::aes::Encrypt** *Key* *data*
: Verschlüsselt die bereitgestellten Daten mit einem vorbereiteten Schlüssel aus **Init**. Das Argument „data“ sollte ein binäres Array sein, dessen Größe ein Vielfaches der AES-Blockgröße von 16 Byte beträgt. Das Ergebnis ist ein binäres Array, dessen Größe der der Eingabedaten entspricht.

**::aes::Decrypt** *Key* *data*
: Hinweis: Der gleiche Schlüssel kann sowohl zum Verschlüsseln als auch zum Entschlüsseln von Daten verwendet werden, sofern der Initialisierungsvektor für den CBC-Modus entsprechend zurückgesetzt wird.

**::aes::Reset** *Key* *iv*
: Setzt den Initialisierungsvektor zurück. Dies ermöglicht es dem Programmierer, einen Schlüssel wiederzuverwenden und den Aufwand für die Neugenerierung des Schlüsselschemas zu vermeiden, wenn dieselben Schlüsseldaten mehrfach verwendet werden.

**::aes::Final** *Key*
: Diese Funktion sollte aufgerufen werden, um die mit *Key* verbundenen Ressourcen freizugeben. Sobald diese Funktion aufgerufen wurde, darf der Schlüssel nicht mehr verwendet werden.


# Betriebsarten

Cipher Block Chaining (CBC)
: Im CBC-Modus wird die Ausgabe der Verschlüsselung des letzten Blocks zur Bearbeitung des aktuellen Blocks herangezogen. Zur Verarbeitung des ersten Blocks wird ein Initialisierungsvektor verwendet, dessen Größe der Chiffreblockgröße entspricht. Der Initialisierungsvektor sollte zufällig ausgewählt und als erster Block der Ausgabe übertragen werden. Fehler bei der Verschlüsselung wirken sich auf den aktuellen Block und den nächsten Block aus; danach korrigiert sich die Verschlüsselung von selbst. CBC ist der am häufigsten verwendete Modus in der Softwareverschlüsselung und der Standardbetriebsmodus dieses Moduls.

Electronic Code Book (ECB)
: Der ECB-Modus ist der Grundmodus aller Blockchiffren. Jeder Block wird unabhängig verschlüsselt, sodass identischer Klartext bei der Verschlüsselung mit demselben Schlüssel zu identischem Ergebnis führt. Etwaige Verschlüsselungsfehler wirken sich nur auf einen einzelnen Block aus. *Dieser Modus ist anfällig für Angriffe mit bekanntem Klartext.*


# Beispiele

```
% set nil_block [string repeat \\0 16]
% aes::aes -hex -mode cbc -dir encrypt -key $nil_block $nil_block
66e94bd4ef8a2c3b884cfa59ca342b2e
```

```
set Key [aes::Init cbc $sixteen_bytes_key_data $sixteen_byte_iv]
append ciphertext [aes::Encrypt $Key $plaintext]
append ciphertext [aes::Encrypt $Key $additional_plaintext]
aes::Final $Key
```

# Literatur

1. „Advanced Encryption Standard“, Federal Information Processing Standards Publication 197, 2001 (<http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf>)


# Autoren

Thorsten Schloermann, Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *aes* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
Copyright (c) 2012-2014, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
