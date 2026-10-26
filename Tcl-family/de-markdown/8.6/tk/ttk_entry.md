---
CommandName: ttk::entry
title: ttk::entry
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - entry(n)
Keywords:
 - entry
 - widget
 - text field
Copyright:
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 1998-2000 Scriptics Corporation.
 - Copyright (c) 2004 Joe English
---

# Name

ttk::entry - Bearbeitbares Einzeilen-Textfeld-Widget

# Übersicht

::: {.synopsis} :::
[ttk::entry]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::entry**-Widget zeigt einen einzeiligen Text-String an und erlaubt dem Benutzer, diesen String zu bearbeiten. Der Wert des Strings kann mit der Option **-textvariable** an eine Tcl-Variable gebunden werden. Entry-Widgets unterstützen horizontales Scrollen mit der Standardoption **-xscrollcommand** und dem Widget-Befehl **xview**.

# Standardoptionen

**-class**, **-cursor**, **-font**, **-foreground**, **-style**, **-takefocus**, **-xscrollcommand**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-exportselection** (**exportSelection**/**ExportSelection**)
: Ein boolescher Wert, der angibt, ob eine Auswahl im Widget mit der X-Selection verknüpft werden soll. Wird die Auswahl exportiert, hebt die Auswahl im Widget die aktuelle X-Selection auf, hebt die Auswahl außerhalb des Widgets jede Widget-Auswahl auf, und das Widget reagiert auf Anfragen zur Abfrage der Selection, wenn es eine Auswahl hat.

**-invalidcommand** (**invalidCommand**/**InvalidCommand**)
: Eine Skript-Vorlage, die ausgewertet wird, wann immer **-validatecommand** 0 zurückgibt. Siehe [Validierung] unten für weitere Informationen.

**-justify** (**justify**/**Justify**)
: Legt fest, wie der Text im Entry-Widget ausgerichtet ist. Einer von **left**, **center** oder **right**.

**-show** (**show**/**Show**)
: Wenn diese Option angegeben ist, wird der wahre Inhalt des Entrys nicht im Fenster angezeigt. Stattdessen wird jedes Zeichen im Wert des Entrys als das erste Zeichen im Wert dieser Option angezeigt, z. B. „\*“ oder ein Aufzählungszeichen. Dies ist nützlich, wenn das Entry beispielsweise zur Eingabe eines Passworts verwendet werden soll. Werden Zeichen im Entry ausgewählt und anderswo kopiert, werden die angezeigten Informationen kopiert, nicht der wahre Inhalt des Entrys.

**-state** (**state**/**State**)
: Kompatibilitätsoption; siehe *ttk::widget(n)* für Details. Legt einen von drei Zuständen für das Entry fest: **normal**, **disabled** oder **readonly**. Siehe [Widget-Zustände] unten.

**-textvariable** (**textVariable**/**Variable**)
: Gibt den Namen einer globalen Variable an, deren Wert mit dem Inhalt des Entry-Widgets verknüpft ist. Wann immer sich der Variablenwert ändert, wird der Widget-Inhalt aktualisiert und umgekehrt.

**-validate** (**validate**/**Validate**)
: Legt den Modus fest, in dem die Validierung arbeiten soll: **none**, **focus**, **focusin**, **focusout**, **key** oder **all**. Standard ist **none**, d. h. die Validierung ist deaktiviert. Siehe [Validierung] unten.

**-validatecommand** (**validateCommand**/**ValidateCommand**)
: Eine Skript-Vorlage, die ausgewertet wird, wann immer eine Validierung ausgelöst wird. Ist sie auf den leeren String gesetzt (Standard), ist die Validierung deaktiviert. Das Skript muss einen booleschen Wert zurückgeben. Siehe [Validierung] unten.

**-width** (**width**/**Width**)
: Ganzzahl für die gewünschte Breite des Eingabefensters in Zeichen durchschnittlicher Größe der Widget-Schriftart.


# Hinweise

Ein Teil des Entrys kann wie unten beschrieben ausgewählt werden. Exportiert ein Entry seine Auswahl (siehe die Option **-exportselection**), beachtet es die Standard-X11-Protokolle für die Behandlung der Selection; Entry-Auswahlen sind als Typ **STRING** verfügbar. Entrys beachten auch die Standard-Tk-Regeln für den Umgang mit dem Eingabefokus. Hat ein Entry den Eingabefokus, zeigt es einen *Einfügecursor* an, um anzuzeigen, wo neue Zeichen eingefügt werden.

Entrys können Strings anzeigen, die zu lang sind, um vollständig in das Fenster des Widgets zu passen. In diesem Fall wird nur ein Teil des Strings angezeigt; unten beschriebene Befehle können verwendet werden, um die Ansicht im Fenster zu ändern. Entrys verwenden den Standard-Mechanismus **-xscrollcommand** für die Interaktion mit Scrollbars (siehe die Beschreibung der Option **-xscrollcommand** für Details).

# Indizes

Viele der [entry]-Widget-Befehle nehmen einen oder mehrere Indizes als Argumente. Ein Index bezeichnet ein bestimmtes Zeichen im String des Entrys, auf eine der folgenden Arten:

*number*
: Bezeichnet das Zeichen als numerischen Index, wobei 0 dem ersten Zeichen im String entspricht.

**@***number*
: In dieser Form wird *number* als x-Koordinate im Fenster des Entrys behandelt; das Zeichen, das diese x-Koordinate überspannt, wird verwendet. Beispielsweise bezeichnet „**@0**“ das linkeste Zeichen im Fenster.

**end**
: Bezeichnet das Zeichen unmittelbar nach dem letzten im String des Entrys. Entspricht einem numerischen Index gleich der Länge des Strings des Entrys.

**insert**
: Bezeichnet das Zeichen neben und unmittelbar nach dem Einfügecursor.

**sel.first**
: Bezeichnet das erste Zeichen in der Auswahl. Die Verwendung dieser Form ist ein Fehler, wenn die Auswahl nicht im Entry-Fenster liegt.

**sel.last**
: Bezeichnet das Zeichen unmittelbar nach dem letzten in der Auswahl. Es ist ein Fehler, diese Form zu verwenden, wenn die Auswahl nicht im Entry-Fenster liegt.


Abkürzungen können für jede der obigen Formen verwendet werden, z. B. „**e**“ oder „**sel.l**“. Im Allgemeinen werden Indizes außerhalb des gültigen Bereichs automatisch auf den nächsten zulässigen Wert gerundet.

# Widget-Befehl

Folgende Unterbefehle sind für Entry-Widgets möglich:

*pathName* **bbox** *index*
: Gibt eine Liste von vier Zahlen zurück, die die Begrenzungsbox des durch *index* angegebenen Zeichens beschreiben. Die ersten beiden Elemente der Liste geben die x- und y-Koordinaten der oberen linken Ecke des vom Zeichen bedeckten Bildschirmbereichs an (in Pixeln relativ zum Widget), die letzten beiden geben Breite und Höhe des Zeichens in Pixeln an. Die Begrenzungsbox kann sich auf einen Bereich außerhalb des sichtbaren Fensterbereichs beziehen.

*pathName* **delete** *first* ?*last*?
: Löscht ein oder mehrere Elemente des Entrys. *First* ist der Index des ersten zu löschenden Zeichens, *last* der Index des Zeichens unmittelbar nach dem letzten zu löschenden. Ist *last* nicht angegeben, entspricht es *first*+1, d. h. es wird ein einzelnes Zeichen gelöscht. Dieser Befehl gibt den leeren String zurück.

*pathName* **get**
: Gibt den String des Entrys zurück.

*pathName* **icursor** *index*
: Sorgt dafür, dass der Einfügecursor unmittelbar vor dem durch *index* angegebenen Zeichen angezeigt wird. Gibt den leeren String zurück.

*pathName* **index** *index*
: Gibt den numerischen Index zurück, der *index* entspricht.

*pathName* **insert** *index string*
: Fügt *string* unmittelbar vor dem durch *index* angegebenen Zeichen ein. Gibt den leeren String zurück.

*pathName* **selection** *option arg*
: Dieser Befehl passt die Auswahl innerhalb eines Entrys an. Er hat mehrere Formen, abhängig von *option*:

    *pathName* **selection clear**
    : Löscht die Auswahl, falls sie derzeit in diesem Widget liegt. Liegt die Auswahl nicht in diesem Widget, hat der Befehl keine Wirkung. Gibt den leeren String zurück.

    *pathName* **selection present**
    : Gibt 1 zurück, wenn im Entry Zeichen ausgewählt sind, 0 wenn nichts ausgewählt ist.

    *pathName* **selection range** *start* *end*
    : Setzt die Auswahl so, dass sie die Zeichen ab dem durch *start* indizierten bis vor dem durch *end* indizierten einschließt. Verweist *end* auf dasselbe Zeichen wie *start* oder ein früheres, wird die Auswahl des Entrys gelöscht.


*pathName* **validate**
: Erzwingt eine erneute Validierung, unabhängig von den durch die Option **-validate** festgelegten Bedingungen. Gibt 0 zurück, wenn die Validierung fehlschlägt, 1 bei Erfolg. Setzt oder löscht den Zustand **invalid** entsprechend. Siehe [Validierung] unten für weitere Details.


Das Entry-Widget unterstützt außerdem die folgenden generischen [ttk::widget][ttk_widget]-Unterbefehle (siehe *ttk::widget(n)* für Details):

::: {.info DISPLAY="yes"}
**cget**	**configure**	**identify**\
**instate**	**state**	**xview**
:::

# Validierung

Die Optionen **-validate**, **-validatecommand** und **-invalidcommand** aktivieren die Validierung des Entry-Widgets.

## Validierungsmodi

Es gibt zwei Haupt-Validierungsmodi: *Prävalidierung*, bei der **-validatecommand** vor jeder Bearbeitung ausgewertet wird und der Rückgabewert bestimmt, ob die Änderung angenommen oder abgelehnt wird; und *Revalidierung*, bei der **-validatecommand** ausgewertet wird, um zu prüfen, ob der aktuelle Wert gültig ist.

Die Option **-validate** legt fest, wann validiert wird; sie kann auf einen der folgenden Werte gesetzt werden:

**none**
: Standard. Die Validierung erfolgt nur, wenn sie ausdrücklich durch den Widget-Befehl **validate** angefordert wird.

**key**
: Das Entry wird vor jeder Bearbeitung prävalidiert (insbesondere wann immer die Widget-Befehle **insert** oder **delete** aufgerufen werden). Schlägt die Prävalidierung fehl, wird die Bearbeitung abgelehnt.

**focus**
: Das Entry wird revalidiert, wenn es den Fokus erhält oder verliert.

**focusin**
: Das Entry wird revalidiert, wenn es den Fokus erhält.

**focusout**
: Das Entry wird revalidiert, wenn es den Fokus verliert.

**all**
: Die Validierung wird bei allen obigen Bedingungen durchgeführt.


**-invalidcommand** wird ausgewertet, wann immer **-validatecommand** einen falschen Wert zurückgibt.

**-validatecommand** und **-invalidcommand** können den Wert des Entry-Widgets über die Widget-Befehle **insert** oder **delete** oder durch Setzen der verknüpften **-textvariable** ändern. Tut eines von beiden dies während der Prävalidierung, wird die Bearbeitung abgelehnt, unabhängig vom von **-validatecommand** zurückgegebenen Wert.

Ist **-validatecommand** leer (Standard), ist die Validierung immer erfolgreich.

## Prozent-Substitutionen in Validierungsskripten

Auf **-validatecommand** und **-invalidcommand** sind Prozent-Substitutionen möglich, wie in einem [bind]-Skript. Folgende Substitutionen werden erkannt:

**%d**
: Art der Aktion: 1 für Prävalidierung bei **insert**, 0 für Prävalidierung bei **delete**, oder -1 für Revalidierung.

**%i**
: Index des einzufügenden/zu löschenden Zeichenstrings, falls vorhanden, sonst -1.

**%P**
: Bei Prävalidierung der neue Wert des Entrys, wenn die Bearbeitung angenommen wird. Bei Revalidierung der aktuelle Wert des Entrys.

**%s**
: Der aktuelle Wert des Entrys vor der Bearbeitung.

**%S**
: Der einzufügende/zu löschende Textstring, falls vorhanden, sonst {}.

**%v**
: Der aktuelle Wert der Option **-validate**.

**%V**
: Die Validierungsbedingung, die den Rückruf ausgelöst hat (**key**, **focusin**, **focusout** oder **forced**).

**%W**
: Der Name des Entry-Widgets.


## Unterschiede zur Validierung des Tk-Entry-Widgets

Das Standard-Tk-Entry-Widget deaktiviert die Validierung automatisch (durch Setzen von **-validate** auf **none**), wenn **-validatecommand** oder **-invalidcommand** den Wert des Entrys ändert. Das Tk-Themen-Entry-Widget deaktiviert die Validierung nur, wenn eines der Validierungsskripte einen Fehler auslöst oder **-validatecommand** keinen gültigen booleschen Wert zurückgibt. (Es ist also nicht nötig, die Validierung nach Änderung des Entry-Werts in einem Validierungsskript wieder zu aktivieren.)

Außerdem ruft das Standard-Entry-Widget die Validierung auf, wann immer die verknüpfte **-textvariable** geändert wird; das Tk-Themen-Entry-Widget tut dies nicht.

# Bindings

Die Standard-Bindings des Entry-Widgets ermöglichen folgendes Verhalten. In den Beschreibungen unten bezeichnet „Wort“ eine zusammenhängende Gruppe aus Buchstaben, Ziffern oder „\_“-Zeichen oder ein einzelnes anderes Zeichen.

- Ein Klick mit Maustaste 1 positioniert den Einfügecursor unmittelbar vor dem Zeichen unter dem Mauszeiger, setzt den Eingabefokus auf dieses Widget und löscht jede Auswahl im Widget. Ziehen mit gedrückter Maustaste 1 erzeugt eine Auswahl zwischen Einfügecursor und dem Zeichen unter der Maus.

- Doppelklick mit Maustaste 1 wählt das Wort unter der Maus aus und positioniert den Einfügecursor am Ende des Worts. Ziehen nach einem Doppelklick erzeugt eine Auswahl aus ganzen Wörtern.

- Dreifachklick mit Maustaste 1 wählt den gesamten Text im Entry aus und positioniert den Einfügecursor am Zeilenende.

- Die Enden der Auswahl können durch Ziehen mit Maustaste 1 bei gedrückter Umschalttaste angepasst werden. Wurde vor dem Ziehen doppelgeklickt, wird die Auswahl in Einheiten ganzer Wörter angepasst.

- Klick mit Maustaste 1 bei gedrückter Steuerung positioniert den Einfügecursor im Entry, ohne die Auswahl zu beeinflussen.

- Werden normale druckbare Zeichen in einem Entry eingegeben, werden sie an der Position des Einfügecursors eingefügt.

- Die Ansicht im Entry kann durch Ziehen mit der mittleren Maustaste (Taste 2, oder Taste 3 unter TkAqua) angepasst werden. Wird die mittlere Maustaste ohne Mausbewegung geklickt, wird die Auswahl an der Mausposition in das Entry kopiert.

- Wird die Maus beim Gedrückthalten von Taste 1 links oder rechts aus dem Entry gezogen, scrollt das Entry automatisch, um mehr Text sichtbar zu machen (falls auf der Seite, auf der die Maus das Fenster verließ, noch Text außerhalb des Bildschirms liegt).

- Die Tasten Links und Rechts bewegen den Einfügecursor um ein Zeichen nach links oder rechts; sie löschen außerdem jede Auswahl im Entry. Wird Links oder Rechts mit gedrückter Umschalttaste eingegeben, bewegt sich der Einfügecursor und die Auswahl wird um das neue Zeichen erweitert. Steuerung-Links und Steuerung-Rechts bewegen den Einfügecursor wortweise; Steuerung-Umschalt-Links und Steuerung-Umschalt-Rechts bewegen ihn wortweise und erweitern die Auswahl. Steuerung-b und Steuerung-f verhalten sich wie Links bzw. Rechts.

- Die Pos1-Taste und Steuerung-a bewegen den Einfügecursor an den Anfang des Entrys und löschen jede Auswahl. Umschalt-Pos1 bewegt den Einfügecursor an den Anfang und erweitert die Auswahl bis dorthin.

- Die Ende-Taste und Steuerung-e bewegen den Einfügecursor ans Ende des Entrys und löschen jede Auswahl. Umschalt-Ende bewegt den Cursor ans Ende und erweitert die Auswahl bis dorthin.

- Steuerung-/ wählt den gesamten Text im Entry aus.

- Steuerung-\\ löscht jede Auswahl im Entry.

- Die virtuellen Ereignisse <<Cut>>, <<Copy>>, <<Paste>> und <<Clear>> von Tk wirken auf die Auswahl wie erwartet.

- Die Entf-Taste löscht die Auswahl, falls eine im Entry besteht. Gibt es keine Auswahl, löscht sie das Zeichen rechts vom Einfügecursor.

- Die Rücktaste und Steuerung-h löschen die Auswahl, falls eine im Entry besteht. Gibt es keine Auswahl, löschen sie das Zeichen links vom Einfügecursor.

- Steuerung-d löscht das Zeichen rechts vom Einfügecursor.

- Steuerung-k löscht alle Zeichen rechts vom Einfügecursor.


# Widget-Zustände

Im Zustand **disabled** kann das Entry nicht bearbeitet und der Text nicht ausgewählt werden. Im Zustand **readonly** wird kein Einfügecursor angezeigt und das Entry kann nicht bearbeitet werden (insbesondere: die Befehle **insert** und **delete** haben keine Wirkung). Der Zustand **disabled** entspricht **readonly**, zusätzlich kann der Text nicht ausgewählt werden.

Änderungen an der verknüpften **-textvariable** werden weiterhin im Entry angezeigt, auch wenn es disabled oder readonly ist.

Typischerweise wird der Text im Zustand **disabled** „ausgegraut“ dargestellt, im Zustand **readonly** ein anderer Hintergrund verwendet.

Das Entry-Widget setzt den Zustand **invalid**, wenn die Revalidierung fehlschlägt, und löscht ihn, wann immer die Validierung erfolgreich ist.

# Stil-Optionen

Der Klassenname für **ttk::entry** ist **TEntry**.

Dynamische Zustände: **disabled**, **focus**, **readonly**.

Mit [ttk::style][ttk_style] konfigurierbare **TEntry**-Stiloptionen:

**-background** *color*
: Zur Abwärtskompatibilität verhält sich diese Option beim aqua-Theme (für macOS) als Alias für **-fieldbackground**, sofern für **-fieldbackground** kein Wert angegeben ist. Andernfalls wird sie ignoriert.


**-bordercolor** *color*

**-darkcolor** *color*

**-fieldbackground** *color*
: Einige Themes verwenden einen grafischen Hintergrund; deren Feld-Hintergrundfarben können nicht geändert werden.


**-foreground** *color*

**-insertcolor** *color*

**-insertwidth** *amount*

**-lightcolor** *color*

**-padding** *padding*

**-relief** *relief*

**-selectbackground** *color*

**-selectborderwidth** *amount*

**-selectforeground** *color*

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[bind]: bind.md
[entry]: entry.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
