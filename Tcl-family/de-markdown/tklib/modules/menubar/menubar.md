---
CommandName: menubar
ManualSection: n
Version: 0.5.1
TclPart: tklib
TclDescription: Create and manipulate menubars
Copyright:
 - Copyright (c) 2009 Tom Krehbiel <krehbiel.tom@gmail.com> All rights reserved.
---

# NAME

menubar – Erstellt eine Instanz der Klasse *menubar*.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6]{.lit} 
[package]{.cmd} [require]{.sub} [menubar]{.lit} [0.5.1]{.optlit} 
[menubar]{.cmd} [new]{.sub} [options]{.optarg} 
[mBarInst]{.ins} [define]{.sub} [body]{.arg} 
[mBarInst]{.ins} [install]{.sub} [pathName]{.arg} [body]{.arg} 
[mBarInst]{.ins} [menu.configure]{.sub} [option]{.arg} [tag-settings]{.arg} [option tag-settings]{.optdot} 
[mBarInst]{.ins} [menu.namespace]{.sub} [tag]{.arg} [namespace]{.arg} 
[mBarInst]{.ins} [menu.hide]{.sub} [tag]{.arg} 
[mBarInst]{.ins} [menu.show]{.sub} [tag]{.arg} 
[mBarInst]{.ins} [tag.add]{.sub} [tag]{.arg} [value]{.arg} 
[mBarInst]{.ins} [tag.configure]{.sub} [pathName]{.arg} [tag]{.arg} [option value ...option value]{.optarg} 
[mBarInst]{.ins} [tag.cget]{.sub} [pathName]{.arg} [tag]{.arg} [option]{.optarg} 
[mBarInst]{.ins} [group.add]{.sub} [tag]{.arg} [label]{.arg} [cmd]{.optarg} [accel]{.optarg} [sequence]{.optarg} [state]{.optarg} 
[mBarInst]{.ins} [group.delete]{.sub} [tag]{.arg} [label]{.arg} 
[mBarInst]{.ins} [group.move]{.sub} [direction]{.arg} [tag]{.arg} [label]{.arg} 
[mBarInst]{.ins} [group.configure]{.sub} [tag]{.arg} [label]{.arg} [option value ...option value]{.optarg} 
[mBarInst]{.ins} [group.serialize]{.sub} [tag]{.arg} 
[mBarInst]{.ins} [group.deserialize]{.sub} [tag]{.arg} [stream]{.arg} 
[mBarInst]{.ins} [notebook.addTabStore]{.sub} [pathname]{.arg} 
[mBarInst]{.ins} [notebook.deleteTabStore]{.sub} [pathname]{.arg} 
[mBarInst]{.ins} [notebook.setTabValue]{.sub} [pathname]{.arg} [tag]{.arg} 
[mBarInst]{.ins} [notebook.restoreTabValues]{.sub} [pathname]{.arg} 
:::

# BESCHREIBUNG

**menubar new** ?options?
: Erzeugt eine Instanz der Klasse menubar und gibt sie zurück. Die Klasse menubar kapselt Definition, Installation und das dynamische Verhalten einer Menüleiste. Sie hängt von keinem Rahmen ab und lässt sich mit oder ohne Rahmen verwenden, zum Beispiel Bwidget, IWidget oder Snit. Anders als andere Tk-Widget-Befehle hat der Befehl menubar kein Argument *pathName*, weil Menüleisten der Fenstermanager verwaltet, also wm, und nicht die Anwendung.


# OPTIONEN

Dem Befehl *menubar new* können die folgenden Optionen übergeben werden.

Diese Optionen werden vom Tk-Menü-Befehl übernommen; ihre Wirkung ist plattformabhängig.

[-activebackground](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-activebackground)
: ...siehe nächstes...

[-activeborderwidth](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-activeborderwidth)
: ...siehe nächstes...

[-activeforeground](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-activeforeground)
: ...siehe nächstes...

[-background](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-background)
: ...siehe nächstes...

[-borderwidth](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-borderwidth)
: ...siehe nächstes...

[-cursor](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-cursor)
: ...siehe nächstes...

[-disabledforeground](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-disabledforeground)
: ...siehe nächstes...

[-font](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-font)
: ...siehe nächstes...

[-foreground](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-foreground)
: ...siehe nächstes...

