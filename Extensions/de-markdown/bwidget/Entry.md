*NAME*
: **Entry** - Entry-Widget mit der Option **state**, dynamischer Hilfe und Ziehen und Ablegen 


*ERZEUGUNG*
: Entry *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
    |   [-disabledbackground](options.md) |   [-disabledforeground](options.md) |
    |   [-exportselection](options.md) |   [-font](options.md) |
    |   [-foreground oder -fg](options.md) |   [-highlightbackground](options.md) |
    |   [-highlightcolor](options.md) |   [-highlightthickness](options.md) |
    |   [-insertbackground](options.md) |   [-insertborderwidth](options.md) |
    |   [-insertofftime](options.md) |   [-insertontime](options.md) |
    |   [-insertwidth](options.md) |   [-justify](options.md) |
    |   [-relief](options.md) |   [-selectbackground](options.md) |
    |   [-selectborderwidth](options.md) |   [-selectforeground](options.md) |
    |   [-takefocus](options.md) |   [-text](options.md) |
    |   [-textvariable](options.md) |   [-xscrollcommand](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   -command |   -dragenabled |
    |   -dragendcmd |   -dragevent |
    |   -draginitcmd |   -dragtype |
    |   -dropcmd |   -dropenabled |
    |   -dropovercmd |   -droptypes |
    |   -editable |   -helptext |
    |   -helptype |   -helpvar |
    |   -show |   -state |
    |   -width |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* invoke 


---

BESCHREIBUNG

 Das Widget **Entry** erweitert das Tk-Entry der Vorgabe. Hinzugekommen sind Optionen für eine sichtbare Wirkung je nach Zustand des Entry, Optionen von [DynamicHelp](DynamicHelp.md) sowie [Ziehen](DragSite.md) und [Ablegen](DropSite.md). Entry verhält sich weitgehend wie ein Label, mit der Option **text**, die den Inhalt setzt.   
Der Tk-Befehl entry kann auch auf dem Entry-Widget verwendet werden. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-command**
:  Legt einen Befehl fest, der aufgerufen wird, wenn im Entry \<Return> gedrückt wird. 


**-dragenabled**
:  Ein boolescher Wert, der angibt, ob Ziehen eingeschaltet ist. 


**-dragendcmd**
:  Legt einen Befehl fest, der aufgerufen wird, wenn das Ziehen endet. **dragendcmd** muss ein Befehl sein, der der Beschreibung der Option **dragendcmd** von **DragSite::register** entspricht.   
  Wenn **dragendcmd** leer ist, aktualisiert der interne Befehl *dragend* das Entry entsprechend der Operation (**move** oder **copy**) und den gezogenen Daten (das ganze Entry oder der ausgewählte Teil). 


**-dragevent**
:  Legt die Nummer der Maustaste fest, die dem Ziehen zugeordnet ist. Muss **1**, **2** oder **3** sein. 


**-draginitcmd**
: Legt einen Befehl fest, der aufgerufen wird, wenn **dragevent** auf dem Widget eintritt. **draginitcmd** muss ein Befehl sein, der der Beschreibung der Option **draginitcmd** von **DragSite::register** entspricht.   
  Wenn **draginitcmd** leer ist, lehnt der Befehl das Ziehen ab, wenn das Entry leer ist oder wenn ein Textabschnitt ausgewählt ist und das Ereignis nicht über der Auswahl eintritt. In allen anderen Fällen gibt der Befehl zurück:

      - als Datentyp den Wert der Option **dragtype** oder *TEXT*, wenn er leer ist, 
      - als Operationen *{copy move}*, wenn **state** normal und **editable** true ist, oder nur *{copy}* in den anderen Fällen, 
      - als Daten den gesamten Inhalt oder den ausgewählten Teil des Entry. 


**-dragtype**
:  Legt einen anderen Typ des gezogenen Objekts fest. 


**-dropcmd**
: Entry hat einen Befehlsrahmen für Ereignisse *drop*. Dieser Befehl beendet das automatische Scrollen und ermittelt die aktuelle Position.   
  Wenn **dropcmd** nicht leer ist, wird er mit den folgenden Argumenten aufgerufen:

      - der Pfadname des Entry, 
      - der Pfadname der Ziehquelle, 
      - der numerische Index im Entry, den der Cursor bezeichnet, 
      - die aktuelle Operation, 
      - der Datentyp, 
      - die Daten. 

    und muss einen Wert zurückgeben, der der Option **dropcmd** entspricht, die in **DropSite::register** beschrieben ist. Wenn **dropcmd** leer ist, aktualisiert der Rahmen das Entry entsprechend dem Typ der Daten:

    :

        |   |   |
        | --- | --- |
        | *COLOR* oder *FGCOLOR* | konfiguriert den **foreground** des Entry neu |
        | *BGCOLOR* | konfiguriert den **background** des Entry neu |
        | *TEXT*,   oder jedes andere Tag | konfiguriert das Entry neu, damit es die zugehörige Zeichenkette anzeigt. |

    und gibt 1 zurück.


**-dropenabled**
:  Ein boolescher Wert, der angibt, ob Ablegen eingeschaltet ist. 


**-dropovercmd**
: Entry hat einen Befehlsrahmen für Ereignisse *drag-over*. Dieser Befehl schaltet während des *drag-over* das automatische Scrollen und die Ermittlung der Position ein.   
  Wenn **dropovercmd** leer ist, nimmt der Rahmen das Ablegen an, wenn die Option **editable** true und die Option **state** normal ist.   
  Wenn **dropovercmd** nicht leer ist, wird er mit den folgenden Argumenten aufgerufen:

      - der Pfadname des Entry, 
      - der Pfadname der Ziehquelle, 
      - das Ereignis, 
      - der numerische Index im Entry, den der Cursor bezeichnet, 
      - die aktuelle Operation, 
      - der Datentyp, 
      - die Daten. 

    und muss einen Wert zurückgeben, der der Option **dropovercmd** entspricht, die in **DropSite::register** beschrieben ist.


**-droptypes**
:  Legt eine Liste der akzeptierten abgelegten Objekte und Operationen fest. Weitere Angaben stehen bei der Option **droptypes** von **DropSite::register**. Die Vorgabe akzeptiert *FGCOLOR*, *COLOR*, *BGCOLOR* und *TEXT*, jeweils mit den Operationen **copy** und **move**. 


**-editable**
:  Legt fest, ob der Benutzer das Entry bearbeiten kann. Entspricht der Option **state** des Tk-Widgets entry. 


**-helptext**
:  Text für die dynamische Hilfe. Wenn der Wert leer ist, gibt es für dieses Widget keine Hilfe. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helptype**
:  Typ der dynamischen Hilfe. *balloon* oder *variable* verwenden. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-helpvar**
:  Variable, die verwendet wird, wenn die Option **helptype** *variable* ist. Siehe auch [DynamicHelp](DynamicHelp.md). 


**-show**
:  Wenn diese Option angegeben ist, wird der wirkliche Inhalt des Entry nicht im Fenster angezeigt. Stattdessen wird jedes Zeichen des Wertes des Entry als das erste Zeichen des Wertes dieser Option angezeigt, wie \`\`\*''. Das ist nützlich, wenn das Entry zum Beispiel für ein Passwort verwendet wird. Wenn Zeichen im Entry ausgewählt und an eine andere Stelle kopiert werden, ist die kopierte Information das Angezeigte, nicht der wirkliche Inhalt des Entry.


**-state**
:  Legt einen von zwei Zuständen für das Entry fest: **normal** oder **disabled**. Im Zustand normal wird der Text des Entry mit der Option **foreground** angezeigt. Im Zustand disabled wird der Text des Entry mit der Option **disabledforeground** angezeigt. Wenn das Entry disabled ist, kann der Wert nicht durch Benutzereingabe geändert werden, und es wird kein Einfügecursor angezeigt, auch wenn der Eingabefokus im Widget liegt. Der Zustand disabled ist dasselbe wie nicht bearbeitbar, mit sichtbarer Wirkung. 


**-width**
:  Legt eine ganze Zahl fest, die die gewünschte Breite des Entry-Fensters in Zeichen mittlerer Größe der Schriftart des Widgets angibt. Wenn der Wert kleiner oder gleich null ist, wählt das Widget eine Größe, die gerade für den aktuellen Text reicht. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **invoke** 
:  Ruft den Befehl auf, den die Option **-command** angibt.
