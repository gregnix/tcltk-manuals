---
CommandName: ripemd160
title: ripemd160
ManualSection: n
Version: 1.0.7
TclPart: tcllib
TclDescription: RIPEMD Message-Digest Algorithm
Links:
 - md4
 - md5
 - ripemd128
 - sha1
Keywords:
 - RIPEMD
 - hashing
 - md4
 - message-digest
 - rfc 1320
 - rfc 1321
 - rfc 2104
 - security
Copyright:
 - Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

ripemd160 – RIPEMD-160-Message-Digest-Algorithmus

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ripemd160]{.lit} [1.0.7]{.optlit}
[::ripemd::ripemd160]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::ripemd::hmac160]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::ripemd::RIPEMD160Init]{.cmd}
[::ripemd::RIPEMD160Update]{.cmd} [token]{.arg} [data]{.arg}
[::ripemd::RIPEMD160Final]{.cmd} [token]{.arg}
[::ripemd::RIPEHMAC160Init]{.cmd} [key]{.arg}
[::ripemd::RIPEHMAC160Update]{.cmd} [token]{.arg} [data]{.arg}
[::ripemd::RIPEHMAC160Final]{.cmd} [token]{.arg}
:::

# Beschreibung

Dieses Paket ist eine Implementierung des RIPEMD-160-Message-Digest-Algorithmus (1) in Tcl. Dieser Algorithmus nimmt eine beliebige Datenmenge entgegen und generiert aus der Eingabe einen 160-Bit-Message-Digest. Der RIPEMD-160-Algorithmus basiert auf dem MD4-Algorithmus (2, 4), wurde jedoch kryptografisch gegen die in MD4 festgestellten Schwachstellen (4) abgesichert.

Dieses Paket nutzt **cryptkit** oder **Trf** zur Beschleunigung der Digest-Berechnung, wenn eines dieser Pakete verfügbar ist. Wenn kein Beschleunigerpaket vorhanden ist, wird die reine Tcl-Implementierung verwendet.

*ACHTUNG* Die Befehle in diesem Paket erwarten Binärdaten als Eingabe. Wird ein **-file** angegeben, wird dies durch die Befehle selbst sichergestellt, da sie die referenzierte Datei im Binärmodus öffnen. Wenn stattdessen Literal-Daten oder ein **-channel** übergeben werden, ist der *Aufrufer des Befehls* dafür verantwortlich, dies sicherzustellen. Der erforderliche Konvertierungsbefehl lautet **encoding convertto utf-8 $string**.

*ACHTUNG*, hier liegt ein *Tcl-9-Kompatibilitätsproblem* vor.

*Tcl 8.x behandelt* nicht-binäre Eingaben stillschweigend falsch, indem es diese intern auf die gewünschte Länge kürzt. Das heißt, indem nur das niedrige Byte eines höheren Unicode-Punkts verwendet wird. Es wird kein Fehler ausgelöst, das *Ergebnis ist einfach falsch*.

*Tcl 9 löst stattdessen einen Fehler aus*, d. h.

```
expected byte sequence but character <location> was ...
```

# Befehle

**::ripemd::ripemd160** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet den RIPEMD-160-Digest der in der Zeichenkette angegebenen Daten. Dieser wird standardmäßig als binäre Zeichenkette zurückgegeben. Bei Angabe der Option *-hex* gibt es eine hexadezimal kodierte Version des Digests zurück.

    Die zu hashenden Daten können entweder als Zeichenfolgenargument des Befehls ripemd160, als Dateiname oder als zuvor geöffneter Kanal angegeben werden. Wenn das Argument *-filename* angegeben wird, wird die Datei geöffnet, die Daten werden gelesen und gehasht, und die Datei wird geschlossen. Wenn das Argument *-channel* angegeben wird, werden Daten aus dem Kanal bis zum Dateiende gelesen. Der Kanal wird nicht geschlossen.

    Es sollte nur eines der Argumente *-file*, *-channel* oder *string* angegeben werden.

**::ripemd::hmac160** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet einen HMAC-Digest (Hashed Message Authentication Digest) unter Verwendung des RIPEMD-160-Digest-Algorithmus. HMACs sind in RFC 2104 (5) beschrieben und liefern einen RIPEMD-160-Digest, der einen Schlüssel enthält. Alle Optionen außer *-key* entsprechen denen des Befehls **::ripemd::ripemd160**.


