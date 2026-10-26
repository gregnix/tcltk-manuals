---
CommandName: scrollbar
ManualSection: n
Version: 4.1
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::scrollbar(n)
Keywords:
 - scrollbar
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

scrollbar - Erstellt und manipuliert 'Scrollbar'-Scroll-Steuerungs- und Anzeige-Widgets

# ÜBERSICHT

::: {.synopsis} :::
[scrollbar]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# WIDGET-SPEZIFISCHE OPTIONEN

**-activerelief** (activeRelief/ActiveRelief)
: Legt das Relief fest, das beim Anzeigen des aktiven Elements verwendet wird, falls vorhanden. Elemente außer dem aktiven Element werden immer mit einem erhabenen Relief angezeigt.

**-command** (command/Command)
: Legt das Präfix eines Tcl-Befehls fest, der aufgerufen wird, um die Ansicht im mit der Scrollbar verknüpften Widget zu ändern. Wenn ein Benutzer eine Ansichtsänderung durch Manipulation der Scrollbar anfordert, wird ein Tcl-Befehl aufgerufen. Der tatsächliche Befehl besteht aus dieser Option gefolgt von zusätzlichen Informationen, wie später beschrieben. Diese Option hat fast immer einen Wert wie **.t xview** oder **.t yview**, bestehend aus dem Namen eines Widgets und entweder **xview** (wenn die Scrollbar für horizontales Scrollen ist) oder **yview** (für vertikales Scrollen). Alle scrollbaren Widgets haben **xview**- und **yview**-Befehle, die genau die zusätzlichen Argumente annehmen, die von der Scrollbar angehängt werden, wie im Abschnitt **SCROLL-BEFEHLE** unten beschrieben.

**-elementborderwidth** (elementBorderWidth/BorderWidth)
: Legt die Breite der Ränder fest, die um die internen Elemente der Scrollbar gezeichnet werden (die beiden Pfeile und der Schieberegler). Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben. Wenn dieser Wert kleiner als null ist, wird stattdessen der Wert der Option **-borderwidth** verwendet.

**-width** (width/Width)
: Legt die gewünschte schmale Dimension des Scrollbar-Fensters fest, ohne 3-D-Rand, falls vorhanden. Bei vertikalen Scrollbars ist dies die Breite und bei horizontalen Scrollbars die Höhe. Der Wert kann eine der von **Tk_GetPixels** akzeptierten Formen haben.


# BESCHREIBUNG

Der Befehl **scrollbar** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Scrollbar-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte der Scrollbar wie Farben, Ausrichtung und Relief zu konfigurieren. Der Befehl **scrollbar** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Eine Scrollbar ist ein Widget, das zwei Pfeile anzeigt, einen an jedem Ende der Scrollbar, und einen *Schieberegler* im mittleren Teil der Scrollbar. Sie liefert Informationen darüber, was in einem *verknüpften Fenster* sichtbar ist, das ein Dokument irgendeiner Art anzeigt (wie eine bearbeitete Datei oder eine Zeichnung). Position und Größe des Schiebereglers geben an, welcher Teil des Dokuments im verknüpften Fenster sichtbar ist. Wenn beispielsweise der Schieberegler in einer vertikalen Scrollbar das obere Drittel des Bereichs zwischen den beiden Pfeilen abdeckt, bedeutet dies, dass das verknüpfte Fenster das obere Drittel seines Dokuments anzeigt.

Scrollbars können verwendet werden, um die Ansicht im verknüpften Fenster durch Klicken oder Ziehen mit der Maus anzupassen. Siehe den Abschnitt **BINDINGS** unten für Details.

# ELEMENTE

Eine Scrollbar zeigt fünf Elemente an, auf die in den Widget-Befehlen für die Scrollbar verwiesen wird:

**arrow1**
: Der obere oder linke Pfeil in der Scrollbar.

**trough1**
: Der Bereich zwischen dem Schieberegler und **arrow1**.

**slider**
: Das Rechteck, das angibt, was im verknüpften Widget sichtbar ist.

**trough2**
: Der Bereich zwischen dem Schieberegler und **arrow2**.

