---
CommandName: autoproxy
ManualSection: n
Version: 1.8.1
TclPart: tcllib
TclDescription: HTTP protocol helper modules
Links:
 - http(n)
Keywords:
 - authentication
 - http
 - proxy
Copyright:
---

# NAME

autoproxy – Automatische Nutzung und Authentifizierung eines HTTP-Proxys

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [http]{.lit} [2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [autoproxy]{.lit} [1.8.1]{.optlit} 
[::autoproxy::init]{.cmd} 
[::autoproxy::cget]{.cmd} [-option]{.arg} 
[::autoproxy::configure]{.cmd} [-option value]{.optarg} 
[::autoproxy::tls_connect]{.cmd} [args]{.arg} 
[::autoproxy::tunnel_connect]{.cmd} [args]{.arg} 
[::autoproxy::tls_socket]{.cmd} [args]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket dient dazu, die Verwendung von HTTP-Proxy-Servern im Tcl-HTTP-Client-Code zu automatisieren. Es versucht, die Einstellungen für den Webzugriff aus den Standardverzeichnissen des Systems zu initialisieren, und kann bei Bedarf so konfiguriert werden, dass es die Authentifizierung mit dem Proxy aushandelt.

Unter Unix scheint es Standard zu sein, den lokalen HTTP-Proxy-Server über die Umgebungsvariablen http_proxy oder ftp_proxy zu identifizieren und die Domänen, die vom Proxy-Einsatz ausgeschlossen werden sollen, über no_proxy aufzulisten. Unter Windows können wir die Werte der Interneteinstellungen aus der Registrierung abrufen, um nahezu dieselben Informationen zu erhalten. Mit diesen Informationen können wir eine geeignete Filter-Prozedur für das Tcl-HTTP-Paket einrichten und die automatische Nutzung des Proxys veranlassen.

Es scheint eine Reihe von Möglichkeiten zu geben, wie die Variable http_proxy eingerichtet werden kann. Entweder als einfache Angabe von Host und Port oder – was häufiger der Fall ist – als URL; manchmal enthält die URL Authentifizierungsparameter, oder diese werden vom Benutzer abgefragt oder über http_proxy_user und http_proxy_pass bereitgestellt. Dieses Paket versucht, all diese Schemata zu unterstützen. Es versucht nach Kräften, die erforderlichen Parameter aus der Umgebung oder der Registrierung zu beziehen; sollte dies fehlschlagen, kann es neu konfiguriert werden.

# TLS-SICHERHEITSHINWEISE

*Hinweis* Dieser Abschnitt gilt nur, wenn die TLS-Unterstützung durch das **TLS**-Paket bereitgestellt wird. Er gilt nicht, wenn **autoproxy** über die Konfigurationsoption **-tls_package** so konfiguriert wurde, dass ein anderes Paket verwendet wird, das dieselbe Funktion bereitstellen kann (z. B. **twapi**).

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# BEFEHLE

**::autoproxy::init**
: Initialisiert das Autoproxy-Paket anhand der Systemressourcen. Unter Unix bedeutet dies, dass wir nach Umgebungsvariablen suchen. Unter Windows suchen wir nach denselben Umgebungsvariablen, prüfen aber zusätzlich die von Internet Explorer verwendeten Registrierungseinstellungen.

**::autoproxy::cget** *-option*
: Einzelne Konfigurationsoptionen des Pakets abrufen. Siehe **OPTIONS**.

**::autoproxy::configure** ?-option *value*?
: Konfiguriert das Autoproxy-Paket. Wenn Sie **configure** ohne Optionen aufrufen, gibt es eine Liste aller Optionsnamen und Werte zurück. Siehe **OPTIONS**.

**::autoproxy::tls_connect** *args*
: Stellt über einen Proxy eine Verbindung zu einem sicheren Socket her. HTTP-Proxy-Server ermöglichen die Verwendung des HTTP-Befehls CONNECT, um über den Proxy eine Verbindung zum Zielrechner herzustellen. Diese Funktion verbirgt die Details. Zur Verwendung mit dem http-Paket siehe **tls_socket**. Die *args*-Liste kann beliebige Optionen enthalten, die von dem jeweils verwendeten TLS-Paket unterstützt werden, muss jedoch mit dem Host und dem Port als letzten beiden Elementen enden.

**::autoproxy::tunnel_connect** *args*
: Stellt über einen Proxy eine Verbindung zu einem Zielhost her. Dabei wird derselbe HTTP-Befehl „CONNECT“ wie bei **tls_connect** verwendet, jedoch wird die Verbindung nach ihrem Aufbau nicht weiter gesichert. Die *args*-Liste kann beliebige Optionen enthalten, die von dem jeweils verwendeten TLS-Paket unterstützt werden, muss jedoch mit dem Host und dem Port als letzten beiden Elementen enden. Beachten Sie, dass viele Proxy-Server CONNECT-Aufrufe nur auf eine begrenzte Anzahl von Ports zulassen – in der Regel nur auf Port 443 (den sicheren HTTP-Port).

**::autoproxy::tls_socket** *args*
: Diese Funktion dient dazu, einen proxy-fähigen Secure-Socket-Handler für das HTTPS-Protokoll zu registrieren. Sie darf nur in Verbindung mit dem Tcl-HTTP-Paket verwendet werden und sollte mit dem Befehl http::register registriert werden (siehe die folgenden Beispiele). Der eigentliche Auftrag zur Herstellung der getunnelten Verbindung erfolgt über den Befehl tls_connect, der verwendet werden kann, wenn keine Registrierung über das HTTP-Paket erfolgt.


# OPTIONEN

**-host** Hostname
: ...siehe nächstes...

**-proxy_host** Hostname
: Legt den Proxy-Hostnamen fest. Dieser wird normalerweise von **init** eingerichtet, kann aber auch hier konfiguriert werden.

**-port** Nummer
: ...siehe nächstes...

**-proxy_port** Nummer
: Legt die Proxy-Portnummer fest. Diese wird normalerweise von **init** eingerichtet. Beispiel: **configure** **-port** *3128*

**-no_proxy** Liste
: Sie können die von **init** eingerichtete **no_proxy**-Liste bearbeiten. Der Wert dieser Option ist eine Tcl-Liste von Zeichenketten, die mithilfe des Tcl-Befehls **string match** mit dem Host der HTTP-Anfrage abgeglichen werden. Daher sind Glob-Muster zulässig. Beispielsweise **configure** **-no_proxy** *\*.localdomain*

**-authProc**-Prozedur
: Mit dieser Option kann eine anwendungsdefinierte Prozedur festgelegt werden, die aufgerufen wird, wenn **configure** **-basic** ohne oder mit unzureichenden Authentifizierungsdaten aufgerufen wird. Dies kann genutzt werden, um dem Benutzer ein Dialogfeld anzuzeigen, in dem er zur Eingabe der zusätzlichen Informationen aufgefordert wird.

**-basic**
: Die folgenden Optionen dienen zur Konfiguration der Parameter für das Basic-Authentifizierungsschema. Siehe **Basic-Authentifizierung**. Um die aus einem früheren Aufruf dieser Funktion beibehaltenen Proxy-Authentifizierungsdaten zurückzusetzen, können entweder „--“ oder keine zusätzlichen Parameter angegeben werden. Dadurch werden die vorhandenen Authentifizierungsdaten entfernt.

**-tls_package** Paketname
: Mit dieser Option kann das Tcl-Paket für die TLS-Unterstützung konfiguriert werden. Gültige Paketnamen sind **tls** (Standard) und **twapi**.


# BASISAUTHENTIFIZIERUNG

„Basic“ ist das einfachste und am häufigsten verwendete Authentifizierungsverfahren für HTTP-Proxys. Es wird in (1, Abschnitt 11) sowie in (2) beschrieben. Es bietet keinerlei Datenschutz und von seiner Verwendung sollte zugunsten sichererer Alternativen wie „Digest“ abgeraten werden. Zur Durchführung der Basic-Authentifizierung kodiert der Client den Benutzernamen und das Passwort im Klartext, getrennt durch einen Doppelpunkt, mit der Base64-Kodierung. Diesem kodierten Text werden das Wort „Basic“ und ein Leerzeichen vorangestellt.

Für dieses Schema stehen folgende Optionen zur Verfügung:

**-username** Name
: Der Benutzername, der für die Authentifizierung beim konfigurierten Proxy erforderlich ist.

**-password** Passwort
: Das für den angegebenen Benutzernamen erforderliche Passwort.

**-realm**-Bereich
: Diese Option wird von diesem Paket nicht verwendet, kann jedoch dazu dienen, Authentifizierungsdaten vom Benutzer abzufragen.

**--**
: Der Indikator „End-of-Options“ kann allein verwendet werden, um alle derzeit aktivierten Authentifizierungsdetails zu deaktivieren.


# BEISPIELE

```
package require autoproxy
autoproxy::init
autoproxy::configure -basic -username ME -password SEKRET
set tok [http::geturl http://wiki.tcl.tk/]
http::data $tok
```

```
package require http
package require tls
package require autoproxy
autoproxy::init
http::register https 443 autoproxy::tls_socket
set tok [http::geturl https://www.example.com/]
```

# LITERATUR

**\[1\]**
: Berners-Lee, T., Fielding, R. und Frystyk, H. „Hypertext Transfer Protocol – HTTP/1.0“, RFC 1945, Mai 1996, (*http://www.rfc-editor.org/rfc/rfc1945.txt*)

**\[2\]**
: Franks, J. et al. „HTTP-Authentifizierung: Basic- und Digest-Zugriffsauthentifizierung“, RFC 2617, Juni 1999 (*http://www.rfc-editor.org/rfc/rfc2617.txt*)


# BUGS

Derzeit wird nur die Basisauthentifizierung (1) (2) unterstützt. Es ist geplant, in Zukunft auch die Unterstützung für Digest (2) und NTLM hinzuzufügen.

# AUTOREN

Pat Thoyts

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *http :: autoproxy* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk
