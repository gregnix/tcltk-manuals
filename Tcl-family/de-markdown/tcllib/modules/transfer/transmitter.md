---
CommandName: transfer::transmitter
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - data source
 - secure
 - ssl
 - tls
 - transfer
 - transmitter
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

transfer::transmitter – Datenquelle

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::data::source]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::connect]{.lit} [0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::transmitter]{.lit} [0.3]{.optlit} 
[transfer::transmitter]{.cmd} [objectName]{.arg} [options]{.optdot} 
[transfer::transmitter]{.cmd} [stream]{.sub} [channel]{.lit} [chan]{.arg} [host]{.arg} [port]{.arg} [arg]{.optdot} 
[transfer::transmitter]{.cmd} [stream]{.sub} [file]{.lit} [path]{.arg} [host]{.arg} [port]{.arg} [arg]{.optdot} 
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [start]{.sub} 
[objectName]{.ins} [busy]{.sub} 
:::

# BESCHREIBUNG

Dieses Paket fasst Datenquellen und Verbindungseinstellungen in einem gemeinsamen Objekt zusammen, um Informationen über einen Socket zu übertragen. Diese Objekte unterstützen alle Optionen der Objekte, die von den Paketen **transfer::data::source** und **transfer::connect** erstellt wurden.

# API

## Paketbefehle

**transfer::transmitter** *objectName* ?*options*...?
: Dieser Befehl erstellt ein neues Senderobjekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten **Objektbefehl** und **Objektmethoden** ausführlich erläutert. Die unterstützten *options* werden im Abschnitt **Optionen** erläutert. Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace. Der vollständig qualifizierte Name des Objektbefehls wird als Ergebnis des Befehls zurückgegeben.

**transfer::transmitter** **stream channel** *chan* *host* *port* ?*arg*...?
: Diese Methode erstellt eine „Fire-and-Forget“-Übertragung für die im Kanal *chan* enthaltenen Daten, beginnend an der aktuellen Suchposition. Der Kanal ist so konfiguriert, dass für die Übertragung eine binäre Übersetzung und Kodierung verwendet wird. Der Kanal wird automatisch geschlossen, wenn die Übertragung abgeschlossen ist. Wenn sowohl *host* als auch *port* angegeben werden, wird eine **active**-Verbindung zum Ziel hergestellt. Wenn nur ein *port* festgelegt wird (wobei *host* die leere Zeichenkette ist), wird stattdessen eine **passive**-Verbindung hergestellt. Alle Argumente nach dem Port werden als Optionen behandelt und dienen zur Konfiguration des internen Senderobjekts. Eine Liste der unterstützten Optionen und deren Bedeutung finden Sie im Abschnitt **Optionen**. *Beachten* Sie jedoch, dass sich die Signatur des für die **-command**-Rückruffunktion angegebene Befehlspräfixes von der Signatur derselben Option des Senderobjekts unterscheidet. Diese Rückruffunktion wird lediglich mit der Anzahl der Bytes und der übertragenen Datenmenge sowie gegebenenfalls einer Fehlermeldung übergeben. Es wird kein Verweis auf das intern verwendete Senderobjekt hergestellt. Das vom Befehl zurückgegebene Ergebnis ist die leere Zeichenkette, wenn dieser so eingestellt war, dass eine *aktive* Verbindung hergestellt wird, und andernfalls der Port, auf dem das interne Senderobjekt auf Verbindungen wartet, d. h. wenn es so konfiguriert ist, dass es *passiv* eine Verbindung herstellt. Siehe auch das Paket **transfer::connect** und die Beschreibung der Methode **connect**, um zu erfahren, woher dieses Verhalten stammt.

**transfer::transmitter** **stream file** *path* *host* *port* ?*arg*...?
: Diese Methode entspricht der Methode **stream channel**, mit dem Unterschied, dass die in der Datei mit dem Pfad *path* enthaltenen Daten übertragen werden.


## Objektbefehl

Alle mit dem Befehl **::transfer::transmitter** erstellten Objekte haben die folgende allgemeine Form:

*objectName* **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt. Wenn Sie dies tun, während eine Übertragung läuft, führt dies später zu Fehlern, sobald die Übertragung abgeschlossen ist und versucht wird, auf die nun fehlenden Datenstrukturen des gelöschten Objekts zuzugreifen.

