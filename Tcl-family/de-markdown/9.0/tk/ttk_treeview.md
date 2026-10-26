---
CommandName: ttk::treeview
title: ttk::treeview
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - listbox(n)
 - image(n)
 - bind(n)
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk::treeview - Hierarchisches mehrspaltiges Datenanzeige-Widget

# Übersicht

::: {.synopsis} :::
[ttk::treeview]{.cmd} [pathname]{.arg} [options]{.optarg}
:::

# Beschreibung

Das **ttk::treeview**-Widget zeigt eine hierarchische Sammlung von Elementen an. Jedes Element hat eine Textbeschriftung, ein optionales Bild und eine optionale Liste von Datenwerten. Die Datenwerte werden in aufeinanderfolgenden Spalten nach der Baumspaltenbeschriftung angezeigt.

Die Reihenfolge, in der Datenwerte angezeigt werden, kann über die Widget-Option **-displaycolumns** gesteuert werden. Das Treeview-Widget kann auch Spaltenüberschriften anzeigen. Auf Spalten kann per Nummer oder über die in der Widget-Option **-columns** aufgeführten symbolischen Namen zugegriffen werden; siehe [Spaltenidentifikatoren].

Jedes Element wird durch einen eindeutigen Namen identifiziert. Fehlen Element-IDs vom Aufrufer, erzeugt das Widget sie selbst. Es gibt ein ausgezeichnetes Wurzelelement mit dem Namen **{}**. Das Wurzelelement selbst wird nicht angezeigt; seine Kinder erscheinen auf der obersten Ebene der Hierarchie.

Jedes Element besitzt außerdem eine Liste von *Tags*, mit denen Ereignisbindungen einzelnen Elementen zugeordnet und das Erscheinungsbild des Elements gesteuert werden können.

Treeview-Widgets unterstützen horizontales und vertikales Scrollen mit den üblichen Optionen **-**\[**xy**\]**scrollcommand** und den Widget-Befehlen \[**xy**\]**view**.

# Standardoptionen

**-class**, **-cursor**, **-takefocus**, **-style**, **-xscrollcommand**, **-yscrollcommand**, **-padding**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-columns** (**columns**/**Columns**)
: Liste von Spaltenkennungen; legt die Anzahl der Spalten und deren Namen fest.

**-displaycolumns** (**displayColumns**/**DisplayColumns**)
: Liste von Spaltenkennungen (symbolische Namen oder ganzzahlige Indizes), die festlegt, welche Datenspalten angezeigt werden und in welcher Reihenfolge, oder die Zeichenkette **#all**. Ist **#all** gesetzt (Standard), werden alle Spalten in der angegebenen Reihenfolge angezeigt.

**-height** (**height**/**Height**)
: Legt die Anzahl der sichtbaren Zeilen fest. Hinweis: Die angeforderte Breite ergibt sich aus der Summe der Spaltenbreiten.

**-selectmode** (**selectMode**/**SelectMode**)
: Legt fest, wie die eingebauten Klassenbindungen die Auswahl verwalten. Einer von **extended**, **browse** oder **none**.

    Ist **extended** gesetzt (Standard), können mehrere Elemente ausgewählt werden. Bei **browse** ist jeweils nur ein Element ausgewählt. Bei **none** wird die Auswahl nicht geändert.

    Hinweis: Anwendungscode und Tag-Bindungen können die Auswahl unabhängig vom Wert von **-selectmode** beliebig setzen.

**-selecttype** (**selectType**/**SelectType**)
: Legt fest, wie die eingebauten Klassenbindungen die Auswahl verwalten. Einer von **item** oder **cell**.

**-show** (**show**/**Show**)
: Liste mit null oder mehr der folgenden Werte; legt fest, welche Teile des Baums angezeigt werden.

    **tree**
    : Baumspaltenbeschriftungen in Spalte #0 anzeigen.

    **headings**
    : Die Überschriftenzeile anzeigen.


    Der Standardwert ist **tree headings**.

    **HINWEIS:** Spalte #0 bezeichnet immer die Baumspalte, auch wenn **-show tree** nicht gesetzt ist.

