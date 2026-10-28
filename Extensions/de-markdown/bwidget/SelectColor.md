*NAME*
: **SelectColor** - Widget zur Farbauswahl 


*ERZEUGUNG*
: SelectColor *pathName* ?*option value...*?


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   -color |   -parent |
    |   -placement |   -title |
    |   -type |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: SelectColor::dialog *pathName* *?option value ...?* 

: SelectColor::menu *pathName* *placement* *?option value ...?* 

: SelectColor::setcolor *index* *color* 


---

BESCHREIBUNG

 SelectColor bietet einen einfachen Weg, eine Farbe auszuwählen. Es kann als Dialog oder als Menüschaltfläche angezeigt werden. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-color**
:  Legt den Farbwert des Widgets fest. 


**-parent**
:  Elternteil des Dialogs. Der Dialog wird in seinem Elternteil zentriert. Wenn der Wert leer ist, wird er im Wurzel-Fenster zentriert. 


**-placement**
:  Wo der Farbdialog *popup* beim Anzeigen platziert wird. Muss einer der Werte sein: **at**, **center**, **left**, **right**, **above** oder **below**. Wenn *-parent* angegeben ist, gilt die Platzierung relativ zum Eltern-Widget. 


**-title**
:  Titel des Dialog-Toplevel-Fensters. 


**-type (nur lesbar)**
:  Legt den Typ des SelectColor-Widgets fest. Muss **dialog** oder **popup** sein.   
  Wenn die Option **type** *dialog* ist, erzeugt SelectColor::**create** den Dialog unmittelbar, zeigt ihn an und gibt eine leere Zeichenkette zurück, wenn die Schaltfläche cancel gedrückt oder der Dialog zerstört wird, und die gewählte Farbe, wenn die Schaltfläche ok gedrückt wird. In allen Fällen wird der Dialog zerstört.   
  Wenn die Option **type** *popup* ist, erzeugt SelectColor::**create** einen kleinen Popup-Dialog mit einer kleinen Menge vordefinierter Farben und einer Schaltfläche, die einen vollständigen Farbdialog öffnet. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


SelectColor::**dialog** *pathName* *?option value ...?* 
:  Erzeugt einen Dialog, in dem eine eigene Farbe gewählt wird. 


SelectColor::**menu** *pathName* *placement* *?option value ...?* 
: Erzeugt einen kleinen Popup-Dialog, in dem aus einer vordefinierten Farbliste gewählt wird, mit einer zusätzlichen Schaltfläche, die einen vollständigen Farbdialog anzeigt.

     *placement* kann einer der Werte **at**, **center**, **left**, **right**, **above** oder **below** sein. Wenn *-parent* angegeben ist, gilt die Platzierung relativ zum Eltern-Widget. 


SelectColor::**setcolor** *index* *color* 
:  Setzt den Wert der vom Benutzer vordefinierten Farbe am Index *index* auf *color*. *index* muss zwischen 0 und 10 liegen.