**arrow2**
: Der untere oder rechte Pfeil in der Scrollbar.


# WIDGET-BEFEHL

Der Befehl **scrollbar** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Scrollbar-Widgets möglich:

*pathName* **activate** ?*element*?
: Markiert das durch *element* angegebene Element als aktiv, wodurch es wie durch die Optionen **-activebackground** und **-activerelief** festgelegt angezeigt wird. Die einzigen Elementwerte, die dieser Befehl versteht, sind **arrow1**, **slider** oder **arrow2**. Wenn ein anderer Wert angegeben ist, ist kein Element der Scrollbar aktiv. Wenn *element* nicht angegeben ist, gibt der Befehl den Namen des derzeit aktiven Elements zurück oder eine leere Zeichenkette, wenn kein Element aktiv ist.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **scrollbar** akzeptierten Werte haben.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe **Tk_ConfigureInfo** für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **scrollbar** akzeptierten Werte haben.

*pathName* **delta** *deltaX deltaY*
: Gibt eine reelle Zahl zurück, die die Bruchteilsänderung in der Scrollbar-Einstellung angibt, die einer gegebenen Änderung der Schiebereglerposition entspricht. Wenn die Scrollbar beispielsweise horizontal ist, gibt das Ergebnis an, um wie viel sich die Scrollbar-Einstellung ändern muss, um den Schieberegler *deltaX* Pixel nach rechts zu bewegen (*deltaY* wird in diesem Fall ignoriert). Wenn die Scrollbar vertikal ist, gibt das Ergebnis an, um wie viel sich die Scrollbar-Einstellung ändern muss, um den Schieberegler *deltaY* Pixel nach unten zu bewegen. Die Argumente und das Ergebnis können null oder negativ sein.

*pathName* **fraction** *x y*
: Gibt eine reelle Zahl zwischen 0 und 1 zurück, die angibt, wo der durch *x* und *y* gegebene Punkt im Trog-Bereich der Scrollbar liegt. Der Wert 0 entspricht dem oberen oder linken Rand des Trogs, der Wert 1 dem unteren oder rechten Rand, 0,5 der Mitte und so weiter. *X* und *y* müssen Pixelkoordinaten relativ zum Scrollbar-Widget sein. Wenn *x* und *y* auf einen Punkt außerhalb des Trogs verweisen, wird der dem Trog am nächsten liegende Punkt verwendet.

*pathName* **get**
: Gibt die Scrollbar-Einstellungen in Form einer Liste zurück, deren Elemente die Argumente des zuletzt ausgeführten Widget-Befehls **set** sind.

*pathName* **identify** *x y*
: Gibt den Namen des Elements unter dem durch *x* und *y* gegebenen Punkt zurück (wie **arrow1**) oder eine leere Zeichenkette, wenn der Punkt in keinem Element der Scrollbar liegt. *X* und *y* müssen Pixelkoordinaten relativ zum Scrollbar-Widget sein.

*pathName* **set** *first last*
: Dieser Befehl wird vom verknüpften Widget der Scrollbar aufgerufen, um der Scrollbar die aktuelle Ansicht im Widget mitzuteilen. Der Befehl nimmt zwei Argumente entgegen, von denen jedes ein reeller Bruch zwischen 0 und 1 ist. Die Brüche beschreiben den Bereich des Dokuments, der im verknüpften Widget sichtbar ist. Wenn beispielsweise *first* 0,2 und *last* 0,4 ist, bedeutet dies, dass der erste sichtbare Teil des Dokuments im Fenster 20 % des Weges durch das Dokument ist und der letzte sichtbare Teil 40 % des Weges durch das Dokument.


# SCROLL-BEFEHLE

Wenn der Benutzer mit der Scrollbar interagiert, beispielsweise durch Ziehen des Schiebereglers, benachrichtigt die Scrollbar das verknüpfte Widget, dass es seine Ansicht ändern muss, indem sie einen aus der Option **-command** erzeugten Tcl-Befehl auswertet. Der Befehl kann eine der folgenden Formen annehmen. In jedem Fall ist *prefix* der Inhalt der Option **-command**, der üblicherweise eine Form wie „**.t yview**“ hat.

