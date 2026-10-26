---
CommandName: imap4
title: imap4
ManualSection: n
Version: 0.5.5
TclPart: tcllib
TclDescription: imap client
Links:
 - ftp
 - http
 - imap
 - mime
 - pop3
 - tls
Keywords:
 - email
 - imap
 - internet
 - mail
 - net
 - rfc3501
 - ssl
 - tls
Copyright:
---

# Name

imap4 – clientseitige TCL-Implementierung des IMAP-Protokolls

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [imap4]{.lit} [0.5.5]{.optlit}
[::imap4::open]{.cmd} [hostname]{.arg} [port]{.optarg}
[::imap4::starttls]{.cmd} [chan]{.arg}
[::imap4::login]{.cmd} [chan]{.arg} [user]{.arg} [pass]{.arg}
[::imap4::folders]{.cmd} [chan]{.arg} [-inline]{.optarg} [mboxref]{.optarg} [mboxname]{.optarg}
[::imap4::select]{.cmd} [chan]{.arg} [mailbox]{.optarg}
[::imap4::examine]{.cmd} [chan]{.arg} [mailbox]{.optarg}
[::imap4::fetch]{.cmd} [chan]{.arg} [range]{.arg} [-inline]{.optarg} [attr]{.optdot}
[::imap4::noop]{.cmd} [chan]{.arg}
[::imap4::check]{.cmd} [chan]{.arg}
[::imap4::folderinfo]{.cmd} [chan]{.arg} [info]{.optarg}
[::imap4::msginfo]{.cmd} [chan]{.arg} [msgid]{.arg} [info]{.optarg} [defval]{.optarg}
[::imap4::mboxinfo]{.cmd} [chan]{.arg} [info]{.optarg}
[::imap4::isableto]{.cmd} [chan]{.arg} [capability]{.optarg}
[::imap4::create]{.cmd} [chan]{.arg} [mailbox]{.arg}
[::imap4::delete]{.cmd} [chan]{.arg} [mailbox]{.arg}
[::imap4::rename]{.cmd} [chan]{.arg} [oldname]{.arg} [newname]{.arg}
[::imap4::subscribe]{.cmd} [chan]{.arg} [mailbox]{.arg}
[::imap4::unsubscribe]{.cmd} [chan]{.arg} [mailbox]{.arg}
[::imap4::search]{.cmd} [chan]{.arg} [expr]{.arg} [...]{.optarg}
[::imap4::close]{.cmd} [chan]{.arg}
[::imap4::cleanup]{.cmd} [chan]{.arg}
[::imap4::debugmode]{.cmd} [chan]{.arg} [errormsg]{.optarg}
[::imap4::store]{.cmd} [chan]{.arg} [range]{.arg} [data]{.arg} [flaglist]{.arg}
[::imap4::expunge]{.cmd} [chan]{.arg}
[::imap4::copy]{.cmd} [chan]{.arg} [msgid]{.arg} [mailbox]{.arg}
[::imap4::logout]{.cmd} [chan]{.arg}
:::

# Beschreibung

Die Bibliothek **imap4** stellt die clientseitige Schnittstelle des *Internet Message Access Protocol* (IMAP) bereit, wobei Standard-Sockets oder eine sichere Verbindung über TLS/SSL verwendet werden. Das Paket ist vollständig in Tcl implementiert.

In diesem Dokument werden die Prozeduren beschrieben und deren Anwendung erläutert.

# Prozeduren

Dieses Paket definiert die folgenden öffentlichen Prozeduren:

**::imap4::open** *hostname* ?*port*?
: Öffnet eine neue IMAP-Verbindung und initialisiert den Handler; der IMAP-Kanal (Handler) wird zurückgegeben.

    *hostname* – Mailserver

    *port* – Verbindungsport, Standardwert ist 143.

    Die Namespace-Variable **::imap4::use\_ssl** kann verwendet werden, um eine sichere Verbindung über TLS/SSL herzustellen, sofern sie auf „true“ gesetzt ist. In diesem Fall ist der Standard-Port für die Verbindung 993.

    *Hinweis:* Für die Verbindung über SSL muss das Tcl-Modul *tls* bereits geladen sein, andernfalls wird ein Fehler ausgelöst.

    ```
        package require tls              ; # must be loaded for TLS/SSL
        set ::imap4::use_ssl 1           ; # request a secure connection
        set chan [::imap4::open $server] ; # default port is now 993
    ```

**::imap4::starttls** *chan*
: Verwenden Sie diese Option, wenn Sie eine Verbindung zu einem ungesicherten Port herstellen sollen, der vor der Benutzeranmeldung in einen gesicherten Port umgeschaltet werden muss. Diese Funktion wird als *STARTTLS* bezeichnet.

**::imap4::login** *chan* *user* *pass*
: Meldet sich mit dem Befehl „IMAP LOGIN“ an; bei erfolgreicher Anmeldung gibt der Befehl den Wert 0 zurück.

    *chan* – IMAP-Kanal

    *user* – Benutzername

    *pass* – Passwort

**::imap4::folders** *chan* ?*-inline*? ?*mboxref*? ?*mboxname*?
: Ruft eine Liste der übereinstimmenden Ordner ab; bei Erfolg gibt es 0 zurück.

    Für *mboxref* und *mboxname* sind Platzhalter wie „\*“ und „%“ zulässig; mit dem Befehl **::imap4::folderinfo** können Ordnerinformationen abgerufen werden.

    *chan* – IMAP-Kanal

    *mboxref* – Postfachreferenz, Standardwert ist „“

    *mboxname* – Postfachname, Standardwert ist „\*“

    Wenn **-inline** festgelegt wird, gibt es anstelle des Ergebniscodes eine kompakte Ordnerliste zurück. Alle Flags werden in Kleinbuchstaben umgewandelt und führende Sonderzeichen werden entfernt.

    ```
    {{Arc08 noselect} {Arc08/Private {noinferiors unmarked}} {INBOX noinferiors}}
    ```

**::imap4::select** *chan* ?*mailbox*?
: Wählt ein Postfach aus; bei Erfolg gibt es 0 zurück.

    *chan* – IMAP-Kanal

    *mailbox* – Pfad des Postfachs, Standardwert ist *INBOX*.

    Vor der Auswahl/Überprüfung muss ein geöffnetes Postfach geschlossen werden – siehe: **::imap4::close**.

**::imap4::examine** *chan* ?*mailbox*?
: „Untersucht“ ein Postfach; entspricht der schreibgeschützten Version von **::imap4::select**.

    *chan* – IMAP-Kanal

    *mailbox* – Name oder Pfad der Mailbox; Standardwert ist *INBOX*.

    Vor der Auswahl oder dem „Select“-Befehl muss eine geöffnete Mailbox geschlossen werden – siehe: **::imap4::close**.

**::imap4::fetch** *chan* *range* ?*-inline*? ?*attr ...*?
: Attribute aus Nachrichten abrufen.

    Die Attribute werden abgerufen und im internen Status gespeichert, der mit dem Befehl **::imap4::msginfo** abgerufen werden kann; bei Erfolg gibt er 0 zurück. Wenn **-inline** festgelegt wird, geben wir alle Datensätze als Liste in der im Argument *attr* definierten Reihenfolge zurück.

    *chan* – IMAP-Kanal

    *range* – Index der Nachrichten im Format *FROM*:*TO*

    *attr* – abzurufende IMAP-Attribute

    *Hinweis:* Wenn *FROM* weggelassen wird, wird die erste Nachricht angenommen; wenn *TO* weggelassen wird, wird die letzte Nachricht angenommen. Alle Indexbereiche beginnen bei 1.

**::imap4::noop** *chan*
: Sendet den Befehl „NOOP“ an den Server. Möglicherweise werden Informationen als unmarkierte Daten zurückgegeben.

    *chan* – IMAP-Kanal

**::imap4::check** *chan*
: Sendet den Befehl „CHECK“ an den Server. Die Festplatte leeren.

    *chan* – IMAP-Kanal

**::imap4::folderinfo** *chan* ?*info*?
: Ruft Informationen zur zuletzt ausgewählten Ordnerliste ab. Wird das Argument *info* weggelassen oder ist es eine leere Zeichenkette, gibt der Befehl die vollständige Liste der für das Postfach verfügbaren Informationen zurück.

    Endet der Name der gewünschten Information mit dem Zeichen ?, gibt der Befehl „true“ zurück, wenn die Information verfügbar ist, andernfalls „false“.

    *chan* – IMAP-Kanal

    *info* – Optionen für die abzurufende Ordnerliste

    Derzeit unterstützte Optionen: *delim* – nur Hierarchie-Trennzeichen, *match* – Suchmuster für ref und mbox (siehe **::imap4::folders**), *names* – ausschließlich Liste der Ordnernamen, *flags* – Liste der Ordnernamen mit Flags im Format *{ {name {flags}} ... }* (Siehe auch kompaktes Format in der Funktion **::imap4::folders**).

    ```
    {{Arc08 {{\NoSelect}}} {Arc08/Private {{\NoInferiors} {\UnMarked}}} {INBOX {\NoInferiors}}}
    ```

**::imap4::msginfo** *chan* *msgid* ?*info*? ?*defval*?
: Ruft Informationen (die zuvor mit „fetch“ erfasst wurden) zu einer bestimmten *msgid* ab. Wenn das Argument „info“ weggelassen wird oder es eine leere Zeichenkette ist, gibt es die Liste der verfügbaren Informationsoptionen für die angegebene Nachricht zurück.

    Wenn dem Namen der gewünschten Information ein „?“-Zeichen angehängt wird, gibt der Befehl „true“ zurück, sofern die Information verfügbar ist, andernfalls „false“.

    *chan* – IMAP-Kanal

    *msgid* – Nachrichtennummer

    *info* – IMAP-Schlüsselwort zum Abrufen

    *defval* – Standardwert, der gegeben wird, wenn „info“ leer ist

    *Hinweis:* Alle Nachrichten-Indexbereiche beginnen bei 1.

**::imap4::mboxinfo** *chan* ?*info*?
: Ruft Informationen zum aktuell ausgewählten Postfach ab. Wird das Argument *info* weggelassen oder ist es eine leere Zeichenkette, wird die Liste der für das Postfach verfügbaren Informationsoptionen zurückgegeben.

    Wird dem Namen der gewünschten Information ein „?“-Zeichen angehängt, gibt der Befehl „true“ zurück, wenn die Information verfügbar ist, andernfalls „false“.

    *chan* – IMAP-Kanal

    *opt* – abzurufende Postfachoption

    Derzeit unterstützte Optionen: *EXISTS* (Anzahl der Nachrichten), *RECENT* (Anzahl der als „aktuell“ markierten Nachrichten), *FLAGS*

    In Verbindung mit OK: *PERMFLAGS*, *UIDNEXT*, *UIDVAL*, *UNSEEN*

    Verschiedene Zustände: *CURRENT*, *FOUND*, *PERM*.

    ```
        ::imap4::select $chan INBOX
        puts "[::imap4::mboxinfo $chan exists] mails in INBOX"
    ```

**::imap4::isableto** *chan* ?*capability*?
: Prüfung der Funktion. Die Funktion gibt 1 zurück, wenn die angeforderte Funktion unterstützt wird, andernfalls 0. Wird *capability* weggelassen, werden alle IMAP-Funktionscodes als Liste zurückgegeben.

    *chan* – IMAP-Kanal

    *info* – IMAP-Schlüsselwort, das abgerufen werden soll

    *Hinweis:* Verwenden Sie den Befehl „capability“, um den Server zu befragen, falls dies vom Benutzer noch nicht geschehen ist.

**::imap4::create** *chan* *mailbox*
: Erstellt ein neues Postfach.

    *chan* – IMAP-Kanal

    *mailbox* – Name des Postfachs

**::imap4::delete** *chan* *mailbox*
: Ein neues Postfach löschen.

    *chan* – IMAP-Kanal

    *mailbox* – Name des Postfachs

**::imap4::rename** *chan* *oldname* *newname*
: Ein neues Postfach umbenennen.

    *chan* – IMAP-Kanal

    *mailbox* – alter Name des Postfachs

    *mailbox* – neuer Name des Postfachs

**::imap4::subscribe** *chan* *mailbox*
: Ein neues Postfach abonnieren.

    *chan* – IMAP-Kanal

    *mailbox* – Name des Postfachs

**::imap4::unsubscribe** *chan* *mailbox*
: Ein neues Postfach abmelden.

    *chan* – IMAP-Kanal

    *mailbox* – Name des Postfachs

**::imap4::search** *chan* *expr* ?*...*?
: Sucht nach E-Mails, die den Suchkriterien entsprechen; bei Erfolg gibt es 0 zurück.

    *chan* – IMAP-Kanal

    *expr* – IMAP-Suchausdruck

    *Hinweise:* Derzeit werden die folgenden Suchausdrücke unterstützt:

    *E-Mail-Header-Flags:* alle E-Mail-Header-Einträge (die mit einem Doppelpunkt „:“ enden), wie z. B. „From:“, „Bcc:“, …

    *IMAP-Nachrichtensuchflags:* ANSWERED, DELETED, DRAFT, FLAGGED, RECENT, SEEN, NEW, OLD, UNANSWERED, UNDELETED, UNDRAFT, UNFLAGGED, UNSEEN, ALL

    *IMAP-Header-Suchflags:* BODY, CC, FROM, SUBJECT, TEXT, KEYWORD, BCC

    *Bedingte Suchflags für IMAP:* SMALLER, LARGER, ON, SENTBEFORE, SENTON, SENTSINCE, SINCE, BEFORE (nicht implementiert), UID (nicht implementiert)

    *Logische Suchbedingungen:* OR, NOT

    ```
    ::imap4::search $chan larger 4000 seen
    puts "Found messages: [::imap4::mboxinfo $chan found]"
    Found messages: 1 3 6 7 8 9 13 14 15 19 20
    ```

**::imap4::close** *chan*
: Schließt das Postfach. Die Nachrichten im Ordner „\\Deleted“ werden endgültig gelöscht, und der Status wird auf „AUTH“ zurückgegeben.

    *chan* – IMAP-Kanal

**::imap4::cleanup** *chan*
: Eine IMAP-Verbindung trennen und den belegten Speicherplatz freigeben. Das Postfach schließen. Die Nachrichten im Ordner „Gelöscht“ werden endgültig entfernt, und der Status gibt zurück zu „AUTH“.

    *chan* – IMAP-Kanal

**::imap4::debugmode** *chan* ?*errormsg*?
: Schaltet den Client in den Debug-Modus der Befehlszeile um.

    Hierbei handelt es sich um einen reinen Entwicklermodus, der die Kontrolle an den Programmierer übergibt. Jede eingegebene Zeile wird unverändert an den Server gesendet (nach Hinzufügung der Anfrage-ID). Die Variable ::imap4::debug wird bei der Eingabe automatisch auf „1“ gesetzt.

    Es ist möglich, Tcl-Befehle auszuführen, die mit einem Schrägstrich beginnen.

    *chan* – IMAP-Kanal

    *errormsg* – optionale Fehlermeldung zur Anzeige

**::imap4::store** *chan* *range* *data* *flaglist*
: Ändert die mit einer Nachricht im ausgewählten Postfach verknüpften Daten.

    *chan* – IMAP-Kanal

    *range* – Index der Nachricht im Format *FROM*:*TO*

    *flaglist* – Flags, auf die sich *data* bezieht.

    *data* – Die derzeit definierten *data*-Elemente, die gespeichert werden können, sind unten aufgeführt. *Hinweis*: Allen diesen Datentypen kann auch das Suffix „.SILENT“ hinzugefügt werden, um die FETCH-Antwort ohne Tags zu unterdrücken.

    FLAGS
    : Ersetzt die Flags für die Nachricht (mit Ausnahme von \\Recent) durch die *flaglist*.

    +FLAGS
    : Fügt die Flags in *flaglist* zu den bereits vorhandenen Flags für die Nachricht hinzu.

    -FLAGS
    : Entfernt die Flags in *flaglist* aus den bestehenden Flags für die Nachricht.


    Beispiel:

    ```
    	::imap4::store $chan $start_msgid:$end_msgid +FLAGS "Deleted"
    ```

**::imap4::expunge** *chan*
: Entfernt dauerhaft alle Nachrichten, bei denen das Flag „\\Deleted“ gesetzt ist, aus dem aktuell ausgewählten Postfach, ohne dass die Verbindung geschlossen werden muss.

    *chan* – IMAP-Kanal

**::imap4::copy** *chan* *msgid* *mailbox*
: Kopiert die angegebene Nachricht (identifiziert durch ihre Nachrichtennummer) in das benannte Postfach, d. h. den IMAP-Ordner.

    *chan* – IMAP-Kanal

    *msgid* – Nachrichtennummer

    *mailbox* – Name des Postfachs

**::imap4::logout** *chan*
: Teilt dem Server mit, dass der Client die Verbindung beendet hat, und schließt die Netzwerkverbindung. Löscht Nachrichten mit dem Tag „\\Deleted“ endgültig.

    Um sich erneut anzumelden, muss eine neue Verbindung hergestellt werden.

    *chan* – IMAP-Kanal


# Beispiele

```
    set user myusername
    set pass xtremescrt
    set server imap.test.tld
    set FOLDER INBOX
    # Connect to server
    set imap [::imap4::open $server]
    ::imap4::login $imap $user $pass
    ::imap4::select $imap $FOLDER
    # Output all the information about that mailbox
    foreach info [::imap4::mboxinfo $imap] {
        puts "$info -> [::imap4::mboxinfo $imap $info]"
    }
    # fetch 3 records inline
    set fields {from: to: subject: size}
    foreach rec [::imap4::fetch $imap :3 -inline {*}$fields] {
        puts -nonewline "#[incr idx])"
        for {set j 0} {$j<[llength $fields]} {incr j} {
            puts "\t[lindex $fields $j] [lindex $rec $j]"
        }
    }

    # Show all the information available about the message ID 1
    puts "Available info about message 1: [::imap4::msginfo $imap 1]"

    # Use the capability stuff
    puts "Capabilities: [::imap4::isableto $imap]"
    puts "Is able to imap4rev1? [::imap4::isableto $imap imap4rev1]"

    # Cleanup
    ::imap4::cleanup $imap
```

# TLS-Sicherheitshinweise

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Literatur

Mark R. Crispin, „INTERNET MESSAGE ACCESS PROTOCOL – VERSION 4rev1“, RFC 3501, März 2003, <http://www.rfc-editor.org/rfc/rfc3501.txt>

OpenSSL, <http://www.openssl.org/>

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *imap4* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste. Nur ein kleiner Teil von RFC 3501 ist umgesetzt.

# Kategorie

Netzwerk
