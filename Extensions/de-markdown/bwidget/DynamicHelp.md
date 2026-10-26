*NAME*
: **DynamicHelp** - Hilfe für ein Tk-Widget oder ein BWidget bereitstellen 


*BEFEHL*
: DynamicHelp::add *widget* ?*option value ...*? 

: DynamicHelp::configure ?*option*? ?*value* *option* *value* ...? 

: DynamicHelp::delete *widget* 

: DynamicHelp::include *class* *type* 

: DynamicHelp::register *path* *type* ?*arg...*? 

: DynamicHelp::sethelp *path* *subpath* ?*force*? 


---

BESCHREIBUNG

 Beschreibungstext 

---

BEFEHL

DynamicHelp::**add** ?*option value ...*? 
:  Dieser Befehl fügt dem angegebenen *widget* dynamische Hilfe hinzu. 

**-command**
:  Wenn angegeben, verweist das auf einen Befehl, der ausgeführt wird, um den anzuzeigenden Hilfetext zu holen. Der Befehl muss eine Zeichenkette zur Anzeige zurückgeben. Wenn der Befehl eine leere Zeichenkette zurückgibt, wird keine Hilfe angezeigt. 


**-index**
:  Wenn angegeben, verweist das auf einen Menüindex, an den die Hilfe gebunden wird, anstelle eines Widgets. Wenn **-type** nicht menu ist, wird diese Option ignoriert. 


**-item**
:  Wenn angegeben, verweist das auf ein Item oder ein Tag eines Canvas-Widgets oder auf ein Tag in einem Text-Widget, an das die Hilfe gebunden wird, anstelle eines Widgets. 


**-type**
:  Legt den Typ der Hilfe fest. Kann sein: **balloon**, **variable** oder **menu**. Vorgabe ist **balloon**. 


**-text**
:  Der Text, der als Hilfe angezeigt wird. 


**-variable**
:  Legt einen Variablennamen fest, in den die Hilfezeichenkette geschrieben wird. Ein anderes Widget (zum Beispiel eine Statusleiste) ist dafür zuständig, diese Variable anzuzeigen. 


 Dynamische Hilfe für ein Menü entsteht in zwei Schritten. Zuerst muss das Menü selbst hinzugefügt werden, danach jeder Menüeintrag einzeln. Hier ist ein kurzes Beispiel. 

```
    # Menü erzeugen
    menu .m -type menubar
    # Menüleiste dem Toplevel zuordnen, BEVOR DynamicHelp::register
    # damit es mit dem Klonnamen des Menüs funktioniert
    . configure -menu .m
    .m add cascade -label "File" -menu .m.file
    menu .m.file
    .m.file add command -label "Open..."
    .m.file add command -label "Quit"
    # Label für die Hilfe erzeugen, mit der Variable varinfo
    label .l -textvariable varinfo
    # alle Einträge des Menüs .m.file der Variable varinfo zuordnen
    DynamicHelp::add .m.file -type menu -variable varinfo
    # dann die Einträge von .m.file deklarieren
    DynamicHelp::add .m.file -type menu -index 0 -text "Detach menu"
    DynamicHelp::add .m.file -type menu -index 1 -text "Open a file"
    DynamicHelp::add .m.file -type menu -index 2 -text "Exit demo"
```


DynamicHelp::**configure** ?*option*? ?*value* *option* *value* ...? 
: Dieser Befehl konfiguriert die Ballonhilfe.

**-borderwidth**
:  Breite des schwarzen Randes um den Ballon. 


**-delay**
:  Legt die Verzögerung in Millisekunden der Mausruhe fest, bevor der Ballon angezeigt wird. 


**-state**
:  Legt einen von zwei Zuständen für Hilfeballons fest: **normal** und **disabled**. 

:  Wenn **state** **disabled** ist, werden Hilfeballons für kein registriertes Widget angezeigt. 


**-topbackground**
:  Die Hintergrundfarbe des Toplevel-Fensters, das für einen Ballon erzeugt wird. 


  
Weitere Standardoptionen sind:

|   |   |
| --- | --- |
|   [-background oder -bg](options.md) |   [-font](options.md) |
|   [-foreground oder -fg](options.md) |   [-justify](options.md) |
|   [-padx](options.md) |   [-pady](options.md) |


DynamicHelp::**delete** *widget* 
:  Löscht die gesamte dynamische Hilfe für das angegebene *widget*. 


DynamicHelp::**include** *class* *type* 
:  Beschreibungstext 


DynamicHelp::**register** *path* *type* ?*arg...*? 
:  **Die Verwendung ist veraltet. Stattdessen DynamicHelp::add verwenden.** 

Registriert einen Hilfetext am Widget *path*. *type* bestimmt den Typ der Hilfe oder den Typ des Widgets. Je nach *type* müssen weitere Optionen angegeben werden.   


|   |   |
| --- | --- |
|  **type**  |  **options**  |
|  **balloon**  |  *?tagOrItem? text*  |
|  **variable**  |  *?tagOrItem? varName text*  |
|  **menu**  |  *varName*  |
|  **menuentry**  |  *index text*  |

  
Wenn eine der Optionen fehlt oder leer ist, wird die Hilfe für dieses Widget entfernt.

 Wenn *tagOrItem* angegeben ist, ist *path* ein canvas oder ein text. Bei einem canvas ist *tagOrItem* der Name eines Tags oder Items auf dem canvas, an das die Hilfe gebunden wird. Bei einem text ist *tagOrItem* der Name eines Tags auf dem text, an das die Hilfe gebunden wird. 

Für einen Typ außer *balloon* ist *varName* gewöhnlich eine Variable, die mit einem Label verknüpft ist.   
Für ein Menü gibt es keine Hilfe vom Typ balloon. Um eine Hilfe für ein Menü zu deklarieren, wird zuerst das Menü deklariert und danach die Einträge dieses Menüs.   
Zum Beispiel:   
  
  # Menü erzeugen menu .m -type menubar # Menüleiste dem Toplevel zuordnen, BEVOR DynamicHelp::register # damit es mit dem Klonnamen des Menüs funktioniert . configure -menu .m .m add cascade -label "File" -menu .m.file menu .m.file .m.file add command -label "Open..." .m.file add command -label "Quit" # Label für die Hilfe erzeugen, mit der Variable varinfo label .l -textvariable varinfo # alle Einträge des Menüs .m.file der Variable varinfo zuordnen DynamicHelp::register .m.file menu varinfo # dann die Einträge von .m.file deklarieren DynamicHelp::register .m.file menuentry 0 "Detach menu" DynamicHelp::register .m.file menuentry 1 "Open a file" DynamicHelp::register .m.file menuentry 2 "Exit demo"    
   
Wenn ein Popup-Menü zu einer Menüleiste gehört, muss die Menüleiste zuerst ihrem Toplevel zugeordnet werden. In diesem Fall wird beim Erzeugen eines Menü-Popups auch sein Klonfenster erzeugt, und DynamicHelp::register erkennt das Vorhandensein des Klonfensters und bildet die Ereignisse darauf ab.


DynamicHelp::**sethelp** *path* *subpath* ?*force*? 
:  Beschreibungstext
