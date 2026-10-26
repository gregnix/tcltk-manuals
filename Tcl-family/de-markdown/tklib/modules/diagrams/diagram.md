---
CommandName: diagram
ManualSection: n
Version: 0.3
TclPart: tklib
TclDescription: Documentation toolbox
Keywords:
 - 2D geometry
 - arc
 - arrow
 - box
 - canvas
 - circle
 - diagram
 - diamond
 - drawing
 - drum
 - ellipse
 - image
 - interpolation
 - intersection
 - line
 - move
 - picture
 - plane geometry
 - plotting
 - point
 - raster image
 - spline
 - text
 - vector
Copyright:
---

# NAME

Diagramm – Erstellung eines Diagramms

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [diagram]{.lit} [1]{.lit} 
[::diagram]{.cmd} [objectName]{.arg} [canvas]{.arg} [script]{.optarg} 
[diagramObject]{.ins} [new]{.sub} [direction]{.lit} [name]{.arg} [key value]{.optdot} 
[diagramObject]{.ins} [new]{.sub} [element]{.lit} [name]{.arg} [attributes]{.arg} [cmdprefix]{.arg} 
[diagramObject]{.ins} [new]{.sub} [alias]{.lit} [name]{.arg} [cmdprefix]{.arg} 
[diagramObject]{.ins} [new]{.sub} [command]{.lit} [name]{.arg} [arguments]{.arg} [body]{.arg} 
[diagramObject]{.ins} [new]{.sub} [attribute]{.lit} [name]{.arg} [key value]{.optdot} 
[diagramObject]{.ins} [unknown]{.sub} [attribute]{.lit} [cmdprefix]{.arg} 
[diagramObject]{.ins} [draw]{.sub} [script]{.arg} 
[arc]{.cmd} [attr...]{.arg} 
[arrow]{.cmd} [attr...]{.arg} 
[-->]{.cmd} [attr...]{.arg} 
[<-->]{.cmd} [attr...]{.arg} 
[<-->]{.cmd} [attr...]{.arg} 
[block]{.cmd} [script]{.arg} [attr...]{.arg} 
[box]{.cmd} [attr...]{.arg} 
[circle]{.cmd} [attr...]{.arg} 
[O]{.cmd} [attr...]{.arg} 
[diamond]{.cmd} [attr...]{.arg} 
[<>]{.cmd} [attr...]{.arg} 
[drum]{.cmd} [attr...]{.arg} 
[ellipse]{.cmd} [attr...]{.arg} 
[line]{.cmd} [attr...]{.arg} 
[--]{.cmd} [attr...]{.arg} 
[move]{.cmd} [attr]{.arg} 
[spline]{.cmd} [attr...]{.arg} 
[text]{.cmd} [attr...]{.arg} 
[west]{.cmd} 
[w]{.cmd} 
[left]{.cmd} 
[l]{.cmd} 
[south]{.cmd} 
[s]{.cmd} 
[down]{.cmd} 
[bottom]{.cmd} 
[bot]{.cmd} 
[b]{.cmd} 
[east]{.cmd} 
[e]{.cmd} 
[right]{.cmd} 
[r]{.cmd} 
[north]{.cmd} 
[n]{.cmd} 
[up]{.cmd} 
[top]{.cmd} 
[t]{.cmd} 
[northwest]{.cmd} 
[nw]{.cmd} 
[up-left]{.cmd} 
[upleft]{.cmd} 
[leftup]{.cmd} 
[northeast]{.cmd} 
[ne]{.cmd} 
[up-right]{.cmd} 
[upright]{.cmd} 
[rightup]{.cmd} 
[southwest]{.cmd} 
[sw]{.cmd} 
[down-left]{.cmd} 
[downleft]{.cmd} 
[leftdown]{.cmd} 
[southeast]{.cmd} 
[se]{.cmd} 
[down-right]{.cmd} 
[downright]{.cmd} 
[rightdown]{.cmd} 
[number]{.ins} [cm]{.sub} 
[number]{.ins} [mm]{.sub} 
[number]{.ins} [inch]{.sub} 
[number]{.ins} [pt]{.sub} 
[by]{.cmd} [distance]{.arg} [direction]{.arg} 
[point1]{.ins} [+]{.sub} [point2]{.arg} 
[point1]{.ins} [-]{.sub} [point2]{.arg} 
[point]{.ins} [by]{.sub} [distance]{.arg} [direction]{.arg} 
[point1]{.ins} [|]{.sub} [point2]{.arg} 
[n]{.ins} [between]{.sub} [poin1]{.arg} [point2]{.arg} 
[intersect]{.cmd} [elem1]{.arg} [elem2]{.arg} 
[element]{.ins} [names]{.sub} [pattern]{.optarg} 
[nth]{.cmd} [corner]{.optarg} 
[nth]{.cmd} [last]{.sub} [corner]{.optarg} 
[nth]{.cmd} [shape]{.arg} [corner]{.optarg} 
[nth]{.cmd} [last]{.sub} [shape]{.arg} [corner]{.optarg} 
[last]{.cmd} [corner]{.optarg} 
[last]{.cmd} [shape]{.arg} [corner]{.optarg} 
[1st]{.cmd} 
[2nd]{.cmd} 
[3rd]{.cmd} 
:::

*number* *number*

*element* *corner*

*element* *corner1* *corner2*...

*element* ?*corner1*... ?**names** ?*pattern*??\]?

# BESCHREIBUNG

Willkommen bei **diagram**, einem Paket zur einfachen Erstellung von Diagrammen (sic), d. h. 2D-Vektorgrafiken, die manchmal auch als *Bilder* bezeichnet werden. Hinweis: Dieses Paket ist kein Ersatz für die „Canvas“ von **Tk**, sondern vielmehr eine darüber liegende Ebene, die die Nutzung vereinfacht. Mit anderen Worten: Durch die Nutzung des „Canvas“ als zentrale Grafik-Engine abstrahiert **diagram** die Feinheiten der Verarbeitung von Koordinaten bei der Positionierung und Größenanpassung der gezeichneten Elemente, sodass sich der Benutzer stattdessen auf den Inhalt des Diagramms konzentrieren kann.

Dies ähnelt der PIC-Sprache von Brian Kernighan für troff, die als geistiger Vorläufer dieses Pakets gilt.

Dieses Dokument enthält eine Übersicht über die API- und Zeichnungsbefehle (Sprache). Es richtet sich an Nutzer des Pakets, die ihr Wissen auffrischen möchten. Einsteiger sollten zunächst das *Tutorial zur Diagrammsprache* lesen. Entwickler, die an den internen Strukturen des Pakets und seiner unterstützenden Pakete arbeiten möchten, sollten zunächst den Abschnitt **DIAGRAMMKLASSEN** lesen und anschließend die Kommentare im Quellcode der Pakete selbst.

Im weiteren Verlauf dieses Dokuments beschreiben wir zunächst die APIs der Diagrammklasse und ihrer Instanzen, gefolgt von der Sprachreferenz für die Zeichensprache selbst.

# API

## API für Klassen

Das Paket exportiert die hier beschriebene API.

**::diagram** *objectName* *canvas* ?*script*?
: Der Befehl erstellt eine neue Instanz eines Diagramm-Controllers und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück. Die neue Instanz wird mit dem angegebenen *canvas*-Objekt verbunden, das als Grafik-Engine für das Diagramm dient. In der Regel handelt es sich dabei um eine Instanz von Tks *canvas*; es kann jedoch jedes Objekt verwendet werden, das eine API-Kompatibilität mit Tks *canvas* hat. Die API dieses Objektbefehls wird im folgenden Abschnitt „**Objekt-API**“ beschrieben. Sie kann verwendet werden, um verschiedene Operationen auf dem Objekt auszuführen. Wenn das Argument *script* angegeben ist, wird die Methode **draw** darauf aufgerufen.


## Objekt-API

Instanzen der Diagrammklasse unterstützen die folgenden Methoden:

*diagramObject* **new direction** *name* ?*key* *value*...?
: Diese Methode definiert eine neue benannte Richtung und deren Attribute. Letztere werden durch die *key*/*value*-Paare angegeben, die auf den *name* folgen. Den Benutzern steht es weitgehend frei, beliebige Attribute mit einer beliebigen Bedeutung festzulegen. Eine Ausnahme bilden die Bezeichnungen *angle* und *opposite*. Diese sind spezifisch für das Diagramm-Paket und haben eine festgelegte Bedeutung.


**angle**
: Dieses Attribut legt den Winkel der Richtung in Grad fest, wobei 0 nach Osten (nach rechts) und 90 nach Norden (nach oben) zeigt.

**opposite**
: Dieses Attribut legt den Namen der Richtung fest, die als komplementär zu der genannten Richtung betrachtet werden soll.


*diagramObject* **new element** *name* *attributes* *cmdprefix*
: Diese Methode definiert ein neues Grafikelement für die Zeichensprache. Das heißt, *name* wird zu einem neuen Befehl in der Sprache, und das angegebene Befehlspräfix (*cmdprefix*) wird aufgerufen, um die eigentliche Zeichnung auszuführen. *attributes* legt die Menge der Attribute fest, für die Daten verfügbar sein müssen. Das heißt, das System führt für diese Attribute die Methode …-callbacks aus. Weitere Informationen zu Attributdefinitionen finden Sie in der Methode **new attribute**. Der Befehls-Präfix muss der folgenden Signatur entsprechen:


**cmdprefix** *canvas* *attributes*
: Dabei ist *canvas* der Handle des Canvas-Widgets, auf dem gezeichnet werden soll, und *attributes* ein Dictionary, das die Attribute des Elements enthält, unabhängig davon, ob es sich um benutzerdefinierte oder um Standardwerte handelt. Das Ergebnis des Befehls muss eine Liste sein, die mindestens zwei und höchstens vier Elemente enthält. Diese sind in der folgenden Reihenfolge:


**\[1\]**
: Die Liste der Canvas-Elemente, aus denen das gezeichnete Element besteht.

**\[2\]**
: Das Dictionary der benannten Positionen innerhalb der Elemente, seine *Ecken*.

**\[3\]**
: Ein optionaler Modus, entweder „relativ“ oder „absolut“. Wird kein Wert gegeben, wird „relativ“ angenommen. Bei einer relativen Elementposition werden die Attribute „with“ und „at“ verwendet, um die endgültige Position des neuen Elements zu bestimmen.

**\[4\]**
: Ein optionaler Name für eine Ausrichtung. Wenn es sich nicht um eine leere Zeichenkette handelt, wird dieser Wert dem automatischen Layout-Modul als neue Ausrichtung übergeben.


*diagramObject* **new alias** *name* *cmdprefix*
: Diese Methode definiert einen neuen Befehl für die Zeichensprache. Das heißt, *name* wird zu einem neuen Befehl in der Sprache, und bei Verwendung dieses neuen Befehls wird das angegebene Befehlspräfix (*cmdprefix*) aufgerufen. Alle an den Befehl übergebenen Argumente werden einfach an das Präfix weitergeleitet. Es gibt keine festgelegte Signatur. Hinweis: Das Präfix wird im Kontext der Zeichensprache ausgeführt, wodurch die direkte Verwendung aller vorhandenen Befehle möglich ist.

*diagramObject* **new command** *name* *arguments* *body*
: Dies entspricht **new alias**, mit dem Unterschied, dass der neue Befehl als Prozedur im Kontext der Sprache definiert ist, mit einer regulären Argumentliste und einem regulären Prozedurkörper.

*diagramObject* **new attribute** *name* ?*key* *value*...?
: Diese Methode definiert ein neues benanntes Attribut, das von grafischen Elementen verwendet werden kann. Die Verarbeitung des Attributs durch den Prozessor wird durch die *key*/*value*-Paare festgelegt, die auf den *name* folgen. Die zulässigen Schlüssel und ihre Bedeutungen lauten:


**key**
: Der Wert dieses Schlüssels ist der Name des Schlüssels, unter dem der Wert des Attributs nach Abschluss der Attributverarbeitung in dem dem Zeichnungsbefehl übergebenen Attribut-Dictionary gespeichert werden soll. Dieser Schlüssel ist optional. Wird er nicht angegeben, wird standardmäßig der Name des Attributs verwendet.

**get**
: Der Wert dieses Schlüssels ist ein Befehlspräfix, das aufgerufen wird, um das bzw. die Argumente des Attributs über die Befehlszeile abzurufen. Dieser Schlüssel ist optional. Wird er nicht angegeben, wird ein Standardwert verwendet, der das einzelne Wort nach dem Attributnamen als Wert des Attributs übernimmt. Die Signatur des Befehlspräfixes lautet


**cmdprefix** *wordqueue*
: Dabei ist *wordqueue* das Handle eines Warteschlangenobjekts, das der API der vom Paket **struct::queue** bereitgestellten Warteschlangen entspricht. Diese Warteschlange enthält den noch nicht verarbeiteten Teil der Attributdefinitionen, wobei pro Wort ein Eintrag vorhanden ist und der erste Eintrag den Namen des Attributs *nach* dem Wort enthält. Mit anderen Worten: Der Name des Attributs wurde bereits aus der Warteschlange entfernt. Das Ergebnis des Befehls ist der Wert des Attributs, der möglicherweise aus der Warteschlange entnommen wurde – oder auch nicht.


**transform**
: Der Wert dieses Schlüssels ist ein Befehlspräfix, das aufgerufen wird, um den abgerufenen Wert (siehe **get**) in seine endgültige Form umzuwandeln. Dieser Schlüssel ist optional. Wird er nicht angegeben, erfolgt keine Transformation. Die Signatur des Befehlspräfixes lautet


**cmdprefix** *value*
: Dabei ist *value* der zu transformierende Wert. Das Ergebnis des Befehls ist der endgültige Wert des Attributs.


**type**
: Der Wert dieses Schlüssels ist ein Befehlspräfix, das zur Validierung der Argumente des Attributs aufgerufen wird. Dieser Schlüssel ist optional. Wird er nicht angegeben, findet keine Validierung statt. Die Signatur des Befehlspräfixes entspricht der der Snit-Validierungstypen. Siehe die Dokumentation zum Paket **snit**.

**merge**
: Der Wert dieses Schlüssels ist ein Befehlspräfix, das aufgerufen wird, um den transformierten und validierten Attributwert in das Dictionary der erfassten Attribute einzufügen. Dieser Schlüssel ist optional. Wird er nicht angegeben, wird eine Standardzusammenführung gewählt, die auf den Daten für den Schlüssel **aggregate** basiert (siehe unten). Die Signatur des Befehlspräfixes lautet


**cmdprefix** *value* *dict*
: Dabei ist *value* der einzufügende Wert und *dict* das bisher gesammelte Dictionary aus Attributen und Werten. Das Ergebnis des Befehls ist das neue Dictionary.


**aggregate**
: Der Wert dieses Schlüssels ist ein boolescher Schalter. Er wirkt sich genau dann aus, wenn der Schlüssel **merge** nicht angegeben wurde. Dieser Schlüssel ist optional. Wird er nicht angegeben, wird standardmäßig der Wert **False** verwendet. Wenn der Schlüssel aktiv ist, bedeutet der Wert von **False**, dass der Wert des Attributs unter Verwendung des Werts des Schlüssels *key* (siehe oben) als Index in das Dictionary *eingetragen* wird, wobei jeder zuvor angegebene Wert *überschrieben* wird. Wenn der Schlüssel aktiv ist, bedeutet der Wert von **True**, dass der Wert des Attributs unter Verwendung des Werts des Schlüssels *key* (siehe oben) als Index in das Dictionary *hinzugefügt* wird, wodurch zuvor angegebene Werte *erweitert* werden. Dies bedeutet, dass der endgültige Wert des Attributs nach dem Prozess eine Liste der gesammelten Werte sein wird.

**default**
: Der Wert dieses Schlüssels ist ein Befehlspräfix, das aufgerufen wird, nachdem die Erfassung der Attribute abgeschlossen ist und dieses Attribut in der Liste der erforderlichen Attribute für das Zeichenelement enthalten ist (siehe Argument *attributes* der Methode **new element**). Beachten Sie, dass die Verbindung über den Wert des Schlüssels *key* hergestellt wird, nicht über den Attributnamen an sich. Beachten Sie ferner, dass dieses Befehlspräfix auch dann aufgerufen wird, wenn ein vom Benutzer angegebener Attributwert vorhanden ist. Dadurch kann der Befehl über das bloße Setzen von Standardwerten hinausgehen und auch abgeleitete Werte berechnen und speichern. Dieser Schlüssel ist optional. Wenn ein Element dieses Attribut benötigt, *default* jedoch nicht angegeben ist, wird nichts unternommen. Die Signatur des Befehlspräfixes lautet


**cmdprefix** **init**
: Diese Methode wird ausgeführt, wenn das Attribut definiert wird. Ihre Aufgabe besteht darin, alle Elemente im Namespace für das Attribut zu initialisieren und die Standardverarbeitung durchzuführen. Das Ergebnis dieser Methode wird ignoriert.

**cmdprefix** **fill** *varname*
: Diese Methode wird ausgeführt, um Standardwerte oder abgeleitete Werte in das durch *varname* benannte AttributDictionary einzutragen. Diese Variable wird im aufrufenden Kontext gesucht. Das Ergebnis dieser Methode wird ignoriert.

**cmdprefix** **set** *name* *value*
: Diese Methode wird aufgerufen, um den aktuellen Wert eines Attributs in den Namespace der Sprache zu übertragen, damit dieser zum neuen Standardwert wird. Das Ergebnis dieser Methode wird ignoriert.


**linked**
: Dieser Schlüssel ist genau dann wirksam, wenn der Schlüssel **default** nicht angegeben ist. In diesem Fall stellt er eine Standardbehandlung für **default** bereit, indem er das Attribut mit einer Variable im Sprachkontext verknüpft. Der Wert für diesen Schlüssel ist eine Liste mit zwei Elementen, die in dieser Reihenfolge den Namen der zu verknüpfenden Variablen und deren Anfangswert enthält.


*diagramObject* **unknown attribute** *cmdprefix*
: Diese Methode registriert das Befehlspräfix bei dem Subsystem, das die Attribute für Elementbefehle verarbeitet, und weist es an, dieses Präfix aufzurufen, sobald es auf ein Attribut stößt, das es nicht eigenständig verarbeiten kann. Es ist zulässig, mehr als eine Rückruffunktion zu registrieren; diese werden in der Reihenfolge ihrer Registrierung (d. h. von vorne nach hinten) aufgerufen, bis eine der Rückruffunktionen die aktuelle Eingabe akzeptiert. Das Befehlspräfix muss der folgenden Signatur entsprechen:


**cmdprefix** *wordqueue*
: Dabei ist *wordqueue* das Handle eines Warteschlangen-Objekts, das der API der vom Paket **struct::queue** bereitgestellten Warteschlangen entspricht. Diese Warteschlange enthält den noch nicht verarbeiteten Teil der Attributdefinitionen, mit einem Eintrag pro Wort, wobei der erste Eintrag den Namen des Attributs enthält, das nicht verarbeitet werden konnte. Das Ergebnis des Befehls muss ein boolescher Wert sein, wobei **True** signalisiert, dass diese Rückruffunktion das Attribut akzeptiert und verarbeitet hat und der neue Zustand von *wordqueue* den Punkt angibt, an dem die allgemeine Verarbeitung fortgesetzt werden soll. Angesichts der Signatur verfügt der Befehl im Wesentlichen über zwei Möglichkeiten, die von ihm erkannten Attribute zu verarbeiten (umzuschreiben):


