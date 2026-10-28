*NAME*
: **DropSite** - Befehlsmenge für Ablegen 


*BEFEHL*
: DropSite::include *class* *types* 

: DropSite::register *path* ?*option value...*? 

: DropSite::setcursor *cursor* 

: DropSite::setdrop *path* *subpath* *dropover* *drop* ?*force*? 

: DropSite::setoperation *op* 


---

BESCHREIBUNG

 Die Befehle dieses Namespace ermöglichen, ein BWidget oder ein Tk-Widget als Ablegeort zu definieren. Ein Ablegeort besteht aus dem Typ des Objekts, das abgelegt werden kann, und der zugehörigen Operation, einem Befehl, der aufgerufen wird, wenn das Ablegen geschieht, und einem Befehl, wenn ein Objekt über das Widget gezogen wird. Ein Ablegeort muss mindestens einen Typ eines zulässigen Objekts und einen Ablegebefehl haben. 

---

BEFEHL

DropSite::**include** *class* *types* 
: Dieser Befehl bietet einen einfachen Weg, Optionen zu einem Ablegeort in die Ressourcendefinition von BWidget aufzunehmen. Er nimmt die Optionen auf, die **register** braucht, *-dropovercmd* und *-dropcmd*, initialisiert auf die leere Zeichenkette, und *-droptypes*, initialisiert auf *types*, und eine neue Option:

    |   |   |
    | --- | --- |
    | *-dropenabled* | Legt fest, ob Ablegen aktiv ist (initialisiert auf 0)  |


DropSite::**register** *path* ?*option value...*? 
: Dieser Befehl erklärt *path* zum Ablegeort. Die Optionen sind:



    **-dropcmd**
    : Dieser Befehl wird aufgerufen, wenn das Ziehsymbol über einem gültigen Ablegeziel-Widget losgelassen wird. Die an den Befehl übergebenen Argumente sind:

            - Pfadname des Ablegeziels (das Widget selbst), 
            - Pfadname der Ziehquelle, 
            - X-Koordinate des Zeigers im Wurzelkoordinatensystem, 
            - Y-Koordinate des Zeigers im Wurzelkoordinatensystem, 
            - Operation, 
            - Typ der gezogenen Daten, 
            - gezogene Daten. 

        Seine Rückgabewerte werden als Ergebnis an den Befehl **-dragendcmd** des Widgets der Ziehquelle übergeben.

    **-dropovercmd**
    : Dieser Befehl kann verwendet werden, um während der Ereignisse *drag-over* ein dynamisches Ziehen bereitzustellen. Während eines Ziehens werden die Ereignisse \<Enter>, \<Motion> und \<Leave> abgefangen und intern behandelt. Die an den Befehl übergebenen Argumente sind:

            - Pfadname des Ablegeziels (das Widget selbst), 
            - Pfadname der Ziehquelle, 
            - Ereignis über dem Ablegeziel: *enter*, *motion* oder *leave*, 
            - X-Koordinate des Zeigers im Wurzelkoordinatensystem, 
            - Y-Koordinate des Zeigers im Wurzelkoordinatensystem, 
            - Operation, 
            - Typ der gezogenen Daten, 
            - gezogene Daten. 

        Der Befehl muss den neuen Zustand des Ziehens angeben:

            - 0, wenn das Widget dieses Ziehen ablehnt. Der Befehl wird beim Ereignis motion/leave nicht erneut aufgerufen. 
            - 1, wenn das Widget dieses Ziehen annimmt. Der Befehl wird beim Ereignis motion/leave nicht erneut aufgerufen. 
            - 2, wenn das Widget dieses Ziehen ablehnt. Der Befehl wird bei jedem Ereignis motion erneut aufgerufen, um neu zu bewerten. 
            - 3, wenn das Widget dieses Ziehen annimmt. Der Befehl wird bei jedem Ereignis motion erneut aufgerufen, um neu zu bewerten. 

        Hier ist eine Liste der Ereignisse und der zugehörigen Aktionen an einem DropSite-Widget. Dieses Beispiel nimmt an, dass der Typ der gezogenen Daten für das Ablegeziel gültig ist. **status** ist der Zustand des Ziehens auf einem DropSite. Sein Wert ist:   


        |   |   |   |   |
        | --- | --- | --- | --- |
        | Ereignis | Alter Zustand | Aktion | Neuer Zustand |
        |  \<Enter> |  - |  wenn DropSite dropovercmd hat, mit enter aufrufen |  Ergebnis von dropovercmd |
        |  sonst |  1 |
        |  \<Motion> |  0 oder 1 |   |  unverändert |
        |  2 oder 3 |  dropovercmd mit motion aufrufen |  Ergebnis von dropovercmd |
        |  \<Leave>  |  0 oder 1 |   |  - |
        |  2 oder 3 |  dropovercmd mit leave aufrufen |  - |
        |  \<Drop> |  0 |  dragendcmd der Ziehquelle aufrufen |  - |
        |  1 |  dropcmd aufrufen und dragendcmd der Ziehquelle aufrufen |
        |  2 |  dropovercmd mit leave aufrufen und dragendcmd der Ziehquelle aufrufen |
        |  3 |  dropcmd aufrufen und dragendcmd der Ziehquelle aufrufen |

    **-droptypes**
    : Legt eine Liste {*type* *oplist* ?*type* *oplist*? ...} der zulässigen Typen und der zugehörigen Operationen für das Ablegeziel fest. Für jeden Typ ist *oplist* eine Liste {*descops* *mod* ?*descops* *mod*? ...}, die Operationen und Modifikatortasten für diese Operationen beschreibt. *descops* beschreibt eine Operation. Das kann eine vordefinierte Operation sein (**copy**, **move** oder **link**) oder eine neue, vom Benutzer definierte Operation der Form {*subop* **baseop** ?*bitmap*?}. *subop* ist der Name der Unteroperation, *baseop* ist der Name der Basisoperation (**copy**, **move** oder **link**) und *bitmap* ist eine Bitmap, die für die Operation angezeigt wird.   
      Wenn *bitmap* leer ist, wird die Vorgabe-Bitmap der Basisoperation für die Unteroperation verwendet.   
      *subop* kann eine Basisoperation sein, um die Bitmap einer Basisoperation zu ändern. In diesem Fall muss *baseop* leer oder gleich *subop* sein.   
      *mod* ist die Modifikatortaste für die Operation. Sie kann sein:

            - **none**, um anzugeben, dass keine Modifikatortaste gedrückt ist. Dieser Modifikator kann nur mit einer Unteroperation namens **default** verwendet werden (und umgekehrt), die keine Operations-Bitmap anzeigt. Für jeden Typ wird der Modifikator **none**, wenn er nicht angegeben ist, automatisch der Unteroperation **default** einer Basisoperation **copy** zugeordnet. 
            - **program**, um eine Unteroperation anzugeben, die nur über **DropSite::setoperation** erreichbar ist. 
            - Eine Liste aus **shift**, **control** und **alt**, die die entsprechende Taste bedeutet. 


DropSite::**setcursor** *cursor* 
:  Dieser Befehl kann innerhalb des Skripts **dragovercmd** verwendet werden. Er ist nützlich, um eine sichtbare Wirkung über den Zustand des Ziehens zu geben. 


DropSite::**setdrop** *path* *subpath* *dropover* *drop* ?*force*? 
: Dieser Befehl bietet einen einfachen Weg, **register** während der Erzeugung oder Konfiguration eines BWidget aufzurufen.

      - *path* ist der Pfadname des BWidget, 
      - *subpath* ist der Pfadname des Tk-Widgets, auf dem das Ziehereignis eintritt, 
      - *dropover* ist ein Befehl für das Ereignis *drag-over*, 
      - *drop* ist ein Befehl für das Ereignis *drop*, 
      - *force* legt fest, ob **register** aufgerufen wird, auch wenn sich kein Optionswert geändert hat (0 als Vorgabe, für die Konfiguration eines BWidget; 1 für die Erzeugung eines BWidget). 

    **setdrop** prüft das Änderungskennzeichen der Optionen **dropenabled** und **droptypes** und ruft **register** auf, wenn das nach den Optionswerten und den Argumenten *dropover* und *drop* nötig ist. **dropovercmd** und **dropcmd** werden nicht aus den Optionen des Widgets genommen, weil sie als Benutzerbefehl gelten, den die BWidget-Umsetzung der Ereignisse *drag-over* und *drop* aufruft.


DropSite::**setoperation** *op* 
:  Beschreibungstext
