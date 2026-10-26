---
CommandName: ttk::notebook
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - grid(n)
Keywords:
 - pane
 - tab
Copyright:
 - Copyright (c) 2004 Joe English
---

# NAME

ttk::notebook - Container-Widget mit mehreren Bereichen

# ÜBERSICHT

::: {.synopsis} :::
[ttk::notebook]{.cmd} [pathname]{.arg} [options]{.optdot} 
[pathname]{.ins} [add]{.sub} [window]{.arg} [options]{.optdot} 
[pathname]{.ins} [insert]{.sub} [index]{.arg} [window]{.arg} [options]{.optdot} 
:::

# BESCHREIBUNG

Ein **ttk::notebook**-Widget verwaltet eine Sammlung von Fenstern und zeigt jeweils nur eines an. Jedes Inhaltsfenster ist einem *Tab* zugeordnet, den der Benutzer auswählen kann, um das aktuell angezeigte Fenster zu wechseln. Standardoptionen (siehe **ttk_widget**): **-class**, **-cursor**, **-takefocus**, **-style**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-height** (height/Height)
: Wenn vorhanden und größer als null, legt die gewünschte Höhe des Bereichs fest (ohne internen Innenabstand oder Tabs). Andernfalls wird die maximale Höhe aller Bereiche verwendet.

**-padding** (padding/Padding)
: Legt fest, wie viel zusätzlicher Platz außen um das Notebook herum hinzugefügt wird. Der Innenabstand ist eine Liste mit bis zu vier Längenangaben *left top right bottom*. Sind weniger als vier Elemente angegeben, gilt standardmäßig *bottom* = *top*, *right* = *left* und *top* = *left*. Eine Liste mit drei Zahlen gibt den linken, vertikalen und rechten Innenabstand an; zwei Zahlen den horizontalen und vertikalen; eine einzelne Zahl denselben Innenabstand rund um das Widget.

**-width** (width/Width)
: Wenn vorhanden und größer als null, legt die gewünschte Breite des Bereichs fest (ohne internen Innenabstand). Andernfalls wird die maximale Breite aller Bereiche verwendet.


# TAB-OPTIONEN

Die folgenden Optionen können für einzelne Notebook-Bereiche angegeben werden:

**-state** (state/State)
: Entweder **normal**, **disabled** oder **hidden**. Bei **disabled** ist der Tab nicht auswählbar. Bei **hidden** wird der Tab nicht angezeigt.

**-sticky** (sticky/Sticky)
: Legt fest, wie das Inhaltsfenster innerhalb des Bereichs positioniert wird. Der Wert ist ein String mit null oder mehr der Zeichen **n**, **s**, **e** oder **w**. Jeder Buchstabe bezeichnet eine Seite (Norden, Süden, Osten oder Westen), an der das Inhaltsfenster „klebt“, entsprechend dem Geometriemanager **grid**.

**-padding** (padding/Padding)
: Legt fest, wie viel zusätzlicher Platz zwischen dem Notebook und diesem Bereich hinzugefügt wird. Die Syntax entspricht der Widget-Option **-padding**.

**-text** (text/Text)
: Legt einen String fest, der im Tab angezeigt wird.

**-image** (image/Image)
: Legt ein Bild fest, das im Tab angezeigt wird. Siehe *ttk_widget(n)* für Details.

**-compound** (compound/Compound)
: Legt fest, wie das Bild relativ zum Text angezeigt wird, wenn sowohl **-text** als auch **-image** vorhanden sind. Siehe *label(n)* für zulässige Werte.

**-underline** (underline/Underline)
: Legt den ganzzahligen Index (0-basiert) eines zu unterstreichenden Zeichens im Textstring fest. Das unterstrichene Zeichen wird für die Mnemonik-Aktivierung verwendet, wenn **ttk::notebook::enableTraversal** aufgerufen wird.


# TAB-KENNUNGEN

Das Argument *tabid* der folgenden Befehle kann eine der folgenden Formen annehmen:

- Eine ganze Zahl zwischen null und der Anzahl der Tabs;

- Der Name eines Inhaltsfensters;

- Eine Positionsangabe der Form „@*x*,*y*“, die den Tab identifiziert

- Der Literalstring „**current**“, der den aktuell ausgewählten Tab bezeichnet; oder:

- Der Literalstring „**end**“, der die Anzahl der Tabs zurückgibt (nur gültig für „*pathname* **index**“).