**-striped** (**striped**/**Striped**)
: Boolescher Wert für Zebra-Streifen-Färbung der Elemente. Gestreifte Elemente verwenden die Option **-stripedbackground**, falls vom Theme oder einem Tag gesetzt. Unterstützt das aktuelle Theme dies nicht, ist nichts sichtbar.

**-titlecolumns** (**titleColumns**/**TitleColumns**)
: Anzahl der linken Anzeigespalten, die nicht horizontal gescrollt werden. Die Baumspalte zählt mit, auch wenn **-show tree** nicht gesetzt ist. Bei Wert N dieser Option ist Spalte #N die erste scrollbare Spalte. Standard ist 0.

**-titleitems** (**titleItems**/**TitleItems**)
: Anzahl der oberen Elemente, die nicht vertikal gescrollt werden. Standard ist 0.


# Widget-Befehl

Zusätzlich zu den Standardbefehlen **cget**, **configure**, **instate**, **state**, **style**, **xview** und **yview** (siehe [ttk::widget][ttk_widget]) unterstützen Treeview-Widgets folgende zusätzliche Befehle:

[pathname]{.ins} [bbox]{.sub} [item]{.arg} [column]{.optarg}
: Gibt die Begrenzungsbox (relativ zum Fenster des Treeview-Widgets) des angegebenen *item* in der Form *x y width height* zurück. Ist *item* nicht sichtbar (z. B. Nachkomme eines geschlossenen Elements oder vertikal aus dem sichtbaren Bereich gescrollt), wird die leere Liste zurückgegeben. Ist *column* angegeben und nicht ausgeblendet (durch **-displaycolumns**), wird die Begrenzungsbox dieser Zelle innerhalb von *item* zurückgegeben (auch wenn die Zelle horizontal aus dem sichtbaren Bereich gescrollt ist).

[pathname]{.ins} [cellselection]{.sub} [selop arg]{.optdot}
: Verwaltet die Zellauswahl. Die Zellauswahl ist unabhängig von der Elementauswahl, die der Befehl **selection** verwaltet. Eine Zelle wird durch eine Liste mit zwei Elementen, item und column, angegeben. Bei Rechteck-Varianten der Befehle müssen die Zellen in angezeigten Spalten liegen. Jede Änderung von **-columns** löscht die Zellauswahl. Ein Argument *cellList* kann eine einzelne Zelle oder eine Liste von Zellen sein. Ist *selop* nicht angegeben, wird die Liste der ausgewählten Zellen zurückgegeben. Andernfalls ist *selop* einer der folgenden:

    [pathname]{.ins} [cellselection]{.sub} [set]{.lit} [cellList]{.arg}
    : *cellList* wird die neue Zellauswahl.

    [pathname]{.ins} [cellselection]{.sub} [set]{.lit} [firstCell]{.arg} [lastCell]{.arg}
    : Das definierte Rechteck wird die neue Zellauswahl.

    [pathname]{.ins} [cellselection]{.sub} [add]{.lit} [cellList]{.arg}
    : *cellList* zur Zellauswahl hinzufügen.

    [pathname]{.ins} [cellselection]{.sub} [add]{.lit} [firstCell]{.arg} [lastCell]{.arg}
    : Das definierte Rechteck zur Zellauswahl hinzufügen.

    [pathname]{.ins} [cellselection]{.sub} [remove]{.lit} [cellList]{.arg}
    : *cellList* aus der Zellauswahl entfernen.

    [pathname]{.ins} [cellselection]{.sub} [remove]{.lit} [firstCell]{.arg} [lastCell]{.arg}
    : Das definierte Rechteck aus der Zellauswahl entfernen.

    [pathname]{.ins} [cellselection]{.sub} [toggle]{.lit} [cellList]{.arg}
    : Den Zellauswahlzustand jeder Zelle in *cellList* umschalten. Ist das Element teilweise sichtbar, umfasst das Ergebnis den vollen Bereich des Elements einschließlich nicht sichtbarer Teile.

    [pathname]{.ins} [cellselection]{.sub} [toggle]{.lit} [firstCell]{.arg} [lastCell]{.arg}
    : Den Zellauswahlzustand jeder Zelle im definierten Rechteck umschalten.


[pathname]{.ins} [children]{.sub} [item]{.arg} [newchildren]{.optarg}
: Ist *newchildren* nicht angegeben, gibt die Liste der Kinder von *item* zurück.

    Ist *newchildren* angegeben, ersetzt die Kinderliste von *item* durch *newchildren*. Elemente der alten Kinderliste, die nicht in der neuen Liste stehen, werden vom Baum getrennt. Keines der Elemente in *newchildren* darf ein Vorfahre von *item* sein.

[pathname]{.ins} [column]{.sub} [column]{.arg} [-option ?value -option value...]{.optarg}
: Abfragen oder Ändern der Optionen der angegebenen *column*. Ist kein *-option* angegeben, wird ein Dictionary der Option/Wert-Paare zurückgegeben. Ist genau ein *-option* angegeben, wird dessen Wert zurückgegeben. Andernfalls werden die Optionen mit den angegebenen Werten aktualisiert. Für jede Spalte können folgende Optionen gesetzt werden:

    [-id]{.lit} [name]{.arg}
    : Der Spaltenname. Schreibgeschützte Option. Beispiel: \[*$pathname* **column #***n* **-id**\] liefert die Datenspalte zur Anzeigespalte *n*. Die Baumspalte hat **-id #0**.

    [-anchor]{.lit} [anchor]{.arg}
    : Legt fest, wie der Text in dieser Spalte relativ zur Zelle ausgerichtet wird. *Anchor* ist einer von **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw** oder **center**.

    [-minwidth]{.lit} [minwidth]{.arg}
    : Mindestbreite der Spalte in Pixeln. Das Treeview-Widget macht die Spalte beim Größenändern oder beim Ziehen eines Spaltentrenners nicht schmaler als **-minwidth**. Standard 20 Pixel.

    [-separator]{.lit} [boolean]{.arg}
    : Legt fest, ob rechts von der Spalte ein Spaltentrenner gezeichnet wird. Standard false.

    [-stretch]{.lit} [boolean]{.arg}
    : Legt fest, ob die Spaltenbreite beim Größenändern des Widgets oder beim Ziehen eines Spaltenüberschrift-Trenners angepasst wird. *Boolean* kann jede von [Tcl\_GetBoolean][GetInt] akzeptierte Form haben. Standardmäßig sind Spalten dehnbar.

    [-width]{.lit} [width]{.arg}
    : Breite der Spalte in Pixeln. Standard 200 Pixel. Die angegebene Breite kann von Tk geändert werden, um **-stretch** und/oder **-minwidth** zu berücksichtigen oder bei Größenänderung bzw. Ziehen eines Spaltentrenners.


    Verwenden Sie *pathname* **column #0**, um die Baumspalte zu konfigurieren.

[pathname]{.ins} [delete]{.sub} [itemList]{.arg}
: Löscht jedes Element in *itemList* und alle Nachkommen. Das Wurzelelement darf nicht gelöscht werden. Siehe auch: **detach**.

[pathname]{.ins} [detach]{.sub} [itemList]{.arg}
: Trennt alle angegebenen Elemente in *itemList* vom Baum. Die Elemente und alle Nachkommen bleiben vorhanden und können mit **move** an anderer Stelle wieder eingefügt werden, werden aber erst dann angezeigt. Das Wurzelelement darf nicht getrennt werden. Siehe auch: **delete**.

[pathname]{.ins} [detached]{.sub} [item]{.optarg}
: Ist *item* angegeben, gibt einen booleschen Wert zurück, ob es der Name eines getrennten Elements ist (siehe **detach**). Andernfalls eine Liste aller getrennten Elemente (in beliebiger Reihenfolge). Das Wurzelelement ist nie getrennt.

[pathname]{.ins} [exists]{.sub} [item]{.arg}
: Gibt 1 zurück, wenn *item* im Baum vorhanden ist, sonst 0.

[pathname]{.ins} [focus]{.sub} [item]{.optarg}
: Ist *item* angegeben, wird das Fokuselement auf *item* gesetzt. Andernfalls das aktuelle Fokuselement oder **{}**, wenn keines gesetzt ist.

[pathname]{.ins} [heading]{.sub} [column]{.arg} [-option ?value -option value...]{.optarg}
: Abfragen oder Ändern der Überschriftenoptionen der angegebenen *column*. Gültige Optionen:

    [-text]{.lit} [text]{.arg}
    : Im Spaltenkopf anzuzeigender Text.

    [-image]{.lit} [imageName]{.arg}
    : Bild rechts neben dem Spaltenkopf.

    [-anchor]{.lit} [anchor]{.arg}
    : Ausrichtung des Überschriftentexts. Einer der üblichen Tk-Ankerwerte.

    [-command]{.lit} [script]{.arg}
    : Skript, das beim Drücken auf die Überschrift ausgewertet wird.


    Verwenden Sie *pathname* **heading #0**, um die Baumspaltenüberschrift zu konfigurieren.

[pathname]{.ins} [identify]{.sub} [component]{.arg} [x]{.arg} [y]{.arg}
: Beschreibung des angegebenen *component* unter dem Punkt *x* und *y*, oder leere Zeichenkette, wenn dort kein solcher *component* liegt. *x* und *y* können jede von [Tk\_GetPixels][GetPixels] akzeptierte Form haben. Folgende Unterbefehle werden unterstützt:

    [pathname]{.ins} [identify]{.sub} [region]{.lit} [x]{.arg} [y]{.arg}
    : Gibt einen der folgenden Werte zurück:

        heading
        : Bereich der Baumüberschrift; \[**pathname identify column** *x y*\] liefert die Überschriftennummer.

        separator
        : Zwischenraum zwischen zwei Spaltenüberschriften; \[**pathname identify column** *x y*\] liefert die Anzeigespaltenkennung der Überschrift links vom Trenner.

        tree
        : Der Baumbereich.

        cell
        : Eine Datenzelle.


    [pathname]{.ins} [identify]{.sub} [item]{.lit} [x]{.arg} [y]{.arg}
    : Element-ID des Elements an Position *y*.

    [pathname]{.ins} [identify]{.sub} [column]{.lit} [x]{.arg} [y]{.arg}
    : Anzeigespaltenkennung der Zelle an Position *x*. Die Baumspalte hat die ID **#0**.

    [pathname]{.ins} [identify]{.sub} [cell]{.lit} [x]{.arg} [y]{.arg}
    : Zellenkennung an Position *x y*. Eine Zellenkennung ist eine Liste aus Element-ID und Spalten-ID.

    [pathname]{.ins} [identify]{.sub} [element]{.lit} [x]{.arg} [y]{.arg}
    : Das Element an Position *x,y*.

    [pathname]{.ins} [identify]{.sub} [row]{.lit} [x]{.arg} [y]{.arg}
    : Veraltetes Synonym für *pathname* **identify item**.


    Siehe [Spaltenidentifikatoren] zur Unterscheidung von Anzeige- und Datenspalten.

[pathname]{.ins} [index]{.sub} [item]{.arg}
: Ganzzahliger Index von *item* in der Kinderliste des Elternelements.

[pathname]{.ins} [insert]{.sub} [parent]{.arg} [index]{.arg} [[-id]{.lit} [id]{.arg}]{.optarg} [options...]{.arg}
: Erstellt ein neues Element. *parent* ist die Element-ID des Elternelements oder die leere Zeichenkette **{}** für ein neues Element der obersten Ebene. *index* ist eine Ganzzahl oder **end** und legt die Einfügeposition in der Kinderliste von *parent* fest. Ist *index* negativ oder null, wird das neue Element am Anfang eingefügt; ist *index* größer oder gleich der aktuellen Kinderanzahl, am Ende. Ist **-id** angegeben, wird es als Elementkennung verwendet; *id* darf im Baum noch nicht existieren. Andernfalls wird eine neue eindeutige Kennung erzeugt.

    *pathname* **insert** gibt die Elementkennung des neuen Elements zurück. Siehe [Elementoptionen] für verfügbare Optionen.

[pathname]{.ins} [item]{.sub} [item]{.arg} [-option ?value -option value...]{.optarg}
: Abfragen oder Ändern der Optionen von *item*. Ohne *-option* ein Dictionary der Option/Wert-Paare. Mit genau einem *-option* dessen Wert. Andernfalls Aktualisierung der Elementoptionen. Siehe [Elementoptionen].

[pathname]{.ins} [move]{.sub} [item]{.arg} [parent]{.arg} [index]{.arg}
: Verschiebt *item* auf Position *index* in der Kinderliste von *parent*. Ein Element unter einen eigenen Nachkommen zu verschieben ist unzulässig.

    Ist *index* negativ oder null, wird *item* an den Anfang verschoben; ist er größer oder gleich der Kinderanzahl, ans Ende.

[pathname]{.ins} [next]{.sub} [item]{.arg}
: Kennung des nächsten Geschwisterelements von *item* oder **{}**, wenn *item* das letzte Kind des Elternelements ist.

[pathname]{.ins} [parent]{.sub} [item]{.arg}
: ID des Elternelements von *item* oder **{}**, wenn *item* auf der obersten Hierarchieebene liegt.

[pathname]{.ins} [prev]{.sub} [item]{.arg}
: Kennung des vorherigen Geschwisterelements von *item* oder **{}**, wenn *item* das erste Kind ist.

[pathname]{.ins} [see]{.sub} [item]{.arg}
: Stellt sicher, dass *item* sichtbar ist: setzt alle Vorfahren von *item* auf **-open true** und scrollt bei Bedarf, sodass *item* im sichtbaren Baumbereich liegt.

[pathname]{.ins} [selection]{.sub} [selop itemList]{.optarg}
: Verwaltet die Elementauswahl. Unabhängig von der Zellauswahl des Befehls **cellselection**. Ist *selop* nicht angegeben, Liste der ausgewählten Elemente. Andernfalls ist *selop* einer der folgenden:

    [pathname]{.ins} [selection]{.sub} [set]{.lit} [itemList]{.arg}
    : *itemList* wird die neue Auswahl.

    [pathname]{.ins} [selection]{.sub} [add]{.lit} [itemList]{.arg}
    : *itemList* zur Auswahl hinzufügen.

    [pathname]{.ins} [selection]{.sub} [remove]{.lit} [itemList]{.arg}
    : *itemList* aus der Auswahl entfernen.

    [pathname]{.ins} [selection]{.sub} [toggle]{.lit} [itemList]{.arg}
    : Auswahlzustand jedes Elements in *itemList* umschalten.


[pathname]{.ins} [set]{.sub} [item]{.arg} [column]{.optarg} [value]{.optarg}
: Mit einem Argument Dictionary der Spalten/Wert-Paare für *item*. Mit zwei Argumenten aktueller Wert von *column*. Mit drei Argumenten wird der Wert von Spalte *column* in Element *item* auf *value* gesetzt. Siehe auch [Spaltenidentifikatoren].

[pathName]{.ins} [tag]{.sub} [args...]{.arg}
: Verwaltet Tags. Tags können auf Elementen und Zellen gesetzt werden. Die Tag-Menge ist für Elemente und Zellen gemeinsam. Element-Tagging und Zellen-Tagging sind jedoch unabhängig (ein Tag auf einem Element gilt nicht automatisch für dessen Zellen). Zellen-Tags haben beim Zeichnen Vorrang vor Element-Tags. Folgende Unterbefehle werden unterstützt:

    [pathName]{.ins} [tag]{.sub} [add]{.lit} [tag]{.arg} [items]{.arg}
    : Fügt *tag* jedem der aufgeführten *items* hinzu. Ist *tag* für ein Element bereits vorhanden, bleiben die **-tags** unverändert.

    [pathName]{.ins} [tag]{.sub} [bind]{.lit} [tagName]{.arg} [sequence]{.optarg} [script]{.optarg}
    : Tk-Bindungsskript für die Ereignissequenz *sequence* auf Tag *tagName*. Bei X-Ereignissen an einem Element werden Bindungen für jedes **-tags** des Elements der Reihe nach wie in *bindtags(n)* ausgewertet. Lässt sich das Ereignis einer Zelle zuordnen (z. B. Mausereignisse), werden auch Bindungen der **-tags** der Zelle ausgewertet.

        **<Key>**, **<KeyRelease>** und virtuelle Ereignisse gehen an das Fokuselement. **<Button>**, **<ButtonRelease>** und **<Motion>** an das Element unter dem Mauszeiger. Andere Ereignistypen werden nicht unterstützt.

        Das Bindungsskript *script* durchläuft **%-Ersetzungen** vor der Auswertung; siehe **bind**(n).

    [pathName]{.ins} [tag]{.sub} [cell]{.lit} [subcommand...]{.arg}
    : Verwaltet Tags auf einzelnen Zellen. *cellList* kann eine Zelle oder eine Liste von Zellen sein.

        [pathName]{.ins} [tag]{.sub} [cell]{.lit} [add]{.lit} [tag]{.arg} [cellList]{.arg}
        : Fügt *tag* jeder Zelle in *cellList* hinzu. Ist *tag* für eine Zelle bereits vorhanden, bleibt deren Tag-Liste unverändert.

        [pathName]{.ins} [tag]{.sub} [cell]{.lit} [has]{.lit} [tagName]{.arg} [cell]{.optarg}
        : Mit *cell*: 1 oder 0, ob die Zelle den Tag *tagName* hat. Ohne *cell*: Liste aller Zellen mit diesem Tag.

        [pathName]{.ins} [tag]{.sub} [cell]{.lit} [remove]{.lit} [tag]{.arg} [cellList]{.optarg}
        : Entfernt *tag* von jeder Zelle in *cellList*. Fehlt *cellList*, von jeder Zelle im Baum.


    [pathName]{.ins} [tag]{.sub} [configure]{.lit} [tagName]{.arg} [option]{.optarg} [value option value...]{.optarg}
    : Abfragen oder Ändern der Optionen von *tagName*. Mit *option/value*-Paaren werden Optionen gesetzt. Mit einer *option* deren Wert (oder leere Zeichenkette, wenn für *tagName* nicht gesetzt). Ohne weitere Argumente Dictionary der Optionen. Siehe [Tag-Optionen].

    [pathName]{.ins} [tag]{.sub} [delete]{.lit} [tagName]{.arg}
    : Löscht alle Tag-Informationen zu *tagName*. Entfernt den Tag von allen Elementen und Zellen und löscht zugehörige Daten wie Bindungen und Anzeigeinformationen. Gibt eine leere Zeichenkette zurück.

    [pathName]{.ins} [tag]{.sub} [has]{.lit} [tagName]{.arg} [item]{.optarg}
    : Mit *item*: 1 oder 0, ob das Element den Tag *tagName* hat. Ohne *item*: Liste aller Elemente mit diesem Tag.

    [pathName]{.ins} [tag]{.sub} [names]{.lit}
    : Liste aller vom Widget verwendeten Tags.

    [pathName]{.ins} [tag]{.sub} [remove]{.lit} [tag]{.arg} [items]{.optarg}
    : Entfernt *tag* von jedem Element in *items*. Fehlt *items*, von jedem Element im Baum. Ist *tag* für ein Element nicht vorhanden, bleiben die **-tags** unverändert.



# Elementoptionen

Die folgenden Elementoptionen können bei **insert** und **item** angegeben werden.

**-text**
: Textbeschriftung des Elements in der Baumspalte.

**-height**
: Höhe des Elements als ganzzahliges Vielfaches von **-rowheight**. Standard 1.

**-image**
: Tk-Bild neben der Beschriftung in der Baumspalte, positioniert gemäß **-imageanchor**.

**-imageanchor**
: Anzeige von **-image** relativ zum Text. Standard **w**. Einer der üblichen Tk-Ankerwerte.

**-values**
: Mit dem Element verknüpfte Werteliste.

    Jedes Element sollte so viele Werte haben wie die Widget-Option **-columns** Spalten vorsieht. Gibt es weniger Werte als Spalten, gelten die restlichen als leer. Gibt es mehr Werte als Spalten, werden die überschüssigen ignoriert.

**-hidden**
: Boolescher Wert, ob das Element angezeigt (**-hidden false**) oder ausgeblendet (**-hidden true**) wird. Ist ein Elternelement ausgeblendet, sind auch alle Nachkommen ausgeblendet.

**-open**
: Boolescher Wert, ob die Kinder angezeigt (**-open true**) oder ausgeblendet (**-open false**) werden.

**-tags**
: Liste der mit diesem Element verknüpften Tags.


# Tag-Optionen

Folgende Optionen können auf Tags gesetzt werden:

**-foreground**
: Vordergrundfarbe des Textes.

**-background**
: Hintergrundfarbe der Zelle oder des Elements.

**-font**
: Schriftart beim Zeichnen des Textes.

**-image**
: Bild der Zelle oder des Elements.

**-imageanchor**
: Bildanker der Zelle oder des Elements.

**-padding**
: Innenabstand der Zelle. Standard für Datenzellen {4 0}

**-stripedbackground**
: Hintergrundfarbe für abwechselnde Zeilen, wenn **-striped** true ist.


Tags auf Zellen haben Vorrang vor Tags auf Elementen. Die Tag-Priorität folgt der Erstellungsreihenfolge: zuerst erstellte Tags haben höhere Priorität. Elementoptionen wie **-image** und **-imageanchor** haben Vorrang vor Tags.

# Bilder

Die Option **-image** auf einem Element und auf einem Element-Tag steuert das Bild neben der Beschriftung in der Baumspalte. Andere Zellen können Bilder über die Zellen-Tag-Option **-image** erhalten.

# Spaltenidentifikatoren

Spaltenkennungen können folgende Formen annehmen:

- Ein symbolischer Name aus der Liste **-columns**.

- Eine Ganzzahl *n* für die *n*-te Datenspalte.

- Eine Zeichenkette der Form **#**_n_, wobei *n* eine Ganzzahl ist und die *n*-te Anzeigespalte bezeichnet.


Spaltenkennungen unterstützen dieselbe einfache Interpretation wie beim Befehl [string index][string], mit einfacher ganzzahliger Indexarithmetik und Indexierung relativ zu **end**.

**HINWEIS:** Die **-values** eines Elements können in anderer Reihenfolge angezeigt werden als gespeichert.

**HINWEIS:** Spalte #0 bezeichnet immer die Baumspalte, auch wenn **-show tree** nicht gesetzt ist.

Eine *Datenspaltennummer* ist ein Index in die **-values**-Liste eines Elements; eine *Anzeigespaltennummer* ist die Spaltennummer im Baum, in der die Werte erscheinen. Baumbeschriftungen stehen in Spalte #0. Ist **-displaycolumns** nicht gesetzt, wird Datenspalte *n* in Anzeigespalte **#**_n+1_ angezeigt. Erneut: **Spalte #0 ist immer die Baumspalte**.

# Virtuelle Ereignisse

Das Treeview-Widget erzeugt folgende virtuelle Ereignisse.

<<TreeviewSelect>>
: Wird ausgelöst, wenn sich Auswahl oder Zellauswahl ändert. Kann auch ausgelöst werden, wenn die Auswahl betroffen, aber nicht tatsächlich geändert wurde. Mehrere Auswahländerungen können vor der Ereignisverarbeitung erfolgen und mehrere Ereignisse mit gleicher sichtbarer Auswahl erzeugen.

<<TreeviewOpen>>
: Kurz bevor das Fokuselement auf **-open true** gesetzt wird.

<<TreeviewClose>>
: Kurz nachdem das Fokuselement auf **-open false** gesetzt wurde.


Die Widget-Befehle **focus** und **selection** liefern das betroffene Element bzw. die betroffenen Elemente.

# Stiloptionen

Der Klassenname für **ttk::treeview** ist **Treeview**. Der Klassenname der Treeview-Überschrift ist **Heading**. Der Klassenname eines Treeview-Elements ist **Item**. Der Klassenname einer Treeview-Zelle ist **Cell**.

Dynamische Zustände: **disabled**, **selected**.

**Treeview**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-background** *color*

**-fieldbackground** *color*

**-font** *font*

**-foreground** *color*

**-indent** *amount*
: Legt fest, wie weit Elemente von ihren Eltern eingerückt sind. Standard 20 Pixel. Der Wert kann jede von [Tk\_GetPixels][GetPixels] akzeptierte Form haben.


**-columnseparatorwidth** *amount*
: Breite der Spaltentrenner. Standard 1 Pixel. Der Wert kann jede von [Tk\_GetPixels][GetPixels] akzeptierte Form haben.


**-rowheight** *amount*
: Standardhöhe eines Elements. Standard 20 Pixel. Der Wert kann jede von [Tk\_GetPixels][GetPixels] akzeptierte Form haben. Ist **-rowheight** im Stil nicht gesetzt, wird sie durch Messen eines Elements und eines Zellenlayouts mit den Stileinstellungen bestimmt — damit werden Schriftart sowie Fokusring oder Innenabstand des Themes übernommen. **-rowheight** muss ggf. gesetzt werden, damit eine Zeile groß genug für Bilder ist.

    Beispiel zum Setzen von **-rowheight**, angepasst an eine Schriftart analog zum Standardwert:


```
ttk::style configure Treeview \
     -rowheight [expr {[font metrics font -linespace] + 2}]
```

**-stripedbackground** *color*

**Heading**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-background** *color*

**-font** *font*

**-relief** *relief*

**Item**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-foreground** *color*

**-indicatormargins** *padding*

**-indicatorsize** *amount*

**-padding** *padding*

**Cell**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-padding** *padding*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[bind]: bind.md
[GetInt]: ../tcl-c/GetInt.md
[GetPixels]: ../tk-c/GetPixels.md
[string]: ../tcl/string.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
