---
CommandName: event
ManualSection: n
Version: 8.3
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
Keywords:
 - event
 - binding
 - define
 - handle
 - virtual event
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
 - Copyright (c) 1998-2000 Ajuba Solutions.
---

# NAME

event - Verschiedene Ereignisfunktionen: virtuelle Ereignisse definieren und Ereignisse erzeugen

# ÜBERSICHT

::: {.synopsis} :::
[event]{.cmd} [option]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **event** bietet mehrere Einrichtungen zum Umgang mit Fenstersystem-Ereignissen, etwa zum Definieren virtueller Ereignisse und zum Synthetisieren von Ereignissen. Der Befehl hat mehrere Formen, die durch das erste Argument bestimmt werden. Derzeit werden folgende Formen unterstützt:

**event add <<**_virtual_**>>** *sequence* ?*sequence ...*?
: Ordnet dem virtuellen Ereignis *virtual* die physischen Ereignissequenz(en) zu, die durch die Argumente *sequence* angegeben werden, sodass das virtuelle Ereignis ausgelöst wird, sobald eine der *sequence*s auftritt. *Virtual* kann ein beliebiger Zeichenkettenwert sein und *sequence* kann jeden der für das Argument *sequence* des Befehls **bind** zulässigen Werte haben. Ist *virtual* bereits definiert, werden die neuen physischen Ereignissequenzen zu den bestehenden Sequenzen für das Ereignis hinzugefügt.

**event delete <<**_virtual_**>>** ?*sequence* *sequence ...*?
: Löscht jede der *sequence*s aus denen, die mit dem virtuellen Ereignis *virtual* verknüpft sind. *Virtual* kann ein beliebiger Zeichenkettenwert sein und *sequence* kann jeden der für das Argument *sequence* des Befehls **bind** zulässigen Werte haben. *sequence*s, die derzeit nicht mit *virtual* verknüpft sind, werden ignoriert. Wird kein Argument *sequence* angegeben, werden alle physischen Ereignissequenzen für *virtual* entfernt, sodass das virtuelle Ereignis nicht mehr ausgelöst wird.

**event generate** *window event* ?*option value option value ...*?
: Erzeugt ein Fensterereignis und sorgt dafür, dass es genauso verarbeitet wird, als käme es vom Fenstersystem. *Window* gibt den Pfadnamen des Fensters an, für das das Ereignis erzeugt wird; es kann auch eine Kennung sein (wie von **winfo id** zurückgegeben), solange es ein Fenster der aktuellen Anwendung ist. *Event* liefert eine grundlegende Beschreibung des Ereignisses, etwa **<Shift-Button-2>** oder **<\<Paste>>**. Ist *Window* leer, ist der gesamte Bildschirm gemeint und die Koordinaten beziehen sich auf den Bildschirm. *Event* kann jede der für das Argument *sequence* des Befehls **bind** zulässigen Formen haben, muss aber aus genau einem Ereignismuster bestehen, nicht aus einer Sequenz. Paare *Option-Wert* können zusätzliche Attribute des Ereignisses angeben, etwa die x- und y-Position der Maus; siehe **EREIGNISFELDER** unten. Ist die Option **-when** nicht angegeben, wird das Ereignis sofort verarbeitet: alle Handler für das Ereignis werden abgeschlossen, bevor der Befehl **event generate** zurückkehrt. Ist die Option **-when** angegeben, legt sie fest, wann das Ereignis verarbeitet wird. Bestimmte Ereignisse, etwa Tastaturereignisse, erfordern, dass das Fenster den Fokus hat, um das Ereignis ordnungsgemäß zu empfangen.

**event info** ?**<<**_virtual_**>>**?
: Gibt Informationen über virtuelle Ereignisse zurück. Wird das Argument **<<***virtual***>>** weggelassen, ist der Rückgabewert eine Liste aller derzeit definierten virtuellen Ereignisse. Ist **<<***virtual***>>** angegeben, ist der Rückgabewert eine Liste, deren Elemente die für das angegebene virtuelle Ereignis derzeit definierten physischen Ereignissequenzen sind; ist das virtuelle Ereignis nicht definiert, wird eine leere Zeichenkette zurückgegeben.
    Beachten Sie, dass virtuelle Ereignisse, die nicht an physische Ereignissequenzen gebunden sind, von **event info** *nicht* zurückgegeben werden.


