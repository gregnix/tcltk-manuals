---
CommandName: Plotchart
title: Plotchart
ManualSection: n
Version: 2.6.2
TclPart: tklib
TclDescription: Plotchart
Copyright:
 - Copyright (c) 2022 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

Plotchart – Einfaches Paket zum Zeichnen und Erstellen von Diagrammen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.optlit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.optlit}
[package]{.cmd} [require]{.sub} [Plotchart]{.lit} [2.6.2]{.optlit}
[::Plotchart::createXYPlot]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [args]{.arg}
[::Plotchart::createStripchart]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [args]{.arg}
[::Plotchart::createTXPlot]{.cmd} [w]{.arg} [timeaxis]{.arg} [xaxis]{.arg} [args]{.arg}
[::Plotchart::createXLogYPlot]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [args]{.arg}
[::Plotchart::createLogXYPlot]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [args]{.arg}
[::Plotchart::createLogXLogYPlot]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [args]{.arg}
[::Plotchart::createPolarPlot]{.cmd} [w]{.arg} [radius\_data]{.arg} [args]{.arg}
[::Plotchart::createWindrose]{.cmd} [w]{.arg} [radius\_data]{.arg} [sectors]{.arg}
[::Plotchart::createIsometricPlot]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [stepsize]{.arg}
[::Plotchart::createHistogram]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [args]{.arg}
[::Plotchart::create3DPlot]{.cmd} [w]{.arg} [xaxis]{.arg} [yaxis]{.arg} [zaxis]{.arg} [args]{.arg}
[::Plotchart::create3DRibbonPlot]{.cmd} [w]{.arg} [yaxis]{.arg} [zaxis]{.arg}
[::Plotchart::createPiechart]{.cmd} [w]{.arg}
[::Plotchart::createSpiralPie]{.cmd} [w]{.arg}
[::Plotchart::createRadialchart]{.cmd} [w]{.arg} [names]{.arg} [scale]{.arg} [style]{.arg}
[::Plotchart::createBarchart]{.cmd} [w]{.arg} [xlabels]{.arg} [yaxis]{.arg} [noseries]{.arg} [args]{.arg}
[::Plotchart::createHorizontalBarchart]{.cmd} [w]{.arg} [xaxis]{.arg} [ylabel]{.arg} [noseries]{.arg}
[::Plotchart::create3DBarchart]{.cmd} [w]{.arg} [yaxis]{.arg} [nobars]{.arg}
[::Plotchart::create3DRibbonChart]{.cmd} [w]{.arg} [names]{.arg} [yaxis]{.arg} [zaxis]{.arg}
[::Plotchart::createBoxplot]{.cmd} [w]{.arg} [xdata]{.arg} [ydata]{.arg} [orientation]{.arg}
[::Plotchart::createTimechart]{.cmd} [w]{.arg} [time\_begin]{.arg} [time\_end]{.arg} [args]{.arg}
[::Plotchart::createGanttchart]{.cmd} [w]{.arg} [time\_begin]{.arg} [time\_end]{.arg} [args]{.arg}
[::Plotchart::createRightAxis]{.cmd} [w\_or\_plot]{.arg} [yaxis]{.arg}
[::Plotchart::createTableChart]{.cmd} [w]{.arg} [columns]{.arg} [widths]{.optarg}
[::Plotchart::createTernaryDiagram]{.cmd} [w]{.arg} [args]{.arg}
[::Plotchart::createNormalPlot]{.cmd} [w]{.arg} [xscale]{.arg} [args]{.arg}
[::Plotchart::createStatusTimeline]{.cmd} [w]{.arg} [xaxis]{.arg} [ylabel]{.arg} [args]{.arg}
[::Plotchart::createDendrogram]{.cmd} [w]{.arg} [args]{.arg}
[$anyplot]{.cmd} [title]{.lit} [text]{.arg} [position]{.arg}
[$anyplot]{.cmd} [subtitle]{.lit} [text]{.arg}
[$anyplot]{.cmd} [canvas]{.lit}
[$anyplot]{.cmd} [saveplot]{.lit} [filename]{.arg} [args]{.arg}
[$anyplot]{.cmd} [xtext]{.lit} [text]{.arg}
[$anyplot]{.cmd} [ytext]{.lit} [text]{.arg}
[$anyplot]{.cmd} [vtext]{.lit} [text]{.arg}
[$anyplot]{.cmd} [xsubtext]{.lit} [text]{.arg}
[$anyplot]{.cmd} [ysubtext]{.lit} [text]{.arg}
[$anyplot]{.cmd} [vsubtext]{.lit} [text]{.arg}
[$anyplot]{.cmd} [xconfig]{.lit} [-option]{.lit} [value]{.arg} ...
[$anyplot]{.cmd} [yconfig]{.lit} [-option]{.lit} [value]{.arg} ...
[$anyplot]{.cmd} [background]{.lit} [part]{.arg} [colour\_or\_image]{.arg} [dir]{.arg} [brightness]{.optarg}
[$anyplot]{.cmd} [xticklines]{.lit} [colour]{.arg} [dash]{.optarg}
[$anyplot]{.cmd} [yticklines]{.lit} [colour]{.arg} [dash]{.optarg}
[$anyplot]{.cmd} [legend]{.lit} [series]{.arg} [text]{.arg} [spacing]{.optarg}
[$anyplot]{.cmd} [removefromlegend]{.lit} [series]{.arg}
[$anyplot]{.cmd} [legendconfig]{.lit} [-option]{.lit} [value]{.arg} ...
[$anyplot]{.cmd} [balloon]{.lit} [x]{.arg} [y]{.arg} [text]{.arg} [dir]{.arg}
[$anyplot]{.cmd} [balloonconfig]{.lit} [args]{.arg}
[$anyplot]{.cmd} [plaintext]{.lit} [x]{.arg} [y]{.arg} [text]{.arg} [dir]{.arg}
[$anyplot]{.cmd} [plaintextconfig]{.lit} [args]{.arg}
[$anyplot]{.cmd} [object]{.lit} [itemtype]{.arg} [series]{.arg} [args]{.arg}
[$anyplot]{.cmd} [deletedata]{.lit}
[$xyplot]{.cmd} [plot]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg}
[$normalplot]{.cmd} [plot]{.lit} [series]{.arg} [mean]{.arg} [stdev]{.arg} [data]{.arg}
[$normalplot]{.cmd} [diagonal]{.lit}
[$xyplot]{.cmd} [plotlist]{.lit} [series]{.arg} [xlist]{.arg} [ylist]{.arg} [every]{.arg}
[$xyplot]{.cmd} [region]{.lit} [series]{.arg} [xlist]{.arg} [ylist]{.arg}
[$xyplot]{.cmd} [minmax]{.lit} [series]{.arg} [xcrd]{.arg} [ymin]{.arg} [ymax]{.arg}
[$histogram]{.cmd} [plotcumulative]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg}
[$xyplot]{.cmd} [trend]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg}
[$xyplot]{.cmd} [rchart]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg}
[$xyplot]{.cmd} [interval]{.lit} [series]{.arg} [xcrd]{.arg} [ymin]{.arg} [ymax]{.arg} [ycentr]{.optarg}
[$xyplot]{.cmd} [box-and-whiskers]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg}
[$xyplot]{.cmd} [violin]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg}
[$xyplot]{.cmd} [vector]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg} [ucmp]{.arg} [vcmp]{.arg}
[$xyplot]{.cmd} [vectorconfig]{.lit} [series]{.arg} [-option]{.lit} [value]{.arg} ...
[$xyplot]{.cmd} [dot]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg} [value]{.arg}
[$xyplot]{.cmd} [dotconfig]{.lit} [series]{.arg} [-option]{.lit} [value]{.arg} ...
[$xyplot]{.cmd} [contourlines]{.lit} [xcrd]{.arg} [ycrd]{.arg} [values]{.arg} [classes]{.optarg}
[$xyplot]{.cmd} [contourlinesfunctionvalues]{.lit} [xvec]{.arg} [yvec]{.arg} [valuesmat]{.arg} [classes]{.optarg}
[$xyplot]{.cmd} [contourfill]{.lit} [xcrd]{.arg} [ycrd]{.arg} [values]{.arg} [classes]{.optarg}
[$xyplot]{.cmd} [contourbox]{.lit} [xcrd]{.arg} [ycrd]{.arg} [values]{.arg} [classes]{.optarg}
[$xyplot]{.cmd} [colorMap]{.lit} [colours]{.arg}
[$xyplot]{.cmd} [legendisolines]{.lit} [values]{.arg} [classes]{.arg}
[$xyplot]{.cmd} [legendshades]{.lit} [values]{.arg} [classes]{.arg}
[$xyplot]{.cmd} [grid]{.lit} [xcrd]{.arg} [ycrd]{.arg}
[$xyplot]{.cmd} [xband]{.lit} [ymin]{.arg} [ymax]{.arg}
[$xyplot]{.cmd} [yband]{.lit} [xmin]{.arg} [xmax]{.arg}
[$xyplot]{.cmd} [labeldot]{.lit} [x]{.arg} [y]{.arg} [text]{.arg} [orient]{.arg}
[$polarplot]{.cmd} [plot]{.lit} [series]{.arg} [radius]{.arg} [angle]{.arg}
[$windrose]{.cmd} [plot]{.lit} [data]{.arg} [colour]{.arg}
[$plot3d]{.cmd} [plotfunc]{.lit} [function]{.arg}
[$plot3d]{.cmd} [plotfuncont]{.lit} [function]{.arg} [contours]{.arg}
[$plot3d]{.cmd} [gridsize]{.lit} [nxcells]{.arg} [nycells]{.arg}
[$plot3d]{.cmd} [plotdata]{.lit} [data]{.arg}
[$plot3d]{.cmd} [interpolatedata]{.lit} [data]{.arg} [contours]{.arg}
[$plot3d]{.cmd} [colour]{.lit} [fill]{.arg} [border]{.arg}
[$plot3d]{.cmd} [ribbon]{.lit} [yzpairs]{.arg}
[$plot3d]{.cmd} [plot]{.lit} [yzpairs]{.arg}
[$xyplot]{.cmd} [dataconfig]{.lit} [series]{.arg} [-option]{.lit} [value]{.arg} ...
[$pie]{.cmd} [plot]{.lit} [data]{.arg}
[$pie]{.cmd} [colours]{.lit} [colour1]{.arg} [colour2]{.arg} ...
[$pie]{.cmd} [explode]{.lit} [segment]{.arg}
[$radial]{.cmd} [plot]{.lit} [data]{.arg} [colour]{.arg} [thickness]{.arg}
[$pie]{.cmd} [colours]{.lit} [colour1]{.arg} [colour2]{.arg} ...
[$barchart]{.cmd} [plot]{.lit} [series]{.arg} [ydata]{.arg} [colour]{.arg} [dir]{.optarg} [brightness]{.optarg}
[$barchart]{.cmd} [config]{.lit} [-option]{.lit} [value]{.arg} ...
[$barchart]{.cmd} [plot]{.lit} [series]{.arg} [xdata]{.arg} [colour]{.arg} [dir]{.optarg} [brightness]{.optarg}
[$barchart]{.cmd} [config]{.lit} [-option]{.lit} [value]{.arg} ...
[$barchart]{.cmd} [plot]{.lit} [label]{.arg} [yvalue]{.arg} [colour]{.arg}
[$barchart]{.cmd} [config]{.lit} [-option]{.lit} [value]{.arg} ...
[$ribbon]{.cmd} [line]{.lit} [xypairs]{.arg} [colour]{.arg}
[$ribbon]{.cmd} [area]{.lit} [xypairs]{.arg} [colour]{.arg}
[$boxplot]{.cmd} [plot]{.lit} [series]{.arg} [label]{.arg} [values]{.arg}
[$boxplot]{.cmd} [violin]{.lit} [series]{.arg} [label]{.arg} [values]{.arg}
[$timechart]{.cmd} [period]{.lit} [text]{.arg} [time\_begin]{.arg} [time\_end]{.arg} [colour]{.arg}
[$timechart]{.cmd} [addperiod]{.lit} [time\_begin]{.arg} [time\_end]{.arg} [colour]{.arg}
[$timechart]{.cmd} [milestone]{.lit} [text]{.arg} [time]{.arg} [colour]{.arg}
[$timechart]{.cmd} [addmilestone]{.lit} [time]{.arg} [colour]{.arg}
[$timechart]{.cmd} [vertline]{.lit} [text]{.arg} [time]{.arg} [colour]{.arg}
[$timechart]{.cmd} [hscroll]{.lit} [scrollbar]{.arg}
[$timechart]{.cmd} [vscroll]{.lit} [scrollbar]{.arg}
[$ganttchart]{.cmd} [task]{.lit} [text]{.arg} [time\_begin]{.arg} [time\_end]{.arg} [completed]{.arg}
[$ganttchart]{.cmd} [milestone]{.lit} [text]{.arg} [time]{.arg} [colour]{.arg}
[$ganttchart]{.cmd} [vertline]{.lit} [text]{.arg} [time]{.arg}
[$ganttchart]{.cmd} [connect]{.lit} [from]{.arg} [to]{.arg}
[$ganttchart]{.cmd} [summary]{.lit} [text]{.arg} [args]{.arg}
[$ganttchart]{.cmd} [color]{.lit} [keyword]{.arg} [newcolor]{.arg}
[$ganttchart]{.cmd} [font]{.lit} [keyword]{.arg} [newfont]{.arg}
[$ganttchart]{.cmd} [hscroll]{.lit} [scrollbar]{.arg}
[$ganttchart]{.cmd} [vscroll]{.lit} [scrollbar]{.arg}
[$isoplot]{.cmd} [plot]{.lit} [rectangle]{.lit} [x1]{.arg} [y1]{.arg} [x2]{.arg} [y2]{.arg} [colour]{.arg}
[$isoplot]{.cmd} [plot]{.lit} [filled-rectangle]{.lit} [x1]{.arg} [y1]{.arg} [x2]{.arg} [y2]{.arg} [colour]{.arg}
[$isoplot]{.cmd} [plot]{.lit} [circle]{.lit} [xc]{.arg} [yc]{.arg} [radius]{.arg} [colour]{.arg}
[$isoplot]{.cmd} [plot]{.lit} [filled-circle]{.lit} [xc]{.arg} [yc]{.arg} [radius]{.arg} [colour]{.arg}
[$table]{.cmd} [row]{.lit} [items]{.arg}
[$table]{.cmd} [separator]{.lit}
[$table]{.cmd} [formatcommand]{.lit} [procname]{.arg}
[$table]{.cmd} [cellconfigure]{.lit} [args]{.arg}
[$ternary]{.cmd} [plot]{.lit} [series]{.arg} [xcrd]{.arg} [ycrd]{.arg} [zcrd]{.arg} [text]{.arg} [dir]{.arg}
[$ternary]{.cmd} [line]{.lit} [series]{.arg} [coords]{.arg}
[$ternary]{.cmd} [fill]{.lit} [series]{.arg} [coords]{.arg}
[$ternary]{.cmd} [text]{.lit} [xtext]{.arg} [ytext]{.arg} [ztext]{.arg}
[$ternary]{.cmd} [ticklines]{.lit} [colour]{.arg}
[$timeline]{.cmd} [plot]{.lit} [series]{.arg} [item]{.arg} [start]{.arg} [stop]{.arg} [color]{.arg}
[$timeline]{.cmd} [vertline]{.lit} [text]{.arg} [time]{.arg} [args]{.arg}
[$dendrogram]{.cmd} [plot]{.lit} [series]{.arg} [data]{.arg}
[::Plotchart::viewPort]{.cmd} [w]{.arg} [pxmin]{.arg} [pymin]{.arg} [pxmax]{.arg} [pymax]{.arg}
[::Plotchart::worldCoordinates]{.cmd} [w]{.arg} [xmin]{.arg} [ymin]{.arg} [xmax]{.arg} [ymax]{.arg}
[::Plotchart::world3DCoordinates]{.cmd} [w]{.arg} [xmin]{.arg} [ymin]{.arg} [zmin]{.arg} [xmax]{.arg} [ymax]{.arg} [zmax]{.arg}
[::Plotchart::coordsToPixel]{.cmd} [w]{.arg} [x]{.arg} [y]{.arg}
[::Plotchart::coords3DToPixel]{.cmd} [w]{.arg} [x]{.arg} [y]{.arg} [z]{.arg}
[::Plotchart::polarCoordinates]{.cmd} [w]{.arg} [radmax]{.arg}
[::Plotchart::polarToPixel]{.cmd} [w]{.arg} [rad]{.arg} [phi]{.arg}
[::Plotchart::pixelToCoords]{.cmd} [w]{.arg} [x]{.arg} [y]{.arg}
[::Plotchart::pixelToIndex]{.cmd} [w]{.arg} [x]{.arg} [y]{.arg}
[::Plotchart::determineScale]{.cmd} [xmin]{.arg} [xmax]{.arg} [inverted]{.arg}
[::Plotchart::determineScaleFromList]{.cmd} [values]{.arg} [inverted]{.arg}
[::Plotchart::plotconfig]{.cmd} [charttype]{.arg} [component]{.arg} [property]{.arg} [value]{.arg}
[::Plotchart::plotstyle]{.cmd} [subcmd]{.arg} [style]{.arg} [args]{.arg}
[::Plotchart::eraseplot]{.cmd} [anyplot]{.arg}
[::Plotchart::createTargetDiagram]{.cmd} [w]{.arg} [limits]{.arg} [scale]{.arg}
[$target]{.cmd} [plot]{.lit} [series]{.arg} [xvalues]{.arg} [yvalues]{.arg}
[::Plotchart::createPerformanceProfile]{.cmd} [w]{.arg} [max]{.arg}
[$performance]{.cmd} [plot]{.lit} [series\_and\_data\_pairs]{.arg}
[::Plotchart::createTaylorDiagram]{.cmd} [w]{.arg} [radius\_data]{.arg} [args]{.arg}
[$taylor]{.cmd} [plot]{.lit} [series]{.arg} [stdev]{.arg} [corr]{.arg}
[::Plotchart::createHeatmap]{.cmd} [w]{.arg} [rowlabels]{.arg} [columnlabels]{.arg} [args]{.arg}
[$heatmap]{.cmd} [plot]{.lit} [row]{.lit} [label]{.arg} [data]{.arg}
[$heatmap]{.cmd} [plot]{.lit} [column]{.lit} [label]{.arg} [data]{.arg}
[$heatmap]{.cmd} [plot]{.lit} [cell]{.lit} [rowlabel]{.arg} [columnlabel]{.arg} [value]{.arg}
[$heatmap]{.cmd} [scale]{.lit} [values]{.lit} [min]{.arg} [max]{.arg}
[$heatmap]{.cmd} [scale]{.lit} [colours]{.lit} [mincolour]{.arg} [maxcolour]{.arg}
[::Plotchart::createCircleplot]{.cmd} [w]{.arg} [labels]{.arg} [args]{.arg}
[$circleplot]{.cmd} [connect]{.lit} [label1]{.arg} [label2]{.arg} [colour]{.arg} [width]{.arg}
[$circleplot]{.cmd} [modify]{.lit} [label]{.arg} [args]{.arg}
[::Plotchart::plotmethod]{.cmd} [charttype]{.arg} [methodname]{.arg} [plotproc]{.arg}
[::Plotchart::plotpack]{.cmd} [w]{.arg} [dir]{.arg} [args]{.arg}
[$anyplot]{.cmd} [bindplot]{.lit} [event]{.arg} [command]{.arg} [args]{.arg}
[$anyplot]{.cmd} [bindlast]{.lit} [series]{.arg} [event]{.arg} [command]{.arg}
:::

# Beschreibung

Plotchart ist ein reines Tcl-Paket, das auf die einfache Erstellung von xy-Diagrammen, Balkendiagrammen und anderen gängigen Arten grafischer Darstellungen ausgerichtet ist. Der Fokus liegt dabei eher auf der Benutzerfreundlichkeit als auf der Flexibilität. Die Prozeduren zur Erstellung eines Diagramms nutzen das gesamte Canvas-Fenster aus, wodurch das Layout des Diagramms vollständig automatisch erfolgt.

Dadurch entsteht ein xy-Diagramm mit beispielsweise zehn Zeilen Code:

```
    package require Plotchart

    canvas .c -background white -width 400 -height 200
    pack   .c -fill both

    #
    # Create the plot with its x- and y-axes
    #
    set s [::Plotchart::createXYPlot .c {0.0 100.0 10.0} {0.0 100.0 20.0}]

    foreach {x y} {0.0 32.0 10.0 50.0 25.0 60.0 78.0 11.0 } {
        $s plot series1 $x $y
    }

    $s title "Data series"
```

Ein Nachteil des Pakets könnte darin bestehen, dass es keine Datenverwaltung übernimmt. Wird der Canvas mit der Darstellung in der Größe geändert, muss die ganze Darstellung neu gezeichnet werden. Der Vorteil besteht jedoch darin, dass es eine Reihe von Darstellungs- und Diagrammtypen bietet:

- XY-Diagramme wie das oben gezeigte mit einer beliebigen Anzahl von Datenreihen.

- Stripcharts sind eine Art von XY-Diagrammen, bei denen die horizontale Achse automatisch angepasst wird. Das Ergebnis ist eine Art gleitendes Fenster über der Datenreihe.

- Polardiagramme, bei denen die Koordinaten polar statt kartesisch sind.

- Histogramme zur Darstellung statistischer Informationen.

- Balkendiagramme, Kreisdiagramme, Gantt-Diagramme, Zeitdiagramme.

- Isometrische Darstellungen, bei denen der Maßstab der Koordinaten in beiden Richtungen stets gleich ist, d. h., ein Kreis in Weltkoordinaten erscheint auf dem Bildschirm als Kreis.

    Diese Darstellungen lassen sich vergrößern, verkleinern und verschieben (*Hinweis:* am besten ohne eingezeichnete Achsen, die Routinen für Zoom und Verschieben unterscheiden die Achsen nicht), mit den Maustasten und der Taste Control sowie mit den Pfeiltasten und der Taste Control.

- Kreisdiagramme mit automatischer Skalierung zur Darstellung der Anteile.

- Balkendiagramme, entweder mit vertikalen oder horizontalen Balken, gestapelten Balken oder nebeneinander angeordneten Balken.

- Zeitdiagramme, in denen Balken einen Zeitraum anzeigen und Meilensteine oder andere wichtige Zeitpunkte durch Dreiecke dargestellt werden.

- 3D-Diagramme (sowohl zur Darstellung von Oberflächen als auch von 3D-Balken)


