---
CommandName: place
title: place
ManualSection: n
Version: unknown
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - grid(n)
 - pack(n)
Keywords:
 - geometry manager
 - height
 - location
 - container
 - place
 - rubber sheet
 - content
 - width
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

place - Geometriemanager für feste oder Gummiertafel-Platzierung

# Übersicht

::: {.synopsis} :::
[place]{.cmd} [option]{.arg} [arg]{.arg} [arg]{.optdot}
:::

# Beschreibung

Der Placer ist ein Geometriemanager für Tk. Er ermöglicht einfache feste Platzierung von Fenstern, bei der Sie die exakte Größe und Position eines Fensters, des *Inhalts*, innerhalb eines anderen Fensters, des *Containers*, angeben. Der Placer bietet außerdem Gummiertafel-Platzierung, bei der Sie Größe und Position des Inhalts in Bezug auf die Abmessungen des Containers angeben, sodass der Inhalt bei Größenänderungen des Containers seine Größe und Position anpasst. Schließlich erlaubt der Placer, diese Platzierungsstile zu mischen, sodass der Inhalt beispielsweise feste Breite und Höhe hat, aber im Container zentriert ist.

**place** *window option value* ?*option value ...*?
: Veranlasst den Placer, die Geometrie eines Inhalts zu verwalten, dessen Pfadname *window* ist. Die übrigen Argumente bestehen aus einem oder mehreren *option-value*-Paaren, die festlegen, wie die Geometrie von *window* verwaltet wird. *Option* kann jeden von **place configure** akzeptierten Wert haben.

**place configure** *window* ?*option*? ?*value option value ...*?
: Abfragen oder Ändern der Geometrie-Optionen des durch *window* angegebenen Inhalts. Ist keine *option* angegeben, gibt der Befehl eine Liste der verfügbaren Optionen zurück (Format siehe [Tk\_ConfigureInfo][ConfigWidg]). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zur benannten Option zurück (identisch mit dem entsprechenden Teillistenwert bei Abfrage aller Optionen). Sind ein oder mehrere *option-value*-Paare angegeben, werden die Optionen auf die angegebenen Werte gesetzt; der Befehl gibt dann einen leeren String zurück.

    Folgende *option-value*-Paare werden unterstützt:

    **-anchor** *where*
    : *Where* legt fest, welcher Punkt von *window* an der durch **-x**, **-y**, **-relx** und **-rely** gewählten (x,y)-Position platziert wird. Der Ankerpunkt bezieht sich auf den äußeren Bereich von *window* einschließlich Rahmen, falls vorhanden. Ist *where* **se**, erscheint die untere rechte Ecke des Rahmens von *window* an der angegebenen (x,y)-Position im Container. Standard-Ankerposition ist **nw**.

    **-bordermode** *mode*
    : *Mode* bestimmt, inwieweit Rahmen innerhalb des Containers bei der Platzierung des Inhalts berücksichtigt werden. Standard und häufigster Wert ist **inside**. Der Placer betrachtet dann den Container-Bereich als innersten Bereich innerhalb jedes Rahmens: **-x 0** entspricht einer x-Koordinate knapp innerhalb des Rahmens und **-relwidth 1.0** bedeutet, dass *window* den Bereich innerhalb des Container-Rahmens füllt.

        Ist *mode* **outside**, gilt der Container-Bereich inklusive Rahmen; typisch beim Platzieren von *window* außerhalb des Containers, z. B. mit **-x 0 -y 0 -anchor ne**. Ist *mode* **ignore**, werden Rahmen ignoriert: Der Container-Bereich ist die offizielle X-Fläche mit internem, aber ohne externem Rahmen. **ignore** ist vermutlich wenig nützlich.

    **-height** *size*
    : *Size* legt die Höhe von *window* in Bildschirmeinheiten fest (Formen wie von [Tk\_GetPixels][GetPixels] akzeptiert). Die Höhe ist die äußere Abmessung von *window* einschließlich Rahmen. Ist *size* leer oder sind weder **-height** noch **-relheight** gesetzt, wird die intern angeforderte Fensterhöhe verwendet.

    **-in** *container*
    : *Container* gibt den Pfadnamen des Fensters an, relativ zu dem *window* platziert wird. *Container* muss Eltern von *window* oder ein Nachfahre des Eltern-Widgets sein. Außerdem müssen *container* und *window* Nachfahren desselben Toplevel-Fensters sein. Dies garantiert, dass *window* sichtbar ist, sobald *container* sichtbar ist. Ohne diese Option ist das Bezugsfenster standardmäßig das Eltern-Widget von *window*.

    **-relheight** *size*
    : *Size* legt die Höhe von *window* als Gleitkommazahl relativ zur Container-Höhe fest: 0.5 bedeutet halbe Container-Höhe, 1.0 gleiche Höhe usw. Sind **-height** und **-relheight** gesetzt, werden die Werte addiert. Beispiel: **-relheight 1.0 -height -2** macht den Inhalt 2 Pixel kürzer als den Container.

    **-relwidth** *size*
    : *Size* legt die Breite von *window* relativ zur Container-Breite fest. 0.5 bedeutet halbe Breite, 1.0 gleiche Breite usw. Sind **-width** und **-relwidth** gesetzt, werden die Werte addiert. Beispiel: **-relwidth 1.0 -width 5** macht den Inhalt 5 Pixel breiter als den Container.

    **-relx** *location*
    : *Location* legt die x-Koordinate des Ankerpunkts von *window* im Container relativ fest: 0.0 linke Kante, 1.0 rechte Kante. *Location* muss nicht zwischen 0.0 und 1.0 liegen. Sind **-x** und **-relx** gesetzt, werden die Werte addiert. Beispiel: **-relx 0.5 -x -2** positioniert die linke Kante des Inhalts 2 Pixel links von der Container-Mitte.

    **-rely** *location*
    : *Location* legt die y-Koordinate des Ankerpunkts relativ fest: 0.0 obere Kante, 1.0 untere Kante. *Location* muss nicht zwischen 0.0 und 1.0 liegen. Sind **-y** und **-rely** gesetzt, werden die Werte addiert. Beispiel: **-rely 0.5 -x 3** positioniert die obere Kante des Inhalts 3 Pixel unter der Container-Mitte.

    **-width** *size*
    : *Size* legt die Breite von *window* in Bildschirmeinheiten fest (Formen wie von [Tk\_GetPixels][GetPixels] akzeptiert). Die Breite ist die äußere Breite einschließlich Rahmen. Ist *size* leer oder sind weder **-width** noch **-relwidth** gesetzt, wird die intern angeforderte Breite verwendet.

    **-x** *location*
    : *Location* legt die x-Koordinate des Ankerpunkts im Container in Bildschirmeinheiten fest (Formen wie von [Tk\_GetPixels][GetPixels] akzeptiert); sie muss nicht innerhalb des Containers liegen.

    **-y** *location*
    : *Location* legt die y-Koordinate des Ankerpunkts im Container in Bildschirmeinheiten fest (Formen wie von [Tk\_GetPixels][GetPixels] akzeptiert); sie muss nicht innerhalb des Containers liegen.


    Wird derselbe Wert mit zwei verschiedenen Optionen angegeben, etwa **-x** und **-relx**, gilt die zuletzt gesetzte Option; die ältere wird ignoriert.

**place forget** *window*
: Der Placer verwaltet die Geometrie von *window* nicht mehr. Als Nebeneffekt wird *window* unmapped, sodass es nicht auf dem Bildschirm erscheint. Wird *window* nicht vom Placer verwaltet, hat der Befehl keine Wirkung. Rückgabe ist ein leerer String.

**place info** *window*
: Gibt eine Liste mit der aktuellen Konfiguration von *window* zurück. Die Liste besteht aus *option-value*-Paaren im gleichen Format wie für **place configure**.

**place slaves** *window*
: Gibt eine Liste aller Inhaltsfenster zurück, für die *window* der Container ist. Gibt es keinen Inhalt für *window*, wird ein leerer String zurückgegeben.

[**place content** *window*]{version="TIP 581"}
: [Synonym für **place slaves** *window*.]{version="TIP 581"}


Wurde die Konfiguration eines Fensters mit **place info** abgerufen, kann sie später wiederhergestellt werden, indem zuerst **place forget** alle vorhandenen Informationen löscht und anschließend **place configure** mit den gespeicherten Werten aufgerufen wird.

# Feinheiten

Der Container muss nicht das Eltern-Widget des Inhalts sein. Das ist in mindestens zwei Situationen nützlich. Erstens können Sie bei komplexen Layouts eine Hierarchie von Unterfenstern anlegen, deren einziger Zweck das Layout des Eltern-Widgets ist. Die „echten Kinder“ des Eltern-Widgets (die für die Benutzeroberfläche relevanten Fenster) können Kinder des Eltern-Widgets sein und dennoch innerhalb der Fenster der Geometrie-Hierarchie platziert werden. Die Pfadnamen der echten Kinder spiegeln die Geometrie-Hierarchie nicht wider, und Benutzer können Optionen für die echten Kinder setzen, ohne die Geometrie-Struktur zu kennen.

Ein zweiter Grund für einen von den Eltern verschiedenen Container ist die Verknüpfung zweier Geschwister. Der Placer kann ein Fenster z. B. immer zentriert direkt unter einem Geschwister halten mit

```
-in sibling -relx 0.5 -rely 1.0 -anchor n -bordermode outside
```

Wird das Geschwister später verschoben, wird der Inhalt ebenfalls neu positioniert.

Anders als viele andere Geometriemanager (z. B. der Packer) manipuliert der Placer nicht die Geometrie der Container-Fenster oder der Eltern von Inhaltsfenstern (er setzt deren angeforderte Größen nicht). Um die Größen zu steuern, verwenden Sie Fenster wie **frame** und **canvas**, die Konfigurationsoptionen dafür bieten.

# Beispiel

Das Label soll den mittleren Bereich des Toplevel einnehmen, unabhängig von der Größenänderung:

```
label .l -text "In the\nMiddle!" -bg black -fg white
place .l -relwidth .3 -relx .35 -relheight .3 -rely .35
```


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetPixels]: ../tk-c/GetPixels.md
