*NAME*
: **MainFrame** - Toplevel-Fenster mit Menü, Werkzeugleiste und Statusleiste verwalten 


*ERZEUGUNG*
: MainFrame *pathName* ?*option value...*?


*OPTIONEN VON ProgressBar*
: 

|   |   |
| --- | --- |
|   -background oder -bg |   -progressfg (siehe **-foreground**) |
|   -progressmax (siehe **-maximum**) |   -progresstype (siehe **-type**) |
|   -progressvar (siehe **-variable**) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -height |
|   -menu |
|   -separator |
|   -textvariable |
|   -width |


*WIDGET-BEFEHL*
: *pathName* addindicator ?*arg...*? 

: *pathName* addtoolbar 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 

: *pathName* getindicator *index* 

: *pathName* getmenu *menuid* 

: *pathName* gettoolbar *index* 

: *pathName* setmenustate *tag* *state* 

: *pathName* showstatusbar *name* 

: *pathName* showtoolbar *index* *bool* 


---

BESCHREIBUNG

 MainFrame verwaltet ein Toplevel-Fenster, damit es hat:  
 

- einfache Erzeugung eines Menüs, mit automatischen Beschleuniger-Bindungen und Zuordnung von [DynamicHelp](DynamicHelp.md), 
- eine oder mehrere Werkzeugleisten, die verborgen werden können, 
- eine Statusleiste, die eine Benutzermeldung oder eine Menübeschreibung anzeigt, und wahlweise eine [ProgressBar](ProgressBar.md). 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-height**
:  Legt die gewünschte Höhe für den Benutzerrahmen in jeder Form fest, die Tk_GetPixels akzeptiert. Wenn diese Option kleiner oder gleich null ist (die Vorgabe), verlangt das Fenster überhaupt keine Größe. 


**-menu (nur lesbar)**
: Diese Option beschreibt das Menü. Das ist eine Liste, deren je fünf Elemente ein Kaskadenmenü beschreiben. Sie hat die folgende Form: {*menuname* *tags* *menuId* *tearoff* *menuentries*...}, wobei *menuentries* eine Liste ist, deren jedes Element einen Menüeintrag beschreibt, der sein kann:

  - für einen Trenner:  
   {**separator**} 
  - für einen Befehl:  
   {**command** *menuname* ?*tags*? ?*description*? ?*accelerator*? ?*option* *value*? ...} 
  - für eine Schaltfläche zum Abhaken:  
   {**checkbutton** *menuname* ?*tags*? ?*description*? ?*accelerator*? ?*option* *value*? ...} 
  - für einen Radiobutton:  
   {**radiobutton** *menuname* ?*tags*? ?*description*? ?*accelerator* ?*option* *value*? ...} 
  - für ein Kaskadenmenü:  
   {**cascade** *menuname* *tags* *menuId* *tearoff* *menuentries*} 

