---
CommandName: panedwindow
title: panedwindow
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::panedwindow(n)
Keywords:
 - panedwindow
 - widget
 - geometry management
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

panedwindow - Erstellt und manipuliert 'Panedwindow'-Widgets als geteilte Container

# Übersicht

::: {.synopsis} :::
[panedwindow]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-background**, **-borderwidth**, **-cursor**, **-orient**, **-relief**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-handlepad** (**handlePad**/**HandlePad**)
: Wenn Sash-Griffe gezeichnet werden, legt dies den Abstand vom oberen oder linken Ende des Sash (je nach Ausrichtung des Widgets) fest, an dem der Griff gezeichnet wird. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierten Wert sein.

**-handlesize** (**handleSize**/**HandleSize**)
: Legt die Seitenlänge eines Sash-Griffs fest. Griffe werden stets als Quadrate gezeichnet. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierten Wert sein.

**-height** (**height**/**Height**)
: Legt eine gewünschte Höhe für das gesamte Panedwindow-Widget fest. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierten Wert sein. Wenn ein leerer String, wird das Widget hoch genug gemacht, damit alle enthaltenen Widgets ihre natürliche Höhe haben können.

**-opaqueresize** (**opaqueResize**/**OpaqueResize**)
: Legt fest, ob Bereiche während des Verschiebens eines Sash in Echtzeit skaliert werden sollen (true), oder ob die Größenänderung bis zum Platzieren des Sash zurückgestellt werden soll (false). Im letzteren Fall wird während der Größenänderung eine „Geister“-Version des Sash angezeigt, um zu zeigen, wohin die Bereiche skaliert werden, wenn die Maustaste losgelassen wird. Diese „Geister“-Version des Sash ist der Proxy. Seine Darstellung kann mit den Optionen **-proxybackground**, **-proxyborderwidth** und **-proxyrelief** konfiguriert werden.

**-proxybackground** (**proxyBackground**/**ProxyBackground**)
: Hintergrundfarbe zum Zeichnen des Proxys. Wenn ein leerer String, wird der Wert der Option **-background** verwendet.

**-proxyborderwidth** (**proxyBorderWidth**/**ProxyBorderWidth**)
: Legt die Rahmenbreite des Proxys fest. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierten Wert sein.

**-proxyrelief** (**proxyRelief**/**ProxyRelief**)
: Relief zum Zeichnen des Proxys. Kann einer der Standard-Tk-Relief-Werte sein. Wenn ein leerer String, wird der Wert der Option **-sashrelief** verwendet.

**-sashcursor** (**sashCursor**/**SashCursor**)
: Mauszeiger, der über einem Sash verwendet wird. Wenn null, wird **sb\_h\_double\_arrow** für horizontale Panedwindows und **sb\_v\_double\_arrow** für vertikale Panedwindows verwendet.

**-sashpad** (**sashPad**/**SashPad**)
: Legt den Innenabstand fest, der auf jeder Seite eines Sash verbleiben soll. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierten Wert sein.

**-sashrelief** (**sashRelief**/**SashRelief**)
: Relief zum Zeichnen eines Sash. Kann einer der Standard-Tk-Relief-Werte sein.

**-sashwidth** (**sashWidth**/**SashWidth**)
: Legt die Breite jedes Sash fest. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierten Wert sein.

**-showhandle** (**showHandle**/**ShowHandle**)
: Legt fest, ob Sash-Griffe angezeigt werden sollen. Kann jeder gültige Tcl-Boolesche Wert sein.

**-width** (**width**/**Width**)
: Legt eine gewünschte Breite für das gesamte Panedwindow-Widget fest. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierten Wert sein. Wenn ein leerer String, wird das Widget breit genug gemacht, damit alle enthaltenen Widgets ihre natürliche Breite haben können.


# Beschreibung

Der Befehl **panedwindow** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Panedwindow-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Panedwindows wie Standard-Hintergrundfarbe und Relief zu konfigurieren. Der Befehl **panedwindow** gibt den Pfadnamen des neuen Fensters zurück.

Ein Panedwindow-Widget enthält beliebig viele Bereiche (*panes*), horizontal oder vertikal angeordnet, je nach Wert der Option **-orient**. Jeder Bereich enthält ein Widget, und jedes Paar von Bereichen wird durch einen verschiebbaren (per Mausbewegung) Sash getrennt. Das Verschieben eines Sash bewirkt, dass die Widgets auf beiden Seiten des Sash skaliert werden.

# Widget-Befehl

Der Befehl **panedwindow** erstellt einen neuen Tcl-Befehl, dessen Name derselbe ist wie der Pfadname des Fensters des Panedwindows. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

*PathName* ist der Name des Befehls, der mit dem Pfadnamen des Panedwindow-Widgets identisch ist. *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Panedwindow-Widgets möglich:

*pathName* **add** *window* ?*window ...*? ?*option value ...*?
: Fügt ein oder mehrere Fenster zum Panedwindow hinzu, jeweils in einem separaten Bereich. Die Argumente bestehen aus den Namen eines oder mehrerer Fenster gefolgt von Argumentpaaren, die angeben, wie die Fenster verwaltet werden sollen. *Option* kann jeden der vom Unterbefehl **configure** akzeptierten Werte haben.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **panedwindow** akzeptierten Werte haben.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **panedwindow** akzeptierten Werte haben.

*pathName* **forget** *window* ?*window ...*?
: Entfernt den Bereich, der *window* enthält, aus dem Panedwindow. Alle Geometrieverwaltungsoptionen für *window* werden vergessen.

*pathName* **identify** *x y*
: Identifiziert die Panedwindow-Komponente unter dem durch *x* und *y* gegebenen Punkt in Fensterkoordinaten. Wenn der Punkt über einem Sash oder einem Sash-Griff liegt, ist das Ergebnis eine zweielementige Liste mit dem Index des Sash oder Griffs und einem Wort, das angibt, ob es sich um einen Sash oder einen Griff handelt, z. B. {0 sash} oder {2 handle}. Wenn der Punkt über einem anderen Teil des Panedwindows liegt, ist das Ergebnis eine leere Liste.

*pathName* **panecget** *window option*
: Abfrage einer Verwaltungsoption für *window*. *Option* kann jeder vom Unterbefehl **paneconfigure** erlaubte Wert sein.

*pathName* **paneconfigure** *window* ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Verwaltungsoptionen für *window*. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. Folgende Optionen werden unterstützt:

    **-after** *window*
    : Fügt das Fenster nach dem angegebenen Fenster ein. *window* sollte der Name eines Fensters sein, das bereits von *pathName* verwaltet wird.

    **-before** *window*
    : Fügt das Fenster vor dem angegebenen Fenster ein. *window* sollte der Name eines Fensters sein, das bereits von *pathName* verwaltet wird.

    **-height** *size*
    : Legt eine Höhe für das Fenster fest. Die Höhe ist die äußere Abmessung des Fensters einschließlich seines Rahmens, falls vorhanden. Wenn *size* ein leerer String ist oder **-height** nicht angegeben ist, wird zunächst die intern vom Fenster angeforderte Höhe verwendet; die Höhe kann später durch Verschieben von Sash im Panedwindow angepasst werden. *Size* kann jeder von [Tk\_GetPixels][GetPixels] akzeptierte Wert sein.

    **-hide** *boolean*
    : Steuert die Sichtbarkeit eines Bereichs. Wenn der *boolean* true ist (gemäß [Tcl\_GetBoolean][GetInt]), ist der Bereich nicht sichtbar, wird aber weiterhin in der Liste der Bereiche geführt.

    **-minsize** *n*
    : Legt fest, dass die Größe des Fensters nicht kleiner als *n* gemacht werden kann. Diese Einschränkung betrifft nur die Größe des Widgets in der Paned-Dimension — der x-Dimension bei horizontalen Panedwindows, der y-Dimension bei vertikalen Panedwindows. Kann jeder von [Tk\_GetPixels][GetPixels] akzeptierte Wert sein.

    **-padx** *n*
    : Legt einen nicht-negativen Wert fest, der angibt, wie viel zusätzlicher Platz auf jeder Seite des Fensters in X-Richtung verbleiben soll. Der Wert kann in einer der von [Tk\_GetPixels][GetPixels] akzeptierten Formen angegeben werden.

    **-pady** *n*
    : Legt einen nicht-negativen Wert fest, der angibt, wie viel zusätzlicher Platz auf jeder Seite des Fensters in Y-Richtung verbleiben soll. Der Wert kann in einer der von [Tk\_GetPixels][GetPixels] akzeptierten Formen angegeben werden.

    **-sticky** *style*
    : Wenn der Bereich eines Fensters größer ist als die angeforderten Abmessungen des Fensters, kann diese Option verwendet werden, um das Fenster innerhalb seines Bereichs zu positionieren (oder zu strecken). *Style* ist ein String, der null oder mehr der Zeichen **n**, **s**, **e** oder **w** enthält. Der String kann optional Leerzeichen oder Kommas enthalten, diese werden jedoch ignoriert. Jeder Buchstabe bezieht sich auf eine Seite (Norden, Süden, Osten oder Westen), an der das Fenster „klebt“. Wenn sowohl **n** als auch **s** (oder **e** und **w**) angegeben sind, wird das Fenster gestreckt, um die gesamte Höhe (oder Breite) seines Hohlraums auszufüllen.

    **-stretch** *when*
    : Steuert, wie zusätzlicher Platz den einzelnen Bereichen zugewiesen wird. *When* ist einer von **always**, **first**, **last**, **middle** und **never**. Das Panedwindow berechnet die erforderliche Größe aller Bereiche. Verbleibender (oder fehlender) Platz wird den zum Strecken markierten Bereichen zugewiesen. Der Platz wird basierend auf dem aktuellen Verhältnis jedes Bereichs am Ganzen verteilt. Die *when*-Werte haben folgende Bedeutung:

        **always**
        : Dieser Bereich wird stets gestreckt.

        **first**
        : Nur wenn dieser Bereich der erste Bereich (ganz links oder ganz oben) ist, wird er gestreckt.

        **last**
        : Nur wenn dieser Bereich der letzte Bereich (ganz rechts oder ganz unten) ist, wird er gestreckt. Dies ist der Standardwert.

        **middle**
        : Nur wenn dieser Bereich weder der erste noch der letzte Bereich ist, wird er gestreckt.

        **never**
        : Dieser Bereich wird niemals gestreckt.


    **-width** *size*
    : Legt eine Breite für das Fenster fest. Die Breite ist die äußere Abmessung des Fensters einschließlich seines Rahmens, falls vorhanden. Wenn *size* ein leerer String ist oder **-width** nicht angegeben ist, wird zunächst die intern vom Fenster angeforderte Breite verwendet; die Breite kann später durch Verschieben von Sash im Panedwindow angepasst werden. *Size* kann jeder von [Tk\_GetPixels][GetPixels] akzeptierte Wert sein.


*pathName* **panes**
: Gibt eine geordnete Liste der von *pathName* verwalteten Widgets zurück.

*pathName* **proxy** ?*args*?
: Dieser Befehl wird verwendet, um die Position des Sash-Proxys abzufragen und zu ändern, der für Rubberband-artige Größenänderung von Bereichen verwendet wird. Er kann eine der folgenden Formen annehmen:

    *pathName* **proxy coord**
    : Gibt eine Liste mit den x- und y-Koordinaten der zuletzt gespeicherten Proxy-Position zurück.

    *pathName* **proxy forget**
    : Entfernt den Proxy von der Anzeige.

    *pathName* **proxy place** *x y*
    : Platziert den Proxy an den gegebenen *x*- und *y*-Koordinaten.


*pathName* **sash** ?*args*?
: Dieser Befehl wird verwendet, um die Position von Sash im Panedwindow abzufragen und zu ändern. Er kann eine der folgenden Formen annehmen:

    *pathName* **sash coord** *index*
    : Gibt das aktuelle x-y-Koordinatenpaar für den durch *index* gegebenen Sash zurück. *Index* muss eine Ganzzahl zwischen 0 und 1 weniger als die Anzahl der Bereiche im Panedwindow sein. Die angegebenen Koordinaten sind die der oberen linken Ecke der Region, die den Sash enthält.

    *pathName* **sash dragto** *index x y*
    : Dieser Befehl berechnet die Differenz zwischen den gegebenen Koordinaten und den Koordinaten, die dem letzten Befehl **sash mark** für den gegebenen Sash übergeben wurden. Er verschiebt diesen Sash dann um die berechnete Differenz. Der Rückgabewert ist der leere String.

    *pathName* **sash mark** *index x y*
    : Speichert *x* und *y* für den durch *index* gegebenen Sash; wird zusammen mit späteren Befehlen **sash dragto** zum Verschieben des Sash verwendet.

    *pathName* **sash place** *index x y*
    : Platziert den durch *index* gegebenen Sash an den gegebenen Koordinaten.



# Bereiche Größe ändern

Ein Bereich wird skaliert, indem der Sash (oder der Sash-Griff, falls vorhanden) gegriffen und mit der Maus gezogen wird. Dies geschieht über Mausbewegungs-Bindings am Widget. Wenn ein Sash verschoben wird, werden die Größen der Bereiche auf beiden Seiten des Sash und damit die Widgets in diesen Bereichen angepasst.

Wenn ein Bereich von außen skaliert wird (z. B. wenn er mit pack zum Expandieren und Ausfüllen gepackt ist und das enthaltende Toplevel-Fenster skaliert wird), wird Platz dem letzten (ganz rechts oder ganz unten liegenden) Bereich im Fenster hinzugefügt.

Anders als untergeordnete Fenster, die z. B. von pack oder grid verwaltet werden, ändern die von einem Panedwindow verwalteten Bereiche ihre Breite oder Höhe nicht, um Änderungen der angeforderten Breiten oder Höhen der Bereiche aufzunehmen, sobald diese eingeblendet (*mapped*) wurden. Daher kann es ratsam sein, insbesondere bei interaktiver Layout-Erstellung, einen Bereich erst dann zum Panedwindow-Widget hinzuzufügen, nachdem die Geometrieanforderungen dieses Bereichs abgeschlossen sind (d.h. alle Komponenten des Bereichs eingefügt, alle die Geometrie beeinflussenden Optionen auf ihre richtigen Werte gesetzt usw.).


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetInt]: ../tcl-c/GetInt.md
[GetPixels]: ../tk-c/GetPixels.md
[options]: options.md
