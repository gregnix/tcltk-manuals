*NAME*
: **MessageDlg** - Meldungsdialog 


*ERZEUGUNG*
: MessageDlg *pathName* ?*option value...*?


*STANDARDOPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   [-anchor](options.md) |   [-font](options.md) |
    |   [-foreground oder -fg](options.md) |   [-padx](options.md) |
    |   [-pady](options.md) |


*OPTIONEN VON Dialog*
: 

    |   |   |
    | --- | --- |
    |   -background oder -bg |   -cancel |
    |   -default |   -parent |


*WIDGET-SPEZIFISCHE OPTIONEN*
: 

    |   |   |
    | --- | --- |
    |   -aspect |   -buttons |
    |   -buttonwidth |   -icon |
    |   -justify |   -message |
    |   -title |   -type |
    |   -width |


---

BESCHREIBUNG

 MessageDlg bietet einen einfachen Weg, einen Meldungsdialog anzuzeigen. MessageDlg::**create** erzeugt den Meldungsdialog, zeigt ihn an und gibt den Index der gedrückten Schaltfläche zurück, oder -1, wenn er zerstört wird. Beim Zurückkehren existiert der Dialog nicht mehr. 

---

WIDGET-SPEZIFISCHE OPTIONEN

**-aspect**
:  Legt eine nichtnegative ganze Zahl fest, die das gewünschte Seitenverhältnis des Textes angibt. Das Seitenverhältnis ist als 100\*width/height angegeben. 100 bedeutet, der Text soll so breit wie hoch sein, 200 bedeutet, der Text soll doppelt so breit wie hoch sein, 50 bedeutet, der Text soll doppelt so hoch wie breit sein, und so weiter. Dient dazu, die Zeilenlänge des Textes zu wählen, wenn die Option **width** nicht angegeben ist. Voreingestellt ist 150. 


**-buttons**
:  Legt eine Liste von Schaltflächen fest, die angezeigt werden, wenn die Option **type** *user* ist. Wenn eine Schaltfläche einen symbolischen Namen hat, wird der zugehörige Text angezeigt. 


**-buttonwidth**
:  Legt die Standardbreite der Schaltflächen im Dialog fest. 


**-icon**
:  Legt ein Icon fest, das angezeigt wird. Muss einer der folgenden Werte sein: **error**, **info**, **question** oder **warning**. 


**-justify**
:  Legt fest, wie Textzeilen ausgerichtet werden. Muss einer der Werte **left**, **center** oder **right** sein. Voreingestellt ist **left**. Diese Option wirkt zusammen mit den Optionen **anchor**, **aspect**, **padx**, **pady** und **width** und ergibt verschiedene Anordnungen des Textes im Fenster. Die Optionen **aspect** und **width** bestimmen, wie viel Bildschirmplatz für die Anzeige des Textes gebraucht wird. Die Optionen **anchor**, **padx** und **pady** bestimmen, wo dieser rechteckige Bereich im Fenster des Widgets angezeigt wird, und die Option **justify** bestimmt, wie jede Zeile in diesem rechteckigen Bereich angezeigt wird. Wenn zum Beispiel **anchor** **e** und **justify** **left** ist und das Meldungsfenster viel größer ist, als der Text braucht, wird der Text so angezeigt, dass die linken Kanten aller Zeilen auf einer Linie liegen und die rechte Kante der längsten Zeile **padx** von der rechten Seite des Fensters entfernt ist; der gesamte Textblock wird in der senkrechten Ausdehnung des Fensters zentriert. 


**-message**
:  Legt die Meldung fest, die in diesem Meldungsfeld angezeigt wird. 


**-title**
: Legt eine Zeichenkette fest, die als Titel des Meldungsfeldes angezeigt wird. Wenn der Wert leer ist (die Vorgabe), wird ein Vorgabetitel passend zur Option **icon** gesetzt. Der zugehörige Vorgabetitel ist englisch und kann in eine andere Sprache gesetzt werden, indem die Ressource angegeben wird:

    ```
        *MessageDlg.nameTitle:   value
    ```

    oder der gleichwertige Tcl-Befehl:

    ```
        option add *MessageDlg.nameTitle value
    ```

    dabei ist *name* der Name eines Icons, wie er in der Option **icon** definiert ist.   
    Zum Beispiel kann für die französische Sprache bei einem Warndialog angegeben werden:

    ```
        option add *MessageDlg.warningTitle  "Attention"
    ```


**-type**
:  Legt eine Menge von Schaltflächen fest, die angezeigt werden. Die folgenden Werte sind möglich: 

:  

     **abortretryignore** 
    : Zeigt drei Schaltflächen an, deren symbolische Namen **abort**, **retry** und **ignore** sind.



        ok

        Zeigt eine Schaltfläche an, deren symbolischer Name **ok** ist.



        okcancel

        Zeigt zwei Schaltflächen an, deren symbolische Namen **ok** und **cancel** sind.



        retrycancel

        Zeigt zwei Schaltflächen an, deren symbolische Namen **retry** und **cancel** sind.



        yesno

        Zeigt zwei Schaltflächen an, deren symbolische Namen **yes** und **no** sind.



        yesnocancel

        Zeigt drei Schaltflächen an, deren symbolische Namen **yes**, **no** und **cancel** sind.



        user

        Zeigt die Schaltflächen der Option **-buttons** an.




**-width**
:  Legt die Länge der Zeilen im Fenster fest. Wenn diese Option einen Wert größer als null hat, wird die Option **aspect** ignoriert und die Option **width** bestimmt die Zeilenlänge. Wenn diese Option einen Wert kleiner oder gleich null hat, bestimmt die Option **aspect** die Zeilenlänge.
