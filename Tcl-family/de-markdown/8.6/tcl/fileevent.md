---
CommandName: fileevent
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - fconfigure(n)
 - gets(n)
 - interp(n)
 - puts(n)
 - read(n)
 - Tcl_StandardChannels(3)
Keywords:
 - asynchronous I/O
 - blocking
 - channel
 - event handler
 - nonblocking
 - readable
 - script
 - writable
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2008 Pat Thoyts
---

# NAME

fileevent - Führt ein Skript aus, wenn ein Kanal lesbar oder beschreibbar wird

# ÜBERSICHT

::: {.synopsis} :::
[fileevent]{.cmd} [channelId]{.arg} [readable]{.lit} [script]{.optarg} 
[fileevent]{.cmd} [channelId]{.arg} [writable]{.lit} [script]{.optarg} 
:::

# BESCHREIBUNG

Dieser Befehl wird verwendet, um *Datei-Ereignis-Handler* zu erstellen. Ein Datei-Ereignis-Handler ist eine Verknüpfung zwischen einem Kanal und einem Skript, sodass das Skript ausgewertet wird, sobald der Kanal lesbar oder beschreibbar wird. Datei-Ereignis-Handler werden am häufigsten genutzt, um Daten von einem anderen Prozess ereignisgesteuert zu empfangen, sodass der Empfänger weiter mit dem Benutzer interagieren kann, während er auf die Daten wartet. Ruft eine Anwendung **gets** oder **read** auf einem blockierenden Kanal auf, wenn keine Eingabedaten verfügbar sind, blockiert der Prozess; bis die Eingabedaten eintreffen, kann er keine anderen Ereignisse bedienen und wirkt für den Benutzer „eingefroren“. Mit **fileevent** kann der Prozess erkennen, wann Daten vorliegen, und **gets** oder **read** nur aufrufen, wenn sie nicht blockieren.

Das Argument *channelId* von **fileevent** bezeichnet einen geöffneten Kanal wie einen Tcl-Standardkanal (**stdin**, **stdout** oder **stderr**), den Rückgabewert eines Aufrufs von **open** oder **socket** oder das Ergebnis eines von einer Tcl-Erweiterung bereitgestellten Kanalerzeugungsbefehls.

Ist das Argument *script* angegeben, erstellt **fileevent** einen neuen Ereignis-Handler: *script* wird ausgewertet, sobald der Kanal lesbar oder beschreibbar wird (je nach dem zweiten Argument von **fileevent**). In diesem Fall gibt **fileevent** eine leere Zeichenkette zurück. Die Handler für lesbare und beschreibbare Ereignisse einer Datei sind unabhängig und können getrennt erstellt und gelöscht werden. Es darf jedoch höchstens ein Handler für **readable** und einer für **writable** pro Datei zur gleichen Zeit im gleichen Interpreter existieren. Wird **fileevent** aufgerufen, wenn der angegebene Handler im aufrufenden Interpreter bereits existiert, ersetzt das neue Skript das alte.

Ist *script* nicht angegeben, gibt **fileevent** das aktuelle Skript für *channelId* zurück oder eine leere Zeichenkette, wenn keines existiert. Wird *script* als leere Zeichenkette angegeben, wird der Ereignis-Handler gelöscht, sodass kein Skript mehr ausgeführt wird. Ein Datei-Ereignis-Handler wird auch automatisch gelöscht, wenn sein Kanal geschlossen wird oder sein Interpreter zerstört wird.

