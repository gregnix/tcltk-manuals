---
CommandName: memory
title: memory
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - Tcl_Alloc
 - Tcl_Free
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

[memory]{.cmd} [active]{.sub} [file]{.arg}
: Schreibt eine Liste aller derzeit allozierten Speicherbereiche in die angegebene *file*.

[memory]{.cmd} [break\_on\_malloc]{.sub} [count]{.arg}
: Nach *count* durchgeführten Allozierungen gibt [Tcl\_Alloc][Alloc] eine entsprechende Meldung aus und versucht, in den C-Debugger einzutreten. Tcl sendet sich dann ein *SIGINT*-Signal. Wenn Tcl unter einem C-Debugger läuft, sollte er in den Debugger-Befehlsmodus wechseln.

[memory]{.cmd} [info]{.sub}
: Gibt einen Bericht zurück mit den Gesamtanzahlen von Allozierungen und Freigaben seit Tcl-Start, derzeit allozierten Paketen (Anzahl von [Tcl\_Alloc][Alloc]-Aufrufen ohne entsprechenden [Tcl\_Free][Alloc]-Aufruf), derzeit allozierten Bytes sowie der maximalen Anzahl allozierter Pakete und Bytes.

[memory]{.cmd} [init]{.sub} \[on|off\]
: Schaltet die Vorinitialisierung allen allozierten Speichers mit Dummy-Bytes ein oder aus. Nützlich zum Erkennen der Verwendung nicht initialisierter Werte.

[memory]{.cmd} [objs]{.sub} [file]{.arg}
: Veranlasst, dass sofort eine Liste aller allozierten [Tcl\_Obj][Object]-Werte zusammen mit dem Ort ihrer Allozierung in die angegebene *file* geschrieben wird. Nützlich zur Prüfung auf Lecks von Werten.

[memory]{.cmd} [onexit]{.sub} [file]{.arg}
: Veranlasst, dass beim Finalisieren des Tcl-Speicher-Subsystems eine Liste aller allozierten Speicherbereiche in die angegebene *file* geschrieben wird. Nützlich zur Prüfung, dass der Speicher beim Prozessende ordnungsgemäß freigegeben wird.

[memory]{.cmd} [tag]{.sub} [string]{.arg}
: Jedem von [Tcl\_Alloc][Alloc] allozierten Speicherpaket kann ein Zeichenketten-Tag zugeordnet werden. In den von **memory active** und **memory onexit** erzeugten Listen wird das Tag jedes Pakets zusammen mit weiteren Informationen ausgegeben. Der Befehl **memory tag** setzt den Tag-Wert für nachfolgende [Tcl\_Alloc][Alloc]-Aufrufe auf *string*.

[memory]{.cmd} [trace]{.sub} \[on|off\]
: Schaltet Speicher-Tracing ein oder aus. Ist Speicher-Tracing aktiv, verursacht jeder [Tcl\_Alloc][Alloc]-Aufruf eine Trace-Zeile auf *stderr*, bestehend aus dem Wort *[Tcl\_Alloc][Alloc]*, gefolgt von der zurückgegebenen Adresse, der allozierten Speichermenge sowie C-Dateiname und Zeilennummer des allozierenden Codes. Beispiel:

    ```
    Tcl_Alloc 40e478 98 tclProc.c 1406
    ```

    [Tcl\_Free][Alloc]-Aufrufe werden auf dieselbe Weise protokolliert.

[memory]{.cmd} [trace\_on\_at\_malloc]{.sub} [count]{.arg}
: Aktiviert Speicher-Tracing nach *count* [Tcl\_Alloc][Alloc]-Aufrufen. Wird z. B. **memory trace\_on\_at\_malloc 100** eingegeben, werden ab dem 100. [Tcl\_Alloc][Alloc]-Aufruf Trace-Informationen für alle Allozierungen und Freigaben ausgegeben. Da vor einem Fehler viel Speicheraktivität auftreten kann, verringert ein gezielter Einsatz dieser Option die Verlangsamung durch Tracing (und die Menge der Trace-Daten), wenn die Anzahl der Allozierungen vor dem Auftreten des Problems bekannt ist. Bei einem Guard-Zone-Fehler wird die aktuelle Anzahl der Speicherallozierungen seit Tcl-Start ausgegeben.

[memory]{.cmd} [validate]{.sub} \[on|off\]
: Schaltet Speicher-Validierung ein oder aus. Ist sie aktiv, werden bei jedem [Tcl\_Alloc][Alloc]- oder [Tcl\_Free][Alloc]-Aufruf die Guard-Zonen jedes noch existierenden, von [Tcl\_Alloc][Alloc] allozierten Speicherbereichs geprüft. Das hat große Auswirkungen auf die Performance und sollte nur bei starkem Verdacht auf Überschreibungen verwendet werden. Vorteil: Eine Guard-Zone-Überschreibung kann schon beim ersten [Tcl\_Alloc][Alloc]- oder [Tcl\_Free][Alloc]-Aufruf nach der Überschreibung erkannt werden, nicht erst bei Freigabe des betroffenen Speichers — was lange danach erfolgen kann.


[Alloc]: ../tcl-c/Alloc.md
[DumpActiveMemory]: ../tcl-c/DumpActiveMemory.md
[Object]: ../tcl-c/Object.md
[TCL_MEM_DEBUG]: ../tcl-c/TCL_MEM_DEBUG.md
