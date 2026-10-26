*NAME*
: **ScrollableFrame** - scrollbarer Rahmen, der ein Widget enthält 


*ERZEUGUNG*
: ScrollableFrame *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

|   |   |
| --- | --- |
|   [-background oder -bg](options.md) |   [-xscrollcommand](options.md) |
|   [-yscrollcommand](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -areaheight |
|   -areawidth |
|   -constrainedheight |
|   -constrainedwidth |
|   -height |
|   -width |
|   -xscrollincrement |
|   -yscrollincrement |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 

: *pathName* see *widget* ?*vert*? ?*horz*? 

: *pathName* xview ?*arg...*? 

: *pathName* yview ?*arg...*? 


---

BESCHREIBUNG

 Das Widget ScrollableFrame, das ein Widget enthält. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-areaheight**
:  Legt die Höhe des scrollbaren Bereichs fest. Wenn null, wird die Höhe des scrollbaren Bereichs gerade groß genug gemacht, um alle seine Kinder aufzunehmen. 


**-areawidth**
:  Legt die Breite des scrollbaren Bereichs fest. Wenn null, wird die Breite des Fensters des scrollbaren Bereichs gerade groß genug gemacht, um alle seine Kinder aufzunehmen. 


**-constrainedheight**
:  Legt fest, ob der scrollbare Bereich dieselbe Höhe wie das gescrollte Fenster haben soll. Wenn true, wird keine senkrechte Bildlaufleiste gebraucht. 


**-constrainedwidth**
:  Legt fest, ob der scrollbare Bereich dieselbe Breite wie das gescrollte Fenster haben soll. Wenn true, wird keine waagerechte Bildlaufleiste gebraucht. 


**-height**
:  Legt die gewünschte Höhe für das Fenster in Pixeln fest. 


**-width**
:  Legt die gewünschte Breite für das Fenster in Pixeln fest. 


**-xscrollincrement**
:  Siehe die Option **xscrollincrement** des Widgets **canvas**. 


**-yscrollincrement**
:  Siehe die Option **yscrollincrement** des Widgets **canvas**. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **getframe** 
:  Gibt den Pfadnamen des gescrollten Rahmens zurück, in dem das Widget erzeugt werden sollte. 


*pathName* **see** *widget* ?*vert*? ?*horz*? 
:  Ordnet den scrollbaren Bereich so an, dass *widget* im Fenster sichtbar ist. *vert* und *horz* geben an, welcher Teil von *widget* vorzugsweise sichtbar sein soll, wenn *widget* zu hoch oder zu breit ist, um ganz sichtbar zu sein. *vert* muss **top** (die Vorgabe) oder **bottom** sein, und *horz* muss **left** (die Vorgabe) oder **right** sein. Wenn *vert* oder *horz* kein gültiger Wert ist, wird der Bereich in dieser Richtung nicht gescrollt. 


*pathName* **xview** ?*arg...*? 
:  Standardbefehl, um das waagerechte Scrollen von *pathName* zu ermöglichen. 


*pathName* **yview** ?*arg...*? 
:  Standardbefehl, um das senkrechte Scrollen von *pathName* zu ermöglichen.
