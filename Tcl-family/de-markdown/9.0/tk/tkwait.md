---
CommandName: tkwait
title: tkwait
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - vwait(n)
Keywords:
 - variable
 - visibility
 - wait
 - window
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

tkwait - Wartet auf Variablenänderung oder Fensterzerstörung

# Übersicht

::: {.synopsis} :::
[tkwait]{.cmd} [variable]{.sub} [name]{.arg}
[tkwait]{.cmd} [visibility]{.sub} [name]{.arg}
[tkwait]{.cmd} [window]{.sub} [name]{.arg}
:::

# Beschreibung

Der Befehl **tkwait** wartet darauf, dass eines von mehreren Ereignissen eintritt, und kehrt dann zurück, ohne weitere Aktionen auszuführen. Der Rückgabewert ist stets eine leere Zeichenkette. Ist das erste Argument **variable** (oder eine Abkürzung davon), ist das zweite Argument der Name einer globalen Variable; der Befehl wartet, bis diese Variable geändert wird. Ist das erste Argument **visibility** (oder eine Abkürzung davon), ist das zweite Argument der Name eines Fensters; der Befehl **tkwait** wartet auf eine Änderung seines Sichtbarkeitszustands (angezeigt durch das Eintreffen eines VisibilityNotify-Ereignisses). Diese Form wird typischerweise verwendet, um zu warten, bis ein neu erstelltes Fenster auf dem Bildschirm erscheint, bevor eine Aktion ausgeführt wird. Ist das erste Argument **window** (oder eine Abkürzung davon), ist das zweite Argument der Name eines Fensters; der Befehl **tkwait** wartet, bis dieses Fenster zerstört wird. Diese Form wird typischerweise verwendet, um zu warten, bis der Benutzer die Interaktion mit einem Dialogfeld beendet hat, bevor das Ergebnis dieser Interaktion verwendet wird.

Während **tkwait** wartet, verarbeitet es Ereignisse auf übliche Weise, sodass die Anwendung weiterhin auf Benutzerinteraktionen reagiert. Ruft ein Ereignisbehandler **tkwait** erneut auf, muss der verschachtelte Aufruf von **tkwait** abgeschlossen sein, bevor der äußere Aufruf beendet werden kann.
