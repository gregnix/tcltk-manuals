---
CommandName: autoproxy
title: autoproxy
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

# Name

autoproxy – Automatische Nutzung und Authentifizierung eines HTTP-Proxys

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [http]{.lit} [2.0]{.optlit}
[package]{.cmd} [require]{.sub} [autoproxy]{.lit} [1.8.1]{.optlit}
[::autoproxy::init]{.cmd}
[::autoproxy::cget]{.cmd} [-option]{.arg}
[::autoproxy::configure]{.cmd} [[-option]{.lit} [value]{.arg}]{.optarg}
[::autoproxy::tls\_connect]{.cmd} [args]{.arg}
[::autoproxy::tunnel\_connect]{.cmd} [args]{.arg}
[::autoproxy::tls\_socket]{.cmd} [args]{.arg}
:::

# Beschreibung

Dieses Paket dient dazu, die Verwendung von HTTP-Proxy-Servern im Tcl-HTTP-Client-Code zu automatisieren. Es versucht, die Einstellungen für den Webzugriff aus den Standardverzeichnissen des Systems zu initialisieren, und kann bei Bedarf so konfiguriert werden, dass es die Authentifizierung mit dem Proxy aushandelt.

Unter Unix scheint es Standard zu sein, den lokalen HTTP-Proxy-Server über die Umgebungsvariablen http\_proxy oder ftp\_proxy zu identifizieren und die Domänen, die vom Proxy-Einsatz ausgeschlossen werden sollen, über no\_proxy aufzulisten. Unter Windows können wir die Werte der Interneteinstellungen aus der Registrierung abrufen, um nahezu dieselben Informationen zu erhalten. Mit diesen Informationen können wir eine geeignete Filter-Prozedur für das Tcl-HTTP-Paket einrichten und die automatische Nutzung des Proxys veranlassen.

Es scheint eine Reihe von Möglichkeiten zu geben, wie die Variable http\_proxy eingerichtet werden kann. Entweder als einfache Angabe von Host und Port oder – was häufiger der Fall ist – als URL; manchmal enthält die URL Authentifizierungsparameter, oder diese werden vom Benutzer abgefragt oder über http\_proxy\_user und http\_proxy\_pass bereitgestellt. Dieses Paket versucht, all diese Schemata zu unterstützen. Es versucht nach Kräften, die erforderlichen Parameter aus der Umgebung oder der Registrierung zu beziehen; sollte dies fehlschlagen, kann es neu konfiguriert werden.

# TLS-Sicherheitshinweise

*Hinweis* Dieser Abschnitt gilt nur, wenn die TLS-Unterstützung durch das **TLS**-Paket bereitgestellt wird. Er gilt nicht, wenn **autoproxy** über die Konfigurationsoption **-tls\_package** so konfiguriert wurde, dass ein anderes Paket verwendet wird, das dieselbe Funktion bereitstellen kann (z. B. **twapi**).

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# Befehle

**::autoproxy::init**
: Initialisiert das Autoproxy-Paket anhand der Systemressourcen. Unter Unix bedeutet dies, dass wir nach Umgebungsvariablen suchen. Unter Windows suchen wir nach denselben Umgebungsvariablen, prüfen aber zusätzlich die von Internet Explorer verwendeten Registrierungseinstellungen.

**::autoproxy::cget** *-option*
: Einzelne Konfigurationsoptionen des Pakets abrufen. Siehe [Optionen].

**::autoproxy::configure** ?-option *value*?
: Konfiguriert das Autoproxy-Paket. Wenn Sie **configure** ohne Optionen aufrufen, gibt es eine Liste aller Optionsnamen und Werte zurück. Siehe [Optionen].

**::autoproxy::tls\_connect** *args*
: Stellt über einen Proxy eine Verbindung zu einem sicheren Socket her. HTTP-Proxy-Server ermöglichen die Verwendung des HTTP-Befehls CONNECT, um über den Proxy eine Verbindung zum Zielrechner herzustellen. Diese Funktion verbirgt die Details. Zur Verwendung mit dem http-Paket siehe **tls\_socket**.

    Die *args*-Liste kann beliebige Optionen enthalten, die von dem jeweils verwendeten TLS-Paket unterstützt werden, muss jedoch mit dem Host und dem Port als letzten beiden Elementen enden.

**::autoproxy::tunnel\_connect** *args*
: Stellt über einen Proxy eine Verbindung zu einem Zielhost her. Dabei wird derselbe HTTP-Befehl „CONNECT“ wie bei **tls\_connect** verwendet, jedoch wird die Verbindung nach ihrem Aufbau nicht weiter gesichert.

    Die *args*-Liste kann beliebige Optionen enthalten, die von dem jeweils verwendeten TLS-Paket unterstützt werden, muss jedoch mit dem Host und dem Port als letzten beiden Elementen enden.

    Beachten Sie, dass viele Proxy-Server CONNECT-Aufrufe nur auf eine begrenzte Anzahl von Ports zulassen – in der Regel nur auf Port 443 (den sicheren HTTP-Port).

