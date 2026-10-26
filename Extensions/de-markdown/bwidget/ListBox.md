*NAME*
: **ListBox** - ListBox-Widget 


*ERZEUGUNG*
: ListBox *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

|   |   |
| --- | --- |
|   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
|   [-cursor](options.md) |   [-highlightbackground](options.md) |
|   [-highlightcolor](options.md) |   [-highlightthickness](options.md) |
|   [-relief](options.md) |   [-selectbackground](options.md) |
|   [-selectforeground](options.md) |   [-takefocus](options.md) |
|   [-xscrollcommand](options.md) |   [-yscrollcommand](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |   |   |
| --- | --- | --- |
|   -autofocus |   -deltax |   -deltay |
|   -dragenabled |   -dragendcmd |
|   -dragevent |   -draginitcmd |
|   -dragtype |   -dropcmd |
|   -dropenabled |   -dropovercmd |
|   -dropovermode |   -droptypes |
|   -height |   -multicolumn |
|   -padx |   -redraw |
|   -selectfill |   -selectmode |   -width |


*WIDGET-BEFEHL*
: *pathName* bindImage *event* *script* 

: *pathName* bindText *event* *script* 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete ?*arg...*? 

: *pathName* edit *item* *text* ?*verifycmd*? ?*clickres*? ?*select*? 

: *pathName* exists *item* 

: *pathName* index *item* 

: *pathName* insert *index* *item* ?*option value...*? 

: *pathName* item *first* ?*last*? 

: *pathName* itemcget *item* *option* 

: *pathName* itemconfigure *item* ?*option*? ?*value* *option* *value* ...? 

: *pathName* items ?*first*? ?*last*? 

: *pathName* move *item* *index* 

: *pathName* reorder *neworder* 

: *pathName* see *item* 

: *pathName* selection *cmd* ?*arg...*? 

: *pathName* xview ?*arg...*? 

: *pathName* yview ?*arg...*? 


---

BESCHREIBUNG

 Das Widget **ListBox** verwendet canvas, um eine Liste von Einträgen anzuzeigen. Jeder Eintrag besteht aus einer Beschriftung mit eigener Schriftart und eigenen Vordergrundattributen und einem optionalen Bild oder Fenster. Jeder Eintrag wird in einer einzigen Zeile gezeichnet, deren Höhe die Option **deltay** festlegt, sie dürfen also höchstens diese Höhe haben. Ein Eintrag wird eindeutig durch eine Zeichenkette gekennzeichnet, die bei der Erzeugung (durch den Befehl **insert**) angegeben wird. Die ListBox kann eine oder mehrere Spalten haben, abhängig von der Option **multicolumn**. Die Spalten werden nicht selbst verwaltet; die Anzahl der Spalten ergibt sich aus der Höhe der ListBox, damit jeder Eintrag senkrecht sichtbar ist. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-autofocus**
:  Wenn diese Option true ist, nimmt die Listbox den Fokus, sobald in sie geklickt wird. Ohne Fokus arbeiten die Mausrad-Bindungen der Listbox nicht richtig. Die Vorgabe ist true. 


**-deltax**
:  Legt den waagerechten Abstand zwischen den Spalten fest. 


**-deltay**
:  Legt die senkrechte Größe der Einträge fest. 


**-dragenabled**
:  Ein boolescher Wert, der angibt, ob Ziehen eingeschaltet ist. 


**-dragendcmd**
:  Legt einen Befehl fest, der aufgerufen wird, wenn das Ziehen endet. **dragendcmd** muss ein Befehl sein, der der Beschreibung der Option **dragendcmd** von **DragSite::register** entspricht. 


**-dragevent**
:  Legt die Nummer der Maustaste fest, die dem Ziehen zugeordnet ist. Muss **1**, **2** oder **3** sein. 


**-draginitcmd**
: ListBox hat einen Befehlsrahmen für Ereignisse *drag-init*. Dieser Befehl lehnt das Ziehen ab, wenn kein Eintrag bezeichnet ist. In den anderen Fällen:   
  Wenn **draginitcmd** leer ist, gibt er zurück:

  - als Datentyp den Wert der Option **dragtype** oder *LISTBOX_ITEM*, wenn er leer ist, 
  - *{move copy link}* als die Operationen, 
  - den Bezeichner des Eintrags als die Daten. 

Wenn **draginitcmd** nicht leer ist, wird er mit den folgenden Argumenten aufgerufen:

  - der Pfadname der Listbox, 
  - der Bezeichner des gezogenen Eintrags, 
  - das Toplevel-Fenster, das erzeugt wird, um die gezogenen Daten darzustellen. 

und muss einen Wert zurückgeben, der der Option **draginitcmd** entspricht, die in **DragSite::register** beschrieben ist.


**-dragtype**
:  Legt einen anderen Typ des gezogenen Objekts fest. 


**-dropcmd**
: ListBox hat einen Befehlsrahmen für Ereignisse *drop*. Dieser Befehl beendet das automatische Scrollen und ermittelt Eintrag und Position.   
  Wenn **dropcmd** nicht leer ist, wird er mit den folgenden Argumenten aufgerufen:

  - der Pfadname der Listbox, 
  - der Pfadname der Ziehquelle, 
  - eine Liste, die beschreibt, wo das Ablegen geschieht. Sie kann sein:  
  - die aktuelle Operation, 
  - der Datentyp, 
  - die Daten. 

    - *{*__widget__*}*, 
    - *{*__item__ *item}* oder 
    - *{*__position__ *index}*. 

 Der Vorgabe-Ablegebefehl erlaubt Ziehen und Ablegen innerhalb der Listbox, aber nicht zu anderen Widgets oder von ihnen. 


**-dropenabled**
:  Ein boolescher Wert, der angibt, ob Ablegen eingeschaltet ist. 


**-dropovercmd**
: LsitBox hat einen Befehlsrahmen für Ereignisse *drag-over*. Dieser Befehl schaltet während des *drag-over* das automatische Scrollen und die Ermittlung der Position ein. Wenn **dropovercmd** nicht leer ist, wird der Befehl mit den folgenden Argumenten aufgerufen:

  - der Pfadname der Listbox, 
  - der Pfadname der Ziehquelle, 
  - eine Liste, die beschreibt, wo das Ablegen geschehen kann; ihre Elemente sind:  
  - die aktuelle Operation, 
  - der Datentyp, 
  - die Daten. 

    - die Zeichenkette *widget*, wenn die Option **dropovertype** *w* enthält, sonst die leere Zeichenkette. 
    - der angezielte Eintrag, wenn das Ziehsymbol auf einen Eintrag zeigt und die Option **dropovertype** *i* enthält, sonst die leere Zeichenkette. 
    - ein Index zwischen zwei Einträgen, auf den das Ziehsymbol zeigt, wenn die Option **dropovertype** *p* enthält, sonst die leere Zeichenkette. 
    - optional die bevorzugte Methode, wenn das Ablegen sowohl innerhalb eines Eintrags als auch zwischen zwei Einträgen geschehen kann. Der Wert ist *position* oder *item*. 

Der Befehl muss eine Liste mit zwei Elementen zurückgeben:

  - den Ablegezustand, entsprechend der Beschreibung in der Option **dropovercmd** von **DropSite::register**, 
  - die gewählte Methode: *widget*, *item* oder *position*. 


**-dropovermode**
:  Legt den Typ der Wechselwirkung *drop-over* fest. Muss eine Kombination aus **w** sein, das festlegt, dass das Ablegen überall auf dem Widget geschehen kann, **p**, das festlegt, dass das Ablegen zwischen zwei Einträgen geschehen kann, und **i**, das festlegt, dass das Ablegen innerhalb von Einträgen geschieht. 


**-droptypes**
:  Legt eine Liste der akzeptierten abgelegten Objekte und Operationen fest. Weitere Angaben stehen bei der Option **droptypes** von **DropSite::register**.   
  Die Vorgabe ist *LISTBOX_ITEM* mit den Operationen **copy** und **move**. 


**-height**
:  Legt die gewünschte Höhe der Listbox in Einheiten von **deltay** Pixeln fest. 


**-multicolumn**
:  Legt fest, ob die ListBox die Einträge so anordnet, dass jeder senkrecht sichtbar ist. 


**-padx**
:  Legt den Abstand zwischen Bild oder Fenster und dem Text der Einträge fest. 


**-redraw**
:  Legt fest, ob die Listbox neu gezeichnet werden soll, wenn der Leerlauf beginnt. Auf false setzen, wenn **update** aufgerufen wird, während die Listbox geändert wird. 


**-selectfill**
:  Wenn true, zeichnet die Listbox ein Auswahlrechteck, das die Listbox von links nach rechts füllt, anstatt nur einen Rahmen um den ausgewählten Eintrag zu zeichnen. Das entspricht eher der Tk-Listbox der Vorgabe. 


**-selectmode**
:  Legt den gewünschten Auswahlmodus der Listbox fest. Muss einer der Werte **none**, **single** oder **multiple** sein. **selectmode** *single* erlaubt, 1 Eintrag über seinen Text oder sein Bild auszuwählen. **selectmode** *multiple* erlaubt, mehrere Einträge über ihren Text oder ihr Bild auszuwählen. Weitere Angaben zu den Auswahlmodi *single* oder *multiple* stehen beim Tk-Befehl **listbox**. Der Vorgabewert für **selectmode** ist *none*. 


**-width**
:  Legt die gewünschte Breite der Listbox in Einheiten von 8 Pixeln fest. 


---

WIDGET-BEFEHL

*pathName* **bindImage** *event* *script* 
: Dieser Befehl ordnet einen Befehl zu, der ausgeführt wird, wenn die von *event* angegebene Ereignisfolge auf dem Bild eines Eintrags eintritt. Der Eintragsbezeichner, auf dem das Ereignis eintritt, wird an den Befehl angehängt.

 Jedes Vorkommen von **%W** in *script* wird durch den Pfad der Listbox ersetzt. 


*pathName* **bindText** *event* *script* 
: Dieser Befehl ordnet einen Befehl zu, der ausgeführt wird, wenn die von *event* angegebene Ereignisfolge auf der Beschriftung eines Eintrags eintritt. Der Eintragsbezeichner, auf dem das Ereignis eintritt, wird an den Befehl angehängt.

 Jedes Vorkommen von **%W** in *script* wird durch den Pfad der Listbox ersetzt. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **delete** ?*arg...*? 
:  Löscht alle Einträge in *arg*. *arg* kann eine Liste von Einträgen oder eine Liste von Listen von Einträgen sein. Um alle Einträge zu löschen, dient *\$pathName delete \[\$pathName items\]*. 


*pathName* **edit** *item* *text* ?*verifycmd*? ?*clickres*? ?*select*? 
:  Bietet einen Weg, die Beschriftung eines Eintrags an Ort und Stelle zu bearbeiten.   
  Der Befehl nimmt den Anfangstext als Argument und ändert die Beschriftung des bearbeiteten Knotens nicht, gibt aber eine leere Zeichenkette zurück, wenn die Bearbeitung abgebrochen wird, oder den eingegebenen Text, wenn die Bearbeitung angenommen wird.   
  Während der Bearbeitung kann mit Escape abgebrochen und mit Return angenommen werden.   
  *clickres* legt fest, was geschieht, wenn außerhalb des bearbeitbaren Bereichs geklickt wird. Wenn *clickres* 0 ist (die Vorgabe), wird die Bearbeitung abgebrochen. Wenn *clickres* 1 ist, wird die Bearbeitung angenommen. In allen anderen Fällen geht die Bearbeitung weiter.   
  Wenn die Bearbeitung angenommen wird und *modifycmd* nicht leer ist, wird er mit dem neuen Text als Argument aufgerufen und muss 1 zurückgeben, um den neuen Text anzunehmen, oder 0, um ihn abzulehnen und die Bearbeitung fortzusetzen.   
  *select* legt fest, ob der Anfangstext ausgewählt werden soll. Die Vorgabe ist 1. 


*pathName* **exists** *item* 
:  Gibt 1 zurück, wenn *item* in der Listbox existiert, sonst 0. 


*pathName* **index** *item* 
:  Gibt die Position von *item* in der Liste zurück. 


*pathName* **insert** *index* *item* ?*option value...*? 
:  Fügt einen neuen Eintrag, der durch *item* gekennzeichnet ist, an der Position *index* in die Liste ein. 

 Jedes Vorkommen von *#auto* im Namen des Eintrags wird durch die Nummer des Eintrags in der Reihenfolge des Einfügens ersetzt. 

 

**-data**
:  Benutzerdaten, die zum Eintrag gehören. 


**-fill**
:  Legt die Vordergrundfarbe der Beschriftung des Eintrags fest. 


**-font**
:  Legt eine Schriftart für die Beschriftung des Eintrags fest. 


**-image**
:  Legt ein Bild fest, das links von der Beschriftung des Eintrags angezeigt wird. Die Option **window** setzt **image** außer Kraft. 


**-indent**
:  Legt den zusätzlichen Abstand in Pixeln links vom Eintrag fest. 


**-text**
:  Legt die Beschriftung des Eintrags fest. 


**-window**
:  Legt einen Pfadnamen fest, der links von der Beschriftung des Eintrags angezeigt wird. Die Option **window** setzt **image** außer Kraft. 



*pathName* **item** *first* ?*last*? 
:  **Die Verwendung ist veraltet. Stattdessen items verwenden.**  
   Wenn *last* weggelassen wird, gibt der Befehl den Eintrag am Index *first* in der Liste zurück, oder eine leere Zeichenkette, wenn *first* auf ein nicht vorhandenes Element zeigt. Wenn *last* angegeben ist, gibt der Befehl eine Liste zurück, deren Elemente alle Einträge zwischen *first* und *last* sind, einschließlich der Grenzen. Sowohl *first* als auch *last* können jede der Standardformen für Indizes haben. 


*pathName* **itemcget** *item* *option* 
:  Gibt den aktuellen Wert einer Konfigurationsoption für den Eintrag zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl des Eintrags akzeptiert. 


*pathName* **itemconfigure** *item* ?*option*? ?*value* *option* *value* ...? 
:  Dieser Befehl entspricht dem Befehl **configure**, er gilt aber für die Optionen eines einzelnen Eintrags, während **configure** für die Optionen des Widgets als Ganzes gilt. **Options** kann jeden Wert haben, den der Widget-Befehl zur Erzeugung des Eintrags akzeptiert. Wenn Optionen angegeben sind, werden sie geändert, wie der Befehl angibt, und der Befehl gibt eine leere Zeichenkette zurück. Wenn keine Optionen angegeben sind, gibt der Befehl eine Liste zurück, die die aktuellen Optionen des Eintrags beschreibt. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **items** ?*first*? ?*last*? 
:  Wenn *first* und *last* weggelassen werden, gibt der Befehl die Liste aller Einträge zurück. Wenn *first* angegeben und *last* weggelassen wird, gibt der Befehl den Eintrag am Index *first* zurück, oder eine leere Zeichenkette, wenn *first* auf ein nicht vorhandenes Element zeigt. Wenn *first* und *last* angegeben sind, gibt der Befehl eine Liste zurück, deren Elemente alle Einträge zwischen *first* und *last* sind, einschließlich der Grenzen. Sowohl *first* als auch *last* können jede der Standardformen für Indizes haben. 


*pathName* **move** *item* *index* 
:  Verschiebt *item* an die Position *index* in der Liste. 


*pathName* **reorder** *neworder* 
:  Ändert die Reihenfolge der Einträge in der Listbox, die *neworder* angibt. Einträge, die nicht in *neworder* vorkommen, werden nicht verschoben. 


*pathName* **see** *item* 
:  Ordnet den Scrollbereich so an, dass *item* sichtbar wird. 


*pathName* **selection** *cmd* ?*arg...*? 
: Ändert die Liste der ausgewählten Einträge entsprechend *cmd*:

**clear** 
: entfernt alle Einträge der Auswahl. 

**set** 
: setzt die Auswahl auf alle Einträge in *arg* 

**add** 
: nimmt alle Einträge von *arg* in die Auswahl auf 

**remove** 
: entfernt alle Einträge von *arg* aus der Auswahl 

**get** 
: gibt die aktuell ausgewählten Einträge zurück 



*pathName* **xview** ?*arg...*? 
:  Standardbefehl, um das waagerechte Scrollen von *pathName* zu ermöglichen. 


*pathName* **yview** ?*arg...*? 
:  Standardbefehl, um das senkrechte Scrollen von *pathName* zu ermöglichen. 


BINDUNGEN

 Ein virtuelles Ereignis **<\<ListboxSelect>>** wird jedes Mal erzeugt, wenn sich die Auswahl in der Listbox ändert. 

 Die Listbox hat alle Standardbindungen des Mausrads, wenn sie den Fokus hat.
