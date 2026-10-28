*NAME*
: **LabelEntry** - LabelFrame, das ein Entry-Widget enthält. 


*ERZEUGUNG*
: LabelEntry *pathName* ?*option value...*?


*OPTIONEN VON Entry*
: 

    |   |   |
    | --- | --- |
    |   -borderwidth oder -bd |   -command |
    |   -disabledforeground |   -dragenabled |
    |   -dragendcmd |   -dragevent |
    |   -draginitcmd |   -dragtype |
    |   -dropcmd |   -dropenabled |
    |   -dropovercmd |   -droptypes |
    |   -editable |   -entrybg (siehe **-background**) |
    |   -entryfg (siehe **-foreground**) |   -exportselection |
    |   -font |   -helptext |
    |   -helptype |   -helpvar |
    |   -highlightbackground |   -highlightcolor |
    |   -highlightthickness |   -insertbackground |
    |   -insertborderwidth |   -insertofftime |
    |   -insertontime |   -insertwidth |
    |   -justify |   -relief |
    |   -selectbackground |   -selectborderwidth |
    |   -selectforeground |   -show |
    |   -state |   -takefocus |
    |   -text |   -textvariable |
    |   -width |   -xscrollcommand |


*OPTIONEN VON LabelFrame*
: 

    |   |   |
    | --- | --- |
    |   -background oder -bg |   -disabledforeground |
    |   -foreground oder -fg |   -helptext |
    |   -helptype |   -helpvar |
    |   -label (siehe **-text**) |   -labelanchor (siehe **-anchor**) |
    |   -labelfont (siehe **-font**) |   -labelheight (siehe **-height**) |
    |   -labeljustify (siehe **-justify**) |   -labelwidth (siehe **-width**) |
    |   -name |   -padx |
    |   -pady |   -side |
    |   -state |   -underline |
    |   -wraplength |


*WIDGET-BEFEHL*
: *pathName* bind ?*arg...*? 

: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

BESCHREIBUNG

 LabelEntry ist ein Widget aus einem [LabelFrame](LabelFrame.md)-Widget, das ein [Entry](Entry.md)-Widget enthält. Der Tk-Befehl entry kann auch auf dem LabelEntry-Widget verwendet werden. 

---

WIDGET-BEFEHL

*pathName* **bind** ?*arg...*? 
:  Setzt Bindungen auf dem Entry-Widget. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert.
