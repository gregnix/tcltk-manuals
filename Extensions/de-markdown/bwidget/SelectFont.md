*NAME*
: **SelectFont** - Widget zur Schriftauswahl 


*ERZEUGUNG*
: SelectFont *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-background oder -bg](options.md) |   [-font](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: -command


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: SelectFont::loadfont 


---

BESCHREIBUNG

 SelectFont bietet einen einfachen Weg, eine Schriftart zu wählen. Es kann als Dialog oder als Werkzeugleiste angezeigt werden.   
Die Texteinträge im Dialog verwenden die Option **-name**, damit sie in jede Sprache übersetzt werden können. Die verwendeten symbolischen Namen sind **ok**, **cancel**, **font**, **size**, **style**, **bold**, **italic**, **underline** und **overstrike**. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-command**
:  Legt einen Befehl fest, der aufgerufen wird, wenn eine neue Schriftart gewählt wird und die Option **type** von SelectFont *toolbar* ist. 


**-initialcolor**
:  Wenn angegeben, kommt eine zusätzliche Schaltfläche hinzu, mit der eine Farbe gewählt werden kann. Diese Option wird ignoriert, wenn **type** *toolbar* ist. 


**-nosizes**
:  Wenn true, wird die Listbox mit den gültigen Schriftgrößen nicht angezeigt. Diese Option wird ignoriert, wenn **type** *toolbar* ist. 


**-parent**
:  Elternteil des Dialogs. Der Dialog wird in seinem Elternteil zentriert. Wenn der Wert leer ist, wird er im Wurzel-Fenster zentriert. 


**-sampletext**
:  Legt den Text fest, der im Vorschaubereich angezeigt wird. 


**-title**
:  Titel des Dialog-Toplevel-Fensters. 


**-type**
:  Legt den Typ des SelectFont-Widgets fest. Muss **dialog** oder **toolbar** sein.   
  Wenn die Option **type** *dialog* ist, erzeugt SelectFont::**create** den Dialog unmittelbar, zeigt ihn an und gibt eine leere Zeichenkette zurück, wenn die Schaltfläche cancel gedrückt oder der Dialog zerstört wird, und die gewählte Schriftart (und die Farbe, wenn **initialcolor**), wenn die Schaltfläche ok gedrückt wird. In allen Fällen wird der Dialog zerstört.   
  Wenn die Option **type** *toolbar* ist, gibt SelectFont::**create** den Pfadnamen des erzeugten Widgets zurück. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


SelectFont::**loadfont** 
:  Lädt die auf dem System verfügbaren Schriftarten.
