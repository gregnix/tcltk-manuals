---
CommandName: canvas::highlight
title: canvas::highlight
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - enter callback
 - highlighting
 - leave callback
Copyright:
---

# Name

canvas::highlight – Verwaltung der Hervorhebung von Canvas-Elementen oder Elementgruppen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::highlight]{.lit} [0.1]{.optlit}
[::canvas::highlight]{.cmd} [on]{.lit} [canvas]{.arg} [tagOrId]{.arg} [cmd]{.arg}
[::canvas::highlight]{.cmd} [off]{.lit} [canvas]{.arg} [tagOrId]{.arg}
[{\*}cmd]{.cmd} [on]{.lit} [canvas]{.arg} [item]{.arg}
[{\*}cmd]{.cmd} [off]{.lit} [canvas]{.arg} [clientdata]{.arg}
:::

# Beschreibung

Dieses Paket enthält Hilfsprogramme für Befehle zum Ein- und Ausschalten von Hervorhebungen für Canvas-Elemente oder Elementgruppen, wobei letztere durch einen Tag gekennzeichnet sind.

# API

**::canvas::highlight** **on** *canvas* *tagOrId* *cmd*
: Dieser Befehl richtet eine allgemeine Hervorhebung ein, wobei die Elemente des Canvas *canvas*, die auf diese Weise hervorgehoben werden sollen, durch *tagOrId* identifiziert werden und das Präfix *cmd* die Umsetzung, d. h. die Art und Weise, wie die Hervorhebung durchgeführt werden soll, festlegt.

    Die Signatur des Befehlspräfixes wird später im Abschnitt [Callback für die Hervorhebung] beschrieben.

    Das Ergebnis des Befehls ist die leere Zeichenkette.

    Einschränkungen:

    1. Wenn eine Hervorhebung aktiv ist, kann keine weitere Hervorhebung aktiviert werden. Das bedeutet, dass verschachtelte Hervorhebungen nicht möglich sind.

    2. Das System kann abstürzen, wenn eine Hervorhebung innerhalb ihrer Rückruffunktion für die Hervorhebung entfernt wird.


**::canvas::highlight** **off** *canvas* *tagOrId*
: Dieser Befehl entfernt alle Hervorhebungen, die für die Elemente des Canvas *canvas* festgelegt wurden, die durch *tagOrId* identifiziert werden.

    Das Ergebnis des Befehls ist die leere Zeichenkette.


## Callback für die Hervorhebung

Der „Highlight“-Callback ist ein Befehlspräfix, das auf die folgenden zwei Arten aufgerufen wird:

**{\*}cmd** **on** *canvas* *item*
: Diese Funktion wird aufgerufen, wenn die Maus in eines der Elemente gelangt ist, für die die Hervorhebung eingerichtet wurde. Die Rückruffunktion muss nun alle notwendigen Neukonfigurationen vornehmen, um das Element (die Gruppe) hervorzuheben.

    Das Ergebnis des Befehls kann beliebig sein. Es wird vom System als Client-Information gespeichert und unverändert an die Rückruffunktion zum Aufheben der Hervorhebung zur weiteren Verwendung übergeben. Auf diese Weise kann die Rückruffunktion zur Hervorhebung einen benutzerdefinierten Zustand vom Hervorheben bis zum Aufheben der Hervorhebung beibehalten.

    Hinweis: Die Rückruffunktion muss weder den Zustand verwalten noch das Element (die Gruppe) tatsächlich neu konfigurieren. Im letzteren Fall dient die Rückruffunktion lediglich als einfache Benachrichtigung über das Betreten bzw. Verlassen des Bereichs.

**{\*}cmd** **off** *canvas* *clientdata*
: Diese Form wird aufgerufen, wenn die Maus (eines) der Elemente der derzeit aktiven Hervorhebung verlassen hat. Die Rückruffunktion muss nun alle erforderlichen Neukonfigurationen vornehmen, um die Hervorhebung des Elements (der Gruppe) aufzuheben.

    Das Ergebnis des Befehls muss ein boolescher Wert sein, dessen üblicher Wert **true** lautet. Durch die Rückgabe von **false** kann die Rückruffunktion das Aufheben der Hervorhebung verhindern.


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