*prefix* **moveto** *fraction*
: *Fraction* ist eine reelle Zahl zwischen 0 und 1. Das Widget soll seine Ansicht so anpassen, dass der durch *fraction* angegebene Punkt am Anfang des Widgets erscheint. Ist *fraction* 0, bezeichnet dies den Anfang des Dokuments. 1.0 bezeichnet das Ende, 0.333 einen Punkt ein Drittel durch das Dokument usw.

*prefix* **scroll** *number* **units**
: Das Widget soll seine Ansicht um *number* Einheiten anpassen. Die Einheiten sind widget-spezifisch definiert, etwa Zeichen oder Zeilen in einem Text-Widget. *Number* ist entweder 1 (eine Einheit scrollt oben oder links aus dem Fenster) oder -1 (eine Einheit scrollt unten oder rechts aus dem Fenster).

*prefix* **scroll** *number* **pages**
: Das Widget soll seine Ansicht um *number* Seiten anpassen. Die Bedeutung einer Seite legt das Widget fest; typischerweise ist sie etwas kleiner als der sichtbare Fensterinhalt, sodass alte und neue Ansicht leicht überlappen. *Number* ist entweder 1 (nächste Seite sichtbar) oder -1 (vorherige Seite sichtbar).


# ALTE BEFEHLS-SYNTAX

In Tk-Versionen vor 4.0 verwendeten die Widget-Befehle **set** und **get** eine andere Form. Diese Form wird aus Gründen der Abwärtskompatibilität weiterhin unterstützt, ist aber veraltet. In der alten Befehls-Syntax hat der Widget-Befehl **set** folgende Form:

*pathName* **set** *totalUnits windowUnits firstUnit lastUnit*
: In dieser Form sind alle Argumente Ganzzahlen. *TotalUnits* gibt die Gesamtgröße des Objekts an, das im verknüpften Widget angezeigt wird. Die Bedeutung einer Einheit hängt vom verknüpften Widget ab; in einem Texteditor-Widget können Einheiten beispielsweise Textzeilen entsprechen. *WindowUnits* gibt die Gesamtzahl der Einheiten an, die gleichzeitig ins verknüpfte Fenster passen. *FirstUnit* und *lastUnit* geben die Indizes der ersten und letzten Einheiten an, die derzeit im verknüpften Fenster sichtbar sind (null entspricht der ersten Einheit des Objekts). Unter der alten Syntax gibt der Widget-Befehl **get** eine Liste von vier Ganzzahlen zurück, bestehend aus den Werten *totalUnits*, *windowUnits*, *firstUnit* und *lastUnit* des zuletzt ausgeführten Widget-Befehls **set**.


Die von Scrollbars erzeugten Befehle haben ebenfalls eine andere Form, wenn die alte Syntax verwendet wird:

*prefix* *unit*
: *Unit* ist eine Ganzzahl, die angibt, was am oberen oder linken Rand des Fensters des verknüpften Widgets erscheinen soll. Sie hat dieselbe Bedeutung wie die Argumente *firstUnit* und *lastUnit* des Widget-Befehls **set**. Der zuletzt ausgeführte Widget-Befehl **set** bestimmt, ob die alte Syntax verwendet wird oder nicht. Wenn er mit zwei reellen Argumenten aufgerufen wird, wird künftig die neue Syntax verwendet, und wenn er mit vier Ganzzahlargumenten aufgerufen wird, wird die alte Syntax verwendet.


# BINDINGS

Tk erstellt automatisch Klassen-Bindings für Scrollbars, die ihnen folgendes Standardverhalten geben. Wenn sich das Verhalten für vertikale und horizontale Scrollbars unterscheidet, ist das horizontale Verhalten in Klammern beschrieben.

1. Das Drücken von Taste 1 über **arrow1** bewirkt, dass die Ansicht im verknüpften Widget um eine Einheit nach oben (links) verschoben wird, sodass das Dokument um eine Einheit nach unten (rechts) zu wandern scheint. Wenn die Taste gedrückt gehalten wird, wiederholt sich die Aktion automatisch.

