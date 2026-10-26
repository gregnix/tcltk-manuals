---
CommandName: transfer::copy::queue
title: transfer::copy::queue
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - queue
 - transfer
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::copy::queue – In der Warteschlange befindliche Überweisungen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit}
[package]{.cmd} [require]{.sub} [struct::queue]{.lit} [1.4]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::copy::queue]{.lit} [0.2]{.optlit}
[transfer::copy::queue]{.cmd} [objectName]{.arg} [outchannel]{.arg} [options...]{.optarg}
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [busy]{.sub}
[objectName]{.ins} [pending]{.sub}
[objectName]{.ins} [put]{.sub} [request]{.arg}
:::

# Beschreibung

Dieses Paket stellt Objekte bereit, die Übertragungsanforderungen für einen einzelnen Kanal mithilfe einer FIFO-Warteschlange serialisieren. Die gesammelten Anforderungen werden in der Reihenfolge ihres Eingangs ausgeführt, wobei in der Regel die erste Anforderung, die ein freies Objekt erreicht, die Ausführung einleitet. Neue Anforderungen können hinzugefügt werden, während das Objekt aktiv ist, und werden zurückgestellt, bis alle zuvor eingegangenen Anforderungen erfolgreich abgeschlossen wurden.

Wenn eine Anfrage einen Übertragungsfehler verursacht, wird die Ausführung angehalten, und alle nachfolgenden Anfragen werden nicht bearbeitet. Derzeit bedeutet dies, dass deren Rückruffunktionen zur Abschlussbestätigung überhaupt nicht ausgelöst werden.

*HINWEIS*: Ich bin mir nicht ganz sicher, ob es sinnvoll ist, die Rückruffunktionen zur Fertigstellung der nicht bearbeiteten Anfragen nach einem Fehler, der das Warteschlangenobjekt stoppt, nicht auszulösen. Dies zwingt den Nutzer der Warteschlange dazu, sich ebenfalls an die Rückruffunktionen zu erinnern und diese auszuführen. Denn andernfalls würde alles im System, was auf eine Benachrichtigung über den Status einer Anfrage angewiesen ist, in der Schwebe bleiben. Ich komme langsam zu der Überzeugung, dass es sinnvoller ist, die entsprechenden Abschluss-Callbacks mit einer Fehlermeldung über den Abbruch der Warteschlange und einer übertragenen Datenmenge von 0 Byte auszulösen.

Alle Transferanfragen haben folgende Form:

```
	{type data options...}
```

wobei *type* zu {**chan**, **string**} gehört und *data* die zu übertragenden Informationen festlegt. Bei **chan** handelt es sich bei *data* um das Handle des Kanals, der die tatsächlich zu übertragenden Informationen enthält, während *data* bei **string** direkt die zu übertragenden Informationen enthält. Die *options* sind eine Liste dieser Optionen und ihrer Werte und entsprechen denen, die von den Low-Level-Kopieroperationen des Pakets **transfer::copy** akzeptiert werden. Beachten Sie, wie sich die Anfrage allein dadurch, dass man ihr „[transfer::copy::do][copyops]“ voranstellt und ein Kanal-Handle zwischen *data* und *options* einfügt, auf einfache Weise von einer reinen Datenstruktur in einen Befehl verwandelt, dessen Auswertung die Anfrage ausführt.

# API

## Paketbefehle

**transfer::copy::queue** *objectName* *outchannel* ?*options*...?
: Dieser Befehl erstellt ein neues Warteschlangenobjekt für die Verwaltung des Kanals *outchannel* mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten [Objektbefehl] und [Objektmethoden] ausführlich erläutert. Die unterstützten *options* werden im Abschnitt [Optionen] erläutert.

    Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace. Der vollständig qualifizierte Name des Objektbefehls wird als Ergebnis des Befehls zurückgegeben.


## Objektbefehl

Alle mit dem Befehl **::transfer::copy::queue** erstellten Objekte haben die folgende allgemeine Form:

*objectName* **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt [Objektmethoden].


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt. Wenn Sie dies tun, während das Objekt gerade beschäftigt ist, kommt es später zu Fehlern, wenn die aktuell ausgeführte Anfrage abgeschlossen ist und versucht, auf die nun fehlenden Datenstrukturen des gelöschten Objekts zuzugreifen.

*objectName* **busy**
: Diese Methode gibt einen booleschen Wert zurück, der angibt, ob das Objekt derzeit eine Anfrage bearbeitet (d. h. *busy*, Wert **True**) oder nicht (d. h. *im Leerlauf*, Wert **False**).

*objectName* **pending**
: Diese Methode gibt die Anzahl der Anfragen zurück, die derzeit in der Warteschlange auf ihre Ausführung warten. Eine Anfrage, die gerade bearbeitet wird, wird nicht als wartend gezählt.

*objectName* **put** *request*
: Diese Methode fügt die Übertragung *request* in die Warteschlange der ausstehenden Anforderungen des Objekts ein. Wenn das Objekt *idle* ist, wird es *busy* und bearbeitet die Anforderung unverzüglich. Andernfalls wird die Bearbeitung der neuen Anforderung zurückgestellt, bis alle vorhergehenden Anforderungen bearbeitet wurden.


# Optionen

Die einzige bekannte Option ist **-on-status-change**. Sie ist optional und ist standardmäßig auf die leere Liste gesetzt, wodurch die Meldung von Statusänderungen deaktiviert wird. Andernfalls ist ihr Argument ein Befehlspräfix, das immer dann aufgerufen wird, wenn sich der interne Status des Objekts ändert. Die Rückruffunktion wird mit zwei zusätzlichen Argumenten aufgerufen, nämlich den Ergebnissen der Methoden **pending** und **busy**, in dieser Reihenfolge. Auf diese Weise kann jeder Benutzer beispielsweise leicht erkennen, wenn das Objekt alle ausstehenden Anfragen verarbeitet hat.

# Verwendung

Eine mögliche Anwendung dieses Pakets und dieser Klasse liegt in einem HTTP-1.1-Server, der die Ergebnisse verwaltet, die auf die Übertragung an den Client warten.

Beachten Sie, dass das System in dieser Anwendung zudem eine zusätzliche Datenstruktur benötigt, die noch ausstehende Ergebnisse erfasst, da diese möglicherweise in einer anderen Reihenfolge zurückkommen als die Anfragen des Clients, und diese in der richtigen Reihenfolge an die eigentliche Warteschlange übergibt.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *transfer* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Transfermodul

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[copyops]: copyops.md