*objectName* **start**
: Diese Methode leitet die Datenübertragung ein, indem sie zunächst die Verbindung herstellt und anschließend die Informationen kopiert. Die Methode löst einen Fehler aus, wenn bereits eine Übertragung im Gange ist oder noch andauert. Das heißt, es ist nicht möglich, zwei Übertragungen parallel für ein einzelnes Objekt durchzuführen, sondern nur nacheinander. Für parallele Übertragungen sind mehrere Senderobjekte erforderlich, eines pro Übertragung. Fehler werden ebenfalls ausgelöst, wenn die Konfiguration der Datenquelle ungültig ist oder wenn keine Rückruffunktion für den Abschluss festgelegt wurde. Das von der Methode zurückgegebene Ergebnis ist die leere Zeichenkette für ein Objekt, das für den Aufbau einer *aktiven* Verbindung konfiguriert ist, und andernfalls der Port, auf dem das Objekt auf Verbindungen wartet, d. h. wenn es für eine *passive* Verbindung konfiguriert ist. Siehe auch das Paket **transfer::connect** und die Beschreibung der Methode **connect**, um zu erfahren, woher dieses Verhalten stammt.

*objectName* **busy**
: Diese Methode gibt einen booleschen Wert zurück, der angibt, ob gerade eine Übertragung stattfindet (**True**) oder nicht (**False**).


## Optionen

Alle Senderobjekte unterstützen die Vereinigung der Optionen, die von ihren „connect“- und „data source“-Komponenten unterstützt werden, sowie zwei eigene Optionen. Siehe auch die Dokumentation zu den Paketen **transfer::data::source** und **transfer::connect**.

**-blocksize** *int*
: Diese Option legt die Größe der Chunks fest, die in einem Block übertragen werden sollen. Die Verwendung ist optional; der Standardwert lautet **1024**.

**-command** *cmdprefix*
: Diese Option legt den Befehl fest, der aufgerufen werden soll, wenn die Übertragung der Informationen abgeschlossen ist. Die diesem Befehl übergebenen Argumente entsprechen denen, die an die Rückruffunktion des Befehls **transfer::copy::do** übergeben werden, die vom Paket **transfer::copy** bereitgestellt wird.

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

**-string** *text*
: Diese Option legt fest, dass die Datenquelle eine direkte Zeichenkette ist und das zugehörige Argument die betreffende Zeichenkette enthält.

**-channel** *handle*
: Diese Option legt fest, dass die Datenquelle ein Kanal ist, und das zugehörige Argument ist das Handle des Kanals, der die Daten enthält.

**-file** *path*
: Diese Option legt fest, dass die Daten aus einer Datei stammen, und das zugehörige Argument ist der Pfad zu der Datei, die die Daten enthält.

**-variable** *varname*
: Diese Option legt fest, dass die Datenquelle eine in einer Variablen gespeicherte Zeichenkette ist und das zugehörige Argument den Namen der betreffenden Variablen enthält. Es wird davon ausgegangen, dass es sich um eine globale Variable oder eine Variable im Namespace handelt, die im globalen Namespace verankert ist.

**-size** *int*
: Diese Option legt die Größe der Datenübertragung fest. Sie ist optional und hat standardmäßig den Wert -1. Dieser Wert sowie jeder andere Wert kleiner als Null bewirkt, dass alle Daten aus der Quelle übertragen werden.

**-progress** *command*
: Wenn diese Option festgelegt ist, wird damit ein Befehl definiert, der für jeden übertragenen Byte-Block aufgerufen wird, sodass der Benutzer den Fortschritt der Datenübertragung überwachen kann. Die Rückruffunktion wird stets mit einem zusätzlichen Argument aufgerufen, nämlich der Anzahl der bisher übertragenen Bytes.


# SICHERE VERBINDUNGEN

Eine Möglichkeit, die von Objekten dieses Pakets hergestellten Verbindungen zu sichern, besteht darin, das Paket **tls** vorzuschreiben und anschließend die Option **-socketcmd** so zu konfigurieren, dass die Verwendung des Befehls **tls::socket** zum Öffnen des Sockets erzwungen wird.

```
    # Load and initialize tls
    package require tls
    tls::init -cafile /path/to/ca/cert -keyfile ...

    # Create a connector with secure socket setup,
    transfer::transmitter T -socketcmd tls::socket ...
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
Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
