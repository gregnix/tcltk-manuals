---
CommandName: spinbox
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::spinbox(n)
Keywords:
 - spinbox
 - entry
 - widget
Copyright:
 - Copyright (c) 2000 Jeffrey Hobbs.
 - Copyright (c) 2000 Ajuba Solutions.
---

# NAME

spinbox - Erstellt und manipuliert 'Spinbox'-Wert-Dreh-Widgets

# ÜBERSICHT

::: {.synopsis} :::
[spinbox]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# WIDGET-SPEZIFISCHE OPTIONEN

**-buttonbackground** (buttonBackground/Background)
: Die Hintergrundfarbe für die Spin-Buttons.

**-buttoncursor** (buttonCursor/Cursor)
: Der Cursor, der über den Spin-Buttons verwendet wird. Ist dies leer (Standard), wird ein Standard-Cursor verwendet.

**-buttondownrelief** (buttonDownRelief/Relief)
: Das Relief für den oberen Spin-Button.

**-buttonuprelief** (buttonUpRelief/Relief)
: Das Relief für den unteren Spin-Button.

**-command** (command/Command)
: Legt einen Tcl-Befehl fest, der aufgerufen wird, wann immer ein Spin-Button betätigt wird. Der Befehl erkennt mehrere Prozent-Substitutionen: **%W** für den Widget-Pfad, **%s** für den aktuellen Wert des Widgets und **%d** für die Richtung des gedrückten Buttons (**up** oder **down**).

**-disabledbackground** (disabledBackground/DisabledBackground)
: Legt die Hintergrundfarbe fest, die verwendet wird, wenn die Spinbox deaktiviert ist. Ist diese Option der leere String, wird die normale Hintergrundfarbe verwendet.

**-disabledforeground** (disabledForeground/DisabledForeground)
: Legt die Vordergrundfarbe fest, die verwendet wird, wenn die Spinbox deaktiviert ist. Ist diese Option der leere String, wird die normale Vordergrundfarbe verwendet.

**-format** (format/Format)
: Legt ein alternatives Format fest, das beim Setzen des String-Werts bei Verwendung des Bereichs **-from** und **-to** verwendet wird. Dies muss ein Format-Spezifizierer der Form **%<pad>.<pad>f** sein, da er eine Fließkommazahl formatiert.

**-from** (from/From)
: Ein Fließkommawert entsprechend dem niedrigsten Wert einer Spinbox, verwendet zusammen mit **-to** und **-increment**. Sind alle korrekt angegeben, steuert die Spinbox ihren Inhalt damit. Ist dieser Wert größer als die Option **-to**, werden **-from** und **-to** automatisch vertauscht. Ist **-values** angegeben, hat diese Option Vorrang.

**-invalidcommand**, **-invcmd** (invalidCommand/InvalidCommand)
: Legt ein Skript fest, das ausgewertet wird, wenn **-validatecommand** 0 zurückgibt. Setzen auf den leeren String deaktiviert diese Funktion (Standard). Die beste Verwendung ist *bell*. Siehe **VALIDIERUNG** unten.

**-increment** (increment/Increment)
: Ein Fließkommawert für die Schrittweite. Zusammen mit **-from** und **-to** wird der Wert im Widget bei Betätigung eines Spin-Buttons um **-increment** angepasst (nach oben addiert, nach unten subtrahiert).

**-readonlybackground** (readonlyBackground/ReadonlyBackground)
: Legt die Hintergrundfarbe fest, die verwendet wird, wenn die Spinbox schreibgeschützt ist. Ist diese Option der leere String, wird die normale Hintergrundfarbe verwendet.

**-state** (state/State)
: Legt einen von drei Zuständen für die Spinbox fest: **normal**, **disabled** oder **readonly**. Ist die Spinbox schreibgeschützt, kann der Wert nicht mit Widget-Befehlen geändert werden und es wird kein Einfügecursor angezeigt, auch wenn der Eingabefokus im Widget liegt; der Inhalt kann weiterhin ausgewählt werden. Ist die Spinbox deaktiviert, kann der Wert nicht geändert werden, es wird kein Einfügecursor angezeigt, der Inhalt ist nicht auswählbar, und die Spinbox kann je nach **-disabledforeground** und **-disabledbackground** in einer anderen Farbe dargestellt werden.

