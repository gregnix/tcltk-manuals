---
CommandName: uri_urn
title: uri_urn
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Tcl Uniform Resource Identifier Management
Keywords:
 - rfc 2141
 - uri
 - url
 - urn
Copyright:
---

# Name

uri\_urn – URI-Dienstprogramme, URN-Schema

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [uri::urn]{.lit} [1.0.4]{.optlit}
[uri::urn::quote]{.cmd} [url]{.arg}
[uri::urn::unquote]{.cmd} [url]{.arg}
:::

# Beschreibung

Dieses Paket stellt zwei Befehle zum Ein- und Ausklemmen der unzulässigen Zeichen für URLs unter Verwendung des *urn*-Schemas bereit, registriert das Schema beim Paket **uri**, und stellt interne Hilfsfunktionen bereit, die automatisch von den Befehlen [uri::split][uri] und [uri::join][uri] des Pakets **uri** verwendet werden, um URLs nach dem *urn*-Schema zu verarbeiten.

# Befehle

**uri::urn::quote** *url*
: Dieser Befehl setzt die Zeichen, die gemäß dem *urn*-Schema (gemäß RFC 2141, Abschnitt 2.2) in der *url* nicht zulässig sind, in Anführungszeichen und gibt die geänderte URL als Ergebnis zurück.

**uri::urn::unquote** *url*
: Dieser Befehl führt das Gegenteil von **::uri::urn::quote** aus. Er nimmt eine *urn*-URL entgegen, entfernt die Anführungszeichen um alle unzulässigen Zeichen und gibt die geänderten URLs als Ergebnis zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *uri* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk


[uri]: uri.md
