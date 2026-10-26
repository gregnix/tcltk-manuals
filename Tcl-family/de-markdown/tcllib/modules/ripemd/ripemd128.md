---
CommandName: ripemd128
title: ripemd128
ManualSection: n
Version: 1.0.6
TclPart: tcllib
TclDescription: RIPEMD Message-Digest Algorithm
Links:
 - md4
 - md5
 - ripemd160
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

ripemd128 – RIPEMD-128-Message-Digest-Algorithmus

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ripemd128]{.lit} [1.0.6]{.optlit}
[::ripemd::ripemd128]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::ripemd::hmac128]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::ripemd::RIPEMD128Init]{.cmd}
[::ripemd::RIPEMD128Update]{.cmd} [token]{.arg} [data]{.arg}
[::ripemd::RIPEMD128Final]{.cmd} [token]{.arg}
[::ripemd::RIPEHMAC128Init]{.cmd} [key]{.arg}
[::ripemd::RIPEHMAC128Update]{.cmd} [token]{.arg} [data]{.arg}
[::ripemd::RIPEHMAC128Final]{.cmd} [token]{.arg}
:::

# Beschreibung

Dieses Paket ist eine Implementierung des RIPEMD-128-Message-Digest-Algorithmus (1) in Tcl. Dieser Algorithmus nimmt eine beliebige Datenmenge entgegen und generiert aus der Eingabe einen 128-Bit-Message-Digest. Der RIPEMD-128-Algorithmus basiert auf dem MD4-Algorithmus (2, 4), wurde jedoch kryptografisch gegen die in MD4 festgestellten Schwachstellen abgesichert (4). RIPEMD-128 wurde als direkter Ersatz für MD4 und MD5 konzipiert (5). Wenn Sicherheit im Vordergrund steht, sollten RIPEMD-160 oder SHA-1 in Betracht gezogen werden.

Dieses Paket nutzt **Trf** zur Beschleunigung der Digest-Berechnung, wenn dieses verfügbar ist. Ist kein Beschleunigerpaket vorhanden, wird die reine Tcl-Implementierung verwendet.

*ACHTUNG* Die Befehle in diesem Paket erwarten Binärdaten als Eingabe. Wird ein **-file** angegeben, wird dies durch die Befehle selbst sichergestellt, da sie die referenzierte Datei im Binärmodus öffnen. Wenn stattdessen Literal-Daten oder ein **-channel** übergeben werden, ist der *Aufrufer des Befehls* dafür verantwortlich, dies sicherzustellen. Der erforderliche Konvertierungsbefehl lautet **encoding convertto utf-8 $string**.

*ACHTUNG*, hier liegt ein *Tcl-9-Kompatibilitätsproblem* vor.

*Tcl 8.x behandelt* nicht-binäre Eingaben stillschweigend falsch, indem es diese intern auf die gewünschte Länge kürzt. Das heißt, indem nur das niedrige Byte eines höheren Unicode-Punkts verwendet wird. Es wird kein Fehler ausgelöst, das *Ergebnis ist einfach falsch*.

*Tcl 9 löst stattdessen einen Fehler aus*, d. h.

```
expected byte sequence but character <location> was ...
```

# Befehle

**::ripemd::ripemd128** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet den RIPEMD-128-Digest der in der Zeichenkette angegebenen Daten. Dieser wird standardmäßig als Binärzeichenkette zurückgegeben. Bei Angabe der Option *-hex* gibt es eine hexadezimal kodierte Version des Digests zurück.

    Die zu hashenden Daten können entweder als Zeichenfolgenargument für den Befehl ripemd128, als Dateiname oder als zuvor geöffneter Kanal angegeben werden. Wenn das Argument *-filename* angegeben wird, wird die Datei geöffnet, die Daten werden gelesen und gehasht, und die Datei wird geschlossen. Wenn das Argument *-channel* angegeben wird, werden Daten aus dem Kanal bis zum Dateiende gelesen. Der Kanal wird nicht geschlossen.

    Es sollte nur eines der Argumente *-file*, *-channel* oder *string* angegeben werden.

**::ripemd::hmac128** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet einen HMAC-Digest (Hashed Message Authentication Digest) unter Verwendung des RIPEMD-128-Digest-Algorithmus. HMACs sind in RFC 2104 (6) beschrieben und liefern einen RIPEMD-128-Digest, der einen Schlüssel enthält. Alle Optionen außer *-key* entsprechen denen des Befehls **::ripemd::ripemd128**.


# Programmierschnittstelle

Für den Programmierer lassen sich Hash-Funktionen als ein Behälter betrachten, in den man Daten einfüllt. Ist die Eingabe abgeschlossen, wird ein Wert extrahiert, der sich eindeutig aus den Daten ableitet, die in den Behälter eingefüllt wurden. Die Programmierschnittstelle zum Hash arbeitet mit einem Token (das dem Behälter entspricht). **RIPEMD128Init** liefert ein Token, **RIPEMD128Update** nimmt so oft wie erforderlich weitere Daten entgegen. **RIPEMD128Final** gibt die Ressourcen frei und liefert den Hash-Wert. Ein entsprechender Funktionssatz liefert Ihnen einen schlüsselbasierten Digest (HMAC).

Wenn Sie über **critcl** verfügen und das Paket **tcllibc** erstellt haben, erfolgt die Implementierung der Hash-Funktion durch kompilierten Code. Sind hingegen sowohl die Trf- als auch die Memchan-Erweiterung verfügbar, werden diese verwendet. Andernfalls greift das Paket auf eine reine Tcl-Implementierung zurück. Die Programmierschnittstelle bleibt jedoch unverändert.

**::ripemd::RIPEMD128Init**
: Erzeugt einen neuen RIPEMD-128-Hash. Gibt eine Token-ID zurück, die für die verbleibenden Funktionen verwendet werden muss.

**::ripemd::RIPEMD128Update** *token* *data*
: Fügt Daten zu dem durch das Token identifizierten Hash hinzu. Der Aufruf von *RIPEMD128Update $token „abcd“* entspricht dem Aufruf von *RIPEMD128Update $token „ab“*, gefolgt von *RIPEMD128Update $token „cb“*. Siehe [Beispiele].

**::ripemd::RIPEMD128Final** *token*
: Gibt den Hash-Wert zurück und gibt alle von diesem Token belegten Ressourcen frei. Sobald dieser Befehl abgeschlossen ist, verliert das Token seine Gültigkeit. Das Ergebnis ist eine binäre Zeichenkette mit einer Länge von 16 Byte, die den 128-Bit-RIPEMD-128-Wert darstellt.

**::ripemd::RIPEHMAC128Init** *key*
: Dies entspricht dem Befehl **::ripemd::RIPEMD128Init**, mit dem Unterschied, dass hierfür der Schlüssel angegeben werden muss, der in den HMAC einbezogen werden soll.

**::ripemd::RIPEHMAC128Update** *token* *data*
: siehe unten ...

**::ripemd::RIPEHMAC128Final** *token*
: Diese Befehle entsprechen den entsprechenden Befehlen des RIPEMD128.


# Beispiele

```
% ripemd::ripemd128 -hex "Tcl does RIPEMD-128"
3cab177bae65205d81e7978f63556c63
```

```
% ripemd::hmac128 -hex -key Sekret "Tcl does RIPEMD-128"
b359dc5971a05beea0be7b106b30e389
```

```
% set tok [ripemd::RIPEMD128Init]
::ripemd::1
% ripemd::RIPEMD128Update $tok "Tcl "
% ripemd::RIPEMD128Update $tok "does "
% ripemd::RIPEMD128Update $tok "RIPEMD-128"
% ripemd::Hex [ripemd::RIPEMD128Final $tok]
3cab177bae65205d81e7978f63556c63
```

# Literatur

1. H. Dobbertin, A. Bosselaers, B. Preneel, „RIPEMD-160, eine erweiterte Version von RIPEMD“ <http://www.esat.kuleuven.ac.be/~cosicart/pdf/AB-9601/AB-9601.pdf>

2. Rivest, R., „The MD4 Message Digest Algorithm“, RFC 1320, MIT, April 1992. (<http://www.rfc-editor.org/rfc/rfc1320.txt>)

3. Rivest, R., „The MD4 message digest algorithm“, in: A.J. Menezes und S.A. Vanstone (Hrsg.), Advances in Cryptology – CRYPTO '90 Proceedings, Seiten 303–311, Springer-Verlag, 1991.

4. Dobbertin, H., „Kryptoanalyse von MD4“, Journal of Cryptology, Band 11 (4), S. 253–271 (1998)

5. Rivest, R., „The MD5 Message-Digest Algorithm“, RFC 1321, MIT und RSA Data Security, Inc., April 1992. (<http://www.rfc-editor.org/rfc/rfc1321.txt>)

6. Krawczyk, H., Bellare, M. und Canetti, R. „HMAC: Keyed-Hashing for Message Authentication“, RFC 2104, Februar 1997. (<http://www.rfc-editor.org/rfc/rfc2104.txt>)


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
