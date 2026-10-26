---
CommandName: md5
ManualSection: n
Version: 2.0.9
TclPart: tcllib
TclDescription: MD5 Message-Digest Algorithm
Links:
 - md4
 - sha1
Keywords:
 - hashing
 - md5
 - message-digest
 - rfc 1320
 - rfc 1321
 - rfc 2104
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# NAME

md5 – MD5-Message-Digest-Algorithmus

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [md5]{.lit} [2.0.9]{.optlit} 
[::md5::md5]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::md5::hmac]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::md5::MD5Init]{.cmd} 
[::md5::MD5Update]{.cmd} [token]{.arg} [data]{.arg} 
[::md5::MD5Final]{.cmd} [token]{.arg} 
[::md5::HMACInit]{.cmd} [key]{.arg} 
[::md5::HMACUpdate]{.cmd} [token]{.arg} [data]{.arg} 
[::md5::HMACFinal]{.cmd} [token]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket ist eine Implementierung des MD5-Message-Digest-Algorithmus in Tcl, wie er in RFC 1321 (1) beschrieben ist. Dieser Algorithmus nimmt eine beliebige Datenmenge entgegen und erzeugt aus der Eingabe einen 128-Bit-Message-Digest. Der MD5-Algorithmus ist mit dem MD4-Algorithmus (2) verwandt, wurde jedoch gegen bestimmte Arten potenzieller Angriffe abgesichert. Bei neuen Anwendungen sollte MD5 gegenüber MD4 bevorzugt werden.

Wenn Sie **critcl** installiert und das **tcllibc**-Paket kompiliert haben, erfolgt die Implementierung der Hash-Funktion durch kompilierten Code. Alternativ wird, wenn Sie entweder **cryptkit** oder **Trf** installiert haben, eines dieser Programme zur Beschleunigung der Digest-Berechnung verwendet. Ist kein geeignetes kompiliertes Paket verfügbar, kommt die reine Tcl-Implementierung zum Einsatz. Die Programmierschnittstelle bleibt in allen Fällen unverändert.

*Hinweis*: Die vorherige Version dieses Pakets gab stets eine hexadezimal kodierte Zeichenkette zurück. Dies wurde geändert, um die Programmierschnittstelle zu vereinfachen und die Kompatibilität dieser Version mit anderen Implementierungen zu verbessern. Um die bisherige Funktionsweise zu erhalten, geben Sie entweder explizit die Paketversion 1 an oder verwenden Sie die Option *-hex* für den Befehl **md5**.

*Achtung* Die Befehle in diesem Paket erwarten Binärdaten als Eingabe. Wenn ein **-file** angegeben wird, wird dies von den Befehlen selbst sichergestellt, da sie die referenzierte Datei im Binärmodus öffnen. Wenn stattdessen Literal-Daten oder ein **-channel** übergeben werden, ist der *Aufrufer des Befehls* dafür verantwortlich, dies sicherzustellen. Die erforderliche Kodierung des Konvertierungsbefehls lautet **encoding convertto utf-8 \$string**.

*Achtung*, hier liegt ein *Tcl-9-Kompatibilitätsproblem* vor.

*Tcl 8.x behandelt* nicht-binäre Eingaben stillschweigend falsch, indem es diese intern auf die gewünschte Länge kürzt. Das heißt, indem nur das niedrige Byte eines höheren Unicode-Punkts verwendet wird. Es wird kein Fehler ausgelöst, das *Ergebnis ist einfach falsch*.

*Tcl 9 löst stattdessen einen Fehler aus*, d. h.

```
expected byte sequence but character <location> was ...
```

# BEFEHLE

**::md5::md5** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet den MD5-Hash der in der Zeichenkette angegebenen Binärdaten. Dieser wird standardmäßig als Binärzeichenkette zurückgegeben. Bei Angabe der Option *-hex* gibt es eine hexadezimal kodierte Version des Hashs zurück. Die zu hashenden Daten können entweder als Zeichenfolgenargument für den Befehl **md5**, als Dateiname oder als zuvor geöffneter Kanal angegeben werden. Wenn das Argument *-filename* angegeben wird, wird die Datei geöffnet, die Daten werden gelesen und gehasht und die Datei wird geschlossen. Wenn das Argument *-channel* angegeben wird, werden Daten aus dem Kanal bis zum Dateiende gelesen. Der Kanal wird nicht geschlossen. Es sollte nur eines der Argumente *-file*, *-channel* oder *string* angegeben werden.