# EREIGNISFELDER

Die folgenden Optionen werden für den Befehl **event generate** unterstützt. Sie entsprechen den „%“-Ersetzungen, die in Bindungsskripten für den Befehl **bind** erlaubt sind.

**-above** *window*
: *Window* legt das Feld *above* für das Ereignis fest, entweder als Fensterpfadnamen oder als ganzzahlige Fensterkennung. Gültig für **Configure**-Ereignisse. Entspricht der **%a**-Ersetzung in Bindungsskripten.

**-borderwidth** *size*
: *Size* muss ein Bildschirmabstand sein; es legt das Feld *border_width* für das Ereignis fest. Gültig für **Configure**-Ereignisse. Entspricht der **%B**-Ersetzung in Bindungsskripten.

**-button** *number*
: *Number* muss eine ganze Zahl sein; es legt das Feld *detail* für ein **ButtonPress**- oder **ButtonRelease**-Ereignis fest und überschreibt jede im Basisargument *event* angegebene Tastennummer. Entspricht der **%b**-Ersetzung in Bindungsskripten.

**-count** *number*
: *Number* muss eine ganze Zahl sein; es legt das Feld *count* für das Ereignis fest. Gültig für **Expose**-Ereignisse. Entspricht der **%c**-Ersetzung in Bindungsskripten.

**-data** *string*
: *String* kann ein beliebiger Wert sein; er legt das Feld *user_data* für das Ereignis fest. Nur gültig für virtuelle Ereignisse. Entspricht der **%d**-Ersetzung für virtuelle Ereignisse in Bindungsskripten.

**-delta** *number*
: *Number* muss eine ganze Zahl sein; es legt das Feld *delta* für das **MouseWheel**-Ereignis fest. *Delta* bezeichnet Richtung und Ausmaß der Mausrad-Drehung. Der Wert ist kein Bildschirmabstand, sondern Einheiten der Mausrad-Bewegung. Typischerweise sind diese Werte Vielfache von 120. Beispielsweise sollte 120 das Text-Widget um 4 Zeilen nach oben scrollen und -240 um 8 Zeilen nach unten. Andere Widgets können für Mausrad-Bewegung anderes Verhalten definieren. Dieses Feld entspricht der **%D**-Ersetzung in Bindungsskripten.

**-detail** *detail*
: *Detail* legt das Feld *detail* für das Ereignis fest und muss eines der folgenden sein:

```
NotifyAncestor    NotifyNonlinearVirtual
NotifyDetailNone  NotifyPointer
NotifyInferior    NotifyPointerRoot
NotifyNonlinear   NotifyVirtual
```

Gültig für **Enter**-, **Leave**-, **FocusIn**- und **FocusOut**-Ereignisse. Entspricht der **%d**-Ersetzung in Bindungsskripten.

**-focus** *boolean*
: *Boolean* muss ein boolescher Wert sein; er legt das Feld *focus* für das Ereignis fest. Gültig für **Enter**- und **Leave**-Ereignisse. Entspricht der **%f**-Ersetzung in Bindungsskripten.

**-height** *size*
: *Size* muss ein Bildschirmabstand sein; er legt das Feld *height* für das Ereignis fest. Gültig für **Configure**-Ereignisse. Entspricht der **%h**-Ersetzung in Bindungsskripten.

**-keycode** *number*
: *Number* muss eine ganze Zahl sein; er legt das Feld *keycode* für das Ereignis fest. Gültig für **KeyPress**- und **KeyRelease**-Ereignisse. Entspricht der **%k**-Ersetzung in Bindungsskripten.

**-keysym** *name*
: *Name* muss der Name eines gültigen Keysym sein, etwa **g**, **space** oder **Return**; der zugehörige Keycode-Wert wird als Feld *keycode* für das Ereignis verwendet und überschreibt jedes im Basisargument *event* angegebene Detail. Gültig für **KeyPress**- und **KeyRelease**-Ereignisse. Entspricht der **%K**-Ersetzung in Bindungsskripten.

