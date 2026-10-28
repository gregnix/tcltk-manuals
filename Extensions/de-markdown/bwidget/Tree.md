*NAME*
: **Tree** - Tree-Widget 


*ERZEUGUNG*
: Tree *pathName* ?*option value...*?


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

    |   |   |
    | --- | --- |
    |   -closecmd |   -crossfill |
    |   -crossclosebitmap |   -crosscloseimage |
    |   -crossopenbitmap |   -crossopenimage |
    |   -deltax |   -deltay |
    |   -dragenabled |   -dragendcmd |
    |   -dragevent |   -draginitcmd |
    |   -dragtype |   -dropcmd |
    |   -dropenabled |   -dropovercmd |
    |   -dropovermode |   -droptypes |
    |   -height |   -linesfill |
    |   -linestipple |   -opencmd |
    |   -padx |   -redraw |
    |   -selectcommand |   -selectfill |
    |   -showlines |   -width |


*WIDGET-BEFEHL*
: *pathName* bindArea *event* *script* 

: *pathName* bindImage *event* *script* 

: *pathName* bindText *event* *script* 

: *pathName* cget *option* 

: *pathName* closetree *node* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete ?*arg...*? 

: *pathName* edit *node* *text* ?*verifycmd*? ?*clickres*? ?*select*? 

: *pathName* exists *node* 

: *pathName* find *findinfo* ?*confine*? 

: *pathName* index *node* 

: *pathName* insert *index* *parent* *node* ?*option value...*? 

: *pathName* itemcget *node* *option* 

: *pathName* itemconfigure *node* ?*option*? ?*value* *option* *value* ...? 

: *pathName* line *node* 

: *pathName* move *parent* *node* *index* 

: *pathName* nodes *node* ?*first*? ?*last*? 

: *pathName* opentree *node* 

: *pathName* parent *node* 

: *pathName* reorder *node* *neworder* 

: *pathName* see *node* 

: *pathName* selection *cmd* ?*arg...*? 

: *pathName* toggle *node* 

: *pathName* visible *node* 

: *pathName* xview ?*arg...*? 

: *pathName* yview ?*arg...*? 


---

BESCHREIBUNG

 Das Widget **Tree** verwendet canvas, um eine hierarchische Liste von Einträgen (Knoten genannt) anzuzeigen. Jeder Knoten besteht aus einer Beschriftung mit eigener Schriftart und eigenen Vordergrundattributen und einem optionalen Bild oder Fenster. Jeder Knoten kann eine Liste von Unterknoten haben, die eingeklappt oder ausgeklappt werden können. Jeder Knoten wird in einer einzigen Zeile gezeichnet, deren Höhe die Option **deltay** festlegt, sie dürfen also höchstens diese Höhe haben. Ein Knoten wird eindeutig durch eine Zeichenkette gekennzeichnet, die bei der Erzeugung (durch den Befehl **insert**) angegeben wird. Der Knoten namens *root* ist die Wurzel des Baums und wird nicht gezeichnet. Die Baumstruktur hält das Widget selbst. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-closecmd**
:  Legt einen Befehl fest, der aufgerufen wird, wenn ein Knoten geschlossen wird. Der geschlossene Knoten wird an den Befehl angehängt. 


**-crossfill**
:  Legt eine Vordergrundfarbe für die Kreuz-Bitmap fest. 


**-crossclosebitmap**
:  Legt eine Bitmap fest, die anstelle des Standardkreuzes angezeigt wird, wenn ein Knoten geschlossen ist. 


**-crosscloseimage**
:  Legt ein Bild fest, das anstelle des Standardkreuzes angezeigt wird, wenn ein Knoten geschlossen ist. Setzt die Option -crossclosebitmap außer Kraft. 


**-crossopenbitmap**
:  Legt eine Bitmap fest, die anstelle des Standardkreuzes angezeigt wird, wenn ein Knoten offen ist. 


