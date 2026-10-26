*NAME*
: **PasswdDlg** - Dialog für Anmeldung und Passwort 


*ERZEUGUNG*
: PasswdDlg *pathName* ?*option value...*?


*OPTIONEN VON Dialog*
: 

|   |   |
| --- | --- |
|   -anchor |   -background oder -bg |
|   -homogeneous |   -modal |
|   -padx |   -pady |
|   -parent |   -spacing |
|   -title |


*OPTIONEN VON LabelEntry*
: 

|   |   |
| --- | --- |
|   -background oder -bg |   -borderwidth oder -bd |
|   -disabledforeground |   -entrybg |
|   -entryfg |   -exportselection |
|   -font |   -foreground oder -fg |
|   -helptype |   -highlightbackground |
|   -highlightcolor |   -highlightthickness |
|   -insertbackground |   -insertborderwidth |
|   -insertofftime |   -insertontime |
|   -insertwidth |   -labelanchor |
|   -labelfont |   -labelheight |
|   -labeljustify |   -labelwidth |
|   -loginhelptext (siehe **-helptext**) |   -loginhelpvar (siehe **-helpvar**) |
|   -loginlabel (siehe **-label**) |   -logintext (siehe **-text**) |
|   -logintextvariable (siehe **-textvariable**) |   -loginunderline (siehe **-underline**) |
|   -passwdeditable (siehe **-editable**) |   -passwdhelptext (siehe **-helptext**) |
|   -passwdhelpvar (siehe **-helpvar**) |   -passwdlabel (siehe **-label**) |
|   -passwdstate (siehe **-state**) |   -passwdtext (siehe **-text**) |
|   -passwdtextvariable (siehe **-textvariable**) |   -passwdunderline (siehe **-underline**) |
|   -relief |   -selectbackground |
|   -selectborderwidth |   -selectforeground |
|   -wraplength |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

|   |
| --- |
|   -command |
|   -type |


*WIDGET-BEFEHL*
: *pathName* cget *option* 

: *pathName* configure ?*option*? ?*value* *option* *value* ...? 


---

BESCHREIBUNG

 PasswdDlg bietet einen einfachen Weg, einen Dialog für Anmeldung und Passwort anzuzeigen. PasswdDlg::**create** erzeugt den Dialog, zeigt ihn an und gibt den Wert von Anmeldung und Passwort in einer Liste zurück, oder eine leere Liste, wenn er zerstört wird oder die Schaltfläche cancel gedrückt wird. Beim Zurückkehren existiert der Dialog nicht mehr.   
Zusätzliche Ressourcen können gesetzt werden, um weiteren Text zu ändern: 

```
    *loginName     Beschriftung für das LabelEntry der Anmeldung
    *passwordName  Beschriftung für das LabelEntry des Passworts
```

---

WIDGET-SPEZIFISCHE OPTIONEN

**-command**
:  Legt einen Befehl fest, der aufgerufen wird, wenn die Schaltfläche ok gedrückt wird. 


**-type**
:  Legt eine Menge von Schaltflächen fest, die angezeigt werden. Die folgenden Werte sind möglich: 

:  

 **ok** 
: Zeigt eine Schaltfläche an, deren symbolischer Name **ok** ist.

 

okcancel

Zeigt zwei Schaltflächen an, deren symbolische Namen **ok** und **cancel** sind.

 



---

WIDGET-BEFEHL

*pathName* **cget** *option* 
:  Gibt den aktuellen Wert der Konfigurationsoption zurück, die *option* angibt. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. 


*pathName* **configure** ?*option*? ?*value* *option* *value* ...? 
:  Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Wenn keine *option* angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt. Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die genannte *option* beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der zurückgegeben wird, wenn keine *option* angegeben ist). Wenn ein oder mehrere Paare aus *option* und *value* angegeben sind, ändert der Befehl die genannten Widget-Optionen auf die genannten Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Erzeugungsbefehl akzeptiert. Optionen, die nur gelesen werden können, werden nicht geändert. 


---

Stephane Lavirotte

(Stephane.Lavirotte@sophia.inria.fr)
