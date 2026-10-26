---
CommandName: memory
title: memory
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - ckalloc
 - ckfree
 - Tcl_ValidateAllMemory
 - Tcl_DumpActiveMemory
 - TCL_MEM_DEBUG
Keywords:
 - memory
 - debug
Copyright:
 - Copyright (c) 1992-1999 Karl Lehenbauer & Mark Diekhans
 - Copyright (c) 2000 Scriptics Corporation.
---

# Name

memory - Steuert die Tcl-Speicher-Debugging-Funktionen

# Übersicht

::: {.synopsis} :::
[memory]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Der Befehl **memory** gibt Tcl-Entwicklern die Kontrolle über die Speicher-Debugging-Funktionen von Tcl. Der Befehl **memory** hat mehrere Unteroptionen, die unten beschrieben werden. Er ist nur verfügbar, wenn Tcl mit aktiviertem Speicher-Debugging kompiliert wurde (wenn [TCL\_MEM\_DEBUG][TCL_MEM_DEBUG] zur Kompilierzeit definiert ist) und nachdem [Tcl\_InitMemory][DumpActiveMemory] aufgerufen wurde.

**memory active** *file*
: Schreibt eine Liste aller derzeit allozierten Speicherbereiche in die angegebene *file*.

**memory break\_on\_malloc** *count*
: Nach *count* durchgeführten Allozierungen gibt [ckalloc][Alloc] eine entsprechende Meldung aus und versucht, in den C-Debugger einzutreten. Tcl sendet sich dann ein *SIGINT*-Signal. Wenn Tcl unter einem C-Debugger läuft, sollte er in den Debugger-Befehlsmodus wechseln.

**memory info**
: Gibt einen Bericht zurück mit den Gesamtanzahlen von Allozierungen und Freigaben seit Tcl-Start, derzeit allozierten Paketen (Anzahl von [ckalloc][Alloc]-Aufrufen ohne entsprechenden [ckfree][Alloc]-Aufruf), derzeit allozierten Bytes sowie der maximalen Anzahl allozierter Pakete und Bytes.

**memory init** \[**on**|**off**\]
: Schaltet die Vorinitialisierung allen allozierten Speichers mit Dummy-Bytes ein oder aus. Nützlich zum Erkennen der Verwendung nicht initialisierter Werte.

**memory objs** *file*
: Veranlasst, dass sofort eine Liste aller allozierten [Tcl\_Obj][Object]-Werte zusammen mit dem Ort ihrer Allozierung in die angegebene *file* geschrieben wird. Nützlich zur Prüfung auf Lecks von Werten.

**memory onexit** *file*
: Veranlasst, dass beim Finalisieren des Tcl-Speicher-Subsystems eine Liste aller allozierten Speicherbereiche in die angegebene *file* geschrieben wird. Nützlich zur Prüfung, dass der Speicher beim Prozessende ordnungsgemäß freigegeben wird.

**memory tag** *string*
: Jedem von [ckalloc][Alloc] allozierten Speicherpaket kann ein Zeichenketten-Tag zugeordnet werden. In den von **memory active** und **memory onexit** erzeugten Listen wird das Tag jedes Pakets zusammen mit weiteren Informationen ausgegeben. Der Befehl **memory tag** setzt den Tag-Wert für nachfolgende [ckalloc][Alloc]-Aufrufe auf *string*.

**memory trace** \[**on**|**off**\]
: Schaltet Speicher-Tracing ein oder aus. Ist Speicher-Tracing aktiv, verursacht jeder [ckalloc][Alloc]-Aufruf eine Trace-Zeile auf *stderr*, bestehend aus dem Wort *ckalloc*, gefolgt von der zurückgegebenen Adresse, der allozierten Speichermenge sowie C-Dateiname und Zeilennummer des allozierenden Codes. Beispiel:

    ```
    ckalloc 40e478 98 tclProc.c 1406
    ```

    [ckfree][Alloc]-Aufrufe werden auf dieselbe Weise protokolliert.

**memory trace\_on\_at\_malloc** *count*
: Aktiviert Speicher-Tracing nach *count* [ckalloc][Alloc]-Aufrufen. Wird z. B. **memory trace\_on\_at\_malloc 100** eingegeben, werden ab dem 100. [ckalloc][Alloc]-Aufruf Trace-Informationen für alle Allozierungen und Freigaben ausgegeben. Da vor einem Fehler viel Speicheraktivität auftreten kann, verringert ein gezielter Einsatz dieser Option die Verlangsamung durch Tracing (und die Menge der Trace-Daten), wenn die Anzahl der Allozierungen vor dem Auftreten des Problems bekannt ist. Bei einem Guard-Zone-Fehler wird die aktuelle Anzahl der Speicherallozierungen seit Tcl-Start ausgegeben.

**memory validate** \[**on**|**off**\]
: Schaltet Speicher-Validierung ein oder aus. Ist sie aktiv, werden bei jedem [ckalloc][Alloc]- oder [ckfree][Alloc]-Aufruf die Guard-Zonen jedes noch existierenden, von [ckalloc][Alloc] allozierten Speicherbereichs geprüft. Das hat große Auswirkungen auf die Performance und sollte nur bei starkem Verdacht auf Überschreibungen verwendet werden. Vorteil: Eine Guard-Zone-Überschreibung kann schon beim ersten [ckalloc][Alloc]- oder [ckfree][Alloc]-Aufruf nach der Überschreibung erkannt werden, nicht erst bei Freigabe des betroffenen Speichers — was lange danach erfolgen kann.


[Alloc]: ../tcl-c/Alloc.md
[DumpActiveMemory]: ../tcl-c/DumpActiveMemory.md
[Object]: ../tcl-c/Object.md
[TCL_MEM_DEBUG]: ../tcl-c/TCL_MEM_DEBUG.md