where:

  - *menuname* ist der Name des Menüs. Wenn er ein & enthält, wird das folgende Zeichen automatisch in die entsprechende Option **-underline** des Befehls **menu add** umgesetzt. 
  - *tags* ist die Tag-Liste für den Eintrag, mit der Menüeinträge über **MainFrame::setmenustate** ein- oder ausgeschaltet werden. 
  - *menuId* ist eine Kennung für das Menü, aus der **MainFrame::getmenu** den Pfadnamen des Menüs holt. 
  - *tearoff* legt fest, ob das Menü einen Abreißeintrag hat. 
  - *description* legt eine Zeichenkette für [DynamicHelp](\"DynamicHelp.html\") fest. 
  - *accelerator* legt eine Tastenfolge fest. Das ist eine Liste aus zwei Elementen, das erste ist **Ctrl**, **Alt** oder **CtrlAlt**, das zweite ein Buchstabe oder eine Ziffer. Eine Beschleuniger-Zeichenkette wird aufgebaut und die entsprechende Bindung auf dem Toplevel gesetzt, um den Menüeintrag aufzurufen. 
  - *option value* legt zusätzliche Optionen für den Eintrag fest (siehe den Befehl **menu add**). 

Jeder Wert in ? ist optional und in der Vorgabe die leere Zeichenkette, muss aber angegeben werden, wenn eine oder mehrere folgende Optionen nicht leer sind.   
Beispiel:

```
set descmenu {
    "&File" {} {} 0 {
        {command "&New"     {} "Create a new document"     {Ctrl n} -command Menu::new}
        {command "&Open..." {} "Open an existing document" {Ctrl o} -command Menu::open}
        {command "&Save"    open "Save the document" {Ctrl s} -command Menu::save}
        {cascade  "&Export"  {} export 0 {
            {command "Format &1" open "Export document to format 1" {} -command {Menu::export 1}}
            {command "Format &2" open "Export document to format 2" {} -command {Menu::export 2}}
        }}
        {separator}
        {cascade "&Recent files" {} recent 0 {}}
        {separator}
        {command "E&xit" {} "Exit the application" {} -command Menu::exit}
    }
    "&Options" {} {} 0 {
        {checkbutton "Toolbar" {} "Show/hide toolbar" {} 
            -variable Menu::_drawtoolbar
            -command  {$Menu::_mainframe showtoolbar toolbar $Menu::_drawtoolbar}
        }
    }
}
```


**-separator (nur lesbar)**
:  Legt fest, ob ein Trenner oben und/oder unten am Benutzerfenster gezeichnet werden soll. Muss einer der Werte **none**, **top**, **bottom** oder **both** sein. Das hängt vom Relief der Unterwidgets des Benutzerfensters ab. 


**-textvariable**
:  Legt die Option textvariable für die Beschriftung der Statusleiste fest. Die Beschreibung der Menüeinträge von [DynamicHelp](DynamicHelp.md) wird bei der Erzeugung des MainFrame auf diese Variable abgebildet. Wenn diese Variable durch MainFrame::configure geändert wird, steht die Menübeschreibung nicht zur Verfügung.   
  Der Text der Beschriftung ändert sich, indem der Wert der Variable geändert wird. 


**-width**
:  Legt die gewünschte Breite für den Benutzerrahmen in jeder Form fest, die Tk_GetPixels akzeptiert. Wenn diese Option kleiner oder gleich null ist (die Vorgabe), verlangt das Fenster überhaupt keine Größe. 


---

WIDGET-BEFEHL

*pathName* **addindicator** ?*arg...*? 
:  Fügt rechts an der Statusleiste ein Anzeigefeld hinzu. Jede Anzeige wird von links nach rechts hinzugefügt. Eine Anzeige ist ein Tk-Label-Widget, das mit den Options-Wert-Paaren aus ?*arg...*? konfiguriert wird. Die Optionen **-relief** und **-borderwidth** sind in der Vorgabe *sunken* und 1. Gibt den Pfadnamen des erzeugten Labels zurück. 


*pathName* **addtoolbar** 
:  Fügt dem MainFrame eine Werkzeugleiste hinzu. Gibt den Pfadnamen des neuen Fensters zurück, in das die Einträge der Werkzeugleiste gelegt werden. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **getframe** 
:  Gibt den Pfadnamen des Benutzerfensters zurück. 


*pathName* **getindicator** *index* 
:  Gibt den Pfadnamen der als *index*-te hinzugefügten Anzeige zurück. 


*pathName* **getmenu** *menuid* 
:  Gibt den Pfadnamen des Menüs zurück, dessen Kennung *menuid* ist. 


*pathName* **getmenustate** *tag* *state* 
:  Gibt den Zustand des angegebenen Menü-*tag* zurück. 


*pathName* **gettoolbar** *index* 
:  Gibt den Pfadnamen der als *index*-te hinzugefügten Werkzeugleiste zurück. 


*pathName* **setmenustate** *tag* *state* 
:  Setzt den Wert der Option **-state** aller Menüeinträge, die das Tag *tag* haben, auf *state*. Ein Menüeintrag ist disabled, wenn eines seiner zugehörigen Tags den Zustand **disabled** hat. 


*pathName* **showstatusbar** *name* 
:  *name* ist einer der Werte **none**, **status** oder **progression**. **none** verbirgt die Statusleiste, **status** zeigt nur die Beschriftung, **progression** zeigt die Beschriftung und die [ProgressBar](ProgressBar.md). 


*pathName* **showtoolbar** *index* *bool* 
:  Verbirgt die als *index*-te hinzugefügte Werkzeugleiste, wenn *bool* 0 ist, oder zeigt sie, wenn *bool* 1 ist. Damit das Toplevel-Fenster beim Verbergen oder Anzeigen der Werkzeugleiste nicht die Größe ändert, dient \[wm geometry \$top \[wm geometry \$top\]\], wenn es verwaltet wird.
