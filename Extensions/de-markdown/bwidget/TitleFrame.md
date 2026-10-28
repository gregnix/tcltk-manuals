*NAME*
: **TitleFrame** - Rahmen mit einem Titel 


*ERZEUGUNG*
: TitleFrame *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-background oder -bg](options.md) |   [-borderwidth oder -bd](options.md) |
    |   [-font](options.md) |
    |   [-relief](options.md) |


*WIDGET-SPEZIFISCHE OPTIONEN*
: -baseline


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 

: *pathName* getframe 


---

BESCHREIBUNG

 TitleFrame ermöglicht, einen Rahmen mit einem Titel zu erzeugen, ähnlich dem Motif-Widget XmFrame. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-baseline**
:  Legt die senkrechte Ausrichtung des Titels fest: **top**, **center** oder **bottom**. 


**-ipad**
:  Legt einen Abstand zwischen dem Rand des Rahmens und dem Benutzerrahmen fest. Der Wert ist in Bildschirmeinheiten. 


**-side**
:  Legt die waagerechte Ausrichtung des Titels fest: **left**, **center** oder **right**. 


---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


*pathName* **getframe** 
:  Gibt den Rahmen zurück, in dem jedes andere Widget erzeugt werden kann.