**\[1\]**
: Ersetzt das Attribut (und die Argumente) durch ein anderes Attribut und andere Argumente.

**\[2\]**
: Weitere Wörter am Anfang setzen den allgemeinen Prozess wieder in Gang.


*diagramObject* **draw** *script*
: Diese Methode führt das angegebene *script* im Kontext der Definitionen der Zeichensprache aus. Einzelheiten zu den verfügbaren Befehlen finden Sie im Abschnitt **SPRACHREFERENZ**. *Hinweis*: Das *script* gilt als *vertrauenswürdig*. Es wird im aktuellen Interpreter ausgeführt und hat Zugriff auf dessen gesamte Funktionen. Für die Ausführung nicht vertrauenswürdiger Diagrammskripte sollte dieser Interpreter ein sicherer sein.


# SPRACHREFERENZ

## Elemente

In diesem Abschnitt werden die Befehle für die vordefinierten Zeichenelemente, auch „Formen“ genannt, aufgeführt. Diese Befehle sind alle im Kontext der Sprache definiert. Alle Befehle dieses Abschnitts geben als Ergebnis den Handle des neu erstellten Elements zurück. Dieser Handle existiert auch als Befehl, mit dem die Eckpunkte des Elements (Namen, Werte) abgefragt werden können. Siehe Abschnitt **Verschiedene Befehle**. BILD: Abbildung 02 – Grundformen

**arc** *attr*...
: Bild: figure-02-arc Ein offenes Element mit den entsprechenden Eckpunkten, d. h. „Start“, „Ende“ und „Mitte“. Hinweis: Es weist auch die Windrose geschlossener Elemente als Eckpunkte auf, wobei der Mittelpunkt des Kreises, zu dem der Bogen gehört, als Mittelpunkt der Windrose dient und die anderen Punkte auf dem Kreis, zu dem der Bogen gehört. Es unterstützt die Attribute


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**clockwise**
: ...siehe nächstes...

**cw**
: Legt die Richtung des Elements **arc** fest, in diesem Fall im Uhrzeigersinn. Das komplementäre Attribut lautet **counterclockwise**. Wenn kein Wert festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **clockwise** entnommen wird, deren Standardwert wiederum **false** ist, was einer Richtung gegen den Uhrzeigersinn entspricht.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**counterclockwise**
: ...siehe nächstes...

**ccw**
: Legt die Richtung des Elements **arc** fest, in diesem Fall gegen den Uhrzeigersinn. Das komplementäre Attribut lautet **clockwise**. Wenn kein Wert festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **clockwise** entnommen wird, deren Standardwert wiederum **false** ist, was einer Richtung gegen den Uhrzeigersinn entspricht.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**from** *location*
: Legt fest, welche Stelle das Element „**arc**“ hat. Standardmäßig ist dies die aktuelle Position, wie sie vom Layout-System verwaltet wird.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**radius** *length*
: Legt den Radius des Elements **arc** fest, genauer gesagt den Radius des Kreises, zu dem der dargestellte Bogen gehört. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **arcradius** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **1 cm** entspricht.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**to** *location*
: Legt die Position fest, an der das Element „**arc**“ endet. Standardmäßig wird eine Position gewählt, an der ein 90-Grad-Bogen in der ausgewählten Richtung gezogen wird, beginnend bei „**from**“.


**arrow** *attr*...
: ...siehe nächstes...

**-->** *attr*...
: ...siehe nächstes...

**<-->** *attr*...
: ...siehe nächstes...

**<-->** *attr*...
: BILD: Abbildung-02-Pfeil Ein Alias für das Element **line** (siehe unten), bei dem das Attribut **arrowhead** auf **->** voreingestellt ist, **<->** oder **<-** voreingestellt ist.  Das Element **arrow** entspricht dem Element **-->**.

**block** *script* *attr*...
: Ein geschlossenes Element mit den entsprechenden Ecken, d. h. den acht Himmelsrichtungen der Windrose, sowie einem „Mittelpunkt“. Der Haupteffekt besteht in der Zusammenfassung aller durch das *script* erstellten Elemente zu einem einzigen Element. Dies bedeutet auch, dass die vom Skript erstellten Elemente zwar während der Ausführung des Skripts im Verlauf sichtbar sind, der Verlauf danach jedoch nur noch den Block selbst enthält und nicht mehr die Elemente, aus denen er besteht. Das Skript hat Zugriff auf den aktuellen Zustand aller Variablen im Sprachkontext. Alle Änderungen an den Variablen werden nach der Ausführung des Blocks rückgängig gemacht. Allerdings werden auch alle im Skript festgelegten Variablen als Ecken der Elemente exportiert, sodass Benutzer ihre eigenen benannten Positionen im Block definieren können. Was den Layout-Mechanismus betrifft, so werden alle durch das Skript vorgenommenen Änderungen rückgängig gemacht, sobald das Element fertiggestellt ist. Mit anderen Worten: Ein Block ist ein implizites **group**. Blöcke verarbeiten alle Attribute und geben deren Einstellungen als Standardwerte an das Skript weiter, die während der Skriptausführung aktiv sind.

**box** *attr*...
: Bild: Abbildung 02 – Kasten Ein geschlossenes Element mit den entsprechenden Ecken, d. h. den acht Himmelsrichtungen der Windrose, sowie dem „Mittelpunkt“. Es verwaltet die Attribute


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**at** *location*
: Legt die Position der Ecke des Elements fest, die durch das Attribut **with** benannt ist. Standardmäßig wird die aktuelle Position verwendet, wie sie vom Layout-System verwaltet wird.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**height** *length*
: ...siehe nächstes...

**ht** *length*
: Legt die Höhe des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxheight** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**slant** *angle*
: Legt den Winkel fest, um den das Element **box** geneigt ist, in Grad. Wenn kein Wert festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **slant** entnommen wird, deren Standardwert wiederum **90** ist, d. h. vertikal, ohne Neigung. 0 Grad entspricht einer Neigung direkt nach Osten, wobei die Spitze nach rechts zeigt. 90 Grad entsprechen einer Neigung nach Norden, wobei das Element senkrecht nach oben zeigt.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**width** *length*
: ...siehe nächstes...

**wid** *length*
: Legt die Breite des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxwidth** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**with** *corner*
: Legt die Ecke des Elements fest, die an der durch das Attribut **at** angegebenen Position platziert werden soll. Standardmäßig wird die aktuelle Ecke verwendet, wie sie vom Layout-System verwaltet wird, es sei denn, der Wert für **at** wurde vom Benutzer festgelegt. In diesem Fall wird standardmäßig der Wert **center** verwendet.


**circle** *attr*...
: ...siehe nächstes...

**O** *attr*...
: Bild: Abbildung 02 – Kreis Ein geschlossenes Element mit den entsprechenden Ecken, d. h. den acht Himmelsrichtungen der Windrose, sowie einem „Mittelpunkt“. Es verfügt über folgende Attribute:


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**at** *location*
: Legt die Position der Ecke des Elements fest, die durch das Attribut **with** benannt ist. Standardmäßig wird die aktuelle Position verwendet, wie sie vom Layout-System verwaltet wird.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**diameter** *length*
: ...siehe nächstes...

**diam** *length*
: Legt den Durchmesser des Elements „**circle**“ fest und stellt damit eine alternative Möglichkeit zur Angabe seines Radius („**radius**“) dar. Gilt genau dann, wenn der Radius nicht angegeben wurde. Das heißt, wenn sowohl Durchmesser als auch Radius angegeben sind, hat die Angabe des Radius Vorrang. Dieses Attribut hat keinen Standardwert, da die Standardwerte aus dem Radius übernommen werden.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**radius** *length*
: ...siehe nächstes...

**rad** *length*
: Legt den Radius des Elements **circle** fest. Wird dieser nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **circleradius** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **1 cm** entspricht.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**with** *corner*
: Legt die Ecke des Elements fest, die an der durch das Attribut **at** angegebenen Position platziert werden soll. Standardmäßig wird die aktuelle Ecke verwendet, wie sie vom Layout-System verwaltet wird, es sei denn, der Wert für **at** wurde vom Benutzer festgelegt. In diesem Fall wird standardmäßig der Wert **center** verwendet.


**diamond** *attr*...
: ...siehe nächstes...

**<>** *attr*...
: Bild: Bild 02 – Diamant Ein geschlossenes Element mit den entsprechenden Ecken, d. h. den acht Himmelsrichtungen der Windrose, sowie einem „Mittelpunkt“. Es verwaltet die Attribute


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**aspect** *number*
: Legt das Seitenverhältnis, d. h. das Verhältnis von Breite zu Höhe, des Elements **diamond** fest. Die Art und Weise, wie ein Standardwert berechnet wird, wenn keine Angabe erfolgt, hängt zudem von den Angaben der Attribute **width** und **height** ab, sofern vorhanden. Wenn sowohl **width** als auch **height** festgelegt sind, wird jede Angabe von **aspect** ignoriert, da diese implizit auch in der Breite / Höhe definiert ist und diese Vorrang hat. Eine fehlende Angabe wird in diesem Fall ebenfalls ignoriert, d. h., es sind keine Standardwerte erforderlich. Wenn **aspect** festgelegt wird und eines der Attribute **width** oder **height**, dann wird das fehlende Attribut aus den beiden angegebenen Attributen berechnet. Auch in diesen Fällen sind keine Standardwerte erforderlich. Wenn nur eines der Attribute **width** oder **height** festgelegt wird, verwendet das System für **aspect** einen Fallback, wobei der Wert aus der Sprachvariablen **diamondaspect** entnommen wird, die ihrerseits standardmäßig auf **2** gesetzt ist. Wenn keines der Attribute **width** oder **height** festgelegt wird, verwendet das System einen Fallback für **width**, den Wert aus der Sprachvariablen **boxwidth**, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Für das Seitenverhältnis wird entweder der vom Benutzer angegebene Wert oder der wie im vorigen Absatz beschriebene Standardwert verwendet.

