---
CommandName: md4
title: md4
ManualSection: n
Version: 1.0.8
TclPart: tcllib
TclDescription: MD4 Message-Digest Algorithm
Links:
 - md5
 - sha1
Keywords:
 - hashing
 - md4
 - message-digest
 - rfc 1320
 - rfc 1321
 - rfc 2104
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

md4 – MD4-Message-Digest-Algorithmus

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [md4]{.lit} [1.0.8]{.optlit}
[::md4::md4]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::md4::hmac]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::md4::MD4Init]{.cmd}
[::md4::MD4Update]{.cmd} [token]{.arg} [data]{.arg}
[::md4::MD4Final]{.cmd} [token]{.arg}
[::md4::HMACInit]{.cmd} [key]{.arg}
[::md4::HMACUpdate]{.cmd} [token]{.arg} [data]{.arg}
[::md4::HMACFinal]{.cmd} [token]{.arg}
:::

# Beschreibung

Dieses Paket ist eine Implementierung des MD4-Message-Digest-Algorithmus in Tcl, wie er in RFC 1320 (1) und (2) beschrieben ist. Dieser Algorithmus nimmt eine beliebige Datenmenge entgegen und generiert aus der Eingabe einen 128-Bit-Message-Digest. Der MD4-Algorithmus ist schneller, aber potenziell weniger sicher als der verwandte MD5-Algorithmus (3).

Wenn Sie über **critcl** verfügen und das Paket **tcllibc** erstellt haben, erfolgt die Implementierung der Hash-Funktion durch kompilierten Code. Alternativ wird, wenn **cryptkit** verfügbar ist, dieses verwendet. Kann kein Paket gefunden werden, kommt die reine TCL-Implementierung zum Einsatz. Die Programmierschnittstelle bleibt in allen Fällen unverändert.

*ACHTUNG* Die Befehle in diesem Paket erwarten Binärdaten als Eingabe. Wird ein **-file** angegeben, wird dies durch die Befehle selbst sichergestellt, da sie die referenzierte Datei im Binärmodus öffnen. Wenn stattdessen Literal-Daten oder ein **-channel** übergeben werden, ist der *Aufrufer des Befehls* dafür verantwortlich, dies sicherzustellen. Der erforderliche Konvertierungsbefehl lautet **encoding convertto utf-8 $string**.

*ACHTUNG*, hier liegt ein *Tcl-9-Kompatibilitätsproblem* vor.

*Tcl 8.x behandelt* nicht-binäre Eingaben stillschweigend falsch, indem es diese intern auf die gewünschte Länge kürzt. Das heißt, indem nur das niedrige Byte eines höheren Unicode-Punkts verwendet wird. Es wird kein Fehler ausgelöst, das *Ergebnis ist einfach falsch*.

*Tcl 9 löst stattdessen einen Fehler aus*, d. h.

```
expected byte sequence but character <location> was ...
```

# Befehle

**::md4::md4** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet den MD4-Hash der in der Zeichenkette angegebenen Daten. Dieser wird standardmäßig als Binärzeichenkette zurückgegeben. Bei Angabe der Option *-hex* gibt es eine hexadezimal kodierte Version des Hashs zurück.

    Die zu hashenden Daten können entweder als Zeichenfolgenargument für den Befehl „md4“, als Dateiname oder als zuvor geöffneter Kanal angegeben werden. Wenn das Argument *-filename* angegeben wird, wird die Datei geöffnet, die Daten werden gelesen und gehasht, und die Datei wird geschlossen. Wenn das Argument *-channel* angegeben wird, werden Daten aus dem Kanal bis zum Dateiende gelesen. Der Kanal wird nicht geschlossen.

    Es sollte nur eines der Argumente *-file*, *-channel* oder *string* angegeben werden.

**::md4::hmac** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet einen HMAC-Digest (Hashed Message Authentication Digest) unter Verwendung des MD4-Digest-Algorithmus. HMACs sind in RFC 2104 (4) beschrieben und liefern einen MD4-Digest, der einen Schlüssel enthält. Alle Optionen außer *-key* entsprechen denen des Befehls **::md4::md4**.


# Programmierschnittstelle

Für den Programmierer lässt sich der MD4-Hash als ein Behälter betrachten, in den man Daten einfüllt. Ist die Eingabe abgeschlossen, wird ein Wert extrahiert, der aus den in den Behälter eingefüllten Daten abgeleitet wird. Die Programmierschnittstelle zum MD4-Hash arbeitet mit einem Token (das dem Behälter entspricht). **MD4Init** liefert ein Token, **MD4Update** nimmt so oft wie erforderlich weitere Daten entgegen. **MD4Final** gibt die Ressourcen frei und liefert den Hash-Wert. Ein entsprechender Funktionssatz stellt Ihnen einen schlüsselbasierten Digest (HMAC) zur Verfügung.

**::md4::MD4Init**
: Leitet einen neuen MD4-Hash ein. Gibt eine Token-ID zurück, die für die verbleibenden Funktionen verwendet werden muss.

**::md4::MD4Update** *token* *data*
: Fügt Daten zu dem durch das Token identifizierten Hash hinzu. Der Aufruf von *MD4Update $token „abcd“* entspricht dem Aufruf von *MD4Update $token „ab“*, gefolgt von *MD4Update $token „cb“*. Siehe [Beispiele].

**::md4::MD4Final** *token*
: Gibt den Hash-Wert zurück und gibt alle von diesem Token belegten Ressourcen frei. Sobald dieser Befehl abgeschlossen ist, verliert das Token seine Gültigkeit. Das Ergebnis ist eine binäre Zeichenkette mit einer Länge von 16 Byte, die den 128-Bit-MD4-Digest-Wert darstellt.

**::md4::HMACInit** *key*
: Dies entspricht dem Befehl **::md4::MD4Init**, mit dem Unterschied, dass hierfür der Schlüssel angegeben werden muss, der in den HMAC einbezogen werden soll.

**::md4::HMACUpdate** *token* *data*
: siehe unten ...

**::md4::HMACFinal** *token*
: Diese Befehle entsprechen den entsprechenden MD4-Befehlen.


# Beispiele

```
% md4::md4 -hex "Tcl does MD4"
858da9b31f57648a032230447bd15f25
```

```
% md4::hmac -hex -key Sekret "Tcl does MD4"
c324088e5752872689caedf2a0464758
```

```
% set tok [md4::MD4Init]
::md4::1
% md4::MD4Update $tok "Tcl "
% md4::MD4Update $tok "does "
% md4::MD4Update $tok "MD4"
% md4::Hex [md4::MD4Final $tok]
858da9b31f57648a032230447bd15f25
```

# Literatur

1. Rivest, R., „The MD4 Message Digest Algorithm“, RFC 1320, MIT, April 1992. (<http://www.rfc-editor.org/rfc/rfc1320.txt>)

2. Rivest, R., „The MD4 message digest algorithm“, in: A.J. Menezes und S.A. Vanstone (Hrsg.), Advances in Cryptology – CRYPTO '90 Proceedings, Seiten 303–311, Springer-Verlag, 1991.

3. Rivest, R., „The MD5 Message-Digest Algorithm“, RFC 1321, MIT und RSA Data Security, Inc., April 1992. (<http://www.rfc-editor.org/rfc/rfc1321.txt>)

4. Krawczyk, H., Bellare, M. und Canetti, R. „HMAC: Keyed-Hashing for Message Authentication“, RFC 2104, Februar 1997. (<http://www.rfc-editor.org/rfc/rfc2104.txt>)


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *md4* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hashwerte, Prüfsummen und Verschlüsselung

# Copyright

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
