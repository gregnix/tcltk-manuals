---
CommandName: des
title: des
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Data Encryption Standard (DES)
Links:
 - aes(n)
 - blowfish(n)
 - md5(n)
 - rc4(n)
 - sha1(n)
Keywords:
 - 3DES
 - DES
 - block cipher
 - data integrity
 - encryption
 - security
Copyright:
 - Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

des – Implementierung der DES- und Triple-DES-Verschlüsselungsverfahren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [des]{.lit} [1.2]{.lit}
[::DES::des]{.cmd} [-mode \[ecb|cbc|cfb|ofb\]]{.optarg} [-dir \[encrypt|decrypt\]]{.optarg} [-key]{.arg} [keydata]{.arg} [-iv vector]{.optarg} [-hex]{.optarg} [-weak]{.optarg} [-out channel]{.optarg} [-chunksize size]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [data]{.arg} \]
[::DES::Init]{.cmd} [mode]{.arg} [keydata]{.arg} [iv]{.arg} [weak]{.optarg}
[::DES::Encrypt]{.cmd} [Key]{.arg} [data]{.arg}
[::DES::Decrypt]{.cmd} [Key]{.arg} [data]{.arg}
[::DES::Reset]{.cmd} [Key]{.arg} [iv]{.arg}
[::DES::Final]{.cmd} [Key]{.arg}
:::

# Beschreibung

Hierbei handelt es sich um eine Implementierung des Data Encryption Standard (DES) in Tcl, wie er vom US-amerikanischen National Institute of Standards and Technology (NIST) veröffentlicht wurde \[1\]. Diese Implementierung unterstützt zudem die Erweiterung „Triple DES“ (3DES) des DES. DES ist eine 64-Bit-Blockverschlüsselung, die einen 56-Bit-Schlüssel verwendet. 3DES verwendet einen 168-Bit-Schlüssel. DES wurde inzwischen offiziell durch AES abgelöst, wird jedoch in vielen Protokollen weiterhin häufig verwendet.

Die tcllib-Implementierung von DES und 3DES basiert auf einer Implementierung von Mac Cody und steht als separater Download unter [2] zur Verfügung. Wer sich für die Einzelheiten der Weitergabe dieses Codes interessiert, wird auf die TclDES-Seiten verwiesen. Der tcllib-spezifische Code ist ein Wrapper für die TclDES-API, der für die DES-Verschlüsselung dieselbe API bereitstellt wie für andere Verschlüsselungsalgorithmen in der Bibliothek.

# Befehle

**::DES::des** ?*-mode \[ecb|cbc|cfb|ofb\]*? ?*-dir \[encrypt|decrypt\]*? *-key keydata* ?*-iv vector*? ?*-hex*? ?*-weak*? ?*-out channel*? ?*-chunksize size*? \[ *-in channel* | *data* \]
: Wendet den Algorithmus **DES** entweder auf die durch das Argument bereitgestellten Daten oder auf die aus dem Kanal *-in* gelesenen Daten an. Wenn ein *-out*-Kanal angegeben wird, wird das Ergebnis in diesen Kanal geschrieben.

    Die Option *-key* muss angegeben werden. Dieser Parameter erwartet eine binäre Zeichenkette mit einer Länge von 8 Byte und dient zur Erzeugung des Schlüsselschemas. Bei DES werden nur 56 Bit der Schlüsseldaten verwendet. Das höchstwertige Bit jedes Bytes wird verworfen.

    Die Optionen *-mode* und *-dir* sind optional und sind standardmäßig auf den CBC-Modus bzw. encrypt gesetzt. Der Initialisierungsvektor *-iv* erwartet ein binäres Argument mit einer Länge von 8 Byte. Standardmäßig besteht dieser aus lauter Nullen. Weitere Informationen zu *-mode* und zur Verwendung des Initialisierungsvektors finden Sie unter [Betriebsarten].

    DES ist eine 64-Bit-Blockverschlüsselung. Das bedeutet, dass die Daten in Einheiten bereitgestellt werden müssen, die ein Vielfaches von 8 Bytes sind.


# Programmierschnittstelle

Der interne Zustand wird in einer undurchsichtigen Struktur verwaltet, die von der Funktion **Init** gegeben wird. Im ECB-Modus wird der Zustand durch die Eingabe nicht beeinflusst; in anderen Modi wird jedoch ein gewisser eingabebedingter Zustand verwaltet, der durch den Aufruf der Funktion **Reset** mit einem neuen Wert für den Initialisierungsvektor zurückgesetzt werden kann.

