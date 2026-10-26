*NAME*
: **LabelFrame** - Rahmen mit einem Label 


*ERZEUGUNG*
: LabelFrame *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

|   |   |
| --- | --- |
|   [-borderwidth oder -bd](options.md) |   [-relief](options.md) |


*OPTIONEN VON Label*
: 

|   |   |
| --- | --- |
|   -anchor |   -background oder -bg |
|   -bitmap |   -disabledforeground |
|   -focus |   -font |
|   -foreground oder -fg |   -height |
|   -helptext |   -helptype |
|   -helpvar |   -image |
|   -justify |   -name |
|   -padx |   -pady |
|   -state |   -text |
|   -textvariable |   -underline |
|   -width |   -wraplength |


*WIDGET-SPEZIFISCHE OPTIONEN*
: -side


*WIDGET-BEFEHL*
: LabelFrame::align ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 


---

BESCHREIBUNG

 LabelFrame ermöglicht, einen Rahmen mit einem [Label](Label.md) zu erzeugen, das an jeder Seite angeordnet ist. LabelFrame wird von [ComboBox](ComboBox.md) und [SpinBox](SpinBox.md) verwendet. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-side (nur lesbar)**
:  Legt fest, wo das Label relativ zum Benutzerrahmen angeordnet wird: **top**, **bottom**, **left** oder **right**. 


---

WIDGET-BEFEHL

LabelFrame::**align** ?*arg...*? 
:  Dieser Befehl richtet das Label aller Widgets aus, die *args* angibt und die die Klasse LabelFrame (oder „derived“) haben, indem er ihre Breite auf das Maximum plus 1 setzt 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **getframe** 
:  Gibt den Rahmen zurück, in dem jedes andere Widget erzeugt werden kann.