**at** *location*
: Legt die Position der Ecke des Elements fest, die durch das Attribut **with** benannt ist. Standardmäßig wird die aktuelle Position verwendet, wie sie vom Layout-System verwaltet wird.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**height** *length*
: Legt die Höhe des Elements **diamond** fest. Die Art und Weise, wie ein Standardwert berechnet wird, wenn dieser nicht angegeben ist, hängt auch von den Angaben der Attribute **aspect** und **width** ab, sofern vorhanden. Wenn sowohl **width** als auch **height** festgelegt sind, wird jede Angabe für **aspect** ignoriert, da diese implizit auch in der Breite / Höhe definiert ist und diese Angaben Vorrang haben. Eine fehlende Angabe wird in diesem Fall ebenfalls ignoriert, d. h., es sind keine Standardwerte erforderlich. Wenn **aspect** festgelegt wird und eines der Attribute **width** oder **height**, dann wird das fehlende Attribut aus den beiden angegebenen Attributen berechnet. Auch in diesen Fällen sind keine Standardwerte erforderlich. Wenn nur eines der Attribute **width** oder **height** festgelegt wird, verwendet das System für **aspect** einen Fallback, wobei der Wert aus der Sprachvariablen **diamondaspect** entnommen wird, deren Standardwert wiederum **2** ist. Wenn keines der Attribute **width** oder **height** festgelegt ist, verwendet das System einen Fallback für **width**, den Wert aus der Sprachvariablen **boxwidth**, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Für das Seitenverhältnis wird entweder der vom Benutzer angegebene Wert oder der wie im vorigen Absatz beschriebene Standardwert verwendet.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**width** *length*
: Legt die Breite des Elements **diamond** fest. Die Art und Weise, wie ein Standardwert berechnet wird, wenn dieser nicht angegeben ist, hängt auch von den Angaben der Attribute **aspect** und **height** ab, sofern vorhanden. Wenn sowohl **width** als auch **height** festgelegt sind, wird jede Angabe für **aspect** ignoriert, da diese implizit auch in der Breite / Höhe definiert ist und diese Vorrang hat. Eine fehlende Angabe wird in diesem Fall ebenfalls ignoriert, d. h., es sind keine Standardwerte erforderlich. Wenn **aspect** sowie eines der Attribute **width** oder **height** angegeben sind, wird das fehlende Attribut aus den beiden angegebenen Attributen berechnet. Auch in diesen Fällen sind keine Standardwerte erforderlich. Wenn nur eines der Attribute **width** oder **height** festgelegt ist, verwendet das System für **aspect** einen Fallback, wobei der Wert aus der Sprachvariablen **diamondaspect** entnommen wird, die ihrerseits standardmäßig auf **2** gesetzt ist. Wenn keines der Attribute **width** oder **height** festgelegt ist, verwendet das System einen Fallback für **width**, den Wert aus der Sprachvariablen **boxwidth**, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Für das Seitenverhältnis wird entweder der vom Benutzer angegebene Wert oder der wie im vorigen Absatz beschriebene Standardwert verwendet.

**with** *corner*
: Legt die Ecke des Elements fest, die an der durch das Attribut **at** angegebenen Position platziert werden soll. Standardmäßig wird die aktuelle Ecke verwendet, wie sie vom Layout-System verwaltet wird, es sei denn, der Wert für **at** wurde vom Benutzer festgelegt. In diesem Fall wird standardmäßig der Wert **center** verwendet.


**drum** *attr*...
: Bild: Bild 02 – Trommel Ein geschlossenes Element mit den entsprechenden Ecken, d. h. den acht Himmelsrichtungen der Windrose, sowie einem „Mittelpunkt“. Es verwaltet die Attribute


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**aspect** *number*
: Legt das Seitenverhältnis, d. h. das Verhältnis von Breite zu Höhe, der Ellipsen fest, die zum Zeichnen des oberen und unteren Randes des Elements „**drum**“ verwendet werden. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **drumaspect** entnommen wird, deren Standardwert wiederum **0.35** ist.

**at** *location*
: Legt die Position der Ecke des Elements fest, die durch das Attribut **with** benannt ist. Standardmäßig wird die aktuelle Position verwendet, wie sie vom Layout-System verwaltet wird.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**height** *length*
: ...siehe nächstes...

**ht** *length*
: Legt die Höhe des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxheight** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**width** *length*
: ...siehe nächstes...

**wid** *length*
: Legt die Breite des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxwidth** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**with** *corner*
: Legt die Ecke des Elements fest, die an der durch das Attribut **at** angegebenen Position platziert werden soll. Standardmäßig wird die aktuelle Ecke verwendet, wie sie vom Layout-System verwaltet wird, es sei denn, der Wert für **at** wurde vom Benutzer festgelegt. In diesem Fall wird standardmäßig der Wert **center** verwendet.


**ellipse** *attr*...
: Bild: Abbildung 02 – Ellipse Ein geschlossenes Element mit den entsprechenden Ecken, d. h. den acht Himmelsrichtungen der Windrose, und einem „Mittelpunkt“. Es unterstützt die folgenden Attribute


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**at** *location*
: Legt die Position der Ecke des Elements fest, die durch das Attribut **with** benannt ist. Standardmäßig wird die aktuelle Position verwendet, wie sie vom Layout-System verwaltet wird.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**height** *length*
: ...siehe nächstes...

**ht** *length*
: Legt die Höhe des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxheight** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**width** *length*
: ...siehe nächstes...

**wid** *length*
: Legt die Breite des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxwidth** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**with** *corner*
: Legt die Ecke des Elements fest, die an der durch das Attribut **at** angegebenen Position platziert werden soll. Standardmäßig wird die aktuelle Ecke verwendet, wie sie vom Layout-System verwaltet wird, es sei denn, der Wert für **at** wurde vom Benutzer festgelegt. In diesem Fall wird standardmäßig der Wert **center** verwendet.


**line** *attr*...
: ...siehe nächstes...

**--** *attr*...
: Bild: Abbildung-02-Zeile Ein offenes Element mit den entsprechenden Eckpunkten, d. h. „start“, „end“ und „center“. Es unterstützt die folgenden Attribute


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**arrowhead** *spec*
: IMAGE: figure-19-style-arrowheads Legt fest, wo am Element **line** Pfeilspitzen gezeichnet werden sollen: am Anfang, am Ende, an beiden Enden oder gar nicht. Wenn kein Wert festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **arrowhead** übernommen wird, deren Standardwert **keine** ist. Die zulässigen Werte sind


**none**, **-**
: Zeichnen Sie an keinem der beiden Enden der Linie Pfeilspitzen ein.

**start**, **first**, **<-**
: Zeichnen Sie am Anfang der Linie eine Pfeilspitze, jedoch nicht am Ende.

**end**, **last**, **->**
: Zeichnen Sie am Ende der Linie eine Pfeilspitze, jedoch nicht am Anfang.

**both**, **<->**
: Zeichnen Sie an beiden Enden der Linie Pfeilspitzen.


: Hinweis: Die Werte „start“, „end“, „-“, „->“, „<-“ und „<->“ werden alle als Kurzformen für den Befehl **arrowhead** akzeptiert und als Argumente verwendet.


**at** *location*
: **Line**-Elemente werden normalerweise absolut positioniert, wobei die über die Attribute **from**, **then** und **to** festgelegten Positionen verwendet werden. Wenn **at** festgelegt wird, werden diese Positionen ein letztes Mal verschoben, wobei die durch das Attribut **with** benannte Ecke der Linie an die durch dieses Attribut angegebene Position verschoben wird.

**chop** ?*length*?
: Legt die Länge des Elements „**line**“ fest, die am Anfang und/oder am Ende entfernt werden soll. Standardmäßig ist kein Wert festgelegt. Wenn einmal angegeben, gilt die Kürzung sowohl für den Anfang als auch für das Ende der Zeile. Wenn zweimal oder mehrmalig angegeben, werden die letzten beiden Angaben verwendet und in dieser Reihenfolge auf den Anfang und das Ende der Zeile angewendet. Wird das Attribut ohne explizite Längenangabe festgelegt, greift das System auf den Wert zurück, der aus der Sprachvariablen **circleradius** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **1 cm** entspricht.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**from** *location*
: Legt die Position fest, an der das Element „**line**“ beginnt. Standardmäßig ist dies die aktuelle Position, wie sie vom Layout-System verwaltet wird.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**noturn**
: Legt fest, dass die Richtung des Elements „**line**“ an dessen Ende nicht an die Layoutverwaltung weitergegeben wird. Wird dies nicht angegeben, wird die Richtung der Linie zur neuen Richtung im Layout.

**smooth**
: Legt die Verwendung von Bézier-Splines für das Element **line** fest. Wird dies nicht angegeben, werden Linien exakt durch die angegebenen Wegpunkte gezogen, ohne glatte Kurven.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**then** *location*
: ...siehe nächstes...

**then** (\<direction> ?*length*?)...
: ...siehe nächstes...