**-mode** *notify*
: *Notify* legt das Feld *mode* für das Ereignis fest und muss eines von **NotifyNormal**, **NotifyGrab**, **NotifyUngrab** oder **NotifyWhileGrabbed** sein. Gültig für **Enter**-, **Leave**-, **FocusIn**- und **FocusOut**-Ereignisse. Entspricht der **%m**-Ersetzung in Bindungsskripten.

**-override** *boolean*
: *Boolean* muss ein boolescher Wert sein; er legt das Feld *override_redirect* für das Ereignis fest. Gültig für **Map**-, **Reparent**- und **Configure**-Ereignisse. Entspricht der **%o**-Ersetzung in Bindungsskripten.

**-place** *where*
: *Where* legt das Feld *place* für das Ereignis fest; es muss **PlaceOnTop** oder **PlaceOnBottom** sein. Gültig für **Circulate**-Ereignisse. Entspricht der **%p**-Ersetzung in Bindungsskripten.

**-root** *window*
: *Window* muss entweder ein Fensterpfadname oder eine ganzzahlige Fensterkennung sein; er legt das Feld *root* für das Ereignis fest. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Enter**-, **Leave**- und **Motion**-Ereignisse. Entspricht der **%R**-Ersetzung in Bindungsskripten.

**-rootx** *coord*
: *Coord* muss ein Bildschirmabstand sein; er legt das Feld *x_root* für das Ereignis fest. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Enter**-, **Leave**- und **Motion**-Ereignisse. Entspricht der **%X**-Ersetzung in Bindungsskripten.

**-rooty** *coord*
: *Coord* muss ein Bildschirmabstand sein; er legt das Feld *y_root* für das Ereignis fest. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Enter**-, **Leave**- und **Motion**-Ereignisse. Entspricht der **%Y**-Ersetzung in Bindungsskripten.

**-sendevent** *boolean*
: *Boolean* muss ein boolescher Wert sein; er legt das Feld *send_event* für das Ereignis fest. Gültig für alle Ereignisse. Entspricht der **%E**-Ersetzung in Bindungsskripten.

**-serial** *number*
: *Number* muss eine ganze Zahl sein; er legt das Feld *serial* für das Ereignis fest. Gültig für alle Ereignisse. Entspricht der **%#**-Ersetzung in Bindungsskripten.

**-state** *state*
: *State* legt das Feld *state* für das Ereignis fest. Für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Enter**-, **Leave**- und **Motion**-Ereignisse muss es ein ganzzahliger Wert sein. Für **Visibility**-Ereignisse muss es eines von **VisibilityUnobscured**, **VisibilityPartiallyObscured** oder **VisibilityFullyObscured** sein. Diese Option überschreibt Modifikatoren wie **Meta** oder **Control**, die im Basis-*event* angegeben sind. Entspricht der **%s**-Ersetzung in Bindungsskripten.

**-subwindow** *window*
: *Window* legt das Feld *subwindow* für das Ereignis fest, entweder als Pfadnamen eines Tk-Widgets oder als ganzzahlige Fensterkennung. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Enter**-, **Leave**- und **Motion**-Ereignisse. Ähnlich der **%S**-Ersetzung in Bindungsskripten.

**-time** *integer*
: *Integer* muss ein ganzzahliger Wert sein; er legt das Feld *time* für das Ereignis fest. Zusätzlich ist der Sonderwert **current** erlaubt; dieser wird durch die aktuelle Ereigniszeit ersetzt. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Enter**-, **Leave**-, **Motion**- und **Property**-Ereignisse. Entspricht der **%t**-Ersetzung in Bindungsskripten.

**-warp** *boolean*
: *boolean* muss ein boolescher Wert sein; er legt fest, ob der Bildschirm-Mauszeiger ebenfalls verschoben („gewarpt“) werden soll. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**- und **Motion**-Ereignisse. Tk unterstützt Zeigerverschiebung relativ zum Root-Fenster des Bildschirms und relativ zu einem Tk-Fenster. Im zweiten Fall wird der Zeiger nur verschoben, wenn das Fenster abgebildet ist.

**-width** *size*
: *Size* muss ein Bildschirmabstand sein; er legt das Feld *width* für das Ereignis fest. Gültig für **Configure**-Ereignisse. Entspricht der **%w**-Ersetzung in Bindungsskripten.

