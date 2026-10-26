---
CommandName: udpcluster
ManualSection: n
Version: 0.3.4
TclPart: tcllib
TclDescription: Lightweight UDP based tool for cluster node discovery
Keywords:
 - name service
 - server
Copyright:
 - Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
---

# NAME

udpcluster – UDP-Peer-to-Peer-Cluster

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [udpcluster]{.lit} [0.3.4]{.optlit} 
[package]{.cmd} [require]{.sub} [ip]{.lit} 
[package]{.cmd} [require]{.sub} [nettool]{.lit} 
[package]{.cmd} [require]{.sub} [comm]{.lit} 
[package]{.cmd} [require]{.sub} [interp]{.lit} 
[package]{.cmd} [require]{.sub} [dicttool]{.lit} 
[package]{.cmd} [require]{.sub} [cron]{.lit} 
:::

# BESCHREIBUNG

Dieses Paket ist eine schlanke Alternative zu Zeroconf. Es nutzt UDP-Pakete, um eine Tabelle der Dienste zu füllen, die jeder Knoten in einem lokalen Netzwerk anbietet. Jeder Teilnehmer sendet per Broadcast eine Schlüssel-Wert-Liste als Klartext in UTF-8. Darin steht, welche Ports offen sind und welche Protokolle an diesen Ports erwartet werden. Entwickler können darüber hinaus beliebige weitere Schlüssel-Wert-Paare hinzufügen.

Verwendung von udpcluster.

Rufen Sie für jeden Dienst, den Sie veröffentlichen möchten, folgenden Befehl auf:

```
cluster::publish echo@[cluster::macid] {port 10000 protocol echo}
```

Um abzufragen, welche Dienste im lokalen Netzwerk verfügbar sind:

```
set results [cluster::search PATTERN]
# And inside that result...
echo@LOCALMACID {
   port 10000
   protocol echo
}
```

So heben Sie die Veröffentlichung eines Dienstes auf:

```
cluster::unpublish echo@[cluster::macid]
```

Historische Hinweise:

Dieses Werkzeug war ursprünglich als nns::cluster bekannt. Im Laufe der Entwicklung wurde klar, dass es mit keiner der anderen Einrichtungen in NNS zusammenarbeitete.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *nameserv* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2016-2018 Sean Woods <yoda@etoyoc.com>
```
