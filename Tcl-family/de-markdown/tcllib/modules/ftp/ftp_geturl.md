---
CommandName: ftp::geturl
title: ftp::geturl
ManualSection: n
Version: 0.2.3
TclPart: tcllib
TclDescription: ftp client
Links:
 - ftpd
 - mime
 - pop3
 - smtp
Keywords:
 - ftp
 - internet
 - net
 - rfc 959
Copyright:
---

# Name

ftp::geturl – URI-Handler für FTP-URLs

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ftp::geturl]{.lit} [0.2.3]{.optlit}
[::ftp::geturl]{.cmd} [url]{.arg}
:::

# Beschreibung

Dieses Paket stellt einen Befehl bereit, der die clientseitige Implementierung des *ftp*-Protokolls, das vom Paket **ftp** bereitgestellt wird, umsetzt, um das Abrufen von URLs unter Verwendung des *ftp*-Schemas zu ermöglichen.

# API

**::ftp::geturl** *url*
: Dieser Befehl kann vom generischen Befehl **::uri::geturl** (siehe Paket **uri**) verwendet werden, um den Inhalt von FTP-URLs abzurufen. Intern nutzt er die Befehle des Pakets **ftp**, um die Anfrage zu bearbeiten.

    Der Inhalt einer *ftp*-URL ist wie folgt definiert:

    *file*
    : Der Inhalt der angegebenen Datei selbst.

    *directory*
    : Eine Auflistung des Inhalts des Verzeichnisses in Schlüssel-Wert-Notation, wobei der Dateiname den Schlüssel und die Attribute den zugehörigen Wert bilden.

    *link*
    : Die Attribute des Links, einschließlich des Pfads, auf den er verweist.



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ftp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk
