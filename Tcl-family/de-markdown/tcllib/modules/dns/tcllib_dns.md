---
CommandName: dns
title: dns
ManualSection: n
Version: 1.6.1
TclPart: tcllib
TclDescription: Domain Name Service
Links:
 - resolver(5)
Keywords:
 - DNS
 - domain name service
 - resolver
 - rfc 1034
 - rfc 1035
 - rfc 1886
 - rfc 7858
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# Name

dns – Tcl-Client für den Domain Name Service

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [dns]{.lit} [1.6.1]{.optlit}
[::dns::resolve]{.cmd} [query]{.arg} [options]{.optarg}
[::dns::configure]{.cmd} [options]{.optarg}
[::dns::name]{.cmd} [token]{.arg}
[::dns::address]{.cmd} [token]{.arg}
[::dns::cname]{.cmd} [token]{.arg}
[::dns::result]{.cmd} [token]{.arg}
[::dns::status]{.cmd} [token]{.arg}
[::dns::error]{.cmd} [token]{.arg}
[::dns::reset]{.cmd} [token]{.arg}
[::dns::wait]{.cmd} [token]{.arg}
[::dns::cleanup]{.cmd} [token]{.arg}
[::dns::nameservers]{.cmd}
:::

# Beschreibung

Das Paket „dns“ stellt einen ausschließlich auf Tcl basierenden DNS-Client (Domain Name Service) bereit. Informationen zum DNS-Protokoll finden Sie unter (1) und (2); lesen Sie die Dokumentation zu resolver(3), um zu erfahren, wie die C-Bibliothek Domänennamen auflöst. Dieses Paket soll Tcl-Skripte vor Problemen schützen, die bei der Verwendung des System-Resolvers für langsame Namensserver auftreten können. Es kann von praktischem Nutzen sein oder auch nicht. Die Namensauflösung im Internet ist ein komplexes Unterfangen, und DNS ist nur ein Teil des Resolvers. Möglicherweise stellen Sie fest, dass Sie Hosts-Dateien, NIS oder WINS verwenden sollten, um nur einige andere Systeme zu nennen. Dieses Paket ist keine Ersetzung für den Resolver der C-Bibliothek – es implementiert jedoch die Namensauflösung über DNS. Das Paket erweitert zudem das Paket **uri** um die Unterstützung von DNS-URIs (4) der Form *dns:what.host.com* oder *dns://my.nameserver/what.host.com*. Der Befehl **dns::resolve** kann sowohl DNS-URIs als auch einfache Domänennamen als Abfrage verarbeiten.

*Hinweis:* Das Paket verwendet standardmäßig DNS über TCP-Verbindungen. Wenn Sie UDP verwenden möchten, müssen Sie das Paket **tcludp** installiert haben und über eine Version verfügen, die Binärdaten korrekt verarbeitet (> 1.0.4). Dieses ist unter http://tcludp.sourceforge.net/ verfügbar. Wenn das Paket **udp** vorhanden ist, wird standardmäßig UDP verwendet.

*Hinweis:* Das Paket unterstützt DNS über TLS (RFC 7858) für einen besseren Datenschutz bei DNS-Abfragen. Für die Nutzung dieser Funktion ist das TLS-Paket erforderlich.

# Befehle