**::autoproxy::tls\_socket** *args*
: Diese Funktion dient dazu, einen proxy-fähigen Secure-Socket-Handler für das HTTPS-Protokoll zu registrieren. Sie darf nur in Verbindung mit dem Tcl-HTTP-Paket verwendet werden und sollte mit dem Befehl http::register registriert werden (siehe die folgenden Beispiele). Der eigentliche Auftrag zur Herstellung der getunnelten Verbindung erfolgt über den Befehl tls\_connect, der verwendet werden kann, wenn keine Registrierung über das HTTP-Paket erfolgt.


# Optionen

**-host** hostname
: siehe unten ...

**-proxy\_host** hostname
: Legt den Proxy-Hostnamen fest. Dieser wird normalerweise von **init** eingerichtet, kann aber auch hier konfiguriert werden.

**-port** number
: siehe unten ...

**-proxy\_port** number
: Legt die Proxy-Portnummer fest. Diese wird normalerweise von **init** eingerichtet. Beispiel: **configure** **-port** *3128*

**-no\_proxy** list
: Sie können die von **init** eingerichtete **no\_proxy**-Liste bearbeiten. Der Wert dieser Option ist eine Tcl-Liste von Zeichenketten, die mithilfe des Tcl-Befehls **string match** mit dem Host der HTTP-Anfrage abgeglichen werden. Daher sind Glob-Muster zulässig. Beispielsweise **configure** **-no\_proxy** *\*.localdomain*

**-authProc** procedure
: Mit dieser Option kann eine anwendungsdefinierte Prozedur festgelegt werden, die aufgerufen wird, wenn **configure** **-basic** ohne oder mit unzureichenden Authentifizierungsdaten aufgerufen wird. Dies kann genutzt werden, um dem Benutzer ein Dialogfeld anzuzeigen, in dem er zur Eingabe der zusätzlichen Informationen aufgefordert wird.

**-basic**
: Die folgenden Optionen dienen zur Konfiguration der Parameter für das Basic-Authentifizierungsschema. Siehe [Basisauthentifizierung]. Um die aus einem früheren Aufruf dieser Funktion beibehaltenen Proxy-Authentifizierungsdaten zurückzusetzen, können entweder „--“ oder keine zusätzlichen Parameter angegeben werden. Dadurch werden die vorhandenen Authentifizierungsdaten entfernt.

**-tls\_package** packagename
: Mit dieser Option kann das Tcl-Paket für die TLS-Unterstützung konfiguriert werden. Gültige Paketnamen sind **tls** (Standard) und **twapi**.


# Basisauthentifizierung

„Basic“ ist das einfachste und am häufigsten verwendete Authentifizierungsverfahren für HTTP-Proxys. Es wird in (1, Abschnitt 11) sowie in (2) beschrieben. Es bietet keinerlei Datenschutz und von seiner Verwendung sollte zugunsten sichererer Alternativen wie „Digest“ abgeraten werden. Zur Durchführung der Basic-Authentifizierung kodiert der Client den Benutzernamen und das Passwort im Klartext, getrennt durch einen Doppelpunkt, mit der Base64-Kodierung. Diesem kodierten Text werden das Wort „Basic“ und ein Leerzeichen vorangestellt.

Für dieses Schema stehen folgende Optionen zur Verfügung:

**-username** name
: Der Benutzername, der für die Authentifizierung beim konfigurierten Proxy erforderlich ist.

**-password** password
: Das für den angegebenen Benutzernamen erforderliche Passwort.

**-realm** realm
: Diese Option wird von diesem Paket nicht verwendet, kann jedoch dazu dienen, Authentifizierungsdaten vom Benutzer abzufragen.

**--**
: Der Indikator „End-of-Options“ kann allein verwendet werden, um alle derzeit aktivierten Authentifizierungsdetails zu deaktivieren.


# Beispiele

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

# Literatur

1. Berners-Lee, T., Fielding, R. und Frystyk, H. „Hypertext Transfer Protocol – HTTP/1.0“, RFC 1945, Mai 1996, (<http://www.rfc-editor.org/rfc/rfc1945.txt>)

2. Franks, J. et al. „HTTP-Authentifizierung: Basic- und Digest-Zugriffsauthentifizierung“, RFC 2617, Juni 1999 (<http://www.rfc-editor.org/rfc/rfc2617.txt>)


# Bugs

Derzeit wird nur die Basisauthentifizierung (1) (2) unterstützt. Es ist geplant, in Zukunft auch die Unterstützung für Digest (2) und NTLM hinzuzufügen.

# Autoren

Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *http :: autoproxy* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk
