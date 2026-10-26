---
CommandName: transfer::receiver
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - data destination
 - receiver
 - secure
 - ssl
 - tls
 - transfer
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

transfer::receiver – Datenquelle

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::data::destination]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::connect]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::receiver]{.lit} [0.3]{.optlit} 
[transfer::receiver]{.cmd} [object]{.arg} [options]{.optdot} 
[transfer::receiver]{.cmd} [stream]{.sub} [channel]{.lit} [chan]{.arg} [host]{.arg} [port]{.arg} [arg]{.optdot} 
[transfer::receiver]{.cmd} [stream]{.sub} [file]{.lit} [path]{.arg} [host]{.arg} [port]{.arg} [arg]{.optdot} 
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [start]{.sub} 
[objectName]{.ins} [busy]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket fasst Datenziele und den Verbindungsaufbau in einem gemeinsamen Objekt zusammen, um über einen Socket eingehende Informationen zu empfangen. Diese Objekte unterstützen alle Optionen der Objekte, die von den Paketen **transfer::data::destination** und **transfer::connect** erstellt wurden.

# API

## Paketbefehle

**transfer::receiver** *object* ?*options*...?
: Dieser Befehl erstellt ein neues Empfängerobjekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten **Objektbefehl** und **Objektmethoden** ausführlich erläutert. Die unterstützten *options* werden im Abschnitt **Optionen** erläutert. Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace. Der vollständig qualifizierte Name des Objektbefehls wird als Ergebnis des Befehls zurückgegeben.

**transfer::receiver** **stream channel** *chan* *host* *port* ?*arg*...?
: Diese Methode erstellt eine „Fire-and-Forget“-Übertragung für die Daten, die von der Quelle unter Host/Port (Details siehe unten) stammen und in den Kanal *chan* geschrieben werden, beginnend an der aktuellen Suchposition. Der Kanal ist so konfiguriert, dass er für die Übertragung binäre Übersetzung und Kodierung verwendet. Der Kanal wird nach Abschluss der Übertragung *nicht* geschlossen. Dies wird der Rückruffunktion überlassen. Werden sowohl *host* als auch *port* angegeben, wird eine **active**-Verbindung zur Datenquelle hergestellt. Wenn nur ein *port* festgelegt wird (wobei *host* die leere Zeichenkette ist), wird stattdessen eine **passive**-Verbindung hergestellt, d. h., der Empfänger wartet dann auf eine Verbindung durch den Sender. Alle Argumente nach dem Port werden als Optionen behandelt und dienen zur Konfiguration des internen Empfängerobjekts. Eine Liste der unterstützten Optionen und deren Bedeutung finden Sie im Abschnitt **Optionen**. *Hinweis*: Die Signatur des für die **-command**-Rückruffunktion angegebenen Befehlspräfixes unterscheidet sich von der Signatur für dieselbe Option des Empfängerobjekts. Diese Rückruffunktion erhält lediglich die Anzahl der Bytes und die übertragene Datenmenge sowie gegebenenfalls eine Fehlermeldung. Es wird kein Verweis auf das intern verwendete Empfängerobjekt hergestellt. Das vom Befehl zurückgegebene Ergebnis ist die leere Zeichenkette, wenn der Befehl so eingestellt wurde, dass eine *aktive* Verbindung hergestellt wird, und andernfalls der Port, auf dem das interne Empfängerobjekt lauscht, d. h. wenn es so konfiguriert ist, dass es *passiv* eine Verbindung herstellt. Siehe auch das Paket **transfer::connect** und die Beschreibung der Methode **connect**, um zu erfahren, woher dieses Verhalten stammt.

**transfer::receiver** **stream file** *path* *host* *port* ?*arg*...?
: Diese Methode entspricht der Methode **stream channel**, mit dem Unterschied, dass die empfangenen Daten in den Pfad *path* geschrieben werden und dabei den bisherigen Inhalt ersetzen.


## Objektbefehl

Alle mit dem Befehl **::transfer::receiver** erstellten Objekte haben die folgende allgemeine Form:

*objectName* **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt. Wenn Sie dies tun, während ein Empfang noch läuft, kommt es später zu Fehlern, sobald der Empfang abgeschlossen ist und versucht wird, auf die nun fehlenden Datenstrukturen des gelöschten Objekts zuzugreifen.

*objectName* **start**
: Diese Methode leitet den Datenempfang ein, indem sie zunächst die Verbindung herstellt und anschließend die empfangenen Informationen in das Ziel kopiert. Die Methode löst einen Fehler aus, wenn bereits ein Empfang läuft oder noch nicht abgeschlossen ist. Das heißt, es ist nicht möglich, zwei Empfänge parallel auszuführen, sondern nur nacheinander. Fehler werden ebenfalls ausgelöst, wenn die Konfiguration des Datenziels ungültig ist oder wenn keine Rückruffunktion für den Abschluss angegeben wurde. Das von der Methode zurückgegebene Ergebnis ist die leere Zeichenkette für ein Objekt, das für eine *aktive* Verbindung konfiguriert ist, und andernfalls der Port, auf dem das Objekt auf Verbindungen wartet, d. h. wenn es für eine *passive* Verbindung konfiguriert ist. Siehe auch das Paket **transfer::connect** und die Beschreibung der Methode **connect**, um zu erfahren, woher dieses Verhalten stammt.

*objectName* **busy**
: Diese Methode gibt einen booleschen Wert zurück, der angibt, ob gerade ein Empfang stattfindet (**True**) oder nicht (**False**).


## Optionen

Alle Empfängerobjekte unterstützen die Vereinigung der Optionen, die von ihren „connect“- und „data destination“-Komponenten unterstützt werden, sowie eine eigene Option. Siehe auch die Dokumentation zu den Paketen **transfer::data::destination** und **transfer::connect**.

**-command** *cmdprefix*
: Diese Option legt den Befehl fest, der aufgerufen werden soll, wenn der Empfang der Informationen abgeschlossen ist. Die diesem Befehl übergebenen Argumente entsprechen denen, die an den Abschluss-Callback des Befehls **transfer::copy::do** übergeben werden, der vom Paket **transfer::copy** bereitgestellt wird.

**-mode** *mode*
: Diese Option legt den Modus fest, in dem sich das Objekt befindet. Sie ist optional und ist standardmäßig auf den Modus **active** eingestellt. Die beiden möglichen Modi sind:


**active**
: In diesem Modus sind die beiden Optionen **-host** und **-port** relevant und legen den Host sowie den TCP-Port fest, mit dem das Objekt eine Verbindung herstellen muss. Der Host wird entweder durch einen Namen oder eine IP-Adresse angegeben.

**passive**
: In diesem Modus ist die Option **-host** ohne Bedeutung und wird ignoriert, falls sie konfiguriert sein sollte. Die einzige Option, die das Objekt benötigt, ist **-port**; diese legt den TCP-Port fest, an dem der lauschenden Socket geöffnet wird, um auf die Verbindung vom Partner zu warten.


**-host** *hostname-or-ipaddr*
: Diese Option legt den Host fest, mit dem im *aktiven* Modus eine Verbindung hergestellt werden soll, entweder anhand des Namens oder der IP-Adresse. Ein für den *passiven* Modus konfiguriertes Objekt ignoriert diese Option.

**-port** *int*
: Im *aktiven* Modus legt diese Option den Port fest, mit dem das Objekt voraussichtlich eine Verbindung herstellen wird. Im *passiven* Modus hingegen handelt es sich um den Port, an dem das Objekt den lauschenden Socket erstellt, um auf eine Verbindung zu warten. Der Standardwert ist **0**, wodurch das Betriebssystem den tatsächlichen Port für den lauschenden Socket selbst auswählen kann.

**-socketcmd** *command*
: Mit dieser Option kann der Benutzer festlegen, welcher Befehl zum Öffnen eines Sockets verwendet werden soll. Standardmäßig wird der integrierte Befehl **::socket** verwendet. Jeder mit diesem Befehl kompatible Befehl ist zulässig. Die vorgesehene Hauptanwendung ist die Angabe von **tls::socket**. Das heißt, diese Option ermöglicht die Einrichtung sicherer Übertragungskanäle, ohne dass dieses Paket explizit vom Paket **tls** abhängig gemacht wird. Siehe auch den Abschnitt **SICHERE VERBINDUNGEN**.

**-encoding** encodingname
: ...siehe nächstes...

**-eofchar** eofspec
: ...siehe nächstes...

**-translation** transspec
: Diese Optionen entsprechen denen, die vom integrierten Befehl **fconfigure** erkannt werden. Sie legen die Konfiguration fest, die für den Kanal zwischen den beiden Partnern nach dessen Aufbau, jedoch vor dem Aufruf der Rückruffunktion, eingestellt werden soll (siehe Methode **connect**).

**-channel** *handle*
: Diese Option legt fest, dass das Ziel der Daten ein Kanal ist, und das zugehörige Argument ist das Handle des Kanals, in den die empfangenen Daten geschrieben werden sollen.

**-file** *path*
: Diese Option legt fest, dass das Ziel der Daten eine Datei ist, und das zugehörige Argument ist der Pfad der Datei, in die die empfangenen Daten geschrieben werden sollen.

**-variable** *varname*
: Diese Option legt fest, dass das Ziel der Daten eine Variable ist, und das zugehörige Argument enthält den Namen der Variable, in die die empfangenen Daten geschrieben werden sollen. Es wird davon ausgegangen, dass es sich um eine globale Variable oder eine Variable im Namespace handelt, die im globalen Namespace verankert ist.

**-progress** *command*
: Wenn diese Option festgelegt ist, wird damit ein Befehl definiert, der für jeden empfangenen Byte-Block aufgerufen wird, sodass der Benutzer den Fortschritt des Datenempfangs überwachen kann. Die Rückruffunktion wird stets mit einem zusätzlichen Argument aufgerufen, nämlich der Anzahl der bisher empfangenen Bytes.


# SICHERE VERBINDUNGEN

Eine Möglichkeit, die von Objekten dieses Pakets hergestellten Verbindungen zu sichern, besteht darin, das Paket **tls** vorzuschreiben und anschließend die Option **-socketcmd** so zu konfigurieren, dass die Verwendung des Befehls **tls::socket** zum Öffnen des Sockets erzwungen wird.

```
    # Load and initialize tls
    package require tls
    tls::init -cafile /path/to/ca/cert -keyfile ...

    # Create a connector with secure socket setup,
    transfer::receiver R -socketcmd tls::socket ...
    ...
```

# TLS-SICHERHEITSHINWEISE

Dieses Paket nutzt das **TLS**-Paket, um die Sicherheit für **https**-URLs und andere Socket-Verbindungen zu gewährleisten.

Entscheidungen wie die Auswahl der zu unterstützenden Protokolle und der zu verwendenden Verschlüsselungsalgorithmen fallen jedoch weder in den Zuständigkeitsbereich von **TLS** noch in den des Pakets. Solche Entscheidungen liegen in der Verantwortung der jeweiligen Anwendung, die das Paket nutzt, und werden wahrscheinlich auch von den Servern beeinflusst, mit denen die Anwendung kommuniziert.

Angesichts des kürzlich von Google entdeckten [POODLE-Angriffs](http://googleonlinesecurity.blogspot.co.uk/2014/10/this-poodle-bites-exploiting-ssl-30.html) werden beispielsweise viele Server die Unterstützung für das SSLv3-Protokoll deaktivieren. Um dieser Änderung Rechnung zu tragen, müssen die Anwendungen, die **TLS** verwenden, gepatcht werden – nicht dieses Paket und auch nicht **TLS** selbst. Ein solcher Patch kann so einfach sein wie die allgemeine Aktivierung der **tls1**-Unterstützung, wie im folgenden Beispiel gezeigt.

```
    package require tls
    tls::init -tls1 1 ;# forcibly activate support for the TLS1 protocol

    ... your own application code ...
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *transfer* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Transfermodul

# COPYRIGHT

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
