---
CommandName: comm
ManualSection: n
Version: 4.7.3
TclPart: tcllib
TclDescription: Remote communication
Links:
 - send(n)
Keywords:
 - comm
 - communication
 - ipc
 - message
 - remote communication
 - remote execution
 - rpc
 - secure
 - send
 - socket
 - ssl
 - tls
Copyright:
 - Copyright (c) 1995-1998 The Open Group. All Rights Reserved.
 - Copyright (c) 2003-2004 ActiveState Corporation.
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

comm – Eine Fernkommunikationsfunktion für Tcl (ab Version 8.5)

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [comm]{.lit} [4.7.3]{.optlit} 
[::comm::comm]{.cmd} [send]{.sub} [-async]{.optarg} [-command callback]{.optarg} [id]{.arg} [cmd]{.arg} [arg arg]{.optdot} 
[::comm::comm]{.cmd} [self]{.sub} 
[::comm::comm]{.cmd} [interps]{.sub} 
[::comm::comm]{.cmd} [connect]{.sub} [id]{.optarg} 
[::comm::comm]{.cmd} [new]{.sub} [chan]{.arg} [name value]{.optdot} 
[::comm::comm]{.cmd} [channels]{.sub} 
[::comm::comm]{.cmd} [config]{.sub} 
[::comm::comm]{.cmd} [config]{.sub} [name]{.arg} 
[::comm::comm]{.cmd} [config]{.sub} [name value]{.optdot} 
[::comm::comm]{.cmd} [shutdown]{.sub} [id]{.arg} 
[::comm::comm]{.cmd} [abort]{.sub} 
[::comm::comm]{.cmd} [destroy]{.sub} 
[::comm::comm]{.cmd} [hook]{.sub} [event]{.arg} [+]{.optlit} [script]{.optarg} 
[::comm::comm]{.cmd} [remoteid]{.sub} 
[::comm::comm_send]{.cmd} 
[::comm::comm]{.cmd} [return_async]{.sub} 
[\$future]{.cmd} [return]{.sub} [-code code]{.optarg} [value]{.optarg} 
[\$future]{.cmd} [configure]{.sub} [-command ?cmdprefix]{.optarg} 
[\$future]{.cmd} [cget]{.sub} [-command]{.lit} 
:::

# BESCHREIBUNG

Der Befehl **comm** bietet eine Einrichtung zur entfernten Ausführung zwischen Interpretern, ähnlich wie **send(n)** von Tk, mit dem Unterschied, dass er für den Kommunikationspfad Sockets anstelle des X-Servers verwendet.  Daher funktioniert **comm** mit mehreren Interpretern, läuft auf Windows- und Macintosh-Systemen und bietet Kontrolle über den Pfad der entfernten Ausführung.

Diese Befehle funktionieren genau wie **send** und **winfo interps**:

```
    ::comm::comm send ?-async? id cmd ?arg arg ...?
    ::comm::comm interps
```

Das ist alles, was Sie wirklich wissen müssen, um **comm** zu verwenden.

## Befehle

Das Paket initialisiert **::comm::comm** als Standard-*chan*.

**comm** benennt Kommunikationsendpunkte mit einer *id*, die auf jedem Rechner eindeutig ist. Vor dem Senden von Befehlen wird die *id* eines anderen Interpreters benötigt.  Im Gegensatz zu Tks send kennt **comm** nicht implizit die *id*s aller Interpreter im System. Die folgenden vier Methoden bilden die grundlegende **comm**-Schnittstelle.

**::comm::comm send** ?-async? ?-command *callback*? *id* *cmd* ?*arg arg ...*?
: Ruft den angegebenen Befehl im Interpreter mit dem Namen *id* auf. Der Befehl wartet auf das Ergebnis, und entfernte Fehler werden zurückgegeben, sofern nicht die Option **-async** oder **-command** angegeben ist.  Ist **-async** angegeben, kehrt send sofort zurück, und es erfolgt keine weitere Benachrichtigung über das Ergebnis.  Wird **-command** verwendet, legt *callback* einen Befehl fest, der beim Empfang des Ergebnisses aufgerufen wird.  Diese Optionen schließen sich gegenseitig aus.  Die Rückruffunktion erhält Argumente in der Form *-option value*, geeignet für **array set**. Die Optionen sind: *-id*, die Comm-ID des Interpreters, der den Befehl empfangen hat; *-serial*, eine eindeutige Seriennummer für jeden Befehl, der an einen bestimmten Comm-Interpreter gesendet wurde; *-chan*, der Name des Comm-Kanals; *-code*, der Ergebniscode des Befehls; *-errorcode*, der Fehlercode des Befehls, falls vorhanden; *-errorinfo*, die Fehlerinformation des Befehls, falls vorhanden; und *-result*, der Rückgabewert des Befehls. Geht die Verbindung verloren, bevor eine Antwort empfangen wird, wird die Rückruffunktion mit einer Meldung über den Verbindungsverlust aufgerufen, wobei -code gleich -1 ist. Bei Verwendung von **-command** gibt der Befehl die eindeutige Seriennummer des Befehls zurück.

**::comm::comm self**
: Gibt die *id* für diesen Kanal zurück.

**::comm::comm interps**
: Gibt eine Liste aller entfernten *id*s zurück, mit denen dieser Kanal verbunden ist.  **comm** lernt eine neue entfernte *id* kennen, wenn zum ersten Mal ein Befehl an sie gesendet wird oder wenn eine entfernte *id* zum ersten Mal einen Befehl an diesen comm-Kanal sendet. **::comm::comm ids** ist ein Alias für diese Methode.

**::comm::comm connect** ?*id*?
: Während **::comm::comm send** automatisch eine Verbindung zur angegebenen *id* herstellt, erzwingt dieser Befehl eine Verbindung zu einer entfernten *id*, ohne dass ein Befehl gesendet wird. Danach erscheint die entfernte *id* in **::comm::comm interps**.


## Auswertungssemantik

Die Semantik der Auswertung von **::comm::comm send** ist so ausgelegt, dass sie *genau* mit der von **send** aus Tk übereinstimmt. Das bedeutet, dass **comm** die Argumente auf der entfernten Seite auswertet.

Sollten Sie feststellen, dass **::comm::comm send** bei einem bestimmten Befehl nicht funktioniert, versuchen Sie dasselbe mit send von Tk und prüfen Sie, ob das Ergebnis anders ausfällt. Sollte ein Problem vorliegen, melden Sie es bitte.  So gab es beispielsweise einen Bericht, wonach dieser Befehl einen Fehler verursachte.  Hinweis: Der entsprechende Befehl **send** verursacht ebenfalls denselben Fehler.

```
    % ::comm::comm send id llength {a b c}
    wrong # args: should be "llength list"
    % send name llength {a b c}
    wrong # args: should be "llength list"
```

Mit dem Hook **eval** (siehe unten) lässt sich von der doppelten Auswertungssemantik von **send** auf eine einfache Auswertungssemantik umstellen.

## Mehrere Kanäle

In jedem Tcl-Interpreter können mehrere **comm**-Kanäle (oder *Listener*) angelegt werden. Das gibt die Flexibilität, vollständige und eingeschränkte Kanäle anzulegen. So sind beispielsweise *Hook*-Skripte spezifisch für den Kanal, für den sie definiert wurden.

**::comm::comm new** *chan* ?*name value ...*?
: Erstellt einen neuen Kanal und einen Tcl-Befehl mit dem angegebenen Kanalnamen. Dieser neue Befehl steuert den neuen Kanal und akzeptiert dieselben Argumente wie **::comm::comm**.  Alle verbleibenden Argumente werden an die Methode **config** übergeben. Der vollständig qualifizierte Name des Kanals wird zurückgegeben.

**::comm::comm channels**
: Listet alle in diesem Tcl-Interpreter angelegten Kanäle auf. Die Standard-Konfigurationsparameter für einen neuen Kanal lauten:


```
    "-port 0 -local 1 -listen 0 -silent 0"
```

Der Standardkanal **::comm::comm** wird wie folgt angelegt:

```
    "::comm::comm new ::comm::comm -port 0 -local 1 -listen 1 -silent 0"
```

## Kanal-Konfiguration

Die Methode **config** verhält sich ähnlich wie **fconfigure**: Sie setzt oder erfragt Konfigurationsvariablen, die einem Kanal zugeordnet sind.

**::comm::comm config**
: ...siehe nächstes...

**::comm::comm config** *name*
: ...siehe nächstes...

**::comm::comm config** ?*name* *value* *...*?
: Ohne Argumente gibt **config** eine Liste aller Variablen und ihrer Werte zurück. Bei einem Argument gibt **config** den Wert eben dieses Arguments zurück.  Bei einer geraden Anzahl von Argumenten werden die angegebenen Variablen auf die angegebenen Werte gesetzt. Diese Konfigurationsvariablen können geändert werden (Beschreibungen dazu finden Sie an anderer Stelle in dieser Handbuchseite):

**-listen** ?*0|1*?
: ...siehe nächstes...

**-local**  ?*0|1*?
: ...siehe nächstes...

**-port**   ?*port*?
: ...siehe nächstes...

**-silent** ?*0|1*?
: ...siehe nächstes...

**-socketcmd** ?*commandname*?
: ...siehe nächstes...

**-interp** ?*interpreter*?
: ...siehe nächstes...

**-events** ?*eventlist*?
: Diese Konfigurationsvariablen sind schreibgeschützt:

**-chan**    *chan*
: ...siehe nächstes...

**-serial**  *n*
: ...siehe nächstes...

**-socket**  sock*In*
: Wenn **config** die Parameter eines bestehenden Kanals ändert (mit Ausnahme von **-interp** und **-events**), schließt es den lauschenden Socket und öffnet ihn neu. Eine automatisch zugewiesene Kanal-*id* ändert sich dabei. Das Erneuern des Sockets geschieht durch den Aufruf von **::comm::comm abort**, wodurch alle aktiven Sendevorgänge beendet werden.


## ID-/Port-Zuordnungen

**comm** verwendet einen TCP-Port als Endpunkt-*id*. Die Methode **interps** (oder **ids**) listet lediglich alle TCP-Ports auf, mit denen der Kanal verbunden ist.  Standardmäßig wird die *id* jedes Kanals vom Betriebssystem zufällig zugewiesen (beginnt jedoch in der Regel bei einem niedrigen Wert um 1024 und erhöht sich bei jeder Eröffnung eines neuen Sockets).  Dieses Verhalten wird erreicht, indem der Konfigurationsoption **-port** der Wert 0 zugewiesen wird.  Alternativ kann für einen bestimmten Kanal eine spezifische TCP-Portnummer angegeben werden. Als Sonderfall enthält comm Code, der mit **-port {}** einen hochnummerierten TCP-Port (>10000) belegt.  Beachten Sie, dass ein Kanal nur dann erstellt und initialisiert wird, wenn der angegebene Port belegt werden kann.

Als Sonderfall gilt: Wenn der Kanal mit **-listen 0** konfiguriert ist, erstellt er keinen lauschenden Socket und verwendet für sich selbst die ID **0**.  Ein solcher Kanal eignet sich nur für ausgehende Verbindungen (obwohl er, sobald eine Verbindung hergestellt ist, Sendeverkehr in beide Richtungen übertragen kann). Als weiterer Sonderfall gilt: Wenn der Kanal mit **-silent 0** konfiguriert ist, ignoriert die lauschende Seite Verbindungsversuche, bei denen die Protokollaushandlungsphase fehlgeschlagen ist, anstatt einen Fehler auszugeben.

## Ausführungsumgebung

Ein Kommunikationskanal verwendet in seiner Standardkonfiguration den aktuellen Interpreter für die Ausführung aller empfangenen Skripte sowie der Skripte für Ereignisse, die den verschiedenen Hooks zugeordnet sind.

Diese unsichere Konfiguration kann vom Benutzer über die beiden Optionen **-interp** und **-events** geändert werden.

Wenn **-interp** gesetzt ist, werden alle empfangenen Skripte in dem als Wert der Option angegebenen Slave-Interpreter ausgeführt. Es wird vorausgesetzt, dass dieser Interpreter bereits vor der Konfiguration vorhanden ist. Das heißt, es liegt in der Verantwortung des Benutzers, diesen zu erstellen. Danach übernimmt jedoch der Kommunikationskanal den Besitz dieses Interpreters und zerstört ihn, wenn der Kommunikationskanal zerstört wird. Beachten Sie, dass eine Neukonfiguration des Kommunikationskanals auf einen anderen Interpreter oder auf die leere Zeichenkette den Besitz aufgibt, *ohne* den zuvor konfigurierten Interpreter zu zerstören. Die leere Zeichenkette hat eine besondere Bedeutung: Sie stellt das Standardverhalten wieder her, bei dem empfangene Skripte im aktuellen Interpreter ausgeführt werden.

*Ebenfalls zu beachten* ist, dass Antworten und Rückrufe (eine besondere Form der Antwort) *nicht* als empfangene Skripte gelten. Sie sind vertrauenswürdig, Teil der internen Mechanik von comm und werden daher stets im aktuellen Interpreter ausgeführt.

Selbst wenn ein Interpreter als Ausführungsumgebung für empfangene Skripte konfiguriert wurde, werden die mit den verschiedenen Hooks verbundenen Ereignisskripte standardmäßig weiterhin im aktuellen Interpreter ausgeführt. Um dies zu ändern, verwenden Sie die Option **-events**, um eine Liste der Ereignisse anzugeben, deren Skripte ebenfalls im angegebenen Interpreter ausgeführt werden sollen. Der Inhalt dieser Option wird ignoriert, wenn der Kanal so konfiguriert ist, dass empfangene Skripte im aktuellen Interpreter ausgeführt werden.

## Entfernte Interpreter

Standardmäßig ist jeder Kanal darauf beschränkt, nur Verbindungen vom lokalen System anzunehmen. Dies lässt sich mit der Konfigurationsoption **-local 0** aufheben. Bei solchen Kanälen hat der Parameter *id* die Form *{ id host }*.

*WARNUNG*: Der *host* muss stets in derselben Form angegeben werden (z. B. entweder als vollqualifizierter Domänenname, einfacher Hostname oder als IP-Adresse).

## Verbindungen schließen

Diese Methoden geben Kontrolle über das Schließen von Verbindungen:

**::comm::comm shutdown** *id*
: Schließt die Verbindung zu *id* und bricht alle noch laufenden Befehle ab. Beachten Sie, dass nichts verhindert, dass die Verbindung durch einen anderen eingehenden oder ausgehenden Befehl sofort wieder geöffnet wird.

**::comm::comm abort**
: Ruft shutdown für alle offenen Verbindungen in diesem comm-Kanal auf.

**::comm::comm destroy**
: Bricht alle Verbindungen ab und zerstört dann diesen comm-Kanal selbst, einschließlich des Schließens des lauschenden Sockets.  Spezieller Code erlaubt es, den Standardkanal **::comm::comm** so zu schließen, dass der Befehl **::comm::comm** nicht zerstört wird.  Dabei wird der lauschende Socket geschlossen, wodurch sowohl eingehende als auch ausgehende Befehle auf dem Kanal verhindert werden. Diese Abfolge initialisiert den Standardkanal neu:


```
    "::comm::comm destroy; ::comm::comm new ::comm::comm"
```

Wenn eine entfernte Verbindung verloren geht (weil die Gegenseite beendet wurde oder **shutdown** aufgerufen hat), kann **comm** eine Rückruffunktion der Anwendung aufrufen. Damit lässt sich beispielsweise ein Hilfsprozess aufräumen oder neu starten.  Siehe die Rückruffunktion *lost* weiter unten.

## Callbacks

Dies ist ein Mechanismus zum Setzen von Hooks für bestimmte Ereignisse:

**::comm::comm hook** *event* ?**+**? ?*script*?
: Verwendet eine Syntax ähnlich dem Tk-Befehl **bind**.  Wird *script* ein **+** vorangestellt, wird das neue Skript angehängt. Ohne dieses ersetzt ein neues *script* jedes vorhandene Skript.  Wird der Befehl ohne Skript aufgerufen, erfolgt keine Änderung.  In allen Fällen gibt der Befehl das neue Hook-Skript zurück. Wenn ein *event* eintritt, wird das damit verknüpfte *script* ausgewertet, wobei die aufgeführten Variablen im Gültigkeitsbereich vorhanden und verfügbar sind. Der Rückgabecode (*nicht* der Rückgabewert) des Skripts wird üblicherweise verwendet, um zu entscheiden, wie nach dem Hook weiter verfahren werden soll. Zu den gängigen Variablen gehören:


**chan**
: der Name des comm-Kanals (und des Befehls)

**id**
: die ID der betreffenden Gegenseite

**fid**
: die Datei-ID für den Socket der Verbindung


Dies sind die definierten *events*:

**connecting**
: Variablen: **chan**, **id** Dieser Hook wird aufgerufen, bevor eine Verbindung zu der in *id* genannten Gegenseite hergestellt wird.  Eine Fehlerrückgabe (über **error**) bricht den Verbindungsversuch mit dem Fehler ab.  Beispiel:


```
    % ::comm::comm hook connecting {
        if {[string match {*[02468]} $id]} {
            error "Can't connect to even ids"
        }
    }
    % ::comm::comm send 10000 puts ok
    Connect to remote failed: Can't connect to even ids
    %
```

**connected**
: Variablen: **chan**, **fid**, **id**, **host** und **port**. Dieser Hook wird unmittelbar nach dem Herstellen einer entfernten Verbindung zu *id* aufgerufen und ermöglicht eine beliebige Authentifizierung über den durch *fid* benannten Socket. Eine Fehlerrückgabe (über **error**) führt zum Schließen der Verbindung mit dem entsprechenden Fehler.  *host* und *port* werden lediglich aus *id* extrahiert; eine Änderung dieser Werte hat jedoch keine Auswirkungen auf die Verbindung. Es ist zudem möglich, *fid* auszutauschen und zu ersetzen.

