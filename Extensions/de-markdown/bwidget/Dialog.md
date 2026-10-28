*NAME*
: **Dialog** - Dialogabstraktion mit eigenen Schaltflächen 


*ERZEUGUNG*
: Dialog *pathName* ?*option value...*?


*OPTIONEN VON ButtonBox*
: 

    |   |   |
    | --- | --- |
    |   -background oder -bg |   -homogeneous |
    |   -padx |   -pady |
    |   -spacing |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |
    | --- |
    |   -anchor |
    |   -bitmap |
    |   -cancel |
    |   -default |
    |   -geometry |
    |   -image |
    |   -modal |
    |   -parent |
    |   -place |
    |   -separator |
    |   -side |
    |   -title |
    |   -transient |


*WIDGET-BEFEHL*
: *pathName* add ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* draw ?*focus*? 

: *pathName* enddialog *result* 

: *pathName* getframe 

: *pathName* invoke *index* 

: *pathName* itemcget *index* *option* 

: *pathName* itemconfigure *index* ?*option*? ?*value* *option* *value* ...? 

: *pathName* setfocus *index* 

: *pathName* withdraw 


---

BESCHREIBUNG

 Das Widget Dialog ermöglicht, einen Dialog zu erzeugen. Einige Befehle nehmen einen *index* als Argument, der angibt, auf welchen Button sie wirken. Dieser Index ist derselbe, der für den entsprechenden Befehl von ButtonBox angegeben wird: 



 *number* 
:  Bezeichnet den Button numerisch, wobei 0 dem zuerst hinzugefügten Button entspricht, 1 dem nächsten, und so weiter. 

 **end** or **last** 
:  Bezeichnet den zuletzt hinzugefügten Eintrag. 

**default** 
:  Bezeichnet den Vorgabe-Button. 


---

WIDGET-SPEZIFISCHE OPTIONEN

**-anchor (nur lesbar)**
:  Legt den Ankerpunkt der ButtonBox fest. Muss einer der Werte **w**, **e**, **n**, **s** oder **c** sein. Wenn die Option **side** auf *top* oder *bottom* gesetzt ist, haben die **anchor**-Werte *n*, *s* und *c* dieselbe Wirkung. Wenn die Option **side** auf *left* oder *right* gesetzt ist, haben die **anchor**-Werte *w*, *e* und *c* dieselbe Wirkung. 


**-bitmap (nur lesbar)**
:  Legt eine Bitmap fest, die links vom Benutzerrahmen angezeigt wird. Die Option **image** setzt **bitmap** außer Kraft. 


**-cancel**
:  Legt die Nummer der Abbrechen-Schaltfläche des Dialogs fest. Wenn Esc oder die Schließen-Schaltfläche des Fensters gedrückt wird, wird diese Schaltfläche aufgerufen.  
   Wenn der Wert **-1** ist, ruft Esc nichts auf. Die Schließen-Schaltfläche des Fensters *zerstört* den Dialog in diesem Fall und gibt **-1** zurück. 


**-default**
:  Legt die Nummer der Vorgabeschaltfläche des Dialogs fest. Wenn im Dialog Return gedrückt wird, wird diese Schaltfläche aufgerufen. 


**-geometry**
:  Setzt die **geometry**, die verwendet wird, wenn die Methode **draw** aufgerufen wird. Die Beschreibung der Parameter steht bei **wm geometry**. 


**-image (nur lesbar)**
:  Legt ein Bild fest, das links vom Benutzerrahmen angezeigt wird. Die Option **image** setzt **bitmap** außer Kraft. 


**-modal**
:  Diese Option muss **none**, **local** oder **global** sein. Der Wert dieser Option legt den Grab-Modus des Dialogs fest und wie Dialog::**draw** arbeitet. 


**-parent**
:  Elternteil des Dialogs. Der Dialog wird relativ zu seinem Elternteil platziert. Wenn der Wert leer ist, wird er relativ zum Wurzel-Fenster platziert. Siehe auch die Option **place**. 


**-place**
:  Legt fest, wo das Dialog-Toplevel-Fenster relativ zum Elternteil des Dialogs gezeichnet wird. Muss einer der Werte **none**, **center**, **left**, **right**, **above**, **below** sein. Der Vorgabewert von **place** ist *center*. 


**-separator (nur lesbar)**
:  Legt fest, ob zwischen dem Benutzerrahmen und der ButtonBox ein Trenner gezeichnet wird. 


**-side (nur lesbar)**
:  Legt fest, wo die ButtonBox relativ zum Benutzerrahmen gezeichnet wird. Muss einer der Werte **top**, **left**, **bottom** oder **right** sein. 


**-title**
:  Titel des Dialog-Toplevel-Fensters. 


**-transient (nur lesbar)**
:  Legt fest, ob das Dialog-Toplevel-Fenster ein transientes Fenster sein soll. Der Vorgabewert von **transient** ist *true*. 


---

WIDGET-BEFEHL

*pathName* **add** ?*arg...*? 
:  Fügt der Schaltflächenleiste des Dialogs eine Schaltfläche hinzu. Die Vorgabe der Option -command ist *Dialog::enddialog \$path index*, wobei *index* die Nummer der hinzugefügten Schaltfläche ist. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **draw** ?*focus*? 
: Dieser Befehl zeichnet den Dialog und setzt den Grab darauf, entsprechend der Option **modal**. Wenn die Option **modal** auf *none* gesetzt ist, gibt der Befehl sofort eine leere Zeichenkette zurück. In allen anderen Fällen kehrt der Befehl zurück, wenn Dialog::**enddialog** aufgerufen oder der Dialog zerstört wird. Der Rückgabewert ist das Ergebnisargument von Dialog::**enddialog** oder -1, wenn er zerstört wird.

     In der Vorgabe wird der Fokus auf die Vorgabeschaltfläche gesetzt, auf die die Option **default** zeigt, oder auf das Toplevel des Dialogs, wenn keine Vorgabeschaltfläche gesetzt wurde. Wenn *focus* vorhanden ist, muss es ein Pfadname oder ein Index einer Schaltfläche sein. Der anfängliche Fokus wird auf diesen Pfadnamen oder die entsprechende Schaltfläche gesetzt. 


*pathName* **enddialog** *result* 
:  Dieser Befehl wird gewöhnlich innerhalb eines Befehls einer Schaltfläche aufgerufen, damit Dialog::**draw** zurückkehrt. 


*pathName* **getframe** 
:  Gibt den Pfadnamen des Benutzerfensters zurück. 


*pathName* **invoke** *index* 
:  Ruft den Button auf, den *index* angibt. 


*pathName* **itemcget** *index* *option* 
:  Gibt den aktuellen Wert einer Konfigurationsoption für den Eintrag zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl des Eintrags akzeptiert. 


*pathName* **itemconfigure** *index* ?*option*? ?*value* *option* *value* ...? 
:  Dieser Befehl entspricht dem Befehl **configure**, er gilt aber für die Optionen eines einzelnen Eintrags, während **configure** für die Optionen des Widgets als Ganzes gilt. **Options** kann jeden Wert haben, den der Widget-Befehl zur Erzeugung des Eintrags akzeptiert. Wenn Optionen angegeben sind, werden sie geändert, wie der Befehl angibt, und der Befehl gibt eine leere Zeichenkette zurück. Wenn keine Optionen angegeben sind, gibt der Befehl eine Liste zurück, die die aktuellen Optionen des Eintrags beschreibt. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **setfocus** *index* 
:  Setzt den Fokus auf den Button, den *index* angibt. 


*pathName* **withdraw** 
:  Dieser Befehl verbirgt den Dialog.
