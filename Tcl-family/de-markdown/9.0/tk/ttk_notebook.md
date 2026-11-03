---
CommandName: ttk::notebook
title: ttk::notebook
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

# Name

ttk::notebook - Container-Widget mit mehreren Bereichen

# Übersicht

::: {.synopsis} :::
[ttk::notebook]{.cmd} [pathname]{.arg} [options...]{.optarg}
[pathname]{.ins} [add]{.sub} [window]{.arg} [options...]{.optarg}
[pathname]{.ins} [insert]{.sub} [index]{.arg} [window]{.arg} [options...]{.optarg}
:::

# Beschreibung

Ein **ttk::notebook**-Widget verwaltet eine Sammlung von Fenstern und zeigt jeweils nur eines an. Jedes Inhaltsfenster ist einem *Register* zugeordnet, das der Benutzer auswählen kann, um das aktuell angezeigte Fenster zu wechseln.

Ist ein Inhaltsfenster kein Kind des Notebooks, muss es in der Stapelreihenfolge über dem Notebook liegen, sonst verdeckt das Notebook es. Am einfachsten erzeugen Sie das Notebook zuerst: das zuletzt erzeugte Fenster liegt oben in der Stapelreihenfolge. Oder Sie verwenden die Befehle [raise] und [lower].

# Standardoptionen

**-class**, **-cursor**, **-takefocus**, **-style**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-height** (**height**/**Height**)
: Ist sie vorhanden und größer als null, legt sie die gewünschte Höhe des Bereichs fest (ohne Innenabstand oder Register). Andernfalls wird die maximale Höhe aller Bereiche verwendet.

**-padding** (**padding**/**Padding**)
: Legt fest, wie viel zusätzlicher Platz außen um das Notebook herum hinzugefügt wird. Der Innenabstand ist eine Liste mit bis zu vier Längenangaben *left top right bottom*. Sind weniger als vier Elemente angegeben, gilt standardmäßig *bottom* = *top*, *right* = *left* und *top* = *left*. Eine Liste mit drei Zahlen gibt den linken, vertikalen und rechten Innenabstand an; zwei Zahlen den horizontalen und vertikalen; eine einzelne Zahl denselben Innenabstand rund um das Widget.

**-width** (**width**/**Width**)
: Ist sie vorhanden und größer als null, legt sie die gewünschte Breite des Bereichs fest (ohne internen Innenabstand). Andernfalls wird die maximale Breite aller Bereiche verwendet.


# Registeroptionen

Die folgenden Optionen können für einzelne Notebook-Bereiche angegeben werden:

**-state** (**state**/**State**)
: Entweder **normal**, **disabled** oder **hidden**. Bei **disabled** ist das Register nicht auswählbar. Bei **hidden** wird das Register nicht angezeigt.

**-sticky** (**sticky**/**Sticky**)
: Legt fest, wie das Inhaltsfenster innerhalb des Bereichs positioniert wird. Der Wert ist eine Zeichenkette mit null oder mehr der Zeichen **n**, **s**, **e** oder **w**. Jeder Buchstabe bezeichnet eine Seite (Norden, Süden, Osten oder Westen), an der das Inhaltsfenster „klebt“, entsprechend dem Geometriemanager [grid].

**-padding** (**padding**/**Padding**)
: Legt fest, wie viel zusätzlicher Platz zwischen dem Notebook und diesem Bereich hinzugefügt wird. Die Syntax entspricht der Widget-Option **-padding**.

**-text** (**text**/**Text**)
: Legt eine Zeichenkette fest, die im Register angezeigt wird.

**-image** (**image**/**Image**)
: Legt ein Bild fest, das im Register angezeigt wird. Siehe *ttk\_widget(n)* für Details.

**-compound** (**compound**/**Compound**)
: Legt fest, wie das Bild relativ zum Text angezeigt wird, wenn sowohl **-text** als auch **-image** vorhanden sind. Siehe *label(n)* für zulässige Werte.

**-underline** (**underline**/**Underline**)
: Legt den ganzzahligen Index (0-basiert) eines zu unterstreichenden Zeichens in der Textzeichenkette fest. Das unterstrichene Zeichen wird für die Mnemonik-Aktivierung verwendet, wenn **ttk::notebook::enableTraversal** aufgerufen wird.


# Registerkennungen

Das Argument *tabid* der folgenden Befehle kann eine der folgenden Formen annehmen:

- Eine ganze Zahl zwischen null und der Anzahl der Register;

- Der Name eines Inhaltsfensters;

- Eine Positionsangabe der Form „@*x*,*y*“, die das Register identifiziert

