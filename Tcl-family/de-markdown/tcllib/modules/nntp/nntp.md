---
CommandName: nntp
title: nntp
ManualSection: n
Version: 0.2.3
TclPart: tcllib
TclDescription: Tcl NNTP Client Library
Keywords:
 - news
 - nntp
 - nntpclient
 - rfc 1036
 - rfc 977
Copyright:
---

# Name

nntp – Tcl-Client für das NNTP-Protokoll

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [nntp]{.lit} [0.2.3]{.optlit}
[::nntp::nntp]{.cmd} [host]{.optarg} [port]{.optarg} [nntpName]{.optarg}
[nntpName]{.ins} [method]{.sub} [arg arg]{.optdot}
[nntpName]{.ins} [article]{.sub} [msgid]{.optarg}
[nntpName]{.ins} [authinfo]{.sub} [user]{.optarg} [pass]{.optarg}
[nntpName]{.ins} [body]{.sub} [msgid]{.optarg}
[nntpName]{.ins} [configure]{.sub}
[nntpName]{.ins} [configure]{.sub} [option]{.arg}
[nntpName]{.ins} [configure]{.sub} [option]{.arg} [value]{.arg} ...
[nntpName]{.ins} [cget]{.sub} [option]{.arg}
[nntpName]{.ins} [date]{.sub}
[nntpName]{.ins} [group]{.sub} [group]{.optarg}
[nntpName]{.ins} [head]{.sub} [msgid]{.optarg}
[nntpName]{.ins} [help]{.sub}
[nntpName]{.ins} [last]{.sub}
[nntpName]{.ins} [list]{.sub}
[nntpName]{.ins} [listgroup]{.sub} [group]{.optarg}
[nntpName]{.ins} [mode\_reader]{.sub}
[nntpName]{.ins} [newgroups]{.sub} [since]{.arg}
[nntpName]{.ins} [newnews]{.sub}
[nntpName]{.ins} [newnews]{.sub} [since]{.arg}
[nntpName]{.ins} [newnews]{.sub} [group]{.arg} [since]{.optarg}
[nntpName]{.ins} [next]{.sub}
[nntpName]{.ins} [post]{.sub} [article]{.arg}
[nntpName]{.ins} [slave]{.sub}
[nntpName]{.ins} [stat]{.sub} [msgid]{.optarg}
[nntpName]{.ins} [quit]{.sub}
[nntpName]{.ins} [xgtitle]{.sub} [group\_pattern]{.optarg}
[nntpName]{.ins} [xhdr]{.sub} [field]{.arg} [range]{.optarg}
[nntpName]{.ins} [xover]{.sub} [range]{.optarg}
[nntpName]{.ins} [xpat]{.sub} [field]{.arg} [range]{.arg} [pattern\_list]{.optarg}
:::

# Beschreibung

Das Paket **nntp** stellt eine einfache, ausschließlich auf Tcl basierende Client-Bibliothek für das NNTP-Protokoll bereit. Es öffnet den Standard-NNTP-Socket auf dem Server und stellt anschließend eine Tcl-API für den Zugriff auf die Befehle des NNTP-Protokolls bereit.  Alle Serverfehler werden als Tcl-Fehler zurückgegeben (ausgelöst) und müssen mit dem Tcl-Befehl **catch** abgefangen werden.

# Befehle

