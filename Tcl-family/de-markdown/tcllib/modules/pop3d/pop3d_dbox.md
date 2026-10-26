---
CommandName: pop3d::dbox
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Tcl POP3 Server Package
Keywords:
 - internet
 - network
 - pop3
 - protocol
 - rfc 822
Copyright:
 - Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

pop3d::dbox – Einfache Postfachdatenbank für POP3D

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pop3d::dbox]{.lit} [1.0.3]{.optlit} 
[::pop3d::dbox::new]{.cmd} [dbName]{.optarg} 
[dbName]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[dbName]{.ins} [destroy]{.sub} 
[dbName]{.ins} [base]{.sub} [base]{.arg} 
[dbName]{.ins} [add]{.sub} [mbox]{.arg} 
[dbName]{.ins} [remove]{.sub} [mbox]{.arg} 
[dbName]{.ins} [move]{.sub} [old]{.arg} [new]{.arg} 
[dbName]{.ins} [list]{.sub} 
[dbName]{.ins} [exists]{.sub} [mbox]{.arg} 
[dbName]{.ins} [locked]{.sub} [mbox]{.arg} 
[dbName]{.ins} [lock]{.sub} [mbox]{.arg} 
[dbName]{.ins} [unlock]{.sub} [mbox]{.arg} 
[dbName]{.ins} [stat]{.sub} [mbox]{.arg} 
[dbName]{.ins} [size]{.sub} [mbox]{.arg} [msgId]{.optarg} 
[dbName]{.ins} [dele]{.sub} [mbox]{.arg} [msgList]{.arg} 
[storageCmd]{.ins} [get]{.sub} [mbox]{.arg} [msgId]{.arg} 
:::

# BESCHREIBUNG

Das Paket **pop3d::dbox** bietet einfache, grundlegende Funktionen zur Verwaltung von Postfächern. Jedes Postfach-Objekt verwaltet ein einzelnes Basisverzeichnis, dessen Unterverzeichnisse die verwalteten Postfächer sind. E-Mails in einem Postfach sind Dateien im Postfachverzeichnis; jede dieser Dateien enthält eine einzelne E-Mail, Header und Body, in einem zu RFC 822 (*http://www.rfc-editor.org/rfc/rfc822.txt*) konformen Format.

Jedes Postfach-Objekt, das der unten beschriebenen Schnittstelle folgt, kann zusammen mit dem POP3-Server-Kern aus dem Paket **pop3d** verwendet werden. Insbesondere lassen sich die von diesem Paket erzeugten Objekte direkt in der Speicher-Rückruffunktion von POP3-Servern verwenden, die derselben Schnittstelle folgen wie die vom Paket **pop3d** erzeugten Server.

**::pop3d::dbox::new** ?*dbName*?
: Dieser Befehl erstellt ein neues Datenbankobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *dbName* lautet. Mit dem Befehl **dbName** können verschiedene Operationen auf der Datenbank ausgeführt werden. Er hat die folgende allgemeine Form:

**dbName** *option* ?*arg arg ...*?
: *Option* und die *arg*s legen das genaue Verhalten des Befehls fest. Für Datenbankobjekte sind folgende Befehle möglich:

*dbName* **destroy**
: Löscht die Postfachdatenbank und alle temporären Daten. Das mit dem Objekt verknüpfte Verzeichnis wird nicht gelöscht.

*dbName* **base** *base*
: Legt das Basisverzeichnis fest, in dem die zu verwaltenden Postfächer liegen. Wird diese Methode nicht aufgerufen, funktioniert keine der folgenden Methoden.

*dbName* **add** *mbox*
: Fügt der Datenbank ein Postfach mit dem Namen *mbox* hinzu. Der Name muss eine gültige Pfad-Komponente sein.

*dbName* **remove** *mbox*
: Entfernt das über *mbox* festgelegte Postfach sowie die darin enthaltenen E-Mails aus der Datenbank. Diese Methode schlägt fehl, wenn das festgelegte Postfach gesperrt ist.

*dbName* **move** *old new*
: Ändert den Namen des Postfachs *old* in *new*.

*dbName* **list**
: Gibt eine Liste zurück, die die Namen aller Postfächer im Verzeichnis enthält, das der Datenbank zugeordnet ist.

*dbName* **exists** *mbox*
: Gibt true zurück, wenn das Postfach mit dem Namen *mbox* in der Datenbank vorhanden ist, andernfalls false.

*dbName* **locked** *mbox*
: Prüft, ob das über *mbox* angegebene Postfach derzeit gesperrt ist.

*dbName* **lock** *mbox*
: Diese Methode sperrt das angegebene Postfach für die Nutzung durch eine einzelne Verbindung zum Server. Das ist nötig, damit mehrere offene Verbindungen zum selben Postfach kein Chaos anrichten. Die ergänzende Methode ist **unlock**. Der Befehl gibt true zurück, wenn die Sperre gesetzt werden konnte, andernfalls false.

*dbName* **unlock** *mbox*
: Dies ist die ergänzende Methode zu **lock**; sie hebt die Sperre für das angegebene Postfach auf.

*dbName* **stat** *mbox*
: Ermittelt die Anzahl der Nachrichten in dem angegebenen Postfach und gibt diese Zahl zurück. Diese Methode schlägt fehl, wenn das Postfach *mbox* nicht gesperrt ist.

*dbName* **size** *mbox* ?*msgId*?
: Ermittelt die Größe der durch die ID in *msgId* angegebenen Nachricht in Byte und gibt diesen Wert zurück. Der Befehl gibt die Größe des gesamten Maildrops zurück, wenn keine Nachrichten-ID angegeben wurde. Falls angegeben, muss die *msgId* im Bereich „1 … \[*dbName* **stat**\]“ liegen, andernfalls schlägt der Aufruf fehl. Wenn **stat** vor diesem Aufruf nicht aufgerufen wurde, geht **size** davon aus, dass sich keine Nachrichten im Postfach befinden.

*dbName* **dele** *mbox msgList*
: Löscht die Nachrichten, deren numerische IDs in der *msgList* enthalten sind, aus dem über *mbox* angegebenen Postfach. Die *msgList* darf nicht leer sein, da dieser Aufruf sonst fehlschlägt. Die numerischen IDs in *msgList* müssen im Bereich „1 … \[*dbName* **stat**\]“ liegen, andernfalls schlägt dieser Aufruf fehl. Wenn **stat** vor diesem Aufruf nicht aufgerufen wurde, geht **dele** davon aus, dass sich keine Nachrichten im Postfach befinden.

*storageCmd* **get** *mbox* *msgId*
: Gibt ein Handle für die angegebene Nachricht zurück. Dieses Handle ist ein MIME-Token, das der in der Dokumentation des Pakets **mime** beschriebenen Schnittstelle entspricht. Das Token ist *schreibgeschützt*. Mit anderen Worten: Der Aufrufer darf mit dem Token alles tun, außer es zu ändern. Die *msgId* muss im Bereich „1 … \[*dbName* **stat**\]“ liegen, andernfalls schlägt dieser Aufruf fehl. Wenn **stat** vor diesem Aufruf nicht aufgerufen wurde, geht **get** davon aus, dass sich keine Nachrichten im Postfach befinden.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pop3d* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
