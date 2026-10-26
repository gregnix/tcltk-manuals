---
CommandName: math::linearalgebra
title: math::linearalgebra
ManualSection: n
Version: 1.1.7
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - least squares
 - linear algebra
 - linear equations
 - math
 - matrices
 - matrix
 - vectors
Copyright:
 - Copyright (c) 2004-2008 Arjen Markus <arjenmarkus@users.sourceforge.net>
 - Copyright (c) 2004 Ed Hume <http://www.hume.com/contact.us.htm>
 - Copyright (c) 2008 Michael Buadin <relaxkmike@users.sourceforge.net>
---

# Name

math::linearalgebra – Lineare Algebra

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::linearalgebra]{.lit} [1.1.7]{.optlit}
[::math::linearalgebra::mkVector]{.cmd} [ndim]{.arg} [value]{.arg}
[::math::linearalgebra::mkUnitVector]{.cmd} [ndim]{.arg} [ndir]{.arg}
[::math::linearalgebra::mkMatrix]{.cmd} [nrows]{.arg} [ncols]{.arg} [value]{.arg}
[::math::linearalgebra::getrow]{.cmd} [matrix]{.arg} [row]{.arg} [imin]{.optarg} [imax]{.optarg}
[::math::linearalgebra::setrow]{.cmd} [matrix]{.arg} [row]{.arg} [newvalues]{.arg} [imin]{.optarg} [imax]{.optarg}
[::math::linearalgebra::getcol]{.cmd} [matrix]{.arg} [col]{.arg} [imin]{.optarg} [imax]{.optarg}
[::math::linearalgebra::setcol]{.cmd} [matrix]{.arg} [col]{.arg} [newvalues]{.arg} [imin]{.optarg} [imax]{.optarg}
[::math::linearalgebra::getelem]{.cmd} [matrix]{.arg} [row]{.arg} [col]{.arg}
[::math::linearalgebra::setelem]{.cmd} [matrix]{.arg} [row]{.arg} [col]{.optarg} [newvalue]{.arg}
[::math::linearalgebra::swaprows]{.cmd} [matrix]{.arg} [irow1]{.arg} [irow2]{.arg} [imin]{.optarg} [imax]{.optarg}
[::math::linearalgebra::swapcols]{.cmd} [matrix]{.arg} [icol1]{.arg} [icol2]{.arg} [imin]{.optarg} [imax]{.optarg}
[::math::linearalgebra::show]{.cmd} [obj]{.arg} [format]{.optarg} [rowsep]{.optarg} [colsep]{.optarg}
[::math::linearalgebra::dim]{.cmd} [obj]{.arg}
[::math::linearalgebra::shape]{.cmd} [obj]{.arg}
[::math::linearalgebra::conforming]{.cmd} [type]{.arg} [obj1]{.arg} [obj2]{.arg}
[::math::linearalgebra::symmetric]{.cmd} [matrix]{.arg} [eps]{.optarg}
[::math::linearalgebra::norm]{.cmd} [vector]{.arg} [type]{.arg}
[::math::linearalgebra::norm\_one]{.cmd} [vector]{.arg}
[::math::linearalgebra::norm\_two]{.cmd} [vector]{.arg}
[::math::linearalgebra::norm\_max]{.cmd} [vector]{.arg} [index]{.optarg}
[::math::linearalgebra::normMatrix]{.cmd} [matrix]{.arg} [type]{.arg}
[::math::linearalgebra::dotproduct]{.cmd} [vect1]{.arg} [vect2]{.arg}
[::math::linearalgebra::unitLengthVector]{.cmd} [vector]{.arg}
[::math::linearalgebra::normalizeStat]{.cmd} [mv]{.arg}
[::math::linearalgebra::axpy]{.cmd} [scale]{.arg} [mv1]{.arg} [mv2]{.arg}
[::math::linearalgebra::add]{.cmd} [mv1]{.arg} [mv2]{.arg}
[::math::linearalgebra::sub]{.cmd} [mv1]{.arg} [mv2]{.arg}
[::math::linearalgebra::scale]{.cmd} [scale]{.arg} [mv]{.arg}
[::math::linearalgebra::rotate]{.cmd} [c]{.arg} [s]{.arg} [vect1]{.arg} [vect2]{.arg}
[::math::linearalgebra::transpose]{.cmd} [matrix]{.arg}
[::math::linearalgebra::matmul]{.cmd} [mv1]{.arg} [mv2]{.arg}
[::math::linearalgebra::angle]{.cmd} [vect1]{.arg} [vect2]{.arg}
[::math::linearalgebra::crossproduct]{.cmd} [vect1]{.arg} [vect2]{.arg}
[::math::linearalgebra::matmul]{.cmd} [mv1]{.arg} [mv2]{.arg}
[::math::linearalgebra::mkIdentity]{.cmd} [size]{.arg}
[::math::linearalgebra::mkDiagonal]{.cmd} [diag]{.arg}
[::math::linearalgebra::mkRandom]{.cmd} [size]{.arg}
[::math::linearalgebra::mkTriangular]{.cmd} [size]{.arg} [uplo]{.optarg} [value]{.optarg}
[::math::linearalgebra::mkHilbert]{.cmd} [size]{.arg}
[::math::linearalgebra::mkDingdong]{.cmd} [size]{.arg}
[::math::linearalgebra::mkOnes]{.cmd} [size]{.arg}
[::math::linearalgebra::mkMoler]{.cmd} [size]{.arg}
[::math::linearalgebra::mkFrank]{.cmd} [size]{.arg}
[::math::linearalgebra::mkBorder]{.cmd} [size]{.arg}
[::math::linearalgebra::mkWilkinsonW+]{.cmd} [size]{.arg}
[::math::linearalgebra::mkWilkinsonW-]{.cmd} [size]{.arg}
[::math::linearalgebra::solveGauss]{.cmd} [matrix]{.arg} [bvect]{.arg}
[::math::linearalgebra::solvePGauss]{.cmd} [matrix]{.arg} [bvect]{.arg}
[::math::linearalgebra::solveTriangular]{.cmd} [matrix]{.arg} [bvect]{.arg} [uplo]{.optarg}
[::math::linearalgebra::solveGaussBand]{.cmd} [matrix]{.arg} [bvect]{.arg}
[::math::linearalgebra::solveTriangularBand]{.cmd} [matrix]{.arg} [bvect]{.arg}
[::math::linearalgebra::determineSVD]{.cmd} [A]{.arg} [eps]{.arg}
[::math::linearalgebra::eigenvectorsSVD]{.cmd} [A]{.arg} [eps]{.arg}
[::math::linearalgebra::leastSquaresSVD]{.cmd} [A]{.arg} [y]{.arg} [qmin]{.arg} [eps]{.arg}
[::math::linearalgebra::choleski]{.cmd} [matrix]{.arg}
[::math::linearalgebra::orthonormalizeColumns]{.cmd} [matrix]{.arg}
[::math::linearalgebra::orthonormalizeRows]{.cmd} [matrix]{.arg}
[::math::linearalgebra::dger]{.cmd} [matrix]{.arg} [alpha]{.arg} [x]{.arg} [y]{.arg} [scope]{.optarg}
[::math::linearalgebra::dgetrf]{.cmd} [matrix]{.arg}
[::math::linearalgebra::det]{.cmd} [matrix]{.arg}
[::math::linearalgebra::largesteigen]{.cmd} [matrix]{.arg} [tolerance]{.arg} [maxiter]{.arg}
[::math::linearalgebra::to\_LA]{.cmd} [mv]{.arg}
[::math::linearalgebra::from\_LA]{.cmd} [mv]{.arg}
:::