(\<direction> ?*length*?)...
: Dieses Attribut legt einen Zwischenstandort fest, den das Element „**line**“ durchlaufen muss. Es kann mehrfach angegeben werden, wobei jede Angabe der Reihe einen weiteren Standort hinzufügt, den die Linie durchlaufen wird. Diese Standorte werden in der Reihenfolge durchlaufen, in der sie angegeben wurden. Der Standort kann explizit angegeben werden oder als Reihe von Wegbeschreibungen mit Entfernungsangaben. Im letzteren Fall werden für den Richtungsteil die Namen aller bekannten Richtungen akzeptiert. Wird für eine Richtung keine Entfernung angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **movelength** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Die gesamte Menge der Richtungs-Distanz-Paare wird als eine Abfolge von Verschiebungen behandelt, die addiert werden, um die endgültige Verschiebung zu ergeben, die den Zwischenpunkt (relativ zum vorhergehenden Punkt) festlegt. Der zuletzt genannte Name der Richtung wird als zu befolgende Richtung an das Layout-System weitergegeben. Die Verwendung von **noturn** kann dieses Verhalten nicht außer Kraft setzen. Schließlich dienen die Namen der registrierten Richtungen auch als Attributbefehle, denen implizit das Attribut **then** vorangestellt wird. Wenn für die Linie weder ein Zwischen- noch ein Endpunkt festgelegt werden, greift das System auf einen Punkt zurück, der **movelength** Pixel vom Startpunkt entfernt liegt, und zwar in der aktuellen Richtung, wie sie vom Layout-System verwaltet wird.

**to** *location*
: Legt fest, welche Stelle das Element „**line**“ erreicht. Dieses Attribut hat keinen Standardwert. Der Standardwert wird durch das Attribut **then** geregelt, wodurch der Eindruck entsteht, dass **to** einen Standardwert hat, wenn dieser nicht angegeben wird.

**with** *corner*
: **Line**-Elemente werden normalerweise absolut positioniert, wobei die über die Attribute **from**, **then** und **to** festgelegten Positionen verwendet werden. Wenn **at** festgelegt wird, werden diese Positionen ein letztes Mal verschoben, wobei die durch das Attribut **with** benannte Ecke der Linie an die durch dieses Attribut angegebene Position verschoben wird. Dies bedeutet, dass *with* genau dann wirksam ist, wenn für die Linie zusätzlich das Attribut **at** festgelegt wurde.


**move** *attr*
: Ein offenes Element mit den entsprechenden Ecken, d. h. „start“, „end“ und „center“. Ein **move**-Element ist im Wesentlichen ein unsichtbares **line**. Zwar interessiert uns in erster Linie die Auswirkung, die es auf das Layout-System hat, doch handelt es sich um ein tatsächliches Element, d. h., es verfügt über dieselben Eckpunkte wie eine gewöhnliche Linie und wird auch im Verlauf angezeigt, sodass später auf alle Plätze verwiesen werden kann, die es berührt hat. Es unterstützt dieselben Attribute wie **line**-Elemente.

**spline** *attr*...
: Bild: figure-02-spline Ein Alias für das Element **line** (siehe oben), bei dem das Attribut **smooth** voreingestellt ist.

**text** *attr*...
: Bild: Abbildung-02-Text Ein geschlossenes Element mit den entsprechenden Ecken, d. h. den acht Himmelsrichtungen der Windrose, sowie dem „Mittelpunkt“. Es unterstützt die folgenden Attribute


**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**at** *location*
: Legt die Position der Ecke des Elements fest, die durch das Attribut **with** benannt ist. Standardmäßig wird die aktuelle Position verwendet, wie sie vom Layout-System verwaltet wird.

**height** *length*
: Legt die Höhe des Elements „**text**“ fest. Standardmäßig entspricht diese der natürlichen Höhe des darin enthaltenen Textes.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**width** *length*
: Legt die Breite des Elements „**text**“ fest. Standardmäßig entspricht diese der natürlichen Breite des darin enthaltenen Textes.

**with** *corner*
: Legt die Ecke des Elements fest, die an der durch das Attribut **at** angegebenen Position platziert werden soll. Standardmäßig wird die aktuelle Ecke verwendet, wie sie vom Layout-System verwaltet wird, es sei denn, der Wert für **at** wurde vom Benutzer festgelegt. In diesem Fall wird standardmäßig der Wert **center** verwendet.


## Attribute

Nachstehend ist die Gesamtheit aller Attribute aufgeführt, die von allen Elementbefehlen unterstützt werden. Auch wenn wir sie als Befehle bezeichnen und eine Syntax dafür angeben, stehen sie nicht wirklich als eigenständige Befehle zur Verfügung, sondern lediglich als Teil der Argumente eines Elementbefehls.

Hinweis: Einige der Attributnamen sind überladen, d. h. sie weisen mehrere unterschiedliche Definitionen auf. Bei der Verarbeitung der Attribute eines Elements wird die tatsächlich verwendete Definition anhand des Typs des Elements ausgewählt, für das der Prozess erfolgt.

Darüber hinaus gilt als Auffangklause, dass jedes Attribut, das nicht gemäß den nachstehenden Definitionen verarbeitet werden konnte, als Argument eines impliziten **text**-Attributs behandelt wird.

**anchor** *name*
: ...siehe nächstes...

**ljust**
: ...siehe nächstes...

**rjust**
: ...siehe nächstes...

**above**
: ...siehe nächstes...

**below**
: IMAGE: figure-22-text-anchoring-3 Legt den Anker des Textes fest, der in der Mitte des Elements platziert werden soll, anhand seines Namens. Das heißt, dieses Attribut definiert die Position des Textes relativ zur Mitte des Elements. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **anchor** entnommen wird, deren Standardwert wiederum **center** ist. Zulässige Werte sind alle, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm) akzeptiert werden. Die Befehle ohne Argumente sind allesamt Kurzformen, bei denen der Anker impliziert ist. Beachten Sie, dass sie sich nicht kombinieren lassen; es wird nur der letzte Befehl verwendet. Für kombinierte Ausrichtungen muss der Hauptattributbefehl **anchor** verwendet werden.


**ljust**
: „Anker West“

**rjust**
: „Anker Ost“

**above**
: „Anker Süd“

**below**
: „Anker Nord“


**arrowhead** *spec*
: Bild: figure-19-style-arrowheads Legt fest, wo am Element **line** Pfeilspitzen gezeichnet werden sollen: am Anfang, am Ende, an beiden Enden oder gar nicht. Wenn kein Wert festgelegt wird, greift das System auf den Wert der Sprachvariablen **arrowhead** zurück, deren Standardwert **keine** ist. Die zulässigen Werte sind


**none**, **-**
: Zeichnen Sie an keinem der beiden Enden der Linie Pfeilspitzen ein.

**start**, **first**, **<-**
: Zeichnen Sie am Anfang der Linie eine Pfeilspitze, jedoch nicht am Ende.

**end**, **last**, **->**
: Zeichnen Sie am Ende der Linie eine Pfeilspitze, jedoch nicht am Anfang.

**both**, **<->**
: Zeichnen Sie an beiden Enden der Linie Pfeilspitzen.


: Hinweis: Die Werte „start“, „end“, „-“, „->“, „<-“ und „<->“ werden alle als Kurzformen für den Befehl **arrowhead** akzeptiert und als Argumente verwendet.


**aspect** *number*
: Legt das Seitenverhältnis, d. h. das Verhältnis von Breite zu Höhe, des Elements **diamond** fest. Die Art und Weise, wie ein Standardwert berechnet wird, wenn keine Angabe erfolgt, hängt zudem von den Angaben der Attribute **width** und **height** ab, sofern vorhanden. Wenn sowohl **width** als auch **height** festgelegt sind, wird jede Angabe von **aspect** ignoriert, da diese implizit auch in der Breite / Höhe definiert ist und diese Vorrang hat. Eine fehlende Angabe wird in diesem Fall ebenfalls ignoriert, d. h., es sind keine Standardwerte erforderlich. Wenn **aspect** festgelegt wird und eines der Attribute **width** oder **height**, dann wird das fehlende Attribut aus den beiden angegebenen Attributen berechnet. Auch in diesen Fällen sind keine Standardwerte erforderlich. Wenn nur eines der Attribute **width** oder **height** festgelegt wird, verwendet das System für **aspect** einen Fallback, wobei der Wert aus der Sprachvariablen **diamondaspect** entnommen wird, die ihrerseits standardmäßig auf **2** gesetzt ist. Wenn keines der Attribute **width** oder **height** festgelegt wird, verwendet das System einen Fallback für **width**, den Wert aus der Sprachvariablen **boxwidth**, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Für das Seitenverhältnis wird entweder der vom Benutzer angegebene Wert oder der wie im vorigen Absatz beschriebene Standardwert verwendet.

**aspect** *number*
: Legt das Seitenverhältnis, d. h. das Verhältnis von Breite zu Höhe, der Ellipsen fest, die zum Zeichnen des oberen und unteren Randes des Elements „**drum**“ verwendet werden. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **drumaspect** entnommen wird, deren Standardwert wiederum **0.35** ist.

**at** *location*
: Legt die Position der Ecke des Elements fest, die durch das Attribut **with** benannt ist. Standardmäßig wird die aktuelle Position verwendet, wie sie vom Layout-System verwaltet wird.

**at** *location*
: **Line**-Elemente werden normalerweise absolut positioniert, wobei die über die Attribute **from**, **then** und **to** festgelegten Positionen verwendet werden. Wenn **at** festgelegt wird, werden diese Positionen ein letztes Mal verschoben, wobei die durch das Attribut **with** benannte Ecke der Linie an die durch dieses Attribut angegebene Position verschoben wird.

**chop** ?*length*?
: Legt die Länge des Elements „**line**“ fest, die am Anfang und/oder am Ende entfernt werden soll. Standardmäßig ist kein Wert festgelegt. Wenn einmal angegeben, gilt die Kürzung sowohl für den Anfang als auch für das Ende der Zeile. Wenn zweimal oder mehrmalig angegeben, werden die letzten beiden Angaben verwendet und in dieser Reihenfolge auf den Anfang und das Ende der Zeile angewendet. Wird das Attribut ohne explizite Längenangabe festgelegt, greift das System auf den Wert zurück, der aus der Sprachvariablen **circleradius** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **1 cm** entspricht.

**clockwise**
: ...siehe nächstes...

**cw**
: Legt die Richtung des Elements **arc** fest, in diesem Fall im Uhrzeigersinn. Das komplementäre Attribut lautet **counterclockwise**. Wenn kein Wert festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **clockwise** entnommen wird, deren Standardwert wiederum **false** ist, was einer Richtung gegen den Uhrzeigersinn entspricht.

**color** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der die Linien des Elements gezeichnet werden. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linecolor** entnommen wird, deren Standardwert wiederum **black** ist.

**counterclockwise**
: ...siehe nächstes...

**ccw**
: Legt die Richtung des Elements **arc** fest, in diesem Fall gegen den Uhrzeigersinn. Das komplementäre Attribut lautet **clockwise**. Wenn kein Wert festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **clockwise** entnommen wird, deren Standardwert wiederum **false** ist, was einer Richtung gegen den Uhrzeigersinn entspricht.

**diameter** *length*
: ...siehe nächstes...

**diam** *length*
: Legt den Durchmesser des Elements „**circle**“ fest und stellt damit eine alternative Möglichkeit zur Angabe seines Radius („**radius**“) dar. Gilt genau dann, wenn der Radius nicht angegeben wurde. Das heißt, wenn sowohl Durchmesser als auch Radius angegeben sind, hat die Angabe des Radius Vorrang. Dieses Attribut hat keinen Standardwert, da die Standardwerte aus dem Radius übernommen werden.

**fillcolor** *spec*
: BILD: figure-21-style-colors Legt die Farbe fest, mit der der Innenbereich des Elements gezeichnet wird. Wird keine Angabe gemacht, greift das System auf den Wert der Sprachvariablen **fillcolor** zurück, deren Standardwert die leere Zeichenkette ist, was „keine Füllung“ bedeutet.

**from** *location*
: Legt die Position fest, an der das Element „**line**“ beginnt. Standardmäßig ist dies die aktuelle Position, wie sie vom Layout-System verwaltet wird.

**from** *location*
: Legt die Position fest, an der das Element „**arc**“ beginnt. Standardmäßig ist dies die aktuelle Position, wie sie vom Layout-System verwaltet wird.

**height** *length*
: ...siehe nächstes...

**ht** *length*
: Legt die Höhe des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxheight** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**height** *length*
: Legt die Höhe des Elements **diamond** fest. Die Art und Weise, wie ein Standardwert berechnet wird, wenn dieser nicht angegeben ist, hängt auch von den Angaben der Attribute **aspect** und **width** ab, sofern vorhanden. Wenn sowohl **width** als auch **height** festgelegt sind, wird jede Angabe für **aspect** ignoriert, da diese implizit auch in der Breite / Höhe definiert ist und diese Angaben Vorrang haben. Eine fehlende Angabe wird in diesem Fall ebenfalls ignoriert, d. h., es sind keine Standardwerte erforderlich. Wenn **aspect** festgelegt wird und eines der Attribute **width** oder **height**, dann wird das fehlende Attribut aus den beiden angegebenen Attributen berechnet. Auch in diesen Fällen sind keine Standardwerte erforderlich. Wenn nur eines der Attribute **width** oder **height** festgelegt wird, verwendet das System für **aspect** einen Fallback, wobei der Wert aus der Sprachvariablen **diamondaspect** entnommen wird, deren Standardwert wiederum **2** ist. Wenn keines der Attribute **width** oder **height** festgelegt ist, verwendet das System einen Fallback für **width**, den Wert aus der Sprachvariablen **boxwidth**, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Für das Seitenverhältnis wird entweder der vom Benutzer angegebene Wert oder der wie im vorigen Absatz beschriebene Standardwert verwendet.

**height** *length*
: Legt die Höhe des Elements „**text**“ fest. Standardmäßig entspricht diese der natürlichen Höhe des darin enthaltenen Textes.

**justify** **left**|**center**|**right**
: Legt fest, wie mehrzeiliger Text, der dem Element zugeordnet ist, innerhalb seines Rahmens positioniert wird. Der Wert wird ignoriert, wenn für das Element kein Text angegeben wurde. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **justify** entnommen wird, deren Standardwert wiederum **left** ist. Die zulässigen Werte sind **left**, **right** und **center**.

**noturn**
: Legt fest, dass die Richtung des Elements „**line**“ an dessen Ende nicht an die Layoutverwaltung weitergegeben wird. Wird dies nicht angegeben, wird die Richtung der Linie zur neuen Richtung im Layout.

**radius** *length*
: ...siehe nächstes...

**rad** *length*
: Legt den Radius des Elements **circle** fest. Wird dieser nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **circleradius** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **1 cm** entspricht.

**radius** *length*
: Legt den Radius des Elements **arc** fest, genauer gesagt den Radius des Kreises, zu dem der dargestellte Bogen gehört. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **arcradius** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **1 cm** entspricht.

**slant** *angle*
: Legt den Winkel fest, um den das Element **box** geneigt ist, in Grad. Wenn kein Wert festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **slant** entnommen wird, deren Standardwert wiederum **90** ist, d. h. vertikal, ohne Neigung. 0 Grad entspricht einer Neigung direkt nach Osten, wobei die Spitze nach rechts zeigt. 90 Grad entsprechen einer Neigung nach Norden, wobei das Element senkrecht nach oben zeigt.

**smooth**
: Legt die Verwendung von Bézier-Splines für das Element **line** fest. Wird dies nicht angegeben, werden Linien exakt durch die angegebenen Wegpunkte gezogen, ohne glatte Kurven.

**stroke** *width*
: IMAGE: figure-20-style-stroke Legt die Breite der für das Element gezeichneten Linien in Pixeln fest. Wenn dieser Wert nicht festgelegt wird, greift das System auf den Wert zurück, der aus der Sprachvariablen **linewidth** entnommen wird, deren Standardwert wiederum **1** ist.

**style** *spec*
: IMAGE: figure-18-style-dash Legt den Stil fest, der zum Zeichnen der Linien des Elements verwendet wird. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **linestyle** entnommen wird, deren Standardwert wiederum **solid** lines ist. Zulässige Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


: Hinweis: Die Werte „solid“, „dot(ted)“, „dash(ed)“, „dash-dot“ und „dash-dot-dot“ werden alle als Kurzformen für den Befehl **style** akzeptiert, wenn sie als Argument verwendet werden.


**text** *string*
: Legt den Text fest, der dem Element zugeordnet werden soll. Standardmäßig ist kein Text angegeben. Bei mehrfacher Angabe entspricht der tatsächlich angezeigte Text der Verkettung der einzelnen Zeichenfolgen, die vertikal übereinandergestapelt werden, wobei die zuerst angegebene Zeichenfolge ganz oben steht.

**textcolor** *spec*
: Legt die Farbe fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textcolor** entnommen wird, deren Standardwert wiederum **black** ist.

**textfont** *spec*
: Legt die Schriftart fest, mit der der Text eines Elements dargestellt wird. Wird ignoriert, wenn kein Text vorhanden ist. Wird dieser Wert nicht angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **textfont** entnommen wird, deren Standardwert wiederum **Helvetica 12pt** ist.

**then** *location*
: ...siehe nächstes...

**then** (\<direction> ?*length*?)...
: ...siehe nächstes...

(\<direction> ?*length*?)...
: Dieses Attribut legt einen Zwischenstandort fest, den das Element „**line**“ durchlaufen muss. Es kann mehrfach angegeben werden, wobei jede Angabe der Reihe einen weiteren Standort hinzufügt, den die Linie durchlaufen wird. Diese Standorte werden in der Reihenfolge durchlaufen, in der sie angegeben wurden. Der Standort kann explizit angegeben werden oder als Reihe von Wegbeschreibungen mit Entfernungsangaben. Im letzteren Fall werden für den Richtungsteil die Namen aller bekannten Richtungen akzeptiert. Wird für eine Richtung keine Entfernung angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **movelength** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Die gesamte Menge der Richtungs-Distanz-Paare wird als eine Abfolge von Verschiebungen behandelt, die addiert werden, um die endgültige Verschiebung zu ergeben, die den Zwischenpunkt (relativ zum vorhergehenden Punkt) festlegt. Der zuletzt genannte Name der Richtung wird als zu befolgende Richtung an das Layout-System weitergegeben. Die Verwendung von **noturn** kann dieses Verhalten nicht außer Kraft setzen. Schließlich dienen die Namen der registrierten Richtungen auch als Attributbefehle, denen implizit das Attribut **then** vorangestellt wird. Wenn für die Linie weder ein Zwischen- noch ein Endpunkt festgelegt werden, greift das System auf einen Punkt zurück, der **movelength** Pixel vom Startpunkt entfernt liegt, und zwar in der aktuellen Richtung, wie sie vom Layout-System verwaltet wird.

**to** *location*
: Legt fest, welche Stelle das Element „**line**“ erreicht. Dieses Attribut hat keinen Standardwert. Der Standardwert wird durch das Attribut **then** geregelt, wodurch der Eindruck entsteht, dass **to** einen Standardwert hat, wenn dieser nicht angegeben wird.

**to** *location*
: Legt die Position fest, an der das Element „**arc**“ endet. Standardmäßig wird eine Position gewählt, an der ein 90-Grad-Bogen in der ausgewählten Richtung gezogen wird, beginnend bei „**from**“.

**width** *length*
: ...siehe nächstes...

**wid** *length*
: Legt die Breite des Elements fest. Wird kein Wert angegeben, greift das System auf den Wert zurück, der aus der Sprachvariablen **boxwidth** entnommen wird, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht.

