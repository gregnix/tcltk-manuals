---
CommandName: crosshair
ManualSection: n
Version: 1.2.1
TclPart: tklib
TclDescription: Crosshairs
Keywords:
 - canvas
 - cross-hairs
 - location
 - tracking
 - viewport
Copyright:
 - Copyright (c) 2003 Kevin Kenny
 - Copyright (c) 2008 (docs) Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2013 Frank Gover, Andreas Kupries
---

# NAME

crosshair – Fadenkreuze für das Tk-Canvas

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.optlit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.optlit} 
[package]{.cmd} [require]{.sub} [crosshair]{.lit} [1.2.1]{.optlit} 
[crosshair::crosshair]{.cmd} [w]{.arg} [arg]{.optdot} 
[crosshair::off]{.cmd} [w]{.arg} 
[crosshair::configure]{.cmd} [w]{.arg} [arg]{.optdot} 
[crosshair::track]{.cmd} [on]{.sub} [w]{.arg} [cmdprefix]{.arg} 
[crosshair::track]{.cmd} [off]{.sub} [w]{.arg} 
[crosshair::bbox_add]{.cmd} [w]{.arg} [bbox]{.arg} 
[crosshair::bbox_remove]{.cmd} [token]{.arg} 
:::

# BESCHREIBUNG

Das Paket **crosshair** stellt Befehle bereit, mit denen sich Fadenkreuze auf Canvas-Widgets ein- und ausschalten und verfolgen lassen.

# API

Die folgenden Befehle werden öffentlich bereitgestellt:

**crosshair::crosshair** *w* ?*arg*...?
: Dieser Befehl schaltet die Anzeige eines Fadenkreuzpaares für das Canvas-Widget *w* ein. Die Fadenkreuze folgen dem Zeigegerät. Das Ergebnis des Befehls ist die leere Zeichenkette. Alle Argumente nach dem Widget *w* gelten als Optionen eines Linien-Elements im Canvas *w*. Besonders wichtig sind **-fill** und **-dash**.

**crosshair::off** *w*
: Dieser Befehl entfernt die Fadenkreuze aus dem Canvas-Widget *w*. Hatte das Widget keine Fadenkreuze, geschieht nichts. Das Ergebnis des Befehls ist die leere Zeichenkette.

**crosshair::configure** *w* ?*arg*...?
: Dieser Befehl ändert das Aussehen der Fadenkreuze im Canvas-Widget *w*. Es ist ein Fehler, ihn für einen Canvas aufzurufen, der keine Fadenkreuze hat. Alle Argumente nach dem Widget *w* gelten als Optionen eines Linien-Elements im Canvas *w*. Besonders wichtig sind **-fill** und **-dash**. Das Ergebnis des Befehls sind die aktuellen Konfigurationseinstellungen.

**crosshair::track** **on** *w* *cmdprefix*
: Dieser Befehl schaltet die Meldung der Position der Fadenkreuze im Canvas-Widget *w* ein. Es ist ein Fehler, diesen Befehl für einen Canvas zu verwenden, der keine Fadenkreuze hat. Das Ergebnis des Befehls ist die leere Zeichenkette. Nach dem Aufruf wird das Befehlspräfix *cmdprefix* bei jeder Mausbewegung im Canvas mit 7 Argumenten aufgerufen. Der Reihe nach:


**\[1\]**
: Das Widget *w*

**\[2\]**
: Die x-Position der Fadenkreuze, in Pixeln.

**\[3\]**
: Die y-Position der Fadenkreuze, in Pixeln.

**\[4\]**
: Die x-Position der linken oberen Ecke des Ansichtsbereichs, in Pixeln.

**\[5\]**
: Die y-Position der linken oberen Ecke des Ansichtsbereichs, in Pixeln.

**\[6\]**
: Die x-Position der rechten unteren Ecke des Ansichtsbereichs, in Pixeln.

**\[7\]**
: Die y-Position der rechten unteren Ecke des Ansichtsbereichs, in Pixeln.


: Eine bereits vorhandene Rückruffunktion für *w* wird deaktiviert. Das heißt, pro Canvas-Widget mit Fadenkreuz ist nur eine Rückruffunktion möglich, die dessen Position meldet.


**crosshair::track** **off** *w*
: Dieser Befehl schaltet die Meldung der Position der Fadenkreuze im Canvas-Widget *w* aus. Es ist ein Fehler, diesen Befehl für einen Canvas zu verwenden, der keine Fadenkreuze hat. Das Ergebnis des Befehls ist die leere Zeichenkette.

**crosshair::bbox_add** *w* *bbox*
: Dieser Befehl fügt den Fadenkreuzen des Canvas *w* einen Begrenzungsrahmen hinzu. Die Fadenkreuze sind nur in diesem Bereich aktiv. Das Ergebnis des Befehls ist ein Token, mit dem sich der Begrenzungsrahmen wieder entfernen lässt, siehe **crosshair::bbox_remove** unten. Der Begrenzungsrahmen *bbox* ist eine Liste von 4 Werten, die linke untere und die rechte obere Ecke des Rahmens. Die Reihenfolge der Werte in der Liste ist:


```
llx lly urx ury
```

Hinweis: Dieser Befehl kann mehrfach verwendet werden, wobei bei jedem Aufruf ein weiterer Begrenzungsrahmen hinzugefügt wird. In diesem Fall entspricht der sichtbare Bereich der *Vereinigung* aller angegebenen Begrenzungsrahmen.

**crosshair::bbox_remove** *token*
: Dieser Befehl entfernt den durch *token* bezeichneten Begrenzungsrahmen (ein Ergebnis von **crosshair::bbox_add**) aus den Fadenkreuzen des zugehörigen Canvas-Widgets.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *tklib :: crosshair* der [Tcllib-SF-Tracker](http://sourceforge.net/tracker/?group_id=12883). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *crosshair* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) 2003 Kevin Kenny
Copyright (c) 2008 (docs) Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2013 Frank Gover, Andreas Kupries
```