# Beschreibung

Dieses Paket bietet sowohl Low-Level-Prozeduren als auch High-Level-Algorithmen zur Lösung von Problemen der linearen Algebra:

- robuste Lösung linearer Gleichungssysteme oder von Problemen der kleinsten Quadrate

- Bestimmung von Eigenvektoren und Eigenwerten symmetrischer Matrizen

- verschiedene Zerlegungen allgemeiner Matrizen oder Matrizen einer bestimmten Form

- (Eingeschränkte) Unterstützung für Matrizen in Bandspeicherung, einer gängigen Art dünn besetzter Matrizen.


Das Paket entstand als Neuimplementierung des LA-Pakets von Hume und aus dem Wunsch heraus, Low-Level-Prozeduren anzubieten, wie sie in der bekannten BLAS-Bibliothek zu finden sind. Matrizen werden als Listen von Listen implementiert und nicht als lineare Listen mit reservierten Elementen, wie im ursprünglichen LA-Paket, da sich herausgestellt hat, dass eine solche Implementierung tatsächlich schneller ist.

Es ist jedoch ratsam, die angebotenen Prozeduren wie *setrow* und *getrow* zu verwenden, anstatt sich explizit auf diese Darstellung zu verlassen: Auf diese Weise kann auf eine möglicherweise noch schnellere, kompilierte Implementierung umgestellt werden, die dieselbe API unterstützt.

*Hinweis:* Bei der Verwendung dieses Pakets in Kombination mit Tk kann es zu einem Namenskonflikt kommen, da sowohl dieses Paket als auch Tk einen Befehl *scale* definieren. Siehe den Abschnitt [Namenskonflikt] weiter unten.

# Prozeduren

Das Paket definiert die folgenden öffentlichen Prozeduren (einige davon existieren als spezialisierte Prozeduren, siehe unten):

*Constructing matrices and vectors*

**::math::linearalgebra::mkVector** *ndim* *value*
: Erzeugt einen Vektor mit ndim Elementen, von denen jedes den Wert *value* hat.

    integer *ndim*
    : Dimension des Vektors (Anzahl der Komponenten)

    double *value*
    : Zu verwendender einheitlicher Wert (Standard: 0.0)


**::math::linearalgebra::mkUnitVector** *ndim* *ndir*
: Erzeugt einen Einheitsvektor im *ndim*-dimensionalen Raum entlang der *ndir*-ten Richtung.

    integer *ndim*
    : Dimension des Vektors (Anzahl der Komponenten)

    integer *ndir*
    : Richtung (0, …, ndim-1)


**::math::linearalgebra::mkMatrix** *nrows* *ncols* *value*
: Erzeugt eine Matrix mit *nrows* Zeilen und *ncols* Spalten. Alle Elemente haben den Wert *value*.

    integer *nrows*
    : Anzahl der Zeilen

    integer *ncols*
    : Anzahl der Spalten

    double *value*
    : Zu verwendender einheitlicher Wert (Standard: 0.0)


