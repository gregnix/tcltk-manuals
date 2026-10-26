---
CommandName: blowfish
ManualSection: n
Version: 1.0.6
TclPart: tcllib
TclDescription: Blowfish Block Cipher
Links:
 - 3des
 - des
 - rc4
Keywords:
 - block cipher
 - blowfish
 - cryptography
 - encryption
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# NAME

blowfish – Implementierung der Blowfish-Blockverschlüsselung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [blowfish]{.lit} [1.0.6]{.optlit} 
[::blowfish::blowfish]{.cmd} [-mode \[ecb|cbc\]]{.optarg} [-dir \[encrypt|decrypt\]]{.optarg} [-key]{.arg} [keydata]{.arg} [-iv vector]{.optarg} [-out channel]{.optarg} [-chunksize size]{.optarg} [-pad padchar]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [--]{.optarg} [data]{.arg} \] 
[::blowfish::Init]{.cmd} [mode]{.arg} [keydata]{.arg} [iv]{.arg} 
[::blowfish::Encrypt]{.cmd} [Key]{.arg} [data]{.arg} 
[::blowfish::Decrypt]{.cmd} [Key]{.arg} [data]{.arg} 
[::blowfish::Reset]{.cmd} [Key]{.arg} [iv]{.arg} 
[::blowfish::Final]{.cmd} [Key]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket ist eine Implementierung des von Bruce Schneier entwickelten Blowfish-Algorithmus \[1\] in Tcl. Blowfish ist eine 64-Bit-Blockverschlüsselung, die für den schnellen Betrieb auf 32-Bit-Architekturen ausgelegt ist und eine variable Schlüssellänge unterstützt. Diese Implementierung unterstützt die Blowfish-Verschlüsselung im ECB- und CBC-Modus.

# BEFEHLE

**::blowfish::blowfish** ?*-mode \[ecb|cbc\]*? ?*-dir \[encrypt|decrypt\]*? *-key keydata* ?*-iv vector*? ?*-out channel*? ?*-chunksize size*? ?*-pad padchar*? \[ *-in channel* | ?*--*? *data* \]
: Wendet den Algorithmus **blowfish** entweder auf die durch das Argument bereitgestellten Daten oder auf die aus dem Kanal *-in* gelesenen Daten an. Wenn ein *-out*-Kanal angegeben wird, wird das Ergebnis in diesen Kanal geschrieben. Die Option *-key* muss angegeben werden. Dieser Parameter nimmt eine binäre Zeichenkette variabler Länge entgegen und dient zur Generierung des **blowfish**-Schlüsselschemas. Beachten Sie, dass die Erstellung eines Schlüsselschemas in Blowfish ein recht rechenintensiver Vorgang ist; daher lohnt es sich, den Schlüssel nach Möglichkeit wiederzuverwenden. Siehe **Reset**. Die Optionen *-mode* und *-dir* sind optional und sind standardmäßig auf den CBC-Modus bzw. encrypt gesetzt. Der Initialisierungsvektor *-iv* erwartet ein 8-Byte-Binärargument, dessen Standardwert aus 8 Nullen besteht. Weitere Informationen zu den verfügbaren Modi und deren Verwendung finden Sie unter **BETRIEBSARTEN**. Blowfish ist eine 64-Bit-Blockverschlüsselung. Das bedeutet, dass die Daten in Einheiten bereitgestellt werden müssen, die ein Vielfaches von 8 Byte sind. Der Befehl ***blowfish*** fügt standardmäßig bei Bedarf Nul-Zeichen hinzu, um die Eingabedaten auf ein Vielfaches von 8 Byte aufzufüllen. Die Befehle der Programmier-API fügen niemals Innenabstände hinzu, sondern lösen stattdessen einen Fehler aus, wenn die Eingabe kein Vielfaches der Blockgröße ist. Mit der Option *-pad* können Sie den Innenabstand ändern oder die Innenabstände deaktivieren, wenn die leere Zeichenkette als Argument übergeben wird.


