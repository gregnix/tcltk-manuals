---
CommandName: profiler
title: profiler
ManualSection: n
Version: 0.7
TclPart: tcllib
TclDescription: Tcl Profiler
Keywords:
 - performance
 - profile
 - speed
Copyright:
---

# Name

profiler – Tcl-Quellcode-Profiler

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [profiler]{.lit} [0.7]{.optlit}
[::profiler::init]{.cmd}
[::profiler::dump]{.cmd} [pattern]{.arg}
[::profiler::print]{.cmd} [pattern]{.optarg}
[::profiler::reset]{.cmd} [pattern]{.optarg}
[::profiler::suspend]{.cmd} [pattern]{.optarg}
[::profiler::resume]{.cmd} [pattern]{.optarg}
[::profiler::new-disabled]{.cmd}
[::profiler::new-enabled]{.cmd}
[::profiler::sortFunctions]{.cmd} [key]{.arg}
:::

# Beschreibung

Das Paket **profiler** stellt einen einfachen Tcl-Quellcode-Profiler bereit. Es handelt sich um einen Profiler auf Funktionsebene; das heißt, er erfasst lediglich Informationen auf Funktionsebene, nicht jedoch die detaillierteren Informationen auf Zeilenebene.  Er funktioniert durch die Neudefinition des Tcl-Befehls **proc**. Die Profilerstellung wird über den Befehl **::profiler::init** initiiert.

# Befehle

**::profiler::init**
: Profilierung starten. Alle Prozeduren, die nach dem Aufruf dieses Befehls erstellt werden, werden profiliert. Um eine gesamte Anwendung zu profilieren, muss dieser Befehl vor allen anderen Befehlen aufgerufen werden.

**::profiler::dump** *pattern*
: Gibt Profilierungsinformationen für alle Funktionen aus, die dem Muster *pattern* entsprechen.  Wenn kein Muster festgelegt wird, werden Informationen zu allen Funktionen zurückgegeben.  Das Ergebnis ist eine Liste von Schlüssel-Wert-Paaren, die Funktionsnamen Informationen zu der jeweiligen Funktion zuordnet.  Die Informationen zu jeder Funktion bestehen wiederum aus einer Liste von Schlüssel-Wert-Paaren. Die verwendeten Schlüssel und ihre Werte lauten wie folgt:

    **totalCalls**
    : Die Gesamtzahl der Aufrufe von *functionName*.

    **callerDist**
    : Eine Liste von Schlüssel-Wert-Paaren, in der jede aufrufende Funktion, die *functionName* aufgerufen hat, der Anzahl ihrer Aufrufe von *functionName* zugeordnet wird.

    **compileTime**
    : Die Laufzeit in Taktklicks der Funktion *functionName* bei ihrem ersten Aufruf.

    **totalRuntime**
    : Die Summe der Laufzeiten aller Aufrufe von *functionName*.

    **averageRuntime**
    : Durchschnittliche Laufzeit von *functionName*.

    **descendantTime**
    : Summe der Zeit, die in den Nachfolgern von *functionName* verbracht wurde.

    **averageDescendantTime**
    : Durchschnittliche Verweildauer in den untergeordneten Elementen von *functionName*.


**::profiler::print** ?*pattern*?
: Gibt die Profiling-Informationen für alle Funktionen aus, die dem Muster *pattern* entsprechen. Wenn kein Muster angegeben wird, werden Informationen zu allen Funktionen angezeigt. Das Ergebnis ist eine für den Menschen lesbare Darstellung der Profiling-Informationen.

**::profiler::reset** ?*pattern*?
: Die Profiling-Informationen für alle Funktionen, die dem Muster *pattern* entsprechen, werden zurückgesetzt. Wird kein Muster festgelegt, werden die Informationen für alle Funktionen zurückgesetzt.

**::profiler::suspend** ?*pattern*?
: Das Profiling für alle Funktionen, die dem Muster *pattern* entsprechen, wird ausgesetzt.  Wenn kein Muster angegeben wird, wird das Profiling für alle Funktionen ausgesetzt. Nach Ausführung dieses Befehls wird die Erfassung von Profiling-Informationen beendet. Bereits zuvor erfasste Profiling-Informationen werden jedoch nicht gelöscht.  Verwenden Sie den Befehl „resume“, um das Profiling wieder zu aktivieren.

**::profiler::resume** ?*pattern*?
: Fährt die Profilerstellung für alle Funktionen fort, die dem Muster *pattern* entsprechen.  Wenn kein Muster angegeben wird, wird die Profilerstellung für alle Funktionen fortgesetzt. Dieser Befehl sollte aufgerufen werden, nachdem der Profiler im Code angehalten wurde.

**::profiler::new-disabled**
: Ändert den anfänglichen Profiling-Status für neue Prozeduren. Durch den Aufruf dieses Befehls wird das Profiling für alle Prozeduren deaktiviert, die nach diesem Befehl erstellt werden, bis der Befehl **new-enabled** aufgerufen wird. Aktivieren Sie das Profiling bestimmter Prozeduren über den Befehl **resume**.

**::profiler::new-enabled**
: Ändert den anfänglichen Profiling-Status für neue Prozeduren. Durch den Aufruf dieses Befehls wird das Profiling für alle Prozeduren aktiviert, die nach diesem Befehl erstellt werden, bis der Befehl **new-disabled** aufgerufen wird. Verhindern Sie das Profiling bestimmter Prozeduren mithilfe von **suspend**.

**::profiler::sortFunctions** *key*
: Gibt eine Liste von Funktionen zurück, sortiert nach einer bestimmten Profiling-Statistik. Unterstützte Werte für *key* sind: **calls**, **exclusiveTime**, **compileTime**, **nonCompileTime**, **totalRuntime**, **avgExclusiveTime** und **avgRuntime**.  Das Rückgaberesultat ist eine Liste von Listen, wobei jede Unterliste aus einem Funktionsnamen und dem Wert von *key* für diese Funktion besteht.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *profiler* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge
