*NAME*
: **ButtonBox** - Menge von Schaltflächen mit waagerechter oder senkrechter Anordnung 


*ERZEUGUNG*
: ButtonBox *pathName* ?*option value...*?


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |   |
| --- | --- |
|   -background oder -bg |   -default |
|   -homogeneous |
|   -orient |
|   -padx |
|   -pady |
|   -spacing |
|   -state |


*WIDGET-BEFEHL*
: *pathName* add ?*option value...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete *index* 

: *pathName* index *index* 

: *pathName* insert *index* ?*option value...*? 

: *pathName* invoke *index* 

: *pathName* itemcget *index* *option* 

: *pathName* itemconfigure *index* ?*option*? ?*value* *option* *value* ...? 

: *pathName* setfocus *index* 


---

BESCHREIBUNG

 ButtonBox ordnet Buttons waagerecht oder senkrecht an. Einige Befehle nehmen einen *index* als Argument, der angibt, auf welchen Button sie wirken. Dieser Index kann in jeder der folgenden Formen angegeben werden: 

 

 *number* 
:  Bezeichnet den Button numerisch, wobei 0 dem zuerst hinzugefügten Button entspricht, 1 dem nächsten, und so weiter. 

 **end** or **last** 
:  Bezeichnet den zuletzt hinzugefügten Eintrag. 

**default** 
:  Bezeichnet den Vorgabe-Button. 

 *name* 
:  Bezeichnet die Schaltfläche, deren Option **-name** *name* ist. 

 *text* 
:  Bezeichnet die Schaltfläche, deren Option **-text** *text* ist. 


---

WIDGET-SPEZIFISCHE OPTIONEN

**-background**
:  Legt eine Vorgabe-Hintergrundfarbe für alle hinzugefügten Schaltflächen und für den Rahmen fest. 


**-default**
:  Legt die Vorgabeschaltfläche der Schaltflächenleiste fest. Der Wert ist eine ganze Zahl, die die n-te hinzugefügte Schaltfläche bezeichnet, beginnend bei 0. Wenn dieser Wert -1 ist (die Vorgabe), werden alle Schaltflächen mit ihrer Option -default auf disabled gezeichnet, und dieser Wert kann nicht geändert werden.   
  Wenn dieser Wert nicht -1 ist, wird die zugehörige Schaltfläche mit der Option -default auf active gezeichnet und die anderen mit der Option -default auf normal. Der Wert kann mit configure geändert werden. 


**-homogeneous (nur lesbar)**
:  Legt fest, ob die Schaltflächen bei waagerechter Anordnung dieselbe Breite haben müssen. 


**-orient (nur lesbar)**
:  Legt die Ausrichtung der Schaltflächenleiste fest. Wenn diese Option **horizontal** ist (die Vorgabe), werden Schaltflächen von oben nach unten hinzugefügt. Wenn diese Option **vertical** ist, werden Schaltflächen von links nach rechts hinzugefügt. 


**-padx**
:  Legt einen Vorgabewert für die Option -padx aller hinzugefügten Schaltflächen fest. 


**-pady**
:  Legt einen Vorgabewert für die Option -pady aller hinzugefügten Schaltflächen fest. 


**-spacing**
:  Legt den Vorgabeabstand zwischen den Schaltflächen fest. Dieser Wert kann vor jedem Aufruf von **add** geändert werden. 


**-state**
:  Legt einen Zustand für alle Schaltflächen in der Schaltflächenleiste fest. Das kann jeder Zustand sein, den Schaltflächen unterstützen. 


---

WIDGET-BEFEHL

*pathName* **add** ?*option value...*? 
: Fügt der Schaltflächenleiste eine Schaltfläche hinzu.

 Die Beschreibung der Optionen steht bei [Button](Button.md). 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **delete** *index* 
:  Löscht die Schaltfläche an *index* aus der Schaltflächenleiste. 


*pathName* **index** *index* 
:  Gibt den numerischen Index zurück, der dem Eintrag entspricht. 


*pathName* **insert** *index* ?*option value...*? 
:  Fügt eine neue Schaltfläche vor dem angegebenen Index in die Schaltflächenleiste ein. 


*pathName* **invoke** *index* 
:  Ruft den Button auf, den *index* angibt. 


*pathName* **itemcget** *index* *option* 
:  Gibt den aktuellen Wert einer Konfigurationsoption für den Eintrag zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl des Eintrags akzeptiert. 


*pathName* **itemconfigure** *index* ?*option*? ?*value* *option* *value* ...? 
:  Dieser Befehl entspricht dem Befehl **configure**, er gilt aber für die Optionen eines einzelnen Eintrags, während **configure** für die Optionen des Widgets als Ganzes gilt. **Options** kann jeden Wert haben, den der Widget-Befehl zur Erzeugung des Eintrags akzeptiert. Wenn Optionen angegeben sind, werden sie geändert, wie der Befehl angibt, und der Befehl gibt eine leere Zeichenkette zurück. Wenn keine Optionen angegeben sind, gibt der Befehl eine Liste zurück, die die aktuellen Optionen des Eintrags beschreibt. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **setfocus** *index* 
:  Setzt den Fokus auf den Button, den *index* angibt.