**-when** *when*
: *When* bestimmt, wann das Ereignis verarbeitet wird; es muss einen der folgenden Werte haben:

**now**
: Das Ereignis wird sofort verarbeitet, bevor der Befehl zurückkehrt. Das gilt auch, wenn die Option **-when** weggelassen wird.

**tail**
: Das Ereignis wird hinten in die Tcl-Ereigniswarteschlange eingereiht, hinter alle für diese Anwendung bereits eingereihten Ereignisse.

**head**
: Das Ereignis wird an den Anfang der Tcl-Ereigniswarteschlange gesetzt, sodass es vor allen anderen bereits eingereihten Ereignissen behandelt wird.

**mark**
: Das Ereignis wird an den Anfang der Tcl-Ereigniswarteschlange gesetzt, aber hinter alle anderen Ereignisse, die bereits mit **-when mark** eingereiht wurden. Diese Option ist nützlich, wenn eine Reihe von Ereignissen erzeugt werden soll, die in Reihenfolge, aber am Anfang der Warteschlange verarbeitet werden sollen.


**-x** *coord*
: *Coord* muss ein Bildschirmabstand sein; er legt das Feld *x* für das Ereignis fest. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Motion**-, **Enter**-, **Leave**-, **Expose**-, **Configure**-, **Gravity**- und **Reparent**-Ereignisse. Entspricht der **%x**-Ersetzung in Bindungsskripten. Ist *Window* leer, bezieht sich die Koordinate auf den Bildschirm, und diese Option entspricht der **%X**-Ersetzung in Bindungsskripten.

**-y** *coord*
: *Coord* muss ein Bildschirmabstand sein; er legt das Feld *y* für das Ereignis fest. Gültig für **KeyPress**-, **KeyRelease**-, **ButtonPress**-, **ButtonRelease**-, **Motion**-, **Enter**-, **Leave**-, **Expose**-, **Configure**-, **Gravity**- und **Reparent**-Ereignisse. Entspricht der **%y**-Ersetzung in Bindungsskripten. Ist *Window* leer, bezieht sich die Koordinate auf den Bildschirm, und diese Option entspricht der **%Y**-Ersetzung in Bindungsskripten.


Optionen, die beim Erzeugen eines Ereignisses nicht angegeben werden, werden mit dem Wert 0 gefüllt, außer *serial*, das mit der nächsten X-Ereignis-Seriennummer gefüllt wird.

# VORDEFINIERTE VIRTUELLE EREIGNISSE

Tk definiert die folgenden virtuellen Ereignisse zu Benachrichtigungszwecken:

**<\<AltUnderlined>>**
: Wird an ein Widget gesendet, um es zu benachrichtigen, dass der Buchstabe, den es mit der Option **-underline** unterstrichen hat (als Beschleuniger-Anzeige), zusammen mit der Alt-Taste gedrückt wurde. Übliche Reaktion: Fokus auf das Widget (oder ein verwandtes Widget) setzen oder das Widget auslösen.

**<\<Invoke>>**
: Kann an einige Widgets (z. B. button, listbox, menu) als Alternative zu <space> gesendet werden.

**<\<ListboxSelect>>**
: Wird an eine Listbox gesendet, wenn die Menge der ausgewählten Einträge in der Listbox aktualisiert wird.

**<\<MenuSelect>>**
: Wird an ein Menü gesendet, wenn sich der aktuell ausgewählte Eintrag im Menü ändert. Gedacht für kontextsensitive Hilfesysteme.

**<\<Modified>>**
: Wird an ein Text-Widget gesendet, wenn sich der Inhalt des Widgets ändert.

**<\<Selection>>**
: Wird an ein Text-Widget gesendet, wenn sich die Auswahl im Widget ändert.

**<\<ThemeChanged>>**
: Wird an alle Widgets gesendet, wenn sich das ttk-Theme ändert. Die ttk-Widgets hören auf dieses Ereignis und zeichnen sich neu, wenn es ausgelöst wird. Die Legacy-Widgets ignorieren dieses Ereignis.