# PROGRAMMIERSCHNITTSTELLE

**::blowfish::Init** *mode* *keydata* *iv*
: Erstellt eine neue Blowfish-Schlüsselplanung unter Verwendung der angegebenen Schlüsseldaten und des vorgegebenen Initialisierungsvektors. Der Initialisierungsvektor wird im ECB-Modus nicht verwendet, ist jedoch für den CBC-Modus von Bedeutung. Weitere Informationen zu den Verschlüsselungsmodi finden Sie unter **BETRIEBSARTEN**.

**::blowfish::Encrypt** *Key* *data*
: Verschlüsselt die bereitgestellten Daten mit einem vorbereiteten Schlüssel aus **Init**. Das Argument „data“ sollte ein binäres Array sein, dessen Größe ein Vielfaches der Blockgröße von 8 Byte beträgt. Das Ergebnis ist ein binäres Array, dessen Größe der der Eingabe der verschlüsselten Daten entspricht.

**::blowfish::Decrypt** *Key* *data*
: Hinweis: Der gleiche Schlüssel kann sowohl zum Verschlüsseln als auch zum Entschlüsseln von Daten verwendet werden, sofern der Initialisierungsvektor für den CBC-Modus entsprechend zurückgesetzt wird.

**::blowfish::Reset** *Key* *iv*
: Setzt den Initialisierungsvektor zurück. Dies ermöglicht es dem Programmierer, einen Schlüssel wiederzuverwenden und den Aufwand für die Neugenerierung des Schlüsselschemas zu vermeiden, wenn dieselben Schlüsseldaten mehrfach verwendet werden.

**::blowfish::Final** *Key*
: Diese Funktion sollte aufgerufen werden, um die mit *Key* verbundenen Ressourcen freizugeben. Sobald diese Funktion aufgerufen wurde, darf der Schlüssel nicht mehr verwendet werden.


# BETRIEBSARTEN

**Electronic Code Book (ECB)**
: Der ECB-Modus ist der Grundmodus aller Blockchiffren. Jeder Block wird unabhängig verschlüsselt, sodass identischer Klartext bei der Verschlüsselung mit demselben Schlüssel zu identischem Ergebnis führt. Etwaige Verschlüsselungsfehler wirken sich zwar nur auf einen einzelnen Block aus, dieser ist jedoch anfällig für Angriffe mit bekanntem Klartext.

**Cipher Block Chaining (CBC)**
: Im CBC-Modus wird die Ausgabe der Verschlüsselung des letzten Blocks zur Beeinflussung des aktuellen Blocks herangezogen. Für die Verarbeitung des ersten Blocks wird ein Initialisierungsvektor verwendet, dessen Größe der Chiffreblockgröße entspricht. Der Initialisierungsvektor sollte zufällig ausgewählt und als erster Block der Ausgabe übertragen werden. Fehler bei der Verschlüsselung wirken sich auf den aktuellen Block und den nächsten Block aus; danach korrigiert sich die Chiffre von selbst. CBC ist der am häufigsten verwendete Modus bei der Softwareverschlüsselung.


# BEISPIELE

```
% blowfish::blowfish -hex -mode ecb -dir encrypt -key secret01 "hello, world!"
d0d8f27e7a374b9e2dbd9938dd04195a
```

```
 set Key [blowfish::Init cbc $eight_bytes_key_data $eight_byte_iv]
 append ciphertext [blowfish::Encrypt $Key $plaintext]
 append ciphertext [blowfish::Encrypt $Key $additional_plaintext]
 blowfish::Final $Key
```

# LITERATUR

**\[1\]**
: Schneier, B. „Applied Cryptography, 2. Auflage“, 1996, ISBN 0-471-11709-9, Verlag John Wiley & Sons.


# AUTOREN

Frank Pilhofer, Pat Thoyts

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *blowfish* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hashwerte, Prüfsummen und Verschlüsselung

# COPYRIGHT

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
