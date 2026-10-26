---
CommandName: process
title: process
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - exec(n)
 - open(n)
 - pid(n)
 - Tcl_DetachPids(3)
 - Tcl_WaitPid(3)
 - Tcl_ReapDetachedProcs(3)
Keywords:
 - background
 - child
 - detach
 - process
 - wait
Copyright:
 - Copyright (c) 2017 Frederic Bonnet.
---

# Name

tcl::process - Verwaltung von Unterprozessen

# Übersicht

::: {.synopsis} :::
[::tcl::process]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl bietet eine Möglichkeit, Unterprozesse zu verwalten, die von den Befehlen [open] und [exec] erstellt wurden, identifiziert anhand der Prozess-IDs (PIDs) dieser Unterprozesse. Die zulässigen *options* (können abgekürzt werden) sind:

[::tcl::process]{.cmd} [autopurge]{.sub} [flag]{.optarg}
: Automatische Bereinigungsfunktion. Wird *flag* als boolescher Wert angegeben, aktiviert oder deaktiviert er autopurge. In allen Fällen gibt er den aktuellen Status als booleschen Wert zurück. Ist autopurge aktiv, wird [Tcl\_ReapDetachedProcs][DetachPids] bei jedem Aufruf von [exec] oder beim Schließen eines von [open] erzeugten Pipe-Kanals aufgerufen. Ist autopurge inaktiv, muss **::tcl::process** purge explizit aufgerufen werden. Standardmäßig ist autopurge aktiv.

[::tcl::process]{.cmd} [list]{.sub}
: Gibt die Liste der Unterprozess-PIDs zurück. Dazu gehören alle derzeit laufenden Unterprozesse sowie alle beendeten Unterprozesse, deren zugehörige Prozesstabelleneinträge noch nicht bereinigt wurden.

[::tcl::process]{.cmd} [purge]{.sub} [pids]{.optarg}
: Bereinigt alle Daten zu beendeten Unterprozessen. Wird *pids* als Liste von PIDs angegeben, bereinigt der Befehl nur Daten der passenden Unterprozesse, sofern sie existieren. Ist ein gelisteter Prozess noch aktiv, tut der Befehl für diesen Prozess nichts. Jede PID, die keinem Unterprozess entspricht, wird ignoriert.

[::tcl::process]{.cmd} [status]{.sub} [switches]{.optarg} [pids]{.optarg}
: Gibt ein Dictionary zurück, das Unterprozess-PIDs ihren jeweiligen Status zuordnet. Wird *pids* als Liste von PIDs angegeben, liefert der Befehl nur den Status der passenden Unterprozesse, sofern sie existieren. Jede PID, die keinem Unterprozess entspricht, wird ignoriert. Für aktive Prozesse ist der Status ein leerer Wert. Für beendete Prozesse ist der Status eine Liste im folgenden Format: „**{***code* ?*msg errorCode*?**}**“, wobei:

    *code*
    : ein standardmäßiger Tcl-Rückgabecode ist, d. h. **0** für [TCL\_OK][catch] und **1** für [TCL\_ERROR][catch],

    *msg*
    : die menschenlesbare Fehlermeldung ist,

    *errorCode*
    : verwendet dasselbe Format wie die globale Variable [errorCode][tclvars]


    **msg** und [errorCode][tclvars] sind nur bei abnormal beendeten Prozessen vorhanden (d. h. wenn *code* ungleich null ist). Intern ruft dieser Befehl [Tcl\_WaitPid][DetachPids] mit gesetztem Flag **WNOHANG** für nicht-blockierendes Verhalten auf, sofern der Schalter **-wait** nicht gesetzt ist (siehe unten).

    Zusätzlich akzeptiert **::tcl::process status** folgende Schalter:

    [-wait]{.lit}
    : Standardmäßig kehrt der Befehl sofort zurück (der zugrunde liegende [Tcl\_WaitPid][DetachPids] wird mit gesetztem Flag **WNOHANG** aufgerufen), sofern dieser Schalter nicht gesetzt ist. Wird *pids* als Liste von PIDs angegeben, wartet der Befehl, bis der Status der passenden Unterprozesse verfügbar ist. Wurde *pids* nicht angegeben, wartet dieser Befehl auf alle bekannten Unterprozesse.

    [--]{.lit}
    : Markiert das Ende der Schalter. Das folgende Argument wird als erstes *arg* behandelt, auch wenn es mit **-** beginnt.



# Beispiele

Die folgenden Beispiele zeigen die Verwendung von **::tcl::process**. Einige Ergebnisse von **::tcl::process status** sind zur Lesbarkeit über mehrere Zeilen verteilt.

```
::tcl::process autopurge
     → true
::tcl::process autopurge false
     → false

set pid1 [exec command1 a b c | command2 d e f &]
     → 123 456
set chan [open "|command1 a b c | command2 d e f"]
     → file123
set pid2 [pid $chan]
     → 789 1011

::tcl::process list
     → 123 456 789 1011

::tcl::process status
     → 123 0
       456 {1 "child killed: write on pipe with no readers" {
         CHILDKILLED 456 SIGPIPE "write on pipe with no readers"}}
       789 {1 "child suspended: background tty read" {
         CHILDSUSP 789 SIGTTIN "background tty read"}}
       1011 {}

::tcl::process status 123
     → 123 0

::tcl::process status 1011
     → 1011 {}

::tcl::process status -wait
     → 123 0
       456 {1 "child killed: write on pipe with no readers" {
         CHILDKILLED 456 SIGPIPE "write on pipe with no readers"}}
       789 {1 "child suspended: background tty read" {
         CHILDSUSP 789 SIGTTIN "background tty read"}}
       1011 {1 "child process exited abnormally" {
         CHILDSTATUS 1011 -1}}

::tcl::process status 1011
     → 1011 {1 "child process exited abnormally" {
         CHILDSTATUS 1011 -1}}

::tcl::process purge
exec command1 1 2 3 &
     → 1213
::tcl::process list
     → 1213
```


[catch]: catch.md
[DetachPids]: ../tcl-c/DetachPids.md
[exec]: exec.md
[open]: open.md
[tclvars]: tclvars.md