[-relief](http://docs.activestate.com/activetcl/8.5/tcl/TkCmd/options.htm#M-relief)
: 


# EINLEITUNG

Eine Instanz der Klasse „menubar“ stellt Methoden bereit, mit denen eine Beschreibung der Menüleiste erstellt, Menüeinträge konfiguriert und die Menüleiste in Toplevel-Fenstern eingebunden werden können.

Eine Menüleiste lässt sich als Baumstruktur aus verschachtelten Menüs vorstellen. Benutzer definieren eine Menüleiste mithilfe einer Sprache, die zu einer für Menschen lesbaren Beschreibung der Menüleiste führt. Die Beschreibung der Menüleiste wird anschließend von einer Instanz der Menüleisten-Klasse kompiliert, woraufhin sie in einem oder mehreren Toplevel-Fenstern installiert werden kann.

Die Menüleisten-Klasse bietet zahlreiche einzigartige Funktionen, die in anderen Tcl/Tk-Menüleisten-Implementierungen nicht zu finden sind. Dazu gehören unter anderem:

**•**
: Ein Tagging-System, das den Zugriff auf Menüeinträge in der Menüstruktur vereinfacht.

**•**
: Unterstützung für benutzerdefinierte Tags, die vom Kontext des Toplevel-Fensters abhängen.

**•**
: Eine vereinfachte und einheitliche Schnittstelle für alle Rückrufbefehle.

**•**
: Namespace-Unterstützung für alle Rückrufbefehle, sodass sie sich leicht in Namespaces gruppieren lassen.

**•**
: Unterstützung für das Ausblenden und Einblenden von Menüs in der Menüleiste.

**•**
: Eine vereinfachte Methode zum Erstellen von Radiobutton-Gruppen.

**•**
: Automatische Verwaltung der Zustandsvariablen von Checkbuttons und Radiobuttons.

**•**
: Steuerung des Gültigkeitsbereichs der Zustandsvariablen von Checkbuttons und Radiobuttons.

**•**
: Verwaltung der Abreißmenüs, die sicherstellt, dass nur ein Abreißmenü erstellt wird.

**•**
: Unterstützung für die dynamische Menü-Erweiterung zur Vereinfachung der Erstellung von Menüs mit zuletzt verwendeten Dokumenten.

**•**
: Unterstützung für das Speichern und Wiederherstellen dynamischer Menüerweiterungen.


# BEGRIFFSBESTIMMUNGEN

**MENUBAR**
: Die sichtbare Menüleiste in einem Toplevel-Fenster ist eine waagerechte Gruppe kaskadierender Tk-Menüs.

**MENU**
: Ein Menü ist eine geordnete Liste von Einträgen und wird senkrecht dargestellt. Sichtbar wird es erst, wenn eine Aktion erfolgt, normalerweise ein Ereignis \<ButtonPress-1>. Ein Menü kann beliebig viele Kindmenüs enthalten, die als kaskadierende Menüs dargestellt werden. Kaskadierende Menüs erscheinen bei der Aktivierung neben dem Elternmenü.

**MENU ENTRY**
: Ein Menü enthält eine geordnete Liste von Einträgen. Menüeinträge haben einen Typ. Die Klasse menubar unterstützt diese sechs Eintragstypen: *Command*, *Checkbutton*, *Radiobutton*, *Separator*, *Group* und *Menu*.

**ENTRY LABEL**
: Jeder Menüeintrag verfügt über eine sichtbare Zeichenfolge, die als Eintragsbezeichnung bezeichnet wird.

**TAG**
: Ein Tag ist ein Name, der normalerweise verwendet wird, um auf einen Eintrag in einem Menübaum zu verweisen. Ein Tag-Name ist eine alphanumerische Zeichenfolge, die das Unterstrichzeichen enthalten darf. Menübaum-Tags werden für alle Knoten und Endelemente in einem Menübaum definiert. Dies bietet eine flache Abstraktion des Baums und vereinfacht die Referenzierung von Elementen in Menüleisten-Methoden. Ohne diese Abstraktion wäre es notwendig, auf Menüelemente über einen Pfad zu verweisen, der sich zur Laufzeit ändern könnte. Die Menubar-Klasse verfügt zudem über eine Methode, mit der ein benutzerdefiniertes Tag erstellt werden kann. Benutzerdefinierte Tags speichern Werte, die sich je nach dem aktuell aktiven Toplevel-Fenster ändern. Benutzerdefinierte Tags können verwendet werden, um Widget-Pfadnamen zu speichern, die von Rückruffunktionen verwendet werden, sodass die Ausgabe an das entsprechende Toplevel-Fenster weitergeleitet werden kann.


# METHODEN

*mBarInst* **define** *body*
: Wandelt *body* in einen Baum aus Menüeinträgen um, die das visuelle Layout der Menüleiste definieren. Das Argument *body* beschreibt das Layout anhand der folgenden Syntax, deren Elemente im Folgenden erläutert werden. *body == definitions*


```
definitions    ::= { <ignore> | <definition> | <definition> <definitions> }
ignore         ::= { <nl> | <white-space> <nl> | # <comment> <nl> }
definition     ::= { <command> | <checkbutton> | <radiobutton> | <separator> | <group> | <menu> }
command        ::= <label> C <tag> <nl>
checkbutton    ::= <label> X<scope> { <tag> | <tag>+ } <nl>
radiobutton    ::= <label> R<scope> { <tag> | <tag>+ } <nl>
separator      ::= <stext> S <tag> <nl>
group          ::= <dummy> G <tag> <nl>
menu           ::= <label> { M:<tag> | M:<tag>+ } <nl> <definitions>
stext          ::= '--' | <label>
scope          ::= '' | '@' | '='
```

:  


**C - Command**
: Der Eintrag vom Typ C ist der häufigste Eintragstyp. Dieser Eintrag führt bei seiner Ausführung einen Befehl aus.

**X - Checkbutton**
: Ein Eintrag vom Typ X verhält sich weitgehend wie ein Tk-Checkbutton. Aufgerufen wechselt er zwischen ausgewählt und nicht ausgewählt. Der Wert eines Checkbuttons ist ein boolescher Wert, also 1 oder 0. Voreingestellt sind alle Checkbuttons nicht ausgewählt. Soll der Checkbutton anfangs ausgewählt sein, steht hinter dem Tag-Namen ein Plus (+). Den Gültigkeitsbereich beschreibt der Abschnitt **STEUERUNG DES GÜLTIGKEITSBEREICHS**.

**R - Radiobutton**
: Ein Menüeintrag vom Typ R verhält sich weitgehend wie ein Tk-Radiobutton. Jeder Radiobutton-Eintrag gehört zu einer Radiobutton-Gruppe, die das Verhalten der Radiobuttons in der Gruppe steuert. Alle Radiobuttons einer Gruppe haben denselben Tag-Namen. Im Beispiel unten haben Red, Green und Blue denselben Tag und gehören damit zur selben Gruppe. Ein Plus (+) hinter dem Tag-Namen macht den Eintrag zum anfangs ausgewählten. Den Gültigkeitsbereich beschreibt der Abschnitt **STEUERUNG DES GÜLTIGKEITSBEREICHS**.

**S - Separator**
: Ein Menüeintrag vom Typ „S“ ist ein Eintrag, der entweder als horizontale Trennlinie oder als Beschriftung angezeigt wird. Trennzeichen sind keine aktiven Elemente eines Menüs und lösen beim Aufruf kein bestimmtes Verhalten aus. Ist \<stext> zwei Bindestriche, also '--', erscheint das Trennzeichen als waagerechte Linie. Sonst erscheint \<stext> als fette Beschriftung zwischen doppelten Bindestrichen, zum Beispiel "-- \<stext> --", mit dem Hintergrund lightgray.

**G - Command Group**
: Der Menüeintrag vom Typ „G“ kennzeichnet eine Stelle im Menübaum, an der Einträge dynamisch hinzugefügt und entfernt werden können. Eine Menüerweiterung kann nur am Ende eines Menüs erfolgen, daher müssen Einträge vom Typ „G“ der letzte Eintrag in einem Menü sein. Ein Eintrag vom Typ „G“ wird als Trennlinie dargestellt. Die Unterbefehle *group.\<xxx>* dienen zur Bearbeitung von Befehlsgruppeneinträgen.

**M - Menu**
: Ein Eintrag vom Typ „M“ wird sowohl zur Definition von Menüs in der Menüleiste als auch von kaskadierenden Menüs verwendet. Menüeinträge sind die komplexesten der sechs Menütypen. Ein Menüeintrag besteht aus drei Listenelementen. Das erste Element der Liste ist seine Bezeichnung. Das zweite Element der Liste ist eine zusammengesetzte Zeichenkette, bestehend aus einer Typkennung (M), gefolgt von einem optionalen Tag (das mit einem Trennzeichen „:“ beginnt) und schließlich einem optionalen Plus (+), das ein Abreißmenü kennzeichnet. Das letzte Element der Liste ist ein LISTENWERT.


*mBarInst* **install** *pathName body*
: Die Methode *install* setzt die mit *define* erzeugte Menüleiste in das Toplevel-Fenster *pathName*. Das Argument *body* enthält ein Tcl-Skript, das die eingesetzte Menüleiste initialisiert. Normalerweise ruft das Skript dazu verschiedene Methoden von menubar auf. Der Initialisierungscode läuft nur einmal, beim Einsetzen der Menüleiste. Der Namespace, in dem *install* ausgeführt wird, wird der voreingestellte Namespace der Rückrufbefehle. Einzelheiten stehen unten bei *menu.namespace*.


# METHODEN – MENU.XXX

*mBarInst* **menu.configure** *option tag-settings ?option tag-settings ...?*
: Konfiguriert die Tags einer Menüleiste und gibt eine leere Zeichenkette zurück. Diese Methode bietet eine bequeme Möglichkeit, eine größere Anzahl von Tags zu konfigurieren, ohne dass die *tag.configure*-Methode mit ihrem hohen Schreibaufwand verwendet werden muss.


*option*
: *Option* kann jeden der Werte annehmen, die von der Methode *tag.configure* akzeptiert werden.

*tag-settings*
: Das Argument *tag-settings* ist eine Zeichenkette, die unter Verwendung der folgenden Syntax in eine Liste von Tag-Wert-Paaren umgewandelt wird. Syntax für *tag-settings*.


```
tag-settings ::= { <ignore> | <value> | <value> <tag-settings> }
ignore       ::= { <nl> | <white-space> <nl> | # <comment> <nl> }
value        ::= <tag> <option-value> <nl>
```

*mBarInst* **menu.namespace** *tag namespace*
: Ändert den Namespace eines Teilbaums der Menüleiste ab dem Eintrag *tag*. Der neue Wert ist *namespace*. Jeder Eintrag im Baum hat einen Namespace für seine Rückrufprozedur. Voreingestellt ist der Namespace, in dem *install* ausgeführt wurde. Mit dieser Methode lässt sich der Namespace der Rückrufe in einem Teilbaum ändern. Sie gilt nur in einem *install*-Skript.

*mBarInst* **menu.hide** *tag*
: Entfernt (verbirgt) einen Eintrag der Menüleiste. Beim Definieren des Baums sind alle Einträge sichtbar. Mit dieser Methode lässt sich ein Eintrag verbergen. Die Methoden *hide* können in einem *install*-Skript stehen, sodass ein Menü beim Start der Anwendung zunächst verborgen ist. *tag* ist der Tag-Name des zu verbergenden Menüs.

*mBarInst* **menu.show** *tag*
: Zeigt einen verborgenen Eintrag der Menüleiste wieder. Beim Definieren des Baums sind alle Einträge sichtbar. Ein mit menu.hide verborgener Eintrag lässt sich mit show wieder zeigen. *tag* ist der Tag-Name des zu zeigenden Menüs.


# METHODEN – TAG.XXX

*mBarInst* **tag.add** *tag value*
: Fügt einen benutzerdefinierten Wert *tag* hinzu. *tag.add* ergänzt die für eine Menüleiste definierten Tags um ein Tag-Wert-Paar. Benutzerdefinierte Tags unterscheiden sich von den Tags aus *define*. *tag.add* gilt nur in einem *install*-Skript, und der Wert hängt am Toplevel, in dem die Menüleiste eingesetzt ist. Das Tag ist damit kontextabhängig: Rückrufcode, der den Tag-Wert abfragt, erhält den Wert des Fensters, das den Rückruf ausgeführt hat.

*mBarInst* **tag.configure** *pathName tag ?option value ...option value?*
: Konfiguriert zum *pathName* eines Toplevel-Fensters und einem *tag* den zugehörigen Menüeintrag und gibt die leere Zeichenkette zurück.


*Standardoptionen*
: Diese Optionen sind dieselben wie die der Menüeinträge in der Tk-Dokumentation zu *menu*.


**-activebackground**
: ...siehe nächstes...

**-activeforeground**
: ...siehe nächstes...

**-background**
: ...siehe nächstes...

**-bitmap**
: ...siehe nächstes...

**-columnbreak**
: ...siehe nächstes...

**-compound**
: ...siehe nächstes...

**-font**
: ...siehe nächstes...

**-foreground**
: ...siehe nächstes...

**-hidemargin**
: ...siehe nächstes...

**-image**
: ...siehe nächstes...

**-indicatoron**
: ...siehe nächstes...

**-label**
: ...siehe nächstes...

**-selectcolor**
: ...siehe nächstes...

**-selectimage**
: ...siehe nächstes...

**-state**
: 


:  


**Klassenspezifische Optionen**
: 


**-bind** {uline accel sequence}
: Der Wert der Option *-bind* ist eine Liste mit drei Elementen, deren Werte wie folgt lauten.


**uline**
: Ein ganzzahliger Index für ein Zeichen, das im Eintrag unterstrichen werden soll. Dieser Wert hat dieselbe Funktion wie die Tk-Menüoption *-underline*. Ist dieser Wert eine leere Zeichenkette, wird keine Unterstreichung vorgenommen.

**accel**
: Eine Zeichenkette, die rechts neben dem Menüeintrag angezeigt werden soll. Die Zeichenkette beschreibt in der Regel eine Tastenkombination, die eingegeben werden kann, um dieselbe Funktion wie der Menüeintrag aufzurufen. Dieser Wert hat dieselbe Funktion wie die Tk-Option *menu* -accelerator. Wenn dieser Wert eine leere Zeichenkette ist, wird keine Tastenkombination angezeigt.

**sequence**
: Eine Bindsequenz, die den zum Eintrag gehörenden Befehl auslöst.


**-command** cmdprefix
: Der Wert der Option *-command* ist ein Befehlspräfix, das beim Aufruf des Menüeintrags ausgewertet wird. Voreingestellt wird der Rückruf in dem Namespace ausgewertet, in dem *install* ausgeführt wurde. Weitere Werte werden an *cmdprefix* angehängt und so als Argumente an den Rückrufbefehl übergeben. Diese zusätzlichen Argumente stehen in der folgenden Liste.


**command entry**
: 1) Der Pfadname des Toplevel-Fensters, das die Rückruffunktion ausgelöst hat.