**::DES::Init** *mode* *keydata* *iv* ?*weak*?
: Erstellt ein neues DES-Schlüsselschema unter Verwendung der angegebenen Schlüsseldaten und des vorgegebenen Initialisierungsvektors. Der Initialisierungsvektor wird im ECB-Modus nicht verwendet, ist jedoch für andere Betriebsmodi von Bedeutung. Siehe [Betriebsarten].

    Es gibt eine kleine Anzahl von Schlüsseln, von denen bekannt ist, dass sie bei der Verwendung mit DES schwach sind. Standardmäßig wird ein Fehler ausgelöst, wenn ein solcher Schlüssel übergeben wird. Sollte es erforderlich sein, solche Schlüssel zu akzeptieren, kann der Parameter *weak* auf „true“ gesetzt werden, um die Auslösung des Fehlers zu vermeiden.

**::DES::Encrypt** *Key* *data*
: Verschlüsselt die bereitgestellten Daten mit einem vorbereiteten Schlüssel aus **Init**. Das Argument „data“ sollte ein binäres Array sein, dessen Größe ein Vielfaches der DES-Blockgröße von 8 Byte beträgt. Das Ergebnis ist ein binäres Array, dessen Größe der der Eingabedaten entspricht.

**::DES::Decrypt** *Key* *data*
: Hinweis: Der gleiche Schlüssel kann sowohl zum Verschlüsseln als auch zum Entschlüsseln von Daten verwendet werden, sofern der Initialisierungsvektor für den CBC-Modus entsprechend zurückgesetzt wird.

**::DES::Reset** *Key* *iv*
: Setzt den Initialisierungsvektor zurück. Dies ermöglicht es dem Programmierer, einen Schlüssel wiederzuverwenden und den Aufwand für die Neugenerierung des Schlüsselschemas zu vermeiden, wenn dieselben Schlüsseldaten mehrfach verwendet werden.

**::DES::Final** *Key*
: Diese Funktion sollte aufgerufen werden, um die mit *Key* verbundenen Ressourcen freizugeben. Sobald diese Funktion aufgerufen wurde, darf der Schlüssel nicht mehr verwendet werden.


# Betriebsarten

Electronic Code Book (ECB)
: Der ECB-Modus ist der Grundmodus aller Blockchiffren. Jeder Block wird unabhängig verschlüsselt, sodass identischer Klartext bei der Verschlüsselung mit demselben Schlüssel zu identischem Ergebnis führt. Etwaige Verschlüsselungsfehler wirken sich zwar nur auf einen einzelnen Block aus, dieser ist jedoch anfällig für Angriffe mit bekanntem Klartext.

Cipher Block Chaining (CBC)
: Im CBC-Modus wird die Ausgabe der Verschlüsselung des letzten Blocks zur Beeinflussung des aktuellen Blocks herangezogen. Für die Verarbeitung des ersten Blocks wird ein Initialisierungsvektor verwendet, dessen Größe der Chiffreblockgröße entspricht. Der Initialisierungsvektor sollte zufällig ausgewählt und als erster Block der Ausgabe übertragen werden. Fehler bei der Verschlüsselung wirken sich auf den aktuellen Block und den nächsten Block aus; danach korrigiert sich die Chiffre von selbst. CBC ist der am häufigsten verwendete Modus bei der Softwareverschlüsselung.

Cipher Feedback (CFB)
: Der CFB-Modus kann verwendet werden, um Blockchiffren in Stromchiffren umzuwandeln. Im CFB-Modus wird der Initialisierungsvektor verschlüsselt und die Ausgabe anschließend mit dem Klartext-Strom XOR-verknüpft. Das Ergebnis wird dann als Initialisierungsvektor für die nächste Runde verwendet. Fehler wirken sich auf den aktuellen Block und den nächsten Block aus.

Output Feedback (OFB)
: OFB ähnelt CFB, mit dem Unterschied, dass das Ergebnis der Verschlüsselung in die nächste Runde zurückgeführt wird und nicht der XOR-verwandelte Klartext. Dies bedeutet, dass sich Fehler nur auf einen einzelnen Block auswirken, die Verschlüsselung jedoch anfälliger für Angriffe ist.


# Beispiele

```
% set ciphertext [DES::des -mode cbc -dir encrypt -key $secret $plaintext]
% set plaintext [DES::des -mode cbc -dir decrypt -key $secret $ciphertext]
```

```
set iv [string repeat \\0 8]
set Key [DES::Init cbc \\0\\1\\2\\3\\4\\5\\6\\7 $iv]
set ciphertext [DES::Encrypt $Key "somedata"]
append ciphertext [DES::Encrypt $Key "moredata"]
DES::Reset $Key $iv
set plaintext [DES::Decrypt $Key $ciphertext]
DES::Final $Key
```

# Literatur

1. „Data Encryption Standard“, Federal Information Processing Standards Publication 46-3, 1999, (<http://csrc.nist.gov/publications/fips/fips46-3/fips46-3.pdf>)

2. „TclDES: Tcl-Skripting auf höchstem Niveau“ *http://tcldes.sourceforge.net//*


# Autoren

Jochen C. Loewer, Mac Cody, Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *des* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
```
