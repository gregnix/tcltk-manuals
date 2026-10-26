---
CommandName: close
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

# NAME

close - Schließt einen offenen Kanal

# ÜBERSICHT

::: {.synopsis} :::
[close]{.cmd} [channelId]{.arg} [r(ead)|w(rite)]{.optarg} 
:::

# BESCHREIBUNG

Der Befehl **close** wurde durch den Befehl **chan close** ersetzt, der die gleiche Syntax und die gleichen Optionen unterstützt.

::: {.info -version="8.6"}
Ab 8.6 (TIP 398) werden nicht-blockierende Kanäle beim Beenden nicht mehr in den blockierenden Modus geschaltet; das garantiert ein zeitnahes Beenden, auch wenn der Partner oder ein Kommunikationskanal hängt. Damit hängende nicht-blockierende Kanäle beim Beenden geleert werden, muss man sie entweder (a) aktiv wieder blockierend schalten oder (b) die Umgebungsvariable TCL_FLUSH_NONBLOCKING_ON_EXIT setzen; ist sie gesetzt und ungleich „0“, gilt das bisherige Verhalten.
:::

::: {.info -version="8.6"}
Die Zwei-Argument-Form ist ein Halbschließen: Bei einem bidirektionalen Kanal wie einem Socket oder einer Befehlspipeline und einer (gegebenenfalls abgekürzten) Richtung wird nur der Teilstrom in dieser Richtung geschlossen. Das ist ein shutdown() auf einem Socket und ein close() eines Pipe-Endes bei einer Befehlspipeline. Die Tcl-Kanalstruktur bleibt erhalten oder wird freigegeben, je nachdem, ob die andere Richtung noch offen ist.

Ein close mit einem Argument auf einem bereits halb geschlossenen bidirektionalen Kanal schließt den Rest. Ein Halbschließen einer bereits geschlossenen Hälfte oder einer falschen Richtung eines unidirektionalen Kanals ist ein Fehler.

Bei einer Befehlspipeline obliegt das Einsammeln der Kindprozesse dem letzten close oder Halbschließen; dieser Aufruf darf daher einen Fehler wegen abnormaler Beendigung melden.

Derzeit unterstützen nur Sockets und Befehlspipelines das Halbschließen.
:::

# BEISPIEL

So bleiben Dateien auch bei Fehlern geschlossen, wenn **catch**, **close** und **return** kombiniert werden:

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
