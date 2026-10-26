---
CommandName: comm_wire
ManualSection: n
Version: 3
TclPart: tcllib
TclDescription: Remote communication
Links:
 - comm
Keywords:
 - comm
 - communication
 - ipc
 - message
 - remote communication
 - remote execution
 - rpc
 - socket
Copyright:
 - Copyright (c) 2005 Docs. Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

comm_wire – Das Comm-Wire-Protokoll

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [comm]{.lit} 
:::

# BESCHREIBUNG

Der Befehl **comm** bietet eine Einrichtung zur entfernten Ausführung zwischen Interpretern, ähnlich wie **send(n)** von Tk, mit dem Unterschied, dass er für den Kommunikationspfad Sockets anstelle des X-Servers verwendet.  Daher funktioniert **comm** mit mehreren Interpretern, läuft auf Windows- und Macintosh-Systemen und bietet Kontrolle über den Pfad der entfernten Ausführung.

Dieses Dokument enthält eine Spezifikation der verschiedenen Versionen des Wire-Protokolls, das von comm intern für die Kommunikation zwischen seinen Endpunkten verwendet wird. Es ist für Anwender von **comm** nicht relevant, sondern richtet sich ausschließlich an Entwickler, die das Paket anpassen, eine kompatible Funktion in einer anderen Sprache schreiben oder eine andere Funktion auf Basis desselben Protokolls entwickeln möchten.

# WIRE-PROTOKOLL VERSION 3

## Grundschicht

Die grundlegende Kodierung für *alle* Daten ist UTF-8. Deshalb können Binärdaten, einschließlich des NULL-Zeichens, unverändert über die Leitung gesendet werden, ohne dass sie eigens verpackt (maskiert) werden müssen.

## Grundlegende Nachrichtenebene

Auf der **Grundschicht** findet ein *nachrichtenorientierter* Datenaustausch statt. Die Gesamtheit aller in den Kanal geschriebenen Zeichen bildet eine Tcl-Liste, wobei jedes Element eine separate *Nachricht* darstellt, die wiederum selbst eine Liste ist. Die Nachrichten in der Gesamtliste werden durch EOL getrennt. Hinweis: EOL-Zeichen können auch innerhalb der Liste vorkommen. Sie lassen sich von den EOL-Zeichen, die Nachrichten voneinander trennen, dadurch unterscheiden, dass die Daten vom Anfang bis zu ihrer Position keine gültige Tcl-Liste bilden.

Das EOL wird durch das Zeilenvorschubzeichen signalisiert, d. h. **LF** oder, im Hexadezimalformat, **0x0a**. Dies entspricht der Unix-Konvention für Zeilenenden.

Als Liste besteht jede Nachricht aus *Wörtern*. Ihre Bedeutung hängt davon ab, wann die Nachricht im Rahmen des gesamten Austauschs gesendet wurde. Dies wird in den folgenden Abschnitten erläutert.

## Verhandlungsnachrichten – erster Handshake

Das Befehlsprotokoll ist wie folgt definiert:

**•**
: Die erste Nachricht, die ein Client beim Aufbau der Verbindung an einen Server sendet, enthält zwei Wörter. Das erste Wort ist ebenfalls eine Liste und enthält die Versionen des Wire-Protokolls, die der Client akzeptieren kann, wobei die bevorzugte Version an erster Stelle steht. Das zweite Wort ist der TCP-Port, auf dem der Client auf Verbindungen zu sich selbst lauscht. Der Wert **0** signalisiert hier, dass der Client nicht auf Verbindungen lauscht, d. h., dass er ausschließlich zum Senden von Befehlen und nicht zum Empfangen von Befehlen dient.

**•**
: Die erste Nachricht, die der Server als Antwort auf die oben genannte Nachricht an den Client sendet, enthält nur ein Wort. Dieses Wort ist eine Liste, deren erstes Element die Zeichenkette **vers** ist und deren zweites Element die Version des Wire-Protokolls ist, die der Server aus den angebotenen Versionen ausgewählt hat.


## Skript-/Befehlsnachrichten

Alle Nachrichten, die nach dem **ersten Handshake** folgen, bestehen aus drei Wörtern: einer Anweisung, einer Transaktions-ID und den Nutzdaten. Die gültigen Anweisungen sind nachstehend aufgeführt. Die Transaktions-IDs verwendet der Client, um eingehende Antworten den von ihm gesendeten Befehlsnachrichten zuzuordnen. Das bedeutet, dass ein Server die Transaktions-ID aus einer Befehlsnachricht in die Antwort kopieren muss, die er für diese Nachricht sendet.

**send**
: ...siehe nächstes...

**async**
: ...siehe nächstes...

**command**
: Die Nutzdaten sind das Tcl-Skript, das auf dem Server ausgeführt werden soll. Genauer ist es eine Liste mit den Skriptfragmenten. Der Server fügt diese Fragmente mit **concat** zusammen und bildet so das vollständige Skript, das serverseitig ausgeführt wird. Dies bildet die Semantik von Tcls "eval" nach. Meist ist es am besten, nur ein Wort in der Liste zu haben, nämlich eine Liste mit dem genauen Befehl. Beispiele:


```
    (a)     {send 1 {{array get tcl_platform}}}
    (b)     {send 1 {array get tcl_platform}}
    (c)     {send 1 {array {get tcl_platform}}}

    are all valid representations of the same command. They are
    generated via

    (a')    send {array get tcl_platform}
    (b')    send array get tcl_platform
    (c')    send array {get tcl_platform}

    respectively
```

Beachten Sie, dass (a), das durch (a') generiert wird, die übliche Form ist, wenn vom Client nur einzelne Befehle gesendet werden. Zum Beispiel mit **list** erstellt, wenn der Befehl variable Argumente enthält. Etwa so:

```
    send [list array get $the_variable]
```

Diese drei Anweisungen rufen das Skript jeweils serverseitig auf. Der Unterschied zwischen ihnen liegt in der Behandlung der Ergebniswerte und bestimmt somit, ob eine Antwort erwartet wird.

**send**
: Eine Antwort wird erwartet. Der Absender wartet auf das Ergebnis.

**async**
: Es wird keine Antwort erwartet; der Absender hat kein Interesse am Ergebnis und wartet auch nicht darauf.

**command**
: Eine Antwort wird erwartet, doch der Absender wartet nicht darauf. Er hat veranlasst, dass er eine prozessinterne Benachrichtigung erhält, wenn das Ergebnis vorliegt.


**reply**
: Wie die drei vorherigen Anweisungen, jedoch ist das Tcl-Skript in den Nutzdaten stark eingeschränkt. Es muss ein syntaktisch gültiger Tcl-Befehl **return** sein. Dieser enthält einen Ergebniscode, einen Wert, einen Fehlercode und Fehlerinformationen. Beispiele:


```
    {reply 1 {return -code 0 {}}}
    {reply 1 {return -code 0 {osVersion 2.4.21-99-default byteOrder littleEndian machine i686 platform unix os Linux user andreask wordSize 4}}}
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *comm* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 2005 Docs. Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