**-to** (to/To)
: Ein Fließkommawert entsprechend dem höchsten Wert der Spinbox, verwendet zusammen mit **-from** und **-increment**. Sind alle korrekt angegeben, steuert die Spinbox ihren Inhalt damit. Ist dieser Wert kleiner als die Option **-from**, werden **-from** und **-to** automatisch vertauscht. Ist **-values** angegeben, hat diese Option Vorrang.

**-validate** (validate/Validate)
: Legt den Modus fest, in dem die Validierung arbeiten soll: **none**, **focus**, **focusin**, **focusout**, **key** oder **all**. Der Standard ist **none**. Wenn Sie Validierung wünschen, müssen Sie explizit angeben, welchen Modus Sie verwenden möchten. Siehe **VALIDIERUNG** unten für weitere Informationen.

**-validatecommand**, **-vcmd** (validateCommand/ValidateCommand)
: Legt ein Skript fest, das ausgewertet wird, wenn die Eingabe im Widget validiert werden soll. Setzen auf den leeren String deaktiviert diese Funktion (Standard). Die Validierung erfolgt gemäß **-validate**. Dieser Befehl muss einen gültigen Tcl-Boolean-Wert zurückgeben. Gibt er 0 zurück (oder das gültige Tcl-Boolean-Äquivalent), ändert sich der Widget-Wert nicht und **-invalidcommand** wird ausgewertet, falls gesetzt. Gibt er 1 zurück, wird der Wert geändert. Siehe **VALIDIERUNG** unten.

**-values** (values/Values)
: Muss ein gültiger Listenwert sein. Ist dies angegeben, verwendet die Spinbox diese Werte zur Steuerung des Inhalts, beginnend mit dem ersten Wert. Diese Option hat Vorrang vor dem Bereich **-from** und **-to**.

**-width** (width/Width)
: Gibt einen ganzzahligen Wert an, der die gewünschte Breite des Spinbox-Fensters in Zeichen durchschnittlicher Größe der Widget-Schriftart angibt. Ist der Wert negativ oder null, wählt das Widget eine Größe, die gerade groß genug für den aktuellen Text ist.

**-wrap** (wrap/wrap)
: Muss ein gültiger boolescher Wert sein. Ist er an, springt die Spinbox an den Enden der Daten im Widget um.


# BESCHREIBUNG

Der Befehl **spinbox** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Spinbox-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte der Spinbox wie Farben, Schriftart und Relief zu konfigurieren. Der Befehl **spinbox** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Eine **spinbox** ist ein erweitertes **entry**-Widget, mit dem der Benutzer durch eine feste Menge auf- oder absteigender Werte (z. B. Zeiten oder Daten) „drehen“ kann, zusätzlich zur Bearbeitung des Werts wie in einem **entry**. Bei der Erstellung ist der String der Spinbox leer. Ein Teil der Spinbox kann wie unten beschrieben ausgewählt werden. Exportiert eine Spinbox ihre Auswahl (siehe die Option **-exportselection**), beachtet sie die Standard-Protokolle für die Behandlung der Selection; Spinbox-Auswahlen sind als Typ **STRING** verfügbar. Spinboxen beachten auch die Standard-Tk-Regeln für den Umgang mit dem Eingabefokus. Hat eine Spinbox den Eingabefokus, zeigt sie einen *Einfügecursor* an, um anzuzeigen, wo neue Zeichen eingefügt werden.

Spinboxen können Strings anzeigen, die zu lang sind, um vollständig in das Fenster des Widgets zu passen. In diesem Fall wird nur ein Teil des Strings angezeigt; unten beschriebene Befehle können verwendet werden, um die Ansicht im Fenster zu ändern. Spinboxen verwenden den Standard-Mechanismus **-xscrollcommand** für die Interaktion mit Scrollbars (siehe die Beschreibung der Option **-xscrollcommand** für Details). Sie unterstützen außerdem Scannen, wie unten beschrieben.

# VALIDIERUNG

Die Validierung funktioniert, indem **-validatecommand** auf ein Skript gesetzt wird, das gemäß **-validate** wie folgt ausgewertet wird:

