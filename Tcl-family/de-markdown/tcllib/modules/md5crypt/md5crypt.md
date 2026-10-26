---
CommandName: md5crypt
ManualSection: n
Version: 1.2.0
TclPart: tcllib
TclDescription: MD5-based password encryption
Links:
 - md5
Keywords:
 - hashing
 - md5
 - md5crypt
 - message-digest
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# NAME

md5crypt – MD5-basierte Passwortverschlüsselung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [md5]{.lit} [2.0]{.lit} 
[package]{.cmd} [require]{.sub} [md5crypt]{.lit} [1.2.0]{.optlit} 
[::md5crypt::md5crypt]{.cmd} [password]{.arg} [salt]{.arg} 
[::md5crypt::aprcrypt]{.cmd} [password]{.arg} [salt]{.arg} 
[::md5crypt::salt]{.cmd} [length]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket enthält eine Implementierung des Passwortverschlüsselungsalgorithmus „MD5-crypt“, der ursprünglich von FreeBSD entwickelt wurde und derzeit in vielen modernen Systemen als Ersatz für die Unix-Funktion „crypt(3)“ verwendet wird. Eine Implementierung des eng verwandten Apache MD5-crypt ist ebenfalls verfügbar. Die Ausgabe dieser Befehle ist kompatibel mit der BSD- und OpenSSL-Implementierung von md5crypt sowie mit dem Programm „htpasswd“ von Apache 2.

# BEFEHLE

**::md5crypt::md5crypt** *password* *salt*
: Erzeugt einen BSD-kompatiblen, MD5-verschlüsselten Passwort-Hash aus dem Klartext-Passwort und einem zufälligen Salt (siehe SALT).

**::md5crypt::aprcrypt** *password* *salt*
: Erzeugt einen Apache-kompatiblen, MD5-verschlüsselten Passwort-Hash aus dem Klartext-Passwort und einem zufälligen Salt (siehe SALT).

**::md5crypt::salt** ?*length*?
: Generiert eine zufällige Salt-Zeichenkette, die für die Verwendung mit den Befehlen **md5crypt** und **aprcrypt** geeignet ist.


# SALT

Das an eines der hier implementierten Verschlüsselungsverfahren übergebene Salt wird daraufhin überprüft, ob es mit der Magic-String des jeweiligen Verschlüsselungsverfahrens beginnt (entweder „\$1\$“ für MD5-crypt oder „\$apr1\$“ für Apache crypt). Wenn dies der Fall ist, wird dieser Teil entfernt. Die verbleibenden Zeichen bis zum nächsten \$ und bis zu einer maximalen Länge von 8 Zeichen werden dann als Salt verwendet. Der Salt-Text sollte wahrscheinlich auf die Menge der alphanumerischen ASCII-Zeichen sowie „./“ (Punkt und Schrägstrich) beschränkt werden – dies dient der Gewährleistung einer maximalen Kompatibilität mit dem Unix-Passwortdateiformat.

Wenn ein Passwort generiert wird, anstatt es aus einer Passwortdatei abzurufen, kann der Befehl **salt** verwendet werden, um ein zufälliges Salt zu generieren.

# BEISPIELE

```
% md5crypt::md5crypt password 01234567
$1$01234567$b5lh2mHyD2PdJjFfALlEz1
```

```
% md5crypt::aprcrypt password 01234567
$apr1$01234567$IXBaQywhAhc0d75ZbaSDp/
```

```
% md5crypt::md5crypt password [md5crypt::salt]
$1$dFmvyRmO$T.V3OmzqeEf3hqJp2WFcb.
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *md5crypt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hashwerte, Prüfsummen und Verschlüsselung

# COPYRIGHT

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
