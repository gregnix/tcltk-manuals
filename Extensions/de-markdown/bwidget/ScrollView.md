*NAME*
: **ScrollView** - den sichtbaren Bereich eines gescrollten Fensters anzeigen 


*ERZEUGUNG*
: ScrollView *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

|   |   |
| --- | --- |
|   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
|   [-cursor](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -fill |
|   -height |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

BESCHREIBUNG

 ScrollView zeigt den sichtbaren Bereich eines gescrollten Fensters innerhalb seines Scrollbereichs an. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-fill**
:  Legt die Füllfarbe des Rechtecks fest. 


**-foreground**
:  Legt die Farbe des Randes des Rechtecks fest. 


**-height**
:  Legt die gewünschte Höhe für das ScrollView fest. 


**-width**
:  Legt die gewünschte Breite für das ScrollView fest. 


**-window**
:  Legt das Fenster fest, das angezeigt wird. Dieses Widget muss die Optionen **-xscrollcommand** und **-yscrollcommand** haben und auf die Befehle **xview** und **yview** antworten. Damit ScrollView mit einer anderen Bildlaufleiste zusammenarbeitet, müssen die Optionen **-xscrollcommand** und **-yscrollcommand** des Widgets gesetzt werden, bevor das Widget an die Option **-window** des ScrollView übergeben wird (wenn das Widget zum Beispiel von einem ScrolledWindow verwaltet wird, **setwidget** aufrufen, bevor die Option **-window** gesetzt wird). 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


---

BINDUNGEN