**none**
: Standard. Es findet keine Validierung statt.

**focus**
: **-validatecommand** wird aufgerufen, wenn die Spinbox den Fokus erhält oder verliert.

**focusin**
: **-validatecommand** wird aufgerufen, wenn die Spinbox den Fokus erhält.

**focusout**
: **-validatecommand** wird aufgerufen, wenn die Spinbox den Fokus verliert.

**key**
: **-validatecommand** wird aufgerufen, wenn die Spinbox bearbeitet wird.

**all**
: **-validatecommand** wird bei allen obigen Bedingungen aufgerufen.


Auf **-validatecommand** und **-invalidcommand** sind Prozent-Substitutionen möglich, wie in einem **bind**-Skript. Folgende Substitutionen werden erkannt:

**%d**
: Art der Aktion: 1 für **insert**, 0 für **delete**, oder -1 für Fokus-, erzwungene oder **textvariable**-Validierung.

**%i**
: Index des einzufügenden/zu löschenden Zeichenstrings, falls vorhanden, sonst -1.

**%P**
: Der Wert der Spinbox, wenn die Bearbeitung erfolgen soll. Konfigurieren Sie die Spinbox mit einer neuen **textvariable**, ist dies der Wert dieser **textvariable**.

**%s**
: Der aktuelle Wert der Spinbox vor der Bearbeitung.

**%S**
: Der einzufügende/zu löschende Text-String, falls vorhanden, sonst ein leerer String.

**%v**
: Der Typ der aktuell gesetzten Validierung.

**%V**
: Der Typ der Validierung, die die Rückruffunktion ausgelöst hat (key, focusin, focusout, forced).

**%W**
: Der Name des Spinbox-Widgets.


Im Allgemeinen können **-textvariable** und **-validatecommand** problematisch kombiniert werden. Das wurde so gelöst, dass **-validatecommand** das traditionelle Verhalten der Spinbox nicht stört. **-textvariable** nur lesend zu verwenden, verursacht nie Probleme. Gefährlich wird es, wenn **-textvariable** auf etwas gesetzt wird, das **-validatecommand** nicht akzeptieren würde — dann wird **-validate** **none** (**-invalidcommand** wird nicht ausgelöst). Dasselbe passiert bei einem Fehler bei der Auswertung von **-validatecommand**.

Vor allem tritt ein Fehler auf, wenn **-validatecommand** oder **-invalidcommand** einen Fehler im Skript hat oder **-validatecommand** keinen gültigen Tcl-Boolean zurückgibt. **-validate** setzt sich auch auf **none**, wenn die Spinbox aus **-validatecommand** oder **-invalidcommand** bearbeitet wird. Solche Bearbeitungen überschreiben die gerade validierte. Soll der Wert während der Validierung geändert und **-validate** beibehalten werden, gehört in **-validatecommand** oder **-invalidcommand** (je nachdem, von wo aus bearbeitet wurde):

```
     %W config -validate %v
```

Es wird empfohlen, während der Validierung keine verknüpfte **-textvariable** zu setzen, da die Spinbox sonst aus dem Takt mit **-textvariable** geraten kann.

**-validate** setzt sich auch auf **none**, wenn sich der Spinbox-Wert durch Anpassung von **-from** oder **-to** ändert und **-validatecommand** false zurückgibt. Beispielsweise

```
     spinbox pathName -from 1 -to 10 -validate all -validatecommand {return 0}
```

setzt **-validate** tatsächlich auf **none**, weil sich der Standardwert der Spinbox (durch **-from** und **-to**) auf einen von der Validierung nicht akzeptierten Wert ändert.

Außerdem wird bei Betätigung eines Spin-Buttons erzwungene Validierung durchgeführt. Gibt das Validierungsskript in dieser Situation false zurück, wird **-validate** automatisch **none**.

# WIDGET-BEFEHL

Der Befehl **spinbox** erstellt einen neuen Tcl-Befehl mit dem Namen *pathName*. Dieser Befehl kann verschiedene Operationen am Widget aufrufen. Er hat die folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls.

## Indizes

