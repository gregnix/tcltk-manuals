---
CommandName: notifywindow
title: notifywindow
ManualSection: n
Version: 1.0.2
TclPart: tklib
TclDescription: notifywindow
Keywords:
 - alert
 - notification
 - tk
Copyright:
 - Copyright (c) 2015 Kevin Walzer/WordTech Communications LLC <kw@codebykevin.com>
---

# Name

notifywindow – Stellt ein unauffälliges Fenster für Warnmeldungen und Benachrichtigungen aus Tk-Anwendungen bereit

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tk]{.lit}
[package]{.cmd} [require]{.sub} [notifywindow]{.lit} [1.0.2]{.optlit}
[::notifywindow::notifywindow]{.cmd} [msg]{.arg} [img]{.arg}
[::notifywindow::demo]{.cmd}
:::

# Beschreibung

Dieses Paket stellt ein unauffälliges, diskretes Fenster für Warnmeldungen und Benachrichtigungen aus Tk-Anwendungen bereit, das kurz in der oberen rechten Ecke des Bildschirms erscheint. In Anlehnung an den „Growl“-Rahmen unter Mac OS X wird das Fenster auf Plattformen, die solche Effekte unterstützen, ein- und ausgeblendet, während es auf anderen Plattformen einfach erscheint und wieder verschwindet.

**::notifywindow::notifywindow** *msg* *img*
: Zeigt das Toplevel-Fenster mit der Zeichenfolge *msg* an, die nicht länger als 40 Zeichen sein sollte, und einem optionalen Bild, das 16x16 Pixel groß sein sollte.

**::notifywindow::demo**
: Einfaches Beispiel, das veranschaulicht, wie das Paket funktioniert.


# Danksagungen

Obwohl **notifywindow** vom Growl-Paket für Mac OS X inspiriert wurde, weist es keinerlei gemeinsame Code-Teile mit diesem Projekt auf.

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *notifywindow* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 2015 Kevin Walzer/WordTech Communications LLC <kw@codebykevin.com>
```