**incoming**
: Variablen: **chan**, **fid**, **addr** und **remport**. Dieser Hook wird beim Empfang einer eingehenden Verbindung aufgerufen und ermöglicht eine beliebige Authentifizierung über den mit *fid* benannten Socket. Eine Fehlerrückgabe (über **error**) führt zur Schließung der Verbindung mit dem entsprechenden Fehler.  Beachten Sie, dass die Gegenstelle durch *remport* und *addr* benannt ist, die entfernte *id* aber noch unbekannt ist.  Beispiel:


```
    ::comm::comm hook incoming {
        if {[string match 127.0.0.1 $addr]} {
            error "I don't talk to myself"
        }
    }
```

**eval**
: Variablen: **chan**, **id**, **cmd** und **buffer**. Dieser Hook wird aufgerufen, nachdem ein vollständiges Skript von einer Gegenseite gesammelt wurde, jedoch *vor* seiner Auswertung. Dies ermöglicht die vollständige Kontrolle über die Verarbeitung eingehender Befehle. *cmd* enthält entweder **send** oder **async**.  *buffer* enthält das auszuwertende Skript. Zum Zeitpunkt des Aufrufs des Hooks ist der Wert von *\$chan remoteid* identisch mit dem Wert von *id*. Durch Ändern von *buffer* kann der Hook das auszuwertende Skript ändern.  Der Hook kann die Auswertung kurzschließen und bewirken, dass sofort ein Wert zurückgegeben wird, indem er **return** *result* (oder innerhalb einer Prozedur **return -code return** *result*) verwendet.  Eine Fehlerrückgabe (über **error**) gibt ein Fehlerergebnis zurück, so als hätte das Skript den Fehler verursacht. Bei jeder anderen Rückgabe wird das Skript in *buffer* wie gewohnt ausgewertet.  Aus Gründen der Kompatibilität mit Version 3.2 werden **break** und **return -code break** *result* unterstützt, die ähnlich wie **return {}** und **return -code return** *result* funktionieren. Beispiele:


**\[1\]**
: Erweiterung eines Befehls


```
    % ::comm::comm send [::comm::comm self] pid
    5013
    % ::comm::comm hook eval {puts "going to execute $buffer"}
    % ::comm::comm send [::comm::comm self] pid
    going to execute pid
    5013
```

**\[2\]**
: Einen Befehl kurzschließen


```
    % ::comm::comm hook eval {puts "would have executed $buffer"; return 0}
    % ::comm::comm send [::comm::comm self] pid
    would have executed pid
    0
```

**\[3\]**
: Ersetzen der doppelten Auswertungssemantik


```
    % ::comm::comm send [::comm::comm self] llength {a b c}
    wrong # args: should be "llength list"
    % ::comm::comm hook eval {return [uplevel #0 $buffer]}
    return [uplevel #0 $buffer]
    % ::comm::comm send [::comm::comm self] llength {a b c}
    3
```

**\[4\]**
: Verwendung eines Slave-Interpreters


```
    % interp create foo
    % ::comm::comm hook eval {return [foo eval $buffer]}
    % ::comm::comm send [::comm::comm self] set myvar 123
    123
    % set myvar
    can't read "myvar": no such variable
    % foo eval set myvar
    123
```

**\[5\]**
: Verwendung eines Slave-Interpreters (doppelte Auswertung)


```
    % ::comm::comm hook eval {return [eval foo eval $buffer]}
```

**\[6\]**
: Das auszuführende Skript unterlaufen


```
    % ::comm::comm hook eval {
        switch -- $buffer {
            a {return A-OK}
            b {return B-OK}
            default {error "$buffer is a no-no"}
        }
    }
    % ::comm::comm send [::comm::comm self] pid
    pid is a no-no
    % ::comm::comm send [::comm::comm self] a
    A-OK
```

**reply**
: Variablen: **chan**, **id**, **buffer**, **ret** und **return()**. Dieser Hook wird aufgerufen, nachdem ein vollständiges Antwortskript von einer Gegenseite gesammelt wurde, jedoch *vor* seiner Auswertung. Dies ermöglicht die vollständige Kontrolle über die Verarbeitung von Antworten auf gesendete Befehle. Der Antwort-*buffer* liegt in einer der folgenden Formen vor


**•**
: return result

**•**
: return -code code result

**•**
: return -code code -errorinfo info -errorcode ecode msg


Aus Sicherheitsgründen wird dies zerlegt. Das Rückgabeergebnis steht in *ret*, die Schalter von return stehen im Array return:

**•**
: *return(-code)*

**•**
: *return(-errorinfo)*

**•**
: *return(-errorcode)*


Jede dieser Variablen kann die leere Zeichenkette sein. Durch Ändern dieser vier Variablen lässt sich der Rückgabewert ändern, während das Ändern von *buffer* keine Auswirkungen hat.

**callback**
: Variablen: **chan**, **id**, **buffer**, **ret** und **return()**. Ähnlich wie *reply*, wird jedoch für Rückrufe verwendet.

**lost**
: Variablen: **chan**, **id** und **reason**. Dieser Hook wird aufgerufen, wenn die Verbindung zu **id** verloren geht.  Der Rückgabewert (oder ein ausgelöster Fehler) wird ignoriert. *reason* ist eine erklärende Zeichenkette, die angibt, warum die Verbindung verloren ging. Beispiel:


```
    ::comm::comm hook lost {
        global myvar
        if {$myvar(id) == $id} {
            myfunc
            return
        }
    }
```

## Nicht unterstützt

Diese Schnittstellen können sich in späteren Versionen ändern oder wegfallen.

**::comm::comm remoteid**
: Gibt die *id* des Absenders des letzten auf diesem Kanal ausgeführten entfernten Befehls zurück.  Wird diese Methode von einer Prozedur verwendet, die entfernt aufgerufen wird, muss sie aufgerufen werden, bevor Ereignisse verarbeitet werden.  Andernfalls könnte ein anderer Befehl aufgerufen werden, der den Wert verändert.

