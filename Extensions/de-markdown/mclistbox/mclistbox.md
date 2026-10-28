

## NAME

mclistbox::mclistbox - Eine mehrspaltige Listbox anlegen und bedienen



## ÜBERSICHT

**package require mclistbox ?1.02**

**mclistbox::mclistbox** *pathName* *?options?*



## EXPORTE

mclistbox



## STANDARDOPTIONEN

**-background** **-borderwidth** **-cursor** **-exportselection** **-font** **-foreground** **-height** **-highlightbackground** **-highlightcolor** **-highlightthickness** **-relief** **-selectbackground** **-selectborderwidth** **-selectforeground** **-setgrid** **-takefocus** **-width** **-xscrollcommand** **-yscrollcommand**

Die ausführliche Beschreibung der Optionen oben steht im Handbucheintrag *options*.



## WIDGET-SPEZIFISCHE OPTIONEN

Befehlszeilen-Name: **-columnborderwidth**
Datenbank-Name: **columnBorderWidth**
Datenbank-Klasse: **BorderWidth**

Legt einen nicht negativen Wert für die Breite des 3D-Rands um die Außenseite der Spalte fest, sofern ein solcher Rand gezeichnet wird. Das bestimmt in der Regel die Option **columnrelief**. Der Wert kann auch für 3D-Effekte im Inneren des Widgets verwendet werden. Zulässig sind alle Formen, die Tk_GetPixels annimmt.

Befehlszeilen-Name: **-columnrelief**
Datenbank-Name: **columnRelief**
Datenbank-Klasse: **Relief**

Legt den gewünschten 3D-Effekt der Spalte fest. Zulässige Werte sind raised, **sunken**, **flat**, **ridge**, **solid** und **groove**. Der Wert sagt, wie das Innere der Spalte gegenüber dem Äußeren erscheinen soll. raised bedeutet zum Beispiel, dass das Innere der Spalte gegenüber dem Äußeren aus dem Bildschirm hervortritt.

Befehlszeilen-Name: **-fillcolumn**
Datenbank-Name: **fillColumn**
Datenbank-Klasse: **FillColumn**

Legt fest, welche Spalte wächst oder schrumpft, sodass alle Spalten das Listbox-Widget genau füllen.

Befehlszeilen-Name: **-labelanchor**
Datenbank-Name: **labelAnchor**
Datenbank-Klasse: **Anchor**

Legt fest, wie der Inhalt der Spaltenbeschriftung angezeigt wird. Einer der Werte **n**, **ne**, **e**, **se**, **s**, **sw**, **w**, **nw** oder **center**. nw zeigt den Inhalt so, dass seine linke obere Ecke in der linken oberen Ecke der Spaltenbeschriftung liegt.

Befehlszeilen-Name: **-labelbackground** oder **-labelbg**
Datenbank-Name: **labelBackground**
Datenbank-Klasse: **Background**

Legt die normale Hintergrundfarbe der Beschriftung fest.

Befehlszeilen-Name: **-labelborderwidth or -labelbd**
Datenbank-Name: **labelBorderWidth**
Datenbank-Klasse: **BorderWidth**

Legt einen nicht negativen Wert für die Breite des 3D-Rands um die Außenseite der Spaltenbeschriftung fest, sofern ein solcher Rand gezeichnet wird. Das bestimmt in der Regel die Option relief. Der Wert kann auch für 3D-Effekte im Inneren der Spaltenbeschriftung verwendet werden. Zulässig sind alle Formen, die Tk_GetPixels annimmt.

Befehlszeilen-Name: **-labelfont**
Datenbank-Name: **labelFont**
Datenbank-Klasse: **Font**

Legt die Schrift fest, mit der Text in der Spaltenbeschriftung gezeichnet wird.

Befehlszeilen-Name: **-labelforeground**
Datenbank-Name: **labelForeground**
Datenbank-Klasse: **Foreground**

Legt die normale Vordergrundfarbe der Spaltenbeschriftung fest.

Befehlszeilen-Name: **-labelheight**
Datenbank-Name: **labelHeight**
Datenbank-Klasse: **Height**