**checkbutton entry**
: 1) Der Pfadname des Toplevel-Fensters, das den Rückruf ausgelöst hat. 2) Der Tag-Name des Checkbuttons. 3) Der neue Wert des Checkbuttons.

**radiobutton entry**
: 1) Der Pfadname des Toplevel-Fensters, das den Rückruf ausgelöst hat. 2) Der Tag-Name des Radiobuttons. 3) Die Beschriftung der ausgewählten Schaltfläche.

**group entry**
: 1) Der Pfadname des Toplevel-Fensters, das die Rückruffunktion ausgelöst hat.


*mBarInst* **tag.cget** *pathName tag ?option?*
: Gibt den Wert der durch *option* angegebenen Konfigurationsoption oder den Wert eines benutzerdefinierten Tags zurück. Das Argument „option“ kann eine beliebige Option sein, die von der Methode *tag.configure* für den Typ *tag* akzeptiert wird. Benutzerdefinierte Tags werden ohne einen *option*-Wert abgefragt.


# METHODEN – GROUP.XXX

*mBarInst* **group.add** *tag label ?cmd? ?accel? ?sequence? ?state?*
: Fügt der Gruppe mit dem Tag-Namen *tag* einen Befehl hinzu. Die Methode hängt einen neuen Befehlseintrag ans Ende einer Befehlsgruppe. Die Reihenfolge der Argumente ist fest, Argumente rechts dürfen entfallen. Die Argumente bedeuten:


tag *(string)*
: Der Tag-Name der Befehlsgruppe.

label *(string)*
: Die angezeigte Beschriftung des Menüeintrags.

cmd *(string)*
: Ein Befehlspräfix für den Rückrufbefehl.

accel *(string)*
: Eine Accelerator-Zeichenkette, die neben der Eintragsbeschriftung erscheint.

sequence *(string)*
: Eine Bindsequenz, die an den Rückrufbefehl gebunden wird.

state *(enum)*
: Setzt den Zustand des Befehls. Einer von normal, disabled, active.


*mBarInst* **group.delete** *tag label*
: Löscht einen Befehl aus der Gruppe mit dem Tag-Namen *tag*. Die Methode löscht den Befehl *label* aus einer Befehlsgruppe.

*mBarInst* **group.move** *direction tag label*
: Ändert die Position eines Eintrags in der Gruppe mit dem Tag-Namen *tag*. *direction* ist die Richtung, up oder down, in die der Eintrag wandert. Der Eintrag heißt *label*.

*mBarInst* **group.configure** *tag label ?option value ...option value?*
: Konfiguriert die Optionen eines Eintrags in der Befehlsgruppe mit dem Tag-Namen *tag*. Die Methode entspricht *tag.configure*, gilt aber für Einträge einer Befehlsgruppe. Die Optionen eines Befehlseintrags stehen oben bei *tag.configure*.

