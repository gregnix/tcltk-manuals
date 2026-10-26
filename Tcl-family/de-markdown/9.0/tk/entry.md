---
CommandName: entry
ManualSection: n
Version: 8.3
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::entry(n)
Keywords:
 - entry
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 1998-2000 Scriptics Corporation.
---

# NAME

entry - Erstellt und manipuliert 'Entry'-Einzeilige-Text-Eingabe-Widgets

# ÜBERSICHT

::: {.synopsis} :::
[entry]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# WIDGET-SPEZIFISCHE OPTIONEN

**-disabledbackground** (disabledBackground/DisabledBackground)
: Legt die Hintergrundfarbe fest, die verwendet wird, wenn das Entry deaktiviert ist. Wenn diese Option der leere String ist, wird die normale Hintergrundfarbe verwendet.

**-disabledforeground** (disabledForeground/DisabledForeground)
: Legt die Vordergrundfarbe fest, die verwendet wird, wenn das Entry deaktiviert ist. Wenn diese Option der leere String ist, wird die normale Vordergrundfarbe verwendet.

**-invalidcommand**, **-invcmd** (invalidCommand/InvalidCommand)
: Legt ein Script fest, das ausgeführt wird, wenn **-validatecommand** 0 zurückgibt. Das Setzen auf {} deaktiviert diese Funktion (Standard). Die beste Verwendung dieser Option ist, sie auf *bell* zu setzen. Siehe **VALIDIERUNG** unten für weitere Informationen.

**-readonlybackground** (readonlyBackground/ReadonlyBackground)
: Legt die Hintergrundfarbe fest, die verwendet wird, wenn das Entry schreibgeschützt ist. Wenn diese Option der leere String ist, wird die normale Hintergrundfarbe verwendet.

**-show** (show/Show)
: Wenn diese Option angegeben ist, wird der wahre Inhalt des Entrys nicht im Fenster angezeigt. Stattdessen wird jedes Zeichen im Wert des Entrys als das erste Zeichen im Wert dieser Option angezeigt, wie z.B. "*". Dies ist nützlich, wenn das Entry beispielsweise zur Eingabe eines Passworts verwendet werden soll. Wenn Zeichen im Entry ausgewählt und anderswo kopiert werden, werden die angezeigten Informationen kopiert, nicht der wahre Inhalt des Entrys.

**-state** (state/State)
: Legt einen von drei Zuständen für das Entry fest: **normal**, **disabled** oder **readonly**. Wenn das Entry schreibgeschützt ist, kann der Wert nicht mit Widget-Befehlen geändert werden und es wird kein Einfügecursor angezeigt, auch wenn der Eingabefokus im Widget ist; der Inhalt des Widgets kann weiterhin ausgewählt werden. Wenn das Entry deaktiviert ist, kann der Wert nicht geändert werden, es wird kein Einfügecursor angezeigt, der Inhalt ist nicht auswählbar, und das Entry kann in einer anderen Farbe angezeigt werden, abhängig von den Werten der Optionen **-disabledforeground** und **-disabledbackground**.

**-validate** (validate/Validate)
: Legt den Modus fest, in dem die Validierung arbeiten soll: **none**, **focus**, **focusin**, **focusout**, **key** oder **all**. Der Standard ist **none**. Wenn Sie Validierung wünschen, müssen Sie explizit angeben, welchen Modus Sie verwenden möchten. Siehe **VALIDIERUNG** unten für weitere Informationen.

**-validatecommand**, **-vcmd** (validateCommand/ValidateCommand)
: Legt ein Script fest, das ausgeführt wird, wenn Sie die Eingabe in das Entry-Widget validieren möchten. Das Setzen auf {} deaktiviert diese Funktion (Standard). Dieser Befehl muss einen gültigen Tcl-Boolean-Wert zurückgeben. Wenn er 0 zurückgibt (oder das gültige Tcl-Boolean-Äquivalent), bedeutet dies, dass Sie die neue Bearbeitung ablehnen und sie nicht erfolgt und das **-invalidcommand** ausgewertet wird, falls gesetzt. Wenn er 1 zurückgibt, erfolgt die neue Bearbeitung. Siehe **VALIDIERUNG** unten für weitere Informationen.

