---
CommandName: listbox
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::treeview(n)
Keywords:
 - listbox
 - widget
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# NAME

listbox - Erstellt und manipuliert 'Listbox'-Elementlisten-Widgets

# ÜBERSICHT

::: {.synopsis} :::
[listbox]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# WIDGET-SPEZIFISCHE OPTIONEN

**-activestyle** (activeStyle/ActiveStyle)
: Legt den Stil fest, in dem das aktive Element gezeichnet wird. Dies muss einer von **dotbox** (zeigt einen Fokusring um das aktive Element), **none** (keine besondere Kennzeichnung des aktiven Elements) oder **underline** (unterstreicht das aktive Element) sein. Der Standardwert ist **underline** unter Windows und **dotbox** anderswo.

**-height** (height/Height)
: Legt die gewünschte Höhe für das Fenster in Zeilen fest. Wenn der Wert null oder kleiner ist, wird die gewünschte Höhe des Fensters gerade groß genug gemacht, um alle Elemente in der Listbox aufzunehmen.

**-listvariable** (listVariable/Variable)
: Legt den Namen einer globalen Variable fest. Der Wert der Variable ist eine Liste, die innerhalb des Widgets angezeigt werden soll; wenn sich der Variablenwert ändert, aktualisiert sich das Widget automatisch, um den neuen Wert widerzuspiegeln. Versuche, einer Variable mit einem ungültigen Listenwert **-listvariable** zuzuweisen, führen zu einem Fehler. Versuche, eine als **-listvariable** verwendete Variable zu entfernen, schlagen fehl, erzeugen aber keinen Fehler.

**-selectmode** (selectMode/SelectMode)
: Legt einen von mehreren Stilen für die Manipulation der Auswahl fest. Der Wert der Option kann beliebig sein, aber die Standard-Bindings erwarten **single**, **browse**, **multiple** oder **extended**; der Standardwert ist **browse**.

**-state** (state/State)
: Legt einen von zwei Zuständen für die Listbox fest: **normal** oder **disabled**. Wenn die Listbox deaktiviert ist, können keine Elemente eingefügt oder gelöscht werden, Elemente werden in der Farbe **-disabledforeground** gezeichnet, und die Auswahl kann nicht geändert werden und wird nicht angezeigt (Auswahlinformationen bleiben jedoch erhalten).

**-width** (width/Width)
: Legt die gewünschte Breite für das Fenster in Zeichen fest. Wenn die Schriftart keine einheitliche Breite hat, wird die Breite des Zeichens „0“ bei der Umrechnung von Zeicheneinheiten in Bildschirmeinheiten verwendet. Wenn der Wert null oder kleiner ist, wird die gewünschte Breite des Fensters gerade groß genug gemacht, um alle Elemente in der Listbox aufzunehmen.


# BESCHREIBUNG

Der Befehl **listbox** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Listbox-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte der Listbox wie Farben, Schriftart, Text und Relief zu konfigurieren. Der Befehl **listbox** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Eine Listbox ist ein Widget, das eine Liste von Zeichenketten anzeigt, eine pro Zeile. Bei der Erstellung hat eine neue Listbox keine Elemente. Elemente können mit den unten beschriebenen Widget-Befehlen hinzugefügt oder gelöscht werden. Zusätzlich können ein oder mehrere Elemente wie unten beschrieben ausgewählt werden. Wenn eine Listbox ihre Auswahl exportiert (siehe Option **-exportselection**), beachtet sie die Standard-X11-Protokolle für die Behandlung der Auswahl. Listbox-Auswahlen sind als Typ **STRING** verfügbar; der Wert der Auswahl ist der Text der ausgewählten Elemente, wobei die Elemente durch Zeilenumbrüche getrennt sind.

Es ist nicht erforderlich, dass alle Elemente gleichzeitig im Listbox-Fenster angezeigt werden; die unten beschriebenen Befehle können verwendet werden, um die Ansicht im Fenster zu ändern. Listboxes erlauben das Scrollen in beide Richtungen mit den Standardoptionen **-xscrollcommand** und **-yscrollcommand**. Sie unterstützen auch Scanning, wie unten beschrieben.

