*NAME*
: **ProgressDlg** - Dialog mit Fortschrittsanzeige 


*ERZEUGUNG*
: ProgressDlg *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

|   |
| --- |
|   [-font](options.md) |
|   [-textvariable](options.md) |


*OPTIONEN VON Dialog*
: 

|   |   |
| --- | --- |
|   -background oder -bg |   -parent |
|   -separator |   -title |


*OPTIONEN VON ProgressBar*
: 

|   |   |
| --- | --- |
|   -background oder -bg |   -borderwidth oder -bd |
|   -foreground oder -fg |   -maximum |
|   -relief |   -troughcolor |
|   -type |   -variable |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -command |
|   -height |
|   -stop |
|   -width |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

BESCHREIBUNG

 ProgressDlg bietet einen einfachen Weg, einen Dialog mit Fortschrittsanzeige anzuzeigen. ProgressDlg::**create** erzeugt den Dialog, zeigt ihn an, setzt einen lokalen Grab darauf und kehrt sofort zurück. Der Dialog wird aktualisiert, indem der Wert der Variable der Optionen **-textvariable** und **-variable** geändert wird. Der Dialog muss nach der Verwendung zerstört werden. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-command**
:  Legt einen Befehl fest, der aufgerufen wird, wenn die Stoppschaltfläche gedrückt wird. Das Programm muss regelmäßig **update** aufrufen, damit Ereignisse für das Drücken der Schaltfläche entstehen können. 


**-height**
:  Legt eine gewünschte Höhe für das Label in Textzeilen fest. 


**-stop**
:  Legt den Text der Schaltfläche fest, die gewöhnlich zum Anhalten des Prozesses dient. Wenn der Wert leer ist, wird keine Schaltfläche gezeichnet. Das kann ein symbolischer Name sein. 


**-width**
:  Legt eine gewünschte Breite für das Label in Zeichen fest. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert.
