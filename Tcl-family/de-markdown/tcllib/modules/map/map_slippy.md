---
CommandName: map::slippy
ManualSection: n
Version: 0.10
TclPart: tcllib
TclDescription: Mapping utilities
Keywords:
 - geodesy
 - geography
 - latitute
 - location
 - longitude
 - map
 - slippy
 - zoom
Copyright:
---

# NAME

map::slippy – Gemeinsamer Code für auf Slippy basierende Kartenpakete

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.10]{.optlit} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [2point]{.lit} [zoom]{.arg} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [center]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [corners]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [diameter]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [dimensions]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [fit]{.lit} [geobox]{.arg} [canvdim]{.arg} [zmax]{.arg} [zmin]{.optarg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [inside]{.lit} [geobox]{.arg} [geo]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [limit]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [opposites]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [perimeter]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [valid]{.lit} [geobox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [box]{.lit} [valid-list]{.lit} [geoboxes]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [distance]{.lit} [geo1]{.arg} [geo2]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [distance\*]{.lit} [closed]{.arg} [geo...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [distance-list]{.lit} [closed]{.arg} [geo-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [limit]{.lit} [geo]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [bbox]{.lit} [geo...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [bbox-list]{.lit} [geo-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [center]{.lit} [geo...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [center-list]{.lit} [geo-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [diameter]{.lit} [geo...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [diameter-list]{.lit} [geo-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [2point]{.lit} [zoom]{.arg} [geo]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [2point\*]{.lit} [zoom]{.arg} [geo...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [2point-list]{.lit} [zoom]{.arg} [geo-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [valid]{.lit} [geo]{.arg} 
[::map]{.cmd} [slippy]{.sub} [geo]{.lit} [valid-list]{.lit} [geos]{.arg} 
[::map]{.cmd} [slippy]{.sub} [length]{.lit} [level]{.arg} 
[::map]{.cmd} [slippy]{.sub} [limit2]{.lit} [x]{.arg} 
[::map]{.cmd} [slippy]{.sub} [limit3]{.lit} [x]{.arg} 
[::map]{.cmd} [slippy]{.sub} [limit6]{.lit} [x]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [2geo]{.lit} [zoom]{.arg} [pointbox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [center]{.lit} [pointbox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [corners]{.lit} [pointbox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [diameter]{.lit} [pointbox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [dimensions]{.lit} [pointbox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [inside]{.lit} [pointbox]{.arg} [point]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [opposites]{.lit} [pointbox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [box]{.lit} [perimeter]{.lit} [pointbox]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [distance]{.lit} [point1]{.arg} [point2]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [distance\*]{.lit} [closed]{.arg} [point...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [distance-list]{.lit} [closed]{.arg} [point-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [bbox]{.lit} [point...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [bbox-list]{.lit} [point-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [center]{.lit} [point...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [center-list]{.lit} [point-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [diameter]{.lit} [point...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [diameter-list]{.lit} [point-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [2geo]{.lit} [zoom]{.arg} [point]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [2geo\*]{.lit} [zoom]{.arg} [point...]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [2geo-list]{.lit} [zoom]{.arg} [point-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [simplify]{.lit} [radial]{.lit} [threshold]{.arg} [point-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [point]{.lit} [simplify]{.lit} [rdp]{.lit} [point-list]{.arg} 
[::map]{.cmd} [slippy]{.sub} [pretty-distance]{.lit} [x]{.arg} 
[::map]{.cmd} [slippy]{.sub} [tiles]{.lit} [level]{.arg} 
[::map]{.cmd} [slippy]{.sub} [tile]{.lit} [size]{.lit} 
[::map]{.cmd} [slippy]{.sub} [tile]{.lit} [valid]{.lit} [zoom]{.arg} [row]{.arg} [column]{.arg} [levels]{.arg} [msgvar]{.optarg} 
[::map]{.cmd} [slippy]{.sub} [valid]{.lit} [latitude]{.lit} [x]{.arg} 
[::map]{.cmd} [slippy]{.sub} [valid]{.lit} [longitude]{.lit} [x]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket bietet eine Reihe von Methoden, die Funktionen bereitstellen, die von allen Arten von auf „slippy“ basierenden Kartenpaketen benötigt werden.

*ACHTUNG*, *Hinweis*: Version *0.9* hat keine Kompatibilität mit Version 0.7 und früheren Versionen. Die gesamte API wurde *grundlegend überarbeitet und geändert*.

*Hinweis:* Informationen zur Darstellung von Positionen in den verschiedenen Koordinatensystemen, die von den Befehlen dieses Pakets verwendet werden, finden Sie im Abschnitt **KOORDINATENSYSTEME**. In den Beschreibungen der Befehle werden diese Informationen nicht erneut aufgegriffen; es wird davon ausgegangen, dass sie bereits bekannt sind.

# KOORDINATENSYSTEME

Die Befehle dieses Pakets arbeiten mit zwei unterschiedlichen Koordinatensystemen: geografischen Standorten und Punkten. Ersteres stellt Koordinaten für Orte auf der Erde dar, während letzteres für die Verwendung in Tk-*Canvas*-Widgets vorgesehen ist.

## Geografisch

Geografische Standorte (kurz: *geo*) werden durch ein Paar aus *Breitengrad*- und *Längengrad*-Werten dargestellt, die jeweils in Grad angegeben werden, da es sich im Wesentlichen um Winkel handelt.

Der Längengrad „**Zero**“ entspricht dem *Greenwich-Meridian*, wobei positive Werte nach *Osten* und negative Werte nach *Westen* verweisen, was einen Gesamtbereich von +/- 180 Grad ergibt. Hinweis: Die Längengrade +180 und -180 stellen denselben *Meridian* dar, der Greenwich gegenüberliegt.

Der Breitengrad **zero** entspricht dem *Äquator*, wobei positive Werte nach *Norden* und negative Werte nach *Süden* verweisen. Während der tatsächliche Bereich bei +/- 90 Grad liegt, erfordert die vom Paket verwendete Projektion, dass wir den Bereich auf etwa +/- **85.05112877983284** Grad begrenzen. Dies bedeutet, dass der Nord- und der Südpol nicht darstellbar sind und auf keiner Karte erscheinen.

Ein geografischer Standort wird durch eine Liste dargestellt, die zwei Werte enthält: den Breitengrad und den Längengrad des Standorts, und zwar in dieser Reihenfolge.

Ein geografischer Begrenzungsrahmen wird durch eine Liste dargestellt, die vier Werte enthält: den minimalen Breiten- und Längengrad des Rahmens sowie den maximalen Breiten- und Längengrad des Rahmens, und zwar in dieser Reihenfolge.

Geografische Standorte und Rahmen können mithilfe eines zusätzlichen Parameters, der *zoom*-Stufe, in Punkte und deren Rahmen umgewandelt werden. Dieser Parameter gibt die Größe der Karte auf dem Canvas an, auf dem die Koordinaten projiziert werden sollen.

## Punkte

Punkte (kurz: *point*) werden durch ein Paar von *x*- und *y*-Werten dargestellt, die jeweils in Pixeln gemessen werden. Sie beziehen sich auf eine Position in einem Tk-*Canvas*-Widget. Da eine Karte in verschiedenen Vergrößerungsstufen angezeigt werden kann, hängen die genauen Pixel-Koordinaten eines geografischen Ortes von dieser *zoom*-Stufe ab.

Damit die folgende Erläuterung verständlich ist, sollten Sie beachten, dass eine in einem Tk-*Canvas*-Widget angezeigte Karte in gleich große quadratische *Kacheln* unterteilt ist.

Punktkoordinaten sind Kachelkoordinaten, die entsprechend der Größe dieser Kacheln skaliert sind. Dieses Paket verwendet Kacheln der Größe **256**; dies ist die Standardgröße, die von vielen Online-Servern verwendet wird, die Kartenkacheln verschiedener Art bereitstellen.

Ein Punkt wird durch eine Liste dargestellt, die die x- und y-Koordinaten des Ortes in dieser Reihenfolge enthält.

Ein Punktbegrenzungsrahmen wird durch eine Liste dargestellt, die vier Werte enthält: die minimalen x- und y-Koordinaten des Rahmens sowie die maximalen x- und y-Koordinaten des Rahmens, und zwar in dieser Reihenfolge.

Punktpositionen und Kästchen können mithilfe eines zusätzlichen Parameters, der *zoom*-Stufe, in geografische Positionen und die dazugehörigen Kästchen umgewandelt werden. Dieser Parameter gibt die Größe der Karte im Canvas an, auf die die Koordinaten projiziert werden.

Kachelkoordinaten kommen in der API nur an einer Stelle vor, nämlich in der Signatur des Befehls **map slippy tile valid**. In allen anderen Fällen werden Punktkoordinaten verwendet.

Die Verwendung von Kachel-Koordinaten im Folgenden erleichtert es jedoch, die Struktur der Karte auf den verschiedenen *zoom*-Ebenen (Vergrößerungsfaktoren) zu erläutern.

Im Allgemeinen geben die ganzzahligen Anteile der Kachelkoordinaten die Zeilen- und Spaltennummer einer Kachel auf der Karte an, während die Bruchanteile angeben, wie weit innerhalb dieser Kachel sich der betreffende Ort befindet, wobei rein ganzzahlige Koordinaten (ohne Bruchanteil) die obere linke Ecke einer Kachel bezeichnen.

Der Nullpunkt der Karte befindet sich in der oberen linken Ecke, unabhängig vom Zoomfaktor, wobei größere Koordinaten nach rechts (Osten) und nach unten (Süden) verlaufen und kleinere Koordinaten nach links (Westen) und nach oben (Norden). Auch dies gilt unabhängig vom Zoomfaktor.

Negative Koordinaten sind nicht zulässig.

Bei der Zoomstufe **0** wird die gesamte Karte durch eine einzige Kachel dargestellt, wobei der geografische Nullpunkt bei den Kachel-Koordinaten bei 1/2, 1/2 liegt und der Bereich der Kachel-Koordinaten \[0...1\] beträgt.

Wenn man von der Zoomstufe **N** zur nächsttieferen (vergrößerten) Stufe wechselt (**N**+1) wird jede Kachel der Ebene **N** in ihre vier Quadranten unterteilt, die dann die Kacheln der Ebene **N**+1 bilden.

Das bedeutet, dass die Karte bei der Zoomstufe **N** (horizontal und vertikal) in **2^N** Zeilen und Spalten unterteilt wird, was insgesamt **4^N** Kacheln ergibt, wobei die Kachel-Koordinaten von **0** bis **2^N+1** reichen.

# API

**::map** **slippy geo box 2point** *zoom* *geobox*
: Der Befehl wandelt den geografischen Bereich *geobox* für die angegebene *zoom*-Stufe in einen Punktbereich auf dem Canvas um und gibt diesen Bereich zurück.

**::map** **slippy geo box center** *geobox*
: Der Befehl gibt den Mittelpunkt des geografischen Bereichs *geobox* zurück.

**::map** **slippy geo box corners** *geobox*
: Dieser Befehl gibt eine Liste zurück, die die vier Eckpunkte enthält, die durch den geografischen Rahmen *geobox* definiert sind. Die vier Punkte sind in dieser Reihenfolge: oben links, unten links, oben rechts und unten rechts.

**::map** **slippy geo box diameter** *geobox*
: Der Befehl gibt den Durchmesser des geografischen Bereichs *geobox* in Metern zurück.

**::map** **slippy geo box dimensions** *geobox*
: Der Befehl gibt die Abmessungen des geografischen Rahmens *geobox* zurück, und zwar in dieser Reihenfolge: Breite und Höhe.

**::map** **slippy geo box fit** *geobox* *canvdim* *zmax* ?*zmin*?
: Dieser Befehl berechnet den Zoomfaktor so, dass die *geobox* in einen durch *canvdim* vorgegebenen Ansichtsbereich passt (eine Liste mit zwei Elementen, die die Breite und Höhe des genannten Ansichtsbereichs enthalten), und gibt diesen Wert zurück. Der Zoomfaktor wird so angepasst, dass er innerhalb des Bereichs *zmin*…*zmax* liegt. Wenn *zmin* nicht angegeben wird, wird standardmäßig der Wert **0** verwendet.

**::map** **slippy geo box inside** *geobox* *geo*
: Der Befehl testet, ob der geografische Standort *geo* innerhalb des geografischen Bereichs *geobox* liegt oder nicht. Wenn dies der Fall ist, gibt er **true** zurück, andernfalls **false**.

**::map** **slippy geo box limit** *geobox*
: Dieser Befehl begrenzt den geografischen Bereich auf maximal 6 Dezimalstellen und gibt das Ergebnis zurück. Bei geografischen Koordinaten entsprechen 6 Dezimalstellen in etwa einem Grid von 11,1 cm.

**::map** **slippy geo box opposites** *geobox*
: Dieser Befehl gibt eine Liste zurück, die die beiden wichtigsten Eckpunkte enthält, die sich aus dem geografischen Rahmen *geobox* ergeben. Die beiden Punkte sind der obere linke und der untere rechte Punkt, in dieser Reihenfolge.

**::map** **slippy geo box perimeter** *geobox*
: Der Befehl gibt den Umfang des geografischen Bereichs *geobox* in Metern zurück.

**::map** **slippy geo box valid** *geobox*
: Dieser Befehl testet, ob das angegebene geografische Rechteck ausschließlich gültige Breiten- und Längengrade enthält. Er gibt den Wert **true** zurück, wenn das Rechteck gültig ist, andernfalls den Wert **false**.

**::map** **slippy geo box valid-list** *geoboxes*
: Dieser Befehl prüft, ob die Liste der geografischen Felder ausschließlich gültige Breiten- und Längengrade enthält. Er gibt den Wert **true** zurück, wenn alle Felder gültig sind, andernfalls den Wert **false**.

**::map** **slippy geo distance** *geo1* *geo2*
: Dieser Befehl berechnet die Großkreisdistanz zwischen den beiden geografischen Standorten in Metern und gibt diesen Wert zurück. Der Code basiert auf der Umsetzung der [Haversine-Formel](](https://en.wikipedia.org/wiki/Haversine_formula)) durch *https://wiki.tcl-lang.org/page/geodesy*.

**::map** **slippy geo distance\*** *closed* *geo*...
: Als Erweiterung von **map slippy geo distance** berechnet dieser Befehl die kumulative Entfernung entlang des durch die geordnete Menge geografischer Standorte festgelegten Pfads in Metern und gibt diese zurück. Wenn der Pfad als *closed* gekennzeichnet ist (d. h. ein Polygon/eine Schleife), enthält das Ergebnis zudem die Entfernung zwischen dem letzten und dem ersten Element des Pfads, sodass das Ergebnis der Umfang der durch die Standorte beschriebenen Fläche entspricht.

**::map** **slippy geo distance-list** *closed* *geo-list*
: Als Variante von **map slippy geo distance\*** verwendet dieser Befehl den Pfad zur Berechnung der Länge als eine einzige Liste geografischer Standorte anstelle einer variierenden Anzahl von Argumenten.

**::map** **slippy geo limit** *geo*
: Dieser Befehl begrenzt die geografische Position auf höchstens 6 Dezimalstellen und gibt das Ergebnis zurück. Bei geografischen Koordinaten entsprechen 6 Dezimalstellen in etwa einem Grid von 11,1 cm.

**::map** **slippy geo bbox** *geo*...
: ...siehe nächstes...

**::map** **slippy geo bbox-list** *geo-list*
: Diese beiden Befehle berechnen den Begrenzungsrahmen für die angegebene Menge geografischer Standorte und geben einen geografischen Rahmen zurück. Wenn keine geografischen Standorte angegeben werden, lautet der Rahmen „**0 0 0 0**“. Die Standorte werden entweder als eine variable Anzahl von Argumenten oder als einzelne Liste angegeben.

**::map** **slippy geo center** *geo*...
: ...siehe nächstes...

**::map** **slippy geo center-list** *geo-list*
: Diese beiden Befehle berechnen den Mittelpunkt des Begrenzungsrahmens für die angegebene Menge geografischer Standorte. Wenn keine geografischen Standorte angegeben werden, lautet der Mittelpunkt „**0 0**“. Die Standorte werden entweder als eine variable Anzahl von Argumenten oder als einzelne Liste angegeben.

**::map** **slippy geo diameter** *geo*...
: ...siehe nächstes...

**::map** **slippy geo diameter-list** *geo-list*
: Diese beiden Befehle berechnen den Durchmesser für die angegebene Menge geografischer Standorte in Metern. Der Durchmesser entspricht dem größten der paarweisen Abstände zwischen allen Standorten. Werden weniger als zwei geografische Standorte angegeben, lautet der Durchmesser „**0**“. Die Standorte werden entweder als eine variable Anzahl von Argumenten oder als einzelne Liste festgelegt.

**::map** **slippy geo 2point** *zoom* *geo*
: Dieser Befehl wandelt den geografischen Standort *geo* für die angegebene *zoom*-Stufe in einen Punkt auf dem Canvas um und gibt diesen Punkt zurück.

**::map** **slippy geo 2point\*** *zoom* *geo*...
: ...siehe nächstes...

**::map** **slippy geo 2point-list** *zoom* *geo-list*
: Diese beiden Befehle sind Erweiterungen von **map slippy geo 2point**, die eine Reihe von geografischen Standorten entweder als eine variable Anzahl von Argumenten oder als einzelne Liste entgegennehmen, diese alle gemäß der angegebenen *zoom*-Stufe in Punkte umwandeln und eine Liste der Ergebnisse gibt.

**::map** **slippy geo valid** *geo*
: Dieser Befehl prüft, ob der angegebene geografische Standort ausschließlich gültige Breiten- und Längengrade enthält. Er gibt den Wert **true** zurück, wenn der Standort gültig ist, andernfalls den Wert **false**.

**::map** **slippy geo valid-list** *geos*
: Dieser Befehl prüft, ob die Liste der geografischen Standorte ausschließlich gültige Breiten- und Längengrade enthält. Er gibt den Wert **true** zurück, wenn alle Standorte gültig sind, andernfalls den Wert **false**.

**::map** **slippy length** *level*
: Dieser Befehl gibt die Breite / Höhe einer auf „Slippy“ basierenden Karte bei der angegebenen Zoom-*level* in Pixeln zurück. Im Wesentlichen entspricht dies dem Ergebnis von


```
expr { [tiles $level] * [tile size] }
```

**::map** **slippy limit2** *x*
: ...siehe nächstes...

**::map** **slippy limit3** *x*
: ...siehe nächstes...

**::map** **slippy limit6** *x*
: Dieser Befehl begrenzt den Wert auf höchstens 2, 3 oder 6 Dezimalstellen und gibt das Ergebnis zurück. Bei geografischen Koordinaten entsprechen 6 Dezimalstellen in etwa einem Grid von 11,1 cm.

**::map** **slippy point box 2geo** *zoom* *pointbox*
: Der Befehl wandelt den Punktbereich *pointbox* entsprechend der angegebenen *zoom*-Stufe in einen geografischen Bereich auf dem canvas um und gibt diesen Bereich zurück.

**::map** **slippy point box center** *pointbox*
: Der Befehl gibt den Mittelpunkt der *pointbox* zurück.

**::map** **slippy point box corners** *pointbox*
: Dieser Befehl gibt eine Liste zurück, die die vier Eckpunkte enthält, die durch den Punktkasten *pointbox* definiert sind. Die vier Punkte sind in dieser Reihenfolge: oben links, unten links, oben rechts und unten rechts.

**::map** **slippy point box diameter** *pointbox*
: Der Befehl gibt den Durchmesser der *pointbox* in Pixeln zurück.

**::map** **slippy point box dimensions** *pointbox*
: Der Befehl gibt die Abmessungen der *pointbox* – Breite und Höhe – in dieser Reihenfolge zurück.

**::map** **slippy point box inside** *pointbox* *point*
: Der Befehl prüft, ob der *point* in der *pointbox* enthalten ist oder nicht. Wenn dies der Fall ist, gibt er **true** zurück, andernfalls **false**.

**::map** **slippy point box opposites** *pointbox*
: Dieser Befehl gibt eine Liste zurück, die die beiden Haupteckpunkte enthält, die durch den Punktkasten *pointbox* definiert sind. Die beiden Punkte sind in dieser Reihenfolge der obere linke und der untere rechte Punkt.

**::map** **slippy point box perimeter** *pointbox*
: Der Befehl gibt den Umfang der *pointbox* in Pixeln zurück.

**::map** **slippy point distance** *point1* *point2*
: Dieser Befehl berechnet den euklidischen Abstand zwischen den beiden Punkten in Pixeln und gibt diesen Wert zurück.

**::map** **slippy point distance\*** *closed* *point*...
: Als Erweiterung von **map slippy point distance** berechnet dieser Befehl die kumulative Entfernung entlang des durch die geordnete Punktmenge festgelegten Pfads und gibt diese zurück. Wenn der Pfad als *closed* markiert ist (d. h. ein Polygon/eine Schleife), enthält das Ergebnis zudem die Entfernung zwischen dem letzten und dem ersten Element des Pfads, sodass das Ergebnis der Umfang der durch die Standorte beschriebenen Fläche entspricht.

**::map** **slippy point distance-list** *closed* *point-list*
: Als Variante von **map slippy point distance\*** verwendet dieser Befehl den Pfad zur Berechnung der Länge als einzelne Liste von Punkten anstelle einer variierenden Anzahl von Argumenten.

**::map** **slippy point bbox** *point*...
: ...siehe nächstes...

**::map** **slippy point bbox-list** *point-list*
: Diese beiden Befehle berechnen den Begrenzungsrahmen für die angegebene Punktmenge und geben einen Punktkasten zurück. Wenn keine Punkte angegeben werden, lautet der Kasten „**0 0 0 0**“. Die Positionen werden entweder als eine variable Anzahl von Argumenten oder als einzelne Liste angegeben.

**::map** **slippy point center** *point*...
: ...siehe nächstes...

**::map** **slippy point center-list** *point-list*
: Diese beiden Befehle berechnen den Mittelpunkt des Begrenzungsrahmens für die angegebene Punktmenge. Wenn keine Punkte angegeben werden, lautet der Mittelpunkt „**0 0**“. Die Positionen werden entweder als eine variable Anzahl von Argumenten oder als einzelne Liste angegeben.

**::map** **slippy point diameter** *point*...
: ...siehe nächstes...

**::map** **slippy point diameter-list** *point-list*
: Dieser Befehl berechnet den Durchmesser der angegebenen Punktmenge in Pixeln. Der Durchmesser entspricht dem größten der paarweisen Abstände zwischen allen Positionen. Werden weniger als zwei Punkte angegeben, lautet der Durchmesser „**0**“. Die Positionen werden entweder als eine variable Anzahl von Argumenten oder als einzelne Liste angegeben.

**::map** **slippy point 2geo** *zoom* *point*
: Dieser Befehl wandelt den *point* auf dem canvas bei der angegebenen *zoom* in einen geografischen Standort um und gibt diesen Standort zurück.

**::map** **slippy point 2geo\*** *zoom* *point*...
: ...siehe nächstes...

**::map** **slippy point 2geo-list** *zoom* *point-list*
: Diese beiden Befehle sind Erweiterungen von **map slippy point 2geo**, die eine Reihe von Punkten entweder als eine variable Anzahl von Argumenten oder als eine einzige Liste entgegennehmen, diese alle entsprechend der angegebenen *zoom*-Stufe in geografische Standorte umwandeln und eine Liste der Ergebnisse gibt.

**::map** **slippy point simplify radial** *threshold* *point-list*
: Dieser Befehl nimmt eine Punktfolge (als einzelne Liste) entgegen, vereinfacht diesen Pfad mithilfe des Algorithmus „*Radial Distance*“ und gibt den vereinfachten Pfad als Liste zurück. Im Wesentlichen behält der Algorithmus von benachbarten Punkten nur denjenigen bei, der näher an diesem ersten Punkt liegt als der festgelegte Schwellenwert, und verwirft die übrigen.

**::map** **slippy point simplify rdp** *point-list*
: Dieser Befehl nimmt eine Punktgruppe (als einzelne Liste) entgegen, vereinfacht diese mithilfe des *nichtparametrischen* *Ramer-Douglas-Peucker*-Algorithmus und gibt den vereinfachten Pfad als Liste von Punkten zurück.

**::map** **slippy pretty-distance** *x*
: Diese Methode formatiert die Entfernung *x* (in Metern) für die Anzeige und gibt die resultierende Zeichenfolge (einschließlich der gewählten Einheit) zurück. Entfernungen im Subkilometerbereich werden auf zwei Dezimalstellen begrenzt, d. h. auf Zentimeter, während Entfernungen im Kilometerbereich auf drei Dezimalstellen begrenzt werden, d. h. auf Meter.

**::map** **slippy tiles** *level*
: Dieser Befehl gibt die Breite / Höhe einer auf Slippy basierenden Karte bei der angegebenen Zoomstufe *level* zurück, in *Kacheln*.

**::map** **slippy tile size**
: Dieser Befehl gibt die Breite / Höhe einer Kachel in einer auf „Slippy“ basierenden Karte in Pixeln zurück.

**::map** **slippy tile valid** *zoom* *row* *column* *levels* ?*msgvar*?
: Dieser Befehl prüft, ob die durch *zoom*, *row* und *column* beschriebene Kachel für eine auf „Slippy“ basierende Karte mit dieser Anzahl an Zoom-*levels* gültig ist oder nicht. Das Ergebnis ist ein boolescher Wert: **true**, wenn die Kachel gültig ist, und **false** andernfalls. Im letzteren Fall wird eine Meldung in der durch *msgvar* benannten Variable hinterlassen, sofern diese festgelegt wurde.

**::map** **slippy valid latitude** *x*
: Dieser Befehl testet, ob das Argument *x* ein gültiger Breitengradwert ist, und gibt das boolesche Ergebnis dieser Prüfung zurück. Das heißt, **true**, wenn der Wert gültig ist, und andernfalls **false**.

**::map** **slippy valid longitude** *x*
: Dieser Befehl testet, ob das Argument *x* ein gültiger Längengradwert ist, und gibt das boolesche Ergebnis dieser Prüfung zurück. Das heißt, **true**, wenn der Wert gültig ist, und **false** andernfalls.


# LITERATUR

**\[1\]**
: *http://wiki.openstreetmap.org/wiki/Main_Page*