**width** *length*
: Legt die Breite des Elements **diamond** fest. Die Art und Weise, wie ein Standardwert berechnet wird, wenn dieser nicht angegeben ist, hängt auch von den Angaben der Attribute **aspect** und **height** ab, sofern vorhanden. Wenn sowohl **width** als auch **height** festgelegt sind, wird jede Angabe für **aspect** ignoriert, da diese implizit auch in der Breite / Höhe definiert ist und diese Vorrang hat. Eine fehlende Angabe wird in diesem Fall ebenfalls ignoriert, d. h., es sind keine Standardwerte erforderlich. Wenn **aspect** sowie eines der Attribute **width** oder **height** angegeben sind, wird das fehlende Attribut aus den beiden angegebenen Attributen berechnet. Auch in diesen Fällen sind keine Standardwerte erforderlich. Wenn nur eines der Attribute **width** oder **height** festgelegt ist, verwendet das System für **aspect** einen Fallback, wobei der Wert aus der Sprachvariablen **diamondaspect** entnommen wird, die ihrerseits standardmäßig auf **2** gesetzt ist. Wenn keines der Attribute **width** oder **height** festgelegt ist, verwendet das System einen Fallback für **width**, den Wert aus der Sprachvariablen **boxwidth**, deren Standardwert wiederum dem Pixeläquivalent von **2 cm** entspricht. Für das Seitenverhältnis wird entweder der vom Benutzer angegebene Wert oder der wie im vorigen Absatz beschriebene Standardwert verwendet.

**width** *length*
: Legt die Breite des Elements „**text**“ fest. Standardmäßig entspricht diese der natürlichen Breite des darin enthaltenen Textes.

**with** *corner*
: Legt die Ecke des Elements fest, die an der durch das Attribut **at** angegebenen Position platziert werden soll. Standardmäßig wird die aktuelle Ecke verwendet, wie sie vom Layout-System verwaltet wird, es sei denn, der Wert für **at** wurde vom Benutzer festgelegt. In diesem Fall wird standardmäßig der Wert **center** verwendet.

**with** *corner*
: **Line**-Elemente werden normalerweise absolut positioniert, wobei die über die Attribute **from**, **then** und **to** festgelegten Positionen verwendet werden. Wenn **at** festgelegt wird, werden diese Positionen ein letztes Mal verschoben, wobei die durch das Attribut **with** benannte Ecke der Linie an die durch dieses Attribut angegebene Position verschoben wird. Dies bedeutet, dass *with* genau dann wirksam ist, wenn für die Linie zusätzlich das Attribut **at** festgelegt wurde.


## Ecken

Ecken sind Namen für Werte in Elementen, in der Regel Positionen.

**•**
: Die *geschlossenen* Elemente definieren die Ecken der Windrose, einschließlich des „Zentrums“, sowie deren „Breite“ und „Höhe“. BILD: Abbildung 27 – Ecken – geschlossen

**•**
: Die Elemente „**block**“ exportieren zusätzlich alle Variablen, die bei ihren Definitionen als Eckpunkte festgelegt wurden.

**•**
: Die *open*-Elemente hingegen definieren „start“, „end“ und „center“. Die ersten beiden werden den Positionen zugeordnet, die ursprünglich über die Attribute **from** und **to** des Elements angegeben wurden. Bild: Bild 28 – Ecken – „open“

**•**
: Der Mittelpunkt der Elemente **line** und **move** befindet sich auf halbem Weg zwischen der „Start“- und der „End“-Ecke, und zwar unabhängig von etwaigen Zwischenpunkten, die das Element aufweisen mag.

**•**
: Die Elemente **line** und **move** bezeichnen zudem alle ihre Positionen als Ecken, wobei sie Nummern als Namen verwenden, beginnend mit **1** (entspricht „start“), in der Reihenfolge der Abtastung. Bild: Abbildung 15 – Spline

**•**
: Der Mittelpunkt der Elemente von **arc** ist der Mittelpunkt des Kreises, zu dem der Bogen gehört.

**•**
: Die Elemente **arc** definieren zudem die Kompassrose geschlossener Elemente.


## Benannte Richtungen

Die genannten Richtungen sind Befehle, die dem Layout-System mitteilen, in welche Richtung es beim Platzieren des nächsten Elements ohne explizite Positionsangabe vorgehen soll. Sie können auch als Argumente für das Attribut **then** sowie für den Befehl **by** bei relativen Punkten verwendet werden; die entsprechende Syntax finden Sie dort.

Der Diagrammkern definiert die Richtungen der Windrose sowie eine Reihe von Aliasen. Die vollständige Liste finden Sie weiter unten.

Bild: Abbildung-27-Ecken-geschlossen

Dies überschneidet sich mit den vordefinierten Ecken für geschlossene Elemente. Das Layout-System nutzt dies folgendermaßen: Wenn Sie sich in X-Richtung bewegen, entspricht der Name der entgegengesetzten Richtung dem Namen der Ecke, an der das neue Element an die aktuelle Position angefügt wird; existiert diese Ecke nicht, wird die winkelmäßig nächstgelegene tatsächliche Ecke verwendet.

**west**
: ...siehe nächstes...

**w**
: ...siehe nächstes...

**left**
: ...siehe nächstes...

**l**
: ...siehe nächstes...

**south**
: ...siehe nächstes...

**s**
: ...siehe nächstes...

**down**
: ...siehe nächstes...

**bottom**
: ...siehe nächstes...

**bot**
: ...siehe nächstes...

**b**
: ...siehe nächstes...

**east**
: ...siehe nächstes...

**e**
: ...siehe nächstes...

**right**
: ...siehe nächstes...

**r**
: ...siehe nächstes...

**north**
: ...siehe nächstes...

**n**
: ...siehe nächstes...

**up**
: ...siehe nächstes...

**top**
: ...siehe nächstes...

**t**
: ...siehe nächstes...

**northwest**
: ...siehe nächstes...

**nw**
: ...siehe nächstes...

**up-left**
: ...siehe nächstes...

**upleft**
: ...siehe nächstes...

**leftup**
: ...siehe nächstes...

**northeast**
: ...siehe nächstes...

**ne**
: ...siehe nächstes...

**up-right**
: ...siehe nächstes...

**upright**
: ...siehe nächstes...

**rightup**
: ...siehe nächstes...

**southwest**
: ...siehe nächstes...

**sw**
: ...siehe nächstes...

**down-left**
: ...siehe nächstes...

**downleft**
: ...siehe nächstes...

**leftdown**
: ...siehe nächstes...

**southeast**
: ...siehe nächstes...

**se**
: ...siehe nächstes...

**down-right**
: ...siehe nächstes...

**downright**
: ...siehe nächstes...

**rightdown**
: 


## Verschiedene Befehle

*number* **cm**
: ...siehe nächstes...

*number* **mm**
: ...siehe nächstes...

*number* **inch**
: ...siehe nächstes...

*number* **pt**
: Mit diesen Befehlen können Abstände und Koordinaten in metrischen und imperialen Einheiten angegeben werden; als Ergebnis gibt der Befehl den entsprechenden Abstand bzw. die entsprechende Koordinate in Pixeln zurück, da dies die Einheit ist, die intern für alle Berechnungen verwendet wird. Die Umrechnungsfaktoren basieren auf dem Ergebnis von **tk scaling** und werden einmalig zum Zeitpunkt des Einladens des Pakets berechnet; spätere Änderungen des Faktors **tk scaling** haben keine Auswirkungen.

*number* *number*
: BILD: figure-50-point-cons-absolute Dieser Befehl nimmt die x- und y-Koordinaten eines Ortes entgegen und gibt den *absoluten* Punkt dafür zurück.

**by** *distance* *direction*
: BILD: figure-51-point-cons-relative Dieser Befehl nimmt *distance* und *direction* entgegen (Winkel in Grad oder registrierter Richtungsname) und gibt den *relativen* Punkt dafür zurück, d. h. das *Delta* oder die *Verschiebung*, die er darstellt. Hinweise zu den (Un-)Ähnlichkeiten zu den Richtungsangaben für das Attribut **then** der Elemente **line** und **move** finden Sie hier.


```
by 50 east
```

: Für das Attribut sagen wir


```
... then east 50 ...
```

: oder einfach


```
... then east ...
```

*point1* **+** *point2*
: BILD: figure-48-point-vectoradd Dieser Befehl interpretiert zwei Punkte als Vektoren und addiert sie. Wenn mindestens einer der Punkte *absolut* ist, ist auch das Ergebnis absolut. Das Ergebnis ist genau dann ein *relativer* Punkt, wenn beide Punkte *relativ* sind.

*point1* **-** *point2*
: BILD: figure-49-point-vectorsub Dieser Befehl interpretiert zwei Punkte als Vektoren und subtrahiert den zweiten vom ersten. Ist mindestens einer der Punkte *absolut*, so ist auch das Ergebnis absolut. Das Ergebnis ist genau dann ein *relativer* Punkt, wenn beide Punkte *relativ* sind.

*point* **by** *distance* *direction*
: Dieser Befehl ist eine bequemere oder zumindest kürzere Form von


```
    [$point + [by $distance $direction]]
```

*point1* **|** *point2*
: BILD: figure-31-point-projection Dieser Befehl berechnet die *Projektion* zweier Punkte, d. h., das Ergebnis ist der Punkt mit den Koordinaten von *point1* und *point2*.

*n* **between** *poin1* *point2*
: BILD: figure-29-point-interpolation-1 Dieser Befehl berechnet den Punkt, der sich zu *n*\*100 Prozent auf halbem Weg zwischen *point1* und *point2* befindet, und gibt ihn als Ergebnis zurück. Das bedeutet, dass für


*n* == 0
: Das Ergebnis lautet *point1*.

*n* == 1
: Das Ergebnis ist *point2*.

*n* == 0.5
: Das Ergebnis liegt auf halbem Weg zwischen den beiden Punkten.


: usw. *Hinweis*: Für *n* sind Werte < 0 und > 1 zulässig


**intersect** *elem1* *elem2*
: BILD: figure-32-point-intersection Dieser Befehl nimmt zwei *offene* Elemente entgegen, berechnet die Geraden, die durch deren „Start“- und „End“--corners verlaufen, und gibt den Schnittpunkt dieser beiden Geraden zurück. Der Befehl löst einen Fehler aus, wenn sich die Geraden nicht schneiden oder zusammenfallen.