**-crossopenimage**
:  Legt ein Bild fest, das anstelle des Standardkreuzes angezeigt wird, wenn ein Knoten offen ist. Setzt die Option -crossopenbitmap außer Kraft. 


**-deltax**
:  Legt die waagerechte Einrückung zwischen einem Knoten und seinen Kindern fest. 


**-deltay**
:  Legt die senkrechte Größe der Knoten fest. 


**-dragenabled**
:  Ein boolescher Wert, der angibt, ob Ziehen eingeschaltet ist. 


**-dragendcmd**
:  Legt einen Befehl fest, der aufgerufen wird, wenn das Ziehen endet. **dragendcmd** muss ein Befehl sein, der der Beschreibung der Option **dragendcmd** von **DragSite::register** entspricht. 


**-dragevent**
:  Legt die Nummer der Maustaste fest, die dem Ziehen zugeordnet ist. Muss **1**, **2** oder **3** sein. 


**-draginitcmd**
: Tree hat einen Befehlsrahmen für Ereignisse *drag-init*. Dieser Befehl lehnt das Ziehen ab, wenn kein Knoten bezeichnet ist. In den anderen Fällen:   
  Wenn **draginitcmd** leer ist, gibt er zurück:

      - als Datentyp den Wert der Option **dragtype** oder *TREE_NODE*, wenn er leer ist, 
      - *{copy move link}* als die Operationen, 
      - den Bezeichner des Knotens als die Daten. 

    Wenn **draginitcmd** nicht leer ist, wird er mit den folgenden Argumenten aufgerufen:

      - der Pfadname des Baums, 
      - der Bezeichner des gezogenen Knotens, 
      - das Toplevel-Fenster, das erzeugt wird, um die gezogenen Daten darzustellen. 

    und muss einen Wert zurückgeben, der der Option **draginitcmd** entspricht, die in **DragSite::register** beschrieben ist.


**-dragtype**
:  Legt einen anderen Typ des gezogenen Objekts fest. 


**-dropcmd**
: Tree hat einen Befehlsrahmen für Ereignisse *drop*. Dieser Befehl beendet das automatische Scrollen und ermittelt Knoten und Position.   
  Wenn **dropcmd** nicht leer ist, wird er mit den folgenden Argumenten aufgerufen:

      - der Pfadname des Baums, 
      - der Pfadname der Ziehquelle, 
      - eine Liste, die beschreibt, wo das Ablegen geschieht. Sie kann sein:  
      - die aktuelle Operation, 
      - der Datentyp, 
      - die Daten. 

        - *{*__widget__*}*, 
        - *{*__node__ *node}* oder 
        - *{*__position__ *node index}*. 


**-dropenabled**
:  Ein boolescher Wert, der angibt, ob Ablegen eingeschaltet ist. 


**-dropovercmd**
: Tree hat einen Befehlsrahmen für Ereignisse *drag-over*. Dieser Befehl schaltet während des *drag-over* das automatische Scrollen und die Ermittlung der Position ein. Wenn **dropovercmd** nicht leer ist, wird der Befehl mit den folgenden Argumenten aufgerufen:

      - der Pfadname des Baums, 
      - der Pfadname der Ziehquelle, 
      - eine Liste, die beschreibt, wo das Ablegen geschehen kann; ihre Elemente sind:  
      - die aktuelle Operation, 
      - der Datentyp, 
      - die Daten. 

        - die Zeichenkette *widget*, wenn die Option **dropovertype** *w* enthält, sonst die leere Zeichenkette. 
        - der angezielte Knoten, wenn das Ziehsymbol auf einen Knoten zeigt und die Option **dropovertype** *n* enthält, sonst die leere Zeichenkette. 
        - eine Liste mit einem Knoten und der Position innerhalb der Kinder des Knotens, auf die das Ziehsymbol zeigt, wenn die Option **dropovertype** *p* enthält, sonst die leere Zeichenkette. 
        - optional die bevorzugte Methode, wenn das Ablegen sowohl innerhalb eines Knotens als auch zwischen zwei Knoten geschehen kann. Der Wert ist *position* oder *node*. 

    Der Befehl muss eine Liste mit zwei Elementen zurückgeben:

      - den Ablegezustand, entsprechend der Beschreibung in der Option **dropovercmd** von **DropSite::register**, 
      - die gewählte Methode: *widget*, *node* oder *position*. 


