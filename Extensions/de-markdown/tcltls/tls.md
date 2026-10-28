---
CommandName: tls
title: tls
ManualSection: n
Version: 2.0.1
TclPart: tls
TclDescription: Tcl TLS extension
Links:
 - OpenSSL [https://www.openssl.org/]
 - http
 - socket
Keywords:
 - I/O
 - IP Address
 - OpenSSL
 - SSL
 - TCP
 - TLS
 - TclTLS
 - asynchronous I/O
 - bind
 - certificate
 - channel
 - connection
 - domain name
 - host
 - https
 - network
 - network address
 - socket
 - tls
Copyright:
 - Copyright (c) 1999 Matt Newman
 - Copyright (c) 2004 Starfish Systems
 - Copyright (c) 2024 Brian O'Hagan
---

# Name

tls - Anbindung an die Bibliothek OpenSSL für verschlüsselte Socket- und E/A-Kanal-Kommunikation

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}
[package]{.cmd} [require]{.sub} [tls]{.lit} [2.0.1]{.lit}
[tls::init]{.cmd} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot}
[tls::socket]{.cmd} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot} [host]{.arg} [port]{.arg}
[tls::socket]{.cmd} [-server]{.lit} [command]{.arg} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot} [port]{.arg}
[tls::import]{.cmd} [channel]{.arg} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot}
[tls::starttls]{.cmd} [channel]{.arg} [-option]{.optarg} [value]{.optarg} [-option value]{.optdot}
[tls::handshake]{.cmd} [channel]{.arg}
[tls::shutdown]{.cmd} [channel]{.arg}
[tls::unimport]{.cmd} [channel]{.arg}
[tls::unstack]{.cmd} [channel]{.arg}
[tls::status]{.cmd} [-local]{.optlit} [channel]{.arg}
[tls::connection]{.cmd} [channel]{.arg}
[tls::ciphers]{.cmd} [protocol]{.optarg} [verbose]{.optarg} [supported]{.optarg}
[tls::protocols]{.cmd}
[tls::version]{.cmd}
:::

# Beschreibung

