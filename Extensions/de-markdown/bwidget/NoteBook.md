*NAME*
: **NoteBook** - Widget zur Notizbuchverwaltung 


*ERZEUGUNG*
: NoteBook *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: [-font](options.md)


*OPTIONS from ArrowButton*
: 

    |   |   |
    | --- | --- |
    |   -activebackground |   -activeforeground |
    |   -background oder -bg |   -borderwidth oder -bd |
    |   -disabledforeground |   -foreground oder -fg |
    |   -repeatdelay |   -repeatinterval |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   -arcradius |   -height |
    |   -homogeneous |   -side |
    |   -tabbevelsize |   -tabpady |
    |   -width |


*WIDGET-BEFEHL*
: *pathName* bindtabs *event* *script* 

: *pathName* cget *option* 

: *pathName* compute_size 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete *page* ?*destroyframe*? 

: *pathName* getframe *page* 

: *pathName* index *page* 

: *pathName* insert *index* *page* ?*option value...*? 

: *pathName* itemcget *page* *option* 

: *pathName* itemconfigure *page* ?*option*? ?*value* *option* *value* ...? 

: *pathName* move *page* *index* 

: *pathName* page *first* ?*last*? 

: *pathName* pages ?*first*? ?*last*? 

: *pathName* raise ?*page*? 

: *pathName* see *page* 


---

BESCHREIBUNG

 Das Widget NoteBook verwaltet eine Menge von Seiten und zeigt eine davon an. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-arcradius**
:  Legt die Stärke der Abrundung an den Ecken eines Reiters fest. Dieser Wert kann von 0 bis 8 Pixel eingestellt werden, die Vorgabe ist 2 Pixel. Gewöhnlich sind kleine Werte vorzuziehen. 


**-height**
:  Legt die gewünschte Höhe für die Seiten fest. Wenn diese Option gleich null ist (die Vorgabe), verlangt das Fenster überhaupt keine Größe. In diesem Fall kann NoteBook::**compute_size** aufgerufen werden, damit NoteBook groß genug ist, um die größte Seite zu enthalten. 


**-homogeneous**
:  Legt fest, ob die Beschriftung der Seiten dieselbe Breite haben muss. 


**-side**
:  Legt die Seite fest, auf der die Beschriftung der Seiten platziert wird. Muss **top** oder **bottom** sein. 


**-tabbevelsize**
:  Legt die Stärke der Abschrägung der Reiter fest. Dieser Wert kann von 0 bis 8 Pixel eingestellt werden, die Vorgabe ist 0 Pixel. Eine Abschrägung von null Pixel ist im Wesentlichen rechteckig, eine von ungleich null sieht trapezförmig aus. 


**-tabpady**
:  Legt den Abstand zwischen dem Text im Reiter und dem oberen und unteren Rand des Reiters fest. Der Abstand kann eine Liste aus zwei Werten sein, die den Abstand oben und unten getrennt angeben. Der Vorgabeabstand ist {0 6}. 


**-width**
:  Legt die gewünschte Breite für die Seiten fest. Wenn diese Option gleich null ist (die Vorgabe), verlangt das Fenster überhaupt keine Größe. In diesem Fall kann NoteBook::**compute_size** aufgerufen werden, damit NoteBook groß genug ist, um die größte Seite zu enthalten. 


---

WIDGET-BEFEHL

*pathName* **bindtabs** *event* *script* 
:  Dieser Befehl ordnet einen Befehl zu, der ausgeführt wird, wenn die von *event* angegebene Ereignisfolge auf einem Reiter eintritt. Der Seitenbezeichner, auf dem das Ereignis eintritt, wird an den Befehl angehängt. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **compute_size** 
:  Dieser Befehl kann aufgerufen werden, damit das NoteBook groß genug ist, um die größte Seite zu enthalten. Wenn alle Seiten -createcmd verwenden, haben sie keine verlangte Größe. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **delete** *page* ?*destroyframe*? 
:  Löscht die Seite *page*. Wenn *destroyframe* 1 ist (die Vorgabe), wird der zu *page* gehörende Rahmen zerstört. Wenn *destroyframe* 0 ist, wird der Rahmen nicht zerstört und von einem weiteren Aufruf von **insert** mit derselben *page* wiederverwendet. 


