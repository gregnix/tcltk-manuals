

Im Aufbau ...

*NAME*
: **BWidget** - Beschreibungstext 


*BEFEHL*
: BWidget::XLFDfont *cmd* ?*arg...*? 

: BWidget::assert *exp* ?*msg*? 

: BWidget::badOptionString *type* *value* *list* 

: BWidget::bindMouseWheel *widget* 

: BWidget::classes *class* 

: BWidget::clonename *menu* 

: BWidget::focus *option* *path* 

: BWidget::get3dcolor *path* *bgcolor* 

: BWidget::getname *name* 

: BWidget::grab *option* *path* 

: BWidget::inuse *class* 

: BWidget::library *class* ?*class ...*? 

: BWidget::lreorder *list* *neworder* 

: BWidget::parsetext *text* 

: BWidget::place *path* *w* *h* ?*arg...*? 

: BWidget::write *filename* ?*mode*? 

: BWidget::wrongNumArgsString *string* 


---

BESCHREIBUNG

 Beschreibungstext 

---

BEFEHL

BWidget::**XLFDfont** *cmd* ?*arg...*? 
:  Beschreibungstext 


BWidget::**assert** *exp* ?*msg*? 
:  Beschreibungstext 


BWidget::**badOptionString** *type* *value* *list* 
:  Gibt eine passende Fehlerzeichenkette für einen *value* vom *type* zurück, der nicht zu *list* passt. 


BWidget::**bindMouseWheel** *widget* 
:  Bindet das angegebene *widget* mit den Standardbindungen des Mausrads. 


BWidget::**classes** *class* 
:  Gibt eine Liste der Klassen zurück, die die angegebene *class* braucht. 


BWidget::**clonename** *menu* 
:  Beschreibungstext 


BWidget::**focus** *option* *path* 
:  Beschreibungstext 


BWidget::**get3dcolor** *path* *bgcolor* 
:  Beschreibungstext 


BWidget::**getname** *name* 
:  Beschreibungstext 


BWidget::**grab** *option* *path* 
:  Beschreibungstext 


BWidget::**inuse** *class* 
:  Gibt true oder false zurück, je nachdem, ob die angegebene *class* vom aktuell laufenden Programm verwendet wird. 


BWidget::**library** *class* ?*class ...*? 
:  Gibt eine Zeichenkette mit Code zurück, die alle Bibliotheken enthält, die gebraucht werden, um die durch *class* angegebenen Widgets zu verwenden. Der Code jeder Klasse und der Code ihrer abhängigen Klassen wird an die Zeichenkette angehängt und zurückgegeben. Das ist vor allem nützlich, um BWidgets in ein anderes Projekt zu speichern. 


BWidget::**lreorder** *list* *neworder* 
:  Beschreibungstext 


BWidget::**parsetext** *text* 
:  Beschreibungstext 


BWidget::**place** *path* *w* *h* ?*arg...*? 
: Dient dazu, das durch *path* angegebene Widget zu positionieren und in der Größe zu ändern. *w* und *h* geben die verlangte Breite und Höhe des Widgets *path* für **wm geometry** an (0 verwendet die aktuellen Werte). Die Platzierung des Widgets relativ zu anderen Widgets oder zum Bildschirm steuern zusätzliche Argumente:

**at** *x* *y*
: Platziert das durch das Argument *path* angegebene Widget an der Bildschirmposition x,y. Angaben zu den Werten der Fensterplatzierung stehen bei **wm geometry**.

**center** *?widget?*
: Platziert das Widget *path* zentriert gegen *widget* oder gegen das Wurzel-Widget, wenn *widget* nicht angegeben ist.

**right** *?widget?*
: Platziert das Widget *path* links oder rechts vom Bezugs-Widget (oder vom Wurzel-Widget, wenn *widget* nicht angegeben ist). Wenn die Position des Bezugs-Widgets so ist, dass das neu platzierte Fenster verdeckt sein könnte, wird die gegenüberliegende Seite versucht.

**below** *?widget?*
: Wie bei links/rechts oben bewirkt diese Option, dass das Widget entweder über oder unter dem Bezugs-Widget platziert wird; die gegenüberliegende Platzierung wird versucht, wenn das neu platzierte Widget nicht sichtbar wäre. 



BWidget::**write** *filename* ?*mode*? 
:  Schreibt die aktuell verwendete Menge des Klassencodes von BWidget in den angegebenen *filename*. Der gesamte Code, der nötig ist, um die aktuell verwendeten BWidgets auszuführen, wird in die Datei geschrieben. Das ist vor allem nützlich, um BWidget-Code als eine einzige Datei in ein anderes Projekt zu speichern, anstelle des gesamten BWidget-Pakets. 


BWidget::**wrongNumArgsString** *string* 
:  Gibt eine Standard-Fehlerzeichenkette für die falsche Anzahl von Argumenten zurück. *string* wird an die Standardzeichenkette angehängt.