Mit Version 1.5 wurde ein neuer Befehl eingeführt: „plotconfig“, mit dem sich die Darstellungsoptionen für bestimmte Arten von Diagrammen und Grafiken konfigurieren lassen (vgl. [Konfigurationsoptionen und weitere Befehle]) Mit Version 1.8.3 wurden mehrere neue Funktionen eingeführt, die eine größere Interaktivität ermöglichen (vgl. [Interaktive Nutzung]). Mit Version 2.0 ist es nun möglich, mehrere Diagramme oder Grafiken auf einem Canvas anzuordnen.

# Befehle zur Erstellung von Diagrammen

Das Diagramm entsteht mit einem einzigen Befehl und wird danach mit Daten gefüllt:

**::Plotchart::createXYPlot** *w* *xaxis* *yaxis* *args*
: Erzeugt ein neues xy-Diagramm (Konfigurationstyp: xyplot).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält. Für eine umgekehrte Achse, bei der der Maximalwert auf der linken Seite steht, dafür: Maximalwert, Minimalwert und eine *negative* Schrittweite.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält. Für eine umgekehrte Achse, bei der der Maximalwert unten erscheint, dafür: Maximalwert, Minimalwert und eine *negative* Schrittweite.

    list *args* (in)
    : Null oder mehr Optionen, die das Erscheinungsbild der Grafik beeinflussen:

        - *-xlabels {labels}:* Benutzerdefinierte Beschriftungen für die x-Achse. Wenn die Beschriftungen numerisch sind, werden sie entsprechend der angegebenen Skalierung positioniert; andernfalls werden sie in gleichen Abständen positioniert, basierend auf der Anzahl der Beschriftungen. Hinweis: Dies funktioniert nur, wenn die Schrittweite des Arguments „xaxis“ eine leere Zeichenkette ist.

        - *-ylabels {labels}:* Ebenso benutzerdefinierte Beschriftungen für die y-Achse.

        - *-box {measures}:* Siehe [Anordnung mehrerer Diagramme auf einem Canvas]

        - *-axesbox {measures}:* Siehe [Anordnung mehrerer Diagramme auf einem Canvas]

        - *-timeformat format:* Siehe [Verwendung von Datums- und Zeitangaben]

        - *-gmt 0/1:* Siehe [Verwendung von Datums- und Zeitangaben]

        - *-axestozero:* Zeichnen Sie die Achsen am Ursprung (1) oder an den Rändern des Diagrammbereichs (0, Standard). Diese Option ist nur für XY-Diagramme implementiert.

        - *-isometric:* Passen Sie die Skalierung der Achsen so an, dass ein Quadrat in den Koordinaten als Quadrat auf dem Bildschirm erscheint (1), oder verwenden Sie die vorgegebenen Extremwerte (0, Standard). Diese Option ist nur für XY-Diagramme implementiert.



**::Plotchart::createStripchart** *w* *xaxis* *yaxis* *args*
: Erzeugt ein neues Streifendiagramm (Konfigurationstyp: „stripchart“). Der einzige Unterschied zu einem gewöhnlichen XY-Diagramm besteht darin, dass die x-Achse automatisch angepasst wird, wenn die x-Koordinate eines neuen Punktes den Maximalwert überschreitet.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält. Hinweis: Eine invertierte x-Achse wird bei dieser Art von Diagramm *nicht* unterstützt.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält. Für eine umgekehrte Achse, bei der der Maximalwert unten erscheint, dafür: Maximalwert, Minimalwert und eine *negative* Schrittweite.

    list *args* (in)
    : Null oder mehr Optionen – weitere Informationen stehen beim XY-Diagramm.


**::Plotchart::createTXPlot** *w* *timeaxis* *xaxis* *args*
: Erzeugt ein neues Zeit-x-Diagramm (Konfigurationstyp: txplot). Die horizontale Achse stellt das Datum und die Uhrzeit der Daten dar, die vertikale Achse die Werte selbst.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *timeaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge das anzuzeigende Mindest- und Höchstdatum bzw. die Mindest- und Höchstuhrzeit sowie die Schrittweite (*in Tagen*) für die Zeitachse enthält. Hinweis: Eine umgekehrte Zeitachse wird *nicht* unterstützt.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die vertikale Achse enthält. Für eine umgekehrte Achse, bei der der Maximalwert unten erscheint, dafür: Maximalwert, Minimalwert und eine *negative* Schrittweite.

    list *args* (in)
    : Null oder mehr Optionen – weitere Informationen stehen beim XY-Diagramm.


**::Plotchart::createXLogYPlot** *w* *xaxis* *yaxis* *args*
: Erzeugt ein neues xy-Diagramm, bei dem die y-Achse logarithmisch skaliert ist (Konfigurationstyp: xlogyplot).

    Die Daten sollten wie bei einer linearen Skalierung angegeben werden, da die logarithmische Transformation intern vorgenommen wird.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält. Für eine umgekehrte Achse, bei der der Maximalwert auf der linken Seite steht, dafür: Maximalwert, Minimalwert und eine *negative* Schrittweite.

    list *yaxis* (in)
    : Eine Liste mit zwei Elementen, die den Minimal- und den Maximalwert für die y-Achse in dieser Reihenfolge enthält. Hinweis: Eine invertierte logarithmische Achse wird *nicht* unterstützt.

    list *args* (in)
    : Null oder mehr Optionen – weitere Informationen stehen beim XY-Diagramm.


**::Plotchart::createLogXYPlot** *w* *xaxis* *yaxis* *args*
: Erzeugt ein neues xy-Diagramm, bei dem die x-Achse logarithmisch skaliert ist (Konfigurationstyp: logxyplot).

    Die Daten sollten wie bei einer linearen Skalierung angegeben werden, da die logarithmische Transformation intern vorgenommen wird.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit zwei Elementen, die den Minimal- und den Maximalwert für die x-Achse in dieser Reihenfolge enthält. Hinweis: Eine invertierte logarithmische Achse wird *nicht* unterstützt.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält. Für eine umgekehrte Achse, bei der der Maximalwert auf der linken Seite erscheint, dafür: Maximalwert, Minimalwert und eine *negative* Schrittweite.

    list *args* (in)
    : Null oder mehr Optionen – weitere Informationen stehen beim XY-Diagramm.


**::Plotchart::createLogXLogYPlot** *w* *xaxis* *yaxis* *args*
: Erzeugt ein neues xy-Diagramm, bei dem sowohl die x-Achse als auch die y-Achse logarithmisch skaliert sind (Konfigurationstyp: logxlogyplot).

    Die Daten sollten wie bei einer linearen Skalierung angegeben werden, da die logarithmische Transformation intern vorgenommen wird.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit zwei Elementen, die den Minimal- und den Maximalwert für die x-Achse in dieser Reihenfolge enthält. Hinweis: Eine invertierte logarithmische Achse wird *nicht* unterstützt.

    list *yaxis* (in)
    : Eine Liste mit zwei Elementen, die den Minimal- und den Maximalwert für die y-Achse in dieser Reihenfolge enthält. Hinweis: Eine invertierte logarithmische Achse wird *nicht* unterstützt.

    list *args* (in)
    : Null oder mehr Optionen – weitere Informationen stehen beim XY-Diagramm.


**::Plotchart::createPolarPlot** *w* *radius\_data* *args*
: Erzeugt ein neues Polardiagramm (Konfigurationstyp: polarplot).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *radius\_data* (in)
    : Eine Liste mit zwei Elementen, die den maximalen Radius und die Schrittweite für die Radialachse in dieser Reihenfolge enthält.

    list *args* (in)
    : Null oder mehr Optionen – weitere Informationen stehen beim XY-Diagramm.


**::Plotchart::createWindrose** *w* *radius\_data* *sectors*
: Erzeugt ein neues Windrosendiagramm. Das Diagramm besteht aus konzentrischen Kreisen, die durch das Argument *radius\_data* definiert werden, sowie aus einer Anzahl von Sektoren (die durch das Argument *sectors* vorgegeben wird). Die Sektoren werden nach der Konvention „nautical“ gezeichnet, d. h.: Der erste befindet sich auf der positiven y-Achse, der zweite rechts davon und so weiter im Uhrzeigersinn.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem das Diagramm angezeigt werden soll

    list *radius\_data* (in)
    : Eine Liste mit zwei Elementen, wobei das erste Element den maximalen Radius und das zweite Element den für die Kreise zu verwendenden Schritt angibt.

    int *sectors*
    : Anzahl der zu verwendenden Sektoren (Standardwert: 16).


**::Plotchart::createIsometricPlot** *w* *xaxis* *yaxis* *stepsize*
: Erzeugt eine neue isometrische Darstellung, bei der die vertikalen und horizontalen Koordinaten so skaliert sind, dass ein Kreis tatsächlich als Kreis erscheint (Konfigurationstyp: isometric).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit zwei Elementen, die in dieser Reihenfolge den Minimalwert und den Maximalwert für die x-Achse enthalten.

    list *yaxis* (in)
    : Eine Liste mit zwei Elementen, die in dieser Reihenfolge den Minimalwert und den Maximalwert für die y-Achse enthalten.

    float|**noaxes** *stepsize* (in)
    : Entweder die von beiden Achsen verwendete Schrittweite oder das Schlüsselwort **noaxes**, um der Darstellung mitzuteilen, dass sie den gesamten Bereich des Widgets nutzen und keine der Achsen zeichnen soll.


**::Plotchart::createHistogram** *w* *xaxis* *yaxis* *args*
: Erzeugt ein neues Histogramm (Konfigurationstyp: histogram).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält.

    list *args* (in)
    : Null oder mehr Optionen – weitere Informationen stehen beim XY-Diagramm.


**::Plotchart::create3DPlot** *w* *xaxis* *yaxis* *zaxis* *args*
: Erzeugt eine neue 3D-Grafik.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält.

    list *zaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die z-Achse enthält.

    list *args* (in)
    : Optionale Liste von Optionen (Schlüsselwörter-Werte-Paare). Derzeit unterstützt: -xlabels zum Festlegen der Beschriftungen für die x-Achse.


**::Plotchart::create3DRibbonPlot** *w* *yaxis* *zaxis*
: Erzeugt ein neues 3D-Banddiagramm. Es handelt sich dabei um eine Vereinfachung des vollständigen 3D-Diagramms, bei der lediglich ein Band gezeichnet wird (die x-Achse wird weggelassen).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält.

    list *zaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die z-Achse enthält.


**::Plotchart::createPiechart** *w*
: Erzeugt ein neues Kreisdiagramm (Konfigurationstyp: piechart).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.


**::Plotchart::createSpiralPie** *w*
: Erzeugt ein neues „spiral pie“ (Konfigurationstyp: spiralpie), eine Variante des gewöhnlichen Kreisdiagramms. Der Wert dient zur Skalierung des Radius und nicht des Winkels. Standardmäßig werden die Daten sortiert.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.


**::Plotchart::createRadialchart** *w* *names* *scale* *style*
: Erzeugt ein neues Radialdiagramm (die Daten werden als Linie dargestellt, die die Speichen des Diagramms verbindet) (Konfigurationstyp: radialchart).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *names* (in)
    : Namen für die Speichen.

    float *scale* (in)
    : Wert zur Bestimmung der Position der Daten entlang der Speichen.

    string *style* (in)
    : Darstellungsstil des Diagramms (optional). Eine der folgenden Optionen:

        - *lines* – Standardeinstellung: Die Daten werden als unabhängige Polylinien dargestellt.

        - *cumulative* – Zeichnen Sie die Daten als Polylinien, wobei die Daten kumuliert werden.

        - *filled* – Zeichnen Sie die Daten als gefüllte Polygone an den Stellen, an denen die Daten kumuliert sind.



**::Plotchart::createBarchart** *w* *xlabels* *yaxis* *noseries* *args*
: Erzeugt ein neues Balkendiagramm mit vertikalen Balken (Konfigurationstyp: vertbars). Auf der horizontalen Achse werden die im Argument *xlabels* enthaltenen Beschriftungen angezeigt. Die durch *noseries* angegebene Anzahl der Reihen bestimmt sowohl die Breite der Balken als auch die Art und Weise, wie die Reihen gezeichnet werden.

    Ist das Schlüsselwort **stacked** angegeben, werden die Reihen übereinander gestapelt gezeichnet. Andernfalls wird jede gezeichnete Reihe nach rechts versetzt dargestellt.

    Die Anzahl der Reihen bestimmt die Breite der Balken, sodass Platz für diese Anzahl an Balken vorhanden ist. Steht statt einer ganzen Zahl wie 2 eine Gleitkommazahl wie 2.2, wird ein kleiner Abstand zwischen den Balkengruppen dargestellt – die Breite hängt dabei vom Bruchteil ab.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xlabels* (in)
    : Liste der Beschriftungen für die x-Achse. Ihre Länge bestimmt zudem die Anzahl der Balken, die pro Reihe dargestellt werden.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält.

    int|**stacked** *noseries* (in)
    : Die Anzahl der Datenreihen, die dargestellt werden sollen. Dies muss eine ganze Zahl größer als Null sein (wenn **stacked** nicht verwendet wird).

    string *args* (in)
    : Ein oder mehrere Schlüssel-Wert-Paare, die die Optionen definieren. Speziell für Balkendiagramme: Der Wert „**-xlabelangle**“ gibt den Winkel an, in dem die Beschriftungen gezeichnet werden sollen. Der Standardwert ist 0 – horizontaler Text. Diese Option ist besonders nützlich, wenn Sie relativ lange Beschriftungen haben.


**::Plotchart::createHorizontalBarchart** *w* *xaxis* *ylabel* *noseries*
: Erzeugt ein neues Balkendiagramm mit horizontalen Balken (Konfigurationstyp: „horizbars“). Auf der vertikalen Achse werden die im Argument *ylabels* enthaltenen Beschriftungen angezeigt. Die durch *noseries* angegebene Anzahl der Reihen bestimmt sowohl die Breite der Balken als auch die Art und Weise, wie die Reihen gezeichnet werden.

    Ist das Schlüsselwort **stacked** angegeben, werden die Reihen von links nach rechts gestapelt gezeichnet. Andernfalls wird jede gezeichnete Reihe nach oben versetzt dargestellt.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält.

    list *ylabels* (in)
    : Liste der Beschriftungen für die y-Achse. Ihre Länge bestimmt zudem die Anzahl der Balken, die pro Reihe dargestellt werden.

    int|**stacked** *noseries* (in)
    : Die Anzahl der Datenreihen, die dargestellt werden sollen. Dies muss eine ganze Zahl größer als Null sein (wenn **stacked** nicht verwendet wird).


**::Plotchart::create3DBarchart** *w* *yaxis* *nobars*
: Erzeugt ein neues Balkendiagramm mit vertikalen 3D-Balken (Konfigurationstyp: 3dbars). Auf der horizontalen Achse werden die Beschriftungen der einzelnen Balken angezeigt. Die durch *nobars* angegebene Anzahl der Balken bestimmt deren Position und Breite. Die Farben können pro Balken variiert werden. (Dieser Diagrammtyp wurde von der Wiki-Seite zu 3D-Balken von Richard Suchenwirth inspiriert.)

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält.

    int *nobars* (in)
    : Die Anzahl der Balken, die dargestellt werden sollen.


**::Plotchart::create3DRibbonChart** *w* *names* *yaxis* *zaxis*
: Erzeugt ein neues „ribbon chart“ (Konfigurationstyp: 3dribbon). Hierbei handelt es sich um ein Diagramm, bei dem die Datenreihen als Bänder in einem dreidimensionalen Achsenkoordinatensystem dargestellt werden. Entlang der x-Achse (die „in den Bildschirm hinein“ verläuft) werden die Namen aufgetragen, wobei jeder Name für eine einzelne Reihe steht. Der erste Plot-Befehl zeichnet die am weitesten entfernte Reihe, der zweite die davor liegende Reihe und so weiter.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    widget *w* (in)
    : Namen der Reihen, als Beschriftungen entlang der x-Achse dargestellt

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse (horizontal dargestellt!) enthält.

    list *zaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die z-Achse (vertikal dargestellt) enthält.

    int *nobars* (in)
    : Die Anzahl der Balken, die dargestellt werden sollen.


**::Plotchart::createBoxplot** *w* *xdata* *ydata* *orientation*
: Erzeugt ein neues Boxplot-Diagramm mit horizontalen oder vertikalen Boxen (Box-and-Whiskers) (Konfigurationstyp: boxplot). Je nach Ausrichtung wird die x- oder y-Achse mit Beschriftungen dargestellt. Die Boxen werden auf der Grundlage der Rohdaten gezeichnet (siehe den Unterbefehl „plot“ für diesen Diagrammtyp).

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *xdata* (in)
    : Hierbei handelt es sich entweder um eine Liste mit drei Elementen, die in dieser Reihenfolge (bei horizontaler Ausrichtung) den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält, oder um eine Liste von Beschriftungen für die x-Achse (bei vertikaler Ausrichtung). Die Länge der Beschriftungsliste bestimmt zudem die Anzahl der Felder, die gezeichnet werden können. Die Beschriftungen werden auch im Unterbefehl „plot“ verwendet.

    list *ydata* (in)
    : Hierbei handelt es sich entweder um eine Liste mit drei Elementen, die in dieser Reihenfolge (bei vertikaler Ausrichtung) den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält, oder um eine Liste von Beschriftungen für die y-Achse (bei horizontaler Ausrichtung). Die Länge der Beschriftungsliste bestimmt zudem die Anzahl der Felder, die gezeichnet werden können. Die Beschriftungen werden auch im Unterbefehl „plot“ verwendet.

    string *orientation* (in)
    : Sind „horizontal“ oder „vertical“ angegeben, bestimmen sie die Ausrichtung der Boxen. Dieser optionale Wert (Standard: horizontal) bestimmt zudem die Interpretation der Argumente „xdata“ und „ydata“.


**::Plotchart::createTimechart** *w* *time\_begin* *time\_end* *args*
: Erzeugt ein neues Zeitdiagramm (Konfigurationstyp: timechart). Die Zeitachse (= x-Achse) reicht von *time\_begin* bis *time\_end*, und der vertikale Abstand richtet sich nach der Anzahl der darzustellenden Elemente.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    string *time\_begin* (in)
    : Die Startzeit in einem Format, das vom Befehl **clock scan** erkannt wird (z. B. „1. Januar 2004“).

    string *time\_end* (in)
    : Die Endzeit in einem Format, das vom Befehl **clock scan** erkannt wird (z. B. „1. Januar 2004“).

    arguments *args* (in)
    : Die übrigen Argumente können wie folgt lauten:

        - Die erwartete/maximale Anzahl von Elementen. Diese bestimmt den vertikalen Abstand. (Wenn angegeben, muss dies das erste Argument nach „time\_end“ sein.)

        - Das Schlüsselwort -barheight und die Anzahl der Pixel pro Balken. Dies ist eine alternative Methode zur Bestimmung des vertikalen Abstands.

        - Das Schlüsselwort -ylabelwidth und die Anzahl der Pixel, die für die Beschriftungen auf der y-Achse reserviert werden sollen.



**::Plotchart::createGanttchart** *w* *time\_begin* *time\_end* *args*
: Erzeugt ein neues Gantt-Diagramm (Konfigurationstyp: ganttchart). Die Zeitachse (= x-Achse) reicht von *time\_begin* bis *time\_end*, und der vertikale Abstand richtet sich nach der Anzahl der darzustellenden Elemente. Über die entsprechenden Befehle können Sie anschließend Aufgaben und Verbindungen zwischen den Aufgaben hinzufügen.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    string *time\_begin* (in)
    : Die Startzeit in einem Format, das vom Befehl **clock scan** erkannt wird (z. B. „1. Januar 2004“).

    string *time\_end* (in)
    : Die Endzeit in einem Format, das vom Befehl **clock scan** erkannt wird (z. B. „1. Januar 2004“).

    arguments *args* (in)
    : Die übrigen Argumente können wie folgt lauten:

        - Die erwartete bzw. maximale Anzahl von Elementen. Diese bestimmt den vertikalen Abstand. (Wird dieser Wert auf diese Weise angegeben, muss er das erste Argument nach „time\_end“ sein.)

        - Die erwartete/maximale Breite des beschreibenden Textes (ungefähr in Zeichen; für den tatsächlich für den Text reservierten Platz wird davon ausgegangen, dass ein Zeichen etwa zehn Pixel breit ist). Der Standardwert beträgt 20. (Wird dieser Wert auf diese Weise angegeben, muss er das zweite Argument nach „time\_end“ sein.)

        - Das Schlüsselwort -barheight und die Anzahl der Pixel pro Balken. Dies ist eine alternative Methode zur Bestimmung des vertikalen Abstands.

        - Das Schlüsselwort -ylabelwidth und die Anzahl der Pixel, die für die Beschriftungen auf der y-Achse reserviert werden sollen.



**::Plotchart::createRightAxis** *w\_or\_plot* *yaxis*
: Erzeugt einen Plot-Befehl, der anstelle der linken Achse die rechte Achse verwendet (Konfigurationstyp: von dem vorhandenen Plot übernommen). Das Canvas-Widget muss bereits einen gewöhnlichen Plot enthalten, da die horizontale Achse und andere Eigenschaften wiederverwendet werden. Verwenden Sie vorzugsweise den Plot-Befehl, da bei mehreren Plots in einem Canvas (auch beim Neudefinieren eines bestehenden Plots!) möglicherweise die falsche Geometrie verwendet wird.

    Um Daten unter Verwendung der rechten Achse zu plotten, verwenden Sie diesen neuen Befehl; um Daten unter Verwendung der Achse *left* zu plotten, verwenden Sie den ursprünglichen Plot-Befehl.

    widget *w\_or\_plot* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll, oder vorzugsweise der Plot-Befehl für die Grafik mit der linken Achse.

    list *yaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die y-Achse enthält.


**::Plotchart::createTableChart** *w* *columns* ?widths?
: Erzeugt einen Befehl zum Zeichnen einer Tabelle. Sie können verschiedene Befehle verwenden, um die einzelnen Zeilen der Tabelle zu zeichnen, die Anzahl der Spalten ist jedoch festgelegt. (Beispiele finden Sie unter [Tabellendiagramme])

    widget *w* (in)
    : Name des Canvas-Widgets, in dem die Tabelle angezeigt werden soll.

    list *columns* (in)
    : Die Überschriften der Spalten in der Tabelle. Die Anzahl der Elemente bestimmt die Anzahl der Spalten.

    list *widths* (in)
    : Wird ein Wert angegeben, so handelt es sich entweder um einen einzelnen Wert – die Breite in Pixeln für alle Spalten – oder um die Breite der jeweiligen Spalten. Wird kein Wert angegeben, erstreckt sich die Tabelle über die gesamte Breite des canvases (abzüglich der Außenabstände).


