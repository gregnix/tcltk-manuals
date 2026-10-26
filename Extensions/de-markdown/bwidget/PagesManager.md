*NAME*
: **PagesManager** - Widget zur Seitenverwaltung 


*ERZEUGUNG*
: PagesManager *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: [-background](options.md)


*WIDGET-SPEZIFISCHE OPTIONEN*
: -height


*WIDGET-BEFEHL*
: *pathName* add *page* 

: *pathName* cget *option* 

: *pathName* compute_size 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* delete *page* 

: *pathName* getframe *page* 

: *pathName* page *first* ?*last*? 

: *pathName* pages ?*first*? ?*last*? 

: *pathName* raise ?*page*? 


---

BESCHREIBUNG

 Das Widget PagesManager verwaltet eine Menge von Seiten und zeigt eine davon an. PagesManager stellt keine Methode für den Benutzerzugriff bereit, wie es NoteBook tut; das kann also über eine Listbox, ein Menü, einen Radiobutton oder etwas anderes geschehen. Das Widget zeigt während der Erzeugung keine Seiten; es muss ein ausdrücklicher Aufruf von **raise** erfolgen, um eine anzuzeigen. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-height**
:  Legt die gewünschte Höhe für die Seiten fest. Wenn diese Option gleich null ist (die Vorgabe), verlangt das Fenster überhaupt keine Größe. In diesem Fall kann PagesManager::**compute_size** aufgerufen werden, damit PagesManager groß genug ist, um die größte Seite zu enthalten. 


**-width**
:  Legt die gewünschte Breite für die Seiten fest. Wenn diese Option gleich null ist (die Vorgabe), verlangt das Fenster überhaupt keine Größe. In diesem Fall kann PagesManager::**compute_size** aufgerufen werden, damit PagesManager groß genug ist, um die größte Seite zu enthalten. 


---

WIDGET-BEFEHL

*pathName* **add** *page* 
:  Fügt eine neue Seite hinzu, die durch *page* gekennzeichnet ist, einen beliebigen Bezeichner. Der Pfadname der neuen Seite wird zurückgegeben, und die Widgets für die Seite sollten mit diesem als Elternteil oder Vorfahr erzeugt werden. PagesManager verwaltet jedoch seine eigene Geometrie. **pack**, **grid** oder ein gleichwertiger Befehl sollten nicht mit dem von **add** zurückgegebenen Pfadnamen verwendet werden. 


*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **compute_size** 
:  Dieser Befehl kann aufgerufen werden, damit der PagesManager groß genug ist, um die größte Seite zu enthalten. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **delete** *page* 
:  Löscht die Seite *page*. 


*pathName* **getframe** *page* 
:  Gibt den Pfadnamen der Seite *page* zurück. 


*pathName* **page** *first* ?*last*? 
:  **Die Verwendung ist veraltet. Stattdessen pages verwenden.**  
   Wenn *last* weggelassen wird, gibt der Befehl die Seite am Index *first* zurück, oder eine leere Zeichenkette, wenn *first* auf ein nicht vorhandenes Element zeigt. Wenn *last* angegeben ist, gibt der Befehl eine Liste zurück, deren Elemente alle Seiten zwischen *first* und *last* sind, einschließlich der Grenzen. Sowohl *first* als auch *last* können jede der Standardformen für Indizes haben. 


*pathName* **pages** ?*first*? ?*last*? 
:  Wenn *first* und *last* weggelassen werden, gibt der Befehl die Liste aller Seiten zurück. Wenn *first* angegeben und *last* weggelassen wird, gibt der Befehl die Seite am Index *first* zurück, oder eine leere Zeichenkette, wenn *first* auf ein nicht vorhandenes Element zeigt. Wenn *first* und *last* angegeben sind, gibt der Befehl eine Liste zurück, deren Elemente alle Seiten zwischen *first* und *last* sind, einschließlich der Grenzen. Sowohl *first* als auch *last* können jede der Standardformen für Indizes haben. 


*pathName* **raise** ?*page*? 
:  Hebt die Seite *page* an oder gibt die angehobene Seite zurück, wenn *page* weggelassen wird.
