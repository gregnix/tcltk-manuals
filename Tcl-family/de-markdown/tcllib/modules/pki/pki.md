---
CommandName: pki
title: pki
ManualSection: n
Version: 0.22
TclPart: tcllib
TclDescription: public key encryption
Links:
 - aes(n)
 - blowfish(n)
 - des(n)
 - md5(n)
 - sha1(n)
Keywords:
 - cipher
 - data integrity
 - encryption
 - public key cipher
 - rsa
 - security
Copyright:
 - Copyright (c) 2010, 2011, 2012, 2013, 2021 - 2024 Roy Keene, Andreas Kupries, Ashok P. Nadkarni
---

# Name

pki – Implementierung der Public-Key-Verschlüsselung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pki]{.lit} [0.22]{.optlit}
[::pki::encrypt]{.cmd} [-binary]{.optarg} [-hex]{.optarg} [-pad]{.optarg} [-nopad]{.optarg} [-priv]{.optarg} [-pub]{.optarg} [--]{.optarg} [input]{.arg} [key]{.arg}
[::pki::decrypt]{.cmd} [-binary]{.optarg} [-hex]{.optarg} [-unpad]{.optarg} [-nounpad]{.optarg} [-priv]{.optarg} [-pub]{.optarg} [--]{.optarg} [input]{.arg} [key]{.arg}
[::pki::sign]{.cmd} [input]{.arg} [key]{.arg} [algo]{.optarg}
[::pki::verify]{.cmd} [signedmessage]{.arg} [plaintext]{.arg} [key]{.arg} [algo]{.optarg}
[::pki::key]{.cmd} [key]{.arg} [password]{.optarg} [encodePem]{.optarg}
[::pki::pkcs::parse\_key]{.cmd} [key]{.arg} [password]{.optarg}
[::pki::x509::parse\_cert]{.cmd} [cert]{.arg}
[::pki::rsa::generate]{.cmd} [bitlength]{.arg} [exponent]{.optarg}
[::pki::x509::verify\_cert]{.cmd} [cert]{.arg} [trustedcerts]{.arg} [intermediatecerts]{.optarg}
[::pki::x509::validate\_cert]{.cmd} [cert]{.arg} [[-sign\_message]{.lit} [dn\_of\_signer]{.arg}]{.optarg} [[-encrypt\_message]{.lit} [dn\_of\_signer]{.arg}]{.optarg} [[-sign\_cert]{.lit} [dn\_to\_be\_signed]{.arg} [ca\_depth]{.arg}]{.optarg} [[-ssl]{.lit} [dn]{.arg}]{.optarg}
[::pki::pkcs::create\_csr]{.cmd} [keylist]{.arg} [namelist]{.arg} [encodePem]{.optarg} [algo]{.optarg}
[::pki::pkcs::parse\_csr]{.cmd} [csr]{.arg}
[::pki::x509::create\_cert]{.cmd} [signreqlist]{.arg} [cakeylist]{.arg} [serial\_number]{.arg} [notBefore]{.arg} [notAfter]{.arg} [isCA]{.arg} [extensions]{.arg} [encodePem]{.optarg} [algo]{.optarg}
:::

# Beschreibung

# Befehle

