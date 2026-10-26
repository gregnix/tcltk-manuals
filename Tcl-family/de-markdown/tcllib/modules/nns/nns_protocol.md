---
CommandName: nameserv::protocol
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Name service facility
Links:
 - comm_wire(n)
 - nameserv(n)
 - nameserv::server(n)
Keywords:
 - comm
 - name service
 - protocol
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

nameserv::protocol – Namensdienst-Funktion, Client/Server-Protokoll

# ÜBERSICHT

::: {.synopsis} :::
[Bind]{.cmd} [name]{.arg} [data]{.arg} 
[Release]{.cmd} 
[Search]{.cmd} [pattern]{.arg} 
[ProtocolVersion]{.cmd} 
[ProtocolFeatures]{.cmd} 
[Search/Continuous/Start]{.cmd} [tag]{.arg} [pattern]{.arg} 
[Search/Continuous/Stop]{.cmd} [tag]{.arg} 
[Search/Continuous/Change]{.cmd} [tag]{.arg} [add|remove]{.lit} [response]{.arg} 
:::

# BESCHREIBUNG

Die Pakete **nameserv::server**, **nameserv** und **nameserv::common** bieten eine einfache, ungeschützte Namensdienstfunktion für den Einsatz in kleinen, vertrauenswürdigen Umgebungen.

Bitte lesen Sie zunächst *Namensdienst-Funktion, Einleitung*.

Dieses Dokument enthält die Spezifikation des Netzwerkprotokolls, das von Client und Server zur Kommunikation untereinander verwendet wird, und ermöglicht so die Implementierung desselben Protokolls in anderen Sprachen.

# NANO-NAMENSDIENSTPROTOKOLL, VERSION 1

Dieses Protokoll definiert den grundlegenden Satz von Nachrichten, die von einem Namensdienst unterstützt werden müssen; dieser wird auch als *Core*-Funktion bezeichnet.

## Grundschicht

Die grundlegende Kommunikation zwischen Client und Server erfolgt über das Protokoll zur Fernausführung, das durch das Tcl-Paket **comm** festgelegt wird. Das entsprechende Dokument, in dem das Übertragungsprotokoll beschrieben wird, finden Sie unter *comm_wire*.

Alle über dieses Protokoll ausgetauschten Skripte bestehen aus einzelnen Befehlen in Listenform und können daher als einfache Nachrichten und nicht als Tcl-Befehle interpretiert werden. Die im folgenden Abschnitt aufgeführten Befehle/Nachrichten sind die einzigen Befehle, die von der Serverseite verstanden werden. Befehls- und Variablenersetzungen sind innerhalb der Nachrichten nicht zulässig, d. h., Argumente müssen Literalwerte sein.

Das Protokoll ist synchron. Das heißt, auf jede gesendete Nachricht wird eine Antwort erwartet, die generiert werden muss. Alle Nachrichten werden vom Client gesendet. Der Server sendet keine Nachrichten, sondern lediglich Antworten auf Nachrichten.

## Nachrichtenebene

**Bind** *name* *data*
: Der Client sendet diese Nachricht, wenn er sich beim Dienst mit einem *name* und zugehörigen *data* registriert. Der Server muss eine Fehlerantwort senden, wenn der *name* bereits vergeben ist. Andernfalls muss die Antwort eine leere Zeichenkette sein. Der Server muss mehrere Namen für denselben Client akzeptieren.

**Release**
: Der Client sendet diese Nachricht, um alle Namen, unter denen er beim Dienst registriert ist, zu löschen. Die Antwort muss stets eine leere Zeichenkette sein.

**Search** *pattern*
: Der Client sendet diese Nachricht, um den Dienst nach Namen zu durchsuchen, die dem Glob-*pattern* entsprechen. Die Antwort muss ein Dictionary sein, das die übereinstimmenden Namen als Schlüssel enthält und diese den Daten zuordnet, die zur **Bind**-Zeit mit ihnen verknüpft waren.

