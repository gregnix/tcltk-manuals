---
CommandName: bell
title: bell
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - beep
 - bell
 - ring
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2000 Ajuba Solutions.
---

# Name

bell - Läutet die Klingel eines Displays

# Übersicht

::: {.synopsis} :::
[bell]{.cmd} [[-displayof]{.lit} [window]{.arg}]{.optarg} [-nice]{.optlit}
:::

# Beschreibung

Dieser Befehl läutet die Klingel auf dem Display von *window* und gibt eine leere Zeichenkette zurück. Fehlt die Option **-displayof**, wird das Display des Hauptfensters der Anwendung verwendet. Der Befehl nutzt die aktuellen Klingel-Einstellungen des Displays; Programme wie **xset** können sie ändern.

Ohne **-nice** setzt dieser Befehl auch den Bildschirmschoner des Bildschirms zurück. Manche Bildschirmschoner ignorieren das, andere setzen sich so zurück, dass der Bildschirm wieder sichtbar wird.
