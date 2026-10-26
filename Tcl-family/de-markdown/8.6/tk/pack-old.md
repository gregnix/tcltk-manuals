---
CommandName: pack-old
title: pack-old
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - geometry manager
 - location
 - packer
 - parcel
 - size
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

pack-old - Veraltete Syntax des Packer-Geometrie-Managers

# Übersicht

::: {.synopsis} :::
[pack]{.cmd} [after]{.sub} [sibling]{.arg} [window]{.arg} [options]{.arg} [window options]{.optdot}
[pack]{.cmd} [append]{.sub} [parent]{.arg} [window]{.arg} [options]{.arg} [window options]{.optdot}
[pack]{.cmd} [before]{.sub} [sibling]{.arg} [window]{.arg} [options]{.arg} [window options]{.optdot}
[pack]{.cmd} [unpack]{.sub} [window]{.arg}
:::

# Beschreibung

*Hinweis: Diese Handbuchseite beschreibt die Syntax des Befehls* [pack] *in der Form vor Tk 3.3. Die Syntax wird aus Kompatibilitätsgründen weiter unterstützt, ist aber veraltet und sollte nicht mehr verwendet werden. Irgendwann kann die Unterstützung entfallen.*

Der Packer ist ein Geometrie-Manager, der die Kinder eines Elternfensters anordnet, indem er sie der Reihe nach an den Rändern des Elternfensters packt. Das erste Kind liegt an einer Seite des Fensters und nimmt die gesamte Ausdehnung des Fensters entlang dieser Seite ein. Der für die übrigen Kinder verbleibende Platz schrumpft, als wäre die Seite um die Größe des ersten Kindes nach innen gerückt. Das nächste Kind liegt dann an einer Seite des verbleibenden Hohlraums, und so weiter, bis alle Kinder platziert sind oder im Hohlraum kein Platz mehr ist.

Die Formen **before**, **after** und **append** des Befehls [pack] fügen ein oder mehrere Kinder in die Packreihenfolge ihres Elternfensters ein. **before** fügt die Kinder vor dem Fenster *sibling* ein; alle anderen Fenster müssen Geschwister von *sibling* sein. **after** fügt die Fenster hinter *sibling* ein, **append** hängt ein oder mehrere Fenster an das Ende der Packreihenfolge von *parent*. Ist ein in diesen Befehlen genanntes *window* in seinem Elternfenster schon gepackt, wird es aus der aktuellen Position genommen und wie angegeben neu gesetzt. Alle diese Befehle geben eine leere Zeichenkette zurück.

Die Form **unpack** nimmt *window* aus der Packreihenfolge seines Elternfensters und entmappt es. Danach verwaltet der Packer die Geometrie von *window* nicht mehr.

Die Platzierung jedes Kindes ist ein Vorgang in vier Schritten. Das Argument *options* hinter jedem *window* ist eine Liste aus einem oder mehreren Feldern, die die Platzierung dieses Fensters steuern. *Hohlraum* meint unten den Platz, der im Elternfenster bleibt, wenn ein bestimmtes Kind platziert wird, also den Platz, den frühere Kinder in der Packreihenfolge nicht beansprucht haben. *Parcel* meint den einem bestimmten Kind zugewiesenen Platz; das ist nicht unbedingt die endgültige Geometrie des Kindfensters.

Der erste Schritt legt fest, an welcher Seite des Hohlraums das Kind liegt. Eine der folgenden Optionen nennt die Seite:

**top**
: Legt das Parcel des Kindes an den oberen Rand des Hohlraums und nimmt die volle Breite des Hohlraums ein.

**bottom**
: Legt das Parcel des Kindes an den unteren Rand des Hohlraums und nimmt die volle Breite des Hohlraums ein.

**left**
: Legt das Parcel des Kindes an die linke Seite des Hohlraums und nimmt die volle Höhe des Hohlraums ein.

**right**
: Legt das Parcel des Kindes an die rechte Seite des Hohlraums und nimmt die volle Höhe des Hohlraums ein.


Für ein Fenster soll höchstens eine dieser Optionen angegeben sein. Fehlt die Seite, gilt **top**.