**::math::linearalgebra::getrow** *matrix* *row* ?imin? ?imax?
: Gibt eine einzelne Zeile einer Matrix als Liste zurück

    list *matrix*
    : Die betreffende Matrix

    integer *row*
    : Index der zurückzugebenden Zeile

    integer *imin*
    : Kleinster Spaltenindex (Standard: 0)

    integer *imax*
    : Größter Spaltenindex (Standard: ncols-1)


**::math::linearalgebra::setrow** *matrix* *row* *newvalues* ?imin? ?imax?
: Setzt eine einzelne Zeile einer Matrix auf neue Werte (diese Liste muss dieselbe Anzahl an Elementen aufweisen wie die Anzahl der *Spalten* in der Matrix)

    list *matrix*
    : *Name* der betreffenden Matrix

    integer *row*
    : Index der zu aktualisierenden Zeile

    list *newvalues*
    : Liste der neuen Werte für die Zeile

    integer *imin*
    : Kleinster Spaltenindex (Standard: 0)

    integer *imax*
    : Größter Spaltenindex (Standard: ncols-1)


**::math::linearalgebra::getcol** *matrix* *col* ?imin? ?imax?
: Gibt eine einzelne Spalte einer Matrix als Liste zurück

    list *matrix*
    : Die betreffende Matrix

    integer *col*
    : Index der zurückzugebenden Spalte

    integer *imin*
    : Kleinster Zeilenindex (Standard: 0)

    integer *imax*
    : Größter Zeilenindex (Standard: nrows-1)


**::math::linearalgebra::setcol** *matrix* *col* *newvalues* ?imin? ?imax?
: Setzt eine einzelne Spalte einer Matrix auf neue Werte (diese Liste muss dieselbe Anzahl an Elementen aufweisen wie die Anzahl der *Zeilen* in der Matrix)

    list *matrix*
    : *Name* der betreffenden Matrix

    integer *col*
    : Index der zu aktualisierenden Spalte

    list *newvalues*
    : Liste der neuen Werte für die Spalte

    integer *imin*
    : Kleinster Zeilenindex (Standard: 0)

    integer *imax*
    : Größter Zeilenindex (Standard: nrows-1)


**::math::linearalgebra::getelem** *matrix* *row* *col*
: Gibt ein einzelnes Element einer Matrix bzw. eines Vektors zurück

    list *matrix*
    : Die betreffende Matrix oder der betreffende Vektor

    integer *row*
    : Zeile des Elements

    integer *col*
    : Spalte des Elements (bei Vektoren nicht vorhanden)


**::math::linearalgebra::setelem** *matrix* *row* ?col? *newvalue*
: Setzt ein einzelnes Element einer Matrix (oder eines Vektors) auf einen neuen Wert

    list *matrix*
    : *Name* der betreffenden Matrix

    integer *row*
    : Zeile des Elements

    integer *col*
    : Spalte des Elements (bei Vektoren nicht vorhanden)


**::math::linearalgebra::swaprows** *matrix* *irow1* *irow2* ?imin? ?imax?
: Vertauscht zwei Zeilen einer Matrix vollständig oder nur in einem ausgewählten Teil

    list *matrix*
    : *Name* der betreffenden Matrix

    integer *irow1*
    : Index der ersten Zeile

    integer *irow2*
    : Index der zweiten Zeile

    integer *imin*
    : Kleinster Spaltenindex (Standard: 0)

    integer *imin*
    : Größter Spaltenindex (Standard: ncols-1)


**::math::linearalgebra::swapcols** *matrix* *icol1* *icol2* ?imin? ?imax?
: Vertauscht zwei Spalten einer Matrix vollständig oder nur in einem ausgewählten Teil

    list *matrix*
    : *Name* der betreffenden Matrix

    integer *irow1*
    : Index der ersten Spalte

    integer *irow2*
    : Index der zweiten Spalte

    integer *imin*
    : Kleinster Zeilenindex (Standard: 0)

    integer *imin*
    : Größter Zeilenindex (Standard: nrows-1)



*Querying matrices and vectors*

**::math::linearalgebra::show** *obj* ?format? ?rowsep? ?colsep?
: Gibt eine Zeichenkette zurück, die den Vektor oder die Matrix darstellt, um die Ausgabe zu vereinfachen. (Derzeit gibt es keine Möglichkeit, festgelegte Gruppen von Spalten auszugeben.)

    list *obj*
    : Die betreffende Matrix oder der betreffende Vektor

    string *format*
    : Format für die Ausgabe der Zahlen (Standard: %6.4f)

    string *rowsep*
    : Zeichenkette, die zur Trennung der Zeilen verwendet werden soll (Standard: Zeilenumbruch)

    string *colsep*
    : Zeichenkette zur Trennung der Spalten (Standard: Leerzeichen)


**::math::linearalgebra::dim** *obj*
: Gibt die Anzahl der Dimensionen des Objekts zurück (entweder 0 für einen Skalar, 1 für einen Vektor und 2 für eine Matrix)

    any *obj*
    : Skalar, Vektor oder Matrix