*element* **names** ?*pattern*?
: Dieser Befehl gibt eine Liste zurück, die die Namen aller Ecken des *element* enthält. Wird ein Muster festgelegt, werden nur die Namen zurückgegeben, die diesem Muster entsprechen (über **string match**). Andernfalls werden alle Namen zurückgegeben (entspricht einem Standardmuster von **\***).

*element* *corner*
: Dieser Befehl gibt den Wert für die *corner* des *element* zurück. Dies kann beliebig sein, einschließlich Punkten und Elementen.

*element* *corner1* *corner2*...
: Dies ist eine praktische Kurzform für


```
[[[$elem $corner1] $corner2] ...]
```

: unter der Annahme, dass der Wert für


```
 [$elem $corner1]
```

.IP usw. ist wiederum ein Element.

*element* ?*corner1*... ?**names** ?*pattern*??\]?
: Dies ist eine praktische Kurzform für


```
[[[$elem $corner1] ...] names ?pattern?]
```

: unter der Annahme, dass der Wert für


```
 [$elem $corner1]
```

.IP usw. ist wiederum ein Element.

**n**th ?*corner*?
: Dieser Befehl fragt den Diagrammverlauf nach dem **n**. erstellten Element ab, wobei er vom Anfang des Verlaufs (gezählt ab 1) aus sucht, und gibt dieses als Ergebnis zurück. Wenn die *corner* festgelegt wird, wird stattdessen der Wert für diese Ecke zurückgegeben.

**n**th **last** ?*corner*?
: Dieser Befehl fragt den Diagrammverlauf nach dem **n**. erstellten Element ab, wobei die Suche am Ende des Verlaufs beginnt, und gibt dieses als Ergebnis zurück. Wenn die *corner* festgelegt wird, gibt der Befehl stattdessen den Wert für diese Ecke zurück.

**n**th *shape* ?*corner*?
: Dieser Befehl fragt den Diagrammverlauf nach dem **n**. erstellten Element der angegebenen *shape* ab, wobei die Suche am Anfang des Verlaufs (ab 1) beginnt, und gibt dieses als Ergebnis zurück. Wenn die *corner* festgelegt wird, wird stattdessen der Wert für diese Ecke zurückgegeben.

**n**th **last** *shape* ?*corner*?
: Dieser Befehl fragt den Diagrammverlauf nach dem **n**. Element der angegebenen *shape* ab, wobei die Suche am Ende des Verlaufs beginnt, und gibt dieses als Ergebnis zurück. Wenn die *corner* festgelegt wird, gibt der Befehl stattdessen den Wert für diese Ecke zurück.

**last** ?*corner*?
: ...siehe nächstes...

**last** *shape* ?*corner*?
: Die Convenience-Befehle erfordern eine Zuordnung zu „**1st last**“ und „**1st last** *shape*“.

**1st**
: ...siehe nächstes...

**2nd**
: ...siehe nächstes...

**3rd**
: Aliase für **1th**, **2th** und **3th**, die der besseren Lesbarkeit dienen und überall dort verwendet werden können, wo **n** vorkommen kann.


## Variablen

Der Sprachkontext enthält eine Reihe vordefinierter Variablen, die die Standardwerte für verschiedene Attribute enthalten. Diese Variablen, ihre Verwendungszwecke und ihre Werte lauten wie folgt:

**anchor**
: Der Standardwert für das Attribut **anchor**. Initialisiert auf **center**. Die zulässigen Werte sind alle Werte, die von [Tk_GetAnchor](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetAnchor.htm)] akzeptiert werden.

**arcradius**
: Der Standardwert für das Attribut **radius** der Elemente **arc**. Wird auf den Pixelwert initialisiert, der dem Wert von **1 cm** entspricht.

**arrowhead**
: Der Standardwert für das Attribut **arrowhead**. Initialisiert auf **none**. Die zulässigen Werte sind


**none**, **-**
: Zeichnen Sie an keinem der beiden Enden der Linie Pfeilspitzen ein.

**start**, **first**, **<-**
: Zeichnen Sie am Anfang der Linie eine Pfeilspitze, jedoch nicht am Ende.

**end**, **last**, **->**
: Zeichnen Sie am Ende der Linie eine Pfeilspitze, jedoch nicht am Anfang.

**both**, **<->**
: Zeichnen Sie an beiden Enden der Linie Pfeilspitzen.


**boxheight**
: Der Standardwert für das Attribut **height** der Elemente **box**, **diamond** und **ellipse**. Wird auf den Pixelwert initialisiert, der dem Wert von **2 cm** entspricht.

**boxwidth**
: Der Standardwert für das Attribut **width** der Elemente **box**, **diamond** und **ellipse**. Wird auf den Pixelwert initialisiert, der dem Wert von **2 cm** entspricht.

**clockwise**
: Der Standardwert für die Attribute **clockwise** und **counterclockwise** der Elemente **arc**. Initialisiert auf **False** für die Richtung gegen den Uhrzeigersinn.

**circleradius**
: Der Standardwert für das Attribut **radius** der Elemente **circle** sowie der Standardwert für das Attribut **chop**, wenn diese ohne explizite Längenangabe angegeben werden. Wird auf den Pixelwert initialisiert, der dem Wert von **1 cm** entspricht.

**drumaspect**
: Der Standardwert für das Attribut **aspect** der Elemente **drum**. Initialisiert auf **0.35**.

**fillcolor**
: Der Standardwert für das Attribut **fillcolor** aller Elemente, die ausgefüllt werden können. Er wird auf die leere Zeichenkette initialisiert und signalisiert damit, dass das Element nicht ausgefüllt ist.

**justify**
: Der Standardwert für das Attribut **justify**. Initialisiert auf **left**. Die zulässigen Werte sind **left**, **right** und **center**.

**linecolor**
: Der Standardwert für das Attribut **color** aller Elemente, die Linien zeichnen müssen (alle außer **text**). Initialisiert auf **black**.

**linestyle**
: Der Standardwert für das Attribut **style** aller Elemente, bei denen eine Linie gezeichnet werden muss. Initialisiert auf **solid**. Die zulässigen Werte sind alle Werte, die von [Tk_GetDash](http://www.tcl-lang.org/man/tcl8.5/TkLib/GetDash.htm)] akzeptiert werden, sowie zusätzlich alle unten aufgeführten Werte:


**solid**, leere Zeichenkette
: Zeichnen Sie eine durchgezogene Linie.

**dash**, **dashed**, **-**
: Zeichnen Sie eine gestrichelte Linie.

**dot**, **dotted**, **.**
: Zeichnen Sie eine gepunktete Linie.

**dash-dot**, **-.**
: Zeichnen Sie eine gestrichelte Linie

**dash-dot-dot**, **-..**
: Zeichnen Sie eine gestrichelte Linie.


**linewidth**
: Der Standardwert für das Attribut **stroke** aller Elemente, bei denen eine Linie gezeichnet werden muss. Initialisiert auf **1** (Pixel).

**movelength**
: Der Standardwert für die Richtungsangabe von Zwischenstandorten durch das Attribut **then** der Elemente **line** und **move**. Wird auf den Pixelwert initialisiert, der dem Wert von **2 cm** entspricht.

**slant**
: Der Standardwert für das Attribut **slant** der Elemente **box**. Initialisiert auf 90 Grad, d. h. senkrecht nach oben geneigt.

**textcolor**
: Der Standardwert für das Attribut **textcolor** aller Elemente, die Text darstellen müssen. Initialisiert auf **black**.

**textfont**
: Der Standardwert für das Attribut **textfont** aller Elemente, die Text darstellen müssen. Initialisiert auf **Helvetica 12pt**.


# DIAGRAMMKLASSEN

über die internen Abläufe des Diagramm-Pakets. Regelmäßige Nutzer von **diagram** können diesen Abschnitt überspringen, ohne etwas zu verpassen.

Die wichtigste Information, die Sie hier sehen, ist die nachstehende Abbildung, die die Klassenhierarchie im Implementierungsdiagramm darstellt.

Bild: Bild-00-Abhängigkeiten

Ganz unten, alle auf derselben Ebene, befinden sich die unterstützenden Pakete wie **snit** usw. Diese sind alle in Tcllib zu finden.

Darüber befindet sich die Gruppe der Diagrammklassen, die die verschiedenen Aspekte des Systems implementieren, d. h.:

**diagram**
: Die Hauptklasse, die für den Benutzer sichtbar ist.

**diagram::core**
: Die Kern-Engine, die selbst auf vier Hilfsklassen verteilt ist.

**diagram::basic**
: Die Implementierung der Standards wie Rechteck, Kreis usw. basiert auf den Erweiterungen des Kerns.

**diagram::element**
: Kernklasse zur Unterstützung, die Datenbank der erstellten Elemente. Sie verwaltet zudem den Verlauf, d. h. die Reihenfolge, in der die Elemente erstellt wurden.

**diagram::attribute**
: Kernunterstützungsklasse, die generische Handhabung der Definition und Verarbeitung von Attributen.

**diagram::direction**
: Kernunterstützungsklasse, die Datenbank der benannten Richtungen.

**diagram::navigation**
: Kernunterstützungsklasse, der Status der Layout-Engine, d. h. aktuelle Position und Richtung, sowie Operationen darauf.

**diagram::point**
: Allgemeine Klasse zur Abwicklung verschiedener Vektoroperationen.


# LITERATUR

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument sowie das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *diagram* des [Tklib Trackers](http://core.tcl-lang.org/tklib/reportlist). Bitte teilen Sie uns auch Ihre Ideen für Verbesserungen mit, die Sie möglicherweise für eines der beiden Pakete und/oder die Dokumentation haben.

# KATEGORIE

Dokumentationswerkzeuge