Legt die gewünschte Höhe der Beschriftung fest. Wird in der Beschriftung ein Bild oder eine Bitmap angezeigt, gilt der Wert in Bildschirmeinheiten, also in jeder Form, die Tk_GetPixels annimmt. Für Text gilt er in Textzeilen. Fehlt die Option, wird die gewünschte Höhe aus der Größe des angezeigten Bildes, der Bitmap oder des Textes berechnet.

Befehlszeilen-Name: **-labelrelief**
Datenbank-Name: **labelRelief**
Datenbank-Klasse: **Relief**

Legt den gewünschten 3D-Effekt der Spaltenbeschriftung fest. Zulässige Werte sind **raised**, **sunken**, **flat**, **ridge**, **solid** und **groove**. Der Wert sagt, wie das Innere der Spaltenbeschriftung gegenüber dem Äußeren erscheinen soll. raised bedeutet zum Beispiel, dass das Innere der Spaltenbeschriftung gegenüber dem Äußeren aus dem Bildschirm hervortritt.

Befehlszeilen-Name: **-labels**
Datenbank-Name: **labels**
Datenbank-Klasse: **Labels**

Ein boolescher Wert. Er legt fest, ob Spaltenbeschriftungen angezeigt werden.

Befehlszeilen-Name: **-selectcommand** *command*
Datenbank-Name: **selectCommand**
Datenbank-Klasse: **Command**

Legt einen Tcl-Befehl fest, der läuft, sobald sich die Auswahl in der mclistbox ändert. Der Befehl wird mit dem Ergebnis des Befehls curselection aufgerufen.

Befehlszeilen-Name: **-resizablecolumns**
Datenbank-Name: **resizableColumns**
Datenbank-Klasse: **ResizableColumns**

Legt fest, ob die Spalten interaktiv in der Größe geändert werden können. Ist der Wert true, werden Mausbindungen definiert, die das Ändern erlauben. Mehr dazu unter **VORGABEBINDUNGEN**.

Befehlszeilen-Name: **-selectmode**
Datenbank-Name: **selectMode**
Datenbank-Klasse: **SelectMode**

Legt einen von mehreren Stilen für die Auswahl fest. Der Wert der Option darf beliebig sein. Die Vorgabebindungen erwarten **single**, **browse**, **multiple** oder **extended**. Der Vorgabewert ist browse.



## BESCHREIBUNG

Der Befehl **mclistbox** erzeugt ein neues Fenster, gegeben durch das Argument *pathName*, und macht es zu einem mclistbox-Widget. Weitere Optionen, oben beschrieben, können auf der Befehlszeile Aspekte der mclistbox festlegen, etwa Farben, Schrift, Text und Relief. Der Befehl mclistbox gibt sein Argument pathName zurück. Beim Aufruf darf noch kein Fenster namens pathName bestehen. Das Elternfenster von pathName muss bestehen.

Eine mclistbox zeigt eine Liste von Zeichenketten, eine je Zeile. Eine neue mclistbox hat anfangs keine Elemente und keine Spalten. Spalten und Elemente werden mit den Widget-Befehlen unten hinzugefügt oder gelöscht. Ein oder mehrere Elemente lassen sich auswählen, wie unten beschrieben. Wird ein Element in einer Spalte ausgewählt, werden die Elemente in allen Spalten ausgewählt.

Nicht alle Elemente müssen gleichzeitig im Fenster der mclistbox sichtbar sein. Die Befehle unten ändern die Sicht im Fenster. Mclistboxen lassen sich in beide Richtungen schieben, über die Standardoptionen xScrollCommand und yScrollCommand. Sie unterstützen auch das Scannen, wie unten beschrieben.



## WIDGET-BEFEHL

Der Widget-Befehl nimmt weitgehend dieselben Argumente an wie der Befehl der gewöhnlichen Listbox. Die folgenden Befehle verhalten sich genau wie die Befehle der gewöhnlichen Listbox:

**activate** **bbox** **cget** **configure** **curselection** **delete** **index** **nearest** **scan** **see** **selection** **size** **xview** **yview**

Dazu kommen einige Befehle, die es nur bei der mclistbox gibt:

**pathName column option args**
:

    **pathName column add name options**
    : Fügt eine neue Spalte mit dem angegebenen *name* hinzu. *options* dürfen alle gültigen Spaltenoptionen sein.

        pathName column cget name option

        Gibt den Wert der genannten *option* zurück.

        pathName column configure name options

        Konfiguriert Attribute der genannten Spalte oder fragt sie ab.

        Spalten lassen sich mit den Standardoptionen der Listbox konfigurieren (-background, -font und so weiter). Zusätzlich stehen diese Optionen zur Verfügung:

        **-background**
        : Legt die Hintergrundfarbe dieser Spalte fest. Ist der Wert die leere Zeichenkette, erhält die Spalte die voreingestellte Hintergrundfarbe.

            -bitmap

            Legt eine Bitmap fest, die in der Spaltenbeschriftung angezeigt wird. Ist die Option bitmap angegeben, verdrängt sie die Option -label. Die Option bitmap lässt sich auf die leere Zeichenkette zurücksetzen, damit wieder Text angezeigt wird.

            -font

            Legt die Schrift dieser Spalte fest. Ist der Wert die leere Zeichenkette, erhält die Spalte die voreingestellte Schrift. Werden für getrennte Spalten Schriften mit verschiedener Zeilenhöhe verwendet, stehen die Daten der Spalten nicht auf einer Linie.

            -foreground

            Legt die Vordergrundfarbe dieser Spalte fest. Ist der Wert die leere Zeichenkette, erhält die Spalte die voreingestellte Vordergrundfarbe.

            -image

            Legt ein Bild fest, das in der Spaltenbeschriftung angezeigt wird. Ist die Option image angegeben, verdrängt sie andere Optionen, die eine Bitmap oder einen Text für die Spaltenbeschriftung nennen. Die Option image lässt sich auf die leere Zeichenkette zurücksetzen, damit wieder eine Bitmap oder Text angezeigt wird.

            -label

            Legt den Text fest, der in der Spaltenbeschriftung stehen soll.

            -position

            Legt die Position der Spalte fest. 0 (null) ist die erste Spalte, 1 (eins) die zweite, und so weiter.

            -resizable

            Legt fest, ob die Spalte in der Größe geändert werden kann. Das wirkt nur, wenn die globale Option **-resizablecolumns** true ist.

            -visible

            Legt fest, ob die Spalte sichtbar ist.

            -width

            Legt die gewünschte Breite der Spalte in Zeichen fest. Hat die Schrift keine einheitliche Breite, wird die Breite des Zeichens \`\`0'' verwendet, um von Zeicheneinheiten auf Bildschirmeinheiten umzurechnen. Ist der Wert null oder kleiner, wird die gewünschte Breite des Fensters gerade so groß, dass alle Elemente der Listbox hineinpassen.

        pathName column delete name

        Löscht die Spalte mit dem Namen *name*.

        pathName column names

        Gibt eine Liste aller Spalten-*names* zurück. Die Reihenfolge der Liste ist die sichtbare Reihenfolge der Spalten und dieselbe Reihenfolge, in der der Befehl get die Daten zurückgibt.

        pathName column nearext x

        Zu einer x-Koordinate im Fenster der mclistbox gibt dieser Befehl den Namen der Spalte zurück, die dieser x-Koordinate am nächsten liegt.

    pathName get first ?last?

    Fehlt last, kommt eine Liste zurück mit dem Element jeder Spalte des Listbox-Elements, das *first* bezeichnet, oder eine leere Liste, wenn first auf ein nicht vorhandenes Element zeigt. Ist *last* angegeben, gibt der Befehl eine Liste von Listen zurück. Jede Teilliste enthält ein Element jeder Spalte des mclistbox-Elements. first und last dürfen jede der üblichen Indexformen haben.

    Die Daten kommen in der sichtbaren Reihenfolge der Spalten zurück, derselben Reihenfolge, die der Befehl **column names** meldet.

    pathName insert index list ?list ...?

    Fügt null oder mehr neue Elemente in die mclistbox ein, unmittelbar vor dem Element, das index bezeichnet. Ist index als end angegeben, kommen die neuen Elemente an das Ende der Liste. Der Befehl gibt die leere Zeichenkette zurück. Jedes Argument *list* wird eine Zeile der mclistbox. Reichen die Elemente nicht für alle Spalten, füllen leere Werte die fehlenden Spalten.

    pathName label bind name sequence command

    Dieser Befehl verbindet *command* mit einer Spaltenbeschriftung. Tritt die Ereignisfolge *sequence* über der Beschriftung der Spalte *name* ein, wird *command* aufgerufen. Der Widget-Befehl ähnelt dem Befehl bind, wirkt aber auf Spaltenbeschriftungen und nicht auf das ganze Widget. Der Handbucheintrag bind beschreibt die Syntax von *sequence* und die Ersetzungen in *command* vor dem Aufruf.




## BEISPIEL

Das folgende Beispiel erzeugt eine Listbox mit drei Spalten:



```
    mclistbox .listbox -width 55