**::Plotchart::createTernaryDiagram** *w* *args*
: Erzeugt einen Befehl zum Zeichnen eines ternären Diagramms (Konfigurationstyp: ternary). Sie können einzelne (beschriftete) Datenpunkte im Diagramm sowie Linien und ausgefüllte Polygone zeichnen.

    widget *w* (in)
    : Name des Canvas-Widgets, in dem das ternäre Diagramm angezeigt werden soll.

    list *args* (in)
    : Null oder mehr Optionen-Wert-Paare zur Steuerung der Position und der Darstellung des Diagramms. Zusätzlich zu den Positionierungsoptionen (-box und -axesbox) unterstützt das Diagramm: *-fractions ja/nein*, um die Zahlen 0 bis 1 anstelle von 0 bis 100 % anzuzeigen, sowie *-steps Zahl*, um die Anzahl der Beschriftungen entlang der drei Seiten zu beeinflussen.


**::Plotchart::createNormalPlot** *w* *xscale* *args*
: Erzeugt einen Befehl zum Zeichnen eines Normalverteilungsdiagramms – nützlich, um zu untersuchen, ob ein Datensatz normalverteilt ist oder nicht. In diesem Fall liegen die Daten auf oder nahe der Diagonalen. Es handelt sich somit um eine spezielle Prozedur zur Diagrammerstellung.

    Die Einzelheiten der Prozedur wurden aus der Funktion *qqnorm* des „R“-Pakets *stats* übernommen und sind auf Wikipedia beschrieben.

    Da die Implementierung dieses Diagrammtyps auf dem Paket *math::statistics* basiert, ist sie nur verfügbar, wenn dieses Paket geladen werden kann.

    widget *w* (in)
    : Name des Canvas-Widgets, in dem die normale Darstellung angezeigt werden soll.

    list *xscale* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält. Daraus wird die Skalierung der y-Achse bestimmt. *Wichtig:* Die Skalierung ist in Bezug auf die normierten Daten anzugeben, d. h.: 0 steht für den Mittelwert der Daten, 1 für eine Standardabweichung vom Mittelwert usw.

    list *args* (in)
    : Null oder mehr Paare mit Optionen zur Steuerung der Position und der Darstellung des Diagramms – weitere Einzelheiten stehen beim XY-Diagramm.


**::Plotchart::createStatusTimeline** *w* *xaxis* *ylabel* *args*
: Erzeugt einen Befehl zum Zeichnen einer sogenannten Status-Zeitleiste. Das Layout ähnelt einem horizontalen Balkendiagramm, jedoch werden die Balken in verschiedenen Farben dargestellt, wobei jede Farbe den Status des Elements im Zeitverlauf (auf der horizontalen Achse) repräsentiert.

    widget *w* (in)
    : Name des Canvas-Widgets, in dem das ternäre Diagramm angezeigt werden soll.

    list *xaxis* (in)
    : Eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die x-Achse enthält.

    list *ylabels* (in)
    : Liste der Beschriftungen für die y-Achse. Ihre Länge bestimmt zudem die Anzahl der Balken, die pro Reihe dargestellt werden.

    list *args* (in)
    : Null oder mehr Paare mit Werten für Optionen zur Anpassung der Position und der Darstellung des Diagramms. Zusätzlich zu den Positionierungsoptionen (-box und -axesbox) unterstützt das Diagramm: *-xaxis ja/nein*, um die Anzeige der numerischen Beschriftungen ein- oder auszuschalten.


**::Plotchart::createDendrogram** *w* *args*
: Erzeugt ein Dendrogramm, um hierarchisch organisierte Daten darzustellen. Die Beschriftungen, die die Endpunkte der Hierarchie kennzeichnen, können entweder alle auf derselben Ebene oder an den Endpunkten der jeweiligen Zweige eingezeichnet werden. Dies wird über die Option „-extend“ gesteuert.

    Die Daten sind als verschachtelte Listen organisiert, beispielsweise:

    ```
         \$dendrogram plot data { {"Label1"  "Label2"} {F {A B} {C {D E}}} }
    ```

    Unterlisten mit mehr als einem Element gelten als Verzweigung und werden entsprechend dargestellt. Unterlisten mit nur einem Element gelten als Blatt und werden als Text dargestellt. Da sich eine Zeichenfolge mit zwei oder mehr Wörtern nicht von einer Liste mit zwei oder mehr Elementen unterscheiden lässt, wurde für diesen Fall eine Regelung getroffen: Wenn das erste Element „LEAF“ ist, wird davon ausgegangen, dass die Liste ausschließlich aus Blättern besteht, und alle Elemente – selbst wenn es sich tatsächlich um verschachtelte Listen handelt – werden als Text dargestellt:

    ```
         \$dendrogram plot data { {LEAF "Label 1"  "Label 2"} {F {A B} {C {D E}}} }
    ```

    widget *w* (in)
    : Name des Canvas-Widgets, in dem das Dendrogramm angezeigt werden soll.

    list *args* (in)
    : Null oder mehr Paare mit Optionen-Werten:

        - Die Option „-direction“ kann einen der folgenden Werte annehmen: left-right, right-left, top-bottom, bottom-top, wobei „top-bottom“ der Vorgabewert ist. Der Baum wird entsprechend dieser Option gezeichnet; die Beschriftungen erscheinen entweder horizontal oder vertikal am Ende des Baums.

        - Die Option „-extend“ mit dem Wert 1 (Standard) oder 0 (keine Erweiterung), um anzugeben, dass alle Beschriftungen auf derselben Ebene erscheinen sollen.




# Diagrammmethoden

Jeder der im letzten Abschnitt erläuterte Befehl zur Erstellung gibt den Namen eines neuen Objektbefehls zurück, mit dem sich die Grafik oder das Diagramm bearbeiten lässt. Welche Unterbefehle für einen Diagrammbefehl verfügbar sind, hängt vom Typ des Diagramms ab.

Allgemeine Unterbefehle für alle Diagrammtypen. \\$anyplot ist der vom Erstellungsbefehl zurückgegebene Befehl:

**$anyplot** title *text* *position*
: Legt den Titel des gesamten Diagramms fest.

    string *text* (in)
    : Der Text des zu erstellenden Titels.

    string *position* (in)
    : Die Position des Titels. Die Standardposition ist „center“, Sie können jedoch alternativ auch „left“ oder „right“ verwenden. Sie können mehrere Titel mit unterschiedlichen Positionen verwenden.


**$anyplot** subtitle *text*
: Legt die Unterüberschrift für das gesamte Diagramm fest.

    string *text* (in)
    : Der Text des zu erstellenden Untertitels.


**$anyplot** canvas
: Gibt den Namen der Canvas zurück (bzw. den Alias, falls Sie innerhalb eines Canvas mehrere Diagramme verwenden). Verwenden Sie diesen Wert für die Transformationen der Koordinaten.

**$anyplot** saveplot *filename* *args*
: Zeichnet die Grafik mithilfe von PostScript in eine Datei.

    string *filename* (in)
    : Enthält den Pfadnamen der Datei, in die die Grafik geschrieben wird.

    list *args* (in)
    : Wenn die Standard-PostScript-Ausgabe verwendet wird, kann die Option -plotregion angegeben werden, um die gesamte Grafik (Wert: bbox) zu speichern, unabhängig davon, was im Fenster sichtbar ist. Standardmäßig (Wert: window) wird nur der sichtbare Teil der Grafik ausgegeben.

        Optional lässt sich -format „some picture format“ setzen, um die Grafik in einer anderen Datei als einer PostScript-Datei zu speichern. Dies setzt jedoch voraus, dass das Img-Paket den eigentlichen Auftrag übernimmt.

        *Hinweis:* Da das Fenster, in dem sich die Grafik befindet, vollständig sichtbar sein muss, bevor Img sie erfolgreich erfassen kann, wird es zunächst in den Vordergrund geholt. Auf einigen Systemen, beispielsweise unter Linux mit KDE, erfolgt das Heranholen eines Fensters nicht automatisch, sondern das Fenster in der Taskleiste braucht einen Klick. Ähnliches gilt für Windows XP.

        Unter bestimmten Umständen scheint es zu Problemen zu kommen; daher wartet die Prozedur, anstatt auf die Sichtbarkeit des Fensters zu warten, einfach zwei Sekunden. Das ist zwar nicht ideal, scheint aber besser zu funktionieren.


**$anyplot** xtext *text*
: Legt den Titel der (horizontalen) x-Achse für jene Diagramme fest, die über eine gerade x-Achse verfügen.

    string *text* (in)
    : Der Text der zu zeichnenden Beschriftung auf der x-Achse.


**$anyplot** ytext *text*
: Legt den Titel der (horizontalen) y-Achse für jene Diagramme fest, die über eine gerade y-Achse verfügen.

    string *text* (in)
    : Der Text der zu zeichnenden Beschriftung auf der y-Achse.


**$anyplot** vtext *text*
: Zeichnet eine Beschriftung *vertical* an die y-Achse. Hinweis: Hierfür ist Tk 8.6 oder höher erforderlich; bei älteren Versionen hat dies keine Auswirkung.

    string *text* (in)
    : Der Text soll an der y-Achse ausgerichtet werden


**$anyplot** xsubtext *text*
: Gibt den Untertext der (horizontalen) x-Achse für jene Diagramme an, die über eine gerade x-Achse verfügen. Dieser Text wird unterhalb des Haupttextes eingezeichnet.

    Da hierfür die Positionierung des Haupttextes und die Festlegung der Außenabstände erforderlich sind, müssen Sie die Option „usesubtext“ für die untere Achse über den Befehl „plotstyle“ festlegen. Die relevanten Optionen lauten: usesubtext, subtextcolor und subtextfont.

    string *text* (in)
    : Der sekundäre Text der zu zeichnenden Beschriftung auf der x-Achse.


**$anyplot** ysubtext *text*
: Legt den Untertext der (vertikalen) y-Achse für jene Diagramme fest, die eine gerade y-Achse aufweisen. Dieser Text wird unterhalb des Haupttextes eingezeichnet, und zwar sowohl für die linke als auch für die rechte Achse.

    Da hierfür die Positionierung des Haupttextes und die Festlegung der Außenabstände erforderlich sind, müssen Sie die Option „usesubtext“ für die linke oder rechte Achse über den Befehl „plotstyle“ festlegen. Die entsprechenden Optionen lauten: „usesubtext“, „subtextcolor“ und „subtextfont“.

    string *text* (in)
    : Der zu zeichnende sekundäre Text der Beschriftung auf der y-Achse.


**$anyplot** vsubtext *text*
: Legt den Untertext der (vertikalen) y-Achse für jene Diagramme fest, die eine gerade y-Achse aufweisen. Dieser Text wird *rechts* vom Haupttext eingezeichnet, sowohl für die linke als auch für die rechte Achse.

    Da hierfür die Positionierung des Haupttextes und die Festlegung der Außenabstände erforderlich sind, müssen Sie die Option „usesubtext“ für die linke oder rechte Achse über den Befehl „plotstyle“ festlegen. Die entsprechenden Optionen lauten: usevsubtext, vsubtextcolor und vsubtextfont. (Beachten Sie den Hinweis „v“, um diese Option von dem Text am oberen Rand einer vertikalen Achse zu unterscheiden, der über *$anyplot ytext* oder *$anyplot ysubtext* gezeichnet wird.)

    string *text* (in)
    : Der sekundäre (vertikale) Text der zu zeichnenden y-Achsenbeschriftung.


**$anyplot** xconfig **-option** *value* ...
: Legt einen oder mehrere Konfigurationsparameter für die x-Achse fest. Folgende Optionen werden unterstützt:

    **format** fmt
    : Das Format für die Zahlen entlang der Achse.

    **ticklength** length
    : Die Länge der Skalenstriche (in Pixeln).

    **ticklines** boolean
    : Ob Gitterlinien gezeichnet werden sollen (**true**) oder nicht (**false**).

    **scale** scale\_data
    : Neue Skalierungsdaten für die Achse, d. h. eine Liste mit drei Elementen, die in dieser Reihenfolge den Minimalwert, den Maximalwert und die Schrittweite für die Achse enthält.

        *Achtung:* Wenn Sie diese Option aktivieren, werden alle Daten aus der Darstellung gelöscht.


**$anyplot** yconfig **-option** *value* ...
: Legt einen oder mehrere Konfigurationsparameter für die y-Achse fest. Diese Methode akzeptiert dieselben Optionen und Werte wie die Methode **xconfig**.

**$anyplot** background *part* *colour\_or\_image* *dir* ?brightness?
: Den Hintergrund eines Teils des Diagramms festlegen

    string *part*
    : Welcher Teil des Diagramms: „axes“ für den Achsenbereich und „plot“ für den inneren Teil. Die Interpretation hängt von der Art des Diagramms ab. Zwei weitere Möglichkeiten sind:

        - *image*, wobei in diesem Fall ein vordefiniertes Bild als Hintergrund der Grafik geladen wird.

        - *gradient*, wobei der Hintergrund in verschiedenen Schattierungen der angegebenen Farbe dargestellt wird. Das Argument „dir“ legt die Richtung fest, in der die Farbe heller wird.


    string *colour\_or\_image*
    : Farbe für diesen Teil oder der Name des Bildes, wenn „part“ gleich „image“ ist

    string *dir*
    : Richtung des Farbverlaufs. Eine von top-down, bottom-up, left-right oder right-left.

    string *brightness*
    : Ob die Farbe heller (bright) oder dunkler (dark) wird. Voreinstellung ist bright.


**$anyplot** xticklines *colour* ?dash?
: Zeichnet an jedem Skalenstrich eine vertikale Gitterlinie ein

    string *colour*
    : Farbe der Linien. Durch Festlegen einer leeren Farbe („“) werden diese wieder entfernt. Die Voreinstellung ist „black“.

    string *dash*
    : Optionales Argument, um das Strichmuster für die Linien festzulegen. Der Standardwert lautet „lines“. Mögliche Werte: lines, dots1, dots2, dots3, dots4, dots5. Der tatsächliche Effekt hängt von der Plattform ab.


**$anyplot** yticklines *colour* ?dash?
: Zeichnet an jedem Skalenstrich eine horizontale Gitterlinie ein

    string *colour*
    : Farbe der Linien. Durch Festlegen einer leeren Farbe („“) werden diese wieder entfernt. Die Voreinstellung ist „black“.

    string *dash*
    : Optionales Argument, um das Strichmuster für die Linien festzulegen. Der Standardwert lautet „lines“. Mögliche Werte: lines, dots1, dots2, dots3, dots4, dots5. Der tatsächliche Effekt hängt von der Plattform ab.


**$anyplot** legend *series* *text* ?spacing?
: Fügt der Legende einen Eintrag hinzu. Die Reihe bestimmt, welches grafische Symbol verwendet werden soll. (Als Nebeneffekt wird die Legende tatsächlich gezeichnet.)

    string *series*
    : Name der Datenreihe. Dieser bestimmt die Farbe der Linie und das Symbol (falls vorhanden), das gezeichnet wird.

    string *text*
    : Text, der neben der Linie/dem Symbol eingefügt werden soll.

    integer *spacing*
    : Optionales Argument, um den vertikalen Abstand zwischen den Einträgen festzulegen (in Pixeln). (Beachten Sie, dass dieser Abstand später wiederverwendet wird.)


**$anyplot** removefromlegend *series*
: Entfernt einen Eintrag für eine Reihe aus der Legende und zeichnet ihn erneut.

    string *series*
    : Name der zu löschenden Datenreihe.


**$anyplot** legendconfig **-option** *value* ...
: Legt eine oder mehrere Optionen für die Legende fest. Die Legende wird als Rechteck dargestellt, in dem sich Text und Grafiken befinden.

    **background** colour
    : Farbe des Hintergrunds (Voreinstellung white). Die leere Zeichenkette ergibt eine durchsichtige Legende.

    **border** colour
    : Farbe des Rahmens (Voreinstellung black). Die leere Zeichenkette lässt den Rahmen weg.

    **canvas** c
    : Zeichnet die Legende in einem separaten Canvas-Widget. Dadurch haben Sie die Möglichkeit, die Legende außerhalb der eigentlichen Grafik zu positionieren.

    **font** font
    : Legt die Schriftart fest, die zum Zeichnen des Textes neben dem Symbol verwendet werden soll.

    **legendtype** type
    : Überschreibt den für den Diagrammtyp vorgegebenen Legendentyp. Möglich sind rectangle oder line.

    **position** corner
    : Position der Legende. Möglich sind top-left, top-right, bottom-left oder bottom-right. Voreinstellung ist top-right.

    **spacing** pixels
    : Senkrechter Abstand zwischen den Legendeneinträgen, in Pixeln. bottom-left oder bottom-right. Voreinstellung ist 10 Pixel.

    **order** string
    : Legt die Reihenfolge der Legendenelemente fest – „normal“ ist die Reihenfolge, in der die Einträge definiert sind, „reverse“ genau das Gegenteil. (Standard: normal)


**$anyplot** balloon *x* *y* *text* *dir*
: Fügt dem Diagramm Sprechblasentext hinzu (außer bei 3D-Diagrammen). Der Pfeil zeigt auf die angegebenen x- und y-Koordinaten. Bei xy-Diagrammen und ähnlichen Darstellungen beziehen sich die Koordinaten direkt auf die Achsen; bei vertikalen Balkendiagrammen wird die x-Koordinate als Anzahl der Balken minus 1 gemessen, bei horizontalen Balkendiagrammen gilt Ähnliches.

    float *x*
    : X-Koordinate des Punktes, auf den der Pfeil des Ballons zeigen wird.

    float *y*
    : Y-Koordinate des Punktes, auf den der Pfeil des Ballons zeigen wird.

    string *text*
    : Text, der in die Sprechblase eingefügt werden soll.

    string *dir*
    : Pfeilrichtung, eine der folgenden: Norden, Nordosten, Osten, Südosten, Süden, Südwesten, Westen oder Nordwesten.


**$anyplot** balloonconfig *args*
: Konfiguriert den Sprechblasentext für die Grafik. Die neuen Einstellungen werden für den nächsten Sprechblasentext verwendet.

    **font** fontname
    : Für den Text zu verwendende Schriftart

    **justify** left|center|right
    : Möglichkeit zur Ausrichtung von mehrzeiligem Text

    **textcolour** colour
    : Farbe für den Text (Synonym: textcolor)

    **background** colour
    : Farbe für den Ballon

    **outline** colour
    : Farbe der Gliederung des Ballons

    **margin** value
    : Außenabstand um den Text herum (in Pixeln)

    **rimwidth** value
    : Breite der Gliederung des Ballons (in Pixeln)

    **arrowsize** value
    : Längenfaktor für den Pfeil (in Pixeln)


**$anyplot** plaintext *x* *y* *text* *dir*
: Fügt dem Diagramm einfachen Text hinzu (mit Ausnahme von 3D-Diagrammen). Der Text wird an den angegebenen x- und y-Koordinaten positioniert. Bei xy-Diagrammen und ähnlichen Darstellungen beziehen sich die Koordinaten direkt auf die Achsen; bei vertikalen Balkendiagrammen wird die x-Koordinate als Anzahl der Balken minus 1 gemessen, bei horizontalen Balkendiagrammen gilt Ähnliches.

    float *x*
    : X-Koordinate der Textposition

    float *y*
    : Y-Koordinate der Textposition

    string *text*
    : Zu zeichnender Text.

    string *dir*
    : Anker für den Text in eine der folgenden Richtungen: Norden, Nordosten, Osten, Südosten, Süden, Südwesten, Westen oder Nordwesten.


**$anyplot** plaintextconfig *args*
: Konfiguriert die Klartext-Anmerkung für die Grafik. Die neuen Einstellungen werden für den nächsten Klartext verwendet.

    **font** fontname
    : Für den Text zu verwendende Schriftart

    **justify** left|center|right
    : Möglichkeit zur Ausrichtung von mehrzeiligem Text

    **textcolour** colour
    : Farbe für den Text (Synonym: textcolor)


**$anyplot** object *itemtype* *series* *args*
: Zeichnet ein Canvas-Element in das Diagramm ein, dessen Koordinaten anhand des Koordinatensystems des Diagramms skaliert werden. Neben den üblichen Canvas-Typen gibt es circle, dot und cross.

    *Hinweis:* Derzeit implementiert für xy-Diagramme, (vertikale und horizontale) Balkendiagramme sowie Kreisdiagramme.

    *Hinweis:* Um einen Eintrag in der Legende für das Objekt hinzuzufügen, können Sie den Unterbefehl *dataconfig* mit dem Typ „rectangle“ verwenden. Dadurch wird ein Rechteck angezeigt.

    string *itemtype* (in)
    : Name eines Standard-Canvas-Elements oder „circle“, „dot“ oder „cross“

    string *series* (in)
    : Die Datenreihe, zu der sie gehört und die zur Festlegung der Standard-Zeichen-Optionen verwendet wird

    list *args* (in)
    : Liste der Koordinaten und Zeichenoptionen


**$anyplot** deletedata
: Entfernt die Linien, Symbole und sonstigen grafischen Objekte, die mit den eigentlichen Daten in Verbindung stehen, aus dem Diagramm.

    *Hinweis:* Derzeit nur für XY-Diagramme implementiert.

    *Hinweis:* Die vorhandenen Optionen für Datenreihen und den Legenden-Eintrag bleiben unverändert.

    *Hinweis:* Derzeit treten Nebenwirkungen auf, wenn der Canvas mehr als ein Diagramm enthält.


*Hinweis:* Die Befehle **xconfig** und **yconfig** sind derzeit nur für XY-Diagramme implementiert, und nur die Option **-format** hat eine Wirkung.

Für *XY-Diagramme*, *Streifendiagramme*, *Histogramme* und *Zeit-X-Diagramme*:

**$xyplot** plot *series* *xcrd* *ycrd*
: Fügt dem Diagramm einen Datenpunkt hinzu.

    string *series* (in)
    : Name der Datenreihe, zu der der neue Datenpunkt gehört.

    float *xcrd* (in)
    : X-Koordinate des neuen Punktes. (Bei Zeit-x-Diagrammen muss es sich um ein gültiges Datum/eine gültige Uhrzeit handeln, die mit dem Befehl *clock scan* ausgelesen werden kann.)

    float *ycrd* (in)
    : Y-Koordinate des neuen Punktes.



Für *normale Handlungen*:

**$normalplot** plot *series* *mean* *stdev* *data*
: Stellt den Datensatz unter Verwendung des angegebenen Mittelwerts und der Standardabweichung grafisch dar.

    Da Sie den Mittelwert und die Standardabweichung separat angeben, kann die Darstellung für mehrere Datenreihen oder zur Ergänzung einer bestehenden Datenreihe verwendet werden.

    string *series* (in)
    : Name der Datenreihe – dient zur Festlegung der Darstellung

    float *mean* (in)
    : Angenommener Mittelwert des Datensatzes.

    float *stdev* (in)
    : Angenommene Standardabweichung des Datensatzes.

    list *data* (in)
    : Verzeichnis der Daten, aus denen sich der Datensatz zusammensetzt