*mBarInst* **group.serialize** *tag*
: Gibt eine Zeichenfolgen-Serialisierung der Einträge in einer Befehlsgruppe zurück. Das Argument *tag* ist der Tag-Name der Gruppe, die serialisiert werden soll. Die resultierende Serialisierung ist eine Liste, die drei Elemente enthält: (1) den Namen des Tags der Gruppe, (2) ein Dictionary mit Optionen auf Gruppenebene und (3) eine Liste aus null oder mehr ähnlichen Dreierlisten, die die Einträge in der Gruppe beschreiben.

*mBarInst* **group.deserialize** *tag stream*
: Ersetzt den Inhalt der Gruppe *tag* durch die Befehle in der Serialisierung *stream*. Der bisherige Inhalt der Gruppe geht verloren.


# METHODEN – NOTEBOOK.XXX

*mBarInst* **notebook.addTabStore** *pathname*
: Diese Methode gehört in Code, der eine neue Notebook-Registerkarte erzeugt. Der Aufruf legt einen Zustandsspeicher für die neue Registerkarte an. Der Pfadname der Notebook-Registerkarte ist das Argument.

*mBarInst* **notebook.deleteTabStore** *pathname*
: Gibt den Zustandsspeicher einer Notebook-Registerkarte frei. Der Pfadname der Registerkarte ist das Argument.