Viele Widget-Befehle für Spinboxen nehmen einen oder mehrere Indizes als Argumente. Ein Index bezeichnet ein bestimmtes Zeichen im String der Spinbox, auf eine der folgenden Arten:

*number*
: Bezeichnet das Zeichen als numerischen Index, wobei 0 dem ersten Zeichen im String entspricht.

**anchor**
: Bezeichnet den Ankerpunkt für die Auswahl, der mit den Widget-Befehlen **select from** und **select adjust** gesetzt wird.

**end**
: Bezeichnet das Zeichen unmittelbar nach dem letzten im String der Spinbox. Entspricht einem numerischen Index gleich der Länge des Spinbox-Strings.

**insert**
: Bezeichnet das Zeichen neben und unmittelbar nach dem Einfügecursor.

**sel.first**
: Bezeichnet das erste Zeichen in der Auswahl. Es ist ein Fehler, diese Form zu verwenden, wenn die Auswahl nicht im Spinbox-Fenster liegt.

**sel.last**
: Bezeichnet das Zeichen unmittelbar nach dem letzten in der Auswahl. Es ist ein Fehler, diese Form zu verwenden, wenn die Auswahl nicht im Spinbox-Fenster liegt.

**@**_number_
: In dieser Form wird *number* als x-Koordinate im Fenster der Spinbox behandelt; das Zeichen, das diese x-Koordinate überspannt, wird verwendet. Beispielsweise bezeichnet „**@0**“ das linkeste Zeichen im Fenster. Abkürzungen können für jede der obigen Formen verwendet werden, z. B. „**e**“ oder „**sel.f**“. Im Allgemeinen werden Indizes außerhalb des gültigen Bereichs automatisch auf den nächsten zulässigen Wert gerundet. Indizes unterstützen dieselbe einfache Interpretation wie beim Befehl **string index**, mit einfacher ganzzahliger Index-Arithmetik und Indizierung relativ zu **end**.


## Unterbefehle

Folgende Befehle sind für Spinbox-Widgets möglich:

*pathName* **bbox** *index*
: Gibt eine Liste von vier Zahlen zurück, die die Begrenzungsbox des durch *index* angegebenen Zeichens beschreiben. Die ersten beiden Elemente der Liste geben die x- und y-Koordinaten der oberen linken Ecke des vom Zeichen bedeckten Bildschirmbereichs an (in Pixeln relativ zum Widget), die letzten beiden geben Breite und Höhe des Zeichens in Pixeln an. Die Begrenzungsbox kann sich auf einen Bereich außerhalb des sichtbaren Fensterbereichs beziehen.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der Konfigurationsoption *option* zurück. *Option* kann jeden von **spinbox** akzeptierten Wert haben.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Ist keine *option* angegeben, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (Format siehe **Tk_ConfigureInfo**). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (identisch mit dem entsprechenden Teilliste der Rückgabe ohne *option*). Sind ein oder mehr *option-value*-Paare angegeben, setzt der Befehl die angegebenen Widget-Optionen auf die angegebenen Werte; in diesem Fall gibt er den leeren String zurück. *Option* kann jeden von **spinbox** akzeptierten Wert haben.

*pathName* **delete** *first* ?*last*?
: Löscht ein oder mehrere Elemente der Spinbox. *First* ist der Index des ersten zu löschenden Zeichens, *last* der Index des Zeichens unmittelbar nach dem letzten zu löschenden. Ist *last* nicht angegeben, entspricht es *first*+1, d. h. es wird ein einzelnes Zeichen gelöscht. Dieser Befehl gibt den leeren String zurück.

*pathName* **get**
: Gibt den String der Spinbox zurück.

*pathName* **icursor** *index*
: Sorgt dafür, dass der Einfügecursor unmittelbar vor dem durch *index* gegebenen Zeichen angezeigt wird. Gibt einen leeren String zurück.

*pathName* **identify** *x y*
: Gibt den Namen des Fensterelements zurück, das den Koordinaten *x* und *y* in der Spinbox entspricht. Rückgabewert ist einer von: **none**, **buttondown**, **buttonup**, **entry**.

*pathName* **index** *index*
: Gibt den numerischen Index zurück, der *index* entspricht.