# INDIZES

Viele der Widget-Befehle für Listboxes nehmen ein oder mehrere Indizes als Argumente. Ein Index gibt ein bestimmtes Element der Listbox an, auf eine der folgenden Arten:

*number*
: Legt das Element als numerischen Index fest, wobei 0 dem ersten Element in der Listbox entspricht.

**active**
: Bezeichnet das Element, das den Positionscursor hat. Dieses Element wird wie durch **-activestyle** festgelegt angezeigt, wenn die Listbox den Tastaturfokus hat, und wird mit dem Widget-Befehl **activate** festgelegt.

**anchor**
: Bezeichnet den Ankerpunkt für die Auswahl, der mit dem Widget-Befehl **selection anchor** gesetzt wird.

**end**
: Bezeichnet das Ende der Listbox. Für die meisten Befehle bezieht sich dies auf das letzte Element in der Listbox, aber für einige Befehle wie **index** und **insert** bezieht es sich auf das Element direkt nach dem letzten.

**@**_x_**,**_y_
: Bezeichnet das Element, das den Punkt im Listbox-Fenster abdeckt, der durch *x* und *y* (in Pixelkoordinaten) angegeben ist. Wenn kein Element diesen Punkt abdeckt, wird das dem Punkt am nächsten liegende Element verwendet. In den unten stehenden Widget-Befehlsbeschreibungen enthalten Argumente mit den Namen *index*, *first* und *last* immer Textindizes in einer der obigen Formen.


# WIDGET-BEFEHL

Der Befehl **listbox** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Listbox-Widgets möglich:

*pathName* **activate** *index*
: Setzt das aktive Element auf das durch *index* angegebene. Wenn *index* außerhalb des Bereichs der Elemente in der Listbox liegt, wird das nächstgelegene Element aktiviert. Das aktive Element wird wie durch **-activestyle** festgelegt gezeichnet, wenn das Widget den Eingabefokus hat, und sein Index kann mit dem Index **active** abgerufen werden.

*pathName* **bbox** *index*
: Gibt eine Liste von vier Zahlen zurück, die die Begrenzungsbox des Textes im durch *index* gegebenen Element beschreiben. Die ersten beiden Elemente der Liste geben die x- und y-Koordinaten der oberen linken Ecke des vom Text abgedeckten Bildschirmbereichs an (in Pixeln relativ zum Widget), und die letzten beiden Elemente geben die Breite und Höhe des Bereichs in Pixeln an. Wenn kein Teil des durch *index* gegebenen Elements auf dem Bildschirm sichtbar ist oder wenn *index* auf ein nicht existierendes Element verweist, ist das Ergebnis eine leere Zeichenkette; wenn das Element teilweise sichtbar ist, gibt das Ergebnis den vollständigen Bereich des Elements an, einschließlich aller nicht sichtbaren Teile.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **listbox** akzeptierten Werte haben.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe **Tk_ConfigureInfo** für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **listbox** akzeptierten Werte haben.

*pathName* **curselection**
: Gibt eine Liste zurück, die die numerischen Indizes aller Elemente in der Listbox enthält, die derzeit ausgewählt sind. Wenn in der Listbox keine Elemente ausgewählt sind, wird eine leere Zeichenkette zurückgegeben.

*pathName* **delete** *first* ?*last*?
: Löscht ein oder mehrere Elemente der Listbox. *First* und *last* sind Indizes, die das erste und letzte Element im zu löschenden Bereich angeben. Wenn *last* nicht angegeben ist, entspricht es *first*, d. h. ein einzelnes Element wird gelöscht.

*pathName* **get** *first* ?*last*?
: Wenn *last* weggelassen wird, gibt der Befehl den Inhalt des durch *first* angegebenen Listbox-Elements zurück oder eine leere Zeichenkette, wenn *first* auf ein nicht existierendes Element verweist. Wenn *last* angegeben ist, gibt der Befehl eine Liste zurück, deren Elemente alle Listbox-Elemente zwischen *first* und *last* einschließlich sind. Sowohl *first* als auch *last* können eine der Standardformen für Indizes haben.