**::math::linearalgebra::shape** *obj*
: Gibt die Anzahl der Elemente in jeder Dimension des Objekts zurück (entweder eine leere Liste für einen Skalar, eine einzelne Zahl für einen Vektor und eine Liste mit der Anzahl der Zeilen und Spalten für eine Matrix)

    any *obj*
    : Skalar, Vektor oder Matrix


**::math::linearalgebra::conforming** *type* *obj1* *obj2*
: Prüft, ob zwei Objekte (Vektor oder Matrix) kompatible Formen aufweisen, d. h., ob sie in einer Operation wie der Addition oder der Matrixmultiplikation verwendet werden können.

    string *type*
    : Art der Prüfung:

        - „shape“ – die beiden Objekte haben dieselbe Form (für alle elementweisen Operationen)

        - „rows“ – die beiden Objekte weisen die gleiche Anzahl von Zeilen auf (zur Verwendung als A und b in einem linearen Gleichungssystem *Ax = b*

        - „matmul“ – Das erste Objekt hat dieselbe Anzahl an Spalten wie das zweite Objekt an Zeilen. Nützlich für die Multiplikation von Matrizen untereinander oder von Matrizen mit Vektoren.


    list *obj1*
    : Erster Vektor oder erste Matrix (linker Operand)

    list *obj2*
    : Zweiter Vektor oder zweite Matrix (rechter Operand)


**::math::linearalgebra::symmetric** *matrix* ?eps?
: Prüft, ob die angegebene (quadratische) Matrix symmetrisch ist. Das Argument „eps“ gibt die Toleranz an.

    list *matrix*
    : Zu prüfende Matrix

    float *eps*
    : Toleranz zur Bestimmung der annähernden Gleichheit (Standardwert: 1.0e-8)



*Basic operations*

**::math::linearalgebra::norm** *vector* *type*
: Gibt die Norm des angegebenen Vektors zurück. Das Argument „type“ kann folgende Werte annehmen: 1, 2, inf oder max; dies entspricht jeweils der Summe der Absolutwerte, der gewöhnlichen euklidischen Norm oder der Max-Norm.

    list *vector*
    : Vektor, Liste der Koeffizienten

    string *type*
    : Normtyp (Standard: 2, die euklidische Norm)


**::math::linearalgebra::norm\_one** *vector*
: Gibt die L1-Norm des angegebenen Vektors zurück, d. h. die Summe der Absolutwerte

    list *vector*
    : Vektor, Liste der Koeffizienten


**::math::linearalgebra::norm\_two** *vector*
: Gibt die L2-Norm des angegebenen Vektors zurück, d. h. die gewöhnliche euklidische Norm

    list *vector*
    : Vektor, Liste der Koeffizienten


**::math::linearalgebra::norm\_max** *vector* ?index?
: Gibt die Linf-Norm des angegebenen Vektors zurück, d. h. den größten absoluten Koeffizienten

    list *vector*
    : Vektor, Liste der Koeffizienten

    integer *index*
    : (optional) Wenn der Wert ungleich Null ist, wird eine Liste aus dem Maximalwert und dem Index zurückgegeben, an dem dieser Maximalwert gefunden wurde. Wenn der Wert Null ist, wird der Maximalwert zurückgegeben.


**::math::linearalgebra::normMatrix** *matrix* *type*
: Gibt die Norm der angegebenen Matrix zurück. Das Argument „type“ kann folgende Werte annehmen: 1, 2, inf oder max; dies entspricht jeweils der Summe der Absolutwerte, der gewöhnlichen euklidischen Norm bzw. der Max-Norm.

    list *matrix*
    : Matrix, Liste von Zeilenvektoren

    string *type*
    : Normtyp (Standard: 2, die euklidische Norm)


**::math::linearalgebra::dotproduct** *vect1* *vect2*
: Berechnet das Skalarprodukt (innere Produkt) zweier Vektoren. Diese müssen dieselbe Form (Anzahl der Dimensionen) aufweisen.

    list *vect1*
    : Erster Vektor, Liste der Koeffizienten

    list *vect2*
    : Zweiter Vektor, Liste der Koeffizienten


**::math::linearalgebra::unitLengthVector** *vector*
: Gibt einen Vektor in derselben Richtung mit der Länge 1 zurück.

    list *vector*
    : Zu normalisierender Vektor


**::math::linearalgebra::normalizeStat** *mv*
: Normalisiert die Matrix oder den Vektor im statistischen Sinne: Der Mittelwert der Elemente der Spalten des Ergebnisses beträgt Null und die Standardabweichung beträgt 1.

    list *mv*
    : Vektor oder Matrix, die im oben genannten Sinne normalisiert werden soll


**::math::linearalgebra::axpy** *scale* *mv1* *mv2*
: Gibt einen Vektor oder eine Matrix zurück, der bzw. die aus einer „daxpy“-Operation resultiert, d. h.: berechnet a\*x+y (wobei a ein Skalar und x sowie y Vektoren oder Matrizen gleicher Form sind) und gibt das Ergebnis zurück.

    Spezielle Varianten sind: axpy\_vect und axpy\_mat (etwas schneller, jedoch ohne Überprüfung der Argumente)

    double *scale*
    : Der Skalierungsfaktor für den ersten Vektor/die erste Matrix (a)

    list *mv1*
    : Erster Vektor oder erste Matrix (x)

    list *mv2*
    : Zweiter Vektor oder zweite Matrix (y)


**::math::linearalgebra::add** *mv1* *mv2*
: Gibt einen Vektor oder eine Matrix zurück, die der Summe der beiden Argumente (x+y) entspricht.

    Spezielle Varianten sind: add\_vect und add\_mat (etwas schneller, jedoch ohne Überprüfung der Argumente)

    list *mv1*
    : Erster Vektor oder erste Matrix (x)

    list *mv2*
    : Zweiter Vektor oder zweite Matrix (y)


**::math::linearalgebra::sub** *mv1* *mv2*
: Gibt einen Vektor oder eine Matrix zurück, die der Differenz der beiden Argumente (x-y) entspricht.

    Spezielle Varianten sind: sub\_vect und sub\_mat (etwas schneller, jedoch ohne Überprüfung der Argumente)

    list *mv1*
    : Erster Vektor oder erste Matrix (x)

    list *mv2*
    : Zweiter Vektor oder zweite Matrix (y)


**::math::linearalgebra::scale** *scale* *mv*
: Skaliert einen Vektor oder eine Matrix und gibt das Ergebnis zurück, d. h.: berechnet a\*x.

    Spezielle Varianten sind: scale\_vect und scale\_mat (etwas schneller, jedoch ohne Überprüfung der Argumente)

    double *scale*
    : Der Skalierungsfaktor für den Vektor/die Matrix (a)

    list *mv*
    : Vektor oder Matrix (x)


**::math::linearalgebra::rotate** *c* *s* *vect1* *vect2*
: Wendet eine ebene Drehung auf zwei Vektoren an und gibt das Ergebnis als Liste aus zwei Vektoren zurück: c\*x-s\*y und s\*x+c\*y. In Algorithmen lassen sich der Kosinus und der Sinus des Winkels oft leicht bestimmen, daher ist es effizienter, diese Informationen direkt zu übergeben.

    double *c*
    : Der Kosinus des Winkels

    double *s*
    : Der Sinus des Winkels

    list *vect1*
    : Erster Vektor (x)

    list *vect2*
    : Zweiter Vektor (x)


**::math::linearalgebra::transpose** *matrix*
: Transponiert eine Matrix

    list *matrix*
    : Zu transponierende Matrix


**::math::linearalgebra::matmul** *mv1* *mv2*
: Multipliziert einen Vektor bzw. eine Matrix mit einem anderen Vektor bzw. einer anderen Matrix. Das Ergebnis ist eine Matrix, wenn sowohl x als auch y Matrizen sind oder beide Vektoren sind; in diesem Fall wird das „äußere Produkt“ berechnet. Ist das eine ein Vektor und das andere eine Matrix, dann ist das Ergebnis ein Vektor.

    list *mv1*
    : Erster Vektor/erste Matrix (x)

    list *mv2*
    : Zweiter Vektor/zweite Matrix (y)


**::math::linearalgebra::angle** *vect1* *vect2*
: Berechnet den Winkel zwischen zwei Vektoren (im Bogenmaß)

    list *vect1*
    : Erster Vektor

    list *vect2*
    : Zweiter Vektor


**::math::linearalgebra::crossproduct** *vect1* *vect2*
: Berechnet das Vektorprodukt zweier (dreidimensionaler) Vektoren

    list *vect1*
    : Erster Vektor

    list *vect2*
    : Zweiter Vektor


**::math::linearalgebra::matmul** *mv1* *mv2*
: Multipliziert einen Vektor bzw. eine Matrix mit einem anderen Vektor bzw. einer anderen Matrix. Das Ergebnis ist eine Matrix, wenn sowohl x als auch y Matrizen sind oder beide Vektoren sind; in diesem Fall wird das „äußere Produkt“ berechnet. Ist das eine ein Vektor und das andere eine Matrix, dann ist das Ergebnis ein Vektor.

    list *mv1*
    : Erster Vektor/erste Matrix (x)

    list *mv2*
    : Zweiter Vektor/zweite Matrix (y)



*Common matrices and test matrices*

**::math::linearalgebra::mkIdentity** *size*
: Erzeugt eine Einheitsmatrix der Dimension *size*.

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkDiagonal** *diag*
: Erzeugt eine Diagonalmatrix, deren Diagonalelemente die Elemente des Vektors *diag* sind.

    list *diag*
    : Vektor, dessen Elemente für die Diagonale verwendet werden


**::math::linearalgebra::mkRandom** *size*
: Erzeugt eine quadratische Matrix, deren Elemente gleichmäßig verteilte Zufallszahlen zwischen 0 und 1 sind und deren Dimension *size* beträgt.

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkTriangular** *size* ?uplo? ?value?
: Erzeugt eine Dreiecksmatrix, deren Elemente im oberen oder unteren Teil von Null verschieden sind, je nach dem Argument *uplo*.

    integer *size*
    : Dimension der Matrix

    string *uplo*
    : Füllt den oberen (U) oder den unteren Teil (L)

    double *value*
    : Wert, mit dem die Matrix ausgefüllt werden soll


**::math::linearalgebra::mkHilbert** *size*
: Erzeugt eine Hilbert-Matrix der Dimension *size*. Hilbert-Matrizen weisen bei Eigenwert- und Eigenvektorproblemen eine sehr schlechte Kondition auf. Daher eignen sie sich gut zum Testen der Genauigkeit von Algorithmen und Implementierungen.

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkDingdong** *size*
: Erzeugt eine „Dingdong“-Matrix der Dimension *size*. Dingdong-Matrizen werden zwar ungenau dargestellt, weisen jedoch die Eigenschaft auf, in Algorithmen wie der Gaußschen Elimination sehr stabil zu sein.

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkOnes** *size*
: Erzeugt eine quadratische Matrix der Dimension *size*, deren Einträge alle den Wert 1 haben.

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkMoler** *size*
: Erzeugt eine Moler-Matrix der Größe *size*. (Moler-Matrizen weisen eine sehr einfache Cholesky-Zerlegung auf. Sie besitzen einen kleinen Eigenwert und können Eliminationsmethoden für lineare Gleichungssysteme leicht stören.)

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkFrank** *size*
: Erzeugt eine Frank-Matrix der Größe *size*. (Frank-Matrizen sind recht gutartige Matrizen.)

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkBorder** *size*
: Erzeugt eine geränderte Matrix der Größe *size*. (Geränderte Matrizen weisen einen sehr niedrigen Rang auf und können bestimmte spezialisierte Algorithmen beeinträchtigen.)

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkWilkinsonW+** *size*
: Erzeugt eine Wilkinson-Matrix W+ der Größe *size*. Diese Art von Matrix weist Paare von Eigenwerten auf, die sehr nahe beieinander liegen. In der Regel ist die Ordnung (Größe) ungerade.

    integer *size*
    : Dimension der Matrix


**::math::linearalgebra::mkWilkinsonW-** *size*
: Erzeugt eine Wilkinson-Matrix W- der Größe *size*. Diese Art von Matrix weist Paare von Eigenwerten mit entgegengesetzten Vorzeichen auf, wenn die Ordnung (Größe) ungerade ist.

    integer *size*
    : Dimension der Matrix



*Common algorithms*

**::math::linearalgebra::solveGauss** *matrix* *bvect*
: Löst ein lineares Gleichungssystem (Ax=b) mithilfe der Gaußschen Elimination. Gibt die Lösung (x) als Vektor oder Matrix derselben Form wie bvect zurück.

    list *matrix*
    : Quadratische Matrix (Matrix A)

    list *bvect*
    : Vektor oder Matrix, deren Spalten die einzelnen b-Vektoren sind


**::math::linearalgebra::solvePGauss** *matrix* *bvect*
: Löst ein lineares Gleichungssystem (Ax=b) mithilfe der Gauß-Elimination mit partieller Pivotierung. Gibt die Lösung (x) als Vektor oder Matrix derselben Form wie bvect zurück.

    list *matrix*
    : Quadratische Matrix (Matrix A)

    list *bvect*
    : Vektor oder Matrix, deren Spalten die einzelnen b-Vektoren sind


**::math::linearalgebra::solveTriangular** *matrix* *bvect* ?uplo?
: Löst ein lineares Gleichungssystem (Ax=b) durch Rückwärtseinsetzen. Es wird angenommen, dass die Matrix obere Dreiecksform aufweist.

    list *matrix*
    : Unter- oder Oberdreiecksmatrix (Matrix A)

    list *bvect*
    : Vektor oder Matrix, deren Spalten die einzelnen b-Vektoren sind

    string *uplo*
    : Gibt an, ob es sich bei der Matrix um eine untere Dreiecksmatrix (L) oder eine obere Dreiecksmatrix (U) handelt. Der Standardwert ist „U“.


**::math::linearalgebra::solveGaussBand** *matrix* *bvect*
: Löst ein lineares Gleichungssystem (Ax=b) mithilfe der Gauß-Elimination, wobei die Matrix als Bandmatrix gespeichert ist (*vgl.* [Speicherung]). Gibt die Lösung (x) als Vektor oder Matrix derselben Form wie bvect zurück.

    list *matrix*
    : Quadratische Matrix (Matrix A; in Bandform)

    list *bvect*
    : Vektor oder Matrix, deren Spalten die einzelnen b-Vektoren sind


**::math::linearalgebra::solveTriangularBand** *matrix* *bvect*
: Löst ein lineares Gleichungssystem (Ax=b) durch Rückwärtseinsetzen. Es wird angenommen, dass die Matrix eine obere Dreiecksmatrix ist und in Bandform gespeichert ist.

    list *matrix*
    : Obere Dreiecksmatrix (Matrix A)

    list *bvect*
    : Vektor oder Matrix, deren Spalten die einzelnen b-Vektoren sind


**::math::linearalgebra::determineSVD** *A* *eps*
: Ermittelt die Singulärwertzerlegung einer Matrix: A = U S Vtrans. Gibt eine Liste zurück, die die Matrix U, den Vektor der Singulärwerte S und die Matrix V enthält.

    list *A*
    : Zu zerlegende Matrix

    float *eps*
    : Toleranz (Standardwert: 2.3e-16)


**::math::linearalgebra::eigenvectorsSVD** *A* *eps*
: Ermittelt die Eigenvektoren und Eigenwerte einer reellen *symmetrischen* Matrix mithilfe der SVD. Gibt eine Liste zurück, die die Matrix der normierten Eigenvektoren und deren Eigenwerte enthält.

    list *A*
    : Matrix, deren Eigenwerte bestimmt werden müssen

    float *eps*
    : Toleranz (Standardwert: 2.3e-16)


**::math::linearalgebra::leastSquaresSVD** *A* *y* *qmin* *eps*
: Ermittelt die Lösung für ein Problem der kleinsten Quadrate Ax ~ y mittels Singulärwertzerlegung. Das Ergebnis ist der Vektor x.

    Hinweis: Wenn Sie der Matrix eine Spalte mit lauter Einsen hinzufügen, stellt diese Spalte eine Konstante dar, wie in: y = a\*x1 + b\*x2 + c. Soll der Achsenabschnitt Null sein, lassen Sie die Spalte einfach weg.

    list *A*
    : Matrix der unabhängigen Variablen

    list *y*
    : Liste der gemessenen Werte

    float *qmin*
    : Kleinster zu berücksichtigender Singulärwert (Standardwert: 0.0)

    float *eps*
    : Toleranz (Standardwert: 2.3e-16)


**::math::linearalgebra::choleski** *matrix*
: Ermittelt die Cholesky-Zerlegung einer symmetrischen, positiv semidefiniten Matrix (diese Bedingung wird nicht überprüft!). Das Ergebnis ist die untere Dreiecksmatrix L, für die gilt: L Lt = matrix.

    list *matrix*
    : Zu zerlegende Matrix


**::math::linearalgebra::orthonormalizeColumns** *matrix*
: Orthogonalisiert und normiert die *Spalten* der angegebenen Matrix mit dem modifizierten Gram-Schmidt-Verfahren und gibt das Ergebnis zurück.

    list *matrix*
    : Matrix, deren Spalten orthonormiert werden sollen


**::math::linearalgebra::orthonormalizeRows** *matrix*
: Orthogonalisiert und normiert die *Zeilen* der angegebenen Matrix mit dem modifizierten Gram-Schmidt-Verfahren und gibt das Ergebnis zurück.

    list *matrix*
    : Matrix, deren Zeilen orthonormiert werden sollen


**::math::linearalgebra::dger** *matrix* *alpha* *x* *y* ?scope?
: Führt die Rang-1-Operation A + alpha\*x\*y' direkt an der Matrix aus (das heißt: Die Matrix A wird verändert). Der Einfachheit halber wird die neue Matrix außerdem als Ergebnis zurückgegeben.

    list *matrix*
    : Matrix, deren Zeilen angepasst werden müssen

    double *alpha*
    : Skalierungsfaktor

    list *x*
    : Ein Spaltenvektor

    list *y*
    : Ein Spaltenvektor

    list *scope*
    : Ohne Angabe wird die Operation auf alle Zeilen/Spalten von A angewendet; mit Angabe wird die Liste {imin imax jmin jmax} erwartet, wobei:

        - *imin* Kleinster Zeilenindex

        - *imax* Größter Zeilenindex

        - *jmin* Kleinster Spaltenindex

        - *jmax* Größter Spaltenindex



**::math::linearalgebra::dgetrf** *matrix*
: Berechnet eine LU-Zerlegung einer allgemeinen Matrix mit partieller Pivotierung und Zeilenvertauschungen. Gibt den Permutationsvektor zurück.

    Die Zerlegung hat die Form

    ```
       P * A = L * U
    ```

    wobei P eine Permutationsmatrix ist, L eine untere Dreiecksmatrix mit Einheitselementen auf der Diagonalen und U eine obere Dreiecksmatrix. Gibt den Permutationsvektor als Liste der Länge n-1 zurück. Der letzte Eintrag der Permutation wird nicht gespeichert, da er implizit bekannt ist und den Wert n hat (die letzte Zeile wird mit keiner anderen Zeile vertauscht). Unter dem Index #i der Permutation ist der Index der Zeile #j gespeichert, die im Schritt #i mit der Zeile #i vertauscht wird. Das bedeutet, dass jeder Index der Permutation die Permutation im jeweiligen Schritt angibt, nicht die kumulierte Permutationsmatrix, die das Produkt der Permutationen ist.

    list *matrix*
    : Bei der Eingabe: die zu faktorisierende Matrix. Bei der Ausgabe: die Faktoren L und U aus der Faktorisierung P\*A = L\*U; die Einheitsdiagonalelemente von L werden nicht gespeichert.


**::math::linearalgebra::det** *matrix*
: Gibt die Determinante der angegebenen Matrix zurück, basierend auf der PA=LU-Zerlegung, d. h. der Gauß-Elimination mit partieller Pivotierung.

    list *matrix*
    : Quadratische Matrix (Matrix A)

    list *ipiv*
    : Die Pivots (optional). Wenn keine Pivots angegeben werden, wird eine PA=LU-Zerlegung durchgeführt. Wenn Pivots angegeben werden, gehen wir davon aus, dass diese die Pivots enthalten und dass die Matrix A die L- und U-Faktoren enthält, wie sie von dgterf bereitgestellt werden. b-Vektoren


**::math::linearalgebra::largesteigen** *matrix* *tolerance* *maxiter*
: Gibt eine Liste zurück, die aus dem (dem Betrag nach) größten Eigenwert und dem zugehörigen Eigenvektor besteht. Verwendet die iterative Potenzmethode, wie sie in Algorithmus 7.3.3 von Golub & Van Loan beschrieben ist. Dieser Algorithmus wird hier für eine dichte Matrix verwendet (wird jedoch üblicherweise für dünn besetzte Matrizen eingesetzt).

    list *matrix*
    : Quadratische Matrix (Matrix A)

    double *tolerance*
    : Die relative Toleranz des Eigenwerts (Standardwert: 1.e-8).

    integer *maxiter*
    : Die maximale Anzahl der Iterationen (Standardwert: 10).



*Kompatibilität mit dem LA-Paket* Zur Gewährleistung der Kompatibilität mit dem LA-Paket von Hume stehen zwei Prozeduren zur Verfügung:

**::math::linearalgebra::to\_LA** *mv*
: Wandelt einen Vektor oder eine Matrix in das vom ursprünglichen LA-Paket verwendete Format um.

    list *mv*
    : Matrix oder Vektor


**::math::linearalgebra::from\_LA** *mv*
: Wandelt einen Vektor oder eine Matrix aus dem vom ursprünglichen LA-Paket verwendeten Format in das von der vorliegenden Implementierung verwendete Format um.

    list *mv*
    : Matrix oder Vektor, wie sie im LA-Paket verwendet werden



# Speicherung

Während die meisten Prozeduren davon ausgehen, dass die Matrizen in vollständiger Form vorliegen, gehen die Prozeduren *solveGaussBand* und *solveTriangularBand* davon aus, dass die Matrizen als *Bandmatrizen* gespeichert sind. Diese gängige Art „dünn besetzter“ Matrizen steht in folgendem Zusammenhang mit gewöhnlichen Matrizen:

- „A“ ist eine vollständige Matrix mit N Zeilen und M Spalten.

- „B“ ist eine Bandmatrix mit m oberen und unteren Diagonalen und n Zeilen.

- „B“ kann in einer gewöhnlichen Matrix mit (2m+1) Spalten (eine für jede Außendiagonale und die Hauptdiagonale) und n Zeilen gespeichert werden.

- Das Element i,j (i = -m,...,m; j =1,...,n) von „B“ entspricht dem Element k,j von „A“, wobei k = M+i-1 gilt und M mindestens (!) n beträgt, also die Anzahl der Zeilen in „B“.

- Um das Element (i,j) der Matrix „B“ zu setzen, verwenden Sie:

    ```
        setelem B $j [expr {$N+$i-1}] $value
    ```


(Hierfür gibt es bislang noch keine vereinfachte Prozedur.)

# Anmerkungen zur Umsetzung

Es besteht ein Unterschied zwischen dem ursprünglichen LA-Paket von Hume und der aktuellen Implementierung. Während das LA-Paket eine lineare Liste verwendet, nutzt das aktuelle Paket Listen von Listen zur Darstellung von Matrizen. Es hat sich herausgestellt, dass die Algorithmen mit dieser Darstellung schneller und einfacher zu implementieren sind.

Das LA-Paket diente als Vorlage, und tatsächlich wurde beispielsweise die Implementierung des SVD-Algorithmus aus diesem Paket übernommen. Der Funktionsumfang wurde unter Verwendung von Ideen aus der bekannten BLAS-Bibliothek erweitert, und einige Algorithmen wurden auf der Grundlage der zweiten Auflage des Buches von J.C. Nash, „Compact Numerical Methods for Computers“ (Adam Hilger, 1990), aktualisiert, das als Inspiration für das LA-Paket diente.

Um den Übergang zwischen den beiden Implementierungen zu erleichtern, stehen zwei Prozeduren zur Verfügung: *to\_LA* und *from\_LA*. Diese wurden oben beschrieben.

# Noch zu tun

Dies und das: Die folgenden Algorithmen wurden noch nicht implementiert:

- determineQR

- certainlyPositive, diagonallyDominant


# Namenskonflikt

Wenn Sie dieses Paket in einer Tk-fähigen Shell wie wish laden, dann führt der Befehl

```
namespace import ::math::linearalgebra
```

zu einer Fehlermeldung bezüglich „scale“. Dies liegt daran, dass Tk alle seine Befehle im globalen Namespace definiert. Die Lösung besteht darin, die Befehle der linearen Algebra in einen Namespace zu importieren, der nicht der globale ist:

```
package require math::linearalgebra
namespace eval compute {
    namespace import ::math::linearalgebra::*
    ... use the linear algebra version of scale ...
}
```

Um den Befehl „scale“ von Tk in demselben Namespace zu verwenden, können Sie ihn umbenennen:

```
namespace eval compute {
    rename ::scale scaleTk
    scaleTk .scale ...
}
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: linearalgebra* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004-2008 Arjen Markus <arjenmarkus@users.sourceforge.net>
Copyright (c) 2004 Ed Hume <http://www.hume.com/contact.us.htm>
Copyright (c) 2008 Michael Buadin <relaxkmike@users.sourceforge.net>
```
