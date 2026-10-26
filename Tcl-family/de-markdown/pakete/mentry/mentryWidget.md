# Der Befehl `mentry::mentry`

## Für Mentry Version 4.5

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Kurzreferenz](#kurzreferenz)
- [Ausführliche Referenz](#ausf-hrliche-referenz)

[Startseite](index.md)

---

## Kurzreferenz

[NAME](#ausf-hrliche-referenz)
: `mentry::mentry` – Mehrfeld-Eingabe-Widgets erstellen und bearbeiten

[ÜBERSICHT](#ausf-hrliche-referenz)
: 

```
mentry::mentry pathName ?options?
```

[STANDARDOPTIONEN](#ausf-hrliche-referenz)
: 

```
-borderwidth          -highlightcolor      -relief
-highlightbackground  -highlightthickness
```

[Optionen für alle Eingabe- und Beschriftungskomponenten](#ausf-hrliche-referenz)
: 

```
-background  -cursor  -font  -foreground
```

[Optionen für alle Eingabekomponenten](#ausf-hrliche-referenz)
: 

```
-exportselection    -insertwidth        -selectforeground
-insertbackground   -invalidcommand     -show
-insertborderwidth  -justify            -state
-insertofftime      -selectbackground   -validate
-insertontime       -selectborderwidth  -validatecommand
```

[WIDGET-SPEZIFISCHE OPTIONEN](#ausf-hrliche-referenz)
: `-body {width ?text width text ...?}`

: `-disabledbackground color`

: `-disabledforeground color`

: `-readonlybackground color`

: `-takefocus 0|1|""|command`

: `-textvariable array`

[INDIZES](#ausf-hrliche-referenz)
: 

```
number  end
```

[WIDGET-BEFEHL](#ausf-hrliche-referenz)
: `pathName adjustentry index string1 ?string2?`

: `pathName attrib ?name? ?value name value ...?`

: `pathName cget option`

: `pathName clear first ?last?`

: `pathName configure ?option? ?value option value ...?`

: `pathName entries`

: `pathName entrycount`

: `pathName entrylimit index`

: `pathName entrypath index`

: `pathName getarray array`

: `pathName getlist`

: `pathName getstring`

: `pathName hasattrib name`

: `pathName isempty ?index?`

: `pathName isfull ?index?`

: `pathName labelcount`

: `pathName labelpath index`

: `pathName labels`

: `pathName put startIndex ?string string ...?`

: `pathName setentryextrawidth index amount`

: `pathName setentryfont index font`

: `pathName setentrywidth index width`

: `pathName unsetattrib name`

[SCHLÜSSELWÖRTER](#ausf-hrliche-referenz)
: mentry, widget, entry, label


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Ausführliche Referenz

**NAME**
: `mentry::mentry` – Mehrfeld-Eingabe-Widgets erstellen und bearbeiten

**ÜBERSICHT**
: 

```
mentry::mentry pathName ?options?
```

**BESCHREIBUNG**
: Der Befehl `mentry::mentry` erstellt ein neues Fenster mit dem Namen `pathName` und der Klasse `Mentry` und wandelt es in ein **mentry**-Widget um.  Zusätzliche Optionen, die im Folgenden beschrieben werden, können über die Befehlszeile oder in der Optionsdatenbank festgelegt werden, um Aspekte des mentry wie Farben, Schriftart und Komponenten zu konfigurieren. Der Befehl `mentry::mentry` gibt sein Argument `pathName` zurück.  Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen `pathName` vorhanden sein, aber das übergeordnete Fenster von `pathName` muss vorhanden sein.

: Das Wort *mentry* ist eine Abkürzung für *multi-entry* (Mehrfeld-Eingabe). Ein Mentry ist ein Megawidget, das aus einer beliebigen Anzahl von Einträgen besteht, die durch Beschriftungen voneinander getrennt und in einem Rahmen eingebettet sind.  Durch entsprechend gewählte Konfigurationsoptionen für die Einträge und Beschriftungen sieht ein „Mentry“-Widget wie ein einziger Eintrag aus, der vorgefertigte Textabschnitte enthält, die vom Benutzer weder verschoben, geändert noch gelöscht werden können.

: Im Mentry-Paket sind sowohl die Eingabekomponente als auch die Beschriftungskomponente direkte untergeordnete Elemente des Mentry-Widgets.  Im Mentry_tile-Paket sind nur die Beschriftungen direkte Kinder, während die Eingabekomponenten Enkelkinder des „mentry“-Widgets sind (aus technischen Gründen sind die Eingabekomponenten eines auf Tile aufbauenden Mentry-Widgets in frame-Widgets eingebettet, die wiederum Kinder des Mentry-Widgets sind).

: Die anfängliche Breite jeder Eingabekomponente (festgelegt durch die Konfigurationsoption `-body`) bestimmt auch die maximale Anzahl an Zeichen, die in diese eingefügt werden können.  Dies wird mithilfe des Befehls `wcb::callback` erreicht, indem die Rückruffunktion `wcb::checkEntryLen` vor `insert` bei der Eingabekomponente registriert wird.  Um diese Rückruffunktion beizubehalten, sollten zusätzliche before-`insert`-Rückruffunktionen (falls erforderlich) nur mit den Befehlen `wcb::cbappend` und `wcb::cbprepend` registriert werden.  Wird diese Grenze bei einem Eintrag erreicht, der den Eingabefokus besitzt, wird dieser automatisch auf die nächste aktivierte Eingabekomponente gesetzt, der Inhalt dieses Widgets wird ausgewählt und der Einfügecursor wird an dessen Ende gesetzt.  Dies wird durch die Definition einer entsprechenden Rückruffunktion nach `insert` sichergestellt, die als letzte solche Rückruffunktion für das Eingabefeld verbleiben muss.  Aus diesem Grund sollten zusätzliche after-`insert`-Rückruffunktionen (falls erforderlich) nur mit dem Befehl `wcb::cbprepend` registriert werden. Derselbe Befehl sollte ausschließlich zur Definition von after-`motion`-Rückruffunktionen (falls erforderlich) verwendet werden, da `mentry::mentry` eine Rückruffunktion registriert, die für jede Eingabekomponente die letzte after-`motion`-Rückruffunktion sein muss.

: Jedes Mentry-Widget kann eine beliebige Anzahl von **Attributen** aufweisen, die in Befehlen verwendet werden können, mit denen Mentry-Widgets für bestimmte Zwecke erstellt oder bearbeitet werden.  Beispielsweise hat jedes vom Befehl `mentry::dateMentry` erzeugte Datums-Mentry ein Attribut `type` mit dem Wert `"Date"` und ein Attribut `format`, das die Bedeutungen seiner Komponenten festlegt. Die Werte dieser Attribute werden abgefragt und im Hauptteil der Prozeduren `mentry::putClockVal` und `mentry::getClockVal` verwendet.

**STANDARDOPTIONEN**
: 

```
-borderwidth          -highlightcolor      -relief
-highlightbackground  -highlightthickness
```

: Weitere Informationen zu den Standardoptionen für Tk-Widgets finden Sie im Handbucheintrag zu den **Optionen**. Diese Optionen werden nur vom Mentry-Paket unterstützt, nicht jedoch von Mentry_tile.

**Optionen für alle Eingabe- und Beschriftungskomponenten**
: 

```
-background  -cursor  -font  -foreground
```

: Diese Optionen (beschrieben im Handbucheintrag **options**) legen die Werte der gleichnamigen Optionen für alle Eingabekomponenten und Beschriftungskomponenten des angegebenen Mehrfeld-Eingabe-Widgets fest.  Diese Werte können für eine einzelne Komponente mithilfe des Unterbefehls `configure` des dieser Komponente entsprechenden Tcl-Befehls geändert werden.  Die Anwendung dieser Methode zur Änderung der Schriftart eines Eintrags in einem auf Tile aufbauenden „mentry“-Widget kann jedoch dessen Darstellung beeinträchtigen (dies hat technische Gründe, die mit Tile zusammenhängen).  Um dieses Problem zu vermeiden, wird empfohlen, den Unterbefehl `setentryfont` des mit dem Mentry-Widget verknüpften Tcl-Befehls zu verwenden, um den Wert der Option `-font` einer seiner Eingabekomponenten zu ändern.

: Wenn das Paket „Mentry_tile“ verwendet wird, haben diese Optionen themenspezifische Standardwerte. Die gängigen Abkürzungen `-bg` (für `-background`) und `-fg` (für `-foreground`) werden sowohl für klassische als auch für Tile-basierte Mentry-Widgets unterstützt.

: **HINWEIS:**  Bitte beachten Sie, dass bei einigen Themen (wie `Arc`, `plastik`, `tileqt`, `vista` und `xpnative`) die Option `-background` für die Eingabekomponenten eines auf Tile aufbauenden Mentry-Widgets ignoriert wird.  Das Gleiche gilt für das Thema `aqua` im Dunkelmodus sowie bei einigen Tk-Versionen auch im hellen Erscheinungsbild.

**Optionen für alle Eingabekomponenten**
: 

```
-exportselection    -insertwidth        -selectforeground
-insertbackground   -invalidcommand     -show
-insertborderwidth  -justify            -state
-insertofftime      -selectbackground   -validate
-insertontime       -selectborderwidth  -validatecommand
```

: Diese Optionen legen die Werte der gleichnamigen Optionen für alle Eingabekomponenten des angegebenen Mehrfeld-Eingabe-Widgets fest. Diese Werte können für eine einzelne Eingabekomponente mithilfe des Unterbefehls `configure` des diesem Eingabefeld entsprechenden Tcl-Befehls geändert werden.  Die Optionen `-insertbackground`, `-insertborderwidth`, `-insertofftime`, `-insertontime`, `-insertwidth`, `-selectbackground`, `-selectborderwidth` und `-selectforeground` werden nur vom Mentry-Paket unterstützt, nicht jedoch von Mentry_tile.  Die gängigen Abkürzungen `-invcmd` (für `-invalidcommand`) und `-vcmd` (für `-validatecommand`) werden sowohl für klassische als auch für auf Tile aufbauende Mentry-Widgets unterstützt.

**WIDGET-SPEZIFISCHE OPTIONEN**
: 

|   |   |
| --- | --- |
| Befehlszeilenname:  | `-body` |
| Name der Datenbank: | ` body` |
| Datenbankklasse: | ` Body` |

Legt die Anfangsbreiten der Eingabekomponenten des angegebenen Mehrfeld-Eingabe-Widgets sowie die Texte fest, die in den Beschriftungen zwischen den Eingabefeldern angezeigt werden sollen. Der Wert dieser Option wird als Liste interpretiert.  Jedes ungerade nummerierte Element wird als Wert der Konfigurationsoption `-width` einer Eingabekomponente interpretiert, während jedes gerade nummerierte Element den Wert der Konfigurationsoption `-text` eines Label-Unterelements darstellt.  Das heißt, auf jede Eingabebreite muss ein Beschriftungstext folgen, mit Ausnahme der letzten, für die ein entsprechender Beschriftungstext optional ist.  Die Reihenfolge der Listenelemente bestimmt die Erstellungsreihenfolge der Komponenten; diese werden in einer Zeile angeordnet, ohne horizontalen Innenabstand. Die anfängliche Breite jedes Eintrags bestimmt zudem die Anzahl der Zeichen, die in ihn eingefügt werden können; diese maximale Länge bleibt unverändert, selbst wenn die Breite des Eintrags später auf einen neuen Wert gesetzt wird.

Die Breite einer Eingabekomponente und der in einer Beschriftung angezeigte Text können mithilfe des Unterbefehls `configure` der dieser Komponente entsprechenden Tcl-Befehls geändert werden.  Die Anwendung dieser Methode zur Änderung der Breite eines Eingabefelds eines auf Tile aufbauenden „mentry“-Widgets kann jedoch dessen Darstellung beeinträchtigen (dies hat technische Gründe, die mit der Tile-Technik zusammenhängen).  Um dieses Problem zu vermeiden, wird empfohlen, den Unterbefehl `setentrywidth` des mit dem „mentry“-Widget verknüpften Tcl-Befehls zu verwenden, um den Wert der Option `-width` einer seiner Eingabekomponenten zu ändern.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-disabledbackground` |
| Name der Datenbank: | ` disabledBackground` |
| Datenbankklasse: | ` DisabledBackground` |

Diese Option legt die Hintergrundfarbe fest, die für alle Eingabekomponenten und Beschriftungskomponenten des angegebenen Mehrfeld-Eingabe-Widgets verwendet werden soll, wenn dieses deaktiviert ist. Wenn der Wert dieser Option eine leere Zeichenkette ist, wird die normale Hintergrundfarbe verwendet. Diese Option wird nur vom Mentry-Paket unterstützt, nicht jedoch von Mentry_tile.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-disabledforeground` |
| Name der Datenbank: | ` disabledForeground` |
| Datenbankklasse: | ` DisabledForeground` |

Diese Option legt die Vordergrundfarbe fest, die für alle Eingabekomponenten und Beschriftungskomponenten des angegebenen Mehrfeld-Eingabe-Widgets verwendet werden soll, wenn dieses deaktiviert ist. Wenn der Wert dieser Option eine leere Zeichenkette ist, wird die normale Vordergrundfarbe verwendet. Diese Option wird nur vom Mentry-Paket unterstützt, nicht jedoch von Mentry_tile.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-readonlybackground` |
| Name der Datenbank: | ` readonlyBackground` |
| Datenbankklasse: | ` ReadonlyBackground` |

Diese Option legt die Hintergrundfarbe fest, die für alle Eingabekomponenten und Beschriftungskomponenten des angegebenen Mehrfeld-Eingabe-Widgets verwendet werden soll, wenn dieses schreibgeschützt ist. Wenn der Wert dieser Option eine leere Zeichenkette ist, wird die normale Hintergrundfarbe verwendet. Diese Option wird nur vom Mentry-Paket unterstützt, nicht jedoch von Mentry_tile.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-takefocus` |
| Name der Datenbank: | ` takeFocus` |
| Datenbankklasse: | ` TakeFocus` |

Diese Option legt fest, ob das Widget während der Tastaturnavigation den Fokus annimmt. Sie ist nahezu identisch mit der gleichnamigen Standardoption (Einzelheiten finden Sie im Handbucheintrag **options**).  Der einzige Unterschied besteht darin, dass nicht das Widget selbst, sondern seine erste aktivierte Eingabekomponente den Fokus erhält, wenn die Standardtasten (`Tab` und `Shift-Tab`) bei der Tastaturnavigation gedrückt werden.  Informationen dazu, wie Sie den Fokus mithilfe der Tastatur von einer Eingabekomponente zu einer anderen verschieben können, finden Sie im Abschnitt [VORGABEBINDUNGEN](#ausf-hrliche-referenz) weiter unten.


|   |   |
| --- | --- |
| Befehlszeilenname:  | `-textvariable` |
| Name der Datenbank: | ` textvariable` |
| Datenbankklasse: | ` Variable` |

Wenn der Wert dieser Option keine leere Zeichenkette ist, muss es sich um ein Array handeln. In diesem Fall legt für jede Eingabekomponente des angegebenen Mehrfeld-Eingabe-Widgets der Wert des Array-Elements mit dem Index der Eingabe als Elementname den Wert der Option `-textvariable` für diese Eingabe fest.  Die Eintragsindizes beginnen bei `0`.  Beispielsweise entspricht die Angabe von ``-textvariable arr`` für ein Mehrfeld-Eingabe-Widget mit zwei Eingabekomponenten der Angabe von ``-textvariable arr(0)`` für den ersten und ``-textvariable arr(1)`` für den zweiten Eintrag dieses Widgets.

**INDIZES**
: Einige der Widget-Befehle für Mentries nehmen einen Index als Argument entgegen. Ein Index legt einen bestimmten Eintrag oder eine bestimmte Beschriftungskomponente des Mentry fest auf eine der folgenden Weisen:


|   |   |
| --- | --- |
| `number  ` | Legt die Komponente als numerischen Index fest, wobei `0` die erste Eingabe- oder Beschriftungskomponente bezeichnet. |
| `end` | Bezeichnet die letzte Eingabe- oder Beschriftungskomponente des Mentry. |

: Das Wort `end` kann als `en` oder `e` abgekürzt werden. Indizes, die außerhalb des zulässigen Bereichs liegen, werden automatisch auf den nächstgelegenen zulässigen Wert gerundet.

**WIDGET-BEFEHL**
: Der Befehl `mentry::mentry` erstellt einen neuen Tcl-Befehl mit dem Namen `pathName`. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget auszuführen. Er hat die folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

: `option` und `arg` legen das genaue Verhalten des Befehls fest. Für Mentry-Widgets sind folgende Befehle möglich:


`pathName adjustentry index string1 ?string2?`
: Erhöht bei Bedarf die Breite der durch `index` identifizierten Eingabekomponente in Pixeln, sodass sie gerade groß genug für Texte der eingabespezifischen maximalen Länge ist, die aus den im Argument `string1` enthaltenen Zeichen bestehen, mit Ausnahme von höchstens einem Zeichen, das im optionalen Argument `string2` enthalten sein darf.  Gibt eine leere Zeichenkette zurück.

: Wenn Sie beispielsweise ein Eingabe-Widget erstellen, dessen Komponenten ausschließlich bis zu zwei hexadezimale Ziffern in Großbuchstaben akzeptieren, können Sie durch Übergabe der Zeichenfolge `"0123456789ABCDEF"` an diesen Unterbefehl sicherstellen, dass die Eingabekomponenten eine optimale Breite haben, gerade groß genug, um nicht nur die Dezimalziffern, sondern auch bis zu zwei Buchstaben im Bereich `A` – `F` anzuzeigen (die bei Verwendung einer proportionalen Schriftart mehr Platz benötigen als die Dezimalziffern).  Es wird empfohlen, diesen Unterbefehl auch dann aufzurufen, wenn die zulässigen Zeichen ausschließlich auf die Ziffern `0` – `9` beschränkt sind, da bei einigen Schriftarten nicht alle Dezimalziffern die gleiche Breite haben.

: Ein Beispiel für den Fall, in dem beide Zeichenfolgenargumente verwendet werden, ist ein Mentry-Widget für (vorzeichenbehaftete) reelle Zahlen im Festkommaformat. Für seine erste Eingabekomponente (die den ganzzahligen Teil einer reellen Zahl anzeigt) sollte dieser Unterbefehl mit `"0123456789"` als Argument `string1` und `"+-"` als Argument `string2` aufgerufen werden, da das erste Zeichen des Eintrags nicht nur eine Dezimalziffer, sondern auch das Vorzeichen `"+"` oder `"-"` sein kann.  (HINWEIS: Bei den meisten proportionalen Schriftarten ist die Breite des Zeichens `"+"` größer als die von `"0"`.)

`pathName attrib ?name? ?value name value ...?`
: Fragt die Attribute des Widgets ab oder ändert sie. Ist kein `name` angegeben, gibt der Befehl eine Liste von Paaren zurück, von denen jedes den Namen und den Wert eines Attributs für `pathName` enthält. Ist `name` ohne `value` angegeben, gibt der Befehl den Wert des genannten Attributs zurück, oder eine leere Zeichenkette, wenn kein entsprechender Wert existiert (mit dem Unterbefehl `hasattrib` unterscheiden Sie diesen Fall von dem, in dem der Wert eines *vorhandenen* Attributs eine leere Zeichenkette ist). Sind ein oder mehrere Paare aus `name` und `value` angegeben, setzt der Befehl die genannten Widget-Attribute auf die genannten Werte; in diesem Fall ist der Rückgabewert eine leere Zeichenkette. `name` kann eine beliebige Zeichenkette sein.

`pathName cget option`
: Gibt den aktuellen Wert der durch `option` angegebenen Konfigurationsoption zurück, die einen der vom Befehl `mentry::mentry` akzeptierten Werte annehmen kann.

`pathName clear first ?last?`
: Löscht den Inhalt einer oder mehrerer Eingabekomponenten des Widgets. `first` und `last` sind Indizes, die den ersten und letzten Eintrag des zu löschenden Bereichs festlegen.  Wenn `last` nicht festgelegt wird, wird standardmäßig `first` verwendet, d. h., ein einzelner Eintrag wird gelöscht. Der Wert ist eine leere Zeichenkette.

`pathName configure ?option? ?value option value ...?`
: Ruft die Konfigurationsoptionen des Widgets ab oder ändert sie.  Wenn kein `option` angegeben ist, gibt der Befehl eine Liste zurück, die alle verfügbaren Optionen für `pathName` beschreibt (Informationen zum Format dieser Liste finden Sie unter `Tk_ConfigureInfo`).  Wenn `option` ohne `value` festgelegt wird, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste entspricht der entsprechenden Unterliste des zurückgegebenen Werts, wenn kein `option` festgelegt wurde).  Wenn ein oder mehrere Paare aus `option` und `value` angegeben werden, ändert der Befehl die angegebenen Widget-Optionen so, dass sie die angegebenen Werte annehmen; in diesem Fall ist der Rückgabewert eine leere Zeichenkette.  `option` kann jeden der vom Befehl `mentry::mentry` akzeptierten Werte annehmen.

`pathName entries`
: Gibt eine Liste zurück, die die Pfadnamen aller Eingabekomponenten des Widgets enthält.

`pathName entrycount`
: Gibt die Anzahl aller Eingabekomponenten des Widgets zurück.

`pathName entrylimit index`
: Gibt die Anzahl der Zeichen zurück, die in die durch `index` identifizierte Eingabekomponente eingefügt werden können.

`pathName entrypath index`
: Gibt den Pfadnamen der durch `index` identifizierten Eingabekomponente zurück.

`pathName getarray array`
: Für jede Eingabekomponente des Widgets weist der Befehl die in der Eingabe enthaltene Zeichenkette dem Element von `array` zu, dessen Index dem Elementnamen der Eingabe entspricht. Die Indizes der Eingaben beginnen bei `0`. Der Rückgabewert ist eine leere Zeichenkette.

`pathName getlist`
: Gibt eine Liste zurück, die die Zeichenfolgen aller Eingabekomponenten des Widgets enthält.

`pathName getstring`
: Gibt eine Zeichenkette zurück, die durch Verknüpfung der in den Eingabekomponenten des Widgets enthaltenen Zeichenketten mit den Texten gebildet wird, die in den die Eingaben trennenden Beschriftungen angezeigt werden, und zwar in der Reihenfolge der Erstellung der Komponenten, wie sie durch die Konfigurationsoption `-body` vorgegeben ist.  Das heißt, auf die Zeichenkette des ersten Eintrags folgt der Text der ersten Beschriftung, auf den wiederum die Zeichenkette des zweiten Eintrags folgt, und so weiter.

`pathName hasattrib name`
: Gibt `1` zurück, wenn das Attribut `name` vorhanden ist, andernfalls `0`.

`pathName isempty ?index?`
: Wenn `index` festgelegt wird, gibt der Befehl den Wert `1` zurück, wenn die Zeichenfolge in der durch `index` identifizierten Eingabekomponente leer ist, und andernfalls den Wert `0`. Fehlt dieses optionale Argument, gibt der Befehl den Wert `1` zurück, wenn die in den Eingabekomponenten des Widgets enthaltenen Zeichenfolgen alle leer sind, und andernfalls den Wert `0`.

`pathName isfull ?index?`
: Wenn `index` festgelegt wird, gibt der Befehl den Wert `1` zurück, wenn die Länge der Zeichenkette, die in der durch `index` identifizierten Eingabekomponente enthalten ist, der Anzahl der Zeichen entspricht, die in den Eintrag eingefügt werden können, und andernfalls den Wert `0`.  Ist dieses optionale Argument nicht vorhanden, gibt der Befehl den Wert `1` zurück, wenn die Längen der Zeichenfolgen in allen Eingabekomponenten des Widgets der Anzahl der Zeichen entsprechen, die in die jeweiligen Einträge eingefügt werden können (d. h., wenn alle Eingabekomponenten voll sind) und andernfalls den Wert `0`.

`pathName labelcount`
: Gibt die Anzahl aller untergeordneten Label-Elemente des Widgets zurück.

`pathName labelpath index`
: Gibt den Pfadnamen des durch `index` identifizierten untergeordneten Labels zurück.

`pathName labels`
: Gibt eine Liste zurück, die die Pfadnamen aller untergeordneten Label-Elemente des Widgets enthält.

`pathName put startIndex ?string string ...?`
: Ersetzt die Texte der Eingabekomponenten, deren Indizes größer oder gleich `startIndex` sind, durch die entsprechenden `string`-Argumente unter Verwendung der Operationen `delete` und `insert`, bis entweder die Einträge oder die `string`s aufgebraucht sind.  Wird einer dieser Unterbefehle durch einen before-Rückruffunktion in einer beliebigen Eingabekomponente abgebrochen, stellt der Befehl den ursprünglichen Inhalt aller betroffenen Einträge wieder her und gibt den Wert `0` zurück; andernfalls gibt er `1` zurück.  In beiden Fällen behält der Befehl die Position des Einfügecursors in allen Eingabekomponenten bei.

`pathName setentryextrawidth index amount`
: Legt eine zusätzliche Breite für die durch `index` identifizierte Eingabekomponente fest. `amount` kann eine beliebige der Standardformen für Bildschirmabstände annehmen (z. B. eine Pixelanzahl). Der Rückgabewert ist eine leere Zeichenkette.

: Beachten Sie, dass eine Änderung der Breite einer Eingabekomponente keinen Einfluss auf die Anzahl der Zeichen hat, die in diese eingegeben werden können; diese bleibt auf den Wert der Option `-body` der entsprechenden Komponente festgelegt.

`pathName setentryfont index font`
: Setzt die Schriftart der durch `index` identifizierten Eingabekomponente auf den durch `font` angegebenen Wert.  Dies geschieht durch Aufruf des Unterbefehls `configure` des dem Eintrag entsprechenden Tcl-Befehls. Bei Verwendung des Pakets Mentry_tile führt dieser Befehl außerdem einige zusätzliche Schritte durch, die zur Aktualisierung des Erscheinungsbilds des auf Tile aufbauenden Mentry-Widgets erforderlich sind. Der Rückgabewert ist eine leere Zeichenkette.

`pathName setentrywidth index width`
: Stellt die Breite der durch `index` identifizierten Eingabekomponente auf die durch `width` angegebene Zeichenanzahl ein.  Dies geschieht durch Aufruf des Unterbefehls `configure` des dem Eintrag entsprechenden Tcl-Befehls. Bei Verwendung des Pakets Mentry_tile führt dieser Befehl außerdem einige zusätzliche Schritte aus, die zur Aktualisierung der Darstellung des auf Tile aufbauenden Mentry-Widgets erforderlich sind. Der Rückgabewert ist eine leere Zeichenkette.

: Beachten Sie, dass eine Änderung der Breite einer Eingabekomponente keinen Einfluss auf die Anzahl der Zeichen hat, die in diese eingegeben werden können; diese bleibt auf den Wert der Option `-body` der entsprechenden Komponente festgelegt.

`pathName unsetattrib name`
: Hebt das Attribut `name` auf. Gibt eine leere Zeichenfolge zurück.


**VORGABEBINDUNGEN**
: Der Befehl `mentry::mentry` definiert die Bindungen der Komponenten des von ihm erstellten „mentry“-Widgets teilweise neu:


  1. Durch Klicken mit der linken Maustaste in ein untergeordnetes Feld einer Beschriftung wird der Einfügecursor an das Ende des letzten aktivierten Eintrags vor der Beschriftung gesetzt, der Fokus auf diesen Eintrag gelegt und die Auswahl dort gelöscht.
  2. Wenn in einer nicht leeren Eingabekomponente ein Zeichen eingegeben wird, das in der diesem Eingabekomponente folgenden Beschriftung (sofern vorhanden) enthalten ist, wird der Fokus auf die nächste aktivierte Eingabekomponente verschoben, der Inhalt dieser Eingabekomponente wird ausgewählt und der Einfügecursor wird an dessen Ende gesetzt.
  3. Am Anfang einer Eingabekomponente, die nicht die erste aktivierte Eingabekomponente innerhalb des Widgets ist, löscht die Taste `Left` die Auswahl in dieser Eingabekomponente, verschiebt den Fokus auf die vorherige aktivierte Eingabekomponente und setzt den Einfügecursor an das Ende dieses Widgets.  Ebenso löscht die Taste `Right` am Ende einer Eingabekomponente, die nicht das letzte aktivierte Eingabefeld innerhalb des Widgets ist, die Auswahl in diesem Eingabefeld, verschiebt den Fokus auf die nächste aktivierte Eingabekomponente und setzt den Einfügecursor an den Anfang dieses Widgets.  Wenn `tk_strictMotif` auf „false“ gesetzt ist, verhalten sich `Control-b` und `Control-f` jeweils genauso wie `Left` und `Right`.
  4. In einer Eingabekomponente, die nicht die erste aktivierte Eingabekomponente innerhalb des Widgets ist, verschiebt `Control-Left` den Fokus auf die vorherige aktivierte Eingabekomponente, wählt den Inhalt dieses Widgets aus und setzt den Einfügecursor an dessen Ende; gibt es links von der aktuellen Eingabekomponente keine aktivierte Eingabekomponente, so verschiebt `Control-Left` den Einfügecursor an den Anfang des aktuellen Eintrags und löscht die Auswahl in diesem Widget.  Ähnlich verhält es sich bei einer Eingabekomponente, die nicht der letzte aktivierte Eintrag innerhalb des Widgets ist: `Control-Right` verschiebt den Fokus auf die nächste aktivierte Eingabekomponente, wählt den Inhalt dieses Widgets aus und setzt den Einfügecursor an dessen Ende; befindet sich rechts vom aktuellen Eintrag keine aktivierte Eingabekomponente, so bewegt `Control-Right` den Einfügecursor an das Ende des aktuellen Eintrags und löscht die Auswahl in diesem Widget.  Wenn `tk_strictMotif` falsch ist, verhalten sich `Meta-b` und `Meta-f` jeweils genauso wie `Control-Left` und `Control-Right`.
  5. Die Taste `Home` löscht die Auswahl im aktuellen Eingabefeld, verschiebt den Fokus auf die erste aktivierte Eingabekomponente und setzt den Einfügecursor an den Anfang dieses Widgets.  Ebenso löscht die Taste `End` die Auswahl im aktuellen Eingabe-Widget, verschiebt den Fokus auf die letzte aktivierte Eingabekomponente und setzt den Einfügecursor an das Ende dieses Widgets.  Wenn `tk_strictMotif` falsch ist, verhalten sich `Control-a` und `Control-e` jeweils genauso wie `Home` und `End`.
  6. `Shift-Home` verschiebt den Fokus auf die erste aktivierte Eingabekomponente, setzt den Einfügecursor an den Anfang dieses Widgets und erweitert entweder die Auswahl bis zu dieser Position oder löscht die Auswahl im aktuellen Eintrag und wählt den Inhalt des neuen Widgets aus, je nachdem, ob der aktuelle Eintrag die erste aktivierte Eingabekomponente ist oder nicht.  In ähnlicher Weise verschiebt `Shift-End` den Fokus auf die letzte aktivierte Eingabekomponente, setzt den Einfügecursor an das Ende dieses Widgets, und erweitert entweder die Auswahl bis zu dieser Position oder löscht die Auswahl im aktuellen Eintrag und markiert den Inhalt des neuen Widgets, je nachdem, ob der aktuelle Eintrag die letzte aktivierte Eingabekomponente ist oder nicht.
  7. Die Taste `BackSpace` löscht die Auswahl, wenn sie im aktuellen Eintrag vorhanden ist. Andernfalls löscht sie entweder das Zeichen links vom Einfügecursor im aktuellen Eintrag oder das letzte Zeichen der vorherigen aktivierten Eingabekomponente.  Letzteres geschieht am Anfang einer Eingabekomponente, die nicht der erste aktivierte Eintrag innerhalb des Widgets ist; in diesem Fall verschiebt die Taste `BackSpace` zudem den Fokus auf die vorherige aktivierte Eingabekomponente und setzt den Einfügecursor an deren Ende.  Wenn `tk_strictMotif` auf „false“ gesetzt ist, verhält sich `Control-h` genauso wie `BackSpace`.
  8. Wenn `tk_strictMotif` auf „false“ gesetzt ist, löscht `Meta-d` alle Zeichen rechts vom Einfügecursor innerhalb des aktuellen Eintrags, während `Meta-BackSpace` und `Meta-Delete` entweder alle Zeichen links vom Einfüge-Cursor im aktuellen Eintrag oder den Inhalt der vorherigen aktivierten Eingabekomponente löschen.  Letzteres geschieht am Anfang einer Eingabekomponente, die nicht der erste aktivierte Eintrag innerhalb des Widgets ist; in diesem Fall löschen `Meta-BackSpace` und `Meta-Delete` zudem die Auswahl im aktuellen Eintrags-Widget und verschieben den Fokus auf die vorherige aktivierte Eingabekomponente.

**SCHLÜSSELWÖRTER**
: mentry, widget, entry, label


[Inhalt](#inhalt)     [Startseite](index.md)
