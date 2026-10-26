---
CommandName: math::geometry
title: math::geometry
ManualSection: n
Version: 1.4.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - angle
 - distance
 - line
 - math
 - plane geometry
 - point
Copyright:
 - Copyright (c) 2001 by Ideogramic ApS and other parties
 - Copyright (c) 2010 by Andreas Kupries
 - Copyright (c) 2010 by Kevin Kenny
 - Copyright (c) 2018 by Arjen Markus
 - Copyright (c) 2020 by Manfred Rosenberger
---

# Name

math::geometry – Geometrische Berechnungen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::geometry]{.lit} [1.4.2]{.optlit}
[::math::geometry::+]{.cmd} [point1]{.arg} [point2]{.arg}
[::math::geometry::-]{.cmd} [point1]{.arg} [point2]{.arg}
[::math::geometry::p]{.cmd} [x]{.arg} [y]{.arg}
[::math::geometry::distance]{.cmd} [point1]{.arg} [point2]{.arg}
[::math::geometry::length]{.cmd} [point]{.arg}
[::math::geometry::s\*]{.cmd} [factor]{.arg} [point]{.arg}
[::math::geometry::direction]{.cmd} [angle]{.arg}
[::math::geometry::h]{.cmd} [length]{.arg}
[::math::geometry::v]{.cmd} [length]{.arg}
[::math::geometry::between]{.cmd} [point1]{.arg} [point2]{.arg} [s]{.arg}
[::math::geometry::octant]{.cmd} [point]{.arg}
[::math::geometry::rect]{.cmd} [nw]{.arg} [se]{.arg}
[::math::geometry::nwse]{.cmd} [rect]{.arg}
[::math::geometry::angle]{.cmd} [line]{.arg}
[::math::geometry::angleBetween]{.cmd} [vector1]{.arg} [vector2]{.arg}
[::math::geometry::inproduct]{.cmd} [vector1]{.arg} [vector2]{.arg}
[::math::geometry::areaParallellogram]{.cmd} [vector1]{.arg} [vector2]{.arg}
[::math::geometry::calculateDistanceToLine]{.cmd} [P]{.arg} [line]{.arg}
[::math::geometry::calculateDistanceToLineSegment]{.cmd} [P]{.arg} [linesegment]{.arg}
[::math::geometry::calculateDistanceToPolyline]{.cmd} [P]{.arg} [polyline]{.arg}
[::math::geometry::calculateDistanceToPolygon]{.cmd} [P]{.arg} [polygon]{.arg}
[::math::geometry::findClosestPointOnLine]{.cmd} [P]{.arg} [line]{.arg}
[::math::geometry::findClosestPointOnLineSegment]{.cmd} [P]{.arg} [linesegment]{.arg}
[::math::geometry::findClosestPointOnPolyline]{.cmd} [P]{.arg} [polyline]{.arg}
[::math::geometry::lengthOfPolyline]{.cmd} [polyline]{.arg}
[::math::geometry::movePointInDirection]{.cmd} [P]{.arg} [direction]{.arg} [dist]{.arg}
[::math::geometry::lineSegmentsIntersect]{.cmd} [linesegment1]{.arg} [linesegment2]{.arg}
[::math::geometry::findLineSegmentIntersection]{.cmd} [linesegment1]{.arg} [linesegment2]{.arg}
[::math::geometry::findLineIntersection]{.cmd} [line1]{.arg} [line2]{.arg}
[::math::geometry::polylinesIntersect]{.cmd} [polyline1]{.arg} [polyline2]{.arg}
[::math::geometry::polylinesBoundingIntersect]{.cmd} [polyline1]{.arg} [polyline2]{.arg} [granularity]{.arg}
[::math::geometry::intervalsOverlap]{.cmd} [y1]{.arg} [y2]{.arg} [y3]{.arg} [y4]{.arg} [strict]{.arg}
[::math::geometry::rectanglesOverlap]{.cmd} [P1]{.arg} [P2]{.arg} [Q1]{.arg} [Q2]{.arg} [strict]{.arg}
[::math::geometry::bbox]{.cmd} [polyline]{.arg}
[::math::geometry::overlapBBox]{.cmd} [polyline1]{.arg} [polyline2]{.arg} [strict]{.optarg}
[::math::geometry::pointInsideBBox]{.cmd} [bbox]{.arg} [point]{.arg}
[::math::geometry::cathetusPoint]{.cmd} [pa]{.arg} [pb]{.arg} [cathetusLength]{.arg} [location]{.optarg}
[::math::geometry::parallel]{.cmd} [line]{.arg} [offset]{.arg} [orient]{.optarg}
[::math::geometry::unitVector]{.cmd} [line]{.arg}
[::math::geometry::pointInsidePolygon]{.cmd} [P]{.arg} [polyline]{.arg}
[::math::geometry::pointInsidePolygonAlt]{.cmd} [P]{.arg} [polyline]{.arg}
[::math::geometry::rectangleInsidePolygon]{.cmd} [P1]{.arg} [P2]{.arg} [polyline]{.arg}
[::math::geometry::areaPolygon]{.cmd} [polygon]{.arg}
[::math::geometry::translate]{.cmd} [vector]{.arg} [polyline]{.arg}
[::math::geometry::rotate]{.cmd} [angle]{.arg} [polyline]{.arg}
[::math::geometry::rotateAbout]{.cmd} [p]{.arg} [angle]{.arg} [polyline]{.arg}
[::math::geometry::reflect]{.cmd} [angle]{.arg} [polyline]{.arg}
[::math::geometry::degToRad]{.cmd} [angle]{.arg}
[::math::geometry::radToDeg]{.cmd} [angle]{.arg}
[::math::geometry::circle]{.cmd} [centre]{.arg} [radius]{.arg}
[::math::geometry::circleTwoPoints]{.cmd} [point1]{.arg} [point2]{.arg}
[::math::geometry::pointInsideCircle]{.cmd} [point]{.arg} [circle]{.arg}
[::math::geometry::lineIntersectsCircle]{.cmd} [line]{.arg} [circle]{.arg}
[::math::geometry::lineSegmentIntersectsCircle]{.cmd} [segment]{.arg} [circle]{.arg}
[::math::geometry::intersectionLineWithCircle]{.cmd} [line]{.arg} [circle]{.arg}
[::math::geometry::intersectionCircleWithCircle]{.cmd} [circle1]{.arg} [circle2]{.arg}
[::math::geometry::tangentLinesToCircle]{.cmd} [point]{.arg} [circle]{.arg}
[::math::geometry::intersectionPolylines]{.cmd} [polyline1]{.arg} [polyline2]{.arg} [mode]{.optarg} [granularity]{.optarg}
[::math::geometry::intersectionPolylineCircle]{.cmd} [polyline]{.arg} [circle]{.arg} [mode]{.optarg} [granularity]{.optarg}
[::math::geometry::polylineCutOrigin]{.cmd} [polyline1]{.arg} [polyline2]{.arg} [granularity]{.optarg}
[::math::geometry::polylineCutEnd]{.cmd} [polyline1]{.arg} [polyline2]{.arg} [granularity]{.optarg}
[::math::geometry::splitPolyline]{.cmd} [polyline]{.arg} [numberVertex]{.arg}
[::math::geometry::enrichPolyline]{.cmd} [polyline]{.arg} [accuracy]{.arg}
[::math::geometry::cleanupPolyline]{.cmd} [polyline]{.arg}
:::

# Beschreibung

Das Paket **math::geometry** ist eine Sammlung von Funktionen für Berechnungen und Bearbeitungen an zweidimensionalen geometrischen Objekten wie Punkten, Geraden und Polygonen.

Die geometrischen Objekte werden als einfache Listen von Koordinaten implementiert. So wird beispielsweise eine Gerade durch eine Liste von vier Zahlen definiert, nämlich die x- und y-Koordinaten eines ersten Punktes sowie die x- und y-Koordinaten eines zweiten Punktes auf dieser Geraden.

*Hinweis:* In Version 1.4.0 wurde eine Unstimmigkeit behoben – siehe <https://core.tcl-lang.org/tcllib/tktview?name=fb4812f82b>. Weitere Informationen finden Sie im Abschnitt [Koordinatensystem]

Die verschiedenen Objekttypen werden an der Anzahl der Koordinatenpaare und am Kontext, in dem sie verwendet werden, erkannt: Eine Liste mit vier Elementen kann als unendliche Gerade, als endliche Strecke, aber auch als Polylinie mit einem Segment oder als Punktmenge mit zwei Punkten betrachtet werden.

Derzeit werden folgende Objekttypen unterschieden:

- *point* (Punkt) – eine Liste mit zwei Koordinaten, die die x- bzw. die y-Koordinate darstellen.

- *line* (Gerade) – eine Liste mit vier Koordinaten, die als x- und y-Koordinaten zweier unterschiedlicher Punkte auf der Geraden interpretiert werden.

- *line segment* (Strecke) – eine Liste mit vier Koordinaten, die als x- und y-Koordinaten des ersten und des letzten Punktes der Strecke interpretiert werden.

- *polyline* (Polylinie) – eine Liste mit einer geraden Anzahl von Koordinaten, die als x- und y-Koordinaten einer geordneten Punktmenge interpretiert werden.

- *polygon* (Polygon) – ähnlich wie eine Polylinie, wobei jedoch implizit davon ausgegangen wird, dass die Polylinie geschlossen ist (wenn der erste und der letzte Punkt nicht zusammenfallen, wird das fehlende Segment automatisch hinzugefügt).

- *point set* (Punktmenge) – wiederum eine Liste mit einer geraden Anzahl von Koordinaten, wobei die Punkte jedoch ohne bestimmte Reihenfolge betrachtet werden.

- *circle* (Kreis) – eine Liste mit drei Zahlen, wobei die ersten beiden die Koordinaten des Mittelpunkts sind und die dritte der Radius ist.


# Prozeduren

Das Paket definiert die folgenden öffentlichen Prozeduren:

**::math::geometry::+** *point1* *point2*
: Berechnet die Summe der beiden als Punkte angegebenen Vektoren und gibt sie zurück. Das Ergebnis ist ebenfalls ein Vektor.

**::math::geometry::-** *point1* *point2*
: Berechnet die Differenz (point1 - point2) der beiden als Punkte angegebenen Vektoren und gibt sie zurück. Das Ergebnis ist ebenfalls ein Vektor.

**::math::geometry::p** *x* *y*
: Erstellt einen Punkt aus seinen Koordinaten und gibt ihn als Ergebnis des Befehls zurück.

**::math::geometry::distance** *point1* *point2*
: Berechnet den Abstand zwischen den beiden Punkten und gibt ihn als Ergebnis des Befehls zurück. Dies entspricht im Wesentlichen

    ```
        math::geometry::length [math::geomtry::- point1 point2]
    ```

**::math::geometry::length** *point*
: Berechnet die Länge des Vektors und gibt sie als Ergebnis des Befehls zurück.

**::math::geometry::s\*** *factor* *point*
: Skaliert den Vektor mit dem Faktor und gibt ihn als Ergebnis des Befehls zurück. Auch hierbei handelt es sich um einen Vektor.

**::math::geometry::direction** *angle*
: Bei Angabe des Winkels in Grad berechnet dieser Befehl den Einheitsvektor, der in diese Richtung zeigt, und gibt ihn zurück. Der Vektor für angle == 0 zeigt nach rechts (Osten), der für angle == 90 nach oben (Norden).

**::math::geometry::h** *length*
: Gibt einen horizontalen Vektor auf der X-Achse mit der festgelegten Länge zurück. Positive Längen weisen nach rechts (Osten).

**::math::geometry::v** *length*
: Gibt einen vertikalen Vektor auf der Y-Achse mit der festgelegten Länge zurück. Positive Längen weisen nach unten (Süden).

**::math::geometry::between** *point1* *point2* *s*
: Berechnet den Punkt, der sich im relativen Abstand *s* zwischen den beiden Punkten befindet, und gibt ihn als Ergebnis des Befehls zurück. Ein relativer Abstand von **0** liefert *point1*, der Abstand **1** liefert *point2*. Bei Abständen < 0 oder > 1 erfolgt eine Extrapolation entlang der Verbindungslinie zwischen den beiden Punkten.

**::math::geometry::octant** *point*
: Berechnet den Oktanten des Kreises, in dem sich der Punkt befindet, und gibt ihn als Ergebnis des Befehls zurück. Die möglichen Ergebnisse sind

    1. Osten

    2. Nordosten

    3. Norden

    4. Nordwesten

    5. Westen

    6. Südwesten

    7. Süden

    8. Südosten


    Jeder Oktant ist der Kreisbogen von +/- 22,5 Grad um die Himmelsrichtung, nach der der Oktant seinen Namen hat.

**::math::geometry::rect** *nw* *se*
: Erstellt ein Rechteck aus seiner nordwestlichen und südöstlichen Ecke und gibt es als Ergebnis des Befehls zurück.

**::math::geometry::nwse** *rect*
: Ermittelt die nordwestliche und die südöstliche Ecke des Rechtecks und gibt sie als Ergebnis des Befehls zurück (eine Liste mit zwei Elementen, die die Punkte in der angegebenen Reihenfolge enthält).

**::math::geometry::angle** *line*
: Berechnet den Winkel von der positiven x-Achse zu einer gegebenen Geraden (nur in zwei Dimensionen).

    list *line*
    : Koordinaten der Geraden


**::math::geometry::angleBetween** *vector1* *vector2*
: Berechnet den Winkel zwischen zwei Vektoren (in Grad)

    list *vector1*
    : Erster Vektor

    list *vector2*
    : Zweiter Vektor


**::math::geometry::inproduct** *vector1* *vector2*
: Berechnet das Skalarprodukt zweier Vektoren

    list *vector1*
    : Erster Vektor

    list *vector2*
    : Zweiter Vektor


**::math::geometry::areaParallellogram** *vector1* *vector2*
: Berechnet die Fläche des Parallelogramms, das die beiden Vektoren als Seiten hat

    list *vector1*
    : Erster Vektor

    list *vector2*
    : Zweiter Vektor


**::math::geometry::calculateDistanceToLine** *P* *line*
: Berechnet den Abstand des Punktes P zur (unendlichen) Geraden und gibt das Ergebnis zurück

    list *P*
    : Liste mit zwei Zahlen, den Koordinaten des Punktes

    list *line*
    : Liste mit vier Zahlen, die Koordinaten zweier Punkte auf der Geraden


**::math::geometry::calculateDistanceToLineSegment** *P* *linesegment*
: Berechnet den Abstand des Punktes P zur (endlichen) Strecke und gibt das Ergebnis zurück.

    list *P*
    : Liste mit zwei Zahlen, den Koordinaten des Punktes

    list *linesegment*
    : Liste mit vier Zahlen, den Koordinaten des ersten und des letzten Punktes der Strecke


**::math::geometry::calculateDistanceToPolyline** *P* *polyline*
: Berechnet den Abstand des Punktes P zur Polylinie und gibt das Ergebnis zurück. Hinweis: Eine Polylinie muss nicht geschlossen sein.

    list *P*
    : Liste mit zwei Zahlen, den Koordinaten des Punktes

    list *polyline*
    : Liste von Zahlen, die die Koordinaten der Eckpunkte der Polylinie darstellen


**::math::geometry::calculateDistanceToPolygon** *P* *polygon*
: Berechnet den Abstand des Punktes P zum Polygon und gibt das Ergebnis zurück. Wenn die Liste der Koordinaten nicht geschlossen ist (erster und letzter Punkt unterscheiden sich), wird sie automatisch geschlossen.

    list *P*
    : Liste mit zwei Zahlen, den Koordinaten des Punktes

    list *polygon*
    : Liste von Zahlen, den Koordinaten der Eckpunkte des Polygons


**::math::geometry::findClosestPointOnLine** *P* *line*
: Gibt den Punkt auf einer Geraden zurück, der einem vorgegebenen Punkt am nächsten liegt.

    list *P*
    : Liste mit zwei Zahlen, den Koordinaten des Punktes

    list *line*
    : Liste mit vier Zahlen, die Koordinaten zweier Punkte auf der Geraden


**::math::geometry::findClosestPointOnLineSegment** *P* *linesegment*
: Gibt den Punkt auf einer *Strecke* zurück, der einem vorgegebenen Punkt am nächsten liegt.

    list *P*
    : Liste mit zwei Zahlen, den Koordinaten des Punktes

    list *linesegment*
    : Liste mit vier Zahlen, dem ersten und dem letzten Punkt der Strecke


**::math::geometry::findClosestPointOnPolyline** *P* *polyline*
: Gibt den Punkt auf einer Polylinie *polyline* zurück, der einem vorgegebenen Punkt am nächsten liegt.

    list *P*
    : Liste mit zwei Zahlen, den Koordinaten des Punktes

    list *polyline*
    : Liste von Zahlen, den Eckpunkten der Polylinie


**::math::geometry::lengthOfPolyline** *polyline*
: Gibt die Länge der Polylinie *polyline* zurück (Hinweis: Sie wird nicht als Polygon betrachtet)

    list *polyline*
    : Liste von Zahlen, den Eckpunkten der Polylinie


**::math::geometry::movePointInDirection** *P* *direction* *dist*
: Verschiebt einen Punkt um einen gegebenen Abstand in eine gegebene Richtung und gibt die neuen Koordinaten zurück (nur in zwei Dimensionen).

    list *P*
    : Koordinaten des zu verschiebenden Punktes

    double *direction*
    : Richtung (in Grad; 0 ist nach rechts, 90 nach oben)

    list *dist*
    : Entfernung, um die der Punkt verschoben werden soll


**::math::geometry::lineSegmentsIntersect** *linesegment1* *linesegment2*
: Prüft, ob sich zwei Strecken schneiden oder zusammenfallen. Gibt 1 zurück, wenn dies der Fall ist, andernfalls 0 (nur in zwei Dimensionen). Liegt ein Endpunkt einer Strecke auf der anderen Strecke (oder sehr nahe daran), gelten sie als sich schneidend.

    list *linesegment1*
    : Erste Strecke

    list *linesegment2*
    : Zweite Strecke


