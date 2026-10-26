---
CommandName: sha1
ManualSection: n
Version: 2.0.5
TclPart: tcllib
TclDescription: SHA-x Message-Digest Algorithm
Links:
 - md4
 - md5
 - ripemd128
 - ripemd160
Keywords:
 - FIPS 180-1
 - hashing
 - message-digest
 - rfc 2104
 - security
 - sha1
Copyright:
 - Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# NAME

sha1 – SHA1-Message-Digest-Algorithmus

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [sha1]{.lit} [2.0.5]{.optlit} 
[::sha1::sha1]{.cmd} [-hex|-bin]{.optlit} \[ [-channel]{.lit} [channel]{.lit} | [-file]{.lit} [filename]{.lit} | [--]{.optlit} [string]{.arg} \] 
[::sha1::hmac]{.cmd} [key]{.arg} [string]{.arg} 
[::sha1::hmac]{.cmd} [-hex|-bin]{.optlit} [-key]{.lit} [key]{.lit} \[ [-channel]{.lit} [channel]{.lit} | [-file]{.lit} [filename]{.lit} | [--]{.optlit} [string]{.arg} \] 
[::sha1::SHA1Init]{.cmd} 
[::sha1::SHA1Update]{.cmd} [token]{.arg} [data]{.arg} 
[::sha1::SHA1Final]{.cmd} [token]{.arg} 
[::sha1::HMACInit]{.cmd} [key]{.arg} 
[::sha1::HMACUpdate]{.cmd} [token]{.arg} [data]{.arg} 
[::sha1::HMACFinal]{.cmd} [token]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine Implementierung des SHA1-Message-Digest-Algorithmus in Tcl gemäß der Spezifikation in FIPS PUB 180-1 (1). Dieser Algorithmus nimmt eine Nachricht entgegen und generiert aus der Eingabe einen 160-Bit-Digest. Der SHA1-Algorithmus ist mit dem MD4-Algorithmus (2) verwandt, wurde jedoch hinsichtlich der Widerstandsfähigkeit gegen bestimmte Arten von kryptografischen Angriffen verbessert. In neuen Anwendungen sollte SHA1 gegenüber MD4 oder MD5 bevorzugt werden.

Dieses Paket enthält außerdem Unterstützung für die Erstellung verschlüsselter Nachrichten-Digests unter Verwendung des HMAC-Algorithmus aus RFC 2104 (3) mit SHA-1 als Nachrichten-Digest.

*Achtung* Die Befehle in diesem Paket erwarten Binärdaten als Eingabe. Wenn ein **-file** angegeben wird, wird dies von den Befehlen selbst sichergestellt, da sie die referenzierte Datei im Binärmodus öffnen. Wenn stattdessen Literal-Daten oder ein **-channel** übergeben werden, ist der *Aufrufer des Befehls* dafür verantwortlich, dies sicherzustellen. Die erforderliche Kodierung des Konvertierungsbefehls lautet **encoding convertto utf-8 \$string**.

*Achtung*, hier liegt ein *Tcl-9-Kompatibilitätsproblem* vor.

*Tcl 8.x behandelt* nicht-binäre Eingaben stillschweigend falsch, indem es diese intern auf die gewünschte Länge kürzt. Das heißt, indem nur das niedrige Byte eines höheren Unicode-Punkts verwendet wird. Es wird kein Fehler ausgelöst, das *Ergebnis ist einfach falsch*.

*Tcl 9 löst stattdessen einen Fehler aus*, d. h.

```
expected byte sequence but character <location> was ...
```

# BEFEHLE

**::sha1::sha1** ?**-hex|-bin**? \[ **-channel channel** | **-file filename** | ?**--**? *string* \]
: Der Befehl nimmt eine Nachricht entgegen und gibt den SHA1-Hash dieser Nachricht als hexadezimale Zeichenkette zurück. Sie können das Ergebnis als Binärdaten anfordern, indem Sie *-bin* angeben. Die zu hashenden Daten können entweder als Zeichenfolgenargument für den Befehl **sha1**, als Dateiname oder als zuvor geöffneter Kanal angegeben werden. Wenn das Argument *-filename* angegeben wird, wird die Datei geöffnet, die Daten werden gelesen und gehasht und die Datei wird geschlossen. Wenn das Argument *-channel* angegeben wird, werden Daten aus dem Kanal bis zum Dateiende gelesen. Der Kanal wird nicht geschlossen. *Hinweis*: Die Verwendung der Kanal- oder Dateinamen-Optionen führt zur internen Nutzung von **vwait**. Um verschachtelte Ereignisschleifen in Tk- oder tclhttpd-Anwendungen zu vermeiden, sollten Sie die inkrementelle Programmier-API verwenden (siehe unten). Es sollte nur eines der Argumente *-file*, *-channel* oder *string* angegeben werden. Wenn der zu hashenden *string* mit einer Option verwechselt werden könnte (führender Bindestrich „-“), verwenden Sie davor die Option **--**, um den Options-Prozess zu beenden und die Interpretation als Zeichenkette zu erzwingen.