**-dropovermode**
:  Legt den Typ der Wechselwirkung *drop-over* fest. Muss eine Kombination aus **w** sein, das festlegt, dass das Ablegen überall auf dem Widget geschehen kann, **p**, das festlegt, dass das Ablegen zwischen zwei Knoten geschehen kann, und **n**, das festlegt, dass das Ablegen innerhalb von Knoten geschieht. 


**-droptypes**
:  Legt eine Liste der akzeptierten abgelegten Objekte und Operationen fest. Weitere Angaben stehen bei der Option **droptypes** von **DropSite::register**.   
  Die Vorgabe ist *TREE_NODE* mit den Operationen **copy** und **move**. 


**-height**
:  Legt die gewünschte Höhe des Baums in Einheiten von **deltay** Pixeln fest. 


**-linesfill**
:  Legt eine Vordergrundfarbe für die Linien zwischen den Knoten fest. 


**-linestipple**
:  Legt eine Schraffur-Bitmap für die Linien zwischen den Knoten fest. 


**-opencmd**
:  Legt einen Befehl fest, der aufgerufen wird, wenn ein Knoten geöffnet wird. Der Name des geöffneten Knotens wird an den Befehl angehängt. 


**-padx**
:  Legt den Abstand zwischen Bild oder Fenster und dem Text der Knoten fest. 


**-redraw**
:  Legt fest, ob der Baum neu gezeichnet werden soll, wenn der Leerlauf beginnt. Auf false setzen, wenn **update** aufgerufen wird, während der Baum geändert wird. 


**-selectcommand**
:  Legt einen Befehl fest, der aufgerufen wird, wenn sich die Auswahl ändert. Der Pfad des Tree-Widgets und die ausgewählten Knoten werden an den Befehl angehängt. 


**-selectfill**
:  Wenn true, wird der Auswahlrahmen über den gesamten Baum von links nach rechts gezeichnet, anstatt nur um den Text des Eintrags. 


**-showlines**
:  Legt fest, ob Linien zwischen den Knoten gezeichnet werden sollen. 


**-width**
:  Legt die gewünschte Breite des Baums in Einheiten von 8 Pixeln fest. 


---

KNOTENNAMEN

 Bestimmte besondere Zeichen in Knotennamen ersetzt der Baum während des Betriebs automatisch. Diese Zeichen sind **& | ^ !**. Sie werden alle durch ein **\_** Zeichen ersetzt. Das dient nur dazu, Fehler zu vermeiden, weil die Zeichen für das Tree-Widget besonders sind.

WIDGET-BEFEHL

*pathName* **bindArea** *event* *script* 
:  Dieser Befehl ordnet einen Befehl zu, der ausgeführt wird, wenn die von *event* angegebene Ereignisfolge irgendwo im Bereich des Tree eintritt. 


*pathName* **bindImage** *event* *script* 
: Dieser Befehl ordnet einen Befehl zu, der ausgeführt wird, wenn die von *event* angegebene Ereignisfolge auf dem Bild eines Knotens eintritt. Der Knotenbezeichner, auf dem das Ereignis eintritt, wird an den Befehl angehängt und kann verwendet werden, um den Baum zu bearbeiten (zum Beispiel **%W** nicht verwenden).

     Wenn **-selectfill** angegeben ist, wird eine etwaige Bindung des Hintergrundrahmens durch **bindText** überschrieben. 