**::math::geometry::findLineSegmentIntersection** *linesegment1* *linesegment2*
: Ermittelt den Schnittpunkt zweier Strecken. Gibt die Koordinaten zurück oder die Schlüsselwörter "coincident" bzw. "none", wenn die Strecken zusammenfallen oder keine gemeinsamen Punkte haben (nur in zwei Dimensionen).

    list *linesegment1*
    : Erste Strecke

    list *linesegment2*
    : Zweite Strecke


**::math::geometry::findLineIntersection** *line1* *line2*
: Ermittelt den Schnittpunkt zweier (unendlicher) Geraden. Gibt die Koordinaten zurück oder die Schlüsselwörter "coincident" bzw. "none", wenn die Geraden zusammenfallen oder keine gemeinsamen Punkte haben (nur in zwei Dimensionen).

    list *line1*
    : Erste Gerade

    list *line2*
    : Zweite Gerade


    Einzelheiten zum Algorithmus und zur zugrunde liegenden Mathematik finden Sie im Abschnitt [Literatur].

**::math::geometry::polylinesIntersect** *polyline1* *polyline2*
: Prüft, ob sich zwei Polylinien schneiden oder nicht (nur in zwei Dimensionen).

    list *polyline1*
    : Erste Polylinie

    list *polyline2*
    : Zweite Polylinie


**::math::geometry::polylinesBoundingIntersect** *polyline1* *polyline2* *granularity*
: Prüft, ob sich zwei Polylinien schneiden, wobei die Genauigkeit des Ergebnisses auf die angegebene Granularität beschränkt wird. Verwenden Sie diese Prozedur für eine schnellere, jedoch weniger genaue Schnittprüfung.

    Funktionsweise:

    Jede Polylinie wird in eine Reihe kleinerer Polylinien unterteilt, die jeweils aus *granularity* Punkten bestehen. Wenn sich die umschließenden Rechtecke eines Paares dieser kleineren Linien schneiden, gibt diese Prozedur 1 zurück, andernfalls 0.

    list *polyline1*
    : Erste Polylinie

    list *polyline2*
    : Zweite Polylinie

    int *granularity*
    : Anzahl der Punkte in jedem Teil (<=1 bedeutet, dass jede Kante überprüft wird)


**::math::geometry::intervalsOverlap** *y1* *y2* *y3* *y4* *strict*
: Prüft, ob sich zwei Intervalle überlappen.

    double *y1,y2*
    : Beginn und Ende des ersten Intervalls

    double *y3,y4*
    : Beginn und Ende des zweiten Intervalls

    logical *strict*
    : Prüft auf strenge oder nicht strenge Überlappung


**::math::geometry::rectanglesOverlap** *P1* *P2* *Q1* *Q2* *strict*
: Prüft, ob sich zwei Rechtecke überlappen.

    list *P1*
    : obere linke Ecke des ersten Rechtecks

    list *P2*
    : untere rechte Ecke des ersten Rechtecks

    list *Q1*
    : obere linke Ecke des zweiten Rechtecks

    list *Q2*
    : untere rechte Ecke des zweiten Rechtecks

    list *strict*
    : Wahl zwischen strenger und nicht strenger Auslegung


**::math::geometry::bbox** *polyline*
: Berechnet das umschließende Rechteck einer Polylinie. Gibt eine Liste mit vier Koordinaten zurück: die obere linke und die untere rechte Ecke des Rechtecks.

    list *polyline*
    : Die zu untersuchende Polylinie


**::math::geometry::overlapBBox** *polyline1* *polyline2* ?strict?
: Prüft, ob sich die umschließenden Rechtecke zweier Polylinien überlappen oder nicht.

    Argumente:

    list *polyline1*
    : Die erste Polylinie

    list *polyline1*
    : Die zweite Polylinie

    int *strict*
    : Ob auf strenge Überlappung geprüft werden soll (1) oder ob sich die umschließenden Rechtecke berühren dürfen (0, Standard)


**::math::geometry::pointInsideBBox** *bbox* *point*
: Prüft, ob sich der Punkt innerhalb oder auf dem Rand des umschließenden Rechtecks befindet oder nicht. Argumente:

    list *bbox*
    : Das umschließende Rechteck als Liste von x/y-Koordinaten

    list *point*
    : Der zu prüfende Punkt


