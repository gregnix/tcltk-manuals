---
CommandName: nameserv
ManualSection: n
Version: 0.4.3
TclPart: tcllib
TclDescription: Name service facility
Links:
 - nameserv::common(n)
 - nameserv::server(n)
Keywords:
 - client
 - name service
Copyright:
 - Copyright (c) 2007-2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

nameserv – Namensdienst-Funktion, Client

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [nameserv]{.lit} [0.4.3]{.optlit} 
[package]{.cmd} [require]{.sub} [comm]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[::nameserv::bind]{.cmd} [name]{.arg} [data]{.arg} 
[::nameserv::release]{.cmd} 
[::nameserv::search]{.cmd} [-async|-continuous]{.optlit} [pattern]{.optarg} 
[::nameserv::protocol]{.cmd} 
[::nameserv::server_protocol]{.cmd} 
[::nameserv::server_features]{.cmd} 
[::nameserv::cget]{.cmd} [-option]{.sub} 
[::nameserv::configure]{.cmd} 
[::nameserv::configure]{.cmd} [-option]{.sub} 
[::nameserv::configure]{.cmd} [-option]{.sub} [value...]{.arg} 
[\$result]{.cmd} [destroy]{.sub} 
[\$result]{.cmd} [filled]{.sub} 
[\$result]{.cmd} [get]{.sub} [name]{.arg} 
[\$result]{.cmd} [names]{.sub} 
[\$result]{.cmd} [size]{.sub} 
[\$result]{.cmd} [getall]{.sub} [pattern]{.optarg} 
:::

# BESCHREIBUNG

Bitte lesen Sie zunächst *Namensdienst-Funktion, Einleitung*.

Dieses Paket stellt einen Client für die vom Paket **nameserv::server** implementierte Namensdienstfunktion bereit.

Dieser Dienst wurde auf der Grundlage des Pakets **comm** entwickelt und ist für dieses bestimmt. Er hat nichts mit dem Domain Name System des Internets zu tun. Wenn Sie nach einem Paket suchen, das sich damit befasst, sehen Sie sich bitte die Tcllib-Pakete **dns** und **resolv** an.

# API

Das Paket exportiert acht Befehle, wie im Folgenden aufgeführt:

**::nameserv::bind** *name* *data*
: Der Aufrufer dieses Befehls registriert den angegebenen *name* als seinen Namen im konfigurierten Namensdienst und ordnet ihm zusätzlich ein Stück *data* zu. Der Dienst führt mit diesen Informationen nichts weiter aus, als sie zu speichern und als Teil der Suchergebnisse bereitzustellen. Die Bedeutung liegt vollständig bei den Anwendungen, die den Namensdienst nutzen. Eine allgemein sinnvolle Wahl wäre beispielsweise eine Kennung für einen Kommunikationsendpunkt, der vom Paket **comm** verwaltet wird. Wer den Namen abruft, kann sofort mit diesem Endpunkt, d. h. der registrierenden Anwendung, kommunizieren. Von weiterer Bedeutung ist, dass sich ein Aufrufer unter mehr als einem Namen registrieren kann und jeder Name über eigene *data* verfügen kann. Der Namensdienst – und somit auch dieser Befehl – löst einen Fehler aus, wenn der gewählte Name bereits registriert ist.

**::nameserv::release**
: Durch den Aufruf dieses Befehls werden alle Namen (und die dazugehörigen Daten) freigegeben, die bei allen bisherigen Aufrufen von **::nameserv::bind** dieses Clients registriert wurden. Hinweis: Der Namensdienst führt diesen Befehl implizit aus, wenn die Verbindung zu diesem Client unterbrochen wird.

**::nameserv::search** ?**-async**|**-continuous**? ?*pattern*?
: Dieser Befehl durchsucht den Namensdienst nach allen registrierten Namen, die dem angegebenen Glob-*pattern* entsprechen. Wird keins festgelegt, lautet das Standardmuster **\***, wodurch alles abgeglichen wird. Das Ergebnis des Befehls ist ein Dictionary, das die übereinstimmenden Namen den ihnen zur *bind*-Zeit zugeordneten Daten zuordnet. Wenn die Option **-async** oder **-continuous** festgelegt wird, ändert sich das Ergebnis dieses Befehls und wird zum Tcl-Befehl eines Objekts, das das eigentliche Ergebnis enthält. Diese beiden Optionen werden genau dann unterstützt, wenn der Dienst, mit dem der Client verbunden ist, die Protokollfunktion *Search/Continuous* unterstützt. Bei **-async** wird das Ergebnisobjekt asynchron mit den Einträgen gefüllt, die zum Zeitpunkt der Suche dem Muster entsprechen, und anschließend nicht mehr geändert. Die Option **-continuous** erweitert dieses Verhalten, indem sie den Dienst zusätzlich kontinuierlich auf das Hinzufügen und Entfernen von Einträgen überwacht, die dem Muster entsprechen, und den Inhalt des Objekts entsprechend aktualisiert. *Hinweis*: Der Aufrufer ist dafür verantwortlich, das Objekt mit einer Rückruffunktion zu konfigurieren, damit er ordnungsgemäß benachrichtigt wird, wenn das aktuelle Ergebnis (oder weitere Änderungen) eintrifft. Weitere Informationen zu diesem Objekt stehen im Abschnitt **ASYNCHRONE UND KONTINUIERLICHE SUCHVORGÄNGE**.