# WIDGET-BEFEHL

*pathname* **add** *window* ?*options...*?
: Fügt dem Notebook einen neuen Tab hinzu. Siehe **TAB-OPTIONEN** für die Liste der verfügbaren *options*. Wenn *window* bereits vom Notebook verwaltet, aber ausgeblendet ist, wird es an seine frühere Position zurückgesetzt.

*pathname* **configure** ?*options*?
: Siehe *ttk::widget(n)*.

*pathname* **cget** *option*
: Siehe *ttk::widget(n)*.

*pathname* **forget** *tabid*
: Entfernt den durch *tabid* angegebenen Tab, blendet das zugehörige Fenster aus und beendet die Verwaltung.

*pathname* **hide** *tabid*
: Blendet den durch *tabid* angegebenen Tab aus. Der Tab wird nicht angezeigt, das zugehörige Fenster bleibt aber vom Notebook verwaltet und seine Konfiguration wird gespeichert. Ausgeblendete Tabs können mit dem Befehl **add** wiederhergestellt werden.

*pathname* **identify** *component x y*
: Gibt den Namen des Elements unter dem Punkt *x* und *y* zurück oder den leeren String, wenn an dieser Position kein Element vorhanden ist. Folgende Unterbefehle werden unterstützt:

*pathname* **identify element** *x y*
: Gibt den Namen des Elements an der angegebenen Position zurück.

*pathname* **identify tab** *x y*
: Gibt den Index des Tabs an der angegebenen Position zurück.


*pathname* **index** *tabid*
: Gibt den numerischen Index des durch *tabid* angegebenen Tabs zurück oder die Gesamtanzahl der Tabs, wenn *tabid* der String „**end**“ ist.

*pathname* **insert** *pos subwindow options...*
: Fügt einen Bereich an der angegebenen Position ein. *pos* ist entweder der String **end**, ein ganzzahliger Index oder der Name eines verwalteten Unterfensters. Wenn *subwindow* bereits vom Notebook verwaltet wird, wird es an die angegebene Position verschoben. Siehe **TAB-OPTIONEN** für die Liste der verfügbaren Optionen.

*pathname* **instate** *statespec* ?*script...*?
: Siehe *ttk::widget(n)*.

*pathname* **select** ?*tabid*?
: Wählt den angegebenen Tab aus. Das zugehörige Inhaltsfenster wird angezeigt, das zuvor ausgewählte Fenster (falls abweichend) wird ausgeblendet. Wenn *tabid* weggelassen wird, gibt der Befehl den Widget-Namen des aktuell ausgewählten Bereichs zurück.

*pathname* **state** ?*statespec*?
: Siehe *ttk::widget(n)*.

*pathname* **tab** *tabid* ?*-option* ?*value ...*
: Fragt die Optionen des angegebenen Tabs ab oder ändert sie. Wenn keine *-option* angegeben ist, gibt ein Dictionary der Tab-Optionswerte zurück. Ist eine *-option* angegeben, gibt der Wert dieser *option* zurück. Andernfalls werden die *-option*en auf die entsprechenden *value*s gesetzt. Siehe **TAB-OPTIONEN** für die verfügbaren Optionen.

*pathname* **tabs**
: Gibt die Liste der vom Notebook verwalteten Fenster in der Indexreihenfolge ihrer zugehörigen Tabs zurück.


# TASTATUR-NAVIGATION

Um die Tastaturnavigation für ein Toplevel-Fenster mit einem Notebook-Widget *$nb* zu aktivieren, rufen Sie auf:

```
ttk::notebook::enableTraversal $nb
```

Dies erweitert die Bindungen für das Toplevel-Fenster, das das Notebook enthält, wie folgt:

- **Control-Tab** wählt den Tab nach dem aktuell ausgewählten aus.

- **Control-Shift-Tab** wählt den Tab vor dem aktuell ausgewählten aus.

- **Alt-**_K_, wobei *K* das mnemonische (unterstrichene) Zeichen eines Tabs ist, wählt diesen Tab aus.


Mehrere Notebooks in einem Toplevel können für die Navigation aktiviert werden, einschließlich verschachtelter Notebooks. Die Notebook-Navigation funktioniert jedoch nur korrekt, wenn alle Bereiche direkte Kinder des Notebooks sind.

# VIRTUELLE EREIGNISSE

Das Notebook-Widget erzeugt nach der Auswahl eines neuen Tabs ein virtuelles Ereignis **<\<NotebookTabChanged>>**.

