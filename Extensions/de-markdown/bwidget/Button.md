*NAME*
: **Button** - Button-Widget mit erweiterten Optionen 


*ERZEUGUNG*
: Button *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-activebackground](options.md) |   [-activeforeground](options.md) |
    |   [-anchor](options.md) |   [-background oder -bg](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   -armcommand |   -command |
    |   -default |   -disarmcommand |
    |   -height |   -helptext |
    |   -helptype |   -helpvar |
    |   -name |   -relief |
    |   -state |   -underline |
    |   -width |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* invoke 


---

BESCHREIBUNG

 Das Widget Button erweitert den Tk-Button um neue Optionen. Hinzugekommen sind Optionen von [DynamicHelp](DynamicHelp.md), ein neuer Relief-Stil, eine Rückruffunktion für **arm**/**disarm** und die Optionen **repeatdelay**/**repeatinterval**. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-armcommand**
:  Legt einen Tcl-Befehl fest, der dem Button zugeordnet wird, wenn Maustaste 1 über dem Button gedrückt wird. Wenn die Option **repeatdelay** oder **repeatinterval** eine positive ganze Zahl ist, wird dieser Befehl wiederholt aufgerufen, solange der Mauszeiger über dem Button ist und bis Maustaste 1 losgelassen wird. 


**-command**
:  Legt einen Tcl-Befehl fest, der dem Button zugeordnet wird. Dieser Befehl wird gewöhnlich aufgerufen, wenn Maustaste 1 über dem Button-Fenster losgelassen wird. 


**-default**
:  Legt einen von drei Zuständen für den Vorgabering fest: **normal**, **active** oder **disabled**. Im Zustand active wird die Schaltfläche mit dem plattformspezifischen Aussehen einer Vorgabeschaltfläche gezeichnet. Im Zustand normal wird die Schaltfläche mit dem plattformspezifischen Aussehen einer Schaltfläche gezeichnet, die nicht die Vorgabe ist, und es bleibt genug Platz, um das Aussehen der Vorgabeschaltfläche zu zeichnen. Die Zustände normal und active ergeben Schaltflächen derselben Größe. Im Zustand disabled wird die Schaltfläche mit dem Aussehen einer Schaltfläche gezeichnet, die nicht die Vorgabe ist, ohne Platz für das Vorgabeaussehen zu lassen. Der Zustand disabled kann eine kleinere Schaltfläche ergeben als der Zustand active. 


**-disarmcommand**
:  Legt einen Tcl-Befehl fest, der dem Button zugeordnet wird, wenn Maustaste 1 losgelassen wird. Dieser Befehl wird auch aufgerufen, wenn der Zeiger nicht über dem Button ist, und immer vor dem Befehl der Option **command**. Er wird gewöhnlich zusammen mit **armcommand**, **repeatdelay** und **repeatinterval** verwendet. 


**-height**
:  Legt eine gewünschte Höhe für den Button fest. Wenn im Button ein Bild oder eine Bitmap angezeigt wird, ist der Wert in Bildschirmeinheiten; bei Text ist er in Textzeilen. Wenn diese Option nicht angegeben ist, wird die gewünschte Höhe des Buttons aus der Größe des angezeigten Bildes, der Bitmap oder des Textes berechnet. 


**-helptext**
:  Text für die dynamische Hilfe. Wenn der Wert leer ist, gibt es für dieses Widget keine Hilfe. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Typ der dynamischen Hilfe. *balloon* oder *variable* verwenden. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable, die verwendet wird, wenn die Option **helptype** *variable* ist. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-name**
:  Legt einen Standardnamen für die Schaltfläche fest. Wenn die Option **\*nameName** in der Ressourcendatenbank gefunden wird, werden die Optionen **text** und **underline** aus ihrem Wert entnommen. 


**-relief**
:  Legt den gewünschten 3D-Effekt für das Widget fest. Zulässige Werte sind die Standardwerte für das Button-Relief (**raised**, **sunken**, **flat**, **ridge**, **solid** und **groove**) und **link**, das festlegt, dass das Button-Relief **flat** ist, wenn der Zeiger außerhalb der Schaltfläche ist, und **raised**, wenn der Zeiger innerhalb ist. 


**-state**
:  Legt einen von drei Zuständen für den Button fest: **normal**, **active** oder **disabled**. Im Zustand normal wird der Button mit den Optionen **foreground** und **background** angezeigt. Der Zustand active wird gewöhnlich verwendet, wenn der Zeiger über dem Button ist. Im Zustand active wird der Button mit den Optionen **activeforeground** und **activebackground** angezeigt. Der Zustand disabled bedeutet, dass der Button unempfindlich sein soll: die Vorgabebindungen weigern sich, das Widget zu aktivieren, und ignorieren das Drücken der Maustasten. In diesem Zustand bestimmen die Optionen **disabledforeground** und **background**, wie der Button angezeigt wird. 


**-underline**
:  Legt den ganzzahligen Index eines Zeichens fest, das in der Beschriftung der Schaltfläche unterstrichen wird. 0 entspricht dem ersten Zeichen des angezeigten Textes, 1 dem nächsten Zeichen, und so weiter.   
  Die Bindung **\<Alt-char>** wird auf dem Toplevel des Buttons automatisch gesetzt, um Button::**setfocus** aufzurufen. 


**-width**
:  Wenn im Button ein Bild oder eine Bitmap angezeigt wird, ist der Wert in Bildschirmeinheiten; bei Text ist er in Zeichen. Wenn diese Option nicht angegeben ist, wird die gewünschte Breite des Buttons aus der Größe des angezeigten Bildes, der Bitmap oder des Textes berechnet. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **invoke** 
: Wenn der **state** des Buttons nicht disabled ist, ruft das die Befehle des Buttons auf. Der Button wird mit der aktiven Farbe und dem Relief sunken neu angezeigt, und **armcommand** wird aufgerufen. Danach wird der Button mit der normalen Farbe und seinem festgelegten Relief neu angezeigt, und **disarmcommand** und danach **command** werden aufgerufen.

    **invoke** wird aufgerufen, wenn der Button den Eingabefokus hat und die Leertaste gedrückt wird.