**$normalplot** diagonal
: Zeichnet eine diagonale Linie ein, die den idealen, normalverteilten Datensatz darstellt.


Für *xy-, x-log-y-, log-x-y- und log-x-log-y-Diagramme* steht der zusätzliche Befehl *plotlist* zur Verfügung, der sich besonders für die Darstellung großer Datenmengen eignet:

**$xyplot** plotlist *series* *xlist* *ylist* *every*
: Stellt eine Datenreihe als Ganzes dar. Wenn Symbole verlangt werden, zeichnen Sie diese nur für jeden N-ten Datenpunkt ein.

    string *series* (in)
    : Name der Datenreihe, zu der die neue Zeile gehört.

    float *xlist* (in)
    : Liste der X-Koordinaten für die Datenreihe.

    float *ycrd* (in)
    : Liste der Y-Koordinaten für die Datenreihe.

    int *every* (in)
    : Optionales Argument, das angibt, wie oft ein Symbol (falls vorhanden) gezeichnet werden soll. Wird es weggelassen, wird eine einfache Heuristik verwendet: N = √(Anzahl der Datenpunkte).



Weitere Befehle für *xy-, x-log-y-, log-x-y- und log-x-log-y-Diagramme* sind *region* und *minmax* zum Zeichnen ausgefüllter Polygone:

**$xyplot** region *series* *xlist* *ylist*
: Zeichnet ein ausgefülltes Polygon (Bereich). Die Konfiguration der Serie wirkt sich wie folgt auf das Polygon aus: *-fillcolour* wird zum Ausfüllen des Polygons verwendet, *-colour* wird für die Umrandung verwendet (setzen Sie den Wert auf {}, wenn keine Umrandung erforderlich ist), und *-width* bestimmt die Breite der Umrandung.

    string *series* (in)
    : Name der Datenreihe, zu der die neue Region gehört.

    float *xlist* (in)
    : Liste der X-Koordinaten für den Bereich.

    float *ycrd* (in)
    : Liste der Y-Koordinaten für den Bereich.


**$xyplot** minmax *series* *xcrd* *ymin* *ymax*
: Zeichnet einen ausgefüllten Streifen, der ein Minimum und ein Maximum darstellt. Die Konfiguration der Reihe wirkt sich wie folgt auf das Polygon aus: *-fillcolour* wird zum Ausfüllen des Polygons verwendet, *-colour* wird für die Begrenzung verwendet (setzen Sie den Wert auf {}, wenn keine Begrenzung erforderlich ist), und *-width* bestimmt die Breite der Begrenzung.

    Die Argumente *ymin* und *ymax* können leer gelassen werden, um einen zusätzlichen Scheitelpunkt im Streifen zu erhalten. Wenn beide leer sind, wird ein neuer Streifen begonnen. Für optimale Ergebnisse sollte die x-Koordinate in aufsteigender Reihenfolge festgelegt werden.

    string *series* (in)
    : Name der Datenreihe, zu der der neue Min/Max-Streifen gehört.

    float *xcrd* (in)
    : X-Koordinate des Streifens.

    float *ymin* (in)
    : Die minimale y-Koordinate für den Streifen.

    float *ymax* (in)
    : Die maximale y-Koordinate für den Streifen.



*Note on histograms:*

Bei Histogrammen wird die angegebene x-Koordinate als die x-Koordinate der *rechten* Seite des Balkens (bzw. des Liniensegments) interpretiert. Der erste Balken beginnt links an der y-Achse. Um den gesamten Bereich der x-Achse vollständig auszufüllen, sollten Sie einen Balken an der maximalen x-Koordinate zeichnen.

Für Histogramme können Sie auch den Befehl **plotcumulative** verwenden:

**$histogram** plotcumulative *series* *xcrd* *ycrd*
: siehe unten ...


Die Argumente haben genau dieselbe Bedeutung wie beim Befehl **plot**, jedoch werden die Daten zu den bisherigen Werten addiert.

Für *xy-Diagramme*:

**$xyplot** trend *series* *xcrd* *ycrd*
: Zeichnet anhand der bisher angegebenen Daten eine Trendlinie ein bzw. aktualisieren Sie diese.

    string *series* (in)
    : Name der Datenreihe, zu der die Trendlinie gehört.

    float *xcrd* (in)
    : X-Koordinate des neuen Datenpunkts

    float *ycrd* (in)
    : Y-Koordinate des neuen Datenpunkts


**$xyplot** rchart *series* *xcrd* *ycrd*
: Zeichnet die Daten auf dieselbe Weise wie bei der Methode „plot“ ein, fügen Sie jedoch zwei Linien hinzu, die den erwarteten Bereich (+/- 3\*Standardabweichung) der Daten anzeigen.

    string *series* (in)
    : Name der Datenreihe, zu der der Datenpunkt gehört.

    float *xcrd* (in)
    : X-Koordinate des neuen Datenpunkts

    float *ycrd* (in)
    : Y-Koordinate des neuen Datenpunkts


**$xyplot** interval *series* *xcrd* *ymin* *ymax* ?ycentr?
: Fügt dem Diagramm ein vertikales Fehlerintervall hinzu. Das Intervall wird von ymin bis ymax eingezeichnet. Wenn das Argument ycentr angegeben wird, wird an dieser Position ein Symbol eingezeichnet.

    string *series* (in)
    : Name der Datenreihe, zu der das Intervall gehört.

    float *xcrd* (in)
    : X-Koordinate des Intervalls

    float *ymin* (in)
    : Minimale y-Koordinate des Intervalls.

    float *ymax* (in)
    : Maximale y-Koordinate des Intervalls.

    float *ycentr* (in)
    : Y-Koordinate, an der das Symbol gezeichnet werden soll (optional)


**$xyplot** box-and-whiskers *series* *xcrd* *ycrd*
: Zeichnet ein Box-Whisker-Diagramm in die Grafik ein. Wenn das Argument *xcrd* eine Liste mehrerer Werte und das Argument *ycrd* einen einzelnen Wert enthält, wird ein horizontales Box-Whisker-Diagramm gezeichnet, wobei die Quartile anhand der in *xcrd* enthaltenen Werte ermittelt werden.

    Wenn das Argument *ycrd* hingegen eine Liste mehrerer Werte enthält und das Argument *xcrd* einen einzelnen Wert enthält, wird ein vertikaler Kasten gezeichnet, wobei die Quartile anhand von *ycrd* bestimmt werden. (Es muss genau eine Liste mit mehreren Werten vorhanden sein. Andernfalls wird ein Fehler gemeldet.)

    Die Option -boxwidth des Befehls „dataconfig“ legt die Breite (bzw. Höhe) des Kastens fest (Standard: 10 Pixel).

    Die Option -whiskers des Befehls „dataconfig“ legt fest, ob die Whisker bis zu den Extremwerten (Wert: „extremes“), bis zum 1,5-fachen des Interquartilsabstands (Wert: „IQR“ oder „iqr“) oder gar nicht (Wert: „none“) gezeichnet werden. Wenn der Wert bei „IQR“ (Großbuchstaben) liegt, werden auch Extremwerte angezeigt (vom 1,5- bis zum 3-fachen des IQR als Punkte, oberhalb des 3-fachen IQR als Sterne). Wenn der Wert „iqr“ (Kleinbuchstaben) vorhanden ist, werden keine Extremwerte angezeigt (Standardwert: IQR).

    Die Option -whiskerwidth des Befehls „dataconfig“ legt die Dicke der Linie fest, mit der die Whisker gezeichnet werden (Standard: 1 Pixel).

    Die Option -mediancolour des Befehls „dataconfig“ legt die Farbe der Linie fest, mit der der Median innerhalb des Kastens gezeichnet wird (Standard: wie bei -colour).

    Die Option -medianwidth des Befehls „dataconfig“ legt die Dicke der Linie fest, mit der der Median innerhalb des Kastens gezeichnet wird (Standard: 1 Pixel).

    string *series* (in)
    : Name der Datenreihe, zu der das Box-and-Whiskers-Diagramm gehört.

    float *xcrd* (in)
    : X-Koordinate des Rechtecks oder eine Liste von Werten.

    float *ymin* (in)
    : Y-Koordinate des Rechtecks oder eine Liste von Werten.


    Der Kasten endet am 1. und 3. Quartil, während die Whisker standardmäßig so dargestellt werden, dass sie sich über 1,5 IQR (Interquartilsabstand) vom 1. und 3. Quartil erstrecken.

**$xyplot** violin *series* *xcrd* *ycrd*
: Zeichnet anhand des angegebenen Datensatzes ein Violin-Diagramm. Es handelt sich dabei um eine Alternative zur Box-and-Whiskers-Darstellung. Genau wie beim Unterbefehl „box-and-whiskers“ wird eine horizontale „Violine“ gezeichnet, wenn das Argument *xcrd* eine Liste mehrerer Werte und das Argument *ycrd* einen einzelnen Wert enthält.

    Wenn das Argument *ycrd* hingegen eine Liste mehrerer Werte und das Argument *xcrd* einen einzelnen Wert enthält, wird eine vertikale „Violine“ gezeichnet.

    Die Option -violinwidth des Befehls „dataconfig“ legt die Breite (oder Höhe) der Violine fest (Standard: 50 Pixel).

    Die Option -colour (-color) legt die Farbe der Gliederung fest, und die Option -fillcolour (-fillcolor) bestimmt die Farbe, mit der die Violine ausgefüllt wird (Vorgaben: black und nicht gefüllt).

    string *series* (in)
    : Name der zu verwendenden Datenreihe.

    float *xcrd* (in)
    : X-Koordinate der Geige oder eine Liste von Werten.

    float *ymin* (in)
    : Y-Koordinate der Geige oder eine Liste von Werten.


**$xyplot** vector *series* *xcrd* *ycrd* *ucmp* *vcmp*
: Zeichnet einen Vektor in die Grafik ein. Der Vektor kann entweder als kartesische Koordinaten oder als Länge/Winkel angegeben werden, wobei der Winkel in Grad angegeben wird und entweder nach der mathematischen Konvention oder nach nautical. (Siehe den Unterbefehl „vectorconfig“)

    string *series* (in)
    : Name der Serie, zu der der Vektor gehört. Bestimmt das Erscheinungsbild und die Interpretation.

    float *xcrd* (in)
    : X-Koordinate des Punktes, an dem der Pfeil erscheint

    float *ycrd* (in)
    : Y-Koordinate des Punktes, an dem der Pfeil erscheint

    float *ucmp* (in)
    : Die x-Komponente oder die Länge des Vektors

    float *ycentr* (in)
    : Y-Komponente oder der Winkel des Vektors


**$xyplot** vectorconfig *series* **-option** *value* ...
: Legt die Zeichenoptionen der Vektoren einer Reihe fest.

    string *series* (in)
    : Name der Reihe, zu der der Vektor gehört.


    Die Optionen können eine der folgenden sein:

    **colour**
    : Die Farbe des Pfeils (Standard: schwarz; Synonym: Farbe)

    **scale** value
    : Der Skalierungsfaktor, der zur Umrechnung der Pfeillänge in eine Pixelanzahl verwendet wird (Standardwert: 1,0)

    **centred** onoff
    : Logischer Wert. Die xy-Koordinaten sind der Anfang des Pfeils oder sein Mittelpunkt (Voreinstellung 0; Synonym: centered).

    **type** keyword
    : Deutung der Vektorkomponenten. „cartesian“ (Voreinstellung) erwartet die x- und y-Komponenten. „polar“: Winkel 0 liegt auf der positiven x-Achse, 90 auf der positiven y-Achse. „nautical“: 0 ist „north“ und 90 ist „east“.


**$xyplot** dot *series* *xcrd* *ycrd* *value*
: Zeichnet einen Punkt in das Diagramm ein. Größe und Farbe richten sich nach dem Wert und den für die zugehörige Reihe festgelegten Optionen. (Siehe den Unterbefehl „dotconfig“)

    string *series* (in)
    : Name der Serie, zu der der Punkt gehört. Legt Größe und Farbe fest

    float *xcrd* (in)
    : X-Koordinate des Punktes, an dem der Pfeil erscheint

    float *ycrd* (in)
    : Y-Koordinate des Punktes, an dem der Pfeil erscheint

    float *value* (in)
    : Wert, der von Größe und Farbe abhängt


**$xyplot** dotconfig *series* **-option** *value* ...
: Legt die Zeichenoptionen der Punkte einer Reihe fest.

    string *series* (in)
    : Name der Serie, zu der der Punkt gehört.


    Die Optionen können eine der folgenden sein:

    **colour**
    : Die Farbe des Punktes, wenn keine Skalierung verwendet wird oder der Wert den oberen Grenzwert der Klassen überschreitet.

    **scale** value
    : Der Skalierungsfaktor, der zur Umrechnung des Wertes in den Radius des Punktes in Pixeln verwendet wird (Standardwert: 1,0)

    **radius** value
    : Der Standardradius der Punkte, der verwendet wird, wenn keine Skalierung anhand eines Wertes erfolgt (in Pixeln; Standardwert: 3)

    **scalebyvalue** onoff
    : Legt fest, ob alle Punkte dieselbe Größe haben oder ob ihre Größe vom angegebenen Wert abhängt (Voreinstellung on).

    **outline** onoff
    : Zeichnet einen Kreis in black um den Punkt oder nicht (Voreinstellung on).

    **classes** list
    : Legt die Grenzwerte und die entsprechenden Farben fest. Zum Beispiel:

        ```
            $xyplot series1 -classes {0 blue 1 green} -colour red
        ```

        Dies führt dazu, dass für Werte kleiner als 0 ein blauer Punkt, für Werte größer oder gleich 0, aber kleiner als 1 ein grüner Punkt und für Werte größer oder gleich 1 ein roter Punkt gezeichnet wird.

    **3deffect** onoff
    : Zeigt eine Hervorhebung in den Punkten an, um einen 3D-Effekt zu imitieren (Voreinstellung off).

        Wenn für die jeweilige Reihe keine Klassenliste vorliegt, werden die Punkte entsprechend dem Wert skaliert.

        Sie können die Farbgebung nach Wert und die Skalierung nach Wert kombinieren, indem Sie eine Klassenliste festlegen und die Option *scalebyvalue* aktivieren.


**$xyplot** contourlines *xcrd* *ycrd* *values* ?classes?
: Zeichnet Konturlinien für die im Grid angegebenen Werte. Das Grid wird durch die Argumente „xcrd“ und „ycrd“ definiert. Das Argument „xcrd“ (bzw. „ycrd“) soll eine Matrix sein, die als Liste von Listen implementiert ist und die x-Koordinaten (bzw. y-Koordinaten) der Ecken der Grid-Zellen angibt. Die Werte werden an diesen Ecken angegeben. Die Anzahl der Zeilen in „xcrd“ (bzw. „ycrd“) beträgt „ny“, und jede Zeile enthält „nx“ Werte, sodass die Gesamtzahl der Werte in „xcrd“ (bzw. „ycrd“) „nx \* ny“ beträgt. Die Klassen legen fest, welche Konturlinien gezeichnet werden. Wenn ein Wert an einer der Ecken fehlt, werden die Konturlinien in dieser Zelle nicht gezeichnet.

    Einträge in der Legende werden über den Unterbefehl *legendisolines* gezeichnet.

    list *xcrd* (in)
    : Liste von Listen, wobei jeder Wert eine x-Koordinate für eine Ecke einer Grid-Zelle darstellt

    list *ycrd* (in)
    : Liste von Listen, wobei jeder Wert eine y-Koordinate für eine Ecke einer Gitterzelle darstellt

    list *values* (in)
    : Liste von Listen, wobei jeder Wert dem Wert an einer Gitterzellenecke entspricht

    list *classes* (in)
    : Eine Liste von Klassenwerten oder eine Liste von Listen mit jeweils zwei Elementen (jede innere Liste enthält den Wert der Klasse und die zu verwendende Farbe). Ist diese leer oder fehlt sie, werden die Klassen automatisch ermittelt.

        *Hinweis:* Die Werte der Klassen müssen den gesamten Wertebereich abdecken. *Hinweis:* Das Argument „xcrd“ besteht in der Regel aus nypoints identischen Zeilen, während jede Zeile von „ycrd“ aus einem einzigen Wert besteht.


**$xyplot** contourlinesfunctionvalues *xvec* *yvec* *valuesmat* ?classes?
: Zeichnet Konturlinien für die im Grid angegebenen Werte. Das Grid wird durch die Argumente xvec und yvec definiert. Dabei ist xvec (bzw. yvec) eine Liste von x-Koordinaten (bzw. y-Koordinaten). Die Anzahl der Werte in „xvec“ (bzw. „yvec“) entspricht der Anzahl der Punkte an den x-Koordinaten (bzw. den y-Koordinaten). Die Funktionswerte sind an diesen Eckpunkten vorgegeben. Die Klassen legen fest, welche Konturlinien gezeichnet werden. Fehlt ein Wert an einem der Eckpunkte, werden die Konturlinien in dieser Zelle nicht gezeichnet.

    Einträge in der Legende werden über den Unterbefehl *legendisolines* gezeichnet.

    list *xvec* (in)
    : Liste der x-Koordinaten in aufsteigender Reihenfolge.

    list *yvec* (in)
    : Listen Sie die y-Koordinaten in aufsteigender Reihenfolge auf.

    list *valuesmat* (in)
    : Eine Liste aus ny Listen mit nx Werten, wobei jeder Wert den Wert an einer Ecke einer Grid-Zelle angibt. Die Gesamtzahl der Werte (valuesmat) beträgt nx × ny.

    list *classes* (in)
    : Eine Liste von Klassenwerten oder eine Liste von Listen mit jeweils zwei Elementen (jede innere Liste enthält den Wert der Klasse und die zu verwendende Farbe). Wenn diese Liste leer oder fehlt, werden die Klassen automatisch festgelegt.

        *Hinweis:* Die Klassenwerte müssen den gesamten Wertebereich abdecken.


**$xyplot** contourfill *xcrd* *ycrd* *values* ?classes?
: Zeichnet ausgefüllte Konturen für die im Grid angegebenen Werte. (Die Verwendung dieser Methode entspricht der Methode „contourlines“.)

    Einträge in der Legende werden über den Unterbefehl *legendshades* gezeichnet.

**$xyplot** contourbox *xcrd* *ycrd* *values* ?classes?
: Zeichnet die Zellen als ausgefüllte Vierecke. Die Farbe ergibt sich aus dem Durchschnitt der Werte an allen vier Ecken.

    Die Einträge in der Legende werden über den Unterbefehl *legendshades* dargestellt.

**$xyplot** colorMap *colours*
: Legt die Farben fest, die bei den Konturierungsmethoden verwendet werden sollen. Das Argument ist entweder eine vordefinierte Farbpalette (grey/gray, jet, hot oder cool) oder eine Liste von Farben. Bei der Auswahl der Farben für die eigentliche Darstellung der Konturen werden die angegebenen Farben interpoliert (basierend auf dem HLS-Schema).

    list *colours* (in)
    : Eine Liste von Farbnamen oder Farbwerten oder eine der vordefinierten Zuordnungen:

        - grey oder gray: graue Farben von dunkel nach hell

        - jet: Regenbogenfarben

        - hot: Farben von yellow über red nach darkred

        - cool: Farben von cyan über blue nach magenta



**$xyplot** legendisolines *values* *classes*
: Fügt die Konturklassen als farbige Linien in die Legende ein. Der Text gibt die Werte an.

    list *values* (in)
    : Die Liste der Werte, die für die eigentliche Zeichnung verwendet werden. Dieses Argument wird nur verwendet, wenn die Liste der Klassen leer ist.

    list *values* (in)
    : Die Liste der Klassen, die für die eigentliche Zeichnung verwendet wurden.


**$xyplot** legendshades *values* *classes*
: Fügt die Konturklassen als farbige Rechtecke in die Legende ein. Der Text gibt die Werte an.

    list *values* (in)
    : Die Liste der Werte, die für die eigentliche Zeichnung verwendet werden. Dieses Argument wird nur verwendet, wenn die Liste der Klassen leer ist.

    list *values* (in)
    : Die Liste der Klassen, die für die eigentliche Zeichnung verwendet wurden.


**$xyplot** grid *xcrd* *ycrd*
: Zeichnet die Grid-Zellen als Linien, die die (gültigen) Grid-Points miteinander verbinden.

    list *xcrd* (in)
    : Liste von Listen, wobei jeder Wert eine x-Koordinate für eine Ecke einer Grid-Zelle darstellt

    list *ycrd* (in)
    : Liste von Listen, wobei jeder Wert eine y-Koordinate für eine Ecke einer Gitterzelle darstellt


**$xyplot** xband *ymin* *ymax*
: Zeichnet ein hellgraues Band über die ganze x-Achse. Es kann einen „typical“-Bereich der Daten anzeigen.

    float *ymin* (in)
    : Untergrenze für das Band

    float *ymax* (in)
    : Obergrenze für das Band


**$xyplot** yband *xmin* *xmax*
: Zeichnet ein hellgraues Band über die ganze y-Achse. Es kann einen „typical“-Bereich der Daten anzeigen.

    float *xmin* (in)
    : Untergrenze für das Band

    float *xmax* (in)
    : Obergrenze für das Band


**$xyplot** labeldot *x* *y* *text* *orient*
: Zeichnet eine Beschriftung und ein Symbol in die Grafik ein. Die Beschriftung erscheint in der Nähe des Symbols. Die Beschriftung wird in Grau dargestellt, damit sie nicht zu sehr ins Auge fällt.

    Sie können das Erscheinungsbild des Symbols mithilfe des Datenreihennamens „labeldot“ konfigurieren: *$w dataconfig labeldot -colour red -type symbol -symbol dot*

    float *x* (in)
    : X-Koordinate des zu zeichnenden Symbols

    float *y* (in)
    : Y-Koordinate des zu zeichnenden Symbols

    string *text* (in)
    : Text für das Etikett

    string *orient* (in)
    : Optionale Ausrichtung (eine der Optionen „w“, „e“, „n“ oder „s“), die die Position der Beschriftung relativ zum Symbol festlegt. Die Standardeinstellung ist „w“ (sodass die Beschriftung links vom Symbol erscheint).



Für *Polardiagramme*:

**$polarplot** plot *series* *radius* *angle*
: Fügt dem Polardiagramm einen Datenpunkt hinzu.

    string *series* (in)
    : Name der Datenreihe, zu der der neue Datenpunkt gehört.

    float *radius* (in)
    : Radialkoordinate des neuen Punktes.

    float *angle* (in)
    : Koordinate des neuen Punktes (in Grad).



Für *Windrosendiagramme*:

**$windrose** plot *data* *colour*
: Zeichnet die im Argument *data* enthaltenen Daten. Die Daten werden den vorhandenen Speichen in Richtung des äußeren Kreises hinzugefügt.

    list *data* (in)
    : Datenliste (die Länge sollte der Anzahl der Sektoren entsprechen)

    string *colour*
    : Farbe, in der die neuen Segmente gezeichnet werden sollen



Für *3D-Diagramme*:

**$plot3d** plotfunc *function*
: Stellt eine Funktion dar, die über die beiden Variablen **x** und **y** definiert ist. Die Auflösung wird durch die festgelegten Grid-Größen bestimmt (weitere Informationen finden Sie in der Methode **gridsize**).

    string *function* (in)
    : Name der Prozedur, die den z-Wert für die angegebenen x- und y-Koordinaten berechnet. Die Prozedur muss zwei Float-Argumente entgegennehmen (x ist das erste Argument, y das zweite) und einen Gleitkomma-Wert zurückgeben.


**$plot3d** plotfuncont *function* *contours*
: Stellt eine über die beiden Variablen **x** und **y** definierte Funktion dar und verwenden Sie dabei die Konturwerte aus **contours**, um die Oberfläche in Farben einzufärben. Die Auflösung wird durch die festgelegten Grid-Größen bestimmt (weitere Informationen finden Sie in der Methode **gridsize**).

    string *function* (in)
    : Name der Prozedur, die den z-Wert für die angegebenen x- und y-Koordinaten berechnet. Die Prozedur muss zwei Float-Argumente entgegennehmen (x ist das erste Argument, y das zweite) und einen Gleitkomma-Wert zurückgeben.

    list *contours* (in)
    : Liste der Werte in aufsteigender Reihenfolge, die die Konturstufen darstellen (die Grenzen zwischen den Farben in der Konturkarte).


**$plot3d** gridsize *nxcells* *nycells*
: Legt die Grid-Größe in beiden Richtungen fest. Zusammen bestimmen sie, wie viele Polygone für eine Funktionsgrafik gezeichnet werden.

    int *nxcells* (in)
    : Anzahl der Grid-Zellen in x-Richtung. Es muss sich um eine ganze Zahl größer als Null handeln.

    int *nycells* (in)
    : Anzahl der Grid-Zellen in y-Richtung. Muss eine ganze Zahl größer als Null sein.


**$plot3d** plotdata *data*
: Stellt eine Datenmatrix grafisch dar.

    list *data* (in)
    : Die zu darstellenden Daten. Die Daten müssen als verschachtelte Liste mit zwei Ebenen bereitgestellt werden. Die äußere Liste enthält Zeilen, die in y-Richtung dargestellt werden, und jede Zeile ist eine Liste, deren Elemente in x-Richtung dargestellt werden und die Spalten bilden. Beispiele:

        ```
            set data {
            {1.0 2.0 3.0}
            {4.0 5.0 6.0}
            }
        ```


**$plot3d** interpolatedata *data* *contours*
: Stellt die Daten mittels bilinearer Interpolation dar und verwenden Sie dabei die Konturwerte aus **contours**, um die Oberfläche in Farben einzufärben. Die Auflösung wird durch die festgelegten Gittergrößen bestimmt (weitere Informationen finden Sie in der Methode **gridsize**).

    list *data* (in)
    : Die zu darstellenden Daten, genau wie beim Unterbefehl „plotdata“.

    list *contours* (in)
    : Liste der Werte in aufsteigender Reihenfolge, die die Konturstufen darstellen (die Grenzen zwischen den Farben in der Konturkarte).


**$plot3d** colour *fill* *border*
: Legt die Farbe fest, die für die Polygon-Rahmen und den Innenbereich verwendet werden soll. *Hinweis:* Der Unterbefehl „color“ ist ein Synonym.

    color *fill* (in)
    : Die Farbe, die zum Ausfüllen der Polygone verwendet werden soll.

    color *border* (in)
    : Die Farbe, die für den Rahmen der Polygone verwendet werden soll.


**$plot3d** ribbon *yzpairs*
: Zeichnet ein Band auf der Grundlage der yz-Koordinatenpaare. Die Farben für das Band selbst und den Rand werden aus der Option colours übernommen.

    list *yzpairs* (in)
    : Liste der yz-Koordinatenpaare



Für 3D-Banddiagramme:

**$plot3d** plot *yzpairs*
: Zeichnet ein Band auf der Grundlage der yz-Koordinatenpaare. Die Farben für das Band selbst und den Rand werden aus der Option colours übernommen.

    list *yzpairs* (in)
    : Liste der yz-Koordinatenpaare



Für *XY-Diagramme*, *Streifendiagramme*, *Histogramme*, *Polardiagramme* und *ternäre Diagramme*:

**$xyplot** dataconfig *series* **-option** *value* ...
: Legt den Wert für eine oder mehrere Optionen fest, die die Darstellung der Daten einer bestimmten Reihe betreffen.

    string *series* (in)
    : Name der Datenreihe, deren Konfiguration wir ändern.


    Folgende Optionen sind zulässig:

    **colour** c
    : siehe unten ...

    **color** c
    : Die Farbe, die beim Zeichnen der Datenreihe verwendet werden soll.

    **type** enum
    : Der für die Serie gewählte Zeichenmodus. Dies kann entweder **line**, **symbol** oder **both** sein.

    **symbol** enum
    : Welche Art von Symbol gezeichnet werden soll. Der Wert dieser Option wird ignoriert, wenn der Zeichenmodus **line** ausgewählt wurde. Mögliche Werte sind **plus**, **cross**, **circle**, **up** (nach oben zeigendes Dreieck), **down** (nach unten zeigendes Dreieck), **dot** (gefüllter Kreis), **upfilled** oder **downfilled** (gefüllte Dreiecke).

    **radius** integer
    : Die Größe des Radius des Symbols. Die Gesamtbreite des Symbols beträgt das Zweifache des Radius. Der Standardradius beträgt 4.

    **width** integer
    : Die Breite der Linie (wenn gezeichnet) oder die Breite der Polygon-Gliederung (im Fall von -filled).

    **filled** enum
    : Ob der Bereich oberhalb oder unterhalb der Datenlinie ausgefüllt werden soll oder nicht. Mögliche Werte sind: **no**, **up** oder **down** ([Spezialeffekte])

    **fillcolour** colour
    : Farbe, die beim Ausfüllen des Bereichs verwendet werden soll, der der Datenlinie zugeordnet ist.

    **style** enum
    : Der für Histogramme zu verwendende Stil:

        - **filled**: Den Bereich unter den Datenpunkten mit Balken ausfüllen (Standard)

        - **spike**: Zeichnen Sie vertikale Linien von der y-Achse (untere Begrenzung) zum Datenpunkt

        - **symbol**: Zeichnen Sie ein Symbol am Datenpunkt

        - **plateau**: Zeichnen Sie eine horizontale Linie auf Höhe des Datenpunkts

        - **stair**: Zeichnen Sie eine durchgehende, treppenartige Linie als Verbindung der Datenpunkte


    **smooth** boolean
    : (Wird bei ternären Diagrammen verwendet) Legt fest, ob die Linien und gefüllten Polygone mit der Option smooth on (abgerundete Ecken) gezeichnet werden sollen oder nicht.



Für *Kreisdiagramme* und *Spiralkreisdiagramme*:

**$pie** plot *data*
: Füllen Sie ein Kreisdiagramm aus.

    list *data* (in)
    : Eine Liste von Paaren (Bezeichnungen und Werte). Die Werte bestimmen die relative Größe der Kreissegmente. Die Bezeichnungen werden neben dem Kreis dargestellt.


**$pie** colours *colour1* *colour2* ...
: Legt die zu verwendenden Farben fest.

    color *colour1* (in)
    : Die erste Farbe.

    color *colour2* (in)
    : Die zweite Farbe und so weiter.


**$pie** explode *segment*
: Ein Segment herausrücken (d. h.: ein Segment aus dem Kreis herausziehen). Wenn das Segment mit „auto“ gekennzeichnet ist, können Sie auf ein Segment klicken. Dieses wird dann anstelle eines zuvor herausgerückten Segments herausgerückt.

    int *segment*
    : Das Segment, das herausgerückt werden soll, oder „auto“, wenn Sie dies interaktiv durchführen möchten.



Für *Radialdiagramme*:

**$radial** plot *data* *colour* *thickness*
: Zeichnet eine neue Linie im Radialdiagramm ein

    list *data* (in)
    : Eine Liste von Daten (jeweils eine für jede Speiche). Die Werte geben den Abstand vom Mittelpunkt der Verbindung zwischen den Speichen an.

    color *colour* (in)
    : Die Farbe der Linie.

    int *thickness* (in)
    : Ein optionales Argument für die Strichstärke.


**$pie** colours *colour1* *colour2* ...
: Legt die zu verwendenden Farben fest.

    color *colour1* (in)
    : Die erste Farbe.

    color *colour2* (in)
    : Die zweite Farbe und so weiter.



Für *vertikale Balkendiagramme*:

**$barchart** plot *series* *ydata* *colour* ?dir? ?brightness?
: Fügt einem Balkendiagramm eine Datenreihe hinzu. Die Balken sind zur Identifizierung mit dem Tag „data\_\\$series“ versehen.

    string *series* (in)
    : Name der Reihe, zu der die Werte gehören.

    list *ydata* (in)
    : Eine Liste von Werten, jeweils einer pro Beschriftung auf der x-Achse.

    color *colour* (in)
    : Die Farbe der Balken.

    string *dir* (in)
    : Falls angegeben: „Top-down“ oder „Bottom-up“, um die Richtung anzugeben, in die sich die Farbe ändert. (Falls nicht angegeben, wird eine einheitliche Farbe verwendet.)

    string *brightness* (in)
    : Falls angegeben, „bright“ oder „dark“ (Voreinstellung „bright“). Die Farbe geht je nach Richtung nach white oder nach black.


**$barchart** config **-option** *value* ...
: Legt die Optionen für die Darstellung der Balken fest.

    **showvalues** boolean
    : Ob die Werte (über den Balken) angezeigt werden sollen oder nicht

    **valuefont** newfont
    : Name der Schriftart, die für die Werte verwendet werden soll

    **valuecolour** colour
    : Farbe für die Werte

    **valueformat** format
    : Formatzeichenfolge, die zur Formatierung der Werte verwendet werden soll



Für *horizontale Balkendiagramme*:

**$barchart** plot *series* *xdata* *colour* ?dir? ?brightness?
: Fügt einem Balkendiagramm eine Datenreihe hinzu. Die Balken sind zur Identifizierung mit dem Tag „data\_\\$series“ versehen.

    string *series* (in)
    : Name der Reihe, zu der die Werte gehören.

    list *xdata* (in)
    : Eine Liste von Werten, jeweils einer pro Beschriftung der y-Achse.

    color *colour* (in)
    : Die Farbe der Balken.

    string *dir* (in)
    : Falls angegeben, „left-right“ oder „right-left“, um die Richtung anzugeben, in der sich die Farbe ändert. (Wird dies nicht angegeben, wird eine einheitliche Farbe verwendet.)

    string *brightness* (in)
    : Falls angegeben, „bright“ oder „dark“ (Voreinstellung „bright“). Die Farbe geht je nach Richtung nach white oder nach black.


**$barchart** config **-option** *value* ...
: Legt die Optionen für die Darstellung der Balken fest.

    **showvalues** boolean
    : Ob die Werte angezeigt werden sollen oder nicht (rechts neben den Balken)

    **valuefont** newfont
    : Name der Schriftart, die für die Werte verwendet werden soll

    **valuecolour** colour
    : Farbe für die Werte

    **valueformat** format
    : Formatzeichenfolge, die zur Formatierung der Werte verwendet werden soll



Für *3D-Balkendiagramme*:

**$barchart** plot *label* *yvalue* *colour*
: Fügt dem Balkendiagramm den nächsten Balken hinzu.

    string *label* (in)
    : Die Beschriftung, die unterhalb der Spalte angezeigt werden soll.

    float *yvalue* (in)
    : Der Wert, der die Höhe der Spalte bestimmt

    color *colour* (in)
    : Die Farbe der Spalte.


**$barchart** config **-option** *value* ...
: Legt einen oder mehrere Parameter der Konfiguration fest. Folgende Optionen werden unterstützt:

    **usebackground** boolean
    : Ob links und hinter den Spalten Wände eingezeichnet werden sollen oder nicht

    **useticklines** boolean
    : Ob Gitterlinien an den Wänden gezeichnet werden sollen oder nicht

    **showvalues** boolean
    : Ob die Werte angezeigt werden sollen oder nicht

    **labelfont** newfont
    : Name der Schriftart, die für Beschriftungen verwendet werden soll

    **labelcolour** colour
    : Farbe für die Etiketten

    **valuefont** newfont
    : Name der Schriftart, die für die Werte verwendet werden soll

    **valuecolour** colour
    : Farbe für die Werte



Für *3D-Banddiagramme*:

**$ribbon** line *xypairs* *colour*
: Stellt die angegebenen xy-Paare als Band im Diagramm dar

    list *xypairs* (in)
    : Die zu zeichnenden x/y-Wertepaare (die Reihe wird als Ganzes gezeichnet)

    color *colour* (in)
    : Die Farbe des Bandes.


**$ribbon** area *xypairs* *colour*
: Stellt die angegebenen xy-Paare als Band mit einem ausgefüllten Bereich davor dar. Der Effekt entspricht dem einer Box, deren Oberseite aus den Daten besteht.

    list *xypairs* (in)
    : Die zu zeichnenden x/y-Wertepaare (die Reihe wird als Ganzes gezeichnet)

    color *colour* (in)
    : Die Farbe des Bandes/Bereichs.



Für *Boxplots*:

**$boxplot** plot *series* *label* *values*
: Fügt dem Diagramm ein Box-and-Whisker-Diagramm hinzu. Mit dem Befehl „dataconfig“ können Sie das Box-and-Whisker-Diagramm anpassen (Einzelheiten finden Sie im Befehl „box-and-whiskers“ für den Befehl „xyplot“).

    string *series* (in)
    : Name der Datenreihe, zu der die Box gehört

    string *label* (in)
    : Die Beschriftung entlang der x- oder y-Achse, zu der die Daten gehören

    list *values* (in)
    : Liste der Rohwerte; anhand dieser Liste werden die Ausdehnung des Kastens und die Länge der Whisker bestimmt.


**$boxplot** violin *series* *label* *values*
: Fügt dem Diagramm eine „Violine“ hinzu. Mit dem Befehl „dataconfig“ können Sie das Erscheinungsbild anpassen (Einzelheiten finden Sie im Befehl „violin“ für den xyplot).

    string *series* (in)
    : Name der Datenreihe, die für die Einstellungen verwendet werden soll

    string *label* (in)
    : Die Beschriftung entlang der x- oder y-Achse, zu der die Daten gehören

    list *values* (in)
    : Liste der Rohwerte; anhand dieser Liste werden die Ausdehnung des Kastens und die Länge der Whisker bestimmt.



Für *Zeitdiagramme*:

**$timechart** period *text* *time\_begin* *time\_end* *colour*
: Fügt dem Diagramm einen Zeitraum hinzu.

    string *text* (in)
    : Der Text, der diese Epoche beschreibt.

    string *time\_begin* (in)
    : Startzeit des Zeitraums.

    string *time\_end* (in)
    : Endzeit des Zeitraums.

    color *colour* (in)
    : Die Farbe des Balkens (standardmäßig schwarz).


**$timechart** addperiod *time\_begin* *time\_end* *colour*
: Fügt der aktuellen Zeile im Diagramm einen neuen Zeitraum hinzu. Auf diese Weise können Sie mehrere Zeiträume in derselben Zeile hervorheben. Es wird kein neuer Text eingezeichnet.

    string *time\_begin* (in)
    : Startzeit des Zeitraums.

    string *time\_end* (in)
    : Endzeit des Zeitraums.

    color *colour* (in)
    : Die Farbe des Balkens (standardmäßig schwarz).


**$timechart** milestone *text* *time* *colour*
: Fügt dem Diagramm einen *Meilenstein* (dargestellt als nach unten zeigendes Dreieck) hinzu.

    string *text* (in)
    : Der Text, der den Meilenstein beschreibt.

    string *time* (in)
    : Zeitpunkt, zu dem der Meilenstein gesetzt werden muss.

    color *colour* (in)
    : Die Farbe des Dreiecks (standardmäßig schwarz).


**$timechart** addmilestone *time* *colour*
: Fügt der aktuellen Zeile im Diagramm einen weiteren *Meilenstein* hinzu.

    string *time* (in)
    : Zeitpunkt, zu dem der Meilenstein gesetzt werden muss.

    color *colour* (in)
    : Die Farbe des Dreiecks (standardmäßig schwarz).


**$timechart** vertline *text* *time* *colour*
: Fügt dem Diagramm eine vertikale Linie (beispielsweise zur Kennzeichnung des Monatsanfangs) in der angegebenen Farbe hinzu.

    string *text* (in)
    : Der Text, der oben angezeigt wird (beispielsweise eine Abkürzung für Datum und Uhrzeit).

    string *time* (in)
    : Zeitpunkt, zu dem die Linie positioniert werden muss.

    color *colour* (in)
    : Die Farbe der zu zeichnenden Linie (Vorgabe black)


**$timechart** hscroll *scrollbar*
: Verbindet eine waagerechte Bildlaufleiste mit dem Diagramm. Siehe auch den Abschnitt zum Bildlauf.

    widget *scrollbar* (in)
    : Die horizontale Bildlaufleiste, die eine Verbindung zum Diagramm hat


**$timechart** vscroll *scrollbar*
: Verbindet eine senkrechte Bildlaufleiste mit dem Diagramm. Siehe auch den Abschnitt zum Bildlauf.

    widget *scrollbar* (in)
    : Die senkrechte Bildlaufleiste, die mit dem Diagramm verbunden wird.



Für *Gantt-Diagramme*:

**$ganttchart** task *text* *time\_begin* *time\_end* *completed*
: Fügt dem Diagramm eine Aufgabe mit ihrer Dauer und ihrem Fertigstellungsgrad hinzu. Gibt eine Liste von Canvas-Elementen zurück, die für weitere Bearbeitungen verwendet werden können, beispielsweise zur Erstellung einer Verbindung zwischen zwei Aufgaben.

    string *text* (in)
    : Der Text, in dem die Aufgabe beschrieben wird.

    string *time\_begin* (in)
    : Startzeit der Aufgabe.

    string *time\_end* (in)
    : Endzeit der Aufgabe.

    float *completed* (in)
    : Der Prozentsatz der bereits erledigten Aufgabe.


**$ganttchart** milestone *text* *time* *colour*
: Fügt dem Diagramm einen *Meilenstein* (dargestellt als nach unten zeigendes Dreieck) hinzu.

    string *text* (in)
    : Der Text, der den Meilenstein beschreibt.

    string *time* (in)
    : Zeitpunkt, zu dem der Meilenstein gesetzt werden muss.

    color *colour* (in)
    : Die Farbe des Dreiecks (standardmäßig schwarz).


**$ganttchart** vertline *text* *time*
: Fügt dem Diagramm eine vertikale Linie hinzu (beispielsweise, um den Monatsanfang zu kennzeichnen).

    string *text* (in)
    : Der Text, der oben angezeigt wird (beispielsweise eine Abkürzung für Datum und Uhrzeit).

    string *time* (in)
    : Zeitpunkt, zu dem die Linie positioniert werden muss.


**$ganttchart** connect *from* *to*
: Fügt einen Pfeil ein, der die Aufgabe *from* mit der Aufgabe *to* verbindet.

    list *from* (in)
    : Die Liste der Elemente, die vom Befehl „task“ gegeben wird und die die Aufgabe darstellt, von der aus der Pfeil ausgeht.

    string *text* (in)
    : Der Text, der die Aufgaben zusammenfasst

    list *args* (in)
    : Eine oder mehrere Aufgaben (die der Befehl „task“ zurückgibt). Diese werden nach unten verschoben, um Platz für die Zusammenfassung zu schaffen.

    list *to* (in)
    : Die Liste der Elemente, die vom Befehl „task“ zurückgegeben wird und die die Aufgabe darstellt, an der der Pfeil endet.


**$ganttchart** summary *text* *args*
: Fügt einen Zusammenfassungsbalken hinzu, der sich über alle aufgeführten Aufgaben erstreckt. Die grafische Darstellung ist ein breiter Balken, der von der Aufgabe ganz links bis zur Aufgabe ganz rechts verläuft.

    Verwenden Sie diesen Befehl, bevor Sie die Aufgaben miteinander verbinden, da der Pfeil sonst nicht nach unten verschoben wird!

    string *text* (in)
    : Der Text, der die Aufgaben zusammenfasst

    list *args* (in)
    : Eine oder mehrere Aufgaben (die der Befehl „task“ zurückgibt). Diese werden nach unten verschoben, um Platz für die Zusammenfassung zu schaffen.


**$ganttchart** color *keyword* *newcolor*
: Legt die Farbe für einen Teil des Gantt-Diagramms fest. Diese Farben gelten für alle Elemente dieses Types.

    string *keyword* (in)
    : Das Schlüsselwort gibt an, welcher Teil des Gantt-Diagramms geändert werden soll:

        - description – Farbe des beschreibenden Textes

        - completed – Farbe des gefüllten Balkens für den erledigten Teil einer Aufgabe

        - left – Farbe für den noch nicht erledigten Teil

        - odd – Hintergrundfarbe der ungeraden Einträge

        - even – Hintergrundfarbe der geraden Einträge

        - summary – Farbe des Zusammenfassungstextes

        - summarybar – die Farbe des Balkens für eine Zusammenfassung


    string *newcolor* (in)
    : Die neue Farbe für die gewählten Elemente.


**$ganttchart** font *keyword* *newfont*
: Legt die Schriftart für einen Teil des Gantt-Diagramms fest. Diese Schriftarten gelten für alle Elemente dieses Types.

    string *keyword* (in)
    : Das Schlüsselwort gibt an, welcher Teil des Gantt-Diagramms geändert werden soll:

        - description – Schrift des beschreibenden Textes

        - summary – Schrift der Zusammenfassungen

        - scale – Schrift der Zeitskala


    string *newfont* (in)
    : Die neue Schriftart für die ausgewählten Elemente.


**$ganttchart** hscroll *scrollbar*
: Verbindet eine waagerechte Bildlaufleiste mit dem Diagramm. Siehe auch den Abschnitt zum Bildlauf.

    widget *scrollbar* (in)
    : Die horizontale Bildlaufleiste, die eine Verbindung zum Diagramm hat


**$ganttchart** vscroll *scrollbar*
: Verbindet eine senkrechte Bildlaufleiste mit dem Diagramm. Siehe auch den Abschnitt zum Bildlauf.

    widget *scrollbar* (in)
    : Die senkrechte Bildlaufleiste, die mit dem Diagramm verbunden wird.



