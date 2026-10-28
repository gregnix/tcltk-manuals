*NAME*
: **ArrowButton** - Button-Widget in Pfeilform. 


*ERZEUGUNG*
: ArrowButton *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-activebackground](options.md) |
    |   [-activeforeground](options.md) |
    |   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
    |   [-disabledforeground](options.md) |
    |   [-foreground oder -fg](options.md) |
    |   [-highlightbackground](options.md) |
    |   [-highlightcolor](options.md) |
    |   [-highlightthickness](options.md) |
    |   [-relief](options.md) |
    |   [-repeatdelay](options.md) |
    |   [-repeatinterval](options.md) |
    |   [-takefocus](options.md) |
    |   [-troughcolor](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |
    | --- |
    |   -armcommand |
    |   -arrowbd |
    |   -arrowrelief |
    |   -clean |
    |   -command |
    |   -dir |
    |   -disarmcommand |
    |   -height |
    |   -helptext |
    |   -helptype |
    |   -helpvar |
    |   -ipadx |
    |   -ipady |
    |   -state |
    |   -type |
    |   -width |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* invoke 


---

BESCHREIBUNG

 ArrowButton kann je nach Option **type** von zwei Typen sein: beim Typ **button** ist es eine Standardschaltfläche mit einem darauf gezeichneten Pfeil; beim Typ **arrow** ist es ein Pfeil wie der Pfeil einer Bildlaufleiste. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-armcommand**
:  Legt einen Tcl-Befehl fest, der dem ArrowButton zugeordnet wird, wenn Maustaste 1 über dem ArrowButton gedrückt wird. Wenn die Option **repeatdelay** oder **repeatinterval** eine positive ganze Zahl ist, wird dieser Befehl wiederholt aufgerufen, solange der Mauszeiger über der Schaltfläche ist und bis Maustaste 1 losgelassen wird. 


**-arrowbd**
:  Wenn der **type** des ArrowButton *arrow* ist, legt das die Randbreite des Pfeils fest. Muss 1 oder 2 sein. 


**-arrowrelief**
:  Wenn der **type** des ArrowButton *arrow* ist, legt das das Relief des Pfeils fest. Muss **raised** oder **sunken** sein. 


**-clean**
:  Legt eine Qualitätsstufe zwischen 0 und 2 für den Pfeil fest. Bei 0 wird der Pfeil mit seiner größten Breite und Höhe gezeichnet. Bei 1 wird die Basis des Pfeils ungerade gemacht, damit die Kanten gleich sind. Bei 2 wird die Basis des Pfeils ungerade gemacht und die Orthogonale zu (base+1)/2, damit die Kanten eine gerade Diagonale haben. 


**-command**
:  Legt einen Tcl-Befehl fest, der dem ArrowButton zugeordnet wird. Dieser Befehl wird gewöhnlich aufgerufen, wenn Maustaste 1 über dem ArrowButton-Fenster losgelassen wird. 


**-dir**
:  Legt die Richtung des Pfeils fest: **top**, **bottom**, **left** oder **right**. 


**-disarmcommand**
:  Legt einen Tcl-Befehl fest, der dem ArrowButton zugeordnet wird, wenn Maustaste 1 losgelassen wird. Dieser Befehl wird auch aufgerufen, wenn der Zeiger nicht über dem ArrowButton ist, und immer vor dem Befehl der Option **command**. Er wird gewöhnlich zusammen mit **armcommand**, **repeatdelay** und **repeatinterval** verwendet. 


**-height**
:  Legt eine gewünschte Höhe für den ArrowButton fest. Der Wert ist in Bildschirmeinheiten. 


**-helptext**
:  Text für die dynamische Hilfe. Wenn der Wert leer ist, gibt es für dieses Widget keine Hilfe. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Typ der dynamischen Hilfe. *balloon* oder *variable* verwenden. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable, die verwendet wird, wenn die Option **helptype** *variable* ist. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-ipadx**
:  Legt einen Mindestabstand zwischen dem Rand des ArrowButton und der rechten und linken Seite des Pfeils fest. Der Wert ist in Bildschirmeinheiten. 


**-ipady**
:  Legt einen Mindestabstand zwischen dem Rand des ArrowButton und der oberen und unteren Seite des Pfeils fest. Der Wert ist in Bildschirmeinheiten. 


**-state**
: Legt einen von drei Zuständen für den ArrowButton fest: **normal**, **active** oder **disabled**.

    Wenn der **type** des ArrowButton *button* ist:
    : Im Zustand normal wird der ArrowButton mit den Optionen **foreground** und **background** angezeigt. Der Zustand active wird gewöhnlich verwendet, wenn der Zeiger über dem ArrowButton ist. Im Zustand active wird der ArrowButton mit den Optionen **activeforeground** und **activebackground** angezeigt. Im Zustand disabled bestimmen die Optionen **disabledforeground** und **background**, wie der ArrowButton angezeigt wird. 

    Wenn der **type** des ArrowButton *arrow* ist:
    : Nur die Farben des Pfeils ändern sich. Der Hintergrund des ArrowButton wird immer mit der Option **troughcolor** angezeigt. Im Zustand normal wird der ArrowButton mit der Option **background** angezeigt. Der Zustand active wird gewöhnlich verwendet, wenn der Zeiger über dem ArrowButton ist. Im Zustand active wird der ArrowButton mit der Option **activebackground** angezeigt. Im Zustand disabled wird der ArrowButton mit einer dunklen Schraffur angezeigt. 

    Der Zustand disabled bedeutet, dass der ArrowButton unempfindlich sein soll: die Vorgabebindungen weigern sich, das Widget zu aktivieren, und ignorieren das Drücken der Maustasten.


**-type**
:  Bestimmt den Typ des ArrowButton: **button** für das Aussehen einer Standardschaltfläche oder **arrow** für das Aussehen des Pfeils einer Bildlaufleiste. 


**-width**
:  Legt eine gewünschte Breite für den ArrowButton fest. Der Wert ist in Bildschirmeinheiten. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **invoke** 
: Wenn der **state** des ArrowButton nicht disabled ist, ruft das die Befehle der Schaltfläche auf. Der ArrowButton wird mit der aktiven Farbe und dem Relief sunken neu angezeigt, und **armcommand** wird aufgerufen. Danach wird der ArrowButton mit der normalen Farbe und seinem festgelegten Relief neu angezeigt, und **disarmcommand** und danach **command** werden aufgerufen.

    **invoke** wird aufgerufen, wenn der ArrowButton den Eingabefokus hat und die Leertaste gedrückt wird.
