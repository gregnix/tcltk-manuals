*NAME*
: **ComboBox** - ComboBox-Widget 


*ERZEUGUNG*
: ComboBox *pathName* ?*option value...*?


*OPTIONS from ArrowButton*
: 

|   |   |
| --- | --- |
|   -background oder -bg |   -disabledforeground |
|   -foreground oder -fg |   -state |


*OPTIONS from Entry*
: 

|   |   |
| --- | --- |
|   -command |   -disabledforeground |
|   -dragenabled |   -dragendcmd |
|   -dragevent |   -draginitcmd |
|   -dragtype |   -dropcmd |
|   -dropenabled |   -dropovercmd |
|   -droptypes |   -editable |
|   -entrybg (siehe **-background**) |   -entryfg (see **-foreground**) |
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

|   |   |
| --- | --- |
|   -autocomplete |   -autopost |
|   -bwlistbox |   -expand |
|   -height |   -hottrack |
|   -images |   -listboxwidth |
|   -modifycmd |   -postcommand |
|   -values |


*WIDGET-BEFEHL*
: *pathName* bind ?*arg...*? 

: *pathName* cget *option* 

: *pathName* clearvalue 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* get

: *pathName* getlistbox

: *pathName* getvalue

: *pathName* icursor *index* 

: *pathName* post

: *pathName* setvalue *index* 

: *pathName* unpost


---

BESCHREIBUNG

 Das Widget ComboBox ermöglicht, einen Wert aus einer Liste zu wählen, die die Option **values** angibt. Die Liste der möglichen Werte kann aufgeklappt werden, indem der ArrowButton gedrückt oder in das Entry geklickt wird, wenn der Wert **editable** der ComboBox **false** ist.  
 Wenn der Wert **editable** der ComboBox **true** ist und das Entry den Fokus hat, können die Pfeiltasten nach oben und unten den Wert ändern. Wenn der aktuelle Wert genau einem Wert in der Liste entspricht, wird der vorherige (Pfeil nach oben) oder der nächste (Pfeil nach unten) Wert der Liste angezeigt. Wenn der aktuelle Wert dem Anfang eines Wertes in der Liste entspricht, wird dieser Wert angezeigt. Wenn der aktuelle Wert zu nichts passt, wird der erste Wert angezeigt. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-autocomplete**
:  Legt fest, ob die Combobox versuchen soll, den Wert im Eingabefeld während der Eingabe zu vervollständigen. Wenn true, füllt die Combobox einen Wert ein, den sie in ihrer Werteliste findet, während in das Entry eingegeben wird. 


**-autopost**
:  Legt fest, ob die Combobox die Auswahlliste während der Eingabe einblenden soll. Wenn true, blendet die Combobox sie ein und scrollt zu dem Eintrag, der der Eingabe am nächsten kommt. 


**-bwlistbox**
:  Legt fest, dass die Combobox in der Auswahlliste eine BWidget-Listbox verwendet, anstelle der Tk-Vorgabe. Diese Option ist in der Vorgabe eingeschaltet, wenn die Option **-images** nicht leer ist. 


**-expand**
:  Legt das Verhalten der Werterweiterung für das Fenster fest. Muss **none** (Vorgabe) oder **tab** sein. Wenn **tab** angegeben ist, wird eine Tab-Bindung hinzugefügt, die versucht, den aktuellen Wert anhand der anderen Werte in **-values** zu erweitern. 


**-height**
:  Legt die gewünschte Höhe für das Fenster in Zeilen fest. Wenn null oder weniger, wird die gewünschte Höhe des Fensters gerade groß genug gemacht, um alle Elemente der Listbox aufzunehmen. 


**-modifycmd**
:  Legt einen Tcl-Befehl fest, der aufgerufen wird, wenn der Wert der ComboBox geändert wird, indem er in der Listbox gewählt oder eine Pfeiltaste gedrückt wird. 


**-postcommand**
:  Legt einen Tcl-Befehl fest, der aufgerufen wird, bevor die Listbox der ComboBox abgebildet wird. 


**-values**
:  Legt die Werte fest, die in der Listbox der ComboBox angezeigt werden. 


---

WIDGET-BEFEHL

*pathName* **bind** ?*arg...*? 
:  Setzt Bindungen auf dem Entry-Widget. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **clearvalue** 
:  Löscht den aktuellen Text der ComboBox. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **get** 
:  Gibt den aktuellen Inhalt des Entry zurück. 


*pathName* **getlistbox** 
:  Gibt den Pfad zur Listbox in der Auswahlliste zurück. 


*pathName* **getvalue** 
:  Gibt den Index des aktuellen Textes der ComboBox in der Werteliste zurück, oder -1, wenn er zu keinem Wert passt. 


*pathName* **icursor** *index* 
:  Sorgt dafür, dass der Einfügecursor unmittelbar vor dem Zeichen angezeigt wird, das *index* angibt. Gibt eine leere Zeichenkette zurück. 


*pathName* **post** 
:  Blendet die Auswahlliste ein. 


*pathName* **setvalue** *index* 
: Setzt den Text der ComboBox auf den Wert, den *index* in der Werteliste angibt. *index* kann in jeder der folgenden Formen angegeben werden:

 

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



*pathName* **unpost** 
:  Blendet die Auswahlliste aus. 


---

BINDUNGEN

Wenn das Entry der ComboBox den Eingabefokus hat, hat es die folgenden Bindungen, zusätzlich
zu den Vorgabebindungen von Entry:

- Die Taste „Bild auf“ setzt den Wert der ComboBox auf den ersten Wert. 
- Die Taste „Bild ab“ setzt den Wert der ComboBox auf den letzten Wert. 
- Die Taste „Pfeil nach oben“ setzt den Wert der ComboBox auf den vorherigen Wert. 
- Die Taste „Pfeil nach unten“ setzt den Wert der ComboBox auf den nächsten Wert. 
- Wenn **-autopost** eingeschaltet ist, blendet Escape die Listbox aus. 

Wenn die Listbox nicht abgebildet ist und die ComboBox nicht bearbeitbar oder disabled ist,
lässt Maustaste 1 auf dem Entry die Listbox aufklappen, als würde der ArrowButton gedrückt.
