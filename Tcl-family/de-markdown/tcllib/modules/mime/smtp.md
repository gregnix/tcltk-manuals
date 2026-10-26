---
CommandName: smtp
title: smtp
ManualSection: n
Version: 1.5.2
TclPart: tcllib
TclDescription: smtp client
Links:
 - ftp
 - http
 - mime
 - pop3
Keywords:
 - email
 - internet
 - mail
 - mime
 - net
 - rfc 2554
 - rfc 2821
 - rfc 3207
 - rfc 821
 - rfc 822
 - smtp
 - tls
Copyright:
 - Copyright (c) 1999-2000 Marshall T. Rose and others
---

# Name

smtp – Clientseitige TCL-Implementierung des SMTP-Protokolls

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit}
[package]{.cmd} [require]{.sub} [mime]{.lit} [1.5.4]{.optlit}
[package]{.cmd} [require]{.sub} [smtp]{.lit} [1.5.2]{.optlit}
[::smtp::sendmessage]{.cmd} [token]{.arg} [option...]{.arg}
:::

# Beschreibung

Die Bibliothek **smtp** stellt die Client-Seite des Simple Mail Transfer Protocol (SMTP) bereit (1) (2).

**::smtp::sendmessage** *token* *option*...
: Dieser Befehl sendet den durch *token* dargestellten MIME-Teil (siehe Paket **mime**) an einen SMTP-Server. *options* ist eine Liste von Optionen und den dazugehörigen Werten. Die folgenden Optionen werden unterstützt:

    **-servers**
    : Eine Liste von SMTP-Servern. Der Standardwert ist **localhost**.

        Wenn mehrere Server festgelegt sind, werden diese nacheinander ausprobiert. Hinweis: Die **-ports**-Einträge werden parallel zu den Servern durchlaufen. Wenn die Ports für die Anzahl der Server nicht ausreichen, wird der Standardport (siehe unten) verwendet. Wenn mehr Ports als Server vorhanden sind, werden die überzähligen Ports ignoriert.

    **-ports**
    : Eine Liste von SMTP-Ports. Der Standardwert ist **25**.

        Informationen zum Verhalten bei Angabe mehrerer Server und Ports finden Sie oben unter der Option **-servers**.

    **-client**
    : Der Name, der als Hostname für die Verbindung zum Server verwendet werden soll. Standardmäßig ist dies entweder „localhost“, wenn einer der Server „localhost“ ist, oder die von **info hostname** zurückgegebene Zeichenfolge.

    **-queue**
    : Gibt an, dass der SMTP-Server aufgefordert werden soll, die Nachricht zur späteren Verarbeitung in die Warteschlange zu stellen. Ein boolescher Wert.

    **-atleastone**
    : Gibt an, dass der SMTP-Server mindestens einen geeigneten Empfänger finden muss, damit die Nachricht gesendet werden kann. Ein boolescher Wert.

    **-originator**
    : Eine Zeichenkette, die eine Adressangabe im 822-Format enthält. Wenn diese vorhanden ist, wird der Header nicht auf eine Absenderadresse überprüft.

    **-recipients**
    : Eine Zeichenkette, die eine oder mehrere Adressangaben im 822-Format enthält. Wenn diese Zeichenkette vorhanden ist, wird der Header nicht auf Empfängeradressen überprüft. Enthält die Zeichenkette mehr als eine Adresse, werden diese durch Kommas getrennt.

    **-header**
    : Eine Liste mit zwei Elementen: einem SMTP-Header und dem dazugehörigen Wert (die Option „-header“ kann nullmal oder mehrmals vorkommen).

    **-usetls**
    : Dieses Paket unterstützt standardmäßig die TLS-Erweiterung gemäß RFC 3207 (3), sofern das Paket „tls“ verfügbar ist. Sie können diese Funktion mit dieser booleschen Option deaktivieren.

    **-tlsimport**
    : Dieses boolesche Flag ist standardmäßig auf **false** gesetzt. Wenn dieses Flag gesetzt ist, importiert das Paket TLS bei einem erfolgreich geöffneten Kanal. Dies ist für Verbindungen erforderlich, die anstelle von **STARTTLS** eine native TLS-Aushandlung verwenden. Das **tls**-Paket wird bei Bedarf automatisch einbezogen.

    **-tlspolicy**
    : Mit dieser Option können Sie einen Befehl festlegen, der aufgerufen werden soll, wenn während der TLS-Einrichtung ein Fehler auftritt. Der Befehl wird aufgerufen, wobei der SMTP-Code und die Diagnosemeldung angehängt werden. Der Befehl sollte „secure“ oder „insecure“ zurückgeben, wobei „insecure“ dazu führt, dass das Paket über den unverschlüsselten Kanal weitergeleitet wird. Bei der Rückgabe von „secure“ wird der Socket geschlossen und der nächste Server in der Liste **-servers** versucht.

    **-username**
    : siehe unten ...

    **-password**
    : Wenn Ihr SMTP-Server vor der Annahme von E-Mails eine Authentifizierung (RFC 2554 (4)) verlangt, können Sie **-username** und **-password** verwenden, um dem Server Ihre Authentifizierungsdaten zu übermitteln. Derzeit unterstützt dieses Paket die Authentifizierungsmethoden DIGEST-MD5, CRAM-MD5, LOGIN und PLAIN. Zunächst wird die sicherste Methode ausprobiert, anschließend werden die Methoden nacheinander durchprobiert, bis entweder die Autorisierung erfolgt ist oder keine Methoden mehr übrig sind. Beachten Sie, dass die Autorisierung, wenn der Server eine TLS-Verbindung zulässt, erst erfolgt, nachdem wir begonnen haben, den sicheren Kanal zu nutzen.

        Bitte lesen Sie auch den Abschnitt [Authentifizierung]; dort werden die notwendigen Voraussetzungen, d. h. die zur Unterstützung dieser Optionen und der Authentifizierung erforderlichen Pakete, detailliert beschrieben.


    Wenn die Option **-originator** nicht vorhanden ist, wird die Absenderadresse aus dem Feld **From** (oder **Resent-From**) übernommen; ebenso werden, wenn die Option **-recipients** nicht vorhanden ist, die Empfängeradressen aus den Feldern **To**, **cc** und **Bcc** (bzw. **Resent-To** usw.) übernommen. Beachten Sie, dass die von der Option **-header** bereitgestellten Header-Schlüssel/Werte (nicht die im MIME-Teil vorhandenen) herangezogen werden. Unabhängig davon werden der ausgehenden Nachricht bei Bedarf Header-Schlüssel/Werte hinzugefügt, um sicherzustellen, dass eine gültige Nachricht im 822-Format versendet wird.

    Der Befehl gibt eine Liste zurück, aus der hervorgeht, welche Empfänger für den SMTP-Server unzulässig waren. Jedes Element der Liste ist eine weitere Liste, die die Adresse, einen SMTP-Fehlercode und eine textuelle Fehlermeldung enthält. Je nach der Option **-atleastone** und den vorgesehenen Empfängern kann eine nicht leere Liste dennoch bedeuten, dass die Nachricht vom Server akzeptiert wurde.


