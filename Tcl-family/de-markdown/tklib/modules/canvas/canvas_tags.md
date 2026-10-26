---
CommandName: canvas::tag
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - append tag
 - canvas
 - insert tag
 - remove tag
 - tags
Copyright:
---

# NAME

canvas::tag – Einfachere Verwaltung der Tags bei Canvas-Elementen oder Elementgruppen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::tag]{.lit} [0.1]{.optlit} 
[::canvas::tag]{.cmd} [append]{.sub} [canvas]{.arg} [tagOrId]{.arg} [tag...]{.arg} 
[::canvas::tag]{.cmd} [prepend]{.sub} [canvas]{.arg} [tagOrId]{.arg} [tag...]{.arg} 
[::canvas::tag]{.cmd} [append]{.sub} [canvas]{.arg} [tagOrId]{.arg} [index]{.arg} [tag...]{.arg} 
[::canvas::tag]{.cmd} [remove]{.sub} [canvas]{.arg} [tagOrId]{.arg} [tag...]{.arg} 
[::canvas::tag]{.cmd} [match]{.sub} [canvas]{.arg} [tagOrId]{.arg} [pattern]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle, die die Verwaltung der mit Canvas-Elementen oder Elementgruppen verknüpften Tag-Listen erleichtern.

Das Problem bei der bestehenden Canvas-API besteht darin, dass eine Tag-Liste nur als Ganzes festgelegt werden kann, wodurch das Hinzufügen und Entfernen von Tags aus solchen Listen zu relativ komplexen Vorgängen wird, bei denen die aktuelle Tag-Liste gelesen, geändert und anschließend die geänderte Liste wieder zurückgeschrieben werden muss.

Die in diesem Paket enthaltenen Befehle verbergen all diese Komplexität vor dem Benutzer.

# API

**::canvas::tag** **append** *canvas* *tagOrId* *tag*...
: Dieser Befehl fügt die Tags *tag*... zur Tag-Liste der Elemente hinzu, die durch *tagOrId* im *canvas*-Widget identifiziert werden. Die neuen Tags werden am Ende der Liste hinzugefügt. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::canvas::tag** **prepend** *canvas* *tagOrId* *tag*...
: Dieser Befehl fügt die Tags *tag*... zur Tag-Liste der Elemente hinzu, die durch *tagOrId* im *canvas*-Widget identifiziert werden. Die neuen Tags werden am Anfang der Liste eingefügt. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::canvas::tag** **append** *canvas* *tagOrId* *index* *tag*...
: Dieser Befehl fügt die Tags *tag*... zur Tag-Liste der Elemente hinzu, die durch *tagOrId* im *canvas*-Widget identifiziert werden. Die neuen Tags werden vor dem Element an Position *index* eingefügt. *index* **0** bezieht sich auf den Anfang der Liste. *index* **end** bezieht sich auf die Position nach dem Ende der Liste. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::canvas::tag** **remove** *canvas* *tagOrId* *tag*...
: Dieser Befehl entfernt die genannten Tags *tag*... aus der Tag-Liste der Elemente, die durch *tagOrId* im *canvas*-Widget identifiziert werden. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::canvas::tag** **match** *canvas* *tagOrId* *pattern*
: Dieser Befehl ermittelt alle Tags für die Elemente, die durch *tagOrId* im *canvas*-Widget identifiziert werden und dem Glob-Muster *pattern* entsprechen. Das Ergebnis des Befehls ist eine Liste der übereinstimmenden Tags. Diese Liste kann leer sein.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