**::dns::resolve** *query* ?*options*?
: Löst einen Domänennamen mithilfe des *DNS*-Protokolls auf. *query* ist der Domänenname, der abgefragt werden soll. Dabei sollte es sich entweder um einen vollqualifizierten Domänennamen oder um eine DNS-URI handeln.

    **-nameserver** *hostname* or **-server** *hostname*
    : Legt einen alternativen Namen für den Nameserver für diese Anfrage fest.

    **-protocol** *tcp|udp*
    : Legt das für diese Anfrage zu verwendende Netzwerkprotokoll fest. Mögliche Werte sind *tcp* oder *udp*.

    **-port** *portnum*
    : Legt einen alternativen Port fest.

    **-search** *domainlist*
    : siehe unten ...

    **-timeout** *milliseconds*
    : Überschreibt die Standard-Zeitüberschreitung.

    **-type** *TYPE*
    : Legt den Typ des DNS-Eintrags fest, der Sie interessiert. Gültige Werte sind A, NS, MD, MF, CNAME, SOA, MB, MG, MR, NULL, WKS, PTR, HINFO, MINFO, MX, TXT, SPF, SRV, AAAA, AXFR, MAILB, MAILA und \*. Einzelheiten zu den Werten, die zurückgegeben werden, finden Sie in RFC 1035. Informationen zu SPF finden Sie unter http://spf.pobox.com/. Informationen zu AAAA-Einträgen finden Sie unter (3) und Einzelheiten zu SRV-Einträgen in RFC 2782.

    **-class** *CLASS*
    : Legt die Klasse des Domainnamens fest. In der Regel ist dies „IN“, es kann sich jedoch auch um „IN“ für Internet-Domainnamen, „CS“, „CH“, „HS“ oder „\*“ für eine beliebige Klasse handeln.

    **-recurse** *boolean*
    : Setzt diesen Wert auf *false*, wenn Sie nicht möchten, dass der Nameserver Ihre Anfrage rekursiv bearbeitet. Standardmäßig ist der Wert auf *true* gesetzt.

    **-command** *procname*
    : Legt eine Prozedur fest, die nach Abschluss der Anfrage aufgerufen werden soll. Der Prozedur wird das Token als einziges Argument übergeben.

    **-usetls** *boolean*
    : Setzt den Wert auf *true*, um DNS über TLS zu verwenden. Dadurch wird die Verwendung von TCP erzwungen und der Standardport auf 853 geändert. Da eine Validierung der Zertifikate erforderlich ist, muss eine Quelle für Zertifikate einer vertrauenswürdigen Zertifizierungsstelle mithilfe von *-cafile* oder *-cadir* angegeben werden.

    **-cafile** *filepath*
    : Gibt eine Datei an, die eine Sammlung vertrauenswürdiger Zertifikate von Zertifizierungsstellen enthält. Weitere Informationen finden Sie auf der Seite des Handbuchs zum Befehl **update-ca-certificates** oder in der Hilfe zur Option **-CAfile** von **openssl**.

    **-cadir** *dirpath*
    : Gibt ein Verzeichnis an, das Zertifikate vertrauenswürdiger Zertifizierungsstellen enthält. Diese Angabe ist erforderlich, wenn **-cafile** nicht angegeben ist, damit die Validierung der Zertifikate funktioniert, wenn **-usetls** aktiviert ist. Informationen zur erforderlichen Struktur dieses Verzeichnisses finden Sie in der Dokumentation zu **openssl**.


**::dns::configure** ?*options*?
: Der Befehl **::dns::configure** dient zur Konfiguration des DNS-Pakets. Der abzufragende Server, das Protokoll und der Pfad für Domänen werden alle über diesen Befehl festgelegt. Werden keine Argumente angegeben, gibt der Befehl eine Liste aller aktuellen Einstellungen zurück. Wird nur ein Argument angegeben, muss es sich um den Namen einer Option handeln, und der Wert dieser Option wird zurückgegeben.

    **-nameserver** *hostname*
    : Legt den Standard-Name des Nameservers fest, der für alle Abfragen verwendet werden soll. Die Standardeinstellung lautet *localhost*.

    **-protocol** *tcp|udp*
    : Legt das standardmäßig zu verwendende Netzwerkprotokoll fest. Die Standardeinstellung ist *tcp*.

    **-port** *portnum*
    : Legt den Standardport fest, der auf dem Nameserver verwendet werden soll. Der Standardwert ist 53.

    **-search** *domainlist*
    : Legt die Liste für die Domänensuche fest. Diese wird derzeit nicht verwendet.

    **-timeout** *milliseconds*
    : Legt den Standardwert für das Timeout bei DNS-Abfragen fest. Der Standardwert beträgt 30 Sekunden.

    **-loglevel** *level*
    : Legt die Protokollstufe fest, die für die Ausgabe von Diagnosemeldungen aus diesem Paket verwendet wird. Die Standardeinstellung ist *warn*. Einzelheiten zu den verfügbaren Stufen finden Sie im Paket **log**.

    **-cafile** *filepath*
    : Legt den Standard-Pfad für die Option „**-cafile**“ auf „**dns::resolve**“ fest.

    **-cadir** *dirpath*
    : Legt den Standard-Verzeichnis-Pfad, der für die Option „**-cadir**“ verwendet werden soll, auf „**dns::resolve**“ fest.


**::dns::name** *token*
: Gibt eine Liste aller Domainnamen zurück, die als Antwort auf Ihre Abfrage zurückgegeben wurden.