**::nntp::nntp** ?*host*? ?*port*? ?*nntpName*?
: Der Befehl öffnet eine Socket-Verbindung zum angegebenen NNTP-Server und erzeugt ein neues nntp-Objekt mit einem zugehörigen globalen Tcl-Befehl namens *nntpName*. Mit diesem Befehl lassen sich die verschiedenen NNTP-Protokollbefehle der neuen Verbindung erreichen. Die Vorgabe für *port* ist „119“, die Vorgabe für *host* ist „news“. Diese Vorgaben lassen sich mit den Umgebungsvariablen **NNTPPORT** beziehungsweise **NNTPHOST** überschreiben.

    Einige der Befehle dieses Pakets gehören nicht zu NNTP RFC 977 (<http://www.rfc-editor.org/rfc/rfc977.txt>) und stehen nicht auf allen NNTP-Servern zur Verfügung (oder sind dort nicht implementiert).

    Der Zugriffsbefehl *nntpName* hat die folgende allgemeine Form:

    *nntpName* **method** ?*arg arg ...*?
    : *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.


*nntpName* **article** ?*msgid*?
: Fragt den Server nach dem Artikel *msgid* aus der aktuellen Gruppe. Der Artikel kommt als gültige Tcl-Liste zurück, darin die Kopfzeilen, dann eine Leerzeile, dann der Textkörper des Artikels. Jedes Element der Liste ist eine Zeile des Artikels.

*nntpName* **authinfo** ?*user*? ?*pass*?
: Sendet die Anmeldedaten (Benutzername und Passwort) an den Server.

*nntpName* **body** ?*msgid*?
: Fragt den Server nach dem Textkörper des Artikels *msgid* aus der aktuellen Gruppe. Der Textkörper des Artikels kommt als gültige Tcl-Liste zurück. Jedes Element der Liste ist eine Zeile des Textkörpers.

*nntpName* **configure**
: siehe unten ...

*nntpName* **configure** *option*
: siehe unten ...

*nntpName* **configure** *option* *value* ...
: siehe unten ...

*nntpName* **cget** *option*
: Fragt Optionen des NNTP-Verbindungsobjekts ab und setzt sie. Derzeit wird nur eine Option unterstützt, **-binary**. Ist sie gesetzt, werden Artikel als Binärdaten statt als Text geholt. Betroffen sind nur die Methoden **article** und **body**.

    Eine Anwendung ist das Herunterladen von Artikeln mit yEnc-kodierten Bildern. Trotz der Kodierung sind die Daten überwiegend binär, und das Holen als Text verfälscht sie.

    Das Paket **yencode** liefert Kodierer und Dekodierer für solche Daten.

*nntpName* **date**
: Fragt den Server nach dem aktuellen Datum des Servers. Das Datum kommt im Format *YYYYMMDDHHMMSS* zurück.

*nntpName* **group** ?*group*?
: Setzt auf Wunsch die aktuelle Gruppe und holt Informationen über die gerade gewählte Gruppe. Gibt die geschätzte Anzahl der Artikel in der Gruppe zurück, gefolgt von der Nummer des ersten Artikels in der Gruppe, gefolgt vom letzten Artikel in der Gruppe, gefolgt vom Namen der Gruppe.

*nntpName* **head** ?*msgid*?
: Fragt den Server nach den Kopfzeilen des Artikels *msgid* aus der aktuellen Gruppe. Die Kopfzeilen des Artikels kommen als gültige Tcl-Liste zurück. Jedes Element der Liste ist eine Zeile der Kopfzeilen.

*nntpName* **help**
: Holt eine Liste der Befehle, die der News-Server unterstützt, mit dem gerade eine Verbindung besteht.

*nntpName* **last**
: Setzt den aktuellen Artikelzeiger so, dass er auf die vorherige Nachricht verweist (wenn vorhanden), und gibt die msgid dieser Nachricht zurück.

*nntpName* **list**
: Gibt eine Tcl-Liste gültiger Newsgroups und der zugehörigen Angaben zurück. Jede Newsgroup ist ein Element der Tcl-Liste in dieser Form:

    ```
          group last first p
    ```

    Dabei ist <group> der Name der Newsgroup, <last> die Nummer des letzten bekannten Artikels, der derzeit in dieser Newsgroup liegt, <first> die Nummer des ersten Artikels, der derzeit in der Newsgroup liegt, und <p> entweder 'y' oder 'n', je nachdem, ob das Posten in dieser Newsgroup erlaubt ('y') oder verboten ('n') ist.

    Die Felder <first> und <last> sind immer numerisch. Sie können führende Nullen haben. Fällt <last> kleiner aus als <first>, liegen derzeit keine Artikel in der Newsgroup.

*nntpName* **listgroup** ?*group*?
: Fragt den Server nach einer Liste aller Nachrichten (Nachrichtennummern) in der Gruppe, die das Argument *group* angibt, oder in der aktuellen Gruppe, wenn *group* nicht übergeben wurde.

*nntpName* **mode\_reader**
: Fragt den Server nach seiner NNTP-Antwortzeichenfolge für 'MODE READER'.

*nntpName* **newgroups** *since*
: Fragt den Server nach einer Liste aller neuen Newsgroups, die seit dem Zeitpunkt im Argument *since* angelegt wurden. *since* kann jede Zeitangabe sein, die **clock scan** versteht. Die Tcl-Liste der Newsgroups kommt in ähnlicher Form zurück wie die Gruppenliste des Befehls **nntpName list**. Jedes Element der Liste hat die Form:

    ```
          group last first p
    ```

    Dabei ist <group> der Name der Newsgroup, <last> die Nummer des letzten bekannten Artikels, der derzeit in dieser Newsgroup liegt, <first> die Nummer des ersten Artikels, der derzeit in der Newsgroup liegt, und <p> entweder 'y' oder 'n', je nachdem, ob das Posten in dieser Newsgroup erlaubt ('y') oder verboten ('n') ist.

*nntpName* **newnews**
: Fragt den Server nach einer Liste neuer Artikel, die am letzten Tag in der aktuellen Gruppe gepostet wurden.

*nntpName* **newnews** *since*
: Fragt den Server nach einer Liste neuer Artikel, die seit dem Zeitpunkt im Argument *since* in der aktuellen Gruppe gepostet wurden. *since* kann jede Zeitangabe sein, die **clock scan** versteht.

*nntpName* **newnews** *group* ?*since*?
: Fragt den Server nach einer Liste neuer Artikel, die seit dem Zeitpunkt im Argument *since* in der durch *group* angegebenen Gruppe gepostet wurden (oder im vergangenen Tag, wenn kein Argument *since* übergeben wird). *since* kann jede Zeitangabe sein, die **clock scan** versteht.

*nntpName* **next**
: Setzt den aktuellen Artikelzeiger so, dass er auf die nächste Nachricht verweist (sofern vorhanden), und gibt die msgid dieser Nachricht zurück.

*nntpName* **post** *article*
: Veröffentlicht einen Artikel in dem in RFC 1036 (<http://www.rfc-editor.org/rfc/rfc1036.txt>, Nachfolger von RFC 850) festgelegten Format in der aktuellen Newsgroup.

*nntpName* **slave**
: Kennzeichnet eine Verbindung als von einem Slave-NNTP-Server kommend. Das kann anzeigen, dass die Verbindung mehrere Personen bedient und Vorrang bekommen sollte. Die tatsächliche Verwendung hängt ganz von der Implementierung ab und kann von Server zu Server verschieden sein.

*nntpName* **stat** ?*msgid*?
: Der Befehl stat ähnelt dem Befehl article, nur dass kein Text zurückgegeben wird. Bei der Auswahl anhand der Nachrichtennummer innerhalb einer Gruppe setzt stat den aktuellen Artikelzeiger, ohne Text zu senden. Die zurückgegebene Bestätigung enthält die message-id, was von gewissem Wert sein kann. stat zur Auswahl anhand der message-id ist zulässig, aber von zweifelhaftem Wert, denn eine Auswahl anhand der message-id ändert den „aktuellen Artikelzeiger“ NICHT.

*nntpName* **quit**
: Schließt die Verbindung geordnet, nachdem ein NNTP-Befehl QUIT über den Socket gesendet wurde.

*nntpName* **xgtitle** ?*group\_pattern*?
: Gibt eine Tcl-Liste zurück, in der jedes Element diese Form hat:

    ```
    newsgroup description
    ```

    Ist ein *group\_pattern* angegeben, kommen nur Name und Beschreibung der Newsgroups zurück, die dem Muster entsprechen.

*nntpName* **xhdr** *field* ?*range*?
: Gibt den Wert des angegebenen Kopffeldes für die aktuelle Nachricht oder für eine Liste von Nachrichten der aktuellen Gruppe zurück. *field* ist der Titel eines Feldes in der Kopfzeile, etwa from, subject, date. Ist *range* nicht angegeben oder "", wird die aktuelle Nachricht abgefragt. Der Befehl gibt eine Liste von Elementen zurück, jedes in der Form:

    ```
        msgid value
    ```

    msgid ist die Nummer der Nachricht, value der Wert des abgefragten Feldes. Das Argument *range* kann eine dieser Formen haben:

    **""**
    : Die aktuelle Nachricht wird abgefragt.

    *msgid1*-*msgid2*
    : Es werden alle Nachrichten zwischen *msgid1* und *msgid2* (einschließlich *msgid1* und *msgid2*) abgefragt.

    *msgid1* *msgid2*
    : Es werden alle Nachrichten zwischen *msgid1* und *msgid2* (einschließlich *msgid1* und *msgid2*) abgefragt.


*nntpName* **xover** ?*range*?
: Gibt Kopfinformationen für die aktuelle Nachricht oder für einen Bereich von Nachrichten der aktuellen Gruppe zurück. Die Angaben kommen als Tcl-Liste zurück, jedes Element in der Form:

    ```
        msgid subject from date idstring bodysize headersize xref
    ```

    Ist *range* nicht angegeben oder "", wird die aktuelle Nachricht abgefragt. Das Argument *range* kann eine dieser Formen haben:

    **""**
    : Die aktuelle Nachricht wird abgefragt.

    *msgid1*-*msgid2*
    : Es werden alle Nachrichten zwischen *msgid1* und *msgid2* (einschließlich *msgid1* und *msgid2*) abgefragt.

    *msgid1* *msgid2*
    : Es werden alle Nachrichten zwischen *msgid1* und *msgid2* (einschließlich *msgid1* und *msgid2*) abgefragt.


*nntpName* **xpat** *field* *range* ?*pattern\_list*?
: Gibt den Wert des angegebenen Kopffeldes für eine bestimmte Nachricht oder für eine Liste von Nachrichten der aktuellen Gruppe zurück, deren Nachrichten zu den Mustern in pattern\_list passen. *field* ist der Titel eines Feldes in der Kopfzeile, etwa from, subject, date. Die Angaben kommen als Tcl-Liste zurück, jedes Element in der Form:

    ```
        msgid value
    ```

    msgid ist die Nummer der Nachricht, value der Wert des abgefragten Feldes. Das Argument *range* kann eine dieser Formen haben:

    *msgid*
    : Die durch *msgid* festgelegte Nachricht wird abgefragt.

    *msgid1*-*msgid2*
    : Es werden alle Nachrichten zwischen *msgid1* und *msgid2* (einschließlich *msgid1* und *msgid2*) abgefragt.

    *msgid1* *msgid2*
    : Es werden alle Nachrichten zwischen *msgid1* und *msgid2* (einschließlich *msgid1* und *msgid2*) abgefragt.



# Beispiel

Ein größeres Beispiel zum Versenden eines einzelnen Artikels.

```
    package require nntp
    set n [nntp::nntp NNTP_SERVER]
    $n post "From: USER@DOMAIN.EXT (USER_FULL)
    Path: COMPUTERNAME!USERNAME
    Newsgroups: alt.test
    Subject: Tcl test post -ignore
    Message-ID: <[pid][clock seconds]
    @COMPUTERNAME>
    Date: [clock format [clock seconds] -format "%a, %d %
    b %y %H:%M:%S GMT" -gmt true]

    Test message body"
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *nntp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk
