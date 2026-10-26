---
CommandName: nns
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv(n)
 - nameserv::common(n)
Keywords:
 - application
 - client
 - name service
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

nns – Name Service Facility, Befehlszeilen-Client-Anwendung

# ÜBERSICHT

::: {.synopsis} :::
[nns]{.cmd} [bind]{.sub} [-host host]{.optarg} [-port port]{.optarg} [name]{.arg} [data]{.arg} 
[nns]{.cmd} [search]{.sub} [-host host]{.optarg} [-port port]{.optarg} [-continuous]{.optlit} [pattern]{.optarg} 
[nns]{.cmd} [ident]{.sub} [-host host]{.optarg} [-port port]{.optarg} 
[nns]{.cmd} [who]{.sub} 
:::

# BESCHREIBUNG

Bitte lesen Sie zunächst *Namensdienst-Funktion, Einleitung*.

Die in diesem Dokument beschriebene Anwendung **nns** ist ein einfacher Befehlszeilen-Client für die Nano-Namensdienstfunktion, die von den Tcllib-Paketen **nameserv** und **nameserv::server** bereitgestellt wird. Darüber hinaus dienen die Quelltexte der Anwendung auch als Beispiele für die Verwendung des Client-Pakets **nameserv**. Alle Funktionen eines Clients werden abgedeckt, von der Konfiguration über die Registrierung von Namen bis hin zur Suche.

Diese Namensdienstfunktion hat nichts mit dem *Domain Name System* des Internets zu tun, das auch als *DNS* bekannt ist. Wenn Sie nach einem Paket suchen, das sich damit befasst, sehen Sie sich bitte eines der Pakete **dns** oder **resolv** an, die beide ebenfalls in Tcllib zu finden sind.

## Anwendungsfälle

**nns** wurde unter Berücksichtigung der folgenden zwei Hauptanwendungsfälle entwickelt.

**\[1\]**
: Registrierung eines Namens-Daten-Paares im Namensdienst.

**\[2\]**
: Durchsuchen des Namensdienstes nach Einträgen, die einem Glob-Muster entsprechen. Darüber hinaus möchten wir auch den Client identifizieren und Informationen über den Namensdienst abrufen können.


## Befehlszeile

**nns** **bind** ?**-host** *host*? ?**-port** *port*? *name* *data*
: Diese Form registriert das Paar *name*/*data* im angegebenen Namensdienst. In dieser Form wird der Befehl *nicht* beendet, damit die Registrierung bestehen bleibt. Der Benutzer muss ihn ausdrücklich beenden, entweder durch ein Signal oder über die Jobsteuerung der verwendeten Shell. Der Prozess übersteht insbesondere den Verlust der Verbindung zum Namensdienst und stellt das Paar *name*/*data* wieder her, wenn die Verbindung wiederhergestellt ist. Die Optionen zur Angabe des Namensdienstes werden später im Abschnitt **Optionen** erläutert.

**nns** **search** ?**-host** *host*? ?**-port** *port*? ?**-continuous**? ?*pattern*?
: Diese Form durchsucht den angegebenen Namensdienst nach Einträgen, die dem Glob-*pattern* entsprechen, und gibt diese über stdout aus, wobei jeder Eintrag in einer eigenen Zeile steht. Wenn kein Muster festgelegt wird, wird standardmäßig **\*** verwendet, das mit allem übereinstimmt. Die Optionen zur Angabe des Namensdienstes werden später im Abschnitt **Optionen** erläutert. Wenn die Option **-continuous** festgelegt wird, beendet der Client nach Durchführung der Suche den Vorgang nicht, sondern beginnt, den Dienst kontinuierlich auf Änderungen an der Menge der übereinstimmenden Einträge zu überwachen und die Anzeige entsprechend zu aktualisieren, sobald Änderungen eintreffen. In dieser Form übersteht er insbesondere auch den Verlust der Verbindung zum Namensdienst und nimmt die Suche wieder auf, wenn die Verbindung wiederhergestellt ist.

**nns** **ident** ?**-host** *host*? ?**-port** *port*?
: Diese Form fragt den angegebenen Namensdienst nach der Version und den Funktionen des von ihm unterstützten Namensdienstprotokolls ab und gibt die Ergebnisse über stdout aus. Die Optionen zur Angabe des Namensdienstes werden später im Abschnitt **Optionen** erläutert.

**nns** **who**
: Diese Form gibt den Namen, die Version und die Protokollversion der Anwendung auf stdout aus.


## Optionen

In diesem Abschnitt werden alle Optionen beschrieben, die dem Benutzer der Anwendung zur Verfügung stehen

**-host** Name|IP-Adresse
: Wenn diese Option nicht angegeben wird, wird standardmäßig „**localhost**“ verwendet. Sie legt den Namen oder die IP-Adresse des Hosts fest, auf dem der anzusprechende Namensdienst ausgeführt wird.

**-port** Nummer
: Wenn diese Option nicht angegeben wird, wird standardmäßig „**38573**“ verwendet. Sie legt den TCP-Port fest, auf dem der anzufragende Namensdienst auf Anfragen wartet.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *nameserv* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