**::pki::encrypt** ?*-binary*? ?*-hex*? ?*-pad*? ?*-nopad*? ?*-priv*? ?*-pub*? ?*--*? *input* *key*
: Verschlüsselt eine Nachricht mithilfe von PKI (voraussichtlich RSA).

    Der Aufrufer muss entweder „**-priv**“ für die Verschlüsselung mit dem privaten Schlüssel oder „**-pub**“ für die Verschlüsselung mit dem öffentlichen Schlüssel festlegen.  Die Standardoption sieht ein Padding und die Rückgabe im Hexadezimalformat vor. Es muss entweder „**-pub**“ oder „**-priv**“ festgelegt werden.

    Die Option „**-hex**“ bewirkt, dass die Daten als hexadezimale Zeichenkette mit Kodierung zurückgegeben werden, während die Option „**-binary**“ bewirkt, dass die Daten als binäre Zeichenkette mit Kodierung zurückgegeben werden.  Wenn diese Optionen mehrfach gelegt werden, wird die zuletzt gelegte Option verwendet.

    Die Option **-pad** bewirkt, dass die Daten vor der Verschlüsselung gemäß PKCS#1 mit Padding aufgefüllt werden. Die Option **-nopad** unterbindet dieses Verhalten. Wenn diese Optionen mehrfach festgelegt werden, wird die zuletzt festgelegte Option verwendet.

    Die zu verschlüsselnde Eingabe wird als *input* festgelegt.

    Der Parameter *key*, der den zu verwendenden Schlüssel enthält, ist ein Wert, der von entweder **::pki::pkcs::parse\_key**, **::pki::x509::parse\_cert** oder **::pki::rsa::generate** gegeben wird.

    Zuordnung zur OpenSSL-Anwendung **openssl**:

    1. "openssl rsautl -encrypt" == "::pki::encrypt -binary -pub"

    2. "openssl rsautl -sign"    == "::pki::encrypt -binary -priv"


**::pki::decrypt** ?*-binary*? ?*-hex*? ?*-unpad*? ?*-nounpad*? ?*-priv*? ?*-pub*? ?*--*? *input* *key*
: Entschlüsselt eine Nachricht mithilfe von PKI (wahrscheinlich RSA). Informationen zur Einstellung der Optionen finden Sie unter **::pki::encrypt**.

    Zuordnung zur OpenSSL-Anwendung **openssl**:

    1. "openssl rsautl -decrypt" == "::pki::decrypt -binary -priv"

    2. "openssl rsautl -verify"  == "::pki::decrypt -binary -pub"


**::pki::sign** *input* *key* ?*algo*?
: Signiert die Nachricht *input* digital mit dem privaten *key*.

    Wenn *algo* weggelassen wird, wird „sha1“ angenommen. Mögliche Werte für *algo* sind „**md5**“, „**sha1**“, „**sha256**“ und „**raw**“. Die Angabe von „**raw**“ für *algo* verhindert die Erstellung einer ASN.1-Struktur für die Kodierung des gewählten Hash-Algorithmus. *Achtung*: In diesem Fall muss der entsprechende **pkgi::verify** als Algorithmusinformation **with** aufgerufen werden. Umgekehrt legt die Angabe eines anderen Algorithmus als „**raw**“ an dieser Stelle fest, dass der entsprechende Aufruf von **pkgi::verify** *ohne* Algorithmusangabe erfolgen muss.

    Die *Eingabe* sollte der Klartext sein, auf den die Hash-Berechnung angewendet wird.

    Der *key* sollte den privaten Schlüssel enthalten.

**::pki::verify** *signedmessage* *plaintext* *key* ?*algo*?
: Überprüfen einer digitalen Signatur mithilfe eines öffentlichen *key*. Gibt „true“ oder „false“ zurück.

    *Achtung*: Die Algorithmusinformation *algo* muss genau dann festgelegt werden, wenn die Funktion **pki::sign**, die die *signedmessage* erzeugt hat, mit dem Algorithmus „**raw**“ aufgerufen wurde. Dadurch wurde die Erstellung der ASN.1-Struktur, die die Kodierung des gewählten Hash-Algorithmus enthält, verhindert. Umgekehrt dürfen Sie hier *keinen* Algorithmus angeben, wenn bei der Signierung bereits ein geeigneter Algorithmus festgelegt wurde.

**::pki::key** *key* ?*password*? ?*encodePem*?
: Konvertiert eine Schlüsselstruktur in einen serialisierten, für andere Anwendungen geeigneten privaten Schlüssel mit der PEM- (Standard) oder DER-Kodierung. Bei RSA-Schlüsseln bedeutet dies PKCS#1.

**::pki::pkcs::parse\_key** *key* ?*password*?
: Konvertiert einen privaten *key* im PKCS#1-Format in einen verwendbaren Schlüssel, d. h. einen Schlüssel, der als Argument für **::pki::encrypt**, **::pki::decrypt**, **::pki::sign** und **::pki::verify** verwendet werden kann.