*mBarInst* **notebook.setTabValue** *pathname tag*
: Diese Methode gehört in den Rückruf von Checkbuttons oder Radiobuttons der Menüleiste mit Gültigkeitsbereich einer Notebook-Registerkarte. Der Aufruf schiebt den zum Tag gehörenden Wert in den Speicher der durch den Pfadnamen bezeichneten Registerkarte.

*mBarInst* **notebook.restoreTabValues** *pathname*
: Diese Methode gehört in ein Bindskript, das das Ereignis <\<NotebookTabChanged>> eines Notebooks auslöst.


# STEUERUNG DES GÜLTIGKEITSBEREICHS

Standardmäßig sieht eine Menüleisten-Instanz in allen installierten Toplevel-Fenstern gleich aus. Werden an einer Instanz einer Menüleiste Änderungen vorgenommen, werden alle anderen Instanzen sofort aktualisiert. Das bedeutet, dass der interne Zustand aller Menüeinträge für die Instanzen synchronisiert wird. Dieses Verhalten wird als globale Steuerung des Menüleisten-Zustands bezeichnet.

Die Klasse menubar erlaubt eine feinere Steuerung des Gültigkeitsbereichs bei Checkbuttons und Radiobuttons. Der Gültigkeitsbereich dieser Eintragstypen ändert sich durch ein Zusatzzeichen am Typzeichen. Zwei Zusatzzeichen werden unterstützt, wie die Tabelle zeigt.

```
''  ::= global scope (no character)
'@' ::= local scope modifier
'=' ::= notebook tab scope modifier
```