Diese Erweiterung gibt Tcl-Skripten Zugang zu Secure Socket Layer (SSL) über das Protokoll Transport Layer Security (TLS). Die Erweiterung bindet allgemein an [OpenSSL](https://www.openssl.org/) und nutzt die API **Tcl\_StackChannel** ab Tcl 8.4. Diese Sockets verhalten sich genau wie Kanäle des eingebauten Befehls **socket** und bieten zusätzliche Optionen für die SSL/TLS-Sitzung.

# Kompatibilität

Diese Erweiterung läuft mit OpenSSL 1.1.1 und neuer, einschließlich der Ausgaben 3.x und 4.0. Sie braucht Tcl 8.5 oder neuer und läuft mit Tcl 9.0.

# Befehle

Die folgenden Befehle stellt das Paket TclTLS bereit. Beispiele stehen unter [Beispiele] und im Verzeichnis "*demos*".

**tls::init** ?*-option*? ?*value*? ?*-option value ...*?
: Setzt optional die Vorgaben, die **tls::socket** verwendet. Ein direkter Aufruf von **tls::import** lässt die Werte dieses Befehls ohne Wirkung. Der Befehl kennt dieselben Optionen wie **tls::socket**. Die Optionen sollten auf die TLS-bezogenen beschränkt bleiben.

**tls::socket** ?*-option*? ?*value*? ?*-option value ...*? *host* *port*
: Hilfsfunktion. Die Funktion stellt die Verbindung über die Befehle **socket** und **tls::import** her, verhält sich wie der Tcl-Befehl **socket** und kennt zusätzlich die Optionen von **tls::import** sowie eine weitere Option. Zurück kommt die Kanal-Kennung des neuen Sockets. Die zusätzliche Option:

    **-autoservername** *bool*
    : Bei **true** wird das Argument **-servername** automatisch auf das Argument *host* gesetzt. Vor TclTLS 2.0 ist die Vorgabe **false**. Ab TclTLS 2.0 ist die Vorgabe **true**, sofern **-servername** nicht ebenfalls angegeben ist.


**tls::socket** **-server** *command* ?*-option*? ?*value*? ?*-option value ...*? *port*
: Wie der vorige Befehl, legt aber einen Server-Socket an, an den sich Klienten verbinden, analog zu **socket -server**. Zurück kommt die Kanal-Kennung des neuen Sockets.

**tls::import** *channel* ?*-option*? ?*value*? ?*-option value ...*?
: siehe unten ...

**tls::starttls** *channel* ?*-option*? ?*value*? ?*-option value ...*?
: Startet die TLS-Verschlüsselung auf dem Tcl-Kanal *channel* über einen gestapelten Kanal. Ein Socket ist dafür nicht nötig. Der Kanal muss Daten in beide Richtungen führen. Außerdem werden die Sitzungsparameter für den SSL-Handshake gesetzt. Gültige Optionen:

    **-alpn** *list*
    : Liste der Protokolle, die bei der Application-Layer Protocol Negotiation (ALPN) angeboten werden. Zum Beispiel **h2** und **http/1.1**, nicht aber **h3** oder **quic**. Diese Option ist neu in TclTLS 1.8.

    **-cadir** *directory*
    : Legt das Verzeichnis fest, in dem die Zertifikate der Zertifizierungsstelle (CA) liegen. Die Vorgabe hängt von der Plattform ab und kann zur Übersetzungszeit gesetzt werden. Die Umgebungsvariable **SSL\_CERT\_DIR** setzt den Vorgabeort außer Kraft. Einzelheiten stehen unter [Zertifikatsprüfung].

    **-cafile** *filename*
    : Legt die Datei mit den Zertifikaten der Zertifizierungsstelle (CA) im Dateiformat **PEM** fest. Die Vorgabe ist "*cert.pem*" im OpenSSL-Verzeichnis. Die Umgebungsvariable **SSL\_CERT\_FILE** setzt die Vorgabedatei außer Kraft. Einzelheiten stehen unter [Zertifikatsprüfung].

    **-castore** *URI*
    : Legt den Uniform Resource Identifier (URI) des Speichers der Zertifizierungsstelle (CA) fest. Das kann ein einzelner Container oder ein Katalog von Containern sein. Ab OpenSSL 3.2 unter MS Windows steht hier "**org.openssl.winstore://**", um den eingebauten Zertifikatsspeicher von MS Windows zu nutzen. Einzelheiten stehen unter [Zertifikatsprüfung]. Diese Option ist neu in TclTLS 1.8.

    **-certfile** *filename*
    : Legt den Namen der Datei fest, deren Zertifikat im PEM-Format als lokales Zertifikat (Klient oder Server) dient. Die Datei enthält auch den öffentlichen Schlüssel.

    **-cert** *string*
    : Legt das Zertifikat als DER-kodierte Zeichenkette fest (X.509 DER).

    **-cipher** *string*
    : Legt die Liste der Ciphers für Verbindungen mit TLS 1.2 und älter fest. Die Zeichenkette ist eine mit Doppelpunkt "**:**" getrennte Liste von Ciphers. Ciphers lassen sich mit dem Zeichen "**+**" verbinden. Vorsilben entfernen eine Cipher dauerhaft ("**!**"), löschen sie ("**-**") oder stellen sie ans Ende ("**+**"). Zulässig sind auch die Schlüsselwörter **@STRENGTH** (Sortierung nach der Schlüssellänge des Algorithmus), **@SECLEVEL=**_n_ (Sicherheitsstufe n) und **DEFAULT** (Vorgabeliste der Ciphers, nur am Anfang). Die vollständige Liste gültiger Werte steht in der Dokumentation von [OpenSSL](https://docs.openssl.org/master/man1/openssl-ciphers/#options).

    **-ciphersuites** *string*
    : Legt die Liste der Cipher-Suites für TLS 1.3 fest, als mit Doppelpunkt "**:**" getrennte Liste von Suite-Namen. Die vollständige Liste gültiger Werte steht in der Dokumentation von [OpenSSL](https://docs.openssl.org/master/man1/openssl-ciphers/#options). Diese Option ist neu in TclTLS 1.8.

    **-command** *callback*
    : Legt den Rückrufbefehl fest, der während des Handshakes an mehreren Stellen aufgerufen wird und Fehler, Ablaufinformationen und Protokollnachrichten übergibt. Einzelheiten stehen unter [Rückrufoptionen].

    **-dhparams** *filename*
    : Legt die Datei mit den Parametern für Diffie-Hellman (DH) fest.

    **-keyfile** *filename*
    : Legt die Datei mit dem privaten Schlüssel fest. Voreingestellt ist die Datei aus der Option **-certfile**.

    **-key** *string*
    : Legt den privaten Schlüssel als DER-kodierte Zeichenkette fest (PKCS#1 DER).

    **-model** *channel*
    : Erzwingt, dass dieser Kanal dieselbe Struktur *SSL\_CTX* nutzt wie der angegebene Kanal *channel* und damit Konfiguration, Rückruffunktionen und Weiteres teilt.

    **-password** *callback*
    : Legt den Rückrufbefehl fest, den OpenSSL aufruft, wenn ein Passwort gebraucht wird. Üblich ist das zum Entsperren des privaten Schlüssels eines Zertifikats. Die Rückruffunktion gibt eine Passwort-Zeichenkette zurück. Diese Option hat sich in TclTLS 1.8 geändert. Einzelheiten stehen unter [Rückrufoptionen].

    **-post\_handshake** *bool*
    : Erlaubt Aktualisierungen des Sitzungstickets nach dem Handshake. Diese Option ist neu in TclTLS 1.8.

    **-request** *bool*
    : Fordert während des SSL-Handshakes ein Zertifikat von der Gegenstelle an. Das ist für die Zertifikatsprüfung nötig. Ab TclTLS 1.8 ist die Vorgabe für Klientenverbindungen **true**. Ab TclTLS 2.0 wird der Wert auf **true** gesetzt, wenn hier **false** steht und **-require** **true** ist. Einzelheiten stehen unter [Zertifikatsprüfung].

    **-require** *bool*
    : Verlangt während des SSL-Handshakes ein gültiges Zertifikat von der Gegenstelle. Steht die Option auf wahr, muss auch **-request** auf wahr stehen, und zur Prüfung muss **-cadir**, **-cafile**, **-castore** oder eine Plattformvorgabe vorhanden sein. In TclTLS 1.8 und älter ist die Vorgabe **false**, weil nicht jede Plattform Zertifikate in einer mit OpenSSL verträglichen Form bereithält. Ab TclTLS 2.0 ist die Vorgabe für Klientenverbindungen **true**. Einzelheiten stehen unter [Zertifikatsprüfung].

    **-security\_level** *integer*
    : Legt die Sicherheitsstufe fest, ein Wert von 0 bis 5. Die Stufe bestimmt die erlaubten Verschlüsselungsalgorithmen der Cipher-Suites, die unterstützten ECC-Kurven, die unterstützten Signaturalgorithmen, die Größen der DH-Parameter, die Schlüsselgrößen der Zertifikate und die Signaturalgorithmen. Vor OpenSSL 3.2 ist die Vorgabe 1, danach 2. Stufe 3 und höher schalten Sitzungstickets ab und nehmen nur Cipher-Suites mit vorwärts gerichteter Geheimhaltung an. Diese Option ist neu in TclTLS 1.8.

    **-server** *bool*
    : Legt fest, ob die Seite als Server auftritt und auf den Handshake eines Klienten mit einem Server-Handshake antwortet. Die Vorgabe ist **false**.

    **-servername** *hostname*
    : Gibt den Hostnamen der Gegenstelle an. Daraus wird die Erweiterung TLS Server Name Indication (SNI) gesetzt. Der Wert ist der erwartete Servername im Zertifikat des Servers oder einer der Subject Alternate Names (SAN). Ab TclTLS 2.0 ist die Vorgabe der Host aus dem Befehl **tls::socket**.

    **-session\_id** *binary\_string*
    : Legt die Sitzungskennung fest, mit der eine Sitzung fortgesetzt wird. Noch nicht unterstützt. Diese Option ist neu in TclTLS 1.8.

    **-ssl2** *bool*
    : Schaltet SSL v2 ein. Die Vorgabe ist **false**. OpenSSL 1.1 und neuer unterstützt SSL v2 nicht mehr, die Option kann also ohne Wirkung bleiben. Die unterstützten Protokolle liefert der Befehl **tls::protocols**.

    **-ssl3** *bool*
    : Schaltet SSL v3 ein. Die Vorgabe ist **false**. Ab TclTLS 1.8 steht SSL v3 nur über eine Option zur Übersetzungszeit zur Verfügung. OpenSSL 4.0 und neuer unterstützt SSL v3 nicht mehr, die Option kann also ohne Wirkung bleiben. Die unterstützten Protokolle liefert der Befehl **tls::protocols**.

    **-tls1** *bool*
    : Schaltet TLS v1 ein. Ab TclTLS 2.0 ist die Vorgabe **false**. TLS 1.0 braucht zum Betrieb SHA1, und das steht bei OpenSSL 3.0 und neuer nur auf Sicherheitsstufe 0 bereit. Siehe die Option **-security\_level**.

    **-tls1.1** *bool*
    : Schaltet TLS v1.1 ein. Ab TclTLS 2.0 ist die Vorgabe **false**. TLS 1.1 braucht zum Betrieb SHA1, und das steht bei OpenSSL 3.0 und neuer nur auf Sicherheitsstufe 0 bereit. Siehe die Option **-security\_level**.

    **-tls1.2** *bool*
    : Schaltet TLS v1.2 ein. Die Vorgabe ist **true**.

    **-tls1.3** *bool*
    : Schaltet TLS v1.3 ein. Die Vorgabe ist **true**. Verfügbar erst ab OpenSSL 1.1.1 und TclTLS 1.7.

    **-validatecommand** *callback*
    : Legt den Rückrufbefehl fest, der während der Protokollverhandlung die Zertifikate der Gegenstelle und weitere Konfiguration prüft. Tcl-Skripte können damit eine eigene Zertifikatsprüfung zusätzlich zur Vorgabe von OpenSSL ausführen. Das Skript gibt den booleschen Wert wahr zurück, damit die Verhandlung weiterläuft. Einzelheiten stehen unter [Rückrufoptionen]. Diese Option ist neu in TclTLS 1.8.


**tls::handshake** *channel*
: Erzwingt den Handshake der TLS-Verhandlung sofort. Zurück kommt 0, wenn der Handshake noch läuft (nicht blockierend), oder 1, wenn er gelungen ist. Schlägt der Handshake fehl, kommt ein Fehler zurück.

**tls::shutdown** *channel*
: siehe unten ...

**tls::unimport** *channel*
: siehe unten ...

**tls::unstack** *channel*
: Beendet die SSL/TLS-Sitzung durch die Nachricht "close\_notify" und nimmt den obersten gestapelten Kanal von *channel*, ohne den Socket zu schließen. Das ist das Gegenstück zu **tls::import** und beendet die Verschlüsselung eines Tcl-Kanals. Ist TLS nicht der oberste gestapelte Kanaltyp, wird ein Fehler ausgelöst.

**tls::status** ?**-local**? *channel*
: Gibt den aktuellen Status eines SSL-Kanals zurück. Das Ergebnis ist eine Liste von Schlüssel-Wert-Paaren zu SSL, Zertifikat und Zertifikatsprüfung. Ist der SSL-Handshake noch nicht abgeschlossen, kommt eine leere Liste zurück. Mit der Option **-local** wird das lokale Zertifikat verwendet. Zurückgegebene Werte sind unter anderem:

    SSL-Status

    **alpn** *protocol*
    : Das nach der Application-Layer Protocol Negotiation (ALPN) gewählte Protokoll. Dieser Wert ist neu in TclTLS 1.8.

    **cipher** *cipher*
    : Die Cipher, die die Sitzung gerade verwendet.

    **peername** *name*
    : Der Name der Gegenstelle aus dem Zertifikat. Dieser Wert ist neu in TclTLS 1.8.

    **protocol** *version*
    : Die Protokollversion der Verbindung: SSL2, SSL3, TLS1, TLS1.1, TLS1.2, TLS1.3 oder unknown. Dieser Wert ist neu in TclTLS 1.8.

    **sbits** *n*
    : Die Anzahl der Bits des Sitzungsschlüssels.

    **signatureHashAlgorithm** *algorithm*
    : Der Hash-Algorithmus der Signatur. Dieser Wert ist neu in TclTLS 1.8.

    **signatureType** *type*
    : Der Wert des Signaturtyps. Dieser Wert ist neu in TclTLS 1.8.

    **verifyDepth** *n*
    : Größte Tiefe bei der Prüfung der Zertifikatskette. Die Vorgabe ist -1, dann wird alles geprüft. Dieser Wert ist neu in TclTLS 1.8.

    **verifyMode** *list*
    : Liste der Modi der Zertifikatsprüfung. Dieser Wert ist neu in TclTLS 1.8.

    **verifyResult** *result*
    : Ergebnis der Zertifikatsprüfung. Dieser Wert ist neu in TclTLS 1.8.

    **ca\_names** *list*
    : Liste der Zertifizierungsstellen, mit denen das Zertifikat erzeugt wurde. Dieser Wert ist neu in TclTLS 1.8.


    Zertifikatsstatus

    **all** *string*
    : Ausgabe aller Zertifikatsangaben. Dieser Wert ist neu in TclTLS 1.8.

    **version** *value*
    : Die Version des Zertifikats.

    **serialNumber** *string*
    : Die Seriennummer des Zertifikats als Hexadezimalzeichenkette. Dieser Wert hieß vor TclTLS 1.8 serial.

    **signature** *algorithm*
    : Cipher-Algorithmus der Zertifikatssignatur. Dieser Wert ist neu in TclTLS 1.8.

    **issuer** *string*
    : Der Distinguished Name (DN) des Ausstellers des Zertifikats.

    **notBefore** *date*
    : Das Anfangsdatum der Gültigkeit des Zertifikats.

    **notAfter** *date*
    : Das Ablaufdatum der Gültigkeit des Zertifikats.

    **subject** *string*
    : Der Distinguished Name (DN) des Inhabers des Zertifikats. Felder sind Common Name (CN), Organization (O), Locality oder City (L), State oder Province (S) und Country Name (C).

    **issuerUniqueID** *string*
    : Die eindeutige Kennung des Ausstellers. Dieser Wert ist neu in TclTLS 1.8.

    **subjectUniqueID** *string*
    : Die eindeutige Kennung des Inhabers. Dieser Wert ist neu in TclTLS 1.8.

    **num\_extensions** *n*
    : Anzahl der Zertifikatserweiterungen. Dieser Wert ist neu in TclTLS 1.8.

    **extensions** *list*
    : Liste der Namen der Zertifikatserweiterungen. Dieser Wert ist neu in TclTLS 1.8.

    **authorityKeyIdentifier** *string*
    : Authority Key Identifier (AKI) des CA-Zertifikats, das das SSL-Zertifikat signiert hat, als Hexadezimalzeichenkette. Der Wert stimmt mit dem SKI des Zwischen-CA-Zertifikats überein. Dieser Wert ist neu in TclTLS 1.8.

    **subjectKeyIdentifier** *string*
    : Subject Key Identifier (SKI), der Hash des öffentlichen Schlüssels im Zertifikat als Hexadezimalzeichenkette. Damit lassen sich Zertifikate erkennen, die einen bestimmten öffentlichen Schlüssel enthalten. Dieser Wert ist neu in TclTLS 1.8.

    **subjectAltName** *list*
    : Liste aller Subject Alternative Names (SAN), einschließlich Domänennamen, Unterdomänen und IP-Adressen, die das Zertifikat absichert. Dieser Wert ist neu in TclTLS 1.8.

    **ocsp** *list*
    : Liste aller URLs des Online Certificate Status Protocol (OCSP), mit denen sich die Gültigkeit dieses Zertifikats prüfen lässt. Dieser Wert ist neu in TclTLS 1.8.

    **certificate** *cert*
    : Das PEM-kodierte Zertifikat.

    **signatureAlgorithm** *algorithm*
    : Cipher-Algorithmus der Signatur des Zertifikats. Dieser Wert ist neu in TclTLS 1.8.

    **signatureValue** *string*
    : Zertifikatssignatur als Hexadezimalzeichenkette. Dieser Wert ist neu in TclTLS 1.8.

    **signatureDigest** *version*
    : Signaturprüfsumme des Zertifikats als Hexadezimalzeichenkette. Dieser Wert ist neu in TclTLS 1.8.

    **publicKeyAlgorithm** *algorithm*
    : Algorithmus des öffentlichen Schlüssels der Zertifikatssignatur. Dieser Wert ist neu in TclTLS 1.8.

    **publicKey** *string*
    : Öffentlicher Schlüssel der Zertifikatssignatur als Hexadezimalzeichenkette. Dieser Wert ist neu in TclTLS 1.8.

    **bits** *n*
    : Anzahl der Bits des Signaturschlüssels des Zertifikats. Dieser Wert ist neu in TclTLS 1.8.

    **self\_signed** *boolean*
    : Ob die Zertifikatssignatur selbst signiert ist. Dieser Wert ist neu in TclTLS 1.8.

    **sha1\_hash** *hash*
    : Der SHA1-Hash des Zertifikats als Hexadezimalzeichenkette. Dieser Wert ist neu in TclTLS 1.8.

    **sha256\_hash** *hash*
    : Der SHA256-Hash des Zertifikats als Hexadezimalzeichenkette. Dieser Wert ist neu in TclTLS 1.8.


**tls::connection** *channel*
: Gibt den aktuellen Verbindungsstatus eines SSL-Kanals zurück. Das Ergebnis ist eine Liste von Schlüssel-Wert-Paaren zur Verbindung. Dieser Befehl ist neu in TclTLS 1.8. Zurückgegebene Werte sind unter anderem:

    SSL-Status

    **state** *state*
    : Zustand der Verbindung.

    **servername** *name*
    : Der Name des Servers, zu dem die Verbindung besteht.

    **protocol** *version*
    : Die Protokollversion der Verbindung: SSL2, SSL3, TLS1, TLS1.1, TLS1.2, TLS1.3 oder unknown.

    **renegotiation\_allowed** *boolean*
    : Ob eine Neuverhandlung des Protokolls unterstützt wird.

    **security\_level** *level*
    : Die Sicherheitsstufe für die Wahl der Ciphers, der Schlüsselgröße und Weiteres.

    **session\_reused** *boolean*
    : Ob die Sitzung wiederverwendet wurde.

    **is\_server** *boolean*
    : Ob die Verbindung als Server (1) oder als Klient (0) eingerichtet ist.

    **compression** *mode*
    : Kompressionsverfahren.

    **expansion** *mode*
    : Expansionsverfahren.

    **caList** *list*
    : Liste der Zertifizierungsstellen (CA) für das X.509-Zertifikat.


    Angaben zur Cipher

    **cipher** *cipher*
    : Die Cipher, die die Verbindung gerade verwendet.

    **standard\_name** *name*
    : Der Standardname der Cipher nach RFC.

    **algorithm\_bits** *n*
    : Die Anzahl der verarbeiteten Bits der Cipher.

    **secret\_bits** *n*
    : Die Anzahl der geheimen Bits der Cipher.

    **min\_version** *version*
    : Die kleinste Protokollversion der Cipher.

    **cipher\_is\_aead** *boolean*
    : Ob die Cipher Authenticated Encryption with Associated Data (AEAD) ist.

    **cipher\_id** *id*
    : Die Cipher-Kennung von OpenSSL.

    **description** *string*
    : Eine Textbeschreibung der Cipher.

    **handshake\_digest** *boolean*
    : Prüfsumme, die während des Handshakes verwendet wird.


    Angaben zur Sitzung

    **alpn** *protocol*
    : Das nach der Application-Layer Protocol Negotiation (ALPN) gewählte Protokoll.

    **resumable** *boolean*
    : Ob die Sitzung fortgesetzt werden kann.

    **start\_time** *seconds*
    : Zeit seit dem Beginn der Sitzung, in Sekunden seit der Epoche.

    **timeout** *seconds*
    : Höchstdauer der Sitzung in Sekunden bis zur Zeitüberschreitung.

    **lifetime** *seconds*
    : Hinweis auf die Lebensdauer des Sitzungstickets in Sekunden.

    **session\_id** *binary\_string*
    : Eindeutige Sitzungskennung zum Fortsetzen der Sitzung.

    **session\_ticket** *binary\_string*
    : Eindeutiges Sitzungsticket zum Fortsetzen der Sitzung.

    **ticket\_app\_data** *binary\_string*
    : Eindeutige Anwendungsdaten des Sitzungstickets.

    **master\_key** *binary\_string*
    : Eindeutiger Master-Schlüssel der Sitzung.

    **session\_cache\_mode** *mode*
    : Cache-Modus des Servers (client, server oder both).


**tls::ciphers** ?*protocol*? ?*verbose*? ?*supported*?
: Ohne Optionen kommt eine Liste aller symmetrischen Ciphers für die Option *-cipher* zurück. Mit *protocol* kommen nur die Ciphers, die dieses Protokoll unterstützt. Die unterstützten Protokolle liefert der Befehl **tls::protocols**. Ist *verbose* wahr, kommt eine ausführliche, lesbare Liste mit weiteren Angaben zur Cipher zurück. Ist *supported* wahr, werden nur die Ciphers aufgeführt, die das Protokoll unterstützt. Das Argument *supported* ist neu in TclTLS 1.8.

**tls::protocols**
: Gibt eine Liste der unterstützten SSL/TLS-Protokolle zurück. Gültige Werte sind **ssl2**, **ssl3**, **tls1**, **tls1.1**, **tls1.2** und **tls1.3**. Die genaue Liste hängt von der OpenSSL-Version und den Schaltern zur Übersetzungszeit ab. Dieser Befehl ist neu in TclTLS 1.8.

**tls::version**
: Gibt die Versionszeichenkette von OpenSSL zurück.


# Zertifikatsprüfung

## PKI und Zertifikate

Mit der Public Key Infrastructure (PKI) erzeugt jeder Benutzer einen privaten Schlüssel, den nur er kennt, und einen öffentlichen Schlüssel, den er mit anderen zum Ver- und Entschlüsseln austauscht. Der Ablauf ist: der Absender verschlüsselt seine Daten mit seinem privaten Schlüssel und dem öffentlichen Schlüssel des Empfängers. Die Daten gehen dann an den Empfänger. Entsprechend entschlüsselt der Empfänger mit seinem privaten Schlüssel und dem öffentlichen Schlüssel des Absenders. Das sichert die Unversehrtheit der Daten, damit sie unterwegs nicht gelesen oder verändert werden können. Der private Schlüssel steht in den Optionen **-key** und **-keyfile**. Das Passwort steht in der Option **-password**.

Für die Authentisierung, also dafür, dass jemand der ist, der er zu sein behauptet, liegen der öffentliche Schlüssel und die Identitätsangaben in einem X.509-Zertifikat, und eine Zertifizierungsstelle (CA) authentisiert dieses Zertifikat, das heißt, sie signiert es. Die Zertifikate werden beim TLS-Start ausgetauscht und gegen die Wurzelzertifikate der CA geprüft. Das erledigt OpenSSL über die Optionen **-request** und **-require**. Wo die CA-Zertifikate liegen, steht in den Optionen **-cadir**, **-cadir** und **-castore**. In einer späteren Ausgabe können sie zusätzlich gegen die Certificate Revocation List (CRL) widerrufener Zertifikate geprüft werden. Zertifikate können auch selbst signiert sein. Voreingestellt gelten sie nicht als vertrauenswürdig, solange sie nicht in den Zertifikatsspeicher aufgenommen sind.

Beim Besuch von Webseiten muss in der Regel nur der Klient das Zertifikat des Servers prüfen. Der Server prüft das Klientenzertifikat nur, wenn eine Anmeldung eine Authentisierung verlangt. Ein eigenes Zertifikat steht in den Optionen **-cert** und **-certfile**.

## Zusammenfassung der Befehlszeilenoptionen

Die folgenden Optionen dienen der Prüfung des Zertifikats der Gegenstelle:

**-cadir** *directory*
: Legt das Verzeichnis fest, in dem die Zertifikate der Zertifizierungsstelle (CA) liegen. Die Vorgabe hängt von der Plattform ab, auf Linux- und Unix-Systemen ist das meist "*/etc/ssl/certs*". Die Umgebungsvariable **SSL\_CERT\_DIR** setzt den Vorgabeort außer Kraft.

**-cafile** *filename*
: Legt die Datei mit den Zertifikaten der Zertifizierungsstelle (CA) im Dateiformat **PEM** fest. Die Vorgabe ist "*cert.pem*" im OpenSSL-Verzeichnis. Auf Linux- und Unix-Systemen ist das meist "*/etc/ssl/ca-bundle.pem*". Die Umgebungsvariable **SSL\_CERT\_FILE** setzt die Vorgabedatei außer Kraft.

**-castore** *URI*
: Legt den Uniform Resource Identifier (URI) des Speichers der Zertifizierungsstelle (CA) fest. Das kann ein einzelner Container oder ein Katalog von Containern sein. Ab OpenSSL 3.2 unter MS Windows steht hier "**org.openssl.winstore://**", um den eingebauten Zertifikatsspeicher von MS Windows zu nutzen. Ab TclTLS 2.0 ist das die Vorgabe, wenn **-cadir**, **-cadir** und **-castore** nicht angegeben sind. Dieser Speicher kennt nur Wurzelzertifikatsspeicher.

**-request** *bool*
: Fordert während des SSL-Handshakes ein Zertifikat von der Gegenstelle an. Das ist für die Zertifikatsprüfung nötig. Ab TclTLS 1.8 ist die Vorgabe für Klientenverbindungen **true**. Ab TclTLS 2.0 wird der Wert auf **true** gesetzt, wenn hier **false** steht und **-require** **true** ist. Zusätzlich kann der Klient jedes Zertifikat mit der Option **-validatecommand** selbst prüfen und annehmen oder ablehnen.

**-require** *bool*
: Verlangt während des SSL-Handshakes ein gültiges Zertifikat von der Gegenstelle. Steht die Option auf wahr, muss auch **-request** auf wahr stehen, und zur Prüfung muss **-cadir**, **-cafile**, **-castore** oder eine Plattformvorgabe vorhanden sein. In TclTLS 1.8 und älter ist die Vorgabe **false**, weil nicht jede Plattform Zertifikate in einer mit OpenSSL verträglichen Form bereithält. Ab TclTLS 2.0 ist die Vorgabe für Klientenverbindungen **true**.


## Wann Befehlszeilenoptionen nötig sind

In TclTLS 1.8 und älter ist die Zertifikatsprüfung voreingestellt *nicht* eingeschaltet. Das liegt daran, dass es keine gemeinsame, plattformübergreifende Datenbank der von einer Zertifizierungsstelle (CA) bereitgestellten Zertifikate gibt. Viele Linux-Systeme unterstützen OpenSSL von Haus aus und haben diese Zertifikate als Teil des Systems installiert, MacOS und MS Windows nicht. Ab TclTLS 2.0 verlangen Klientenverbindungen die Zertifikatsprüfung voreingestellt. Für die Option **-require** muss eines der Folgenden zutreffen:

- Auf Linux- und Unix-Systemen mit bereits installiertem OpenSSL, oder wenn die CA-Zertifikate im PEM-Format vorliegen und an den üblichen Orten liegen oder die Umgebungsvariablen **SSL\_CERT\_DIR** oder **SSL\_CERT\_FILE** gesetzt sind, werden **-cadir**, **-cadir** und **-castore** nicht gebraucht.

- Liegt OpenSSL nicht am Vorgabeort, oder ist OpenSSL unter Mac OS oder MS Windows installiert, müssen die Umgebungsvariablen **SSL\_CERT\_DIR** und/oder **SSL\_CERT\_FILE** oder eine der Optionen **-cadir**, **-cadir** oder **-castore** gesetzt sein.

- Unter MS Windows kann OpenSSL ab Version 3.2 den eingebauten Windows-Zertifikatsspeicher ansprechen. Dafür steht die Option **-castore** auf "**org.openssl.winstore://**". In TclTLS 2.0 ist das der Vorgabewert, wenn **-cadir**, **-cadir** und **-castore** nicht angegeben sind.

- Ist OpenSSL nicht installiert oder liegen die CA-Zertifikate nicht im PEM-Format vor, müssen die CA-Zertifikate geladen und mit der Software installiert werden. Das CURL-Team stellt sie unter [CA-Zertifikate aus Mozilla](https://curl.se/docs/caextract.html) in der Datei "*cacert.pem*" bereit. Danach zeigen die Umgebungsvariablen **SSL\_CERT\_DIR** und/oder **SSL\_CERT\_FILE** oder die Optionen **-cadir** oder **-cafile** auf den Installationsort dieser Datei. Die Datei aktuell zu halten, liegt beim Anwender.


# Rückrufoptionen

Wie oben beschrieben, kann jeder Kanal eigene Rückruffunktionen für die Zwischenverarbeitung durch die Bibliothek OpenSSL bekommen, über die Optionen **-command**, **-password** und **-validate\_command** an **tls::socket** oder **tls::import**. Anders als in älteren TclTLS-Versionen wird der Befehl **bgerror** nur aufgerufen, wenn die Rückruffunktion einen Fehler erzeugt, und dann mit den Fehlerangaben.

## Werte für den Befehlsrückruf

Die Rückruffunktion der Option **-command** wird an mehreren Stellen während des OpenSSL-Handshakes und im laufenden Betrieb aufgerufen. Die möglichen Argumente des Rückrufskripts stehen unten. Rückgabewerte der Rückruffunktion werden ignoriert.

**error** *channelId message*
: Diese Form wird aufgerufen, wenn während der ersten Verbindung, des Handshakes oder der E/A ein Fehler auftritt. Das Argument *message* kann von Tcl\_ErrnoMsg, von der OpenSSL-Funktion **ERR\_reason\_error\_string()** oder eine eigene Nachricht sein. Diese Form ist neu in TclTLS 1.8.

**info** *channelId major minor message type*
: Diese Form wird von der OpenSSL-Funktion **SSL\_set\_info\_callback()** während der ersten Verbindung und des Handshakes aufgerufen. Die Argumente:

    *major*
    : Hauptkategorie des Fehlers. Gültige Werte: **handshake**, **alert**, **connect**, **accept**.

    *minor*
    : Nebenkategorie des Fehlers. Gültige Werte: **start**, **done**, **read**, **write**, **loop**, **exit**.

    *message*
    : Beschreibende Nachricht, je nach Zusammenhang von **SSL\_state\_string\_long()** oder **SSL\_alert\_desc\_string\_long()**.

    *type*
    : Bei Alarmen sind die Werte **warning**, **fatal** und **unknown**. Sonst steht **info**. Dieses Argument ist neu in TclTLS 1.8.


**message** *channelId direction version content\_type message*
: Diese Form wird von der OpenSSL-Funktion **SSL\_set\_msg\_callback()** aufgerufen, wenn während der ersten Verbindung, des Handshakes oder der E/A eine Nachricht gesendet oder empfangen wird. Verfügbar nur, wenn OpenSSL mit der Option **enable-ssl-trace** übersetzt wurde. Diese Form ist neu in TclTLS 1.8. Die Argumente:

    *direction*
    : Die Richtung ist **Sent** oder **Received**.

    *version*
    : Die Version ist die Protokollversion.

    *content\_type*
    : Der Inhaltstyp ist der Inhaltstyp der Nachricht.

    *message*
    : Die Nachricht sind weitere Angaben aus der API **SSL\_trace**.


**session** *channelId session\_id session\_ticket lifetime*
: Diese Form wird von der OpenSSL-Funktion **SSL\_CTX\_sess\_set\_new\_cb()** aufgerufen, wenn der Server während der ersten Verbindung und des Handshakes eine neue Sitzungskennung sendet, und auch während der Sitzung, wenn **-post\_handshake** auf wahr steht. Diese Form ist neu in TclTLS 1.8. Die Argumente:

    *session\_id*
    : Die Sitzungskennung ist der aktuelle Bezeichner der Sitzung.

    *session\_ticket*
    : Das Ticket sind die Angaben zum Sitzungsticket.

    *lifetime*
    : Die Lebensdauer ist die Lebensdauer des Tickets in Sekunden.


**verify** *channelId depth cert status error*
: Diese Rückruffunktion liegt seit TclTLS 1.8 bei **-validatecommand**.


## Werte für den Passwortrückruf

Die Rückruffunktion der Option **-password** ruft TclTLS auf, wenn OpenSSL ein Passwort braucht. Die möglichen Argumente des Rückrufskripts stehen unten. Die Rückruffunktion gibt das eingegebene Passwort zurück.

**password** *rwflag size*
: Wird beim Laden oder Speichern eines verschlüsselten PEM-Zertifikats aufgerufen. Die Argumente:

    *rwflag*
    : Die Lese-/Schreibmarke ist 0 für Lesen und Entschlüsseln oder 1 für Schreiben und Verschlüsseln. Der Wert 1 zeigt, wann eine Bestätigung erfragt wird. Dieses Argument ist neu in TclTLS 1.8.

    *size*
    : Die Größe ist die größte Länge des Passworts in Bytes. Dieses Argument ist neu in TclTLS 1.8.



## Werte für den Prüfrückruf

Die Rückruffunktion der Option **-validatecommand** wird während des Handshakes aufgerufen, damit die Anwendung die übergebenen Werte prüft. Die möglichen Argumente des Rückrufskripts stehen unten. Ist keiner angegeben, nimmt OpenSSL alle gültigen Zertifikate und Erweiterungen an. Zum Ablehnen des Wertes und Abbrechen der Verbindung gibt die Rückruffunktion 0 zurück. Zum Annehmen und Fortsetzen gibt er 1 zurück. Zum Ablehnen bei fortgesetzter Verbindung gibt er 2 zurück. Diese Form ist neu in TclTLS 1.8.

**alpn** *channelId protocol match*
: Auf Servern wird diese Form aufgerufen, wenn die ALPN-Erweiterung des Klienten ankommt. Ist *match* wahr, ist *protocol* die erste Option **-alpn**, die Klient und Server gemeinsam haben. Sonst wird das erste vom Klienten angegebene Protokoll verwendet. Diese Form kommt nach den Formen **hello** und **sni**.

**hello** *channelId servername session\_id*
: Auf Servern wird diese Form bei der Verarbeitung der Client-Hello-Nachricht aufgerufen. Der Server kann damit das passende Zertifikat für den Klienten wählen und die Konfiguration zu diesem Servernamen anpassen. Diese Form kommt vor den Formen **sni** und **alpn**.

**sni** *channelId servername*
: Auf Servern wird diese Form aufgerufen, wenn die Erweiterung Server Name Indication (SNI) ankommt. Das Argument *servername* ist der vom Klienten angegebene Servername aus der Option **-servername**. Unterstützt ein Server mehrere Namen, kann so das richtige Zertifikat verwendet werden. Diese Form kommt nach **hello** und vor **alpn**.

**verify** *channelId depth cert status error*
: Diese Form wird von OpenSSL aufgerufen, wenn von der Gegenstelle ein neues Zertifikat ankommt. Der Klient kann das Prüfergebnis ansehen und entscheiden, ob es weitergeht. Die Rückruffunktion läuft für jedes Zertifikat der Kette. Diese Form lag vor TclTLS 1.8 bei **-command**. Die Argumente:

    *depth*
    : Die Tiefe ist die ganzzahlige Tiefe des Zertifikats in der Zertifikatskette. 0 ist das Zertifikat der Gegenstelle, höhere Werte führen hinauf zur Zertifizierungsstelle (CA).

    *cert*
    : Das Argument cert ist eine Liste von Schlüssel-Wert-Paaren, ähnlich der Rückgabe von **tls::status**.

    *status*
    : Das Argument status ist die boolesche Gültigkeit des aktuellen Zertifikats. 0 ist ungültig, 1 ist gültig.

    *error*
    : Das Argument error ist die Fehlermeldung, sofern vorhanden, von **X509\_STORE\_CTX\_get\_error()**.



Referenzumsetzungen dieser Rückruffunktionen stehen in "*tls.tcl*" als **tls::callback**, **tls::password** und **tls::validate\_command**. Das sind nur Beispielumsetzungen. In einem wirklichen Einsatz bekommen die TLS-Kanäle eigene Rückrufskripte über die Optionen **-command**, **-password** und **-validate\_command**.

Sind **-command** und **-validate\_command** nicht angegeben, verarbeitet TclTLS die zugehörigen Bibliotheksrückrufe intern. Ist **-password** nicht angegeben, versucht TclTLS, **tls::password** aufzurufen. Der Unterschied folgt aus der Verträglichkeit mit älteren Umsetzungen.

*Von den Referenzrückrufen* **tls::callback**, **tls::password** und **tls::validate\_command** wird abgeraten. In späteren Ausgaben können sie entfallen.

# Fehlersuche

Für die meisten Fälle der Fehlersuche genügt die Option **-callback**, um den TLS-Handshake und den Fortschritt zu sehen. Wird mehr gebraucht, liefert die Option zur Übersetzungszeit **--enable-debug** einen genauen Ablauf.

Die Protokollierung von TLS-Schlüsseln wird eingeschaltet, indem die Umgebungsvariable **SSLKEYLOGFILE** auf den Namen der Protokolldatei zeigt. Erzeugtes oder empfangenes TLS-Schlüsselmaterial wird dann in diese Datei geschrieben. Netz-Protokollwerkzeuge können die Daten damit entschlüsseln.

Die Variable **tls::debug** steuert die Diagnoseprotokolle der Vorgaben **tls::callback**, **tls::password** und **tls::validate\_command** in "*tls.tcl*" zusätzlich. Die Vorgabe ist 0. Höhere Werte erzeugen mehr Diagnose und zwingen die Prüfmethode in **tls::callback**, das Zertifikat anzunehmen, auch wenn es ungültig ist, sofern **-validatecommand** auf **tls::validate\_command** steht.

*Von der Variablen* **tls::debug** wird abgeraten. In späteren Ausgaben kann sie entfallen.

# Beispiele

Die folgenden Skripte laden mit dem Paket http eine Webseite und eine Datei. Wann zusätzlich **-cadir**, **-cafile** und **-castore** nötig sind, steht unter [Zertifikatsprüfung]. Weitere Beispielskripte liegen im Verzeichnis "*demos*".

Beispiel 1: Eine Webseite laden

```
package require http
package require tls

set url "https://www.tcl.tk/"
http::register https 443 [list ::tls::socket -autoservername 1 -require 1]

# Get URL
set token [http::geturl $url]

# Check for error
if {[http::status $token] ne "ok"} {
    puts [format "Error %s" [http::status $token]]
}

# Save web page to file
set ch [open example.html wb]
puts $ch [http::data $token]
close $ch

# Cleanup
::http::cleanup $token
```

Beispiel 2: Eine Datei laden

```
package require http
package require tls

set url "https://wiki.tcl-lang.org/sitemap.xml"
http::register https 443 [list ::tls::socket -autoservername 1 -require 1]

# Open output file
set filename [file tail $url]
set ch [open $filename wb]

# Get file
set token [::http::geturl $url -blocksize 65536 -channel $ch]

# Check for error
if {[http::status $token] ne "ok"} {
    puts [format "Error %s" [http::status $token]]
}

# Cleanup
close $ch
::http::cleanup $token
```

# Besondere Hinweise

Was dieses Paket kann, hängt stark davon ab, wie die angebundene OpenSSL-Bibliothek konfiguriert und gebaut wurde. Neue Versionen können ältere Protokollversionen ablösen, Ciphers hinzufügen oder entfernen, Vorgaben ändern. Die unterstützten Protokollversionen liefert der Befehl **tls::protocols**.

# Fehlermeldungen

Manche Fehlermeldungen von OpenSSL sind schwer zu lesen. Die Liste nennt die Meldung und ihre Bedeutung.

*handshake failed: certificate verify failed due to "unable to get local issuer certificate"*
: In der CA-Datei oder im Zertifikatsspeicher fehlt mindestens ein Aussteller der geprüften Zertifikate, oder die Zertifikate sind abgelaufen. In der Regel wird eine aktuelle CAcert-Datei gebraucht.

*packet length too long*
: Der Klient hat einen HTTP-Server auf dem Klartext-Port angesprochen, nicht auf dem SSL/TLS-Port.

*unexpected eof while reading*
: Die Gegenstelle hat die Verbindung geschlossen, ohne den Abschlusshinweis "close notify" zu senden. Manche Server beenden die Verbindung nach dem Senden der Datei oder Webseite ohne diese Nachricht. Dann sollten keine Daten fehlen.

*wrong version number*
: Der Klient hat einen Server, der kein HTTP spricht, auf einem Port ohne TLS angesprochen, also im Klartext.


# Kategorie

tls

# Copyright

```
Copyright (c) 1999 Matt Newman
Copyright (c) 2004 Starfish Systems
Copyright (c) 2024 Brian O'Hagan
```