**<\<TkWorldChanged>>**
: Dieses Ereignis wird an alle Widgets gesendet, wenn eine Schriftart geändert wird, etwa durch [font configure]. Das Feld *user_data* (%d) hat den Wert „FontChanged“. Bei anderen systemweiten Änderungen wird dieses Ereignis an alle Widgets gesendet, und das Feld *user_data* gibt die Ursache der Änderung an. HINWEIS: alle tk- und ttk-Widgets behandeln dieses Ereignis bereits intern.

**<\<TraverseIn>>**
: Wird an ein Widget gesendet, wenn der Fokus das Widget betritt, weil der Benutzer per Tab zum Widget wechselt.

**<\<TraverseOut>>**
: Wird an ein Widget gesendet, wenn der Fokus das Widget verlässt, weil der Benutzer per Tab zum Widget wechselt.

**<\<UndoStack>>**
: Wird an ein Text-Widget gesendet, wenn sein Undo- oder Redo-Stack leer oder nicht mehr leer wird.

**<\<WidgetViewSync>>**
: Wird an ein Text-Widget gesendet, wenn seine internen Daten veraltet werden, und erneut, wenn diese internen Daten wieder mit der Widget-Ansicht synchron sind. Das Detailfeld (%d-Ersetzung) ist entweder true (wenn das Widget synchron ist) oder false (wenn nicht).


Tk definiert die folgenden virtuellen Ereignisse, um Bindungen über mehrere Plattformen hinweg zu vereinheitlichen. Benutzer erwarten folgendes Verhalten:

**<\<Clear>>**
: Den aktuell ausgewählten Widget-Inhalt löschen.

**<\<Copy>>**
: Den aktuell ausgewählten Widget-Inhalt in die Zwischenablage kopieren.

**<\<Cut>>**
: Den aktuell ausgewählten Widget-Inhalt in die Zwischenablage verschieben.

**<\<LineEnd>>**
: Zum Zeilenende im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<LineStart>>**
: Zum Zeilenanfang im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<NextChar>>**
: Zum nächsten Element (d. h. sichtbaren Zeichen) im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<NextLine>>**
: Zur nächsten Zeile im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<NextPara>>**
: Zum nächsten Absatz im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<NextWord>>**
: Zur nächsten Gruppe von Elementen (d. h. sichtbares Wort) im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<Paste>>**
: Den aktuell ausgewählten Widget-Inhalt durch den Inhalt der Zwischenablage ersetzen.

**<\<PasteSelection>>**
: Den Inhalt der Selection an der Mausposition einfügen. (Dieses Ereignis hat sinnvolle **%x**- und **%y**-Ersetzungen).

**<\<PrevChar>>**
: Zum vorherigen Element (d. h. sichtbaren Zeichen) im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<PrevLine>>**
: Zur vorherigen Zeile im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<PrevPara>>**
: Zum vorherigen Absatz im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<PrevWindow>>**
: Zum vorherigen Fenster wechseln (Traverse).

**<\<PrevWord>>**
: Zur vorherigen Gruppe von Elementen (d. h. sichtbares Wort) im aktuellen Widget wechseln und dabei jede Auswahl aufheben.

**<\<Redo>>**
: Eine rückgängig gemachte Aktion wiederherstellen.

**<\<SelectAll>>**
: Den Bereich der ausgewählten Inhalte auf das gesamte Widget setzen.

**<\<SelectLineEnd>>**
: Zum Zeilenende im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectLineStart>>**
: Zum Zeilenanfang im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectNextChar>>**
: Zum nächsten Element (d. h. sichtbaren Zeichen) im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectNextLine>>**
: Zur nächsten Zeile im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectNextPara>>**
: Zum nächsten Absatz im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectNextWord>>**
: Zur nächsten Gruppe von Elementen (d. h. sichtbares Wort) im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectNone>>**
: Den Bereich der ausgewählten Inhalte auf leer zurücksetzen.

**<\<SelectPrevChar>>**
: Zum vorherigen Element (d. h. sichtbaren Zeichen) im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectPrevLine>>**
: Zur vorherigen Zeile im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectPrevPara>>**
: Zum vorherigen Absatz im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<SelectPrevWord>>**
: Zur vorherigen Gruppe von Elementen (d. h. sichtbares Wort) im aktuellen Widget wechseln und dabei den Bereich der ausgewählten Inhalte erweitern.

