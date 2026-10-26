---
CommandName: otp
title: otp
ManualSection: n
Version: 1.1.0
TclPart: tcllib
TclDescription: RFC 2289 A One-Time Password System
Links:
 - SASL
 - md4
 - md5
 - ripemd160
 - sha1
Keywords:
 - hashing
 - message-digest
 - password
 - rfc 2289
 - security
Copyright:
 - Copyright (c) 2006, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

otp – Einmalpasswörter

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [otp]{.lit} [1.1.0]{.optlit}
[::otp::otp-md4]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg}
[::otp::otp-md5]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg}
[::otp::otp-sha1]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg}
[::otp::otp-rmd160]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg}
:::

# Beschreibung

Dieses Paket ist eine Implementierung des in RFC 2289 (1) beschriebenen Einmalpasswort-Systems in Tcl. Dieses System verwendet Message-Digest-Algorithmen, um eine Passphrase schrittweise zu hashen und so Einmalpasswörter zu erzeugen. Die resultierenden Daten werden dem Benutzer dann entweder als Hexadezimalziffern oder – durch Kodierung mit einem Dictionary mit 2048 Wörtern – bereitgestellt. Dieses System wird von OpenBSD für die Sicherheit der Anmeldung verwendet und kann als SASL-Mechanismus zur Authentifizierung von Benutzern eingesetzt werden.

In dieser Implementierung bieten wir Unterstützung für vier Algorithmen, die in der tcllib-Distribution enthalten sind: MD5 (2), MD4 (3), RIPE-MD160 (4) und SHA-1 (5).

# Befehle

- **::otp::otp-md4** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*
- **::otp::otp-md5** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*
- **::otp::otp-sha1** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*
- **::otp::otp-rmd160** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*


# Beispiele

```
% otp::otp-md5 -count 99 -seed host67821 "My Secret Pass Phrase"
(binary gibberish)
% otp::otp-md5 -words -count 99 -seed host67821 "My Secret Pass Phrase"
SOON ARAB BURG LIMB FILE WAD
% otp::otp-md5 -hex -count 99 -seed host67821 "My Secret Pass Phrase"
e249b58257c80087
```

# Literatur

1. Haller, N. et al., „A One-Time Password System“, RFC 2289, Februar 1998. <http://www.rfc-editor.org/rfc/rfc2289.txt>

2. Rivest, R., „The MD5 Message-Digest Algorithm“, RFC 1321, MIT und RSA Data Security, Inc., April 1992. (<http://www.rfc-editor.org/rfc/rfc1321.txt>)

3. Rivest, R., „The MD4 Message Digest Algorithm“, RFC 1320, MIT, April 1992. (<http://www.rfc-editor.org/rfc/rfc1320.txt>)

4. H. Dobbertin, A. Bosselaers, B. Preneel, „RIPEMD-160, eine erweiterte Version von RIPEMD“ <http://www.esat.kuleuven.ac.be/~cosicart/pdf/AB-9601/AB-9601.pdf>

5. „Secure Hash Standard“, National Institute of Standards and Technology, US-Handelsministerium, April 1995. (<http://www.itl.nist.gov/fipspubs/fip180-1.htm>)


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *otp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2006, Pat Thoyts <patthoyts@users.sourceforge.net>
```