*pathName* **bindText** *event* *script* 
: Dieser Befehl ordnet einen Befehl zu, der ausgeführt wird, wenn die von *event* angegebene Ereignisfolge auf der Beschriftung eines Knotens eintritt. Der Knotenbezeichner, auf dem das Ereignis eintritt, wird an den Befehl angehängt und kann verwendet werden, um den Baum zu bearbeiten (zum Beispiel **%W** nicht verwenden).

     Wenn **-selectfill** angegeben ist, wird eine etwaige Bindung des Hintergrundrahmens durch **bindImage** überschrieben. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **closetree** *node* ?*recurse*? 
:  Dieser Befehl schließt den gesamten Teilbaum, den *node* angibt. Er geht den Baum von *node* aus durch und setzt die Option **open** auf 0, abhängig von *recurse*. Der Vorgabewert von *recurse* ist *true*. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **delete** ?*arg...*? 
:  Löscht alle Knoten (und ihre Kinder) in *arg*. *arg* kann eine Liste von Knoten oder eine Liste von Listen von Knoten sein. Um den ganzen Baum zu löschen, dient *\$pathName delete \[\$pathName nodes root\]*. 


*pathName* **edit** *node* *text* ?*verifycmd*? ?*clickres*? ?*select*? 
:  Bietet einen Weg, die Beschriftung eines Knotens an Ort und Stelle zu bearbeiten. Das ist nur möglich, wenn *node* sichtbar ist (alle seine Eltern sind offen).   
  Der Befehl nimmt den Anfangstext als Argument und ändert die Beschriftung des bearbeiteten Knotens nicht, gibt aber eine leere Zeichenkette zurück, wenn die Bearbeitung abgebrochen wird, oder den eingegebenen Text, wenn die Bearbeitung angenommen wird.   
  Während der Bearbeitung kann mit Escape abgebrochen und mit Return angenommen werden.   
  *clickres* legt fest, was geschieht, wenn außerhalb des bearbeitbaren Bereichs geklickt wird. Wenn *clickres* 0 ist (die Vorgabe), wird die Bearbeitung abgebrochen. Wenn *clickres* 1 ist, wird die Bearbeitung angenommen. In allen anderen Fällen geht die Bearbeitung weiter.   
  Wenn die Bearbeitung angenommen wird und *modifycmd* nicht leer ist, wird er mit dem neuen Text als Argument aufgerufen und muss 1 zurückgeben, um den neuen Text anzunehmen, oder 0, um ihn abzulehnen und die Bearbeitung fortzusetzen.   
  *select* legt fest, ob der Anfangstext ausgewählt werden soll. Die Vorgabe ist 1. 


*pathName* **exists** *node* 
:  Gibt zurück, ob *node* im Baum existiert. 


*pathName* **find** *findinfo* ?*confine*? 
:  Gibt den Knoten zurück, den die Position *findinfo* angibt. *findinfo* kann die Form einer Pixelposition *@x,y* oder der Zeilennummer eines gerade sichtbaren Tree-Knotens haben. Die erste Zeile des Tree hat den Wert null. 

     Wenn *confine* nicht leer ist, wird *findinfo* darauf beschränkt, nur Pixelpositionen in der Fläche der Tree-Beschriftungen zu treffen, nicht irgendwo auf ihren Zeilen. (*confine* hat keine Wirkung, wenn *findinfo* eine Zeilennummer ist.) 


*pathName* **index** *node* 
:  Gibt die Position von *node* in seinem Elternteil zurück. 