- Die literale Zeichenkette „**current**“, die das aktuell ausgewählte Register bezeichnet; oder:

- Die literale Zeichenkette „**end**“, die die Anzahl der Register zurückgibt (nur gültig für „*pathname* **index**“).


Indizes unterstützen dieselbe einfache Interpretation wie beim Befehl [string index][string], mit einfacher ganzzahliger Indexarithmetik und Indexierung relativ zu **end**.

# Widget-Befehl

Zusätzlich zu den Standardbefehlen **cget**, **configure**, **instate**, **state** und **style** (siehe [ttk::widget][ttk_widget]) unterstützen Notebook-Widgets folgende zusätzliche Befehle:

[pathname]{.ins} [add]{.sub} [window]{.arg} [options...]{.optarg}
: Fügt dem Notebook ein neues Register hinzu. Siehe [Registeroptionen] für die Liste der verfügbaren *options*. Wenn *window* bereits vom Notebook verwaltet, aber ausgeblendet ist, wird es an seine frühere Position zurückgesetzt.

[pathname]{.ins} [forget]{.sub} [tabid]{.arg}
: Entfernt das durch *tabid* angegebene Register, blendet das zugehörige Fenster aus und beendet die Verwaltung.

[pathname]{.ins} [hide]{.sub} [tabid]{.arg}
: Blendet das durch *tabid* angegebene Register aus. Das Register wird nicht angezeigt, das zugehörige Fenster bleibt aber vom Notebook verwaltet und seine Konfiguration wird gespeichert. Ausgeblendete Register können mit dem Befehl **add** wiederhergestellt werden.

[pathname]{.ins} [identify]{.sub} [component]{.arg} [x]{.arg} [y]{.arg}
: Gibt den Namen des Elements unter dem Punkt *x* und *y* zurück oder die leere Zeichenkette, wenn an dieser Position kein Element vorhanden ist. Folgende Unterbefehle werden unterstützt:

    [pathname]{.ins} [identify]{.sub} [element]{.lit} [x]{.arg} [y]{.arg}
    : Gibt den Namen des Elements an der angegebenen Position zurück.

    [pathname]{.ins} [identify]{.sub} [tab]{.lit} [x]{.arg} [y]{.arg}
    : Gibt den Index des Registers an der angegebenen Position zurück.


[pathname]{.ins} [index]{.sub} [tabid]{.arg}
: Gibt den numerischen Index des durch *tabid* angegebenen Registers zurück oder die Gesamtanzahl der Register, wenn *tabid* die Zeichenkette „**end**“ ist.

[pathname]{.ins} [insert]{.sub} [pos]{.arg} [subwindow]{.arg} [options...]{.arg}
: Fügt einen Bereich an der angegebenen Position ein. *pos* ist entweder die Zeichenkette **end**, ein ganzzahliger Index oder der Name eines verwalteten Unterfensters. Wenn *subwindow* bereits vom Notebook verwaltet wird, wird es an die angegebene Position verschoben. Siehe [Registeroptionen] für die Liste der verfügbaren Optionen.

[pathname]{.ins} [select]{.sub} [tabid]{.optarg}
: Wählt das angegebene Register aus. Das zugehörige Inhaltsfenster wird angezeigt, das zuvor ausgewählte Fenster (falls abweichend) wird ausgeblendet. Wenn *tabid* weggelassen wird, gibt der Befehl den Widget-Namen des aktuell ausgewählten Bereichs zurück.

[pathname]{.ins} [tab]{.sub} [tabid]{.arg} [-option ?value ...]{.optarg}
: Fragt die Optionen des angegebenen Registers ab oder ändert sie. Wenn keine *-option* angegeben ist, wird ein Dictionary der Registeroptionswerte zurückgegeben. Ist eine *-option* angegeben, wird der Wert dieser *option* zurückgegeben. Andernfalls werden die *-option*en auf die entsprechenden *value*-Argumente gesetzt. Siehe [Registeroptionen] für die verfügbaren Optionen.

[pathname]{.ins} [tabs]{.sub}
: Gibt die Liste der vom Notebook verwalteten Fenster in der Indexreihenfolge ihrer zugehörigen Register zurück.


# Tastaturnavigation

Um die Tastaturnavigation für ein Toplevel-Fenster mit einem Notebook-Widget *$nb* zu aktivieren, rufen Sie auf:

```
ttk::notebook::enableTraversal $nb
```

Dies erweitert die Bindungen für das Toplevel-Fenster, das das Notebook enthält, wie folgt:

- **Control-Tab** wählt das Register nach dem aktuell ausgewählten aus.

- **Control-Shift-Tab** wählt das Register vor dem aktuell ausgewählten aus.

- **Alt-***K*, wobei *K* das mnemonische (unterstrichene) Zeichen eines Registers ist, wählt dieses Register aus.


Mehrere Notebooks in einem Toplevel können für die Navigation aktiviert werden, einschließlich verschachtelter Notebooks. Die Notebook-Navigation funktioniert jedoch nur korrekt, wenn alle Bereiche direkte Kinder des Notebooks sind.

# Virtuelle Ereignisse

Das Notebook-Widget erzeugt nach der Auswahl eines neuen Registers ein virtuelles Ereignis **<<NotebookTabChanged>>**.

# Beispiel

```
pack [ttk::notebook .nb]
.nb add [frame .nb.f1] -text "First tab"
.nb add [frame .nb.f2] -text "Second tab"
.nb select .nb.f2
ttk::notebook::enableTraversal .nb
```

# Styling-Optionen

Der Klassenname für ein **ttk::notebook** ist **TNotebook**. Das Register hat den Klassennamen **TNotebook.Tab**

Dynamische Zustände: **active**, **disabled**, **selected**.

**TNotebook**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-background** *color*

**-bordercolor** *color*

**-darkcolor** *color*

**-foreground** *color*

**-lightcolor** *color*

**-padding** *padding*

**-tabmargins** *padding*

**-tabposition** *position*
: Legt die Position der Registerzeile oder -spalte als Zeichenkette der Länge 1 oder 2 fest. Das erste Zeichen gibt die Seite als **n**, **s**, **w** oder **e** an, das zweite Zeichen (falls vorhanden) ist das Sticky-Bit (angegeben als **w**, **e**, **n** oder **s**) innerhalb der Registerposition. Die Standardposition ist **n** für das Theme **aqua** und **nw** für alle anderen eingebauten Themes.


**-tabplacement** *placement*
: Legt die Platzierung (den Anker) der Register innerhalb der Registerzeile oder -spalte als Zeichenkette der Länge 1 oder 2 fest. Das erste Zeichen gibt die Seite als **w**, **e**, **n** oder **s** an, das zweite Zeichen (falls vorhanden) ist das Sticky-Bit (angegeben als **s**, **n**, **e** oder **w**) innerhalb der Registerplatzierung. Die Platzierung **ws** heißt zum Beispiel: die Westseite (links) jedes Registers an das vorherige hängen und die Südkanten (unten) aneinander ausrichten. Entsprechend hängt **se** die Südseite (unten) jedes Registers an das vorherige und richtet die Ostkanten (rechts) aneinander aus. Die Standardplatzierung hängt vom ersten Zeichen der Registerposition ab: **ws** für **n\***, **wn** für **s\***, **ne** für **w\*** und **nw** für **e\***.


**TNotebook.Tab**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-background** *color*

**-bordercolor** *color*

**-compound** *compound*

**-expand** *padding*
: Legt fest, wie stark das Register in der Größe wächst. Wird üblicherweise mit dem dynamischen Zustand **selected** verwendet. **-tabmargins** sollte entsprechend gesetzt werden, damit Platz für das Wachstum des Registers vorhanden ist. Die Ttk-Bibliotheksdatei **vistaTheme.tcl** enthält beispielsweise die Zeilen

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

    Am einfachsten geschieht dies durch Aufruf der Bibliotheksprozedur **ttk::configureNotebookStyle** mit **$nbStyle** als Argument, nachdem die Stiloption **-tabposition** gesetzt wurde.


**-font** *font*

**-foreground** *color*

**-padding** *padding*
: Einige Themes verwenden einen anderen *padding* für das ausgewählte Register. Die Ttk-Bibliotheksdatei **clamTheme.tcl** enthält beispielsweise die Zeilen

    ```
    ttk::style configure TNotebook.Tab \
        -padding {4.5p 1.5p 4.5p 1.5p}
    ttk::style map TNotebook.Tab \
        -padding {selected {4.5p 3p 4.5p 1.5p}}
    ```

    die für den Standardwert **nw** der Stiloption **-tabposition** gültig sind. Für einen **ttk::notebook**-Stil mit abweichender Registerposition müssen die obigen Einstellungen entsprechend angepasst werden. Am einfachsten geschieht dies durch Aufruf der Bibliotheksprozedur **ttk::configureNotebookStyle** mit dem Stilnamen als Argument, nachdem die Stiloption **-tabposition** gesetzt wurde.


Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[grid]: grid.md
[lower]: lower.md
[raise]: raise.md
[string]: ../tcl/string.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
