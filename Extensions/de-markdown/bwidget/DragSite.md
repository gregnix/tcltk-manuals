*NAME*
: **DragSite** - Befehlsmenge für Ziehen 


*BEFEHL*
: DragSite::include *class* *type* *event* 

: DragSite::register *path* ?*option value...*? 

: DragSite::setdrag *path* *subpath* *initcmd* *endcmd* ?*force*? 


---

BESCHREIBUNG

 Die Befehle dieses Namespace ermöglichen, ein BWidget oder ein Tk-Widget als Ziehort zu definieren. 

---

BEFEHL

DragSite::**include** *class* *type* *event* 
: Dieser Befehl bietet einen einfachen Weg, Optionen zu einem Ziehort in die Ressourcendefinition von BWidget aufzunehmen. Er nimmt die Optionen auf, die **register** braucht: *-dragevent*, initialisiert auf *event*, *-draginitcmd* und *-dragendcmd*, initialisiert auf die leere Zeichenkette, und zwei neue Optionen:

|   |   |
| --- | --- |
| *-dragenabled* | Legt fest, ob Ziehen aktiv ist (initialisiert auf 0)  |


DragSite::**register** *path* ?*option value...*? 
: Dieser Befehl erklärt *path* zum Ziehort. Die Optionen sind:

 

**-dragendcmd**
: Befehl, der aufgerufen wird, wenn das Ziehen endet (das heißt, wenn das Ziehsymbol losgelassen wird). Dieser Befehl wird mit den folgenden Argumenten aufgerufen:

    - der Pfadname der Ziehquelle (das Widget selbst), 
    - der Pfadname des Ablegeziels, 
    - die Operation, 
    - der Typ der gezogenen Daten, 
    - die gezogenen Daten, 
    - das Ergebnis des Ablegens (das Ergebnis des Aufrufs von **-dropcmd** des Ziels), 

Wenn das Ablegen nicht stattfindet, sind das Ziel und die Operation die leere Zeichenkette und das Ergebnis ist 0.


**-dragevent**
:  Legt die Nummer der Maustaste fest, die dem Ziehen zugeordnet ist. Muss **1**, **2** oder **3** sein. 


**-draginitcmd**
: Befehl, der aufgerufen wird, wenn das Ziehen beginnt. Wenn das Ereignis der Option **dragevent** auf *path* eintritt, wird dieser Befehl mit den folgenden Argumenten aufgerufen:

    - Pfadname der Ziehquelle (*path*), 
    - X-Koordinate des Zeigers im Wurzelkoordinatensystem, 
    - Y-Koordinate des Zeigers im Wurzelkoordinatensystem, 
    - ein Toplevel-Fenster, das erzeugt wird, um die gezogenen Daten darzustellen. Wenn der Befehl zurückkehrt und es keine Kinder hat, wird automatisch eine Bitmap angezeigt. 

Wenn der Befehl eine leere Zeichenkette zurückgibt, wird das Ziehen unterdrückt. Andernfalls muss der Befehl eine Liste mit drei Elementen zurückgeben:

    - der Typ der Daten, 
    - die Liste der zulässigen Grundoperationen (**copy**, **move** und **link**) 
    - und die Daten. 

Auch wenn **copy** nicht in der Liste der Grundoperationen steht, gilt es als zulässige Operation, weil die Bedeutung von **copy** die Ziehquelle nicht verändert.



DragSite::**setdrag** *path* *subpath* *initcmd* *endcmd* ?*force*? 
: Dieser Befehl bietet einen einfachen Weg, **register** während der Erzeugung oder Konfiguration eines BWidget aufzurufen.

  - *path* ist der Pfadname des BWidget, 
  - *subpath* ist der Pfadname des Tk-Widgets, auf dem das Ziehereignis eintritt, 
  - *initcmd* BWidget-Befehl für das Ereignis *drag-init*, 
  - *endcmd* BWidget-Befehl für das Ereignis *drag-end*, 
  - *force* legt fest, ob **register** aufgerufen wird, auch wenn sich kein Optionswert geändert hat (0 als Vorgabe, für die Konfiguration eines BWidget; 1 für die Erzeugung eines BWidget). 

**setdrag** prüft das Änderungskennzeichen der Optionen **dragenabled** und **dragevent** und ruft **register** auf, wenn das nach den Optionswerten und den Argumenten *initcmd* und *endcmd* nötig ist. **draginitcmd** und **dragendcmd** werden nicht aus den Optionen des Widgets genommen, weil sie als Benutzerbefehl gelten, den die BWidget-Umsetzung der Ereignisse *drag-init* und *drag-end* aufruft.
