---
CommandName: pid
ManualSection: n
Version: 7.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - exec(n)
 - open(n)
Keywords:
 - file
 - pipeline
 - process identifier
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

pid - Ermittelt Prozesskennungen

# ÜBERSICHT

::: {.synopsis} :::
[pid]{.cmd} [fileId]{.optarg} 
:::

# BESCHREIBUNG

Ist das Argument *fileId* angegeben, sollte es normalerweise auf eine mit **open** erzeugte Prozess-Pipeline verweisen. In diesem Fall gibt **pid** eine Liste zurück, deren Elemente die Prozesskennungen aller Prozesse in der Pipeline in Reihenfolge sind. Die Liste ist leer, wenn *fileId* eine geöffnete Datei bezeichnet, die keine Prozess-Pipeline ist. Ohne *fileId* gibt **pid** die Prozesskennung des aktuellen Prozesses zurück. Alle Prozesskennungen werden als Dezimalzeichenketten zurückgegeben.

# BEISPIEL

Prozessinformationen zu den Prozessen einer Pipeline mit dem SysV-Programm **ps** ausgeben, bevor die Pipeline-Ausgabe gelesen wird:

```
set pipeline [open "| zcat somefile.gz | grep foobar | sort -u"]
# Prozessinformationen ausgeben
exec ps -fp [pid $pipeline] >@stdout
# Trennzeile und dann die Pipeline-Ausgabe
puts [string repeat - 70]
puts [read $pipeline]
close $pipeline
```
