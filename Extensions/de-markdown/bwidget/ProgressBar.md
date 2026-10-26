*NAME*
: **ProgressBar** - Widget für eine Fortschrittsanzeige 


*ERZEUGUNG*
: ProgressBar *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

|   |   |
| --- | --- |
|   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
|   [-foreground oder -fg](options.md) |   [-orient](options.md) |
|   [-relief](options.md) |
|   [-troughcolor](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -height |
|   -maximum |
|   -type |
|   -variable |
|   -width |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

BESCHREIBUNG

 Das Widget ProgressBar zeigt den Fortschritt einer langwierigen Operation an. Es wird von [MainFrame](MainFrame.md) und [ProgressDlg](ProgressDlg.md) verwendet. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-height**
:  Legt die gewünschte Höhe der Fortschrittsanzeige fest. 


**-maximum**
:  Legt den Höchstwert der Variable fest. Dieser Wert muss größer als null sein. 


**-type**
:  Legt den Typ der ProgressBar fest. Muss einer der Werte **normal**, **incremental**, **infinite** oder **nonincremental_infinite** sein.   
    
  Wenn **type** *normal* ist, wird die Fortschrittsanzeige jedes Mal, wenn die Variable gesetzt wird, im Verhältnis zum Wert der Variable und zur Option **maximum** gezeichnet.   
    
  Wenn **type** *incremental* ist, wird der Wert der Fortschrittsanzeige intern gehalten und jedes Mal, wenn die Variable gesetzt wird, um ihren Wert erhöht. Die Fortschrittsanzeige wird im Verhältnis zum internen Wert und zur Option **maximum** gezeichnet.   
    
  Wenn **type** *infinite* ist, wird der Wert der Fortschrittsanzeige intern gehalten und jedes Mal, wenn die Variable gesetzt wird, um ihren Wert erhöht. Die Fortschrittsanzeige bewegt sich von links nach rechts, wenn der interne Wert (modulo **maximum**) kleiner als **maximum**/2 ist, und von rechts nach links, wenn der interne Wert größer als **maximum**/2 ist.   
    
  Wenn **type** *nonincremental_infinite* ist, wird der Wert der Fortschrittsanzeige aus dem Wert der Variable genommen. Die Fortschrittsanzeige bewegt sich von links nach rechts, wenn der Wert der Variable (modulo **maximum**) kleiner als **maximum**/2 ist, und von rechts nach links, wenn der interne Wert größer als **maximum**/2 ist.   
    
  Der Sonderfall des Wertes steht bei der Option **-variable**,   
    
  Der Vorgabewert für **type** ist *normal*. 


**-variable**
:  Legt die Variable fest, die an die Fortschrittsanzeige gebunden ist. Die Fortschrittsanzeige wird aktualisiert, wenn sich der Wert der Variable ändert. Wenn der Wert der Variable negativ ist, wird die Fortschrittsanzeige nicht angezeigt (sie wird flach in der Farbe **background** gezeichnet, nützlich für ProgressDlg, um sie unsichtbar zu machen). Wenn ihr Wert 0 ist, wird die Fortschrittsanzeige neu initialisiert. 


**-width**
:  Legt die gewünschte Breite der Fortschrittsanzeige fest. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert.