```



```
    .listbox column add name -label "First Name"    -width 20
    .listbox column add size -label "Last Name"     -width 20
    .listbox column add mod  -label "Organization"  -width 15
```

Einträge kommen so in die Liste:



```
    .listbox insert end [list "Bryan" "Oakley" "ChannelPoint"]
    .listbox insert end [list "John"  "Ousterhout" "Ajuba Solutions"]
```

… oder kürzer:



```
    .listbox insert end \
            [list "Bryan" "Oakley" "ChannelPoint"] \
            [list "John"  "Ousterhout" "Ajuba Solutions"]
```

Damit eine Prozedur aufgerufen wird, wenn auf die Spaltenbeschriftung der Spalte \`\`date'' geklickt wird, dient \`\`label bind'' wie im folgenden Beispiel:



```
    .listbox label bind date <ButtonPress-1> "sortByDate %W"
```



```
    proc sortByDate {w} {
        # code to sort the contents of the mclistbox named $w
    }
```



## VORGABEBINDUNGEN

Die Bindungen des mclistbox-Widgets sind dieselben wie bei einem gewöhnlichen Listbox-Widget. Ist **-resizableColumns** true, kommen diese Bindungen dazu:

**ButtonPress-1** beginnt eine Größenänderung der Spalte, wenn der Zeiger über einem Spaltenkopf und wenige Pixel vom linken oder rechten Rand der Beschriftung entfernt ist. **B1-Motion** ändert die Spalten beiderseits des Zeigers entsprechend der Bewegung des Zeigers. **ButtonRelease-1** beendet die Größenänderung.

Ist über **label bind** eine Bindung auf einer Beschriftung gesetzt und **-resizablecolumns** ist gesetzt, feuert die Bindung nicht, wenn das Ereignis in den wenigen Pixeln am linken und rechten Rand der Beschriftung liegt, in denen eine Größenänderung möglich ist. So lösen eine Beschriftungsbindung und eine Größenänderung nicht denselben Tastendruck aus.



## FEHLER

Werden für verschiedene Spalten verschiedene Schriften verwendet, stehen die Daten nicht auf einer Linie, wenn diese Schriften nicht dieselbe Zeilenhöhe haben. Derzeit hilft nur, Schriften mit derselben Zeilenhöhe zu verwenden.

Beschriftungen und Bilder gemischt in den Spaltenköpfen ergeben ungleich hohe Köpfe. Dadurch stehen die Daten in den Spalten nicht auf einer Linie.

Ereignisbindungen, die feuern, während der Mauszeiger über einer Spalte ist, liefern falsche Werte für %W, `%x` und %y. Die Werte beziehen sich auf die internen Widgets unter dem Klick und nicht auf das mclistbox-Widget. In Tk gibt es dafür bis 8.1b2 keinen Ausweg. Ein Wert zum Schlüsselwort `%W` lässt sich mit der Funktion ::mclistbox::convert umrechnen. Eine eigene Beschreibung fehlt. Das Beispiel example.tcl dieser Verteilung zeigt den Aufruf.

Der Befehl \`\`\<pathName> xview index'' funktioniert nicht.

Weitere sind sicher noch da.