**::comm::comm_send**
: Durch den Aufruf dieser Prozedur werden die Tk-Befehle **send** und **winfo interps** durch diese Entsprechungen ersetzt, die **::comm::comm** verwenden.


```
    proc send {args} {
        eval ::comm::comm send $args
    }
    rename winfo tk_winfo
    proc winfo {cmd args} {
        if {![string match in* $cmd]} {
            return [eval [list tk_winfo $cmd] $args]
        }
        return [::comm::comm interps]
    }
```

## Sicherheit

Ab Version 4.6 des Pakets wird die Option **-socketcmd** unterstützt, mit der der Benutzer eines comm-Kanals festlegen kann, welcher Befehl beim Öffnen eines Sockets verwendet werden soll. Es kann alles verwendet werden, was API-kompatibel mit dem eingebauten **::socket** (dem Standard) ist.

Die vorgesehene Hauptanwendung ist die Angabe des Befehls **tls::socket** (siehe Paket **tls**), um die Kommunikation abzusichern.

```
	# Load and initialize tls
	package require tls
	tls::init  -cafile /path/to/ca/cert -keyfile ...

	# Create secured comm channel
	::comm::comm new SECURE -socketcmd tls::socket -listen 1
	...
```

Die Abschnitte **Ausführungsumgebung** und **Callbacks** sind ebenfalls für die Sicherheit des Systems von Bedeutung, da sie Möglichkeiten bieten, die Ausführung auf eine bestimmte Umgebung zu beschränken, zusätzliche Authentifizierungen durchzuführen und Ähnliches.

## Blockierungssemantik

Es gibt einen wesentlichen Unterschied zwischen **comm** und **send**.  Beim Blockieren in einem synchronen entfernten Befehl verwendet **send** einen internen C-Hook (Tk_RestrictEvents) in die Ereignisschleife, um vorab nach send-bezogenen Ereignissen zu suchen und nur diese zu verarbeiten, ohne andere Ereignisse zu verarbeiten.  Im Gegensatz dazu verwendet **comm** den Befehl **vwait** als Semaphor, um anzuzeigen, dass die Antwortnachricht eingetroffen ist.  Der Unterschied besteht darin, dass ein synchroner **send** die Anwendung blockiert und die Verarbeitung aller Ereignisse (einschließlich fensterbezogener Ereignisse) verhindert, während ein synchroner **::comm::comm send** die Anwendung zwar blockiert, die Verarbeitung anderer Ereignisse jedoch weiterhin zulässt.  Insbesondere werden **after idle**-Handler sofort ausgelöst, wenn comm blockiert.

Was lässt sich dagegen tun?  Beachten Sie zunächst, dass dieses Verhalten bei jedem Code auftritt, der **vwait** verwendet, um zu blockieren und auf das Eintreten eines Ereignisses zu warten.  Auf Kosten der Unterstützung mehrerer Kanäle könnte **comm** so geändert werden, dass es blockierende E/A am Socket durchführt, was eine send-ähnliche Blockierungssemantik ergibt. Die Unterstützung mehrerer Kanäle ist jedoch eine sehr nützliche Eigenschaft von comm, die als zu wichtig gilt, um darauf zu verzichten.  Die verbleibenden Ansätze erfordern ein neues, in C geschriebenes ladbares Modul (was der Philosophie von **comm** etwas widerspricht). Eine Möglichkeit wäre die Erstellung einer modifizierten Version des Befehls **vwait**, die die Angabe der an Tcl_DoOneEvent übergebenen Ereignisflags ermöglicht. Bei **comm** würden lediglich die TCL_FILE_EVENTS verarbeitet werden.  Ein weiterer Ansatz wäre die Implementierung eines Mechanismus ähnlich wie Tk_RestrictEvents, der jedoch auf die Tcl-Ereignisschleife angewendet wird (da **comm** kein Tk erfordert).  Einer dieser Ansätze wird in einer zukünftigen Version von **comm** als optionale Komponente verfügbar sein.

## Asynchrone Ergebniserzeugung

Standardmäßig ist das Ergebnis, das ein entfernt aufgerufener Befehl zurückgibt, das Ergebnis, das an den Aufrufer zurückgesendet wird. Das bedeutet, dass das Ergebnis synchron erzeugt wird und der Server, der den Aufruf bearbeitet, für die Dauer der Befehlsausführung blockiert ist.

Dies ist zwar vertretbar, solange auf dem Server nur kurz laufende Befehle ausgeführt werden; lang laufende Befehle, wie beispielsweise Datenbankabfragen, stellen jedoch ein Problem dar. Ein einzelner Befehl kann die Bearbeitung der Anfragen aller anderen Clients für einen beliebigen Zeitraum verhindern.

Vor Version 4.5 von comm bestand die einzige Lösung darin, den Serverbefehl so umzuschreiben, dass er den eingebauten Tcl-Befehl **vwait** oder einen seiner Verwandten wie **tkwait** verwendet, um eine neue Ereignisschleife zu öffnen, die Anfragen verarbeitet, während der lang andauernde Vorgang ausgeführt wird. Dies birgt jedoch eigene Risiken, da dadurch sowohl ein Überlauf des Tcl-Stacks durch eine große Anzahl von Ereignisschleifen möglich ist als auch die Gefahr besteht, dass neuere Anfragen die Rückgabe älterer Anfragen blockieren, da die Ereignisschleifen in der Reihenfolge ihrer Erstellung abgebaut werden müssen.

Die richtige Lösung besteht darin, dass der aufgerufene Befehl **comm** mitteilt, dass er kein sofortiges, synchrones Ergebnis liefern kann oder will, dies jedoch zu einem späteren Zeitpunkt tun wird. Dann kann der Rahmen das Senden des eigentlichen Ergebnisses zurückstellen und die Verarbeitung der Anfragen in der Hauptereignisschleife fortsetzen. Keine Blockierung, keine Verschachtelung von Ereignisschleifen. Zu einem späteren Zeitpunkt liefert der lang andauernde Vorgang das Ergebnis über das Future-Objekt an comm, das es dann wie gewohnt an den Aufrufer weiterleitet.

Die für diese Lösung erforderliche Unterstützung wurde seit Version 4.5 in Form der neuen Methode **return_async** in comm integriert.

**::comm::comm return_async**
: Dieser Befehl wird von einem entfernt aufgerufenen Skript verwendet, um dem comm-Kanal, der es aufgerufen hat, mitzuteilen, dass das an den Aufrufer zurückzusendende Ergebnis nicht synchron erzeugt wird. Wird dieser Befehl nicht aufgerufen, sendet comm standardmäßig das synchron erzeugte Ergebnis des Skripts selbst an den Aufrufer. Das Ergebnis von **return_async** ist ein Objekt. An dieses Objekt, *future* genannt, muss das Ergebnis des Skripts übergeben werden, sobald es bereitsteht. Dann unternimmt es alles Nötige, um das Ergebnis an den Aufrufer des Skripts zu übermitteln, und zerstört sich anschließend selbst. Hat comm während der Berechnung des Ergebnisses die Verbindung zum Aufrufer verloren, versucht das Future nicht, das erhaltene Ergebnis zu übermitteln, sondern zerstört sich lediglich selbst. Das Future kann mit einem Befehl konfiguriert werden, der aufgerufen wird, wenn der Aufrufer verloren geht. Dies ermöglicht es dem Benutzer, einen vorzeitigen Abbruch des lang andauernden Vorgangs zu implementieren, sofern dieser dies unterstützt. Ein Beispiel:


```
# Procedure invoked by remote clients to run database operations.
proc select {sql} {
    # Signal the async generation of the result

    set future [::comm::comm return_async]

    # Generate an async db operation and tell it where to deliver the result.

    set query [db query -command [list $future return] $sql]

    # Tell the database system which query to cancel if the connection
    # goes away while it is running.

    $future configure -command [list db cancel $query]

    # Note: The above will work without problem only if the async
    # query will nover run its completion callback immediately, but
    # only from the eventloop. Because otherwise the future we wish to
    # configure may already be gone. If that is possible use 'catch'
    # to prevent the error from propagating.
    return
}
```

Die API eines Future-Objekts lautet wie folgt:

**\$future** **return** ?**-code** *code*? ?*value*?
: Mit dieser Methode teilen Sie dem Future mit, dass der lang andauernde Vorgang abgeschlossen ist. Als Argumente dienen ein optionaler Rückgabewert (Standardwert: die leere Zeichenkette) und der Tcl-Rückgabecode (Standardwert: OK). Das Future übermittelt diese Informationen an den Aufrufer, sofern die Verbindung in der Zwischenzeit nicht verloren ging, und zerstört sich anschließend selbst. Ist die Verbindung verloren gegangen, zerstört es sich lediglich selbst.

**\$future** **configure** ?**-command** ?*cmdprefix*??
: ...siehe nächstes...

**\$future** **cget** **-command**
: Mit diesen Methoden kann der Benutzer einen Befehl abfragen und festlegen, der aufgerufen wird, wenn die Verbindung, zu der das Future gehört, verloren gegangen ist.


## Kompatibilität

**comm** exportiert sich als Paket. Die Versionsnummer des Pakets hat das Format *Hauptversion . Nebenversion*, wobei sich die Hauptversion nur ändert, wenn eine nicht kompatible Änderung an der API oder am Protokoll vorgenommen wird. Kleinere Fehlerbehebungen und Änderungen wirken sich lediglich auf die Nebenversion aus.  Um **comm** zu laden, wird in der Regel dieser Befehl verwendet:

```
    package require comm 3
```

Beachten Sie, dass auch ohne Versionsangabe (oder mit einer bestimmten Version) angefordert werden kann.

Die Versionshistorie von **comm** umfasst folgende Versionen:

**4.6.3**
: Ticket \[ced0d60fc9\] behoben. Korrekte Erkennung von EOF auf einem Socket hinzugefügt, der dann ordnungsgemäß geschlossen wird.

**4.6.2**
: Die Fehler 2972571 und 3066872 wurden behoben; im ersten Fall handelte es sich um eine fehlerhafte Erkennung einer maskierten geschweiften Klammer nach einem doppelten Backslash, im anderen Fall um ein blockierendes gets, das (im Nachhinein offensichtlich) einen DoS-Angriff auf comm-Kanäle ermöglichte.

**4.6.1**
: Die Implementierung von **comm::commCollect** wurde geändert, um das Verhalten von lindex vor Tcl 8 nachzubilden, d. h., es wurde die Möglichkeit geschaffen, das erste Wort einer Liste zu extrahieren, selbst wenn der gesamte Puffer keine wohlgeformte Liste ist. Ohne diese Änderung konnte das erste Wort nur extrahiert werden, wenn der gesamte Puffer eine wohlgeformte Liste war (seit Tcl 8), und in einer Situation mit sehr hoher Auslastung – d. h. wenn ein Server sehr schnell viele und/oder große Befehle sendet – kann dies unter Umständen nie geschehen, was schließlich zum Absturz des Empfängers führen kann, wenn ihm der Speicher ausgeht. Mit dieser Änderung ist der Empfänger stets in der Lage, das erste Wort zu verarbeiten, sobald es wohlgeformt ist, unabhängig von der Struktur des restlichen Puffers.

**4.6**
: Es wurde die Option **-socketcmd** hinzugefügt, mit der Benutzer die Art und Weise, wie ein Socket geöffnet wird, überschreiben können. Der vorgesehene Hauptzweck besteht in der Angabe des Befehls **tls::socket** (siehe Paket **tls**) zur Sicherung der Kommunikation.

**4.5.7**
: Die Behandlung bereits belegter Ports wurde geändert, um eine korrekte Fehlermeldung auszugeben.

**4.5.6**
: Fehlerbehebung im Ersatz für **vwait**, robust gemacht gegen Variablennamen, die Leerzeichen enthalten.

**4.5.5**
: Fehlerbehebung bei der Verarbeitung von Hooks, Tippfehler im Namen der Variablen.

**4.5.4**
: Fehlerbehebung bei der Verarbeitung des von der Methode **send** empfangenen Ergebnisses. Ein *after idle unset result* wurde durch ein sofortiges **unset** ersetzt, wobei die Information in einer lokalen Variable gesichert wird. Das **after idle** kann in einen durch fork erzeugten Kindprozess übergreifen, wenn zwischen seiner Einrichtung und dem fork keine Ereignisschleife liegt. Das kann den Kindprozess durcheinanderbringen, wenn die nächste Ereignisschleife das **vwait** im **send** von **comm** ist, einige Zeilen oberhalb des **after idle**, und der Kindprozess dieselbe Seriennummer für seine nächste Anfrage verwendet hat. In diesem Fall löscht das **after idle unset** des Elternprozesses genau das Array-Element, auf das der Kindprozess wartet, wodurch das **vwait** freigegeben wird und auf ein nun fehlendes Array-Element zugreift statt auf das erwartete Ergebnis.

**4.5.3**
: Fehlerbehebungen in den Wrappern für die eingebauten Befehle **update** und **vwait**.

**4.5.2**
: Fehlerbehebung im Wrapper für den eingebauten Befehl **update**.

**4.5.1**
: Fehlerbehebungen bei der Verarbeitung von -interp für reguläre Skripte. Bei Skripten, die aus einer einzigen Anweisung in Form einer Liste bestehen, war die Verarbeitung des Puffers fehlerhaft. Ein fehlendes Argument beim neuen Befehl **commSendReply**, der mit Version 4.5 eingeführt wurde, wurde behoben. Dies hatte Auswirkungen auf die Fehlersuche.

**4.5**
: Neue serverseitige Funktion. Der auf dem Server aufgerufene Befehl kann comm nun von der standardmäßigen synchronen Rückgabe seines Ergebnisses auf eine asynchrone (verzögerte) Rückgabe umstellen. Da snit zur Implementierung der von dieser Funktion verwendeten *future*-Objekte eingesetzt wird, benötigt comm ab dieser Version mindestens Tcl 8.3, um ausgeführt zu werden. Bitte lesen Sie den Abschnitt **Asynchrone Ergebniserzeugung** für weitere Details.

**4.4.1**
: Fehlerbehebung bei der Ausführung von Hooks.

**4.4**
: Fehlerbehebungen bei der Verarbeitung von -interp für reguläre Skripte und Hook-Skripte. Fehlerbehebungen bei der Bereinigung der Kanäle.

**4.3.1**
: -interp und -events eingeführt, um die einfache Verwendung eines Slave-Interpreters zur Ausführung empfangener Skripte sowie von Skripten für Ereignisse zu ermöglichen.

**4.3**
: Fehlerbehebungen sowie die Einführung von -silent, wodurch der Benutzer den Server bzw. die lauschende Seite dazu zwingen kann, Verbindungsversuche, bei denen die Protokollaushandlung fehlgeschlagen ist, stillschweigend zu ignorieren.

**4.2**
: Fehlerbehebungen und, am wichtigsten, Umstellung auf UTF-8 als Standardkodierung für vollständige Internationalisierung (i18n) ohne Probleme.

**4.1**
: Überarbeitung des internen Codes zur Entfernung des alten Pseudo-Objektmodells.  Option send -command für eine asynchrone Rückruffunktion hinzugefügt.

**4.0**
: Auf Wunsch von John LoVerso. Verbesserte Fehlerbehandlung bei asynchron aufgerufenen Befehlen.

**3.7**
: In tcllib verschoben und in einen eigenen Namespace gelegt.

**3.6**
: Ein Fehler beim Nachschlagen der remoteid für einen ausgeführten Befehl konnte auftreten, wenn die Verbindung geschlossen wurde, während mehrere asynchrone Sendevorgänge zur Ausführung in der Warteschlange standen.

**3.5**
: Interne Änderung hinsichtlich der Verarbeitung von Antwortnachrichten aus einem **send**. Antwortnachrichten werden nun in den *value* dekodiert, der an **return** übergeben wird; anschließend wird mit diesem Wert eine neue return-Anweisung zusammengebaut.  Bisher wurde der Rückgabecode von der Gegenseite als auszuwertender Befehl übergeben. Da sich das Wire-Protokoll nicht geändert hat, ist dies nach wie vor der Fall. Stattdessen dekodiert der Code zur Verarbeitung der Antwort die **reply**-Nachricht.

**3.4**
: Es wurden weitere Kommentare im Quellcode hinzugefügt sowie die Konfigurationsvariablen in dieser Man-Seite dokumentiert. Ein Fehler wurde behoben, bei dem der Verlust der Verbindung eine Fehlermeldung über eine Variable namens **pending** statt der Meldung über die verlorene Verbindung lieferte.  **comm ids** ist nun ein Alias für **comm interps** (zuvor war es ein Alias für **comm chans**). Seit der Änderung des Methodenaufrufs in Version 3.0 wurden break und andere Ausnahmebedingungen von **comm send** nicht korrekt zurückgegeben. Dies wurde behoben, indem die zusätzliche Indirektionsebene in die interne Prozedur **commSend** entfernt wurde.  Zudem wurde die Weitergabe der Variablen *errorCode* hinzugefügt. Dies bedeutet, dass diese Befehle nun genau so zurückgeben, wie sie es mit **send** tun würden:


```
    comm send id break
    catch {comm send id break}
    comm send id expr 1 / 0
```

Es wurde ein neuer Hook für Antwortnachrichten hinzugefügt.  Der Aufruf der Methode wurde überarbeitet, um die Verwendung von comm:\*-Prozeduren zu vermeiden; dadurch konnte die Aufrufzeit um 40 % verkürzt werden.  **comm config** wurde dokumentiert (da diese Handbuchseite noch das nicht mehr existierende **comm init** aufführte!)

**3.3**
: Es wurden einige kleinere Fehler behoben und die Dokumentation überarbeitet. Es wurden einige Beispiele für Hooks hinzugefügt. Die Rückgabesemantik des Hooks **eval** wurde geändert.

