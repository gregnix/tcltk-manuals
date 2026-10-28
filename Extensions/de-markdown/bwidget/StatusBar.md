*NAME*
: **StatusBar** - Statusleisten-Widget 


*ERZEUGUNG*
: StatusBar *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
    |   [-foreground oder -fg](options.md) |   [-orient](options.md) |
    |   [-relief](options.md) |
    |   [-troughcolor](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |
    | --- |
    |   -height |
    |   -showresize |
    |   -ipad |
    |   -pad |
    |   -width  |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

BESCHREIBUNG

 Das Widget StatusBar ist ein einfacher Container mit einer Ecke zur Größenänderung, gedacht für den unteren Rand eines Toplevel-Dialogs. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-height**
:  Legt die gewünschte Höhe für das Widget fest. 


**-showresize**
:  Legt fest, ob die Ecke zur Größenänderung angezeigt wird. 


**-pad**
:  Der Abstand um die Statusleiste. 


**-ipad**
:  Der Abstand um die einzelnen Einträge der Statusleiste. 


**-width**
:  Legt die gewünschte Breite für das Widget fest. 


---

WIDGET-BEFEHL

*pathName* **add** **widget** ?*option* *value* *option* *value* ...? 
: Fügt der Statusleiste ein Widget hinzu. Mögliche Optionen sind:

    **-weight**
    : Gewichtung dieses Eintrags bei der Größenänderung (wird an **grid** übergeben).

    **-separator**
    : Ob für diesen Eintrag ein Trenner verwendet wird.

    **-sticky**
    : Wird an grid weitergegeben.

    **-pad**
    : Überschreibt die Option **-ipad** des Widgets für diesen Eintrag.


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **delete** **widget** ?*widget* ...? 
:  Löscht ein Widget und den zugehörigen Zustand aus der Statusleiste.


*pathName* **getframe** 
:  Holt das Rahmen-Widget der Statusleiste, in dem die Einträge der Statusleiste erzeugt werden sollen.


*pathName* **items** 
: Liste der Einträge in der Statusleiste.
