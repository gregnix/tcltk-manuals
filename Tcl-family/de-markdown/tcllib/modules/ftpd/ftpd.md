---
CommandName: ftpd
title: ftpd
ManualSection: n
Version: 1.4.1
TclPart: tcllib
TclDescription: Tcl FTP Server Package
Keywords:
 - ftp
 - ftpd
 - ftpserver
 - rfc 959
 - services
Copyright:
---

# Name

ftpd – Tcl-basierte FTP-Server-Implementierung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ftpd]{.lit} [1.4.1]{.optlit}
[::ftpd::server]{.cmd} [myaddr]{.optarg}
[::ftpd::config]{.cmd} [option value]{.optarg} [option value]{.optdot}
[fsCmd]{.ins} [append]{.sub} [path]{.arg}
[fsCmd]{.ins} [delete]{.sub} [path]{.arg} [channel]{.arg}
[fsCmd]{.ins} [dlist]{.sub} [path]{.arg} [style]{.arg} [channel]{.arg}
[fsCmd]{.ins} [exists]{.sub} [path]{.arg}
[fsCmd]{.ins} [mkdir]{.sub} [path]{.arg} [channel]{.arg}
[fsCmd]{.ins} [mtime]{.sub} [path]{.arg} [channel]{.arg}
[fsCmd]{.ins} [permissions]{.sub} [path]{.arg}
[fsCmd]{.ins} [rename]{.sub} [path]{.arg} [newpath]{.arg} [channel]{.arg}
[fsCmd]{.ins} [retr]{.sub} [path]{.arg}
[fsCmd]{.ins} [rmdir]{.sub} [path]{.arg} [channel]{.arg}
[fsCmd]{.ins} [size]{.sub} [path]{.arg} [channel]{.arg}
[fsCmd]{.ins} [store]{.sub} [path]{.arg}
:::

# Beschreibung