**::sha1::hmac** *key* *string*
: ...siehe nächstes...

**::sha1::hmac** ?**-hex|-bin**? **-key key** \[ **-channel channel** | **-file filename** | ?**--**? *string* \]
: Berechnet einen HMAC-Digest (Hashed Message Authentication Digest) unter Verwendung des SHA-1-Digest-Algorithmus. HMACs werden in RFC 2104 (3) beschrieben und liefern einen SHA-1-Digest, der einen Schlüssel enthält. Alle Optionen außer *-key* entsprechen denen des Befehls **::sha1::sha1**. Wenn die zu hashende *Zeichenkette* mit einer Option verwechselt werden könnte (vorangestellter Bindestrich „-“), verwenden Sie davor die Option **--**, um den Options-Prozess zu beenden und die Interpretation als Zeichenkette zu erzwingen.


# PROGRAMMIERSCHNITTSTELLE

Für den Programmierer lässt sich der SHA1-Hash als eine Art Behälter betrachten, in den Sie Daten einfüllen. Wenn Sie fertig sind, extrahieren Sie einen Wert, der aus den in den Behälter eingefüllten Daten abgeleitet wird. Die Programmierschnittstelle zum SHA1-Hash arbeitet mit einem Token (das dem Behälter entspricht). Sie rufen **SHA1Init** auf, um ein Token zu erhalten, und ruft anschließend **SHA1Update** so oft wie nötig auf, um Daten zum Hash hinzuzufügen. Um Ressourcen freizugeben und den Wert des Hash-Algorithmuses zu erhalten, rufen Sie dann **SHA1Final** auf. Ein entsprechender Funktionssatz liefert Ihnen einen schlüsselbasierten Digest (HMAC).

Wenn Sie **critcl** installiert und das **tcllibc**-Paket kompiliert haben, erfolgt die Implementierung der Hash-Funktion durch kompilierten Code. Falls dies nicht der Fall ist, können Sie das **Trf**-Paket verwenden; andernfalls steht ein reines Tcl-Äquivalent zur Verfügung. Die Programmierschnittstelle bleibt in allen Fällen unverändert.

**::sha1::SHA1Init**
: Erzeugt einen neuen SHA1-Hash. Gibt eine Token-ID zurück, die für die verbleibenden Funktionen verwendet werden muss.

**::sha1::SHA1Update** *token* *data*
: Fügt Daten zu dem durch das Token identifizierten Hash hinzu. Der Aufruf von *SHA1Update \$token „abcd“* entspricht dem Aufruf von *SHA1Update \$token „ab“*, gefolgt von *SHA1Update \$token „cb“*. Siehe **BEISPIELE**.

**::sha1::SHA1Final** *token*
: Gibt den Hash-Wert zurück und gibt alle von diesem Token belegten Ressourcen frei. Sobald dieser Befehl abgeschlossen ist, ist das Token ungültig. Das Ergebnis ist eine binäre Zeichenkette mit einer Länge von 20 Byte, die den 160-Bit-SHA1-Hash-Wert darstellt.

**::sha1::HMACInit** *key*
: Dies entspricht dem Befehl **::sha1::SHA1Init**, mit dem Unterschied, dass hierfür der Schlüssel angegeben werden muss, der in den HMAC einbezogen werden soll.

**::sha1::HMACUpdate** *token* *data*
: ...siehe nächstes...

**::sha1::HMACFinal** *token*
: Diese Befehle entsprechen den entsprechenden SHA1-Befehlen.


# BEISPIELE

```
% sha1::sha1 "Tcl does SHA1"
285a6a91c45a9066bf39fcf24425796ef0b2a8bf
```

```
% sha1::hmac Sekret "Tcl does SHA1"
ae6251fa51b95b18cba2be95eb031d07475ff03c
```

```
% set tok [sha1::SHA1Init]
::sha1::1
% sha1::SHA1Update $tok "Tcl "
% sha1::SHA1Update $tok "does "
% sha1::SHA1Update $tok "SHA1"
% sha1::Hex [sha1::SHA1Final $tok]
285a6a91c45a9066bf39fcf24425796ef0b2a8bf
```

# LITERATUR

**\[1\]**
: „Secure Hash Standard“, National Institute of Standards and Technology, US-Handelsministerium, April 1995. (*http://www.itl.nist.gov/fipspubs/fip180-1.htm*)

**\[2\]**
: Rivest, R., „The MD4 Message Digest Algorithm“, RFC 1320, MIT, April 1992. (*http://www.rfc-editor.org/rfc/rfc1320.txt*)

**\[3\]**
: Krawczyk, H., Bellare, M. und Canetti, R. „HMAC: Keyed-Hashing for Message Authentication“, RFC 2104, Februar 1997. (*http://www.rfc-editor.org/rfc/rfc2104.txt*)


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *sha1* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hashwerte, Prüfsummen und Verschlüsselung

# COPYRIGHT

```
Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
```
