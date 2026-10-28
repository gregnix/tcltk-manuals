*NAME*
: **PanelFrame** - Rahmen mit einem umrahmten Titelbereich 


*ERZEUGUNG*
: PanelFrame *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
    |   [-text](options.md) |
    |   [-textvariable](options.md) |
    |   [-font](options.md) |   [-relief](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   -height |
    |   -width |
    |   -panelbackground |   -panelforeground |
    |   -ipad |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

BESCHREIBUNG

 PanelFrame erzeugt einen Rahmenbereich mit einem umrahmten Titelbereich. Der umrahmte Titelbereich enthält ein Label und erlaubt, weitere Einträge darin zu platzieren. Das kann wie eine kleine Werkzeugleiste dienen. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-height**
:  Legt die gewünschte Höhe für das Widget fest. 

**-ipad**
:  Der Abstand um die einzelnen Einträge des Panelbereichs. 

**-panelbackground**
:  Die Farbe für den Hintergrund des Panelbereichs. Voreingestellt ist die Hintergrundfarbe der Auswahlhervorhebung. 

**-panelforeground**
:  Die Farbe für den Titeltext. Voreingestellt ist die Vordergrundfarbe der Auswahlhervorhebung. 

**-width**
:  Legt die gewünschte Breite für das Widget fest. 


---

WIDGET-BEFEHL

*pathName* **add** **widget** ?*option* *value* *option* *value* ...? 
: Fügt dem Panel ein Widget hinzu. Die Widgets werden mit **pack** hineingelegt. Mögliche Optionen sind:

    **-side**
    : Seite, auf die der Eintrag gelegt wird (Vorgabe **right**).

    **-fill**
    : Ob der Platz gefüllt wird (Vorgabe **none**).

    **-expand**
    : Ob der Platz ausgedehnt wird (Vorgabe **0**).

    **-pad**
    : Überschreibt die Option **-ipad** des Widgets für diesen Eintrag.


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **delete** **widget** ?*widget* ...? 
:  Löscht ein Widget und den zugehörigen Zustand aus dem Panel.


*pathName* **getframe** 
:  Holt das Rahmen-Widget der Statusleiste, in dem die Einträge der Statusleiste erzeugt werden sollen.


*pathName* **items** 
: Liste der Einträge in der Statusleiste.