*pathName* **index** *index*
: Gibt den ganzzahligen Indexwert zurück, der *index* entspricht. Wenn *index* **end** ist, ist der Rückgabewert eine Anzahl der Elemente in der Listbox (nicht der Index des letzten Elements).

*pathName* **insert** *index* ?*element element ...*?
: Fügt null oder mehr neue Elemente in die Liste direkt vor dem durch *index* gegebenen Element ein. Wenn *index* als **end** angegeben ist, werden die neuen Elemente am Ende der Liste hinzugefügt. Gibt einen leeren String zurück.

*pathName* **itemcget** *index option*
: Gibt den aktuellen Wert der durch *option* gegebenen Item-Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **itemconfigure** akzeptierten Werte haben.

*pathName* **itemconfigure** *index* ?*option*? ?*value*? ?*option value ...*?
: Abfrage oder Änderung der Konfigurationsoptionen eines Items in der Listbox. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für das Item beschreibt (siehe **Tk_ConfigureInfo** für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. Die folgenden Optionen werden derzeit für Items unterstützt:

**-background** *color*
: *Color* legt die Hintergrundfarbe fest, die beim Anzeigen des Items verwendet wird. Sie kann eine der von **Tk_GetColor** akzeptierten Formen haben.

**-foreground** *color*
: *Color* legt die Vordergrundfarbe fest, die beim Anzeigen des Items verwendet wird. Sie kann eine der von **Tk_GetColor** akzeptierten Formen haben.

**-selectbackground** *color*
: *color* legt die Hintergrundfarbe fest, die beim Anzeigen des Items verwendet wird, während es ausgewählt ist. Sie kann eine der von **Tk_GetColor** akzeptierten Formen haben.

**-selectforeground** *color*
: *color* legt die Vordergrundfarbe fest, die beim Anzeigen des Items verwendet wird, während es ausgewählt ist. Sie kann eine der von **Tk_GetColor** akzeptierten Formen haben.


*pathName* **nearest** *y*
: Gibt bei einer y-Koordinate innerhalb des Listbox-Fensters den Index des (sichtbaren) Listbox-Elements zurück, das dieser y-Koordinate am nächsten liegt.

*pathName* **scan** *option args*
: Dieser Befehl wird verwendet, um Scanning auf Listboxes zu implementieren. Er hat zwei Formen, abhängig von *option*:

*pathName* **scan mark** *x y*
: Speichert *x* und *y* sowie die aktuelle Ansicht im Listbox-Fenster; wird in Verbindung mit späteren **scan dragto**-Befehlen verwendet. Typischerweise wird dieser Befehl mit einem Maustastendruck im Widget verknüpft. Gibt einen leeren String zurück.

*pathName* **scan dragto** *x y*.
: Dieser Befehl berechnet die Differenz zwischen seinen *x*- und *y*-Argumenten und den *x*- und *y*-Argumenten des letzten **scan mark**-Befehls für das Widget. Anschließend passt er die Ansicht um das Zehnfache der Koordinatendifferenz an. Dieser Befehl wird typischerweise mit Mausbewegungs-Events im Widget verknüpft, um den Effekt zu erzeugen, die Liste mit hoher Geschwindigkeit durch das Fenster zu ziehen. Der Rückgabewert ist ein leerer String.


*pathName* **see** *index*
: Passt die Ansicht in der Listbox so an, dass das durch *index* gegebene Element sichtbar ist. Wenn das Element bereits sichtbar ist, hat der Befehl keine Wirkung; wenn das Element nahe an einer Kante des Fensters liegt, scrollt die Listbox, um das Element an der Kante sichtbar zu machen; andernfalls scrollt die Listbox, um das Element zu zentrieren.

*pathName* **selection** *option arg*
: Dieser Befehl wird verwendet, um die Auswahl innerhalb einer Listbox anzupassen. Er hat mehrere Formen, abhängig von *option*:

*pathName* **selection anchor** *index*
: Setzt den Auswahlanker auf das durch *index* gegebene Element. Wenn *index* auf ein nicht existierendes Element verweist, wird das nächstgelegene Element verwendet. Der Auswahlanker ist das Ende der Auswahl, das beim Ziehen einer Auswahl mit der Maus fest bleibt. Der Index **anchor** kann verwendet werden, um auf das Ankerelement zu verweisen.

*pathName* **selection clear** *first* ?*last*?
: Wenn eines der Elemente zwischen *first* und *last* (einschließlich) ausgewählt ist, wird die Auswahl aufgehoben. Der Auswahlzustand wird für Elemente außerhalb dieses Bereichs nicht geändert.

*pathName* **selection includes** *index*
: Gibt 1 zurück, wenn das durch *index* angegebene Element derzeit ausgewählt ist, 0 wenn nicht.

*pathName* **selection set** *first* ?*last*?
: Wählt alle Elemente im Bereich zwischen *first* und *last* einschließlich aus, ohne den Auswahlzustand von Elementen außerhalb dieses Bereichs zu beeinflussen.


*pathName* **size**
: Gibt eine Dezimalzeichenkette zurück, die die Gesamtzahl der Elemente in der Listbox angibt.

*pathName* **xview** ?*args*
: Dieser Befehl wird verwendet, um die horizontale Position der Informationen im Fenster des Widgets abzufragen und zu ändern. Er kann eine der folgenden Formen annehmen:

*pathName* **xview**
: Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruch zwischen 0 und 1; zusammen beschreiben sie den horizontal sichtbaren Bereich im Fenster. Wenn beispielsweise das erste Element .2 und das zweite Element .6 ist, sind 20 % des Listbox-Textes links außerhalb des Bildschirms, die mittleren 40 % sind im Fenster sichtbar und 40 % des Textes sind rechts außerhalb des Bildschirms. Dies sind dieselben Werte, die über die Option **-xscrollcommand** an Scrollbars übergeben werden.

*pathName* **xview** *index*
: Passt die Ansicht im Fenster so an, dass die durch *index* gegebene Zeichenposition am linken Rand des Fensters angezeigt wird. Zeichenpositionen werden durch die Breite des Zeichens **0** definiert.

*pathName* **xview moveto** *fraction*
: Passt die Ansicht im Fenster so an, dass *fraction* der Gesamtbreite des Listbox-Textes links außerhalb des Bildschirms ist. *fraction* muss ein Bruch zwischen 0 und 1 sein.

*pathName* **xview scroll** *number what*
: Dieser Befehl verschiebt die Ansicht im Fenster nach links oder rechts gemäß *number* und *what*. *Number* muss eine Ganzzahl sein. *What* muss entweder **units** oder **pages** oder eine Abkürzung davon sein. Wenn *what* **units** ist, passt sich die Ansicht nach links oder rechts um *number* Zeicheneinheiten (die Breite des Zeichens **0**) auf der Anzeige an; wenn es **pages** ist, passt sich die Ansicht um *number* Bildschirmfüllungen an. Wenn *number* negativ ist, werden Zeichen weiter links sichtbar; wenn es positiv ist, werden Zeichen weiter rechts sichtbar.


*pathName* **yview** ?*args*?
: Dieser Befehl wird verwendet, um die vertikale Position des Textes im Fenster des Widgets abzufragen und zu ändern. Er kann eine der folgenden Formen annehmen:

*pathName* **yview**
: Gibt eine Liste mit zwei Elementen zurück, die beide reelle Brüche zwischen 0 und 1 sind. Das erste Element gibt die Position des Listbox-Elements am oberen Rand des Fensters relativ zur Listbox als Ganzes an (0,5 bedeutet beispielsweise, dass es auf halber Strecke durch die Listbox ist). Das zweite Element gibt die Position des Listbox-Elements direkt nach dem letzten im Fenster relativ zur Listbox als Ganzes an. Dies sind dieselben Werte, die über die Option **-yscrollcommand** an Scrollbars übergeben werden.

*pathName* **yview** *index*
: Passt die Ansicht im Fenster so an, dass das durch *index* gegebene Element am oberen Rand des Fensters angezeigt wird.

*pathName* **yview moveto** *fraction*
: Passt die Ansicht im Fenster so an, dass das durch *fraction* gegebene Element am oberen Rand des Fensters erscheint. *Fraction* ist ein Bruch zwischen 0 und 1; 0 bezeichnet das erste Element in der Listbox, 0,33 bezeichnet das Element ein Drittel des Weges durch die Listbox und so weiter.

*pathName* **yview scroll** *number what*
: Dieser Befehl passt die Ansicht im Fenster nach oben oder unten gemäß *number* und *what* an. *Number* muss eine Ganzzahl sein. *What* muss entweder **units** oder **pages** sein. Wenn *what* **units** ist, passt sich die Ansicht nach oben oder unten um *number* Zeilen an; wenn es **pages** ist, passt sich die Ansicht um *number* Bildschirmfüllungen an. Wenn *number* negativ ist, werden frühere Elemente sichtbar; wenn es positiv ist, werden spätere Elemente sichtbar.



# STANDARD-BINDINGS

Tk erstellt automatisch Klassen-Bindings für Listboxes, die ihnen Motif-ähnliches Verhalten geben. Ein Großteil des Verhaltens einer Listbox wird durch ihre Option **-selectmode** bestimmt, die eine von vier Arten der Behandlung der Auswahl auswählt.

Wenn der Auswahlmodus **single** oder **browse** ist, kann höchstens ein Element in der Listbox gleichzeitig ausgewählt sein. In beiden Modi wählt ein Klick mit Taste 1 auf ein Element es aus und hebt die Auswahl aller anderen ausgewählten Elemente auf. Im Modus **browse** ist es auch möglich, die Auswahl mit Taste 1 zu ziehen. Bei Taste 1 erhält die Listbox auch den Fokus, wenn sie den Zustand **normal** hat.

Wenn der Auswahlmodus **multiple** oder **extended** ist, können beliebig viele Elemente gleichzeitig ausgewählt werden, einschließlich nicht zusammenhängender Bereiche. Im Modus **multiple** schaltet ein Klick mit Taste 1 auf ein Element dessen Auswahlzustand um, ohne andere Elemente zu beeinflussen. Im Modus **extended** wählt das Drücken von Taste 1 auf ein Element es aus, hebt die Auswahl aller anderen auf und setzt den Anker auf das Element unter der Maus; das Ziehen der Maus mit gedrückter Taste 1 erweitert die Auswahl, um alle Elemente zwischen dem Anker und dem Element unter der Maus einschließlich einzubeziehen.

Die meisten Benutzer werden wahrscheinlich den Modus **browse** für Einzelauswahlen und den Modus **extended** für Mehrfachauswahlen verwenden wollen; die anderen Modi scheinen nur in besonderen Situationen nützlich zu sein.

Jedes Mal, wenn die Menge der ausgewählten Elemente in der Listbox vom Benutzer über Tastatur oder Maus aktualisiert wird, wird das virtuelle Event **<\<ListboxSelect>>** erzeugt. Dieses virtuelle Event wird nicht erzeugt, wenn die Auswahl mit dem Befehl *pathName* **selection** angepasst wird. Am einfachsten ist es, an dieses Event zu binden, um über Benutzeränderungen der Listbox-Auswahl informiert zu werden.

Zusätzlich zu dem obigen Verhalten wird durch die Standard-Bindings folgendes weiteres Verhalten definiert:

1. Im Modus **extended** kann der ausgewählte Bereich angepasst werden, indem Taste 1 mit gedrückter Umschalttaste gedrückt wird: dies ändert die Auswahl so, dass sie aus den Elementen zwischen dem Anker und dem Element unter der Maus einschließlich besteht. Das nicht verankerte Ende dieser neuen Auswahl kann ebenfalls mit gedrückter Taste gezogen werden.

2. Im Modus **extended** startet das Drücken von Taste 1 mit gedrückter Steuerungstaste eine Umschaltoperation: der Anker wird auf das Element unter der Maus gesetzt und dessen Auswahlzustand wird umgekehrt. Der Auswahlzustand anderer Elemente wird nicht geändert. Wenn die Maus mit gedrückter Taste 1 gezogen wird, wird der Auswahlzustand aller Elemente zwischen dem Anker und dem Element unter der Maus so gesetzt, dass er dem des Ankerelements entspricht; der Auswahlzustand aller anderen Elemente bleibt, was er vor Beginn der Umschaltoperation war.

3. Wenn die Maus das Listbox-Fenster mit gedrückter Taste 1 verlässt, scrollt das Fenster von der Maus weg und macht Informationen sichtbar, die zuvor auf der Seite der Maus außerhalb des Bildschirms waren. Das Scrollen setzt sich fort, bis die Maus das Fenster wieder betritt, die Taste losgelassen wird oder das Ende der Listbox erreicht ist.

4. Maustaste 2 kann für Scanning verwendet werden. Wenn sie gedrückt und über die Listbox gezogen wird, zieht der Inhalt der Listbox mit hoher Geschwindigkeit in die Richtung, in die sich die Maus bewegt.

5. Wenn die Auf- oder Ab-Taste gedrückt wird, bewegt sich der Positionscursor (aktives Element) um ein Element nach oben oder unten. Wenn der Auswahlmodus **browse** oder **extended** ist, wird das neue aktive Element auch ausgewählt und alle anderen Elemente abgewählt. Im Modus **extended** wird das neue aktive Element zum Auswahlanker.

6. Im Modus **extended** bewegen Umschalt-Auf und Umschalt-Ab den Positionscursor (aktives Element) um ein Element nach oben oder unten und erweitern die Auswahl auf dieses Element in ähnlicher Weise wie das Ziehen mit Maustaste 1.

7. Die Links- und Rechts-Tasten scrollen die Listbox-Ansicht nach links und rechts um die Breite des Zeichens **0**. Steuerung-Links und Steuerung-Rechts scrollen die Listbox-Ansicht nach links und rechts um die Breite des Fensters. Steuerung-Bild-Auf und Steuerung-Bild-Ab scrollen ebenfalls nach links und rechts um die Breite des Fensters.

8. Die Bild-Auf- und Bild-Ab-Tasten scrollen die Listbox-Ansicht nach oben und unten um eine Seite (die Höhe des Fensters).

9. Die Pos1- und Ende-Tasten scrollen die Listbox horizontal zu den linken bzw. rechten Rändern.

10. Steuerung-Pos1 setzt den Positionscursor auf das erste Element in der Listbox, wählt dieses Element aus und hebt die Auswahl aller anderen in der Listbox auf.

11. Steuerung-Ende setzt den Positionscursor auf das letzte Element in der Listbox, wählt dieses Element aus und hebt die Auswahl aller anderen in der Listbox auf.

12. Im Modus **extended** erweitert Steuerung-Umschalt-Pos1 die Auswahl auf das erste Element in der Listbox und Steuerung-Umschalt-Ende erweitert die Auswahl auf das letzte Element.

13. Im Modus **multiple** bewegt Steuerung-Umschalt-Pos1 den Positionscursor auf das erste Element in der Listbox und Steuerung-Umschalt-Ende bewegt den Positionscursor auf das letzte Element.

14. Die Leertaste und die Auswahl-Taste treffen eine Auswahl am Positionscursor (aktives Element), genau so, als wäre Maustaste 1 über diesem Element gedrückt worden.

15. Im Modus **extended** erweitern Steuerung-Umschalt-Leertaste und Umschalt-Auswahl die Auswahl auf das aktive Element, genau so, als wäre Taste 1 mit gedrückter Umschalttaste gedrückt worden.

16. Im Modus **extended** bricht die Escape-Taste die letzte Auswahl ab und stellt den vorherigen Auswahlzustand aller Elemente im ausgewählten Bereich wieder her.

17. Steuerung-/ wählt alles im Widget aus, außer in den Modi **single** und **browse**, in denen das aktive Element ausgewählt und alles andere abgewählt wird.

18. Steuerung-\\ hebt die Auswahl alles im Widget auf, außer im Modus **browse**, wo es keine Wirkung hat.

19. Die F16-Taste (auf vielen Sun-Arbeitsplätzen mit Copy beschriftet) oder Meta-w kopiert die Auswahl im Widget in die Zwischenablage, sofern eine Auswahl vorhanden ist.


Das Verhalten von Listboxes kann geändert werden, indem neue Bindings für einzelne Widgets definiert werden oder indem die Klassen-Bindings neu definiert werden.