Für *isometrische Darstellungen* (wird noch erweitert):

**$isoplot** plot rectangle *x1* *y1* *x2* *y2* *colour*
: Zeichnet die Gliederungen eines Rechtecks ein.

    float *x1* (in)
    : Minimale x-Koordinate des zu zeichnenden Rechtecks.

    float *y1* (in)
    : Minimale y-Koordinate des Rechtecks.

    float *x2* (in)
    : Maximale x-Koordinate des zu zeichnenden Rechtecks.

    float *y2* (in)
    : Maximale y-Koordinate des Rechtecks.

    color *colour* (in)
    : Die Farbe des Rechtecks.


**$isoplot** plot filled-rectangle *x1* *y1* *x2* *y2* *colour*
: Zeichnet ein Rechteck, das mit der angegebenen Farbe gefüllt ist.

    float *x1* (in)
    : Minimale x-Koordinate des zu zeichnenden Rechtecks.

    float *y1* (in)
    : Minimale y-Koordinate des Rechtecks.

    float *x2* (in)
    : Maximale x-Koordinate des zu zeichnenden Rechtecks.

    float *y2* (in)
    : Maximale y-Koordinate des Rechtecks.

    color *colour* (in)
    : Die Farbe des Rechtecks.


**$isoplot** plot circle *xc* *yc* *radius* *colour*
: Zeichnet die Gliederung eines Kreises ein.

    float *xc* (in)
    : X-Koordinate des Kreismittelpunkts.

    float *yc* (in)
    : Y-Koordinate des Kreismittelpunkts.

    color *colour* (in)
    : Die Farbe des Kreises.


**$isoplot** plot filled-circle *xc* *yc* *radius* *colour*
: Zeichnet einen Kreis, der mit der angegebenen Farbe ausgefüllt ist.

    float *xc* (in)
    : X-Koordinate des Kreismittelpunkts.

    float *yc* (in)
    : Y-Koordinate des Kreismittelpunkts.

    color *colour* (in)
    : Die Farbe des Kreises.



Für *Tabellen* können Sie die folgenden Unterbefehle verwenden:

**$table** row *items*
: Zeichnet eine einzelne Zeile mit Elementen. Das Erscheinungsbild der Elemente lässt sich explizit über den Befehl „format“ steuern.

    list *items* (in)
    : Liste der zu zeichnenden Textelemente, jeweils eines pro Spalte


**$table** separator
: Zeichnet eine horizontale Linie, um zwei Zeilen voneinander zu trennen

**$table** formatcommand *procname*
: Legt die Prozedur fest, die die Formatierung der Elemente steuert. Standardmäßig werden Elemente lediglich als zentrierter Text dargestellt.

    string *procname* (in)
    : Name der zu verwendenden Prozedur. Ihre Signatur lautet:

        ```
        proc procname {table widget row column value} {...}
        ```

        Nutzt den Unterbefehl „cellconfigure“, um die Attribute pro Zelle festzulegen.


**$table** cellconfigure *args*
: Legt die Attribute für die nächste(n) zu zeichnende(n) Zelle(n) fest.

    list *args* (in)
    : Schlüssel-Wert-Paare: -background legt die Hintergrundfarbe der Zellen fest, -cell legt die Vordergrundfarbe fest, -font legt die Schriftart fest, -anchor legt die Position des Textes innerhalb der Zelle fest und -justify steuert das Layout von mehrzeiligem Text.



Für *ternäre Diagramme* stehen Ihnen die folgenden Unterbefehle zur Verfügung:

**$ternary** plot *series* *xcrd* *ycrd* *zcrd* *text* *dir*
: Zeichnet einen einzelnen Datenpunkt mit einer Beschriftung. Die drei Koordinaten werden so skaliert, dass ein eindeutiger Punkt im Dreieck entsteht. Daneben wird eine Beschriftung eingezeichnet.

    string *series* (in)
    : Name der Datenreihe, zu der der Punkt gehört (dient zur Bestimmung von Farbe und Symbol)

    float *xcrd* (in)
    : X-Koordinate des Datenpunkts (bezogen auf die linke untere Ecke).

    float *ycrd* (in)
    : Y-Koordinate des Datenpunkts (bezogen auf die rechte untere Ecke).

    float *zcrd* (in)
    : Z-Koordinate des Datenpunkts (bezogen auf die obere Ecke).

    string *text* (in)
    : Bezeichnung, die den Datenpunkt beschreibt.

    string *dir* (in)
    : Optionaler String, der die Richtung angibt, in der die Beschriftung dargestellt werden soll (e, n usw.)


**$ternary** line *series* *coords*
: Zeichnet eine durchgehende Linie auf der Grundlage der angegebenen Koordinaten (Dreiergruppen).

    string *series* (in)
    : Name der Datenreihe, zu der die Linie gehört (dient zur Bestimmung der Farbe und der Glättung)

    list *coords* (in)
    : Die Koordinaten der Punkte, die die Gerade bestimmen (beachten Sie, dass ein Punkt durch drei Koordinaten definiert ist).


**$ternary** fill *series* *coords*
: Zeichnet ein ausgefülltes Vieleck auf der Grundlage der angegebenen Koordinaten (Dreiergruppen).

    string *series* (in)
    : Name der Datenreihe, zu der das Polygon gehört (dient zur Bestimmung von Farbe und Glättung)

    list *coords* (in)
    : Die Koordinaten der Punkte, die das Polygon bestimmen (Hinweis: Ein Punkt wird durch drei Koordinaten definiert).


**$ternary** text *xtext* *ytext* *ztext*
: Fügt an den drei Ecken des Diagramms Text ein, um die Komponenten zu kennzeichnen.

    string *xtext* (in)
    : Text, der in der unteren linken Ecke dargestellt werden soll

    string *ytext* (in)
    : Text, der in der rechten unteren Ecke dargestellt werden soll

    string *ztext* (in)
    : Text, der in der oberen Ecke dargestellt werden soll


**$ternary** ticklines *colour*
: Zeichnet Gitterlinien ein, um das Ablesen des Diagramms zu erleichtern.

    string *colour* (in)
    : Optionales Argument, das als Farbe für die Gitterlinien verwendet wird. Die Standardfarbe ist Grau.



Für *Status-Zeitreihen-Diagramme* können Sie die folgenden Unterbefehle verwenden:

**$timeline** plot *series* *item* *start* *stop* *color*
: Zeichnet für das Element *item* einen Balken in der angegebenen Farbe von *start* bis *stop*. Das Element dient lediglich als Bezeichner – es besteht kein Zusammenhang zu den Beschriftungen entlang der Achse. Die Elemente werden von unten nach oben gezeichnet.

    string *item* (in)
    : Name zur Identifizierung der Leiste. Siehe Anmerkung oben.

    float *start* (in)
    : X-Koordinate (bzw. Zeitpunkt), an dem der Balken beginnt

    float *stop* (in)
    : X-Koordinate (bzw. Zeitpunkt), an der der Balken zum Stillstand kommt

    string *color* (in)
    : Für die Leiste zu verwendende Farbe. Vorgabe ist black.


**$timeline** vertline *text* *time* *args*
: Ziehen Sie eine vertikale Linie, um einen wichtigen Moment zu markieren.

    string *text* (in)
    : Text zur Beschreibung des Augenblicks.

    float *time* (in)
    : X-Koordinate (bzw. Zeitpunkt), an der die Linie gezeichnet werden soll

    list *args* (in)
    : Einzelne optionale Argumente, die an den Unterbefehl *create line* des zugrunde liegenden Canvases übergeben werden. Auf diese Weise können Sie die Farbe oder die Linienbreite der vertikalen Linie festlegen.



Für *Dendrogramme* gibt es einen speziellen Unterbefehl:

**$dendrogram** plot *series* *data*
: Zeichnet ein Dendrogramm gemäß den Optionen, die bei der Erstellung des Dendrogramm-Befehls angegeben oder impliziert wurden. Über den Namen „series“ können Sie die Farbe der Zweige (-colour/-color) sowie die Farbe und Schriftart der Beschriftungen auswählen (-labelcolour/-labelcolor und -labelfont).

    string *series* (in)
    : Name der Optionen, mit denen das Dendrogramm gezeichnet werden soll.

    list *data* (in)
    : Verschachtelte Liste, die die Baumstruktur beschreibt. Siehe den Befehl *createDendrogram*.



# Koordinatentransformationen

Neben den Befehlen, die sich direkt auf die Darstellungen und Diagramme beziehen, gibt es eine Reihe von Befehlen, mit denen sich Weltkoordinaten in Pixel umrechnen lassen und umgekehrt. Dazu gehören:

**::Plotchart::viewPort** *w* *pxmin* *pymin* *pxmax* *pymax*
: Legt den Ansichtsbereich für das Fenster *w* fest. Sollte in Verbindung mit **::Plotchart::worldCoordinates** verwendet werden.

    widget *w* (in)
    : Name des betreffenden Fensters (Canvas-Widget).

    float *pxmin* (in)
    : Koordinate des Pixels ganz links.

    float *pymin* (in)
    : Koordinate des obersten Pixels (die senkrechte Pixelkoordinate beginnt oben bei 0).

    float *pxmax* (in)
    : Koordinate des Pixels ganz rechts.

    float *pymax* (in)
    : Koordinate des untersten Pixels.


**::Plotchart::worldCoordinates** *w* *xmin* *ymin* *xmax* *ymax*
: Legt die Extremwerte der Weltkoordinaten für das Fenster *w* fest. Die Weltkoordinaten müssen nicht in aufsteigender Reihenfolge vorliegen (d. h., xmin kann größer als xmax sein, sodass eine Umkehrung der x-Achse erreicht wird).

    widget *w* (in)
    : Name des betreffenden Fensters (Canvas-Widget).

    float *xmin* (in)
    : X-Koordinate, die auf die linke Seite des Ansichtsbereichs abgebildet werden soll.

    float *ymin* (in)
    : Y-Koordinate, die auf den unteren Rand des Ansichtsfensters abgebildet werden soll.

    float *xmax* (in)
    : X-Koordinate, die auf die rechte Seite des Ansichtsfensters abgebildet werden soll.

    float *ymax* (in)
    : Y-Koordinate, die auf die Oberseite des Ansichtsfensters abgebildet werden soll.


**::Plotchart::world3DCoordinates** *w* *xmin* *ymin* *zmin* *xmax* *ymax* *zmax*
: Legt die äußersten dreidimensionalen Weltkoordinaten für das Fenster *w* fest. Die Weltkoordinaten müssen nicht in aufsteigender Reihenfolge vorliegen (d. h., xmin kann größer als xmax sein, sodass eine Umkehrung der x-Achse erreicht wird).

    widget *w* (in)
    : Name des betreffenden Fensters (Canvas-Widget).

    float *xmin* (in)
    : X-Koordinate, die auf die Vorderseite des 3D-Ansichtsfensters abgebildet werden soll.

    float *ymin* (in)
    : Y-Koordinaten, die auf die linke Seite des Ansichtsfensters abgebildet werden sollen.

    float *zmin* (in)
    : Z-Koordinate, die auf den unteren Rand des Ansichtsfensters abgebildet werden soll.

    float *xmax* (in)
    : X-Koordinate, die auf die Rückseite des Ansichtsfensters abgebildet werden soll.

    float *ymax* (in)
    : Y-Koordinate, die auf die rechte Seite des Ansichtsfensters abgebildet werden soll.

    float *zmax* (in)
    : Z-Koordinate, die auf die Oberseite des Ansichtsfensters abgebildet werden soll.


**::Plotchart::coordsToPixel** *w* *x* *y*
: Gibt eine Liste von Pixelkoordinaten zurück, die für das angegebene Fenster gültig sind.

    widget *w* (in)
    : Name des betreffenden Canvas-Alias (wie von \[\\$anyplot canvas\] gegeben).

    float *x* (in)
    : Zu abgebildende X-Koordinate.

    float *y* (in)
    : Zu abgebildende Y-Koordinate.


**::Plotchart::coords3DToPixel** *w* *x* *y* *z*
: Gibt eine Liste von Pixelkoordinaten zurück, die für das angegebene Fenster gültig sind.

    widget *w* (in)
    : Name des betreffenden Canvas-Alias (wie von \[\\$anyplot canvas\] gegeben).

    float *x* (in)
    : Zu abgebildende X-Koordinate.

    float *y* (in)
    : Zu abgebildende Y-Koordinate.

    float *y* (in)
    : Zu abgebildende Z-Koordinate.


**::Plotchart::polarCoordinates** *w* *radmax*
: Legt die äußersten Polarkoordinaten für das Fenster *w* fest. Der Winkel reicht stets von 0 bis 360 Grad, und der Radius beginnt bei 0. Daher müssen Sie lediglich den maximalen Radius angeben. *Hinweis:* Wenn der Darstellungsbereich nicht quadratisch ist, werden die Extremwerte bei dieser Prozedur nicht angepasst, was zu einer elliptischen Darstellung führen würde. Die Erstellungsroutine für eine polare Darstellung legt stets einen quadratischen Darstellungsbereich fest.

    widget *w* (in)
    : Name des betreffenden Canvas-Alias (wie von \[\\$anyplot canvas\] gegeben).

    float *radmax* (in)
    : Maximaler Radius.


**::Plotchart::polarToPixel** *w* *rad* *phi*
: Wrapper für einen Aufruf von **::Plotchart::coordsToPixel**. *Hinweis:* Diese Prozedur ist veraltet – bitte verwenden Sie stattdessen die Prozedur **::Plotchart::coordsToPixel**.

    widget *w* (in)
    : Name des betreffenden Canvas-Alias (wie von \[\\$anyplot canvas\] gegeben).

    float *rad* (in)
    : Radius des Punktes.

    float *phi* (in)
    : Winkel zur positiven x-Achse.


**::Plotchart::pixelToCoords** *w* *x* *y*
: Gibt eine Liste von Weltkoordinaten zurück, die für das angegebene Fenster gültig sind.

    widget *w* (in)
    : Name des betreffenden Canvas-Alias (wie von \[\\$anyplot canvas\] gegeben).

    float *x* (in)
    : X Pixel sollen abgebildet werden.

    float *y* (in)
    : Zu abgebildendes Y-Pixel.


**::Plotchart::pixelToIndex** *w* *x* *y*
: Gibt den Index des Kreissegments zurück, das die Pixelkoordinaten (x, y) enthält

    widget *w* (in)
    : Name des betreffenden Canvas-Alias (wie von \[\\$anyplot canvas\] gegeben), der ein Kreisdiagramm enthält.

    float *x* (in)
    : X Pixel sollen abgebildet werden.

    float *y* (in)
    : Zu abgebildendes Y-Pixel.



Darüber hinaus gibt es eine Routine zur Ermittlung „pretty“-Zahlen für die Verwendung in einer Achse:

**::Plotchart::determineScale** *xmin* *xmax* *inverted*
: Ermittelt „pretty“-Zahlen aus dem angegebenen Bereich und gibt eine Liste zurück, die das Minimum, das Maximum und die Schrittweite enthält, die für eine (lineare) Achse verwendet werden können.

    float *xmin* (in)
    : Ungefährer Wert für die Skalierung

    float *xmax* (in)
    : Ungefährer Wert für die Skalierung.

    boolean *inverted* (in)
    : Optionales Argument: Wenn der Wert 1 ist, gibt die zurückgegebene Liste eine umgekehrte Achse zurück. Der Standardwert ist 0 (die Achse verläuft vom Minimum zum Maximum).


**::Plotchart::determineScaleFromList** *values* *inverted*
: Ermittelt aus der vorgegebenen Werteliste „pretty“-Zahlen und gibt eine Liste zurück, die das Minimum, das Maximum und die Schrittweite enthält, die für eine (lineare) Achse verwendet werden können.

    float *values* (in)
    : Liste der Werte, die überprüft werden sollen. Kann fehlende Werte (leere Zeichenfolgen) enthalten.

    boolean *inverted* (in)
    : Optionales Argument: Wenn der Wert 1 ist, gibt die zurückgegebene Liste eine umgekehrte Achse zurück. Der Standardwert ist 0 (die Achse verläuft vom Minimum zum Maximum).



# Fehlende Werte

Häufig weisen Daten, die grafisch dargestellt werden sollen, Lücken auf – in einer Messdatenreihe können diese beispielsweise durch einen Geräteausfall, eine fehlerhafte Probenentnahme oder aus vielen anderen Gründen entstehen. Das *Plotchart* behandelt diese Lücken, indem es davon ausgeht, dass eine oder beide Koordinaten solcher Datenpunkte eine leere Zeichenkette sind:

```
    #
    # Create the plot with its x- and y-axes
    #
    set s [::Plotchart::createXYPlot .c {0.0 100.0 10.0} {0.0 100.0 20.0}]

    foreach {x y} {0.0 32.0 10.0 {} 25.0 60.0 78.0 11.0 } {
        $s plot series1 $x $y
    }
```

Die Wirkung hängt von der Art der Darstellung ab:

- Bei xy-Diagrammen, Radialdiagrammen und Streifendiagrammen führt der fehlende Datenpunkt zu einer Lücke in der Linie, die durch die Punkte verläuft.

- Bei Balkendiagrammen werden fehlende Werte so behandelt, als wäre der Wert Null angegeben worden.

- Bei Zeitdiagrammen und Gantt-Diagrammen führen fehlende Werte zu Fehlern – dort sind sie nutzlos.


# Weitere Ausgabeformate

Neben der Ausgabe auf das Canvas ist das Modul in der Lage, über **canvas postscript** PostScript-Dateien zu erzeugen. Man mag sich fragen, ob es möglich ist, diese Auswahl an Ausgabeformaten zu erweitern, und die Antwort lautet „yes“. In diesem Abschnitt wird versucht, die Aspekte der Nutzung dieses Moduls für eine andere Art der Ausgabe zusammenzufassen.

Eine Möglichkeit, Ausgabedateien in einem anderen Format zu erstellen, besteht darin, den Inhalt des Canvases zu überprüfen, nachdem alles gezeichnet wurde, und diesen Inhalt in der richtigen Form darzustellen. Dies ist wahrscheinlich der einfachste Weg, da er lediglich die Neuerstellung aller bereits vorhandenen Elemente in der Zeichnung erfordert.

Der Nachteil ist, dass ein Display nötig ist. Das fehlt oft bei einem CGI-Server oder Ähnlichem.

Eine Alternative ist, den Befehl canvas nachzubilden. Dafür muss klar sein, welche Unterbefehle von canvas benutzt werden und wozu. Offensichtlich wird der Unterbefehl *create* zum Erstellen von Linien, Texten und anderen Elementen verwendet. Aber auch die Unterbefehle *raise* und *lower* kommen zum Einsatz, da das Modul mit diesen die Zeichenreihenfolge beeinflussen kann – was wichtig ist, um ein Clipping-Rechteck um die Achsen herum zu simulieren. (Die Routine „DrawMask“ ist hierfür zuständig – wenn das Ausgabeformat korrekte Bereiche für Clipping unterstützt, könnte eine Neudefinition dieser Routine das Problem möglicherweise lösen).

Darüber hinaus nutzt das Modul den Unterbefehl *cget*, um die Abmessungen des Canvases zu ermitteln. Ein eher praktischer Aspekt dabei ist, dass das Modul derzeit davon ausgeht, dass der Text 14 Pixel hoch ist und dass 80 Pixel Breite für die Achsenbeschriftungen ausreichen. Es wird kein „Hook“ bereitgestellt, um diese Werte anzupassen.

Zusammenfassend lässt sich sagen:

- Den Unterbefehl *create* nachbilden, damit alle Elemente im richtigen Format entstehen

- Den Unterbefehl *cget* für die Optionen -width und -height nachbilden, damit Lage und Größe des Rechtecks stimmen

- Das Anheben und Absenken der Elemente so lösen, dass sie richtig beschnitten werden, etwa durch eine neue Definition der Routine DrawMask.

- Die derzeit festen Eigenschaften der Textgröße berücksichtigen


# Spezialeffekte

Als Beispiel für einige Spezialeffekte, die Sie erzielen können, finden Sie hier den Code für eine Darstellung, bei der sich die Farbe des Bereichs unterhalb der Datenlinie ändert:

```
canvas .c  -background white -width 400 -height 200
pack .c -fill both

set s [::Plotchart::createXYPlot .c {0.0 100.0 10.0} {0.0 100.0 20.0}]

$s background gradient green top-down

$s dataconfig series1 -filled up -fillcolour white

$s plot series1  0.0 20.0
$s plot series1 10.0 20.0
$s plot series1 30.0 50.0
$s plot series1 35.0 45.0
$s plot series1 45.0 25.0
$s plot series1 75.0 55.0
$s plot series1 100.0 55.0

$s plaintext 30.0 60.0 "Peak" south
```

Der Trick besteht darin, den Hintergrund mit einer Farbe zu füllen, die sich von oben (grün) nach unten (weiß) verändert. Anschließend wird der Bereich oberhalb der Datenlinie mit einem weißen Polygon ausgefüllt. Auf diese Weise variiert die grüne Schattierung je nach Höhe der Linie.

# Verbesserungsbedarf

In dieser Version gibt es noch viele Dinge, die umgesetzt werden müssen:

- Robustere Behandlung fehlerhafter Aufrufe (derzeit können die Prozeduren bei fehlerhaftem Aufruf fehlschlagen):

    - Die Routinen zum Zeichnen von Achsen können derzeit keine umgekehrten Achsen verarbeiten.

    - Wenn der Benutzer eine ungültige Datums-/Zeitangabe eintippt, lösen die Routinen lediglich einen Fehler aus.



# Größenanpassung

**Plotchart** ist nicht dafür ausgelegt, Diagramme zu erzeugen, die sich die eingegebenen Daten merken. Wenn eine Anwendung dem Benutzer also erlauben soll, die Größe des Fensters mit dem Diagramm zu ändern, muss sie selbst dafür sorgen, das gesamte Diagramm neu zu zeichnen.

Der folgende Code ist ein einfaches Beispiel dafür, wie dies umgesetzt werden kann:

```
package require Plotchart

grid [canvas .c -background white] -sticky news
grid columnconfigure . 0 -weight 1
grid rowconfigure . 0 -weight 1

bind .c <Configure> {doResize}

proc doPlot {} {
    #
    # Clean up the contents (see also the note below!)
    #
    .c delete all

    #
    # (Re)draw the bar chart
    #
    set p [::Plotchart::createBarchart .c {x y z} {0 100 10} 3]
    $p plot R {10 30 40} red
    $p plot G {30 40 60} green
}

proc doResize {} {
    global redo

    #
    # To avoid redrawing the plot many times during resizing,
    # cancel the callback, until the last one is left.
    #
    if { [info exists redo] } {
        after cancel $redo
    }

    set redo [after 50 doPlot]
}
```