**ProtocolVersion**
: Der Client sendet diese Nachricht, um beim Dienst die höchste Version des Namensdienstprotokolls abzufragen, die dieser unterstützt. Die Antwort muss eine positive ganze Zahl sein. Server, die ausschließlich das *Nano Name Service Protocol Version 1* unterstützen, geben **1** zurück.

**ProtocolFeatures**
: Der Client sendet diese Nachricht, um beim Dienst die von ihm unterstützten Funktionen des Namensdienstprotokolls abzufragen. Die Antwort muss eine Liste mit den Namen der Funktionen enthalten. Server, die ausschließlich das *Nano Name Service Protocol Version 1* unterstützen, geben **{Core}** zurück.


# ERWEITERUNG DES NANO-NAMENSDIENSTPROTOKOLLS: FORTLAUFENDE SUCHE

Dieses Protokoll definiert einen erweiterten Satz von Nachrichten, die von einem Namensdienst unterstützt werden sollen; diese Funktion wird auch als *Search/Continuous*-Funktion bezeichnet. Diese Funktion definiert zusätzliche Nachrichten zwischen Client und Server und entspricht ansonsten vollständig der Version 1 des Protokolls. Einzelheiten zu unseren Grundlagen finden Sie im letzten Abschnitt.

Ein Dienst, der diese Funktion unterstützt, muss den Namen der Funktion **Search/Continuous** in die Liste der Funktionen aufnehmen, die von der Nachricht *ProtocolFeatures* zurückgegeben wird.

Bei dieser Erweiterung ist das Protokoll asynchron. Für keine der Nachrichten in der Erweiterung wird eine direkte Antwort erwartet. Darüber hinaus beginnt der Server von sich aus mit dem Versenden von Nachrichten, anstatt lediglich auf Nachrichten zu antworten, und der Client muss in der Lage sein, diese Benachrichtigungen zu verarbeiten.

**Search/Continuous/Start** *tag* *pattern*
: Der Client sendet diese Nachricht, um die Suche nach Namen, die dem Glob-*pattern* entsprechen, im Dienst zu starten. Im Gegensatz zur regulären *Search*-Anfrage fordert diese den Server auf, die Datenbank kontinuierlich auf das Hinzufügen und Entfernen passender Einträge zu überwachen und den Client über alle derartigen Änderungen zu benachrichtigen. Die jeweilige Suche wird durch das *tag* identifiziert. Es wird keine direkte Antwort erwartet; vielmehr erwarten die Clients, über Änderungen mittels expliziter *Search/Continuous/Result*-Nachrichten informiert zu werden, die vom Dienst generiert werden. Ferner wird erwartet, dass die *tag*-Information unverändert an die *Search/Continuous/Result*-Nachrichten weitergegeben wird. Diese Kennzeichnung der Ergebnisse ermöglicht es den Clients, mehrere Suchvorgänge zu starten und zwischen den verschiedenen Ergebnissen zu unterscheiden.

**Search/Continuous/Stop** *tag*
: Der Client sendet diese Nachricht, um die durch das *tag* gekennzeichnete fortlaufende Suche zu beenden.

**Search/Continuous/Change** *tag* **add**|**remove** *response*
: Diese Nachricht wird vom Dienst an Clients mit aktiven fortlaufenden Suchen gesendet, um gefundene Änderungen zu übermitteln. Die erste derartige Nachricht für eine neue fortlaufende Suche muss den aktuellen Satz übereinstimmender Einträge enthalten. Um dies sicherzustellen, muss ein Dienst eine **add**-Nachricht mit einem leeren *response*-Feld generieren, falls zu diesem Zeitpunkt keine übereinstimmenden Einträge vorhanden waren. Die *response* muss ein Dictionary sein, das die übereinstimmenden Namen als Schlüssel enthält und diese den zum Zeitpunkt von **Bind** zugehörigen Daten zuordnet. Das Argument vor der *response* teilt dem Client mit, ob die Namen in der *response* zum Dienst hinzugefügt oder daraus entfernt wurden.


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