**<\<ToggleSelection>>**
: Die Auswahl umschalten.

**<\<Undo>>**
: Die letzte Aktion rückgängig machen.


# BEISPIELE

## Tasten auf virtuelle Ereignisse abbilden

Damit eine Bindung an ein virtuelles Ereignis ausgelöst wird, müssen zwei Dinge geschehen. Zuerst muss das virtuelle Ereignis mit dem Befehl **event add** definiert werden. Zweitens muss mit dem Befehl **bind** eine Bindung für das virtuelle Ereignis erstellt werden. Betrachten Sie die folgenden Definitionen virtueller Ereignisse:

```
event add <<Paste>> <Control-y>
event add <<Paste>> <Button-2>
event add <<Save>> <Control-X><Control-S>
event add <<Save>> <Shift-F12>
if {[tk windowingsystem] eq "aqua"} {
    event add <<Save>> <Command-s>
}
```

Im Befehl **bind** kann ein virtuelles Ereignis wie jeder andere eingebaute Ereignistyp gebunden werden:

```
bind Entry <<Paste>> {%W insert [selection get]}
```

Die doppelten spitzen Klammern geben an, dass ein virtuelles Ereignis gebunden wird. Tippt der Benutzer Control-y oder drückt Taste 2, oder wird ein virtuelles Ereignis **<\<Paste>>** mit **event generate** synthetisiert, wird die **<\<Paste>>**-Bindung aufgerufen.

Hat eine virtuelle Bindung exakt dieselbe Sequenz wie eine separate physische Bindung, hat die physische Bindung Vorrang. Betrachten Sie folgendes Beispiel:

```
event add <<Paste>> <Control-y> <Meta-Control-y>
bind Entry <Control-y> {puts Control-y}
bind Entry <<Paste>> {puts Paste}
```

Tippt der Benutzer Control-y, wird die Bindung **<Control-y>** aufgerufen, weil ein physisches Ereignis als spezifischer gilt als ein virtuelles, sofern sonst gleich. Tippt der Benutzer Meta-Control-y, wird die **<\<Paste>>**-Bindung aufgerufen, weil der **Meta**-Modifikator im physischen Muster der virtuellen Bindung spezifischer ist als die Sequenz **\<Control-y**> für das physische Ereignis.

Bindungen an ein virtuelles Ereignis können erstellt werden, bevor das virtuelle Ereignis existiert. Das virtuelle Ereignis muss sogar nie definiert werden, etwa auf Plattformen, auf denen das jeweilige virtuelle Ereignis sinnlos oder nicht erzeugbar wäre.

Ändert sich die Definition eines virtuellen Ereignisses zur Laufzeit, reagieren alle Fenster sofort auf die neue Definition. Ausgehend vom vorherigen Beispiel, wenn folgender Code ausgeführt wird:

```
bind Entry <Control-y> {}
event add <<Paste>> <Key-F6>
```

ändert sich das Verhalten in zweierlei Hinsicht. Zuerst tritt die verdeckte **<\<Paste>>**-Bindung hervor. Control-y ruft nicht mehr die Bindung **<Control-y>** auf, sondern das virtuelle Ereignis **<\<Paste>>**. Zweitens ruft das Drücken der F6-Taste nun ebenfalls die **<\<Paste>>**-Bindung auf.

## Mauszeiger bewegen

Manchmal ist es nützlich, den Mauszeiger wirklich zu bewegen. Beispielsweise bei Software, die dem Benutzer direkt zeigt, wie das Programm bedient wird. Dazu muss die Maus mit **event generate** „gewarpt“ werden, etwa so:

```
for {set xy 0} {$xy < 200} {incr xy} {
    event generate . <Motion> -x $xy -y $xy -warp 1
    update
    after 50
}
```

Beachten Sie, dass es üblicherweise als schlechter Stil gilt, den Mauszeiger für den Benutzer zu bewegen, weil ihm die Kontrolle entzogen wird. Die Technik sollte daher mit Vorsicht eingesetzt werden. Außerdem ist nicht garantiert, dass sie auf allen Plattformen funktioniert.