**-width** (width/Width)
: Legt einen ganzzahligen Wert fest, der die gewünschte Breite des Entry-Fensters angibt, in Zeichen durchschnittlicher Größe der Schriftart des Widgets. Wenn der Wert negativ oder null ist, wählt das Widget eine Größe, die gerade groß genug ist, um seinen aktuellen Text zu halten.


# BESCHREIBUNG

Der Befehl **entry** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Entry-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Entrys wie Farben, Schriftart und Relief zu konfigurieren. Der Befehl **entry** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Ein Entry ist ein Widget, das einen einzeiligen Text-String anzeigt und es erlaubt, diesen String mit unten beschriebenen Widget-Befehlen zu bearbeiten, die typischerweise an Tastendrücke und Mausaktionen gebunden sind. Wenn es erstellt wird, ist der String des Entrys leer. Ein Teil des Entrys kann wie unten beschrieben ausgewählt werden. Wenn ein Entry seine Auswahl exportiert (siehe die Option **-exportselection**), beachtet es die Standard-X11-Protokolle für die Behandlung der Auswahl; Entry-Auswahlen sind als Typ **STRING** verfügbar. Entrys beachten auch die Standard-Tk-Regeln für den Umgang mit dem Eingabefokus. Wenn ein Entry den Eingabefokus hat, zeigt es einen *Einfügecursor* an, um anzuzeigen, wo neue Zeichen eingefügt werden.

Entrys können Strings anzeigen, die zu lang sind, um vollständig in das Fenster des Widgets zu passen. In diesem Fall wird nur ein Teil des Strings angezeigt; unten beschriebene Befehle können verwendet werden, um die Ansicht im Fenster zu ändern. Entrys verwenden den Standard-Mechanismus **-xscrollcommand** für die Interaktion mit Scrollbars (siehe die Beschreibung der Option **-xscrollcommand** für Details). Sie unterstützen auch das Scannen, wie unten beschrieben.

# VALIDIERUNG

Die Validierung funktioniert, indem die Option **-validatecommand** auf ein Script (*validateCommand*) gesetzt wird, das gemäß der Option **-validate** wie folgt ausgewertet wird:

**none**
: Standard. Es findet keine Validierung statt.

**focus**
: *validateCommand* wird aufgerufen, wenn das Entry den Fokus erhält oder verliert.

**focusin**
: *validateCommand* wird aufgerufen, wenn das Entry den Fokus erhält.

**focusout**
: *validateCommand* wird aufgerufen, wenn das Entry den Fokus verliert.

**key**
: *validateCommand* wird aufgerufen, wenn das Entry bearbeitet wird.

**all**
: *validateCommand* wird bei allen obigen Bedingungen aufgerufen.


Es ist möglich, Prozent-Substitutionen auf den Werten der Optionen **-validatecommand** und **-invalidcommand** durchzuführen, genau wie in einem **bind**-Script. Folgende Substitutionen werden erkannt:

**%d**
: Art der Aktion: 1 für **insert**, 0 für **delete** oder -1 für Fokus-, erzwungene oder **textvariable**-Validierung.

**%i**
: Index des einzufügenden/zu löschenden Zeichenstrings, falls vorhanden, sonst -1.

**%P**
: Der Wert des Entrys, wenn die Bearbeitung erlaubt ist. Wenn Sie das Entry-Widget mit einer neuen **textvariable** konfigurieren, ist dies der Wert dieser **textvariable**.

**%s**
: Der aktuelle Wert des Entrys vor der Bearbeitung.

**%S**
: Der einzufügende/zu löschende Textstring, falls vorhanden, sonst {}.

**%v**
: Der Typ der aktuell gesetzten Validierung.

**%V**
: Der Typ der Validierung, die die Rückruffunktion ausgelöst hat (key, focusin, focusout, forced).

**%W**
: Der Name des Entry-Widgets.


Im Allgemeinen können die Optionen **-textvariable** und **-validatecommand** problematisch sein, wenn sie gemischt werden. Alle Probleme wurden behoben, sodass die Verwendung von **-validatecommand** das traditionelle Verhalten des Entry-Widgets nicht stört. Die Verwendung von **-textvariable** nur zu Lesezwecken verursacht nie Probleme. Die Gefahr entsteht, wenn Sie versuchen, **-textvariable** auf etwas zu setzen, was **-validatecommand** nicht akzeptieren würde; dadurch wird **-validate** auf *none* gesetzt (**-invalidcommand** wird nicht ausgelöst). Dasselbe geschieht, wenn beim Auswerten von **-validatecommand** ein Fehler auftritt.