**::dns::address** *token*
: Gibt eine Liste der Adressdatensätze zurück, die Ihrer Abfrage entsprechen.

**::dns::cname** *token*
: Gibt eine Liste der kanonischen Namen zurück (in der Regel nur einen), die Ihrer Abfrage entsprechen.

**::dns::result** *token*
: Gibt eine Liste aller dekodierten Antwortdatensätze zurück, die für Ihre Abfrage bereitgestellt wurden. Auf diese Weise können Sie auch bei ungewöhnlicheren Abfragetypen das Ergebnis extrahieren.

**::dns::status** *token*
: Gibt das Statusflag zurück. Bei einer erfolgreich abgeschlossenen Abfrage lautet dieses *ok*. Es kann auch *error*, *timeout* oder *eof* lauten. Siehe auch **::dns::error**

**::dns::error** *token*
: Gibt die Fehlermeldung zu Anfragen mit dem Status *error* zurück. Liegt keine Fehlermeldung vor, kommt eine leere Zeichenkette zurück.

**::dns::reset** *token*
: Eine DNS-Abfrage zurücksetzen oder abbrechen.

**::dns::wait** *token*
: Wartet, bis eine DNS-Abfrage abgeschlossen ist, und gibt danach den Status zurück.

**::dns::cleanup** *token*
: Entfernt alle Zustandsvariablen, die zu der Anfrage gehören.

**::dns::nameservers**
: Versucht, eine Liste der derzeit für das System des Benutzers konfigurierten Nameserver zurückzugeben. Auf einem Unix-Rechner werden die in der Datei /etc/resolv.conf angegebenen Nameserver ausgewertet (sofern diese Datei vorhanden ist), während auf Windows-Systemen bestimmte Bereiche der Registrierung überprüft werden. Kann kein Nameserver gefunden werden, wird die Loopback-Adresse (127.0.0.1) als Standard verwendet.


# Beispiele

```
% set tok [dns::resolve www.tcl.tk]
::dns::1
% dns::status $tok
ok
% dns::address $tok
199.175.6.239
% dns::name $tok
www.tcl.tk
% dns::cleanup $tok
```

Verwendung von DNS-URIs als Abfragen:

```
% set tok [dns::resolve "dns:tcl.tk;type=MX"]
% set tok [dns::resolve "dns://l.root-servers.net/www.tcl.tk"]
```

Adressrückwärtssuche:

```
% set tok [dns::resolve 127.0.0.1]
::dns::1
% dns::name $tok
localhost
% dns::cleanup $tok
```

Verwendung von DNS über TLS (RFC 7858):

```
% set tok [dns::resolve www.tcl.tk -nameserver dns-tls.bitwiseshift.net  -usetls 1 -cafile /etc/ssl/certs/ca-certificates.crt]
::dns::12
% dns::wait $tok
ok
% dns::address $tok
104.25.119.118 104.25.120.118
```

# Literatur

1. Mockapetris, P., „Domain Names – Concepts and Facilities“, RFC 1034, November 1987. (<http://www.ietf.org/rfc/rfc1034.txt>)

2. Mockapetris, P., „Domain Names – Implementation and Specification“, RFC 1035, November 1087. (<http://www.ietf.org/rfc/rfc1035.txt>)

3. Thompson, S. und Huitema, C., „DNS-Erweiterungen zur Unterstützung von IP Version 6“, RFC 1886, Dezember 1995. (<http://www.ietf.org/rfc/rfc1886.txt>)

4. Josefsson, S., „Domain Name System Uniform Resource Identifiers“, Internet-Entwurf, Oktober 2003, (<http://www.ietf.org/internet-drafts/draft-josefsson-dns-url-09.txt>)

5. Gulbrandsen, A., Vixie, P. und Esibov, L., „Ein DNS-RR zur Festlegung des Standorts von Diensten (DNS SRV)“, RFC 2782, Februar 2000, (<http://www.ietf.org/rfc/rfc2782.txt>)

6. Ohta, M. „Incremental Zone Transfer in DNS“, RFC 1995, August 1996, (<http://www.ietf.org/rfc/rfc1995.txt>)

7. Hu, Z. et al. „Spezifikation für DNS über Transport Layer Security (TLS)“, RFC 7858, Mai 2016, (<http://www.ietf.org/rfc/rfc7858.txt>)


# Autoren

Pat Thoyts

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *dns* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2002, Pat Thoyts
```