*pathName* **insert** *index string*
: Fügt die Zeichen von *string* unmittelbar vor dem durch *index* angegebenen Zeichen ein. Gibt einen leeren String zurück.

*pathName* **invoke** *element*
: Löst das angegebene Element, entweder **buttondown** oder **buttonup**, aus und löst die damit verbundene Aktion aus.

*pathName* **scan** *option args*
: Dieser Befehl implementiert Scannen auf Spinboxen. Er hat zwei Formen, abhängig von *option*:

*pathName* **scan mark** *x*
: Merkt sich *x* und die aktuelle Ansicht im Spinbox-Fenster; wird zusammen mit späteren **scan dragto**-Befehlen verwendet. Typischerweise ist dieser Befehl mit einem Mausklick im Widget verknüpft. Gibt den leeren String zurück.

*pathName* **scan dragto** *x*
: Dieser Befehl berechnet die Differenz zwischen seinem *x*-Argument und dem *x*-Argument des letzten **scan mark**-Befehls für das Widget. Anschließend passt er die Ansicht um das 10-fache der x-Koordinatendifferenz nach links oder rechts an. Dieser Befehl ist typischerweise mit Mausbewegungsereignissen im Widget verknüpft, um den Effekt zu erzeugen, die Spinbox mit hoher Geschwindigkeit durch das Fenster zu ziehen. Der Rückgabewert ist ein leerer String.


*pathName* **selection** *option arg*
: Dieser Befehl passt die Auswahl innerhalb einer Spinbox an. Er hat mehrere Formen, abhängig von *option*:

*pathName* **selection adjust** *index*
: Findet das Ende der Auswahl, das *index* am nächsten liegt, und passt dieses Ende so an, dass es bei *index* liegt (d. h. einschließlich, aber nicht über *index* hinaus). Das andere Ende der Auswahl wird zum Ankerpunkt für künftige **select to**-Befehle. Liegt die Auswahl derzeit nicht in der Spinbox, wird eine neue Auswahl erstellt, die die Zeichen zwischen *index* und dem zuletzt gesetzten Auswahl-Ankerpunkt einschließt. Gibt den leeren String zurück.

*pathName* **selection clear**
: Löscht die Auswahl, wenn sie derzeit in diesem Widget liegt. Liegt die Auswahl nicht in diesem Widget, hat der Befehl keine Wirkung. Gibt einen leeren String zurück.

*pathName* **selection element** ?*element*?
: Setzt oder fragt das aktuell ausgewählte Element ab. Ist ein Spin-Button-Element angegeben, wird es gedrückt dargestellt.

*pathName* **selection from** *index*
: Setzt den Auswahl-Ankerpunkt unmittelbar vor das durch *index* gegebene Zeichen. Ändert die Auswahl nicht. Gibt einen leeren String zurück.

*pathName* **selection present**
: Gibt 1 zurück, wenn in der Spinbox Zeichen ausgewählt sind, 0 wenn nichts ausgewählt ist.

*pathName* **selection range** *start end*
: Setzt die Auswahl so, dass sie die Zeichen ab dem durch *start* indizierten bis einschließlich dem unmittelbar vor *end* umfasst. Bezieht sich *end* auf dasselbe Zeichen wie *start* oder ein früheres, wird die Auswahl in der Spinbox gelöscht.

*pathName* **selection to** *index*
: Liegt *index* vor dem Ankerpunkt, wird die Auswahl auf die Zeichen von *index* bis vor den Ankerpunkt gesetzt. Ist *index* gleich dem Ankerpunkt, geschieht nichts. Liegt *index* nach dem Ankerpunkt, wird die Auswahl auf die Zeichen vom Ankerpunkt bis vor *index* gesetzt. Der Ankerpunkt wird durch den zuletzt in diesem Widget ausgeführten Befehl **select from** oder **select adjust** bestimmt. Liegt die Auswahl nicht in diesem Widget, wird eine neue Auswahl mit dem zuletzt für das Widget angegebenen Ankerpunkt erstellt. Gibt einen leeren String zurück.


*pathName* **set** ?*string*?
: Ist *string* angegeben, versucht die Spinbox, diesen Wert zu setzen, andernfalls gibt sie einfach den String der Spinbox zurück. Ist die Validierung aktiv, erfolgt sie beim Setzen des Strings.

*pathName* **validate**
: Dieser Befehl erzwingt eine Auswertung von **-validatecommand** unabhängig von den durch die Option **-validate** festgelegten Bedingungen. Dazu wird **-validate** vorübergehend auf **all** gesetzt. Er gibt 0 oder 1 zurück.

*pathName* **xview** *args*
: Dieser Befehl fragt die horizontale Position des Texts im Fenster des Widgets ab und ändert sie. Er kann eine der folgenden Formen haben:

*pathName* **xview**
: Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruchteil zwischen 0 und 1; zusammen beschreiben sie den horizontal sichtbaren Bereich im Fenster. Beispielsweise bedeuten die Elemente .2 und .6, dass 20 % des Spinbox-Texts links außerhalb des Bildschirms liegen, die mittleren 40 % im Fenster sichtbar sind und 40 % rechts außerhalb. Dies sind dieselben Werte, die Scrollbars über die Option **-xscrollcommand** übergeben werden.

*pathName* **xview** *index*
: Passt die Ansicht im Fenster so an, dass das durch *index* gegebene Zeichen am linken Rand des Fensters angezeigt wird.

*pathName* **xview moveto** *fraction*
: Passt die Ansicht im Fenster so an, dass das Zeichen *fraction* des Weges durch den Text am linken Rand des Fensters erscheint. *Fraction* muss ein Bruchteil zwischen 0 und 1 sein.

*pathName* **xview scroll** *number what*
: Dieser Befehl verschiebt die Ansicht im Fenster nach links oder rechts gemäß *number* und *what*. *Number* muss eine Ganzzahl oder eine Fließkommazahl sein; ist es eine Fließkommazahl, wird sie in eine Ganzzahl umgewandelt, von 0 weg gerundet. *What* muss **pages** oder **units** oder eine Abkürzung davon sein. Ist *what* **pages**, passt sich die Ansicht um *number* Bildschirmseiten an. Ist *number* negativ, werden Zeichen weiter links sichtbar; ist es positiv, werden Zeichen weiter rechts sichtbar. Ist *what* **units**, verschiebt sich die Ansicht um *number* Zeichen durchschnittlicher Breite auf der Anzeige nach links oder rechts.



# BINDINGS

Tk erstellt automatisch Klassen-Bindings für Spinboxen, die ihnen folgendes Standardverhalten geben. In den Beschreibungen unten bezeichnet „Wort“ eine zusammenhängende Gruppe aus Buchstaben, Ziffern oder „_“-Zeichen oder ein einzelnes anderes Zeichen.

1. Ein Klick mit Maustaste 1 positioniert den Einfügecursor unmittelbar vor dem Zeichen unter dem Mauszeiger, setzt den Eingabefokus auf dieses Widget und löscht jede Auswahl im Widget. Ziehen mit Maustaste 1 erzeugt eine Auswahl zwischen Einfügecursor und dem Zeichen unter der Maus.

2. Doppelklick mit Maustaste 1 wählt das Wort unter der Maus aus und positioniert den Einfügecursor am Anfang des Worts. Ziehen nach einem Doppelklick erzeugt eine Auswahl aus ganzen Wörtern.

3. Dreifachklick mit Maustaste 1 wählt den gesamten Text in der Spinbox aus und positioniert den Einfügecursor vor dem ersten Zeichen.

4. Die Enden der Auswahl können durch Ziehen mit Maustaste 1 bei gedrückter Umschalttaste angepasst werden; dabei wird das Ende der Auswahl angepasst, das dem Mauszeiger beim Drücken von Taste 1 am nächsten war. Wurde vor dem Ziehen doppelgeklickt, wird die Auswahl in Einheiten ganzer Wörter angepasst.

5. Klick mit Maustaste 1 bei gedrückter Steuerung positioniert den Einfügecursor in der Spinbox, ohne die Auswahl zu beeinflussen.

6. Werden normale druckbare Zeichen in einer Spinbox eingegeben, werden sie an der Position des Einfügecursors eingefügt.

7. Die Ansicht in der Spinbox kann durch Ziehen mit der mittleren Maustaste (Taste 2, oder Taste 3 unter TkAqua) angepasst werden. Wird die mittlere Maustaste ohne Mausbewegung geklickt, wird die Auswahl an der Mausposition in die Spinbox kopiert.

8. Wird die Maus beim Gedrückthalten von Taste 1 links oder rechts aus der Spinbox gezogen, scrollt die Spinbox automatisch, um mehr Text sichtbar zu machen (falls auf der Seite, auf der die Maus das Fenster verließ, noch Text außerhalb des Bildschirms liegt).

9. Die Tasten Links und Rechts bewegen den Einfügecursor um ein Zeichen nach links oder rechts; sie löschen außerdem jede Auswahl in der Spinbox und setzen den Auswahl-Anker. Wird Links oder Rechts mit gedrückter Umschalttaste eingegeben, bewegt sich der Einfügecursor und die Auswahl wird um das neue Zeichen erweitert. Steuerung-Links und Steuerung-Rechts bewegen den Einfügecursor wortweise; Steuerung-Umschalt-Links und Steuerung-Umschalt-Rechts bewegen ihn wortweise und erweitern die Auswahl. Steuerung-b und Steuerung-f verhalten sich wie Links bzw. Rechts. Meta-b und Meta-f verhalten sich wie Steuerung-Links bzw. Steuerung-Rechts.

10. Die Pos1-Taste oder Steuerung-a bewegt den Einfügecursor an den Anfang der Spinbox und löscht jede Auswahl. Umschalt-Pos1 bewegt den Einfügecursor an den Anfang und erweitert die Auswahl bis dorthin.

11. Die Ende-Taste oder Steuerung-e bewegt den Einfügecursor ans Ende der Spinbox und löscht jede Auswahl. Umschalt-Ende bewegt den Cursor ans Ende und erweitert die Auswahl bis dorthin.

12. Die Select-Taste und Steuerung-Leertaste setzen den Auswahl-Anker auf die Position des Einfügecursors. Sie beeinflussen die aktuelle Auswahl nicht. Umschalt-Select und Steuerung-Umschalt-Leertaste passen die Auswahl an die aktuelle Position des Einfügecursors an und wählen vom Anker bis zum Einfügecursor, falls zuvor keine Auswahl bestand.

13. Steuerung-/ wählt den gesamten Text in der Spinbox aus.

14. Steuerung-\ löscht jede Auswahl in der Spinbox.

15. Die F16-Taste (auf vielen Sun-Arbeitsplätzen mit Copy beschriftet) oder Meta-w kopiert die Auswahl im Widget in die Zwischenablage, falls eine Auswahl besteht.

16. Die F20-Taste (auf vielen Sun-Arbeitsplätzen mit Cut beschriftet) oder Steuerung-w kopiert die Auswahl in die Zwischenablage und löscht sie. Gibt es keine Auswahl im Widget, haben diese Tasten keine Wirkung.

17. Die F18-Taste (auf vielen Sun-Arbeitsplätzen mit Paste beschriftet) oder Steuerung-y fügt den Inhalt der Zwischenablage an der Position des Einfügecursors ein.

18. Die Entf-Taste löscht die Auswahl, falls eine in der Spinbox besteht. Gibt es keine Auswahl, löscht sie das Zeichen rechts vom Einfügecursor.

19. Die Rücktaste und Steuerung-h löschen die Auswahl, falls eine in der Spinbox besteht. Gibt es keine Auswahl, löschen sie das Zeichen links vom Einfügecursor.

20. Steuerung-d löscht das Zeichen rechts vom Einfügecursor.

21. Meta-d löscht das Wort rechts vom Einfügecursor.

22. Steuerung-k löscht alle Zeichen rechts vom Einfügecursor.

23. Steuerung-t kehrt die Reihenfolge der beiden Zeichen rechts vom Einfügecursor um.


Ist die Spinbox mit der Option **-state** deaktiviert, kann die Ansicht der Spinbox weiterhin angepasst und Text in der Spinbox weiterhin ausgewählt werden, aber es wird kein Einfügecursor angezeigt und es finden keine Textänderungen statt.

Das Verhalten von Spinboxen kann geändert werden, indem neue Bindings für einzelne Widgets definiert oder die Klassen-Bindings neu definiert werden.