**::math::geometry::cathetusPoint** *pa* *pb* *cathetusLength* ?location?
: Gibt den dritten Punkt des rechtwinkligen Dreiecks zurück, das durch die beiden angegebenen Endpunkte der Hypotenuse definiert ist. Die Seite des Dreiecks vom Punkt A (oder B, wenn als Lage "b" angegeben ist) bis zum dritten Punkt hat die Länge der Kathete. Ist die Länge der Kathete größer als die Länge der Hypotenuse, wird eine leere Liste zurückgegeben.

    Argumente:

    list *pa*
    : Der Ausgangspunkt auf der Hypotenuse

    list *pb*
    : Der Endpunkt auf der Hypotenuse

    float *cathetusLength*
    : Die Länge der Kathete des Dreiecks

    string *location*
    : Die Lage der angegebenen Kathete: "a" bedeutet, dass die angegebene Kathete den Punkt pa enthält (Standard), "b" bedeutet, dass die angegebene Kathete den Punkt pb enthält.


**::math::geometry::parallel** *line* *offset* ?orient?
: Gibt eine zur angegebenen Geraden parallele Gerade im Abstand "offset" zurück. Die Ausrichtung wird durch die beiden Punkte bestimmt, die die Gerade definieren.

    Argumente:

    list *line*
    : Die angegebene Gerade

    float *offset*
    : Der Abstand zur angegebenen Geraden

    string *orient*
    : Ausrichtung der neuen Geraden relativ zur angegebenen Geraden (Standardwert: "right")


**::math::geometry::unitVector** *line*
: Gibt einen Einheitsvektor zur angegebenen Geraden zurück, oder zur Richtung, wenn das Argument *line* ein einzelner Punkt ist (dann wird eine Gerade durch den Ursprung angenommen). Argumente:

    list *line*
    : Die betreffende Gerade (oder ein einzelner Punkt, was eine Gerade durch den Ursprung impliziert)


**::math::geometry::pointInsidePolygon** *P* *polyline*
: Stellt fest, ob sich ein Punkt vollständig innerhalb eines Polygons befindet. Wenn der Punkt das Polygon berührt, so befindet er sich nicht vollständig innerhalb des Polygons.

    list *P*
    : Koordinaten des Punktes

    list *polyline*
    : Die zu untersuchende Polylinie


**::math::geometry::pointInsidePolygonAlt** *P* *polyline*
: Stellt fest, ob sich ein Punkt vollständig innerhalb eines Polygons befindet. Wenn der Punkt das Polygon berührt, so befindet er sich nicht vollständig innerhalb des Polygons. *Hinweis:* Diese alternative Prozedur nutzt dafür die sogenannte Windungszahl. Sie behandelt sich selbst schneidende Polygone auf „natürliche“ Weise.

    list *P*
    : Koordinaten des Punktes

    list *polyline*
    : Die zu untersuchende Polylinie


**::math::geometry::rectangleInsidePolygon** *P1* *P2* *polyline*
: Stellt fest, ob sich ein Rechteck vollständig innerhalb eines Polygons befindet. Berührt das Polygon das Rechteck, so befindet sich das Rechteck nicht vollständig innerhalb des Polygons.

    list *P1*
    : Obere linke Ecke des Rechtecks

    list *P2*
    : Untere rechte Ecke des Rechtecks

    list *polygon*
    : Das betreffende Polygon


**::math::geometry::areaPolygon** *polygon*
: Berechnet die Fläche eines Polygons.

    list *polygon*
    : Das betreffende Polygon


**::math::geometry::translate** *vector* *polyline*
: Verschiebt eine Polylinie um einen gegebenen Vektor

    list *vector*
    : Verschiebungsvektor

    list *polyline*
    : Die zu verschiebende Polylinie


**::math::geometry::rotate** *angle* *polyline*
: Dreht eine Polylinie um einen gegebenen Winkel (in Grad) um den Ursprung

    list *angle*
    : Winkel, um den die Polylinie gedreht werden soll (Grad)

    list *polyline*
    : Die zu drehende Polylinie


**::math::geometry::rotateAbout** *p* *angle* *polyline*
: Dreht eine Polylinie um einen gegebenen Punkt p und gibt die neue Polylinie zurück.

    Argumente:

    list *p*
    : Der Drehpunkt

    float *angle*
    : Der Winkel, um den die Polylinie gedreht werden soll (Grad)

    list *polyline*
    : Die zu drehende Polylinie


**::math::geometry::reflect** *angle* *polyline*
: Spiegelt eine Polylinie an einer Geraden durch den Ursprung, die einen gegebenen Winkel (in Grad) mit der x-Achse bildet

    list *angle*
    : Winkel der Spiegelachse (Grad)

    list *polyline*
    : Die zu spiegelnde Polylinie


**::math::geometry::degToRad** *angle*
: Rechnet von Grad in Radiant um

    list *angle*
    : Winkel in Grad


**::math::geometry::radToDeg** *angle*
: Rechnet von Radiant in Grad um

    list *angle*
    : Winkel in Radiant


**::math::geometry::circle** *centre* *radius*
: Hilfsprozedur, die einen Kreis aus einem Punkt und einem Radius erstellt.

    list *centre*
    : Koordinaten des Kreismittelpunkts

    list *radius*
    : Radius des Kreises


**::math::geometry::circleTwoPoints** *point1* *point2*
: Hilfsprozedur, die einen Kreis aus zwei Punkten auf seinem Umfang erstellt. Der Mittelpunkt ist der Punkt zwischen den beiden gegebenen Punkten, der Radius entspricht der Hälfte des Abstands zwischen diesen beiden Punkten.

    list *point1*
    : Erster Punkt

    list *point2*
    : Zweiter Punkt


**::math::geometry::pointInsideCircle** *point* *circle*
: Stellt fest, ob der angegebene Punkt innerhalb des Kreises oder auf dem Kreisumfang liegt (1) oder außerhalb (0).

    list *point*
    : Zu prüfender Punkt

    list *circle*
    : Ein Kreis, der den Punkt enthalten kann oder auch nicht


**::math::geometry::lineIntersectsCircle** *line* *circle*
: Stellt fest, ob die angegebene Gerade den Kreis schneidet oder ihn berührt (1) oder nicht (0).

    list *line*
    : Zu prüfende Gerade

    list *circle*
    : Kreis, der möglicherweise geschnitten wird oder auch nicht


**::math::geometry::lineSegmentIntersectsCircle** *segment* *circle*
: Stellt fest, ob die angegebene Strecke den Kreis schneidet oder ihn berührt (1) oder nicht (0).

    list *segment*
    : Zu prüfende Strecke

    list *circle*
    : Kreis, der möglicherweise geschnitten wird oder auch nicht


**::math::geometry::intersectionLineWithCircle** *line* *circle*
: Bestimmt die Punkte, an denen die angegebene Gerade den Kreis schneidet. Es kann null, ein oder zwei Punkte geben. (Wenn die Gerade den Kreis berührt oder ihm sehr nahe kommt, wird ein Punkt zurückgegeben. Zur Erkennung dieses Falls wird eine willkürlich gewählte Toleranz von 1.0e-10 mal dem Radius verwendet.)

    list *line*
    : Zu prüfende Gerade

    list *circle*
    : Kreis, der möglicherweise geschnitten wird oder auch nicht


**::math::geometry::intersectionCircleWithCircle** *circle1* *circle2*
: Bestimmt die Schnittpunkte der beiden angegebenen Kreise. Es kann null, ein oder zwei Schnittpunkte geben. (Wenn sich die beiden Kreise berühren oder sehr nahe kommen, wird ein Punkt zurückgegeben. Zur Erkennung dieses Falls wird eine willkürlich gewählte Toleranz von 1.0e-10 mal dem Mittelwert der Radien der beiden Kreise verwendet.)

    list *circle1*
    : Erster Kreis

    list *circle2*
    : Zweiter Kreis


**::math::geometry::tangentLinesToCircle** *point* *circle*
: Ermittelt die Tangenten vom angegebenen Punkt an den Kreis. Es kann null, eine oder zwei Geraden geben. (Wenn der Punkt auf dem Kreisumfang oder sehr nahe am Kreis liegt, wird eine Gerade zurückgegeben. Zur Erkennung dieses Falls wird eine willkürlich gewählte Toleranz von 1.0e-10 mal dem Kreisradius verwendet.)

    list *point*
    : Der betreffende Punkt

    list *circle*
    : Kreis, für den die Tangenten bestimmt werden sollen


**::math::geometry::intersectionPolylines** *polyline1* *polyline2* ?mode? ?granularity?
: Gibt den ersten Punkt oder alle Punkte zurück, an denen sich die beiden Polylinien schneiden. Wenn die Anzahl der Punkte in den Polylinien groß ist, können Sie die Granularität nutzen, um schneller ein Näherungsergebnis zu erhalten.

    Argumente:

    list *polyline1*
    : Die erste Polylinie

    list *polyline2*
    : Die zweite Polylinie

    string *mode*
    : Ob nur der erste (Standard) oder alle Schnittpunkte ("all") zurückgegeben werden sollen

    int *granularity*
    : Die Anzahl der Punkte, die bei der Suche nach Schnittpunkten übersprungen werden, zuzüglich 1 (ein Wert von 1 oder kleiner bedeutet, dass ein exaktes Ergebnis zurückgegeben wird)