*Bitte beachten Sie:* Der obige Code funktioniert einwandfrei für Balkendiagramme und viele andere Diagrammtypen; da **Plotchart** jedoch bei XY-Diagrammen bestimmte vertrauliche Informationen speichert, sind in diesen Fällen zusätzliche Maßnahmen erforderlich. Hierfür ist tatsächlich der Befehl „destroyPlot“ erforderlich, um solche Details zu regeln. Eine nächste Version von **Plotchart** könnte diese Funktion enthalten.

Alternativ können Sie das Paket **xyplot** verwenden, das auf Plotchart aufbaut. Dieses Paket unterstützt das Vergrößern und Verkleinern sowie die Größenanpassung der gesamten Darstellung. Hier ist ein kleines Demonstrationsprogramm:

```
# xyplot_demo.tcl --
#     Demonstration of the xyplot package
#

package require xyplot

set xydata1 {}
set xydata2 {}
set xydata3 {}
set xydata4 {}
for { set i 0 } { $i < 1024 } { incr i } {
    lappend xydata1 [expr {$i-1000}] [expr {$i * sin($i/4096.0*3.1415*2) * (sin($i/256.0*3.1415*2))}]
    lappend xydata2 [expr {$i-1000}] [expr {$i * sin($i/4096.0*3.1415*2) * (sin($i/256.0*3.1415*2) + 0.25 * sin($i/256.0*3.1415*6))}]
    lappend xydata3 [expr {$i-1000}] [expr {$i * sin($i/4096.0*3.1415*2) * (sin($i/256.0*3.1415*2) + 0.25 * sin($i/256.0*3.1415*6) + 0.0625 * sin($i/256.0*3.1415*10))}]
    lappend xydata4 [expr {$i-1000}] [expr {$i * sin($i/4096.0*3.1415*2) * (sin($i/256.0*3.1415*2) + 0.25 * sin($i/256.0*3.1415*6) + 0.0625 * sin($i/256.0*3.1415*10) + 0.015625 * sin($i/256.0*3.1415*14))}]
}

set xyp [xyplot .xyp -xformat "%5.0f" -yformat "%5.0f" -title "XY plot testing" -background gray90]
pack $xyp -fill both -expand true

set s1 [$xyp add_data sf1 $xydata1 -legend "Serie 1 data" -color red]
set s2 [$xyp add_data sf2 $xydata2 -legend "Serie 2 data" -color green]
set s3 [$xyp add_data sf3 $xydata3 -legend "Serie 3 data" -color blue]
set s4 [$xyp add_data sf4 $xydata4 -legend "Serie 4 data" -color orange]

set xyp2 [xyplot .xyp2 -xticks 8 -yticks 4 -yformat %.2f -xformat %.0f]
pack $xyp2 -fill both -expand true

set s1 [$xyp2 add_data sf1 $xydata1]
set s2 [$xyp2 add_data sf2 $xydata2]
set s3 [$xyp2 add_data sf3 $xydata3]
set s4 [$xyp2 add_data sf4 $xydata4]
```

Zum Vergrößern wird bei gedrückter linker Maustaste ein Rechteck aufgezogen. Zum Verkleinern dient die rechte Maustaste. Ändert sich die Fenstergröße, ändern sich auch die Canvas-Widgets darin. Nach dem Vergrößern lässt sich die Darstellung über die automatisch angebrachten Bildlaufleisten verschieben.

# Vergrößern

Da das „Plotchart“-Paket die Daten selbst nicht verwaltet, müsste eine Neuskalierung eines bestehenden Diagramms – beispielsweise beim Vergrößern – durch eine Neudefinition des Diagramms und ein erneutes Zeichnen der Daten erfolgen. Das „Canvas“-Widget bietet jedoch eine Lösung, indem es Elemente skaliert und verschiebt, sodass das Vergrößern etwas einfacher wird.

Ob das Zoomen tatsächlich sinnvoll ist, hängt von der Art der Darstellung ab. Derzeit ist diese Funktion nur für XY-Diagramme definiert. Die Methode heißt „rescale“ und zeichnet die Achsen und Skalen einfach neu und verschiebt die Datenpunkte so, dass sie den neuen Achsen entsprechen. Der Nachteil besteht darin, dass alle Symbole um denselben Faktor skaliert werden. Die „rescale“-Methode eignet sich am besten für Diagramme, die nur Linien und keine Symbole enthalten.

Die Methode funktioniert ganz einfach:

```
   $p rescale {newxmin newxmax newxstep} {newymin newymax newystep}
```

# Konfigurationsoptionen und weitere Befehle

Mit den Befehlen **plotconfig** und **plotstyle** lassen sich verschiedene Optionen festlegen. Der Befehl **eraseplot** löscht eine Darstellung oder ein Diagramm vollständig. Die Syntax dieser Befehle lautet:

**::Plotchart::plotconfig** *charttype* *component* *property* *value*
: Legt einen neuen Wert für die Eigenschaft einer Komponente in einem bestimmten Diagramm- oder Darstellungstyp fest oder fragen Sie deren aktuellen Wert ab. Geänderte Eigenschaften wirken sich nur auf die nachfolgenden Darstellungen aus, nicht auf bereits erstellte. Jedes Argument ist optional.

    *Hinweis:* Der Befehl **plotstyle** bietet eine flexiblere Möglichkeit zur Steuerung der Konfigurationsoptionen.

    string *charttype* (in)
    : Der Typ des Diagramms oder der Darstellung (siehe den Konfigurationstyp, der bei jedem create-Befehl angegeben ist). Wird dieser nicht angegeben oder ist er leer, gibt es eine Liste der Diagrammtypen zurück. Wird er angegeben, werden die Eigenschaften für diesen bestimmten Typ verwendet.

    string *component* (in)
    : Die Komponente des Diagramms: leftaxis, rightaxis, background, margin und so weiter. Fehlt sie oder ist sie leer, kommt eine Liste der Komponenten zurück. Ist sie angegeben, gelten die Eigenschaften dieser Komponente für diesen Diagrammtyp.

    string *property* (in)
    : Die Eigenschaft der Komponente: textcolor, die thickness der Achsenlinie und so weiter. Fehlt sie oder ist sie leer, kommt eine Liste der Eigenschaften zurück. Ist sie angegeben, wird diese Eigenschaft dieser Komponente für diesen Diagrammtyp gesetzt.

    string *value* (in)
    : Der neue Wert der Eigenschaft. Ist er leer, kommt der aktuelle Wert zurück. Der Wert „default“ stellt den Vorgabewert wieder her.

        Ein leerer Wert ist manchmal sinnvoll. Dafür steht „none“, etwa bei Farben und Formaten.


**::Plotchart::plotstyle** *subcmd* *style* *args*
: Steuert den *style*, in dem die folgenden Darstellungen gezeichnet werden. Der Vorgabestil ist „default“. Weitere Stile lassen sich definieren und laden.

    string *subcmd* (in)
    : Der auszuführende Unterbefehl:

        - *configure* – Mit diesem Unterbefehl können Sie die Optionen für die einzelnen Diagrammtypen festlegen. Er akzeptiert dieselben Optionen wie der Befehl **plotconfig**.

        - *current* – gibt den aktuellen Stil zurück

        - *load* – Legt den angegebenen Style als aktiven Style für nachfolgende Diagramme und Grafiken fest

        - *names* – gibt die Liste der derzeit definierten Styles zurück


    string *style* (in)
    : Der Name des Diagrammstils, der bearbeitet werden soll

    list *args* (in)
    : Die neuen Optionen für das Design. Jede Option wird wie folgt beschrieben: Diagrammtyp, Komponente des Diagramms, Eigenschaft der Komponente und der neue Wert für die Eigenschaft – Einzelheiten finden Sie im Befehl **plotconfig**.



Nachstehend finden Sie eine detaillierte Auflistung der Komponenten und Eigenschaften:

- Achsen gibt es in vielen Varianten:

    - „leftaxis“, „rightaxis“, „topaxis“ und „bottomaxis“ für die Diagramme mit rechteckiger Form.

    - xaxis, yaxis und zaxis gelten für die 3D-Diagramme

    - axis – die radiale und die tangentiale Achse eines Polardiagramms


- Alle Achsen weisen die folgenden Eigenschaften auf:

    - color – Farbe der Linie und der Skalenstriche

    - thickness – Breite der Achsenlinie selbst, nicht der Skalenstriche

    - ticklength – die Länge der Skalenstriche in Pixeln. Ein positiver Wert bedeutet nach außen, ein negativer Wert nach innen.

    - font – Schrift der Beschriftungen und des Textes an der Achse

    - format – Format der numerischen Beschriftungen. An der Zeitachse das Format für Datum und Uhrzeit.

    - textcolor – die Farbe für die Beschriftungen und den Text.

    - labeloffset – Abstand (in Pixeln) zwischen dem Skalenstrich und der eigentlichen Beschriftung

    - minorticks – Anzahl der kleinen Skalenstriche zwischen den großen

    - shownumbers – Legt fest, ob die Zahlen/Bezeichnungen angezeigt werden sollen oder nicht.

    - showaxle – Legt fest, ob die Achsenlinie angezeigt werden soll oder nicht.


- Die Komponente *margin* bestimmt das Layout. Derzeit lassen sich die Ränder nur bei rechteckigen Diagrammen setzen: left, right, top und bottom. Die Werte sind Pixel.

- Die Komponente *text* gilt für Text über den Unterbefehl plaintext. Die Eigenschaften sind textcolor, font und anchor (Lage des Textes zu den angegebenen Koordinaten).

- Die Komponente *background* hat zwei Eigenschaften: outercolor, die Farbe außerhalb der eigentlichen Darstellung, und innercolor, die Farbe innen. (Derzeit ist nur outercolor umgesetzt.)

- Die Komponente *mask* hat nur die Eigenschaft draw. Steht sie auf 1, der Vorgabe, werden weiße Rechtecke gezeichnet, die das Abschneiden nachahmen: überstehende Daten werden unsichtbar. Sonst entfallen die Rechtecke. Das hilft, das Layout enger zu steuern, etwa bei mehreren Darstellungen auf einem Canvas.

- Die *title*-Komponente verfügt über dieselben Eigenschaften wie die *text*-Komponente (ist jedoch von dieser unabhängig). Sie verfügt zudem über eine *background*-Eigenschaft: Ist diese nicht festgelegt (oder auf die leere Zeichenkette gesetzt), entspricht sie der outercolor-Eigenschaft der *background*-Komponente; andernfalls handelt es sich um eine eigene Farbe.

- Die Komponente *legend* hat drei Eigenschaften: background, border und position. Die Bedeutung steht beim Unterbefehl legend.

- Die Komponente *bar* wird für alle Balkendiagramm-ähnlichen Darstellungen verwendet und verfügt über drei Eigenschaften: *barwidth* (relative Breite der Balken im Verhältnis zu den Elementen entlang der Achse), *innermargin* (relative Breite der Abstände zwischen Balken oder Balkengruppen) und die Farbe *outline*.

- Die Komponente *labels* dient dazu, das Erscheinungsbild der Beschriftungen von Kreisdiagrammen und „Spiral“-Kreisdiagrammen zu beschreiben. Die Eigenschaften lauten:

    - textcolor – Farbe des Beschriftungstextes

    - font – Schrift des Beschriftungstextes

    - placement – *out* außerhalb des Kreises oder *in* im Kreis

    - sorted – die Daten werden zuerst aufsteigend geordnet

    - shownumbers – Die Bezeichnungen werden gemäß dem Format mit den Zahlen kombiniert

    - format – das zu verwendende Format (Standardwert: „%s (%g)“), wenn die Zahlen angezeigt werden sollen. Der Befehl „format“ gibt zunächst die Bezeichnung und anschließend die Zahl an.

    - formatright – Falls angegeben, das Format, das für Beschriftungen und Zahlen rechts neben dem Kreisdiagramm verwendet werden soll. Der Befehl „format“ gibt zuerst die Zahl und dann die Beschriftung an. (Standardwert: „“)


- Die Komponente *slice* verfügt über Eigenschaften, mit denen sich das Erscheinungsbild der Segmente im Kreisdiagramm steuern lässt:

    - outline – Farbe der Linie um die Segmente (Vorgabe: black)

    - outlinewidth – Breite der Linie um die Segmente herum (Standard: 1 Pixel)

    - startangle – Winkel gegen die positive x-Achse, an dem das erste Segment beginnt

    - direction – Richtung, in der die Segmente gezeichnet werden (Vorgabe: +, also im Uhrzeigersinn)


- Tabellendiagramme nutzen die allgemeinen Komponenten *title* und *margin* und dazu *header*, *oddrow*, *evenrow*, *cell* und *frame*:

    - *header*, *oddrow* und *evenrow* haben die Eigenschaften *background*, *font*, *color*, *height* und *anchor*.

    - Die Komponente *cell* definiert zusätzlich *leftspace*, *rightspace* und *topspace* zur feinen Steuerung der Abstände innerhalb der Zelle. Diese werden jedoch nicht über den Unterbefehl *cellconfigure* festgelegt.

    - Die Komponente *frame* nutzt *color*, *outerwidth* (Breite der Linie um die ganze Tabelle) und *innerwidth* (Breite der Linien zwischen Spalten und Zeilen).


- Das Zieldiagramm und das Taylor-Diagramm verwenden neben den verschiedenen allgemeinen Komponenten auch die *limits*-Komponente. Die *limits*-Komponente verfügt über eine Eigenschaft: die Farbe der Kreise und Kreissegmente.

    Beim Taylor-Diagramm können Sie die Farbe der Referenzkreise über die *reference*-Komponente festlegen.


**::Plotchart::eraseplot** *anyplot*
: Löschen Sie die Kurve/das Diagramm samt aller Verbindungen zu den damit verbundenen Ressourcen.

    string *anyplot* (in)
    : Der Befehl „plot/chart“. Alle mit diesem Befehl verknüpften Canvas-Elemente sowie alle internen Ressourcen werden entfernt, einschließlich des Befehls „plot/chart“ selbst.



Beispiele für die Verwendung finden Sie in der Datei „plotdemos7.tcl“.

# Scrollen bei Zeitdiagrammen und Gantt-Diagrammen

Für zwei Arten von Diagrammen wurde eine automatische Bildlaufsteuerung implementiert: Zeitdiagramme und Gantt-Diagramme. Die Unterbefehle *hscroll* und *vscroll* ordnen dem Diagramm (vorhandene) Bildlaufleisten zu, ähnlich wie dies bei Text- und Canvas-Widgets der Fall ist.

Sobald die Zuordnung hergestellt ist, werden die Bildlaufleisten automatisch aktualisiert, wenn:

- Ein Eintrag kommt hinzu, dessen Zeitraum länger ist als der aktuelle.

- Eine senkrechte Linie kommt für einen Zeitpunkt außerhalb der aktuellen Grenzen hinzu.

- Ein weiteres Element kommt hinzu, über die Zahl hinaus, mit der das Diagramm erzeugt wurde.


Zum Beispiel:

```
package require Plotchart

canvas .c -width 400 -height 200
scrollbar .y -orient vertical
scrollbar .x -orient horizontal

grid .c .y -sticky news
grid .x    -sticky news

source plotchart.tcl

set s [::Plotchart::createTimechart .c "1 january 2004"  "31 december 2004" 4]

$s period "Spring" "1 march 2004" "1 june 2004" green
$s period "Summer" "1 june 2004" "1 september 2004" yellow
$s vertline "1 jan" "1 january 2004"
$s vertline "1 apr" "1 april 2004"
$s vertline "1 jul" "1 july 2004"
$s vertline "1 oct" "1 october 2004"
$s vertline "1 jan" "1 january 2005"
$s vertline "1 apr" "1 april 2005"
$s vertline "1 jul" "1 july 2005"
$s milestone "Longest day" "21 july 2004"
$s milestone "Longest day 2" "21 july 2004"
$s milestone "Longest day 3" "21 july 2004"
$s milestone "Longest day 4" "21 july 2004"
$s milestone "Longest day 5" "21 july 2004"
$s milestone "Longest day 6" "21 july 2004"
$s title "Seasons (northern hemisphere)"

$s vscroll .y
$s hscroll .x
```

Der ursprüngliche Zeitraum des Diagramms erstreckt sich vom 1. Januar 2004 bis zum 31. Dezember 2004. Da jedoch im Jahr 2005 vertikale Linien hinzugefügt wurden und mehr Elemente vorhanden sind, als bei der Erstellung des Diagramms festgelegt waren, werden sowohl die horizontale als auch die vertikale Bildlaufleiste aktiviert.

# Spezielle Diagramme

Die meisten der oben beschriebenen Diagramm- und Grafiktypen sind relativ allgemein einsetzbar, und Sie bereiten die zu darstellenden Daten einfach selbst vor. In diesem Abschnitt werden mehrere Diagrammtypen beschrieben, die insofern spezialisierter sind, als sie spezifische Zwecke erfüllen und Sie Rohdaten übergeben, die dann in den Darstellungsroutinen verarbeitet werden.

Derzeit gibt es folgende Typen:

- Zieldiagramme dienen dazu, die Fähigkeit numerischer Modelle zur Nachbildung von Messdaten zu bewerten. Sie werden ausführlich beschrieben in:

    ```
    Jason K. Joliff et al.
        Summary diagrams for coupled hydrodynamic-ecosystem model skill assessment
        Journal of Marine Systems 76 (2009) 64-82
        DOI: 10.1016/j.jmarsys.2008.05.014
    ```

- Leistungsprofile dienen dazu, die Leistung numerischer Methoden oder deren Implementierungen miteinander zu vergleichen. Weitere Informationen finden Sie unter:

    ```
    Desmond Higham and Nicholas Higham
        Matlab Guide
        SIAM, 2005, Philadephia
    ```

- Taylor-Diagramme sind eine weitere grafische Darstellung davon, wie numerische Modelle Messdaten nachbilden. Eine ausführliche Beschreibung findet sich in <https://en.wikipedia.org/wiki/Taylor_diagram>.


Die meisten allgemeinen Methoden für XY-Diagramme lassen sich auch auf diese Diagramme anwenden, doch ihre Erstellung und die Methoden zur Darstellung der Daten sind sehr spezifisch.

**::Plotchart::createTargetDiagram** *w* *limits* *scale*
: Erzeugt ein neues Zieldiagramm mit Kreisen, die bestimmte Grenzwerte kennzeichnen. Die x-Achse stellt die unverzerrte „root-mean-square difference“ dar (die typischerweise zwischen -1 und 1 schwankt), und die y-Achse stellt die normalisierte Verzerrung dar.

    Datenpunkte, die näher am Ursprung liegen, stehen für bessere Ergebnisse als Datenpunkte, die weiter entfernt sind.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *limits* (in)
    : Liste der Radien der Kreise, die die Grenzwerte darstellen (beispielsweise: 0,5 und 0,7)

    double *scale* (in)
    : Skalierung der Achsen – der Standardwert ist 1; wenn die Modellergebnisse jedoch nicht gut passen, ist dieser Wert möglicherweise zu klein. Beide Achsen werden auf dieselbe Weise skaliert.


**$target** plot *series* *xvalues* *yvalues*
: Die Plot-Methode verwendet zwei Datensätze gleicher Länge, wobei der erste die Modellergebnisse und der zweite die Messwerte oder, allgemeiner gesagt, die Daten darstellt, die reproduziert werden sollen.

    string *series* (in)
    : Name der Serie (wird als Symbol dargestellt, das über den Befehl *$target dataconfig* konfiguriert wird (siehe die entsprechende XY-Darstellung zur Erläuterung))

    list *xvalues* (in)
    : Liste der Modellergebnisse (fehlende Werte werden als leere Zeichenfolgen dargestellt)

    list *yvalues* (in)
    : Liste der Werte (fehlende Werte werden als leere Zeichenfolgen dargestellt; nur wenn sowohl der x- als auch der y-Wert angegeben sind, wird das Paar in den Berechnungen berücksichtigt)


**::Plotchart::createPerformanceProfile** *w* *max*
: Erzeugt ein Diagramm, um die Leistungsfähigkeit verschiedener numerischer Methoden (oder Löser) darzustellen. Die Idee besteht darin, diese Methoden zunächst auf eine Reihe von Aufgaben anzuwenden und ihre Leistungsfähigkeit zu messen. Je kleiner der Wert, desto besser. Anschließend werden diese Methoden anhand eines sogenannten Leistungsprofils verglichen: Die Daten werden skaliert und geordnet, sodass die beste Methode an oberster Stelle steht.

    Aufgrund der Art der Darstellung müssen alle Daten auf einmal angegeben werden.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    float *max* (in)
    : Maximaler Wert für die x-Achse (die x-Achse stellt den skalierten Wert der Reihe dar).


**$performance** plot *series\_and\_data\_pairs*
: Stellt die Daten für jede angegebene Methode grafisch dar. Die Daten werden anhand des Namens der Serie identifiziert, und die Darstellung wird über den zuvor eingegebenen „dataconfig“-Unterbefehl gesteuert.

    list *series\_and\_data\_pairs* (in)
    : Liste der Serientitel und Daten. Alle Daten müssen auf einmal angegeben werden.


**::Plotchart::createTaylorDiagram** *w* *radius\_data* *args*
: Erzeugt ein neues Taylor-Diagramm (ein Quadrant) mit Kreisen, die den Abstand zum Referenzpunkt angeben.

    Die Datenpunkte sind als Standardabweichung und als Korrelation zum Referenzpunkt angegeben.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Grafik angezeigt werden soll.

    list *radius\_data* (in)
    : Eine Liste der maximalen Radien für die Standardabweichung und die Schrittweite. Es werden Viertelkreise mit den Achsenbeschriftungen eingezeichnet.


    Derzeit wird eine Option unterstützt:

    **reference** value
    : Wert, mit dem die Datenpunkte verglichen werden sollen. Er wird als Punkt auf der x-Achse dargestellt. Zusammen mit diesem Punkt werden Kreissegmente im gleichen Abstand wie die Achsenbeschriftungen eingezeichnet, um den Abstand der Datenpunkte zur Referenz anzuzeigen.


**$taylor** plot *series* *stdev* *corr*
: Die Plot-Methode nimmt die Standardabweichung und die Korrelation zur Referenz als Eingabewerte entgegen und zeichnet ein Symbol als Darstellung. Die Standardabweichung dient als Abstand vom Ursprung, und die Korrelation bestimmt den Winkel.

    string *series* (in)
    : Name der Serie (wird als Symbol dargestellt, das über den Befehl *$target dataconfig* konfiguriert wird (siehe die entsprechende XY-Darstellung zur Erläuterung))

    float *stdev* (in)
    : Standardabweichung des Datenpunkts

    list *corr* (in)
    : Korrelationskoeffizient mit dem Referenzdatensatz