*pathName* **getframe** *page* 
:  Gibt den Pfadnamen der Seite *page* zurück. 


*pathName* **index** *page* 
:  Gibt den numerischen Index zurück, der dem Eintrag entspricht. 


*pathName* **insert** *index* *page* ?*option value...*? 
: Fügt eine neue Seite ein, die durch *page* gekennzeichnet ist, an der Position *index* in der Seitenliste. *index* muss numerisch oder **end** sein. Der Pfadname der neuen Seite wird zurückgegeben.

    **-createcmd**
    :  Legt einen Befehl fest, der aufgerufen wird, wenn die Seite zum ersten Mal angehoben wird. 

    **-image**
    :  Legt ein Bild fest, das für die Seite links von der Beschriftung angezeigt wird 

    **-leavecmd**
    :  Legt einen Befehl fest, der aufgerufen wird, wenn eine Seite verlassen werden soll. Der Befehl muss 0 zurückgeben, wenn die Seite nicht verlassen werden kann, oder 1, wenn sie es kann. 

    **-raisecmd**
    :  Legt einen Befehl fest, der jedes Mal aufgerufen wird, wenn die Seite angehoben wird. 

    **-state**
    :  Legt den Zustand der Seite fest. Muss **normal** oder **disabled** sein. 

    **-text**
    :  Legt eine Beschriftung fest, die für die Seite angezeigt wird. 


*pathName* **itemcget** *page* *option* 
:  Gibt den aktuellen Wert einer Konfigurationsoption für den Eintrag zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl des Eintrags akzeptiert. 


*pathName* **itemconfigure** *page* ?*option*? ?*value* *option* *value* ...? 
:  Dieser Befehl entspricht dem Befehl **configure**, er gilt aber für die Optionen eines einzelnen Eintrags, während **configure** für die Optionen des Widgets als Ganzes gilt. **Options** kann jeden Wert haben, den der Widget-Befehl zur Erzeugung des Eintrags akzeptiert. Wenn Optionen angegeben sind, werden sie geändert, wie der Befehl angibt, und der Befehl gibt eine leere Zeichenkette zurück. Wenn keine Optionen angegeben sind, gibt der Befehl eine Liste zurück, die die aktuellen Optionen des Eintrags beschreibt. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **move** *page* *index* 
:  Verschiebt den Reiter *page* zum Index *index*. 


*pathName* **page** *first* ?*last*? 
:  **Die Verwendung ist veraltet. Stattdessen pages verwenden.**  
   Wenn *last* weggelassen wird, gibt der Befehl die Seite am Index *first* zurück, oder eine leere Zeichenkette, wenn *first* auf ein nicht vorhandenes Element zeigt. Wenn *last* angegeben ist, gibt der Befehl eine Liste zurück, deren Elemente alle Seiten zwischen *first* und *last* sind, einschließlich der Grenzen. Sowohl *first* als auch *last* können jede der Standardformen für Indizes haben. 


*pathName* **pages** ?*first*? ?*last*? 
:  Wenn *first* und *last* weggelassen werden, gibt der Befehl die Liste aller Seiten zurück. Wenn *first* angegeben und *last* weggelassen wird, gibt der Befehl die Seite am Index *first* zurück, oder eine leere Zeichenkette, wenn *first* auf ein nicht vorhandenes Element zeigt. Wenn *first* und *last* angegeben sind, gibt der Befehl eine Liste zurück, deren Elemente alle Seiten zwischen *first* und *last* sind, einschließlich der Grenzen. Sowohl *first* als auch *last* können jede der Standardformen für Indizes haben. 


*pathName* **raise** ?*page*? 
:  Hebt die Seite *page* an oder gibt die angehobene Seite zurück, wenn *page* weggelassen wird. 


*pathName* **see** *page* 
:  Scrollt die Beschriftungen so, dass die Beschriftung der Seite *page* sichtbar wird.