*pathName* **insert** *index* *parent* *node* ?*option value...*? 
:  Fügt einen neuen Knoten, der durch *node* gekennzeichnet ist, in die Kinderliste von *parent* an der Position *index* ein. 

     Jedes Vorkommen von *#auto* im Knotennamen wird durch die Nummer des Eintrags in der Reihenfolge des Einfügens ersetzt. Die nicht druckbaren Zeichen \\1 to \\5 sind für den internen Gebrauch reserviert und sollen in Knotennamen nicht vorkommen.



    **-anchor**
    :  Legt den Anker des Bildes oder Fensters des Knotens fest. Voreingestellt ist w. 

    **-data**
    :  Benutzerdaten, die zum Knoten gehören. 

    **-deltax**
    :  Legt die waagerechte Einrückung des Knotens fest. Wenn der Wert -1 ist, wird der Knoten mit dem deltax des gesamten Baums gezeichnet. 

    **-drawcross**
    :  Legt fest, wie das Kreuz gezeichnet wird, mit dem die Kinder eines Knotens ausgeklappt oder eingeklappt werden. Muss einer der Werte **auto**, **always** oder **never** sein.   
      Bei **auto** wird das Kreuz nur gezeichnet, wenn der Knoten Kinder hat. Bei **always** wird das Kreuz immer gezeichnet. Bei **never** wird das Kreuz nie gezeichnet. Zur Kompatibilität mit älteren Versionen dieses Widgets ist **allways** ein veraltetes Synonym für **always**. 

    **-fill**
    :  Legt die Vordergrundfarbe der Beschriftung des Knotens fest. 

    **-font**
    :  Legt eine Schriftart für die Beschriftung des Knotens fest. 

    **-helpcmd**
    :  Wenn angegeben, verweist das auf einen Befehl, der ausgeführt wird, um den anzuzeigenden Hilfetext zu holen. Der Befehl muss eine Zeichenkette zur Anzeige zurückgeben. Wenn der Befehl eine leere Zeichenkette zurückgibt, wird keine Hilfe angezeigt. Siehe auch [DynamicHelp](DynamicHelp.md). 

    **-helptext**
    :  Text für die dynamische Hilfe. Siehe auch [DynamicHelp](DynamicHelp.md). 

    **-helptype**
    :  Typ der dynamischen Hilfe. *balloon* oder *variable* verwenden. Siehe auch [DynamicHelp](DynamicHelp.md). 

    **-helpvar**
    :  Variable, die verwendet wird, wenn die Option **helptype** *variable* ist. Siehe auch [DynamicHelp](DynamicHelp.md). 

    **-image**
    :  Legt ein Bild fest, das links von der Beschriftung des Knotens angezeigt wird. Die Option **window** setzt **image** außer Kraft. 

    **-open**
    :  Legt fest, ob die Kinder des Knotens gezeichnet werden sollen. 

    **-padx**
    :  Legt den Abstand zwischen Bild oder Fenster und dem Text des Knotens fest. Wenn der Wert -1 ist, wird der Knoten mit dem padx des gesamten Baums gezeichnet. 

    **-selectable**
    :  Legt fest, ob der Knoten ausgewählt werden kann. 

    **-text**
    :  Legt die Beschriftung des Knotens fest. 

    **-window**
    :  Legt einen Pfadnamen fest, der links von der Beschriftung des Knotens angezeigt wird. Die Option **window** setzt **image** außer Kraft. 


*pathName* **itemcget** *node* *option* 
:  Gibt den aktuellen Wert einer Konfigurationsoption für den Eintrag zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl des Eintrags akzeptiert. 


*pathName* **itemconfigure** *node* ?*option*? ?*value* *option* *value* ...? 
:  Dieser Befehl entspricht dem Befehl **configure**, er gilt aber für die Optionen eines einzelnen Eintrags, während **configure** für die Optionen des Widgets als Ganzes gilt. **Options** kann jeden Wert haben, den der Widget-Befehl zur Erzeugung des Eintrags akzeptiert. Wenn Optionen angegeben sind, werden sie geändert, wie der Befehl angibt, und der Befehl gibt eine leere Zeichenkette zurück. Wenn keine Optionen angegeben sind, gibt der Befehl eine Liste zurück, die die aktuellen Optionen des Eintrags beschreibt. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **line** *node* 
:  Gibt die Zeilennummer zurück, in der *node* gezeichnet wurde. Wenn der Knoten nicht sichtbar ist, wird -1 zurückgegeben. Die erste Zeile des Baums hat den Wert 0. 


