# Das `scrollutil::scrollableframe` und  
 `scrollutil::adaptBtn2EventHandling` BEFEHLE

## Für Scrollutil Version 2.11

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl scrollutil::scrollableframe – Kurzreferenz](#der-befehl-scrollutil-scrollableframe-kurzreferenz)
- [Der Befehl scrollutil::scrollableframe – Ausführliche Referenz](#der-befehl-scrollutil-scrollableframe-ausf-hrliche-referenz)
- [Der Befehl scrollutil::adaptBtn2EventHandling](#der-befehl-scrollutil-adaptbtn2eventhandling)
- [Vergleich mit BWidget ScrollableFrame und iwidgets::scrolledframe](#vergleich-mit-bwidget-scrollableframe-und-iwidgets-scrolledframe)

[Startseite](index.md)

---

## Der Befehl `scrollutil::scrollableframe` – Kurzreferenz

[NAME](#der-befehl-scrollutil-scrollableframe-ausf-hrliche-referenz)
: `scrollutil::scrollableframe` – Erstellen und Bearbeiten von „ScrollableFrame“-Widgets

[ÜBERSICHT](#der-befehl-scrollutil-scrollableframe-ausf-hrliche-referenz)
: 

```
scrollutil::scrollableframe pathName ?options?
```

[STANDARDOPTIONEN](#der-befehl-scrollutil-scrollableframe-ausf-hrliche-referenz)
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor       -xscrollcommand
-cursor       -highlightthickness   -yscrollcommand
```

[WIDGET-SPEZIFISCHE OPTIONEN](#der-befehl-scrollutil-scrollableframe-ausf-hrliche-referenz)
: `-contentheight screenDistance`

: `-contentwidth screenDistance`

: `-fitcontentheight boolean`

: `-fitcontentwidth boolean`

: `-height screenDistance`

: `-takefocus 0|1|""|command`

: `-width screenDistance`

: `-xscrollincrement screenDistance`

: `-yscrollincrement screenDistance`

[Widget COMMAND](#der-befehl-scrollutil-scrollableframe-ausf-hrliche-referenz)
: `pathName attrib ?name ?value name value ...??`

: `pathName autofillx ?boolean?`

: `pathName autofilly ?boolean?`

: `pathName autosize ?w|h|wh?`

: `pathName cget option`

: `pathName configure ?option ?value option value ...??`

: `pathName contentframe`

: `pathName hasattrib name`

: `pathName preparescan`

: `pathName preparescroll`

: `pathName scan option args`

: `pathName scan mark x y`

: `pathName scan dragto x y ?gain?` 


: `pathName see widget ?nw|ne|sw|se?`

: `pathName seerect x1 y1 x2 y2 ?nw|ne|sw|se?`

: `pathName unsetattrib name`

: `pathName xview ?args?`

: `pathName xview`

: `pathName xview units`

: `pathName xview moveto fraction`

: `pathName xview scroll number units|pages`


: `pathName yview ?args?`

: `pathName yview`

: `pathName yview units`

: `pathName yview moveto fraction`

: `pathName yview scroll number units|pages`


[SCHLÜSSELWÖRTER](#der-befehl-scrollutil-scrollableframe-ausf-hrliche-referenz)
: scrollableframe, widget, frame, scrollable


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::scrollableframe` – Ausführliche Referenz

**NAME**
: `scrollutil::scrollableframe` – Erstellen und Bearbeiten von „scrollableframe“-Widgets

**ÜBERSICHT**
: 

```
scrollutil::scrollableframe pathName ?options?
```

**BESCHREIBUNG**
: Der Befehl `scrollutil::scrollableframe` erstellt ein neues Fenster mit dem Namen `pathName` und der Klasse `Scrollableframe` und wandelt es in ein **scrollableframe**-Widget um.  Zusätzliche Optionen, die im Folgenden beschrieben werden, können über die Befehlszeile oder in der Optionsdatenbank festgelegt werden, um Aspekte des „scrollableframe“-Widgets wie dessen Breite, Höhe und Scroll-Schritte zu konfigurieren. Der Befehl `scrollutil::scrollableframe` gibt sein Argument `pathName` zurück.  Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen `pathName` vorhanden sein, aber das übergeordnete Fenster von `pathName` muss vorhanden sein.

: Ein „scrollableframe“ ist ein Megawidget, das einen **Inhaltsrahmen** enthält, dessen Abmessungen größer sein können als die des Widgets selbst. Beliebige Bereiche dieses Rahmens können durch Scrollen in den sichtbaren Bereich gebracht werden, da das „scrollableframe“-Widget die Konfigurationsoptionen `-xscrollcommand` und `-yscrollcommand` unterstützt und der zugehörige Tcl-Befehl über die Unterbefehle `xview` und `yview` verfügt. Der Inhaltsrahmen kann eine beliebige Anzahl beliebiger Widgets enthalten.  Mit anderen Worten: Der Befehl `scrollutil::scrollableframe` implementiert einen **scrollbaren Widget-Container**.

: Im Scrollutil-Paket sind sowohl das „scrollableframe“-Widget als auch dessen Inhaltsrahmen als Tk-Core-Frames implementiert, während es sich bei Scrollutil_tile um ttk::frame-Widgets handelt.  Auf den Inhaltsrahmen kann über den Unterbefehl `contentframe` zugegriffen werden. Die darin enthaltenen einzelnen Widgets können mithilfe des Unterbefehls `see` im „scrollableframe“-Fenster sichtbar gemacht werden.  Neben dem Scrollen unterstützen „scrollableframe“-Widgets auch das Scannen mithilfe entsprechender Mausereignis-Bindungen, die den Unterbefehl `scan` aufrufen.

: Ein „ScrollableFrame“-Widget wird in der Regel innerhalb eines [scrollarea](scrollarea.md) erstellt, wie im folgenden Beispiel gezeigt:

```
set sa [scrollutil::scrollarea ...]
set sf [scrollutil::scrollableframe $sa.sf ...]
$sa setwidget $sf

set cf [$sf contentframe]
<populate the content frame>

$sf autosize w
update idletasks
$sf configure -height ... -yscrollincrement ...

pack $sa -expand yes -fill both
```

: **HINWEIS:**  Nach der Erstellung des „scrollableframe“-Widgets registriert der Befehl `scrollutil::scrollableframe` dieses automatisch für das Scrollen mit dem Mausrad oder dem Touchpad, indem er dessen Pfadnamen an den Befehl `scrollutil::enableScrollingByWheel` übergibt.

**STANDARDOPTIONEN**
: 

```
-background   -highlightbackground  -relief
-borderwidth  -highlightcolor       -xscrollcommand
-cursor       -highlightthickness   -yscrollcommand
```

: Weitere Informationen zu den Standardoptionen für Tk-Widgets finden Sie im Handbucheintrag zu den **options**. Die Optionen `-background`, `-highlightbackground`, `-highlightcolor` und `-highlightthickness` werden nur vom Scrollutil-Paket unterstützt, nicht jedoch von Scrollutil_tile.  Sie haben dieselben Standardwerte wie die gleichnamigen Optionen für Tk-Frame-Widgets.  Die Standardwerte der übrigen Standardoptionen lauten:


```
-borderwidth 0 -cursor "" -relief flat -xscrollcommand "" -yscrollcommand ""
```

**WIDGET-SPEZIFISCHE OPTIONEN**
: 

|   |   |
| --- | --- |
| Befehlszeilenname:  | `-contentheight` |
| Name der Datenbank: | ` contentHeight` |
| Datenbankklasse: | ` ContentHeight` |

Legt die gewünschte Höhe für den Inhaltsrahmen in einem der von `Tk_GetPixels` akzeptierten Formate fest.  Wenn der Wert der Option kleiner oder gleich Null ist, wird die Höhe des Inhaltsrahmens gerade so groß gewählt, dass alle untergeordneten Elemente darin Platz finden. Diese Option ist nur relevant, wenn der Wert der Option `-fitcontentheight` auf „false“ gesetzt ist; ansonsten hat der Inhaltsrahmen dieselbe Höhe wie das „scrollableframe“-Fenster (ohne dessen Rahmen und gegebenenfalls vorhandenes Hervorhebungsrechteck), unabhängig vom Wert der Option `-contentheight`.  Der Standardwert ist `0`, was für die überwiegende Mehrheit der Anwendungen geeignet ist.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-contentwidth` |
| Name der Datenbank: | ` contentWidth` |
| Datenbankklasse: | ` ContentWidth` |

Legt die gewünschte Breite für den Inhaltsrahmen in einem der von `Tk_GetPixels` akzeptierten Formate fest.  Wenn der Wert der Option kleiner oder gleich Null ist, wird die Breite des Inhaltsrahmens gerade so groß gewählt, dass alle seine untergeordneten Elemente Platz finden. Diese Option ist nur relevant, wenn der Wert der Option `-fitcontentwidth` auf „false“ gesetzt ist; ansonsten hat der Inhaltsrahmen dieselbe Breite wie das „scrollableframe“-Fenster (ohne dessen Rahmen und gegebenenfalls vorhandenes Hervorhebungsrechteck), unabhängig vom Wert der Option `-contentwidth`.  Der Standardwert ist `0`, was für die überwiegende Mehrheit der Anwendungen geeignet ist.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-fitcontentheight` |
| Name der Datenbank: | ` fitContentHeight` |
| Datenbankklasse: | ` FitContentHeight` |

Legt einen booleschen Wert fest, der angibt, ob der Inhaltsrahmen dieselbe Höhe wie das „scrollableframe“-Fenster haben soll (ohne dessen Rahmen und gegebenenfalls vorhandenes Hervorhebungsrechteck).  Wenn der Wert „true“ ist, wird die Höhe des Inhaltsrahmens mit der des Widgets synchronisiert, und der Wert der Option `-contentheight` wird ignoriert. Der Standardwert ist `0`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-fitcontentwidth` |
| Name der Datenbank: | ` fitContentWidth` |
| Datenbankklasse: | ` FitContentWidth` |

Legt einen booleschen Wert fest, der angibt, ob der Inhaltsrahmen dieselbe Breite wie das „scrollableframe“-Fenster haben soll (ohne dessen Rahmen und gegebenenfalls vorhandenes Hervorhebungsrechteck).  Wenn der Wert „true“ ist, wird die Breite des Inhaltsrahmens an die des Widgets angepasst, und der Wert der Option `-contentwidth` wird ignoriert. Der Standardwert ist `0`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-height` |
| Name der Datenbank: | ` height` |
| Datenbankklasse: | ` Height` |

Legt die gewünschte Höhe für das „scrollableframe“-Widget in einem der von `Tk_GetPixels` akzeptierten Formate fest.  Beachten Sie, dass hiermit die *innere* Höhe festgelegt wird, ohne den Rahmen und das Hervorhebungsrechteck (falls vorhanden), die um das Widget herum gezeichnet werden. Der Standardwert ist `7c`, der durch einen geeigneten anwendungsspezifischen Wert überschrieben werden sollte.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-takefocus` |
| Name der Datenbank: | ` takeFocus` |
| Datenbankklasse: | ` TakeFocus` |

Diese Option legt fest, ob das „scrollableframe“-Widget während der Tastaturnavigation den Fokus annimmt. Sie ist nahezu identisch mit der gleichnamigen Standardoption (Einzelheiten finden Sie im Handbucheintrag **options**).  Der einzige Unterschied besteht darin, dass nicht das „scrollableframe“-Widget selbst, sondern dessen Inhaltsrahmen den Fokus erhält, wenn die Standardtasten (`Tab` und `Shift-Tab`) bei der Tastaturnavigation gedrückt werden.  Die Standardeinstellung ist `0`, da ein „scrollableframe“-Widget im Wesentlichen ein Rahmen ist, der als Ansicht für seine Inhaltsrahmen-Komponente dient.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-width` |
| Name der Datenbank: | ` width` |
| Datenbankklasse: | ` Width` |

Legt die gewünschte Breite für das „scrollableframe“-Widget in einem der von `Tk_GetPixels` akzeptierten Formate fest.  HINWEIS: Hiermit wird die *innere* Breite festgelegt, ohne den Rahmen und das Hervorhebungsrechteck (falls vorhanden), die um das Widget herum gezeichnet werden. Der Standardwert ist `10c`, der durch einen geeigneten anwendungsspezifischen Wert überschrieben werden sollte.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-xscrollincrement` |
| Name der Datenbank: | ` xScrollIncrement` |
| Datenbankklasse: | ` ScrollIncrement` |

Legt einen Schrittwert für das horizontale Scrollen fest, in einer der von `Tk_GetPixels` akzeptierten Formen.  Wenn der Wert dieser Option größer als Null ist, wird die horizontale Ansicht im Fenster so begrenzt, dass die x-Koordinate innerhalb des Inhaltsrahmens am linken Rand des Fensters stets ein gerades Vielfaches von `xScrollIncrement` ist; außerdem entsprechen die Einheiten für den horizontalen Bildlauf (siehe den Unterbefehl `xview`) ebenfalls `xScrollIncrement`.  Wenn der Wert kleiner oder gleich Null ist, ist der horizontale Bildlauf uneingeschränkt.  Der Standardwert ist `0`.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-yscrollincrement` |
| Name der Datenbank: | ` yScrollIncrement` |
| Datenbankklasse: | ` ScrollIncrement` |

Legt einen Schrittwert für das vertikale Scrollen fest, in einer der von `Tk_GetPixels` akzeptierten Formen.  Wenn der Wert dieser Option größer als Null ist, wird die vertikale Ansicht im Fenster so begrenzt, dass die y-Koordinate innerhalb des Inhaltsrahmens am oberen Rand des Fensters stets ein gerades Vielfaches von `yScrollIncrement` ist; außerdem entsprechen die Einheiten für das vertikale Scrollen (siehe den Unterbefehl `yview`) ebenfalls `yScrollIncrement`.  Wenn der Wert kleiner oder gleich Null ist, ist das vertikale Scrollen uneingeschränkt. Der Standardwert ist `0`.

**WIDGET-BEFEHL**
: Der Befehl `scrollutil::scrollableframe` erstellt einen neuen Tcl-Befehl mit dem Namen `pathName`. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget auszuführen. Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

: `option` und `arg` legen das genaue Verhalten des Befehls fest. Für „scrollableframe“-Widgets sind folgende Befehle möglich:


`pathName attrib ?name ?value name value ...??`
: Fragt die Attribute des Widgets ab oder ändert sie.  Wenn kein `name` angegeben ist, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs für `pathName` enthält.  Wenn `name` ohne `value` festgelegt wird, gibt der Befehl den Wert des genannten Attributs zurück oder eine leere Zeichenkette, falls kein entsprechender Wert vorhanden ist (mit dem Unterbefehl `hasattrib` können Sie diesen Fall von dem unterscheiden, bei dem der Wert eines *vorhandenen* Attributs eine leere Zeichenkette ist).  Wenn ein oder mehrere Paare aus `name` und `value` angegeben werden, legt der Befehl das/die angegebene(n) Widget-Attribut(e) auf den/die angegebenen Wert(e) fest; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  Jedes `name` kann eine beliebige Zeichenkette sein.

`pathName autofillx ?boolean?`
: Prüft oder fragt ab, ob der Inhaltsrahmen die gesamte innere Breite des Widgets ausfüllt.  Wenn das optionale boolesche Argument „true“ ist, setzt der Befehl die Option `-fitcontentwidth` auf „true“, wenn die angeforderte Breite des Inhaltsrahmens kleiner ist als die innere Breite des scrollbaren Rahmens, andernfalls auf „false“.  Außerdem stellt der Befehl sicher, dass diese Aktion wiederholt wird, sobald sich die angeforderte Breite des Inhaltsrahmens oder die Innenbreite des scrollbaren Rahmens ändert.  Wenn das optionale Argument „false“ ist, löscht der Befehl das Flag, das diese dynamische Aktion steuert. In beiden Fällen ist der Rückgabewert eine leere Zeichenkette. Ohne das optionale Argument gibt der Befehl den aktuellen Wert des oben genannten Flags zurück.

`pathName autofilly ?boolean?`
: Prüft oder fragt ab, ob der Inhaltsrahmen die gesamte innere Höhe des Widgets ausfüllt.  Wenn das optionale boolesche Argument „true“ ist, setzt der Befehl die Option `-fitcontentheight` auf „true“, wenn die angeforderte Höhe des Inhaltsrahmens kleiner ist als die innere Höhe des scrollbaren Rahmens, andernfalls auf „false“.  Außerdem stellt der Befehl sicher, dass diese Aktion immer dann wiederholt wird, wenn sich die angeforderte Höhe des Inhaltsrahmens oder die innere Höhe des scrollbaren Rahmens ändert.  Wenn das optionale Argument „false“ ist, löscht der Befehl das Flag, das diese dynamische Aktion steuert. In beiden Fällen ist der Rückgabewert eine leere Zeichenkette. Ohne das optionale Argument gibt der Befehl den aktuellen Wert des oben genannten Flags zurück.

`pathName autosize ?dimensions?`
: Dieser Befehl setzt die Option `-width` und/oder `-height` des scrollableframe auf die gewünschte Breite und/oder Höhe seines Inhaltsrahmens, entsprechend dem optionalen Argument `dimensions`, dessen mögliche Werte `w` (Breite), `h` (Höhe) und `wh` (Breite / Höhe).  Der Standardwert ist eine leere Zeichenkette, was bedeutet, dass weder die Breite noch die Höhe *explizit* festgelegt werden soll.  Beachten Sie, dass der Befehl, wenn der Wert der Option `-fitcontentwidth` „true“ ist, die innere Breite des Widgets auf die angeforderte Breite seines Inhaltsrahmens setzt, unabhängig davon, ob diese *explizit* angegeben wurde oder nicht.  Ebenso setzt der Befehl, wenn der Wert der Option `-fitcontentheight` „true“ ist, die innere Höhe des Widgets auf die angeforderte Höhe seines Inhaltsrahmens, auch wenn diese nicht *explizit* angegeben wurde.

: **HINWEIS:**  Das Festlegen der inneren Breite und/oder Höhe des Widgets im Rahmen dieses Unterbefehls wird als  `"after 100"`  -Callback ausgeführt, um sicherzustellen, dass die Berechnungen zur Geometrieverwaltung im Inhaltsrahmen des Widgets abgeschlossen sind, bevor dessen Breite und/oder Höhe festgelegt werden.

`pathName cget option`
: Gibt den aktuellen Wert der durch `option` angegebenen Konfigurationsoption zurück, die einen beliebigen der vom Befehl `scrollutil::scrollableframe` akzeptierten Werte annehmen kann.

`pathName configure ?option ?value option value ...??`
: Ruft die Konfigurationsoptionen des Widgets ab oder ändert sie.  Wenn kein `option` festgelegt wird, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für `pathName` beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste entspricht der entsprechenden Unterliste des Werts, der zurückgegeben wird, wenn kein `option` festgelegt wurde).  Wenn ein oder mehrere Paare aus `option` und `value` festgelegt werden, ändert der Befehl die festgelegten Widget-Optionen so, dass sie die festgelegten Werte annehmen; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück.  `option` kann jeden der vom Befehl `scrollutil::scrollableframe` akzeptierten Werte annehmen.

`pathName contentframe`
: Gibt den Pfadnamen des Inhaltsrahmens des Widgets zurück.

`pathName hasattrib name`
: Gibt `1` zurück, wenn das Attribut `name` vorhanden ist, andernfalls `0`.

`pathName preparescan`
: Bereitet den ScrollableFrame für das Scannen vor, indem er seine untergeordneten Elemente, die sich im gleichen Toplevel-Fenster befinden und über Bindungen für Ereignisse der Maustaste 2 verfügen, an den Befehl `scrollutil::adaptBtn2EventHandling` übergibt.

: **HINWEIS:**  Wenn der „scrollableframe“ viele untergeordnete Elemente enthält, ist es wesentlich sicherer, diesen Unterbefehl aufzurufen, als manuell eine große Anzahl von Widgets an `scrollutil::adaptBtn2EventHandling` zu übergeben, da die Entscheidung, welche untergeordneten Elemente verarbeitet werden sollen, mühsam und fehleranfällig sein kann.

`pathName preparescroll`
: Bereitet den „scrollableframe“ für das Scrollen mit dem Mausrad und dem Touchpad vor, indem er seine untergeordneten Elemente, die sich auf dem gleichen Toplevel-Fenster befinden und über Bindungen für Mausrad- oder `<TouchpadScroll>`-Ereignisse verfügen, an den Befehl `scrollutil::adaptWheelEventHandling` übergibt.

: **HINWEIS:** Der Aufruf dieses Unterbefehls ist lediglich eine Abkürzung, um den Wert `pathName` an den Befehl `scrollutil::prepareScrollingByWheel` zu übergeben.

`pathName scan option args`
: Dieser Befehl dient dazu, das Scannen bei „scrollableframe“-Widgets zu implementieren. Je nach `option` gibt es zwei Varianten:


`pathName scan mark x y`
: Speichert die Datensätze `x` und `y` sowie die aktuelle Ansicht im ScrollableFrame-Fenster; wird in Verbindung mit den nachfolgenden Befehlen `scan dragto` verwendet.  In der Regel ist dieser Befehl mit einem Mausklick im Widget verknüpft, wobei `x` und `y` die Koordinaten der Maus darstellen. Er gibt eine leere Zeichenkette zurück.

`pathName scan dragto x y ?gain?`
: Dieser Befehl berechnet die Differenz zwischen seinen Argumenten `x` und `y` (bei denen es sich in der Regel um Mauskoordinaten handelt) und den Argumenten `x` und `y` des letzten  `scan mark`-Befehls für das Widget.  Anschließend passt er die Ansicht um das `gain`-fache der Differenz der Koordinaten an, wobei `gain` standardmäßig auf `10` gesetzt ist, außer auf Android, wo der Standardwert `2` ist, da dieser Wert besser zur Emulation von Ereignissen der Maustaste 2 mit Ein-Finger-Gesten geeignet ist.  Dieser Befehl wird typischerweise mit Mausbewegungsereignissen im Widget verknüpft, um den Effekt zu erzeugen, dass der Inhaltsrahmen mit hoher Geschwindigkeit durch das Fenster gezogen wird. Der Rückgabewert ist eine leere Zeichenkette.


`pathName see widget ?corner?`
: Dieser Befehl passt die Ansicht im Fenster des ScrollableFrame so an, dass `widget` darin sichtbar wird. Das angegebene Widget muss ein Nachkomme des Inhaltsrahmen sein und dieselbe Toplevel-Fenster-Ebene haben. Außerdem muss es von einem Geometriemanager verwaltet werden (wie beispielsweise `grid`, `pack`, `place`, `text` oder `canvas`) verwaltet werden.  Das optionale Argument `corner` legt fest, welche Ecke von `widget` sichtbar werden soll, wenn es zu groß ist, um in das Fenster zu passen. Mögliche Werte sind `nw` (Nordwesten), `ne` (Nordosten), `sw` (Südwesten) und `se` (Südosten).  Die Standardecke ist `nw`.

: **HINWEIS:**  Mit diesem Unterbefehl können Sie die Tastaturnavigation im Inhaltsrahmen benutzerfreundlicher gestalten, wie im folgenden Beispiel, in dem `$w` ein untergeordneter Element des Inhaltsrahmens des ScrollableFrame-Widgets `$sf` ist (es wird davon ausgegangen, dass `$sf` keine Zeichen von `%` enthält):


```
bind $w <<TraverseIn>> [list $sf see %W]
```

: Wenn das Widget `$w` über dessen Unterbefehl `setwidget` in einen [scrollarea](scrollarea.md) eingebettet wurde und der Scrollbereich wiederum ein Nachkomme des Inhaltsrahmens ist, dann ist es benutzerfreundlicher, den Scrollbereich in den sichtbaren Bereich zu bringen, anstatt nur das Widget:


```
bind $w <<TraverseIn>> [list seeScrollarea $sf %W]

proc seeScrollarea {sf w} { $sf see [scrollutil::getscrollarea $w] }
```

`pathName seerect x1 y1 x2 y2 ?corner?`
: Dieser Befehl passt die Ansicht im Fenster des ScrollableFrame so an, dass das durch `x1`, `y1`, `x2` und `y2` darin sichtbar werden.  Diese Koordinaten beziehen sich auf den Inhaltsrahmen und legen zwei diagonal gegenüberliegende Ecken des Rechtecks fest (das seine obere und linke Kante, nicht jedoch seine untere oder rechte Kante umfasst).  Das optionale Argument `corner` legt fest, welche Ecke des Rechtecks sichtbar werden soll, wenn es zu groß ist, um in das Fenster zu passen. Die möglichen Werte sind `nw` (Nordwesten), `ne` (Nordosten), `sw` (Südwesten) und `se` (Südosten).  Die Standardecke ist `nw`.

`pathName unsetattrib name`
: Hebt das Attribut `name` auf. Gibt eine leere Zeichenfolge zurück.

`pathName xview ?args?`
: Dieser Befehl dient dazu, die horizontale Position der im Fenster des Widgets angezeigten Informationen abzufragen und zu ändern. Er kann eine der folgenden Formen annehmen:


`pathName xview`
: Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruch zwischen `0` und `1`; zusammen beschreiben sie den horizontalen Bereich, der im Fenster sichtbar ist.  Wenn beispielsweise das erste Element `0.2` und das zweite Element `0.6` ist, liegen 20 % des Inhaltsrahmens links außerhalb des Bildschirms, die mittleren 40 % sind im Fenster sichtbar, und 40 % des Inhaltsrahmens befinden sich rechts außerhalb des Bildschirms.  Dies sind dieselben Werte, die über die Option `-xscrollcommand` an die Bildlaufleisten übergeben werden.

`pathName xview units`
: Passt die Ansicht im Fenster so an, dass die durch `units` angegebene Position des Inhaltsrahmens am linken Rand des Fensters angezeigt wird.  Dieses Argument legt die Anzahl der Einheiten der Option `xScrollIncrement` fest, wenn der Wert größer als Null ist; andernfalls entspricht es einem Zehntel der inneren Breite des Fensters.

`pathName xview moveto fraction`
: Passt die Ansicht im Fenster so an, dass `fraction` der Gesamtbreite des Inhaltsrahmens links außerhalb des Bildschirms liegt.  `fraction` muss ein Bruchwert zwischen `0` und `1` sein.

`pathName xview scroll number what`
: Dieser Befehl verschiebt die Ansicht im Fenster entsprechend den Werten `number` und `what` nach links oder rechts.  `number` muss eine Ganzzahl oder eine Gleitkommazahl sein; wenn es sich um eine Gleitkommazahl handelt, wird sie in eine Ganzzahl umgewandelt und dabei von `0` weg gerundet.  `what` muss entweder `units` oder `pages` oder eine Abkürzung eines dieser Werte sein.  Wenn `what` gleich `units` ist, passt sich die Ansicht nach links oder rechts in Einheiten der Option `xScrollIncrement` an, sofern diese größer als Null ist, andernfalls in Einheiten von einem Zehntel der inneren Breite des Fensters.  Wenn `what` gleich `pages` ist, so wird die Ansicht in Einheiten von neun Zehnteln der inneren Breite des Fensters angepasst.  Wenn `number` negativ ist, werden Informationen weiter links sichtbar; wenn der Wert positiv ist, werden Informationen weiter rechts sichtbar.


`pathName yview ?args?`
: Dieser Befehl dient dazu, die vertikale Position der im Fenster des Widgets angezeigten Informationen abzufragen und zu ändern. Er kann in einer der folgenden Formen vorliegen:


`pathName yview`
: Gibt eine Liste mit zwei Elementen zurück. Jedes Element ist ein reeller Bruch zwischen `0` und `1`; zusammen beschreiben sie den vertikalen Bereich, der im Fenster sichtbar ist.  Wenn beispielsweise das erste Element `0.2` und das zweite Element `0.6` ist, liegen 20 % des Inhaltsrahmens oben außerhalb des Bildschirms, die mittleren 40 % sind im Fenster sichtbar, und 40 % des Inhaltsrahmens liegen am unteren Rand außerhalb des Bildschirms.  Dies sind dieselben Werte, die über die Option `-yscrollcommand` an die Bildlaufleisten übergeben werden.

`pathName yview units`
: Passt die Ansicht im Fenster so an, dass die durch `units` angegebene Position des Inhaltsrahmens am oberen Rand des Fensters angezeigt wird.  Dieses Argument legt eine Anzahl von Einheiten der Option `yScrollIncrement` fest, wenn diese größer als Null ist; andernfalls legt es ein Zehntel der inneren Höhe des Fensters fest.

`pathName yview moveto fraction`
: Passt die Ansicht im Fenster so an, dass `fraction` der Gesamthöhe des Inhaltsrahmens oben außerhalb des Bildschirms liegt.  `fraction` muss ein Bruch zwischen `0` und `1` sein.

`pathName yview scroll number what`
: Dieser Befehl verschiebt die Ansicht im Fenster entsprechend den Werten `number` und `what` nach oben oder unten.  `number` muss eine Ganzzahl oder eine Gleitkommazahl sein; wenn es sich um eine Gleitkommazahl handelt, wird diese in eine Ganzzahl umgewandelt und dabei von `0` weg gerundet.  `what` muss entweder `units` oder `pages` oder eine Abkürzung eines dieser Werte sein.  Wenn `what` gleich `units` ist, passt sich die Ansicht in Einheiten der Option `yScrollIncrement` an, sofern diese größer als Null ist, andernfalls in Einheiten von einem Zehntel der inneren Höhe des Fensters.  Wenn `what` gleich `pages` ist, so wird die Ansicht in Einheiten von neun Zehnteln der inneren Höhe des Fensters angepasst.  Wenn `number` negativ ist, werden Informationen weiter oben sichtbar; wenn der Wert positiv ist, werden Informationen weiter unten sichtbar.



**VORGABEBINDUNGEN**
: Mausknopf 2 kann zum Scrollen verwendet werden.  Wenn er gedrückt und über einen freien Bereich des „scrollableframe“-Fensters gezogen wird, bewegt sich der Rahmen des Inhalts mit hoher Geschwindigkeit in die Richtung, in die die Maus bewegt wird.  Das Gleiche geschieht, wenn auf ein untergeordnetes Element geklickt wurde, das entweder keine Bindungen für Ereignisse der Maustaste 2 hat oder an den Befehl `scrollutil::adaptBtn2EventHandling` übergeben wurde, und sich der Fokus außerhalb des Fensters `[focusCheckWindow descendant]` befindet.

: **HINWEIS:**  Unter Android bedeutet die Unterstützung für das Scannen mit der rechten Maustaste, dass das Scannen auch über Ein-Finger-Gesten möglich ist, da schnelle Wischbewegungen mit einem Finger von AndroWish in die Ereignisse `<Button-2>`, `<B2-Motion>` und `<ButtonRelease-2>` als Ereignisse umgewandelt.

**SCHLÜSSELWÖRTER**
: scrollableframe, widget, frame, scrollable


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `scrollutil::adaptBtn2EventHandling`

**NAME**
: `scrollutil::adaptBtn2EventHandling` – Ereignisbehandlung für Maustaste 2 anpassen

**ÜBERSICHT**
: 

```
scrollutil::adaptBtn2EventHandling ?widget widget ...?
```

**BESCHREIBUNG**
: Für jedes `widget`-Argument führt der Befehl die folgenden Aktionen aus:


  -  Wenn `widget` der Pfadname eines [tablelist](https://www.nemethi.de/tablelist/)-Widgets ist, setzt dieser Befehl dessen Option `-button2window` auf den Pfadnamen des Toplevel-Fensters, vorausgesetzt, die Tablelist-Version ist 7.6 oder höher (bei früheren Tablelist-Versionen ignoriert der Befehl stillschweigend jedes Tablelist-Widget, das ihm als Argument übergeben wird).  Infolgedessen wird ein an den Hauptbereich oder das Bearbeitungsfenster der Tablelist gesendetes Ereignis vom Typ `<Button-2>`, `<B2-Motion>` oder `<ButtonRelease-2>` (genauer gesagt: ein Ereignis der Maustaste 2, das an eine beliebige Komponente der Tablelist gesendet wird, die das Tag `TablelistBody` oder `TablelistEdit` trägt), wie folgt behandelt:  
  -  Andernfalls wird das (erste) Bindungs-Tag gesucht, das Ereignisbindungen für Maustaste 2 enthält und sich sowohl vom Pfadnamen des Toplevel-Fensters als auch von `all` unterscheidet.  Wenn die Suche nach diesem Tag erfolgreich ist, ändert der Befehl die Liste der Bindungs-Tags des Widgets, indem er diesem Bindungs-Tag das Tag `Btn2EventRedir` voranstellt und das Tag `Btn2EventBreak` anhängt.  Infolgedessen wird ein an dieses Widget gesendetes Ereignis vom Typ `<Button-2>`, `<B2-Motion>` oder `<ButtonRelease-2>` wie folgt behandelt:  

    - Wenn der Fokus innerhalb des „tablelist“-Widgets liegt, löst das Ereignis eine Überprüfung des Inhalts der „tablelist“ oder ihres Bearbeitungsfensters aus, und es erfolgt keine weitere Verarbeitung des Ereignisses.
    - Wenn der Fokus außerhalb des „tablelist“-Widgets liegt, findet kein Scanvorgang innerhalb des Hauptbereichs oder des Bearbeitungsfensters der „tablelist“ statt. Stattdessen wird das Ereignis über `event generate` an das übergeordnete Toplevel-Fenster weitergeleitet.  Dies löst wiederum eine Überprüfung des Inhalts des (innersten) „scrollableframe“-Widgets aus, das ein Vorfahr von `widget` ist und das gleiche Toplevel-Fenster hat (sofern ein solches „scrollableframe“-Widget vorhanden ist).

    - Wenn der Fokus auf oder innerhalb des Fensters  `[focusCheckWindow widget]` ist, wird das Ereignis durch das diesem Tag zugeordnete Skript der Bindung verarbeitet, und es erfolgt keine weitere Verarbeitung des Ereignisses.
    - Wenn der Fokus außerhalb des Fensters  `[focusCheckWindow widget]` ist, wird das Ereignis über  `event generate` an das Toplevel-Fenster weitergeleitet, anstatt vom Skript der Bindung verarbeitet zu werden, das dem oben genannten Tag zugeordnet ist.  Dies löst wiederum eine Überprüfung des Inhalts des (innersten) „scrollableframe“-Widgets aus, das ein Vorfahr von `widget` ist und das gleiche Toplevel-Fenster hat (wenn ein solches „scrollableframe“-Widget vorhanden ist).

: **ANMERKUNG 1:** Dieser Befehl ist dafür vorgesehen, für Widgets aufgerufen zu werden, die Bindungen für Ereignisse der Maustaste 2 haben und Nachkommen eines scrollableframe sind. Die Tk- und Tile-Widgets, die Klassenbindungen für Ereignisse der Maustaste 2 haben, sind: Tk-Core-Entry, ttk::entry, ttk::combobox, listbox, PanedWindow, Tk-Core-Scale, ttk::scale, Tk-Core-Spinbox, ttk::spinbox, Tk-Core-Scrollbar, ttk::scrollbar und Text.  Beispiele für Widgets mit anderen Bindungs-Tags als ihren Namen der Klasse, die Ereignisse für die rechte Maustaste aufweisen, sind ctext- und tablelist-Widgets.  (Im Fall eines ctext-Widgets `w` beziehen sich die in der obigen BESCHREIBUNG genannten Bindungs-Tags auf das untergeordnete Haupttext-Widget des Widgets `w.t` und nicht auf das Widget selbst.)

: **ANMERKUNG 2:**  Wie oben erwähnt, verfügen die Tk-Core-Scrollbar- und ttk::scrollbar-Widgets über Klassenbindungen für Ereignisse der Maustaste 2; daher sollte dieser Befehl für sie aufgerufen werden, falls sie Nachkommen eines ScrollableFrame-Widgets sind.  Da diese Aufgabe mühsam werden kann, sorgt Scrollutil dafür, dass, wenn Sie diesem Befehl ein Widget übergeben und dieses Widget in ein [scrollarea](scrollarea.md) über dessen Unterbefehl `setwidget` eingebettet ist, wird dieser Befehl automatisch auch für die Bildlaufleisten dieses scrollarea aufgerufen.

: **ANMERKUNG 3:**  Bei der Verarbeitung eines Mausklick-2-Ereignisses, das an eine Tk-Core- oder Tile-Bildlaufleiste gesendet wird, deren Pfadname an diesen Befehl übergeben wurde, wird das Ereignis von der Bildlaufleiste verarbeitet, anstatt an das übergeordnete Toplevel-Fenster weitergeleitet zu werden, sofern sich der Fokus auf oder innerhalb des zugehörigen Widgets befindet – genau so, als befände sich der Fokus auf der Bildlaufleiste selbst.

**SCHLÜSSELWÖRTER**
: mouse button 2 event, binding, event handling, scanning, scrollableframe, focus


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Vergleich mit BWidget ScrollableFrame und iwidgets::scrolledframe

Das Widget „scrollutil::scrollableframe“ wurde als schlanker, an das jeweilige Thema anpassbarer und voll ausgestatteter Ersatz für „BWidget ScrollableFrame“ und „iwidgets::scrolledframe“ entwickelt. Die folgende Tabelle enthält einen Vergleich der Optionen und Befehle, die von den drei Widgets bereitgestellt werden:

| scrollutil::scrollableframe | BWidget ScrollableFrame | iwidgets::scrolledframe |
| --- | --- | --- |
| `-background` | `-background` | `-background` |
| `-borderwidth` |  | `-borderwidth` |
| `-cursor` |  | `-cursor` |
| `-contentheight` | `-areaheight` | `[pathName component canvas] \ itemconfigure frameTag -height ...` |
| `-contentwidth` | `-areawidth` | `[pathName component canvas] \ itemconfigure frameTag -width ...` |
| `-fitcontentheight` | `-constrainedheight` | `bind [pathName component canvas] <Configure> \ { %W itemconfigure frameTag -height %h }` |
| `-fitcontentwidth` | `-constrainedwidth` | `bind [pathName component canvas] <Configure> \ { %W itemconfigure frameTag -width %w }` |
| `-height`  (legt die *innere* Höhe fest, ohne den Rahmen und das Hervorhebungsrechteck, falls vorhanden) | `-height`  (Innenhöhe = Gesamthöhe) | `-height`  (legt die *Gesamthöhe* fest, einschließlich    des Rahmens und der horizontalen Bildlaufleiste, falls vorhanden) |
| `-highlightbackground` |  |  |
| `-highlightcolor` |  |  |
| `-highlightthickness` |  |  |
| `-relief` |  | `-relief` |
| `-takefocus` |  |  |
| `-width`  (legt die *innere* Breite fest, ohne den Rahmen und das Hervorhebungsrechteck, wenn sie vorhanden sind) | `-width`  (Innenbreite = Gesamtbreite) | `-width`  (legt die *Gesamtbreite* fest, einschließlich    des Rahmens und der vertikalen Bildlaufleiste, wenn vorhanden) |
| `-xscrollcommand` | `-xscrollcommand` |  |
| `-xscrollincrement` | `-xscrollincrement` | `-xscrollincrement` für `[pathName component canvas]` |
| `-yscrollcommand` | `-yscrollcommand` |  |
| `-yscrollincrement` | `-yscrollincrement` | `-yscrollincrement` für `[pathName component canvas]` |
|  |  |  |
| `attrib` |  |  |
| `autosize` |  |  |
| `autofillx` |  |  |
| `autofilly` |  |  |
| `cget` | `cget` | `cget` |
| `configure` | `configure` | `configure` |
| `contentframe` | `getframe` | `childsite` |
| `hasattrib` |  |  |
| `preparescan` |  |  |
| `preparescroll` |  |  |
| `scan`  (mit Mausereignis-Bindungen) |  |  |
| `see widget ?nw\|ne\|sw\|se?` | `see widget ?top\|bottom ?left\|right??` |  |
| `seerect x1 y1 x2 y2 ?nw\|ne\|sw\|se?` |  |  |
| `unsetattrib` |  |  |
| `xview` | `xview` | `xview` |
| `yview` | `yview` | `yview` |
| `xview\|yview units` |  |  |
| `xview\|yview moveto 0\|1` | `xview\|yview moveto 0\|1` | `justify left\|right\|top\|bottom`    (Kurzbezeichnung für  `xview\|yview moveto 0\|1`) |

**ANMERKUNG 1:** Beim Befehl `see` des BWidget-Widgets „ScrollableFrame“ kann die horizontale Seite nicht ohne Angabe der vertikalen Seite festgelegt werden.  Noch ärgerlicher ist jedoch, dass bei einem positiven Wert für `-xscrollincrement` oder `-yscrollincrement` Widgets, die klein genug sind, um in das Fenster zu passen, häufig nur teilweise sichtbar sind.  Zudem funktioniert der Befehl nur für direkte untergeordnete Elemente des Inhaltsrahmens des ScrollableFrame-Widgets.

**ANMERKUNG 2:**  Das Widget iwidgets::scrolledframe verfügt über keine Entsprechungen zu den Optionen scrollutil::scrollableframe, `-contentheight`, `-contentwidth`, `-fitcontentheight` und `-fitcontentwidth`, diese lassen sich jedoch (unter Verwendung undokumentierter interner Informationen!) wie oben gezeigt nachbilden.  Es bietet einen Befehl `justify`, der jedoch lediglich eine Abkürzung für `xview|yview moveto 0|1` ist.  Was diesem Widget wirklich fehlt, ist ein Befehl `see`, um einzelne Widgets im Fenster sichtbar zu machen (was für eine benutzerfreundliche Tastaturnavigation wichtig ist).

[Inhalt](#inhalt)     [Startseite](index.md)