**::pki::x509::parse\_cert** *cert*
: Konvertiert ein X.509-Zertifikat in einen verwendbaren (öffentlichen) Schlüssel. Das zurückgegebene Dictionary kann als Argument für **::pki:encrypt**, **::pki::decrypt** und **::pki::verify** verwendet werden. Das Argument *cert* kann entweder mit PEM- oder DER-Kodierung kodiert sein. Zusätzlich zu den Informationen zum öffentlichen Schlüssel enthält das Dictionary die folgenden Schlüssel mit Zertifikatsinhalten, wie in [RFC5280](https://www.rfc-editor.org/rfc/rfc5280#section-4.1) definiert:

    - **subject** enthält den Namen des Zertifikatsinhabers.

    - **issuer** enthält den Namen der ausstellenden Zertifizierungsstelle.

    - „**serial\_number**“ enthält die Seriennummer des Zertifikats.

    - In „**notBefore**“ ist das Startdatum der Gültigkeitsdauer des Zertifikats hinterlegt.

    - In „**notAfter**“ ist das Ablaufdatum der Zertifikatsgültigkeit hinterlegt.

    - **version** liegt im X.509-Format vor.

    - **extensions** enthält ein Dictionary mit den im Zertifikat enthaltenen Erweiterungen (siehe unten).


    Das Wörterbuch enthält zusätzliche Einträge zum Thema Verschlüsselung. Diese sind für die Verwendung der oben genannten Befehle für kryptografische Operationen vorgesehen.

    Der Schlüssel „**extensions**“ im zurückgegebenen Wörterbuch enthält ein verschachteltes Dictionary, dessen Schlüssel den Namen (mit genau derselben Groß-/Kleinschreibung) in [Certificate Extensions](https://www.rfc-editor.org/rfc/rfc5280#section-4.2) in RFC 5280. Das Format jedes Werts basiert ebenfalls auf den dort definierten ASN.1-Strukturen. Eine Veranschaulichung finden Sie im Abschnitt *Beispiele* \[#section3\].

**::pki::rsa::generate** *bitlength* ?*exponent*?
: Erzeugt ein neues RSA-Schlüsselpaar, dessen Bestandteile als Argumente für **::pki::encrypt**, **::pki::decrypt**, **::pki::sign** und **::pki::verify** verwendet werden können.

    Das Argument *bitlength* gibt die Länge des Moduls des öffentlichen Schlüssels an.

    Das Argument *exponent* sollte im Allgemeinen nicht angegeben werden, es sei denn, Sie wissen genau, was Sie tun.

**::pki::x509::verify\_cert** *cert* *trustedcerts* ?*intermediatecerts*?
: Prüft, ob eine Vertrauensbeziehung zwischen dem im Argument *cert* angegebenen Zertifikat und einem der in der Zertifikatsliste des Arguments *trustedcerts* aufgeführten Zertifikate besteht.  (Gegebenenfalls kann die Kette über nicht vertrauenswürdige Zertifikate verlaufen, die im Argument *intermediatecerts* aufgeführt sind; dies ist jedoch derzeit noch nicht implementiert.) Die in den Optionen *cert* und *trustedcerts* angegebenen Zertifikate sollten geparst werden (aus **::pki::x509::parse\_cert**).

**::pki::x509::validate\_cert** *cert* ?**-sign\_message** *dn\_of\_signer*? ?**-encrypt\_message** *dn\_of\_signer*? ?**-sign\_cert** *dn\_to\_be\_signed* *ca\_depth*? ?**-ssl** *dn*?
: Prüft, ob ein Zertifikat für eine bestimmte Verwendung gültig ist. Wenn mehrere Optionen festgelegt werden, müssen alle erfüllt sein, damit diese Prozedur den Wert „true“ zurückgibt.

    Derzeit ist nur die Option **-sign\_cert** funktionsfähig. Die Argumente lauten *dn\_to\_be\_signed* und *ca\_depth*.  *dn\_to\_be\_signed* ist der Distinguished Name des Zertifikatsinhabers, um zu überprüfen, ob das im Argument *cert* angegebene Zertifikat signieren darf.  Das Argument *ca\_depth* dient dazu anzugeben, in welcher Tiefe die Überprüfung erfolgen soll. Bei einigen Zertifikaten ist begrenzt, wie weit in der Kette hinab sie zur Überprüfung eines bestimmten Zertifikats verwendet werden können.

**::pki::pkcs::create\_csr** *keylist* *namelist* ?*encodePem*? ?*algo*?
: Erstellt eine Zertifikatssignierungsanforderung (CSR) anhand eines Schlüsselpaars, das im Argument *keylist* angegeben ist.

    Das Argument *namelist* ist eine Liste aus „Name“- und „Wert“-Paaren, die als angeforderter Distinguished Name in der CSR durch die Kodierung dargestellt werden sollen.

    Die Option *encodePem* legt fest, ob das Ergebnis im PEM- oder im DER-Format kodiert werden soll. Der Wert „true“ bewirkt, dass das Ergebnis im PEM-Format kodiert wird, während jeder andere Wert dazu führt, dass das Ergebnis im DER-Format kodiert wird. Die DER-Kodierung ist die Standardeinstellung.

    Das Argument *algo* legt den Hash-Algorithmus fest, den wir zum Signieren dieser Zertifikatssignierungsanforderung verwenden sollen. Die Standardeinstellung ist „sha1“. Weitere mögliche Werte sind „md5“ und „sha256“.

**::pki::pkcs::parse\_csr** *csr*
: Ein Zertifikatssignierungsersuchen analysieren. Das Argument *csr* kann entweder in der PEM- oder DER-Kodierung vorliegen. Der Befehl gibt ein Dictionary zurück, das die folgenden Schlüssel enthält:

    - **subject** – enthält den Namen des Subjekts aus dem CSR.

    - **type** – enthält den Namen des Algorithmus für den öffentlichen Schlüssel. Derzeit wird ausschließlich **rsa** unterstützt.

    - **extensionRequest** – enthält ein Dictionary mit den Inhalten der **extensionRequest** <HTTPS://datatracker.ietf.org/doc/html/rfc2986#page-5>-Informationen im CSR. Dieses hat dieselbe Form wie das für das **extensions**-Dictionary in der Dokumentation zu **parse\_cert** beschriebene.


    Möglicherweise sind im Dictionary weitere Schlüssel enthalten, die mit dem verwendeten Algorithmus für öffentliche Schlüssel in Zusammenhang stehen.

**::pki::x509::create\_cert** *signreqlist* *cakeylist* *serial\_number* *notBefore* *notAfter* *isCA* *extensions* ?*encodePem*? ?*algo*?
: Unterzeichnet eine Signaturanforderung (in der Regel von **::pki::pkcs::create\_csr** oder **::pki::pkcs::parse\_csr**) mit einem Zertifikat einer Zertifizierungsstelle (CA).

    Das Argument *signreqlist* sollte die geparste Signaturanforderung sein.

    Das Argument *cakeylist* sollte das geparste CA-Zertifikat sein.

    Das Argument *serial\_number* sollte eine für dieses Zertifikat von dieser Zertifizierungsstelle eindeutige Seriennummer sein.

    Die Argumente *notBefore* und *notAfter* sollten den Zeitpunkt vor bzw. nach dem das Zertifikat als ungültig gelten soll, enthalten.  Die Zeitangabe sollte durch eine Kodierung in einem Format dargestellt werden, das von **clock format** akzeptiert wird (d. h. die Ergebnisse von **clock seconds** und **clock add**).

    Das Argument *isCA* ist ein boolesches Argument, das angibt, ob es sich bei dem signierten Zertifikat um ein CA-Zertifikat handeln soll oder nicht.  Wenn der Wert „true“ angegeben wird, wird die Erweiterung „id-ce-basicConstraints“ hinzugefügt, wobei die Argumente „critical“ auf „true“, „allowCA“ auf „true“ und „caDepth“ auf -1 (unendlich) gesetzt sind.

    Das Argument *extensions* ist eine Liste von Erweiterungen und deren Parametern, die für die Kodierung des erstellten Zertifikats verwendet werden sollen. Derzeit wird nur eine Erweiterung unterstützt („id-ce-basicConstraints“). Sie akzeptiert drei Argumente: *critical*, *allowCA* und *caDepth*.  Das Argument *critical* dieser Erweiterung (und jeder anderen Erweiterung) legt fest, ob der Validator das Zertifikat als ungültig zurückweisen soll, wenn er die Erweiterung nicht versteht (bei der Einstellung „true“), oder ob er die Erweiterung ignorieren soll (bei der Einstellung „false“).  Das Argument *allowCA* dient dazu, als boolescher Wert festzulegen, ob wir als Zertifizierungsstelle (CA) verwendet werden dürfen oder nicht.  Das Argument *caDepth* gibt an, wie viele untergeordnete Zertifizierungsstellen in der Hierarchie unter dieser Zertifizierungsstelle liegen dürfen. Ein Wert von „0“ für das Argument *caDepth* bedeutet, dass diese Zertifizierungsstelle kein CA-Zertifikat signieren kann, ohne dass das Ergebnis ungültig wird. Ein Wert von „-1“ bedeutet unbegrenzte Tiefe.


# Beispiele

Im folgenden Beispiel wird mithilfe der TLS-Erweiterung ein Zertifikat von *www.example.com* abgerufen und dessen Inhalt ausgegeben.

```
    % set so [tls::socket www.example.com 443]
    sock00000229EB84E710
    % tls::handshake $so
    1
    % set status [tls::status $so]
    ...output not shown...
    % set cert_pem [dict get $status certificate]
    ...output not shown...
    % set cert [::pki::x509::parse_cert $cert_pem]
    ...output not shown...
    % dict get $cert subject
    C=US, ST=California, L=Los Angeles, O=Internet Corporation for Assigned Names and Numbers, CN=www.example.org
    % dict get $cert issuer
    C=US, O=DigiCert Inc, CN=DigiCert TLS RSA SHA256 2020 CA1
    % clock format [dict get $cert notAfter]
    Sun Dec 26 05:29:59 +0530 2021
    % set extensions [dict get $cert extensions]
    ...output not shown...
    % dict keys $extensions
    authorityKeyIdentifier subjectKeyIdentifier subjectAltName keyUsage extKeyUsage cRLDistributionPoints certificatePolicies authorityInfoAccess id-ce-basicConstraints basicConstraints 1.3.6.1.4.1.11129.2.4.2
    dict get $extensions basicConstraints
    1 {0 -1}
    % dict get $extensions keyUsage
    1 {5 digitalSignature keyEncipherment}
    % dict get $extensions extKeyUsage
    0 {serverAuth clientAuth}
    % dict get $extensions subjectAltName
    0 {dNSName www.example.org dNSName example.com dNSName example.edu dNSName example.net dNSName example.org dNSName www.example.com dNSName www.example.edu dNSName www.example.net}
    % dict get $extensions basicConstraints
    1 {0 -1}
    % dict get $extensions keyUsage
    1 {5 digitalSignature keyEncipherment}
    % dict get $extensions extKeyUsage
    0 {serverAuth clientAuth}
```

# Literatur

1. [Profil für X.509-Zertifikate und Zertifikatssperrlisten (CRL) im Rahmen der öffentlichen Schlüsselinfrastruktur im Internet](https://www.rfc-editor.org/rfc/rfc5280)

2. [Neue ASN.1-Module für die Public-Key-Infrastruktur unter Verwendung von X.509 (PKIX)](https://www.rfc-editor.org/rfc/rfc5912)

3. [PKCS #10: Spezifikation der Syntax für Zertifikatsanfragen](https://www.rfc-editor.org/rfc/rfc2986)


# Autoren

Roy Keene, Ashok P. Nadkarni

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *rsa* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2010, 2011, 2012, 2013, 2021 - 2024 Roy Keene, Andreas Kupries, Ashok P. Nadkarni
```