Vor allem tritt ein Fehler auf, wenn **-validatecommand** oder **-invalidcommand** beim Auswerten einen Fehler in seinem Script hat oder **-validatecommand** keinen gültigen Tcl-Boolean-Wert zurückgibt. Die Option **-validate** setzt sich außerdem auf **none**, wenn Sie das Entry-Widget innerhalb von **-validatecommand** oder **-invalidcommand** bearbeiten. Solche Bearbeitungen überschreiben die gerade validierte. Wenn Sie das Entry-Widget während der Validierung bearbeiten möchten (z. B. auf {} setzen) und die Option **-validate** gesetzt bleiben soll, sollten Sie den Befehl

```
after idle {%W config -validate %v}
```

in **-validatecommand** oder **-invalidcommand** (je nachdem, von welchem aus Sie das Entry bearbeitet haben) aufnehmen. Es wird auch empfohlen, während der Validierung keine zugehörige **-textvariable** zu setzen, da das Entry-Widget sonst aus dem Takt mit **-textvariable** geraten kann.

# WIDGET-BEFEHL

Der Befehl **entry** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName subcommand ?arg ...?
```

*Subcommand* und die *arg*s bestimmen das genaue Verhalten des Befehls.

## INDIZES

Viele Widget-Befehle für Entrys nehmen einen oder mehrere Indizes als Argumente. Ein Index bezeichnet ein bestimmtes Zeichen im String des Entrys, auf eine der folgenden Arten:

*number*
: Bezeichnet das Zeichen als numerischen Index, wobei 0 dem ersten Zeichen im String entspricht.

**anchor**
: Bezeichnet den Ankerpunkt für die Auswahl, der mit den Widget-Befehlen **select from** und **select adjust** gesetzt wird.

**end**
: Bezeichnet das Zeichen unmittelbar nach dem letzten im String des Entrys. Entspricht einem numerischen Index gleich der Länge des Strings des Entrys.

**insert**
: Bezeichnet das Zeichen neben und unmittelbar nach dem Einfügecursor.

**sel.first**
: Bezeichnet das erste Zeichen in der Auswahl. Die Verwendung dieser Form ist ein Fehler, wenn die Auswahl nicht im Entry-Fenster liegt.

**sel.last**
: Bezeichnet das Zeichen unmittelbar nach dem letzten in der Auswahl. Die Verwendung dieser Form ist ein Fehler, wenn die Auswahl nicht im Entry-Fenster liegt.

**@**_number_
: In dieser Form wird *number* als x-Koordinate im Fenster des Entrys behandelt; das Zeichen, das diese x-Koordinate überspannt, wird verwendet. Beispielsweise bezeichnet "**@0**" das Zeichen ganz links im Fenster. Abkürzungen sind für alle obigen Formen möglich, z. B. "**e**" oder "**sel.f**". Im Allgemeinen werden außerhalb des gültigen Bereichs liegende Indizes automatisch auf den nächsten zulässigen Wert gerundet. Indizes unterstützen dieselbe einfache Interpretation wie beim Befehl **string index**, mit einfacher ganzzahliger Indexarithmetik und Indexierung relativ zu **end**.


## Unterbefehle

Folgende Befehle sind für Entry-Widgets möglich:

*pathName* **bbox** *index*
: Gibt eine Liste von vier Zahlen zurück, die die Begrenzungsbox des durch *index* angegebenen Zeichens beschreiben. Die ersten beiden Elemente der Liste geben die x- und y-Koordinaten der oberen linken Ecke des vom Zeichen bedeckten Bildschirmbereichs an (in Pixeln relativ zum Widget), die letzten beiden geben Breite und Höhe des Zeichens in Pixeln an. Die Begrenzungsbox kann sich auf einen Bereich außerhalb des sichtbaren Fensterbereichs beziehen.

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **entry** akzeptierten Werte haben.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe **Tk_ConfigureInfo** für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **entry** akzeptierten Werte haben.

*pathName* **delete** *first* ?*last*?
: Löscht ein oder mehrere Elemente des Entrys. *First* ist der Index des ersten zu löschenden Zeichens, *last* der Index des Zeichens unmittelbar nach dem letzten zu löschenden. Wenn *last* nicht angegeben ist, entspricht es *first*+1, d. h. es wird ein einzelnes Zeichen gelöscht. Dieser Befehl gibt einen leeren String zurück.

*pathName* **get**
: Gibt den String des Entrys zurück.

*pathName* **icursor** *index*
: Sorgt dafür, dass der Einfügecursor unmittelbar vor dem durch *index* gegebenen Zeichen angezeigt wird. Gibt einen leeren String zurück.

*pathName* **index** *index*
: Gibt den numerischen Index zurück, der *index* entspricht.

*pathName* **insert** *index string*
: Fügt die Zeichen von *string* unmittelbar vor dem durch *index* angegebenen Zeichen ein. Gibt einen leeren String zurück.

*pathName* **scan** *option args*
: Dieser Befehl implementiert das Scannen auf Entrys. Er hat zwei Formen, abhängig von *option*:

*pathName* **scan mark** *x*
: Speichert *x* und die aktuelle Ansicht im Entry-Fenster; wird zusammen mit späteren **scan dragto**-Befehlen verwendet. Typischerweise ist dieser Befehl mit einem Maustastendruck im Widget verknüpft. Er gibt einen leeren String zurück.

*pathName* **scan dragto** *x*
: Dieser Befehl berechnet die Differenz zwischen seinem *x*-Argument und dem *x*-Argument des letzten **scan mark**-Befehls für das Widget. Anschließend wird die Ansicht um das Zehnfache der Differenz der x-Koordinaten nach links oder rechts verschoben. Typischerweise ist dieser Befehl mit Mausbewegungs-Events im Widget verknüpft, um den Effekt zu erzeugen, das Entry mit hoher Geschwindigkeit durch das Fenster zu ziehen. Der Rückgabewert ist ein leerer String.


*pathName* **selection** *option arg*
: Dieser Befehl passt die Auswahl innerhalb eines Entrys an. Er hat mehrere Formen, abhängig von *option*:

*pathName* **selection adjust** *index*
: Findet das Ende der Auswahl, das dem durch *index* gegebenen Zeichen am nächsten liegt, und passt dieses Ende der Auswahl auf *index* an (d. h. einschließlich, aber nicht über *index* hinaus). Das andere Ende der Auswahl wird zum Ankerpunkt für zukünftige **select to**-Befehle. Befindet sich die Auswahl derzeit nicht im Entry, wird eine neue Auswahl erstellt, die die Zeichen zwischen *index* und dem zuletzt gesetzten Auswahl-Ankerpunkt einschließt. Gibt einen leeren String zurück.

*pathName* **selection clear**
: Löscht die Auswahl, wenn sie derzeit in diesem Widget liegt. Liegt die Auswahl nicht in diesem Widget, hat der Befehl keine Wirkung. Gibt einen leeren String zurück.

*pathName* **selection from** *index*
: Setzt den Auswahl-Ankerpunkt unmittelbar vor das durch *index* gegebene Zeichen. Ändert die Auswahl nicht. Gibt einen leeren String zurück.

*pathName* **selection present**
: Gibt 1 zurück, wenn im Entry Zeichen ausgewählt sind, 0 wenn nichts ausgewählt ist.

*pathName* **selection range** *start end*
: Setzt die Auswahl so, dass sie die Zeichen ab dem durch *start* indizierten bis vor dem durch *end* indizierten einschließt. Verweist *end* auf dasselbe Zeichen wie *start* oder ein früheres, wird die Auswahl des Entrys gelöscht.

*pathName* **selection to** *index*
: Liegt *index* vor dem Ankerpunkt, wird die Auswahl auf die Zeichen von *index* bis vor den Ankerpunkt gesetzt. Ist *index* gleich dem Ankerpunkt, geschieht nichts. Liegt *index* nach dem Ankerpunkt, wird die Auswahl auf die Zeichen vom Ankerpunkt bis vor *index* gesetzt. Der Ankerpunkt wird durch den zuletzt in diesem Widget ausgeführten Befehl **select from** oder **select adjust** bestimmt. Liegt die Auswahl nicht in diesem Widget, wird eine neue Auswahl mit dem zuletzt für das Widget angegebenen Ankerpunkt erstellt. Gibt einen leeren String zurück.


*pathName* **validate**
: Dieser Befehl erzwingt eine Auswertung von **-validatecommand** unabhängig von den durch die Option **-validate** festgelegten Bedingungen. Dazu wird **-validate** vorübergehend auf **all** gesetzt. Er gibt 0 oder 1 zurück.

*pathName* **xview** *args*
: Dieser Befehl fragt die horizontale Position des Texts im Fenster des Widgets ab und ändert sie. Er kann eine der folgenden Formen haben:

*pathName* **xview**
: Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruchteil zwischen 0 und 1; zusammen beschreiben sie den horizontal sichtbaren Bereich im Fenster. Beispielsweise bedeuten die Elemente .2 und .6, dass 20 % des Entry-Texts links außerhalb des Bildschirms liegen, die mittleren 40 % im Fenster sichtbar sind und 40 % rechts außerhalb. Dies sind dieselben Werte, die Scrollbars über die Option **-xscrollcommand** übergeben werden.

*pathName* **xview** *index*
: Passt die Ansicht im Fenster so an, dass das durch *index* gegebene Zeichen am linken Rand des Fensters angezeigt wird.

*pathName* **xview moveto** *fraction*
: Passt die Ansicht im Fenster so an, dass das Zeichen *fraction* des Weges durch den Text am linken Rand des Fensters erscheint. *Fraction* muss ein Bruchteil zwischen 0 und 1 sein.

*pathName* **xview scroll** *number what*
: Dieser Befehl verschiebt die Ansicht im Fenster nach links oder rechts gemäß *number* und *what*. *Number* muss eine Ganzzahl oder eine Fließkommazahl sein; ist es eine Fließkommazahl, wird sie in eine Ganzzahl umgewandelt, von 0 weg gerundet. *What* muss **pages** oder **units** oder eine Abkürzung davon sein. Ist *what* **pages**, passt sich die Ansicht um *number* Bildschirmseiten an. Ist *number* negativ, werden Zeichen weiter links sichtbar; ist es positiv, werden Zeichen weiter rechts sichtbar. Ist *what* **units**, verschiebt sich die Ansicht um *number* Zeichen durchschnittlicher Breite auf der Anzeige nach links oder rechts.



# STANDARD-BINDINGS

Tk erstellt automatisch Klassen-Bindings für Entrys, die ihnen folgendes Standardverhalten geben. In den Beschreibungen unten bezeichnet „Wort“ eine zusammenhängende Gruppe aus Buchstaben, Ziffern oder „_“-Zeichen oder ein einzelnes anderes Zeichen.

1. Ein Klick mit Maustaste 1 positioniert den Einfügecursor unmittelbar vor dem Zeichen unter dem Mauszeiger, setzt den Eingabefokus auf dieses Widget und löscht jede Auswahl im Widget. Ziehen mit Maustaste 1 erzeugt eine Auswahl zwischen Einfügecursor und dem Zeichen unter der Maus.

2. Doppelklick mit Maustaste 1 wählt das Wort unter der Maus aus und positioniert den Einfügecursor am Ende des Worts. Ziehen nach einem Doppelklick erzeugt eine Auswahl aus ganzen Wörtern.

3. Dreifachklick mit Maustaste 1 wählt den gesamten Text im Entry aus und positioniert den Einfügecursor am Zeilenende.

4. Die Enden der Auswahl können durch Ziehen mit Maustaste 1 bei gedrückter Umschalttaste angepasst werden; dabei wird das Ende der Auswahl angepasst, das dem Mauszeiger beim Drücken von Taste 1 am nächsten war. Wurde vor dem Ziehen doppelgeklickt, wird die Auswahl in Einheiten ganzer Wörter angepasst.

5. Klick mit Maustaste 1 bei gedrückter Steuerung positioniert den Einfügecursor im Entry, ohne die Auswahl zu beeinflussen.

6. Werden normale druckbare Zeichen in einem Entry eingegeben, werden sie an der Position des Einfügecursors eingefügt.

7. Die Ansicht im Entry kann durch Ziehen mit der mittleren Maustaste (Taste 2, oder Taste 3 unter TkAqua) angepasst werden. Wird die mittlere Maustaste ohne Mausbewegung geklickt, wird die Auswahl an der Mausposition in das Entry kopiert.

8. Wird die Maus beim Gedrückthalten von Taste 1 links oder rechts aus dem Entry gezogen, scrollt das Entry automatisch, um mehr Text sichtbar zu machen (falls auf der Seite, auf der die Maus das Fenster verließ, noch Text außerhalb des Bildschirms liegt).

9. Die Tasten Links und Rechts bewegen den Einfügecursor um ein Zeichen nach links oder rechts; sie löschen außerdem jede Auswahl im Entry und setzen den Auswahl-Anker. Wird Links oder Rechts mit gedrückter Umschalttaste eingegeben, bewegt sich der Einfügecursor und die Auswahl wird um das neue Zeichen erweitert. Steuerung-Links und Steuerung-Rechts bewegen den Einfügecursor wortweise; Steuerung-Umschalt-Links und Steuerung-Umschalt-Rechts bewegen ihn wortweise und erweitern die Auswahl. Steuerung-b und Steuerung-f verhalten sich wie Links bzw. Rechts. Meta-b und Meta-f verhalten sich wie Steuerung-Links bzw. Steuerung-Rechts.

10. Die Pos1-Taste oder Steuerung-a bewegt den Einfügecursor an den Anfang des Entrys und löscht jede Auswahl. Umschalt-Pos1 bewegt den Einfügecursor an den Anfang und erweitert die Auswahl bis dorthin.

11. Die Ende-Taste oder Steuerung-e bewegt den Einfügecursor ans Ende des Entrys und löscht jede Auswahl. Umschalt-Ende bewegt den Cursor ans Ende und erweitert die Auswahl bis dorthin.

12. Die Select-Taste und Steuerung-Leertaste setzen den Auswahl-Anker auf die Position des Einfügecursors. Sie beeinflussen die aktuelle Auswahl nicht. Umschalt-Select und Steuerung-Umschalt-Leertaste passen die Auswahl an die aktuelle Position des Einfügecursors an und wählen vom Anker bis zum Einfügecursor, falls zuvor keine Auswahl bestand.

13. Steuerung-/ wählt den gesamten Text im Entry aus.

14. Steuerung-\\ löscht jede Auswahl im Entry.

15. Die F16-Taste (auf vielen Sun-Arbeitsplätzen mit Copy beschriftet) oder Meta-w kopiert die Auswahl im Widget in die Zwischenablage, falls eine Auswahl besteht.

16. Die F20-Taste (auf vielen Sun-Arbeitsplätzen mit Cut beschriftet) oder Steuerung-w kopiert die Auswahl in die Zwischenablage und löscht sie. Gibt es keine Auswahl im Widget, haben diese Tasten keine Wirkung.

17. Die F18-Taste (auf vielen Sun-Arbeitsplätzen mit Paste beschriftet) oder Steuerung-y fügt den Inhalt der Zwischenablage an der Position des Einfügecursors ein.

18. Die Entf-Taste löscht die Auswahl, falls eine im Entry besteht. Gibt es keine Auswahl, löscht sie das Zeichen rechts vom Einfügecursor.

19. Die Rücktaste und Steuerung-h löschen die Auswahl, falls eine im Entry besteht. Gibt es keine Auswahl, löschen sie das Zeichen links vom Einfügecursor.

20. Steuerung-d löscht das Zeichen rechts vom Einfügecursor.

21. Meta-d löscht das Wort rechts vom Einfügecursor.

22. Steuerung-k löscht alle Zeichen rechts vom Einfügecursor.

23. Steuerung-t kehrt die Reihenfolge der beiden Zeichen rechts vom Einfügecursor um.


Ist das Entry mit der Option **-state** deaktiviert, kann die Ansicht des Entrys weiterhin angepasst und Text im Entry weiterhin ausgewählt werden, aber es wird kein Einfügecursor angezeigt und es finden keine Textänderungen statt, außer wenn das Entry über die Option **-textvariable** mit einer Variable verknüpft ist; in diesem Fall spiegelt das Entry jede Änderung der Variable wider, unabhängig vom Wert seiner Option **-state**.

Das Verhalten von Entrys kann geändert werden, indem neue Bindings für einzelne Widgets definiert oder die Klassen-Bindings neu definiert werden.

