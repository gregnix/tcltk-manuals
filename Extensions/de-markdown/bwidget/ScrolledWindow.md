*NAME*
: **ScrolledWindow** - allgemeines gescrolltes Widget 


*ERZEUGUNG*
: ScrolledWindow *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

|   |   |
| --- | --- |
|   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
|   [-relief](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -auto |
|   -ipad |
|   -managed |
|   -scrollbar |
|   -sides |
|   -size |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 

: *pathName* setwidget *widget* 


---

BESCHREIBUNG

 ScrolledWindow ermöglicht, leicht ein Widget mit seiner Bildlaufleiste zu erzeugen. Die Bildlaufleisten erzeugt ScrolledWindow, und die Scrollbefehle werden mit **ScrolledWindow::setwidget** automatisch einem scrollbaren Widget zugeordnet. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-auto**
:  Legt die gewünschte automatisch verwaltete Bildlaufleiste fest: none bedeutet, die Bildlaufleisten werden immer gezeichnet, horizontal bedeutet, die waagerechte Bildlaufleiste wird bei Bedarf gezeichnet, vertical bedeutet, die senkrechte Bildlaufleiste wird bei Bedarf gezeichnet, both bedeutet, waagerechte und senkrechte Bildlaufleisten werden bei Bedarf gezeichnet (Vorgabewert) 


**-ipad (nur lesbar)**
:  Abstand in Pixeln zwischen dem Client-Widget und den Bildlaufleisten. Vorgabewert: **1**. 


**-managed (nur lesbar)**
:  Wenn true, werden die Bildlaufleisten bei der Erzeugung verwaltet, ihre Größe geht also in die verlangte Größe des ScrolledWindow ein. Wenn false, dann nicht. Vorgabewert: **true**. 


**-scrollbar**
:  Legt die gewünschte Bildlaufleiste fest: **none**, **horizontal**, **vertical** oder **both** (Vorgabewert). 


**-sides (nur lesbar)**
:  Seite der Bildlaufleisten. Mögliche Werte sind: **ne**, **en**, **nw**, **wn**, **se** (Vorgabewert), **es**, **sw**, **ws**. 


**-size (nur lesbar)**
:  Größe der Bildlaufleisten in Pixeln. 0 steht für die Standardgröße (Vorgabewert). 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **getframe** 
:  Gibt den Pfadnamen des Rahmens zurück, in dem das gescrollte Widget erzeugt werden sollte. Dieser Befehl wird nicht mehr gebraucht. Das gescrollte Widget kann unmittelbar als Kind von *pathName* erzeugt werden. 


*pathName* **setwidget** *widget* 
:  Ordnet *widget* den Bildlaufleisten zu. *widget* wird vom ScrolledWindow verwaltet. *widget* sollte nicht selbst verwaltet werden, solange das ScrolledWindow es verwaltet. *widget* muss ein scrollbares Widget sein, das heißt die Optionen **xscrollcommand**/**yscrollcommand** und die Befehle **xview**/**yview** haben, wie canvas oder text.