# BEISPIEL

```
pack [ttk::notebook .nb]
\&.nb add [frame .nb.f1] \-text "First tab"
\&.nb add [frame .nb.f2] \-text "Second tab"
\&.nb select .nb.f2
ttk::notebook::enableTraversal .nb
```

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::notebook** ist **TNotebook**. Der Tab hat den Klassennamen **TNotebook.Tab**

Dynamische Zustände: **active**, **disabled**, **selected**.

**TNotebook**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können, sind:

**-background** *color* .br **-bordercolor** *color* .br **-darkcolor** *color* .br **-foreground** *color* .br **-lightcolor** *color* .br **-padding** *padding* .br **-tabmargins** *padding* .br **-tabposition** *position* Legt die Position der Tab-Zeile oder -Spalte als String der Länge 1 oder 2 fest. Das erste Zeichen gibt die Seite als **n**, **s**, **w** oder **e** an, das zweite Zeichen (falls vorhanden) ist der Sticky-Bit (angegeben als **w**, **e**, **n** oder **s**) innerhalb der Tab-Position. Die Standardposition ist **n** für das Theme **aqua** und **nw** für alle anderen eingebauten Themes. .br **-tabplacement** *placement* Legt die Platzierung (den Anker) der Tabs innerhalb der Tab-Zeile oder -Spalte als String der Länge 1 oder 2 fest. Das erste Zeichen gibt die Seite als **w**, **e**, **n** oder **s** an, das zweite Zeichen (falls vorhanden) ist der Sticky-Bit (angegeben als **s**, **n**, **e** oder **w**) innerhalb der Tab-Platzierung. Die Platzierung **ws** heißt zum Beispiel: die Westseite (links) jedes Tabs an den vorherigen hängen und die Südkanten (unten) aneinander ausrichten. Entsprechend hängt **se** die Südseite (unten) jedes Tabs an den vorherigen und richtet die Ostkanten (rechts) aneinander aus. Die Standardplatzierung hängt vom ersten Zeichen der Tab-Position ab: **ws** für **n\***, **wn** für **s\***, **ne** für **w\*** und **nw** für **e\***. .br

**TNotebook.Tab**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können, sind:

**-background** *color* .br **-bordercolor** *color* .br **-compound** *compound* .br **-expand** *padding* Legt fest, wie stark der Tab in der Größe wächst. Wird üblicherweise mit dem dynamischen Zustand **selected** verwendet. **-tabmargins** sollte entsprechend gesetzt werden, damit Platz für das Tab-Wachstum vorhanden ist. Die Ttk-Bibliotheksdatei **vistaTheme.tcl** enthält beispielsweise die Zeilen

```
ttk::style configure TNotebook -tabmargins {2 2 2 0}
ttk::style map TNotebook.Tab -expand {selected {2 2 2 2}}
```

die für den Standardwert **nw** der Stiloption **-tabposition** gültig sind. Für einen **ttk::notebook**-Stil **nbStyle**, definiert durch

```
set nbStyle SW.TNotebook
ttk::style configure $nbStyle -tabposition sw
```

müssen die obigen Einstellungen wie folgt angepasst werden:

```
ttk::style configure $nbStyle -tabmargins {2 0 2 2}
ttk::style map $nbStyle.Tab -expand {selected {2 2 2 2}}
```

Am einfachsten geschieht dies durch Aufruf der Bibliotheksprozedur **ttk::configureNotebookStyle** mit **$nbStyle** als Argument, nachdem die Stiloption **-tabposition** gesetzt wurde. **-font** *font* .br **-foreground** *color* .br **-padding** *padding* Einige Themes verwenden einen anderen *padding* für den ausgewählten Tab. Die Ttk-Bibliotheksdatei **clamTheme.tcl** enthält beispielsweise die Zeilen

```
ttk::style configure TNotebook.Tab -padding {6 2 6 2}
ttk::style map TNotebook.Tab -padding {selected {6 4 6 2}}
```

die für den Standardwert **nw** der Stiloption **-tabposition** gültig sind. Für einen **ttk::notebook**-Stil mit abweichender Tab-Position müssen die obigen Einstellungen entsprechend angepasst werden. Am einfachsten geschieht dies durch Aufruf der Bibliotheksprozedur **ttk::configureNotebookStyle** mit dem Stilnamen als Argument, nachdem die Stiloption **-tabposition** gesetzt wurde.

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.
