---
CommandName: autoscroll
title: autoscroll
ManualSection: n
Version: 1.1
TclPart: tklib
TclDescription: Automatic mapping of scrollbars
Keywords:
 - scroll
 - scrollbar
Copyright:
---

# Name

autoscroll – Sorgt dafür, dass eine Scrollbar je nach Bedarf automatisch ein- und ausgeblendet wird

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit}
[package]{.cmd} [require]{.sub} [autoscroll]{.lit} [1.1]{.optlit}
[::autoscroll::autoscroll]{.cmd} [scrollbar]{.arg}
[::autoscroll::unautoscroll]{.cmd} [scrollbar]{.arg}
[::autoscroll::wrap]{.cmd}
[::autoscroll::unwrap]{.cmd}
:::

# Beschreibung

Mit diesem Paket können Scrollbars je nach Größe und Inhalt des Widgets, das die Scrollbar verschiebt, nach Bedarf zugeordnet und wieder entfernt werden. Die Scrollbar muss entweder von pack oder grid verwaltet werden; andere Geometriemanager werden nicht unterstützt.

Bei der Verwaltung durch pack gehen alle Geometrieänderungen verloren, die im Elternwidget der Scrollbar zwischen dem Entfernen und dem erneuten Zuordnen vorgenommen werden. Es ist ein Fehler, eines der Geschwisterwidgets der Scrollbar zu löschen, während sie nicht zugeordnet ist. Bei der Verwaltung durch grid ersetzt die Scrollbar beim erneuten Zuordnen das, was inzwischen mit grid in derselben Zeile und Spalte platziert wurde.

Dieses Paket kann für jedes Widget verwendet werden, das einer Scrollbar ähnelt, sofern es den Unterbefehl **set** in derselben Weise wie eine Scrollbar unterstützt. Wenn der Unterbefehl **set** nicht verwendet wird, hat dieses Paket keine Wirkung.

**::autoscroll::autoscroll** *scrollbar*
: Sorgt dafür, dass die bereits vorhandene Scrollbar **scrollbar** je nach Bedarf ein- und ausgeblendet wird.

**::autoscroll::unautoscroll** *scrollbar*
: Gibt die angegebene Scrollbar in ihren ursprünglichen statischen Zustand zurück.

**::autoscroll::wrap**
: Stellt sicher, dass alle nach Ausführung dieses Befehls erstellten Scrollbars bei Bedarf automatisch zugeordnet und wieder entfernt werden.

**::autoscroll::unwrap**
: Deaktiviert das automatische Scrollen aller neuen Scrollbars. Hat keine Auswirkungen auf bereits vorhandene Scrollbars.


```
text .t -yscrollcommand ".scrolly set"
scrollbar .scrolly -orient v -command ".t yview"
pack .scrolly -side right -fill y
pack .t -side left -fill both -expand 1
::autoscroll::autoscroll .scrolly
```

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *autoscroll* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