**::nameserv::protocol**
: Dieser Befehl gibt die höchste Version des Namensdienstprotokolls zurück, die von dem Paket unterstützt wird.

**::nameserv::server_protocol**
: Dieser Befehl gibt die höchste Version des Namensdienstprotokolls zurück, die von dem Namensdienst unterstützt wird, mit dem der Client derzeit verbunden ist.

**::nameserv::server_features**
: Dieser Befehl gibt eine Liste zurück, die die Namen der Funktionen des Namensdienstprotokolls enthält, die von dem Namensdienst unterstützt werden, mit dem der Client derzeit verbunden ist.

**::nameserv::cget** **-option**
: Dieser Befehl gibt den aktuell konfigurierten Wert für das angegebene **-option** zurück. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt **OPTIONEN**.

**::nameserv::configure**
: In dieser Form gibt der Befehl ein Dictionary mit allen unterstützten Optionen und deren aktuellen Werten zurück. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt **OPTIONEN**.

**::nameserv::configure** **-option**
: In dieser Form ist der Befehl ein Alias für „**::nameserv::cget** **-option**“. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt **OPTIONEN**.

**::nameserv::configure** **-option** *value*...
: In dieser Form wird der Befehl verwendet, um eine oder mehrere der unterstützten Optionen zu konfigurieren. Es muss mindestens eine Option angegeben werden, und auf jede Option folgt ihr neuer Wert. Die Liste der unterstützten Optionen und deren Bedeutung steht im Abschnitt **OPTIONEN**. Diese Form kann nur verwendet werden, solange der Client noch keinen Kontakt zum Namensdienst hergestellt hat. Nach Herstellung des Kontakts ist eine Neukonfiguration nicht mehr möglich. Das bedeutet, dass diese Form des Befehls zur Initialisierung des Clients vor dessen Verwendung dient. Die Befehle, die einen Kontakt mit dem Namensdienst erzwingen, lauten


**bind**
: ...siehe nächstes...

**release**
: ...siehe nächstes...

**search**
: ...siehe nächstes...

**server_protocol**
: ...siehe nächstes...

**server_features**
: 


# VERBINDUNGSVERWALTUNG

Der Client stellt automatisch eine Verbindung zum Dienst her, wenn einer der folgenden Befehle zum ersten Mal ausgeführt wird oder wenn einer der Befehle ausgeführt wird, nachdem die Verbindung unterbrochen wurde – unabhängig davon, wann dies geschehen ist.

**bind**
: ...siehe nächstes...

**release**
: ...siehe nächstes...

**search**
: ...siehe nächstes...

**server_protocol**
: ...siehe nächstes...

**server_features**
: Seit Version 0.2 des Clients wird ein Ereignis generiert, wenn die Verbindung abbricht, wodurch höhere Schichten zusätzliche Maßnahmen ergreifen können. Dies erfolgt über das Support-Paket **uevent**. Dieses und alle anderen Pakete im Zusammenhang mit dem Namensdienst reservieren hiermit das uevent-Tag *nameserv*. Alle ihre Ereignisse werden an dieses Tag gesendet.


# EREIGNISSE

Dieses Paket generiert nur ein Ereignis: *lost-connection*. Die zu diesem Ereignis bereitgestellten Detailinformationen sind ein Tcl-Dictionary. Der einzige im Dictionary enthaltene Schlüssel ist **reason**, und sein Wert ist eine Zeichenkette, die beschreibt, warum die Verbindung unterbrochen wurde. Diese Zeichenkette wird vom zugrunde liegenden Kommunikationspaket bereitgestellt, d. h. von **comm**.

# OPTIONEN

Die vom Client unterstützten Optionen dienen der Festlegung, welcher Namensdienst kontaktiert werden soll, d. h. des Standorts des Namensdienstes. Es handelt sich dabei um folgende Optionen:

**-host** *name*|*ipaddress*
: Diese Option legt fest, auf welchem Host der zu kontaktierende Namensdienst läuft, entweder über den *name* oder über die *ipaddress*. Die anfängliche Standardeinstellung lautet **localhost**, d. h., es wird erwartet, dass ein Namensdienst kontaktiert wird, der auf demselben Host läuft wie die Anwendung, die dieses Paket verwendet.

**-port** *number*
: Diese Option legt den Port fest, auf dem der zu kontaktierende Namensdienst auf eingehende Verbindungen wartet. Es muss sich um eine positive ganze Zahl (> 0) handeln, die nicht größer als 65536 (unsigned short) ist. Der anfängliche Standardwert ist die Zahl, die vom Befehl **::nameserv::common::port** zurückgegeben wird, wie sie vom Paket **::nameserv::common** bereitgestellt wird.


# ASYNCHRONE UND KONTINUIERLICHE SUCHVORGÄNGE

Asynchrone und kontinuierliche Suchvorgänge werden aufgerufen, indem entweder die Option **-async** oder **-continuous** als Argument für den Befehl **::nameserv::search** verwendet wird.

*Hinweis*: Diese beiden Optionen werden genau dann unterstützt, wenn der Dienst, mit dem der Client verbunden ist, die Protokollfunktion *Search/Continuous* unterstützt. Der vom Paket **::nameserv::server** bereitgestellte Dienst unterstützt dies seit Version 0.3.

Bei solchen Suchvorgängen ist das Ergebnis des Suchbefehls der Tcl-Befehl eines Objekts, das das eigentliche Ergebnis enthält. Die von diesen Objekten bereitgestellte API lautet wie folgt:

**Optionen:**
: 


**-command** *command_prefix*
: Diese Option ist zu setzen, wenn ein Nutzer des Ergebnisobjekts asynchrone Benachrichtigungen erhalten möchte, sobald das Suchergebnis oder Änderungen daran eintreffen. *Hinweis*: Es ist zwar möglich, über die Methode **filled** auf das Eintreffen des ersten Suchergebnisses zu prüfen und nachfolgende Änderungen durch den Vergleich der Ausgabe der Methode **getall** mit einer gespeicherten Kopie zu erkennen; dies ist jedoch nicht die empfohlene Vorgehensweise. Weitaus effizienter ist es, die Rückruffunktion **-command** zu setzen und die Benachrichtigungen bei ihrem Eintreffen zu verarbeiten. Der *command_prefix* wird mit zwei Argumenten aufgerufen: dem Typ der Änderung und den Daten der Änderung. Der Typ ist entweder **add** oder **remove**, was jeweils auf neue bzw. gelöschte Daten hinweist. Die Daten der Änderung sind stets ein Dictionary, in dem die hinzugefügten bzw. entfernten Namen und die zugehörigen Daten aufgeführt sind. Die erste für eine Suche gemeldete Änderung ist stets die Menge der zum Zeitpunkt der Suche übereinstimmenden Einträge.


**Methoden:**
: 


**\$result** **destroy**
: Löscht das Objekt und beendet jegliche fortlaufende Überwachung des Dienstes, die für das Objekt möglicherweise aktiv war.

**\$result** **filled**
: Das Ergebnis ist ein boolescher Wert, der angibt, ob das Suchergebnis bereits vorliegt (**True**) oder nicht (**False**).

**\$result** **get** *name*
: Gibt die Daten zurück, die dem angegebenen *name* zur *bind*-Zeit zugeordnet sind.

**\$result** **names**
: Gibt eine Liste zurück, die alle Namen enthält, die dem Objekt zum Zeitpunkt des Aufrufs bekannt sind.

**\$result** **size**
: Gibt einen ganzzahligen Wert zurück, der die Größe des Ergebnisses zum Zeitpunkt des Aufrufs angibt.

**\$result** **getall** ?*pattern*?
: Gibt ein Dictionary zurück, das das Suchergebnis zum Zeitpunkt des Aufrufs enthält und die übereinstimmenden Namen den ihnen zur *bind*-Zeit zugeordneten Daten zuordnet.


# GESCHICHTE

**0.3.1**
: Der SF-Fehler 1954771 wurde behoben.

**0.3**
: Der Client wurde um die Möglichkeit erweitert, asynchrone und kontinuierliche Suchvorgänge durchzuführen.

**0.2**
: Der Client wurde um die Funktion erweitert, Ereignisse zu generieren, wenn die Verbindung zum Namensdienst unterbrochen wird. Basierend auf dem Paket **uevent**.

**0.1**
: Erste Implementierung des Clients.


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
