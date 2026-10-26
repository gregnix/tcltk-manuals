---
CommandName: smtpd
ManualSection: n
Version: 1.6
TclPart: tcllib
TclDescription: Tcl SMTP Server Package
Keywords:
 - rfc 2821
 - rfc 821
 - services
 - smtp
 - smtpd
 - socket
 - vwait
Copyright:
 - Copyright (c) Pat Thoyts <patthoyts@users.sourceforge.net>
---

# NAME

smtpd – Tcl-basierte SMTP-Server-Implementierung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [smtpd]{.lit} [1.6]{.optlit} 
[::smtpd::start]{.cmd} [myaddr]{.optarg} [port]{.optarg} 
[::smtpd::stop]{.cmd} 
[::smptd::configure]{.cmd} [option value]{.optarg} [option value]{.optdot} 
[::smtpd::cget]{.cmd} [option]{.optarg} 
:::

# BESCHREIBUNG

Das Paket **smtpd** stellt eine einfache, ausschließlich auf Tcl basierende Serverbibliothek für das Simple Mail Transfer Protocol bereit, wie es in RFC 821 (*http://www.rfc-editor.org/rfc/rfc821.txt*) und RFC 2821 (*http://www.rfc-editor.org/rfc/rfc2821.txt*). Standardmäßig bindet der Server an die Standard-Netzwerkadresse und den Standard-SMTP-Port (25).

Dieses Paket wurde entwickelt, um Tests von Mail-User-Agent-Code von der Arbeitsstation eines Entwicklers aus zu ermöglichen. *Es wird nicht versucht, E-Mails an Ihr Postfach zuzustellen.* Stattdessen wird von den Nutzern dieses Pakets erwartet, dass sie eine Prozedur schreiben, die bei Eingang einer E-Mail aufgerufen wird. Sobald diese Prozedur zurückgibt, hat der Server nichts mehr mit der E-Mail zu tun.

# SICHERHEIT

Auf Unix-Plattformen sind Root-Rechte erforderlich, um eine Bindung zum SMTP-Port durchzuführen. Ich würde davon abraten, einen skriptbasierten Server als Root auszuführen, es sei denn, es gibt eine Methode, die Root-Rechte unmittelbar nach der Bindung des Sockets wieder abzulegen. Auf Windows-Plattformen sind keine Root- oder Administratorrechte erforderlich, um Sockets mit niedrigen Nummern zu binden. Allerdings ist die Sicherheit auf diesen Plattformen ohnehin gering.

Kurz gesagt: Dieser Code sollte wahrscheinlich nicht als dauerhaft laufender Mail Transfer Agent auf einem mit dem Internet verbundenen Server eingesetzt werden, auch wenn wir sorgfältig darauf achten, keine Benutzereingaben von außen zu bewerten. Es gibt viele andere, gründlich getestete und sicherheitsgeprüfte Programme, die als Mailserver für mit dem Internet verbundene Rechner verwendet werden können.

# TLS-SICHERHEITSHINWEISE

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# BEFEHLE

**::smtpd::start** ?*myaddr*? ?*port*?
: Startet den Dienst, der auf *port* oder dem Standardport 25 lauscht. Wenn *myaddr* als Domänenname oder als numerische IP-Adresse im „Dotted-Quad“-Format angegeben wird, wird der Server-Socket an diese Netzwerkschnittstelle gebunden. Standardmäßig ist der Server an alle Netzwerkschnittstellen gebunden. Beispiel:


```
  set sock [::smtpd::start [info hostname] 0]
```

wird an die Internetschnittstelle des Hosts auf dem ersten verfügbaren Port gebunden.

Derzeit unterstützt das Paket nur eine einzige Instanz eines SMTP-Servers. Dies könnte bei Bedarf geändert werden, was jedoch zur Folge hätte, dass das Paket etwas schwerer zu verstehen wäre. Wenn es einen triftigen Grund für den Betrieb mehrerer SMTP-Dienste gibt, wäre lediglich eine Anpassung des Arrays „**options**“ und der Verwendung der Variablen „**::smtpd::stopped**“ erforderlich.

Da der Servercode **fileevent**(n)-Handler zur Verarbeitung der Eingaben über Sockets verwendet, muss die Ereignisschleife laufen. Die Anwendung läuft dazu innerhalb von **wish**(1), oder **vwait**(n) wartet auf die Variable **::smtpd::stopped**, die gesetzt wird, wenn der Server anhält.

**::smtpd::stop**
: Hält den Server an und gibt den lauschenden Socket frei. Wenn der Server nicht gestartet wurde, hat dieser Befehl keine Auswirkung. Die Variable **::smtpd::stopped** wird für die Verwendung mit **vwait**(n) gesetzt. Beachten Sie, dass durch das Beenden des Servers keine derzeit aktiven Sitzungen getrennt werden, da diese über einen unabhängigen Kanal laufen. Nur durch das explizite Nachverfolgen und Schließen dieser Sitzungen oder durch das Beenden des Server-Prozesses werden alle laufenden Sitzungen beendet. Dies entspricht der üblichen Vorgehensweise bei Unix-Daemons, bei der der Server einen **fork**(2)-Befehl ausführt und die Client-Sitzung im untergeordneten Prozess fortgesetzt wird.

**::smptd::configure** ?*option* *value*? ?*option* *value* *...*?
: Legt die Konfigurationsoptionen für den SMTP-Server fest. Bei den meisten Werten handelt es sich um den Namen einer Callback-Prozedur, die an verschiedenen Stellen im SMTP-Protokoll aufgerufen wird. Einzelheiten zu den Prozeduren finden Sie im Abschnitt **CALLBACKS**.


**-banner** *text*
: Hinweis zu einer benutzerdefinierten Banner-Meldung. Das Standard-Banner lautet „tcllib smtpd 1.6“. Beachten Sie, dass eine Änderung des Banners keinen Einfluss auf den Text in Klammern in der vollständigen Begrüßung, die Ausgabe des Status 220, die Serveradresse und den Zeitstempel hat.

**-validate_host** *proc*
: Rückruffunktion zur Authentifizierung neuer Verbindungen anhand der IP-Adresse des Clients.

**-validate_sender** *proc*
: Rückruffunktion zur Authentifizierung neuer Verbindungen anhand der E-Mail-Adresse des Absenders.

**-validate_recipient** *proc*
: Rückruffunktion zur Validierung und Autorisierung einer E-Mail-Adresse des Empfängers

**-deliverMIME** *proc*
: Rückruffunktion, die zur Zustellung von E-Mails als MIME-Token verwendet wird, das vom tcllib-Paket **mime** erstellt wurde.

**-deliver** *proc*
: Rückruffunktion zur Zustellung von E-Mails. Diese Option hat keine Auswirkung, wenn die Option **-deliverMIME** gesetzt wurde.


**::smtpd::cget** ?*option*?
: Wird keine *option* angegeben, gibt der Befehl eine Liste aller Optionen und ihrer aktuellen Werte zurück. Wird eine Option angegeben, gibt er den Wert dieser Option zurück.


# CALLBACKS

**validate_host**-Rückruffunktion
: Diese Prozedur wird mit der IP-Adresse des Clients aufgerufen, sobald eine Verbindungsanfrage angenommen wurde und bevor Protokollbefehle verarbeitet werden. Wenn Sie einem bestimmten Host den Zugriff verweigern möchten, sollte diese Rückruffunktion einen Fehler geben. Beispiel:


```
 proc validate_host {ipnum} {
    if {[string match "192.168.1.*" $ipnum]} {
       error "go away!"
    }
 }
```

Wenn der Zugriff verweigert wird, erhält der Client eine Standardmeldung, die den Wortlaut Ihrer Fehlermeldung enthält, beispielsweise:

```
 550 Access denied: I hate you.
```

Gemäß dem SMTP-Protokoll wird die Verbindung nicht geschlossen, sondern wir warten darauf, dass der Client einen QUIT-Befehl sendet. Alle anderen Befehle führen zu einem Fehler „**503 Bad Sequence**“.

**validate_sender**-Rückruffunktion
: Die Rückruffunktion validate_sender wird während der Verarbeitung eines MAIL-Befehls mit der E-Mail-Adresse des Absenders aufgerufen, damit Sie E-Mails je nach dem angegebenen Absender annehmen oder ablehnen können. Um eine E-Mail abzulehnen, sollten Sie einen Fehler auslösen. Um beispielsweise E-Mails vom Benutzer „denied“ abzulehnen:


```
 proc validate_sender {address} {
    eval array set addr [mime::parseaddress $address]
    if {[string match "denied" $addr(local)]} {
         error "mailbox $addr(local) denied"
    }
    return
 }
```

Der Inhalt einer Fehlermeldung wird nicht an den Client zurückgegeben.

**validate_recipient**-Rückruffunktion
: Die Rückruffunktion „validate_recipient“ ähnelt der Rückruffunktion „validate_sender“ und ermöglicht es Ihnen, während der Verarbeitung des RCPT-Befehls ein lokales Postfach zu überprüfen und E-Mails für eine lokale Benutzeradresse anzunehmen. Um E-Mails abzulehnen, lösen Sie wie oben beschrieben einen Fehler aus. Die Fehlermeldung wird ignoriert.

**deliverMIME**-Rückruffunktion
: Die Rückruffunktion „deliverMIME“ wird aufgerufen, sobald eine E-Mail-Nachricht erfolgreich an den Server übermittelt wurde. Aus dem Absender, den Empfängern und den Daten wird ein MIME-Token erstellt, und die Prozedur des Benutzers wird mit diesem einzigen Argument aufgerufen. Wenn der Aufruf zurückgibt, wird das MIME-Token bereinigt; möchte der Benutzer die Daten daher aufbewahren, muss er eine Kopie anlegen.


```
 proc deliverMIME {token} {
     set sender [lindex [mime::getheader $token From] 0]
     set recipients [lindex [mime::getheader $token To] 0]
     set mail "From $sender [clock format [clock seconds]]"
     append mail "\n" [mime::buildmessage $token]
     puts $mail
 }
```

**deliver**-Rückruffunktion
: Der „deliver“-Callback wird aufgerufen, sobald eine E-Mail-Nachricht erfolgreich an den Server übermittelt wurde und die Option -deliverMIME nicht gesetzt ist. Die Prozedur wird mit dem Absender, einer Liste der Empfänger und dem Text der E-Mail als Liste von Zeilen aufgerufen. Beispiel:


```
 proc deliver {sender recipients data} {
    set mail "From $sender  [clock format [clock seconds]]"
    append mail "\n" [join $data "\n"]
    puts "$mail"
 }
```

Beachten Sie, dass der Befehl „DATA“ eine Fehlermeldung gibt, wenn noch kein Absender oder Empfänger definiert wurde.

# VARIABLEN

**::smtpd::stopped**
: Diese Variable wird während des Befehls **::smtpd::stop** auf **true** gesetzt, damit **vwait**(n) darauf warten kann.


# AUTOREN

Verfasst von Pat Thoyts *mailto:patthoyts@users.sourceforge.net*.

# LIZENZ

Diese Software wird in der Hoffnung bereitgestellt, dass sie von Nutzen ist, jedoch OHNE JEGLICHE GEWÄHRLEISTUNG; dies schließt sogar die stillschweigende Gewährleistung der MARKTGÄNGIGKEIT oder der EIGNUNG FÜR EINEN BESTIMMTEN ZWECK ein. Weitere Einzelheiten entnehmen Sie bitte der Datei „*license.terms*“.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *smtpd* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) Pat Thoyts <patthoyts@users.sourceforge.net>
```