Der zweite Schritt wählt ein Parcel für das Kind. Bei **top** und **bottom** ist die gewünschte Parcel-Breite normalerweise die Breite des Hohlraums und die gewünschte Höhe die angeforderte Höhe des Fensters, wie sie an [Tk\_GeometryRequest][GeomReq] übergeben wird. Bei **left** und **right** ist die gewünschte Parcel-Höhe normalerweise die Höhe des Hohlraums und die gewünschte Breite die angeforderte Breite des Fensters. Zusätzlicher Platz lässt sich mit einer der folgenden Optionen anfordern:

**padx** *num*
: Addiert *num* Pixel zur angeforderten Breite des Fensters, bevor die Parcel-Größe wie oben berechnet wird.

**pady** *num*
: Addiert *num* Pixel zur angeforderten Höhe des Fensters, bevor die Parcel-Größe wie oben berechnet wird.

**expand**
: Das Parcel des Fensters soll übrig gebliebenen Platz im Hohlraum des Elternfensters aufnehmen, nachdem alle Kinder gepackt sind. Wie viel übrig bleibt, hängt von den Größen der anderen Kinder ab und kann null sein. Haben mehrere Fenster **expand** angegeben, wird die zusätzliche Breite gleichmäßig auf alle **left**- und **right**-Fenster mit **expand** verteilt und die zusätzliche Höhe gleichmäßig auf alle **top**- und **bottom**-Fenster mit **expand**.


Ist die gewünschte Breite oder Höhe eines Parcels größer als die entsprechende Abmessung des Hohlraums, gilt die Abmessung des Hohlraums.

Der dritte Schritt legt Breite und Höhe des Fensters fest. Voreingestellt erhält das Fenster seine angeforderte Breite und Höhe oder die des Parcels, je nachdem, was kleiner ist. Ist das Parcel größer als die angeforderte Größe des Fensters, können folgende Optionen das Fenster teilweise oder ganz auf das Parcel ausdehnen:

**fill**
: Setzt die Größe des Fensters auf die Größe des Parcels.

**fillx**
: Vergrößert die Breite des Fensters auf die Breite des Parcels und behält die angeforderte Höhe.

**filly**
: Vergrößert die Höhe des Fensters auf die Höhe des Parcels und behält die angeforderte Breite.


Der letzte Schritt legt den Ort des Fensters in seinem Parcel fest. Ist die Größe des Fensters gleich der des Parcels, füllt das Fenster das Parcel. Ist das Parcel größer, nennt eine der folgenden Optionen die Lage im Parcel:

**frame center**
: Zentriert das Fenster im Parcel. Das ist die Voreinstellung, wenn keine **frame**-Option angegeben ist.

**frame n**
: Setzt das Fenster so, dass seine Oberkante auf der Mitte der Oberkante des Parcels liegt.

**frame ne**
: Setzt die obere rechte Ecke des Fensters auf die obere rechte Ecke des Parcels.

**frame e**
: Setzt das Fenster so, dass seine rechte Kante auf der Mitte der rechten Kante des Parcels liegt.

**frame se**
: Setzt die untere rechte Ecke des Fensters auf die untere rechte Ecke des Parcels.

**frame s**
: Setzt das Fenster so, dass seine Unterkante auf der Mitte der Unterkante des Parcels liegt.

**frame sw**
: Setzt die untere linke Ecke des Fensters auf die untere linke Ecke des Parcels.

**frame w**
: Setzt das Fenster so, dass seine linke Kante auf der Mitte der linken Kante des Parcels liegt.

**frame nw**
: Setzt die obere linke Ecke des Fensters auf die obere linke Ecke des Parcels.


Der Packer verwaltet den gemappten und entmappten Zustand aller gepackten Kindfenster. Er mappt die Fenster beim Packen und entmappt Fenster, für die im Hohlraum kein Platz blieb.

Der Packer stellt Geometrieanforderungen für die Elternfenster, die er verwaltet. Für jedes Elternfenster fordert er eine Größe, die alle von den gepackten Kindern angegebenen Optionen aufnimmt, sodass für **expand** kein Platz übrig bleibt.


[GeomReq]: ../tk-c/GeomReq.md
[pack]: pack.md
