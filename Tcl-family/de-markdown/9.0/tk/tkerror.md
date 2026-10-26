---
CommandName: tkerror
title: tkerror
ManualSection: n
Version: 4.1
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - background error
 - reporting
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

tkerror - Befehl zur Verarbeitung von Hintergrundfehlern

# Übersicht

::: {.synopsis} :::
[tkerror]{.cmd} [message]{.arg}
:::

# Beschreibung

Hinweis: Ab Tk 4.1 wurde der Befehl **tkerror** in [bgerror] umbenannt, weil die Ereignisschleife (die ihn normalerweise aufruft) nun Teil von Tcl ist. Die Verwendung des Namens **tkerror** ist veraltet.
Zur Abwärtskompatibilität versucht die vom aktuellen Tk bereitgestellte [bgerror] weiterhin, **tkerror** aufzurufen, falls einer vorhanden ist (oder per Auto-Load geladen werden kann), sodass alte Skripte, die diesen Fehlerbehandler definieren, weiterhin funktionieren sollten. Sie sollten Ihre Skripte dennoch auf [bgerror] statt **tkerror** umstellen, da die Unterstützung für den alten Namen in Zukunft entfallen könnte. Schlägt dieser Aufruf fehl, zeigt [bgerror] einen Dialog mit der Fehlermeldung an und bietet dem Benutzer an, den Stack-Trace anzuzeigen. Wenn Sie eine eigene Fehlerbehandlung wünschen, sollten Sie [bgerror] direkt überschreiben statt **tkerror**. Die Dokumentation zu [bgerror] ist Teil der Tcl-Dokumentation.


[bgerror]: ../tcl/bgerror.md