2. Das Drücken von Taste 1 über **trough1** bewirkt, dass die Ansicht im verknüpften Widget um eine Bildschirmfüllung nach oben (links) verschoben wird, sodass das Dokument um eine Bildschirmfüllung nach unten (rechts) zu wandern scheint. Wenn die Taste gedrückt gehalten wird, wiederholt sich die Aktion automatisch.

3. Das Drücken von Taste 1 über den Schieberegler und Ziehen bewirkt, dass die Ansicht mit dem Schieberegler mitgezogen wird. Wenn die Option **jump** wahr ist, zieht die Ansicht nicht mit dem Schieberegler mit; sie ändert sich erst, wenn die Maustaste losgelassen wird.

4. Das Drücken von Taste 1 über **trough2** bewirkt, dass die Ansicht im verknüpften Widget um eine Bildschirmfüllung nach unten (rechts) verschoben wird, sodass das Dokument um eine Bildschirmfüllung nach oben (links) zu wandern scheint. Wenn die Taste gedrückt gehalten wird, wiederholt sich die Aktion automatisch.

5. Das Drücken von Taste 1 über **arrow2** bewirkt, dass die Ansicht im verknüpften Widget um eine Einheit nach unten (rechts) verschoben wird, sodass das Dokument um eine Einheit nach oben (links) zu wandern scheint. Wenn die Taste gedrückt gehalten wird, wiederholt sich die Aktion automatisch.

6. Wenn Taste 2 über dem Trog oder dem Schieberegler gedrückt wird, setzt sie die Ansicht entsprechend der Mausposition; das Ziehen der Maus mit gedrückter Taste 2 bewirkt, dass die Ansicht mit der Maus mitgezogen wird. Wenn Taste 2 über einem der Pfeile gedrückt wird, bewirkt sie dasselbe Verhalten wie das Drücken von Taste 1.

7. Wenn Taste 1 mit gedrückter Steuerungstaste gedrückt wird, ändert sich die Ansicht zum oberen (linken) Rand des Dokuments, wenn die Maus über **arrow1** oder **trough1** ist; wenn die Maus über **arrow2** oder **trough2** ist, ändert sich die Ansicht zum unteren (rechten) Rand des Dokuments; wenn die Maus sonst irgendwo ist, hat der Tastendruck keine Wirkung.

8. Bei vertikalen Scrollbars haben die Auf- und Ab-Tasten dasselbe Verhalten wie Mausklicks über **arrow1** bzw. **arrow2**. Bei horizontalen Scrollbars haben diese Tasten keine Wirkung.

9. Bei vertikalen Scrollbars haben Steuerung-Auf und Steuerung-Ab dasselbe Verhalten wie Mausklicks über **trough1** bzw. **trough2**. Bei horizontalen Scrollbars haben diese Tasten keine Wirkung.

10. Bei horizontalen Scrollbars haben die Auf- und Ab-Tasten dasselbe Verhalten wie Mausklicks über **arrow1** bzw. **arrow2**. Bei vertikalen Scrollbars haben diese Tasten keine Wirkung.

11. Bei horizontalen Scrollbars haben Steuerung-Auf und Steuerung-Ab dasselbe Verhalten wie Mausklicks über **trough1** bzw. **trough2**. Bei vertikalen Scrollbars haben diese Tasten keine Wirkung.

12. Die Bild-Auf- und Bild-Ab-Tasten haben dasselbe Verhalten wie Mausklicks über **trough1** bzw. **trough2**.

13. Die Pos1-Taste passt die Ansicht an den oberen (linken) Rand des Dokuments an.

14. Die Ende-Taste passt die Ansicht an den unteren (rechten) Rand des Dokuments an.


# BEISPIEL

Erstellt ein Fenster mit einem scrollbaren **text**-Widget:

```
toplevel .tl
text .tl.t -yscrollcommand {.tl.s set}
scrollbar .tl.s -command {.tl.t yview}
grid .tl.t .tl.s -sticky nsew
grid columnconfigure .tl 0 -weight 1
grid rowconfigure .tl 0 -weight 1
```