**::Plotchart::createHeatmap** *w* *rowlabels* *columnlabels* *args*
: Erzeugt eine Heatmap, d. h. eine Tabelle aus Rechtecken, deren Farben von bestimmten Daten abhängen. Die Zeilen- und Spalte-Bezeichnungen dienen beim Einfügen der Daten als Kennungen. Ihre Anzahl bestimmt die Größe der Tabelle.

    Die Daten werden zeilenweise, spaltenweise oder zelleweise übergeben.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Heatmap angezeigt werden soll.

    list *rowlabels* (in)
    : Liste der Bezeichnungen, die in jeder Zeile angezeigt werden sollen. Die Bezeichnungen dienen zudem als Kennungen.

    list *columnlabels* (in)
    : Liste der Bezeichnungen, die in jeder Spalte angezeigt werden sollen. Die Bezeichnungen dienen zudem als Kennungen.

    list *args* (in)
    : Null oder mehr Argumente zur Festlegung der Größe der Heatmap. Weitere Informationen finden Sie unter „XY-Diagramm“.


**$heatmap** plot row *label* *data*
: Nutzt die angegebenen Daten, um die Rechtecke der Zeile „label“ auszufüllen.

    string *label* (in)
    : Zeichenkette, die angibt, welche Zeile verwendet werden soll.

    list *data* (in)
    : Liste der numerischen Daten, die für die Farbgebung der Rechtecke verwendet werden sollen.


**$heatmap** plot column *label* *data*
: Füllt mit den angegebenen Daten die Rechtecke der Spalte „label“.

    string *label* (in)
    : Zeichenkette, die angibt, welche Spalte verwendet wird.

    list *data* (in)
    : Liste der numerischen Daten, die für die Farbgebung der Rechtecke verwendet werden sollen.


**$heatmap** plot cell *rowlabel* *columnlabel* *value*
: Nutzt den angegebenen Wert, um das Rechteck auszufüllen, das zu der Zelle mit den angegebenen Zeilen- und Spaltenbezeichnungen gehört.

    string *rowlabel* (in)
    : Zeichenkette, die angibt, welche Zeile verwendet werden soll.

    string *columnlabel* (in)
    : Zeichenkette, die angibt, welche Spalte verwendet wird.

    float *value* (in)
    : Wert, der für die Farbgebung der Zelle verwendet werden soll.


**$heatmap** scale values *min* *max*
: Legt den Bereich der Werte fest – die Werte werden mittels linearer Interpolation einer Farbe zugeordnet.

    float *min* (in)
    : Zu verwendender Mindestwert.

    float *max* (in)
    : Zu verwendender Höchstwert.


**$heatmap** scale colours *mincolour* *maxcolour*
: Legt die Farben fest, die für den Minimal- und den Maximal-Wert verwendet werden sollen. Die tatsächliche Farbe wird durch lineare Interpolation der RGB-Werte ermittelt.

    string *mincolour* (in)
    : Farbe beim Minimalwert.

    string *maxcolour* (in)
    : Farbe beim Maximalwert.


**::Plotchart::createCircleplot** *w* *labels* *args*
: Erzeugt einen circle plot, einen Kreis mit Beschriftungen, die sich durch farbige Bögen verbinden lassen. Typische Anwendung: Darstellung der Beziehungen zwischen den Elementen auf dem Kreis in grafischer Form.

    Die Verbindungen können paarweise eingezeichnet werden.

    widget *w* (in)
    : Name des *vorhandenen* Canvas-Widgets, in dem die Kreisgrafik angezeigt werden soll.

    list *rowlabels* (in)
    : Liste der Beschriftungen, die entlang des Kreises angezeigt werden sollen. Jede Beschriftung wird von einem ausgefüllten Punkt begleitet.

    list *args* (in)
    : Null oder mehr Argumente zur Festlegung der Größe des circle plot. Weitere Informationen finden Sie unter „XY-Diagramm“.


**$circleplot** connect *label1* *label2* *colour* *width*
: Schaffen Sie eine Verbindung zwischen den beiden Beschriftungen durch einen farbigen Bogen mit einer vorgegebenen Breite (der Bogen ist eigentlich eine Parabel).

    string *label1* (in)
    : Zeichenkette, die die erste zu verbindende Beschriftung angibt.

    string *label2* (in)
    : Zeichenkette, die die zweite Beschriftung angibt, mit der eine Verbindung hergestellt werden soll.

    string *colour* (in)
    : Farbe, die für den verbundenen Bogen verwendet werden soll.

    string *width* (in)
    : Breite der Verbindung des Bogens.


**$circleplot** modify *label* *args*
: Passt das Aussehen der Beschriftung und des dazugehörigen Punkts an.

    string *label* (in)
    : Zeichenkette, die angibt, welche Bezeichnung geändert werden soll.

    list *args* (in)
    : Liste der Schlüssel-Wert-Paare:

        - *-textcolour colour* – Farbe des Textes (Alternative: „-textcolor“)

        - *-font font* – Schrift des Textes

        - *-dotcolour colour* – Farbe des Punktes (Alternative: „-dotcolor“)




# Eigene Diagrammmethoden hinzufügen

Mit dem Befehl *plotmethod* lassen sich neue Methoden für einen bestimmten Diagrammtyp hinzufügen. Er hilft, spezielle grafische Darstellungen zu entwickeln.

**::Plotchart::plotmethod** *charttype* *methodname* *plotproc*
: Fügt eine neue Methode für den angegebenen Diagramm- oder Charttyp hinzu. Die Methode wird durch den im Argument „plotproc“ angegebenen Befehl oder die dort angegebene Prozedur implementiert. Die Prozedur wird mit zwei zusätzlichen Argumenten aufgerufen: dem Namen des erstellten Diagramms und dem Canvas-Widget, das dieses enthält (siehe das Beispiel unten).

    string *charttype* (in)
    : Die Art des Diagramms oder der Grafik, zu der die neue Methode hinzugefügt werden soll.

    string *methodname* (in)
    : Name der zu verwendenden Methode.

    string *plotproc* (in)
    : Name des Befehls oder der Prozedur, die die Methode implementiert.



Hier ist ein einfaches Beispiel für die Anwendung:

```
#
# The custom method "doodle" always adds the text "DOODLE"
# to the plot
#
proc doodle {p w x y} {
    $p plaintext $x $y "DOODLE"
}
::Plotchart::plotmethod xyplot doodle doodle

#
# Use it
pack [canvas .c]

set p [::Plotchart::createXYPlot .c {0 100 10} {0 20 5}]

$p doodle 40 10
```

# Tabellendiagramme

Um zu veranschaulichen, welche Möglichkeiten Ihnen mit Tabellendiagrammen zur Verfügung stehen, finden Sie hier ein einfaches Beispiel, in dem eine Reihe von Zufallsdaten grafisch dargestellt wird. Die Farben richten sich nach dem Bereich, zu dem die Daten gehören. Hierfür wird die Prozedur *setColor* verwendet.

```
package require Plotchart

pack [canvas .c -bg white -height 300] -fill both -expand yes

::Plotchart::plotconfig table frame outerwidth 3
::Plotchart::plotconfig table frame color red

set t [::Plotchart::createTableChart .c {"Column 1" "Column 2" "Column 3"} 80]


proc setColor {table widget row col value} {
    $table cellconfigure -background white -color black
    if { $value < 2.0 } {
        $table cellconfigure -background red -color white
    }
    if { $value > 6.0 } {
        $table cellconfigure -background green
    }

    return [format "%6.3f" $value]
}

# Command must already exist ...
$t formatcommand setColor

$t title "Demonstration of table charts"
$t separator

for {set i 0} {$i < 9} {incr i} {
    set row {}

    for {set j 0} {$j < 3} {incr j} {
        lappend row [expr {10.0 * rand()}]
    }

    if { $i == 3 } {
        $t separator
    }

    $t row $row
}
```

# Anzeigeinstrumente

TODO

# Verwendung von Datums- und Zeitangaben

Die Optionen -timeformat und -gmt dienen dazu, die Anzeige von Datums- und Zeitangaben entlang der x-Achse für jene Diagrammtypen zu steuern, bei denen dies sinnvoll ist. Diese Optionen wurden implementiert, um Datums- und Zeitangaben für Streifendiagramme zu berücksichtigen, da sich bei einer Achse „static“ auch eigene Beschriftungen (die Option -xlabels) setzen lassen. Da dies bei Streifendiagrammen nicht der Fall ist, war dies keine Option (Tcllib/Tklib-Fehler 3613718). Sie können auch die Option -locale angeben, um eine lokalisierte Datums- und Zeitbeschriftung zu erhalten. Das folgende Beispiel veranschaulicht die Verwendung der Option -timeformat. Die Option -gmt unterdrückt lediglich die Berücksichtigung der Sommerzeit durch den Befehl \[clock format\].

```
package require Plotchart

pack [canvas .c -width 500 -bg white]

#
# Note that we need to present the x values as clock seconds
#
set start [clock scan  "0:00"]
set stop  [clock scan "10:00"]
set s [Plotchart::createStripchart .c [list $start $stop 7200] {0 10 1} -timeformat "%H:%M"]

# With a locale like "de":
#set s [Plotchart::createStripchart .c [list $start $stop 7200] {0 10 1} -timeformat "%H:%M" -locale de]

foreach {x y} {0 0 2 5 5 2 9 9 12 10} {
    set x [expr {$start + 3600 * $x}] ;# Convert hour to clock seconds
    $s plot a $x $y
}
```

Der Unterbefehl *plot* interpretiert die x- und y-Daten lediglich als reine Zahlen, die Umrechnung von Datum und Uhrzeit in „clock seconds“ bleibt außen vor.

# Anordnung mehrerer Diagramme auf einem Canvas

Mit dem Befehl *plotpack* können Sie den Inhalt einer Grafik in ein anderes Canvas-Widget kopieren. Dieses Canvas-Widget fungiert nicht als zusammengesetzte Grafik, kann jedoch beispielsweise als PostScript-Datei gespeichert werden: Hinweis: Der Befehl erstellt lediglich eine Momentaufnahme der Grafiken, wie sie zu diesem Zeitpunkt aussehen.

**::Plotchart::plotpack** *w* *dir* *args*
: Kopieren Sie den Inhalt der Diagramme/Grafiken in ein anderes Widget, ähnlich wie beim Geometriemanager *pack*.

    widget *w* (in)
    : Der Name des Canvas-Widgets, in das die Diagramme/Grafiken kopiert werden sollen

    string *dir* (in)
    : Die Ausrichtung der Anordnung – oben, links, unten oder rechts

    list *args* (in)
    : Liste der zu kopierenden Diagramme/Grafiken.



Beispiel:

```
    set p1 [createXYPlot ...]
    set p2 [createBarchart ...]

    ... fill the plots ...

    toplevel .t
    pack [canvas .t.c2 -width ...]

    #
    # Copy the two plots above each other in the new canvas
    #
    plotpack .t.c2 top $p1 $p2
```

Eine andere Methode besteht darin, bei der Erstellung der Grafik die Optionen *-box* und *-axesbox* zu verwenden. Diese steuern den Bereich auf dem Canvas, in dem die Grafik oder das Diagramm gezeichnet wird.

Die Option *-box* nimmt als Wert eine Liste aus vier Zahlen entgegen:

- X-Koordinate der oberen linken Ecke des Bereichs, in dem die Grafik oder das Diagramm angezeigt werden soll (einfach eine Canvas-Koordinate)

- Y-Koordinate der oberen linken Ecke

- Breite des Bereichs

- Höhe des Bereichs


Durch die Angabe von Breite und Höhe lässt sich der Bereich leichter im Verhältnis zu anderen Diagrammen neu positionieren.

Die Option *-axesbox* soll die Ausrichtung der Achsen eines Diagramms an denen anderer Diagramme erleichtern. Die Option erwartet eine Liste mit sechs Argumenten:

- Identifikation des Plots, in Bezug auf den er positioniert werden soll (der vom Befehl „create“ zurückgegebene Befehl).

- Die zu verwendende Position des Ankers (n, nw, …)

- X-Koordinate der oberen linken Ecke des Bereichs, in dem die Grafik oder das Diagramm angezeigt werden soll. Diese Koordinate wird relativ zur *Ankerposition* angegeben.

- Y-Koordinate der oberen linken Ecke

- Breite des Achsenbereichs

- Höhe des Achsenbereichs


Mit dieser Option wird zunächst die Fläche ermittelt, die die Achsen einnehmen, und die Gesamtfläche wird anhand der Außenabstände berechnet.

Beispiel:

```
    set p2 [::Plotchart::createXYPlot .c {0 10 1} {-5 5 2.5} -axesbox [list $p1 ne 0 0 200 200]]
```

Erzeugt ein zweites Diagramm, dessen linke Achse mit der rechten Achse des Diagramms „\\$p1“ zusammenfällt und dessen Achsenoberkante sich ebenfalls auf derselben Höhe befindet – da die Achsen an einem Punkt positioniert sind, der 0 Pixel links und 0 Pixel unterhalb der nordöstlichen Ecke liegt.

# Interaktive Nutzung

*Plotchart* verfügt über mehrere Funktionen für die interaktive Nutzung (vgl. [Hinweise zu Tags]):

- Sie können die Legende verschieben, indem Sie die linke Maustaste innerhalb des Legendenfeldes drücken und gedrückt halten.

- Mit den Befehlen *bindplot* und *bindlast* können Sie Aktionen definieren, die ausgeführt werden sollen, wenn der Benutzer auf ein Element der Darstellung oder des Diagramms klickt. (siehe unten, siehe auch den Beispielcode in plotdemos12.tcl)

- *Piecharts* können ein Segment „exploded“ anzeigen, das sich mit Maustaste 1 wählen lässt.


Andere Interaktion, die *Plotchart* selbst nicht bietet, lässt sich über die Tags der Canvas-Elemente mit weiteren Bindungen einrichten.

*bindplot* und *bindlast* sind so definiert:

**$anyplot** bindplot *event* *command* *args*
: Registrieren Sie einen Befehl, der immer dann ausgeführt wird, wenn das angegebene Ereignis im Diagramm eintritt.

    string *event*
    : Das Ereignis, an das Sie den Befehl binden möchten

    string *command*
    : Name des Befehls bzw. der Prozedur, die Sie ausführen möchten. Den folgenden Argumenten werden die x- und y-Koordinaten des Punktes in der Darstellung (die Weltkoordinaten!) vorangestellt, sodass die Prozedur folgende Signatur aufweist:

        ```
            cmd $xworld $yworld $string1 $string2 $string3
        ```

        Angenommen, das Argument „command“ lautet: {cmd A B C}


**$anyplot** bindlast *series* *event* *command*
: Registrieren Sie einen Befehl, der ausgeführt wird, wenn das Ereignis in der Nähe des zuletzt zur angegebenen Reihe hinzugefügten Punktes eintritt. (Sie können dies unmittelbar nach dem Einfügen eines Datenpunkts tun. Alle derartigen Befehle bleiben aktiv.)

    string *event*
    : Das Ereignis, an das Sie den Befehl binden möchten

    list *command*
    : Name des Befehls bzw. der Prozedur, die Sie ausführen möchten. Den folgenden Argumenten werden die x- und y-Koordinaten des Punktes in der Darstellung (die Weltkoordinaten!) vorangestellt, sodass die Prozedur folgende Signatur aufweist:

        ```
            cmd $xworld $yworld $string1 $string2 $string3
        ```

        Angenommen, das Argument „command“ lautet: {cmd A B C}



Hier ist ein Beispiel – zeigen Sie die Werte der Datenpunkte in einer Beschriftung an (aus dem Beispielcode in „plotdemos12.tcl“):

```
#
# Procedure for showing an annotation
#
proc showAnnotation {xcoord ycoord plot w} {

    $plot balloon $xcoord $ycoord "Data point: [format "%.3f, %.3f" $xcoord $ycoord]" north

    after 2000 [list removeAnnotation $w]
}

#
# Procedure for erase an annotation
#
proc removeAnnotation {w} {

    # Use the tags to remove all annotations
    $w delete BalloonText
    $w delete BalloonFrame
}

#
# Create a simple plot and a label
#
pack [canvas .c -bg white] [label .l -textvariable coords]

set p [::Plotchart::createXYPlot .c {0 1000 200} {0 10 1}]

$p dataconfig series1 -type both -symbol cross

foreach x {1 2 5 10 20 50 100 200 500 1000} {
    $p plot series1 $x [expr {log($x)}]

    #
    # Show the annotation for each data point
    #
    $p bindlast series1 <Enter> [list showAnnotation $p %W]
}
```

# Hinweise zu Tags

Die Implementierung von *Plotchart* stützt sich in hohem Maße auf die Fähigkeit des Canvases, grafische Objekte anhand von Tags zu identifizieren und die Zeichenreihenfolge der Objekte zu ändern. In diesem Abschnitt werden die verwendeten Tags beschrieben.

(*Hinweis:* Die Tags werden nicht immer einheitlich verwendet – siehe die Hinweise zu den jeweiligen Tags. In diesem Abschnitt wird der aktuelle Stand beschrieben.)

*General graphical objects:*

- *mask* – Dient zur Bearbeitung der undurchsichtigen Rechtecke, die sicherstellen, dass Daten außerhalb des Ansichtsbereichs nicht angezeigt werden.

- *topmask, horizmask, vertmask* – spezielle Tags, die für scrollbare Diagramme verwendet werden.

- *title* – Tag für Titelzeichenketten.

- *BalloonText, BalloonFrame* – Dienen zur Bearbeitung von Sprechblasentexten.

- *PlainText* – Wird verwendet, um einfachen Text ohne jegliche Formatierung zu bearbeiten.

- *background* – Tag für Farbverlaufs- und Bildhintergründe und für Balken mit Farbverlauf.

- *xaxis*, *yaxis* – Tags für alle Objekte einer waagerechten oder senkrechten Achse, sowohl bei numerischen Achsen als auch bei Achsen mit Beschriftungen wie in Balkendiagrammen. Der *text* entlang der Achsen hat kein eigenes Tag.

- *raxis* – Tag, der für alle Objekte verwendet wird, die sich auf eine *rechte* Achse beziehen.

- *taxis* – Tag für alle Objekte einer Achse *time*.

- *axis3d* – Tag, das für 3D-Achsen verwendet wird

- *xtickline, ytickline* – Tags für die Gitterlinien.

- *legend, legengb, legendobj* – Tags, die für die Legende verwendet werden. Letzteres dient dazu, die Legende als Ganzes zu bearbeiten.

- *legend\_series* – Tag zur Steuerung der Darstellung des Legenden-Eintrags („series“ sollte durch den Namen der Reihe ersetzt werden).

- *object* – Standard-Tag für alle Objekte, die **::Plotchart::drawobject** zeichnet. Tags von der Erzeugung kommen dazu.


*XY-Diagramme (alle Achsenarten):*

- *data* – allgemeines Tag für grafische Objekte, die zu Daten gehören. *data\_seriesname* – Tag einer Datenreihe („seriesname“ wird ersetzt). *band* – das waagerechte oder senkrechte Band der Unterbefehle xband und yband trägt dieses Tag unter dem tatsächlichen Namen. *xtext* – Beschriftung der x-Achse. *ytext* – waagerechte Beschriftung der y-Achse. *vtext* – senkrechte Beschriftung der y-Achse.


Beschriftete Punkte tragen nur das Tag „data“.

*Kreisdiagramme und Spiralkreisdiagramme:*

- *segment\_segmentnumber* – Das Tag zur Identifizierung des Segments; die Zeichenfolge „segmentnumber“ sollte durch die tatsächliche Nummer ersetzt werden. Dieses Tag zieht die Segmente heraus.


*Balkendiagramme:*

Balkendiagramme verwenden dieselben Tags wie XY-Diagramme (bei Balken mit Farbverlauf wird jedoch „data\_seriesname“ nicht verwendet).

*Histogramme und isometrische Diagramme:*

Derzeit wird ausschließlich das Tag „data“ verwendet.

*Zeitdiagramme:*

Da diese Diagramme scrollbar sind, werden mehrere Tags verwendet, die spezifisch für das Scrollen sind: „vertscroll“, „horizscroll“, „below“, „lowest“, „above“, „timeline“, „tline“. Jedes Element verfügt zudem über ein Tag der Form „item\_number“, wobei „number“ durch die tatsächliche Sequenznummer des Elements ersetzt werden muss.

*Gantt-Diagramme:*

Zusätzlich zu den für Zeitdiagramme beschriebenen Tags werden folgende Tags verwendet: description, completed, summary und summarybar.

*Radialdiagramme und Polardiagramme:*

Derzeit haben die radialen Linien, die das Grid anzeigen, keine Tags. Die mit Daten verbundenen grafischen Objekte besitzen lediglich das Tag „data“.

*Windrosen:*

Derzeit wird nur das Tag *data\_number* verwendet („number“ sollte durch die fortlaufende Nummer der Daten ersetzt werden, beginnend bei 0.

*Kontur- und Isoliniendiagramme:*

Es werden keine Tags verwendet.

*3D-Diagramme und 3D-Banddiagramme:*

Für die Achsen und die Datenobjekte werden Tags verwendet:

- *data* – Das allgemeine Tag zur Kennzeichnung von grafischen Objekten, die mit Daten verknüpft sind. *line* – Das Tag für Linien, die mit dem Unterbefehl „plotline“ erstellt wurden.


*Diagramme mit 3D-Effekten:*

Die folgenden Tags werden zur Kennzeichnung verschiedener Arten von grafischen Objekten verwendet: platform, background, d, u, ticklines.

Der mit den Balken verbundene Text hat keine Tags. Auch die Bandlinien und Flächen haben keine Tags.

*Tabellen:*

Verwendete Tags sind: „frame“, „cellbg“ und „celltext“

*Spezielle Diagrammtypen (Zieldiagramme, Taylor-Diagramme):*

Verwendete Tags sind: limits, limit\_labels, reference *Zudem:* Um mehrere Plots und Diagramme auf einem einzigen Canvas darzustellen, erhalten alle Elemente zusätzlich als Tag den Plot bzw. das Diagramm, zu dem sie gehören. Dies ermöglicht es Plotchart, ausschließlich diese Elemente zu bearbeiten.

# Noch zu tun – einige private Notizen

Ich habe folgende Wunschliste:

- Isometrische Darstellungen – ermöglichen die einfache Implementierung neuer Elemente.

- Ein allgemeiner 3D-Viewer – mit Schwerpunkt auf Geometrie, kein Raytracer.

- Mehrere Verbesserungen bei den Boxplots:

    - Die Höhe des Kastens skaliert mit dem Logarithmus der Punktanzahl

    - Markierungslinie zur Kennzeichnung eines Wertes „current“

    - Aus Quantilen erstellte Box



<

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *plotchart* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 2022 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