Ein Kanal gilt als lesbar, wenn auf dem zugrunde liegenden Gerät ungelesene Daten verfügbar sind. Ein Kanal gilt auch als lesbar, wenn ungelesene Daten in einem Eingabepuffer liegen, außer im Sonderfall, dass der letzte Leseversuch vom Kanal ein **gets**-Aufruf war, der keine vollständige Zeile im Eingabepuffer finden konnte. So kann eine Datei zeilenweise im nicht blockierenden Modus mit Ereignissen gelesen werden. Ein Kanal gilt außerdem als lesbar, wenn auf der zugrunde liegenden Datei oder dem Gerät ein Dateiende- oder Fehlerzustand vorliegt. *script* sollte diese Zustände prüfen und angemessen behandeln; ohne besondere Prüfung auf Dateiende kann eine Endlosschleife entstehen, in der *script* keine Daten liest, zurückkehrt und sofort erneut aufgerufen wird.

Ein Kanal gilt als beschreibbar, wenn mindestens ein Byte auf die zugrunde liegende Datei oder das Gerät ohne Blockieren geschrieben werden kann oder ein Fehlerzustand auf der zugrunde liegenden Datei oder dem Gerät vorliegt.

Ereignisgesteuerte E/A funktioniert am besten für Kanäle, die mit **fconfigure** in den nicht blockierenden Modus versetzt wurden. Im blockierenden Modus kann ein **puts**-Befehl blockieren, wenn mehr Daten übergeben werden, als die zugrunde liegende Datei oder das Gerät aufnehmen kann, und **gets** oder **read** blockieren, wenn mehr Daten gelesen werden sollen als bereitstehen; dass eine zugrunde liegende Datei oder ein Gerät lesbar ist, garantiert nicht einmal, dass ein blockierendes [read 1] erfolgreich ist (Gegenbeispiele sind Mehrbyte-Kodierungen, Kompressions- oder Verschlüsselungstransformationen). In all diesen Fällen werden keine Ereignisse verarbeitet, solange die Befehle blockieren.

Im nicht blockierenden Modus blockieren **puts**, **read** und **gets** nie. In der Dokumentation der einzelnen Befehle finden sich Angaben zum Umgang mit blockierenden und nicht blockierenden Kanälen.

Die Prüfung auf Dateiende sollte nach jedem Versuch, Kanaldaten zu lesen, erfolgen. Das eof-Flag wird gesetzt, sobald ein Leseversuch das Datenende erreicht hat; eine Prüfung davor erfordert ein zusätzliches Ereignis.

Das Skript eines Datei-Ereignisses wird auf globaler Ebene (außerhalb des Kontexts einer Tcl-Prozedur) in dem Interpreter ausgeführt, in dem **fileevent** aufgerufen wurde. Tritt beim Ausführen des Skripts ein Fehler auf, meldet der mit **interp bgerror** registrierte Befehl den Fehler. Außerdem wird der Datei-Ereignis-Handler gelöscht, wenn er jemals einen Fehler zurückgibt; das verhindert Endlosschleifen durch fehlerhafte Handler.

# BEISPIELE

In dieser Konfiguration wird **GetData** mit dem Kanal als Argument aufgerufen, sobald $chan lesbar wird. Der **read**-Aufruf liest alle derzeit verfügbaren Binärdaten ohne Blockieren. Hier wird das fileevent entfernt, wenn ein Dateiende eintritt, um ständige Aufrufe zu vermeiden (siehe oben). Alternativ kann der Kanal in diesem Fall geschlossen werden.

```
proc GetData {chan} {
    set data [read $chan]
    puts "[string length $data] $data"
    if {[eof $chan]} {
        fileevent $chan readable {}
    }
}

fconfigure $chan -blocking 0 -translation binary
fileevent $chan readable [list GetData $chan]
```

Das nächste Beispiel zeigt die Verwendung von **gets** zum zeilenweisen Lesen von Daten.

```
proc GetData {chan} {
    if {[gets $chan line] >= 0} {
        puts $line
    }
    if {[eof $chan]} {
        close $chan
    }
}

fconfigure $chan -blocking 0 -buffering line -translation crlf
fileevent $chan readable [list GetData $chan]
```

# DANKSAGUNGEN

**fileevent** basiert auf dem Befehl **addinput**, den Mark Diekhans erstellt hat.