*pathName* **move** *parent* *node* *index* 
:  Verschiebt *node* in die Kinderliste von *parent* an die Position *index*. *parent* kann kein Nachkomme von *node* sein. 


*pathName* **nodes** *node* ?*first*? ?*last*? 
:  Gibt Teile der Kinder von *node* zurück, entsprechend *first* und *last*.  
   Wenn *first* und *last* weggelassen werden, gibt der Befehl die Liste aller Kinder zurück. Wenn *first* angegeben und *last* weggelassen wird, gibt der Befehl das Kind am Index *first* zurück, oder eine leere Zeichenkette, wenn *first* auf ein nicht vorhandenes Element zeigt. Wenn *first* und *last* angegeben sind, gibt der Befehl eine Liste zurück, deren Elemente alle Kinder zwischen *first* und *last* sind, einschließlich der Grenzen. Sowohl *first* als auch *last* können jede der Standardformen für Indizes haben. 


*pathName* **opentree** *node* ?*recurse*? 
:  Dieser Befehl öffnet den gesamten Teilbaum, den *node* angibt. Er geht den Baum von *node* aus durch und setzt die Option **open** auf 1, abhängig vom Wert von *recurse*. Der Vorgabewert von *recurse* ist *true*. 


*pathName* **parent** *node* 
:  Gibt den Elternteil von *node* zurück. 


*pathName* **reorder** *node* *neworder* 
:  Ändert die Reihenfolge der Kinder von *node*, die *neworder* angibt. Kinder von *node*, die nicht in *neworder* vorkommen, werden nicht verschoben. 


*pathName* **see** *node* 
:  Ordnet den Scrollbereich so an, dass *node* sichtbar wird. 


*pathName* **selection** *cmd* ?*arg...*? 
: Ändert die Liste der ausgewählten Knoten entsprechend *cmd*:

    **add** 
    : Nimmt alle Knoten in *arg* in die Auswahl auf. 

    **clear** 
    : Entfernt alle Knoten aus der Auswahl. 

    **get** 
    : Gibt eine Liste mit den Indizes der aktuell ausgewählten Knoten zurück. 

    **includes** 
    : Prüft, ob der angegebene Knoten ausgewählt ist. Gibt true zurück, wenn die Antwort ja ist, und sonst false. 

    **range** 
    : Setzt die Auswahl auf alle Knoten zwischen den beiden angegebenen. 

    **remove** 
    : Entfernt alle Knoten in *arg* aus der Auswahl. 

    **set** 
    : Setzt die Auswahl auf alle Knoten in *arg*. 

    **toggle** 
    : Schaltet den Auswahlzustand aller Knoten in *arg* um. 

    Die Unterbefehle **add**, **range** und **set** ignorieren still Knoten, die als nicht auswählbar deklariert sind. Die Knotenoption -selectable beeinflusst das.


*pathName* **toggle** *node* 
:  Schaltet den Zustand offen/geschlossen des angegebenen *node* um. 


*pathName* **visible** *node* 
:  Gibt zurück, ob *node* sichtbar ist (alle seine Eltern sind offen). 


*pathName* **xview** ?*arg...*? 
:  Standardbefehl, um das waagerechte Scrollen von *pathName* zu ermöglichen. 


*pathName* **yview** ?*arg...*? 
:  Standardbefehl, um das senkrechte Scrollen von *pathName* zu ermöglichen. 


BINDUNGEN

 Ein virtuelles Ereignis **<\<TreeSelect>>** wird jedes Mal erzeugt, wenn sich die Auswahl im Baum ändert. Das ist das Vorgabeverhalten eines Eintrags im Baum, es kann aber mit dem Befehl bindText oder bindImage überschrieben werden. Wenn die Bindung der Taste 1 überschrieben wird, wird dieses Ereignis möglicherweise nicht erzeugt.

 Der Baum hat alle Standardbindungen des Mausrads, wenn er den Fokus hat.