**::md5::hmac** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Berechnet einen HMAC-Digest (Hashed Message Authentication Digest) unter Verwendung des MD5-Digest-Algorithmus. HMACs sind in RFC 2104 (3) beschrieben und liefern einen MD5-Digest, der einen Schlüssel enthält. Alle Optionen außer *-key* entsprechen denen des Befehls **::md5::md5**.


# PROGRAMMIERSCHNITTSTELLE

Für den Programmierer lässt sich der MD5-Hash als ein Behälter betrachten, in den Sie Daten einfüllen. Wenn Sie fertig sind, extrahieren Sie einen Wert, der aus den in den Behälter eingefüllten Daten abgeleitet wird. Die Programmierschnittstelle zum MD5-Hash arbeitet mit einem Token (das dem Behälter entspricht). Sie rufen **MD5Init** auf, um ein Token zu erhalten, und ruft anschließend **MD5Update** so oft wie nötig auf, um Daten zum Hash hinzuzufügen. Um Ressourcen freizugeben und den Wert des Hash-Werts zu erhalten, rufen Sie dann **MD5Final** auf. Eine entsprechende Funktionsgruppe liefert einen schlüsselgebundenen Digest (HMAC).

**::md5::MD5Init**
: Erzeugt einen neuen MD5-Hash. Gibt eine Token-ID zurück, die für die verbleibenden Funktionen verwendet werden muss.

**::md5::MD5Update** *token* *data*
: Fügt Daten zu dem durch das Token identifizierten Hash hinzu. Der Aufruf von *MD5Update \$token „abcd“* entspricht dem Aufruf von *MD5Update \$token „ab“*, gefolgt von *MD5Update \$token „cb“*. Siehe **BEISPIELE**.

**::md5::MD5Final** *token*
: Gibt den Hash-Wert zurück und gibt alle von diesem Token belegten Ressourcen frei. Sobald dieser Befehl abgeschlossen ist, ist das Token ungültig. Das Ergebnis ist eine binäre Zeichenkette mit einer Länge von 16 Byte, die den 128-Bit-MD5-Wert darstellt.

**::md5::HMACInit** *key*
: Dies entspricht dem Befehl **::md5::MD5Init**, mit dem Unterschied, dass hierfür der Schlüssel angegeben werden muss, der in den HMAC einbezogen werden soll.

**::md5::HMACUpdate** *token* *data*
: ...siehe nächstes...

**::md5::HMACFinal** *token*
: Diese Befehle entsprechen den entsprechenden MD5-Befehlen.


# BEISPIELE

```
% md5::md5 -hex "Tcl does MD5"
8AAC1EE01E20BB347104FABB90310433
```

```
% md5::hmac -hex -key Sekret "Tcl does MD5"
35BBA244FD56D3EDF5F3C47474DACB5D
```

```
% set tok [md5::MD5Init]
::md5::1
% md5::MD5Update $tok "Tcl "
% md5::MD5Update $tok "does "
% md5::MD5Update $tok "MD5"
% md5::Hex [md5::MD5Final $tok]
8AAC1EE01E20BB347104FABB90310433
```

# LITERATUR

**\[1\]**
: Rivest, R., „The MD5 Message-Digest Algorithm“, RFC 1321, MIT und RSA Data Security, Inc., April 1992. (*http://www.rfc-editor.org/rfc/rfc1321.txt*)

**\[2\]**
: Rivest, R., „The MD4 Message Digest Algorithm“, RFC 1320, MIT, April 1992. (*http://www.rfc-editor.org/rfc/rfc1320.txt*)

**\[3\]**
: Krawczyk, H., Bellare, M. und Canetti, R. „HMAC: Keyed-Hashing for Message Authentication“, RFC 2104, Februar 1997. (*http://www.rfc-editor.org/rfc/rfc2104.txt*)


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *md5* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hashwerte, Prüfsummen und Verschlüsselung

# COPYRIGHT

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