# Programmierschnittstelle

Für den Programmierer lassen sich Hash-Funktionen als ein Behälter betrachten, in den man Daten einfüllt. Ist die Eingabe abgeschlossen, wird ein Wert extrahiert, der sich eindeutig aus den Daten ableitet, die in den Behälter eingefüllt wurden. Die Programmierschnittstelle zum Hash arbeitet mit einem Token (das dem Behälter entspricht). **RIPEMD160Init** liefert ein Token, **RIPEMD160Update** nimmt so oft wie erforderlich weitere Daten entgegen. **RIPEMD160Final** gibt die Ressourcen frei und liefert den Hash-Wert. Ein entsprechender Funktionssatz liefert Ihnen einen schlüsselbasierten Digest (HMAC).

**::ripemd::RIPEMD160Init**
: Startet einen neuen RIPEMD-160-Hash. Gibt eine Token-ID zurück, die für die verbleibenden Funktionen verwendet werden muss.

**::ripemd::RIPEMD160Update** *token* *data*
: Fügt Daten zu dem durch das Token identifizierten Hash hinzu. Der Aufruf von *RIPEMD160Update $token „abcd“* entspricht dem Aufruf von *RIPEMD160Update $token „ab“*, gefolgt von *RIPEMD160Update $token „cb“*. Siehe [Beispiele].

**::ripemd::RIPEMD160Final** *token*
: Gibt den Hash-Wert zurück und gibt alle von diesem Token belegten Ressourcen frei. Sobald dieser Befehl abgeschlossen ist, verliert das Token seine Gültigkeit. Das Ergebnis ist eine binäre Zeichenkette mit einer Länge von 16 Byte, die den 160-Bit-RIPEMD-160-Wert darstellt.

**::ripemd::RIPEHMAC160Init** *key*
: Dies entspricht dem Befehl **::ripemd::RIPEMD160Init**, mit dem Unterschied, dass hierfür der Schlüssel angegeben werden muss, der in den HMAC einbezogen werden soll.

**::ripemd::RIPEHMAC160Update** *token* *data*
: siehe unten ...

**::ripemd::RIPEHMAC160Final** *token*
: Diese Befehle entsprechen den entsprechenden Befehlen des RIPEMD160.


# Beispiele

```
% ripemd::ripemd160 -hex "Tcl does RIPEMD-160"
0829dea75a1a7074c702896723fe37763481a0a7
```

```
% ripemd::hmac160 -hex -key Sekret "Tcl does RIPEMD-160"
bf0c927231733686731dddb470b64a9c23f7f53b
```

```
% set tok [ripemd::RIPEMD160Init]
::ripemd::1
% ripemd::RIPEMD160Update $tok "Tcl "
% ripemd::RIPEMD160Update $tok "does "
% ripemd::RIPEMD160Update $tok "RIPEMD-160"
% ripemd::Hex [ripemd::RIPEMD160Final $tok]
0829dea75a1a7074c702896723fe37763481a0a7
```

# Literatur

1. H. Dobbertin, A. Bosselaers, B. Preneel, „RIPEMD-160, eine erweiterte Version von RIPEMD“ <http://www.esat.kuleuven.ac.be/~cosicart/pdf/AB-9601/AB-9601.pdf>

2. Rivest, R., „The MD4 Message Digest Algorithm“, RFC 1320, MIT, April 1992. (<http://www.rfc-editor.org/rfc/rfc1320.txt>)

3. Rivest, R., „The MD4 message digest algorithm“, in: A.J. Menezes und S.A. Vanstone (Hrsg.), Advances in Cryptology – CRYPTO '90 Proceedings, Seiten 303–311, Springer-Verlag, 1991.

4. Dobbertin, H., „Kryptoanalyse von MD4“, Journal of Cryptology, Band 11 (4), S. 253–271 (1998)

5. Krawczyk, H., Bellare, M. und Canetti, R. „HMAC: Keyed-Hashing for Message Authentication“, RFC 2104, Februar 1997. (<http://www.rfc-editor.org/rfc/rfc2104.txt>)


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ripemd* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
```
