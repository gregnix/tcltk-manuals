---
CommandName: close
title: close
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - open(n)
 - socket(n)
 - eof(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - channel
 - close
 - nonblocking
 - half-close
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

close - Schließt einen offenen Kanal

# Übersicht

::: {.synopsis} :::
[close]{.cmd} [channelId]{.arg} [r(ead)|w(rite)]{.optarg}
:::

# Beschreibung

Schließt den durch *channelId* angegebenen Kanal ganz oder halb.

*ChannelId* muss der Bezeichner eines offenen Kanals sein, etwa eines Tcl-Standardkanals (**stdin**, **stdout** oder **stderr**), der Rückgabewert eines Aufrufs von [open] oder [socket] oder das Ergebnis eines Befehls zum Erzeugen von Kanälen aus einer Tcl-Erweiterung.

Die Form mit einem Argument ist ein einfaches vollständiges Schließen: Die gesamte gepufferte Ausgabe wird auf das Ausgabegerät des Kanals geleert, gepufferte Eingabe wird verworfen, die zugrunde liegende Datei oder das Gerät wird geschlossen, und *channelId* ist danach nicht mehr verwendbar.

Ist der Kanal blockierend, kehrt der Befehl erst zurück, wenn die gesamte Ausgabe geleert wurde. Ist der Kanal nicht blockierend und gibt es noch nicht geleerte Ausgabe, bleibt der Kanal geöffnet und der Befehl kehrt sofort zurück; die Ausgabe wird im Hintergrund geleert und der Kanal wird geschlossen, wenn das Leeren abgeschlossen ist.

Ist *channelId* ein blockierender Kanal einer Befehlspipeline, wartet **close**, bis die Kindprozesse beendet sind.

Wird der Kanal von mehreren Interpretern gemeinsam genutzt, macht **close** *channelId* im aufrufenden Interpreter unverfügbar, hat aber sonst keine Wirkung, bis alle beteiligten Interpreter den Kanal geschlossen haben. Ruft der letzte Interpreter, in dem der Kanal registriert ist, **close** auf, finden die oben beschriebenen Aufräumarbeiten statt. Eine Beschreibung der gemeinsamen Nutzung von Kanälen findet sich beim Befehl [interp].

Kanäle werden automatisch geschlossen, wenn ein Interpreter zerstört wird und wenn der Prozess beendet wird. [Ab 8.6 (TIP 398) werden nicht-blockierende Kanäle beim Beenden nicht mehr in den blockierenden Modus geschaltet; das garantiert ein zeitnahes Beenden, auch wenn der Partner oder ein Kommunikationskanal hängt. Damit hängende nicht-blockierende Kanäle beim Beenden geleert werden, muss man sie entweder (a) aktiv wieder blockierend schalten oder (b) die Umgebungsvariable TCL\_FLUSH\_NONBLOCKING\_ON\_EXIT setzen; ist sie gesetzt und ungleich „0“, gilt das bisherige Verhalten.]{version="8.6"}

Der Befehl gibt eine leere Zeichenkette zurück und kann einen Fehler erzeugen, wenn beim Leeren der Ausgabe ein Fehler auftritt. Gibt ein Befehl in einer mit [open] erzeugten Befehlspipeline einen Fehler zurück, erzeugt **close** einen Fehler (ähnlich dem Befehl [exec]).

[Die Zwei-Argument-Form ist ein Halbschließen: Bei einem bidirektionalen Kanal wie einem Socket oder einer Befehlspipeline und einer (gegebenenfalls abgekürzten) Richtung wird nur der Teilstrom in dieser Richtung geschlossen. Das ist ein shutdown() auf einem Socket und ein close() eines Pipe-Endes bei einer Befehlspipeline. Die Tcl-Kanalstruktur bleibt erhalten oder wird freigegeben, je nachdem, ob die andere Richtung noch offen ist.]{version="8.6"}

Ein close mit einem Argument auf einem bereits halb geschlossenen bidirektionalen Kanal schließt den Rest. Ein Halbschließen einer bereits geschlossenen Hälfte oder einer falschen Richtung eines unidirektionalen Kanals ist ein Fehler.

Bei einer Befehlspipeline obliegt das Einsammeln der Kindprozesse dem letzten close oder Halbschließen; dieser Aufruf darf daher einen Fehler wegen abnormaler Beendigung melden.

Derzeit unterstützen nur Sockets und Befehlspipelines das Halbschließen. Eine künftige Erweiterung wird dies auch für reflektierte und gestapelte Kanäle ermöglichen.

# Beispiele

So bleiben Dateien auch bei Fehlern geschlossen, wenn [catch], **close** und [return] kombiniert werden:

```
proc withOpenFile {filename channelVar script} {
    upvar 1 $channelVar chan
    set chan [open $filename]
    catch {
        uplevel 1 $script
    } result options
    close $chan
    return -options $options $result
}
```


[catch]: catch.md
[exec]: exec.md
[interp]: interp.md
[open]: open.md
[return]: return.md
[socket]: socket.md