**3.2**
: Ein neues Wire-Protokoll, Version 3, wurde hinzugefügt. Es ist abwärtskompatibel mit Version 2, fügt aber einen Austausch der unterstützten Protokollversionen hinzu, um künftig eine Protokollaushandlung zu ermöglichen. Mehrere Fehler in der Hook-Implementierung wurden behoben. Ein neuer Abschnitt zur Blockierungssemantik wurde in die Handbuchseite aufgenommen.

**3.1**
: Alle dokumentierten Hooks wurden implementiert. **commLostHook** wurde entfernt. Ein Fehler in **comm new** wurde behoben.

**3.0**
: Dies ist eine neue Version von **comm** mit mehreren wesentlichen Änderungen. Es gibt eine neue Vorgehensweise zum Erstellen der Methoden, die unter dem Befehl **comm** verfügbar sind.  Die Methode **comm init** wurde ausgemustert und durch **comm configure** ersetzt, das den Zugriff auf viele der klar definierten internen Variablen ermöglicht. Dadurch werden auch die für **comm new** verfügbaren Optionen verallgemeinert.  Schließlich wird nun bei Herstellung einer Verbindung eine Protokollversion ausgetauscht. Dies ermöglicht zukünftige Änderungen am Wire-Protokoll. Derzeit ist die Protokollversion auf 2 festgelegt.

**2.3**
: **comm ids** wurde in **comm channels** umbenannt. Die allgemeine Unterstützung für **comm hook** wurde vollständig implementiert, es existiert jedoch nur der Hook *lost*, der angepasst wurde, um der allgemeinen Hook-API zu entsprechen.  **commLostHook** wird nicht mehr unterstützt (ersetzt durch **comm hook lost**) und **commLost** wurde entfernt.

**2.2**
: Der Hook *died* wurde in *lost* umbenannt, um von **commLostHook** und einer frühen Implementierung von **comm lost hook** aufgerufen zu werden.  Daher heißt **commDied** nun **commLost**.

**2.1**
: Die nicht unterstützte Methode **comm remoteid** wurde hinzugefügt.

**2.0**
: **comm** wurde von Grund auf neu geschrieben (ist aber vollständig kompatibel mit Comm 1.0, ohne dass obTcl benötigt wird).


# TLS-SICHERHEITSHINWEISE

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# AUTOREN

John LoVerso, John@LoVerso.Southborough.MA.US

*http://www.opengroup.org/~loverso/tcl-tk/#comm*

# LIZENZ

Bitte beachten Sie die Datei *comm.LICENSE*, die diesem Quellcode beiliegt, oder *http://www.opengroup.org/www/dist_client/caubweb/COPYRIGHT.free.html*.

Diese Lizenz für **comm**, die ab Version 3.2 gilt, ermöglicht die kostenlose Nutzung ohne Lizenzgebühren oder Tantiemen.

# BUGS

**•**
: Schlägt die Initialisierung eines mit **::comm::comm new** erstellten Kanals fehl, sollte der Kanal zerstört werden. Derzeit verbleibt er in einem inkonsistenten Zustand.

**•**
: Es sollte eine Möglichkeit geben, einen Kanal bei einer Änderung der Konfiguration in den Ruhezustand zu versetzen. Die folgenden Punkte lassen sich mit den vorhandenen Hooks umsetzen und werden hier als Erinnerung aufgeführt, um in einer zukünftigen Version einen Beispiel-Hook bereitzustellen.

**•**
: Einfachere Verwendung eines Slave-Interpreters für die eigentliche Ausführung der Befehle (insbesondere im Modus „nicht lokal“).

**•**
: Authentifizierung über eine Hostliste (wie xhost) oder ein „Magic Cookie“ (wie xauth) im ersten Handshake. Im Folgenden sind noch offene Aufgaben aufgeführt.

**•**
: Erkennung von Interpretern und Zuordnung von Namen zu Ports. Dies wird voraussichtlich in einem separaten, optionalen Nameserver liegen. (Siehe auch die unten aufgeführten verwandten Arbeiten.)

**•**
: Die Form *{id host}* so korrigieren, dass sie nicht von kanonischen Hostnamen abhängt.  Dies erfordert Anpassungen an Tcl, um Hostnamen aufzulösen! Diese Man-Seite ist umfangreicher als die Quelldatei.


# ZUR VERWENDUNG ÄLTERER VERSIONEN VON TCL

Tcl7.5 unter Windows weist einen Fehler auf, der dazu führt, dass der Interpreter hängen bleibt, wenn bei nicht-blockierenden Sockets das EOF erreicht wird. Dies lässt sich mit einem Befehl wie dem folgenden auslösen:

```
    "comm send $other exit"
```

Stellen Sie stets sicher, dass der Kanal inaktiv ist, bevor Sie ihn schließen oder beenden, oder verwenden Sie unter Windows mindestens Tcl7.6.

Tcl7.6 auf dem Mac weist mehrere Fehler auf. Es wird empfohlen, mindestens Tcl7.6p2 zu verwenden.

Tcl8.0 unter UNIX weist einen Socket-Fehler auf, der zum Absturz von Tcl führen kann. Es wird empfohlen, Tcl8.0p1 (oder Tcl7.6p2) zu verwenden.

# VERWANDTE ARBEITEN

Tcl-DP bietet eine RPC-basierte Schnittstelle zur entfernten Ausführung, ist jedoch eine kompilierte Tcl-Erweiterung. Siehe *http://www.cs.cornell.edu/Info/Projects/zeno/Projects/Tcl-DP.html*.

Michael Doyle \<miked@eolas.com> hat Code, der die Tcl-DP-RPC-Schnittstelle unter Verwendung von Standard-Tcl-Sockets implementiert, ähnlich wie **comm**. Das DpTcl-Paket ist unter *http://chiselapp.com/user/gwlester/repository/DpTcl* verfügbar.

Andreas Kupries \<andreas_kupries@users.sourceforge.net> verwendet **comm** und hat im Rahmen seiner Pool-Bibliothek einen einfachen Nameserver entwickelt.  Siehe *http://www.purl.org/net/akupries/soft/pool/index.htm*.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *comm* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 1995-1998 The Open Group. All Rights Reserved.
Copyright (c) 2003-2004 ActiveState Corporation.
Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