# Authentifizierung

Achtung: Die SMTP-Authentifizierung nutzt **SASL**. Das heißt, wenn der Benutzer eine Verbindung authentifizieren muss, d. h. die Optionen **-user** und **-password** verwenden muss (siehe oben), muss das **sasl**-Paket verfügbar sein, damit **smtp** es laden kann.

Dies ist eine weiche Abhängigkeit, da nicht jeder eine Authentifizierung benötigt und **sasl** von vielen kryptografischen (sicheren) Hash-Funktionen abhängt, d. h. von allen folgenden: **md5**, **otp**, **md4**, **sha1** und **ripemd160**.

# Beispiel

```
proc send_simple_message {recipient email_server subject body} {
    package require smtp
    package require mime

    set token [mime::initialize -canonical text/plain \
	-string $body]
    mime::setheader $token Subject $subject
    smtp::sendmessage $token \
	-recipients $recipient -servers $email_server
    mime::finalize $token
}

send_simple_message someone@somewhere.com localhost \
    "This is the subject." "This is the message."
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

1. Jonathan B. Postel, „SIMPLE MAIL TRANSFER PROTOCOL“, RFC 821, August 1982. (<http://www.rfc-editor.org/rfc/rfc821.txt>)

2. J. Klensin, „Simple Mail Transfer Protocol“, RFC 2821, April 2001. (<http://www.rfc-editor.org/rfc/rfc2821.txt>)

3. P. Hoffman, „SMTP-Dienst-Erweiterung für sicheres SMTP über Transport Layer Security“, RFC 3207, Februar 2002. (<http://www.rfc-editor.org/rfc/rfc3207.txt>)

4. J. Myers, „SMTP-Erweiterung für Authentifizierung“, RFC 2554, März 1999. (<http://www.rfc-editor.org/rfc/rfc2554.txt>)


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *smtp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 1999-2000 Marshall T. Rose and others
```
