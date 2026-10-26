*NAME*
: **PanedWindow** - Widget zur gekachelten Anordnung 


*ERZEUGUNG*
: PanedWindow *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: [-background oder -bg](options.md)


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |   |
| --- | --- |
|   -activator |   -pad |
|   -side |   -weights |
|   -width |


*WIDGET-BEFEHL*
: *pathName* add ?*option value...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe *index* 


---

BESCHREIBUNG

 PanedWindow ist ein Widget, das Kinder senkrecht oder waagerecht gekachelt anordnet. Die Größe der Teilflächen lässt sich über einen Steuersteg einstellen, der zwischen den Kindern erzeugt wird. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-activator (nur lesbar)**
:  Der Steuersteg ist in der Vorgabe je nach Betriebssystem eine Schaltfläche oder eine Linie. Dieser Steg kann mit dieser Option ausdrücklich gesetzt werden. Ist er auf **line** gesetzt, besteht der Steg nur aus einer Trennlinie. Ist er auf **button** gesetzt, besteht er aus einem Knopf, der gezogen werden kann. 


**-pad (nur lesbar)**
:  Legt zusätzlichen Abstand zwischen der Schaltfläche des Stegs und den Kindern fest. 


**-side (nur lesbar)**
:  Legt die Seite des Stegs fest und damit die Anordnung: **top** oder **bottom** (waagerechte Anordnung), **left** oder **right** (senkrechte Anordnung). 


**-weights (nur lesbar)**
:  Legt fest, wie die Gewichte verwendet werden, die beim Hinzufügen von Teilflächen angegeben werden. Muss **extra** oder **available** sein. Bei *extra* wird nur der zusätzliche Platz im Verhältnis zum Gewicht auf die verschiedenen Teilflächen verteilt. Bei *available* wird der gesamte Platz im Verhältnis zum Gewicht auf die verschiedenen Teilflächen verteilt. Der Vorgabewert für **weights** ist *extra*. 


**-width (nur lesbar)**
:  Legt die Breite der Schaltfläche des Stegs fest. Diese Option wird ignoriert, wenn der Activator auf **line** gesetzt ist. 


---

WIDGET-BEFEHL

*pathName* **add** ?*option value...*? 
: Dieser Befehl fügt eine neue Teilfläche hinzu. Die neue Teilfläche wird bei senkrechter Anordnung unter die vorherige Teilfläche gelegt und bei waagerechter Anordnung rechts davon. Dieser Befehl gibt einen Rahmen zurück, in den das Widget gelegt werden kann. Gültige Optionen sind:

**-minsize**
:  Legt die verlangte Mindestgröße der Teilfläche fest. Weitere Angaben stehen beim Befehl **grid**. 


**-weight**
:  Legt das relative Gewicht fest, nach dem zusätzlicher Platz auf die Teilflächen verteilt wird. Weitere Angaben stehen beim Befehl **grid**. 



*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **getframe** *index* 
:  Gibt den Pfadnamen der als *index*-te hinzugefügten Teilfläche zurück.