Das Paket **ftpd** stellt eine einfache, ausschließlich auf Tcl basierende Serverbibliothek für das FTP-Protokoll bereit, wie es in RFC 959 (<http://www.rfc-editor.org/rfc/rfc959.txt>) festgelegt ist. Es lauscht auf dem üblichen FTP-Socket. Die meisten Serverfehler werden als Fehlermeldungen zurückgegeben, mit dem passenden Code daran. Da der Servercode des FTP-Daemons in der Ereignisschleife läuft, kann auf dem Server ein **bgerror** ausgelöst werden, wenn der Code im Modul Probleme macht.

# Befehle

**::ftpd::server** ?*myaddr*?
: Öffnet einen lauschenden Socket, der FTP-Verbindungen annimmt. *myaddr* ist ein optionales Argument. *myaddr* ist der Name in Domain-Schreibweise oder die numerische IP-Adresse der clientseitigen Netzschnittstelle, die für die Verbindung verwendet wird.

**::ftpd::config** ?*option value*? ?*option value ...*?
: Der Wert ist immer der Name des Befehls, der als Rückruffunktion aufgerufen wird. Die Option legt fest, welche Rückruffunktion konfiguriert wird. Argumente und Rückgabewerte der einzelnen Rückruffunktionen stehen im Abschnitt [Callbacks].

    -authIpCmd *proc*
    : Rückruffunktion, die neue Verbindungen anhand der IP-Adresse der Gegenstelle authentifiziert.

    -authUsrCmd *proc*
    : Rückruffunktion, die neue Verbindungen anhand des Benutzers authentifiziert, der sich anmeldet, und anhand des Benutzerpassworts.

    -authFileCmd *proc*
    : Rückruffunktion zur Gewährung oder Verweigerung des Lese- und Schreibzugriffs eines Benutzers auf einen bestimmten Pfad oder eine bestimmte Datei.

    -logCmd *proc*
    : Rückruffunktion für Log-Meldungen, die die FTP-Engine erzeugt.

    -fsCmd *proc*
    : Rückruffunktion, die die Engine mit dem Dateisystem verbindet, auf dem sie arbeitet.

    -closeCmd *proc*
    : Rückruffunktion, die aufgerufen wird, wenn eine Verbindung geschlossen wird. Dies ermöglicht es der einbettenden Anwendung, eigene Aufräumvorgänge durchzuführen.

    -xferDoneCmd *proc*
    : Rückruffunktion für die Meldung, dass eine Übertragung abgeschlossen ist. Sie wird aufgerufen, sobald eine Datenübertragung zum oder vom Client abgeschlossen ist.



# Callbacks

**authIpCmd** callback
: authIpCmd erhält als Argument die IP-Adresse der Gegenstelle, die sich mit dem FTP-Server verbinden will. Sie gibt 1 zurück, damit Benutzer von der angegebenen IP einen Anmeldeversuch unternehmen dürfen, und 0, um den Anmeldeversuch von dieser IP abzulehnen.

**authUsrCmd** callback
: authUsrCmd erhält Benutzername und Passwort als seine zwei Argumente. Es gibt 1 zurück, um den Anmeldeversuch am ftpd anzunehmen, und 0, um ihn abzulehnen.

**authFileCmd** callback
: authFileCmd erhält drei Argumente: den Benutzer (der gerade angemeldet ist), den Pfad oder Dateinamen, der gelesen oder geschrieben werden soll, und **read** oder **write**. Es gibt 1 zurück, damit der Pfad oder Dateiname gelesen oder geschrieben werden darf, und 0, um den Lese- oder Schreibversuch mit einem Berechtigungsfehlercode abzulehnen.

**logCmd** callback
: logCmd erhält einen Schweregrad und eine Meldung als seine zwei Argumente. Die Schweregrade im Paket ftpd sind **note**, **debug** und **error**. logCmd gibt nichts zurück.

**fsCmd** callback
: fsCmd erhält einen Unterbefehl, einen Dateinamen oder Pfad und je nach Unterbefehl weitere Argumente.

    fsCmd unterstützt diese Unterbefehle:

    *fsCmd* **append** *path*
    : Der Unterbefehl append erhält als Argument den Dateinamen, an den angehängt wird. Er gibt einen beschreibbaren Tcl-Kanal zurück.

    *fsCmd* **delete** *path* *channel*
    : Der Unterbefehl „delete“ erhält als zwei Argumente den Dateinamen der zu löschenden Datei und einen Kanal, in den geschrieben werden soll. Die angegebene Datei wird gelöscht, und die entsprechende FTP-Meldung wird in den Kanal geschrieben, der als zweites Argument übergeben wird. Der Unterbefehl „delete“ gibt keinen Wert zurück.

    *fsCmd* **dlist** *path* *style* *channel*
    : Der Unterbefehl dlist erhält drei Argumente: den Pfad, dessen Dateien aufzulisten sind, den Stil der Auflistung, entweder **nlst** oder **list**, und einen Kanal, auf den geschrieben wird. Die Dateien im angegebenen Pfad werden zeilenweise auf den angegebenen Kanal geschrieben. Ist der Stil **nlst**, wird nur der Name der Datei auf den Kanal geschrieben. Ist der Stil **list**, werden die Dateirechte, die Anzahl der Links auf die Datei, der Name des Benutzers, dem die Datei gehört, der Name der Gruppe, der die Datei gehört, die Größe der Datei in Byte, die Änderungszeit der Datei und der Dateiname in einem formatierten, durch Leerzeichen getrennten Format auf den Kanal geschrieben. Der Unterbefehl **dlist** gibt nichts zurück.

    *fsCmd* **exists** *path*
    : Der Unterbefehl „exists“ nimmt als einziges Argument den Namen einer Datei entgegen, deren Existenz überprüft werden soll. Der Unterbefehl „exists“ gibt den Wert 1 zurück, wenn der angegebene Pfad existiert und es sich dabei nicht um ein Verzeichnis handelt.

    *fsCmd* **mkdir** *path* *channel*
    : Der Unterbefehl „mkdir“ erhält als zwei Argumente den Pfad eines zu erstellenden Verzeichnisses und einen Kanal, in den geschrieben werden soll. Der Unterbefehl „mkdir“ erstellt das angegebene Verzeichnis, sofern dies erforderlich und möglich ist. Anschließend gibt der Unterbefehl „mkdir“ die entsprechende Erfolgsmeldung oder Fehlermeldung an den Kanal aus. Der Unterbefehl „mkdir“ gibt keinen Wert zurück.

    *fsCmd* **mtime** *path* *channel*
    : Der Unterbefehl „mtime“ erhält als zwei Argumente den Pfad einer Datei, deren Änderungszeit überprüft werden soll, sowie einen Kanal. Wenn die Datei vorhanden ist, wird die mtime im korrekten FTP-Format an den Kanal ausgegeben; andernfalls werden eine entsprechende Fehlermeldung und ein Fehlercode an den Kanal ausgegeben. Der Unterbefehl „mtime“ gibt keinen Wert zurück.

    *fsCmd* **permissions** *path*
    : Der Unterbefehl „permissions“ erwartet den Pfad einer Datei, deren Zugriffsrechte abgerufen werden sollen. Der Unterbefehl „permissions“ gibt die oktalen Dateizugriffsrechte der angegebenen Datei zurück. Es wird vorausgesetzt, dass die Datei vorhanden ist.

    *fsCmd* **rename** *path* *newpath* *channel*
    : Der Unterbefehl „rename“ erhält als drei Argumente den Pfad der aktuellen Datei, den neuen Dateipfad und einen Kanal, in den geschrieben werden soll.  Der Unterbefehl „rename“ benennt die aktuelle Datei in den neuen Dateipfad um, wenn der Pfad zur neuen Datei existiert, und gibt anschließend die entsprechende Meldung über den Kanal aus.  Existiert der neue Dateipfad nicht, wird die entsprechende Fehlermeldung über den Kanal ausgegeben.  Der Unterbefehl „rename“ gibt keinen Wert zurück.

    *fsCmd* **retr** *path*
    : Der Unterbefehl „retr“ erhält als einziges Argument den Pfad einer Datei, die gelesen werden soll. Der Unterbefehl „retr“ gibt einen lesbaren Kanal zurück, über den die angegebene Datei gelesen werden kann.

    *fsCmd* **rmdir** *path* *channel*
    : Der Unterbefehl „rmdir“ erhält als zwei Argumente den Pfad eines zu löschenden Verzeichnisses und einen Kanal, in den geschrieben werden soll. Der Unterbefehl „rmdir“ löscht das angegebene Verzeichnis (sofern möglich) und gibt die entsprechende Meldung an den Kanal aus (wobei es sich um eine Fehlermeldung handeln kann, falls das angegebene Verzeichnis nicht existiert oder nicht leer ist).  Der Unterbefehl „rmdir“ gibt keinen Wert zurück.

    *fsCmd* **size** *path* *channel*
    : Der Unterbefehl „size“ erhält als zwei Argumente den Pfad einer Datei, deren Größe (in Byte) ermittelt werden soll, sowie einen Kanal, in den die Ausgabe geschrieben werden soll. Der Unterbefehl „size“ gibt den entsprechenden Code und die Größe der Datei aus, wenn es sich bei dem angegebenen Pfad um eine Datei handelt; andernfalls werden ein entsprechender Fehlercode und eine Fehlermeldung an den Kanal ausgegeben. Der Unterbefehl „size“ gibt keinen Wert zurück.

    *fsCmd* **store** *path*
    : Der Unterbefehl „store“ erhält als einziges Argument den Pfad einer Datei, in die geschrieben werden soll. Der Unterbefehl „store“ gibt einen beschreibbaren Kanal zurück.


**closeCmd**
: Die Funktion **closeCmd** erhält beim Aufruf keine Argumente, und ein eventuell von ihr generierter Wert wird verworfen.

**xferDoneCmd** sock sock2 file bytes filename err
: **xferDoneCmd** erhält beim Aufruf sechs Argumente. Das sind, in dieser Reihenfolge, das Kanal-Handle des Steuer-Sockets der Verbindung, das Kanal-Handle des Daten-Sockets der Übertragung (bereits geschlossen), das Handle des Kanals mit der übertragenen Datei, die Anzahl der übertragenen Bytes, der Pfad der übertragenen Datei und eine (möglicherweise leere) Fehlermeldung. Ein Rückgabewert wird verworfen.


# Variablen

**::ftpd::cwd**
: Das aktuelle Arbeitsverzeichnis einer Sitzung, wenn sich jemand zum ersten Mal mit dem FTPD verbindet oder der FTP-Befehl **REIN** eintrifft.

**::ftpd::contact**
: Die E-Mail-Adresse der Person, die Kontakt für den FTP-Server ist. Diese Adresse wird als Teil der Antwort auf den Befehl **FTP HELP** ausgegeben.

**::ftpd::port**
: Der Port, auf dem der FTP-Server lauschen soll. Ist der Port als Null angegeben, teilt das Betriebssystem einen ungenutzten Port als Server-Socket zu; danach enthält die Variable die zugeteilte Portnummer.

**::ftpd::welcome**
: Die Meldung, die ausgegeben wird, wenn der Benutzer sich zum ersten Mal mit dem FTP-Server verbindet.

**::ftpd::CurrentSocket**
: Für alle Rückruffunktionen und alle Dateisystembefehle zugänglich, die eine besondere Form der Rückruffunktion sind, und enthält das Handle des Socket-Kanals, der beim Aufruf der Rückruffunktion aktiv war.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ftpd* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk
