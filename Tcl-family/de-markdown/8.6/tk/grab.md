---
CommandName: grab
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - busy(n)
Keywords:
 - grab
 - keyboard events
 - pointer events
 - window
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

grab - Maus- und Tastaturereignisse auf einen Fenster-Unterbaum beschränken

# ÜBERSICHT

::: {.synopsis} :::
[grab]{.cmd} [-global]{.optlit} [window]{.arg} 
[grab]{.cmd} [option]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl implementiert einfache Maus- und Tastatur-Grabs für Tk. Tk-Grabs unterscheiden sich von den in der Xlib-Dokumentation beschriebenen Grabs. Ist für ein bestimmtes Fenster ein Grab gesetzt, beschränkt Tk alle Mauszeigerereignisse auf das Grab-Fenster und dessen Nachkommen in der Tk-Fensterhierarchie. Befindet sich der Mauszeiger innerhalb des Unterbaums des Grab-Fensters, verhält er sich genau so, als ob kein Grab aktiv wäre, und alle Ereignisse werden wie üblich gemeldet. Befindet sich der Mauszeiger außerhalb des Baums von *window*, werden Tastendrücke und -loslassungen sowie Mausbewegungen an *window* gemeldet; Fenstereintritts- und -austrittsereignisse werden ignoriert. Der Grab-Unterbaum besitzt den Mauszeiger: Fenster außerhalb des Grab-Unterbaums sind auf dem Bildschirm sichtbar, sind jedoch unempfindlich, bis der Grab freigegeben wird. Der Baum der Fenster unter dem Grab-Fenster kann Toplevel-Fenster enthalten; dann erhalten alle diese Toplevel-Fenster und ihre Nachkommen während des Grabs weiterhin Mausereignisse.

Zwei Grab-Formen sind möglich: lokal und global. Ein lokaler Grab betrifft nur die anfordernde Anwendung: Ereignisse werden an andere Anwendungen so gemeldet, als ob kein Grab stattgefunden hätte. Grabs sind standardmäßig lokal. Ein globaler Grab sperrt alle Anwendungen auf dem Bildschirm, sodass nur der angegebene Unterbaum der anfordernden Anwendung auf Mauszeigerereignisse reagiert (Tastendrücke und -loslassungen, Mausbewegungen, Fenstereintritte und -austritte). Während globaler Grabs erhält auch der Window-Manager keine Mauszeigerereignisse.

Bei lokalen Grabs werden Tastaturereignisse (Tastendrücke und -loslassungen) wie gewohnt zugestellt: Der Window-Manager steuert, welche Anwendung Tastaturereignisse erhält; gehen sie an ein Fenster der anfordernden Anwendung, werden sie an das Fokusfenster umgeleitet. Bei einem globalen Grab übernimmt Tk die Tastatur; alle Tastaturereignisse gehen stets an die anfordernde Anwendung. Der Befehl **focus** legt weiterhin fest, welches Fenster in der Anwendung die Tastaturereignisse erhält. Der Tastatur-Grab wird freigegeben, wenn der Grab endet.

Unter macOS betrifft ein globaler Grab alle von einem Tk-Prozess erzeugten Fenster. Kein anderes Fenster in diesem Prozess kann fokussiert werden, daher erhält kein anderes Fenster Tastatur- oder Mausereignisse. Ein lokaler Grab unter macOS betrifft alle von einem Tcl-Interpreter erzeugten Fenster. Während eines lokalen Grabs kann jedes Fenster des Tk-Prozesses fokussiert werden, aber das Grab-Fenster ist das einzige Fenster seines Interpreters, das Tastatur- oder Mausereignisse erhält. Fenster desselben Prozesses, die von anderen Interpretern erzeugt wurden, erhalten Tastatur- und Mausereignisse weiterhin normal.

Grabs gelten für bestimmte Displays. Hat eine Anwendung Fenster auf mehreren Displays, kann sie pro Display einen separaten Grab setzen. Der Grab auf einem Display betrifft nur die Fenster auf diesem Display. Verschiedene Anwendungen auf einem Display können gleichzeitig lokale Grabs haben, aber nur eine Anwendung kann gleichzeitig einen globalen Grab auf einem Display haben.

Der Befehl **grab** kann eine der folgenden Formen annehmen:

**grab** ?**-global**? *window*
: Entspricht **grab set**, siehe unten.

**grab current** ?*window*?
: Ist *window* angegeben, gibt der Befehl den Namen des aktuellen Grab-Fensters dieser Anwendung für das Display von *window* zurück, oder eine leere Zeichenkette, wenn keines existiert. Wird *window* weggelassen, liefert der Befehl eine Liste aller von dieser Anwendung auf allen Displays gehaltenen Grab-Fenster, oder eine leere Zeichenkette, wenn die Anwendung keine Grabs hat.

**grab release** *window*
: Gibt den Grab auf *window* frei, falls einer gesetzt ist; andernfalls keine Wirkung. Gibt eine leere Zeichenkette zurück.

**grab set** ?**-global**? *window*
: Setzt einen Grab auf *window*. Mit **-global** ist der Grab global, andernfalls lokal. War für diese Anwendung auf dem Display von *window* bereits ein Grab aktiv, wird er automatisch freigegeben. Existiert bereits ein Grab auf *window* in derselben global/lokal-Form wie angefordert, tut der Befehl nichts. Gibt eine leere Zeichenkette zurück.

**grab status** *window*
: Gibt **none** zurück, wenn auf *window* kein Grab gesetzt ist, **local** bei lokalem Grab und **global** bei globalem Grab.

# WARNUNG

Mit globalen Grabs lässt sich ein Display sehr leicht vollständig unbenutzbar machen (z. B. Grab auf ein Widget ohne Ereignisbehandlung, ohne Mechanismus zur Freigabe). Seien Sie bei der Verwendung *äußerst* vorsichtig!

# FEHLER

Die beschriebene einfache Grab-Wirkung erforderte eine außerordentlich komplexe und unschöne Implementierung. Bei der gegenwärtigen Implementierung ist es für Anwendungen nicht sicher, die Xlib-Grab-Funktionen außer über die Tk-Grab-Prozeduren zu nutzen. Versuchen Anwendungen, X-Grab-Mechanismen direkt zu manipulieren, wird es vermutlich Probleme geben.

Verwaltet ein einzelner Prozess mehrere Tk-Anwendungen, kann jeweils nur eine davon gleichzeitig einen lokalen Grab für ein Display haben. Liegen die Anwendungen in verschiedenen Prozessen, gilt diese Einschränkung nicht.

# BEISPIEL

Grab setzen, sodass aus einer Gruppe nur eine Schaltfläche per Maus klickbar ist. Die anderen reagieren erst nach Klick auf die mittlere Schaltfläche.

```
pack [button .b1 -text "Click me! #1" -command {destroy .b1}]
pack [button .b2 -text "Click me! #2" -command {destroy .b2}]
pack [button .b3 -text "Click me! #3" -command {destroy .b3}]
grab .b2
```