Wenn das Zeichen für den lokalen Geltungsbereich (@) zur Definition einer Schaltfläche hinzugefügt wird, erhält die Schaltfläche für jedes installierte Toplevel-Fenster eine neue Variable. Dies bewirkt, dass der Zustand der Schaltfläche auf das jeweilige Fenster beschränkt ist (d. h. lokaler Geltungsbereich). Ein Beispiel ist eine Statusleiste, die ein Checkbutton ein- und ausschaltet. Der Entwickler möchte dem Benutzer möglicherweise ermöglichen, die Sichtbarkeit der Statusleiste für jedes Fenster einzeln zu steuern. In diesem Fall würde dem Selektor der Statusleiste ein lokaler Modifikator hinzugefügt, sodass die Rückruffunktion einen entsprechenden Wert basierend auf dem aktuellen Toplevel-Fenster erhält.

Das Zeichen für den Gültigkeitsbereich einer Notebook-Registerkarte (=) wirkt ähnlich wie das Zeichen für den lokalen Gültigkeitsbereich, nur dass auch die Auswahl einer Notebook-Registerkarte den Zustand einer Schaltfläche führen kann. Der Zusatz schaltet diese Steuerung ein. Die Unterbefehle notebook.xxxx müssen die Zustandswerte dann führen, wenn Registerkarten hinzukommen, gelöscht oder ausgewählt werden.

# BEISPIEL

```
package require Tcl
package require Tk
package require menubar

set tout [text .t -width 25 -height 12]
pack ${tout} -expand 1 -fill both
set mbar [menubar new \
    -borderwidth 4 \
    -relief groove  \
    -foreground black \
    -background tan \
    ]
${mbar} define {
    File M:file {
        Exit                 C      exit
    }
    Edit M:items+ {
    #   Label               Type    Tag Name(s)
    #   -----------------   ----    ---------
        "Cut"               C       cut
        "Copy"              C       copy
        "Paste"             C       paste
        --                  S       s2
        "Options" M:opts {
            "CheckList" M:chx+ {
                Coffee      X       coffee+
                Donut       X       donut
                Eggs        X       eggs
                }
            "RadioButtons" M:btn+ {
                "Red"       R       color
                "Green"     R       color+
                "Blue"      R       color
                }
        }
    }
    Help M:help {
        About               C       about
    }
}
${mbar} install . {
    ${mbar} tag.add tout ${tout}
    ${mbar} menu.configure -command {
        # file menu
        exit            {Exit}
        # Item menu
        cut             {CB Edit cut}
        copy            {CB Edit copy}
        paste           {CB Edit paste}
        # boolean menu
        coffee          {CB CheckButton}
        donut           {CB CheckButton}
        eggs            {CB CheckButton}
        # radio menu
        color           {CB RadioButton}
        # Help menu
        about           {CB About}
    } -bind {
        exit        {1 Cntl+Q  Control-Key-q}
        cut         {2 Cntl+X  Control-Key-x}
        copy        {0 Cntl+C  Control-Key-c}
        paste       {0 Cntl+V  Control-Key-v}
        coffee      {0 Cntl+A  Control-Key-a}
        donut       {0 Cntl+B  Control-Key-b}
        eggs        {0 Cntl+C  Control-Key-c}
        about       0
    } -background {
        exit red
    } -foreground {
        exit white
    }
}
proc pout { txt } {
    global mbar
    set tout [${mbar} tag.cget . tout]
    ${tout} insert end "${txt}\n"
}
proc Exit { args } {
    puts "Goodbye"
    exit
}
proc CB { args } {
    set alist [lassign ${args} cmd]
    pout "${cmd}: [join ${alist} {, }]"
}
wm minsize . 300 300
wm geometry . +4+4
wm protocol . WM_DELETE_WINDOW exit
wm title . "Example"
wm focusmodel . active
pout "Example started ..."
```

# EINSCHRÄNKUNGEN

Diese Implementierung nutzt TclOO und erfordert daher Version 8.6. Der Code wurde unter Windows (Vista), Linux und OSX (10.4) getestet.

# LITERATUR

Siehe auch

**\[1\]**
: [menu](http://www.tcl-lang.org/man/tcl8.6/TkCmd/menu.htm)

**\[2\]**
: [Ein Befehl, der Menüleistenobjekte erzeugt](http://wiki.tcl-lang.org/25231)


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *menubar* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) 2009 Tom Krehbiel <krehbiel.tom@gmail.com> All rights reserved.
```
