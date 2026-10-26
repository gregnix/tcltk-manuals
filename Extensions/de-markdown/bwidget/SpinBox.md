*NAME*
: **SpinBox** - SpinBox-Widget 


*ERZEUGUNG*
: SpinBox *pathName* ?*option value...*?


*OPTIONEN VON ArrowButton*
: 

|   |   |
| --- | --- |
|   -background oder -bg |   -disabledforeground |
|   -foreground oder -fg |   -repeatdelay |
|   -repeatinterval |   -state |


*OPTIONEN VON Entry*
: 

|   |   |
| --- | --- |
|   -command |   -disabledforeground |
|   -dragenabled |   -dragendcmd |
|   -dragevent |   -draginitcmd |
|   -dragtype |   -dropcmd |
|   -dropenabled |   -dropovercmd |
|   -droptypes |   -editable |
|   -entrybg (siehe **-background**) |   -entryfg (siehe **-foreground**) |
|   -exportselection |   -font |
|   -helptext |   -helptype |
|   -helpvar |   -highlightbackground |
|   -highlightcolor |   -highlightthickness |
|   -insertbackground |   -insertborderwidth |
|   -insertofftime |   -insertontime |
|   -insertwidth |   -justify |
|   -selectbackground |   -selectborderwidth |
|   -selectforeground |   -show |
|   -state |   -takefocus |
|   -text |   -textvariable |
|   -width |   -xscrollcommand |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -modifycmd |
|   -range |
|   -values |


*WIDGET-BEFEHL*
: *pathName* bind ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getvalue 

: *pathName* setvalue *index* 


---

BESCHREIBUNG

 Das Widget SpinBox ermöglicht, einen Wert aus einer Liste zu wählen, die die Option **values** angibt, oder aus einer Menge von Werten, die durch ein Minimum, ein Maximum und ein Inkrement definiert ist. Die Option **range** definiert eine Liste von Werten, deshalb arbeiten **getvalue** und **setvalue** sowohl mit values als auch mit range. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-modifycmd**
:  Legt einen Tcl-Befehl fest, der aufgerufen wird, wenn der Wert der SpinBox geändert wird. 


**-range**
:  Legt eine Liste aus drei ganzen Zahlen (oder reellen Zahlen) fest, die Minimum, Maximum und Inkrement der SpinBox beschreiben. 


**-values**
:  Legt die Werte fest, die die SpinBox akzeptiert. Diese Option hat Vorrang vor der Option **range**. 


---

WIDGET-BEFEHL

*pathName* **bind** ?*arg...*? 
:  Setzt Bindungen auf dem Entry-Widget. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **getvalue** 
:  Gibt den Index des aktuellen Textes der SpinBox in der Werteliste zurück, oder -1, wenn er zu keinem Wert passt. 


*pathName* **setvalue** *index* 
: Setzt den Text der SpinBox auf den Wert, den *index* in der Werteliste angibt. *index* kann in jeder der folgenden Formen angegeben werden:

 

 **last** 
:  Legt das letzte Element der Werteliste fest. 

**first** 
:  Legt das erste Element der Werteliste fest. 

 **next** 
:  Legt das Element fest, das auf das aktuelle folgt (das heißt das von **getvalue** zurückgegebene) in der Werteliste. 

**previous** 
:  Legt das Element fest, das dem aktuellen vorausgeht (das heißt das von **getvalue** zurückgegebene) in der Werteliste. 

 @*number* 
:  Legt den ganzzahligen Index in der Werteliste fest. 



---

BINDUNGEN

Wenn das Entry der SpinBox den Eingabefokus hat, hat es die folgenden Bindungen, zusätzlich
zu den Vorgabebindungen von Entry:

- Die Taste „Bild auf“ setzt den Wert der SpinBox auf den letzten Wert. 
- Die Taste „Bild ab“ setzt den Wert der SpinBox auf den ersten Wert. 
- Die Taste „Pfeil nach oben“ setzt den Wert der SpinBox auf den nächsten Wert. 
- Die Taste „Pfeil nach unten“ setzt den Wert der SpinBox auf den vorherigen Wert.