**::math::geometry::intersectionPolylineCircle** *polyline* *circle* ?mode? ?granularity?
: Gibt den ersten Punkt oder alle Punkte zurück, an denen die Polylinie den Kreis schneidet. Wenn die Anzahl der Punkte in der Polylinie groß ist, können Sie die Granularität nutzen, um schneller ein Näherungsergebnis zu erhalten.

    Argumente:

    list *polyline*
    : Die Polylinie, die den Kreis möglicherweise schneidet

    list *circle*
    : Der betreffende Kreis

    string *mode*
    : Ob nur der erste (Standard) oder alle Schnittpunkte ("all") zurückgegeben werden sollen

    int *granularity*
    : Die Anzahl der Punkte, die bei der Suche nach Schnittpunkten übersprungen werden, zuzüglich 1 (ein Wert von 1 oder kleiner bedeutet, dass ein exaktes Ergebnis zurückgegeben wird)


**::math::geometry::polylineCutOrigin** *polyline1* *polyline2* ?granularity?
: Gibt den Abschnitt der ersten Polylinie vom Ursprung bis zum ersten Schnittpunkt mit der zweiten Polylinie zurück. Wenn die Anzahl der Punkte in der Polylinie groß ist, können Sie die Granularität nutzen, um schneller ein Näherungsergebnis zu erhalten.

    Argumente:

    list *polyline1*
    : Die erste Polylinie (von der ein Teil zurückgegeben werden soll)

    list *polyline2*
    : Die zweite Polylinie

    int *granularity*
    : Die Anzahl der Punkte, die bei der Suche nach Schnittpunkten übersprungen werden, zuzüglich 1 (ein Wert von 1 oder kleiner bedeutet, dass ein exaktes Ergebnis zurückgegeben wird)


**::math::geometry::polylineCutEnd** *polyline1* *polyline2* ?granularity?
: Gibt den Abschnitt der ersten Polylinie zurück, der vom letzten Schnittpunkt mit der zweiten Polylinie bis zum Ende reicht. Wenn die Anzahl der Punkte in der Polylinie groß ist, können Sie die Granularität nutzen, um schneller ein Näherungsergebnis zu erhalten.

    Argumente:

    list *polyline1*
    : Die erste Polylinie (von der ein Teil zurückgegeben werden soll)

    list *polyline2*
    : Die zweite Polylinie

    int *granularity*
    : Die Anzahl der Punkte, die bei der Suche nach Schnittpunkten übersprungen werden, zuzüglich 1 (ein Wert von 1 oder kleiner bedeutet, dass ein exaktes Ergebnis zurückgegeben wird)


**::math::geometry::splitPolyline** *polyline* *numberVertex*
: Teilt die Polylinie in eine Reihe von Polylinien auf, wobei jede einzelne Polylinie "numberVertex" Eckpunkte zwischen den beiden Endpunkten enthält.

    Argumente:

    list *polyline*
    : Die zu teilende Polylinie

    int *numberVertex*
    : Die Anzahl der „inneren“ Eckpunkte


**::math::geometry::enrichPolyline** *polyline* *accuracy*
: Unterteilt jedes Segment einer Polylinie in mehrere kleinere Segmente und gibt das Ergebnis zurück.

    Argumente:

    list *polyline*
    : Die zu verfeinernde Polylinie

    int *accuracy*
    : Die Anzahl der zu erstellenden Teilsegmente


**::math::geometry::cleanupPolyline** *polyline*
: Entfernt doppelte benachbarte Eckpunkte und gibt das Ergebnis zurück.

    Argumente:

    list *polyline*
    : Die zu bereinigende Polylinie



# Koordinatensystem

Das vom Paket verwendete Koordinatensystem ist das gewöhnliche kartesische Koordinatensystem, bei dem die positive x-Achse nach rechts und die positive y-Achse nach oben zeigt. Winkel und Richtungen werden in Bezug auf die positive x-Achse gegen den Uhrzeigersinn definiert, sodass ein Winkel von 90 Grad der Richtung der positiven y-Achse entspricht. Hinweis: Die Tk-Canvas-Koordinaten unterscheiden sich davon, da sich dort der Ursprung in der oberen linken Ecke des Fensters befindet. Bis einschließlich Version 1.3 verwendeten die Prozeduren direction und octant dieses Pakets diese Konvention uneinheitlich.

# Literatur

1. [Polygon Intersection](http:/wiki.tcl.tk/12070)

2. <http://en.wikipedia.org/wiki/Line-line_intersection>

3. <http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/>


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: geometry* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2001 by Ideogramic ApS and other parties
Copyright (c) 2010 by Andreas Kupries
Copyright (c) 2010 by Kevin Kenny
Copyright (c) 2018 by Arjen Markus
Copyright (c) 2020 by Manfred Rosenberger
```
