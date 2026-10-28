*NAME*
: **Label** - Label-Widget mit der Option **state**, dynamischer Hilfe und Ziehen und Ablegen 


*ERZEUGUNG*
: Label *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |
    | --- |
    |   [-anchor](options.md) |
    |   [-background oder -bg](options.md) |
    |   [-bitmap](options.md) |
    |   [-borderwidth oder -bd](options.md) |
    |   [-cursor](options.md) |
    |   [-disabledforeground](options.md) |
    |   [-font](options.md) |
    |   [-foreground oder -fg](options.md) |
    |   [-highlightbackground](options.md) |
    |   [-highlightcolor](options.md) |
    |   [-highlightthickness](options.md) |
    |   [-image](options.md) |
    |   [-justify](options.md) |
    |   [-padx](options.md) |
    |   [-pady](options.md) |
    |   [-relief](options.md) |
    |   [-takefocus](options.md) |
    |   [-text](options.md) |
    |   [-textvariable](options.md) |
    |   [-wraplength](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |
    | --- |
    |   -dragenabled |
    |   -dragendcmd |
    |   -dragevent |
    |   -draginitcmd |
    |   -dragtype |
    |   -dropcmd |
    |   -dropenabled |
    |   -dropovercmd |
    |   -droptypes |
    |   -focus |
    |   -height |
    |   -helptext |
    |   -helptype |
    |   -helpvar |
    |   -name |
    |   -state |
    |   -underline |
    |   -width |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* setfocus 


---

BESCHREIBUNG

 Das Widget **Label** erweitert das Tk-Label der Vorgabe. Hinzugekommen sind Optionen für eine sichtbare Wirkung je nach Zustand des Labels, Optionen von [DynamicHelp](DynamicHelp.md) sowie [Ziehen ](DragSite.md) und [Ablegen](DropSite.md). 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-dragenabled**
:  Ein boolescher Wert, der angibt, ob Ziehen eingeschaltet ist. 


**-dragendcmd**
:  Legt einen Befehl fest, der aufgerufen wird, wenn das Ziehen endet. **dragendcmd** muss ein Befehl sein, der der Beschreibung der Option **dragendcmd** von **DragSite::register** entspricht. 


**-dragevent**
:  Legt die Nummer der Maustaste fest, die dem Ziehen zugeordnet ist. Muss **1**, **2** oder **3** sein. 


**-draginitcmd**
: Legt einen Befehl fest, der aufgerufen wird, wenn **dragevent** auf dem Widget eintritt. **draginitcmd** muss ein Befehl sein, der der Beschreibung der Option **draginitcmd** von **DragSite::register** entspricht.   
  Wenn **draginitcmd** leer ist, wird stattdessen der interne Befehl **draginitcmd** verwendet und gibt zurück:

    :

        |   |   |
        | --- | --- |
        | *IMAGE {copy} \<image name>*  | wenn ein Bild angezeigt wird.  |

    Wenn die Option **dragtype** nicht leer ist, wird ihr Wert anstelle der oben genannten verwendet.


**-dragtype**
:  Legt einen anderen Typ des gezogenen Objekts fest. 


**-dropcmd**
: Legt einen Befehl fest, der aufgerufen wird, wenn auf dem Widget abgelegt wird. **dropcmd** muss ein Befehl sein, der der Beschreibung der Option **dropcmd** von **DropSite::register** entspricht.   
  Wenn **dropcmd** leer ist, aktualisiert der Befehl das Label entsprechend dem Typ der Daten:

    :

        |   |   |
        | --- | --- |
        | *COLOR* oder *FGCOLOR* | konfiguriert den **foreground** des Labels neu. |
        | *BGCOLOR* | konfiguriert den **background** des Labels neu. |
        | *IMAGE* | konfiguriert das Label neu, damit es das zugehörige Bild anzeigt. |
        | *BITMAP* | konfiguriert das Label neu, damit es die zugehörige Bitmap anzeigt. Die Option **image** wird auf leer gesetzt. |
        | *TEXT*,   oder jedes andere Tag | konfiguriert das Label neu, damit es die zugehörige Zeichenkette anzeigt. Die Optionen **image** und **bitmap** werden auf leer gesetzt. |

    und gibt 1 zurück.


**-dropenabled**
:  Ein boolescher Wert, der angibt, ob Ablegen eingeschaltet ist. 


**-dropovercmd**
:  Legt einen Befehl fest, der aufgerufen wird, wenn das Ziehsymbol über dem Widget ist. **dropovercmd** muss ein Befehl sein, der der Beschreibung der Option **dropovercmd** von **DropSite::register** entspricht.   
  Wenn **dropovercmd** leer ist, nimmt Label das Ablegen immer an, wenn der Datentyp *FGCOLOR*, *COLOR* oder *BGCOLOR* ist, und nimmt jeden anderen Datentyp nur an, wenn **state** normal ist. 


**-droptypes**
:  Legt eine Liste der akzeptierten abgelegten Objekte und Operationen fest. Weitere Angaben stehen bei der Option **droptypes** von **DropSite::register**. Die Vorgabe akzeptiert *FGCOLOR*, *COLOR*, *BGCOLOR*, *TEXT*, *BITMAP* und *IMAGE*, jeweils mit den Operationen **copy** und **move**. 


**-focus**
:  Legt einen Pfadnamen fest, auf den der Befehl Label::**setfocus** den Fokus setzt. 


**-height**
:  Legt eine gewünschte Höhe für das Label fest. Wenn im Label ein Bild oder eine Bitmap angezeigt wird, ist der Wert in Bildschirmeinheiten, bei Text in Textzeilen. Wenn diese Option nicht angegeben ist, wird die gewünschte Höhe des Labels aus der Größe des angezeigten Bildes, der Bitmap oder des Textes berechnet. 


**-helptext**
:  Text für die dynamische Hilfe. Wenn der Wert leer ist, gibt es für dieses Widget keine Hilfe. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Typ der dynamischen Hilfe. *balloon* oder *variable* verwenden. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable, die verwendet wird, wenn die Option **helptype** *variable* ist. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-name**
:  Legt einen Standardnamen für das Label fest. Wenn die Option **\*nameName** in der Ressourcendatenbank gefunden wird, werden die Optionen **text** und **underline** aus ihrem Wert entnommen. 


**-state**
:  Legt einen von zwei Zuständen für das Label fest: **normal** oder **disabled**. Im Zustand normal wird der Text des Labels mit der Option **foreground** angezeigt. Im Zustand disabled wird der Text des Labels mit der Option **disabledforeground** angezeigt. 


**-underline**
:  Legt den ganzzahligen Index eines Zeichens fest, das im Label unterstrichen wird. 0 entspricht dem ersten Zeichen des angezeigten Textes, 1 dem nächsten Zeichen, und so weiter.   
  Die Bindung **\<Alt-char>** wird auf dem Toplevel des Labels automatisch gesetzt, um Label::**setfocus** aufzurufen. 


**-width**
:  Legt eine gewünschte Breite für das Label fest. Wenn im Label ein Bild oder eine Bitmap angezeigt wird, ist der Wert in Bildschirmeinheiten, bei Text in Zeichen. Wenn diese Option nicht angegeben ist, wird die gewünschte Breite des Labels aus der Größe des angezeigten Bildes, der Bitmap oder des Textes berechnet. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **setfocus** 
:  Setzt den Fokus auf den Pfadnamen der Option **-focus**, wenn **-state** *normal* ist.
