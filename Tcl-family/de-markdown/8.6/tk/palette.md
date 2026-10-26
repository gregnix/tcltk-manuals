---
CommandName: tk_setPalette
title: tk_setPalette
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - bisque
 - color
 - palette
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# Name

tk\_setPalette, tk\_bisque - Ändert die Tk-Farbpalette

# Übersicht

::: {.synopsis} :::
[tk\_setPalette]{.cmd} [background]{.arg}
[tk\_setPalette]{.cmd} [name]{.arg} [value]{.arg} [name value]{.optdot}
[tk\_bisque]{.cmd}
:::

# Beschreibung

Die Prozedur **tk\_setPalette** ändert das Farbschema für Tk. Dazu werden die Farben bestehender Widgets geändert und die Optionsdatenbank so angepasst, dass zukünftig erstellte Widgets das neue Farbschema verwenden. Wird **tk\_setPalette** mit einem einzigen Argument aufgerufen, ist dieses Argument der Name einer Farbe, die als normale Hintergrundfarbe verwendet werden soll; **tk\_setPalette** berechnet daraus eine vollständige Farbpalette. Alternativ können die Argumente von **tk\_setPalette** aus beliebig vielen *name*-*value*-Paaren bestehen, wobei das erste Argument des Paars der Name einer Option in der Tk-Optionsdatenbank und das zweite Argument der neue Wert für diese Option ist. Folgende Datenbanknamen werden derzeit unterstützt:

::: {.info DISPLAY="yes"}
**activeBackground**	**foreground**	**selectColor**\
**activeForeground**	**highlightBackground**	**selectBackground**\
**background**	**highlightColor**	**selectForeground**\
**disabledForeground**	**insertBackground**	**troughColor**
:::

**tk\_setPalette** versucht, sinnvolle Standardwerte für alle Optionen zu berechnen, die Sie nicht angeben. Sie können auch andere Optionen als die oben genannten angeben; Tk ändert dann diese Optionen an Widgets ebenfalls. Diese Funktion kann nützlich sein, wenn Sie eigene Widgets mit zusätzlichen Farboptionen verwenden.

Nachdem **tk\_setPalette** für jede Farboption den neuen Wert ermittelt hat, durchsucht es die Widget-Hierarchie, um die Optionen aller bestehenden Widgets zu ändern. Für jedes Widget prüft es, ob eine der oben genannten Optionen für das Widget definiert ist. Ist das der Fall und hat die Option den aktuellen Standardwert, wird der Wert geändert; hat die Option einen anderen Wert als den Standard, ändert **tk\_setPalette** ihn nicht. Der Standardwert einer Option ist der vom Widget bereitgestellte (**\[lindex \[$w configure $option\] 3\]**), sofern **tk\_setPalette** nicht zuvor ausgeführt wurde; in diesem Fall ist es der Wert aus dem vorherigen Aufruf von **tk\_setPalette**.

Nach der Änderung aller Widgets in der Anwendung fügt **tk\_setPalette** der Optionsdatenbank Einträge hinzu, um die Standardwerte für künftig erstellte Widgets zu ändern. Die neuen Optionen werden mit der Priorität **widgetDefault** eingetragen, sodass sie durch Optionen aus der .Xdefaults-Datei oder durch Optionen auf der Befehlszeile beim Erstellen eines Widgets überschrieben werden können.

Die Prozedur **tk\_bisque** dient der Abwärtskompatibilität: Sie stellt die Anwendungsfarben auf das hellbraune („bisque“) Farbschema von Tk 3.6 und früheren Versionen zurück.
