---
CommandName: nns_intro
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv(n)
 - nameserv::auto(n)
 - nameserv::common(n)
 - nameserv::protocol(n)
 - nameserv::server(n)
 - nnsd(n)
 - nss(n)
Keywords:
 - client
 - name service
 - server
Copyright:
 - Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

nns_intro – Namensdienst-Funktion, Einleitung

# BESCHREIBUNG

*nns* (Abkürzung für *nano nameservice*) ist eine für das Paket **comm** entwickelte Komponente, die diesem einen einfachen Namensdienst hinzufügt. Sie baut zudem auf **comm** auf und nutzt dieses für den Austausch von Nachrichten zwischen Client- und Server-Komponenten.

Diese Namensdienstfunktion hat nichts mit dem *Domain Name System* des Internets zu tun, das auch als *DNS* bekannt ist. Wenn Sie nach einem Paket suchen, das sich damit befasst, sehen Sie sich bitte eines der Pakete **dns** oder **resolv** an, die beide ebenfalls in Tcllib zu finden sind.

Tcllib stellt zwei Anwendungen und vier Pakete bereit, die zusammenarbeiten und auf verschiedenen Ebenen Zugriff auf die Funktion ermöglichen.

# ANWENDUNGEN

Die Anwendung **nnsd** stellt einen einfachen Nameserver bereit, der von jedem an jedem beliebigen Ort auf seinem System nach eigenem Ermessen ausgeführt werden kann. Sie dient zudem als Beispiel für die Verwendung des serverseitigen Pakets **nameserv::server**.

Ergänzend zu diesem Server gibt es die Client-Anwendung **nns**. Eine mögliche, wenn auch nicht besonders sinnvolle Anwendung wäre die Eingabe von Name-Port-Bindungen in einen Server über ein Shell-Skript. Dies ist nicht sinnvoll, da Shell-Skripte in der Regel keinen auf **comm** basierenden Dienst bereitstellen.

Der einzige Fall, in dem dies einen gewissen Sinn ergeben würde, wäre ein Shell-Skript, das ein Tcl-Skript FOO umschließt, das **comm** verwendet, um den von FOO genutzten Listening-Port zu registrieren. Doch selbst in diesem Fall wäre es weitaus sinnvoller, FOO so zu erweitern, dass es den Namensdienst direkt nutzt. Wie das geht, kann **nns** sowohl als Beispiel als auch als Vorlage dienen. Darüber hinaus kann es ebenfalls nützlich sein, Nameservice-Abfragen aus Shell-Skripten heraus durchzuführen.

Die dritte Anwendung, **nnslog**, ist eine abgespeckte Version der Client-Anwendung **nns**. Sie ist darauf beschränkt, kontinuierlich nach allen Änderungen zu suchen und alle empfangenen Ereignisse auf stdout zu protokollieren.

Beide Clients nutzen das Paket **nameserv::auto**, um den Verlust und die Wiederherstellung der Verbindung zum Server automatisch zu handhaben.

# PAKETE

Die beiden wichtigsten Pakete zur Implementierung des Dienstes sind **nameserv** und **nameserv::server**, d. h. Client und Server. Letzteres verfügt über keine umfangreiche API, sondern lediglich über die notwendigen Funktionen zum Starten, Beenden und zur Konfiguration. Informationen zur Verwendung finden Sie in der Anwendung **nnsd**.

Der einfache Client im Paket **nameserv** stellt die eigentliche API bereit, mit der der Dienst verändert und abgefragt wird. Ein Beispiel für seine Verwendung ist die Anwendung **nns**.

Das zweite Client-Paket, **nameserv::auto**, hat API-Kompatibilität mit dem Basis-Client und bietet die zusätzliche Funktion, dass es Daten wie gebundene Namen automatisch wiederherstellt, wenn die Verbindung zum Namensdienst unterbrochen und anschließend wiederhergestellt wurde. Das heißt, es erkennt den Ausfall des Servers automatisch und gibt die Daten erneut ein, wenn der Server wieder verfügbar ist.

Das Paket **nameserv::common** ist für Benutzer nicht von Interesse. Es handelt sich um ein internes Paket, das Code und Definitionen enthält, die den Paketen **nameserv** und **nameserv::server** gemeinsam sind.

Alle Pakete verwenden das Paket **uevent** zur Meldung besonderer Umstände über Ereignisse und reservieren das uevent-Tag *nameserv* für ihre ausschließliche Nutzung. Alle ihre Ereignisse werden unter diesem Tag veröffentlicht.

# INTERNE ABLÄUFE

Das Dokument *Namensdienst-Funktion, Client/Server-Protokoll* legt das Protokoll fest, das von den Paketen **nameserv** und **nameserv::server** für die Kommunikation untereinander verwendet wird. Es ist für Nutzer weder der Pakete noch der Anwendungen von Belang.

Entwicklern, die die Namensdienstfunktion ändern und/oder erweitern oder einfach nur deren interne Funktionsweise verstehen möchten, wird jedoch dringend empfohlen, dieses Dokument zu lesen.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *nameserv* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
